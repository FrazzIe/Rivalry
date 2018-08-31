--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local robbers = {}
local stores = {
	["paleto_twentyfourseven"] = {
		position = { ['x'] = 1730.35949707031, ['y'] = 6416.7001953125, ['z'] = 35.0372161865234 },
		reward = math.random(500,700),
		nameofstore = "Twenty Four Seven. (Paleto Bay)",
		time = 120,
		lastrobbed = 0
	},
	["sandyshores_twentyfourseven"] = {
		position = { ['x'] = 1960.4197998047, ['y'] = 3742.9755859375, ['z'] = 32.343738555908 },
		reward = math.random(500,700),
		nameofstore = "Twenty Four Seven. (Sandy Shores)",
		time = 120,
		lastrobbed = 0
	},
	["bar_one"] = {
		position = { ['x'] = 1986.1240234375, ['y'] = 3053.8747558594, ['z'] = 47.215171813965 },
		reward = math.random(800,1000),
		nameofstore = "Yellow Jack. (Sandy Shores)",
		time = 120,
		lastrobbed = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { ['x'] = -709.17022705078, ['y'] = -904.21722412109, ['z'] = 19.215591430664 },
		reward = math.random(800,1000),
		nameofstore = "Twenty Four Seven. (Little Seoul)",
		time = 120,
		lastrobbed = 0
	},
	["palomino_twentyfourseven"] = {
		position = { ['x'] = 2553.0849609375, ['y'] = 383.39788818359, ['z'] = 300.11364746094 },
		reward = math.random(500,700),
		nameofstore = "Twenty Four Seven. (Palomino Fwy)",
		time = 120,
		lastrobbed = 0
	}
}

local cooldown = 15--minutes
local cops = 0

RegisterServerEvent('holdup:toofar')
AddEventHandler('holdup:toofar', function(current_store)
	local source = tonumber(source)
	if(robbers[source])then
		TriggerClientEvent('holdup:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent("holdup:notifycop", -1, "Robbery was cancelled at " .. stores[current_store].nameofstore)
	end
end)

RegisterServerEvent('holdup:checkrob')
AddEventHandler('holdup:checkrob', function(k)
	local source = tonumber(source)
	TriggerEvent("police:getCops", function(cops)
		if tonumber(cops) then
			TriggerEvent('holdup:rob',k,cops,source)
		end
	end)
end)

RegisterServerEvent('holdup:rob')
AddEventHandler('holdup:rob', function(current_store,cops,source)
	local source = tonumber(source)
	if stores[current_store] then
		local store = stores[current_store]

		if (os.time() - store.lastrobbed) < (cooldown*60) and store.lastrobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((cooldown*60) - (os.time() - store.lastrobbed))/60)) .. " minutes.")
			return
		end
		if(cops >= 2)then
			TriggerClientEvent("holdup:notifycop", -1, "Store robbery at "..store.nameofstore..".")
			TriggerClientEvent('customNotification', source, "The Alarm has been triggered! <br> Hold the fort for "..(math.floor(store.time/60)).." minutes")
			TriggerClientEvent('holdup:currentlyrobbing', source, current_store)
			stores[current_store].lastrobbed = os.time()
			robbers[source] = current_store
			SetTimeout(math.floor((store.time*1000)+2000), function()
				if(robbers[source])then
					TriggerClientEvent('holdup:robberycomplete', source, job)
					TriggerEvent('core:getuser', source, function(target) 
						if(target)then
							target.addDirty(store.reward) 
							TriggerClientEvent('customNotification', source, "Robbery complete, you received <span style='color:lime'>$</span><span style='color:white'>" .. store.reward.."</span>")
							TriggerClientEvent("bank:notifycop", -1, "Robbery is over at " .. store.nameofstore)	
						end
					end)
				end
			end)
		else
			TriggerClientEvent('customNotification', source, "There are not enough police online. (At least 2 needed)")
		end				
	end
end)

--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local holdingup = false
local store = ""
local secondsRemaining = 0

local stores = {
	["paleto_twentyfourseven"] = {
		position = { ['x'] = 1730.35949707031, ['y'] = 6416.7001953125, ['z'] = 35.0372161865234 },
		reward = 750,
		nameofstore = "24/7 (Paleto Bay)",
		time = 120,
		lastrobbed = 0
	},
	["sandyshores_twentyfourseven"] = {
		position = { ['x'] = 1960.4197998047, ['y'] = 3742.9755859375, ['z'] = 32.343738555908 },
		reward = 750750,
		nameofstore = "24/7 (Sandy Shores)",
		time = 120,
		lastrobbed = 0
	},
	["bar_one"] = {
		position = { ['x'] = 1986.1240234375, ['y'] = 3053.8747558594, ['z'] = 47.215171813965 },
		reward = 750,
		nameofstore = "Yellow Jack. (Sandy Shores)",
		time = 120,
		lastrobbed = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { ['x'] = -709.17022705078, ['y'] = -904.21722412109, ['z'] = 19.215591430664 },
		reward = 750,
		nameofstore = "24/7 (Little Seoul)",
		time = 120,
		lastrobbed = 0
	},
	["palomino_twentyfourseven"] = {
		position = { ['x'] = 2553.1997070313, ['y'] = 383.5231628418, ['z'] = 108.62293243408 },
		reward = 750,
		nameofstore = "24/7 (Palomino Fwy)",
		time = 120,
		lastrobbed = 0
	},
	["richman_twentyfourseven"] = {
		position = { ['x'] = -1826.9853515625, ['y'] = 797.06665039063, ['z'] = 138.17137145996 },
		reward = 750,
		nameofstore = "24/7 (Richman Glen)",
		time = 120,
		lastrobbed = 0
	}
}

Citizen.CreateThread(function()
    for k,v in pairs(stores)do
        local ve = v.position

        local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
        SetBlipSprite(blip, 500)
        SetBlipColour(blip, 6)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Robbable Store")
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('holdup:currentlyrobbing')
AddEventHandler('holdup:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
	secondsRemaining = stores[store].time
end)

RegisterNetEvent('holdup:toofarlocal')
AddEventHandler('holdup:toofarlocal', function(robb)
	holdingup = false
	TriggerEvent('customNotification', "The robbery was cancelled, you will receive nothing.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)


RegisterNetEvent('holdup:robberycomplete')
AddEventHandler('holdup:robberycomplete', function(robb)
	holdingup = false
	store = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('holdup:notifycop')
AddEventHandler('holdup:notifycop', function(cop_msg)
	if exports.policejob:getIsInService() == true then
		TriggerEvent("chatMessage", "10-90", {255, 0, 0}, cop_msg)
	end
end)

Citizen.CreateThread(function()
	while true do
		if holdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)

local incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
					
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rob ~b~" .. v.nameofstore .. "~w~ beware, the police will be alerted!")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							if exports.policejob:getIsInService() == false then
								TriggerServerEvent('holdup:checkrob', k)
							else
								TriggerEvent('customNotification', "You are a cop, you cannot break the law.")
							end
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then
			local value = secondsRemaining
			local maxvalue = stores[store].time
			local width = 0.2
			local height = 0.025
			local xvalue = 0.4
			local yvalue = 0.05
			local outlinecolour = {0, 0, 0, 150}
			local barcolour = {255, 0, 0}
            DrawRect(xvalue + (width/2), yvalue, width + 0.004, height + 0.006705, outlinecolour[1], outlinecolour[2], outlinecolour[3], outlinecolour[4]) -- Box that creates outline
            drawHelpTxt(xvalue + (((maxvalue/2)/((maxvalue/2)/width))/2 + 0.045), yvalue + 0.0275, 0.1, 0.1, 0.5, value, 255, 255, 255, 255, 6) -- Text display of timer
            DrawRect(xvalue + (width/2), yvalue, width, height, barcolour[1], barcolour[2], barcolour[3], 75) --  Static full bar
            DrawRect(xvalue + ((value/(maxvalue/width))/2), yvalue, value/(maxvalue/width), height, barcolour[1], barcolour[2], barcolour[3], 255) -- Moveable Bar	
			
			local pos2 = stores[store].position
			DrawMarker(1, pos2.x, pos2.y, pos2.z - 1, 0, 0, 0, 0, 0, 0, 15.0, 15.0, 0.2, 1555, 0, 0,255, 0, 0, 0,0)			

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('holdup:toofar', store)
			end
		end

		Citizen.Wait(0)
	end
end)

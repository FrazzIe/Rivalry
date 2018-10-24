RegisterServerEvent('scrapyardgiveitem')
AddEventHandler('scrapyardgiveitem', function(item_id)
	local source = source
	TriggerEvent("inventory:add_server", source, item_id, 1)
end)

--[[ 
0: Compacts
1: Sedans
2: SUVs
3: Coupes
4: Muscle
5: Sports Classics
6: Sports
7: Super
8: Motorcycles
9: Off-road
10: Industrial
11: Utility
12: Vans
13: Cycles
14: Boats
15: Helicopters
16: Planes
17: Service
18: Emergency
19: Military
20: Commercial
21: Trains
22: Player Owned Vehicle
]]--
local chopshop_pay_clean = {
    [0] = 125,
    [1] = 150,
    [2] = 175,
    [3] = 150,
    [4] = 150,
    [5] = 200,
    [6] = 200,
    [7] = 300,
    [8] = 150,
    [9] = 150,
    [10] = 175,
    [11] = 175,
    [12] = 150,
    [13] = 75,
    [14] = 0,
    [15] = 0,
    [16] = 0,
    [17] = 175,
    [18] = 0,
    [19] = 0,
    [20] = 175,
    [21] = 0,
    [22] = 0,
}

local chopshop_pay_dirty = {
    [0] = 125,
    [1] = 150,
    [2] = 175,
    [3] = 150,
    [4] = 150,
    [5] = 200,
    [6] = 200,
    [7] = 300,
    [8] = 150,
    [9] = 150,
    [10] = 175,
    [11] = 175,
    [12] = 150,
    [13] = 75,
    [14] = 0,
    [15] = 0,
    [16] = 0,
    [17] = 175,
    [18] = 0,
    [19] = 0,
    [20] = 175,
    [21] = 0,
    [22] = 0,
}

local chopshop_vehicle_scrap = {
    [0] = 125,
    [1] = 150,
    [2] = 175,
    [3] = 150,
    [4] = 150,
    [5] = 200,
    [6] = 200,
    [7] = 300,
    [8] = 150,
    [9] = 150,
    [10] = 175,
    [11] = 175,
    [12] = 150,
    [13] = 75,
    [14] = 0,
    [15] = 0,
    [16] = 0,
    [17] = 175,
    [18] = 0,
    [19] = 0,
    [20] = 175,
    [21] = 0,
    [22] = 0,
}

RegisterServerEvent("chopshop:pay")
AddEventHandler("chopshop:pay", function(type, class)
	local source = source
	if type == "dirty" then
		if not chopshop_pay_dirty[class] then class = 2 end
		TriggerEvent("core:getuser", source, function(user)
			user.addWallet(chopshop_pay_dirty[class])
			TriggerEvent('addScrap', chopshop_vehicle_scrap[class])
		end)
	elseif "clean" then
		if not chopshop_pay_clean[class] then class = 2 end
		TriggerEvent("core:getuser", source, function(user)
			user.addDirty(chopshop_pay_clean[class])
			TriggerEvent('addScrap', chopshop_vehicle_scrap[class])
		end)
	end
end)

RegisterServerEvent('addScrap')
AddEventHandler('addScrap', function(amount)
	scrap = exports['GHMattiMySQL']:QueryAsync("UPDATE scrap_stockpile SET ('total') = (@total);", {
		['@total'] = ['@total'] + amount
	})
	TriggerClientEvent('scrapyard:sync', scrap[1])
end)

local scrap = 300

RegisterServerEvent('scrapyard:giveScrap')
AddEventHandler('scrapyard:giveScrap', function(id, quantity)
	local source = source
	local user_quantity = getQuantity(source)
	TriggerEvent("core:getuser", source, function(user)
		if user_quantity >= 100 then
			TriggerClientEvent("pNotify:SendNotification", source, {text = "You cannot hold anymore items!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
		elseif user_quantity + tonumber(quantity) >= 100 then
			local available_space = 100 - user_quantity
			if user.get("wallet") >= (scrap*available_space) then
				user.removeWallet(scrap*available_space)
				TriggerEvent("inventory:add_server", source, id, available_space)
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Successfully purchased "..available_space.." "..itemlist[id].name.."(s)!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
			elseif user.get("bank") >= (scrap*available_space) then
				user.removeBank(scrap*available_space)
				TriggerEvent("inventory:add_server", source, id, available_space)
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Successfully purchased "..available_space.." "..itemlist[id].name.."(s)!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
			else
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
			end
		else
			if user.get("wallet") >= (scrap*tonumber(quantity)) then
				user.removeWallet(scrap*tonumber(quantity))
				TriggerEvent("inventory:add_server", source, id, tonumber(quantity))
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Successfully purchased "..quantity.." "..itemlist[id].name.."(s)!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
			elseif user.get("bank") >= (scrap*tonumber(quantity)) then
				user.removeBank(scrap*tonumber(quantity))
				TriggerEvent("inventory:add_server", source, id, tonumber(quantity))
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Successfully purchased "..quantity.." "..itemlist[id].name.."(s)!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
			else
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
			end
		end
	end)
end)
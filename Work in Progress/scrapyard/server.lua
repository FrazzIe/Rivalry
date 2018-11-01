RegisterServerEvent('scrapyardgiveitem')
AddEventHandler('scrapyardgiveitem', function(item_id)
	local source = source
	TriggerEvent("inventory:add_server", source, item_id, 1)
end)

local chopshop_pay_clean = { -- Clean Money Prices
    [0] = 125, -- Compacts
    [1] = 150, -- Sedans
    [2] = 175, -- SUVs
    [3] = 150, -- Coupes
    [4] = 150, -- Muscle
    [5] = 200, -- Sports Classics
    [6] = 200, -- Sports
    [7] = 300, -- Super
    [8] = 150, -- Motorcycles
    [9] = 150, -- Off-road
    [10] = 175, -- Industrial
    [11] = 175, -- Utility
    [12] = 150, -- Vans
    [13] = 75, -- Cycles
    [14] = 0, -- Boats
    [15] = 0, -- Helicopters
    [16] = 0, -- Planes
    [17] = 175, -- Service
    [18] = 0, -- Emergency
    [19] = 0, -- Military
    [20] = 175, -- Commerical
    [21] = 0, -- Trains
    [22] = 0, -- Player Owned Vehicle
}

local chopshop_pay_dirty = { -- Dirty Money Prices
    [0] = 125, -- Compacts
    [1] = 150, -- Sedans
    [2] = 175, -- SUVs
    [3] = 150, -- Coupes
    [4] = 150, -- Muscle
    [5] = 200, -- Sports Classics
    [6] = 200, -- Sports
    [7] = 300, -- Super
    [8] = 150, -- Motorcycles
    [9] = 150, -- Off-road
    [10] = 175, -- Industrial
    [11] = 175, -- Utility
    [12] = 150, -- Vans
    [13] = 75, -- Cycles
    [14] = 0, -- Boats
    [15] = 0, -- Helicopters
    [16] = 0, -- Planes
    [17] = 175, -- Service
    [18] = 0, -- Emergency
    [19] = 0, -- Military
    [20] = 175, -- Commerical
    [21] = 0, -- Trains
    [22] = 0, -- Player Owned Vehicle
}

local chopshop_vehicle_scrap = { -- How much scrap each type of car gives
    [0] = 125, -- Compacts
    [1] = 150, -- Sedans
    [2] = 175, -- SUVs
    [3] = 150, -- Coupes
    [4] = 150, -- Muscle
    [5] = 200, -- Sports Classics
    [6] = 200, -- Sports
    [7] = 300, -- Super
    [8] = 150, -- Motorcycles
    [9] = 150, -- Off-road
    [10] = 175, -- Industrial
    [11] = 175, -- Utility
    [12] = 150, -- Vans
    [13] = 75, -- Cycles
    [14] = 0, -- Boats
    [15] = 0, -- Helicopters
    [16] = 0, -- Planes
    [17] = 175, -- Service
    [18] = 0, -- Emergency
    [19] = 0, -- Military
    [20] = 175, -- Commerical
    [21] = 0, -- Trains
    [22] = 0, -- Player Owned Vehicle
}

RegisterServerEvent("chopshop:pay")
AddEventHandler("chopshop:pay", function(type, class)
	local source = source
	if type == "dirty" then
		if not chopshop_pay_dirty[class] then class = 2 end
		TriggerEvent("core:getuser", source, function(user)
			user.addDirty(chopshop_pay_dirty[class])
			--TriggerEvent('addScrap', chopshop_vehicle_scrap[class])
		end)
	elseif type == "clean" then
		if not chopshop_pay_clean[class] then class = 2 end
		TriggerEvent("core:getuser", source, function(user)
			user.addWallet(chopshop_pay_clean[class])
			--TriggerEvent('addScrap', chopshop_vehicle_scrap[class])
		end)
	elseif type == "scrap" then
		TriggerEvent('addScrap', chopshop_vehicle_scrap[class])
	end
end)

RegisterServerEvent('addScrap')
AddEventHandler('addScrap', function(amount)
    exports['GHMattiMySQL']:QueryAsync("UPDATE scrap_stockpile set total = total + @amount WHERE id = 1", {['@amount'] = amount})
    TriggerEvent('scrapyard:sync')
end)

RegisterServerEvent('scrapyard:sync')
AddEventHandler('scrapyard:sync', function()
    exports['GHMattiMySQL']:QueryAsync("SELECT * FROM scrap_stockpile WHERE id = 1", {}, function(scrap)
        TriggerClientEvent('scrapyard:sync', scrap)
    end)
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
local Prices = {
	[54] = 20,
	[55] = 30,
	[56] = 40,
	[57] = 50,
	[58] = 60,
	[59] = 75,
	[60] = 85,
	[61] = 95,
	[62] = 105,
	[63] = 115,
	[64] = 125,
}

	RegisterServerEvent('Fisher:Car')
	AddEventHandler('Fisher:Car', function()
		TriggerClientEvent('Fisher:getCar',source)
	end)
	
	RegisterServerEvent('Fisher:Car2')
	AddEventHandler('Fisher:Car2', function()
		TriggerClientEvent('Fisher:getCar2', source)
	end)

	local pierFish = {54, 55, 56, 57, 58}
	local deepFish = {59, 60, 61, 62, 63, 64}
	local allFish = {54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64}
	local fishies = {.80,.70,.60,.40,.20,.10}

	function NearestValue(table, number)
	    local smallestSoFar, smallestIndex
	    for i, y in ipairs(table) do
	        if not smallestSoFar or (math.abs(number-y) < smallestSoFar) then
	            smallestSoFar = math.abs(number-y)
	            smallestIndex = i
	        end
	    end
	    return smallestIndex
	end

	RegisterServerEvent('caughtFish')
	AddEventHandler('caughtFish', function (typeRequest, nearbyPlayers)
		local source = tonumber(source)
		TriggerEvent("inventory:getuser", source, function(inventory)
			if(typeRequest == "Deep")then
				local randomizer = 0
				local quantity = math.random(1,2)
				local fiftyfifty = math.random(1,10)
				if(nearbyPlayers >= 4) then
					randomizer = math.random(1,100) / 100 + .5
				elseif(nearbyPlayers == 3) then
					randomizer = math.random(1,100) / 100 + .5
				elseif(nearbyPlayers == 2) then
					randomizer = math.random(1,100) / 100 + .5
				else
					randomizer = math.random(1,100) / 100
				end
				local index = NearestValue(fishies, randomizer)
				if fiftyfifty <= 3 then
					TriggerClientEvent('caughtFish:success', source, deepFish[index], quantity, "nofish")
				else
					TriggerEvent("inventory:add_server", source, deepFish[index], quantity)
					TriggerClientEvent('caughtFish:success', source, deepFish[index], quantity, "caught")
				end
			else
				local randomizer = 0
				local fiftyfifty = math.random(1,10)
				if(nearbyPlayers >= 4) then
					randomizer = math.random(1,5) + 1
				elseif(nearbyPlayers == 3) then
					randomizer = math.random(1,5) + 1
				elseif(nearbyPlayers == 2) then
					randomizer = math.random(1,5) + 1
				else
					randomizer = math.random(1,5)
				end
				if fiftyfifty > 3 then
					if randomizer <= 5 then
						TriggerEvent("inventory:add_server", source, pierFish[randomizer], 1)
						TriggerClientEvent('caughtFish:success', source, pierFish[randomizer], 1, "caught")
					else
						randomizer = 5
					end
				else
					TriggerClientEvent('caughtFish:success', source, pierFish[randomizer], 1, "nofish")
				end
			end
		end)
	end)
		
RegisterServerEvent('Fisher:setService')
AddEventHandler('Fisher:setService', function (inService)
	TriggerEvent('core:getuser', source , function (Player)
		Player.setSessionVar('FisherInService', inService)
	end)
	TriggerEvent('fish:initialise')
end)

local prices = {20, 30, 40, 50, 60, 75, 85, 95, 105, 115, 125}
local previousTime = 0
RegisterServerEvent('updatePrices')
AddEventHandler('updatePrices', function(mostSoldFish, leastSoldFish)
	if mostSoldFish ~= 0 and leastSoldFish ~= 0 then
		local time = os.time()
		if(previousTime == 0)then
			previousTime = time
			prices[mostSoldFish] = prices[mostSoldFish] - 25
			prices[leastSoldFish] = prices[leastSoldFish] + 25
		elseif previousTime - time <= -7200 then
			prices = {20,30,40,50,60,75,85,95,105,115,125}
			prices[mostSoldFish] = prices[mostSoldFish] - 25
			prices[leastSoldFish] = prices[leastSoldFish] + 25
		else
			if prices[mostSoldFish] <= 500 and prices[leastSoldFish] >= 25 then
				prices[mostSoldFish] = prices[mostSoldFish] - 25
				prices[leastSoldFish] = prices[leastSoldFish] + 25
			end
		end
	end
end)

local table = {
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 0,
	[5] = 0,
	[6] = 0,
	[7] = 0,
	[8] = 0,
	[9] = 0,
	[10] = 0,
	[11] = 0
}

--[[RegisterServerEvent('fluxiateMarket')
AddEventHandler('fluxiateMarket', function(id, sold, index)
	local source = source
	local mostSoldFishIndex = 0
	local leastSoldFishIndex = 0
	for k, v in ipairs(table) do
		if index == k then
			v = sold
		end
	end
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM fish_market WHERE (`id` = @id)", {["@id"] = 1}, function(queryTable)
		fish = exports['GHMattiMySQL']:QueryAsync("UPDATE fish_market SET `Snook` = @Snook AND `Pompano` = @Pompano AND `Snapper` = @Snapper AND `Redfish` = @Redfish AND `Bass` = @Bass AND `Mackerel` = @Mackerel AND `Herring` = @Herring AND `Salmon` = '@Salmon' AND `Barracuda` = @Barracuda AND `Tuna` = @Tuna AND `Yellowfish` = @Yellowfish WHERE ( `id` = @id );", { 
		    ['@Snook'] = table[1] + queryTable[1].Snook,
		    ['@Pompano'] = table[2] + queryTable[1].Pompano,
		    ['@Snapper'] = table[3] + queryTable[1].Snapper,
		    ['@Redfish'] = table[4] + queryTable[1].Redfish,
		    ['@Bass'] = table[5] + queryTable[1].Bass,
		    ['@Mackerel'] = table[6] + queryTable[1].Mackerel,
		    ['@Herring'] = table[7] + queryTable[1].Herring,
		    ['@Salmon'] = table[8] + queryTable[1].Salmon,
		    ['@Barracuda'] = table[9] + queryTable[1].Barracuda,
		    ['@Tuna'] = table[10] + queryTable[1].Tuna,
		    ['@Yellowfish'] = table[11] + queryTable[1].Yellowfish,
	    	['@id'] = 1,
		})

		for k, v in ipairs(queryTable) do
			for a, b in ipairs(queryTable) do
				if v[1] > b[k] then
					mostSoldFishIndex = k
				end
				if v[1] < b[k] then
					leastSoldFishIndex = k
				end
			end
		end
		TriggerEvent('updatePrices', mostSoldFishIndex, leastSoldFishIndex)
	end)
end)--]]

RegisterServerEvent("Fish.Sell")
AddEventHandler("Fish.Sell", function(Ids)
	local Source = source
	local Query = ""

	TriggerEvent("core:getuser", Source, function(User)
		if user_inventory[Source] then
			local character_id = user.get("characterID")
			for Index = 1, #Ids do
				if user_inventory[Source][Ids[Index]] then
					if user_inventory[Source][Ids[Index]].quantity > 0 then
						Query = Query = "DELETE FROM inventory WHERE (character_id="..character_id..") AND (item_id="..Ids[Index]..");"
						User.addWallet(Prices[Ids[Index]] * user_inventory[Source][Ids[Index]].quantity)
						user_inventory[Source][Ids[Index]] = nil
					end
				end
			end

			if Query ~= "" then
				exports["GHMattiMySQL"]:QueryAsync(Query)
				TriggerClientEvent("inventory:updateitems", Source, user_inventory[source])
				TriggerClientEvent("inventory:sync", -1, user_inventory)
			end
		end
	end)
end)
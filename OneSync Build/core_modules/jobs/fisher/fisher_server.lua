local Prices = {
	[54] = 10,
	[55] = 15,
	[56] = 20,
	[57] = 25,
	[58] = 30,
	[59] = 50,
	[60] = 60,
	[61] = 70,
	[62] = 80,
	[63] = 90,
	[64] = 99,
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

RegisterServerEvent("Fish.Sell")
AddEventHandler("Fish.Sell", function(Ids)
	local Source = source

	TriggerEvent("core:getuser", Source, function(User)
		if user_inventory[Source] then
			local character_id = User.get("characterID")
			local total = 0

			for Index = 1, #Ids do
				if user_inventory[Source][Ids[Index]] then
					if user_inventory[Source][Ids[Index]].quantity > 0 then
						total = total + (Prices[Ids[Index]] * user_inventory[Source][Ids[Index]].quantity)
						user_inventory[Source][Ids[Index]] = nil
					end
				end
			end

			if #Ids > 0 then
				exports["ghmattimysql"]:execute("DELETE FROM inventory WHERE character_id = ? AND item_id IN(?)", {User.get("characterID"), Ids})
				User.addWallet(total)
				TriggerClientEvent("inventory:updateitems", Source, user_inventory[source])
				TriggerClientEvent("inventory:sync", -1, user_inventory)
			end
		end
	end)
end)

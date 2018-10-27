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

	RegisterServerEvent('caughtFish')
	AddEventHandler('caughtFish', function (typeRequest, nearbyPlayers)
		local source = tonumber(source)
		TriggerEvent("inventory:getuser", source, function(inventory)
			if(typeRequest == "Deep")then
				local randomizer = 0
				if(nearbyPlayers >= 4) then
					randomizer = math.random(1,6) + 3
				elseif(nearbyPlayers == 3) then
					randomizer = math.random(1,6) + 2
				elseif(nearbyPlayers == 2) then
					randomizer = math.random(1,6) + 1
				else
					randomizer = math.random(1,6)
				end
				if randomizer <= 6 then
					TriggerEvent("inventory:add_server", source, deepFish[randomizer], 1)
					TriggerClientEvent('caughtFish:success', source, deepFish[randomizer])
				else
					randomizer = 0
				end
			else
				local randomizer = 0
				if(nearbyPlayers >= 4) then
					randomizer = math.random(1,5) + 3
				elseif(nearbyPlayers == 3) then
					randomizer = math.random(1,5) + 2
				elseif(nearbyPlayers == 2) then
					randomizer = math.random(1,5) + 1
				else
					randomizer = math.random(1,5)
				end
				if randomizer <= 5 then
					TriggerEvent("inventory:add_server", source, pierFish[randomizer], 1)
					TriggerClientEvent('caughtFish:success', source, pierFish[randomizer])
				else
					randomizer = 0
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

local prices = {50,50,50,50,150,175,200,225,250,275}
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
			prices = {50,50,50,50,150,175,200,225,250,275}
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

RegisterServerEvent('sellFish')
AddEventHandler('sellFish', function(id, quantity)
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		for k, v in ipairs(allFish) do
			if v == id then
				user.addWallet(prices[k] * quantity)
			end
		end
    end)
end)
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
					TriggerClientEvent('caughtFish:success', deepFish[randomizer])
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
					TriggerClientEvent('caughtFish:success', pierFish[randomizer])
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
end)

RegisterServerEvent('fluxiateMarket')
AddEventHandler('fluxiateMarket', function(table)
	local source = source
	local queryTable = {}
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM fish_market WHERE (id = @id)", {["@id"] = 1}, function(search)
		table.insert(queryTable, search)	
	end)

	fish = exports['GHMattiMySQL']:QueryAsync("UPDATE fish_market SET (`Snook`, `Pompano`, `Snapper`, `Redfish`, `Bass`, `Mackerel`, `Herring`, `Salmon`, `Barracuda`, `Tuna`, `Yellowfish`) = @Snook, @Pompano, @Snapper, @Redfish, @Bass, @Mackerel, @Herring, @Salmon, @Barracuda, @Tuna, @Yellowfish) WHERE ( `id` = @id );", { 
	    ['@Snook'] = table[1].sold + queryTable.Snook,
	    ['@Pompano'] = table[2].sold + queryTable.Pompano,
	    ['@Snapper'] = table[3].sold + queryTable.Snapper,
	    ['@Redfish'] = table[4].sold + queryTable.Redfish,
	    ['@Bass'] = table[5].sold + queryTable.Bass,
	    ['@Mackerel'] = table[6].sold + queryTable.Mackerel,
	    ['@Herring'] = table[7].sold + queryTable.Herring,
	    ['@Salmon'] = table[8].sold + queryTable.Salmon,
	    ['@Barracuda'] = table[9].sold + queryTable.Barracuda,
	    ['@Tuna'] = table[10].sold + queryTable.Tuna,
	    ['@Yellowfish'] = table[11].sold + queryTable.Yellowfish,
	    ['@id'] = 1,
	})

	local values = {}

	for i = 1, #fish do
		table.insert(values, fish[i])
	end
	local mostSoldFish = math.max(unpack(fish))
	local leastSoldFish = math.min(unpack(fish))
	local mostSoldFishIndex = 0
	local leastSoldFishIndex = 0
	for i = 1, #fish do 
		if mostSoldFish == fish[i] then
			mostSoldFishIndex = i
		end
		if leastSoldFish == fish[i] then
			leastSoldFishIndex = i
		end
	end
	TriggerEvent('updatePrices', mostSoldFishIndex, leastSoldFishIndex)
end)

RegisterServerEvent('sellFish')
AddEventHandler('sellFish', function(id)
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		user.addWallet(prices[id])
    end)
end)
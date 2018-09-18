	RegisterServerEvent('Fisher:Car')
	AddEventHandler('Fisher:Car', function()
		TriggerClientEvent('Fisher:getCar',source)
	end)
	
	RegisterServerEvent('Fisher:Car2')
	AddEventHandler('Fisher:Car2', function()
		TriggerClientEvent('Fisher:getCar2', source)
	end)

	RegisterServerEvent('Fisher:serverRequest')
	AddEventHandler('Fisher:serverRequest', function (typeRequest)
		local source = tonumber(source)
		TriggerEvent("inventory:getuser", source, function(inventory)
			if typeRequest == "GetPoisson" then
				local possibleValues = {21, 50, 52, 53, 56}
				local data = {}
				for k, v in ipairs(possibleValues) do
					if(inventory[v])then
						table.insert(data, inventory[v].quantity)
					end
				end
				TriggerClientEvent('Fisher:drawGetPoisson', source, data)
			elseif typeRequest == "GetPoissonDeep" then
				local possibleValues = {58, 60, 62, 64, 66, 68}
				local data = {}
				for k, v in ipairs(possibleValues) do
					if(inventory[v])then
						table.insert(data, inventory[v].quantity)
					end
				end
				TriggerClientEvent('Fisher:drawGetPoissonDeep',source, data)
			elseif typeRequest == "SellFilet" then
				local possibleValues = {21, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68}
				local data = {}
				for k, v in ipairs(possibleValues) do
					if(inventory[v])then
						table.insert(data, inventory[v].quantity)
					end
				end
				TriggerClientEvent('Fisher:drawSellFilet', source, data)
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
AddEvenHandler('updatePrices', function(mostSoldFish, leastSoldFish)
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
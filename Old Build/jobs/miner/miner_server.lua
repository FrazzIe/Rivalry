	RegisterServerEvent('Miner:Car1')
	AddEventHandler('Miner:Car1', function()
		TriggerClientEvent('Miner:getCar1',source)
	end)

	RegisterServerEvent('Miner:Car2')
	AddEventHandler('Miner:Car2', function()
		TriggerClientEvent('Miner:getCar2',source)
	end)

	RegisterServerEvent('Miner:Car3')
	AddEventHandler('Miner:Car3', function()
		TriggerClientEvent('Miner:getCar3',source)
	end)

	RegisterServerEvent('Miner:serverRequest')
	AddEventHandler('Miner:serverRequest', function (typeRequest)
		local source = tonumber(source)
		TriggerEvent("inventory:getuser", source, function(inventory)
			if typeRequest == "GetMinerai" then
				local data = 0
				if inventory[1] then data = inventory[1].quantity end
				TriggerClientEvent('Miner:drawGetMinerai', source, data)
			elseif typeRequest == "GetMetal" then
				local data = 0
				local data2 = 0
				if inventory[1] then data = inventory[1].quantity end
				if inventory[2] then data2 = inventory[2].quantity end
				TriggerClientEvent('Miner:drawGetMetal',source, data, data2)
			elseif typeRequest == "SellMetal" then
				local data = 0
				if inventory[2] then data = inventory[2].quantity end
				TriggerClientEvent('Miner:drawSellMetal', source, data)
			else
				print('DEBUG : Une erreur de type de requête à été détecté')
			end
		end)
	end)

RegisterServerEvent('Miner:setService')
AddEventHandler('Miner:setService', function (inService)
	TriggerEvent('core:getuser', source , function (Player)
		Player.setSessionVar('MinerInService', inService)
	end)
end)

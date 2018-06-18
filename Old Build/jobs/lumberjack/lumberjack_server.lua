	RegisterServerEvent('bucheron:Car')
	AddEventHandler('bucheron:Car', function()
		TriggerClientEvent('bucheron:getCar',source)
	end)

	RegisterServerEvent('bucheron:serverRequest')
	AddEventHandler('bucheron:serverRequest', function (typeRequest)
		local source = tonumber(source)
		TriggerEvent("inventory:getuser", source, function(inventory)
			if typeRequest == "GetBois" then
				local data = 0
				if inventory[19] then data = inventory[19].quantity end
				TriggerClientEvent('bucheron:drawGetBois', source, data)
			elseif typeRequest == "GetPlanche" then
				local data = 0
				local data2 = 0
				if inventory[19] then data = inventory[19].quantity end
				if inventory[20] then data2 = inventory[20].quantity end
				TriggerClientEvent('bucheron:drawGetPlanche',source, data, data2)
			elseif typeRequest == "SellPlanche" then
				local data = 0
				if inventory[20] then data = inventory[20].quantity end
				TriggerClientEvent('bucheron:drawSellPlanche', source, data)
			else
				print('DEBUG : A query type error has been detected')
			end
			
		end)
	end)

RegisterServerEvent('bucheron:setService')
AddEventHandler('bucheron:setService', function (inService)
	TriggerEvent('core:getuser', source , function (Player)
		Player.setSessionVar('bucheronInService', inService)
	end)
end)
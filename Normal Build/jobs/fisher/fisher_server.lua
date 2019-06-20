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
				local data = 0
				if inventory[21] then data = inventory[21].quantity end
				TriggerClientEvent('Fisher:drawGetPoisson', source, data)
			elseif typeRequest == "GetFilet" then
				local data = 0
				local data2 = 0
				if inventory[21] then data = inventory[21].quantity end
				if inventory[22] then data2 = inventory[22].quantity end
				TriggerClientEvent('Fisher:drawGetFilet',source, data, data2)
			elseif typeRequest == "SellFilet" then
				local data = 0
				if inventory[22] then data = inventory[22].quantity end
				TriggerClientEvent('Fisher:drawSellFilet', source, data)
			else
				print('DEBUG : Une erreur de type de requête à été détecté')
			end
			
		end)
	end)
	
	
		
RegisterServerEvent('Fisher:setService')
AddEventHandler('Fisher:setService', function (inService)
	TriggerEvent('core:getuser', source , function (Player)
		Player.setSessionVar('FisherInService', inService)
	end)
end)
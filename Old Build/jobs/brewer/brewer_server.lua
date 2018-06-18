	RegisterServerEvent('Brewer:Car')
	AddEventHandler('Brewer:Car', function()
		TriggerClientEvent('Brewer:getCar',source)
	end)

	RegisterServerEvent('Brewer:serverRequest')
	AddEventHandler('Brewer:serverRequest', function (typeRequest)
		local source = tonumber(source)
		TriggerEvent("inventory:getuser", source, function(inventory)
			if typeRequest == "GetOrge" then
				local data = 0
				if inventory[tonumber(Brewer_ressourceBase)] then data = inventory[tonumber(Brewer_ressourceBase)].quantity end
				TriggerClientEvent('Brewer:drawGetOrge', source, data)
			elseif typeRequest == "GetBiere" then
				local data = 0
				local data2 = 0
				if inventory[tonumber(Brewer_ressourceBase)] then data = inventory[tonumber(Brewer_ressourceBase)].quantity end
				if inventory[tonumber(Brewer_ressourceTraite)] then data2 = inventory[tonumber(Brewer_ressourceTraite)].quantity end
				TriggerClientEvent('Brewer:drawGetBiere',source, data, data2)
			elseif typeRequest == "SellBiere" then
				local data = 0
				if inventory[tonumber(Brewer_ressourceTraite)] then data = inventory[tonumber(Brewer_ressourceTraite)].quantity end
				TriggerClientEvent('Brewer:drawSellBiere', source, data)
			else
				print('DEBUG : A query type error has been detected')
			end			
		end)
	end)

RegisterServerEvent('Brewer:setService')
AddEventHandler('Brewer:setService', function (inService)
	TriggerEvent('core:getuser', source , function (Player)
		Player.setSessionVar('BrewerInService', inService)
	end)
end)
	RegisterServerEvent('vigneron:Car')
	AddEventHandler('vigneron:Car', function()
		TriggerClientEvent('vigneron:getCar',source)
	end)

	RegisterServerEvent('vigneron:serverRequest')
	AddEventHandler('vigneron:serverRequest', function (typeRequest)
		local source = tonumber(source)
		TriggerEvent("inventory:getuser", source, function(inventory)
			if typeRequest == "GetRaisin" then
				local data = 0
				if inventory[tonumber(vigneron_ressourceBase)] then data = inventory[tonumber(vigneron_ressourceBase)].quantity end
				TriggerClientEvent('vigneron:drawGetRaisin', source, data)
			elseif typeRequest == "GetVin" then
				local data = 0
				local data2 = 0
				if inventory[tonumber(vigneron_ressourceBase)] then data = inventory[tonumber(vigneron_ressourceBase)].quantity end
				if inventory[tonumber(vigneron_ressourceTraite)] then data2 = inventory[tonumber(vigneron_ressourceTraite)].quantity end
				TriggerClientEvent('vigneron:drawGetVin',source, data, data2)			
			elseif typeRequest == "SellVin" then
				local data = 0
				if inventory[tonumber(vigneron_ressourceTraite)] then data = inventory[tonumber(vigneron_ressourceTraite)].quantity end
				TriggerClientEvent('vigneron:drawSellVin', source, data)
			else
				print('DEBUG : Une erreur de type de requête à été détecté')
			end			
		end)
	end)

	
RegisterServerEvent('vigneron:setService')
AddEventHandler('vigneron:setService', function (inService)
	TriggerEvent('core:getuser', source , function (Player)
		Player.setSessionVar('vigneronInService', inService)
	end)
end)
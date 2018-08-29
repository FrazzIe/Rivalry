RegisterServerEvent('Farmer:Car')
AddEventHandler('Farmer:Car', function()
	TriggerClientEvent('Farmer:getCar',source)
end)

RegisterServerEvent('Farmer:serverRequest')
AddEventHandler('Farmer:serverRequest', function (typeRequest)
	local source = tonumber(source)
	TriggerEvent("inventory:getuser", source, function(inventory)
		if typeRequest == "GetBle" then
			local data = 0
			if inventory[10] then data = inventory[10].quantity end
			TriggerClientEvent('Farmer:drawGetBle', source, data)
		elseif typeRequest == "GetFarine" then
			local data = 0
			local data2 = 0
			if inventory[10] then data = inventory[10].quantity end
			if inventory[5] then data2 = inventory[5].quantity end
			TriggerClientEvent('Farmer:drawGetFarine',source, data, data2)
		elseif typeRequest == "SellFarine" then
			local data = 0
			if inventory[5] then data = inventory[5].quantity end
			TriggerClientEvent('Farmer:drawSellFarine', source, data)
		else
			print('DEBUG : Error')
		end
	end)
end)
	
RegisterServerEvent('Farmer:setService')
AddEventHandler('Farmer:setService', function (inService)
	TriggerEvent('core:getuser', source , function (Player)
		Player.setSessionVar('FarmerInService', inService)
	end)
end)
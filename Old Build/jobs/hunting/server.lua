RegisterServerEvent('hunting:serverRequest')
AddEventHandler('hunting:serverRequest', function (typeRequest)
	if typeRequest == "SellViande" then
		TriggerEvent("inventory:getuser", source, function(inventory)
			local data = 0 
			if inventory[23] then data = inventory[23].quantity end
			TriggerClientEvent('hunting:drawSellViande', source, data)
		end)
	end
end)
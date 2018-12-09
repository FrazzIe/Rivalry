RegisterServerEvent('Garbage.Success')
AddEventHandler('Garbage.Success', function(amount)
	TriggerEvent("core:getuser", source, function(user)
		user.addWallet(amount)
	end)
end)

RegisterServerEvent('Garbage.Rent')
AddEventHandler('Garbage.Rent', function()
	local source = source
	TriggerEvent('core:getuser', source, function(user)
		if user.get("wallet") >= 150 then
			user.removeWallet(150)
			TriggerClientEvent('Garbage.Rent', source)
		else
			user.removeBank(150)
			TriggerClientEvent('Garbage.Rent', source)
		end
	end)
end)
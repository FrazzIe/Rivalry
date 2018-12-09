RegisterServerEvent("GoPostal.Rent")
AddEventHandler("GoPostal.Rent", function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user.get("wallet") >= 150 then
			user.removeWallet(150)
			TriggerClientEvent('GoPostal.Rent', source)
		else
			user.removeBank(150)
			TriggerClientEvent('GoPostal.Rent', source)
		end
	end)
end)

RegisterServerEvent("GoPostal.Success")
AddEventHandler("GoPostal.Success", function(amount)
	TriggerEvent("core:getuser", source, function(user)
		user.addWallet(amount)
	end)
end)
local carwash_cost = 50

RegisterServerEvent("carwash:pay")
AddEventHandler("carwash:pay", function(_vehicle)
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user.get("wallet") >= carwash_cost then
			user.removeWallet(carwash_cost)
			TriggerClientEvent("carwash:wash", source, _vehicle)
		elseif user.get("bank") >= carwash_cost then
			user.removeBank(carwash_cost)
			TriggerClientEvent("carwash:wash", source, _vehicle)
		else
			Notify("Insufficient funds!", source)
		end
	end)
end)
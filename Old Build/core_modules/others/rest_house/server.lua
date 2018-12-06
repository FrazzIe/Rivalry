RegisterServerEvent("resthouse:pay")
AddEventHandler("resthouse:pay", function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user.get("wallet") >= 3000 then
			user.removeWallet(3000)
			TriggerClientEvent("resthouse:approve", source)
		else
			Notify("Insufficient funds!", 3000, source)
		end
	end)
end)
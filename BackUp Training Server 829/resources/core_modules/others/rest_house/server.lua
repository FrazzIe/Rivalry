RegisterServerEvent("resthouse:pay")
AddEventHandler("resthouse:pay", function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user.get("wallet") >= 10000 then
			user.removeWallet(10000)
			TriggerClientEvent("paramedic:lifesupport", source, 300)
		else
			Notify("Insufficient funds!", 3000, source)
		end
	end)
end)
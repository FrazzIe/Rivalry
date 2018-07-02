local bus_rent = 200

RegisterServerEvent("bus:rent")
AddEventHandler("bus:rent", function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user.get("wallet") >= bus_rent then
			user.removeWallet(bus_rent)
			TriggerClientEvent("bus:rent", source)
		elseif user.get("bank") >= bus_rent then
			user.removeBank(bus_rent)
			TriggerClientEvent("bus:rent", source)
		else
			Notify("Insufficient funds", 2500, source)
		end
	end)
end)

RegisterServerEvent("bus:complete")
AddEventHandler("bus:complete", function()
	TriggerEvent("core:getuser", source, function(user)
        user.addWallet(400)
    end)
	Notify("You have been paid $400 for arriving at the bus stop!", 3000, source)
end)
RegisterServerEvent("diving:buy")
AddEventHandler("diving:buy", function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user.get("wallet") >= 300 then
			Notify("Diving suit purchased", 3000, source)
			user.removeWallet(300)
			TriggerClientEvent("diving:bought", source)
		elseif user.get("bank") >= 300 then
			Notify("Diving suit purchased", 3000, source)
			user.removeBank(300)
			TriggerClientEvent("diving:bought", source)
		else
			Notify("Insufficient funds!", 3000, source)
		end
	end)
end)

TriggerEvent("core:addGroupCommand", "scuba", "emergency", function(source, args, rawCommand, data, power, group)
	TriggerClientEvent("diving:emergency", source)
end, {help = "Toggle scuba gear"})
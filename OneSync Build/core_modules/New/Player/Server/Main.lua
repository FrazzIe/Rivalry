RegisterServerEvent("Rob:Sucessful")
AddEventHandler("Rob:Sucessful", function(IsCops)
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		local RandomAmount = math.random(250, 750)
		if IsCops then
			User.addWallet(RandomAmount)
		else
			User.addWallet(RandomAmount/2)
		end
	end)
end)

RegisterServerEvent("Hospital.ServiceHeal")
AddEventHandler("Hospital.ServiceHeal", function()
	local Source = source
	local Cost = 500
	TriggerEvent("core:getuser", Source, function(User)
		if User.get("wallet") > Cost then
			User.removeWallet(Cost)
			TriggerClientEvent("Hospital.ServiceHeal", Source)
		else
			TriggerClientEvent("pNotify:SendNotification", Source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
		end
	end)
end)
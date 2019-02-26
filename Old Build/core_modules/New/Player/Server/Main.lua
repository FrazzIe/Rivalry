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

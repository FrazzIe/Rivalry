RegisterServerEvent("Rob:Sucessful")
AddEventHandler("Rob:Sucessful", function()
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		local RandomAmount = math.random(50, 300)
		User.addWallet(RandomAmount)
	end)
end)
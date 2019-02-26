local Payouts = {50,150,200,250,300,350,400,450,500,550,600}

RegisterServerEvent("Rob:Sucessful")
AddEventHandler("Rob:Sucessful", function()
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		local RandomAmount = math.random(1, #Payouts)
		User.addWallet(Payouts[RandomAmount])
	end)
end)
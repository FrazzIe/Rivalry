local trucker_rent = 500
local trucker_trailers = {
    [1] = 6000,
    [2] = 6300,
    [3] = 2000,
    [4] = 1700,
    [5] = 2000,
}

RegisterServerEvent("trucker:rent")
AddEventHandler("trucker:rent", function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user.get("wallet") >= trucker_rent then
			user.removeWallet(trucker_rent)
			TriggerClientEvent("trucker:rent", source)
		elseif user.get("bank") >= trucker_rent then
			user.removeBank(trucker_rent)
			TriggerClientEvent("trucker:rent", source)
		else
			Notify("Insufficient funds", 2500, source)
		end
	end)
end)

RegisterServerEvent("trucker:complete")
AddEventHandler("trucker:complete", function(trucker_job)
	TriggerEvent("core:getuser", source, function(user)
		user.addWallet(trucker_trailers[trucker_job])
		Notify("You have been paid $"..trucker_trailers[trucker_job].." for completing the delivery!", 3000, source)
	end)
end)
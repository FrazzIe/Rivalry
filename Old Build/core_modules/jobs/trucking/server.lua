local trucker_rent = 500
local trucker_tiers = {
    [1] = 250,
    [2] = 400,
    [3] = 500,
    [4] = 600,
    [5] = 750,
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
AddEventHandler("trucker:complete", function(tier)
	TriggerEvent("core:getuser", source, function(user)
		user.addWallet(trucker_tiers[tier])
		Notify("You have been paid $"..trucker_tiers[tier].." for completing the delivery!", 3000, source)
	end)
end)
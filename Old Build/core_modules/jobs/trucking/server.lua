local trucker_rent = 500
local trucker_tiers = {
    [1] = 2500,
    [2] = 4000,
    [3] = 5000,
    [4] = 6000,
    [5] = 7500,
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
		local jobtotal = trucker_tiers[tier]
        if jobtotal > 4 then jobtotal = 150 end
        total = math.random(50,math.floor(jobtotal))
        user.addWallet(total*8)
        local payment = (total * 8)
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "~g~$~s~Payment Recieved : + "..payment.."")
    end)
end)

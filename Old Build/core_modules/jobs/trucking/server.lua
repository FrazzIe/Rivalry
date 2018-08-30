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
AddEventHandler("trucker:complete", function(tier, distance)
	TriggerEvent("core:getuser", source, function(user)
		local payment = math.floor(math.floor(distance) / 6.4)
		user.addWallet(payment)
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "~s~Payment Recieved: ~g~$~s~"..payment.."")
    end)
end)
 
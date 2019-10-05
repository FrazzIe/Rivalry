local uncuffCost = 250

RegisterServerEvent("uncuff:remove")
AddEventHandler("uncuff:remove", function()
    local src = source

	TriggerEvent("core:getuser", src, function(user)
		if user.get("dirty") >= uncuffCost then
            user.removeDirty(uncuffCost)
            TriggerClientEvent("police:uncuff", src)
			TriggerEvent("handcuffs:uncuff2", src)
        elseif user.get("wallet") >= (uncuffCost * 3) then
            user.removeWallet(uncuffCost * 3)
            TriggerClientEvent("police:uncuff", src)
			TriggerEvent("handcuffs:uncuff2", src)
		else
			Notify("Insufficient funds!", 2500, src)
		end
	end)
end)
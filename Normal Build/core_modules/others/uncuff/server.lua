local uncuffCost = 250

RegisterServerEvent("uncuff:remove")
AddEventHandler("uncuff:remove", function()
    local src = source

	TriggerEvent("core:getuser", src, function(user)
		if user.get("dirty") >= uncuffCost then
            user.removeDirty(uncuffCost)
            TriggerClientEvent("police:uncuff", src)
			TriggerEvent("handcuffs:uncuff", src)
        elseif user.get("wallet") >= uncuffCost then
            user.removeWallet(uncuffCost)
            TriggerClientEvent("police:uncuff", src)
			TriggerEvent("handcuffs:uncuff", src)
			Notify("Insufficient funds!", 2500, src)
		end
	end)
end)
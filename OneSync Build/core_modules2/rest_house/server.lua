RegisterServerEvent("resthouse:pay")
AddEventHandler("resthouse:pay", function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user.get("dirty") >= 2500 then
			user.removeDirty(2500)
			TriggerClientEvent("resthouse:revive", source)
		else
			Notify("Insufficient funds!", 2500, source)
		end
	end)
end)
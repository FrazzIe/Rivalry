
RegisterServerEvent("dm:clean")
AddEventHandler("dm:clean", function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		local dirty = user.get("dirty")
		if dirty > 0 then
			user.addWallet(dirty)
			user.removeDirty(dirty)
			TriggerClientEvent("customNotification", source, "Money laundered")
		end
	end)
end)
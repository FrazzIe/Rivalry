RegisterServerEvent("dm:clean")
AddEventHandler("dm:clean", function(distance)
	local source = source
	local payment = 0
	TriggerEvent("core:getuser", source, function(user)
		local dirty = user.get("dirty")
		if distance < 1500 then
			payment = 4000
		elseif distance > 1500 and distance < 3000 then
			payment = 8000
		else
			payment = 12000
		end
		if dirty >= payment and dirty > 0 then
			user.addWallet(payment)
			user.removeDirty(payment)
			TriggerClientEvent("customNotification", source, "Money laundered!")
		elseif dirty < 0 then
			TriggerClientEvent("customNotification", source, "You have no more money to clean!")
		else
			user.addWallet(dirty)
			user.removeDirty(dirty)
		end
	end)
end)
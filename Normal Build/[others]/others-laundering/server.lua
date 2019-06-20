RegisterServerEvent("dm:clean")
AddEventHandler("dm:clean", function(distance)
	local source = source
	local payment = 0
	TriggerEvent("core:getuser", source, function(user)
		local dirty = user.get("dirty")
		if distance < 500 then
			payment = math.random(100, 500) + (distance/5)
		elseif distance > 500 and distance < 1000 then
			payment = math.random(500, 1000) + (distance/5)
		else
			payment = math.random(1000, 1500) + (distance/5)
		end
		if dirty >= payment and dirty > 0 then
			user.addWallet(payment)
			user.removeDirty(payment)
			TriggerClientEvent("customNotification", source, "Money laundered!")
		elseif dirty <= 0 then
			TriggerClientEvent("customNotification", source, "You have no more money to clean!")
		else
			user.addWallet(dirty)
			user.removeDirty(dirty)
		end
	end)
end)

RegisterServerEvent('server:launderingVan')
AddEventHandler('server:launderingVan', function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user.get("dirty") > 0 then
			user.removeDirty(250)
			TriggerClientEvent('client:launderingVan', source)
		else
			TriggerClientEvent("customNotification", source, "Insufficient Funds! Stop playing games with me.")
		end
	end)
end)
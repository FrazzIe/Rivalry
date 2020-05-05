RegisterNetEvent("robberies:sell")
AddEventHandler("robberies:sell", function(market)
	-- local config = Config.Markets[market]
	-- if not config then return end

	TriggerEvent("core:getuser", source, function(user)
		user.addDirty(market)
	end)
end)
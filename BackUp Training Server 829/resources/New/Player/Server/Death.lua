RegisterServerEvent("Player.Respawn.Normal")
AddEventHandler("Player.Respawn.Normal", function()
	local source = source
	TriggerClientEvent("Player.Respawn", source)
end)

RegisterServerEvent("Player.Respawn.Remove")
AddEventHandler("Player.Respawn.Remove", function()
	local source = source
	TriggerEvent('core:getuser', source, function(user)
		user.wallet(0)
		user.dirty(0)
	end)
	TriggerEvent("weapon:delete", source)
	TriggerEvent("inventory:delete", source)

	TriggerClientEvent("Player.Respawn", source)
end)
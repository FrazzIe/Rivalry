RegisterServerEvent("flash:start")
AddEventHandler("flash:start", function(x, y, z, players)
	for k,v in pairs(players) do
		TriggerClientEvent("flash:start", tonumber(v), x, y, z)
	end
end)
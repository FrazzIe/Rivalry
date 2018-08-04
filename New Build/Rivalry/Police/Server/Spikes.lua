RegisterServerEvent("Spikes.Burst")
AddEventHandler("Spikes.Burst", function(Target, Tyre)
	local Source = source
	
	TriggerClientEvent("Spikes.Burst", Target, Tyre)
end)
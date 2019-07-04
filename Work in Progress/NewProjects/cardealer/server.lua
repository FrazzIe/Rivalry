local DisplayedVehicles = {}

RegisterServerEvent("Spawn.DisplayVehicle")
AddEventHandler("Spawn.DisplayVehicle", function(Vehicle)
	local Source = source
	DisplayedVehicles = table.insert(Vehicle, DisplayedVehicles)
	TriggerServerEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
end)

RegisterServerEvent("Retrieve.DisplayVehicles")
AddEventHandler("Retrieve.DisplayVehicles", function()
	local Source = source
	TriggerClientEvent("DisplayVehicles.Sync", Source, DisplayedVehicles)
end)
local zones = {}

AddEventHandler("onServerResourceStart", function(resource)
	if resource == GetCurrentResourceName() then
		zones = LoadResourceFile(GetCurrentResourceName(), "others/zones/zones.txt") or "[]"
		zones = json.decode(zones)
		TriggerClientEvent("zones:intitialise", -1, zones)
	end
end)

AddEventHandler("core:loaded", function(source)
	TriggerClientEvent("zones:intitialise", source, zones)
end)

RegisterServerEvent("zones:update")
AddEventHandler("zones:update", function(_zones)
	zones = _zones
	SaveResourceFile(GetCurrentResourceName(), "others/zones/zones.txt", json.encode(zones), -1)
	TriggerClientEvent("zones:intitialise", -1, zones)
end)

RegisterServerEvent("zones:reload")
AddEventHandler("zones:reload", function(_zones)
	TriggerClientEvent("zones:intitialise", -1, zones)
end)
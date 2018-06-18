keys_vehicles = {}
keys_users = {}

AddEventHandler("playerDropped", function()
    local source = source
    if keys_users[source] then
        for plate, owner in pairs(keys_users[source]) do
            if plate ~= nil and owner ~= nil then
            	if keys_vehicles[plate] then
                	keys_vehicles[plate] = nil
                end
            end
        end
        keys_users[source] = nil
    end
end)

AddEventHandler("core:switch", function(source)
    local source = source
    if keys_users[source] then
        for plate, owner in pairs(keys_users[source]) do
            if plate ~= nil and owner ~= nil then
            	if keys_vehicles[plate] then
                	keys_vehicles[plate] = nil
                end
            end
        end
        keys_users[source] = {}
    end
end)

AddEventHandler("core:loaded", function(source)
	keys_users[source] = {}
	TriggerClientEvent("keys:sync", -1, keys_vehicles, keys_users)
end)

RegisterServerEvent("keys:lock")
AddEventHandler("keys:lock", function(vehicle, plate, callback)
	local source = source
	if keys_vehicles[plate] then
		if keys_users[source][plate] then
			Notify("Locked.", 2500, source)
			TriggerClientEvent("keys:trigger", source, vehicle, true)
		else
			Notify("You do not have the keys to this vehicle", 3000, source)
		end
	else
		Notify("You haven't picked up the keys to this vehicle", 3000, source)
	end
end)

RegisterServerEvent("keys:unlock")
AddEventHandler("keys:unlock", function(vehicle, plate, callback)
	local source = source
	if keys_vehicles[plate] then
		if keys_users[source][plate] then
			Notify("Unlocked.", 2500, source)
			TriggerClientEvent("keys:trigger", source, vehicle, false)
		else
			Notify("You do not have the keys to this vehicle", 3000, source)
		end
	else
		Notify("You haven't picked up the keys to this vehicle", 3000, source)
	end
end)

RegisterServerEvent("keys:get")
AddEventHandler("keys:get", function(vehicle, plate)
	local source = source
	if not keys_vehicles[plate] then
		Notify("Grabbed keys!", 3000, source)
		keys_vehicles[plate] = source
		keys_users[source][plate] = source
		TriggerClientEvent("keys:sync", -1, keys_vehicles, keys_users)
	else
		Notify("You do not have the keys to this vehicle!", 3000, source)
	end
end)

RegisterServerEvent("keys:give")
AddEventHandler("keys:give", function(plate, target)
	local source = source
	if keys_users[source][plate] then
		if keys_users[target] then
			Notify(GetIdentity(source).." gave you keys to a vehilce!", 3000, target)
			Notify("You gave your vehicle keys to "..GetIdentity(target).."!", 3000, source)
			keys_users[source][plate] = nil
			keys_users[target][plate] = target
			TriggerClientEvent("keys:sync", -1, keys_vehicles, keys_users)
		end
	end
end)

RegisterServerEvent("keys:remove")
AddEventHandler("keys:remove", function(plate)
	local source = source
	if keys_users[source][plate] then
		Notify("Removed!", 3000, source)
		keys_users[source][plate] = nil
		keys_vehicles[plate] = nil
		TriggerClientEvent("keys:sync", -1, keys_vehicles, keys_users)
	end
end)
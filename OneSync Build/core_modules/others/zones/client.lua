local zones = {}
local debug = false

local function CalculateCentre(zone)
	local x, y, count = 0, 0, #zone
	for i = 1, count, 1 do
		x = x + zone[count].x
		y = y + zone[count].y
	end
	return math.ceil(x/count*100)/100, math.ceil(y/count*100)/100
end

local function CalculateLongest(zone)
	local x, y = CalculateCentre(zone)
	local max = 0
	local distances = {}

	for i = 1, #zone, 1 do
		table.insert(distances, GetDistanceBetweenCoords(x, y, 0, zone[i].x, zone[i].y, 0, false))
	end

	for i = 1, #distances, 1 do
		if distances[i] > max then 
			max = distances[i]
		end
	end
	return math.ceil((max*100)/100) + 0.01
end

local function IsLeft(point0, point1, point2)
	return (((point1.x - point0.x) * (point2.y - point0.y)) - ((point2.x - point0.x) * (point1.y - point0.y)))
end

local function IsPointInPolygon(point, points)
	local winding_number = 0
	table.insert(points, points[1])
	for i = 1, #points - 1, 1 do
		if points[i].y <= point.y then
			if points[i+1].y > point.y then
				if IsLeft(points[i], points[i+1], point) > 0 then
					winding_number = winding_number + 1
				end
			end
		else
			if points[i+1].y <= point.y then
				if IsLeft(points[i], points[i+1], point) < 0 then
					winding_number = winding_number - 1
				end
			end
		end
	end
	table.remove(points, #points)
	return winding_number
end

local function SharpenZone(zone)
	for i = 1, #zone, 1 do
		zone[i].x = math.ceil(zone[i].x*100)/100
		zone[i].y = math.ceil(zone[i].y*100)/100
		zone[i].z = math.ceil(zone[i].z*100)/100
	end
	return zone
end

local function DoesZoneExist(zone)
	for i = 1, #zones, 1 do
		if zones[i].name == zone then
			return true
		end
	end
	return false
end

local function DeleteZone(zone)
	for i = 1, #zones, 1 do
		if zones[i].name == zone then
			table.remove(zones, i)
		end
	end
end

local function CreateZone(zone)
	table.insert(zones, {
		name = zone,
		active = false,
		centre = {
			x = 0.0,
			y = 0.0,
		},
		longest = 0,
		points = {},
	})
end

local function AddPoint(zone)
	local point = GetEntityCoords(PlayerPedId(), false)
	for i = 1, #zones, 1 do
		if zones[i].name == zone then
			table.insert(zones[i].points, {
				x = point.x,
				y = point.y,
				z = point.z,
			})
			zones[i].centre.x, zones[i].centre.y = CalculateCentre(zones[i].points)
			zones[i].longest = CalculateLongest(zones[i].points)
			SharpenZone(zones[i].points)
		end
	end
end

local function RemovePoint(zone, point)
	for i = 1, #zones, 1 do
		if zones[i].name == zone then
			if zones[i].points[point] then
				table.remove(zones[i].points, point)
				zones[i].centre.x, zones[i].centre.y = CalculateCentre(zones[i].points)
				zones[i].longest = CalculateLongest(zones[i].points)
				SharpenZone(zones[i].points)
			end
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local position = GetEntityCoords(PlayerPedId(), false)
		for i = 1, #zones, 1 do
			if GetDistanceBetweenCoords(zones[i].centre.x, zones[i].centre.y, 0, position.x, position.y, 0, false) < zones[i].longest then
				if IsPointInPolygon(position, zones[i].points) ~= 0 then
					zones[i].active = true
				else
					zones[i].active = false
				end
			else
				zones[i].active = false
			end
			if debug then
				for j = 1, #zones[i].points, 1 do
					if zones[i].active then
						DrawLine(zones[i].points[j].x, zones[i].points[j].y, zones[i].points[j].z, zones[i].points[j].x, zones[i].points[j].y, zones[i].points[j].z+1.0, 0, 255, 0, 255)
						Draw3DText(zones[i].points[j].x, zones[i].points[j].y, zones[i].points[j].z+1.1, "~g~"..j, 1.5)
					else
						DrawLine(zones[i].points[j].x, zones[i].points[j].y, zones[i].points[j].z, zones[i].points[j].x, zones[i].points[j].y, zones[i].points[j].z+1.0, 255, 0, 0, 255)
						Draw3DText(zones[i].points[j].x, zones[i].points[j].y, zones[i].points[j].z+1.1, "~r~"..j, 1.5)
					end
				end
			end
		end
	end
end)

RegisterCommand("zone", function(source, args, fullCommand)
	if isAdmin then
		if #args >= 1 then
			if args[1] ~= "add" and args[1] ~= "remove" and args[1] ~= "create" and args[1] ~= "delete" and args[1] ~= "debug" then
				TriggerEvent("chatMessage", "> ", {255,255,255}, "^3/zone [add/remove/create/delete/debug] [zone] [point to delete]")
			else
				if args[1] == "debug" then
					debug = not debug
					TriggerEvent("chatMessage", "> ", {255,255,255}, "Zone debug mode: ^5"..tostring(debug))
				elseif DoesZoneExist(args[2]) and args[1] ~= "create" then
					if args[1] == "add" then
						TriggerEvent("chatMessage", "> ", {255,255,255}, "Pont Added")
						AddPoint(args[2])
						TriggerServerEvent("zones:update", zones)
					elseif args[1] == "remove" then
						if args[3] then
							if tonumber(args[3]) then
								RemovePoint(args[2], tonumber(args[3]))
								TriggerServerEvent("zones:update", zones)
							else
								TriggerEvent("chatMessage", "> ", {255,255,255}, "^1Has to be a number?")
							end
						else
							TriggerEvent("chatMessage", "> ", {255,255,255}, "^1You never specified a point to delete")
						end
					elseif args[1] == "delete" then
						DeleteZone(args[2])
						TriggerEvent("chatMessage", "> ", {255,255,255}, "Zone deleted")
						TriggerServerEvent("zones:update", zones)
					end
				elseif DoesZoneExist(args[2]) and args[1] == "create" then
					TriggerEvent("chatMessage", "> ", {255,255,255}, "This zone already exists")
				elseif not DoesZoneExist(args[2]) and args[1] == "create" then
					CreateZone(args[2])
					TriggerEvent("chatMessage", "> ", {255,255,255}, "Zone created")
					TriggerServerEvent("zones:update", zones)
				else
					TriggerEvent("chatMessage", "> ", {255,255,255}, "Zone doesn't exist")
				end
			end
		else
			TriggerEvent("chatMessage", "> ", {255,255,255}, "^3/zone [add/remove/create/delete/debug] [zone] [point to delete]")
		end
	else
		TriggerEvent("chatMessage", "> ", {255,255,255}, "^1You do not have permission to use this command!")
	end
end, false)

RegisterNetEvent("zones:intitialise")
AddEventHandler("zones:intitialise", function(_zones)
	zones = _zones
end)

function IsInZone(zone)
	for i = 1, #zones, 1 do
		if zones[i].name == zone then
			if zones[i].active then
				return true
			else
				return false
			end
		end
	end
	return false
end

RegisterNetEvent("zones:IsInZone")
AddEventHandler("zones:IsInZone", function(zone, callback)
	callback(IsInZone(zone))
end)

AddEventHandler("onClientResourceStart", function(resource)
	TriggerServerEvent("zones:reload")
end)
--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
--Door models: https://wiki.gtanet.work/index.php?title=Doors

local doors = {
	single = {
		[1] = {x = 463.4782, y = -1003.538, z = 25.00599, model = -1033001619, heading = 0.0, locked = false}, -- Mission Row Door To Cells Back
		[2] = {x = 461.8065, y = -994.4086, z = 25.06443, model = 631614199, heading = 270.0, locked = false}, -- Mission Row Cell Door 1
		[3] = {x = 461.8065, y = -997.6583, z = 25.06443, model = 631614199, heading = 90.0, locked = false}, -- Mission Row Cell Door 2
		[4] = {x = 461.8065, y = -1001.302, z = 25.06443, model = 631614199, heading = 90.0, locked = false}, -- Mission Row Cell Door 3
		[5] = {x = 464.5701, y = -992.6641, z = 25.06443, model = 631614199, heading = 0.0, locked = false}, -- Mission Row Door To Cells Front
		[6] = {x = 446.5728, y = -980.0106, z = 30.8393, model = -1320876379, heading = 180.00012207031, locked = false}, -- Mission Row Police Station Captan's Office Door
		[7] = {x = 450.1041, y = -985.73840, z = 30.8393, model = 1557126584, heading = 89.661880493164, locked = false}, -- Mission Row Police Station Door To Locker Rooms
		[8] = {x = 452.6248, y = -987.3626, z = 30.8393, model = -2023754432, heading = 179.75776672363, locked = false}, -- Mission Row Police Station Locker Room 1 Door
		[9] = {x = 461.2865, y = -985.3206, z = 30.83926, model = 749848321, heading = 90.0, locked = false}, -- Mission Row Police Station Roof Access Door
		[10] = {x = 464.3613, y = -984.678, z = 43.83443, model = -340230128, heading = 90.0, locked = false}, -- Mission Row Police Station Roof Door
	},
	double = {
		[1] = {
			["left"] = {x = 434.7479, y = -980.6184, z = 30.839260, model = -1215222675, heading = 270.18865966797, locked = false},
			["right"] = {x = 434.7479, y = -983.2151, z = 30.83926, model = 320433149, heading = 270.39477539063, locked = false},
		}, -- Mission Row Police Station Main Entrance
		[2] = {
			["left"] = {x = 467.3716, y = -1014.452, z = 26.53623, model = -2023754432, heading = 0.0, locked = false},
			["right"] = {x = 469.9679, y = -1014.452, z = 26.53623, model = -2023754432, heading = 179.99998474121, locked = false},
		}, -- Mission Row Police Station Back Entrance
		[3] = {
			["left"] = {x = 446.0079, y = -989.4454, z = 30.8393, model = 185711165, heading = 0.0, locked = false},
			["right"] = {x = 443.4078, y = -989.4454, z = 30.8393, model = 185711165, heading = 179.99998474121, locked = false},
		}, -- Mission Row Police Station Cell And Briefing Doors
		[4] = {
			["left"] = {x = 443.0298, y = -994.5412, z = 30.8393, model = -131296141, heading = 270.0, locked = false},
			["right"] = {x = 443.0298, y = -991.941, z = 30.8393, model = -131296141, heading = 90.0, locked = false},
		}, -- Mission Row Police Station Briefing Doors
	}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for k,v in pairs(doors.single) do
			if v.locked then
				local door = GetClosestObjectOfType(v.x, v.y, v.z, 0.5, v.model, false, false, false)
				if door ~= nil and door ~= 0 then
					SetEntityHeading(door, v.heading)
				end
			end
			local pos = GetEntityCoords(PlayerPedId(),false)
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) <= 1.2 then
				local state = "Unlocked"
				if v.locked then state = "Locked" end
				Draw3DText(v.x, v.y, pos.z,"~o~[E]"..state)
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("doors:lock", k, "single")
				end
			end
		end
		for k,v in pairs(doors.double) do
			if v.left.locked and v.right.locked then
				local leftdoor = GetClosestObjectOfType(v.left.x, v.left.y, v.left.z, 0.5, v.left.model, false, false, false)
				local rightdoor = GetClosestObjectOfType(v.right.x, v.right.y, v.right.z, 0.5, v.right.model, false, false, false)
				if rightdoor ~= nil and rightdoor ~= 0 and leftdoor ~= nil and leftdoor ~= 0 then
					SetEntityHeading(leftdoor, v.left.heading)
					SetEntityHeading(rightdoor, v.right.heading)
				end
			end
			local pos = GetEntityCoords(PlayerPedId(),false)
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.left.x, v.left.y, v.left.z, true) <= 1.5 or GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.right.x, v.right.y, v.right.z, true) <= 1.5 then
				local state = "Unlocked"
				if v.left.locked then state = "Locked" end
				Draw3DText(v.left.x, v.left.y, v.left.z,"~o~[E]"..state)
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("doors:lock", k, "double")
				end
			end
		end
	end
end)

RegisterNetEvent("doors:sync")
AddEventHandler("doors:sync", function(_doors)
	doors = _doors
end)

AddEventHandler("doors:initialise", function(source)
	TriggerClientEvent("doors:sync", -1, doors)
end)

RegisterServerEvent("doors:lock")
AddEventHandler("doors:lock", function(doorid, type)
	local source = source
	if type == "single" then
		doors.single[doorid].locked = not doors.single[doorid].locked
		TriggerClientEvent("doors:sync", -1, doors)
	elseif type == "double" then
		doors.double[doorid]["left"].locked = not doors.double[doorid]["left"].locked
		doors.double[doorid]["right"].locked = doors.double[doorid]["left"].locked
		TriggerClientEvent("doors:sync", -1, doors)
	end
end)
--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
--Door models: https://wiki.gtanet.work/index.php?title=Doors

doors = {
	single = {},
	double = {}
}

doors_locked = {
	single = {
		[1] = {x = -1002.4011230469, y = -477.61575317383, z = 50.027568817139, model = -2030220382, heading = 299.10842895508}, -- Property door (Movie studio)
	},
	double = {}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		for k,v in pairs(doors.single) do
			if v.locked then
				local door = GetClosestObjectOfType(v.x, v.y, v.z, 0.5, v.model, false, false, false)
				if door ~= nil and door ~= 0 then
					SetEntityHeading(door, v.heading)
				end
			end

			if GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, v.x, v.y, v.z, true) <= 1.2 then
				local state = "Unlocked"
				if v.locked then state = "Locked" end
				Draw3DText(v.x, v.y, PlayerPosition.z,"~o~[E]"..state)
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

			if GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, v.left.x, v.left.y, v.left.z, true) <= 1.5 or GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, v.right.x, v.right.y, v.right.z, true) <= 1.5 then
				local state = "Unlocked"
				if v.left.locked then state = "Locked" end
				Draw3DText(v.left.x, v.left.y, v.left.z,"~o~[E]"..state)
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("doors:lock", k, "double")
				end
			end
		end

		for k,v in pairs(doors_locked.single) do
			local door = GetClosestObjectOfType(v.x, v.y, v.z, 0.5, v.model, false, false, false)
			if door ~= nil and door ~= 0 then
				SetEntityHeading(door, v.heading)
			end
		end
		for k,v in pairs(doors_locked.double) do
			local leftdoor = GetClosestObjectOfType(v.left.x, v.left.y, v.left.z, 0.5, v.left.model, false, false, false)
			local rightdoor = GetClosestObjectOfType(v.right.x, v.right.y, v.right.z, 0.5, v.right.model, false, false, false)
			if rightdoor ~= nil and rightdoor ~= 0 and leftdoor ~= nil and leftdoor ~= 0 then
				SetEntityHeading(leftdoor, v.left.heading)
				SetEntityHeading(rightdoor, v.right.heading)
			end
		end
	end
end)

RegisterNetEvent("doors:sync")
AddEventHandler("doors:sync", function(_doors)
	doors = _doors
end)

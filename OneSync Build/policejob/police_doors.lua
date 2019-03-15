--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--Door models: https://wiki.gtanet.work/index.php?title=Doors

local function RenderText(Text, X, Y, Font, Scale, R, G, B, A, Alignment, DropShadow, Outline, WordWrap)
    local Text, X, Y = tostring(Text), (tonumber(X) or 0)/1920, (tonumber(Y) or 0)/1080

    SetTextFont(Font or 0)
    SetTextScale(1.0, Scale or 0)
    SetTextColour(tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)

    if DropShadow then
        SetTextDropShadow()
    end

    if Outline then
        SetTextOutline()
    end

    if Alignment ~= nil then
        if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
            SetTextCentre(true)
        elseif Alignment == 2 or Alignment == "Right" then
            SetTextRightJustify(true)
        end
    end

    if tonumber(WordWrap) and tonumber(WordWrap) ~= 0 then
        if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
            SetTextWrap(X - ((WordWrap/1920)/2), X + ((WordWrap/1920)/2))
        elseif Alignment == 2 or Alignment == "Right" then
            SetTextWrap(0, X)
        else
            SetTextWrap(X, X + (WordWrap/1920))
        end
    else
        if Alignment == 2 or Alignment == "Right" then
            SetTextWrap(0, X)
        end
    end

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(Text) 
    EndTextCommandDisplayText(X, Y)
end

local doors = {
	single = {
		{coords = vector3(471.04309, -987.978, 24.9137), model = 452874391, heading = 180.0, locked = true}, -- Mission Row Interrogation Cell Door 1
		{coords = vector3(478.5546, -987.878, 25.0524), model = 452874391, heading = 180.0, locked = true}, -- Mission Row Interrogation Cell Door 2
		{coords = vector3(474.4076, -987.878, 25.0675), model = -340230128, heading = 0.0, locked = true}, -- Mission Row Interrogation Observe
		{coords = vector3(478.1655, -992.1209, 25.060), model = 452874391, heading = 0, locked = true}, -- Mission Row Mug Shot
		{coords = vector3(463.4782, -1003.538, 25.00599), model = -1033001619, heading = 0.0, locked = true}, -- Mission Row Door To Cells Back
		{coords = vector3(461.8065, -994.4086, 25.06443), model = 631614199, heading = 270.0, locked = true}, -- Mission Row Cell Door 1
		{coords = vector3(461.8065, -997.6583, 25.06443), model = 631614199, heading = 90.0, locked = true}, -- Mission Row Cell Door 2
		{coords = vector3(461.8065, -1001.302, 25.06443), model = 631614199, heading = 90.0, locked = true}, -- Mission Row Cell Door 3
		{coords = vector3(464.5701, -992.6641, 25.06443), model = 631614199, heading = 0.0, locked = true}, -- Mission Row Door To Cells Front
		{coords = vector3(446.5728, -980.0106, 30.8393), model = -1320876379, heading = 180.00012207031, locked = true}, -- Mission Row Police Station Captan's Office Door
		{coords = vector3(450.1041, -985.73840, 30.8393), model = 1557126584, heading = 89.661880493164, locked = true}, -- Mission Row Police Station Door To Locker Rooms
		{coords = vector3(452.6248, -987.3626, 30.8393), model = -2023754432, heading = 179.75776672363, locked = true}, -- Mission Row Police Station Locker Room 1 Door
		{coords = vector3(461.2865, -985.3206, 30.83926), model = 749848321, heading = 90.0, locked = true}, -- Mission Row Police Station Roof Access Door
		{coords = vector3(464.3613, -984.678, 43.83443), model = -340230128, heading = 90.0, locked = true}, -- Mission Row Police Station Roof Door
		{coords = vector3(1855.2312011719, 3683.5375976563, 34.266860961914), model = -1765048490, heading = 30.19642829895, locked = false}, -- Sandy Shores Main Door
		{coords = vector3(1846.4598388672, 3662.5939941406, -116.789894104), model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 1
		{coords = vector3(1852.0426025391, 3665.8259277344, -116.789894104), model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 2
		{coords = vector3(1857.5572509766, 3668.9914550781, -116.77988433838), model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 3
		{coords = vector3(1867.9284667969, 3674.638671875, -116.77992248535), model = 871712474, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 4 Lockdown
		{coords = vector3(1872.2075195313, 3676.9758300781, -116.7799911499), model = 871712474, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 5 Lockdown
	},
	double = {
		{
			["left"] = {coords = vector3(434.7479, -980.6184, 30.839260), model = -1215222675, heading = 270.18865966797, locked = false},
			["right"] = {coords = vector3(434.7479, -983.2151, 30.83926), model = 320433149, heading = 270.39477539063, locked = false},
		}, -- Mission Row Police Station Main Entrance
		{
			["left"] = {coords = vector3(467.3716, -1014.452, 26.53623), model = -2023754432, heading = 0.0, locked = true},
			["right"] = {coords = vector3(469.9679, -1014.452, 26.53623), model = -2023754432, heading = 179.99998474121, locked = true},
		}, -- Mission Row Police Station Back Entrance
		{
			["left"] = {coords = vector3(446.0079, -989.4454, 30.8393), model = 185711165, heading = 0.0, locked = true},
			["right"] = {coords = vector3(443.4078, -989.4454, 30.8393), model = 185711165, heading = 179.99998474121, locked = true},
		}, -- Mission Row Police Station Cell And Briefing Doors
		{
			["left"] = {coords = vector3(443.0298, -994.5412, 30.8393), model = -131296141, heading = 270.0, locked = true},
			["right"] = {coords = vector3(443.0298, -991.941, 30.8393), model = -131296141, heading = 90.0, locked = true},
		}, -- Mission Row Police Station Briefing Doors
		{
			["left"] = {coords = vector3(465.65545, -988.7089, 25.063995), model = 185711165, heading = 90.0, locked = false},
			["right"] = {coords = vector3(465.6554, -991.3040, 25.06399), model = 185711165, heading = 270.0, locked = false},
		}, -- Mission Row Police Station Interrogation Main Doors
	},
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2500)
		for Index = 1, #doors.single do
			if not DoesEntityExist(doors.single[Index].handle) then
				doors.single[Index].handle = GetClosestObjectOfType(doors.single[Index].coords.x, doors.single[Index].coords.y, doors.single[Index].coords.z, 0.5, doors.single[Index].model, false, false, false)
			end
		end

		for Index = 1, #doors.double do
			if not DoesEntityExist(doors.double[Index].left.handle) then
				doors.double[Index].left.handle = GetClosestObjectOfType(doors.double[Index].left.coords.x, doors.double[Index].left.coords.y, doors.double[Index].left.coords.z, 0.5, doors.double[Index].left.model, false, false, false)
			end

			if not DoesEntityExist(doors.double[Index].right.handle) then
				doors.double[Index].right.handle = GetClosestObjectOfType(doors.double[Index].right.coords.x, doors.double[Index].right.coords.y, doors.double[Index].right.coords.z, 0.5, doors.double[Index].right.model, false, false, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		local isParamedic = exports["emsjob"]:getIsParamedic()

		for Index = 1, #doors.single do
			local Distance = #(doors.single[Index].coords - PlayerPosition)

			if Distance <= 10.0 then
				if doors.single[Index].locked then
					if doors.single[Index].handle ~= nil and doors.single[Index].handle ~= 0 then
						SetEntityHeading(doors.single[Index].handle, doors.single[Index].heading)
					end
				end

				if isParamedic or isCop then
					if Distance <= 1.2 then
						SetDrawOrigin(doors.single[Index].coords.x, doors.single[Index].coords.y, PlayerPosition.z, 0)
						RenderText("~o~[E]"..(doors.single[Index].locked and "Locked" or "Unlocked"), 0, 0, 6, 0.3, 255, 255, 255, 255, "Centre", true, true)
						ClearDrawOrigin()

						if IsControlJustPressed(1, 51) then
							TriggerServerEvent("police:doors_lock", Index, "single")
						end
					end
				end
			end
		end

		for Index = 1, #doors.double do
			local LeftDistance, RightDistance =  #(doors.double[Index].left.coords - PlayerPosition), #(doors.double[Index].right.coords - PlayerPosition)

			if LeftDistance <= 10.0 or RightDistance <= 10.0 then
				if doors.double[Index].left.locked then
					if doors.double[Index].left.handle ~= nil and doors.double[Index].left.handle ~= 0 then
						SetEntityHeading(doors.double[Index].left.handle, doors.double[Index].left.heading)
					end

					if doors.double[Index].right.handle ~= nil and doors.double[Index].right.handle ~= 0 then
						SetEntityHeading(doors.double[Index].right.handle, doors.double[Index].right.heading)
					end
				end
				
				if isParamedic or isCop then
					if LeftDistance <= 1.2 or RightDistance <= 1.2 then
						SetDrawOrigin(doors.double[Index].left.coords.x, doors.double[Index].left.coords.y, PlayerPosition.z, 0)
						RenderText("~o~[E]"..(doors.double[Index].left.locked and "Locked" or "Unlocked"), 0, 0, 6, 0.3, 255, 255, 255, 255, "Centre", true, true)
						ClearDrawOrigin()

						if IsControlJustPressed(1, 51) then
							TriggerServerEvent("police:doors_lock", Index, "double")
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("police:doors_sync")
AddEventHandler("police:doors_sync", function(_doors)
	for Index = 1, #doors.single do
		doors.single[Index].locked = _doors.single[Index]
	end

	for Index = 1, #doors.double do
		doors.double[Index].left.locked = _doors.double[Index].left
		doors.double[Index].right.locked = _doors.double[Index].right
	end
end)

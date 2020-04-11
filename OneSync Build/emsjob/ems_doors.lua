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
		-- Gabz Hospital
		{coords = vector3(307.11819458008, -569.56896972656, 43.433910369873), model = 854291622, heading = -19.903734207153, locked = false}, -- Lab
		{coords = vector3(313.48007202148, -595.45831298828, 43.433910369873), model = 854291622, heading = -110.06006622314, locked = true}, -- Reception to lobby.
		{coords = vector3(309.13372802734, -597.75146484375, 43.433910369873), model = 854291622, heading = 160.00003051758, locked = true}, -- Reception to kitchen.
		{coords = vector3(340.78182983398, -581.82147216797, 43.433910369873), model = 854291622, heading = -19.96741104126, locked = false}, -- Diagnostics
		{coords = vector3(339.00497436523, -586.70336914063, 43.433910369873), model = 854291622, heading = -20.060035705566, locked = false}, -- Admin
		{coords = vector3(352.19967651367, -594.14776611328, 43.433910369873), model = 854291622, heading = -109.99677276611, locked = false}, -- Dr Office 373
		{coords = vector3(350.83407592773, -597.89971923828, 43.433910369873), model = 854291622, heading = -109.85498809814, locked = false}, -- Private Room 374
		{coords = vector3(356.12518310547, -583.36248779297, 43.433910369873), model = 854291622, heading = -109.88408660889, locked = false}, -- Private Room 370
		{coords = vector3(357.49078369141, -579.61053466797, 43.433910369873), model = 854291622, heading = -109.95799255371, locked = false}, -- Private Room 369
		{coords = vector3(360.50338745117, -588.99951171875, 43.433910369873), model = 854291622, heading = -19.999963760376, locked = false}, -- Private Room 371
		{coords = vector3(358.72653198242, -593.88140869141, 43.433910369873), model = 854291622, heading = -19.999963760376, locked = false}, -- Dr Office 372
		-- Sandy Shores
		{ coords = vector3(1841.9404296875, 3683.4755859375, 34.362609863281), heading = 209.79792785645, model = -1320876379, locked = true}, -- Locker Room
		{ coords = vector3(1838.6497802734, 3686.3188476563, 34.362609863281), heading = 299.70166015625, model = -1320876379, locked = true}, -- Desk Entrance
		{ coords = vector3(1835.650390625, 3691.7912597656, 34.362609863281), heading = 209.79792785645, model = -1320876379, locked = true}, -- Locker Room
	},
	double = {
		{
			["left"] = { coords = vector3(312.00512695313, -571.34118652344, 43.433910369873), model = -434783486, heading = -19.999963760376, locked = false },
			["right"] = { coords = vector3(314.4241027832, -572.22155761719, 43.433910369873), model = -1700911976, heading = -19.999963760376, locked = false },
		},
		{
			["left"] = { coords = vector3(317.84255981445, -573.46588134766, 43.433910369873), model = -434783486, heading = -19.999963760376, locked = false },
			["right"] = { coords = vector3(320.26153564453, -574.34631347656, 43.433910369873), model = -1700911976, heading = -19.999963760376, locked = false },
		},
		{
			["left"] = { coords = vector3(323.23754882813, -575.42944335938, 43.433910369873), model = -434783486, heading = -19.999963760376, locked = false },
			["right"] = { coords = vector3(325.6565246582, -576.30993652344, 43.433910369873), model = -1700911976, heading = -19.999963760376, locked = false },
		}
	}
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
		local isCop = exports["policejob"]:getIsCop()

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
							TriggerServerEvent("paramedic:doors_lock", Index, "single")
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
							TriggerServerEvent("paramedic:doors_lock", Index, "double")
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("paramedic:doors_sync")
AddEventHandler("paramedic:doors_sync", function(_doors)
	for Index = 1, #doors.single do
		doors.single[Index].locked = _doors.single[Index]
	end

	for Index = 1, #doors.double do
		doors.double[Index].left.locked = _doors.double[Index].left
		doors.double[Index].right.locked = _doors.double[Index].right
	end
end)
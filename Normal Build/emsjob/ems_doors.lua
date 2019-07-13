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
		{coords = vector3(272.21752929688, -1361.5660400391, 24.551530838013), model = 1653893025, heading = 320.00003051758, locked = true}, -- Morgue, reception door
		{coords = vector3(265.06137084961, -1363.3120117188, 24.551530838013), model = 1653893025, heading = 230.00003051758, locked = true}, -- Morgue, reception door 2
		{coords = vector3(256.56033325195, -1377.4182128906, 39.737594604492), model = 374758529, heading = 4.9999651908875, locked = true}, -- Computing room, 3rd floor, door 1
		{coords = vector3(261.21139526367, -1380.8220214844, 39.737594604492), model = 374758529, heading = 320.00003051758, locked = true}, -- Computing room, 3rd floor, door 2
		{coords = vector3(236.77729797363, -1367.3142089844, 39.679546356201), model = 1859711902, heading = 95.08666229248, locked = true}, -- Medical office, 3rd floor
	},
	double = {
		{
			["left"] = {coords = vector3(328.62420654297,-585.201171875, 43.327369689941), model = -770740285, heading = 160.00001525879, locked = false},
			["right"] = {coords = vector3(330.7939453125,-585.99090576172,43.327369689941), model = -770740285, heading = 340.00003051758, locked = false},
		}, -- Inner Pillbox hospital doors
		{
			["left"] = {coords = vector3(249.54711914063, -1383.7418212891, 39.744342803955), model = 374758529, heading = 49.99995803833, locked = false},
			["right"] = {coords = vector3(247.88844299316, -1385.7186279297, 39.744342803955), model = 374758529, heading = 229.99996948242, locked = false},
		}, -- Computing room, 3rd floor, double doors
		{
			["left"] = {coords = vector3(239.21530151367, -1363.4578857422, 39.737594604492), model = 374758529, heading = 229.62672424316, locked = false},
			["right"] = {coords = vector3(240.8713684082, -1361.4842529297, 39.737594604492), model = 374758529, heading = 49.889072418213, locked = false},
		}, -- Documents room, 3rd floor
		{
			["left"] = {coords = vector3(250.10475158691, -1370.2286376953, 39.737594604492), model = 374758529, heading = 320.25872802734, locked = false},
			["right"] = {coords = vector3(248.12802124023, -1368.5699462891, 39.737594604492), model = 374758529, heading = 140.00001525879, locked = false},
		}, -- Forensics Lab, 3rd floor Middle doors
		{
			["left"] = {coords = vector3(245.19139099121, -1383.4554443359, 39.743377685547), model = 374758529, heading = 229.73471069336, locked = false},
			["right"] = {coords = vector3(246.85006713867, -1381.4786376953, 39.743377685547), model = 374758529, heading = 50.25090026855, locked = false},
		}, -- Forensics Lab, 3rd floor Left doors
		{
			["left"] = {coords = vector3(237.6615447998, -1373.7686767578, 39.744342803955), model = 374758529, heading = 50.000022888184, locked = false},
			["right"] = {coords = vector3(236.00286865234, -1375.7454833984, 39.744342803955), model = 374758529, heading = 230.00003051758, locked = false},
		}, -- Forensics Lab, 3rd floor Right doors
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
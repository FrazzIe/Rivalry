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
		-- LOWER PILLBOX NEW INTERIOR
		{coords = vector3(337.22735595703, -584.046875, 28.81494140625), model = 1653893025, heading = 250.0055847168, locked = true}, -- Lower Pillbox Locker Room
		{coords = vector3(352.73638916016, -574.73425292969, 28.811931610107), model = 1653893025, heading = 69.991722106934, locked = true}, -- Lookout Room
		{coords = vector3(361.26593017578, -567.70306396484, 28.819242477417), model = 1653893025, heading = 69.991722106934, locked = true}, -- Infirmary Room
		{coords = vector3(334.15838623047, -577.46087646484, 28.820701599121), model = 1653893025, heading = 339.98083496094, locked = true}, -- Operation Side
		{coords = vector3(330.17877197266, -576.01202392578, 28.820701599121), model = 1653893025, heading = 159.99555969238, locked = true}, -- Operation 2
		{coords = vector3(323.71957397461, -590.71240234375, 28.938451766968), model = 1859711902, heading = 159.85054016113, locked = true}, -- Chief Examiner
		{coords = vector3(332.70712280273, -587.72082519531, 28.809652328491), model = 1653893025, heading = 159.99555969238, locked = true}, -- Lower Pillbox Locker Side
	},
	double = {
		{
			["left"] = {coords = vector3(325.05090332031, -588.92846679688, 43.344619750977), model = -770740285, heading = 160.00001525879, locked = false},
			["right"] = {coords = vector3(327.2121887207, -589.71508789063, 43.344619750977), model = -770740285, heading = 340.00003051758, locked = false},
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

		-- LOWER PILLBOX NEW INTERIOR
		{
			["left"] = {coords = vector3(346.8180847168, -572.02557373047, 28.797302246094), model = -770740285, heading = 69.991722106934, locked = true}, -- Lookout Room
			["right"] = {coords = vector3(346.0309753418, -574.18878173828, 28.797302246094), model = -770740285, heading = 250.0055847168, locked = true},
		},
		{ 
			["left"] = {coords = vector3(345.05859375, -567.96478271484, 28.820510864258), model = -770740285, heading = 159.99555969238, locked = false}, -- Infirmary
			["right"] = {coords = vector3(347.22665405273, -568.73327636719, 28.820510864258), model = -770740285, heading = 339.98083496094, locked = false},
		},
		{
			["left"] = {coords = vector3(341.39196777344, -572.50708007813, 28.818971633911), model = -770740285, heading = 250.0055847168, locked = true}, -- Hall Entrance
			["right"] = {coords = vector3(342.17840576172, -570.34729003906, 28.818971633911), model = -770740285, heading = 69.991722106934, locked = true},
		},
		{
			["left"] = {coords = vector3(333.78845214844, -593.40551757813, 28.802772521973), model = -770740285, heading = 250.0055847168, locked = true}, -- Paramedic Entrance
			["right"] = {coords = vector3(334.57537841797, -591.24450683594, 28.802772521973), model = -770740285, heading = 69.991729736328, locked = true},
		},
		{
			["left"] = {coords = vector3(337.99127197266, -572.20837402344, 28.9397315979), model = 580361003, heading = 339.98083496094, locked = true}, -- Operation Table
			["right"] = {coords = vector3(335.56884765625, -571.33117675781, 28.9397315979), model = 1415151278, heading = 339.98083496094, locked = true},
		},
		{
			["left"] = {coords = vector3(331.38259887695, -569.80816650391, 28.9397315979), model = 580361003, heading = 340.17709350586, locked = true}, -- Opperation 2
			["right"] = {coords = vector3(328.95724487305, -568.92449951172, 28.9397315979), model = 1415151278, heading = 339.98083496094, locked = true},
		},
		{
			["left"] = {coords = vector3(323.12307739258, -566.95922851563, 28.82303237915), model = -770740285, heading = 339.98083496094, locked = true}, -- Morgue Entrance
			["right"] = {coords = vector3(320.95690917969, -566.17059326172, 28.82303237915), model = -770740285, heading = 159.99555969238, locked = true},
		},
		{
			["left"] = {coords = vector3(318.76770019531, -561.01983642578, 28.880311965942), model = -1920147247, heading = 206.43293762207, locked = true}, -- Back Exit
			["right"] = {coords = vector3(321.0087890625, -559.96087646484, 28.880311965942), model = -1920147247, heading = 26.040521621704, locked = true},
		},
		{
			["left"] = {coords = vector3(318.76806640625, -574.02288818359, 28.937282562256), model = 1415151278, heading = 250.0055847168, locked = true}, -- Autopsy One
			["right"] = {coords = vector3(317.88784790039, -576.44207763672, 28.937282562256), model = 580361003, heading = 249.77551269531, locked = true},
		},
		{
			["left"] = {coords = vector3(313.5016784668, -574.84906005859, 28.935340881348), model = 580361003, heading = 249.70288085938, locked = true}, -- Morgue Doorway
			["right"] = {coords = vector3(314.38244628906, -572.42840576172, 28.935340881348), model = 1415151278, heading = 249.72265625, locked = true},
		},
		{
			["left"] = {coords = vector3(314.88363647461, -581.20758056641, 28.819841384888), model = -770740285, heading = 339.98083496094, locked = true}, -- Paramedic Hall
			["right"] = {coords = vector3(312.72149658203, -580.42041015625, 28.819841384888), model = -770740285, heading = 159.99555969238, locked = true},
		},
		{
			["left"] = {coords = vector3(318.94046020508, -588.97814941406, 28.983642578125), model = 374758529, heading = 339.93426513672, locked = true}, --Classroom Door
			["right"] = {coords = vector3(316.51669311523, -588.09576416016, 28.983652114868), model = 374758529, heading = 160.16090393066, locked = true},
		},
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
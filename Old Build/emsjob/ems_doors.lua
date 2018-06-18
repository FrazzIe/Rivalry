--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--Door models: https://wiki.gtanet.work/index.php?title=Doors

local function Draw3DText(x,y,z, text) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.3*scale)
        SetTextFont(6)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local doors = {
	single = {
		[1] = {x = 272.21752929688, y = -1361.5660400391, z = 24.551530838013, model = 1653893025, heading = 320.00003051758, locked = true}, -- Morgue, reception door
		[2] = {x = 265.06137084961, y = -1363.3120117188, z = 24.551530838013, model = 1653893025, heading = 230.00003051758, locked = true}, -- Morgue, reception door 2
		[3] = {x = 256.56033325195, y = -1377.4182128906, z = 39.737594604492, model = 374758529, heading = 4.9999651908875, locked = true}, -- Computing room, 3rd floor, door 1
		[4] = {x = 261.21139526367, y = -1380.8220214844, z = 39.737594604492, model = 374758529, heading = 320.00003051758, locked = true}, -- Computing room, 3rd floor, door 2
		[5] = {x = 236.77729797363, y = -1367.3142089844, z = 39.679546356201, model = 1859711902, heading = 95.08666229248, locked = true}, -- Medical office, 3rd floor
	},
	double = {
		[1] = {
			["left"] = {x = 325.05090332031, y = -588.92846679688, z = 43.344619750977, model = -770740285, heading = 160.00001525879, locked = false},
			["right"] = {x = 327.2121887207, y = -589.71508789063, z = 43.344619750977, model = -770740285, heading = 340.00003051758, locked = false},
		}, -- Inner Pillbox hospital doors
		[2] = {
			["left"] = {x = 249.54711914063, y = -1383.7418212891, z = 39.744342803955, model = 374758529, heading = 49.99995803833, locked = false},
			["right"] = {x = 247.88844299316, y = -1385.7186279297, z = 39.744342803955, model = 374758529, heading = 229.99996948242, locked = false},
		}, -- Computing room, 3rd floor, double doors
		[3] = {
			["left"] = {x = 239.21530151367, y = -1363.4578857422, z = 39.737594604492, model = 374758529, heading = 229.62672424316, locked = false},
			["right"] = {x = 240.8713684082, y = -1361.4842529297, z = 39.737594604492, model = 374758529, heading = 49.889072418213, locked = false},
		}, -- Documents room, 3rd floor
		[4] = {
			["left"] = {x = 250.10475158691, y = -1370.2286376953, z = 39.737594604492, model = 374758529, heading = 320.25872802734, locked = false},
			["right"] = {x = 248.12802124023, y = -1368.5699462891, z = 39.737594604492, model = 374758529, heading = 140.00001525879, locked = false},
		}, -- Forensics Lab, 3rd floor Middle doors
		[5] = {
			["left"] = {x = 245.19139099121, y = -1383.4554443359, z = 39.743377685547, model = 374758529, heading = 229.73471069336, locked = false},
			["right"] = {x = 246.85006713867, y = -1381.4786376953, z = 39.743377685547, model = 374758529, heading = 50.25090026855, locked = false},
		}, -- Forensics Lab, 3rd floor Left doors
		[6] = {
			["left"] = {x = 237.6615447998, y = -1373.7686767578, z = 39.744342803955, model = 374758529, heading = 50.000022888184, locked = false},
			["right"] = {x = 236.00286865234, y = -1375.7454833984, z = 39.744342803955, model = 374758529, heading = 230.00003051758, locked = false},
		}, -- Forensics Lab, 3rd floor Right doors
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
			if isParamedic or exports["policejob"]:getIsCop() then
				local pos = GetEntityCoords(PlayerPedId(),false)
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) <= 1.2 then
					local state = "Unlocked"
					if v.locked then state = "Locked" end
					Draw3DText(v.x, v.y, pos.z,"~o~[E]"..state)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("paramedic:doors_lock", k, "single")
					end
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
			if isParamedic or exports["policejob"]:getIsCop() then
				local pos = GetEntityCoords(PlayerPedId(),false)
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.left.x, v.left.y, v.left.z, true) <= 1.5 or GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.right.x, v.right.y, v.right.z, true) <= 1.5 then
					local state = "Unlocked"
					if v.left.locked then state = "Locked" end
					Draw3DText(v.left.x, v.left.y, v.left.z,"~o~[E]"..state)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("paramedic:doors_lock", k, "double")
					end
				end
			end
		end
	end
end)

RegisterNetEvent("paramedic:doors_sync")
AddEventHandler("paramedic:doors_sync", function(_doors)
	doors = _doors
end)
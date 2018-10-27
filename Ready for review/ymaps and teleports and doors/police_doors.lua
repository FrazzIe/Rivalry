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
		[1] = {x = 463.4782, y = -1003.538, z = 25.00599, model = -1033001619, heading = 0.0, locked = true}, -- Mission Row Door To Cells Back
		[2] = {x = 461.8065, y = -994.4086, z = 25.06443, model = 631614199, heading = 270.0, locked = true}, -- Mission Row Cell Door 1
		[3] = {x = 461.8065, y = -997.6583, z = 25.06443, model = 631614199, heading = 90.0, locked = true}, -- Mission Row Cell Door 2
		[4] = {x = 461.8065, y = -1001.302, z = 25.06443, model = 631614199, heading = 90.0, locked = true}, -- Mission Row Cell Door 3
		[5] = {x = 464.5701, y = -992.6641, z = 25.06443, model = 631614199, heading = 0.0, locked = true}, -- Mission Row Door To Cells Front
		[6] = {x = 446.5728, y = -980.0106, z = 30.8393, model = -1320876379, heading = 180.00012207031, locked = true}, -- Mission Row Police Station Captan's Office Door
		[7] = {x = 450.1041, y = -985.73840, z = 30.8393, model = 1557126584, heading = 89.661880493164, locked = true}, -- Mission Row Police Station Door To Locker Rooms
		[8] = {x = 452.6248, y = -987.3626, z = 30.8393, model = -2023754432, heading = 179.75776672363, locked = true}, -- Mission Row Police Station Locker Room 1 Door
		[9] = {x = 461.2865, y = -985.3206, z = 30.83926, model = 749848321, heading = 90.0, locked = true}, -- Mission Row Police Station Roof Access Door
		[10] = {x = 464.3613, y = -984.678, z = 43.83443, model = -340230128, heading = 90.0, locked = true}, -- Mission Row Police Station Roof Door
		[11] = {x = 1855.2312011719, y = 3683.5375976563, z = 34.266860961914, model = -1765048490, heading = 30.19642829895, locked = false}, -- Sandy Shores Main Door
		[12] = {x = 1846.4598388672, y = 3662.5939941406, z = -116.789894104, model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 1
		[13] = {x = 1852.0426025391, y = 3665.8259277344, z = -116.789894104, model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 2
		[14] = {x = 1857.5572509766, y = 3668.9914550781, z = -116.77988433838, model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 3
		[15] = {x = 1867.9284667969, y = 3674.638671875, z = -116.77992248535, model = 871712474, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 4 Lockdown
		[16] = {x = 1872.2075195313, y = 3676.9758300781, z = -116.7799911499, model = 871712474, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 5 Lockdown
		[17] = {x = 423.20999145508, y = -998.20001220703, z = 30.799999237061, model = -1635579193, heading = 179.98808288574, locked = true}, -- Mission Row Wall Door
		[18] = {x = -440.42999267578, y = 6006.08984375, z = -118.59999847412, model = -642608865, heading = 135.51921081543, locked = true}, -- Paleto Jail Cells 1
		[19] = {x = -436.8454284668, y = 6002.5263671875, z = -118.59999847412, model = -642608865, heading = 135.51921081543, locked = true}, -- Paleto Jail Cells 2
		[20] = {x = -433.29452514648, y = 5998.9741210938, z = -118.59999847412, model = -642608865, heading = 135.18885803223, locked = true}, -- -- Paleto Jail Cells 3
		[21] = {x = 1785.7900390625, y = 2479.2099609375, z = -122.55000305176, model = -642608865, heading = 178.45016479492, locked = true}, -- Jail Cell 1
		[22] = {x = 1788.9499511719, y = 2479.1799316406, z = -122.55000305176, model = -642608865, heading = 178.2713470459,  locked = true}, -- Jail Cell 2
		[23] = {x = 1792.1300048828, y = 2479.2099609375, z = -122.55000305176, model = -642608865, heading = 179.91905212402, locked = true}, -- Jail Cell 3
		[24] = {x = 1795.2900390625, y = 2479.1799316406, z = -122.55000305176, model = -642608865, heading = 180.31105041504, locked = true}, -- Jail Cell 4
		[25] = {x = 1798.4499511719, y = 2479.1499023438, z = -122.54000091553, model = -642608865, heading = 181.47987365723, locked = true}, -- Jail Cell 5
		[26] = {x = 1788.9599609375, y = 2487.1101074219, z = -122.55000305176, model = -642608865, heading = 180.24070739746, locked = true}, -- Jail Cell 6
		[27] = {x = 1792.1300048828, y = 2487.1000976563, z = -122.55000305176, model = -642608865, heading = 180.52368164063, locked = true}, -- Jail Cell 7
		[28] = {x = 1795.2900390625, y = 2487.1201171875, z = -122.55999755859, model = -642608865, heading = 179.66612243652, locked = true}, -- Jail Cell 8
		[29] = {x = 1798.4499511719, y = 2487.1398925781, z = -122.54000091553, model = -642608865, heading = 178.89085388184, locked = true}, -- Jail Cell 9
		[30] = {x = 1788.9599609375, y = 2487.1201171875, z = -118.93000030518, model = -642608865, heading = 180.18588256836, locked = true}, -- Jail Cell 10
		[31] = {x = 1792.1300048828, y = 2487.1201171875, z = -118.91000366211, model = -642608865, heading = 180.36251831055, locked = true}, -- Jail Cell 11
		[32] = {x = 1795.3000488281, y = 2487.1201171875, z = -118.93000030518, model = -642608865, heading = 180.23712158203, locked = true}, -- Jail Cell 12
		[33] = {x = 1798.4499511719, y = 2487.1201171875, z = -118.91999816895, model = -642608865, heading = 180.23712158203, locked = true}, -- Jail Cell 13
		[34] = {x = 1798.4399414063, y = 2479.2099609375, z = -118.91999816895, model = -642608865, heading = 181.01045227051, locked = true}, -- Jail Cell 14
		[35] = {x = 1795.2800292969, y = 2479.1999511719, z = -118.91999816895, model = -642608865, heading = 179.83967590332, locked = true}, -- Jail Cell 15
		[36] = {x = 1792.1300048828, y = 2479.2099609375, z = -118.93000030518, model = -642608865, heading = 180.14208984375, locked = true}, -- Jail Cell 16
		[37] = {x = 1788.9499511719, y = 2479.1799316406, z = -118.93000030518, model = -642608865, heading = 180.10104370117, locked = true}, -- Jail Cell 17
		[38] = {x = 1785.7900390625, y = 2479.2099609375, z = -118.91000366211, model = -642608865, heading = 179.72773742676, locked = true}, -- Jail Cell 18
		[39] = {x = 1693.1748046875, y = 2577.3432617188, z = -69.220001220703, model = -519068795, heading = 89.498985290527, locked = true}, -- Jail Visitation Door 1
		[40] = {x = 1692.4855957031, y = 2579.74609375, z = -69.290000915527, model = -642608865, heading = 359.79888916016, locked = true}, -- Jail Visitation Door 2
		[41] = {x = 1693.5672607422, y = 2581.3898925781, z = -69.23999786377, model = -519068795, heading = 89.498947143555, locked = true}, -- Jail Visitation Door 3
		[42] = {x = 1702.5899658203, y = 2577.3898925781, z = -69.290000915527, model = -519068795, heading = 359.49954223633, locked = true}, -- Jail Visitation Door 4
		[43] = {x = 1708.8831787109, y = 2570.6899414063, z = -69.300003051758, model = -519068795, heading = 89.498870849609, locked = true}, -- Jail Armoury Door 1
		[44] = {x = 2050.6770019531, y = 2963.6096191406, z = -67.152450561523, model = -147325430, heading = 54.57328414917, locked = true}, -- Interogation Room 1
		[45] = {x = 2050.6818847656, y = 2974.7854003906, z = -67.152450561523, model = -147325430,  heading = 54.99116897583, locked = true}, -- Interogation Room 2
		[46] = {x = 2054.6921386719, y = 2969.34375, z = -67.152450561523, model = -147325430, heading = 54.729328155518, locked = true}, -- Interogation Room 3
		[47] = {x = 2054.6967773438, y = 2980.51953125, z = -67.152450561523, model = -147325430, heading = 54.668598175049, locked = true}, -- Interogation Room 4
		[48] = {x = 1844.9984130859, y = 2604.810546875, z = 44.636260986328, model = 741314661, heading = 90.0, locked = true}, -- Jail Gate 1
		[49] = {x = 1818.5428466797, y = 2604.810546875, z = 44.607486724854, model = 741314661, heading = 90.0, locked = true}, -- Jail Gate 2
		[50] = {x = 1799.6083984375, y = 2616.9753417969, z = 44.603248596191, model = 741314661, heading = 179.99998474121, locked = true}, -- Jail Gate 3
		[51] = {x = 1797.7608642578, y = 2596.5649414063, z = 46.387306213379, model = -1156020871, heading = 179.99987792969, locked = true}, -- Jail Fence Door 1
		[52] = {x = 1798.0900878906, y = 2591.6872558594, z = 46.417839050293, model = -1156020871, heading = 179.99987792969, locked = true}, -- Jail Fence Door 2
	}, 
	double = {
		[1] = {
			["left"] = {x = 434.7479, y = -980.6184, z = 30.839260, model = -1215222675, heading = 270.18865966797, locked = false},
			["right"] = {x = 434.7479, y = -983.2151, z = 30.83926, model = 320433149, heading = 270.39477539063, locked = false},
		}, -- Mission Row Police Station Main Entrance
		[2] = {
			["left"] = {x = 467.3716, y = -1014.452, z = 26.53623, model = -2023754432, heading = 0.0, locked = true},
			["right"] = {x = 469.9679, y = -1014.452, z = 26.53623, model = -2023754432, heading = 179.99998474121, locked = true},
		}, -- Mission Row Police Station Back Entrance
		[3] = {
			["left"] = {x = 446.0079, y = -989.4454, z = 30.8393, model = 185711165, heading = 0.0, locked = true},
			["right"] = {x = 443.4078, y = -989.4454, z = 30.8393, model = 185711165, heading = 179.99998474121, locked = true},
		}, -- Mission Row Police Station Cell And Briefing Doors
		[4] = {
			["left"] = {x = 443.0298, y = -994.5412, z = 30.8393, model = -131296141, heading = 270.0, locked = true},
			["right"] = {x = 443.0298, y = -991.941, z = 30.8393, model = -131296141, heading = 90.0, locked = true},
		}, -- Mission Row Police Station Briefing Doors
	},
	chairs = {
		[1] = {x = 2062.16796875, y = 2968.5678710938, z = -68.302452087402, h = 240.00004577637, model = -109356459},
		[2] = {x = 2061.2041015625, y = 2967.1762695313, z = -68.302452087402, h = 235.00003051758, model = -109356459},
		[3] = {x = 2059.6010742188, y = 2969.2836914063, z = -68.221450805664, h = 55.000015258789, model = 1037469683},
		[4] = {x = 2050.7937011719, y = 2985.0041503906, z = -68.221450805664, h = 144.99996948242, model = 1037469683},
		[5] = {x = 2052.1916503906, y = 2986.9226074219, z = -68.221450805664, h = 340.00003051758, model = 1037469683},
		[6] = {x = 2046.7769775391, y = 2979.2724609375, z = -68.221450805664, h = 144.99996948242, model = 1037469683},
		[7] = {x = 2048.1748046875, y = 2981.1906738281, z = -68.221450805664, h = 340.00003051758, model = 1037469683},
		[8] = {x = 2055.5239257813, y = 2963.4650878906, z = -68.221450805664, h = 55.000015258789, model = 1037469683},
		[9] = {x = 2058.0908203125, y = 2962.7495117188, z = -68.302452087402, h = 240.00004577637, model = -109356459},
		[10] = {x = 2057.1271972656, y = 2961.3579101563, z = -68.302452087402, h = 235.00003051758, model = -109356459},
	}
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
			if isCop then
				if GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, v.x, v.y, v.z, true) <= 1.2 then
					local state = "Unlocked"
					if v.locked then state = "Locked" end
					Draw3DText(v.x, v.y, PlayerPosition.z,"~o~[E]"..state)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("police:doors_lock", k, "single")
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
			if isCop then
				if GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, v.left.x, v.left.y, v.left.z, true) <= 1.5 or GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, v.right.x, v.right.y, v.right.z, true) <= 1.5 then
					local state = "Unlocked"
					if v.left.locked then state = "Locked" end
					Draw3DText(v.left.x, v.left.y, v.left.z,"~o~[E]"..state)
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("police:doors_lock", k, "double")
					end
				end
			end
		end
		for k, v in pairs(doors.chairs) do
			local entity = GetClosestObjectOfType(v.x, v.y, v.z, 0.5, v.model, false, false, false)
			FreezeEntityPosition(entity, true)
		end
	end
end)

RegisterNetEvent("police:doors_sync")
AddEventHandler("police:doors_sync", function(_doors)
	doors = _doors
end)
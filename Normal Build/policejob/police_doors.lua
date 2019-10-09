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
		-- OLD (Lamars)
		-- {coords = vector3(471.04309, -987.978, 24.9137), model = 452874391, heading = 180.0, locked = true}, -- Mission Row Interrogation Cell Door 1
		-- {coords = vector3(478.5546, -987.878, 25.0524), model = 452874391, heading = 180.0, locked = true}, -- Mission Row Interrogation Cell Door 2
		-- {coords = vector3(474.4076, -987.878, 25.0675), model = -340230128, heading = 0.0, locked = true}, -- Mission Row Interrogation Observe
		-- {coords = vector3(478.1655, -992.1209, 25.060), model = 452874391, heading = 0, locked = true}, -- Mission Row Mug Shot
		-- END
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
		-- NEW ALPHA MRPD
		{coords = vector3(464.15835571289,-1011.2600097656,33.011207580566), model = 507213820, heading = 0.87829905748367, locked = true}, -- Back 2nd Floor Exit
		{coords = vector3(463.69995117188,-983.37902832031,35.99437713623), model = -131296141, heading = 89.447227478027, locked = true}, -- 2nd Floor Stair Door
		{coords = vector3(467.18310546875,-1003.5381469727,25.005992889404), model = -1033001619, heading = 0.13817027211189, locked = true}, -- 1st Interrogation Room
		{coords = vector3(471.46899414063,-1003.5381469727,25.005992889404), model = -1033001619, heading = 0.046020869165659, locked = true}, -- 1st Interrogation Room Observe
		{coords = vector3(475.75552368164,-1003.5381469727,25.005992889404), model = -1033001619, heading = 359.99917602539, locked = true}, -- 2nd Interrogation Room
		{coords = vector3(480.03005981445,-1003.5381469727,25.005992889404), model = -1033001619, heading = 359.82995605469, locked = true}, -- 2nd Interrogation Room Observe
		{coords = vector3(467.19216918945,-996.45935058594,25.005992889404), model = -1033001619, heading = 359.86532592773, locked = true}, -- 1st Cell
		{coords = vector3(471.47552490234,-996.45935058594,25.005992889404), model = -1033001619, heading = 359.90072631836, locked = true}, -- 2nd Cell
		{coords = vector3(475.75427246094,-996.45935058594,25.005992889404), model = -1033001619, heading = 0.29999488592148, locked = true}, -- 3rd Cell
		{coords = vector3(480.03005981445,-996.45935058594,25.005992889404), model = -1033001619, heading = 359.71765136719, locked = true}, -- 4th Cell
		{coords = vector3(463.61459350586,-980.58135986328,25.057952880859), model = -131296141, heading = 90.584655761719, locked = true}, -- Forensics Lab
		{coords = vector3(467.59359741211,-977.99334716797,25.057952880859), model = -131296141, heading = 180.23388671875, locked = true}, -- Server Room
		{coords = vector3(471.3154296875,-986.10906982422,25.057952880859), model = -131296141, heading = 270.37399291992, locked = true}, -- Evidence Locker
		{coords = vector3(442.66253662109,-988.24133300781,26.819765090942), model = -131296141, heading = 178.92091369629, locked = true}, -- Mugshot
		-- END
		-- OLD
		-- {coords = vector3(1846.4598388672, 3662.5939941406, -116.789894104), model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 1
		-- {coords = vector3(1852.0426025391, 3665.8259277344, -116.789894104), model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 2
		-- {coords = vector3(1857.5572509766, 3668.9914550781, -116.77988433838), model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 3
		-- {coords = vector3(1867.9284667969, 3674.638671875, -116.77992248535), model = 871712474, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 4 Lockdown
		-- {coords = vector3(1872.2075195313, 3676.9758300781, -116.7799911499), model = 871712474, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 5 Lockdown
		-- END
		-- Paleto Office
		{coords = vector3(-449.79461669922,6015.4482421875,31.866329193115), model = -2023754432, heading = 135.06001281738, locked = true}, -- Interrogation Viewing
		{coords = vector3(-454.53598022461,6011.2578125,31.869819641113), model = -519068795, heading = 10.008575439453, locked = true}, -- Interrogation Room
		{coords = vector3(-450.97872924805,6006.0747070313,31.994165420532), model = 452874391, heading = 315.33605957031, locked = true}, -- Back Door Number One
		{coords = vector3(-447.2262878418,6002.3286132813,31.839426040649), model = 452874391, heading = 134.83694458008, locked = true}, -- Back Door Number Two
		{coords = vector3(-437.68914794922,6008.3637695313,31.864067077637), model = -952356348, heading = 45.045776367188, locked = true}, -- Office One
		{coords = vector3(-441.05389404297,6004.9970703125,31.864400863647), model = -952356348, heading = 44.928436279297, locked = true}, -- Office Two
		{coords = vector3(-437.61444091797,5992.8193359375,31.936056137085), model = -1011692606, heading = 314.71322631836, locked = true}, -- Evidence Locker Door Entrance
		{coords = vector3(-441.47674560547,5990.244140625,32.333431243896), model = -1156020871, heading = 315.2255859375, locked = true}, -- Evidence Locker Gate Entrance
		{coords = vector3(-432.17544555664,5992.1215820313,31.873119354248), model = 631614199, heading = 315.49444580078, locked = true}, -- Cell Area Entrance One
		{coords = vector3(-428.06463623047,5996.671875,31.873123168945), model = 631614199, heading = 315.51547241211, locked = true}, -- Cell 2
		{coords = vector3(-431.19207763672,5999.7416992188,31.873123168945), model = 631614199, heading = 315.51547241211, locked = true}, -- Cell 1
		-- New Sandy Shores
		{ coords = vector3(1856.1451416016, 3689.67578125, 34.435485839844), heading = 30.165987014771, model = -2023754432, locked = true }, -- Locker Room / Armory Room
		{ coords = vector3(1848.1761474609, 3681.4304199219, 34.404941558838), heading = 299.81994628906, model = 631614199, locked = true }, -- Cell 1
		{ coords = vector3(1846.4395751953, 3684.4345703125, 34.40397644043), heading = 299.81994628906, model = 631614199, locked = true },-- Cell 2
		{ coords = vector3(1844.0726318359, 3688.5341796875, 34.40397644043), heading = 119.99996948242, model = 631614199, locked = true }, -- Cell 3
		{ coords = vector3(1853.8251953125, 3695.8830566406, 34.52759552002), heading = 298.60534667969, model = 1817008884, locked = true }, -- Evidence Gate
		{ coords = vector3(1855.6870117188, 3683.9265136719, 34.585845947266), heading = 30.196424484253, model = -1765048490, locked = false }, -- Front Door
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
		-- OLD (Lamars)
		-- {
		-- 	["left"] = {coords = vector3(465.65545, -988.7089, 25.063995), model = 185711165, heading = 90.0, locked = false},
		--	["right"] = {coords = vector3(465.6554, -991.3040, 25.06399), model = 185711165, heading = 270.0, locked = false},
		-- }, -- Mission Row Police Station Interrogation Main Doors
		-- END
		-- NEW ALPHA MRPD
		{
			["left"] = {coords = vector3(429.17147827148,-996.22595214844,36.168766021729), model = -603023671, heading = 269.99044799805, locked = true},
			["right"] = {coords = vector3(429.20233154297,-994.04864501953,36.168766021729), model = -603023671, heading = 89.235107421875, locked = true},
		}, -- Front 2nd Floor Balcony Doors
		{
			["left"] = {coords = vector3(447.21844482422,-999.00231933594,30.789419174194), model = -1033001619, heading = 180.0746307373, locked = true},
			["right"] = {coords = vector3(444.62118530273,-999.00103759766,30.788663864136), model = -1033001619, heading = 359.98760986328, locked = true},
		},  -- 1st Floor Exit to Motor pool
		-- END
		-- New Paleto
		{
			["left"] = {coords = vector3(-444.49850463867,6017.0600585938,31.866329193115), model = -1501157055, heading = 135.03819274902, locked = false},
			["right"] = {coords = vector3(-442.66006469727,6015.2216796875,31.866329193115), model = -1501157055, heading = 314.99880981445, locked = false},
		},
		{
			["left"] = {coords = vector3(-440.98068237305,6012.771484375,31.866329193115), model = 964838196, heading = 45.062015533447, locked = true},
			["right"] = {coords = vector3(-442.82150268555,6010.9306640625,31.866329193115), model = 964838196, heading = 224.77478027344, locked = true},
		},
		{
			["left"] = {coords = vector3(-447.70916748047,6006.716796875,31.8088722229), model = 245182344, heading = 315.00006103516, locked = true},
			["right"] = {coords = vector3(-449.55001831055,6008.5576171875,31.8088722229), model = -681066206, heading = 135.00007629395, locked = true},
		},
		-- Sandy Shores
		{
			["left"] = { coords = vector3(1851.2661132813, 3681.8745117188, 34.40412902832), heading = 119.31882476807, model = -2023754432, locked = true }, -- Left Doors
			["right"] = { coords = vector3(1849.9934082031, 3684.140625, 34.40412902832), heading = 299.99996948242, model = -2023754432, locked = true }, -- Left Doors
		},
		{
			["left"] = { coords = vector3(1847.1619873047, 3689.912109375, 34.423355102539), heading = 29.999992370605, model = -2023754432, locked = true }, -- Center Doors
			["right"] = { coords = vector3(1849.4134521484, 3691.2119140625, 34.423355102539), heading = 210.07531738281, model = -2023754432, locked = true }, -- Center Doors
		},
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

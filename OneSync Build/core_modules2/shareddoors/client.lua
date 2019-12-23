--[[
    Script created by: Frazzle / Kole

    Contact: frazzle9999@gmail.com / ructararena@gmail.com

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
        { coords = vector3(-580.07202148438, -212.22734069824, 38.367610931396), heading = 120.00005340576, model = 1042741067, locked = true, Shared = false }, -- Parliament Head Office
        { coords = vector3(-569.13677978516, -209.33868408203, 38.331676483154), heading = 209.99981689453, model = -739665083, locked = true, Shared = false }, -- Parliament Room Left Door
        { coords = vector3(-577.65844726563, -214.25868225098, 38.331676483154), heading = 30.03768157959, model = -739665083, locked = true, Shared = false }, -- Parliament Room Right Door
        { coords = vector3(-580.68151855469, -210.82168579102, 42.863037109375), heading = 119.93845367432, model = 1042741067, locked = true, Shared = false }, -- Parliament Wing Second Story Main Office
        { coords = vector3(-540.59063720703, -189.69480895996, 38.369422912598), heading = 210.00004577637, model = 1335309163, locked = true, Shared = false }, -- Right Wing Office Space
        { coords = vector3(-536.71636962891, -182.96731567383, 38.369422912598), heading = 209.99998474121, model = 1335309163, locked = true, Shared = false }, -- RIght Wing Committee Room
        { coords = vector3(-535.8828125, -186.9859161377, 38.369422912598), heading = 29.999996185303, model = 1335309163, locked = true, Shared = false }, -- Right Wing Secondary Office
        { coords = vector3(-533.64685058594, -181.19012451172, 42.860984802246), heading = 29.999996185303, model = 1042741067, locked = true, Shared = false }, -- Right Wing Second Story Office Space
        { coords = vector3(-542.0390625, -191.61517333984, 47.695934295654), heading = 29.999996185303, model = 736699661, locked = true, Shared = false }, -- Third Floor Right Wing Hallway Office
    },
	double = {
		{
			["left"] = { coords = vector3(-546.45855712891, -203.94764709473, 38.372299194336), heading = 210.00076293945, model = -29187315, locked = false, Shared = true }, -- Front Main Entrance
			["right"] = { coords = vector3(-544.55334472656, -202.84765625, 38.372299194336), heading = 29.999996185303, model = -29187315, locked = false, Shared = true }, -- Front Main Entrance
		},
		{
			["left"] = { coords = vector3(-555.69122314453, -197.61819458008, 38.36275100708), heading = 300.01049804688, model = -384927587, locked = true, Shared = true }, -- Lobby Left Door
			["right"] = { coords = vector3(-556.96118164063, -195.41850280762, 38.36275100708), heading = 119.95844268799, model = -384927587, locked = true, Shared = true } -- Lobby Left Door
        },
        {
			["left"] = { coords = vector3(-546.82006835938, -189.56350708008, 38.36275100708), heading = 120.00009155273, model = -384927587, locked = true, Shared = true }, -- Lobby Right Door
			["right"] = { coords = vector3(-545.55010986328, -191.76319885254, 38.36275100708), heading = 300.00006103516, model = -384927587, locked = true, Shared = true }, -- Lobby Right Door
        },
        {
			["left"] = { coords = vector3(-569.60107421875, -205.63862609863, 38.362159729004), heading = 300.04782104492, model = -384927587, locked = true, Shared = true }, -- Parliament Inner Main Entrance
			["right"] = { coords = vector3(-570.87103271484, -203.43891906738, 38.362159729004), heading = 119.91987609863, model = -384927587, locked = true, Shared = true }, -- Parliament Inner Main Entrance
        },
        {
			["left"] = { coords = vector3(-583.58221435547, -195.82420349121, 38.517795562744), heading = 210.00009155273, model = -29187315, locked = true, Shared = true }, -- Parliament Main Entrance
			["right"] = { coords = vector3(-581.69946289063, -194.73719787598, 38.517795562744), heading = 29.999996185303, model = -29187315, locked = true, Shared = true }, -- Parliament Main Entrance
        },
        {
            ["left"] = { coords = vector3(-569.9619140625, -202.13093566895, 33.569732666016), heading = 209.99980163574, model = 1956494919, locked = true, Shared = true }, -- Parliament Stage Entrance
            ["right"] = { coords = vector3(-567.71453857422, -200.8334197998, 33.569732666016), heading = 29.999996185303, model = 1956494919, locked = true, Shared = true }, -- Parliament Stage Entrance
        },
        {
            ["left"] = { coords = vector3(-567.45550537109, -236.29885864258, 34.379070281982), heading = 300.00012207031, model = 1858896923, locked = true, Shared = true }, -- Parliament Side Exterior Entrance
            ["right"] = { coords = vector3(-568.55700683594, -234.35293579102, 34.379070281982), heading = 120.00009155273, model = 1858896923, locked = true, Shared = true }, -- Parliament Side Exterior Entrance
        },
        {
            ["left"] = { coords = vector3(-555.69122314453, -197.61819458008, 42.832748413086), heading = 300.07586669922, model = -384927587, locked = true, Shared = true }, -- Second Story Lobby Left
            ["right"] = { coords = vector3(-556.96118164063, -195.41850280762, 42.832748413086), heading = 119.94416809082, model = -384927587, locked = true, Shared = true }, -- Second Story Lobby Left
        },
        {
            ["left"] = { coords = vector3(-546.64685058594, -189.46350097656, 42.832748413086), heading = 120.00009155273, model = -384927587, locked = true, Shared = true }, -- Second Story Lobby Right
            ["right"] = { coords = vector3(-545.37689208984, -191.66319274902, 42.832748413086), heading = 300.00006103516, model = -384927587, locked = true, Shared = true }, -- Second Story Lobby Right
        },
        {
            ["left"] = { coords = vector3(-559.54895019531, -200.62289428711, 42.851837158203), heading = 30.101263046265, model = 1042741067, locked = true, Shared = false }, -- Second Story Secretary Cortex
            ["right"] = { coords = vector3(-561.7919921875, -201.91790771484, 42.851837158203), heading = 210.07623291016, model = 1042741067, locked = true, Shared = false }, -- Second Story Secretary Cortex
        },
        {
            ["left"] = { coords = vector3(-554.36633300781, -197.27201843262, 47.68860244751), heading = 299.98211669922, model = -384927587, locked = true, Shared = false }, -- Third Story Lobby Left
            ["right"] = { coords = vector3(-555.63635253906, -195.07231140137, 47.68860244751), heading = 119.98211669922, model = -384927587, locked = true, Shared = false }, -- Third Story Lobby Left
        },
        {
            ["left"] = { coords = vector3(-547.13195800781, -190.16230773926, 47.68860244751), heading = 119.98211669922, model = -384927587, locked = true, Shared = false }, -- Third Story Lobby Right
            ["right"] = { coords = vector3(-545.86193847656, -192.36201477051, 47.68860244751), heading = 299.98211669922, model = -384927587, locked = true, Shared = false }, -- Third Story Lobby Right
        },
        {
            ["left"] = { coords = vector3(-560.74133300781, -200.96807861328, 47.696018218994), heading = 119.94696807861, model = 736699661, locked = true, Shared = false }, -- Third Story Speaker Of The House Head Office
            ["right"] = { coords = vector3(-562.03637695313, -198.72508239746, 47.696018218994), heading = 299.98065185547, model = 736699661, locked = true, Shared = false }, -- Third Story Speaker Of The House Head Office
        },
        {
            ["left"] = { coords = vector3(-553.11334228516, -201.48667907715, 47.696018218994), heading = 299.99264526367, model = 736699661, locked = true, Shared = false }, -- Third Story Speaker Of The House Head Office
            ["right"] = { coords = vector3(-551.81829833984, -203.72967529297, 47.696018218994), heading = 120.00002288818, model = 736699661, locked = true, Shared = false }, -- Third Story Speaker Of The House Head Office
        },
        {
            ["left"] = { coords = vector3(-532.94793701172, -181.55445861816, 38.352108001709), heading = 120.06700134277, model = -384927587, locked = true, Shared = true }, -- Supreme Court Hallway Entrance
            ["right"] = { coords = vector3(-531.67797851563, -183.75416564941, 38.352108001709), heading = 299.99752807617, model = -384927587, locked = true, Shared = true }, -- Supreme Court Hallway Entrance
        },
        {
            ["left"] = { coords = vector3(-534.92120361328, -167.71211242676, 38.507648468018), heading = 209.99996948242, model = -29187315, locked = true, Shared = false }, -- Supreme Court Back Entrance
            ["right"] = { coords = vector3(-533.03326416016, -166.62210083008, 38.507648468018), heading = 29.999996185303, model = -29187315, locked = true, Shared = false }, -- Supreme Court Back Entrance
        },
        {
            ["left"] = { coords = vector3(-510.47232055664, -204.76765441895, 38.369518280029), heading = 209.99992370605, model = 736699661, locked = true, Shared = false },  -- Supreme Court Inner Section Back Entrance
            ["right"] = { coords = vector3(-512.71875, -206.06465148926, 38.369518280029), heading = 29.999996185303, model = 736699661, locked = true, Shared = false }, -- Supreme Court Inner Section Back Entrance
        },
        {
            ["left"] = { coords = vector3(-515.40283203125, -211.44340515137, 38.491451263428), heading = 299.99987792969, model = -29187315, locked = false, Shared = true }, -- Supreme Court Pedestrian Entrance
            ["right"] = { coords = vector3(-516.49230957031, -209.55635070801, 38.491451263428), heading = 119.99987030029, model = -29187315, locked = false, Shared = true }, -- Supreme Court Pedestrian Entrance
        },
        {
            ["left"] = { coords = vector3(-545.18475341797, -187.83883666992, 42.852973937988), heading = 210.00004577637, model = 1042741067, locked = true, Shared = false }, -- Right Wing Office Space
            ["right"] = { coords = vector3(-542.94689941406, -186.54682922363, 42.852973937988), heading = 29.999996185303, model = 1042741067, locked = true, Shared = false }, -- Right Wing Office Space
        },
        {
            ["left"] = { coords = vector3(-532.74365234375, -185.15933227539, 42.852973937988), heading = 29.999996185303, model = 1042741067, locked = true, Shared = false }, -- Right Wing Secretary Doors
            ["right"] = { coords = vector3(-534.98150634766, -186.45133972168, 42.852973937988), heading = 210.00004577637, model = 1042741067, locked = true, Shared = false }, -- Right Wing Secretary Doors
        },
        {
            ["left"] = { coords = vector3(-530.12213134766, -179.88572692871, 42.822452545166), heading = 300.00003051758, model = -739665083, locked = true, Shared = false }, -- Large Meeting Room Court
            ["right"] = { coords = vector3(-528.826171875, -182.13046264648, 42.822452545166), heading = 120.00005340576, model = -739665083, locked = true, Shared = false }, -- Large Meeting Room Court
        },
        {
            ["left"] = { coords = vector3(-541.30151367188, -186.75294494629, 47.70044708252), heading = 300.00006103516, model = 736699661, locked = true, Shared = false }, -- Right Wing Third Story Cortex Entrance
            ["right"] = { coords = vector3(-540.00152587891, -189.00462341309, 47.70044708252), heading = 120.00005340576, model = 736699661, locked = true, Shared = false }, -- Right Wing Third Story Cortex Entrance
        },
	},
}


-- Archived CityHall Double Doors
-- local doors = {
-- 	single = {
--         { coords = vector3(-560.70056152344, -196.77244567871, 38.369140625), heading = 30.130535125732, model = 1042741067, locked = true, Shared = false }, -- Main Office Entrance
--         { coords = vector3(-558.02264404297, -186.33824157715, 38.369617462158), heading = 119.93824005127, model = 1042741067, locked = true, Shared = false }, -- Reception Entrance
--         { coords = vector3(-581.74206542969, -209.33480834961, 38.367610931396), heading = 300.00006103516, model = 1042741067, locked = true, Shared = false }, -- Parliament Side Office
--         { coords = vector3(-575.22265625, -205.03575134277, 42.857681274414), heading = 210.15367126465, model = 1042741067, locked = true, Shared = true }, -- Second Story Security Office
--         { coords = vector3(-577.20037841797, -206.2349395752, 42.860279083252), heading = 30.760059356689, model = 1042741067, locked = true, Shared = true }, -- Second Story Security Secondary Office Space
--         { coords = vector3(-580.98651123047, -210.29341125488, 42.863037109375), heading = 300.13348388672, model = 1042741067, locked = true, Shared = false }, -- Parliament Wing Second Story Side Office
--         { coords = vector3(-565.71350097656, -203.70745849609, 47.696018218994), heading = 339.94277954102, model = 736699661, locked = true, Shared = false }, -- Parliament Wing Third Story Office One
--         { coords = vector3(-566.89849853516, -201.65498352051, 47.696018218994), heading = 80.245414733887, model = 736699661, locked = true, Shared = false }, -- Parliament Wing Third Story Office Two
--         { coords = vector3(-565.47772216797, -199.27586364746, 47.696018218994), heading = 29.964212417603, model = 736699661, locked = true, Shared = false }, -- Parliament Wing Third Story Office Three
--         { coords = vector3(-556.49041748047, -190.82736206055, 56.437919616699), heading = 300.12600708008, model = 736699661, locked = true, Shared = false }, -- Main Tower Office One
--         { coords = vector3(-556.49041748047, -190.82736206055, 61.063911437988), heading = 299.99996948242, model = 736699661, locked = true, Shared = false }, -- Main Tower Office Two
--         { coords = vector3(-556.49041748047, -190.82736206055, 65.603927612305), heading = 299.99996948242, model = 736699661, locked = true, Shared = false }, -- Main Tower Office Three
--         { coords = vector3(-556.49041748047, -190.82736206055, 70.123931884766), heading = 300.0, model = 736699661, locked = true, Shared = false }, -- Main Tower Office Four
--         { coords = vector3(-522.04162597656, -175.06144714355, 38.369384765625), heading = 300.00003051758, model = 1042741067, locked = true, Shared = false } -- Right Wing Office One
--         { coords = vector3(-520.43658447266, -177.8413848877, 38.369384765625), heading = 120.00005340576, model = 1042741067, locked = true, Shared = false } -- Right Wing Office Two
--         { coords = vector3(-520.47003173828, -181.08952331543, 38.369518280029), heading = 210.00009155273, model = 736699661, locked = true, Shared = false } -- Right Wing Office Three
--         { coords = vector3(-528.22961425781, -185.56951904297, 38.369518280029), heading = 29.999996185303, model = 736699661, locked = true, Shared = false } -- Right Wing Office Four
--         { coords = vector3(-539.08471679688, -184.03207397461, 47.695934295654), heading = 210.00007629395, model = 736699661, locked = true, Shared = false }, -- Third Floor Right Wing Office One
--         { coords = vector3(-537.54235839844, -183.60348510742, 47.695934295654), heading = 339.99996948242, model = 736699661, locked = true, Shared = false }, -- Third Floor Right Wing Office Two
--         { coords = vector3(-535.36145019531, -187.32106018066, 47.695934295654), heading = 79.999984741211, model = 736699661, locked = true, Shared = false }, -- Third Floor Right Wing Office Three
--     },
-- 	double = {
--         {
-- 			["left"] = { coords = vector3(-556.91778564453, -199.11116027832, 38.369476318359), heading = 30.000450134277, model = 1042741067, locked = true, Shared = false }, -- Committee Room Left
-- 			["right"] = { coords = vector3(-559.15472412109, -200.40266418457, 38.369476318359), heading = 209.89834594727, model = 1042741067, locked = true, Shared = false }, -- Committee Room Left
--         },
--         {
-- 			["left"] = { coords = vector3(-568.86895751953, -201.49992370605, 38.369728088379), heading = 209.99978637695, model = 1956494919, locked = true, Shared = true }, -- Left Wing Staircase Entrance
-- 			["right"] = { coords = vector3(-566.61730957031, -200.1999206543, 38.369728088379), heading = 29.999996185303, model = 1956494919, locked = true, Shared = true }, -- Left Wing Staircase Entrance
--         },
--         {
--             ["left"] = { coords = vector3(-568.23089599609, -201.09744262695, 42.851837158203), heading = 209.96221923828, model = 1042741067, locked = true, Shared = false }, -- Second Story Committee Room
--             ["right"] = { coords = vector3(-565.98785400391, -199.80242919922, 42.851837158203), heading = 30.129161834717, model = 1042741067, locked = true, Shared = false }, -- Second Story Committee Room
--         },
--         {
--             ["left"] = { coords = vector3(-556.69177246094, -200.0885925293, 47.696018218994), heading = 210.13217163086, model = 736699661, locked = true, Shared = false }, -- Third Story Parliament Wing Office Cortex
--             ["right"] = { coords = vector3(-558.93481445313, -201.38360595703, 47.696018218994), heading = 30.045997619629, model = 736699661, locked = true, Shared = false }, -- Third Story Parliament Wing Office Cortex
--         },
--         {
--             ["left"] = { coords = vector3(-588.52001953125, -136.85116577148, 48.192443847656), heading = 247.04447937012, model = 1434919553, locked = true, Shared = true }, -- Third Story Balcony Doors
--             ["right"] = { coords = vector3(-587.64349365234, -134.69735717773, 48.192443847656), heading = 67.044418334961, model = 1434919553, locked = true, Shared = true }, -- Third Story Balcony Doors
--         },
-- 	},
-- }

local CityHall = vector3(-546.84252929688, -194.8543548584, 52.203201293945)
local IsPolice = false
local IsDOJ = false

function SetPolice(_IsPolice)
    IsPolice = _IsPolice
end

function SetDOJ(_IsDOJ)
    IsDOJ = _IsDOJ
end

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

        if #(PlayerPosition - CityHall) <= 80.0 then

            for Index = 1, #doors.single do
                local Distance = #(doors.single[Index].coords - PlayerPosition)

                if Distance <= 10.0 then
                    if doors.single[Index].locked then
                        if doors.single[Index].handle ~= nil and doors.single[Index].handle ~= 0 then
                            SetEntityHeading(doors.single[Index].handle, doors.single[Index].heading)
                        end
                    end

                    if IsDOJ or IsPolice then
                        if Distance <= 1.2 then
                            if IsDOJ or doors.single[Index].Shared then
                                SetDrawOrigin(doors.single[Index].coords.x, doors.single[Index].coords.y, PlayerPosition.z, 0)
                                RenderText("~o~[E]"..(doors.single[Index].locked and "Locked" or "Unlocked"), 0, 0, 6, 0.3, 255, 255, 255, 255, "Centre", true, true)
                                ClearDrawOrigin()

                                if IsControlJustPressed(1, 51) then
                                    TriggerServerEvent("Shared.Doors.Lock", Index, "single")
                                end
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
                    
                    if IsDOJ or IsPolice then
                        if LeftDistance <= 1.2 or RightDistance <= 1.2 then
                            if IsDOJ or doors.double[Index].left.Shared then
                                SetDrawOrigin(doors.double[Index].left.coords.x, doors.double[Index].left.coords.y, PlayerPosition.z, 0)
                                RenderText("~o~[E]"..(doors.double[Index].left.locked and "Locked" or "Unlocked"), 0, 0, 6, 0.3, 255, 255, 255, 255, "Centre", true, true)
                                ClearDrawOrigin()

                                if IsControlJustPressed(1, 51) then
                                    TriggerServerEvent("Shared.Doors.Lock", Index, "double")
                                end
                            end
                        end
                    end
                end
            end
        end
	end
end)

RegisterNetEvent("Shared.Doors.Sync")
AddEventHandler("Shared.Doors.Sync", function(_doors)
	for Index = 1, #doors.single do
		doors.single[Index].locked = _doors.single[Index]
	end

	for Index = 1, #doors.double do
		doors.double[Index].left.locked = _doors.double[Index].left
		doors.double[Index].right.locked = _doors.double[Index].right
	end
end)

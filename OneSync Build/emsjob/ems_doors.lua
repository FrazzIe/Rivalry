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
		-- Gibz Pillbox
		{coords = vector3(339.89434814453, -586.47802734375, 43.284065246582), model = 1653893025, heading = 185.40148925781, locked = true},
		{coords = vector3(326.52206420898, -579.4091796875, 43.284049987793), model = 1653893025, heading = 64.32706451416, locked = true},
		{coords = vector3(324.40243530273, -576.35919189453, 43.284065246582), model = 1653893025, heading = 346.73965454102, locked = true},
		{coords = vector3(318.86959838867, -574.14691162109, 43.302772521973), model = 1653893025, heading = 160.67063903809, locked = true},
		{coords = vector3(313.03244018555, -572.16491699219, 43.28406524658), model = 1653893025, heading = 328.20544433594, locked = true},
		{coords = vector3(307.84359741211, -570.31097412109, 43.284065246582), model = 1653893025, heading = 343.85919189453, locked = true},
		{coords = vector3(308.33557128906, -597.05810546875, 43.284065246582), model = 1653893025, heading = 163.37902832031, locked = true},
		{coords = vector3(327.32177734375, -593.91131591797, 43.284065246582), model = 1653893025, heading = 249.45266723633, locked = true},
		{coords = vector3(325.17391967773, -589.88824462891, 43.284076690674), model = 1653893025, heading = 350.64340209961, locked = true},
		{coords = vector3(347.31259155273, -592.73492431641, 43.284072875977), model = 1653893025, heading = 64.424926757813, locked = true},
		{coords = vector3(350.12319946289, -598.87091064453, 43.284061431885), model = 1653893025, heading = 251.04223632813, locked = true},
		{coords = vector3(356.83480834961, -580.03039550781, 43.284069061279), model = 1653893025, heading = 224.53964233398, locked = true},
		{coords = vector3(355.41946411133, -583.92779541016, 43.284069061279), model = 1653893025, heading = 240.02548217773, locked = true},
		{coords = vector3(348.44921875, -587.44653320313, 43.284072875977), model = 1653893025, heading = 295.59777832031, locked = true},
		{coords = vector3(341.60543823242, -582.099609375, 43.284065246582), model = 1653893025, heading = 338.75845336914, locked = true},
		-- Sandy Shores
		{ coords = vector3(1841.9404296875, 3683.4755859375, 34.362609863281), heading = 209.79792785645, model = -1320876379, locked = true}, -- Locker Room
		{ coords = vector3(1838.6497802734, 3686.3188476563, 34.362609863281), heading = 299.70166015625, model = -1320876379, locked = true}, -- Desk Entrance
		{ coords = vector3(1835.650390625, 3691.7912597656, 34.362609863281), heading = 209.79792785645, model = -1320876379, locked = true}, -- Locker Room
	},
	double = {
		{
			["left"] = {coords = vector3(302.80307006836, -581.42456054688, 43.433910369873), model = -434783486, heading = 340.00003051758, locked = false},
			["right"] = {coords = vector3(305.22186279297, -582.30560302734, 43.433910369873), model = -1700911976, heading = 339.79483032227, locked = false},
		},
		{
			["left"] = {coords = vector3(328.1364440918, -592.77606201172, 43.433910369873), model = -434783486, heading = 249.98272705078, locked = true},
			["right"] = {coords = vector3(305.22186279297, -582.30560302734, 43.433910369873), model = -1700911976, heading = 249.98272705078, locked = true},
		},
		{
			["left"] = {coords = vector3(324.23602294922, -589.22619628906, 43.433910369873), model = -434783486, heading = 340.00003051758, locked = true},
			["right"] = {coords = vector3(326.6549987793, -590.10662841797, 43.433910369873) , model = -1700911976, heading = 340.00003051758, locked = true},
		},
		{
			["left"] = {coords = vector3(312.00512695313, -571.34118652344, 43.433910369873), model = -434783486, heading = 340.00003051758, locked = true},
			["right"] = {coords = vector3(305.22186279297, -582.30560302734, 43.433910369873), model = -1700911976, heading = 340.00003051758, locked = true},
		},
		{
			["left"] = {coords = vector3(317.84255981445, -573.46588134766, 43.433910369873), model = -434783486, heading = 340.00003051758, locked = true},
			["right"] = {coords = vector3(320.26153564453, -574.34631347656, 43.433910369873), model = -1700911976, heading = 340.00003051758, locked = true},
		},
		{
			["left"] = {coords = vector3(323.23754882813, -575.42944335938, 43.433910369873), model = -434783486, heading = 340.00003051758, locked = true},
			["right"] = {coords = vector3(325.6565246582, -576.30993652344, 43.433910369873), model = -1700911976, heading = 340.00003051758, locked = true},
		},
		{
			["left"] = {coords = vector3(325.66946411133, -580.45959472656, 43.433910369873), model = -434783486, heading = 249.98272705078, locked = true},
			["right"] = {coords = vector3(326.54989624023, -578.04064941406, 43.433910369873), model = -1700911976, heading = 250.04809570313, locked = true},
		},
		{
			["left"] = {coords = vector3(348.4333190918, -588.74499511719, 43.433910369873), model = -434783486, heading = 249.93737792969, locked = true},
			["right"] = {coords = vector3(349.3137512207, -586.32598876953, 43.433910369873), model = -1700911976, heading = 250.00057983398, locked = true},
		},
		{
			["left"] = {coords = vector3(318.48468017578, -579.22814941406, 43.433910369873), model = -434783486, heading = 160.00001525879, locked = false},
			["right"] = {coords = vector3(316.0657043457, -578.34771728516, 43.433910369873), model = -1700911976, heading = 160.00001525879, locked = false},
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
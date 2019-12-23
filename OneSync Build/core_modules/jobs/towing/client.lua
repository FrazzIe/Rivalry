--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
tow_menu = false
local isTow = true
local towInService = false
local towVehicle = nil
local activeTows = {}
local impound_blips = {}
local impound_cars = {}
local car_collection = {x=0.0,y=0.0,z=0.0,heading=0.0}

local tow_locations = {
	signOn = {
		{name="Towing Co.", colour=2, sprite=68, x=409.57522583008, y=-1623.2700195313, z=29.291940689087},
	},
	impound = {
		{x=401.23916625977, y=-1632.4448242188, z=29.291940689087},
	},
	vehicle = {		
		{x=390.65679931641, y=-1621.8651123047, z=29.291940689087},
	},
	retrieval = {
		markers = {
			{name="Impound retrieval", colour=2, sprite=365, x=413.79144287109, y=-1617.0236816406, z=29.291570663452},
		},
		car_spawns = {
			{x=395.98846435547, y=-1644.5775146484, z=29.291948318481},
			{x=398.0966796875, y=-1646.4318847656, z=29.291948318481},
			{x=400.81781005859, y=-1648.5462646484, z=29.292821884155},
			{x=403.29568481445, y=-1650.7073974609, z=29.294179916382},
			{x=405.67791748047, y=-1652.6270751953, z=29.292518615723},
			{x=408.23059082031, y=-1654.4868164063, z=29.291900634766},
			{x=410.47653198242, y=-1656.7316894531, z=29.291900634766},
		}
	},
}
local towVehicles = {
	{name = "Tow Truck", model="towtruck"},
}

Citizen.CreateThread(function()
    for _, item in pairs(tow_locations.signOn) do
    	addBlip(item)
    end
    for _, item in pairs(tow_locations.retrieval.markers) do
    	addBlip(item)
    end
    while true do
        Citizen.Wait(0)
		if isTow then
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
	        for k,v in ipairs(tow_locations.signOn) do
	            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
	                RenderMarker(25, v.x, v.y, v.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
	                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0001)then
	                    if not towInService then
	                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~g~clock in~w~!")
	                    else
	                    	DisplayHelpText("Press ~INPUT_CONTEXT~ to ~r~clock out~w~!")
	                    end
	                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
	                    	towInService = not towInService
	                    	TriggerServerEvent("tow:setservice", towInService)
	                    end
	                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0001)then

	                end
	            end
	        end
	        if towInService then
		        for k,v in ipairs(tow_locations.vehicle) do
		            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 20.0)then
		                RenderMarker(25, v.x, v.y, v.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
		                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 3.5001)then
		                    if not towVehicle then
		                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~g~collect your truck~w~!")
		                    else
		                    	DisplayHelpText("Press ~INPUT_CONTEXT~ to ~r~store your truck~w~!")
		                    end
		                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
		                    	if not towVehicle then
			                        --GUI.maxVisOptions = 10; titleTextSize = {0.85, 0.65}; titleRectSize = {0.16, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.16, 0.035}; menuX = 0.75; menuXOption = 0.075; menuXOtherOption = 0.055; menuYModify = 0.3000; menuYOptionDiv = 8.56; menuYOptionAdd = 0.36;
		                    		--tow_menu = not tow_menu
			                    	--towGarage()
			                    	spawnTow("towtruck")
		                    	else
		                            SetEntityAsMissionEntity(towVehicle, true, true)
		                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(towVehicle))
		                            towVehicle = nil
		                    	end
		                    end
		                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 3.5001)then
		                	--tow_menu = false
		                end
		            end
		        end
			    for k,v in ipairs(tow_locations.impound) do
			    	if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 20.0)then
			       		RenderMarker(25, v.x, v.y, v.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
			        	if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 3.5001)then
	                    	local closestVeh = GetClosestVehicle(v.x, v.y, v.z, 3.000, 0, 70)
	                    	local plate = GetVehicleNumberPlateText(closestVeh)
	                    	if DoesEntityExist(closestVeh) and closestVeh ~= towVehicle and impound_cars[plate] ~= nil then
								DisplayHelpText("Press ~INPUT_CONTEXT~ to ~g~impound the~b~ "..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(closestVeh))).."~w~!")
							elseif DoesEntityExist(closestVeh) then
								DisplayHelpText("This vehicle isn't in our database?")
							else
								DisplayHelpText("No vehicle in range!")
			            	end
			            	if IsControlJustReleased(1, 51) then
			                	if DoesEntityExist(closestVeh) and closestVeh ~= towVehicle and impound_cars[plate] ~= nil then
			                    	local closestTow = GetClosestVehicle(v.x, v.y, v.z, 60.0, GetHashKey("towtruck"), 70)
			                    	local plate = GetVehicleNumberPlateText(closestVeh)
				                    if DoesEntityExist(closestTow) and closestTow == towVehicle then
				                    	SetEntityAsMissionEntity(closestVeh, true, true)
										Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(closestVeh))
										SetEntityCoords(closestVeh,401.71649169922, -1631.1243896484, -2.7080497741699)
				                    	TriggerServerEvent("tow:impound", plate, closestVeh)
				                    else
										SetEntityAsMissionEntity(closestVeh, true, true)
										Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(closestVeh))
										SetEntityCoords(closestVeh,401.71649169922, -1631.1243896484, -2.7080497741699)
				                    	TriggerEvent("customNotification", "We couldn't find your tow truck nearby, the whole point of this job is to tow vehicles..")
				                    	TriggerServerEvent("police:impound", plate, closestVeh)
									end
								end
							end 
						elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 3.5001)then
						end
					end
			    end
	        end
	    end
		for k,v in ipairs(tow_locations.retrieval.markers) do
			if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 20.0)then
				RenderMarker(25, v.x, v.y, v.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.5001)then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to see if you have any impounded vehicles!")
					if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
						GUI.maxVisOptions = 10; titleTextSize = {0.85, 0.65}; titleRectSize = {0.16, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.16, 0.035}; menuX = 0.75; menuXOption = 0.075; menuXOtherOption = 0.055; menuYModify = 0.3000; menuYOptionDiv = 8.56; menuYOptionAdd = 0.36;
						tow_menu = not tow_menu
						impoundClaim()
					end
				elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.5001)then
					tow_menu = false
				end
			end
		end
    end
end)

function towGarage()
    Menu.SetupMenu("tow_menu_garage","Tow garage")
    Menu.Switch(nil,"tow_menu_garage")
    for k,v in pairs(towVehicles) do
	    Menu.addOption("tow_menu_garage", function()
	        if(Menu.Option(v.name))then
	            spawnTow(v.model)
	        end
	    end)
    end
end

function spawnTow(car)
    local carhashed = GetHashKey(car)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    RequestModel(carhashed)
    while not HasModelLoaded(carhashed) do
        Citizen.Wait(0)
    end
                            
    towVehicle = CreateVehicle(carhashed, pos.x, pos.y, pos.z, -40.0, true, false)
    local id = NetworkGetNetworkIdFromEntity(towVehicle)
    SetEntityAsMissionEntity(towVehicle, true, false)
    SetNetworkIdCanMigrate(id, true)
    SetNetworkIdExistsOnAllMachines(id, true)
    SetVehicleNumberPlateText(towVehicle, "TOW"..math.random(1,999))
    SetVehicleDirtLevel(towVehicle, 0)
    TaskWarpPedIntoVehicle(GetPlayerPed(-1), towVehicle, -1)
    tow_menu = false
end

function impoundClaim()
    Menu.SetupMenu("tow_menu_claim","Collect vehicle")
    Menu.Switch(nil,"tow_menu_claim")
    for i = 1, #user_vehicles do
        if (user_vehicles[i] ~= nil) then
            if user_vehicles[i].s == "~r~Impounded" then
                Menu.addOption("tow_menu_claim", function()
                    if(Menu.GunBool(user_vehicles[i].n, vehiclebool, "~g~$~w~5000","~g~$~w~5000",function(cb)   vehiclebool = cb end))then
                        local pos = GetEntityCoords(GetPlayerPed(-1), true)
                        local spot = GetRandomIntInRange(1, #tow_locations.retrieval.car_spawns)
                        local isAreaCrowded = GetClosestVehicle(tow_locations.retrieval.car_spawns[spot].x, tow_locations.retrieval.car_spawns[spot].y, tow_locations.retrieval.car_spawns[spot].z, 3.000, 0, 70)
						if DoesEntityExist(isAreaCrowded) then
                            exports.pNotify:SendNotification({text = "Try again, the spawn location is occupied!", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                        else
                        	car_collection.x = tow_locations.retrieval.car_spawns[spot].x
                            car_collection.y = tow_locations.retrieval.car_spawns[spot].y
                            car_collection.z = tow_locations.retrieval.car_spawns[spot].z
                            car_collection.heading = -40.0
                            TriggerServerEvent("tow:claim", user_vehicles[i])
                        end
                    end
                end)
            end
        end
    end
end

function SpawnReplacement2(data)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        RequestModel(data.m)
        while not HasModelLoaded(data.m) do
           Citizen.Wait(0)
        end
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        local veh = CreateVehicle(data.m, car_collection.x, car_collection.y, car_collection.z, car_collection.heading, true, false)
        table.insert(out, veh)
        SetVehicleNumberPlateText(veh, data.p)
        SetVehicleOnGroundProperly(veh)
        SetVehicleHasBeenOwnedByPlayer(veh,true)
        local id = NetworkGetNetworkIdFromEntity(veh)
        SetNetworkIdCanMigrate(id, true)
        SetNetworkIdExistsOnAllMachines(id, true)
        SetVehicleColours(veh, data.cp, data.cs)
        SetVehicleExtraColours(veh, tonumber(data.pc), tonumber(data.wc))
        SetVehicleNumberPlateTextIndex(veh,plateindex)
        SetVehicleNeonLightsColour(veh,tonumber(data.nc[1]),tonumber(data.nc[2]),tonumber(data.nc[3]))
        SetVehicleTyreSmokeColor(veh,tonumber(data.sc[1]),tonumber(data.sc[2]),tonumber(data.sc[3]))
        SetVehicleModKit(veh,0)
        SetVehicleMod(veh, 0, tonumber(data.m0))
        SetVehicleMod(veh, 1, tonumber(data.m1))
        SetVehicleMod(veh, 2, tonumber(data.m2))
        SetVehicleMod(veh, 3, tonumber(data.m3))
        SetVehicleMod(veh, 4, tonumber(data.m4))
        SetVehicleMod(veh, 5, tonumber(data.m5))
        SetVehicleMod(veh, 6, tonumber(data.m6))
        SetVehicleMod(veh, 7, tonumber(data.m7))
        SetVehicleMod(veh, 8, tonumber(data.m8))
        SetVehicleMod(veh, 9, tonumber(data.m9))
        SetVehicleMod(veh, 10, tonumber(data.m10))
        SetVehicleMod(veh, 11, tonumber(data.m11))
        SetVehicleMod(veh, 12, tonumber(data.m12))
        SetVehicleMod(veh, 13, tonumber(data.m13))
        SetVehicleMod(veh, 14, tonumber(data.m14))
        SetVehicleMod(veh, 15, tonumber(data.m15))
        SetVehicleMod(veh, 16, tonumber(data.m16))
        if data.t == "on" then
            ToggleVehicleMod(veh, 18, true)
        else
            ToggleVehicleMod(veh, 18, false)
        end
        if data.ts == "on" then
            ToggleVehicleMod(veh, 20, true)
        else
            ToggleVehicleMod(veh, 20, false)
        end
        if data.xl == "on" then
            ToggleVehicleMod(veh, 22, true)
        else
            ToggleVehicleMod(veh, 22, false)
        end
        SetVehicleWheelType(veh, tonumber(data.wht))
        SetVehicleMod(veh, 23, tonumber(data.m23))
        SetVehicleMod(veh, 24, tonumber(data.m24))
        if data.cw == "on" then
            SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), true)-- Vehicle Mod 23
            SetVehicleMod(veh, 24, GetVehicleMod(veh, 24), true)-- Vehicle Mod 24
        end
        if data.n0 == "on" then
            SetVehicleNeonLightEnabled(veh,0, true)
        else
            SetVehicleNeonLightEnabled(veh,0, false)
        end
        if data.n1 == "on" then
            SetVehicleNeonLightEnabled(veh,1, true)
        else
            SetVehicleNeonLightEnabled(veh,1, false)
        end
        if data.n2 == "on" then
            SetVehicleNeonLightEnabled(veh,2, true)
        else
            SetVehicleNeonLightEnabled(veh,2, false)
        end
        if data.n3 == "on" then
            SetVehicleNeonLightEnabled(veh,3, true)
        else
            SetVehicleNeonLightEnabled(veh,3, false)
        end
        if data.bp == "on" then
            SetVehicleTyresCanBurst(veh, false)
        else
            SetVehicleTyresCanBurst(veh, true)
        end
        SetVehicleWindowTint(veh,tonumber(data.wt))
        TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
        SetEntityInvincible(veh, false)
        tow_menu = false
        data.s = "~r~Missing" -- Vehicle State
        local instance = veh -- Current vehicle instance
        TriggerServerEvent("garage:out", data, instance)
    end)
end

function GetActiveTows()
	local count = 0
	for _, v in pairs(activeTows) do 
		if v == "true" then
			count = count + 1
		end
	end
	return count
end

local towHeight = 1.0
local towHelp = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isTow then
			if towInService then
				if towVehicle then
					local myPed = GetPlayerPed(-1)
					local myCoord = GetEntityCoords(myPed)
					if GetVehiclePedIsIn(GetPlayerPed(-1), 0) == 0 then
						local closestVeh = GetClosestVehicle(myCoord.x, myCoord.y, myCoord.z, 10.0, GetHashKey("towtruck"), 70)
						if closestVeh ~= 0 and closestVeh == towVehicle then
							local coords = GetOffsetFromEntityInWorldCoords(closestVeh, -1.5, -3.2, 0)
							local dist = GetDistanceBetweenCoords(myCoord.x, myCoord.y, myCoord.z, coords.x, coords.y, coords.z, true)
							if dist < 10 then
								RenderMarker(25, coords.x-0.1, coords.y, coords.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
							end
							if dist < 1.5 then 
								DisplayHelpText("Press ~INPUT_CONTEXT~ to tow\nPress ~INPUT_INTERACTION_MENU~ for help\n~g~+~w~/~r~-~w~ to adjust hook")
								local c1 = GetOffsetFromEntityInWorldCoords(closestVeh, 0.0, -4.3, 1.8)
								local c2 = GetOffsetFromEntityInWorldCoords(closestVeh, 0.0, -4.3, -1.2)
								local vehicleAttach = GetEntityAttachedToTowTruck(closestVeh)
								local vehicleGrap = GetVehicleInDirection(c1,c2)
								if towHelp then
									if vehicleAttach ~= 0 then 
										DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 255, 0, 255)
									elseif vehicleGrap ~= 0 then
										DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 0, 255, 255)
									else
										DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
									end
								end
								if IsControlPressed(1, 96) then
									if towHeight < 1.0 then
										towHeight = towHeight + 0.1
										Citizen.InvokeNative(0xFE54B92A344583CA, closestVeh, towHeight)
									end
								elseif IsControlPressed(1, 97) then
									if towHeight > 0.0 then
										towHeight = towHeight - 0.1
										Citizen.InvokeNative(0xFE54B92A344583CA, closestVeh,  towHeight)
									end
								elseif IsControlJustPressed(1, 51) then
									if vehicleAttach ~= 0 then
										DetachVehicleFromTowTruck(closestVeh, vehicleAttach)
									elseif vehicleGrap ~= 0 then
										AttachVehicleToTowTruck(closestVeh, vehicleGrap, true, 0.0,0.0,0.0)
									end
								elseif IsControlJustPressed(1, 244) then
									towHelp = not towHelp
								end
							end
						end
					else
						if towHelp then
							local inTowtruck = IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0), GetHashKey("towtruck"))
							if inTowtruck then
								local c1 = GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 0.0, -4.3, 1.8)
								local c2 = GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 0.0, -4.3, -0.8)
								local vehicle = GetVehicleInDirection(c1,c2)
								if vehicle ~= 0 then
									DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 0, 255, 255)
								else
									DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
								end
							else 
								local inFlatBed = IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0),GetHashKey("flatbed"))
								if inFlatBed then
									local c1 = GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 0.0, -7.3, 1.8)
									local c2 = GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 0.0, -7.3, -1.2)
									local vehicleGrap = GetVehicleInDirection(c1,c2)
									if vehicleGrap ~= 0 then 
										DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 255, 0, 255)
									else
										DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
									end
								end
							end
						end
					end
				end
				local pos = GetEntityCoords(PlayerPedId(), true)
				local closestVeh = GetClosestVehicle(pos.x, pos.y, pos.z, 3.000, 0, 70)
				if DoesEntityExist(closestVeh) and closestVeh ~= towVehicle and impound_cars[plate] ~= nil and GetVehicleDoorLockStatus(closestVeh) == 2 then
					DisplayHelpText("Press ~INPUT_INTERACTION_MENU~ to ~b~unlock vehicle~w~!")
					if IsControlJustReleased(1, 244) then
						SetVehicleDoorsLocked(closestVeh, 1)
						SetVehicleDoorsLockedForPlayer(closestVeh, PlayerId(), false)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("tow:recieveTows")
AddEventHandler("tow:recieveTows", function(recieveTows)
	activeTows = recieveTows
end)

RegisterNetEvent("tow:status")
AddEventHandler("tow:status", function(status)
	isTow = status
end)

RegisterNetEvent("tow:claim")
AddEventHandler("tow:claim", function(replacement)
	SpawnReplacement2(replacement)
end)

RegisterNetEvent("tow:addBlip")
AddEventHandler("tow:addBlip", function(activeBlips)
	impound_cars = activeBlips
	if towInService then
		for _, remove in pairs(impound_blips) do
			RemoveBlip(remove)
		end

		for plate, coords in pairs(activeBlips) do
			for vehicle in EnumerateVehicles() do
				if GetVehicleNumberPlateText(vehicle) == plate then
			        local towblip = AddBlipForEntity(vehicle)
			        SetBlipSprite(towblip, 68)
			        SetBlipColour(towblip, 47)
			        SetBlipFlashes(towblip, true)
			        table.insert(impound_blips, towblip)
			    end
			end
		end
	else
		for _, remove in pairs(impound_blips) do
			RemoveBlip(remove)
		end
	end
end)
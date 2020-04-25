--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local currentgarage = {x = 0.0, y = 0.0, z = 0.0}
local stationGarage = {
    {name = "Paramedic Garage", sprite = 50, colour = 2, x=-237.292, y=6332.39, z=32.3463},
    {name = "Paramedic Garage", sprite = 50, colour = 2, x=1842.64, y=3667.10, z=33.6801},
    {name = "Paramedic Garage", sprite = 50, colour = 2, x=-657.582, y=293.92, z=81.4133},
    {name = "Paramedic Garage", sprite = 50, colour = 2, x=-876.029, y=-300.418, z=39.6034},
    {name = "Paramedic Garage", sprite = 50, colour = 2, x=1169.01, y=-1509.82, z=34.6926},
    {name = "Paramedic Garage", sprite = 50, colour = 2, x=303.086, y=-1439.04, z=29.8019},
    {name = "Paramedic Garage", sprite = 50, colour = 2, x=342.47305297852,y=-557.20935058594,z=28.743783950806},
    {name = "Paramedic Garage", sprite = 50, colour = 2, x=-475.254, y=-352.322, z=34.3147},
	{name = "Paramedic Garage", sprite = 50, colour = 2, x=-1465.16, y=-1003.4, z=6.26},
	{name = "Paramedic Garage", sprite = 50, colour = 2, x = -731.64776611328, y = -1413.0021972656, z = 5.0005211830139, h = 228.73706054688},
	{name = "Paramedic Garage", sprite = 50, colour = 2, x = -218.0043182373, y = 6537.3842773438, z = 11.097856521606, h = 279.17037963867},
}

local stationHeliGarage = {
    {name = "Paramedic Helipad", sprite = 43, colour = 2, x=-475.22604370117, y=5988.6201171875, z=31.336700439453},
    {name = "Paramedic Helipad", sprite = 43, colour = 2, x=313.30563354492, y=-1465.1845703125, z=46.509475708008},
    {name = "Paramedic Helipad", sprite = 43, colour = 2, x=299.50131225586, y=-1453.5455322266, z=46.509475708008},
    {name = "Paramedic Helipad", sprite = 43, colour = 2, x=352.01733398438, y=-588.12835693359, z=74.165634155273},
    {name = "Paramedic Helipad", sprite = 43, colour = 2, x=1770.2397460938, y=3239.8703613281, z=42.1227684021},
    {name = "Paramedic Helipad", sprite = 43, colour = 2, x=1216.7823486328, y=-1516.5510253906, z=34.700180053711},
}

local stationBoatGarage = {
	{name = "Paramedic Boatyard", sprite = 266, colour = 2, x = -725.88293457031, y = -1374.7302246094, z = 1.595218539238},
	{name = "Paramedic Boatyard", sprite = 266, colour = 2, x = -276.0068359375, y = 6639.4140625, z = 7.5257635116577},
	{name = "Paramedic Boatyard", sprite = 266, colour = 2, x = 1537.3765869141, y = 3913.4584960938, z = 31.677017211914},
}

cars = {
    --{name = "Ambulance", model = "ambulance2", type = "", rank = "probationary", livery=1, extras={1}},
    {name = "Ambulance", model = "ambulance", type = "", rank = "recruit", livery=1, extras={1}},
    {name = "Ambulance (Large)", model = "ambulance3", type = "", rank = "paramedic", livery=1, extras={2,3}},
    {name = "Contender", model = "lguard2", type = "", rank = "paramedic", livery=1, extras={1,2}},
    {name = "Transport Van", model = "emsvan", type = "", rank = "specialist", livery=4, extras={1}},
    {name = "Rapid Response", model = "emscar2", type = "", rank = "lieutenant", livery=1, extras={1}},
    {name = "Granger", model = "emssuv", type = "", rank = "captain", livery=1, extras={1,3}},
    {name = "Crown Victoria", model = "emscar", type = "", rank = "assistant chief", livery=1, extras={1}},
}

heli = {
    {name = "LSFD Chopper", model = "polmav", type = "helicopter", rank = "paramedic"},
}

boat = {
	{name = "LSFD Rescue Boat", model = "predator", type = "", rank = "paramedic"}
}

function tobool(input)
    if input == "true" or tonumber(input) == 1 or input == true or input == "on" then
        return true
    else
        return false
    end
end

function isNearStationGarage()
    for i = 1, #stationGarage do
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 30) then
            DrawMarker(25, stationGarage[i].x, stationGarage[i].y, stationGarage[i].z-0.9, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 243, 44, 82, 155, 0, 0, 2, 0, 0, 0, 0)
            currentgarage.x, currentgarage.y, currentgarage.z = stationGarage[i].x, stationGarage[i].y, stationGarage[i].z
            if(distance < 2) then
                return true
            elseif distance > 2 then
                if WarMenu.IsMenuOpened("car_menu") then
                    WarMenu.CloseMenu("car_menu")
                end
            end
        end
    end
end

function isNearStationHeliGarage()
    for i = 1, #stationHeliGarage do
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 30) then
            DrawMarker(25, stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z-0.9, 0, 0, 0, 0, 0, 0, 9.0, 9.0, 2.5, 243, 44, 82, 155, 0, 0, 2, 0, 0, 0, 0)
            currentgarage.x, currentgarage.y, currentgarage.z = stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z
            if(distance < 7) then
                return true
            elseif distance > 7 then
                if WarMenu.IsMenuOpened("heli_menu") then
                    WarMenu.CloseMenu("heli_menu")
                end
            end
        end
    end
end

function isNearStationBoatGarage()
    for i = 1, #stationBoatGarage do
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(stationBoatGarage[i].x, stationBoatGarage[i].y, stationBoatGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 30) then
            DrawMarker(25, stationBoatGarage[i].x, stationBoatGarage[i].y, stationBoatGarage[i].z-0.7, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 243, 44, 82, 155, 0, 0, 2, 0, 0, 0, 0)
            if i == 1 then
            	currentgarage.x, currentgarage.y, currentgarage.z = -731.48315429688, -1369.9741210938, 0.52509331703186
            elseif i == 2 then
				currentgarage.x, currentgarage.y, currentgarage.z = -289.64694213867, 6645.7841796875, 1.5431871414185
			elseif i == 3 then
				currentgarage.x, currentgarage.y, currentgarage.z = 1535.8880615234, 3895.6235351563, 31.606565475464
			end
            if(distance < 7) then
                return true
            elseif distance > 7 then
                if WarMenu.IsMenuOpened("boat_menu") then
                    WarMenu.CloseMenu("boat_menu")
                end
            end
        end
    end
end

Citizen.CreateThread(function()
    local currentLiveryIndex = 1
    local selectedLiveryIndex = 1
    local currentExtraIndex = 1
    local selectedExtraIndex = 1
    while true do
        Citizen.Wait(0)
        if isParamedic then
            if isInService then
                if isNearStationGarage() then
                    if existingVeh == nil then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~collect your vehicle~w~!")
                    else
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~store your vehicle~w~!\nPress ~INPUT_VEH_HEADLIGHT~ to ~b~modify~w~!")
                    end
        
                    if IsControlJustPressed(1, 38) then
                        if existingVeh ~= nil then
                            SetEntityAsMissionEntity(existingVeh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
                            existingVeh = nil
                        else
                            if not WarMenu.IsMenuOpened("car_menu") then
                                if not WarMenu.DoesMenuExist("car_menu") then
                                    WarMenu.CreateMenu("car_menu", "Vehicles")
                                    WarMenu.SetSpriteTitle("car_menu", "shopui_title_ie_modgarage")
                                    WarMenu.SetSubTitle("car_menu", "Vehicles")
                                    WarMenu.SetMenuX("car_menu", 0.6)
                                    WarMenu.SetMenuY("car_menu", 0.15)
                                    WarMenu.SetTitleBackgroundColor("car_menu", 243, 44, 82, 255)
                                    WarMenu.OpenMenu("car_menu")
                                else
                                    WarMenu.OpenMenu("car_menu")
                                end
                            else
                                WarMenu.CloseMenu("car_menu")
                            end
                        end
                    end
                    if existingVeh ~= nil then
                        if IsControlJustPressed(1, 74) then
                            if not WarMenu.IsMenuOpened("car_modify_menu") then
                                if not WarMenu.DoesMenuExist("car_modify_menu") then
                                    WarMenu.CreateMenu("car_modify_menu", "Modify vehicle")
                                    WarMenu.SetSpriteTitle("car_modify_menu", "shopui_title_ie_modgarage")
                                    WarMenu.SetSubTitle("car_modify_menu", "Modifications")
                                    WarMenu.SetMenuX("car_modify_menu", 0.6)
                                    WarMenu.SetMenuY("car_modify_menu", 0.15)
                                    WarMenu.SetTitleBackgroundColor("car_modify_menu", 0, 128, 255, 255)
                                    WarMenu.OpenMenu("car_modify_menu")
                                    currentLiveryIndex = 1
                                    selectedLiveryIndex = 1
                                    currentExtraIndex = 1
                                    selectedExtraIndex = 1
                                else
                                    WarMenu.OpenMenu("car_modify_menu")
                                    currentLiveryIndex = 1
                                    selectedLiveryIndex = 1
                                    currentExtraIndex = 1
                                    selectedExtraIndex = 1
                                end
                            else
                                WarMenu.CloseMenu("car_modify_menu")
                            end
                        end
                    end
                    if WarMenu.IsMenuOpened("car_menu") then
                        for k,v in pairs(cars) do
                            if ranks[user_paramedic.rank][v.rank] or user_paramedic.rank == v.rank then
                                if WarMenu.Button(v.name) then
                                    TriggerServerEvent("emsjob:payforservices", 150)
                                    spawncar(v.model, v.type, v.livery, v.extras)
                                end
                            end
                        end
                        WarMenu.Display()
                    end
                    if WarMenu.IsMenuOpened("car_modify_menu") then
                        if existingVeh ~= nil then
                            local liveries = {}
                            local extras = {}

                            for i = 0, GetVehicleLiveryCount(existingVeh) do 
                                table.insert(liveries, i) 
                            end
                            
                            for i = 0, 14 do 
                                if DoesExtraExist(existingVeh, i) then 
                                    table.insert(extras, i) 
                                end 
                            end

                            if WarMenu.ComboBox("Livery", liveries , currentLiveryIndex, selectedLiveryIndex, function(currentIndex, selectedIndex)
                                currentLiveryIndex = currentIndex
                                selectedLiveryIndex = selectedIndex
                            end) then
                                SetVehicleLivery(existingVeh, liveries[selectedLiveryIndex])
                            end

                            if WarMenu.ComboBox("Extra", extras, currentExtraIndex, selectedExtraIndex, function(currentIndex, selectedIndex)
                                currentExtraIndex = currentIndex
                                selectedExtraIndex = selectedIndex
                            end) then
                                SetVehicleExtra(existingVeh, extras[selectedExtraIndex], tobool(IsVehicleExtraTurnedOn(existingVeh, extras[selectedExtraIndex])))
                            end

                            WarMenu.Display()
                        else
                            WarMenu.CloseMenu("car_modify_menu")
                        end
                    end
                end
                if isNearStationHeliGarage() then
                    if existingVeh == nil then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~collect your chopper~w~!")
                    else
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~store your chopper~w~!")
                    end
        
                    if IsControlJustPressed(1, 38) then
                        if existingVeh ~= nil then
                            SetEntityAsMissionEntity(existingVeh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
                            existingVeh = nil
                        else
                            if not WarMenu.IsMenuOpened("heli_menu") then
                                if not WarMenu.DoesMenuExist("heli_menu") then
                                    WarMenu.CreateMenu("heli_menu", "Helicopters")
                                    WarMenu.SetSpriteTitle("heli_menu", {"pause_menu_pages_char_mom_dad", "vignette", "Helicopters"})
                                    WarMenu.SetSubTitle("heli_menu", "")
                                    WarMenu.SetMenuX("heli_menu", 0.6)
                                    WarMenu.SetMenuY("heli_menu", 0.15)
                                    WarMenu.SetTitleBackgroundColor("heli_menu", 43, 44, 82, 255)
                                    WarMenu.OpenMenu("heli_menu")
                                else
                                    WarMenu.OpenMenu("heli_menu")
                                end
                            else
                                WarMenu.CloseMenu("heli_menu")
                            end
                        end
                    end
                    if WarMenu.IsMenuOpened("heli_menu") then
                        for k,v in pairs(heli) do
                            if ranks[user_paramedic.rank][v.rank] or user_paramedic.rank == v.rank then
                                if WarMenu.Button(v.name) then
                                    TriggerServerEvent("emsjob:payforservices", 500)
                                    spawncar(v.model, v.type)
                                end
                            end
                        end
                        WarMenu.Display()
                    end
                end
                if isNearStationBoatGarage() then
                    if existingVeh == nil then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~collect your rescue boat~w~!")
                    else
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~store your rescue boat~w~!")
                    end
        
                    if IsControlJustPressed(1, 38) then
                        if existingVeh ~= nil then
                            SetEntityAsMissionEntity(existingVeh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
                            existingVeh = nil
                        else
                            if not WarMenu.IsMenuOpened("boat_menu") then
                                if not WarMenu.DoesMenuExist("boat_menu") then
                                    WarMenu.CreateMenu("boat_menu", "Boats")
                                    WarMenu.SetSpriteTitle("boat_menu", {"pause_menu_pages_char_mom_dad", "vignette", "Boats"})
                                    WarMenu.SetSubTitle("boat_menu", "")
                                    WarMenu.SetMenuX("boat_menu", 0.6)
                                    WarMenu.SetMenuY("boat_menu", 0.15)
                                    WarMenu.SetTitleBackgroundColor("boat_menu", 43, 44, 82, 255)
                                    WarMenu.OpenMenu("boat_menu")
                                else
                                    WarMenu.OpenMenu("boat_menu")
                                end
                            else
                                WarMenu.CloseMenu("boat_menu")
                            end
                        end
                    end
                    if WarMenu.IsMenuOpened("boat_menu") then
                        for k,v in pairs(boat) do
                            if ranks[user_paramedic.rank][v.rank] or user_paramedic.rank == v.rank then
                                if WarMenu.Button(v.name) then
                                    spawncar(v.model, v.type)
                                end
                            end
                        end
                        WarMenu.Display()
                    end
                end
            end
        end
    end
end)

function spawncar(model, type, livery, extras)
    Citizen.CreateThread(function()
        local plate = "LSFD"..math.random(1,999)
        local helicopter = false
        local tint = false
        if type == "helicopter" or type == "heli" then
            helicopter = true
        elseif type == "undercover" then
            tint = true
            plate = math.random(00000000,99999999)
        end

        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply, 0)
          
        existingVeh = exports["core"]:SpawnVehicle(model, currentgarage, 90.0, false)

        if existingVeh ~= nil and existingVeh ~= 0 then
            SetVehicleMod(existingVeh, 11, 3)
            SetVehicleMod(existingVeh, 12, 3)
            SetVehicleMod(existingVeh, 13, 3)
			SetVehicleMod(existingVeh, 15, 3)
			SetVehicleModKit(existingVeh, 0)
            SetVehicleTyresCanBurst(existingVeh, false)
            SetVehicleNumberPlateText(existingVeh, plate)

            if tint then
                SetVehicleWindowTint(existingVeh, 1)
            elseif helicopter then
                SetVehicleLivery(existingVeh, 1)
            else
				SetVehicleWindowTint(existingVeh, 0)
				
				if livery ~= nil then
					SetVehicleLivery(existingVeh, livery)
				end
            end

            SetVehicleDirtLevel(existingVeh, 0)

            for i = 1, 25 do 
				if DoesExtraExist(existingVeh, i) then
					local disableExtra = true
					if helicopter then
						disableExtra = false
					elseif extras ~= nil then
						for k, v in ipairs(extras) do
							if v == i then
								disableExtra = false
							end
						end
					end

                    SetVehicleExtra(existingVeh, i, disableExtra)
                end 
            end

            TaskWarpPedIntoVehicle(ply, existingVeh, -1)

            if WarMenu.IsMenuOpened("car_menu") then
                WarMenu.CloseMenu("car_menu")
            end             
            if WarMenu.IsMenuOpened("heli_menu") then
                WarMenu.CloseMenu("heli_menu")
            end
        end
    end)
end


function AddParamedicBlips()
    for _, item in pairs(stationGarage) do
        addBlip(item)
    end
    for _, item in pairs(stationHeliGarage) do
        addBlip(item)
    end  
    for _, item in pairs(stationBoatGarage) do
        addBlip(item)
    end  
end

function RemoveParamedicBlips()
    for _, item in pairs(stationGarage) do
        RemoveBlip(item.blip)
    end
    for _, item in pairs(stationHeliGarage) do
        RemoveBlip(item.blip)
    end
    for _, item in pairs(stationBoatGarage) do
        RemoveBlip(item.blip)
    end
end

function IsVehicleExempt(_model)
	if not isParamedic then
		return false
	end
    local exempt = false
    for i = 1, #cars do
        if GetHashKey(cars[i].model) == _model then
            exempt = true
            break
        end
    end
    for i = 1, #heli do
        if GetHashKey(heli[i].model) == _model then
            exempt = true
            break
        end
    end
    for i = 1, #boat do
        if GetHashKey(boat[i].model) == _model then
            exempt = true
            break
        end
    end
    return exempt
end
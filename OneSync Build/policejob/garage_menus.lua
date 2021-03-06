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
	{name = "Police Garage", sprite = 50, colour = 18, x=452.115966796875, y=-1018.10681152344, z=28.4786586761475}, -- Mission row
	{name = "Police Garage", sprite = 50, colour = 18, x=-457.88, y=6024.79, z=31.34}, -- Paleto Bay
	{name = "Police Garage", sprite = 50, colour = 18, x=1866.84, y=3697.15, z=33.60}, -- Sandy Shores
	{name = "Police Garage", sprite = 50, colour = 18, x=-1068.95, y=-859.73, z=4.87}, -- San Andreas Ave
	{name = "Police Garage", sprite = 50, colour = 18, x=-570.28, y=-145.50, z=37.79}, -- Rockford Hills
	{name = "Police Garage", sprite = 50, colour = 18, x = 367.40277099609, y = 790.59448242188, z = 187.22383117676, h = 236.06201171875}, -- Park Ranger Station
}

local stationHeliGarage = {
	{name = "Police Helipad", sprite = 43, colour = 18, x=449.150207519531, y=-981.246459960938, z=43.6916275024414}, -- Mission row
	{name = "Police Helipad", sprite = 43, colour = 18, x=-475.33, y=5988.55, z=31.34}, -- Paleto Bay
	{name = "Police Helipad", sprite = 43, colour = 18, x=1889.5676269531, y=3705.4157714844, z=32.930965423584}, -- Sandy Shores
	{name = "Police Helipad", sprite = 43, colour = 18, x=-1095.3184814453, y=-834.97686767578, z=37.675365447998}, -- San Andreas Ave
}

local boatGarage = {
	{name = "Police Boatyard", sprite = 266, colour = 18, x = -772.71636962891, y = -1431.1351318359, z = 1.5952169895172, h = 52.574047088623},
	{name = "Police Boatyard", sprite = 266, colour = 18, x = -280.49618530273, y = 6635.1884765625, z = 7.5431871414185, h = 40.816436767578},
	{name = "Police Boatyard", sprite = 266, colour = 18, x = 1542.1602783203, y = 3911.0981445313, z = 31.58381652832, h = 162.13052368164},
}

heli = {
	{name = "LSPD Maverick", model = "polmav", type = "helicopter", rank = "officer ii"},
	{name = "Sheriff Buzzard", model = "buzzard2", type = "helicopter", rank = "officer ii"},
}

boat = {
	{name = "LSPD Predator", model = "Predator", type = "", rank = "officer i"},
}

function tobool(input)
	if input == "true" or tonumber(input) == 1 or input == true or input == "on" then
		return true
	else
		return false
	end
end

function isNearStationHeliGarage()
	for i = 1, #stationHeliGarage do
		local ply = PlayerPedId()
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(25, stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z-0.9, 0, 0, 0, 0, 0, 0, 9.0, 9.0, 2.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			currentgarage.x, currentgarage.y, currentgarage.z = stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z
			if(distance < 7) then
				return true
			elseif distance > 7 then
				--if WarMenu.IsMenuOpened("heli_menu") then
					--WarMenu.CloseMenu("heli_menu")
				--end
			end
		end
	end
end

function isNearStationBoatyard()
	for i = 1, #boatGarage do
		local ply = PlayerPedId()
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(boatGarage[i].x, boatGarage[i].y, boatGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		local distance2 = GetDistanceBetweenCoords(boatGarage[i].x, boatGarage[i].y, boatGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, boatGarage[i].x, boatGarage[i].y, boatGarage[i].z-0.9, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
			if i == 1 then
				currentgarage.x, currentgarage.y, currentgarage.z = -778.4921875, -1430.2032470703, 1.294110417366
			elseif i == 2 then
				currentgarage.x, currentgarage.y, currentgarage.z = -289.64694213867, 6645.7841796875, 1.5431871414185
			elseif i == 3 then
				currentgarage.x, currentgarage.y, currentgarage.z =  1541.8719482422, 3898.4375, 31.970890045166
			end
			if(distance < 7)then
				return true
			elseif distance > 7 then

			end
		end
		if distance2 < 20 then
			return true
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
		if isCop then
			if isInService then
				if isNearStationHeliGarage() then
					if existingVeh == nil then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~collect your chopper~w~!")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~store your chopper~w~!\nPress ~INPUT_VEH_HEADLIGHT~ to ~b~modify~w~!")
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
									WarMenu.SetTitleBackgroundColor("heli_menu", 0, 128, 255, 255)
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
							if ranks[user_cop.rank][v.rank] or user_cop.rank == v.rank then
								if WarMenu.Button(v.name) then
									TriggerServerEvent("police:payforservices", 500)
									spawncar(v.model, v.type)
								end
							end
						end
						WarMenu.Display()
					end
					if existingVeh ~= nil then
                        if IsControlJustPressed(1, 74) then
                            if not WarMenu.IsMenuOpened("heli_modify_menu") then
                                if not WarMenu.DoesMenuExist("heli_modify_menu") then
                                    WarMenu.CreateMenu("heli_modify_menu", "Modify vehicle")
                                    WarMenu.SetSpriteTitle("heli_modify_menu", {"pause_menu_pages_char_mom_dad", "vignette", "Helicopters"})
                                    WarMenu.SetSubTitle("heli_modify_menu", "Modifications")
                                    WarMenu.SetMenuX("heli_modify_menu", 0.6)
                                    WarMenu.SetMenuY("heli_modify_menu", 0.15)
                                    WarMenu.SetTitleBackgroundColor("heli_modify_menu", 0, 128, 255, 255)
                                    WarMenu.OpenMenu("heli_modify_menu")
                                    currentLiveryIndex = 1
                                    selectedLiveryIndex = 1
                                else
                                    WarMenu.OpenMenu("heli_modify_menu")
                                    currentLiveryIndex = 1
                                    selectedLiveryIndex = 1
                                end
                            else
                                WarMenu.CloseMenu("heli_modify_menu")
                            end
                        end
                    end
                    if WarMenu.IsMenuOpened("heli_modify_menu") then
                        if existingVeh ~= nil then
                            local livery_count = GetVehicleLiveryCount(existingVeh)
                            local liveries = {}
                            for i = 1, livery_count do table.insert(liveries, tostring(i)) end
                            if WarMenu.ComboBox("Livery", liveries , currentLiveryIndex, selectedLiveryIndex, function(currentIndex, selectedIndex)
                                currentLiveryIndex = currentIndex
                                selectedLiveryIndex = selectedIndex
                            end) then
                                SetVehicleLivery(existingVeh, selectedLiveryIndex)
                            end
                            WarMenu.Display()
                        else
                            WarMenu.CloseMenu("heli_modify_menu")
                        end
                    end
				end
				if isNearStationBoatyard() then
					if existingVeh == nil then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~collect your predator~w~!")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~store your predator~w~!")
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
									WarMenu.SetTitleBackgroundColor("boat_menu", 0, 128, 255, 255)
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
							if ranks[user_cop.rank][v.rank] or user_cop.rank == v.rank then
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

function spawncar(model, type)
	Citizen.CreateThread(function()
		local helicopter = false
		local tint = false
		if type == "helicopter" or type == "heli" then
			helicopter = true
		elseif type == "undercover" then
			tint = true
		end

		local ply = PlayerPedId()
		local plyCoords = GetEntityCoords(ply, 0)
								
		existingVeh = exports["core"]:SpawnVehicle(model, currentgarage, 90.0, false)

		if existingVeh ~= nil and existingVeh ~= 0 then
			SetVehicleMod(existingVeh, 11, 3)
			SetVehicleMod(existingVeh, 12, 3)
			SetVehicleMod(existingVeh, 13, 3)
			SetVehicleMod(existingVeh, 15, 3)
			SetVehicleTyresCanBurst(existingVeh, true)

			if tint then
				SetVehicleWindowTint(existingVeh, 1)
			elseif helicopter then
				SetVehicleLivery(existingVeh, 0)
			else
				SetVehicleWindowTint(existingVeh, 0)
			end
			SetVehicleDirtLevel(existingVeh, 0)
			for i = 1, 25 do 
				if DoesExtraExist(existingVeh, i) then
					SetVehicleExtra(existingVeh, i, false)
				end 
			end
			TaskWarpPedIntoVehicle(ply, existingVeh, -1)
		
			if WarMenu.IsMenuOpened("heli_menu") then
				WarMenu.CloseMenu("heli_menu")
			end
			if WarMenu.IsMenuOpened("boat_menu") then
				WarMenu.CloseMenu("boat_menu")
			end
		end
	end)
end

function GarageBlips()
	for _, item in pairs(stationGarage) do
		addBlip(item)
	end
	for _, item in pairs(stationHeliGarage) do
		addBlip(item)
	end
	for _, item in pairs(boatGarage) do
		addBlip(item)
	end
end

function RemoveGarageBlips()
	for _, item in pairs(stationGarage) do
		RemoveBlip(item.blip)
	end
	for _, item in pairs(stationHeliGarage) do
		RemoveBlip(item.blip)
	end
	for _, item in pairs(boatGarage) do
		RemoveBlip(item.blip)
	end
end

function IsVehicleExempt(_model)
	if not isCop then
		return false
	end
	local exempt = false
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
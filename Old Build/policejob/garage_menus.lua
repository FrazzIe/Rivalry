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
}

local stationHeliGarage = {
	{name = "Police Helipad", sprite = 43, colour = 18, x=449.150207519531, y=-981.246459960938, z=43.6916275024414}, -- Mission row
	{name = "Police Helipad", sprite = 43, colour = 18, x=-475.33, y=5988.55, z=31.34}, -- Paleto Bay
	{name = "Police Helipad", sprite = 43, colour = 18, x=1889.5676269531, y=3705.4157714844, z=32.930965423584}, -- Sandy Shores
	{name = "Police Helipad", sprite = 43, colour = 18, x=-1095.3184814453, y=-834.97686767578, z=37.675365447998}, -- San Andreas Ave
}

cars = {
    {name = "Marked City CVPI", model = "police7", type = "", rank = "cadet"},
    {name = "Marked City Taurus", model = "police", type = "", rank = "officer i"}, 
    {name = "Marked City Charger", model = "police2", type = "", rank = "officer i"},
    {name = "Marked City Explorer", model = "police5", type = "", rank = "officer ii"},
    {name = "2011 CVPI Slicktop", model = "police3", type = "", rank = "officer ii"},
    {name = "Sheriff CVPI", model = "sheriff3", type = "", rank = "cadet"},
    {name = "Sheriff Charger", model = "sheriff", type = "", rank = "officer ii"},
    {name = "Sheriff Chevy Tahoe", model = "sheriff2", type = "", rank = "officer ii"},
    {name = "Marked K9 Charger", model = "k9c", type = "", rank = "officer ii"},
    {name = "Marked Motorcycle", model = "policebmw", type = "", rank = "officer i"},
    {name = "Trooper Motorcycle", model = "policeb", type = "", rank = "sergeant"},
    {name = "Trooper Vic", model = "statep", type = "", rank = "sergeant"},
    {name = "Trooper Charger", model = "statep2", type = "", rank = "sergeant"},
    {name = "Trooper Chevy Silverado", model = "statep3", type = "", rank = "sergeant"},
    {name = "Trooper Hellcat", model = "statep4", type = "", rank = "sergeant"},
    {name = "Interceptor 1", model = "2015polstang", type = "", rank = "officer ii"},
    {name = "Interceptor 2", model = "rmodpolice", type = "", rank = "officer ii"},
    {name = "Unmarked Taxi Vic", model = "umt1", type = "", rank = "detective"},
    {name = "Unmarked Buffalo", model = "dtu1", type = "", rank = "detective"},
    {name = "Unmarked Fugitive", model = "dtu2", type = "", rank = "detective"},
    {name = "Unmarked Cruiser", model = "dtu3", type = "", rank = "detective"},
    {name = "Unmarked Suburban", model = "usuburban", type = "", rank = "lieutenant"},
    {name = "Unmarked Charger", model = "18charger", type = "", rank = "lieutenant"},
}

heli = {
	{name = "LSPD Chopper", model = "polmav", type = "helicopter", rank = "officer ii"},
}

function isNearStationGarage()
	for i = 1, #stationGarage do
		local ply = PlayerPedId()
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(25, stationGarage[i].x, stationGarage[i].y, stationGarage[i].z-0.9, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
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

Citizen.CreateThread(function()
    local currentLiveryIndex = 1
    local selectedLiveryIndex = 1
    local currentExtraIndex = 1
    local selectedExtraIndex = 1
	while true do
		Citizen.Wait(0)
		if isCop then
			if isInService then
				if isNearStationGarage() then
					if existingVeh == nil then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~collect your cruiser~w~!")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~store your cruiser~w~!\nPress ~INPUT_VEH_HEADLIGHT~ to ~b~modify~w~!")
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
									WarMenu.SetTitleBackgroundColor("car_menu", 0, 128, 255, 255)
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
                                else
                                    WarMenu.OpenMenu("car_modify_menu")
                                    currentLiveryIndex = 1
                                    selectedLiveryIndex = 1
                                end
                            else
                                WarMenu.CloseMenu("car_modify_menu")
                            end
                        end
                    end
					if WarMenu.IsMenuOpened("car_menu") then
						for k,v in pairs(cars) do
							if ranks[user_cop.rank][v.rank] or user_cop.rank == v.rank then
								if WarMenu.Button(v.name) then
									spawncar(v.model, v.type)
								end
							end
						end
						WarMenu.Display()
					end
                    if WarMenu.IsMenuOpened("car_modify_menu") then
                        if existingVeh ~= nil then
                            local livery_count = GetVehicleLiveryCount(existingVeh)
                            local liveries = {}
                            for i = 1, livery_count do table.insert(liveries, tostring(i)) end
                            local extras = {}
                            for i = 1, 25 do 
                            	if DoesExtraExist(existingVeh, i) then table.insert(extras, tostring(i)) end 
                            end
                            if WarMenu.ComboBox("Livery", liveries , currentLiveryIndex, selectedLiveryIndex, function(currentIndex, selectedIndex)
                                currentLiveryIndex = currentIndex
                                selectedLiveryIndex = selectedIndex
                            end) then
                                SetVehicleLivery(existingVeh, selectedLiveryIndex)
                            end
                            if WarMenu.ComboBox("Extra", extras , currentExtraIndex, selectedExtraIndex, function(currentIndex, selectedIndex)
                                currentExtraIndex = currentIndex
                                selectedExtraIndex = selectedIndex
                            end) then
                            	if IsVehicleExtraTurnedOn(existingVeh, selectedExtraIndex) == 1 then
                                	SetVehicleExtra(existingVeh, selectedExtraIndex, true)
                                else
                                	SetVehicleExtra(existingVeh, selectedExtraIndex, false)
                                end
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
		local plate = "LSPD"..math.random(1,999)
		local helicopter = false
		local tint = false
		if type == "helicopter" or type == "heli" then
			helicopter = true
		elseif type == "undercover" then
			tint = true
			plate = math.random(00000000,99999999)
		end
		local carhashed = GetHashKey(model)
		local ply = PlayerPedId()
		local plyCoords = GetEntityCoords(ply, 0)
		RequestModel(carhashed)
		while not HasModelLoaded(carhashed) do
			Citizen.Wait(0)
		end
								
		existingVeh = CreateVehicle(carhashed, currentgarage.x, currentgarage.y, currentgarage.z, 90.0, true, false)
		while not DoesEntityExist(existingVeh) do
			Citizen.Wait(0)
		end
		local id = NetworkGetNetworkIdFromEntity(existingVeh)
		SetNetworkIdCanMigrate(id, true)
		SetVehicleMod(existingVeh, 11, 3)
		SetVehicleMod(existingVeh, 12, 3)
		SetVehicleMod(existingVeh, 13, 3)
		SetVehicleMod(existingVeh, 15, 3)
		SetVehicleTyresCanBurst(existingVeh, false)
		SetVehicleNumberPlateText(existingVeh, plate)
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
		if WarMenu.IsMenuOpened("car_menu") then
			WarMenu.CloseMenu("car_menu")
		end				
		if WarMenu.IsMenuOpened("heli_menu") then
			WarMenu.CloseMenu("heli_menu")
		end
		SetModelAsNoLongerNeeded(carhashed)
	end)
end

function GarageBlips()
	for _, item in pairs(stationGarage) do
		addBlip(item)
	end
	for _, item in pairs(stationHeliGarage) do
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
end

function IsVehicleExempt(_model)
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
	return exempt
end
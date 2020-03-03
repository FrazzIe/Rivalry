CarDealer = {
	IsDealer = false,
	OnDuty = false,
	Sold = nil,
	Rank = nil,
	Type = nil,
}

local carDealers = {
	["normal"] = { -- Legion PDM
		{
			clockIn = vector3(-27.503318786621, -1103.9670410156, 26.422353744507),
			vehicleMenu = vector3(-56.683197021484, -1098.8134765625, 26.422353744507),
			spawnArea = vector4(-15.347786903381, -1084.8883056641, 26.675786972046, 72.441734313965),
			returnArea = vector3(-18.606876373291, -1101.9809570313, 26.671327590942)
		},
	},
	["luxary"] = {

	},
	["import"] = {

	}
}

local displayedVehicles = {
    ["normal"] = {},
    ["luxary"] = {},
    ["import"] = {},
}

Citizen.CreateThread(function()
	function CarDealer:SpawnVehicle(model, coords, heading, clearArea)
		local clearRadius = 1.5
		local modelHash = (type(model) == "string" and GetHashKey(model) or model)
		local startTime = GetGameTimer()

		if not IsModelInCdimage(modelHash) then
			Citizen.Trace("[Export]:SpawnVehicle -> Invalid model")
			return nil
		end

		if not IsModelAVehicle(modelHash) then
			Citizen.Trace("[Export]:SpawnVehicle -> Model is not a vehicle")
			return nil
		end

		if not CanRegisterMissionVehicles(1) then
			Citizen.Trace("[Export]:SpawnVehicle -> Unable to register mission vehicles")
			return nil
		end

		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(25)

			if (GetGameTimer() - startTime) > 15000 then
				break
			end
		end

		if not HasModelLoaded(modelHash) then
			Citizen.Trace("[Export]:SpawnVehicle -> Unable to load model")
			return nil
		end
		
		if model == "bombushka" then
			clearRadius = 20.0
		end

		if clearArea then
			ClearAreaOfVehicles(coords.x, coords.y, coords.z, clearRadius, false, false, false, false, false)
		end

		local handle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, heading, true, false)

		if DoesEntityExist(handle) then
			local netHandle = VehToNet(handle)

			SetEntitySomething(handle, true)

			if NetworkGetEntityIsNetworked(handle) then
				SetNetworkIdExistsOnAllMachines(netHandle, true)
			end

			SetVehicleIsStolen(handle, false)
			N_0xb2e0c0d6922d31f2(handle, true)
			SetModelAsNoLongerNeeded(modelHash)
			
			return handle
		else
			Citizen.Trace("[Export]:SpawnVehicle -> Vehicle does not exist")
			return nil
		end
	end
end)

RegisterNetEvent("CarDealer:Set")
AddEventHandler("CarDealer:Set", function(_Data, _CarDealer, first)
	CarDealer.IsDealer = _CarDealer

	if not CarDealer.IsDealer then
		CarDealer.Sold = nil
		CarDealer.Rank = nil
		CarDealer.Type = nil
	else
		if _Data ~= nil then
			if _Data.sold ~= nil and _Data.rank ~= nil then
				CarDealer.Sold = _Data.sold
				CarDealer.Rank = _Data.rank
				CarDealer.Type = _Data.type
			end
		end
	end
end)

RegisterNetEvent("DisplayVehicles.Sync")
AddEventHandler("DisplayVehicles.Sync", function(Table)
	DisplayedVehicles = Table
end)

RegisterNetEvent("carshop:bought")
AddEventHandler("carshop:bought",function(data, NetworkID, Store)
    Citizen.CreateThread(function()
        Citizen.Wait(0)

		local veh = NetworkGetEntityFromNetworkId(NetworkID)
        local count = #user_vehicles + 1
        user_vehicles[count] = data
		user_vehicles[count].state = "~g~Stored"

		if veh ~= nil and veh ~= 0 then
            table.insert(out, veh)
            user_vehicles[count].instance = veh
            user_vehicles[count].state = "~r~Missing"
            SetVehicleOnGroundProperly(veh)
			DecorSetBool(veh, "hotwire", true)
			DecorSetFloat(veh, "_Fuel_Level", 100)
            SetVehicleColours(veh, data.primary_colour, data.secondary_colour)
            SetVehicleExtraColours(veh, tonumber(data.pearlescent_colour), tonumber(data.wheel_colour))
            SetVehicleNumberPlateTextIndex(veh, data.plate_colour)
			SetVehicleNumberPlateText(veh, data.plate)
            SetVehicleNeonLightsColour(veh, tonumber(data.neon_colour[1]), tonumber(data.neon_colour[2]), tonumber(data.neon_colour[3]))
            SetVehicleTyreSmokeColor(veh, tonumber(data.smoke_colour[1]), tonumber(data.smoke_colour[2]), tonumber(data.smoke_colour[3]))
			SetVehicleModKit(veh, 0)

            for i = 0, 8 do
                SetVehicleMod(veh, i, tonumber(data["mod"..i]))
            end

            for i = 10, 16 do
                SetVehicleMod(veh, i, tonumber(data["mod"..i]))
            end

            for i = 23, 46 do
                SetVehicleMod(veh, i, tonumber(data["mod"..i]))
            end

            SetVehicleMod(veh, 48, tonumber(data.mod48))

			SetVehicleLivery(veh, data.livery)

			for i = 1, 15 do
				if DoesExtraExist(veh, i-1) and data["extra"..i] then
					SetVehicleExtra(veh, i-1, not data["extra"..i])
				end
			end
			
            if data.turbo == "on" then
                ToggleVehicleMod(veh, 18, true)
            else
                ToggleVehicleMod(veh, 18, false)
            end

            if data.tyre_smoke == "on" then
                ToggleVehicleMod(veh, 20, true)
            else
                ToggleVehicleMod(veh, 20, false)
            end

            if data.xenon_lights == "on" then
                ToggleVehicleMod(veh, 22, true)
            else
                ToggleVehicleMod(veh, 22, false)
            end

            SetVehicleWheelType(veh, tonumber(data.wheeltype))
            SetVehicleMod(veh, 23, tonumber(data.mod23))
            SetVehicleMod(veh, 24, tonumber(data.mod24))

            if data.custom_wheels == "on" then
                SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), true)
            end

            if data.custom_wheels2 == "on" then
                SetVehicleMod(veh, 24, GetVehicleMod(veh, 24), true)
            end

            if data.neon0 == "on" then
                SetVehicleNeonLightEnabled(veh, 0, true)
            else
                SetVehicleNeonLightEnabled(veh, 0, false)
            end

            if data.neon1 == "on" then
                SetVehicleNeonLightEnabled(veh, 1, true)
            else
                SetVehicleNeonLightEnabled(veh, 1, false)
            end

            if data.neon2 == "on" then
                SetVehicleNeonLightEnabled(veh, 2, true)
            else
                SetVehicleNeonLightEnabled(veh, 2, false)
            end

            if data.neon3 == "on" then
                SetVehicleNeonLightEnabled(veh, 3, true)
            else
                SetVehicleNeonLightEnabled(veh, 3, false)
            end

            if data.bulletproof_wheels == "on" then
                SetVehicleTyresCanBurst(veh, false)
            else
                SetVehicleTyresCanBurst(veh, true)
            end

			SetVehicleHeadlightsColour(veh, data.headlight_colour)
			SetVehicleDashboardColour(veh, data.dashboard_colour)
			SetVehicleInteriorColour(veh, data.interior_colour)
            SetVehicleWindowTint(veh, tonumber(data.tint_colour))
        end
	end)
	TriggerServerEvent("CarDealer.RemoveVehicle", NetworkID, Store)
end)

RegisterNetEvent("Dealer.SoldVehicle")
AddEventHandler("Dealer.SoldVehicle", function(Sold)
	if CarDealer.IsDealer and CarDealer.OnDuty then
		CarDealer.sold = Sold
	end
end)

RegisterNetEvent("carshop:setplate")
AddEventHandler("carshop:setplate", function(Plate, NetworkID)
	local Vehicle = NetworkGetEntityFromNetworkId(NetworkID)
	SetVehicleNumberPlateText(Vehicle, Plate)
	DecorSetFloat(Vehicle, "_Fuel_Level", 100.0)
end)

function GetGarage()
    local garages_used, garages_slots, available_garages = {}, {}, {}
    for i = 1, tablelength(user_garages) do
        garages_slots[user_garages[i].garage_id] = user_garages[i].slots
        garages_used[user_garages[i].garage_id] = 0 
    end
    for i = 1, tablelength(user_vehicles) do
        if garages_used[user_vehicles[i].garage_id] then
            garages_used[user_vehicles[i].garage_id] = garages_used[user_vehicles[i].garage_id] + 1
        end
    end

    for k,v in pairs(garages_slots) do
        if v ~= nil then
            if garages_used[k] < v then
                table.insert(available_garages, k)
            end
        end
	end
	
    return available_garages[1]
end

function IsDealershipCar(NetworkID, Store)
	if displayedVehicles[Store] then
		for Index = 1, #displayedVehicles[Store] do
			if displayedVehicles[Store][Index].Entity == NetworkID then
				return true
			end
		end
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CarDealer.IsDealer then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)

			if #(PlayerPosition - Data.Service) <= 1.0 then
				if CarDealer.OnDuty then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to sign off duty!")
					if IsControlJustPressed(1, 51) then
						CarDealer.OnDuty = false
					end
				else
					DisplayHelpText("Press ~INPUT_CONTEXT~ to sign on duty!")
					if IsControlJustPressed(1, 51) then
						CarDealer.OnDuty = true
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CarDealer.OnDuty and CarDealer.IsDealer and CarDealer.Type then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player)

			if carDealers[CarDealer.Type] then
				for i = 1, #carDealers[CarDealer.Type] do
					-- Vehicle menu marker
					if #(PlayerPosition - carDealers[CarDealer.Type][i].vehicleMenu) <= 1.0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to view avaliable display vehicles!")
						if IsControlJustPressed(1, 51) then
							if not WarMenu.IsMenuOpened("DisplayedCars") then
								if not WarMenu.DoesMenuExist("DisplayedCars") then
									WarMenu.CreateMenu("DisplayedCars", "Vehicle Inventory")
									WarMenu.SetSpriteTitle("DisplayedCars", "shopui_title_ie_modgarage")
									WarMenu.SetSubTitle("DisplayedCars", "CATEGORIES")
									WarMenu.SetMenuX("DisplayedCars", 0.6)
									WarMenu.SetMenuY("DisplayedCars", 0.15)
									for k,v in pairs(cars) do
										WarMenu.CreateSubMenu(v.title, "DisplayedCars", v.title.." SECTION")
										for i,j in pairs(v.vehicles) do
											WarMenu.CreateSubMenu(j.name, v.title, j.name)
										end
									end
									WarMenu.OpenMenu("DisplayedCars")
								else
									WarMenu.OpenMenu("DisplayedCars")
								end
							else
								WarMenu.CloseMenu("DisplayedCars")
							end
						end
					end
					-- Vehicle return marker
					local returnAreaDist = #(PlayerPosition - carDealers[CarDealer.Type][i].returnArea)
					if returnAreaDist <= 11.0 then
						RenderMarker(25, carDealers[CarDealer.Type][i].returnArea.x, carDealers[CarDealer.Type][i].returnArea.y, carDealers[CarDealer.Type][i].returnArea.z - 0.9, 1.5, 1.5, 2.0, 255, 255, 0, 20)
						if returnAreaDist <= 4.0 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to return vehicle!")
							if IsControlJustPressed(1, 51) then
								if IsPedInAnyVehicle(PlayerPedId(), false) then
									local Vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
									local NetworkID = NetworkGetNetworkIdFromEntity(Vehicle)
									if IsDealershipCar(NetworkID, CarDealer.Type) then
										TriggerServerEvent("CarDealer.RemoveVehicle", NetworkID)
										DestroyVehicle(Vehicle)
									else
										Notify("This vehicle is not a dealership vehicle!", 3100)
									end
								else
									Notify("You must be in a vehicle!", 3100)
								end
							end
						end
					end
					-- Vehicle menu [main]
					if WarMenu.IsMenuOpened("DisplayedCars") then
						if CarDealer.Type then
							if vehicleList[CarDealer.Type] then
								for k,v in pairs(vehicleList[CarDealer.Type]) do
									if WarMenu.MenuButton(v.title, v.title) then
										currentCategory = v.vehicles
									end
								end

								WarMenu.Display()
							end
						end
					end
					-- Vehicle menu [sub menus]
					if CarDealer.Type then
						if vehicleList[CarDealer.Type] then
							for k,v in pairs(vehicleList[CarDealer.Type]) do
								if WarMenu.IsMenuOpened(v.title) then
									for i,j in pairs(v.vehicles) do
										if WarMenu.Button(j.name) then
											local Vehicle = CarDealer:SpawnVehicle(j.model, { x = carDealers[CarDealer.Type][i].spawnArea.x, y = carDealers[CarDealer.Type][i].spawnArea.y, z = carDealers[CarDealer.Type][i].spawnArea.z }, carDealers[CarDealer.Type][i].spawnArea.w, false)
											SetVehicleOnGroundProperly(Vehicle)
											SetPedIntoVehicle(Player, Vehicle, -1)
											DecorSetBool(Vehicle, "hotwire", true)
											for i = 0,24 do
												SetVehicleModKit(Vehicle,0)
												RemoveVehicleMod(Vehicle,i)
											end
											local turbo
											local tiresmoke
											local xenon
											local neon0
											local neon1
											local neon2
											local neon3
											local bulletproof
											local custom_wheels
											local custom_wheels2
											local plate = GetVehicleNumberPlateText(Vehicle)
											local colors = table.pack(GetVehicleColours(Vehicle))
											local extra_colors = table.pack(GetVehicleExtraColours(Vehicle))
											local neoncolor = table.pack(GetVehicleNeonLightsColour(Vehicle))
											local smokecolor = table.pack(GetVehicleTyreSmokeColor(Vehicle))

											if IsToggleModOn(Vehicle,18) then
												turbo = "on"
											else
												turbo = "off"
											end

											if IsToggleModOn(Vehicle,20) then
												tiresmoke = "on"
											else
												tiresmoke = "off"
											end

											if IsToggleModOn(Vehicle,22) then
												xenon = "on"
											else
												xenon = "off"
											end

											if IsVehicleNeonLightEnabled(Vehicle,0) then
												neon0 = "on"
											else
												neon0 = "off"
											end

											if IsVehicleNeonLightEnabled(Vehicle,1) then
												neon1 = "on"
											else
												neon1 = "off"
											end

											if IsVehicleNeonLightEnabled(Vehicle,2) then
												neon2 = "on"
											else
												neon2 = "off"
											end

											if IsVehicleNeonLightEnabled(Vehicle,3) then
												neon3 = "on"
											else
												neon3 = "off"
											end

											if GetVehicleTyresCanBurst(Vehicle) then
												bulletproof = "off"
											else
												bulletproof = "on"
											end

											if GetVehicleModVariation(Vehicle, 23) then
												custom_wheels = "on"
											else
												custom_wheels = "off"
											end

											if GetVehicleModVariation(Vehicle, 24) then
												custom_wheels2 = "on"
											else
												custom_wheels2 = "off"
											end

											local data = {
												garage_id = nil,
												model = j.model,
												name = j.name,
												instance = Vehicle,
												plate = GetVehicleNumberPlateText(Vehicle),
												state = "~r~Missing",
												primary_colour = colors[1],
												secondary_colour = colors[2],
												pearlescent_colour = extra_colors[1],
												wheel_colour = extra_colors[2],
												smoke_colour = {smokecolor[1],smokecolor[2],smokecolor[3]},
												plate_colour = GetVehicleNumberPlateTextIndex(Vehicle),
												neon_colour = {neoncolor[1],neoncolor[2],neoncolor[3]},
												tint_colour = GetVehicleWindowTint(Vehicle),
												tyre_smoke = tiresmoke,
												xenon_lights = xenon,
												turbo = turbo,
												custom_wheels = custom_wheels,
												custom_wheels2 = custom_wheels2,
												bulletproof_wheels = bulletproof,
												wheeltype = GetVehicleWheelType(Vehicle),
												neon0 = neon0,
												neon1 = neon1,
												neon2 = neon2,
												neon3 = neon3,
												engine_health = GetVehicleEngineHealth(Vehicle),
												petrol_health = GetVehiclePetrolTankHealth(Vehicle),
												body_health = GetVehicleBodyHealth(Vehicle),
												vehicle_health = GetEntityHealth(Vehicle),
												insurance = "true",
												claims = 1,
												fuel = 100,
												livery = GetVehicleLivery(Vehicle),
												headlight_colour = GetVehicleHeadlightsColour(Vehicle),
												dashboard_colour = GetVehicleDashboardColour(Vehicle),
												interior_colour = GetVehicleInteriorColour(Vehicle),
											}

											for i = 0, 8 do
												data["mod"..i] = GetVehicleMod(Vehicle, i)
											end

											for i = 10, 16 do
												data["mod"..i] = GetVehicleMod(Vehicle, i)
											end

											for i = 23, 46 do
												data["mod"..i] = GetVehicleMod(Vehicle, i)
											end

											data["mod48"] = GetVehicleMod(Vehicle, 48)

											for i = 1, 15 do
												if DoesExtraExist(Vehicle, i-1) then
													data["extra"..i] = IsVehicleExtraTurnedOn(Vehicle, i-1) and true or false
												else
													data["extra"..i] = false
												end
											end
											
											--DecorSetBool(Vehicle, "_Is_DealerShip_Car", true)
											--DecorSetBool(Vehicle, "_Is_CarDealer_Car", true)
											TriggerServerEvent("Spawn.DisplayVehicle", CarDealer.Type, {Model = j.model, Entity = NetworkGetNetworkIdFromEntity(Vehicle), Data = data, Price = 0, Intrest = 0, Weeks = 0, CashDown = 0, DealerText = "", Seller = GetPlayerServerId(PlayerId())})
											WarMenu.CloseMenu()
										end
									end

									WarMenu.Display()
								end
							end
						end
					end
					
					if CarDealer.Type then
						if displayedVehicles[CarDealer.Type] then
							if #displayedVehicles[CarDealer.Type] > 0 then
								for Index = 1, #displayedVehicles[CarDealer.Type] do
									local displayVehicle = displayedVehicles[CarDealer.Type][Index]
									if NetworkDoesNetworkIdExist(displayVehicle.Entity) then
										local displayVehicleEntity = NetworkGetEntityFromNetworkId(displayVehicle.Entity)
										if GetHashKey(displayVehicle.Model) == GetEntityModel(NetworkGetEntityFromNetworkId(displayVehicle.Entity)) then
											local VehicleCoords = GetEntityCoords(displayVehicleEntity, false)
											if #(PlayerPosition - VehicleCoords) <= 2.0 and not IsPedInAnyVehicle(Player) then
												if displayVehicle.DealerText == "" then
													Draw3DText(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, "[E] - Press to set information")
												else
													Draw3DText(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z - 0.1, "[E] - Press to set information")
												end

												if IsControlJustPressed(1, 51) then
													-- Create Inputs here
													local Price = tonumber(KeyboardInput("Enter Total Price:", "100000", 11))
													local Weeks = tonumber(KeyboardInput("Enter Total Weeks:", "8", 11))
													local Interest = tonumber(KeyboardInput("Enter Intrest Rate:", "10", 11))

													if Interest > 20 then
														Interest = 20
													elseif Interest < 5 then
														Interest = 5
													end

													local CashDown = tonumber(KeyboardInput("Enter Cash Down: ", "0", 11))

													if CashDown > ( Price * 0.05) then
														CashDown = Price * 0.05
														CashDown = tonumber(CashDown)
													end

													if Price ~= nil and Weeks ~= nil and Interest ~= nil and CashDown ~= nil then
														displayVehicle.Price = Price
														displayVehicle.Weeks = Weeks
														displayVehicle.Intrest = Interest
														displayVehicle.CashDown = CashDown
														displayVehicle.DealerText = "[E] - Price: $"..displayVehicle.Price.." | Weeks: "..displayVehicle.Weeks.. " | Interest: "..displayVehicle.Interest.."%".." | Cash Down: $"..displayVehicle.CashDown

														TriggerServerEvent("Change.DisplayVehicle", displayVehicle, CarDealer.Type, Index)
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		-- Check For Distance Between Player And DisplayedVehicles To Draw 3D Text

		for k,v in pairs(displayedVehicles) do
			if #v > 0 then
				for Index = 1, #v do
					if v[Index].Price > 0 and v[Index].Price ~= nil and v[Index].Weeks > 0 and v[Index].Weeks ~= nil and v[Index].Interest > 0 and v[Index].Interest ~= nil then
						local displayVehicle = v[Index]
						if NetworkDoesNetworkIdExist(displayVehicle.Entity) then
							local displayVehicleEntity = NetworkGetEntityFromNetworkId(displayVehicle.Entity)
							if GetHashKey(displayVehicle.Model) == GetEntityModel(displayVehicleEntity) then
								local VehicleCoords = GetEntityCoords(displayVehicleEntity, false)
								local VehicleDist = #(PlayerPosition - VehicleCoords)
								if VehicleDist <= 6.0 then
									Draw3DText(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, displayVehicle.DealerText)
									if CarDealer.OnDuty == false then
										if VehicleDist <= 2.0 and not IsPedInAnyVehicle(Player) then
											if IsControlJustPressed(1, 51) then
												local available_garage = GetGarage()
												if available_garage then
													if displayVehicle.Price > 0 and displayVehicle.Price ~= nil and displayVehicle.Weeks > 0 and displayVehicle.Weeks ~= nil and displayVehicle.Interest > 0 and displayVehicle.Interest ~= nil then
														Citizen.CreateThread(function()
															if lockBuyingCar ~= true then
																lockBuyingCar = true
																local notifReceivedAt = GetGameTimer()
																local msg = "Press <span style='color:lime'>Y</span> to buy with cash, press <span style='color:white'>L</span> to lease it, or press <span style='color:red'>M</span> to refuse!"
																exports.pNotify:SendNotification({text = msg,type = "error",timeout = 30000,layout = "centerRight",queue = "left"})
																while(true) do
																	Wait(0)
																	
																	if (GetTimeDifference(GetGameTimer(), notifReceivedAt) > 30000) then
																		exports.pNotify:SendNotification({text = "The application for the fine has expired.",type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
																		lockBuyingCar = false
																		break
																	end
																	
																	if IsControlPressed(1, 246) then
																		local msg = "You paid the full price of $"..displayVehicle.Price
																		exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
																		TriggerServerEvent('CarDealer.BuyCar', 0, k, Index, available_garage, 0)
																		lockBuyingCar = false
																		break
																	end
																	
																	if IsControlPressed(1, 182) then
																		local CashDown = tonumber(KeyboardInput("Would you like to put more cash down? If so enter it now:", "0", 11))
																		local msg = "You have accepted to finance the car."
																		exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
																		TriggerServerEvent('CarDealer.BuyCar', 1, k, Index, available_garage, CashDown)
																		lockBuyingCar = false
																		break
																	end

																	if IsControlPressed(1, 301) then
																		local msg = "You refused the offer."
																		exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
																		lockBuyingCar = false
																		break
																	end
																end
															end
														end)
													end
												else
													Notify("You do not have any room in your garage!", 3100)
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

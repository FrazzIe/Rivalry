local Data = {
	Service = vector3(),
	DisplayMenu = vector3(),
	DisplayVehicleSpawns = {
		[1] = {coords = vector3(), occupied = false},
		[2] = {coords = vector3(), occupied = false},
		[3] = {coords = vector3(), occupied = false},
	}
	DisplayVehicleRotation = ,
}

CarDealer = {}
CarDealer.IsDealer = false
CarDealer.OnDuty = false

local DisplayVehicle = nil
local OwnedVehicles = {}

RegisterNetEvent("CarDealer:Set")
AddEventHandler("CarDealer:Set", function(_Data, _CarDealer, first)
	CarDealer.IsDealer = _CarDealer

	if not CarDealer.IsDealer then
		CarDealer.OnDuty = false
	end
end)

RegisterNetEvent("DisplayVehicles.Sync")
AddEventHandler("DisplayVehicles.Sync", function(Table)
	DisplayedVehicles = Table
end)

RegisterNetEvent("Open.KeyMenu")
AddEventHandler("Open.KeyMenu", function(Vehicles)
	OwnedVehicles = Vehicles
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CarDealer.IsDealer then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(PlayerPosition - Data.Service) <= 1.0 then
				if CarDealer.OnDuty then
					DisplayHelpText("Press ~INPUT_CONTEXT to sign off duty!")
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
		if CarDealer.OnDuty and CarDealer.IsDealer then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player)
			if #(PlayerPosition - Data.DisplayMenu) <= 1.0 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to view avaliable display vehicles!")
				if IsControlJustPressed(1, 51) then
					if not WarMenu.IsMenuOpened("DisplayCars") then
						if not WarMenu.DoesMenuExist("DisplayCars") then
							WarMenu.CreateMenu("DisplayCars", "Car Showcase")
							WarMenu.SetSpriteTitle("DisplayCars", "")
							WarMenu.SetSubTitle("DisplayCars", "CATEGORIES")
							WarMenu.SetMenuX("DisplayCars", 0.6)
							WarMenu.SetMenuY("DisplayCars", 0.15)
							WarMenu.SetTitleBackgroundColor("DisplayCars", 0, 107, 87)
							WarMenu.OpenMenu("DisplayCars")
						else
							currentItemIndex = 1
							WarMenu.OpenMenu("DisplayCars")
						end
					else
						WarMenu.CloseMenu()
					end
					if WarMenu.IsMenuOpened("DisplayCars") then
                        for k,v in pairs(cars) do
                            if WarMenu.MenuButton(v.title, v.title) then
                                
                            end
                        end
                        WarMenu.Display()
                    end
					for k,v in pairs(cars) do
                        if WarMenu.IsMenuOpened(v.title) then
                            for i,j in pairs(v.vehicles) do
								if WarMenu.Button(j.name) then
									local Vehicle = CreateVehicle(x, y, z, 0, 0)
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
										model = j.model,
										name = j.name,
										instance = Vehicle,
										plate = GetVehicleNumberPlateText(Vehicle),
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
										fuel = DecorGetFloat(Vehicle, "_Fuel_Level")
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
									TriggerServerEvent("Spawn.DisplayVehicle", {Entity = Vehicle, Data = data})
									WarMenu.CloseMenu()
                                end
                            end
                            WarMenu.Display()
                        end
                    end
				end
			end
			if #DisplayedVehicles > 0 then
				for Index = 1, #DisplayedVehicles do
					local VehicleCoords = GetEntityCoords(DisplayVehicles[Index].Entity, false)
					if #(PlayerPosition - VehicleCoords) <= 2.0 and not IsPedInAnyVehicle(Player) then
						if IsControlJustPressed(1, 51) then
							-- Create Inputs here
							local Price = tonumber(KeyboardInput("Enter Total Price:", "100000", 11))
							local Weeks = tonumber(KeyboardInput("Enter Total Weeks:", "8", 1))
							local Intrest = tonumber(KeyboardInput("Enter Intrest Rate:", "10", 11))
							DisplayedVehicles[Index].Price = Price
							DisplayedVehicles[Index].Weeks = Weeks
							DisplayedVehicles[Index].Intrest = Intrest
							DisplayedVehicles[Index].DealerText = "[E] - Price: $"..DisplayedVehicles[Index].Price.." | Weeks: "..DisplayedVehicles[Index].Weeks.. " | Intrest: "..DisplayedVehicles[Index].Intrest.."%"
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
		if #DisplayedVehicles > 0 then
			for Index = 1, #DisplayedVehicles do
				if DisplayedVehicles[Index].Price > 0 and DisplayedVehicles[Index].Price ~= nil and DisplayedVehicles[Index].Weeks > 0 and DisplayedVehicles[Index].Weeks ~= nil and DisplayedVehicles[Index].Intrest > 0 and DisplayedVehicles[Index].Intrest ~= nil then
					local VehicleCoords = GetEntityCoords(DisplayVehicles[Index].Entity, false)
					if #(PlayerPosition - VehicleCoords) <= 10.0 then
						Draw3DText(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, DisplayedVehicles[Index].DealerText)
						if #(PlayerPosition - VehicleCoords) <= 2.0 and not IsPedInAnyVehicle(Player) then
							if IsControlJustPressed(1, 51) then
								if DisplayedVehicles[Index].Price > 0 and DisplayedVehicles[Index].Price ~= nil and DisplayedVehicles[Index].Weeks > 0 and DisplayedVehicles[Index].Weeks ~= nil and DisplayedVehicles[Index].Intrest > 0 and DisplayedVehicles[Index].Intrest ~= nil then
									Citizen.CreateThread(function()
										if(lockBuyingCar ~= true) then
											lockBuyingCar = true
											local notifReceivedAt = GetGameTimer()
											local msg = "Press <span style='color:lime'>B</span> to buy with cash, press <span style='color:red'>E</span> to lease it, or press <span style='color:red'>N</span> to refuse!"
											exports.pNotify:SendNotification({text = msg,type = "error",timeout = 30000,layout = "centerRight",queue = "left"})
											while(true) do
												Wait(0)
												
												if (GetTimeDifference(GetGameTimer(), notifReceivedAt) > 30000) then
													exports.pNotify:SendNotification({text = "The application for the fine has expired.",type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
													lockBuyingCar = false
													break
												end
												
												if IsControlPressed(1, 51) then
													TriggerServerEvent('bank:withdrawAmende', DisplayedVehicles[Index].Buy)
													local msg = "You paid the fine of $ ".. DisplayedVehicles[Index].Buy .."."
													exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
													TriggerServerEvent('CarDealer.BuyCar', 0, Index)
													lockBuyingCar = false
													break
												end
												
												if IsControlPressed(1, 7) then
													local msg = "You have accepted to lease the car."
													exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
													TriggerServerEvent('CarDealer.BuyCar', 1, Index)
													lockBuyingCar = false
													break
												end

												if IsControlPressed(1, 7) then
													local msg = "You refused the offer."
													exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
													lockBuyingCar = false
													break
												end
											end
										end
									end)
								end
							end
						end
					end
				end
			end
		end
	end
end)

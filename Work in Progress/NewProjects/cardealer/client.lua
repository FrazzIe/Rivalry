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

DisplayVehicle = nil

RegisterNetEvent("CarDealer.Set")
AddEventHandler("CarDealer.Set", function(_Data, _CarDealer, first)
	CarDealer.IsDealer = _CarDealer

	if not CarDealer.IsDealer then
		CarDealer.OnDuty = false
	end
end)

RegisterNetEvent("DisplayVehicles.Sync")
AddEventHandler("DisplayVehicles.Sync", function(Table)
	DisplayedVehicles = Table
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
					if WarMenu.IsMenuOpened("") then
						if WarMenu.Button("") then
							if WarMenu.OpenMenu("")
						end
					end
					if WarMenu.IsMenuOpened("") then
						if WarMenu.Button("") then
							if WarMenu.OpenMenu("")
						end
					end
				end
			end
			if #DisplayedVehicles > 0 then
				for Index = 1, #DisplayedVehicles do
					local VehicleCoords = GetEntityCoords(DisplayVehicles[Index].Entity, false)
					if #(PlayerPosition - VehicleCoords) <= 10.0 then
						Draw3DText(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, DisplayedVehicles[Index].DealerText)
						if #(PlayerPosition - VehicleCoords) <= 2.0 and not IsPedInAnyVehicle(Player) then
							if IsControlJustPressed(1, 51) then

							end
						end
					end
				end
			end

		end
	end
end)
local ChopShops = {
   	Locations = {
   		vector3(2351.8010253906,3133.4558105469,48.2087059021),
   		vector3(481.07803344727,-1317.2355957031,29.202587127686),
   	},
   	Blips = {
   		name = "Chopshop", 
   		sprite = 402, 
   		colour = 49, 
   	}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Ped = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Ped, 0)
		for Index = 1, #ChopShops.Locations do
			local Distance = #(PlayerPosition - ChopShops.Locations[Index])
			if Distance < 20 then
				drawMarker(25, ChopShops.Locations[Index].x, ChopShops.Locations[Index].y, ChopShops.Locations[Index].z, 3.0, 3.0, 3.5, 255, 255, 0, 255)
				if Distance < 2 then
					if IsPedSittingInAnyVehicle(Ped) then
						local Vehicle = GetVehiclePedIsIn(Ped, false)
						if GetPedInVehicleSeat(Vehicle, -1) == Ped then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to scrap this vehicle!")
							if IsControlJustPressed(1, 51) then
								local Owned = false
								local Rental = false
								-- Uncomment if you want player cars non-chopable! --
								for k,v in pairs(user_vehicles) do
									if v.plate == GetVehicleNumberPlateText(vehicle) then
										Owned = true
										break
									end
								end
								local Plate = GetVehicleNumberPlateText(Vehicle)
								if string.sub(Plate, 1, 2) == "RR" then
									Rental = true
								end
								if not Owned and not Rental then
									local Class = GetVehicleClass(Vehicle)
								    for Seat = -1, GetVehicleMaxNumberOfPassengers(Vehicle) do
								        if not IsVehicleSeatFree(Vehicle, Seat) then
								            TaskLeaveVehicle(GetPedInVehicleSeat(Vehicle, Seat), Vehicle, 0)
								        end
								    end
								    NetworkRequestControlOfEntity(Vehicle)
								    while not NetworkHasControlOfEntity(Vehicle) do
								        Citizen.Wait(0)
								    end
								    SetEntityAsMissionEntity(Vehicle, true, true)
								    while IsPedInAnyVehicle(PlayerPedId(), true) do
								        Citizen.Wait(0)
								    end
								    DestroyCar(Vehicle)
							    	if IsEntityDead(Vehicle) then
										TriggerServerEvent("ChopShop.Pay", Class)
									end
								else
									Notify("We don't accept that type of vehicle!", 3000)
								end
							end
						end
					end
				end
			end
		end
	end
end)
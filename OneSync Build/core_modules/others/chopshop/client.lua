local ChopShops = {
   	Locations = {
   		vector3(2351.8010253906,3133.4558105469,48.2087059021),
   		vector3(481.07803344727,-1317.2355957031,29.202587127686),
   	},
   	Blips = {
   		name = "Chopshop", 
   		sprite = 402, 
   		colour = 49, 
	},
	ObjectiveGiver = {
		vector3(472.31494140625,-1310.7248535156,29.220439910889),
	}   
}

Data = {
	CarList = {}
}

function IsCarListCar(Model)
	for Index = 1, #Data.CarList do
		if GetHashKey(Data.CarList[Index].Model:lower()) == Model then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Ped = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Ped, 0)
		for Index = 1, #ChopShops.Locations do
			if #(PlayerPosition - ChopShops.Locations[Index]) < 20 then
				RenderMarker(25, ChopShops.Locations[Index].x, ChopShops.Locations[Index].y, ChopShops.Locations[Index].z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if #(PlayerPosition - ChopShops.Locations[Index]) < 2 then
					if IsPedSittingInAnyVehicle(Ped) then
						local Vehicle = GetVehiclePedIsIn(Ped, false)
						if GetPedInVehicleSeat(Vehicle, -1) == Ped then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to scrap this vehicle!")
							if IsControlJustPressed(1, 51) then
								if #Data.CarList > 0 then
									local Owned = false
									local Rental = false
									for k,v in pairs(user_vehicles) do
										if v.plate == GetVehicleNumberPlateText(vehicle) then
											Owned = true
										end
									end
									local Plate = GetVehicleNumberPlateText(Vehicle)
									if string.sub(Plate, 1, 2) == "RR" then
										Rental = true
									end
									if not Owned and not Rental then
										local Model = GetEntityModel(Vehicle)
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
										if IsCarListCar(Model) then
											for Index = 1, #Data.CarList do
												if GetHashKey(Data.CarList[Index].Model:lower()) == Model then
													DestroyCar(Vehicle)
													if IsEntityDead(Vehicle) then
														TriggerServerEvent("ChopShop.Pay", Data.CarList[Index].Model)
													end
												end
											end
										else
											Notify("This car is not on the list!")
										end
									else
										Notify("We don't accept that type of vehicle!", 3000)
									end
								else
									Notify("I never gave you a list of vehicles!", 3100)
								end
							end
						end
					end
				end
			end
		end
		for Index = 1, #ChopShops.ObjectiveGiver do
			if #(PlayerPosition - ChopShops.ObjectiveGiver[Index]) <= 11.0 then
				if #(PlayerPosition - ChopShops.ObjectiveGiver[Index]) <= 1.1 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to recieve vehicle list!")
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("ChopShop.RecieveList")
					end
				end
			end
		end
	end
end)

RegisterNetEvent("ChopShop.RecieveList")
AddEventHandler("ChopShop.RecieveList", function(List)
	Data.CarList = List
end)


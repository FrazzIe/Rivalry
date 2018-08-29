local car_washes = {
	{name = "Car wash", sprite = 100, colour = 57, x = -699.79278564453, y = -933.81256103516, z = 19.013898849487},
	{name = "Car wash", sprite = 100, colour = 57, x = 27.134170532227, y = -1391.93359375, z = 29.362623214722},
	{name = "Car wash", sprite = 100, colour = 57, x = -74.021369934082, y = 6427.2153320313, z = 31.440073013306},
	{name = "Car wash", sprite = 100, colour = 57, x = 1983.6413574219, y = 3778.5671386719, z = 32.180778503418},
}

Citizen.CreateThread(function()
	for k,v in pairs(car_washes) do
		addBlip(v)
	end
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		for k,v in pairs(car_washes) do
			local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, v.x, v.y, v.z, true)
			if Distance < 20 then
				drawMarker(25, v.x, v.y, v.z, 2.0, 2.0, 2.5, 255, 255, 0, 255)
				if Distance < 2 then
					if IsPedSittingInAnyVehicle(PlayerPed) then
						local vehicle = GetVehiclePedIsIn(PlayerPed, false)
						if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
							if IsControlJustPressed(1, 51) then
								TriggerServerEvent("carwash:pay", vehicle)
							end
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("carwash:wash")
AddEventHandler("carwash:wash", function(_vehicle)
	SetVehicleDirtLevel(_vehicle, 0)
end)
local car_washes = {
	{name = "Car wash", sprite = 100, colour = 57, coords = vector3(-699.79278564453, -933.81256103516, 19.013898849487)},
	{name = "Car wash", sprite = 100, colour = 57, coords = vector3(27.134170532227, -1391.93359375, 29.362623214722)},
	{name = "Car wash", sprite = 100, colour = 57, coords = vector3(-74.021369934082, 6427.2153320313, 31.440073013306)},
	{name = "Car wash", sprite = 100, colour = 57, coords = vector3({1206.0718994141, 2639.423828125, 37.812465667725})},
}

Citizen.CreateThread(function()
	for k,item in pairs(car_washes) do
	    item.blip = AddBlipForCoord(item.coords.x, item.coords.y, item.coords.z)
	    SetBlipSprite(item.blip, item.sprite)
	    SetBlipColour(item.blip, item.colour)
	    SetBlipAsShortRange(item.blip, true)
	    SetBlipScale(item.blip, 0.6)
	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentString(item.name)
	    EndTextCommandSetBlipName(item.blip)
	end
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		for index = 1, #car_washes do
			local Distance = #(car_washes[index].coords - PlayerPosition)
			if Distance < 20 then
				drawMarker(25, car_washes[index].coords.x, car_washes[index].coords.y, car_washes[index].coords.z, 2.0, 2.0, 2.5, 255, 255, 0, 255)
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

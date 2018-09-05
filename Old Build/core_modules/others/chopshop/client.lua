local chopshops = {
    {name = "Chopshop", sprite = 402, colour = 49, x = 103.68435668945, y = 6622.658203125, z = 31.828517913818},
    {name = "Chopshop", sprite = 402, colour = 49, x = 481.07803344727, y = -1317.2355957031, z = 29.202587127686},
}

function DestroyVehicle(Handle)
	Citizen.CreateThread(function()
		local Handle = Handle
		local Start = GetGameTimer()
		for Seat = -1, GetVehicleMaxNumberOfPassengers(Handle) do
			if not IsVehicleSeatFree(Handle, Seat) then
				TaskLeaveVehicle(GetPedInVehicleSeat(Handle, Seat), Handle, 0)
			end
		end

		NetworkRequestControlOfEntity(Handle)

		while not NetworkHasControlOfEntity(Handle) and Start + 5000 > GetGameTimer() do
			Citizen.Wait(0)
		end

		DeleteVehicle(Handle)
		SetEntityAsNoLongerNeeded(Handle)
		
		if DoesEntityExist(Handle) then
			SetEntityCoords(Handle, 601.28948974609, -4396.9853515625, 384.98565673828)
		end
	end)
end

Citizen.CreateThread(function()
	for k,v in pairs(chopshops) do
		addBlip(v)
	end
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId(), false)
		for k,v in pairs(chopshops) do
			if Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 20 then
				drawMarker(25, v.x, v.y, v.z, 3.0, 3.0, 3.5, 255, 255, 0, 255)
				if Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2 then
					if IsPedSittingInAnyVehicle(PlayerPedId()) then
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
						if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to scrap this vehicle!")
							if IsControlJustPressed(1, 51) then
								local owned = false
								--[[for k,v in pairs(user_vehicles) do
									if v.plate == GetVehicleNumberPlateText(vehicle) then
										owned = true
										break
									end
								end--]]
								if not owned then
									local class = GetVehicleClass(vehicle)
								    for seat = -1, GetVehicleMaxNumberOfPassengers(vehicle) do
								        if not IsVehicleSeatFree(vehicle, seat) then
								            TaskLeaveVehicle(GetPedInVehicleSeat(vehicle, seat), vehicle, 0)
								        end
								    end
								    NetworkRequestControlOfEntity(vehicle)
								    while not NetworkHasControlOfEntity(vehicle) do
								        Citizen.Wait(0)
								    end
								    SetEntityAsMissionEntity(vehicle, true, true)
								    while IsPedInAnyVehicle(PlayerPedId(), true) do
								        Citizen.Wait(0)
								    end
								    DestroyVehicle(vehicle)
									TriggerServerEvent("chopshop:pay", class)
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
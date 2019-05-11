function Utilities:DestroyVehicle(Handle)
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
		SetEntityAsMissionEntity(Handle, false, true)
		SetEntityAsNoLongerNeeded(Handle)
		
		if DoesEntityExist(Handle) then
			SetEntityCoords(Handle, 601.28948974609, -4396.9853515625, 384.98565673828)
		end
	end)
end

function Utilities:DestroyObject(Handle)
	Citizen.CreateThread(function()
		local Handle = Handle
		local Start = GetGameTimer()

		NetworkRequestControlOfEntity(Handle)

		while not NetworkHasControlOfEntity(Handle) and Start + 5000 > GetGameTimer() do
			Citizen.Wait(0)
		end

		DeleteObject(Handle)
		SetEntityAsNoLongerNeeded(Handle)

		if DoesEntityExist(Handle) then
			SetEntityCoords(Handle, 601.28948974609, -4396.9853515625, 384.98565673828)
		end
	end)
end

function Utilities:DestroyPed(Handle)
	Citizen.CreateThread(function()
		local Handle = Handle
		local Start = GetGameTimer()

		NetworkRequestControlOfEntity(Handle)

		while not NetworkHasControlOfEntity(Handle) and Start + 5000 > GetGameTimer() do
			Citizen.Wait(0)
		end

		DeletePed(Handle)
		SetEntityAsNoLongerNeeded(Handle)

		if DoesEntityExist(Handle) then
			SetEntityCoords(Handle, 601.28948974609, -4396.9853515625, 384.98565673828)
		end
	end)
end
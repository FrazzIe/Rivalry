exports("GetSeatPedIsIn", function(vehicle, ped)
	local seats = GetVehicleMaxNumberOfPassengers(vehicle)
	for i = -1, seats - 1 do
		if GetPedInVehicleSeat(vehicle, i) == ped then
			return i
		end
	end
end)
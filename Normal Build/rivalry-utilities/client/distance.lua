function Utilities:GetPlayers()
	local Players = {}
	for Index = 0, 255 do
		if NetworkIsPlayerActive(Index) then
			table.insert(Players, Index)
		end
	end
	return Players
end

function Utilities:GetClosestVehicle(Position, Radius, Dead, Model, ExcludedVehicle)
	local Vehicles = {}
	local ClosestVehicle = {}

	for Vehicle in self:EnumerateVehicles() do
		if DoesEntityExist(Vehicle) then
			if (not Dead and true or IsEntityDead(Vehicle)) then
				if (not Model and true or IsVehicleModel(Vehicle, Model)) then
					if (not ExcludedVehicle and true or (Vehicle ~= ExcludedVehicle)) then
						local VehiclePosition = GetEntityCoords(Vehicle, false)
						local Distance = #(VehiclePosition - Position)

						if Distance <= Radius then
							table.insert(Vehicles, {Handle = Vehicle, Distance = Distance, Position = VehiclePosition})
						end
					end
				end
			end
		end
	end

	ClosestVehicle = Vehicles[1]

	for Index = 2, #Vehicles do
		if Vehicles[Index] then
			if ClosestVehicle.Distance > Vehicles[Index].Distance then
				ClosestVehicle = Vehicles[Index]
			end
		end
	end

	return ClosestVehicle
end

function Utilities:GetClosestPlayerVehicle(Position, Radius, Dead, Model, ExcludedVehicle)
	local Players = self:GetPlayers()
	local Vehicles = {}
	local ClosestVehicle = {}

	for Index = 1, #Players do
		local Vehicle = GetVehiclePedIsIn(GetPlayerPed(Players[Index]), false)
		if DoesEntityExist(Vehicle) then
			if (not Dead and true or IsEntityDead(Vehicle)) then
				if (not Model and true or IsVehicleModel(Vehicle, Model)) then
					if (not ExcludedVehicle and true or (Vehicle ~= ExcludedVehicle)) then
						local VehiclePosition = GetEntityCoords(Vehicle, false)
						local Distance = #(VehiclePosition - Position)

						if Distance <= Radius then
							table.insert(Vehicles, {Handle = Vehicle, Distance = Distance, Position = VehiclePosition, Player = GetPlayerServerId(Players[Index])})
						end
					end
				end
			end
		end
	end

	ClosestVehicle = Vehicles[1]

	for Index = 2, #Vehicles do
		if Vehicles[Index] then
			if ClosestVehicle.Distance > Vehicles[Index].Distance then
				ClosestVehicle = Vehicles[Index]
			end
		end
	end

	return ClosestVehicle
end

function Utilities:GetClosestPed(Position, Radius, Dead, Model, ExcludedPed)
	local Peds = {}
	local ClosestPed = {}

	for Ped in self:EnumeratePeds() do
		if DoesEntityExist(Ped) then
			if (not Dead and true or IsEntityDead(Ped)) then
				if (not Model and true or IsVehicleModel(Ped, Model)) then
					if (not ExcludedPed and true or (Ped ~= ExcludedPed)) then
						local PedPosition = GetEntityCoords(Ped, false)
						local Distance = #(PedPosition - Position)

						if Distance <= Radius then
							table.insert(Peds, {Handle = Ped, Distance = Distance, Position = PedPosition})
						end
					end
				end
			end
		end
	end

	ClosestPed = Peds[1]

	for Index = 2, #Peds do
		if Peds[Index] then
			if ClosestPed.Distance > Peds[Index].Distance then
				ClosestPed = Peds[Inddex]
			end
		end
	end

	return ClosestPed
end

function Utilities:GetClosestPlayerPed(Position, Radius, Dead, Model, ExcludedPed)
	local Players = self:GetPlayers()
	local Peds = {}
	local ClosestPed = {}

	for Index = 1, #Players do
		local Ped = GetPlayerPed(Players[Index])
		if DoesEntityExist(Ped) then
			if (not Dead and true or IsEntityDead(Ped)) then
				if (not Model and true or IsVehicleModel(Ped, Model)) then
					if (not ExcludedPed and true or (Ped ~= ExcludedPed)) then
						local PedPosition = GetEntityCoords(Ped, false)
						local Distance = #(PedPosition - Position)

						if Distance <= Radius then
							table.insert(Peds, {Handle = Ped, Distance = Distance, Position = PedPosition, Player = GetPlayerServerId(Players[Index])})
						end
					end
				end
			end
		end
	end

	ClosestPed = Peds[1]

	return ClosestPed
end

function Utilities:GetClosestObject(Position, Radius, Dead, Model, ExcludedObject)
	local Objects = {}
	local ClosestObject = {}

	for Object in self:EnumerateObjects() do
		if DoesEntityExist(Object) then
			if (not Dead and true or IsEntityDead(Object)) then
				if (not Model and true or (GetEntityModel(Object) == Model)) then
					if (not ExcludedObject and true or (Object ~= ExcludedObject)) then
						local ObjectPosition = GetEntityCoords(Object, false)
						local Distance = #(ObjectPosition - Position)

						if Distance <= Radius then
							table.insert(Objects, {Handle = Object, Distance = Distance, Position = ObjectPosition})
						end
					end
				end
			end
		end
	end

	ClosestObject = Objects[1]

	for Index = 2, #Objects do
		if Objects[Index] then
			if ClosestPed.Distance > Objects[Index].Distance then
				ClosestObject = Objects[Inddex]
			end
		end
	end

	return ClosestObject
end

function Utilities:GetClosestPickup(Position, Radius, Dead, ExcludedPickup)
	local Pickups = {}
	local ClosestPickup = {}

	for Pickup in self:EnumeratePickups() do
		if DoesEntityExist(Pickup) then
			if (not Dead and true or IsEntityDead(Pickup)) then
				if (not ExcludedPickup and true or (Pickup ~= ExcludedPickup)) then
					local PickupPosition = GetEntityCoords(Pickup, false)
					local Distance = #(PickupPosition - Position)

					if Distance <= Radius then
						table.insert(Pickups, {Handle = Pickup, Distance = Distance, Position = PickupPosition})
					end
				end
			end
		end
	end

	ClosestPickup = Pickups[1]

	for Index = 2, #Pickups do
		if Pickups[Index] then
			if ClosestPed.Distance > Pickups[Index].Distance then
				ClosestPickup = Pickups[Inddex]
			end
		end
	end

	return ClosestPickup
end

function Utilities:GetNearbyVehicles(Position, Radius, Dead, Model, ExcludedVehicle)
	local Vehicles = {}

	for Vehicle in self:EnumerateVehicles() do
		if DoesEntityExist(Vehicle) then
			if (not Dead and true or IsEntityDead(Vehicle)) then
				if (not Model and true or IsVehicleModel(Vehicle, Model)) then
					if (not ExcludedVehicle and true or (Vehicle ~= ExcludedVehicle)) then
						local VehiclePosition = GetEntityCoords(Vehicle, false)
						local Distance = #(VehiclePosition - Position)

						if Distance <= Radius then
							table.insert(Vehicles, {Handle = Vehicle, Distance = Distance, Position = VehiclePosition})
						end
					end
				end
			end
		end
	end

	return Vehicles
end

function Utilities:GetNearbyPlayerVehicles(Position, Radius, Dead, Model, ExcludedVehicle)
	local Players = self:GetPlayers()
	local Vehicles = {}

	for Index = 1, #Players do
		local Vehicle = GetVehiclePedIsIn(GetPlayerPed(Players[Index]), false)
		if DoesEntityExist(Vehicle) then
			if (not Dead and true or IsEntityDead(Vehicle)) then
				if (not Model and true or IsVehicleModel(Vehicle, Model)) then
					if (not ExcludedVehicle and true or (Vehicle ~= ExcludedVehicle)) then
						local VehiclePosition = GetEntityCoords(Vehicle, false)
						local Distance = #(VehiclePosition - Position)

						if Distance <= Radius then
							table.insert(Vehicles, {Handle = Vehicle, Distance = Distance, Position = VehiclePosition, Player = GetPlayerServerId(Players[Index])})
						end
					end
				end
			end
		end
	end

	return Vehicles
end

function Utilities:GetNearbyPeds(Position, Radius, Dead, Model, ExcludedPed)
	local Peds = {}

	for Ped in self:EnumeratePeds() do
		if DoesEntityExist(Ped) then
			if (not Dead and true or IsEntityDead(Ped)) then
				if (not Model and true or IsVehicleModel(Ped, Model)) then
					if (not ExcludedPed and true or (Ped ~= ExcludedPed)) then
						local PedPosition = GetEntityCoords(Ped, false)
						local Distance = #(PedPosition - Position)

						if Distance <= Radius then
							table.insert(Peds, {Handle = Ped, Distance = Distance, Position = PedPosition})
						end
					end
				end
			end
		end
	end

	return Peds
end

function Utilities:GetNearbyPlayerPeds(Position, Radius, Dead, Model, ExcludedPed)
	local Players = self:GetPlayers()
	local Peds = {}

	for Index = 1, #Players do
		local Ped = GetPlayerPed(Players[Index])
		if DoesEntityExist(Ped) then
			if (not Dead and true or IsEntityDead(Ped)) then
				if (not Model and true or IsVehicleModel(Ped, Model)) then
					if (not ExcludedPed and true or (Ped ~= ExcludedPed)) then
						local PedPosition = GetEntityCoords(Ped, false)
						local Distance = #(PedPosition - Position)

						if Distance <= Radius then
							table.insert(Peds, {Handle = Ped, Distance = Distance, Position = PedPosition, Player = GetPlayerServerId(Players[Index])})
						end
					end
				end
			end
		end
	end

	return Peds
end

function Utilities:GetNearbyObjects(Position, Radius, Dead, Model, ExcludedObject)
	local Objects = {}

	for Object in self:EnumerateObjects() do
		if DoesEntityExist(Object) then
			if (not Dead and true or IsEntityDead(Object)) then
				if (not Model and true or (GetEntityModel(Object) == Model)) then
					if (not ExcludedObject and true or (Object ~= ExcludedObject)) then
						local ObjectPosition = GetEntityCoords(Object, false)
						local Distance = #(ObjectPosition - Position)

						if Distance <= Radius then
							table.insert(Objects, {Handle = Object, Distance = Distance, Position = ObjectPosition})
						end
					end
				end
			end
		end
	end

	return Objects
end

function Utilities:GetNearbyPickups(Position, Radius, Dead, Model, ExcludedPickup)
	local Pickups = {}

	for Pickup in self:EnumeratePickups() do
		if DoesEntityExist(Pickup) then
			if (not Dead and true or IsEntityDead(Pickup)) then
				if (not ExcludedPickup and true or (Pickup ~= ExcludedPickup)) then
					local PickupPosition = GetEntityCoords(Pickup, false)
					local Distance = #(PickupPosition - Position)

					if Distance <= Radius then
						table.insert(Pickups, {Handle = Pickup, Distance = Distance, Position = PickupPosition})
					end
				end
			end
		end
	end

	return Pickups
end
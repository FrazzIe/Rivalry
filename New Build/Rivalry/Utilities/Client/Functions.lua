local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
	
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
	
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
	
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function GetPlayers()
	local Players = {}
	for Index = 0, 31 do
		if NetworkIsPlayerActive(Index) then
			table.insert(Players, Index)
		end
	end
	return Players
end

function GetNearestVehicleAtCoords(X, Y, Z, Radius, Alive, ExcludePlayer)
	local NearestVehicles = {}
	local NearestVehicle = {Handle = nil, Position = nil}
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		if tonumber(Radius) then
			for Vehicle in EnumerateVehicles() do
				if DoesEntityExist(Vehicle) and not (Alive and false or IsEntityDead(Vehicle)) and not (ExcludePlayer and false or (Vehicle == Player.Vehicle.Current)) then
					local VehiclePosition = GetEntityCoords(Vehicle, false)
					if Vdist(X, Y, Z, VehiclePosition.x, VehiclePosition.y, VehiclePosition.z) <= Radius then
						table.insert(NearestVehicles, {Handle = Vehicle, Position = VehiclePosition})
					end
				end
			end

			for Index = 1, #NearestVehicles, 1 do
				if NearestVehicles[Index] then
					if Index == 1 then NearestVehicle = NearestVehicles[Index] end
					if Vdist(X, Y, Z, NearestVehicle.Position.x, NearestVehicle.Position.y, NearestVehicle.Position.z) > Vdist(X, Y, Z, NearestVehicles[Index].Position.x, NearestVehicles[Index].Position.y, NearestVehicles[Index].Position.z) then
						NearestVehicle = NearestVehicles[Index]
					end
				end
			end
		else
			Log.Warn("GetNearestVehicleAtCoords was given an invalid radius!")
		end
	else
		Log.Warn("GetNearestVehicleAtCoords was given invalid coordinates!")
	end
	return NearestVehicle.Handle, NearestVehicle.Position
end

function GetNearestPedAtCoords(X, Y, Z, Radius, Alive, ExcludePlayer)
	local NearestPeds = {}
	local NearestPed = {Handle = nil, Position = nil}
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		if tonumber(Radius) then
			for Ped in EnumeratePeds() do
				if DoesEntityExist(Ped) and not (Alive and false or IsEntityDead(Ped)) and not (ExcludePlayer and false or (Ped == Player.Ped)) then
					local PedPosition = GetEntityCoords(Ped, false)
					if Vdist(X, Y, Z, PedPosition.x, PedPosition.y, PedPosition.z) <= Radius then
						table.insert(NearestPeds, {Handle = Ped, Position = PedPosition})
					end
				end
			end

			for Index = 1, #NearestPeds, 1 do
				if NearestPeds[Index] then
					if Index == 1 then NearestPed = NearestPeds[Index] end
					if Vdist(X, Y, Z, NearestPed.Position.x, NearestPed.Position.y, NearestPed.Position.z) > Vdist(X, Y, Z, NearestPeds[Index].Position.x, NearestPeds[Index].Position.y, NearestPeds[Index].Position.z) then
						NearestPed = NearestPeds[Index]
					end
				end
			end
		else
			Log.Warn("GetNearestPedAtCoords was given an invalid radius!")
		end
	else
		Log.Warn("GetNearestPedAtCoords was given invalid coordinates!")
	end
	return NearestPed.Handle, NearestPed.Position
end

function GetNearestPlayerVehicleAtCoords(X, Y, Z, Radius, Alive, ExcludePlayer)
	local NearestVehicles = {}
	local NearestVehicle = {Player = nil, Ped = nil, Vehicle = nil, Position = nil}
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		if tonumber(Radius) then
			local Players = GetPlayers()
			for Index = 1, #Players do
				local TargetPed = GetPlayerPed(Players[Index])
				if DoesEntityExist(TargetPed) then
					local Vehicle = GetVehiclePedIsUsing(TargetPed)
					if DoesEntityExist(Vehicle) and not (Alive and false or IsEntityDead(Vehicle)) and not (ExcludePlayer and false or (Vehicle == Player.Vehicle.Current)) then
						local VehiclePosition = GetEntityCoords(Vehicle, false)
						if Vdist(X, Y, Z, VehiclePosition.x, VehiclePosition.y, VehiclePosition.z) <= Radius then
							table.insert(NearestVehicles, {Player = Players[Index], Ped = TargetPed, Vehicle = Vehicle, Position = VehiclePosition})
						end
					end
				end
			end

			for Index = 1, #NearestVehicles, 1 do
				if NearestVehicles[Index] then
					if Index == 1 then NearestVehicle = NearestVehicles[Index] end
					if Vdist(X, Y, Z, NearestVehicle.Position.x, NearestVehicle.Position.y, NearestVehicle.Position.z) > Vdist(X, Y, Z, NearestVehicles[Index].Position.x, NearestVehicles[Index].Position.y, NearestVehicles[Index].Position.z) then
						NearestVehicle = NearestVehicles[Index]
					end
				end
			end
		else
			Log.Warn("GetNearestPlayerVehicleAtCoords was given an invalid radius!")
		end
	else
		Log.Warn("GetNearestPlayerVehicleAtCoords was given invalid coordinates!")
	end
	return NearestVehicle.Player, NearestVehicle.Ped, NearestVehicle.Vehicle, NearestVehicle.Position
end

function GetNearestPlayerAtCoords(X, Y, Z, Radius, Alive, ExcludePlayer)
	local NearestPlayers = {}
	local NearestPlayer = {Player = nil, Ped = nil, Position = nil}
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		if tonumber(Radius) then
			local Players = GetPlayers()
			for Index = 1, #Players do
				local TargetPed = GetPlayerPed(Players[Index])
				if DoesEntityExist(TargetPed) and not (Alive and false or IsEntityDead(TargetPed)) and not (ExcludePlayer and false or (TargetPed == Player.Ped)) then
					local TargetPosition = GetEntityCoords(TargetPed, false)
					if Vdist(X, Y, Z, TargetPosition.x, TargetPosition.y, TargetPosition.z) <= Radius then
						table.insert(NearestPlayers, {Player = Players[Index], Ped = TargetPed, Position = TargetPosition})
					end					
				end
			end

			for Index = 1, #NearestPlayers, 1 do
				if NearestPlayers[Index] then
					if Index == 1 then NearestPlayer = NearestPlayers[Index] end
					if Vdist(X, Y, Z, NearestPlayer.Position.x, NearestPlayer.Position.y, NearestPlayer.Position.z) > Vdist(X, Y, Z, NearestPlayers[Index].Position.x, NearestPlayers[Index].Position.y, NearestPlayers[Index].Position.z) then
						NearestPlayer = NearestPlayers[Index]
					end
				end
			end
		else
			Log.Warn("GetNearestPlayer was given an invalid radius!")
		end
	else
		Log.Warn("GetNearestPlayerAtCoords was given invalid coordinates!")
	end
	return NearestPlayer.Player, NearestPlayer.Ped, NearestPlayer.Position
end

function GetNearbyObjects(X, Y, Z, Radius)
	local NearbyObjects = {}
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		if tonumber(Radius) then
			for Object in EnumerateObjects() do
				if DoesEntityExist(Object) then
					local ObjectPosition = GetEntityCoords(Object, false)
					if Vdist(X, Y, Z, ObjectPosition.x, ObjectPosition.y, ObjectPosition.z) <= Radius then
						table.insert(NearbyObjects, Object)
					end
				end
			end
		else
			Log.Warn("GetNearbyObjects was given an invalid radius!")
		end
	else
		Log.Warn("GetNearbyObjects was given invalid coordinates!")
	end
	return NearbyObjects
end

function GetNearbyPeds(X, Y, Z, Radius)
	local NearbyPeds = {}
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		if tonumber(Radius) then
			for Ped in EnumeratePeds() do
				if DoesEntityExist(Ped) then
					local PedPosition = GetEntityCoords(Ped, false)
					if Vdist(X, Y, Z, PedPosition.x, PedPosition.y, PedPosition.z) <= Radius then
						table.insert(NearbyPeds, Ped)
					end
				end
			end
		else
			Log.Warn("GetNearbyPeds was given an invalid radius!")
		end
	else
		Log.Warn("GetNearbyPeds was given invalid coordinates!")
	end
	return NearbyPeds
end

function GetNearbyVehicles(X, Y, Z, Radius)
	local NearbyVehicles = {}
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		if tonumber(Radius) then
			for Vehicle in EnumerateVehicles() do
				if DoesEntityExist(Vehicle) then
					local VehiclePosition = GetEntityCoords(Vehicle, false)
					if Vdist(X, Y, Z, VehiclePosition.x, VehiclePosition.y, VehiclePosition.z) <= Radius then
						table.insert(NearbyVehicles, Vehicle)
					end
				end
			end
		else
			Log.Warn("GetNearbyVehicles was given an invalid radius!")
		end
	else
		Log.Warn("GetNearbyVehicles was given invalid coordinates!")
	end
	return NearbyVehicles
end

function GetNearbyPickups(X, Y, Z, Radius)
	local NearbyPickups = {}
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		if tonumber(Radius) then
			for Pickup in EnumeratePickups() do
				if DoesEntityExist(Pickup) then
					local PickupPosition = GetEntityCoords(Vehicle, false)
					if Vdist(X, Y, Z, PickupPosition.x, PickupPosition.y, PickupPosition.z) <= Radius then
						table.insert(NearbyPickups, Pickup)
					end
				end
			end
		else
			Log.Warn("GetNearbyPickups was given an invalid radius!")
		end
	else
		Log.Warn("GetNearbyPickups was given invalid coordinates!")
	end
	return NearbyPickups
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLength	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end

function GetVehicleName(Model)
    local VehicleNameLabel = GetDisplayNameFromVehicleModel(Model)
    
    if DoesTextLabelExist(VehicleNameLabel) then
        return GetLabelText(VehicleNameLabel)
    end
    return GetLabelText("collision_1s44o03")
end

function CreatePlate(Vehicle)
	local Model = GetEntityModel(Vehicle)
	local Name = GetVehicleName(Model)
	local Plate = string.gsub(GetVehicleNumberPlateText(Vehicle), "%s*", "")
    local Class = GetLabelText("VEH_CLASS_"..GetVehicleClassFromName(Name))
    return string.upper(Name.."_"..Plate.."_"..Class)
end

function GetVehicleSeatPedIsIn(Vehicle, Ped)
    for Index = -1, GetVehicleMaxNumberOfPassengers(Vehicle) do
        if GetPedInVehicleSeat(Vehicle, Index) == Ped then
            return Index
        end
    end
    return nil
end

function GetRandomIntegerPercentage()
	return GetRandomIntInRange(0, 101)
end

function GetRandomFloatPercentage()
	return GetRandomFloatInRange(0, 101)
end

function TeleportPlayer(X, Y, Z, H)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
	    Citizen.CreateThread(function()
	        DoScreenFadeOut(1000)
	        while IsScreenFadingOut() do Citizen.Wait(0) end
	        NetworkFadeOutEntity(Player.Ped, true, false)
	        Citizen.Wait(1000)
	        SetEntityCoords(Player.Ped, X, Y, Z)
	        SetEntityHeading(Player.Ped, H or 90.0)
	        NetworkFadeInEntity(Player.Ped, 0)
	        Citizen.Wait(1000)
	        SimulatePlayerInputGait(Player.Id, 1.0, 100, 1.0, 1, 0)
	        DoScreenFadeIn(1000)
	        while IsScreenFadingIn() do Citizen.Wait(0) end
	    end)
	else
		Log.Warn("TeleportPlayer was given invalid coordinates!")
	end
end

function RenderMarker(Type, X, Y, Z, SX, SY, SZ, R, G, B, A, BobUpAndDown)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		DrawMarker(Type, X, Y, Z - 0.9, 0, 0, 0, 0, 0, 0, SX or 0, SY or 0, SZ or 0, R or 255, G or 255, B or 255, A or 255, BobUpAndDown or false, 0, 2, 0, 0, 0, 0)
	else
		Log.Warn("RenderMarker was given invalid coordinates!")
	end
end

function DisplayHelpText(Str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(Str or "")
	EndTextCommandDisplayHelp(0, 0, 0, -1)
end

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

function DestroyObject(Handle)
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

function DestroyPed(Handle)
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

function GetCoordsInfrontOfEntityWithDistance(Entity, Distance, Heading)
	if DoesEntityExist(Entity) then
		if tonumber(Distance) and tonumber(Heading) then
			local Coordinates = GetEntityCoords(Entity, false)
			local Head = (GetEntityHeading(Entity) + (Heading or 0.0)) * math.pi / 180.0
			return {x = Coordinates.x + Distance * math.sin(-1.0 * Head), y = Coordinates.y + Distance * math.cos(-1.0 * Head), z = Coordinates.z}
		else
			Log.Warn("GetCoordsInfrontOfEntityWithDistance - Invalid Distance or Heading")
		end
	else
		Log.Warn("GetCoordsInfrontOfEntityWithDistance - Entity doesn't exist.")
	end
end

function GetGroundZ(X, Y, Z)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		local _, GroundZ = GetGroundZFor_3dCoord(X + 0.0, Y + 0.0, Z + 0.0, Citizen.ReturnResultAnyway())
		return GroundZ
	else
		Log.Warn("GetGroundZ was given invalid coordinates!")
		return 0.0
	end
end

function UsingController()
	return not IsInputDisabled(2)
end

function Atan(Value)
	return Value / ( 1+ (Value * Value / (3 + (4 * Value * Value) / (5 + (9 * Value * Value) / (7 + (16 * Value * Value) / (9 + (25 * Value * Value) / (11 + (36 * Value * Value) / (13 + (49 * Value * Value) / (15 + (64 * Value * Value) / (17 + (81 * Value * Value)))))))))))
end

function Atan2(Y, X)
	local Product = 0

	if tonumber(Y) == nil or tonumber(X) == nil then
		return 0
	end

	if X == 0 and Y == 0 then 
		return 0
	end

	if X == 0 then
		Product = math.pi / 2
		if Y < 0 then 
			Product = Product * 3
		end
	else
		Product = Atan(Y/X)
		if X < 0 then
			Product = Product + math.pi
		end
	end
	return Product
end

function GetHeadingFromCoordinates(X1, Y1, X2, Y2)
	if tonumber(X1) and tonumber(Y1) and tonumber(X2) and tonumber(Y2) then
		local Heading = (Atan2(Y2 - Y1, X2 - X1) * 360) / (2*math.pi)
		if Heading < 0 then
			Heading = Heading + 360
		end
		return Heading
	else
		Log.Warn("GetHeadingFromCoordinates was given invalid parameters!")
		return 0.0
	end
end
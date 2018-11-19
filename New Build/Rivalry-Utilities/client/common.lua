function Utilities:DisplayKeyboard(TextEntry, ExampleText, MaxStringLength)
	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLength	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square

	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength) --Actually calls the Keyboard Input

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing

		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing

		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing

		return nil --Returns nil if the typing got aborted
	end
end

function Utilities:GetVehicleName(Model)
    local Name = GetDisplayNameFromVehicleModel(Model)
    
    if DoesTextLabelExist(Name) then
        return GetLabelText(Name)
    else
    	return GetLabelText("collision_1s44o03")
    end
end

function Utilities:CreatePlate(Vehicle)
	local Model = GetEntityModel(Vehicle)
	local Name = GetVehicleName(Model)
	local Plate = GetVehicleNumberPlateText(Vehicle)
    local Class = GetLabelText("VEH_CLASS_"..GetVehicleClass(Vehicle))

    return string.gsub(string.upper(Name.." "..Plate.." "..Class), "%s*", "")
end

function Utilities:GetPedVehicleSeat(Vehicle, Ped)
	if DoesEntityExist(Vehicle) and DoesEntityExist(Ped) then
	    for Index = -1, GetVehicleMaxNumberOfPassengers(Vehicle) do
	        if GetPedInVehicleSeat(Vehicle, Index) == Ped then
	            return Index
	        end
	    end
	end

    return nil
end

function Utilities:GetRandomIntegerPercentage()
	return GetRandomIntInRange(0, 101)
end

function Utilities:GetRandomFloatPercentage()
	return GetRandomFloatInRange(0, 101)
end

function Utilities:RenderMarker(MarkerType, Position, Direction, Colour, BobUpAndDown)
	DrawMarker(MarkerType, Position.x, Position.y, Position.z - 0.9, 0, 0, 0, 0, 0, 0, Direction.x, Direction.y, Direction.z, Colour[1], Colour[2], Colour[3], BobUpAndDown or false, 0, 2, 0, 0, 0, 0)
end

function Utilities:DisplayHelpText(Text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(Text or "")
	EndTextCommandDisplayHelp(0, 0, 0, -1)
end

function Utilities:GetCoordsInfrontOfEntityWithDistance(Entity, Distance, Heading)
	if DoesEntityExist(Entity) then
		local Coords = GetEntityCoords(Entity, false)
		local Head = (GetEntityHeading(Entity) + (Heading or 0)) * math.pi / 180.0

		return vector3(Coords.x + Distance * math.sin(-1.0 * Head), Coords.y + Distance * math.cos(-1.0 * Head), Coords.z)
	end
end

function Utilities:GetGroundZ(Position)
	return GetGroundZFor_3dCoord(Position.x, Position.y, Position.z)
end

function Utilities:UsingController()
	return not IsInputDisabled(2)
end

function Utilities:GetHeadingFromCoordinates(Position, Position2)
	local Heading = (math.atan(Position.y - Position2.y, Position2.x - Position.x) * 360) / (2 * math.pi)

	if Heading < 0 then
		Heading = Heading + 360
	end

	return Heading
end

function Utilities:GetVehicleAttachedToVehicle(AttachedVehicle)
	for Vehicle in Utilities:EnumerateVehicles() do
		if DoesEntityExist(Vehicle) then
			if GetEntityAttachedTo(Vehicle) == AttachedVehicle then
				return Vehicle
			end
		end
	end

	return 0
end
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
	return GetRandomFloatInRange(0.0, 101.0)
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
	for Vehicle in self:EnumerateVehicles() do
		if DoesEntityExist(Vehicle) then
			if GetEntityAttachedTo(Vehicle) == AttachedVehicle then
				return Vehicle
			end
		end
	end

	return 0
end

function Utilities:Blip(Data)
	local Blip = nil

	if not Data.Entity and not Data.Coords and not Data.Pickup then
		return nil
	end

	if Data.Entity then
		Blip = AddBlipForEntity(Data.Entity)
	elseif Data.Pickup then
		Blip = AddBlipForPickup(Data.Pickup)
	else
		Blip = AddBlipForCoord(Data.Coords.x, Data.Coords.y, Data.Coords.z)
	end

	if Data.Sprite then
		SetBlipSprite(Blip, Data.Sprite) --[[ Set the blip sprite ]]--
	end

	if Data.Colour then
		SetBlipColour(Blip, Data.Colour) --[[ Set the blip colour]]--
	end

	if Data.Alpha then
		SetBlipAlpha(Blip, Data.Alpha) --[[ Set the alpha of the blip colour]]--
	end

	if Data.Scale then
		SetBlipScale(Blip, Data.Scale) --[[ Set the blip size ]]--
	end

	if Data.ShortRange ~= nil then
		SetBlipAsShortRange(Blip, Data.ShortRange) --[[ True to only display the blip as 'short range', false to display the blip from a longer distance ]]--
	end

	if Data.Bright ~= nil then
		SetBlipBright(Blip, Data.Bright) --[[ Makes the blip brighter? maybe]]--
	end

	if Data.Category then
		SetBlipCategory(Blip, Data.Category) --[[ 1: No text on blip or distance 2: Text on blip 3: No text, just distance, 4+: No text on blip or distance]]--
	end

	if Data.Friendly == nil or Data.Friendly == false then
		if Data.Friend ~= nil then
			SetBlipFriend(Blip, Data.Friend) --[[ Displays a blue half circle on the right of the blip ]]--
		end

		if Data.Crew ~= nil then
			SetBlipCrew(Blip, Data.Crew) --[[ Displays a half circle on the left of the blip ]]--
		end

		if Data.Crew and Data.Colour2 then
			SetBlipSecondaryColour(Blip, Data.Colour2[1], Data.Colour2[2], Data.Colour2[3]) --[[ Sets the colour of the crew half circle]]--
		end
	else
		SetBlipFriendly(Blip, true) --[[ Gives the blip a full blue hightlight ]]--
	end

	if Data.Fade then
		SetBlipFade(Blip, Data.Fade[1], Data.Fade[2]) --[[ Fades the blip in preset intervals ]]--
	end

	if Data.Route ~= nil then
		SetBlipRoute(Blip, Data.Route) --[[ Shows a route from the player to the blip ]]--

		if Data.Route then
			if Data.RouteColour then
				SetBlipRouteColour(Blip, Data.RouteColour) --[[ Sets the colour of the route line ]]--
			end
		end
	end

	if Data.Cone ~= nil then
		SetBlipShowCone(Blip, Data.Cone) --[[ Not sure ]]--
	end

	if Data.Shrink ~= nil then
		SetBlipShrink(Blip, Data.Shrink) --[[ Blip shrinks when off the minimap ]]--
	end

	if Data.Heading ~= nil then
		ShowHeadingIndicatorOnBlip(Blip, Data.Heading) --[[ Shows an arrow on the blip indicating the header of a player ]]--
	end

	if Data.Number ~= nil then
		ShowNumberOnBlip(Blip, Data.Number) --[[ Shows a number on a blip ]]--
	end

	if Data.Tick ~= nil then
		ShowTickOnBlip(Blip, Data.Tick) --[[ Displays green tick on blip ]]--
	end

	if Data.Display then
		SetBlipDisplay(Blip, Data.Display) --[[ 8: Shows on radar, 3: Shows on main map, not radar (not selectable), 2: Shows on main map, radar, selectable ]]--
	end

	if Data.Text then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(Data.Text) --[[ Sets the blip text ]]--
		EndTextCommandSetBlipName(Blip)
	elseif Data.Label then
		SetBlipNameFromTextFile(Blip, Data.Label) --[[ Sets blip text to a LabelText String ]]--
	elseif Data.Player then
		SetBlipNameToPlayerName(Blip, Data.Player) --[[ Sets blip text to a players name ]]--
	end

	return Blip
end

function Utilities:GetVehicleInDirectionSphere(Entity, Coords, Offset)
	local RayHandle = StartShapeTestCapsule(Coords.x, Coords.y, Coords.z, Offset.x, Offset.y, Offset.z, 2.0, 2, Entity, 7)
	local _, _, _, _, Vehicle = GetShapeTestResult(RayHandle)
	
	return Vehicle
end
local Vehicle = nil
local Prop = nil

local PropPosition = vector3(0, 0, 0)
local PropRotation = vector3(0, 0, 0)

local VehicleModel = "flatbed3"
local PropModel = "inm_flatbed_base"

function DropBed()
	if not DoesEntityExist(Prop) then
		AttachBed()
	end

	local Distance = #(GetEntityCoords(Vehicle, false) - GetEntityCoords(Prop, false))

	if Distance >= 3.0 and Distance <= 4.0 then
		repeat
			PropPosition.y = PropPosition.y - 0.03
			AttachEntityToEntity(Prop, Vehicle, GetEntityBoneIndexByName(Vehicle, "misc_a"), 0.0, PropPosition.y, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
			Citizen.Wait(10)
		until PropPosition.y <= -4.5

		PropPosition.y = -4.5

		repeat
			PropRotation.x = PropRotation.x + 0.1
			PropPosition.z = PropPosition.z - 0.03

			AttachEntityToEntity(Prop, Vehicle, GetEntityBoneIndexByName(Vehicle, "misc_a"), 0.0, PropPosition.y, PropPosition.z, PropRotation.x * 4.3, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

			Citizen.Wait(20)
		until GetEntityHeightAboveGround(Prop) <= 0.5
	elseif Distance >= 7.0 and Distance <= 9.0 then
		if PropPosition.y == 0 then
			PropPosition = vector3(3.0, -4.5, 0.9299996)
		end

		repeat
			PropRotation.x = PropRotation.x - 0.1
			PropPosition.z = PropPosition.z + 0.03

			AttachEntityToEntity(Prop, Vehicle, GetEntityBoneIndexByName(Vehicle, "misc_a"), 0.0, PropPosition.y, PropPosition.z, PropRotation.x * 4.3, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

			Citizen.Wait(20)
		until PropRotation.x <= 0.1

		PropRotation.x = 0.0
		PropPosition.z = 0.0

		repeat
			PropPosition.y = PropPosition.y + 0.03

			AttachEntityToEntity(Prop, Vehicle, GetEntityBoneIndexByName(Vehicle, "misc_a"), 0.0, PropPosition.y, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

			Citizen.Wait(10)
		until PropPosition.y >= 0.1

		PropPosition.y = 0.0

		AttachEntityToEntity(Prop, Vehicle, GetEntityBoneIndexByName(Vehicle, "misc_a"), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
	end
end

function IsBedDropped(Vehicle)
	local Distance = #(GetEntityCoords(Vehicle, false) - GetEntityCoords(Prop, false))

	if Distance >= 7.0 and Distance <= 9.0 then
		return true
	else
		return false
	end
end

function AttachBed()
	PropRotation = vector3(0, 0, 0)
	PropPosition = vector3(0, 0, 0)

	if DoesEntityExist(Prop) then
		Utilities:DestroyObject(Prop)
	end

	RequestModel(PropModel)

	while not HasModelLoaded(PropModel) do
		Citizen.Wait(150)
	end

	Prop = CreateObject(PropModel, GetWorldPositionOfEntityBone(Vehicle, "misc_a"), true, false, false)

	AttachEntityToEntity(Prop, Vehicle, GetEntityBoneIndexByName(Vehicle, "misc_a"), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

	SetVehicleExtra(Vehicle, 1, false)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		if IsControlJustPressed(1, 51) then
			if DoesEntityExist(Vehicle) then
				Utilities:DestroyVehicle(Vehicle)
				Utilities:DestroyObject(Prop)
			else
				RequestModel(VehicleModel)
				while not HasModelLoaded(VehicleModel) do
					Citizen.Wait(150)
				end

 				Vehicle = CreateVehicle(VehicleModel, PlayerPosition, 90.0, true, false)
			end
		end

		if IsControlJustPressed(0, 73) then
			DropBed()
		end
	end
end)

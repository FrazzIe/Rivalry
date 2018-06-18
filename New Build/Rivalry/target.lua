local TargetEntity = nil
local TargetEntityCoords = nil
local TargetEntityWorldCoords = nil
local TargetEntityHeight = nil

function ApplyForce(Entity)
	local EntityCoords = GetEntityCoords(Entity, false)
	local Force = 500
	local DX, DY, DZ = EntityCoords.x - Player.Coordinates.x, EntityCoords.y - Player.Coordinates.y, EntityCoords.z - Player.Coordinates.z + 20.0
	local Distance = math.sqrt(DX * DX + DY * DY + DZ * DZ)
	local DistanceRate = (Force / Distance) * (1.04 ^ (1 - Distance))
	SetEntityHealth(Entity, 0)
	SetEntityHasGravity(Entity, false)
	if IsEntityAVehicle(Entity) then
		SetVehicleGravity(Entity, false)
	elseif IsEntityAPed(Entity) then
		SetPedGravity(Entity, false)
	end
	Citizen.Wait(100)
	ApplyForceToEntity(Entity, 1, DistanceRate * DX, DistanceRate * DY, DistanceRate * DZ + 50.0, 1.0, 0.0, 0.0, true, false, true, true, true)
end

function Push()
	if DoesEntityExist(TargetEntity) then
		if IsEntityAPed(TargetEntity) then
			local Vehicle = GetVehiclePedIsIn(TargetEntity, false)
			if DoesEntityExist(Vehicle) then
				TargetEntity = Vehicle
			end
		end
		ApplyForce(TargetEntity)
	end
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		--SetPlayerForcedAim(PlayerId(), false)
		--SetPlayerForceSkipAimIntro(PlayerId(), true)
		--SetPlayerSimulateAiming(PlayerId(), true)
		SetPlayerForcedAim(PlayerId(), true)
		if IsPlayerFreeAiming(PlayerId()) and not TargetLocked then
			local FoundEntity, Entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
			if FoundEntity then
				TargetEntity = Entity
			end
		end
		if DoesEntityExist(TargetEntity) then
			TargetEntityCoords = GetEntityCoords(TargetEntity, false)
			TargetEntityWorldCoords = GetOffsetFromEntityInWorldCoords(TargetEntity, 0.0, 0.0, 0.0)
			TargetEntityHeight = GetEntityHeight(TargetEntity, TargetEntityWorldCoords.x, TargetEntityWorldCoords.y, TargetEntityWorldCoords.z, true, true)
			RenderMarker(0, TargetEntityWorldCoords.x, TargetEntityWorldCoords.y, TargetEntityHeight + 1.5, 0.75, 0.75, 0.5, 255, 0, 0, 255, true)
		end
		if IsControlJustPressed(1, 51) then
			Push()
		end
	end
end)
local sentry_gun = nil

local targetPlayers = false
local targetVehicles = true
local target = 0
local rotation = 0

local timeout = 200
local timer = 0 
local weapon = "WEAPON_MG"

local function spawnSentry()
	Citizen.CreateThread(function()
		local model = "p_rcss_folded"
		RequestModel(GetHashKey(model))
		while not HasModelLoaded(GetHashKey(model)) do
			Citizen.Wait(0)
		end
		sentry_gun = CreateObject(GetHashKey(model), GetEntityCoords(PlayerPedId(), false), true, true, false)
		ObjToNet(sentry_gun)
	end)
end

local function GetHeadingFromCoords(_source, _target)
	return ATAN2((_target.y - _source.y), (_target.x - _source.x))
end

local function sentryAimDraw()
	if DoesEntityExist(sentry_gun) then
		if targetPlayers then
			target = GetNearestPlayerToEntity(sentry_gun)
		elseif targetVehicles then
			local pos = GetEntityCoords(sentry_gun, false)
			target = GetClosestVehicle(pos.x, pos.y, pos.z, 50.0, 0, 70)
		end
		if DoesEntityExist(target) then
			local world_pos = GetOffsetFromEntityInWorldCoords(sentry_gun, 0, -0.2, 0.57)
			local target_pos = GetEntityCoords(target, false)
			DrawLine(world_pos.x, world_pos.y, world_pos.z, target_pos.x, target_pos.y, target_pos.z, 255, 0, 0, 255)
			rotation = GetHeadingFromCoords(GetEntityCoords(sentry_gun, false), GetEntityCoords(target, false)) * 100
			print(rotation)
			local sentry_rot = GetEntityRotation(sentry_gun, 2, 1)
			SetEntityRotation(sentry_gun, sentry_rot.x, sentry_rot.y, rotation, 2, 1)
		end
	end
end

local function sentryFire()
	if timer <= GetGameTimer() then
		timer = GetGameTimer() + timeout
		if DoesEntityExist(sentry_gun) and DoesEntityExist(target) then
			ShootSingleBulletBetweenCoords(GetOffsetFromEntityInWorldCoords(sentry_gun, 0.0, -0.8, 0.6), GetEntityCoords(target, false), 250, 0, GetHashKey(weapon), PlayerPedId(), 1, 1, 0xBF800000)
		end
	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 51) then
			if DoesEntityExist(sentry_gun) then
				DeleteEntity(sentry_gun)
				sentry_gun = nil
			else
				spawnSentry()
			end
		end
		sentryAimDraw()
		sentryFire()
	end
end)
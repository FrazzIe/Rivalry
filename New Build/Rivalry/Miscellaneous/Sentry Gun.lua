local Sentry = {
	Spawned = false,
	Handle = nil,
	Model = "p_rcss_folded",
	Weapon = "WEAPON_RAILGUN",
	Range = 50.0,
	Find = false,
	Target = {
		Handle = nil,
		Position = nil,
	},
	Position = {
		Normal = nil,
		BulletOffset = nil,
		LineOffset = nil
	},
}

function Sentry.Create()
	if not Sentry.Spawning and not Sentry.Spawned then
		Sentry.Spawning = true
		local Model = GetHashKey(Sentry.Model)

		RequestModel(Model)
		while not HasModelLoaded(Model) do
			Citizen.Wait(250)
		end

		Sentry.Handle = CreateObject(Model, Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, true, false)

		FreezeEntityPosition(Sentry.Handle, true)
		PlaceObjectOnGroundProperly(Sentry.Handle)

		Sentry.Position.Normal = GetEntityCoords(Sentry.Handle, false)
		Sentry.Spawned = true
		Sentry.Find = true
		Sentry.Spawning = false
	end
end

function Sentry.Destroy()
	if not Sentry.Deleting and Sentry.Spawned then
		Sentry.Deleting = true
		
		DestroyObject(Sentry.Handle)
		
		Sentry.Handle = nil
		Sentry.Find = true
		Sentry.Spawned = false
		Sentry.Deleting = false
	end
end

function Sentry.Locate()
	Sentry.Find = false

	local NearestVehicle, NearestVehiclePosition = GetNearestVehicleAtCoords(Sentry.Position.Normal.x, Sentry.Position.Normal.y, Sentry.Position.Normal.z, Sentry.Range, true, true)
	local NearestPed, NearestPedPosition = GetNearestPedAtCoords(Sentry.Position.Normal.x, Sentry.Position.Normal.y, Sentry.Position.Normal.z, Sentry.Range, true, true)

	if NearestVehicle and NearestPed then
		if Vdist(NearestVehiclePosition.x, NearestVehiclePosition.y, NearestVehiclePosition.z) < Vdist(NearestPedPosition.x, NearestPedPosition.y, NearestPedPosition.z) then
			Sentry.Target.Handle = NearestVehicle
		else
			Sentry.Target.Handle = NearestPed
		end
	elseif NearestVehicle then
		Sentry.Target.Handle = NearestVehicle
	elseif NearestPed then
		Sentry.Target.Handle = NearestPed
	else
		Sentry.Find = true
	end
end

function Sentry.Aim()
	Sentry.Position.BulletOffset = GetOffsetFromEntityInWorldCoords(Sentry.Handle, 0.0, -0.8, 0.6)
	Sentry.Position.LineOffset = GetOffsetFromEntityInWorldCoords(Sentry.Handle, 0, -0.2, 0.57)

	if DoesEntityExist(Sentry.Target.Handle) and not IsEntityDead(Sentry.Target.Handle) then
		Sentry.Target.Position = GetEntityCoords(Sentry.Target.Handle, false)
		DrawLine(Sentry.Position.LineOffset.x, Sentry.Position.LineOffset.y, Sentry.Position.LineOffset.z, Sentry.Target.Position.x, Sentry.Target.Position.y, Sentry.Target.Position.z, 255, 0, 0, 255)
		SetEntityHeading(Sentry.Handle, GetHeadingFromCoordinates(Sentry.Position.Normal.x, Sentry.Position.Normal.y, Sentry.Target.Position.x, Sentry.Target.Position.y) + 90)
	else
		Sentry.Find = true
	end
end

function Sentry.Fire()
	if DoesEntityExist(Sentry.Target.Handle) and not IsEntityDead(Sentry.Target.Handle) and GetDistanceBetweenCoords(Sentry.Position.Normal.x, Sentry.Position.Normal.y, Sentry.Position.Normal.z, Sentry.Target.Position.x, Sentry.Target.Position.y, Sentry.Target.Position.z, true) <= Sentry.Range and HasEntityClearLosToEntity(Sentry.Handle, Sentry.Target.Handle, 17) then
		ShootSingleBulletBetweenCoords(Sentry.Position.BulletOffset.x, Sentry.Position.BulletOffset.y, Sentry.Position.BulletOffset.z, Sentry.Target.Position.x, Sentry.Target.Position.y, Sentry.Target.Position.z, 250, 0, GetHashKey(Sentry.Weapon), Player.Ped, true, false, 0xBF800000)
	else
		Sentry.Find = true
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Sentry.Spawned then
			if Sentry.Find then Sentry.Locate() end
			Sentry.Aim()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Sentry.Spawned then
			Citizen.Wait(200)
			Sentry.Fire()
		end
	end
end)
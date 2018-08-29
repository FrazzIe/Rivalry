local Deer = {
	Handle = nil,
	Speed = {
		Walk = 2.0,
		Run = 10.0,
	},
	Sit = {
		Dictionary = "rcmjosh2",
		Animation = "josh_sitting_loop",
	},
}

function IsAnyPlayerAttachedToEntity(Entity)
	local Players = GetPlayers()
	for i = 1, #Players do
		local PlayerPed = GetPlayerPed(Players[i])
		if DoesEntityExist(PlayerPed) then
			if GetEntityAttachedTo(PlayerPed) == Entity then
				return true
			end
		end
	end
	return false
end

function Deer.Destroy()
	local PlayerPed = PlayerPedId()

	DetachEntity(PlayerPed, true, false)
	ClearPedTasksImmediately(PlayerPed)

	DestroyPed(Deer.Handle)
	Deer.Handle = nil
end

function Deer.Create()
	local PlayerPed = PlayerPedId()
	local PedPosition = GetEntityCoords(PlayerPed, false)

	local Model = GetHashKey("a_c_deer")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(50)
	end

	Deer.Handle = CreatePed(28, Model, PedPosition.x, PedPosition.y, PedPosition.z, GetEntityHeading(PlayerPed), true, false)

	SetPedCanRagdoll(Deer.Handle, false)

	SetModelAsNoLongerNeeded(Model)
end

function Deer.Attach()
	local PlayerPed = PlayerPedId()

	FreezeEntityPosition(Deer.Handle, true)
	FreezeEntityPosition(PlayerPed, true)

	local DeerPosition = GetEntityCoords(Deer.Handle, false)
	SetEntityCoords(PlayerPed, DeerPosition.x, DeerPosition.y, DeerPosition.z)

	AttachEntityToEntity(PlayerPed, Deer.Handle, GetPedBoneIndex(Deer.Handle, 24816), -0.3, 0.0, 0.3, 0.0, 0.0, 90.0, false, false, false, true, 2, true)

	TaskPlayAnim(PlayerPed, Deer.Sit.Dictionary, Deer.Sit.Animation, 8.0, 1, -1, 2, 1.0, 0, 0, 0)

	FreezeEntityPosition(Deer.Handle, false)
	FreezeEntityPosition(PlayerPed, false)
end

function Deer.Detach(AttachedEntity)
	local PlayerPed = PlayerPedId()
	local SideCoordinates = GetCoordsInfrontOfEntityWithDistance(AttachedEntity, 1.0, 90.0)
	local SideHeading = GetEntityHeading(AttachedEntity)

	SideCoordinates.z = GetGroundZ(SideCoordinates.x, SideCoordinates.y, SideCoordinates.z)

	Deer.Handle = nil
	DetachEntity(PlayerPed, true, false)
	ClearPedTasksImmediately(PlayerPed)

	SetEntityCoords(PlayerPed, SideCoordinates.x, SideCoordinates.y, SideCoordinates.z)
	SetEntityHeading(PlayerPed, SideHeading)
end

function Deer.Ride()
	local PlayerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(PlayerPed) or IsPedGettingIntoAVehicle(PlayerPed) or IsEntityDead(PlayerPed) then
		return
	end

	local PedPosition = GetEntityCoords(PlayerPed, false)
	local AttachedEntity = GetEntityAttachedTo(PlayerPed)

	if IsEntityAttached(PlayerPed) and GetEntityModel(AttachedEntity) == GetHashKey("a_c_deer") then
		Deer.Detach(AttachedEntity)
	else
		for _, Ped in pairs(GetNearbyPeds(PedPosition.x, PedPosition.y, PedPosition.z, 2.0)) do
			if GetEntityModel(Ped) == GetHashKey("a_c_deer") then
				if not IsEntityDead(Ped) and not IsAnyPlayerAttachedToEntity(Ped) then
					Deer.Handle = Ped
					Deer.Attach()
					break
				end
			end
		end
	end
end

Citizen.CreateThread(function()
	RequestAnimDict(Deer.Sit.Dictionary)
	while not HasAnimDictLoaded(Deer.Sit.Dictionary) do
		Citizen.Wait(250)
	end
	while true do
		Citizen.Wait(0)

		if IsControlJustPressed(1, 51) then
			Deer.Ride()
		end

		local PlayerPed = PlayerPedId()
		local AttachedEntity = GetEntityAttachedTo(PlayerPed)

		if (not IsPedSittingInAnyVehicle(PlayerPed) or not IsPedGettingIntoAVehicle(PlayerPed)) and IsEntityAttached(PlayerPed) and AttachedEntity == Deer.Handle then
			if DoesEntityExist(Deer.Handle) and not IsEntityDead(Deer.Handle) and not IsEntityDead(PlayerPed) then

				if not IsEntityPlayingAnim(PlayerPed, Deer.Sit.Dictionary, Deer.Sit.Animation, 3) then
					TaskPlayAnim(PlayerPed, Deer.Sit.Dictionary, Deer.Sit.Animation, 8.0, 1, -1, 2, 1.0, 0, 0, 0)
				end
				
				local LeftAxisXNormal, LeftAxisYNormal = GetControlNormal(2, 218), GetControlNormal(2, 219)
				local Speed, Range = Deer.Speed.Walk, 4.0

				if IsControlPressed(0, 21) then
					Speed = Deer.Speed.Run
					Range = 8.0
				end

				local GoToOffset = GetOffsetFromEntityInWorldCoords(Deer.Handle, LeftAxisXNormal * Range, LeftAxisYNormal * -1.0 * Range, 0.0)

				TaskLookAtCoord(Deer.Handle, GoToOffset.x, GoToOffset.y, GoToOffset.z, 0, 0, 2)
				TaskGoStraightToCoord(Deer.Handle, GoToOffset.x, GoToOffset.y, GoToOffset.z, Speed, 20000, 40000.0, 0.5)
			else
				Deer.Detach(AttachedEntity)
			end
		end
	end
end)
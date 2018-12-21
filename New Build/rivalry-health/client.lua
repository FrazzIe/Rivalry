function Health:BodyPart(id)
	for BodyPart, Bones in pairs(self.Body) do
		for Bone, Value in pairs(Bones) do
			if id == Value then
				return BodyPart
			end
		end
	end

	return nil
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		local PlayerHealth = GetEntityHealth(PlayerPed)

		if Health.Player.Ped ~= PlayerPed then
			Health.Player.Ped = PlayerPed
			Health.Player.Health = PlayerHealth
		end 

		if not IsEntityDead(PlayerPed) then
			if Health.Player.Health ~= PlayerHealth then
				local _, DamagedBone = GetPedLastDamageBone(PlayerPed)
				local DamagedBodyPart = FindBodyPart(bone)
				local DamageTaken = PlayerHealth - Health.Player.Health

				for Index = 1, #Utilities.Data.Weapons do
					if HasPedBeenDamagedByWeapon(PlayerPed, Utilities:GetWeaponHash(Utilities.Data.Weapons[Index]), 0) then
						TriggerServerEvent("Health.Injury.Add", DamagedBodyPart, Utilities:GetWeaponLabel(Utilities.Data.Weapons[Index]), DamageTaken)

						ClearEntityLastDamageEntity(PlayerPed)
					end
				end
				
				Health.Player.Health = PlayerHealth
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsSessionStarted() then
			Health.Player.Id = GetPlayerServerId(PlayerId())
			return
		end
	end
end)

RegisterNetEvent("Health.Sync")
AddEventHandler("Health.Sync", function(Injuries)
	Health.Injuries = Injuries
end)

RegisterCommand("injuries", function(source, args, fullCommand)
	SetNuiFocus(true, true)
	SendNUIMessage({["type"] = "DisplayInjuries", ["payload"] = {name = GetPlayerName(PlayerId()), injuries = Health.Injuries[Health.Player.Id] or {}}})
end, false)

RegisterNUICallback("close", function(data, cb)
	SetNuiFocus(false, false)
	cb("ok")
end)
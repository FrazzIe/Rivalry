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
				local DamagedBodyPart = Health:BodyPart(DamagedBone)
				local DamageTaken = Health.Player.Health - PlayerHealth

				for Index = 1, #Utilities.Data.Weapons.List do
					if HasPedBeenDamagedByWeapon(PlayerPed, Utilities:GetWeaponHash(Utilities.Data.Weapons.List[Index]), 0) then
						TriggerServerEvent("Health.Injury.Add", DamagedBodyPart, Utilities:GetWeaponLabel(Utilities.Data.Weapons.List[Index]), DamageTaken)
						TriggerEvent("Damage.StartBleeding", DamagedBodyPart, Utilities.Data.Weapons.List[Index], DamageTaken)
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
		Citizen.Wait(60000)
		local PlayerPed = PlayerPedId()
		local PlayerHealth = GetEntityHealth(PlayerPed)
		if PlayerHealth == GetEntityMaxHealth(PlayerPed) then
			TriggerServerEvent("Health.Injury.Reset")
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

RegisterNetEvent("Health.View")
AddEventHandler("Health.View", function(Name, Injuries)
	SetNuiFocus(true, true)
	SendNUIMessage({["type"] = "DisplayInjuries", ["payload"] = {name = Name, injuries = Injuries}})
end)

RegisterCommand("ci", function(source, args, fullCommand)
	local PlayerPed = PlayerPedId()
	local ClosestPlayer = Utilities:GetClosestPlayerPed(GetEntityCoords(PlayerPed, false), 3.0, false, false, PlayerPed)

	if ClosestPlayer.Player ~= nil and ClosestPlayer ~= nil then
		TriggerServerEvent("Health.Injury.Get", exports.core:GetCharacterName(ClosestPlayer.Player), ClosestPlayer.Player)
	else
		print("No player near you!")
	end
end, false)

RegisterCommand("mi", function(source, args, fullCommand)
	SetNuiFocus(true, true)
	SendNUIMessage({["type"] = "DisplayInjuries", ["payload"] = {name = exports.core:GetCharacterName(GetPlayerServerId(PlayerId())), injuries = Health.Injuries or {}}})
end, false)

RegisterNUICallback("close", function(data, cb)
	SetNuiFocus(false, false)
	cb("ok")
end)
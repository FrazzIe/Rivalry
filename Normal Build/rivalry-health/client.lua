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
	TriggerServerEvent("Health.Injury.Get", exports.core:GetCharacterName(source), source)
end, false)

RegisterNUICallback("close", function(data, cb)
	SetNuiFocus(false, false)
	cb("ok")
end)
Player = {
	CurrentInstance = 0,
	Instanced = false,
	InstancedPlayers = {}
}
AllInstances = {}
InMotel = false

RegisterNetEvent("Storage.Open")
AddEventHandler("Storage.Open", function()

end)

ReigsterNetEvent("Motel.Enter")
AddEventHandler("Motel.Enter", function(Instance)
	if IsBuildingUnlocked(Instance) then
		DoScreenFadeIn(2000)
		Player.Instanced = true
		TriggerServerEvent("Properties.Motel.Sync", GetPlayerServerId(PlayerPedId()), {Player = PlayerPedId(), ServerId = GetPlayerServerId(PlayerPedId()), RoomInstance = Instance})
		TriggerServerEvent("Properties.Instance", true)
		NetworkSetVoiceChannel(Instance)
		SetEntityCoord(PlayerPedId(), Rivalry.Properties.Motel.InsideMotelDoor, 0.0, 0.0, 0.0, 0)
		SetEntityHeading(PlayerPedId(), Rivalry.Properties.Motel.InsideMotelHeading)
		DoScreenFadeOut(2000)
	end 
end)

RegisterNetEvent("Motel.Exit")
AddEventHandler("Motel.Exit", function()
	DoScreenFadeIn(2000)
	Player.Instanced = false
	Player.CurrentInstance = 0
	InMotel = false
	TriggerServerEvent("Properties.Motel.Sync", GetPlayerServerId(PlayerPedId()), {Player = PlayerPedId(), ServerId = GetPlayerServerId(PlayerPedId()), RoomInstance = Instance})
	NetworkClearVoiceChannel()
	SetEntityCoords(PlayerPedId(), Rivalry.Properties.Motel.OutsideMotelDoor, 0.0, 0.0, 0.0, 0)
	SetEntityHeading(PlayerPedId(), Rivalry.Properties.Motel.OutsideMotelHeading)
	DoScreenFadeOut(2000)
end)

RegisterNetEvent("Storage.Open")
AddEventHandler("Storage.Open", function(Result)

end)

RegisterNetEvent("Storage.Close")
AddEventHandler("Storage.Close", function()

end)

RegisterNetEvent("Properties.Instanced.Sync")
AddEventHandler("Properties.Instanced.Sync", function(InstancedPlayers)
	Player.InstancedPlayers = InstancedPlayers
end)

function IsInBuilding()
	local Player = GetPlayerServerId(PlayerPedId())
	for Index = 1, #AllInstances do
		if AllInstances[Index].ServerId = Player then
			if Player.CurrentInstance == AllInstances[Index].RoomInstance then
				return true
			end
		end
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		if #(PlayerPosition - Rivalry.Properties.Motel.Storage) < 1 then
			DisplayHelpText("Press ~INPUT_CONTEXT~ to open your storage!")
			if IsControlJustPressed(1, 51) then
				if Player.CurrentInstance > 0 then
					TriggerServerEvent("Storage.Open", GetPlayerServerId(Player), Player.CurrentInstance)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		if Player.Instanced then
			for Player = 0, 255 do
				if NetworkIsPlayerActive(Player) then
					local OtherPed = GetPlayerPed(Player)
					if OtherPed ~= PlayerPed and not IsInBuilding() then
						SetEntityVisible(OtherPed, false)
						SetEntityNoCollisionEntity(PlayerPed, OtherPed, true)
					else
						SetEntityVisible(PlayerPed, true)
					end
				end
			end
		else
			for PlayerServerId, _ in pairs(Player.InstancedPlayers) do
				local Player = GetPlayerFromServerId(PlayerServerId)
				if NetworkIsPlayerActive(Player) then
					local OtherPed = GetPlayerPed(Player)
					if OtherPed ~= PlayerPed and not IsInBuilding() then
						SetEntityVisible(OtherPed, false)
						SetEntityNoCollisionEntity(PlayerPed, OtherPed, true)
					else
						SetEntityVisible(PlayerPed, true)
					end
				end
			end
		end
	end
end)

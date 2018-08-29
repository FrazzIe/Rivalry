--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
isAdmin = false

Citizen.CreateThread(function()
	Citizen.Wait(20000)
	while true do
		Citizen.Wait(5000)
		if exports.core:GetGroup(GetPlayerServerId(PlayerId())) == "owner" or exports.core:GetGroup(GetPlayerServerId(PlayerId())) == "staff" then
			isAdmin = true
		else
			isAdmin = false
		end
	end
end)

local nv, wp, WaypointCoords, scale; RequestPTFX = true, entity

local function getGroundZ(x, y, z)
  local result, groundZ = GetGroundZFor_3dCoord(x + 0.0, y + 0.0, z + 0.0, Citizen.ReturnResultAnyway())
  return groundZ
end

Citizen.CreateThread(function() --Teleport To Waypoint
	local zHeigt = 0.0; height = 1000.0
	while true do
		Citizen.Wait(0)
		if isAdmin then
			if DoesBlipExist(GetFirstBlipInfoId(8)) then
				local blipIterator = GetBlipInfoIdIterator(8)
				local blip = GetFirstBlipInfoId(8, blipIterator)
				WaypointCoords = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector()) --Thanks To Briglair [forum.FiveM.net]
				wp = true
			end
			if wp and IsControlPressed(1, 303) then
				if IsPedInAnyVehicle(GetPlayerPed(-1), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)) then
					entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
				else
					entity = GetPlayerPed(-1)
				end

				SetEntityCoords(entity, WaypointCoords.x, WaypointCoords.y, height)
				local Pos = GetEntityCoords(entity, true)
		
				if zHeigt == 0.0 then
					height = height - 50.0
					SetEntityCoords(entity, Pos.x, Pos.y, height)
					zHeigt = getGroundZ(Pos.x, Pos.y, Pos.z)
				else
					SetEntityCoords(entity, Pos.x, Pos.y, zHeigt)
					FreezeEntityPosition(entity, false)
					wp = false
					height = 1000.0
					zHeigt = 0.0
				end
			end
		end
	end
end)

RegisterNetEvent("command:spawnvehicle")
AddEventHandler("command:spawnvehicle", function(_model, type)
	if type == "normal" or type == "upgrade" then
		local model = GetHashKey(_model)
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		local pos = GetEntityCoords(PlayerPedId(),false)
		local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 90, true, false)
		local id = NetworkGetNetworkIdFromEntity(vehicle)
		SetNetworkIdCanMigrate(id, true)
		SetNetworkIdExistsOnAllMachines(id, true)
		if type == "upgrade" then
			ClearVehicleCustomPrimaryColour(vehicle)
			ClearVehicleCustomSecondaryColour(vehicle)
			SetVehicleModKit(vehicle, 0)
			SetVehicleWheelType(vehicle, 7)
			for i = 0, 13 do
				SetVehicleMod(vehicle, i, GetNumVehicleMods(vehicle, i) - 1, false)
			end
			SetVehicleMod(vehicle, 14, 16, false)
			SetVehicleMod(vehicle, 15, GetNumVehicleMods(vehicle, 15) - 2, false)
			SetVehicleMod(vehicle, 16, GetNumVehicleMods(vehicle, 16) - 1, false)
			for i = 17, 22 do 
				ToggleVehicleMod(vehicle, i, true)
			end
			SetVehicleMod(vehicle, 23, 1, false)
			SetVehicleMod(vehicle, 24, 1, false)
			SetVehicleMod(vehicle, 25, GetNumVehicleMods(vehicle, 25) - 1, false)
			SetVehicleMod(vehicle, 27, GetNumVehicleMods(vehicle, 27) - 1, false)
			SetVehicleMod(vehicle, 28, GetNumVehicleMods(vehicle, 28) - 1, false)
			SetVehicleMod(vehicle, 30, GetNumVehicleMods(vehicle, 30) - 1, false)
			SetVehicleMod(vehicle, 33, GetNumVehicleMods(vehicle, 33) - 1, false)
			SetVehicleMod(vehicle, 34, GetNumVehicleMods(vehicle, 34) - 1, false)
			SetVehicleMod(vehicle, 35, GetNumVehicleMods(vehicle, 35) - 1, false)
			SetVehicleMod(vehicle, 38, GetNumVehicleMods(vehicle, 38) - 1, true)
			SetVehicleTyreSmokeColor(vehicle, 0, 0, 127)
			SetVehicleWindowTint(vehicle, 1)
			SetVehicleTyresCanBurst(vehicle, true)
			SetVehicleNumberPlateTextIndex(vehicle, 5)
			SetVehicleModColor_1(vehicle, 4, 12, 0)
			SetVehicleModColor_2(vehicle, 4, 12)
			SetVehicleColours(vehicle, 12, 12)
			SetVehicleExtraColours(vehicle, 70, 141)
		end
		SetModelAsNoLongerNeeded(model)
		SetVehicleDirtLevel(vehicle, 0)
		DecorSetBool(vehicle, "hotwire", true)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
	end
end,false)

RegisterNetEvent("command:spawnweapon")
AddEventHandler("command:spawnweapon", function(_model)
	GiveWeaponToPed(PlayerPedId(), GetHashKey(_model), 250, false, false)
end,false)

RegisterNetEvent("command:fix")
AddEventHandler("command:fix", function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		SetVehicleFixed(vehicle)
	else
		local pos = GetEntityCoords(PlayerPedId())
		local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 10.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
		local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			if DoesEntityExist(vehicleHandle) then
				SetVehicleFixed(vehicleHandle)
			end
		end
	end
end)

RegisterNetEvent("command:delete")
AddEventHandler("command:delete", function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		DestroyCar(vehicle)
	else
		local pos = GetEntityCoords(PlayerPedId())
		local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 10.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
		local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			if DoesEntityExist(vehicleHandle) then
				DestroyCar(vehicle)
			end
		end
	end
end)

RegisterNetEvent("command:clean")
AddEventHandler("command:clean", function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		SetVehicleDirtLevel(vehicle, 0)
	else
		local pos = GetEntityCoords(PlayerPedId())
		local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 10.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
		local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			if DoesEntityExist(vehicleHandle) then
				SetVehicleDirtLevel(vehicleHandle, 0)
			end
		end
	end
end)

RegisterNetEvent("command:livery")
AddEventHandler("command:livery", function(_livery)
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local total_livery = GetVehicleLiveryCount(vehicle)
		if _livery <= total_livery then
			SetVehicleLivery(vehicle, _livery)
		else
			TriggerEvent('chatMessage', "", {255, 0, 0}, "Livery doesn't exist")
		end
	else
		local pos = GetEntityCoords(PlayerPedId())
		local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 10.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
		local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			if DoesEntityExist(vehicleHandle) then
				local total_livery = GetVehicleLiveryCount(vehicleHandle)
				if _livery <= total_livery then
					SetVehicleLivery(vehicleHandle, _livery)
				else
					TriggerEvent('chatMessage', "", {255, 0, 0}, "Livery doesn't exist")
				end
			end
		end
	end
end)

RegisterCommand("ragdoll", function(source, args, fullCommand)
	SetPedToRagdoll(PlayerPedId(), 2000, 2000, 0, 0, 0, 0)
end, false)

RegisterNetEvent("command:upgradeperformance")
AddEventHandler("command:upgradeperformance", function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		SetVehicleModKit(vehicle, 0)
		SetVehicleMod(vehicle, 11, 2)
		SetVehicleMod(vehicle, 12, 2)
		SetVehicleMod(vehicle, 13, 2)
		SetVehicleMod(vehicle, 15, 3)
		SetVehicleMod(vehicle, 16, 4)
		ToggleVehicleMod(vehicle, 18, true)
	end
end)

RegisterNetEvent("command:goblin")
AddEventHandler("command:goblin", function()
        Citizen.CreateThread(function()
            local model = GetHashKey("goblin")
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(250)
            end
            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
        end)
end)
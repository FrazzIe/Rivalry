--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]

Users = {}
UGroup = {}
UPower = {}
Characters = {}
CharacterNames = {}
MDTCharacters = {}

local loggedIn = false
local timeplayed = 0
local timeout = 0
local time = -1
local selected = false

local function freezePlayer(id, freeze)
    local player = id
    SetPlayerControl(player, not freeze, false)

    local ped = GetPlayerPed(player)

    if not freeze then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end

        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end

        FreezeEntityPosition(ped, false)
        --SetCharNeverTargetted(ped, false)
        SetPlayerInvincible(player, false)
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end

        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        --SetCharNeverTargetted(ped, true)
        SetPlayerInvincible(player, true)
        --RemovePtfxFromPed(ped)

        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

function ToggleSelectionScreen(val)
	SetPlayerControl(PlayerId(), val and 0 or 1, 0)
	SetNuiFocus(val, val)
	SendNUIMessage({ type = "SetVisible", payload = val })
end

local function drawTimedMissionScaleform(heading, desc)

	local scaleform = RequestScaleformMovie("mission_quit")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(heading)
	PushScaleformMovieFunctionParameterString(desc)
	PopScaleformMovieFunctionVoid()

	DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
end

local function FindNearbyPlayers(distance)

	local results = {}
	for _, i in ipairs(GetActivePlayers()) do
		if GetPlayerPed(i) ~= nil then
			local targetPed = GetPlayerPed(i)
			if GetDistanceBetweenCoords(GetEntityCoords(targetPed),GetEntityCoords(GetPlayerPed(-1))) < distance then
				if GetPlayerPed(-1) ~= GetPlayerPed(i) then
					results[#results+1] = {ped = targetPed, pedID = i};
				end
			end
		end
	end

	return results
end

local function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function GetCharacterName(id)
	if CharacterNames[id] then
		return CharacterNames[id]
	else
		return GetPlayerName(GetPlayerFromServerId(id))
	end
end

function GetPower(id)
	if UPower[id] then
		return UPower[id]
	else
		return false
	end
end

function GetGroup(id)
	if UGroup[id] then
		return UGroup[id]
	else
		return false
	end
end

function GetMdtData()
	local Data = {}
	
	if MDTCharacters ~= nil then
		for _, value in pairs(MDTCharacters) do
			if value ~= nil then
				table.insert(Data, value)
			end
		end
	end

	return Data
end

RegisterNetEvent("core:sync")
AddEventHandler("core:sync", function(_Characters, _CharactersNames, _Users, _UPower, _UGroup, _MDTCharacters)
	Characters = _Characters
	CharacterNames = _CharactersNames
	Users = _Users
	UGroup = _UGroup
	UPower = _UPower
	if _MDTCharacters ~= nil then
		MDTCharacters = _MDTCharacters
	end
end)

AddEventHandler("playerSpawned", function()
	if not loggedIn then
		TriggerEvent("anticheat:set", "invisible", true, function(callback)
			if callback then
				SetEntityVisible(PlayerPedId(), false)
			else
				TriggerServerEvent("core:bug", "Line 105 in resource "..GetCurrentResourceName())
				SetEntityVisible(PlayerPedId(), false)
			end
		end)
		TriggerEvent("anticheat:set", "invincible", true, function(callback)
			if callback then
				SetPlayerInvincible(PlayerPedId(), true)
			else
				TriggerServerEvent("core:bug", "Line 113 in resource "..GetCurrentResourceName())
				SetPlayerInvincible(PlayerPedId(), true)
			end
		end)
		TriggerEvent("anticheat:set", "noclip", true, function(callback)
			if callback then
				SetEntityCoords(PlayerPedId(),  394.99826049805, -984.61370849609, 118.63548278809)
			else
				TriggerServerEvent("core:bug", "Line 121 in resource "..GetCurrentResourceName())
				SetEntityCoords(PlayerPedId(), 394.99826049805, -984.61370849609, 118.63548278809)
			end
		end)
		FreezeEntityPosition(PlayerPedId(), true)
		TriggerServerEvent("core:retrieveCharacters")
	end
end)

RegisterNetEvent("core:switchCharacter")
AddEventHandler("core:switchCharacter", function()
	loggedIn = false
	if not loggedIn then
		TriggerEvent("anticheat:set", "invisible", true, function(callback)
			if callback then
				SetEntityVisible(PlayerPedId(), false)
			else
				TriggerServerEvent("core:bug", "Line 105 in resource "..GetCurrentResourceName())
				SetEntityVisible(PlayerPedId(), false)
			end
		end)
		TriggerEvent("anticheat:set", "invincible", true, function(callback)
			if callback then
				SetPlayerInvincible(PlayerPedId(), true)
			else
				TriggerServerEvent("core:bug", "Line 113 in resource "..GetCurrentResourceName())
				SetPlayerInvincible(PlayerPedId(), true)
			end
		end)
		TriggerEvent("anticheat:set", "noclip", true, function(callback)
			if callback then
				SetEntityCoords(PlayerPedId(), -1400.11, -1530.36, 81.1)
			else
				TriggerServerEvent("core:bug", "Line 121 in resource "..GetCurrentResourceName())
				SetEntityCoords(PlayerPedId(), -1400.11, -1530.36, 81.1)
			end
		end)
		Citizen.Wait(5)
		FreezeEntityPosition(PlayerPedId(), true) 
		TriggerServerEvent("core:retrieveCharacters")
	end
end)

RegisterNetEvent("core:loadCharacters")
AddEventHandler("core:loadCharacters", function(_Characters)
	ToggleSelectionScreen(true)

	SendNUIMessage({ type = "SetCharacters", payload = _Characters })
end)

local selectCallback = nil
local deleteCallback = nil
local createCallback = nil
local refreshCallback = nil

RegisterNUICallback("select", function(data, cb)
	selectCallback = cb
	TriggerServerEvent("core:selectCharacter", data)
end)

RegisterNetEvent("core:login")
AddEventHandler("core:login", function(coords, _timeplayed)
	selectCallback("ok")
	selectCallback = nil

	timeplayed = _timeplayed
	
	ToggleSelectionScreen(false)

	freezePlayer(PlayerId(), true)

	SwitchOutPlayer(PlayerPedId(), 0, 1)

	Citizen.Wait(1000)

	local _, GroundZ = GetGroundZFor_3dCoord(coords.x + 0.0, coords.y + 0.0, coords.z + 0.0, Citizen.ReturnResultAnyway())	

	local ped = PlayerPedId()

	RequestCollisionAtCoord(coords.x, coords.y, GroundZ)

	SetEntityCoordsNoOffset(ped, coords.x, coords.y, GroundZ, false, false, false, true)

	ClearPedBloodDamage(ped)
	
    TriggerEvent('mythic_hospital:client:RemoveBleed')
	TriggerEvent('mythic_hospital:client:ResetLimbs')
	
	NetworkResurrectLocalPlayer(coords.x, coords.y, GroundZ, 90.0, true, true, false)

	ped = PlayerPedId()

	ClearPedTasksImmediately(ped)

	local time = GetGameTimer()

	while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 5000) do
		Citizen.Wait(0)
	end

	freezePlayer(PlayerId(), false)
	
	N_0xd8295af639fd9cb8(PlayerPedId())

	loggedIn = true

	SetEntityVisible(PlayerPedId(), true)
	SetPlayerInvincible(PlayerPedId(), false)
	DisablePlayerVehicleRewards(PlayerPedId())
	SetPlayerHealthRechargeMultiplier(PlayerPedId(), 0.0)

	TriggerEvent("anticheat:set", "invisible", false, function(callback)
	end)
	TriggerEvent("anticheat:set", "invincible", false, function(callback)
	end)
	TriggerEvent("anticheat:set", "noclip", false, function(callback)
	end)
	TriggerEvent("core:pvp")
	TriggerServerEvent("core:loggedin")
end)

RegisterNUICallback("delete", function(data, cb)
	deleteCallback = cb
	TriggerServerEvent("core:deleteCharacter", data)
end)

RegisterNetEvent("core:deleteCharacter")
AddEventHandler("core:deleteCharacter", function(_Characters)
	deleteCallback({ characters = _Characters })
	deleteCallback = nil
end)

RegisterNUICallback("create", function(data, cb)
	createCallback = cb
	TriggerServerEvent("core:createCharacter", data)
end)

RegisterNetEvent("core:createCharacter")
AddEventHandler("core:createCharacter", function(_Characters)
	createCallback({ characters = _Characters })
	createCallback = nil
end)

RegisterNUICallback("refresh", function(data, cb)
	refreshCallback = cb
	TriggerServerEvent("core:refreshChangelog")
end)

RegisterNetEvent("core:enableDeletion")
AddEventHandler("core:enableDeletion", function(val)
	SendNUIMessage({ type = "EnableCharRemoval", payload = val })
end)

RegisterNetEvent("core:setCharLimit")
AddEventHandler("core:setCharLimit", function(val)
	SendNUIMessage({ type = "SetCharLimit", payload = val })
end)

RegisterNetEvent("core:setChangelog")
AddEventHandler("core:setChangelog", function(changelog)
	if refreshCallback ~= nil then
		refreshCallback("ok")
		refreshCallback = nil
	end

	if changelog ~= nil and changelog ~= "" then
		SendNUIMessage({ type = "SetChangelog", payload = changelog })
	end
end)

RegisterNetEvent("core:pvp")
AddEventHandler("core:pvp", function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			SetPedSuffersCriticalHits(PlayerPedId(), false)
			for _, player in ipairs(GetActivePlayers()) do
				SetCanAttackFriendly(GetPlayerPed(player), true, true)
				NetworkSetFriendlyFireOption(true)
			end
		end
	end)
end)

RegisterNetEvent("core:kickall")
AddEventHandler("core:kickall", function(reason)
	TriggerServerEvent("core:kickall", reason)
end)

--[[	Time Played	   ]]--

Citizen.CreateThread(function()
	local oldpos = nil
	local olderpos = nil
	while true do
		Citizen.Wait(1000)
		if loggedIn then
			local pos = GetEntityCoords(PlayerPedId())
			timeout = timeout + 1
			timeplayed = timeplayed + 1
			if timeout >= 60 then
				timeout = 0
				TriggerServerEvent("core:updatePlaytime", timeplayed)
			end
			if oldpos ~= pos then
				TriggerServerEvent("core:updatePosition", pos.x, pos.y, pos.z, false)
				oldpos = pos
			end
			if olderpos == nil then
				olderpos = pos
			else
				if Vdist(olderpos.x, olderpos.y, olderpos.z, pos.x, pos.y, pos.z) > 100 then
					TriggerServerEvent("core:updatePosition", pos.x, pos.y, pos.z, true)
					olderpos = pos
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if time >= 1 then
			Citizen.Wait(1000)
			time = time - 1
			local nearbyPlayers = FindNearbyPlayers(75)
			if #nearbyPlayers > 0 then
				time = -1
				exports.pNotify:SendNotification({text = "Someone came in range and the process was cancelled!", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
			elseif IsEntityDead(PlayerPedId()) then
				time = -1
				exports.pNotify:SendNotification({text = "You've been severely injured and need medical assistance", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if loggedIn then
			if IsControlJustPressed(1, 166) then

				if time >= 1 then
					time = -1
				else
					local nearbyPlayers = FindNearbyPlayers(75)
					if #nearbyPlayers == 0 then
						time = 25
					else
						exports.pNotify:SendNotification({text = "Please get to an area where no one is nearby!", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
					end
				end
			end
			if time == 0 then
				time = -1
				loggedIn = false
				TriggerServerEvent("core:switchCharacter")
			elseif time >= 1 then
				drawTimedMissionScaleform("Switching character!", "in ~g~"..time.." ~w~seconds!")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent("core:initalise")
			TriggerServerEvent("Queue:playerActivated")
			return
		end
	end
end)

Citizen.CreateThread(function()
	exports("SpawnVehicle", function(model, coords, heading, clearArea)
	    local clearRadius = 1.5
	    local modelHash = (type(model) == "string" and GetHashKey(model) or model)
	    local startTime = GetGameTimer()

	    if not IsModelInCdimage(modelHash) then
	    	Citizen.Trace("[Export]:SpawnVehicle -> Invalid model")
	        return nil
	    end

	    if not IsModelAVehicle(modelHash) then
	    	Citizen.Trace("[Export]:SpawnVehicle -> Model is not a vehicle")
	    	return nil
	    end

	    -- if not CanRegisterMissionVehicles(1) then
	    -- 	Citizen.Trace("[Export]:SpawnVehicle -> Unable to register mission vehicles")
	    --     return nil
	    -- end

	    RequestModel(modelHash)

	    while not HasModelLoaded(modelHash) do
	        Citizen.Wait(25)

	        if (GetGameTimer() - startTime) > 15000 then
	            break
	        end
	    end

	    if not HasModelLoaded(modelHash) then
	    	Citizen.Trace("[Export]:SpawnVehicle -> Unable to load model")
	        return nil
	    end
	    
	    if model == "bombushka" then
	        clearRadius = 20.0
	    end

	    if clearArea then
	        ClearAreaOfVehicles(coords.x, coords.y, coords.z, clearRadius, false, false, false, false, false)
	    end

	    local handle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, heading, true, false)

	    if DoesEntityExist(handle) then
	        local netHandle = VehToNet(handle)

	        SetEntitySomething(handle, true)

	        if NetworkGetEntityIsNetworked(handle) then
	            SetNetworkIdExistsOnAllMachines(netHandle, true)
	        end

	        SetVehicleIsStolen(handle, false)
	        N_0xb2e0c0d6922d31f2(handle, true)
	        SetModelAsNoLongerNeeded(modelHash)
	        
	        return handle
	    else
	    	Citizen.Trace("[Export]:SpawnVehicle -> Vehicle does not exist")
	        return nil
	    end
	end)
end)
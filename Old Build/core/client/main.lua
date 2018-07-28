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

local loggedIn = false
local timeplayed = 0
local timeout = 0
local time = -1
local selected = false

local function open(_characters)
	SetPlayerControl(PlayerId(), 0, 0)
	SetNuiFocus(true, true)
	SendNUIMessage({open = true, characters = _characters})
end

local function close()
	SetNuiFocus(false, false)
	SendNUIMessage({open = false})
	SetPlayerControl(PlayerId(), 1, 0)
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
	for i=-1,32 do
		if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= nil then
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

RegisterNetEvent("core:sync")
AddEventHandler("core:sync", function(_Characters, _CharactersNames, _Users, _UPower, _UGroup)
	Characters = _Characters
	CharacterNames = _CharactersNames
	Users = _Users
	UGroup = _UGroup
	UPower = _UPower
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
				SetEntityCoords(PlayerPedId(), -1400.11, -1530.36, 81.1)
			else
				TriggerServerEvent("core:bug", "Line 121 in resource "..GetCurrentResourceName())
				SetEntityCoords(PlayerPedId(), -1400.11, -1530.36, 81.1)
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

RegisterNetEvent("core:login")
AddEventHandler("core:login", function(coords, _timeplayed)
	timeplayed = _timeplayed
	close()
	FreezeEntityPosition(PlayerPedId(), false)

	SwitchOutPlayer(PlayerPedId(), 0, 1)

	Citizen.Wait(1000)
	
	SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
				
	N_0xd8295af639fd9cb8(PlayerPedId())

	loggedIn = true

	SetEntityVisible(PlayerPedId(), true)
	SetPlayerInvincible(PlayerPedId(), false)

	TriggerEvent("anticheat:set", "invisible", false, function(callback)
	end)
	TriggerEvent("anticheat:set", "invincible", false, function(callback)
	end)
	TriggerEvent("anticheat:set", "noclip", false, function(callback)
	end)
	TriggerEvent("core:pvp")
end)

RegisterNetEvent("core:loadCharacters")
AddEventHandler("core:loadCharacters", function(_Characters)
	open(_Characters)
end)

RegisterNetEvent("core:deleteCharacter")
AddEventHandler("core:deleteCharacter", function(_Characters)
	open(_Characters)
end)

RegisterNetEvent("core:editCharacter")
AddEventHandler("core:editCharacter", function(_Characters)
	open(_Characters)
end)

RegisterNetEvent("core:createCharacter")
AddEventHandler("core:createCharacter", function(_Characters)
	open(_Characters)
end)

RegisterNetEvent("core:pvp")
AddEventHandler("core:pvp", function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			for i = 0,32 do
				if NetworkIsPlayerActive(i) then
					SetCanAttackFriendly(GetPlayerPed(i), true, true)
					NetworkSetFriendlyFireOption(true)
				end
			end
		end
	end)
end)

RegisterNetEvent("core:kickall")
AddEventHandler("core:kickall", function(reason)
	TriggerServerEvent("core:kickall", reason)
end)

RegisterNUICallback("create_character", function(data, cb)
	local split_dob = stringsplit(data.dob, "-")
	if #split_dob == 3 then
		data.dob = split_dob[2].."/"..split_dob[3].."/"..split_dob[1]
	end

	TriggerServerEvent("core:createCharacter", data)
end)

RegisterNUICallback("edit_character", function(data, cb)
	local split_dob = stringsplit(data.dob, "-")
	if #split_dob == 3 then
		data.dob = split_dob[2].."/"..split_dob[3].."/"..split_dob[1]
	end

	TriggerServerEvent("core:editCharacter", data)
end)

RegisterNUICallback("select_character", function(data, cb)
	TriggerServerEvent("core:selectCharacter", data.character)
end)

RegisterNUICallback("delete_character", function(data, cb)
	TriggerServerEvent("core:deleteCharacter", data.character)
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
				exports.pNotify:SendNotification({text = "You are in a coma.", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
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
--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local first_tick = true
local InstructionalButtons = nil

local function getPlayers() --Get all users
	local players = {}
	for i = 0, 255 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, {id = GetPlayerServerId(i), name = GetPlayerName(i)})
		end
	end
	return players
end

local function SetInstructionalButtons(buttons, layout) --Layout: 0 - Horizontal, 1 - vertical
    Citizen.CreateThread(function()
        if not HasScaleformMovieLoaded(InstructionalButtons) then
            InstructionalButtons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
            while not HasScaleformMovieLoaded(InstructionalButtons) do
                Citizen.Wait(0)
            end
        end
        local sf = InstructionalButtons
        local w,h = GetScreenResolution()
        PushScaleformMovieFunction(sf,"INSTRUCTIONAL_BUTTONS")
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
        PushScaleformMovieFunctionParameterInt(w)
        PushScaleformMovieFunctionParameterInt(h)
        PushScaleformMovieFunctionParameterFloat(0.02)
        PushScaleformMovieFunctionParameterFloat(0.98)
        PushScaleformMovieFunctionParameterFloat(0.02)
        PushScaleformMovieFunctionParameterFloat(0.98)
        PushScaleformMovieFunctionParameterBool(true)
        PushScaleformMovieFunctionParameterBool(false)
        PushScaleformMovieFunctionParameterBool(false)
        PushScaleformMovieFunctionParameterInt(w)
        PushScaleformMovieFunctionParameterInt(h)
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
        PushScaleformMovieFunctionParameterInt(1)
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"CLEAR_ALL")
        PopScaleformMovieFunction()
        for i,btn in pairs(buttons) do
            PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
            PushScaleformMovieFunctionParameterInt(i-1)
            PushScaleformMovieFunctionParameterString(btn[1])
            PushScaleformMovieFunctionParameterString(btn[2])
            PopScaleformMovieFunction()
            
        end
        if layout ~= 1 then
            PushScaleformMovieFunction(sf,"SET_PADDING")
            PushScaleformMovieFunctionParameterInt(10)
            PopScaleformMovieFunction()
        end
        PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
        PushScaleformMovieFunctionParameterInt(layout)
        PopScaleformMovieFunction()
    end)
end

local function DrawInstructionalButtons()
    if HasScaleformMovieLoaded(InstructionalButtons) then
        DrawScaleformMovie(InstructionalButtons, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
    end
end

local function successCallback(_source, _message)
	TriggerServerEvent("core:quickoption_callback", _source, _message)
end

--Open panel
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 212) and IsControlJustPressed(1, 213) then
			if exports.core:GetGroup(GetPlayerServerId(PlayerId())) == "admin" or exports.core:GetGroup(GetPlayerServerId(PlayerId())) == "owner" or exports.core:GetGroup(GetPlayerServerId(PlayerId())) == "staff" then
				SetPlayerControl(PlayerId(), 0, 0)
				SetNuiFocus(true, true)
				SendNUIMessage({open = true, players = getPlayers()})
			end
		end
	end
end)

--Exit panel callback
RegisterNUICallback("escape", function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({open = false})
	SetPlayerControl(PlayerId(), 1, 0)
end)

--Quickoption callback
RegisterNUICallback("quickoption", function(data)
	if data.id ~= 0 then
		TriggerServerEvent("core:quickoption", data)
	end
end)

--Stats callback
RegisterNUICallback("set", function(data)
	if data.id ~= 0 then
		TriggerServerEvent("core:setData", data)
	end
end)

--Kick callback
RegisterNUICallback("kick", function(data)
	if data.reason ~= nil and data.reason ~= "" then
		if data.id ~= 0 then
			TriggerServerEvent("core:kick", data.id, data.reason)
		end
	end
end)

--Ban callback
RegisterNUICallback("ban", function(data)
	if data.perm or tonumber(data.time) >= 0 then
		if data.perm then data.time = "1" end
		if data.id ~= 0 then
			TriggerServerEvent("core:ban", data.id, data.time..data.bantime_type, data.reason, data.perm)
		end
	end 
end)

--Quick options
local frozen = false
local noclip = false

RegisterNetEvent("core:quickoption_slay")
AddEventHandler("core:quickoption_slay", function(_source)
	SetEntityHealth(PlayerPedId(), 0)
	successCallback(_source, "has been slayed")
end)

RegisterNetEvent("core:quickoption_noclip")
AddEventHandler("core:quickoption_noclip", function(_source)
	noclip = not noclip
	frozen = noclip
	if not noclip then
		first_tick = true
		FreezeEntityPosition(PlayerPedId(), frozen)
		SetEntityInvincible(PlayerPedId(), noclip)
		TriggerEvent("anticheat:set", "noclip", false, function(callback)
		end)
		TriggerEvent("anticheat:set", "invincible", false, function(callback)
		end)
	else
		FreezeEntityPosition(PlayerPedId(), frozen)
		TriggerEvent("anticheat:set", "noclip", true, function(callback)
			if callback then
			else
				TriggerServerEvent("core:bug", "Line 161 in resource "..GetCurrentResourceName())
			end
		end)
		TriggerEvent("anticheat:set", "invincible", true, function(callback)
			if callback then
				SetPlayerInvincible(GetPlayerIndex(),true)
			else
				TriggerServerEvent("core:bug", "Line 167 in resource "..GetCurrentResourceName())
				SetEntityInvincible(PlayerPedId(), noclip)
			end
		end)
	end
	successCallback(_source, "Noclip: ^3"..tostring(noclip))
end)

RegisterNetEvent("core:quickoption_freeze")
AddEventHandler("core:quickoption_freeze", function(_source)
	frozen = not frozen
	FreezeEntityPosition(PlayerPedId(), frozen)
	successCallback(_source, "Frozen: ^3"..tostring(frozen))
end)

RegisterNetEvent("core:quickoption_bring")
AddEventHandler("core:quickoption_bring", function(_source)
	TriggerEvent("anticheat:set", "noclip", true, function(callback)
		if callback then
			SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(_source)), false))
			TriggerEvent("anticheat:set", "noclip", false, function(callback)
			end)
		else
			SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(_source)), false))
			TriggerServerEvent("core:bug", "Line 188 in resource "..GetCurrentResourceName())
			TriggerEvent("anticheat:set", "noclip", false, function(callback)
			end)
		end
	end)
	successCallback(_source, "has been brought")
end)

RegisterNetEvent("core:quickoption_goto")
AddEventHandler("core:quickoption_goto", function(_source)
	TriggerEvent("anticheat:set", "noclip", true, function(callback)
		if callback then
			SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(_source)), false))
			TriggerEvent("anticheat:set", "noclip", false, function(callback)
			end)
		else
			SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(_source)), false))
			TriggerServerEvent("core:bug", "Line 205 in resource "..GetCurrentResourceName())
			TriggerEvent("anticheat:set", "noclip", false, function(callback)
			end)
		end
	end)
	successCallback(GetPlayerServerId(PlayerId()), " has been teleported to")
end)

RegisterNetEvent("core:quickoption_slap")
AddEventHandler("core:quickoption_slap", function(_source)
	ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
	successCallback(_source, "has been slapped")
end)

RegisterNetEvent("core:quickoption_crash")
AddEventHandler("core:quickoption_crash", function(_source)
	successCallback(_source, "has been crashed")
	Citizen.CreateThread(function()
		while true do end
	end) 
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if noclip then
			if first_tick then
				first_tick = false
				SetInstructionalButtons({
					{GetControlInstructionalButton(1, 173, 0), "Down"},
					{GetControlInstructionalButton(1, 172, 0), "Up"},
					{GetControlInstructionalButton(1, 33, 0), "Backward"},
					{GetControlInstructionalButton(1, 32, 0), "Forward"},
					{GetControlInstructionalButton(1, 35, 0), "Right"},
					{GetControlInstructionalButton(1, 34, 0), "Left"},
				}, 0)
			end
			DrawInstructionalButtons()
			if IsControlPressed(0, 34) then
				SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) + 2.5)
			elseif IsControlPressed(0, 35) then
				SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 2.5)
			end

			if IsControlPressed(0, 32) then
				SetEntityCoordsNoOffset(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.5, 0.0))
			elseif IsControlPressed(0, 33) then
				SetEntityCoordsNoOffset(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, 0.0))
			end

			if IsControlPressed(0, 172) then
				SetEntityCoordsNoOffset(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.5))
			elseif IsDisabledControlPressed(0, 173) then
				SetEntityCoordsNoOffset(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -0.5))
			end
		end
	end
end)
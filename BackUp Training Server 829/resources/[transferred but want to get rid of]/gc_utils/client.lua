--=============================================================================
-- #Author: Jonathan D @ Gannon
--=============================================================================

GcUtils = {}

function getGcUtils()
    return GcUtils
end

--[[
    @return List des joueurs en ligne
]]--
GcUtils.GetPlayers = function()
    local players = {}
    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end

--[[
    Retourne le joueurs le proche du joueur actuelle
    @distmax: distance max de recherche
    @useZ: 
    @return Joueur or nil
            distance or -1
]]--
GcUtils.GetClosestPlayer = function (distmax, useZ)
    local players = GetPlayers()
    local closestDistance = distmax or -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    useZ = useZ or false
    for _ ,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if (target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords, plyCoords, useZ)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

--[[
    @ped:
    @dist: distance max
    @Return Véhicule devant le joueurs
]]--
GcUtils.GetVehicleLookByPlayer = function (ped, dist)
    local playerPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 0.0)
    local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(ped, 0.0, dist, -0.8)
    return GcUtils.GetVehicleInDirection(playerPos, inFrontOfPlayer)
end

--[[
    Recherche un véhicule entre 2 point
    @return vehicule or nil
]]
GcUtils.GetVehicleInDirection = function (coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1 ), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

--[[
    @Return time 
]]--
GcUtils.getTime = function()
    return Citizen.InvokeNative(0x9A73240B49945C76)
end

--[[
]]--
GcUtils.PlayEmote = function (name, duration) 
    Citizen.CreateThread(function()
        TaskStartScenarioInPlace(GetPlayerPed(-1), name, 0, true)
        Citizen.Wait(duration)
        ClearPedTasks(GetPlayerPed(-1))
    end)
end


--=============================================================================
--
--  UI
--
--=============================================================================

local requestFocus = false
local cSetNuiFocus = function(isFocus)
    Citizen.Trace('[GcUtils] Call cSetNuiFocus')
    if isFocus == true then 
        -- SetCurLocation
        Citizen.InvokeNative(0xFC695459D4D0E219, 0.5, 0.5)
    end
    SetNuiFocus(isFocus)
    requestFocus = isFocus
end
--=============================================================================
--  
--=============================================================================
GcUtils.DrawText = function (text, posX, posY, textColor, isCenter, font, scale, outline) 
    font = font or 0
    scale = scale or 0.35
    isCenter = isCenter or 0
    -- shadow = shadow or 0
    -- edge = edge or 0
    outline = outline or false
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(isCenter)
    if outline then
        SetTextOutline()
    end
    -- SetTextDropShadow(shadow, 0, 0, 0, 255)
    -- SetTextEdge(edge, 0, 0, 0, 255)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(posX, posY)
end

GcUtils.DrawTextIn3DWorld = function (x, y, z, text)
    local f, x, y = World3dToScreen2d(x, y, z)
    if x ~= -1 then
        GcUtils.DrawText(text, x, y, {255,255,255,255}, 1)
    end
end
--=============================================================================
--  ProgressBar
--=============================================================================
GcUtils.showProgressBar = function (percent, text, time) 
    SendNUIMessage({method = 'showProgressBar', percent = percent, text = text, time = time})
end

GcUtils.showProgressBarTimer = function (time, text, text2) 
    SendNUIMessage({method = 'showProgressBarTime', time = time, text = text, text2 = text2})
end

GcUtils.hideProgressBar = function () 
    SendNUIMessage({method = 'hideProgressBar'})
end


--=============================================================================
--  InputText
--=============================================================================
local callbackInputText = nil

GcUtils.InputText = function (title, defaultValue, callback)
    if callbackInputText ~= nil then
        callback(nil)
        return
    end
    cSetNuiFocus(true)
    SendNUIMessage({method = 'showInpuText', title = title, defaultValue = defaultValue})
    callbackInputText = callback
end

RegisterNUICallback('onValidInputText', function(value)
    cSetNuiFocus(false)
    if callbackInputText ~= nil then 
        callbackInputText(value)
        callbackInputText = nil
    end
end)
--=============================================================================
--  InputText
--=============================================================================
local callbackDialog = nil

GcUtils.showDialog = function (texte, reponses, callback)
    if callbackDialog ~= nil then
        --callbackDialog(nil)
    end
    cSetNuiFocus(true)
    callbackDialog = callback
    SendNUIMessage({method = 'showDialog', texte = texte, reponses = reponses}) 
end

RegisterNUICallback('onValidDialog', function(value)
    cSetNuiFocus(false)
    
    Citizen.Trace('[gc_ui] Reponse: ' .. (value or 'nil'))
    if callbackDialog ~= nil then 
        Citizen.CreateThread(function ()
            local callB = callbackDialog
            callbackDialog= nil
            callB(value)
        end)
    end
end)

--=============================================================================
--  Native Function
--=============================================================================
GcUtils.showMessageInformation = function (message, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

GcUtils.showActionInfo = function (text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

GcUtils.showNotification = function (text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

--=============================================================================
--  Focus thread
--=============================================================================
Citizen.CreateThread(function()
    while true do
        if requestFocus == true then
            DisableControlAction(0, 1, 1) -- LookLeftRight
            DisableControlAction(0, 2, 1) -- LookUpDown
            DisableControlAction(0, 24, 1) -- Attack
            DisableControlAction(0, 142, 1) -- MeleeAttackAlternate
            DisableControlAction(0, 106, 1) -- VehicleMouseControlOverride
            DisablePlayerFiring(GetPlayerPed(-1), 1) -- Disable weapon firing
            if IsDisabledControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({method = "click"})
            end
        end
        Citizen.Wait(0)
    end
end)

-- DEV
-- Citizen.CreateThread(function() 
--   while true do 
--     local pos = GetEntityCoords(GetPlayerPed(-1))
--     GcUtils.showMessageInformation('~r~' ..pos.x .. '\n~g~' .. pos.y .. '\n~b~' .. pos.z,200)
--     Citizen.Wait(0)
--   end
-- end)

--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
IsJailed = false
local removeSentence = false
 
 
RegisterNetEvent("jail:jail")
AddEventHandler("jail:jail", function(JailTime)
    if IsJailed == true then
        return
    end

    if exports.policejob:getIsCuffed() then
        TriggerEvent('police:uncuff')
    end
    if DoesEntityExist(PlayerPedId()) then
       
        Citizen.CreateThread(function()
            SetEntityCoords(PlayerPedId(), 1677.233, 2658.618, 45.216)
            IsJailed = true
            removeSentence = false
            local invisible = false
            TriggerEvent("anticheat:set", "invincible", true, function(callback)
                if callback then
                    invisible = true
                else
                    invisible = true
                    TriggerServerEvent("core:bug", "Line 33 in resource "..GetCurrentResourceName())
                end
            end)
            while invisible == false do Citizen.Wait(1) end
            while JailTime > 0 and not removeSentence do
                RemoveAllPedWeapons(PlayerPedId(), true)
                SetEntityInvincible(PlayerPedId(), true)
                TriggerEvent("fm:eat", 100)
                TriggerEvent("fm:drink", 100)
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    ClearPedTasksImmediately(PlayerPedId())
                end
                if JailTime % 30 == 0 then
                    exports.pNotify:SendNotification({text = JailTime .." more seconds until release.",type = "error",timeout = 3000,layout = "centerRight",queue = "left"})
                    TriggerServerEvent("jail:update", JailTime)
                end
                Citizen.Wait(500)
                local coords = GetEntityCoords(PlayerPedId(), true)
                local Distance = Vdist(1677.233, 2658.618, 45.216, coords['x'], coords['y'], coords['z'])
                if Distance > 90 then
                    SetEntityCoords(PlayerPedId(), 1677.233, 2658.618, 45.216)
                    if Distance > 100 then
                        JailTime = JailTime + 60
                        exports.pNotify:SendNotification({text = "Your jail time was extended for an unlawful escape attempt.",type = "error",timeout = 5000,layout = "centerRight",queue = "left"})
                    end
                end
                JailTime = JailTime - 0.5
            end
            SetEntityCoords(PlayerPedId(), 1839.099, 2608.195, 45.562)
            IsJailed = false
            SetEntityInvincible(PlayerPedId(), false)
            TriggerEvent("anticheat:set", "invincible", false, function(callback)
            end)
            if not removeSentence then
                TriggerServerEvent("jail:update", 0)
            end
        end)
    end
end)

RegisterNetEvent("jail:unjail")
AddEventHandler("jail:unjail", function()
    removeSentence = true
end)

function IsInJail()
    return IsJailed
end

RegisterNetEvent("jail:break")
AddEventHandler("jail:break", function()
    removeSentance = true
end)

local table = {
    {x = , y = , z = ,}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k, v in pairs(table) do
            DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 255, false, true, 2, false, false, false, false)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        for k, v in pairs(table) do
            local plyCoords = GetEntityCoords(ped, false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            local maxRadius = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x+100,v.y+100,v.z+100)
            if(dist <= 1.5)then
                if(IsControlJustPressed(1, 51))then
                    TriggerServerEvent('allPlayers')
                    Notify("You just triggered the alarm at the prison! Cops have been notified!", 5000)
                    if(dist > maxRadius) then
                        Notify("Alarm System Canceled!", 5000)
                    else
                    Citizen.Wait(300000)
                    if(IsJailed == true)then
                         removeSentance = true
                    end
                end
            end
        end
    end
end)

function Notify(Message, Time)
    exports.pNotify:SendNotification({text = Message}, type = "error", timeout = Time or 3000,layout = "centerRight", queue = "left")
end

local isCop = nil
RegisterNetEvent('allPlayersCB')
AddEventHandler('allPlayersCB', function(player)
    for k, v in ipairs(player) do
        if(exports.policejob:getIsCop() and exports.policejob:getIsInService())then
            Notify("DISPATCH: BREAK BREAK BREAK! PRISON BREAK IN PROGRESS! RESPOND AND IDENTIFY", 10000)
        end
    end
end)
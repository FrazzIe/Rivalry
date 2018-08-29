--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local isCursorActive = false
local enabled = false
local currentMenu = ""
local previousMenu = ""

function cursor()
    return isCursorActive
end

function showcursor()
    isCursorActive = not isCursorActive
    SetNuiFocus(isCursorActive, isCursorActive)
end

function event(name, data)
    TriggerEvent(name, data)
end

function close()
    currentMenu = ""
    previousMenu = ""
    enabled = false
    SendNUIMessage({
        type = "enableui",
        enable = false
    })
    SetNuiFocus(false, false)
    ClearPedTasks(PlayerPedId())
end

function open(name)
    SetNuiFocus(isCursorActive, isCursorActive)
    currentMenu = name or "open"
    SendNUIMessage({
        type = "enableui",
        enable = true
    })
    enabled = true
end

function reset()
    SendNUIMessage({
        type = "reset",
    })
    previousMenu = ""
end

function back(event_name, params)
    SetNuiFocus(isCursorActive, isCursorActive)
    previousMenu = event_name
    local name = "Back"
    if event_name == "" then
        name = "Close"
    end
    SendNUIMessage({
        type = "addButton",
        name = name,
        functionname = event_name,
        params = params or false
    })
end

function currentmenu()
    return currentMenu
end

function addOption(text, event_name, params)
    SetNuiFocus(isCursorActive, isCursorActive)
    SendNUIMessage({
        type = "addButton",
        name = text,
        functionname = event_name,
        params = params or false
    })
end

RegisterNUICallback('runfunction', function(data, cb)
    if data.params ~= "phone" then
        close()
    else
        currentMenu = ""
        previousMenu = ""
        enabled = false

        SendNUIMessage({
            type = "enableui",
            enable = false
        })
    end
    --print("UI::"..tostring(data.params))
    if data.params ~= false then
        TriggerEvent(data.event_func, data.params)
    else
        assert(load(data.event_func))()
    end
    cb('ok')
end)

RegisterNUICallback('backfunction', function(data, cb)
    if previousMenu ~= "" then
        assert(load(previousMenu))()
    else
        close()
    end
    cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)
    close()
    cb('ok')
end)

RegisterNUICallback('cursor', function(data, cb)
    showcursor()
    cb('ok')
end)

Citizen.CreateThread(function()
    local first_tick = true
    while true do
        Citizen.Wait(0)
        if enabled then
            if first_tick then
                first_tick = false
                TriggerEvent("chat:close")
            end
            DisableControlAction(0, 245, enabled)
            if isCursorActive then
                DisableControlAction(0, 1, enabled) -- LookLeftRight
                DisableControlAction(0, 2, enabled) -- LookUpDown
                DisableControlAction(0, 142, enabled) -- MeleeAttackAlternate
                DisableControlAction(0, 106, enabled) -- VehicleMouseControlOverride

                if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                    SendNUIMessage({type = "click"})
                end
            else
                DisableControlAction(0, 14, enabled)
                DisableControlAction(0, 15, enabled)

                if IsControlJustReleased(0, 184) then -- MIDDLE MOUSE
                    showcursor()
                end

                HideHudComponentThisFrame(19)
                HideHudComponentThisFrame(20)
                if IsControlJustReleased(0, 14) or IsDisabledControlJustReleased(0, 14) then -- Scroll down
                    SendNUIMessage({type = "scroll_down"})
                end

                if IsControlJustReleased(0, 15) or IsDisabledControlJustReleased(0, 15) then -- Scroll up
                    SendNUIMessage({type = "scroll_up"})
                end

                if IsControlJustReleased(0, 177) or IsDisabledControlJustReleased(0, 177) then -- BACK
                    SendNUIMessage({type = "back"})
                end
            end

            if (IsControlJustReleased(0, 18) or IsDisabledControlJustReleased(0, 18)) and not IsControlJustReleased(1, 55) and not IsControlJustReleased(1, 76) then -- ENTER
                SendNUIMessage({type = "enter"})
            end

            if IsControlJustReleased(0, 172) or IsDisabledControlJustReleased(0, 172) then -- UP
                SendNUIMessage({type = "up"})
            end

            if IsControlJustReleased(0, 173) or IsDisabledControlJustReleased(0, 173) then -- DOWN
                SendNUIMessage({type = "down"})
            end
        else
            first_tick = true
        end
    end
end)

RegisterCommand("frozen", function(source, args, rawCommand)
    close()
    SetPlayerControl(PlayerId(), 1, 0)
    ClearPedTasks(PlayerPedId()) 
    SetNuiFocus(false, false)
    TriggerEvent("phone:close")
    TriggerEvent("chat:close")
end,false)
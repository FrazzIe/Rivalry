--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
currentMissionBlip = nil 
availableMissions = {}
currentMissions = nil
CopCallStatus = 0
activeCops = 0
availableCops = 0

function Notify_p(icon, type, sender, title, text)
    Citizen.CreateThread(function()
        Wait(1)
        SetNotificationTextEntry("STRING");
        if text == nil then
            text = "Show this to an admin!"
        end
        AddTextComponentString(text);
        SetNotificationMessage(icon, icon, true, type, sender, title, text);
        DrawNotification(false, true);
    end)
end

RegisterNetEvent("police:notifyallCops")
AddEventHandler("police:notifyallCops",function(message)
    if isInService then
        Notify_p("CHAR_BLANK_ENTRY", 1, "Police Info", false, message)
    end
end)

RegisterNetEvent("police:notifyClient")
AddEventHandler("police:notifyClient",function(message)
    Notify_p("CHAR_BLANK_ENTRY", 1, "Police", false, message)
end)

-- 
AddEventHandler("police:accept_mission", function(data)
    TriggerServerEvent('police:acceptMission', data.id)
end)

AddEventHandler("police:finish_mission", function()
    if currentMissions ~= nil then
        TriggerServerEvent('police:finishMission', currentMissions.id)
    end
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
end)

function updateMissionMenu() 
    local cmissions = {}
    for k,v in pairs(availableMissions) do
        Citizen.Trace('==>' .. k )
    end
    for _,m in pairs(availableMissions) do
        local data = {
            name = '' .. m.name .. ' reported ' .. m.type,
            mission = m,
            event = "police:accept_mission",
        }
        if #m.acceptBy ~= 0 then
            data.name = data.name .. ' (' .. #m.acceptBy ..' Unit)'
        end
        table.insert(cmissions, data)
    end

    if currentMissions ~= nil then
        table.insert(cmissions, {name = 'Finish the mission', event = "police:finish_mission", mission = ""})
    end
    mission_list = cmissions
    if exports.ui:currentmenu() == "police:missions" then
        TriggerEvent("police:menu_missions")
    end
end

function callPolice(type)
    local callerPos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('police:Call', callerPos.x, callerPos.y, callerPos.z, type)
end

RegisterNetEvent('police:acceptMission')
AddEventHandler('police:acceptMission',function(mission)
    currentMissions = mission
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    currentMissionBlip = AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(currentMissionBlip, 58)
    SetBlipColour(currentMissionBlip, 5)
    SetBlipAsShortRange(currentMissionBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Mission in progress')
    EndTextCommandSetBlipName(currentMissionBlip)
    SetBlipAsMissionCreatorBlip(currentMissionBlip, true)
end)

RegisterNetEvent('police:cancelMission')
AddEventHandler('police:cancelMission', function ()
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
            MissionMenu()
        end
    end
end)

RegisterNetEvent('police:changeMission')
AddEventHandler('police:changeMission', function (missions)
    if not isInService then
        return
    end 
    
    availableMissions = missions
    local MissionsOnHold = 0
    for _,m in pairs(availableMissions) do
        if #m.acceptBy == 0 then
            MissionsOnHold = MissionsOnHold + 1
        end
    end
    if MissionsOnHold == 0 then 
        TriggerEvent("police:updateInformation", "~g~No calls waiting")
    else
        TriggerEvent("police:updateInformation", "~g~"..MissionsOnHold.." ~w~call(s) waiting")
    end
    updateMissionMenu()
end)

RegisterNetEvent('police:callPolice')
AddEventHandler('police:callPolice',function(type)
    callPolice(type)
end)

RegisterNetEvent('police:callPoliceCustom')
AddEventHandler('police:callPoliceCustom',function(_type)
    callPolice(_type)
end)

RegisterNetEvent('police:callStatus')
AddEventHandler('police:callStatus',function(status)
    CopCallStatus = status
end)

RegisterNetEvent('police:updateactiveCops')
AddEventHandler('police:updateactiveCops',function(activeCount, availableCount)
    activeCops = activeCount
    availableCops = availableCount
end)

RegisterNetEvent('police:cancelCall')
AddEventHandler('police:cancelCall',function(data)
    TriggerServerEvent('police:cancelCall')
end)


TriggerServerEvent('police:getactiveCops') -- Initilized on startup



function openTextInput()
    showLoadingPrompt("Enter a reason..", 3)
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 200)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        stopLoadingPrompt()
        return GetOnscreenKeyboardResult()
    end
    stopLoadingPrompt()
    return nil
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isCop) then
            if(isInService) then
                if currentMissions == nil then
                    if currentMissionBlip ~= nil then
                        RemoveBlip(currentMissionBlip)
                    end
                end
            end
        end
    end
end)
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
MedicCallStatus = 0
activeMedics = 0
availableMedics = 0

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

RegisterNetEvent("paramedic:notifyallMedics")
AddEventHandler("paramedic:notifyallMedics",function(message)
    if isInService then
        Notify_p("CHAR_CALL911", 1, "Emergency Info", false, message)
    end
end)

RegisterNetEvent("paramedic:notifyClient")
AddEventHandler("paramedic:notifyClient",function(message)
    Notify_p("CHAR_CALL911", 1, "Emergency", false, message)
end)

-- 
AddEventHandler("paramedic:accept_mission", function(data)
    TriggerServerEvent('paramedic:acceptMission', data.id)
end)

AddEventHandler("paramedic:finish_mission", function()
    if currentMissions ~= nil then
        TriggerServerEvent('paramedic:finishMission', currentMissions.id)
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
            name = '' .. m.name .. ' ' .. m.type,
            mission = m,
            event = "paramedic:accept_mission"
        }
        if #m.acceptBy ~= 0 then
            data.name = data.name .. ' (' .. #m.acceptBy ..' Unit)'
        end
        table.insert(cmissions, data)
    end

    if currentMissions ~= nil then
        table.insert(cmissions, {name = 'Finish the mission', event = "paramedic:finish_mission", mission = ""})
    end
    mission_list = cmissions
    if exports.ui:currentmenu() == "paramedic:missions" then
        TriggerEvent("paramedic:menu_missions")
    end
end

function callAmbulance(type)
    local callerPos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('paramedic:Call', callerPos.x, callerPos.y, callerPos.z, type)
end

RegisterNetEvent('paramedic:acceptMission')
AddEventHandler('paramedic:acceptMission',function(mission)
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

RegisterNetEvent('paramedic:cancelMission')
AddEventHandler('paramedic:cancelMission', function ()
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

RegisterNetEvent('paramedic:changeMission')
AddEventHandler('paramedic:changeMission', function (missions)
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
        TriggerEvent("paramedic:updateInformation", "~g~No calls waiting")
    else
        TriggerEvent("paramedic:updateInformation", "~g~"..MissionsOnHold.." ~w~call(s) waiting")
    end  
    updateMissionMenu()
end)

RegisterNetEvent('paramedic:callAmbulance')
AddEventHandler('paramedic:callAmbulance',function(type)
    callAmbulance(type)
end)

RegisterNetEvent('paramedic:callAmbulanceCustom')
AddEventHandler('paramedic:callAmbulanceCustom',function(_type)
    callAmbulance(_type)
end)

RegisterNetEvent('paramedic:callStatus')
AddEventHandler('paramedic:callStatus',function(status)
    MedicCallStatus = status
end)

RegisterNetEvent('paramedic:updateactiveMedics')
AddEventHandler('paramedic:updateactiveMedics',function(activeCount, availableCount)
    activeMedics = activeCount
    availableMedics = availableCount
end)

RegisterNetEvent('paramedic:cancelCall')
AddEventHandler('paramedic:cancelCall',function(data)
    TriggerServerEvent('paramedic:cancelCall')
end)


TriggerServerEvent('paramedic:getactiveMedics') -- Initilized on startup



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

function dht(message)
    Citizen.CreateThread(function()
        Wait(10)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(message)
        DrawNotification(false, false)
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isParamedic) then
            if(isInService) then
                if currentMissions ~= nil then
                    if currentMissionBlip ~= nil then
                        RemoveBlip(currentMissionBlip)
                    end
                    local patient = GetPlayerPed(GetPlayerFromServerId(currentMissions.id))
                    local pos = {x=currentMissions.pos[1],y=currentMissions.pos[2],z=currentMissions.pos[3]}

                    if patient ~= nil and patient ~= 0 and patient ~= GetPlayerPed(-1) then
                        pos = GetEntityCoords(patient)
                    end

                    currentMissionBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
                    SetBlipAsShortRange(currentMissionBlip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Patient")
                    EndTextCommandSetBlipName(currentMissionBlip)

                    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos.x, pos.y, pos.z, false)

                    if distance < 13.0 then
                        DrawMarker(1,pos.x, pos.y, 0.0 , 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 350.0, 0, 155, 255, 64, 0, 0, 0, 0)
                    end
                    if distance < 3.0 then

                        if tostring(currentMissions.type) == "is in a coma!" then
                            dht('Press ~g~E~w~ to revive player')
                            if (IsControlJustReleased(1, 51)) then
                                TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                                Citizen.Wait(8000)
                                ClearPedTasks(GetPlayerPed(-1));
                                TriggerServerEvent("paramedic:revive", currentMissions.id)
                                TriggerEvent("paramedic:finish_mission")
                            end
                        else
                            TriggerEvent("paramedic:finish_mission")
                        end
                    end
                else
                    if currentMissionBlip ~= nil then
                        RemoveBlip(currentMissionBlip)
                    end
                end
            end
        end
    end
end)
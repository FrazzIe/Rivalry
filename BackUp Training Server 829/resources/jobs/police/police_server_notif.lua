function closures_police_server()
    local listMissions = {}
    local listPersonnelActive = {}
    local acceptMulti = true
    local preFixEventName = 'police'

    local CALL_INFO_WAIT = 2 
    local CALL_INFO_OK = 1
    local CALL_INFO_NONE = 0

    -- Notifyle changement de status des missions
    function POLICE_notifyMissionChange(target)
        target = target or -1
        TriggerClientEvent(preFixEventName .. ':MissionChange', target, listMissions)
    end

    function POLICE_notifyMissionCancel(source)
        TriggerClientEvent(preFixEventName .. ':MissionCancel', source)
    end

    -- Notify le changement de status des missions
    function POLICE_notifyPersonnelChange(target)
        target = target or -1
        TriggerClientEvent(preFixEventName .. ':personnelChange', target,  POLICE_getNbPerosnnelActive(), POLICE_getNbPerosnnelDispo())
     end

    -- Notify un message a tout les personnels
    function POLICE_notifyAllPersonnel(MESS)
        TriggerClientEvent(preFixEventName .. ':PersonnelMessage', -1, MESS)
    end

    -- Notify un message un personnel
    function POLICE_notifyPersonnel(source, MESS)
        TriggerClientEvent(preFixEventName .. ':PersonnelMessage', source, MESS)
    end

    -- Notify un message un client
    function POLICE_notifyClient(source, MESS)
        TriggerClientEvent(preFixEventName .. ':ClientMessage', source, MESS)
    end

    -- Not use || Notify a message a tout le monde
    function POLICE_notifyAllClient(MESS)
        TriggerClientEvent(preFixEventName .. ':ClientMessage', -1 , MESS)
    end

    -- Notify call status change
    function POLICE_notifyCallStatus(source, status)
        TriggerClientEvent(preFixEventName .. ':callStatus', source, status)
    end

    function POLICE_addMission(source, position, type)
        local sMission = listMissions[source]
        if sMission == nil then
            listMissions[source] = {
                id = source,
                pos = position,
                acceptBy = {},
                type = type
            }

            POLICE_notifyClient(source, 'CALL_RECU')
            POLICE_notifyCallStatus(source, CALL_INFO_WAIT)
            POLICE_notifyAllPersonnel('MISSION_NEW')
            POLICE_notifyMissionChange()
        else -- Missions deja en cours
            POLICE_notifyClient(source, 'CALL_EN_COURS')
        end
    end

    function POLICE_closeMission(source, missionId)
        if listMissions[missionId] ~= nil then
            for _, v in pairs(listMissions[missionId].acceptBy) do 
                if v ~= source then
                    POLICE_notifyPersonnel(v, 'MISSION_ANNULE')
                    notifyMissionCancel(v)
                end
                POLICE_setInactivePersonnel(v)
            end
            listMissions[missionId] = nil
            POLICE_notifyClient(missionId, 'CALL_FINI')
            POLICE_notifyCallStatus(missionId, CALL_INFO_NONE)
            POLICE_notifyMissionChange()
            POLICE_notifyPersonnelChange()
        end
    end

    function POLICE_personelAcceptMission(source, missionId)
        local sMission = listMissions[missionId]
        if sMission == nil then
            POLICE_notifyPersonnel(source,'MISSION_INCONNU')
        elseif #sMission.acceptBy ~= 0  and not acceptMulti then 
            POLICE_notifyPersonnel(source, 'MISSION_EN_COURS')
        else
            POLICE_removePersonel(source)
            if #sMission.acceptBy >= 1 then
                if sMission.acceptBy[1] ~= source then
                    for _, m in pairs(sMission.acceptBy) do
                        POLICE_notifyPersonnel(m, 'MISSION_CONCURENCE')
                    end
                    table.insert(sMission.acceptBy, source)
                end
            else
                table.insert(sMission.acceptBy, source)
                POLICE_notifyClient(sMission.id, 'CALL_ACCEPT_P')
                POLICE_notifyPersonnel(source, 'MISSION_ACCEPT')
            end
            TriggerClientEvent(preFixEventName .. ':MissionAccept', source, sMission)
            POLICE_notifyCallStatus(missionId, CALL_INFO_OK)
            POLICE_setActivePersonnel(source)
            POLICE_notifyMissionChange()
            POLICE_notifyPersonnelChange()
        end
    end

    function POLICE_removePersonel(personnelId)
        for _, mission in pairs(listMissions) do 
            for k, v in pairs(mission.acceptBy) do 
                if v == personnelId then
                    table.remove(mission.acceptBy, k)
                    if #mission.acceptBy == 0 then
                        POLICE_notifyClient(mission.id, 'CALL_CANCEL')
                        TriggerClientEvent(preFixEventName .. ':callStatus', mission.id, 2)
                        POLICE_notifyCallStatus(mission.id, CALL_INFO_WAIT)
                        POLICE_notifyAllPersonnel('MISSION_NEW')
                    end
                    break
                end
            end
        end
        POLICE_removePersonelService(personnelId)
        POLICE_notifyPersonnelChange()
    end

    function POLICE_removeClient(clientId)
        if listMissions[clientId] ~= nil then
            for _, v in pairs(listMissions[clientId].acceptBy) do 
                POLICE_notifyPersonnel(v, 'MISSION_ANNULE')
                notifyMissionCancel(v)
                POLICE_setInactivePersonnel(v)
            end
            listMissions[clientId] = nil
            POLICE_notifyCallStatus(clientId, CALL_INFO_NONE)
            POLICE_notifyMissionChange()
            POLICE_notifyPersonnelChange()
        end
    end


    --=========================================================================
    --  Gestion des personnels en service & activité
    --=========================================================================

    function POLICE_addPersonelService(source)
        listPersonnelActive[source] = false
    end
    
    function POLICE_removePersonelService(source)
        listPersonnelActive[source] = nil
    end

    function POLICE_setActivePersonnel(source)
        listPersonnelActive[source] = true
        
    end

    function POLICE_setInactivePersonnel(source)
        listPersonnelActive[source] = false
    end

    function POLICE_getNbPerosnnelActive()
        local dispo = 0
        for _, v in pairs(listPersonnelActive) do 
            dispo = dispo + 1
        end
        return dispo
    end

    function POLICE_getNbPerosnnelDispo()
        local dispo = 0
        for _, v in pairs(listPersonnelActive) do 
            if v == false then
                dispo = dispo + 1
            end
        end
        return dispo
    end

    function POLICE_getNbPerosnnelBusy()
        local dispo = 0
        for _, v in pairs(listPersonnelActive) do 
            if v == true then
                dispo = dispo + 1
            end
        end
        return dispo
    end


    RegisterServerEvent(preFixEventName .. ':takeService')
    AddEventHandler(preFixEventName .. ':takeService', function ()
        POLICE_addPersonelService(source)
        POLICE_notifyPersonnelChange()
    end)

    RegisterServerEvent(preFixEventName .. ':breakService')
    AddEventHandler(preFixEventName .. ':breakService', function ()
        POLICE_removePersonel(source)
        POLICE_removePersonelService(source)
    end)

    RegisterServerEvent(preFixEventName .. ':requestMission')
    AddEventHandler(preFixEventName .. ':requestMission', function ()
        POLICE_notifyMissionChange(source)
    end)

    RegisterServerEvent(preFixEventName .. ':requestPersonnel')
    AddEventHandler(preFixEventName .. ':requestPersonnel', function ()
        POLICE_notifyPersonnelChange(source)
    end)

    RegisterServerEvent(preFixEventName .. ':Call')
    AddEventHandler(preFixEventName .. ':Call', function (posX,posY,posZ,type)
        POLICE_addMission(source, {posX, posY, posZ}, type)
    end)

    RegisterServerEvent(preFixEventName .. ':CallCancel')
    AddEventHandler(preFixEventName .. ':CallCancel', function ()
        POLICE_removeClient(source)
    end)

    RegisterServerEvent(preFixEventName .. ':AcceptMission')
    AddEventHandler(preFixEventName .. ':AcceptMission', function (id)
        POLICE_personelAcceptMission(source, id)
    end)

    RegisterServerEvent(preFixEventName .. ':FinishMission')
    AddEventHandler(preFixEventName .. ':FinishMission', function (id)
        POLICE_closeMission(source, id)
    end)

    RegisterServerEvent(preFixEventName .. ':cancelCall')
    AddEventHandler(preFixEventName .. ':cancelCall', function ()
        POLICE_removeClient(source)
    end)

    AddEventHandler('playerDropped', function()
        POLICE_removePersonel(source)
        POLICE_removeClient(source)
    end)


end

closures_police_server()

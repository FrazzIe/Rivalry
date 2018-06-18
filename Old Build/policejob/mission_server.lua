--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
function activateMissionSystem()
    local availableMissions = {}
    local activeCops = {}
    local acceptMultiple = true
    local callstatus = {
        onHold = 2,
        accepted = 1,
        none = 0,
    }

    function ms_setMission(target)
        target = target or -1
        TriggerClientEvent('police:changeMission', target, availableMissions)
    end

    function ms_cancelMission(source)
        TriggerClientEvent('police:cancelMission', source)
    end

    function ms_updateCops(target)
        target = target or -1
        TriggerClientEvent('police:updateactiveCops', target,  ms_getAllCops(), ms_getAvailableCops())
     end

    function ms_messageCops(msg)
        TriggerClientEvent('police:notifyallCops', -1, msg)
    end

    function ms_messageCop(source, msg)
        TriggerClientEvent('police:notifyallCops', source, msg)
    end

    function ms_messageClient(source, msg)
        TriggerClientEvent('police:notifyClient', source, msg)
    end

    function ms_messageClients(msg)
        TriggerClientEvent('police:notifyClient', -1 , msg)
    end

    function ms_setCallstatus(source, status)
        TriggerClientEvent('police:callStatus', source, status)
    end

    function ms_addMission(source, position, reason)
        local sMission = availableMissions[source]
        if sMission == nil then
            availableMissions[source] = {
                id = source,
                name = GetPlayerName(source),
                pos = position,
                acceptBy = {},
                type = reason
            }
            ms_messageClient(source, 'Confirmation\nYour call has been registered')
            ms_setCallstatus(source, callstatus.onHold)
            ms_messageCops('A new alert has been posted, it has been added to your list of missions')
            ms_setMission()
        else
            ms_messageClient(source, 'You already have a request ...')
        end
    end

    function ms_closeMission(source, missionId)
        if availableMissions[missionId] ~= nil then
            for _, v in pairs(availableMissions[missionId].acceptBy) do 
                if v ~= source then
                    ms_messageCop(v, 'Your customer has canceled')
                    ms_cancelMission(v)
                end
                ms_setCopAvailable(v)
            end
            availableMissions[missionId] = nil
            ms_messageClient(missionId, 'Your call has been resolved')
            ms_setCallstatus(missionId, callstatus.none)
            ms_setMission()
            ms_updateCops()
        end
    end

    function ms_acceptMission(source, missionId)
        local sMission = availableMissions[missionId]
        if sMission == nil then
            ms_messageCop(source,'The mission is no longer available')
        elseif #sMission.acceptBy ~= 0  and not acceptMultiple then 
            ms_messageCop(source, 'This mission is already under way')
        else
            ms_exitMission(source)
            if #sMission.acceptBy >= 1 then
                if sMission.acceptBy[1] ~= source then
                    for _, m in pairs(sMission.acceptBy) do
                        ms_messageCop(m, 'You are several on the go')
                    end
                    table.insert(sMission.acceptBy, source)
                end
            else
                table.insert(sMission.acceptBy, source)
                ms_messageClient(sMission.id, 'Your call has been accepted, a Policeman is on the way')
                ms_messageCop(source, 'Mission accepted, get started')
            end
            TriggerClientEvent('police:acceptMission', source, sMission)
            ms_setCallstatus(missionId, callstatus.accepted)
            ms_setCopBusy(source)
            ms_setMission()
            ms_updateCops()
        end
    end

    function ms_exitMission(personnelId)
        for _, mission in pairs(availableMissions) do 
            for k, v in pairs(mission.acceptBy) do 
                if v == personnelId then
                    table.remove(mission.acceptBy, k)
                    if #mission.acceptBy == 0 then
                        ms_messageClient(mission.id, 'The policeman has just abandoned your call')
                        TriggerClientEvent('police:callStatus', mission.id, 2)
                        ms_setCallstatus(mission.id, callstatus.onHold)
                        ms_messageCops('A new alert has been posted, it has been added to your list of missions')
                    end
                    break
                end
            end
        end
        ms_removeCop(personnelId)
        ms_updateCops()
    end

    function ms_cancelMissionclient(clientId)
        if availableMissions[clientId] ~= nil then
            for _, v in pairs(availableMissions[clientId].acceptBy) do 
                ms_messageCop(v, 'Your customer has canceled')
                ms_cancelMission(v)
                ms_setCopAvailable(v)
            end
            availableMissions[clientId] = nil
            ms_setCallstatus(clientId, callstatus.none)
            ms_setMission()
            ms_updateCops()
        end
    end

    function ms_addCop(source)
        activeCops[source] = false
    end
    
    function ms_removeCop(source)
        activeCops[source] = nil
    end

    function ms_setCopBusy(source)
        activeCops[source] = true        
    end

    function ms_setCopAvailable(source)
        activeCops[source] = false
    end

    function ms_getAllCops()
        local count = 0
        for _, v in pairs(activeCops) do 
            count = count + 1
        end
        return count
    end

    function ms_getAvailableCops()
        local count = 0
        for _, v in pairs(activeCops) do 
            if v == false then
                count = count + 1
            end
        end
        return count
    end

    function ms_getBusyCops()
        local count = 0
        for _, v in pairs(activeCops) do 
            if v == true then
                count = count + 1
            end
        end
        return count
    end


    RegisterServerEvent('police:setService')
    AddEventHandler('police:setService', function(isInService)
        local source = source
        if isInService then
            ms_addCop(source)
            ms_updateCops()
        else
            ms_exitMission(source)
            ms_removeCop(source)
        end
    end)

    RegisterServerEvent('police:requestMission')
    AddEventHandler('police:requestMission', function ()
        ms_setMission(source)
    end)

    RegisterServerEvent('police:getactiveCops')
    AddEventHandler('police:getactiveCops', function ()
        ms_updateCops(source)
    end)

    RegisterServerEvent('police:Call')
    AddEventHandler('police:Call',function(posX,posY,posZ,type)
        ms_addMission(source, {posX, posY, posZ}, type)
    end)

    RegisterServerEvent('police:CallCancel')
    AddEventHandler('police:CallCancel', function ()
        ms_cancelMissionclient(source)
    end)

    RegisterServerEvent('police:acceptMission')
    AddEventHandler('police:acceptMission', function (id)
        ms_acceptMission(source, id)
    end)

    RegisterServerEvent('police:finishMission')
    AddEventHandler('police:finishMission', function (id)
        ms_closeMission(source, id)
    end)

    RegisterServerEvent('police:cancelCall')
    AddEventHandler('police:cancelCall', function ()
        local source = source
        ms_cancelMissionclient(source)
    end)

    AddEventHandler('playerDropped', function()
        ms_exitMission(source)
        ms_cancelMissionclient(source)
    end)
    AddEventHandler('police:getCops',function(cb)
        cb(ms_getAllCops())
    end)
end

activateMissionSystem()
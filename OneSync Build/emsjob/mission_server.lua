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
    local activeMedics = {}
    local acceptMultiple = true
    local callstatus = {
        onHold = 2,
        accepted = 1,
        none = 0,
    }

    function ms_setMission(target)
        target = target or -1
        TriggerClientEvent('paramedic:changeMission', target, availableMissions)
    end

    function ms_cancelMission(source)
        TriggerClientEvent('paramedic:cancelMission', source)
    end

    function ms_updateMedics(target)
        target = target or -1
        TriggerClientEvent('paramedic:updateactiveMedics', target,  ms_getAllMedics(), ms_getAvailableMedics())
     end

    function ms_messageMedics(msg)
        TriggerClientEvent('paramedic:notifyallMedics', -1, msg)
    end

    function ms_messageMedic(source, msg)
        TriggerClientEvent('paramedic:notifyallMedics', source, msg)
    end

    function ms_messageClient(source, msg)
        TriggerClientEvent('paramedic:notifyClient', source, msg)
    end

    function ms_messageClients(msg)
        TriggerClientEvent('paramedic:notifyClient', -1 , msg)
    end

    function ms_setCallstatus(source, status)
        TriggerClientEvent('paramedic:callStatus', source, status)
    end

    function ms_addMission(source, position, reason)
        local sMission = availableMissions[source]
        if sMission == nil then
            availableMissions[source] = {
                id = source,
                name = "["..source.."]",
                pos = position,
                acceptBy = {},
                type = reason
            }
            ms_messageClient(source, 'Confirmation\nYour call has been registered')
            ms_setCallstatus(source, callstatus.onHold)
            ms_messageMedics('Someone is critically injured! Check your missions and respond!')
            ms_setMission()
        else
            ms_messageClient(source, 'You have already placed a call...')
        end
    end

    function ms_closeMission(source, missionId)
        if availableMissions[missionId] ~= nil then
            for _, v in pairs(availableMissions[missionId].acceptBy) do 
                if v ~= source then
                    ms_messageMedic(v, 'Your customer has canceled')
                    ms_cancelMission(v)
                end
                ms_setMedicAvailable(v)
            end
            availableMissions[missionId] = nil
            ms_messageClient(missionId, 'Your call has been resolved')
            ms_setCallstatus(missionId, callstatus.none)
            ms_setMission()
            ms_updateMedics()
        end
    end

    function ms_acceptMission(source, missionId)
        local sMission = availableMissions[missionId]
        if sMission == nil then
            ms_messageMedic(source, 'Another paramedic resolved this call')
        elseif #sMission.acceptBy ~= 0  and not acceptMultiple then 
            ms_messageMedic(source, "You're already responding to this call")
        else
            ms_exitMission(source)
            if #sMission.acceptBy >= 1 then
                if sMission.acceptBy[1] ~= source then
                    for _, m in pairs(sMission.acceptBy) do
                        ms_messageMedic(m, 'An additional paramedic is responding!')
                        ms_messageClient(sMission.id, "An additional paramedic is responding!")
                    end
                    table.insert(sMission.acceptBy, source)
                end
            else
                table.insert(sMission.acceptBy, source)
                ms_messageClient(sMission.id, 'Your call has been accepted, a Paramedic is on the way')
                ms_messageMedic(source, 'Call Accepted. Your GPS has been updated!')
            end
            TriggerClientEvent('paramedic:acceptMission', source, sMission)
            ms_setCallstatus(missionId, callstatus.accepted)
            ms_setMedicBusy(source)
            ms_setMission()
            ms_updateMedics()
        end
    end

    function ms_exitMission(personnelId)
        for _, mission in pairs(availableMissions) do 
            for k, v in pairs(mission.acceptBy) do 
                if v == personnelId then
                    table.remove(mission.acceptBy, k)
                    if #mission.acceptBy == 0 then
                        ms_messageClient(mission.id, 'The responding paramedic was re-assigned. Your call has been placed back in queue.')
                        TriggerClientEvent('paramedic:callStatus', mission.id, 2)
                        ms_setCallstatus(mission.id, callstatus.onHold)
                        ms_messageMedics('Someone is critically injured! Check your missions and respond!')
                    end
                    break
                end
            end
        end
        ms_removeMedic(personnelId)
        ms_setMission()
        ms_updateMedics()
    end

    function ms_cancelMissionclient(clientId)
        if availableMissions[clientId] ~= nil then
            for _, v in pairs(availableMissions[clientId].acceptBy) do 
                ms_messageMedic(v, 'Your customer s\'has canceled')
                ms_cancelMission(v)
                ms_setMedicAvailable(v)
            end
            availableMissions[clientId] = nil
            ms_setCallstatus(clientId, callstatus.none)
            ms_setMission()
            ms_updateMedics()
        end
    end

    function ms_addMedic(source)
        activeMedics[source] = false
    end
    
    function ms_removeMedic(source)
        activeMedics[source] = nil
    end

    function ms_setMedicBusy(source)
        activeMedics[source] = true        
    end

    function ms_setMedicAvailable(source)
        activeMedics[source] = false
    end

    function ms_getAllMedics()
        local count = 0
        for _, v in pairs(activeMedics) do 
            count = count + 1
        end
        return count
    end

    function ms_getAvailableMedics()
        local count = 0
        for _, v in pairs(activeMedics) do 
            if v == false then
                count = count + 1
            end
        end
        return count
    end

    function ms_getBusyMedics()
        local count = 0
        for _, v in pairs(activeMedics) do 
            if v == true then
                count = count + 1
            end
        end
        return count
    end


    RegisterServerEvent('paramedic:setService')
    AddEventHandler('paramedic:setService', function (isInService)
        local source = source
        if isInService then
            ms_addMedic(source)
            ms_updateMedics()
            ms_setMission()
        else
            ms_exitMission(source)
            ms_removeMedic(source)
            ms_updateMedics()
        end
    end)

    RegisterServerEvent('paramedic:requestMission')
    AddEventHandler('paramedic:requestMission', function ()
        local source = source
        ms_setMission(source)
    end)

    RegisterServerEvent('paramedic:getactiveMedics')
    AddEventHandler('paramedic:getactiveMedics', function ()
        local source = source
        ms_updateMedics(source)
    end)

    RegisterServerEvent('paramedic:Call')
    AddEventHandler('paramedic:Call',function(posX,posY,posZ,type)
        local source = source
        ms_addMission(source, {posX, posY, posZ}, type)
    end)

    RegisterServerEvent('paramedic:CallCancel')
    AddEventHandler('paramedic:CallCancel', function ()
        local source = source
        ms_cancelMissionclient(source)
    end)

    RegisterServerEvent('paramedic:acceptMission')
    AddEventHandler('paramedic:acceptMission', function (id)
        local source = source
        ms_acceptMission(source, id)
    end)

    RegisterServerEvent('paramedic:finishMission')
    AddEventHandler('paramedic:finishMission', function (id)
        local source = source
        ms_closeMission(source, id)
    end)

    RegisterServerEvent('paramedic:cancelCall')
    AddEventHandler('paramedic:cancelCall', function ()
        local source = source
        ms_cancelMissionclient(source)
    end)

    RegisterServerEvent('paramedic:respawn')
    AddEventHandler('paramedic:respawn', function()
        local source = tonumber(source)
        local online = ms_getAllMedics()
        if online == 0 then
            ms_cancelMissionclient(source)
            TriggerClientEvent("paramedic:respawn", source)
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = GetPlayerName(source).." you cannot instantly respawn as there are "..online.." paramedic(s) online!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
        end
    end)

    RegisterServerEvent('paramedic:respawn_rip')
    AddEventHandler('paramedic:respawn_rip', function(seconds)
        local source = tonumber(source)
        local online = ms_getAllMedics()
        if seconds ~= nil then
            if seconds > 0 then
                if online == 0 then
                    ms_cancelMissionclient(source)
                    TriggerClientEvent("paramedic:respawn", source)
                end
            else
                if online == 0 then
                    ms_cancelMissionclient(source)
                    TriggerClientEvent("paramedic:respawn", source)
                else
                    ms_cancelMissionclient(source)
                    TriggerClientEvent("paramedic:respawn", source)
                    TriggerEvent('core:getuser', source, function(user)
                        user.wallet(0)
                        user.dirty(0)
                    end)
                    TriggerEvent("weapon:delete", source)
                    TriggerEvent("inventory:delete", source)
                end
            end
        else
            if online == 0 then
                ms_cancelMissionclient(source)
                TriggerClientEvent("paramedic:respawn", source)
            else
                ms_cancelMissionclient(source)
                TriggerClientEvent("paramedic:respawn", source)
                TriggerEvent('core:getuser', source, function(user)
                    user.wallet(0)
                    user.dirty(0)
                end)
                TriggerEvent("weapon:delete", source)
                TriggerEvent("inventory:delete", source)
            end
        end
    end)

--[[
    RegisterServerEvent('paramedic:respawn_rip')
    AddEventHandler('paramedic:respawn_rip', function(seconds)
        local source = tonumber(source)
        if seconds ~= nil then
            if seconds > 0 then
                local online_ems = ms_getAllMedics()
                local online_cops = nil
                TriggerEvent("police:getCops", function(cops)
                    if cops then
                        online_cops = cops
                    else
                        online_cops = 0
                    end
                    if online_ems == 0 and online_cops == 0 then
                        ms_cancelMissionclient(source)
                        TriggerClientEvent("paramedic:respawn", source)
                    end
                end)
            else
                local online_ems = ms_getAllMedics()
                local online_cops = nil
                TriggerEvent("police:getCops", function(cops)
                    if cops then
                        online_cops = cops
                    else
                        online_cops = 0
                    end
                    if online_ems == 0 and online_cops == 0 then
                        ms_cancelMissionclient(source)
                        TriggerClientEvent("paramedic:respawn", source)
                    else
                        TriggerEvent('core:getuser', source, function(user)
                            user.wallet(0)
                            user.dirty(0)
                        end)
                        TriggerEvent("weapon:delete", source)
                        TriggerEvent("inventory:delete", source)
                        ms_cancelMissionclient(source)
                        TriggerClientEvent("paramedic:respawn", source)
                    end
                end)
            end
        else
            local online_ems = ms_getAllMedics()
            local online_cops = nil
            TriggerEvent("police:getCops", function(cops)
                if cops then
                    online_cops = cops
                else
                    online_cops = 0
                end
                if online_ems == 0 and online_cops == 0 then
                    ms_cancelMissionclient(source)
                    TriggerClientEvent("paramedic:respawn", source)
                else
                    TriggerEvent('core:getuser', source, function(user)
                        user.wallet(0)
                        user.dirty(0)
                    end)
                    TriggerEvent("weapon:delete", source)
                    TriggerEvent("inventory:delete", source)
                    ms_cancelMissionclient(source)
                    TriggerClientEvent("paramedic:respawn", source)
                end
            end)
        end
    end)
--]]

    RegisterServerEvent('paramedic:doa')
    AddEventHandler('paramedic:doa', function(target)
        local source = tonumber(source)
        if ems[source] or exports["policejob"]:GetCop(source) then
            ms_cancelMissionclient(target)
            TriggerEvent('core:getuser', target, function(t)
                t.wallet(0)
                t.dirty(0)
                TriggerClientEvent("pNotify:SendNotification", target, {text = t.get("first_name").." "..t.get("last_name").." you were pronounced dead on arrival! <br>So your cash, weapons and inventory have been wiped.",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
            end)
            TriggerEvent("weapon:delete", target)
            TriggerEvent("inventory:delete", target)
            TriggerClientEvent("paramedic:respawn", target)
            TriggerEvent('core:getuser', source, function(user)
                local pay = math.random(50,100)
                user.addWallet(pay)
                TriggerClientEvent("pNotify:SendNotification", source, {text = user.get("first_name").." "..user.get("last_name").." you have been paid <span style='color:lime'>$</span><span style='color:white'>"..pay.."</span> for doing the best you could!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
            end)
        else
            TriggerEvent("core:anticheat-ban", source)
        end
    end)

    RegisterServerEvent("paramedic:revive")
    AddEventHandler("paramedic:revive",function(target)
        local source = tonumber(source)
        TriggerEvent("police:iscop", source, function(ispolice)
            if ems[source] or ispolice then
                ms_cancelMissionclient(target)
                TriggerClientEvent("paramedic:heal", tonumber(target))
                TriggerClientEvent("Recieved.Medical.Attention", tonumber(target))
                TriggerEvent('core:getuser', source, function(user)
                    local pay = 250
                    user.addWallet(pay)
                    TriggerClientEvent("pNotify:SendNotification", source, {text = user.get("first_name").." "..user.get("last_name").." you have been paid <span style='color:lime'>$</span><span style='color:white'>"..math.floor(pay).."</span> for rescuing "..GetIdentity(target).."!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
                end)
            else
                TriggerEvent("core:anticheat-ban", source)
            end
        end)
    end)

    RegisterServerEvent("medkit:revive")
    AddEventHandler("medkit:revive",function(target)
        local source = tonumber(source)
        TriggerClientEvent("paramedic:heal", tonumber(target))
    end)

    AddEventHandler('playerDropped', function()
        local source = source
        ms_exitMission(source)
        ms_cancelMissionclient(source)
        ms_removeMedic(source)
        ms_updateMedics()
    end)

    AddEventHandler("core:switch", function(source)
        local source = source
        ms_exitMission(source)
        ms_cancelMissionclient(source)
        ms_removeMedic(source)
        ms_updateMedics()
    end)
end

activateMissionSystem()

RegisterServerEvent("emsjob:payforservices")
AddEventHandler("emsjob:payforservices", function(Price)
    local Source = source
    TriggerEvent('core:getuser', Source, function(User)
        User.removeBank(Price)
    end)
end)
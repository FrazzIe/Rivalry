--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local JailedPlayers = {}
local LastJailbreak = 0

RegisterServerEvent('jail:payout')
AddEventHandler('jail:payout', function(amount)
    TriggerEvent("core:getuser", source, function(user)
        user.addWallet(amount)
        TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "~s~Payment Recieved: ~g~$~s~"..amount.."")
    end)
end)

RegisterServerEvent("AddJailedPlayer")
AddEventHandler("AddJailedPlayer", function()
    table.insert(JailedPlayers, source)
end)

RegisterServerEvent("RemoveJailedPlayer")
AddEventHandler("RemoveJailedPlayer", function(TargetID)
    if TargetID then
        for Index = 1, #JailedPlayers do
            if JailedPlayers[Index] == TargetID then
                table.remove(JailedPlayers, Index)
            end
        end
    end
end)

RegisterServerEvent("Jailbreak.Start")
AddEventHandler("Jailbreak.Start", function()
    local Source = source
    if LastJailbreak == 0 then
        TriggerClientEvent("Jailbreak.Start")
        TriggerEvent("Dispatch.Jailbreak")
        LastJailbreak = os.time()
    else
        if (os.time() - LastJailbreak) < (Cooldown*60) and LastJailbreak ~= 0 then
            TriggerClientEvent("pNotify:SendNotification", Source, {text = "THe prison is currently under lockdown due to a recent jailbreak!",type = "error", queue = "left",timeout = 10000,layout = "bottomCenter"})
        else
            TriggerClientEvent("Jailbreak.Start")
            TriggerEvent("Dispatch.Jailbreak")
            LastJailbreak = os.time() 
        end
    end
end)

RegisterServerEvent("Jailbreak.Complete")
AddEventHandler("Jailbreak.Complete", function()
    local Source = source
    for Index = 1, #JailedPlayers do
        JailedPlayers[Index].set("jail_time", 0)
        TriggerClientEvent("jail:unjail", JailedPlayers[Index])
        table.remove(JailedPlayers, Index)
    end
end)

AddEventHandler("jail:initialise", function(source, time)
    local source = source
    if tonumber(time) > 0 then
        TriggerClientEvent("jail:jail", source , tonumber(time) * 60)
    end
end)

TriggerEvent("core:addGroupCommand", "jail", "emergency", function(source, args, rawCommand, data, power, group)
    if #args < 3 then
        TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /jail [ID] [TIME] [REASON]") 
    else
        if GetPlayerName(tonumber(args[1])) then
            if tonumber(args[2]) ~= nil then
                if tostring(args[3]) ~= nil then
                    TriggerEvent("core:getuser", tonumber(tonumber(args[1])), function(target)
                        TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been jailed. <br> Time: <span style='color:lime'>".. tonumber(args[2]) .."</span> months <br> Charges: <span style='color:lime'>".. table.concat(args, " ", 3) .."</span>", type = "error", queue = "left", timeout = 15000, layout = "bottomRight"})
                        TriggerClientEvent("pNotify:SendNotification", tonumber(args[1]), {text = "You have arrived at the San Andreas Bolingbroke Penitentiary...",type = "error", queue = "left",timeout = 10000,layout = "bottomCenter"})
                        TriggerClientEvent("jail:jail", tonumber(args[1]) , tonumber(args[2]) * 60)
                        target.set("jail_time", tonumber(args[2]) * 60)
                    end)
                else
                    TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /jail [ID] [TIME] [REASON]") 
                end
            else
                TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /jail [ID] [TIME] [REASON]") 
            end
        else
            TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /jail [ID] [TIME] [REASON]") 
        end
    end
end, {help = "Jail a shitlord", params = {{name = "id", help = "The id of the shitlord"},{name = "time", help = "The amount of time"},{name = "reason", help = "Why are they being jailed?"}}})

TriggerEvent("core:addGroupCommand", "unjail", "emergency", function(source, args, rawCommand, data, power, group)
    if #args ~= 1 then
        TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /unjail [ID]") 
    else
        if GetPlayerName(args[1]) then
            TriggerEvent("core:getuser", tonumber(args[1]), function(target)
                TriggerClientEvent("jail:unjail", tonumber(args[1]))
                target.set("jail_time", 0)
            end)
        else
            TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /unjail [ID]") 
        end
    end
end,{help = "unjail a shitlord", params = {{name = "id", help = "The id of the shitlord"}}})

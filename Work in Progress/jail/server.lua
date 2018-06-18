--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
AddEventHandler("jail:initialise", function(source, time)
    local source = source
    if tonumber(time) > 0 then
        TriggerClientEvent("jail:jail", source , tonumber(time))
    end
end)

RegisterServerEvent('allPlayers')
AddEventHandler('allPlayers', function()
    local players = GetPlayers()
    TriggerClientEvent('allPlayersCB', players)
end)

TriggerEvent("core:addGroupCommand", "jail", "emergency", function(source, args, rawCommand, data, power, group)
    if #args < 3 then
        TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /jail [ID] [TIME] [REASON]") 
    else
        if GetPlayerName(tonumber(args[1])) then
            if tonumber(args[2]) ~= nil then
                if tostring(args[3]) ~= nil then
                    TriggerEvent("core:getuser", tonumber(tonumber(args[1])), function(target)
                        TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been jailed. <br> Time: <span style='color:lime'>".. tonumber(args[2]) .."</span> Seconds <br> Charges: <span style='color:lime'>".. table.concat(args, " ", 3) .."</span>", type = "error", queue = "left", timeout = 10000, layout = "bottomRight"})
                        TriggerClientEvent("pNotify:SendNotification", tonumber(args[1]), {text = "Your weapons have been confiscated!",type = "error", queue = "left",timeout = 10000,layout = "bottomCenter"})
                        TriggerClientEvent("jail:jail", tonumber(args[1]) , tonumber(args[2]))
                        target.set("jail_time", tonumber(args[2]))
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
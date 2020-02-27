--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]

local Twitter = {}

AddEventHandler("playerDropped", function()
    local source = source
    if Twitter[source] then
        Twitter[source] = nil
    end
end)

AddEventHandler('chatMessage', function(source, author, message)
    local source = tonumber(source)
    local args = stringsplit(message, " ")
    CancelEvent()
    if args[1] then
        if not string.find(args[1], "/") then
            TriggerEvent("core:getuser", source, function(character, user)
                if user ~= nil then
                    local template = user.get("group") or "user"
                    TriggerClientEvent("prox_chatMessageLOOC", -1, source, "", message)
                end
            end)
        end
    end
end)

TriggerEvent('core:addCommand', 'ooc', function(source, args, rawCommand, data)
    local message = table.concat(args, " ")
    local author = GetPlayerName(source)
    TriggerEvent("core:getuser", source, function(character, user)
        if user ~= nil then
            local template = user.get("group") or "user"
            TriggerClientEvent("chat:addMessage", -1, {templateId = template, color = {30, 144, 255}, multiline = true, args = {"^0[^3"..source.."^0]^8"..author, message}})
        end
    end)

end, {help = "Out of character chat"})

-- TriggerEvent('core:addCommand', 'tweet', function(source, args, rawCommand, data)
--     local message = table.concat(args, " ")
--     local author = data.get("first_name").." "..data.get("last_name")
--     TriggerEvent("Phone.Get", source, function(Phone)
--         if Phone then
--             if Phone.Has then
--                 if Twitter[source] then
--                     TriggerClientEvent("twitter:message", -1, {templateId = "tweet", color = {255, 255, 255}, multiline = true, args = {author, message}})
--                 end
--             else
--                 TriggerClientEvent('chatMessage', source, "ERROR", {0, 255, 0}, "You don't have a phone!")
--             end
--         else
--             TriggerClientEvent('chatMessage', source, "ERROR", {0, 255, 0}, "You don't have a phone!")
--         end
--     end)
-- end, {help = "Post a tweet"})

-- TriggerEvent('core:addCommand', 't', function(source, args, rawCommand, data)
--     local message = table.concat(args, " ")
--     local author = data.get("first_name").." "..data.get("last_name")
--     TriggerEvent("Phone.Get", source, function(Phone)
--         if Phone then
--             if Phone.Has then
--                 if Twitter[source] then
--                     TriggerClientEvent("twitter:message", -1, {templateId = "tweet", color = {255, 255, 255}, multiline = true, args = {author, message}})
--                 end
--             else
--                 TriggerClientEvent('chatMessage', source, "ERROR", {0, 255, 0}, "You don't have a phone!")
--             end
--         else
--             TriggerClientEvent('chatMessage', source, "ERROR", {0, 255, 0}, "You don't have a phone!")
--         end
--     end)
-- end, {help = "Post a tweet"})

-- TriggerEvent('core:addCommand', "twitter", function(source, args, rawCommand, data)
--     if Twitter[source] == nil then
--         Twitter[source] = true
--     end

--     TriggerEvent("Phone.Get", source, function(Phone)
--         if Phone then
--             if Phone.Has then
--                 Twitter[source] = not Twitter[source]

--                 local message = (Twitter[source] and "^*^2Activated" or "^*^1Deactivated")
--                 TriggerClientEvent("chat:addMessage", source, {templateId = "tweet", color = {255, 255, 255}, multiline = true, args = {"Twitter", message}})
--                 TriggerClientEvent("twitter:toggle", source, Twitter[source])
--             else
--                 TriggerClientEvent('chatMessage', source, "ERROR", {0, 255, 0}, "You don't have a phone!")
--                 Twitter[source] = false
--                 TriggerClientEvent("twitter:toggle", source, Twitter[source])
--             end
--         else
--             TriggerClientEvent('chatMessage', source, "ERROR", {0, 255, 0}, "You don't have a phone!")
--             Twitter[source] = false
--             TriggerClientEvent("twitter:toggle", source, Twitter[source])
--         end
--     end)
-- end, {help = "Toggle Twitter"})

TriggerEvent('core:addCommand', 'balance', function(source, args, rawCommand, data)
    local author = "$"..data.get("bank").." is your current balance."
    TriggerClientEvent('chatMessage', source, "Bank", {0, 255, 0}, author)
end, {help = "Returns Bank Balance"})

TriggerEvent('core:addCommand', 'wallet', function(source, args, rawCommand, data)
    local author = "You have $"..data.get("wallet").." in cash and $"..data.get("dirty").." in dirty cash."
    TriggerClientEvent('chatMessage', source, "Wallet", {0, 255, 0}, author)
end, {help = "Returns Cash and Dirty Cash"})

TriggerEvent('core:addCommand', 'chips', function(source, args, rawCommand, data)
    local author = "You have $"..data.get("chips").." worth of chips."
    TriggerClientEvent('chatMessage', source, "Chips", {0, 255, 0}, author)
end, {help = "Returns chip amount"})

-- TriggerEvent("core:addCommand", "ad", function(source, args, rawCommand, data, power, group)
--     local message = table.concat(args, " ")
--     TriggerEvent("Phone.Get", source, function(Phone)
--         if Phone then
--             if Phone.Has then
--                 if data.get("bank") >= 1000 then
--                     data.removeBank(1000)
--                     TriggerClientEvent('chatMessage', -1, "ADVERTISEMENT", {0, 255, 0}, message)
--                 else
--                     TriggerClientEvent('chatMessage', source, "ADVERTISEMENT", {0, 255, 0}, "The cost for an ad is $1000")
--                 end
--             else
--                 TriggerClientEvent('chatMessage', source, "ERROR", {0, 255, 0}, "You don't have a phone!")
--             end
--         else
--             TriggerClientEvent('chatMessage', source, "ERROR", {0, 255, 0}, "You don't have a phone!")
--         end
--     end)
-- end, {help = "Advertisment"})


function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
 
function ResolveSeat(InVeh, Id)
    if Id == -1 then return "Driver" end
    if (Id == 0 and InVeh) or Id ~= -1 and Id ~= 0 then return "Passenger" end
    return "Unavailable"
end

RegisterServerEvent('baseevents:onPlayerKilled')
AddEventHandler('baseevents:onPlayerKilled', function(attacker, data)
    local victim = source
    local victim_table = GetCharacter(victim)
    local victim_info = {}
    local attacker_table = GetCharacter(attacker)
    local attacker_info = {}
    if attacker_table then
        attacker_info = {
            [1] = {
                name = "Attacker - Player names",
                value = "Steam: "..(attacker_table.User.get("name") or "Null")..", Character: "..(attacker_table.Character.get("first_name") or "Null").." "..(attacker_table.Character.get("last_name") or "Null"),
            },
            [2] = {
                name = "Attacker - Identifiers",
                value = "Character Id: "..(attacker_table.Character.get("characterID") or "Null")..", Steam: "..(attacker_table.User.get("steam") or "Null")..", License: "..(attacker_table.User.get("license") or "Null"),
            },
            [3] = {
                name = "Attacker - Weapon details",
                value = "Hash: "..(data.deathreason.Hash or "Null")..", String: "..(data.deathreason.Str or "Null")..", Label: "..(data.deathreason.Label or "Null"),
            },
            [4] = {
                name = "Attacker - Extra",
                value = "In Vehicle: "..tostring(data.killerinveh)..", Seat: "..ResolveSeat(data.killerinveh, data.killervehseat)..", Vehicle name: "..(data.killervehname or "Null"),
            },
        }
    end
    if victim_table then
        victim_info = {
            [1] = {
                name = "Victim - Player names",
                value = "Steam: "..(victim_table.User.get("name") or "Null")..", Character: "..(victim_table.Character.get("first_name") or "Null").." "..(victim_table.Character.get("last_name") or "Null"),
            },
            [2] = {
                name = "Victim - Identifiers",
                value = "Character Id: "..(victim_table.Character.get("characterID") or "Null")..", Steam: "..(victim_table.User.get("steam") or "Null")..", License: "..(victim_table.User.get("license") or "Null"),
            },
        }
    end
    logkill(attacker_info, victim_info)
    --TriggerClientEvent("killfeed", -1, "^1Attacker: ^0"..(GetPlayerName(attacker) or "["..attacker.."]").." / ^1Victim: ^0"..(GetPlayerName(victim) or "["..victim.."]").." / ^1Weapon: ^0"..(data.deathreason.Str or "Null").." / ^1In Vehicle: ^0"..tostring(data.deathreason.killerinveh).." / ^1Seat: ^0"..ResolveSeat(data.deathreason.killerinveh, data.killervehseat))
end)

RegisterServerEvent("killfeed")
AddEventHandler("killfeed", function(msg)
    local source = source
    TriggerEvent("core:getuser", source, function(character, user)
        if user then
            if user.get("power") >= 3 then
                TriggerClientEvent('chatMessage', source, "^1-", {0, 255, 0}, msg)
            end
        end
    end)
end)

RegisterServerEvent("Phone.Set")
AddEventHandler("Phone.Set", function(Source, Value)
    if type(Value) == "boolean" then
        if not Value and Twitter[Source] then
            Twitter[Source] = false
            TriggerClientEvent("twitter:toggle", Source, Twitter[Source])
        end
    end
end)

AddEventHandler("Phone.Finished", function(Source, Data)
    Twitter[Source] = Data.Has

    TriggerClientEvent("twitter:toggle", Source, Twitter[Source])
end)
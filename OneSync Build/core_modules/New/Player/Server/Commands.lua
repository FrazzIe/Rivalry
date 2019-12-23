Chat.Template("showid", "<img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAE5SURBVDhPxZNfS8JQGIf3SaJv2WU30V0R/WEQUnRTbdOpre04jWYzMMECU+emm42mpkkYhEHdvHle2khWo1154OH8+HHeB3YOYxa/2NWT5TNWSUn7RIkDnaGzjJRQjb7Zhel4hIxsF4Yznp3HyK5nOCAn8i1G3M5qg1YdXj0L6Tdr0GvU4D9dek8qo+Bz0gXKxDNB5xQo8TJmv/+LkOCKJzB9EBFdIMFBq1KFcraIvLgG7m9P7bBA5yT48ESEZr8ftuvgVG/neB/bYcHlMQG3IoB7I2COJZDFAqwJKVgXuBmnmM+TeRT8/ASafXEgoBd2qOaAbRTmOFBJ5GUGgtCTNe/Dz/hLh4LMrli3igQGdxeIXcpBRyfgXKuRnakpkN5JNZitlaMlfoPP8JtJLRazGTr7/UcsbDHMF28/dfzPChDpAAAAAElFTkSuQmCC\" height=\"20\" />  <b>{0}</b>: {1}")

function FormatPhoneNumber(value)
    return "^3(^5"..value:sub(1, 3).."^3) ^5"..value:sub(4, 6).."^3-^5"..value:sub(7, 10)
end

Chat.Command({"pn", "phonenumber", "number"}, function(source, args, fullCommand)
    TriggerEvent("Phone.Get", source, function(Phone)
        if Phone then
            Chat.Message(-1, "^0-", "^5"..GetIdentity(source).."  ^0notes down "..FormatPhoneNumber(Phone.Number).." ^0and passes it to the nearest person", 48, 177, 232, true, nil, 5, source)
        else
            Chat.Message(source, "INFO", "Unable to get phone number? >.>", 255, 0, 0, true)
        end
    end)
end, false, {Help = "Share your phone number", Params = {}})

Chat.Command({"bino", "binoculars"}, function(source, args, fullCommand)
    TriggerClientEvent('toggle:binoculars', source)
end, false, {Help = "Toggle's Binoculars", Params = {}})

Chat.Command("showid", function(source, args, fullCommand)
    local license = ""
    TriggerEvent("core:getuser", source, function(user)
        if user ~= nil then
            if user.get("drivers_license") == "true" then
                license = "Valid"
            else
                license = "Suspended"
            end
            Chat.Message(-1, "", "^5First name^0: ^3"..user.get("first_name").."^0, ^5Last name^0: ^3"..user.get("last_name").."^0, ^5DOB^0: ^3"..user.get("dob").."^0, ^5Occupation^0: ^3"..user.get("job").name.."^0, ^5Drivers License^0: ^3"..license, 48, 177, 232, true, "showid", 5, source)
        else
            Chat.Message(source, "INFO", "Unable share id? >.>", 255, 0, 0, true)
        end
    end)
end, false, {Help = "Share your Identification", Params = {}})

local jailed = {}

RegisterServerEvent('drugs:sendMessage')
AddEventHandler('drugs:sendMessage', function(type)
    local source = source
    if type == "weed" then
        TriggerClientEvent("prox_chatMessageWeed", -1, source, "","**^*You smell a strong scent of Marijuana**")
    end
--[[    if type == "cocaine" then
        TriggerClientEvent("prox_chatMessage", -1, source, GetIdentity(source)," has a strong stench of cocaine coming off there clothing.")
    end--]]
end)

RegisterServerEvent('sync:jailedPlayers')
AddEventHandler('sync:jailedPlayers', function(id)
    local source = source
    table.insert(jailed, id)
end)

RegisterServerEvent('sync:jailedPlayersClearTable')
AddEventHandler('sync:jailedPlayersClearTable', function()
    local source = source
    jailed = {}
end)

RegisterServerEvent("Carry.Player")
AddEventHandler("Carry.Player", function(TargetPlayer)
    local Source = source
    TriggerClientEvent("Carry.Player", TargetPlayer, source)
end)

RegisterServerEvent("Kidnap.Player")
AddEventHandler("Kidnap.Player", function(TargetPlayer)
    local Source = source
    TriggerClientEvent("Force.Into.Trunk", TargetPlayer)
end)

RegisterServerEvent("Remove.Player.From.Trunk")
AddEventHandler("Remove.Player.From.Trunk", function(TargetPlayer)
    local Source = source
    TriggerClientEvent("Remove.Player.From.Trunk", TargetPlayer)
end)

--[[Chat.Command("whojail", function(source, args, fullCommand)
    local source = source
    Chat.Message(source, "CURRENTLY JAILED", "", 255, 0, 0, true)
    for k, v in pairs(jailed) do
        Chat.Message(source, "", "- "..GetIdentity(v), 255, 255, 255, true)
    end
    
end, false, {Help = "Lists all people who are currently incarcerated", Params = {}})--]]
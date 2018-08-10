function GetIdentifier(type, source)
    for _, Identifier in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(tostring(Identifier), 1, string.len("steam:")) == "steam:" and (type == "steam" or type == 1) then
            return Identifier
        elseif string.sub(tostring(Identifier), 1, string.len("license:")) == "license:" and (type == "license" or type == 2) then
            return Identifier
        elseif string.sub(tostring(Identifier), 1, string.len("ip:")) == "ip:" and (type == "ip" or type == 3) then
            return Identifier
        end
    end
    return nil
end

RegisterServerEvent("server:phonenumber")
AddEventHandler("server:phonenumber", function()
    local source = source
    TriggerEvent("core:getuser", source, function(user)
        local character_id = user.get("characterID")
        local currentjob = user.get("job").name
        local lastname = user.get("last_name")
        local firstname = user.get("first_name")
        local phonenumber = 0
        exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from phone WHERE character_id=@character_id", {["@character_id"] = character_id}, function(player)
            phonenumber = player.phone_number
        end)
        TriggerClientEvent("showid:phonenumber", source, currentjob, lastname, firstname, phonenumber)
    end)
end)

RegisterServerEvent("server:showid")
AddEventHandler("server:showid", function()
    local source = source
    TriggerEvent("core:getuser", source, function(user)
        local character_id = user.get("characterID")
        local currentjob = user.get("job").name
        local lastname = user.get("last_name")
        local firstname = user.get("first_name")
        TriggerClientEvent("showid:info", source, currentjob, lastname, firstname)
    end)
end)
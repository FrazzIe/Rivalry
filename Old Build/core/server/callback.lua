AddEventHandler("core:getuser", function(source, callback)
    if Characters and Users then
        if Characters[source] and Users[source] then
            callback(Characters[source], Users[source])
        else
            callback(nil, nil)
        end
    else
        callback(nil, nil)
    end
end)

AddEventHandler("core:getuserfromidentifier", function(identifier, callback)
    if Identifiers then
        if Identifiers[identifier] then
            if GetPlayerName(Identifiers[identifier]) then
                callback(Identifiers[identifier])
            else
                callback(nil)
            end
        else
            callback(nil)
        end
    else
        callback(nil)
    end
end)

AddEventHandler("core:getname", function(source, callback)
    if CharacterNames then
        if CharacterNames[source] then
            callback(CharacterNames[source])
        else
            if GetPlayerName(source) then
                callback(GetPlayerName(source))
            else
                callback(nil)
            end
        end
    else
        if GetPlayerName(source) then
            callback(GetPlayerName(source))
        else
            callback(nil)
        end
    end
end)
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

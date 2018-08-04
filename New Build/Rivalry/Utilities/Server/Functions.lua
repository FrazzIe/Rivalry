function Utilities.GetPlayerSteam(SourcePlayer)
    for Index = 0, GetNumPlayerIdentifiers(SourcePlayer) do
        local Identifier = GetPlayerIdentifier(SourcePlayer, Index)
        
        if string.sub(tostring(Identifier), 1, string.len("steam:")) == "steam:" then
            return Identifier
        end
    end

    return nil
end

function Utilities.GetPlayerSteam64(SourcePlayer)
    local SteamHex = Utilities.GetPlayerSteam(SourcePlayer)
    if SteamHex then
        return math.floor(tonumber(string.sub(SteamHex, 7, string.len(SteamHex)), 16))
    else
        return nil
    end 
end

function Utilities.GetPlayerSteam32(SourcePlayer)
    local Steam64 = Utilities.GetPlayerSteam64(SourcePlayer)
    if Steam64 then
        Steam64 = tonumber(string.sub(Steam64, 2))
        
        local Y = Steam64 % 2 == 0 and 0 or 1
        local Z = math.floor(math.abs(6561197960265728 - Steam64 - Y) / 2)
        return "STEAM_0:"..Y..":"..(Y == 1 and Z -1 or Z)
    else
        return nil
    end
end

function Utilities.GetPlayerLicense(SourcePlayer)
    for Index = 0, GetNumPlayerIdentifiers(SourcePlayer) do
        local Identifier = GetPlayerIdentifier(SourcePlayer, Index)

        if string.sub(tostring(Identifier), 1,  string.len("license:")) == "license:" then
            return Identifier
        end
    end

    return nil
end

function Utilities.GetPlayerIP(SourcePlayer)
    for Index = 0, GetNumPlayerIdentifiers(SourcePlayer) do
        local Identifier = GetPlayerIdentifier(SourcePlayer, Index)

        if string.sub(tostring(v), 1, string.len("ip:")) == "ip:" then
            return Identifier
        end
    end

    return GetPlayerEndpoint(SourcePlayer) or nil
end
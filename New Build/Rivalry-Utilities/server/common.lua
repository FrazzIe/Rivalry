function Utilities:GetPlayerSteam(Source)
    for Index = 0, GetNumPlayerIdentifiers(Source) - 1 do
        local Identifier = GetPlayerIdentifier(Source, Index)
            
        if self:StartWith(Identifier, "steam:") then
            return Identifier
        end
    end

    return nil
end

function Utilities:GetPlayerSteam64(Source)
    local SteamHex = self:GetPlayerSteam(Source)
    if SteamHex then
         return math.floor(tonumber(string.sub(SteamHex, 7, string.len(SteamHex)), 16))
    else
        return nil
    end
end

function Utilities:GetPlayerSteam32(Source)
    local Steam64 = self:GetPlayerSteam64(Source)
    if Steam64 then
        Steam64 = tonumber(string.sub(Steam64, 2))
            
        local Y = Steam64 % 2 == 0 and 0 or 1
        local Z = math.floor(math.abs(6561197960265728 - Steam64 - Y) / 2)
        
        return "STEAM_0:"..Y..":"..(Y == 1 and Z -1 or Z)
    else
         return nil
    end
end

function Utilities:GetPlayerLicense(SourcePlayer)
    for Index = 0, GetNumPlayerIdentifiers(Source) - 1 do
        local Identifier = GetPlayerIdentifier(Source, Index)

        if self:StartWith(Identifier, "license:") then
            return Identifier
        end
    end

    return nil
end

function Utilities:GetPlayerIP(Source)
    for Index = 0, GetNumPlayerIdentifiers(Source) - 1 do
        local Identifier = GetPlayerIdentifier(Source, Index)

        if self:StartWith(Identifier, "ip:") then
            return Identifier
        end
    end

    return GetPlayerEndpoint(Source) or nil
end
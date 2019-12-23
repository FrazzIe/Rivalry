local PlayerInjurys = {}

function GetCharsInjuries(Source)
    return PlayerInjurys[Source]
end

RegisterServerEvent('mythic_hospital:server:SyncInjuries')
AddEventHandler('mythic_hospital:server:SyncInjuries', function(data)
    local Source = source
    PlayerInjurys[Source] = data
end)
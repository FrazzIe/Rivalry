local Games = {}

function DoesLobbyExist(Source)
    for Index = 1, #Games do
        if Games[Index].LobbyID == Source then
            return true
        end
    end
    return false
end

RegisterServerEvent("Golf.Create.Lobby")
AddEventHandler("Golf.Create.Lobby", function()
    local Source = source
    if not DoesLobbyExist(Source) then
        local CharacterName = ""
        TriggerEvent("core:getuser", Source, function(User)
            CharacterName = User.get("first_name").." "..User.get("last_name")
        end)
        local Lobby = {
            LobbyID = Source,
            Players = {
                [Source] = {
                    Score = {0,0,0,0,0,0,0,0,0},
                    Name = CharacterName,
                },
            }
        }
        Games[Source] = {}
        table.insert(Games[Source], Lobby)
        TriggerClientEvent("Golf.Join.Lobby", Source, Source)
    else
        TriggerClientEvent("pNotify:SendNotification", Source, {text = "Lobby already exists!"})
    end
end)

RegisterServerEvent("Golf.Join.Lobby")
AddEventHandler("Golf.Join.Lobby", function(LobbyID)
    local Source = source
    if Games[LobbyID] then
        if #Games[LobbyID].Players < 4 then
            Games[LobbyID].Players[Source].Score = {0,0,0,0,0,0,0,0,0}
            TriggerEvent("core:getuser", Source, function(User)
                Games[LobbyID].Players[Source].Name = User.get("first_name").." "..User.get("last_name")
            end)
            TriggerClientEvent("Golf.Join.Lobby", Source, LobbyID)
        else
            TriggerClientEvent("pNotify:SendNotification", Source, {text = "Lobby is already full!"})
        end
    else
        TriggerClientEvent("pNotify:SendNotification", Source, {text = "Lobby Doesn't Exist!"})
    end
end)

RegisterServerEvent("Golf.Leave.Lobby")
AddEventHandler("Golf.Leave.Lobby", function(LobbyID)
    local Source = source
    if Games[LobbyID] then
        if Games[LobbyID].Players[Source] ~= nil then
            table.remove(Games[LobbyID].Players[Source], Source)
            TriggerClientEvent("Golf.Leave.Lobby", Source)
        end
    end
end)

RegisterServerEvent("Golf.Get.Score")
AddEventHandler("Golf.Get.Score", function(LobbyID)
    local Source = source
    if Games[LobbyID] then
        TriggerClientEvent("Golf.Get.Score", Source, Games[LobbyID].Players)
    end
end)

RegisterServerEvent("Golf.Set.Score")
AddEventHandler("Golf.Set.Score", function(Score, LobbyID)
    if Games[LobbyID] then
        Games[LobbyID].Players[Source] = Score
        TriggerClientEvent("Golf.Set.Score", Source, Games[LobbyID].Players)
    end
end)

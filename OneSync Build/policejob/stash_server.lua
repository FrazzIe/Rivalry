RegisterServerEvent("policeStash:fetch")
AddEventHandler("policeStash:fetch", function()
    local src = source
    local charId = exports["core"]:GetCharacterId(src)

    if charId then
        exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM weapons WHERE pd_stash = 1 AND character_id = @character_id", { 
            ["@character_id"] = charId,
        }, function(stash)
            TriggerClientEvent("policeStash:received", src, stash)
        end)
    else
        TriggerClientEvent("policeStash:received", src, {})
    end
end)
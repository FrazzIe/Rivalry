GSR = {}

RegisterServerEvent("GSR.Set")
AddEventHandler("GSR.Set", function(value)
    local src = source
    GSR[src] = value
    TriggerClientEvent("GSR.Sync", -1, src, value)
end)

AddEventHandler("playerDropped", function()
    local src = source
    GSR[src] = nil
    TriggerClientEvent("GSR.Sync", -1, src, nil)
end)

AddEventHandler("core:switch", function(source)
    local src = source
    GSR[src] = nil
    TriggerClientEvent("GSR.Sync", -1, src, nil)
end)
local Evidence = {
    ["Fingerprints"] = {},
    ["Ballistics"] = {},
    ["Inventory"] - {},
    ["Firearms"] = {},
}

local FetchedLocker = {}
local IsInUse = false

RegisterServerEvent("Pickup.Evidence")
AddEventHandler("Pickup.Evidence", function(Type, PieceOfEvidence)
    local Source = source
    if Type == "Ballistics" then
        for Index = 1, #Evidence[Type] do
            if Evidence[Type].WeaponUsed == PieceOfEvidence.WeaponUsed then
                table.remove(Index, Evidence[Type])
                TriggerClientEvent("Pickup.Evidence", Source, Type, PieceOfEvidence)
            end
        end
    elseif Type == "Fingerprints" then
        for Index = 1, #Evidence[Type] do
           if Evidence[Type].VehiclePlate == PieceOfEvidence.VehiclePlate and Evidence[Type].Seat == PieceOfEvidence.Seat then
               table.remove(Index, Evidence[Type])
               TriggerClientEvent("Pickup.Evidence", Source, Type, PieceOfEvidence)
           end
        end
    elseif Type == "Inventory" then
        for Index = 1, #Evidence[Type] do
            if Evidence[Type].ItemID == PieceOfEvidence.ItemID and Evidence[Type].Quantity == PieceOfEvidence.Quantity and Evidence[Type].CharacterName == PieceOfEvidence.CharacterName then
                table.remove(Index, Evidence[Type])
                TriggerClientEvent("Pickup.Evidence", Source, Type, PieceOfEvidence)
            end
        end
    elseif Type == "Firearms" then
       for Index = 1, #Evidence[Type] do
           if Evidence[Type].WeaponUsed == PieceOfEvidence.WeaponUsed and Evidence[Type].CharacterName == PieceOfEvidence.CharacterName then
                 table.remove(Index, Evidence[Type])
                 TriggerClientEvent("Pickup.Evidence", Source, Type, PieceOfEvidence)
           end
       end
    end
end)
    
RegisterServerEvent("Swab.Vehicle.Results")
AddEventHandler("Swab.Vehicle.Results", function(Results)
    if Results ~= nil then
        if #Results > 0 then
            Results.Time = os.date("%c", os.time())
            TriggerClientEvent("chat:addMessage", Source, "Results", {255, 255, 255}, Results.Time.." | "..Results.Seat.." - "..Results.VehiclePlate)
        end
    end
end)
         
RegisterServerEvent("Insert.Evidence")
AddEventHandler("Insert.Evidence", function(Data, SelectedEvidence)
    local Source = source
    TriggerEvent("core:getuser", Source, function(User)                                     
        if SelectedEvidence == "Ballistics" then
           exports["GHMattiMySQL"]:QueryAsync("INSERT INTO police_evidence_ballistics '', '', '', AS @, @, @", {
               ["@"] = Data.,

           })
        elseif SelectedEvidence == "Fingerprints" then
           exports["GHMattiMySQL"]:QueryAsync("INSERT INTO police_evidence_fingerprints '', '', '', AS @, @, @", {
               ["@"] = Data.,

           })
        elseif SelectedEvidence == "Inventory" then
           exports["GHMattiMySQL"]:QueryAsync("INSERT INTO police_evidence_inventory '', '', '', AS @, @, @", {
               ["@"] = Data.,

           })
        elseif SelectedEvidence == "Firearms" then
           exports["GHMattiMySQL"]:QueryAsync("INSERT into police_evidence_firearms '', '', '', AS @, @, @", {
               ["@"] = Data.,
               
           })
        end
    end)
end)
            
RegisterServerEvent("Withdraw.Evidence")
AddEventHandler("Withdraw.Evidence", function(Index, SelectedEvidence)
    local Source = source
    local Data = nil
    if FetchedLocker ~= nil and #FetchedLocker > 0 then
        if SelectedEvidence == "Ballistics" then
            Data = FetchedLocker["Ballistics"][Index]
            exports["GHMattiMySQL"]:QueryAsync(" ", {})  
        elseif SelectedEvidence == "Fingerprints" then
             Data = FetchedLocker["Fingerprints"][Index]
            exports["GHMattiMySQL"]:QueryAsync(" ", {})              
        elseif SelectedEvidence == "Inventory" then
            Data = FetchedLocker["Inventory"][Index]
            exports["GHMattiMySQL"]:QueryAsync(" ", {})            
        elseif SelectedEvidence == "Firearms" then
            Data = FetchedLocker["Firearms"][Index]
            exports["GHMattiMySQL"]:QueryAsync(" ", {})  
        end
    end
end)
            
RegisterServerEvent("Fetch.Evidence.Locker")
AddEventHandler("Fetch.Evidence.Locker", function()
    local Source = source
    local Data = {
        ["Ballistics"] = {},
        ["Fingerprints"] = {},
        ["Inventory"] = {},
        ["Firearms"] = {},
    }
    table.insert(Data["Ballistics"], exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM police_evidence_ballistics")
    table.insert(Data["Fingerprints"], exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM police_evidence_fingerprints")
    table.insert(Data["Inventory"], exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM police_evidence_inventory")
    table.insert(Data["Firearms"], exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM police_evidence_firearms")
    FetchedLocker = Data
    TriggerClientEvent("Fetch.Evidence.Locker", Data)
end)
                            
RegisterServerEvenT("Sync.Evidence")
AddEvenTHandler("Sync.Evidence", function(Data, Type)
    local Source = source
    if Type == "Ballistics" or Type == "Fingerprints" or Type == "Inventory" or Type == "Firearms" then
        table.insert(Evidence[Type], Data)
    end
    TriggerClientEvent("Sync.Evidence", -1, Evidence)
end)
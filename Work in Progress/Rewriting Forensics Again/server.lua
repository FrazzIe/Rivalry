local UncollectedEvidence = {
    ["Ballistics"] = {},
    ["Fingerprints"] = {}
}

function SyncForensics()
    TriggerClientEvent("Forensics.Sync.Uncollected.Evidence", -1, UncollectedEvidence)
end

RegisterServerEvent("Forensics.Add.Uncollected.Evidence")
AddEventHandler("Forensics.Add.Uncollected.Evidence", function(Evidence)
    local Source = source
    if Evidence.Type == "Ballistics" then
        TriggerEvent("weapon:getuser", Source, function(Weapons)
            for Index = 1, #Weapons do
                if Weapons.model == Evidence.Weapon then
                    Evidence.SerialNumber = Evidence.Weapon
                end
            end
            table.insert(UncollectedEvidence[Evidence.Type], Evidence)
            SyncForensics()
        end)
    elseif Evidence.Type == "Fingerprints" then
        TriggerEvent("core:getuser", Source, function(User)
            Evidence.CharacterID = User.get("characterID")
            table.insert(UncollectedEvidence[Evidence.Type], Evidence)
            SyncForensics()
        end)
    end
end)

RegisterServerEvent("Forensics.Store.Evidence")
AddEventHandler("Forensics.Store.Evidence", function(Evidence)
    local Source = source
    if Evidence.Type == "Ballistics" then

    elseif Evidence.Type == "Fingerprints" then

    elseif Evidence.Type == "Items" then

    elseif Evidence.Type == "Firearms" then

    end
end)

RegisterServerEvent("Forensics.Run.Evidence", function(Evidence)
    local Source = source
    if Evidence.Type == "Ballistics" then
        exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM police_evidence_ballistics ")
    elseif Evidence.Type == "Fingerprints" then

    elseif Evidence.Type == "Items" then

    elseif Evidence.Type == "Firearms" then

    end
end)

RegisterServerEvent("Forensics.Open.Evidence.Locker")
AddEventHandler("Forensics.Open.Evidence.Locker", function(EvidenceType)
    if EvidenceType == "Ballistics" then
        exports["GHMattiMySQL"]:QueryResult("SELECT * FROM police_evidence_ballistics", {}, function(Result)
            if Result[1] ~= nil then
                TriggerClientEvent("Forensics.Open.Evidence.Locker", Source, Result)
            else
                TriggerClientEvent("Forensics.Open.Evidence.Locker", Source, {})
            end
        end)
    elseif EvidenceType == "Fingerprints" then
        exports["GHMattiMySQL"]:QueryResult("SELECT * FROM police_evidence_fingerprints", {}, function(Result)
            if Result[1] ~= nil then
                TriggerClientEvent("Forensics.Open.Evidence.Locker", Source, Result)
            else
                TriggerClientEvent("Forensics.Open.Evidence.Locker", Source, {})
            end
        end)
    elseif EvidenceType == "Items" then
        exports["GHMattiMySQL"]:QueryResult("SELECT * FROM police_evidence_items", {}, function(Result)
            if Result[1] ~= nil then
                TriggerClientEvent("Forensics.Open.Evidence.Locker", Source, Result)
            else
                TriggerClientEvent("Forensics.Open.Evidence.Locker", Source, {})
            end
        end)
    elseif EvidenceType == "Firearms" then
        exports["GHMattiMySQL"]:QueryResult("SELECT * FROM police_evidence_firearms", {}, function(Result)
            if Result[1] ~= nil then
                TriggerClientEvent("Forensics.Open.Evidence.Locker", Source, Result)
            else
                TriggerClientEvent("Forensics.Open.Evidence.Locker", Source, {})
            end
        end)
    end
end)
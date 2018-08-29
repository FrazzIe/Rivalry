--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
RegisterServerEvent("police:load-warrants")
AddEventHandler("police:load-warrants", function(openUI)
    local source = source
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_warrants", {}, function(warrants)
        if(warrants[1] == nil) then
            TriggerClientEvent("police:load-warrants", source, {}, openUI)
        else
            TriggerClientEvent("police:load-warrants", source, warrants, openUI)
        end
    end)
end)

RegisterServerEvent("police:new-warrant")
AddEventHandler("police:new-warrant", function(offender_name, location, notes)
    local source = source; timestamp = os.time(); officer_name = GetIdentity(source)
    local warrant = exports['GHMattiMySQL']:QueryResult("INSERT INTO police_warrants (`timestamp`,`officer_name`,`offender_name`,`location`,`notes`) VALUES (@timestamp,@officer_name,@offender_name,@location,@notes); SELECT * FROM police_warrants WHERE `id` = (SELECT LAST_INSERT_ID());", { 
        ['@timestamp'] = timestamp,
        ['@officer_name'] = officer_name,
        ['@offender_name'] = offender_name,
        ['@location'] = location,
        ['@notes'] = notes,
    })
    TriggerClientEvent("police:new-warrant", -1, warrant)
end)

RegisterServerEvent("police:remove-warrant")
AddEventHandler("police:remove-warrant", function(id)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM police_warrants WHERE id=@id", { ['@id'] = id})
    TriggerClientEvent("police:remove-warrant", -1, id)
end)

RegisterServerEvent("police:load-arrests")
AddEventHandler("police:load-arrests", function(openUI)
    local source = source
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_arrests", {}, function(arrests)
        if(arrests[1] == nil) then
            TriggerClientEvent("police:load-arrests", source, {}, openUI)
        else
            TriggerClientEvent("police:load-arrests", source, arrests, openUI)
        end
    end)
end)

RegisterServerEvent("police:new-arrest")
AddEventHandler("police:new-arrest", function(officer_name, offender_name, sentenceORfine, sentence, fine, charges, offender_identifier)
    local source = source; timestamp = os.time(); officer_identifier = getID("steam", source)
    local arrest = exports['GHMattiMySQL']:QueryResult("INSERT INTO police_arrests (`timestamp`,`officer_identifier`,`officer_name`,`offender_identifier`,`offender_name`,`sentenceORfine`,`sentence`,`fine`,`charges`) VALUES (@timestamp,@officer_identifier,@officer_name,@offender_identifier,@offender_name,@sentenceORfine,@sentence,@fine,@charges); SELECT * FROM police_arrests WHERE `id` = (SELECT LAST_INSERT_ID());", { 
        ['@timestamp'] = timestamp,
        ['@officer_identifier'] = officer_identifier,
        ['@officer_name'] = officer_name,
        ['@offender_identifier'] = offender_identifier,
        ['@offender_name'] = offender_name,
        ['@sentenceORfine'] = sentenceORfine,
        ['@sentence'] = sentence,
        ['@fine'] = fine,
        ['@charges'] = charges,
    })
    TriggerClientEvent("police:new-arrest", -1, arrest)
end)

RegisterServerEvent("police:remove-arrest")
AddEventHandler("police:remove-arrest", function(id)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM police_arrests WHERE id=@id", { ['@id'] = id})
    TriggerClientEvent("police:remove-arrest", -1, id)
end)

RegisterServerEvent("police:load-violations")
AddEventHandler("police:load-violations", function(openUI)
    local source = source
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_violations", {}, function(violations)
        if(violations[1] == nil) then
            TriggerClientEvent("police:load-violations", source, {}, openUI)
        else
            TriggerClientEvent("police:load-violations", source, violations, openUI)
        end
    end)
end)

RegisterServerEvent("police:new-violation")
AddEventHandler("police:new-violation", function(officer_name, offender_name, violations, fine, offender_identifier)
    local source = source; timestamp = os.time(); officer_identifier = getID("steam", source)
    local violation = exports['GHMattiMySQL']:QueryResult("INSERT INTO police_violations (`timestamp`,`officer_identifier`,`officer_name`,`offender_identifier`,`offender_name`,`fine`,`violations`) VALUES (@timestamp,@officer_identifier,@officer_name,@offender_identifier,@offender_name,@fine,@violations); SELECT * FROM police_violations WHERE `id` = (SELECT LAST_INSERT_ID());", { 
        ['@timestamp'] = timestamp,
        ['@officer_identifier'] = officer_identifier,
        ['@officer_name'] = officer_name,
        ['@offender_identifier'] = offender_identifier,
        ['@offender_name'] = offender_name,
        ['@fine'] = fine,
        ['@violations'] = violations,
    })
    TriggerClientEvent("police:new-violation", -1, violation)
end)

RegisterServerEvent("police:remove-violation")
AddEventHandler("police:remove-violation", function(id)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM police_violations WHERE id=@id", { ['@id'] = id})
    TriggerClientEvent("police:remove-violation", -1, id)
end)
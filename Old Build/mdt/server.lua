RegisterServerEvent("police:search-table")
AddEventHandler("police:search-table", function(firstnamev, lastnamev)
       local source = source
       local first_name = firstnamev
       local last_name = lastnamev
       exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM characters WHERE (first_name = @first_name)", {["@first_name"] = first_name}, function(search)
	   if(search[1] == nil) then
	        TriggerClientEvent("police:load-searchtable", source, {"Not", "In", "The", "Database"}, openUI)
	   else
	        TriggerClientEvent("police:load-searchtable", source, search, openUI )
	   end
    end)
end)

RegisterServerEvent("police:loadplayerdata")
AddEventHandler("police:loadplayerdata", function(lastname, firstname)
    local source = source
    local first_name = firstname
    local last_name = lastname
    local offender_name = first_name.." "..last_name
    local character_id = 0
    local weapons_license = nil
    local drivers_license = nil
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM characters WHERE (first_name = @first_name) AND (last_name = @last_name)", {["@first_name"] = first_name, ["@last_name"] = last_name}, function(character)
    	character_id = character[1].character_id
    	weapons_license = character[1].weapon_license
    	drivers_license = character[1].drivers_license
    end)
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_warrants WHERE (offender_name = @offender_name)", {["@offender_name"] = offender_name}, function(warrants)
        exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_arrests WHERE (offender_name = @offender_name)", {["@offender_name"] = offender_name}, function(arrests)
            exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_violations WHERE (offender_name = @offender_name)", {["@offender_name"] = offender_name}, function(tickets)
                exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_notepad WHERE (character_id = @character_id)", {["@character_id"] = character_id}, function(notes)
                    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM vehicles WHERE (character_id = @character_id)", {["@character_id"] = character_id}, function(vehicles)
                        TriggerClientEvent( "police:loadplayerdata-client", source, first_name, last_name, character_id, #arrests, #warrants, #tickets, weapons_license, drivers_license )
                        TriggerClientEvent( "police:loadvehiclesdata-client", source, vehicles )
                        TriggerClientEvent('client:load-notepad', source, notes) 
                    end)
                end)
            end)
        end)
    end)
end)

RegisterServerEvent("police:loadarrestdata")
AddEventHandler("police:loadarrestdata", function(firstname, lastname)
    local source = source
    local first_name = firstname
    local last_name = lastname
    local offender_name = first_name.." "..last_name
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM characters WHERE (first_name = @first_name) AND (last_name = @last_name)", {["@first_name"] = first_name, ["@last_name"] = last_name}, function(character)
        exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_arrests WHERE (offender_name = @offender_name)", {["@offender_name"] = offender_name}, function(arrests)
            TriggerClientEvent( "police:loadarrestdata-client", source, arrests )
        end)
    end)
end)

RegisterServerEvent("police:loadticketsdata")
AddEventHandler("police:loadticketsdata", function(firstname, lastname)
    local source = source
    local first_name = firstname
    local last_name = lastname
    local offender_name = first_name.." "..last_name
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM characters WHERE (first_name = @first_name) AND (last_name = @last_name)", {["@first_name"] = first_name, ["@last_name"] = last_name}, function(character)
        exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_violations WHERE (offender_name = @offender_name)", {["@offender_name"] = offender_name}, function(tickets)
            TriggerClientEvent( "police:loadticketsdata-client", source, tickets )
        end)
    end)
end)

RegisterServerEvent("police:new-arrest")
AddEventHandler("police:new-arrest", function(officer_name, offender_first_name, offender_last_name, charges, fine, sentence)
    local source = source; timestamp = os.time();
    local arrest = exports['GHMattiMySQL']:QueryResult("INSERT INTO police_arrests ( `timestamp`, `officer_name`, `offender_name`, `charges`, `fine`, `sentence` ) VALUES ( @timestamp, @officer_name, @offender_name, @charges, @fine, @sentence ); SELECT * FROM police_arrests WHERE `id` = (SELECT LAST_INSERT_ID());", { 
        ['@timestamp'] = timestamp,
        ['@officer_name'] = officer_name,
        ['@offender_name'] = offender_first_name.." "..offender_last_name,
        ['@sentence'] = sentence,
        ['@fine'] = fine,
        ['@charges'] = charges,
    })
    TriggerClientEvent("police:new-arrest", -1, arrest)
end)

RegisterServerEvent("police:new-citation")
AddEventHandler("police:new-citation", function(officer_name, offender_first_name, offender_last_name, charges, fine)
    local source = source; timestamp = os.time();
    local citation = exports['GHMattiMySQL']:QueryResult("INSERT INTO police_violations ( `timestamp`,`officer_name`,`offender_name`,`fine`,`violations` ) VALUES ( @timestamp, @officer_name, @offender_name, @fine, @violations ); SELECT * FROM police_violations WHERE `id` = (SELECT LAST_INSERT_ID());", { 
        ['@timestamp'] = timestamp,
        ['@officer_name'] = officer_name,
        ['@offender_name'] = offender_first_name.." "..offender_last_name,
        ['@fine'] = fine,
        ['@violations'] = charges,
    })
    TriggerClientEvent("police:new-citation", -1, citation)
end)

function setNotepad(character_id, notes)
	notepad = exports['GHMattiMySQL']:QueryAsync("UPDATE police_notepad SET `notes` = @notes WHERE ( `character_id` = @character_id );", { 
        ['@notes'] = notes,
        ['@character_id'] = character_id,
    })
end

function insertNotepad(character_id, notes)
	notepad = exports['GHMattiMySQL']:QueryAsync("INSERT INTO police_notepad ( `character_id`,`notes` ) VALUES ( @character_id, @notes ); SELECT * FROM police_notepad WHERE `id` = (SELECT LAST_INSERT_ID());", { 
        ['@character_id'] = character_id,
        ['@notes'] = notes,
    })
end

RegisterServerEvent("police:edit-notepad")
AddEventHandler("police:edit-notepad", function(firstname, lastname, notesv)
	local source = source
	local first_name, last_name, notes = firstname, lastname, notesv
	local character_id = 0
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM characters WHERE (first_name = @first_name) AND (last_name = @last_name)", {["@first_name"] = first_name, ["@last_name"] = last_name}, function(character)
    	character_id = character[1].character_id
    	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_notepad WHERE (character_id = @character_id)", {["@character_id"] = character_id}, function(notepad)
	    	if(notepad[1]==nil)then
	    		insertNotepad(character_id, notes)
		    else
		    	setNotepad(character_id, notes)
		    end
	    end)
    end)
end)

function updateWarrant(description, charge, newdescription)
	warrant = exports['GHMattiMySQL']:QueryAsync("UPDATE police_warrants SET `location` = @charges WHERE ( `notes` = @description );", { 
        ['@charges'] = charge,
        ['@description'] = description,
    })
    warrant2 = exports['GHMattiMySQL']:QueryAsync("UPDATE police_warrants SET `notes` = @newdescription WHERE ( `notes` = @description );", { 
        ['@newdescription'] = newdescription,
        ['@description'] = description,
    })
end

RegisterServerEvent('police:edit-warrant')
AddEventHandler('police:edit-warrant', function(description, charges, newdescription)
	local source = source
	local desc, charge, ndesc = description, charges, newdescription
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_warrants WHERE (notes = @desc)", {["@desc"] = desc}, function(warrant)
        if(warrant[1]==nil)then
	    	
		else
		    updateWarrant(desc, charge, ndesc)
		end
    end)
end)

RegisterServerEvent("police:load-warrants")
AddEventHandler("police:load-warrants", function(openUI)
    local source = source
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_warrants", {}, function(warrants)
        if(warrants[1] == nil) then
            TriggerClientEvent("police:loads-warrants", source, {}, openUI)
        else
            TriggerClientEvent("police:loads-warrants", source, warrants, openUI)
        end
    end)
end)

RegisterServerEvent("police:selwarrants")
AddEventHandler("police:selwarrants", function(namev)
    local source = source
    local offender_name = namev
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_warrants WHERE (offender_name = @offender_name)", {["@offender_name"] = offender_name}, function(warrant)
        TriggerClientEvent( "police:selectedwarrant", source, warrant[1] )
    end)
end)

RegisterServerEvent("police:submitreport")
AddEventHandler("police:submitreport", function(r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22)
    local source = source
    local report = exports['GHMattiMySQL']:QueryResult("INSERT INTO police_reports ( `r1`, `r2`,  `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, `r11`, `r12`, `r13`, `r14`, `r15`, `r16`, `r17`, `r18`, `r19`, `r20`, `r21`, `r22` ) VALUES ( @r1, @r2, @r3, @r4, @r5, @r6, @r7, @r8, @r9, @r10, @r11, @r12, @r13, @r14, @r15, @r16, @r17, @r18, @r19, @r20, @r21, @r22 ); SELECT * FROM police_reports WHERE `id` = (SELECT LAST_INSERT_ID());", { 
    ['@r1'] = r1,
    ['@r2'] = r2,
    ['@r3'] = r3,
    ['@r4'] = r4,
    ['@r5'] = r5,
    ['@r6'] = r6,
    ['@r7'] = r7,
    ['@r8'] = r8,
    ['@r9'] = r9,
    ['@r10'] = r10,
    ['@r11'] = r11,
    ['@r12'] = r12,
    ['@r13'] = r13,
    ['@r14'] = r14,
    ['@r15'] = r15,
    ['@r16'] = r16,
    ['@r17'] = r17,
    ['@r18'] = r18,
    ['@r19'] = r19,
    ['@r20'] = r20,
    ['@r21'] = r21,
    ['@r22'] = r22,
    })
    TriggerClientEvent("police:new-report", source, report)    
end)

RegisterServerEvent("police:loadreports")
AddEventHandler("police:loadreports", function(openUI)
    local source = source
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_reports", {}, function(reports)
        if(reports[1] == nil) then
            TriggerClientEvent("police:loadreports", source, {}, openUI)
        else
            TriggerClientEvent("police:loadreports", source, reports, openUI)
        end
    end)
end)

RegisterServerEvent("police:loadreport")
AddEventHandler("police:loadreport", function(idv)
    local source = source
    local id = idv
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_reports WHERE (id = @id)", {["@id"] = id}, function(report)
        TriggerClientEvent( "police:loadreport", source, report[1] )
    end)
end)

RegisterServerEvent("police:new-warrant")
AddEventHandler("police:new-warrant", function(date, officer_name, offender_name, location, notes)
    local source = source; timestamp = os.time();
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
AddEventHandler("police:remove-warrant", function(desc)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM police_warrants WHERE notes=@desc", { ['@desc'] = desc})
    TriggerClientEvent("police:remove-warrant", -1, desc)
end)

RegisterServerEvent("police:remove-arrest")
AddEventHandler("police:remove-arrest", function(id)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM police_arrests WHERE id=@id", { ['@id'] = id})
    TriggerClientEvent("police:remove-arrest", -1, id)
end)

RegisterServerEvent("police:remove-violation")
AddEventHandler("police:remove-violation", function(id)
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM police_violations WHERE id=@id", { ['@id'] = id})
    TriggerClientEvent("police:remove-violation", -1, id)
end)
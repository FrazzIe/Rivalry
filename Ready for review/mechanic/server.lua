Mechanic = {}
Mechanic.Players = {}

AddEventHandler("Mechanic:Initialise", function(source, identifier, character_id)
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM mechanic WHERE character_id=@character_id", {["@character_id"] = character_id}, function(result)
		if result[1] == nil then
			TriggerClientEvent("Mechanic:Set", source, {}, false, true)
		else
			Mechanic.Players[source] = result[1]
			TriggerClientEvent("Mechanic:Set", source, Mechanic.Players[source], true, true)
		end
	end)
end)

TriggerEvent("core:addGroupCommand", "mechanicadd", "admin", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /mechanicadd [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if Mechanic.Ranks[rank:lower()] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					Mechanic.Players[tonumber(args[1])] = nil
					exports['GHMattiMySQL']:QueryAsync("DELETE FROM mechanic WHERE character_id=@character_id; INSERT INTO Mechanic (`character_id`, `rank`) VALUES (@character_id, @rank)", {
						["@character_id"] = target.get("characterID"),
						["@rank"] = rank:lower(),
					})
					Mechanic.Players[tonumber(args[1])] = { character_id = target.get("characterID"), rank = rank:lower(), onduty = "false" }
					Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been accepted. <br> Congratulations on joining the Mechanic!", 10000, tonumber(args[1]))
					TriggerClientEvent("Mechanic:Set", tonumber(args[1]), Mechanic.Players[tonumber(args[1])], true)
				end)
			else
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "This rank does not exist")
			end
		else
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /mechanicadd [ID] [RANK]")
		end
	end
end, {help = "Add a player to the department of justice", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Paralegal | State Attorney | Assistant Distruct Attorney | District Attorney | Judge | Chief Justice"}}})

TriggerEvent("core:addGroupCommand", "mechanicrem", "admin", function(source, args, rawCommand, data, power, group)
	local source = source
	if(not args[1]) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /mechanicrem [ID]")	
	else
		if GetPlayerName(tonumber(args[1])) then
			if Mechanic.Players[tonumber(args[1])] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					Mechanic.Players[tonumber(args[1])] = nil
					exports['GHMattiMySQL']:QueryAsync("DELETE FROM Mechanic WHERE character_id=@character_id", {["@character_id"] = target.get("characterID")})
					Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been fired. <br> They are no longer an officer of the Mechanic!", 10000, tonumber(args[1]))
					TriggerClientEvent("Mechanic:Set", tonumber(args[1]), Mechanic.Players[tonumber(args[1])], false)
				end)
			else
				Notify("This user is not apart of the Mechanic", 3000, source)
			end
		else
			Notify("No player with this ID !", 3000, source)
		end
	end
end, {help = "Remove a player from the department of justice", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent("core:addGroupCommand", "mechanicpromote", "admin", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /mechanicpromote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if Mechanic.Players[source] ~= nil then
				if Mechanic.Players[tonumber(args[1])] ~= nil then
					if Mechanic.Ranks[rank:lower()] ~= nil then
						canTargetRank(Mechanic.Players[source].rank, Mechanic.Players[tonumber(args[1])].rank, function(cb)
							if cb then
								if canPromote(Mechanic.Players[source].rank) then
									TriggerEvent("core:getuser", tonumber(args[1]), function(target)
										exports['GHMattiMySQL']:QueryAsync("UPDATE mechanic SET rank=@rank WHERE character_id=@character_id", {["@character_id"] = target.get("characterID"), ["@rank"] = rank:lower()})
										Mechanic.Players[tonumber(args[1])].rank = rank:lower()
										Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been promoted!</span><br> You are now a "..rank, 10000, tonumber(args[1]))
										TriggerClientEvent("Mechanic:Set", tonumber(args[1]), Mechanic.Players[tonumber(args[1])], true)
									end)
								else
									Notify("You cannot promote anyone", 3000, source)
								end
							else
								Notify("You cannot target this player", 3000, source)
							end
						end)
					else
						Notify("This rank does not exist", 3000, source)
					end
				else
					Notify("This user is not apart of the Mechanic", 3000, source)
				end
			else
				Notify("You aren't apart of the Mechanic", 3000, source)
			end
		else
			Notify("Player could not be found", 3000, source)
		end
	end
end, {help = "Promote to Whitelisted Mechanic", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Worker | Boss"}}})

TriggerEvent("core:addGroupCommand", "mechanicdemote", "emergency", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /mechanicdemote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if Mechanic.Players[source] ~= nil then
				if Mechanic.Players[tonumber(args[1])] ~= nil then
					if Mechanic.Ranks[rank:lower()] ~= nil then
						canTargetRank(Mechanic.Players[source].rank, Mechanic.Players[tonumber(args[1])].rank, function(cb)
							if cb then
								if canPromote(Mechanic.Players[source].rank) then
									TriggerEvent("core:getuser", tonumber(args[1]), function(target)
										exports['GHMattiMySQL']:QueryAsync("UPDATE mechanic SET rank=@rank WHERE character_id=@character_id", {["@character_id"] = target.get("characterID"), ["@rank"] = rank:lower()})
										Mechanic.Players[tonumber(args[1])].rank = rank:lower()
										Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been demoted!</span><br> You are now a "..rank, 10000, tonumber(args[1]))
										TriggerClientEvent("Mechanic:Set", tonumber(args[1]), Mechanic.Players[tonumber(args[1])], true)
									end)
								else
									Notify("You cannot demote anyone", 3000, source)
								end
							else
								Notify("You cannot target this player", 3000, source)
							end
						end)
					else
						Notify("This rank does not exist", 3000, source)
					end
				else
					Notify("This user is not apart of the Mechanic", 3000, source)
				end
			else
				Notify("You aren't apart of the Mechanic", 3000, source)
			end
		else
			Notify("Player could not be found", 3000, source)
		end
	end
end, {help = "Demote from Whitelisted Mechanic", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Worker | Boss"}}})

RegisterServerEvent("Mechanic:RequestFine")
AddEventHandler("Mechanic:RequestFine", function(sender, amount)
	local source = source
	if Mechanic.Players[source] then
		Notify("Fine request sent", 3000, source)
		TriggerClientEvent("Mechanic:RequestFine", sender, amount, source)
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
	end
end)

RegisterServerEvent("Mechanic:Fine")
AddEventHandler("Mechanic:Fine", function(sender, amount, bool)
	local source = source
	if Mechanic.Players[sender] then
		if bool then
			Notify(GetIdentity(source).." paid the fee of $"..amount, 3000, sender)
			Notify("You paid the fee of $"..amount, 3000, source)
			TriggerEvent("core:getuser", source, function(user)
				user.removeBank(amount)
			end)
		else
			Notify(GetIdentity(source).." refused to pay the fee of $"..amount, 3000, sender)
			Notify("You refused to pay the fee of $"..amount, 3000, source)
		end
	else
		TriggerEvent("core:ban", sender, 99, "Script tampering", true, "Anticheat")
	end
end)
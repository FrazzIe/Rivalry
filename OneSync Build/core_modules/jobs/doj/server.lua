DOJ = {}
DOJ.Players = {}

function GetPermissionLevel(rank)
	if rank == "chief justice" or rank == "justice" or rank == "judge" then
		return 7
	elseif rank == "district attorney" or rank =="assistant district attorney" then
		return 6
	else return 0
	end
end

AddEventHandler("DOJ:Initialise", function(source, identifier, character_id)
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM doj WHERE character_id=@character_id", {["@character_id"] = character_id}, function(result)
		if result[1] == nil then
			TriggerClientEvent("DOJ:Set", source, {}, false, true)
		else
			DOJ.Players[source] = result[1]
			exports["mdt"]:SetPermissionLevel(source, GetPermissionLevel(result[1].rank))
			TriggerClientEvent("DOJ:Set", source, DOJ.Players[source], true, true)
		end
	end)
end)

RegisterServerEvent('DOJ:setService')
AddEventHandler('DOJ:setService', function (inService)
	TriggerEvent('core:getuser', source , function (Player)
		Player.setSessionVar('DOJInService', inService)
	end)
end)

RegisterServerEvent("DOJ:Grant")
AddEventHandler("DOJ:Grant", function(target, type)
	local source = source
	if DOJ.Players[source] then
		TriggerEvent("core:getuser", target, function(user)
			if type == "weapon" then
				user.set("weapon_license", "true")
				TriggerClientEvent("weapon:set_license", target, "true")
				Notify(GetIdentity(source).." issued you with a weapons license!", 3000, target)
				Notify("You issued "..GetIdentity(target).." with a weapons license", 3000, source)
			elseif type == "drivers" then
				user.set("drivers_license", "true")
				TriggerClientEvent("interaction:set_drivers_license", target, "true")
				Notify(GetIdentity(source).." issued you with a drivers license!", 3000, target)
				Notify("You issued "..GetIdentity(target).." with a drivers license", 3000, source)
			end
		end)
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
	end
end)

RegisterServerEvent("DOJ:Seize")
AddEventHandler("DOJ:Seize", function(target, type)
	local source = source
	if DOJ.Players[source] then
		TriggerEvent("core:getuser", target, function(user)
			if type == "weapon" then
				user.set("weapon_license", "false")
				TriggerClientEvent("weapon:set_license", target, "false")
				Notify("Your weapons license has been confiscated by "..GetIdentity(source), 3000, target)
				Notify("You confiscated "..GetIdentity(target).."'s weapons license", 3000, source)
			elseif type == "drivers" then
				user.set("drivers_license", "false")
				TriggerClientEvent("interaction:set_drivers_license", target, "false")
				Notify("Your drivers license has been confiscated by "..GetIdentity(source), 3000, target)
				Notify("You confiscated "..GetIdentity(target).."'s drivers license", 3000, source)
			end
		end)
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
	end
end)

TriggerEvent("core:addGroupCommand", "dojadd", "admin", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /dojadd [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if DOJ.Ranks[rank:lower()] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					DOJ.Players[tonumber(args[1])] = nil
					exports['GHMattiMySQL']:QueryAsync("DELETE FROM doj WHERE character_id=@character_id; INSERT INTO doj (`character_id`, `rank`) VALUES (@character_id, @rank)", {
						["@character_id"] = target.get("characterID"),
						["@rank"] = rank:lower(),
					})
					DOJ.Players[tonumber(args[1])] = { character_id = target.get("characterID"), rank = rank:lower(), onduty = "false" }
					TriggerEvent("mdt.set.permission", tonumber(args[1]), GetPermissionLevel(rank:lower()))
					Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been accepted. <br> Congratulations on joining the DOJ!", 10000, tonumber(args[1]))
					TriggerClientEvent("DOJ:Set", tonumber(args[1]), DOJ.Players[tonumber(args[1])], true)
				end)
			else
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "This rank does not exist")
			end
		else
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /dojadd [ID] [RANK]")
		end
	end
end, {help = "Add a player to the department of justice", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Paralegal | State Attorney | Assistant Distruct Attorney | District Attorney | Judge | Justice | Chief Justice"}}})

TriggerEvent("core:addGroupCommand", "addlawyer", "admin", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 1) then
		TriggerClientEvent("chatMessage", source, 'SYSTEM', {255, 0, 0}, "Usage : /lawyeradd [ID]")
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			TriggerEvent("core:getuser", tonumber(args[1]), function (target)
				TriggerClientEvent("Lawyer:Set", tonumber(args[1]), true)
			end)
		end
	end
end, {help = "", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent("core:addGroupCommand", "remlawyer", "admin", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 1) then
		TriggerClientEvent("chatMessage", source, 'SYSTEM', {255, 0, 0}, "Usage : /lawyeradd [ID]")
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			TriggerEvent("core:getuser", tonumber(args[1]), function (target)
				TriggerClientEvent("Lawyer:Set", tonumber(args[1]), false)
			end)
		end
	end
end, {help = "", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent("core:addGroupCommand", "dojrem", "admin", function(source, args, rawCommand, data, power, group)
	local source = source
	if(not args[1]) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /dojrem [ID]")	
	else
		if GetPlayerName(tonumber(args[1])) then
			if DOJ.Players[tonumber(args[1])] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					DOJ.Players[tonumber(args[1])] = nil
					exports['GHMattiMySQL']:QueryAsync("DELETE FROM doj WHERE character_id=@character_id", {["@character_id"] = target.get("characterID")})
					TriggerEvent("mdt.set.permission", tonumber(args[1]), 0)
					Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been fired. <br> They are no longer an officer of the DOJ!", 10000, tonumber(args[1]))
					TriggerClientEvent("DOJ:Set", tonumber(args[1]), DOJ.Players[tonumber(args[1])], false)
				end)
			else
				Notify("This user is not apart of the doj", 3000, source)
			end
		else
			Notify("No player with this ID !", 3000, source)
		end
	end
end, {help = "Remove a player from the department of justice", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent("core:addGroupCommand", "dojpromote", "emergency", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /dojpromote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if DOJ.Players[source] ~= nil then
				if DOJ.Players[tonumber(args[1])] ~= nil then
					if DOJ.Ranks[rank:lower()] ~= nil then
						canTargetRank(DOJ.Players[source].rank, DOJ.Players[tonumber(args[1])].rank, function(cb)
							if cb then
								if canPromote(DOJ.Players[source].rank) then
									TriggerEvent("core:getuser", tonumber(args[1]), function(target)
										exports['GHMattiMySQL']:QueryAsync("UPDATE doj SET rank=@rank WHERE character_id=@character_id", {["@character_id"] = target.get("characterID"), ["@rank"] = rank:lower()})
										DOJ.Players[tonumber(args[1])].rank = rank:lower()
										TriggerEvent("mdt.set.permission", tonumber(args[1]), 0)
										Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been promoted!</span><br> You are now a "..rank, 10000, tonumber(args[1]))
										TriggerClientEvent("DOJ:Set", tonumber(args[1]), DOJ.Players[tonumber(args[1])], true)
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
					Notify("This user is not apart of the doj", 3000, source)
				end
			else
				Notify("You aren't apart of the doj", 3000, source)
			end
		else
			Notify("Player could not be found", 3000, source)
		end
	end
end, {help = "Promote an officer", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Paralegal | State Attorney | Assistant Distruct Attorney | District Attorney | Judge | Justice | Chief Justice"}}})

TriggerEvent("core:addGroupCommand", "dojdemote", "emergency", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /dojdemote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if DOJ.Players[source] ~= nil then
				if DOJ.Players[tonumber(args[1])] ~= nil then
					if DOJ.Ranks[rank:lower()] ~= nil then
						canTargetRank(DOJ.Players[source].rank, DOJ.Players[tonumber(args[1])].rank, function(cb)
							if cb then
								if canPromote(DOJ.Players[source].rank) then
									TriggerEvent("core:getuser", tonumber(args[1]), function(target)
										exports['GHMattiMySQL']:QueryAsync("UPDATE doj SET rank=@rank WHERE character_id=@character_id", {["@character_id"] = target.get("characterID"), ["@rank"] = rank:lower()})
										DOJ.Players[tonumber(args[1])].rank = rank:lower()
										TriggerEvent("mdt.set.permission", tonumber(args[1]), GetPermissionLevel(rank:lower()))
										Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been demoted!</span><br> You are now a "..rank, 10000, tonumber(args[1]))
										TriggerClientEvent("DOJ:Set", tonumber(args[1]), DOJ.Players[tonumber(args[1])], true)
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
					Notify("This user is not apart of the doj", 3000, source)
				end
			else
				Notify("You aren't apart of the doj", 3000, source)
			end
		else
			Notify("Player could not be found", 3000, source)
		end
	end
end, {help = "Demote an Officer", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Paralegal | State Attorney | Assistant Distruct Attorney | District Attorney | Judge | Justice | Chief Justice"}}})

RegisterServerEvent("DOJ:RequestFine")
AddEventHandler("DOJ:RequestFine", function(sender, amount)
	local source = source
	if DOJ.Players[source] then
		Notify("Fine request sent", 3000, source)
		TriggerClientEvent("DOJ:RequestFine", sender, amount, source)
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
	end
end)

RegisterServerEvent("DOJ:Fine")
AddEventHandler("DOJ:Fine", function(sender, amount, bool)
	local source = source
	if DOJ.Players[sender] then
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
News = {}
News.Players = {}
News.OnDutyPlayers = {}

AddEventHandler("News:Initialise", function(source, identifier, character_id)
	exports["ghmattimysql"]:execute("SELECT * FROM newsreporter WHERE character_id=?", {character_id}, function(result)
		if result[1] == nil then
			TriggerClientEvent("News:Set", source, {}, false, true)
		else
			News.Players[source] = result[1]
			TriggerClientEvent("News:Set", source, News.Players[source], true, true)
		end
	end)
end)

RegisterServerEvent("News:Sync")
AddEventHandler("News:Sync", function(type)
	local Source = source
	if type == "remove" then
		for Index = 1, #News.OnDutyPlayers do
			if News.OnDutyPlayers[Index] == Source then
				table.remove(News.OnDutyPlayers, Index)
				TriggerEvent('core:getuser', Source , function (Player)
					Player.setSessionVar('newsInService', false)
				end)
			end
		end
	end
	if type == "add" then
		table.insert(News.OnDutyPlayers, Source)
		TriggerEvent('core:getuser', Source , function (Player)
			Player.setSessionVar('newsInService', true)
		end)
	end
end)

RegisterServerEvent("News:Dispatch")
AddEventHandler("News:Dispatch", function(street_name, crossing_name)
	for k, v in ipairs(News.OnDutyPlayers) do
		TriggerClientEvent("chatMessage", v, "NEWS", {255, 0, 0}, "^7Crime reported at "..street_name.." crossing "..crossing_name)
	end
end)

TriggerEvent("core:addGroupCommand", "newsadd", "admin", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /newsadd [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if News.Ranks[rank:lower()] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					News.Players[tonumber(args[1])] = nil
					exports["ghmattimysql"]:execute("DELETE FROM newsreporter WHERE character_id=?; INSERT INTO newsreporter (`character_id`, `rank`) VALUES (?, ?)", {target.get("characterID"), target.get("characterID"), rank:lower()})
					News.Players[tonumber(args[1])] = { character_id = target.get("characterID"), rank = rank:lower(), onduty = "false" }
					Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been accepted. <br> Congratulations on joining the News!", 10000, tonumber(args[1]))
					TriggerClientEvent("News:Set", tonumber(args[1]), News.Players[tonumber(args[1])], true)
				end)
			else
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "This rank does not exist")
			end
		else
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /Newsadd [ID] [RANK]")
		end
	end
end, {help = "Add a player to the news team", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Chief Executive / Lead Reporter / Lead Cameraman / Journalist II / Photographer II / Cameraman II / Journalist I / Photographer I/ Cameraman I / Intern"}}})

TriggerEvent("core:addGroupCommand", "newsrem", "admin", function(source, args, rawCommand, data, power, group)
	local source = source
	if(not args[1]) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /Newsrem [ID]")	
	else
		if GetPlayerName(tonumber(args[1])) then
			if News.Players[tonumber(args[1])] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					News.Players[tonumber(args[1])] = nil
					exports["ghmattimysql"]:execute("DELETE FROM newsreporter WHERE character_id=?", {target.get("characterID")})
					Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been fired. <br> They are no longer an officer of the News!", 10000, tonumber(args[1]))
					TriggerClientEvent("News:Set", tonumber(args[1]), News.Players[tonumber(args[1])], false)
				end)
			else
				Notify("This user is not apart of the News", 3000, source)
			end
		else
			Notify("No player with this ID !", 3000, source)
		end
	end
end, {help = "Remove a player from the news team", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent("core:addGroupCommand", "newspromote", "emergency", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /newspromote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if News.Players[source] ~= nil then
				if News.Players[tonumber(args[1])] ~= nil then
					if News.Ranks[rank:lower()] ~= nil then
						canTargetRank(News.Players[source].rank, News.Players[tonumber(args[1])].rank, function(cb)
							if cb then
								if canPromote(News.Players[source].rank) then
									TriggerEvent("core:getuser", tonumber(args[1]), function(target)
										exports["ghmattimysql"]:execute("UPDATE newsreporter SET rank=? WHERE character_id=?", {rank:lower(), target.get("characterID")})
										News.Players[tonumber(args[1])].rank = rank:lower()
										Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been promoted!</span><br> You are now a "..rank, 10000, tonumber(args[1]))
										TriggerClientEvent("News:Set", tonumber(args[1]), News.Players[tonumber(args[1])], true)
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
					Notify("This user is not apart of the News", 3000, source)
				end
			else
				Notify("You aren't apart of the News", 3000, source)
			end
		else
			Notify("Player could not be found", 3000, source)
		end
	end
end, {help = "Promote an journalist", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Chief Executive / Lead Reporter / Lead Cameraman / Journalist II / Photographer II / Cameraman II / Journalist I / Photographer I/ Cameraman I / Intern"}}})

TriggerEvent("core:addGroupCommand", "newsdemote", "emergency", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /newsdemote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if News.Players[source] ~= nil then
				if News.Players[tonumber(args[1])] ~= nil then
					if News.Ranks[rank:lower()] ~= nil then
						canTargetRank(News.Players[source].rank, News.Players[tonumber(args[1])].rank, function(cb)
							if cb then
								if canPromote(News.Players[source].rank) then
									TriggerEvent("core:getuser", tonumber(args[1]), function(target)
										exports["ghmattimysql"]:execute("UPDATE newsreporter SET rank=? WHERE character_id=?", {rank:lower(), target.get("characterID")})
										News.Players[tonumber(args[1])].rank = rank:lower()
										Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been demoted!</span><br> You are now a "..rank, 10000, tonumber(args[1]))
										TriggerClientEvent("News:Set", tonumber(args[1]), News.Players[tonumber(args[1])], true)
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
					Notify("This user is not apart of the News", 3000, source)
				end
			else
				Notify("You aren't apart of the News", 3000, source)
			end
		else
			Notify("Player could not be found", 3000, source)
		end
	end
end, {help = "Demote an journalist", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Chief Executive / Lead Reporter / Lead Cameraman / Journalist II / Photographer II / Cameraman II / Journalist I / Photographer I/ Cameraman I / Intern"}}})
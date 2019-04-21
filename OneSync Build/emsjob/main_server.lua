--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
ems = {}
ranks = {}
user_models = {}
local doors = {
	single = {
		true, -- Morgue, reception door
		true, -- Morgue, reception door 2
		true, -- Computing room, 3rd floor, door 1
		true, -- Computing room, 3rd floor, door 2
		true, -- Medical office, 3rd floor
	},
	double = {
		{
			["left"] = false,
			["right"] = false,
		}, -- Inner Pillbox hospital doors
		{
			["left"] = false,
			["right"] = false,
		}, -- Computing room, 3rd floor, double doors
		{
			["left"] = false,
			["right"] = false,
		}, -- Documents room, 3rd floor
		{
			["left"] = false,
			["right"] = false,
		}, -- Forensics Lab, 3rd floor Middle doors
		{
			["left"] = false,
			["right"] = false,
		}, -- Forensics Lab, 3rd floor Left doors
		{
			["left"] = false,
			["right"] = false,
		}, -- Forensics Lab, 3rd floor Right doors
	}
}
local function addRank(rank, inherit)
	if ranks[inherit] then
		local table = {}
		for k,v in pairs(ranks[inherit]) do
			table[k] = {}
		end
		table[inherit] = {}
		for k,v in pairs(ranks) do
			if v[inherit] then
				v[rank] = {}
			end
		end
		ranks[rank] = table
	else
		for k,v in pairs(ranks) do
			v[rank] = {}
		end
		ranks[rank] = {}	
	end
end

local function canTargetRank(user, target, callback)
	if ranks[user] then
		if ranks[target] then
			if ranks[user][target] then
				callback(true)
			else
				callback(false)
			end
		else
			print("Error -> canTargetRank -> "..target.." rank doesn't exist.")
			callback(false)
		end
	else
		print("Error -> canTargetRank -> "..user.." rank doesn't exist.")
		callback(false)
	end
end

local function canPromote(rank)
	if rank == "chief" or rank == "lieutenant" or rank == "captain" or rank == "assistant chief" then
		return true
	else
		return false
	end
end

function getID(type, source)
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" and (type == "steam" or type == 1) then
            return v
        elseif string.sub(tostring(v), 1, string.len("license:")) == "license:" and (type == "license" or type == 2) then
            return v
        elseif string.sub(tostring(v), 1, string.len("ip:")) == "ip:" and (type == "ip" or type == 3) then
            return v
        end
    end
    return nil
end

function GetPermissionLevel(rank)
	if rank == "probationary" or rank == "paramedic" or rank == "coroner" or rank == "doctor" or rank == "specialist" then
		return 4
	else
		return 5
	end
end

addRank("chief", "")
addRank("assistant chief", "")
addRank("captain", "")
addRank("lieutenant", "")
addRank("fto", "")
addRank("specialist", "")
addRank("doctor", "")
addRank("coroner", "")
addRank("paramedic", "")
addRank("probationary", "")

AddEventHandler("paramedic:initialise", function(source, identifier, character_id)
	TriggerClientEvent("paramedic:setranks", source, ranks)

	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM paramedic WHERE character_id=@character_id", {["@character_id"] = character_id}, function(paramedic)
		if paramedic[1] == nil then
			TriggerClientEvent("paramedic:set", source, {}, false, true)
		else
			ems[source] = paramedic[1]
			if ems[source]["unit"] then
				ems[source]["unit_number"] = "M-"..ems[source]["unit"]
			end
			TriggerClientEvent("paramedic:set", source, ems[source], true, true)
			exports["mdt"]:SetPermissionLevel(source, GetPermissionLevel(ems[source]["rank"]))
		end
	end)
end)

TriggerEvent("core:addGroupCommand", "emsadd", "command", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emsadd [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if ranks[rank:lower()] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					ems[tonumber(args[1])] = nil
					exports['GHMattiMySQL']:QueryAsync("DELETE FROM paramedic WHERE character_id=@character_id; INSERT INTO paramedic (`character_id`, `rank`, `onduty`) VALUES (@character_id, @rank, @onduty)", {
						["@character_id"] = target.get("characterID"),
						["@rank"] = rank:lower(),
						["@onduty"] = "false",
					})
					ems[tonumber(args[1])] = {character_id = target.get("characterID"), rank = rank:lower(), onduty = "false" }
					exports["mdt"]:SetPermissionLevel(source, GetPermissionLevel(rank:lower()))
					TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been accepted. <br> Congratulations on joining the LSFD!",type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
					TriggerClientEvent('paramedic:set', tonumber(args[1]), ems[tonumber(args[1])], true)
				end)
			else
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "This rank does not exist")
			end
		else
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emsadd [ID] [RANK]")
		end
	end
end, {help = "Add a player to the LSFD", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Probationary | Paramedic | Coroner | Doctor | Specialist | FTO | Lieutenant | Captain | Assistant Chief | Chief"}}})

TriggerEvent("core:addGroupCommand", "emsrem", "command", function(source, args, rawCommand, data, power, group)
	local source = source
	if(not args[1]) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emsrem [ID]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil)then
			if ems[tonumber(args[1])] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					ems[tonumber(args[1])] = nil
					exports["mdt"]:SetPermissionLevel(source, 0)
					exports['GHMattiMySQL']:QueryAsync("DELETE FROM paramedic WHERE character_id=@character_id", {["@character_id"] = target.get("characterID")})
					TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been fired. <br> They are no longer part of the LSFD!",type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
					TriggerClientEvent('paramedic:set', tonumber(args[1]), ems[tonumber(args[1])], false)
				end)
			else
				Notify("This user is not a paramedic", 3000, source)
			end
		else
			Notify("No player with this ID !", 3000, source)
		end
	end
end, {help = "Remove a player from the LSFD", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent("core:addGroupCommand", "emspromote", "emergency", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emspromote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if ems[source] ~= nil then
				if ems[tonumber(args[1])] ~= nil then
					if ranks[rank:lower()] ~= nil then
						canTargetRank(ems[source].rank, ems[tonumber(args[1])].rank, function(cb)
							if cb then
								if canPromote(ems[source].rank) then
									TriggerEvent("core:getuser", tonumber(args[1]), function(target)
										exports['GHMattiMySQL']:QueryAsync("UPDATE paramedic SET rank=@rank WHERE character_id=@character_id", {["@character_id"] = target.get("characterID"), ["@rank"] = rank:lower()})
										ems[tonumber(args[1])].rank = rank:lower()
										exports["mdt"]:SetPermissionLevel(source, GetPermissionLevel(rank:lower()))
										TriggerClientEvent("pNotify:SendNotification", tonumber(args[1]), {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been promoted!</span><br> You are now a "..rank,type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
										TriggerClientEvent('paramedic:set', tonumber(args[1]), ems[tonumber(args[1])], true)
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
					Notify("This user is not a paramedic", 3000, source)
				end
			else
				Notify("You aren't a paramedic", 3000, source)
			end
		else
			Notify("Player could not be found", 3000, source)
		end
	end
end, {help = "Promote a paramedic", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Probationary | Paramedic | Coroner | Doctor | Specialist | FTO | Lieutenant | Captain | Assistant Chief | Chief"}}})

TriggerEvent("core:addGroupCommand", "emsdemote", "emergency", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emsdemote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if ems[source] ~= nil then
				if ems[tonumber(args[1])] ~= nil then
					if ranks[rank:lower()] ~= nil then
						canTargetRank(ems[source].rank, ems[tonumber(args[1])].rank, function(cb)
							if cb then
								if canPromote(ems[source].rank) then
									TriggerEvent("core:getuser", tonumber(args[1]), function(target)
										exports['GHMattiMySQL']:QueryAsync("UPDATE paramedic SET rank=@rank WHERE character_id=@character_id", {["@character_id"] = target.get("characterID"), ["@rank"] = rank:lower()})
										ems[tonumber(args[1])].rank = rank:lower()
										exports["mdt"]:SetPermissionLevel(source, GetPermissionLevel(rank:lower()))
										TriggerClientEvent("pNotify:SendNotification", tonumber(args[1]), {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been demoted!</span><br> You are now a "..rank,type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
										TriggerClientEvent('paramedic:set', tonumber(args[1]), ems[tonumber(args[1])], true)
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
					Notify("This user is not a paramedic", 3000, source)
				end
			else
				Notify("You aren't a paramedic", 3000, source)
			end
		else
			Notify("Player could not be found", 3000, source)
		end
	end
end, {help = "Demote an Officer", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Probationary | Paramedic | Coroner | Doctor | Specialist | FTO | Lieutenant | Captain | Assistant Chief | Chief"}}})

RegisterServerEvent("paramedic:doors_lock")
AddEventHandler("paramedic:doors_lock", function(doorid, type)
	local source = source
	if type == "single" then
		doors.single[doorid] = not doors.single[doorid]
		TriggerClientEvent("paramedic:doors_sync", -1, doors)
	elseif type == "double" then
		doors.double[doorid]["left"] = not doors.double[doorid]["left"]
		doors.double[doorid]["right"] = doors.double[doorid]["left"]
		TriggerClientEvent("paramedic:doors_sync", -1, doors)
	end
end)
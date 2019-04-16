--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
ranks = {}
cops = {}
user_models = {}
local doors = {
	single = {
		true, -- Mission Row Interrogation Cell Door 1
		true, -- Mission Row Interrogation Cell Door 2
		true, -- Mission Row Interrogation Observe
		true, -- Mission Row Mug Shot
		true, -- Mission Row Door To Cells Back
		true, -- Mission Row Cell Door 1
		true, -- Mission Row Cell Door 2
		true, -- Mission Row Cell Door 3
		true, -- Mission Row Door To Cells Front
		true, -- Mission Row Police Station Captan's Office Door
		true, -- Mission Row Police Station Door To Locker Rooms
		true, -- Mission Row Police Station Locker Room 1 Door
		true, -- Mission Row Police Station Roof Access Door
		true, -- Mission Row Police Station Roof Door
		true, -- Sandy Shores Main Door
		true, -- Sandy Jail Cell 1
		true, -- Sandy Jail Cell 2
		true, -- Sandy Jail Cell 3
		true, -- Sandy Jail Cell 4 Lockdown
		true, -- Sandy Jail Cell 5 Lockdown
	},
	double = {
		{
			["left"] = false,
			["right"] = false,
		}, -- Mission Row Police Station Main Entrance
		{
			["left"] = true,
			["right"] = true,
		}, -- Mission Row Police Station Back Entrance
		{
			["left"] = true,
			["right"] = true,
		}, -- Mission Row Police Station Cell And Briefing Doors
		{
			["left"] = true,
			["right"] = true,
		}, -- Mission Row Police Station Briefing Doors
		{
			["left"] = true,
			["right"] = true,
		}, -- Mission Row Police Station Interrogation Main Doors
	},
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
	if rank == "chief of police" or rank == "colonel" or rank == "deputy chief of police" or rank == "lieutenant colonel" or rank == "captain" or rank == "director" or rank == "lieutenant" then
		return true
	else
		return false
	end
end

local function GetCallSign(rank)
	if rank == "chief of police" or rank == "assistant chief" or rank == "deputy chief of police" then
		return "O-"
	elseif rank == "captain ii" or rank == "captain" or rank == "lieutenant ii" or rank == "lieutenant" then
		return "S-"
	elseif rank == "sergeant ii" or rank == "sergeant i" then
		return "L-"
	elseif rank == "detective" or rank == "senior detective" or rank == "chief inspector" then
		return "D-"
	elseif rank == "officer ii" or rank == "officer i" then
		return "A-"
	elseif rank == "cadet" then
		return "R-"
	else
		return "U-"
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

function Notify(source,msg)
	TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text = msg,type = "error",queue = "left",timeout = 3500,layout = "centerRight"})
end

addRank("chief of police", "")
addRank("colonel", "")
addRank("deputy chief of police", "")
addRank("lieutenant colonel", "")
addRank("captain", "")
addRank("director", "")
addRank("lieutenant", "")
addRank("sergeant", "")
addRank("detective", "")
addRank("officer ii", "")
addRank("officer i", "")
addRank("recruit", "")
addRank("cadet", "")

exports("GetCop", function(Player)
	return cops[Player]
end)

AddEventHandler('police:initialise', function(source, identifier, character_id)
	TriggerClientEvent("police:doors_sync", -1, doors)
	TriggerClientEvent("police:setranks", source, ranks)

	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police WHERE character_id=@character_id", {["@character_id"] = character_id}, function(officer)
		if officer[1] == nil then
			TriggerClientEvent("police:set", source, {}, false, true)
		else
			cops[source] = officer[1]
			if cops[source]["rank"] and cops[source]["unit"] then
				cops[source]["unit_number"] = GetCallSign(cops[source]["rank"])..cops[source]["unit"]
			end
			TriggerClientEvent("police:set", source, cops[source], true, true)
		end
	end)
end)

RegisterServerEvent("police:doors_lock")
AddEventHandler("police:doors_lock", function(doorid, type)
	local source = source
	if type == "single" then
		doors.single[doorid] = not doors.single[doorid]
		TriggerClientEvent("police:doors_sync", -1, doors)
	elseif type == "double" then
		doors.double[doorid]["left"] = not doors.double[doorid]["left"]
		doors.double[doorid]["right"] = doors.double[doorid]["left"]
		TriggerClientEvent("police:doors_sync", -1, doors)
	end
end)

TriggerEvent("core:addGroupCommand", "copadd", "command", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /copadd [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if ranks[rank:lower()] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					cops[tonumber(args[1])] = nil
					exports['GHMattiMySQL']:QueryAsync("DELETE FROM police WHERE character_id=@character_id; INSERT INTO police (`character_id`, `rank`, `onduty`) VALUES (@character_id, @rank, @onduty)", {
						["@character_id"] = target.get("characterID"),
						["@rank"] = rank:lower(),
						["@onduty"] = "false",
					})
					cops[tonumber(args[1])] = { character_id = target.get("characterID"), rank = rank:lower(), onduty = "false" }
					TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been accepted. <br> Congratulations on joining the LSPD!",type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
					TriggerClientEvent('police:set', tonumber(args[1]), cops[tonumber(args[1])], true)
				end)
			else
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "This rank does not exist")
			end
		else
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /copadd [ID] [RANK]")
		end
	end
end, {help = "Add a player to the police force", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Cadet | Officer I | Officer II | Detective | Trooper | Sergeant | Trooper Sergeant | Lieutenant | Director | Captain | Lieutenant Colonel | Deputy Chief of Police | Colonel | Chief of Police"}}})

TriggerEvent("core:addGroupCommand", "coprem", "command", function(source, args, rawCommand, data, power, group)
	local source = source
	if(not args[1]) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /coprem [ID]")	
	else
		if GetPlayerName(tonumber(args[1])) then
			if cops[tonumber(args[1])] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					cops[tonumber(args[1])] = nil
					exports['GHMattiMySQL']:QueryAsync("DELETE FROM police WHERE character_id=@character_id", {["@character_id"] = target.get("characterID")})
					TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been fired. <br> They are no longer an officer of the LSPD!",type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
					TriggerClientEvent('police:set', tonumber(args[1]), cops[tonumber(args[1])], false)
				end)
			else
				Notify(source,"This user is not a cop")
			end
		else
			Notify(source,"No player with this ID !")
		end
	end
end, {help = "Remove a player from the police force", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent("core:addGroupCommand", "coppromote", "emergency", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /coppromote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if cops[source] ~= nil then
				if cops[tonumber(args[1])] ~= nil then
					if ranks[rank:lower()] ~= nil then
						canTargetRank(cops[source].rank, cops[tonumber(args[1])].rank, function(cb)
							if cb then
								if canPromote(cops[source].rank) then
									TriggerEvent("core:getuser", tonumber(args[1]), function(target)
										exports['GHMattiMySQL']:QueryAsync("UPDATE police SET rank=@rank WHERE character_id=@character_id", {["@character_id"] = target.get("characterID"), ["@rank"] = rank:lower()})
										cops[tonumber(args[1])].rank = rank:lower()
										TriggerClientEvent("pNotify:SendNotification", tonumber(args[1]), {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been promoted!</span><br> You are now a "..rank,type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
										TriggerClientEvent('police:set', tonumber(args[1]), cops[tonumber(args[1])], true)
									end)
								else
									Notify(source,"You cannot promote anyone")
								end
							else
								Notify(source,"You cannot target this player")
							end
						end)
					else
						Notify(source,"This rank does not exist")
					end
				else
					Notify(source,"This user is not a cop")
				end
			else
				Notify(source,"You aren't a cop")
			end
		else
			Notify(source,"Player could not be found")
		end
	end
end, {help = "Promote an officer", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Cadet | Officer I | Officer II | Detective | Trooper | Sergeant | Trooper Sergeant | Lieutenant | Director | Captain | Lieutenant Colonel | Deputy Chief of Police | Colonel | Chief of Police"}}})

TriggerEvent("core:addGroupCommand", "copdemote", "emergency", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /copdemote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if cops[source] ~= nil then
				if cops[tonumber(args[1])] ~= nil then
					if ranks[rank:lower()] ~= nil then
						canTargetRank(cops[source].rank, cops[tonumber(args[1])].rank, function(cb)
							if cb then
								if canPromote(cops[source].rank) then
									TriggerEvent("core:getuser", tonumber(args[1]), function(target)
										exports['GHMattiMySQL']:QueryAsync("UPDATE police SET rank=@rank WHERE character_id=@character_id", {["@character_id"] = target.get("characterID"), ["@rank"] = rank:lower()})
										cops[tonumber(args[1])].rank = rank:lower()
										TriggerClientEvent("pNotify:SendNotification", tonumber(args[1]), {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been demoted!</span><br> You are now a "..rank,type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
										TriggerClientEvent('police:set', tonumber(args[1]), cops[tonumber(args[1])], true)
									end)
								else
									Notify(source,"You cannot demote anyone")
								end
							else
								Notify(source,"You cannot target this player")
							end
						end)
					else
						Notify(source,"This rank does not exist")
					end
				else
					Notify(source,"This user is not a cop")
				end
			else
				Notify(source,"You aren't a cop")
			end
		else
			Notify(source,"Player could not be found")
		end
	end
end, {help = "Demote an Officer", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Cadet | Officer I | Officer II | Detective | Trooper | Sergeant | Trooper Sergeant | Lieutenant | Director | Captain | Lieutenant Colonel | Deputy Chief of Police | Colonel | Chief of Police"}}})

RegisterServerEvent("jail:user")
AddEventHandler("jail:user",function(target, time, reason)
	local source = source
	if cops[source] then
	    TriggerEvent("core:getuser", target, function(user)
	        TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>"..user.get("first_name").." "..user.get("last_name").."</span> has been arrested! <br> Time: <span style='color:lime'>".. time .."</span> months <br> Charges: <span style='color:lime'>".. reason .. " - " .. GetIdentity(source) .."</span>",type = "error",queue = "left",timeout = 15000,layout = "bottomRight"})
	        TriggerClientEvent("pNotify:SendNotification", tonumber(target), {text = "You have arrived at the Bolingbroke San Andreas State Penitentiary...",type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
	        TriggerClientEvent("jail:jail", target , tonumber(time) * 60)
	        user.set("jail_time", tonumber(time))
	        user.set("dateofjail", os.time())
	    end)
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
	end
end)

RegisterServerEvent("police:tackle")
AddEventHandler("police:tackle", function(targets)
	local source = source
	if cops[source] then
		for i = 1, #targets do
			TriggerClientEvent("police:tackle", targets[i], source)
		end
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
	end
end)

AddEventHandler("police:iscop", function(user, cb)
	if cops[user] then
		cb(true)
	else
		cb(false)
	end
end)

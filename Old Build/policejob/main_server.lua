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
		[1] = {x = 463.4782, y = -1003.538, z = 25.00599, model = -1033001619, heading = 0.0, locked = true}, -- Mission Row Door To Cells Back
		[2] = {x = 461.8065, y = -994.4086, z = 25.06443, model = 631614199, heading = 270.0, locked = true}, -- Mission Row Cell Door 1
		[3] = {x = 461.8065, y = -997.6583, z = 25.06443, model = 631614199, heading = 90.0, locked = true}, -- Mission Row Cell Door 2
		[4] = {x = 461.8065, y = -1001.302, z = 25.06443, model = 631614199, heading = 90.0, locked = true}, -- Mission Row Cell Door 3
		[5] = {x = 464.5701, y = -992.6641, z = 25.06443, model = 631614199, heading = 0.0, locked = true}, -- Mission Row Door To Cells Front
		[6] = {x = 446.5728, y = -980.0106, z = 30.8393, model = -1320876379, heading = 180.00012207031, locked = true}, -- Mission Row Police Station Captan's Office Door
		[7] = {x = 450.1041, y = -985.73840, z = 30.8393, model = 1557126584, heading = 89.661880493164, locked = true}, -- Mission Row Police Station Door To Locker Rooms
		[8] = {x = 452.6248, y = -987.3626, z = 30.8393, model = -2023754432, heading = 179.75776672363, locked = true}, -- Mission Row Police Station Locker Room 1 Door
		[9] = {x = 461.2865, y = -985.3206, z = 30.83926, model = 749848321, heading = 90.0, locked = true}, -- Mission Row Police Station Roof Access Door
		[10] = {x = 464.3613, y = -984.678, z = 43.83443, model = -340230128, heading = 90.0, locked = true}, -- Mission Row Police Station Roof Door
		[11] = {x = 1855.2312011719, y = 3683.5375976563, z = 34.266860961914, model = -1765048490, heading = 30.19642829895, locked = false}, -- Sandy Shores Main Door
		[12] = {x = 1846.4598388672, y = 3662.5939941406, z = -116.789894104, model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 1
		[13] = {x = 1852.0426025391, y = 3665.8259277344, z = -116.789894104, model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 2
		[14] = {x = 1857.5572509766, y = 3668.9914550781, z = -116.77988433838, model = -642608865, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 3
		[15] = {x = 1857.5572509766, y = 3668.9914550781, z = -116.77988433838, model = 871712474, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 4 Lockdown
		[16] = {x = 1872.2075195313, y = 3676.9758300781, z = -116.7799911499, model = 871712474, heading = 30.000001907349, locked = true}, -- Sandy Jail Cell 5 Lockdown
	},

	double = {
		[1] = {
			["left"] = {x = 434.7479, y = -980.6184, z = 30.839260, model = -1215222675, heading = 270.18865966797, locked = false},
			["right"] = {x = 434.7479, y = -983.2151, z = 30.83926, model = 320433149, heading = 270.39477539063, locked = false},
		}, -- Mission Row Police Station Main Entrance
		[2] = {
			["left"] = {x = 467.3716, y = -1014.452, z = 26.53623, model = -2023754432, heading = 0.0, locked = true},
			["right"] = {x = 469.9679, y = -1014.452, z = 26.53623, model = -2023754432, heading = 179.99998474121, locked = true},
		}, -- Mission Row Police Station Back Entrance
		[3] = {
			["left"] = {x = 446.0079, y = -989.4454, z = 30.8393, model = 185711165, heading = 0.0, locked = true},
			["right"] = {x = 443.4078, y = -989.4454, z = 30.8393, model = 185711165, heading = 179.99998474121, locked = true},
		}, -- Mission Row Police Station Cell And Briefing Doors
		[4] = {
			["left"] = {x = 443.0298, y = -994.5412, z = 30.8393, model = -131296141, heading = 270.0, locked = true},
			["right"] = {x = 443.0298, y = -991.941, z = 30.8393, model = -131296141, heading = 90.0, locked = true},
		}, -- Mission Row Police Station Briefing Doors
	},
	jaildoors = {
		[1] = {x = 1818.5627441406, y = 2605.3168945313, z = 45.569450378418, h = 82.570022583008, model = 741314661},
		[2] = {x = 1845.115234375, y = 2605.5734863281, z = 45.568618774414, h = 267.99041748047, model = 741314661},
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

AddEventHandler('police:initialise', function(source, identifier, character_id)
	TriggerClientEvent("police:doors_sync", -1, doors)
	TriggerClientEvent("police:setranks", source, ranks)
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * from police_models WHERE character_id=@character_id", {["@character_id"] = character_id}, function(result)
    	if result[1] == nil then
	        exports["GHMattiMySQL"]:QueryAsync("INSERT INTO police_models (`character_id`,`model`,`new`,`clothing_drawables`,`clothing_textures`,`clothing_palette`,`props_drawables`,`props_textures`,`overlays_drawables`,`overlays_opacity`,`overlays_colours`) VALUES (@character_id,@model,@new,@clothing_drawables,@clothing_textures,@clothing_palette,@props_drawables,@props_textures,@overlays_drawables,@overlays_opacity,@overlays_colours)", {
	            ["@character_id"] = character_id,
	            ["@model"] = "s_m_y_cop_01",
	            ["@new"] = "true",
	            ["@clothing_drawables"] = json.encode({0,0,0,0,0,0,0,0,0,0,0,0}),
	            ["@clothing_textures"] = json.encode({2,0,1,1,0,0,0,0,0,0,0,0}),
	            ["@clothing_palette"] = json.encode({0,0,0,0,0,0,0,0,0,0,0,0}),
	            ["@props_drawables"] = json.encode({-1,-1,-1,-1,-1,-1,-1,-1}),
	            ["@props_textures"] = json.encode({-1,-1,-1,-1,-1,-1,-1,-1}),
	            ["@overlays_drawables"] = json.encode({-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}),
	            ["@overlays_opacity"] = json.encode({1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}),
	            ["@overlays_colours"] = json.encode({{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}}),
	        })
	    	local models = {}
	    	models.model = "s_m_y_cop_01"
	    	models.new = "true"
	    	models.clothing = { drawables = {0,0,0,0,0,0,0,0,0,0,0,0}, textures = {2,0,1,1,0,0,0,0,0,0,0,0}, palette = {0,0,0,0,0,0,0,0,0,0,0,0} }
	    	models.props = { drawables = {-1,-1,-1,-1,-1,-1,-1,-1}, textures = {-1,-1,-1,-1,-1,-1,-1,-1} }
	    	models.overlays = { drawables = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}, opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}, colours = {{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}} }
	    	user_models[source] = models
    	else
	    	local models = {}
	    	models.model = result[1].model
	    	models.new = result[1].new
	    	models.clothing = { drawables = json.decode(result[1].clothing_drawables), textures = json.decode(result[1].clothing_textures), palette = json.decode(result[1].clothing_palette) }
	    	models.props = { drawables = json.decode(result[1].props_drawables), textures = json.decode(result[1].props_textures) }
	    	models.overlays = { drawables = json.decode(result[1].overlays_drawables), opacity = json.decode(result[1].overlays_opacity), colours = json.decode(result[1].overlays_colours) }
	    	user_models[source] = models
	    end
    end)
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
		doors.single[doorid].locked = not doors.single[doorid].locked
		TriggerClientEvent("police:doors_sync", -1, doors)
	elseif type == "double" then
		doors.double[doorid]["left"].locked = not doors.double[doorid]["left"].locked
		doors.double[doorid]["right"].locked = doors.double[doorid]["left"].locked
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

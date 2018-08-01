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
		[1] = {x = 272.21752929688, y = -1361.5660400391, z = 24.551530838013, model = 1653893025, heading = 320.00003051758, locked = true}, -- Morgue, reception door
		[2] = {x = 265.06137084961, y = -1363.3120117188, z = 24.551530838013, model = 1653893025, heading = 230.00003051758, locked = true}, -- Morgue, reception door 2
		[3] = {x = 256.56033325195, y = -1377.4182128906, z = 39.737594604492, model = 374758529, heading = 4.9999651908875, locked = true}, -- Computing room, 3rd floor, door 1
		[4] = {x = 261.21139526367, y = -1380.8220214844, z = 39.737594604492, model = 374758529, heading = 320.00003051758, locked = true}, -- Computing room, 3rd floor, door 2
		[5] = {x = 236.77729797363, y = -1367.3142089844, z = 39.679546356201, model = 1859711902, heading = 95.08666229248, locked = true}, -- Medical office, 3rd floor
	},
	double = {
		[1] = {
			["left"] = {x = 325.05090332031, y = -588.92846679688, z = 43.344619750977, model = -770740285, heading = 160.00001525879, locked = true},
			["right"] = {x = 327.2121887207, y = -589.71508789063, z = 43.344619750977, model = -770740285, heading = 340.00003051758, locked = true},
		}, -- Inner Pillbox hospital doors
		[2] = {
			["left"] = {x = 249.54711914063, y = -1383.7418212891, z = 39.744342803955, model = 374758529, heading = 49.99995803833, locked = true},
			["right"] = {x = 247.88844299316, y = -1385.7186279297, z = 39.744342803955, model = 374758529, heading = 229.99996948242, locked = true},
		}, -- Computing room, 3rd floor, double doors
		[3] = {
			["left"] = {x = 239.21530151367, y = -1363.4578857422, z = 39.737594604492, model = 374758529, heading = 229.62672424316, locked = true},
			["right"] = {x = 240.8713684082, y = -1361.4842529297, z = 39.737594604492, model = 374758529, heading = 49.889072418213, locked = true},
		}, -- Documents room, 3rd floor
		[4] = {
			["left"] = {x = 250.10475158691, y = -1370.2286376953, z = 39.737594604492, model = 374758529, heading = 320.25872802734, locked = true},
			["right"] = {x = 248.12802124023, y = -1368.5699462891, z = 39.737594604492, model = 374758529, heading = 140.00001525879, locked = true},
		}, -- Forensics Lab, 3rd floor Middle doors
		[5] = {
			["left"] = {x = 245.19139099121, y = -1383.4554443359, z = 39.743377685547, model = 374758529, heading = 229.73471069336, locked = true},
			["right"] = {x = 246.85006713867, y = -1381.4786376953, z = 39.743377685547, model = 374758529, heading = 50.25090026855, locked = true},
		}, -- Forensics Lab, 3rd floor Left doors
		[6] = {
			["left"] = {x = 237.6615447998, y = -1373.7686767578, z = 39.744342803955, model = 374758529, heading = 50.000022888184, locked = true},
			["right"] = {x = 236.00286865234, y = -1375.7454833984, z = 39.744342803955, model = 374758529, heading = 230.00003051758, locked = true},
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

addRank("chief", "")
addRank("assistant chief", "")
addRank("captain", "")
addRank("lieutenant", "")
addRank("specialist", "")
addRank("paramedic", "")
addRank("probationary", "")

AddEventHandler("paramedic:initialise", function(source, identifier, character_id)
	TriggerClientEvent("paramedic:setranks", source, ranks)
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * from paramedic_models WHERE character_id=@character_id", {["@character_id"] = character_id}, function(result)
    	if result[1] == nil then
	        exports["GHMattiMySQL"]:QueryAsync("INSERT INTO paramedic_models (`character_id`,`model`,`new`,`clothing_drawables`,`clothing_textures`,`clothing_palette`,`props_drawables`,`props_textures`,`overlays_drawables`,`overlays_opacity`,`overlays_colours`) VALUES (@character_id,@model,@new,@clothing_drawables,@clothing_textures,@clothing_palette,@props_drawables,@props_textures,@overlays_drawables,@overlays_opacity,@overlays_colours)", {
	            ["@character_id"] = character_id,
	            ["@model"] = "s_m_m_paramedic_01",
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
	    	models.model = "s_m_m_paramedic_01"
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
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM paramedic WHERE character_id=@character_id", {["@character_id"] = character_id}, function(paramedic)
		if paramedic[1] == nil then
			TriggerClientEvent("paramedic:set", source, {}, false, true)
		else
			ems[source] = paramedic[1]
			if ems[source]["unit"] then
				ems[source]["unit_number"] = "M-"..ems[source]["unit"]
			end
			TriggerClientEvent("paramedic:set", source, ems[source], true, true)
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
end, {help = "Add a player to the LSFD", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Probationary | Paramedic | Specialist | Lieutenant | Captain | Assistant Chief | Chief"}}})

TriggerEvent("core:addGroupCommand", "emsrem", "command", function(source, args, rawCommand, data, power, group)
	local source = source
	if(not args[1]) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emsrem [ID]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil)then
			if ems[tonumber(args[1])] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					ems[tonumber(args[1])] = nil
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
end, {help = "Promote a paramedic", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Probationary | Paramedic | Specialist | Lieutenant | Captain | Assistant Chief | Chief"}}})

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
end, {help = "Demote an Officer", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Probationary | Paramedic | Specialist | Lieutenant | Captain | Assistant Chief | Chief"}}})

RegisterServerEvent("paramedic:doors_lock")
AddEventHandler("paramedic:doors_lock", function(doorid, type)
	local source = source
	if type == "single" then
		doors.single[doorid].locked = not doors.single[doorid].locked
		TriggerClientEvent("paramedic:doors_sync", -1, doors)
	elseif type == "double" then
		doors.double[doorid]["left"].locked = not doors.double[doorid]["left"].locked
		doors.double[doorid]["right"].locked = doors.double[doorid]["left"].locked
		TriggerClientEvent("paramedic:doors_sync", -1, doors)
	end
end)
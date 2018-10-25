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
		[17] = {x = 423.20999145508, y = -998.20001220703, z = 30.799999237061, model = -1635579193, heading = 179.98808288574, locked = true}, -- Mission Row Wall Door
		[18] = {x = -440.42999267578, y = 6006.08984375, z = -118.59999847412, model = -642608865, heading = 135.51921081543, locked = true}, -- Paleto Jail Cells 1
		[19] = {x = -436.8454284668, y = 6002.5263671875, z = -118.59999847412, model = -642608865, heading = 135.51921081543, locked = true}, -- Paleto Jail Cells 2
		[20] = {x = -433.29452514648, y = 5998.9741210938, z = -118.59999847412, model = -642608865, heading = 135.18885803223, locked = true}, -- -- Paleto Jail Cells 3
		[21] = {x = 1785.7900390625, y = 2479.2099609375, z = -122.55000305176, model = -642608865, heading = 178.45016479492, locked = true}, -- Jail Cell 1
		[22] = {x = 1788.9499511719, y = 2479.1799316406, z = -122.55000305176, model = -642608865, heading = 178.2713470459,  locked = true}, -- Jail Cell 2
		[23] = {x = 1792.1300048828, y = 2479.2099609375, z = -122.55000305176, model = -642608865, heading = 179.91905212402, locked = true}, -- Jail Cell 3
		[24] = {x = 1795.2900390625, y = 2479.1799316406, z = -122.55000305176, model = -642608865, heading = 180.31105041504, locked = true}, -- Jail Cell 4
		[25] = {x = 1798.4499511719, y = 2479.1499023438, z = -122.54000091553, model = -642608865, heading = 181.47987365723, locked = true}, -- Jail Cell 5
		[26] = {x = 1788.9599609375, y = 2487.1101074219, z = -122.55000305176, model = -642608865, heading = 180.24070739746, locked = true}, -- Jail Cell 6
		[27] = {x = 1792.1300048828, y = 2487.1000976563, z = -122.55000305176, model = -642608865, heading = 180.52368164063, locked = true}, -- Jail Cell 7
		[28] = {x = 1795.2900390625, y = 2487.1201171875, z = -122.55999755859, model = -642608865, heading = 179.66612243652, locked = true}, -- Jail Cell 8
		[29] = {x = 1798.4499511719, y = 2487.1398925781, z = -122.54000091553, model = -642608865, heading = 178.89085388184, locked = true}, -- Jail Cell 9
		[30] = {x = 1788.9599609375, y = 2487.1201171875, z = -118.93000030518, model = -642608865, heading = 180.18588256836, locked = true}, -- Jail Cell 10
		[31] = {x = 1792.1300048828, y = 2487.1201171875, z = -118.91000366211, model = -642608865, heading = 180.36251831055, locked = true}, -- Jail Cell 11
		[32] = {x = 1795.3000488281, y = 2487.1201171875, z = -118.93000030518, model = -642608865, heading = 180.23712158203, locked = true}, -- Jail Cell 12
		[33] = {x = 1798.4499511719, y = 2487.1201171875, z = -118.91999816895, model = -642608865, heading = 180.23712158203, locked = true}, -- Jail Cell 13
		[34] = {x = 1798.4399414063, y = 2479.2099609375, z = -118.91999816895, model = -642608865, heading = 181.01045227051, locked = true}, -- Jail Cell 14
		[35] = {x = 1795.2800292969, y = 2479.1999511719, z = -118.91999816895, model = -642608865, heading = 179.83967590332, locked = true}, -- Jail Cell 15
		[36] = {x = 1792.1300048828, y = 2479.2099609375, z = -118.93000030518, model = -642608865, heading = 180.14208984375, locked = true}, -- Jail Cell 16
		[37] = {x = 1788.9499511719, y = 2479.1799316406, z = -118.93000030518, model = -642608865, heading = 180.10104370117, locked = true}, -- Jail Cell 17
		[38] = {x = 1785.7900390625, y = 2479.2099609375, z = -118.91000366211, model = -642608865, heading = 179.72773742676, locked = true}, -- Jail Cell 18
		[39] = {x = 1693.1748046875, y = 2577.3432617188, z = -69.220001220703, model = -519068795, heading = 89.498985290527, locked = true}, -- Jail Visitation Door 1
		[40] = {x = 1692.4855957031, y = 2579.74609375, z = -69.290000915527, model = -642608865, heading = 359.79888916016, locked = true}, -- Jail Visitation Door 2
		[41] = {x = 1693.5672607422, y = 2581.3898925781, z = -69.23999786377, model = -519068795, heading = 89.498947143555, locked = true}, -- Jail Visitation Door 3
		[42] = {x = 1702.5899658203, y = 2577.3898925781, z = -69.290000915527, model = -519068795, heading = 359.49954223633, locked = true}, -- Jail Visitation Door 4
		[43] = {x = 1708.8831787109, y = 2570.6899414063, z = -69.300003051758, model = -519068795, heading = 89.498870849609, locked = true}, -- Jail Armoury Door 1
		[44] = {x = 2050.6770019531, y = 2963.6096191406, z = -67.152450561523, model = -147325430, heading = 54.57328414917, locked = true}, -- Interogation Room 1
		[45] = {x = 2050.6818847656, y = 2974.7854003906, z = -67.152450561523, model = -147325430,  heading = 54.99116897583, locked = true}, -- Interogation Room 2
		[46] = {x = 2054.6921386719, y = 2969.34375, z = -67.152450561523, model = -147325430, heading = 54.729328155518, locked = true}, -- Interogation Room 3
		[47] = {x = 2054.6967773438, y = 2980.51953125, z = -67.152450561523, model = -147325430, heading = 54.668598175049, locked = true}, -- Interogation Room 4
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
	
	chairs = {
		[1] = {x = 2062.16796875, y = 2968.5678710938, z = -68.302452087402, h = 240.00004577637, model = -109356459},
		[2] = {x = 2061.2041015625, y = 2967.1762695313, z = -68.302452087402, h = 235.00003051758, model = -109356459},
		[3] = {x = 2059.6010742188, y = 2969.2836914063, z = -68.221450805664, h = 55.000015258789, model = 1037469683},
		[4] = {x = 2050.7937011719, y = 2985.0041503906, z = -68.221450805664, h = 144.99996948242, model = 1037469683},
		[5] = {x = 2052.1916503906, y = 2986.9226074219, z = -68.221450805664, h = 340.00003051758, model = 1037469683},
		[6] = {x = 2046.7769775391, y = 2979.2724609375, z = -68.221450805664, h = 144.99996948242, model = 1037469683},
		[7] = {x = 2048.1748046875, y = 2981.1906738281, z = -68.221450805664, h = 340.00003051758, model = 1037469683},
		[8] = {x = 2055.5239257813, y = 2963.4650878906, z = -68.221450805664, h = 55.000015258789, model = 1037469683},
		[9] = {x = 2058.0908203125, y = 2962.7495117188, z = -68.302452087402, h = 240.00004577637, model = -109356459},
		[10] = {x = 2057.1271972656, y = 2961.3579101563, z = -68.302452087402, h = 235.00003051758, model = -109356459},
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
addRank("trooper sergeant", "")
addRank("sergeant", "")
addRank("trooper", "")
addRank("detective", "")
addRank("officer ii", "")
addRank("officer i", "")
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

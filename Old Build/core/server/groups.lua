--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
chat_help = {}
groups = {}

chat_help["info"] = {help = "Shows basic information", params = {}}
RegisterCommand("info", function(source, args, rawCommand)
	TriggerClientEvent("chatMessage", source, "→", {255, 0, 0}, "^2core framework")
	TriggerClientEvent("chatMessage", source, "→", {255, 0, 0}, "^3by frazzle")
	TriggerClientEvent("chatMessage", source, "→", {255, 0, 0}, "^5version 1.0")
	if Users[source] ~= nil then
		TriggerClientEvent("chatMessage", source, "→", {255, 0, 0}, "^6power: ^0"..Users[source].get("power"))
		TriggerClientEvent("chatMessage", source, "→", {255, 0, 0}, "^9group: ^0"..Users[source].get("group"))
	end
end, true)

AddEventHandler("core:addGroup", function(group, inherit)
	if groups[inherit] then
		local table = {}
		for k,v in pairs(groups[inherit]) do
			table[k] = {}
		end
		table[inherit] = {}
		for k,v in pairs(groups) do
			if v[inherit] then
				v[group] = {}
			end
		end
		groups[group] = table
		ExecuteCommand("add_ace group."..group.." command.info allow")
	else
		for k,v in pairs(groups) do
			v[group] = {}
		end
		groups[group] = {}	
		ExecuteCommand("add_ace group."..group.." command.info allow")
	end
end)

AddEventHandler("core:canTargetGroup", function(user, target, callback)
	if groups[user] then
		if groups[target] then
			if groups[user][target] then
				callback(true)
			else
				callback(false)
			end
		else
			print("Error -> core:canTargetGroup -> "..target.." group doesn't exist.")
			callback(false)
		end
	else
		print("Error -> core:canTargetGroup -> "..user.." group doesn't exist.")
		callback(false)
	end
end)

AddEventHandler("core:canSetGroup", function(user, target, callback)
	if groups[user] then
		if groups[target] then
			if groups[user][target] or user == target then
				callback(true)
			else
				callback(false)
			end
		else
			print("Error -> core:canSetGroup -> "..target.." group doesn't exist.")
			callback(false)
		end
	else
		print("Error -> core:canSetGroup -> "..user.." group doesn't exist.")
		callback(false)
	end
end)

AddEventHandler("core:addCommand", function(command, callback, suggestions)
	RegisterCommand(command, function(source, args, rawCommand)
		if source ~= 0 then
			callback(source, args, rawCommand, Characters[source], Users[source].get("power"), Users[source].get("group"))
		end
	end, false)

	if suggestions then	
		if not suggestions.params or not type(suggestions.params) == "table" then suggestions.params = {} end			
		if not suggestions.help or not type(suggestions.help) == "string" then suggestions.help = "" end			
		chat_help[command] = suggestions		
	end
end)

AddEventHandler("core:addGroupCommand", function(command, group, callback, suggestions)
	if groups[group] then
		RegisterCommand(command, function(source, args, rawCommand)
			if source ~= 0 then
				callback(source, args, rawCommand, Characters[source], Users[source].get("power"), Users[source].get("group"))
			end
		end, true)
		ExecuteCommand("add_ace group."..group.." command."..command.." allow")
		for k,v in pairs(groups) do
			if v[group] then
				ExecuteCommand("add_ace group."..k.." command."..command.." allow")
			end
		end
		
		if suggestions then	
			if not suggestions.params or not type(suggestions.params) == "table" then suggestions.params = {} end			
			if not suggestions.help or not type(suggestions.help) == "string" then suggestions.help = "" end			
			chat_help[command] = suggestions		
		end
	else
		print("Error -> core:addGroupCommand -> Group doesn't exist -> "..group)
	end
end)

--[[
Examples
TriggerEvent("core:addCommand", "command", function(source, args, rawCommand, data, power, group)
	-- do stuff
end)

TriggerEvent("core:addGroupCommand", "command", "group", function(source, args, rawCommand, data, power, group)
    -- do stuff
end)
]]--
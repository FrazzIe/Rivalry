--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]

TriggerEvent("core:addGroupCommand", "spawn", "staff", function(source, args, rawCommand, data, power, group)
	local source = source
	if not args[2] then
		TriggerClientEvent('chatMessage', source, "^0[^1SYSTEM^0]", {255, 0, 0}, "^3/spawn [model] [normal|upgrade]")
	else
		if args[2] ~= "upgrade" and args[2] ~= "normal" then
			TriggerClientEvent('chatMessage', source, "^0[^1SYSTEM^0]", {255, 0, 0}, "^3/spawn [model] [normal|upgrade]")
		else
			logCommand("spawn", {
				{
					name = GetPlayerName(source).." spawned a "..args[1], 
					value = "`"..getID("steam", source).."` -> `"..args[2].." "..args[1].."`"
				},
			})
			TriggerClientEvent("command:spawnvehicle", source, args[1],args[2])
		end
	end
end, {help = "Spawn a vehicle", params = {{name = "model", help = "The vehicle model (turismor)"},{name = "type", help = "normal or upgrade"}}})

TriggerEvent("core:addGroupCommand", "weapon", "staff", function(source, args, rawCommand, data, power, group)
	local source = source
	if not args[1] then
		TriggerClientEvent('chatMessage', source, "^0[^1SYSTEM^0]", {255, 0, 0}, "^3/weapon [model]")
	else
		TriggerClientEvent("command:spawnweapon", source, args[1])
	end
end, {help = "Spawn a weapon", params = {{name = "model", help = "The weapon model"}}})

TriggerEvent("core:addGroupCommand", "upgradep", "staff", function(source, args, rawCommand, data, power, group)
	local source = source
	TriggerClientEvent("command:upgradeperformance", source)
end, {help = "Upgrade car performance", params = {}})

TriggerEvent("core:addCommand", "fix", function(source, args, rawCommand, data, power, group)
	local source = source
	if power >= 3 then
		TriggerClientEvent("command:fix", source)
	else
		TriggerClientEvent('chatMessage', source, "", {0, 0, 0}, "You do not have access to this command")
	end
end, {help = "Fix a vehicle"})

TriggerEvent("core:addCommand", "dv", function(source, args, rawCommand, data, power, group)
	local source = source
	if power >= 3 then
		TriggerClientEvent("command:delete", source)
	else
		TriggerClientEvent('chatMessage', source, "", {0, 0, 0}, "You do not have access to this command")
	end
end, {help = "Delete a vehicle"})

TriggerEvent("core:addCommand", "clean", function(source, args, rawCommand, data, power, group)
	local source = source
	if power >= 3 then
		TriggerClientEvent("command:clean", source)
	else
		TriggerClientEvent('chatMessage', source, "", {0, 0, 0}, "You do not have access to this command")
	end
end, {help = "Clean a vehicle"})

TriggerEvent("core:addCommand", "livery", function(source, args, rawCommand, data, power, group)
	local source = source
	if power >= 3 then
		if tonumber(args[1]) ~= nil then
			TriggerClientEvent("command:livery", source, tonumber(args[1]))
		else
			TriggerClientEvent('chatMessage', source, "", {0, 0, 0}, "/livery [number]")
		end
	else
		TriggerClientEvent('chatMessage', source, "", {0, 0, 0}, "You do not have access to this command")
	end
end, {help = "Change livery of a vehicle", params = {{name = "number", help = "The vehicle livery"}}})

TriggerEvent("core:addGroupCommand", "revive", "admin", function(source, args, rawCommand, data, power, group)
	local source = source
	if not args[1] then
		TriggerClientEvent('chatMessage', source, "^0[^1SYSTEM^0]", {255, 0, 0}, "^3/revive [ID]")
	else
		if tonumber(args[1]) and GetPlayerName(tonumber(args[1])) then
			logCommand("revive", {
				{
					name = GetPlayerName(source).." revived "..GetPlayerName(tonumber(args[1])), 
					value = "`"..getID("steam", source).."` -> `"..getID("steam", tonumber(args[1])).."`",
				},
			})
			TriggerClientEvent("paramedic:heal", tonumber(args[1]))
		else
			TriggerClientEvent('chatMessage', source, "^0[^1SYSTEM^0]", {255, 0, 0}, "^3/revive [ID]")
		end
	end
end, {help = "Revive someone", params = {{name = "id", help = "Server id of the player"}}})

TriggerEvent("core:addGroupCommand", "spawnitem", "owner", function(source, args, rawCommand, data, power, group)
	if tonumber(args[1]) == nil then
		TriggerClientEvent('chatMessage', source, "^0[^1SYSTEM^0]", {255, 0, 0}, "^3/spawnitem [ID] (Amount)")
	else
		logCommand("spawnitem", {
			{
				name = GetPlayerName(source).." spawned item "..tostring(args[1]),
				value = "`"..getID("steam", source).."`",
			},
		})
		TriggerClientEvent("inventory:addQty", source, args[1], tonumber(args[2]) or 1)
	end
end, {help = "Spawn items", params = {{name = "id", help = "Item id"},{name = "amount", help = "Amount of the item"}}})

TriggerEvent("core:addGroupCommand", "goblin", "staff", function(source, args, rawCommand, data, power, group)
    local source = source
        TriggerClientEvent("command:goblin", source)
end, {help = "Become a Goblin. (FOR STANLEY)"})
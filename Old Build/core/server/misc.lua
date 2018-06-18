--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
local function logMessage(_target, _source, message)
	PerformHttpRequest(GetConvar("admin_panel_webhook", "https://discordapp.com/api/webhooks/393124622926741504/kjC2it8lmFuu2KjzJDPskTlRX3MSES64HSbs_ZEbKyf4Ujp0XZ0ggHi1jmP0-oyJ3GP5"), function(err, text, headers) end, 'POST', json.encode(
	{
		username = "Log Bot",
		embeds = {
			{
				title = "",
				description = "",
				fields = {
					{name = "Target name", value = _target.name},
					{name = "Target steam", value = _target.steam}, 
					{name = "What happened", value = message},
					{name = "Source name", value = _source.name},  
					{name = "Source steam", value = _source.steam}, 
				},
				color = "8190976",
			}
		},

		content = ""

	}), { ['Content-Type'] = 'application/json' })
end

function logError(message)
	PerformHttpRequest(GetConvar("https://discordapp.com/api/webhooks/393124622926741504/kjC2it8lmFuu2KjzJDPskTlRX3MSES64HSbs_ZEbKyf4Ujp0XZ0ggHi1jmP0-oyJ3GP5", "https://discordapp.com/api/webhooks/393124622926741504/kjC2it8lmFuu2KjzJDPskTlRX3MSES64HSbs_ZEbKyf4Ujp0XZ0ggHi1jmP0-oyJ3GP5"), function(err, text, headers) end, 'POST', json.encode(
	{
		username = "Log Bot",
		content = message

	}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("core:setData")
AddEventHandler("core:setData", function(data)
	local source = source
	if Characters[data.id] and Users[data.id] and Users[source] then
		if data.type == "money" then
			if Users[source].get("group") == "owner" or Users[source].get("group") == "staff" then
				if data.money_type == "Wallet" then
					logMessage({steam = Users[data.id].get("steam"), name = GetPlayerName(data.id)},{steam = Users[source].get("steam"), name = GetPlayerName(source)},"Wallet set to "..data.amount)
					Characters[data.id].wallet(data.amount)
				elseif data.money_type == "Dirty Money" then
					logMessage({steam = Users[data.id].get("steam"), name = GetPlayerName(data.id)},{steam = Users[source].get("steam"), name = GetPlayerName(source)},"Dirty money set to "..data.amount)
					Characters[data.id].dirty(data.amount)
				elseif data.money_type == "Bank" then
					logMessage({steam = Users[data.id].get("steam"), name = GetPlayerName(data.id)},{steam = Users[source].get("steam"), name = GetPlayerName(source)},"Bank set to "..data.amount)
					Characters[data.id].bank(data.amount)
				end
			else
				TriggerClientEvent('chatMessage', source, "^0[^3Panel^0]"..GetPlayerName(source), {255, 0, 0}, "^5Only staff and the founders can use this.")
			end
		elseif data.type == "power" then
			if tonumber(data.power) ~= nil and tonumber(data.power) >= 0 then
				if Users[source].get("power") > Users[data.id].get("power") then
					if tonumber(data.power) < Users[source].get("power") then
						logMessage({steam = Users[data.id].get("steam"), name = GetPlayerName(data.id)},{steam = Users[source].get("steam"), name = GetPlayerName(source)},"Power set to "..data.power)
						Users[data.id].set("power", tonumber(data.power))
						exports["GHMattiMySQL"]:QueryAsync("UPDATE users SET power_level=@power_level WHERE identifier=@identifier", {["@identifier"] = Users[data.id].get("steam"), ["@power_level"] = tonumber(data.power)})
						TriggerClientEvent("core:sync", -1, Characters, CharacterNames, Users, UPower, UGroup)
					else
						TriggerClientEvent('chatMessage', source, "^0[^3Panel^0]"..GetPlayerName(source), {255, 0, 0}, "^5You cannot set someones power higher than your own!")
					end
				else
					TriggerClientEvent('chatMessage', source, "^0[^3Panel^0]"..GetPlayerName(source), {255, 0, 0}, "^5You cannot target this user")
				end
			end
		elseif data.type == "group" then
			if groups[data.group] then
				TriggerEvent("core:canTargetGroup", Users[source].get("group"), Users[data.id].get("group"), function(canTarget)
					if canTarget then
						TriggerEvent("core:canSetGroup", Users[source].get("group"), data.group, function(canSet)
							if canSet then
								logMessage({steam = Users[data.id].get("steam"), name = GetPlayerName(data.id)},{steam = Users[source].get("steam"), name = GetPlayerName(source)},"Group set to "..data.group)
								ExecuteCommand("remove_principal identifier."..Users[data.id].get("steam").." group."..Users[data.id].get("group"))
								ExecuteCommand("add_principal identifier."..Users[data.id].get("steam").." group."..data.group)
								Users[data.id].set("group", data.group)
								exports["GHMattiMySQL"]:QueryAsync("UPDATE users SET `group`=@group WHERE identifier=@identifier", {["@identifier"] = Users[data.id].get("steam"), ["@group"] = tostring(data.group)})
								TriggerClientEvent("core:sync", -1, Characters, CharacterNames, Users, UPower, UGroup)
							else
								TriggerClientEvent('chatMessage', source, "^0[^3Panel^0]"..GetPlayerName(source), {255, 0, 0}, "^5Your group doesn't have the permission to set someones group to: "..data.group)
							end
						end)
					else
						TriggerClientEvent('chatMessage', source, "^0[^3Panel^0]"..GetPlayerName(source), {255, 0, 0}, "^5You cannot target this user")
					end
				end)
			end
		end
	end
end)

RegisterServerEvent("jail:update")
AddEventHandler("jail:update", function(time)
	local source = source
	if Characters[source] ~= nil then
		Characters[source].set("jail_time", time)
	end
end)

AddEventHandler('rconCommand', function(commandName, args)
	if commandName:lower() == "setpower" then
		if #args ~= 2 then
			RconPrint("setpower [id] [power]\n")
			CancelEvent()
		else
			if GetPlayerName(tonumber(args[1])) == nil then
				RconPrint("User not found\n")
				CancelEvent()
			else
				if tonumber(args[2]) == nil or tonumber(args[2]) < 0 then
					RconPrint("Power must be a positive number value\n")
					CancelEvent()
				else
					if not Users[tonumber(args[1])] then
						RconPrint("User hasn't loaded in yet!\n")
						CancelEvent()
					else
						RconPrint("Power set to "..args[2].."\n")
						Users[tonumber(args[1])].set("power", tonumber(args[2]))
						exports["GHMattiMySQL"]:QueryAsync("UPDATE users SET power_level=@power_level WHERE identifier=@identifier", {["@identifier"] = Users[tonumber(args[1])].get("steam"), ["@power_level"] = tonumber(args[2])})
						TriggerClientEvent("core:sync", -1, Characters, CharacterNames, Users, UPower, UGroup)
						CancelEvent()
					end
				end
			end
		end    
	elseif commandName:lower() == "setgroup" then
		if #args ~= 2 then
			RconPrint("setgroup [id] [group]\n")
			CancelEvent()
		else
			if GetPlayerName(tonumber(args[1])) == nil then
				RconPrint("User not found\n")
				CancelEvent()
			else
				if not groups[args[2]] then
					RconPrint("Group does not exist\n")
					CancelEvent()
				else
					if not Users[tonumber(args[1])] then
						RconPrint("User hasn't loaded in yet!\n")
						CancelEvent()
					else
						RconPrint("Group set to "..args[2].."\n")
						ExecuteCommand("remove_principal identifier."..Users[tonumber(args[1])].get("steam").." group."..Users[tonumber(args[1])].get("group"))
						ExecuteCommand("add_principal identifier."..Users[tonumber(args[1])].get("steam").." group."..tostring(args[2]))
						Users[tonumber(args[1])].set("group", tostring(args[2]))
						exports["GHMattiMySQL"]:QueryAsync("UPDATE users SET `group`=@group WHERE identifier=@identifier", {["@identifier"] = Users[tonumber(args[1])].get("steam"), ["@group"] = tostring(args[2])})
						TriggerClientEvent("core:sync", -1, Characters, CharacterNames, Users, UPower, UGroup)
						CancelEvent()
					end
				end
			end
		end
	elseif commandName:lower() == "setmoney" then
		if #args ~= 3 then
			RconPrint("setmoney [id] [wallet|dirty|bank] [amount]\n")
			CancelEvent()
		else
			if GetPlayerName(tonumber(args[1])) == nil then
				RconPrint("User not found\n")
				CancelEvent()
			else
				if args[2] ~= "wallet" and args[2] ~= "dirty" and args[2] ~= "bank" then
					RconPrint("Invalid money type entered\n")
					CancelEvent()
				else
					if tonumber(args[3]) == nil or tonumber(args[3]) < 0 then
						RconPrint("Amount must be a positive number value\n")
						CancelEvent()
					else
						if Characters[tonumber(args[1])] then
							if args[2] == "wallet" then
								Characters[tonumber(args[1])].wallet(tonumber(args[3]))
								RconPrint("Wallet set to "..args[3].."\n")
								CancelEvent()
							elseif args[2] == "dirty" then
								Characters[tonumber(args[1])].dirty(tonumber(args[3]))
								RconPrint("Dirty set to "..args[3].."\n")
								CancelEvent()
							elseif args[2] == "bank" then
								Characters[tonumber(args[1])].bank(tonumber(args[3]))
								RconPrint("Bank set to "..args[3].."\n")
								CancelEvent()
							end
						else
							RconPrint("The user currently isn't playing and might be on the character selection screen\n")
							CancelEvent()
						end
					end
				end
			end            
		end
	elseif commandName:lower() == "ban" then
		if #args < 5 then
			RconPrint("ban [id] [time] [s|m|h] [permanent (true|false)] [reason]\n")
			CancelEvent()
		else
			if GetPlayerName(tonumber(args[1])) == nil then
				RconPrint("User not found\n")
				CancelEvent()
			else
				if tonumber(args[2]) == nil or tonumber(args[2]) < 0 then
					RconPrint("The time must be a positive number\n")
					CancelEvent()
				else
					if args[3] ~= "s" and args[3] ~= "m" and args[3] ~= "h" then
						RconPrint("Invalid type for time entered\n")
						CancelEvent()
					else
						if args[3] ~= "s" then
							args[2] = args[2]..args[3]
						end
						if args[4] ~= "true" and args[4] ~= "false" then
							RconPrint("Invalid type for permanent entered\n")
							CancelEvent()                            
						else
							if tostring(args[5]) == nil or tostring(args[5]) == "" then
								RconPrint("Something went wrong with the reason\n")
								CancelEvent()
							else
								TriggerEvent("core:ban", tonumber(args[1]), args[2], table.concat(args, " ", 5), tostring(args[4]), "Console")
								CancelEvent()
							end
						end
					end
				end
			end
		end
	elseif commandName:lower() == "kick" then
		if #args < 2 then
			RconPrint("kick [id] [reason]\n")
			CancelEvent()
		else
			if GetPlayerName(tonumber(args[1])) == nil then
				RconPrint("User not found\n")
				CancelEvent()
			else
				if tostring(args[2]) == nil or tostring(args[2]) == "" then
					RconPrint("kick [id] [reason]\n")
					CancelEvent()
				else
					TriggerEvent("core:kick", tonumber(args[1]), table.concat(args, " ", 2), "Console")
					CancelEvent()
				end
			end
		end
	elseif commandName:lower() == "kickall" then
		if #args < 1 then
			RconPrint("kickall [reason]\n")
			CancelEvent()
		else
			if tostring(args[1]) == nil or tostring(args[1]) == "" then
				RconPrint("kickall [reason]\n")
				CancelEvent()
			else
				TriggerClientEvent("core:kickall", -1, table.concat(args, " ", 1))
				CancelEvent()
			end
		end
	elseif commandName:lower() == "whitelist" then
		if #args < 2 then
			RconPrint("whitelist [add/remove] [steam:hex]\n")
			CancelEvent()
		else
			if tostring(args[1]) ~= "add" and tostring(args[1]) ~= "remove" then
				RconPrint("whitelist [add/remove] [steam:hex]\n")
				CancelEvent()
			else
				if tostring(args[2]) == nil or string.sub(args[2], 1, 5) ~= "steam" then
					RconPrint("whitelist [add/remove] [steam:hex]\n")
					CancelEvent()
				else
					if args[1] == "add" then
						CancelEvent()
						exports["GHMattiMySQL"]:Query("INSERT INTO whitelist (`identifier`) VALUES (@identifier)", {["@identifier"] = args[2]})
						RconPrint("[CORE]"..args[2].." has been added to the whitelist!\n")
					else
						CancelEvent()
						exports["GHMattiMySQL"]:Query("DELETE FROM whitelist WHERE identifier=@identifier", {["@identifier"] = args[2]})
						RconPrint("[CORE]"..args[2].." has been removed from the whitelist!\n")
					end
				end
			end
		end
	end
end)

RegisterServerEvent("core:bug")
AddEventHandler("core:bug", function(_message)
	logError(_message)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		TriggerClientEvent("core:synctime", -1, os.time())
	end
end)
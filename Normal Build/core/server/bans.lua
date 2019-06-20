--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
local function ordinal_numbers(n)
	local ordinal, digit = {"st", "nd", "rd"}, string.sub(n, -1)
	if tonumber(digit) > 0 and tonumber(digit) <= 3 and string.sub(n,-2) ~= 11 and string.sub(n,-2) ~= 12 and string.sub(n,-2) ~= 13 then
		return n .. ordinal[tonumber(digit)]
	else
		return n .. "th"
	end
end

function banMessage(name, steam, license, duration, reason, banner)
	PerformHttpRequest(GetConvar("ban_webhook", "https://discordapp.com/api/webhooks/393124622926741504/kjC2it8lmFuu2KjzJDPskTlRX3MSES64HSbs_ZEbKyf4Ujp0XZ0ggHi1jmP0-oyJ3GP5"), function(err, text, headers) end, 'POST', json.encode(
	{
		username = "Ban Bot",
		embeds = {
			{
				title = "",
				description = "",
				fields = {
					{name = "Display name", value = name}, 
					{name = "Steam", value = steam}, 
					{name = "License", value = license},
					{name = "Duration", value = duration},  
					{name = "Reason", value = reason}, 
					{name = "Banned by", value = banner},
				},
				color = "16597762",
			}
		},

		content = ""

	}), { ['Content-Type'] = 'application/json' })
end

local function kickMessage(name, steam, license, reason, kicker)
	PerformHttpRequest(GetConvar("kick_webhook", "https://discordapp.com/api/webhooks/393124622926741504/kjC2it8lmFuu2KjzJDPskTlRX3MSES64HSbs_ZEbKyf4Ujp0XZ0ggHi1jmP0-oyJ3GP5"), function(err, text, headers) end, 'POST', json.encode(
	{
		username = "Kick Bot",
		embeds = {
			{
				title = "",
				description = "",
				fields = {
					{name = "Display name", value = name}, 
					{name = "Steam", value = steam}, 
					{name = "License", value = license}, 
					{name = "Reason", value = reason}, 
					{name = "Kicked by", value = kicker},
				},
				color = "16597762",
			}
		},

		content = ""

	}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("core:ban")
AddEventHandler("core:ban", function(target, time, reason, isPerm, banner)
	local source = source
	local steam = getID("steam", source) or "Console"
	local license = getID("license", source) or "Console"
	local name = GetPlayerName(source) or banner
	if source == target and banner ~= nil then name = banner end
	if isPerm == nil then 
		isPerm = false 
	elseif isPerm == "false" then
		isPerm = false
	elseif isPerm == "true" then
		isPerm = true
	end

	local bantime = "Default"
	local duration = tostring(time)
	if string.find(duration, "m") then
		duration = string.gsub(duration, "m", "")
		bantime = duration .. " minute(s)"
		duration = os.time() + (tonumber(duration) * 60)
	elseif string.find(duration, "h") then
		duration = string.gsub(duration, "h", "")
		bantime = duration .. " hour(s)"
		duration = os.time() + (tonumber(duration) * 60 * 60)
	else
		bantime = duration .. " second(s)"
		duration = os.time() + tonumber(duration)
	end

	local anticheat = false

	if source ~= nil then
		if UGroup[source] then
			local group = UGroup[source]
			if group ~= "admin" and group ~= "staff" and group ~= "owner" then
				anticheat = true
			end
		end
	end

	if not anticheat then
		if GetPlayerName(tonumber(target)) == nil then
			local target_key, target_info = nil, nil
			for k,v in pairs(disconnectedPlayers) do
				if v ~= nil then
					if v.id == target then
						target_key = k
						target_info = v
					end
				end
			end
			if target_info == nil then
				if source ~= nil then
					TriggerClientEvent("pNotify:SendNotification", source, {text = "The player you tried to ban is offline and we could not find the target in our list of disconnected players", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
				else
					RconPrint("The player you tried to ban is offline and we could not find the target in our list of disconnected players")
				end
				--The player you tried to ban is offline and we could not find the target in our list of disconnected players
			else
				table.remove(disconnectedPlayers, target_key)
				exports["GHMattiMySQL"]:QueryAsync("INSERT INTO bans (`identifier`,`license`,`timestamp`,`expire`,`reason`,`name`,`banner`,`permanent`) VALUES (@identifier, @license, @timestamp, @expire, @reason, @name, @banner, @permanent)", {
					["@identifier"] = target_info.steam,
					["@license"] = target_info.license,
					["@timestamp"] = os.time(),
					["@expire"] = duration,
					["@reason"] = reason,
					["@name"] = target_info.name,
					["@banner"] = name,
					["@permanent"] = tostring(isPerm),
				})
				if not isPerm then
					banMessage(target_info.name, target_info.steam, target_info.license, bantime, reason, name)
				else
					banMessage(target_info.name, target_info.steam, target_info.license, "Permanent", reason, name)
				end
			end
		else
			local target_steam = getID("steam", target)
			local target_license = getID("license", target)
			local target_name = GetPlayerName(target)
			exports["GHMattiMySQL"]:QueryAsync("INSERT INTO bans (`identifier`,`license`,`timestamp`,`expire`,`reason`,`name`,`banner`,`permanent`) VALUES (@identifier, @license, @timestamp, @expire, @reason, @name, @banner, @permanent)", {
				["@identifier"] = target_steam,
				["@license"] = target_license,
				["@timestamp"] = os.time(),
				["@expire"] = duration,
				["@reason"] = reason,
				["@name"] = target_name,
				["@banner"] = name,
				["@permanent"] = tostring(isPerm),
			})
			if not isPerm then
				DropPlayer(target, target_name.." you have been banned! It will expire on "..os.date("%A the "..ordinal_numbers(os.date("%d", duration)).." of %B at %I:%M%p", duration)..". Ban reason: "..reason.." - rivalryrp.com")
				banMessage(target_name, target_steam, target_license, bantime, reason, name)
			else
				DropPlayer(target, target_name.." you have been permanently banned! Ban reason: "..reason.." - rivalryrp.com")
				banMessage(target_name, target_steam, target_license, "Permanent", reason, name)
			end
		end
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)

RegisterServerEvent("core:kick")
AddEventHandler("core:kick", function(target, reason, kicker)
	local source = source
	local name = GetPlayerName(source) or kicker
	if source == target and kicker ~= nil then name = kicker end

	local anticheat = false

	if source ~= nil then
		if UGroup[source] then
			local group = UGroup[source]
			if group ~= "admin" and group ~= "staff" and group ~= "owner" then
				anticheat = true
				return
			end
		end
	end

	if not anticheat then
		if GetPlayerName(tonumber(target)) == nil then
			if source ~= nil then
				TriggerClientEvent("pNotify:SendNotification", source, {text = "The player you tried to kick has already left the server", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
			else
				RconPrint("The player you tried to kick has already left the server")
			end
			--The player you tried to kick has already left the server
		else
			local target_steam = getID("steam", target)
			local target_license = getID("license", target)
			local target_name = GetPlayerName(target)
			DropPlayer(target, name.." kicked you from the server, Reason: "..reason.." - rivalryrp.com")
			kickMessage(target_name, target_steam, target_license, reason, name)
		end
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)

RegisterServerEvent("core:kickall")
AddEventHandler("core:kickall", function(reason)
	local source = source
	DropPlayer(source, reason)
end)

AddEventHandler("core:anticheat-ban", function(target, reason)
	local reason = reason or "Script Tampering"
	local duration = os.time()
	local name = "Anticheat"
	local isPerm = true

	if GetPlayerName(tonumber(target)) == nil then
		local target_key, target_info = nil, nil
		for k,v in pairs(disconnectedPlayers) do
			if v ~= nil then
				if v.id == target then
					target_key = k
					target_info = v
				end
			end
		end
		if target_info ~= nil then
			table.remove(disconnectedPlayers, target_key)

			exports["GHMattiMySQL"]:QueryAsync("INSERT INTO bans (`identifier`,`license`,`timestamp`,`expire`,`reason`,`name`,`banner`,`permanent`) VALUES (@identifier, @license, @timestamp, @expire, @reason, @name, @banner, @permanent)", {
				["@identifier"] = target_info.steam,
				["@license"] = target_info.license,
				["@timestamp"] = os.time(),
				["@expire"] = duration,
				["@reason"] = reason,
				["@name"] = target_info.name,
				["@banner"] = name,
				["@permanent"] = tostring(isPerm),
			})
			if not isPerm then
				banMessage(target_info.name, target_info.steam, target_info.license, bantime, reason, name)
			else
				banMessage(target_info.name, target_info.steam, target_info.license, "Permanent", reason, name)
			end
		end
	else
		local target_steam = getID("steam", target)
		local target_license = getID("license", target)
		local target_name = GetPlayerName(target)
		exports["GHMattiMySQL"]:QueryAsync("INSERT INTO bans (`identifier`,`license`,`timestamp`,`expire`,`reason`,`name`,`banner`,`permanent`) VALUES (@identifier, @license, @timestamp, @expire, @reason, @name, @banner, @permanent)", {
			["@identifier"] = target_steam,
			["@license"] = target_license,
			["@timestamp"] = os.time(),
			["@expire"] = duration,
			["@reason"] = reason,
			["@name"] = target_name,
			["@banner"] = name,
			["@permanent"] = tostring(isPerm),
		})
		if not isPerm then
			DropPlayer(target, target_name.." you have been banned! It will expire on "..os.date("%A the "..ordinal_numbers(os.date("%d", duration)).." of %B at %I:%M%p", duration)..". Ban reason: "..reason.." - rivalryrp.com")
			banMessage(target_name, target_steam, target_license, bantime, reason, name)
		else
			DropPlayer(target, target_name.." you have been permanently banned! Ban reason: "..reason.." - rivalryrp.com")
			banMessage(target_name, target_steam, target_license, "Permanent", reason, name)
		end
	end
end)
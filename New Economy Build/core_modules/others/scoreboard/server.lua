--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local function getSteamAccount(hexId, callback)
    local apiKey = GetConvar("steam_api_key","766D5415D35F70B5C2424992A89BB8DA")
    
    if not hexId then callback(nil) return end
    local comId = tonumber(string.sub(hexId, 7), 16)
    if not comId then callback(nil) return end

    local url = string.format("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=%s&steamids=%s", apiKey, comId)

    PerformHttpRequest(url, function(err, response, headers)
        if err ~= 200 then callback(nil) print("HTTP ERROR: "..err) return end

        local data = json.decode(response)
        local date = data.response.players[1].timecreated
        if not date then callback(nil) return end
        callback(data)
    end, "GET", "")
end

RegisterServerEvent("scoreboard:report")
AddEventHandler("scoreboard:report", function(report, ids)
	local source = source
	local steam = getID("steam", source)
	local license = getID("license", source)
	local ip = getID("ip", source)
	getSteamAccount(ids.steam, function(cb_a)
		if cb_a ~= nil then
			getSteamAccount(steam, function(cb_b)
				if cb_b ~= nil then
					PerformHttpRequest(GetConvar("report_webhook", "https://discordapp.com/api/webhooks/393124622926741504/kjC2it8lmFuu2KjzJDPskTlRX3MSES64HSbs_ZEbKyf4Ujp0XZ0ggHi1jmP0-oyJ3GP5"), function(err, text, headers) end, 'POST', json.encode(
					{
						username = "Report bot",
					    embeds = {
						    {
						    	title = GetPlayerName(source).." reported "..ids.name,
						    	description = report,
						    	fields = {
						    		{name = "Targets steam", value = cb_a.response.players[1].profileurl},
						    		{name = "Targets license", value = ids.license},
						    		{name = "Targets ip", value = ids.ip},
						    		{name = "Sources steam", value = cb_b.response.players[1].profileurl},
						    		{name = "Sources license", value = license},
						    		{name = "Sources ip", value = ip},
						    	},
						    	color = "39423",
						    }
						},

					    content = ""

					}), { ['Content-Type'] = 'application/json' })
				else
					PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(
					{
						username = "Report bot",
					    embeds = {
						    {
						    	title = GetPlayerName(source).." reported "..ids.name,
						    	description = report,
						    	fields = {
						    		{name = "Targets steam", value = cb_a.response.players[1].profileurl},
						    		{name = "Targets license", value = ids.license},
						    		{name = "Targets ip", value = ids.ip},
						    		{name = "Sources steam", value = steam},
						    		{name = "Sources license", value = license},
						    		{name = "Sources ip", value = ip},
						    	},
						    	color = "39423",
						    }
						},

					    content = ""

					}), { ['Content-Type'] = 'application/json' })
				end
			end)
		else
			getSteamAccount(steam, function(cb_b)
				if cb_b ~= nil then
					PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(
					{
						username = "Report bot",
					    embeds = {
						    {
						    	title = GetPlayerName(source).." reported "..ids.name,
						    	description = report,
						    	fields = {
						    		{name = "Targets steam", value = ids.steam},
						    		{name = "Targets license", value = ids.license},
						    		{name = "Targets ip", value = ids.ip},
						    		{name = "Sources steam", value = cb_b.response.players[1].profileurl},
						    		{name = "Sources license", value = license},
						    		{name = "Sources ip", value = ip},
						    	},
						    	color = "39423",
						    }
						},

					    content = ""

					}), { ['Content-Type'] = 'application/json' })
				else
					PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(
					{
						username = "Report bot",
					    embeds = {
						    {
						    	title = GetPlayerName(source).." reported "..ids.name,
						    	description = report,
						    	fields = {
						    		{name = "Targets steam", value = ids.steam},
						    		{name = "Targets license", value = ids.license},
						    		{name = "Targets ip", value = ids.ip},
						    		{name = "Sources steam", value = steam},
						    		{name = "Sources license", value = license},
						    		{name = "Sources ip", value = ip},
						    	},
						    	color = "39423",
						    }
						},

					    content = ""

					}), { ['Content-Type'] = 'application/json' })					
				end
			end)			
		end
	end)
end)
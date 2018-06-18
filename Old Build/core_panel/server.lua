--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--[[ Create server groups ]]--
TriggerEvent("core:addGroup", "owner", "")
TriggerEvent("core:addGroup", "staff", "")
TriggerEvent("core:addGroup", "admin", "")
TriggerEvent("core:addGroup", "mod", "")
TriggerEvent("core:addGroup", "command", "")
TriggerEvent("core:addGroup", "emergency", "")
TriggerEvent("core:addGroup", "user", "")

Users = {}
local function logMessage(_target, _source, message)
    PerformHttpRequest(GetConvar("admin_panel_actions_webhook", "https://discordapp.com/api/webhooks/393124622926741504/kjC2it8lmFuu2KjzJDPskTlRX3MSES64HSbs_ZEbKyf4Ujp0XZ0ggHi1jmP0-oyJ3GP5"), function(err, text, headers) end, 'POST', json.encode(
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

local function getID(type, _source)
    for k,v in ipairs(GetPlayerIdentifiers(_source)) do
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

RegisterServerEvent("core:quickoption")
AddEventHandler("core:quickoption", function(data)
	local source = source
	if GetPlayerName(tonumber(data.id)) ~= nil then
        if Users[source] then
    		if data.type == "crash" and Users[source].get("group") == "owner" then
    			TriggerClientEvent("core:quickoption_"..data.type, data.id, source)
    		elseif data.type ~= "crash" then
                if data.type == "goto" then
                    TriggerClientEvent("core:quickoption_"..data.type, source, data.id)
                else
                    TriggerClientEvent("core:quickoption_"..data.type, data.id, source)
                end
    		else
    			TriggerClientEvent('chatMessage', source, "^0[^3Panel^0]"..GetPlayerName(source), {255, 0, 0}, "^5You group cannot crash a user")
    		end
        end
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = "The player you tried to target has left the server", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
	end
end)

RegisterServerEvent("core:quickoption_callback")
AddEventHandler("core:quickoption_callback", function(_source, _message)
	local source = source
	logMessage({steam = getID("steam", source), name = GetPlayerName(source)},{steam = getID("steam", _source), name = GetPlayerName(_source)}, _message)
	TriggerClientEvent('chatMessage', _source, "^0[^3"..source.."^0]"..GetPlayerName(source), {255, 0, 0}, "^5".._message)
end)

AddEventHandler("core:sync", function(_Characters, _ChracterNames, _Users)
    Users = _Users
end)
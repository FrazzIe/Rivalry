--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
local speedhack = {}
local violations = {}
local max_violations = 3

local function warningMessage(message)
	local fields = {}
	for k,v in pairs(message) do
		table.insert(fields, {name = v.name, value = v.value})
	end

	PerformHttpRequest(GetConvar("warning_webhook", "https://discordapp.com/api/webhooks/393124622926741504/kjC2it8lmFuu2KjzJDPskTlRX3MSES64HSbs_ZEbKyf4Ujp0XZ0ggHi1jmP0-oyJ3GP5"), function(err, text, headers) end, 'POST', json.encode(
	{
		username = "Ban Bot",
		embeds = {
			{
				title = "",
				description = "",
				fields = fields,
				color = "16597762",
			}
		},

		content = ""

	}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("anticheat:speedcheck")
AddEventHandler("anticheat:speedcheck", function()
	if speedhack[source] then
		if (os.time() - speedhack[source]) < 15 then
			TriggerEvent("core:kick", source, "Speedhacking", "Anticheat")
		else
			speedhack[source] = os.time()
		end
	else
		speedhack[source] = os.time()
	end
end)

AddEventHandler('playerDropped', function()
	if speedhack[source] then
		speedhack[source] = nil
	end
end)

RegisterServerEvent("anticheat:flag")
AddEventHandler("anticheat:flag", function(type, data)
	local source = source
	local message = {}
	local reason = ""
	if violations[source] then
		violations[source] = violations[source] + 1
	else
		violations[source] = 1
	end
	if type == "health" then
		if data.invincible then
			message = {
				{name = "Violaters name, ", value = GetPlayerName(source)},
				{name = "Violaters steam, ", value = getID("steam", source)},
				{name = "Type of violation", value = "Health (Invincible)"},
				{name = "What happened", value = "The player regenerated "..data.health.new-data.health.old.."hp to reach "..data.health.new.."hp!"},
				{name = "Violation", value = violations[source].."/"..max_violations}
			}
			reason = "Health (Invincible), You regenerated "..data.health.new-data.health.old.."hp to reach "..data.health.new.."hp in 50ms!"
		else
			message = {
				{name = "Violaters name, ", value = GetPlayerName(source)},
				{name = "Violaters steam, ", value = getID("steam", source)},
				{name = "Type of violation", value = "Health (Forced)"},
				{name = "What happened", value = "The player regenerated "..data.health.new-data.health.old.."hp to reach "..data.health.new.."hp!"},
				{name = "Violation", value = violations[source].."/"..max_violations}
			}
			reason = "Health (Forced), You regenerated "..data.health.new-data.health.old.."hp to reach "..data.health.new.."hp in 50ms!"
		end
	elseif type == "noclip" then
		message = {
			{name = "Violaters name, ", value = GetPlayerName(source)},
			{name = "Violaters steam, ", value = getID("steam", source)},
			{name = "Type of violation", value = "Possible noclip"},
			{name = "What happened", value = "Caught with "..data.distance.." units between last checked location"},
			{name = "Violation", value = violations[source].."/"..max_violations}
		}
		reason = "Possible noclip!, Caught with "..data.distance.." units between last checked location"
	end

	warningMessage(message)
	if violations[source] >= 3 then
		TriggerEvent("core:ban", source, 1, reason, true, "Anticheat")
	end
end)
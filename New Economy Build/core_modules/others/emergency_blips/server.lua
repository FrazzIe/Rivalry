--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local emergency_blips = {}

RegisterServerEvent("blips:set")
AddEventHandler("blips:set", function(source, inService, colour)
	local source = source
	if inService then
		emergency_blips[source] = colour
	else
		emergency_blips[source] = "rip"
	end
	for k,v in pairs(emergency_blips) do
		TriggerClientEvent("blips:set", k, emergency_blips)
	end
end)
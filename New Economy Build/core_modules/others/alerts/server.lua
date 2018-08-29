--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
RegisterServerEvent("alerts:weapon")
AddEventHandler("alerts:weapon", function()
	TriggerClientEvent("alerts:weapon", -1, source)
end)
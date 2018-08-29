--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local blips_client = {}
local blips_server = {}

RegisterNetEvent("blips:set")
AddEventHandler("blips:set", function(_blips)
	blips_server = _blips
	if exports.policejob:getIsInService() or exports.emsjob:getIsInService() then
		for _, _blip in pairs(blips_client) do
			RemoveBlip(_blip)
		end

		blips_client = {}

		for k,v in pairs(blips_server) do
			if v ~= "rip" then
				if NetworkIsPlayerActive(GetPlayerFromServerId(k)) and GetPlayerFromServerId(k) ~= PlayerId() then
					local playerId = GetPlayerFromServerId(k)
					local blip = GetBlipFromEntity(GetPlayerPed(playerId))
					if not DoesBlipExist(blip) then
						blip = AddBlipForEntity(GetPlayerPed(playerId))
						SetBlipSprite(blip, 1)
						SetBlipColour(blip, tonumber(v))
						SetBlipScale(blip, 0.85)
						SetBlipAlpha(blip, 255)
						ShowHeadingIndicatorOnBlip(blip, true)
						HideNumberOnBlip(blip)
						SetBlipNameToPlayerName(blip, playerId)
						table.insert(blips_client, blip)
					else
						SetBlipSprite(blip, 1)
						SetBlipColour(blip, tonumber(v))
						SetBlipScale(blip, 0.85)
						SetBlipAlpha(blip, 255)
						ShowHeadingIndicatorOnBlip(blip, true)
						HideNumberOnBlip(blip)
						SetBlipNameToPlayerName(blip, playerId)
						table.insert(blips_client, blip)		
					end
				end
			end
		end
	else
		for _, _blip in pairs(blips_client) do
			RemoveBlip(_blip)
		end

		blips_client = {}
	end
end)
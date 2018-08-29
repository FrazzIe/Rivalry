--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local Armed = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedArmed(PlayerPedId(), 7) and not Armed then
			Armed = true
			--TriggerServerEvent("alerts:weapon")
		elseif not IsPedArmed(PlayerPedId(), 7) and Armed then
			Armed = false
		end
	end
end)

RegisterNetEvent("alerts:weapon")
AddEventHandler("alerts:weapon", function(sender)
	if GetPlayerFromServerId(sender) == PlayerId() then
	elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(),0), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(sender)),0), true) < 50 and GetPlayerFromServerId(sender) ~= PlayerId() then
		TriggerEvent('chatMessage', "^0-", {30, 144, 255}, "^5Someone just manipulated a weapon")
	end
end)
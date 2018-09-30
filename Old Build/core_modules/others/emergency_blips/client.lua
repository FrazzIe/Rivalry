--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]

local EmergencyPlayers = {}
local EmergencyBlips = {}

function GetEmergencyBlipColour(Type, Panic)
	if Panic then
		return 1
	else
		if Type == 1 then
			return 2
		elseif Type == 2 then
			return 3
		else
			return 0
		end
	end
end

function SetEmergencyBlipProperties(Blip, Colour, Name)
	SetBlipSprite(Blip, 1)
	SetBlipColour(Blip, Colour)
	SetBlipAsShortRange(Blip, false)
	SetBlipScale(Blip, 0.85)
	ShowHeadingIndicatorOnBlip(Blip, true)
	HideNumberOnBlip(Blip)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Name)
	EndTextCommandSetBlipName(Blip)
end

RegisterNetEvent("core:ready")
AddEventHandler("core:ready", function()
	Chat.Command("panic", function(source, args, rawCommand)
		if exports.policejob:getIsInService() or exports.emsjob:getIsInService() then
			if exports["phone"]:PlayerHasPhone() then
				if not exports.policejob:getIsCuffed() then
					local Position = GetEntityCoords(PlayerPedId(), false)
					local Street, Crossing = GetStreetNameAtCoord(Position.x, Position.y, Position.z)

					TriggerServerEvent("EmergencyBlips.Panic", (exports.policejob:getIsInService() and "^7Officer" or "^7Medic"), GetStreetNameFromHashKey(Street))
				else
					Chat.Message("INFO", "You are handcuffed, you cannot reach the button!", 255, 0, 0, true)
				end
			else
				Chat.Message("INFO", "You must have a phone!", 255, 0, 0, true)
			end
		else
			Chat.Message("INFO", "You must be on duty use this command!", 255, 0, 0, true)
		end
	end, false, {Help = "Toggle Panic Button",  Params = {}})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		if exports.policejob and exports.emsjob then
			if exports.policejob:getIsInService() or exports.emsjob:getIsInService() then
				for Player, Data in pairs(EmergencyPlayers) do
					local PlayerId = GetPlayerFromServerId(Player)
					if NetworkIsPlayerActive(PlayerId) then
						local PedId = GetPlayerPed(PlayerId)
						if DoesEntityExist(PedId) then
							local PlayerBlip = GetBlipFromEntity(PedId)
							local BlipColour = GetEmergencyBlipColour(Data[1], Data[2])

							if DoesBlipExist(PlayerBlip) then
								if not EmergencyBlips[Player] then
									EmergencyBlips[Player] = PlayerBlip
									SetEmergencyBlipProperties(EmergencyBlips[Player], BlipColour, Data[3])
								elseif EmergencyBlips[Player] and EmergencyBlips[Player] ~= PlayerBlip then
									RemoveBlip(EmergencyBlips[Player])
									EmergencyBlips[Player] = PlayerBlip
									SetEmergencyBlipProperties(EmergencyBlips[Player], BlipColour, Data[3])
								else
									if GetBlipColour(EmergencyBlips[Player]) ~= BlipColour then
										SetBlipColour(EmergencyBlips[Player], BlipColour)
									end
								end
							else
								if not EmergencyBlips[Player] then
									EmergencyBlips[Player] = AddBlipForEntity(PedId)
									SetEmergencyBlipProperties(EmergencyBlips[Player], BlipColour, Data[3])
								else
									if GetBlipColour(EmergencyBlips[Player]) ~= BlipColour then
										SetBlipColour(EmergencyBlips[Player], BlipColour)
									end
								end							
							end
						end
					end
				end
			else
				if table.length(EmergencyBlips) > 0 then
					for Player, Blip in pairs(EmergencyBlips) do
						RemoveBlip(Blip)
					end

					EmergencyBlips = {}
				end
			end
		end
	end
end)

RegisterNetEvent("EmergencyBlips.Sync")
AddEventHandler("EmergencyBlips.Sync", function(Data)
	EmergencyPlayers = Data

	for Player, Blip in pairs(EmergencyBlips) do
		if not EmergencyPlayers[Player] then
			RemoveBlip(Blip)
			EmergencyBlips[Player] = nil
		end
	end
end)

AddEventHandler("EmergencyBlips.Panic", function()
	local Position = GetEntityCoords(PlayerPedId(), false)
	local Street, Crossing = GetStreetNameAtCoord(Position.x, Position.y, Position.z)
	TriggerServerEvent("EmergencyBlips.Panic", (exports.policejob:getIsInService() and "^7Officer" or "^7Medic"), GetStreetNameFromHashKey(Street))
end)
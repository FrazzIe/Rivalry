PanicPlayers = {}

if IsDuplicityVersion() then
	RegisterServerEvent("Panic.Toggle")
	AddEventHandler("Panic.Toggle", function()
		local Source = source

		if PanicPlayers[Source] then
			PanicPlayers[Source] = nil
		else
			PanicPlayers[Source] = true
		end

		TriggerClientEvent("Panic.Sync", -1, PanicPlayers)
	end)

	AddEventHandler("core:loaded", function(Source)
		TriggerClientEvent("Panic.Sync", Source, PanicPlayers)
	end)
else
	PanicBlips = {}

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(500)

			if exports.policejob and exports.emsjob then
				if exports.policejob:getIsInService() or exports.emsjob:getIsInService() then
					for Player, _ in pairs(PanicPlayers) do
						local PlayerId = GetPlayerFromServerId(Player)
						if NetworkIsPlayerActive(PlayerId) then
							local PedId = GetPlayerPed(PedId)
							if DoesEntityExist(PedId) then
								if not Panicblips[Player] then
									Panicblips[Player] = AddBlipForEntity(PedId)
									SetBlipSprite(Panicblips[Player], 1)
									SetBlipColour(Panicblips[Player], 1)
									SetBlipAsShortRange(Panicblips[Player], true)
									SetBlipScale(Panicblips[Player], 0.85)
									BeginTextCommandSetBlipName("STRING")
									AddTextComponentString("10-13")
									EndTextCommandSetBlipName(Panicblips[Player])
								else
									if GetBlipFromEntity(PedId) ~= Panicblips[Player] then
										Panicblips[Player] = AddBlipForEntity(PedId)
										SetBlipSprite(Panicblips[Player], 1)
										SetBlipColour(Panicblips[Player], 1)
										SetBlipAsShortRange(Panicblips[Player], true)
										SetBlipScale(Panicblips[Player], 0.85)
										BeginTextCommandSetBlipName("STRING")
										AddTextComponentString("10-13")
										EndTextCommandSetBlipName(Panicblips[Player])
									end
								end
							end
						end
					end
				else
					if table.length(PanicBlips) > 0 then
						for Player, Blip in pairs(PanicBlips) do
							RemoveBlip(Blip)
						end

						PanicBlips = {}
					end
				end
			end
		end
	end)

	RegisterNetEvent("core:ready")
	AddEventHandler("core:ready", function()
	    Chat.Command("panic", function(source, args, rawCommand)
	        if exports.policejob:getIsInService() or exports.policejob:getIsInService() then
	            if exports["phone"]:PlayerHasPhone() then
	                if not exports.policejob:getIsCuffed() then
	                    TriggerServerEvent("Panic.Toggle")
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

	RegisterNetEvent("Panic.Sync")
	AddEventHandler("Panic.Sync", function(Data)
		PanicPlayers = Data

		for Player, Blip in pairs(PanicBlips) do
			if not PanicPlayers[Player] then
				RemoveBlip(Blip)
				PanicBlips[Player] = nil
			end
		end
	end)
end
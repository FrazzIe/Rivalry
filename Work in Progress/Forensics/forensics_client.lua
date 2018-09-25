all_evidence = {}
picked_evidence = {}
microscope = {x = 435.41537475586, y = -973.22076416016, z = 35.466178894043, h = 356.96154785156},

RegisterNetEvent('police:forensicssync_client')
AddEventHandler('police:forensicssync_client', function(type, data)
	if(type == "wep") then
		all_evidence = data
	end
	if( type == "pickedupevidence" ) then
		picked_evidence = data
	end
end)

RegisterNetEvent('police:forensics_return')
AddEventHandler('police:forensics_return', function(table)
	if #table >= 1 then
		Chat_Message("Results", "The bullet has noticeable markings to a weapon in the Los Santos Ballistics Database. The bullet matches to a weapon with the Serial Number "..table[1].id, 255, 0, 0, true)
	else
		Chat_Message("Results", "The bullet seems to have came from a weapon not registered in the Los Santos Ballistics Database",255, 0, 0, true))
	end
end)

RegisterNetEvent('police:forensics_weapon')
AddEventHandler('police:forensics_weapon', function(gun)
	Chat_Message("Results", "^0Results: The bullet traces back to a "..gun, 255, 0, 0, true)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		RequestAnimDict("mp_common")
		while not HasAnimDictLoaded("mp_common") do
			Citizen.Wait(0)
		end
		if IsPedShooting(PlayerPedId()) then
			local coords = GetEntityCoords(PlayerPedId(), false)
			local street, crossing = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
			local evidence = {
				ped = PlayerId(),
				x = coords.x,
				y = coords.y,
				z = coords.z,
				gun = GetSelectedPedWeapon(PlayerPedId()),
				location = street
			}
			TriggerServerEvent('police:forensicssync', evidence, "wepevidence", "add", 0)
		end

		if isInService then
			local coords = GetEntityCoords(PlayerPedId(), false)
			for k, v in ipairs(all_evidence) do
				if Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 10 then
					DrawMarker(25, v.x, v.y, v.z-0.9, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
					if Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to pick up evidence!")
						if IsControlJustPressed(1, 51) then
							TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)
							TriggerServerEvent('police:forensicssync', v, "pickedupevidence", "add", k)
							TriggerServerEvent('police:forensicssync', v, "wepevidence", "remove", k)
						end
					end
				end
			end
			if Vdist(coords.x, coords.y, coords.z, microscope.x, microscope.y, microscope.z) < 1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to use the microscope!")
				if IsControlJustPressed(1, 51) then
					Notify("Please select a piece of evidence through this list! Use /evidence [number]", 7400)
					for k, v in ipairs(picked_evidence) do
						if #picked_evidence < 1 then
							Chat_Message("Evidence Locker", "^0Is empty!")
						else
							Chat_Message("Evidence Locker", "^0["..k.."] - "..GetStreetNameFromHashKey(v.location))
						end
					end
					while selectedEvidence < 1 do
						Citizen.Wait(0)
					end
					Notify("Examining Ballistics Evidence...", 10000)
					Citizen.Wait(10000)
					local probability = math.random(1, 100)
					if probability >= 60 then
						Chat_Message("Results", "^0The bullet was not able to provide any links to a type of gun.", 255, 0, 0, true)
					elseif probability < 60 and probability > 20 then
						local gunhash = picked_evidence[selectedEvidence].gun
						local gun = Weaponhashes[tostring(gunhash)]
						TriggerServerEvent('police:forensicssyncevidence', "nameofweapon", gun, GetPlayerServerId(picked_evidence[selectedEvidence].ped))
					else
						local gunhash = picked_evidence[selectedEvidence].gun
						local gun = Weaponhashes[tostring(gunhash)]
						TriggerServerEvent('police:forensicssyncevidence', "weapon", gun, GetPlayerServerId(picked_evidence[selectedEvidence].ped))
					end
					TriggerServerEvent('police:forensicssync', picked_evidence[selectedEvidence], "pickedupevidence", "remove", selectedEvidence)
					selectedEvidence = 0
				end
			end
		end
	end
end)
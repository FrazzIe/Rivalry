all_evidence = {}
picked_evidence = {}
fingerprints = {}
collectedprint = {}
bloodevidence = {}
collectedblood = {}
microscope = {x = 461.35046386719, y = -1007.7575073242, z = 32.819652557373, h = 86.325080871582}
computer = {x = 460.87170410156, y = -1002.9169311523, z = 32.809814453125, h = 86.314888000488}
gloves = {x = 460.26904296875, y = -1004.2963256836, z = 32.81978225708, h = 184.68264770508},
local steps = {
	step1 = true,
	step2 = false,
	step3 = false,
	step4 = false,
}
local lab = {
	[1] = {x = 464.69943237305, y = -1005.9356689453, z = 32.819774627686, h = 274.05487060547},
	[2] = {x = 464.73379516602, y = -1004.453125, z = 32.81965637207, h = 264.93878173828},
	[3] = {x = 461.36331176758, y = -1006.5458984375, z = 32.809818267822, h = 89.826110839844},
}
-- Sync Event
RegisterNetEvent('police:forensicssync_client')
AddEventHandler('police:forensicssync_client', function(type, data)
	if(type == "wep") then
		all_evidence = data
	end
	if( type == "pickedupevidence" ) then
		picked_evidence = data
	end
	if( type == "fpevidence" ) then
		fingerprints = data
	end
	if( type == "pickedupfp" ) then
		collectedprint = data
	end
	if ( type == "pickedupblood" ) then
		collectedblood = data
	end
	if( type == "blood" ) then
		bloodevidence = data
	end
end)

--[[
__________        .__  .__  .__          __  .__         ___________     .__    .___                          
\______   \_____  |  | |  | |__| _______/  |_|__| ____   \_   _____/__  _|__| __| _/____   ____   ____  ____  
 |    |  _/\__  \ |  | |  | |  |/  ___/\   __\  |/ ___\   |    __)_\  \/ /  |/ __ |/ __ \ /    \_/ ___\/ __ \ 
 |    |   \ / __ \|  |_|  |_|  |\___ \  |  | |  \  \___   |        \\   /|  / /_/ \  ___/|   |  \  \__\  ___/ 
 |______  /(____  /____/____/__/____  > |__| |__|\___  > /_______  / \_/ |__\____ |\___  >___|  /\___  >___  >
        \/      \/                  \/               \/          \/              \/    \/     \/     \/    \/ 
--]]
RegisterNetEvent('police:forensics_return')
AddEventHandler('police:forensics_return', function(id)
	if id ~= nil then
		Chat_Message("Results", "The bullet has noticeable markings to a weapon in the Los Santos Ballistics Database. The bullet matches to a weapon with the Serial Number "..id, 255, 0, 0, true)
	else
		Chat_Message("Results", "The bullet seems to have came from a weapon not registered in the Los Santos Ballistics Database",255, 0, 0, true)
	end
end)

RegisterNetEvent('police:forensics_weapon')
AddEventHandler('police:forensics_weapon', function(gun)
	Chat_Message("Results", "^0Results: The bullet traces back to a "..gun, 255, 0, 0, true)
end)

RegisterNetEvent("police:bleachvehicle")
AddEventHandler("police:bleachvehicle", function(vplate)
	RequestAnimDict("timetable@floyd@clean_kitchen@idle_a")
	while not HasAnimDictLoaded("timetable@floyd@clean_kitchen@idle_a") do
		Wait(0)
	end
	TaskPlayAnim(PlayerPedId(), "timetable@floyd@clean_kitchen@idle_a", "idle_a", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)
	for k, v in ipairs(fingerprints) do
		if v.plate == vplate then
			TriggerServerEvent('police:forensicssync', "", "fpevidence", "remove", k)
		end
	end
	Wait(10000)
	Notify("Vehicle has been cleaned of all fingerprints!")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		RequestAnimDict("mp_common")
		while not HasAnimDictLoaded("mp_common") do
			Citizen.Wait(0)
		end
		if IsPedShooting(PlayerPedId()) and IsWeaponValid(GetSelectedPedWeapon(PlayerPedId())) and GetAmmoInPedWeapon(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId())) > 0 then
			local coords = GetEntityCoords(PlayerPedId(), false)
			local street, crossing = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
			local evidence = {
				ped = GetPlayerServerId(PlayerId()),
				x = coords.x,
				y = coords.y,
				z = coords.z,
				gun = GetSelectedPedWeapon(PlayerPedId()),
				location = street
			}
			if #all_evidence >= 1 then
				for k, v in ipairs(all_evidence) do
					for a, b in ipairs(all_evidence) do
						if(v.ped ~= b.ped and Vdist(v.x, v.y, v.z, b.x, b.y, b.z) > 15) then
							TriggerServerEvent('police:forensicssync', evidence, "wepevidence", "add", 0)
							Citizen.Wait(1000)
						end
					end
				end
			else
				TriggerServerEvent('police:forensicssync', evidence, "wepevidence", "add", 0)
				Citizen.Wait(1000)
			end
		end

		if isInService then
			local coords = GetEntityCoords(PlayerPedId(), false)
			for k, v in ipairs(all_evidence) do
				if Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 10 then
					DrawMarker(25, v.x, v.y, v.z-0.9, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
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
					Notify("Please select a piece of evidence through this list! Use /evidence wep [number]", 7400)
					if #picked_evidence < 1 then
						Chat_Message("Evidence Locker", "^0Is empty!")
					else
						for k, v in ipairs(picked_evidence) do
							Chat_Message("Evidence Locker", "^0["..k.."] - "..GetStreetNameFromHashKey(v.location))
						end
					end
					while selectedEvidence < 1 do
						Citizen.Wait(0)
					end
					if #picked_evidence > 0 and picked_evidence[selectedEvidence] ~= nil then
						Notify("Examining Ballistics Evidence...", 10000)
						Citizen.Wait(10000)
						local probability = math.random(1, 100)
						if probability > 50 then
							local gunhash = picked_evidence[selectedEvidence].gun
							local gun = Weaponhashes[tostring(gunhash)]
							TriggerServerEvent('police:forensicssyncevidence', "nameofweapon", gun, picked_evidence[selectedEvidence].ped)
						else
							local gunhash = picked_evidence[selectedEvidence].gun
							local gun = Weaponhashes[tostring(gunhash)]
							TriggerServerEvent('police:forensicssyncevidence', "weapon", gun, picked_evidence[selectedEvidence].ped)
						end
						TriggerServerEvent('police:forensicssync', picked_evidence[selectedEvidence], "pickedupevidence", "remove", selectedEvidence)
						selectedEvidence = 0
					end
				end
			end
		end
	end
end)
--[[
___________.__                                         .__  __                 
\_   _____/|__| ____    ____   ________________________|__|/  |_  ____   ______
 |    __)  |  |/    \  / ___\_/ __ \_  __ \____ \_  __ \  \   __\/    \ /  ___/
 |     \   |  |   |  \/ /_/  >  ___/|  | \/  |_> >  | \/  ||  | |   |  \\___ \ 
 \___  /   |__|___|  /\___  / \___  >__|  |   __/|__|  |__||__| |___|  /____  >
     \/            \//_____/      \/      |__|                       \/     \/ 
--]]

RegisterNetEvent('police:vehicleswab')
AddEventHandler('police:vehicleswab', function(swabedcar)
	RequestAnimDict("timetable@floyd@clean_kitchen@idle_a")
		while not HasAnimDictLoaded("timetable@floyd@clean_kitchen@idle_a") do
			Wait(0)
		end
	local count = 0
	for k, v in ipairs(fingerprints) do
		if swabedcar == v.plate then
			TaskPlayAnim(PlayerPedId(), "timetable@floyd@clean_kitchen@idle_a", "idle_a", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)
			count = count + 1
			Notify("You are currently swabbing the vehicle!", 10000)
			Citizen.Wait(10000)
			ClearPedTasks(PlayerPedId())
			TriggerServerEvent('police:forensicssync', v, "pickedupfp", "add", k)
			TriggerServerEvent('police:forensicssync', v, "fpevidence", "remove", k)
		end
	end
	Chat_Message("Results", "^0You collected "..count.." fingerprint(s).", 255, 0, 0, true)
end)

RegisterNetEvent('police:print_results')
AddEventHandler('police:print_results', function(type, name)
	if type == "sucesss" then
		Chat_Message("Results", "^0The fingerprint matches to someone who has been arrested | Name: "..name, 255, 0, 0, true)

	end
	if type == "nomatch" then
		Chat_Message("Results", "^0The fingerprint doesn't match anything within the database!", 255, 0, 0, true)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(PlayerPedId()) then
			local handle = GetVehiclePedIsIn(PlayerPedId(), false)
			local plate = GetVehicleNumberPlateText(handle)
			local ped = PlayerPedId()
			if GetPedDrawableVariation(PlayerPedId(), 3) < 16 then
				local fingerprint = {
					player = exports.core:GetCharacterName(GetPlayerServerId(PlayerId())),
					plate = plate
				}
				if #fingerprints >= 1 then
					for k, v in ipairs(fingerprints) do
						if v.player ~= ped and v.plate ~= plate then
							TriggerServerEvent('police:forensicssync', fingerprint, "fpevidence", "add", 0)
							Citizen.Wait(2000)
						else
							TriggerServerEvent('police:forensicssync', fingerprint, "fpevidence", "remove", k)
							Citizen.Wait(2000)
						end
					end
				else
					TriggerServerEvent('police:forensicssync', fingerprint, "fpevidence", "add", 0)
					Citizen.Wait(2000)
				end
			end
		end
		if isInService then
			local coords = GetEntityCoords(PlayerPedId(), false)
			if Vdist(computer.x, computer.y, computer.z, coords.x, coords.y, coords.z) < 1 then
				DisplayHelpText('Press ~INPUT_CONTEXT~ to use the computer!')
				if IsControlJustPressed(1, 51) then
					Notify("Please select a piece of evidence through this list! Use /evidence fp [number]")
					if #collectedprint < 1 then
						Chat_Message("Evidence Locker", "^0Is empty!")
					else
						for k, v in ipairs( collectedprint ) do
							Chat_Message("Evidence Locker", "^0["..k.."] - Plate: "..v.plate)
						end
					end
					while selectedEvidenceFP < 1 do
						Citizen.Wait(0)
					end
					Notify("Examining Fingerprint, Cross Referencing with Los Santos Fingerprint Database", 60000)
					Citizen.Wait(60000)
					if #collectedprint > 0 and collectedprint[selectedEvidenceFP].player ~= nil then
						TriggerServerEvent('police:checkprint', collectedprint[selectedEvidenceFP].player)
						selectedEvidenceFP = 0
					end
				end
			end
			if Vdist(gloves.x, gloves.y, gloves.z, coords.x, coords.y, < 1) then
				DisplayHelpText('Press ~INPUT_CONTEXT~ to use this!')
				if IsControlJustPressed(1,51) then
					if isMale(PlayerPedId()) then
						SetPedDrawableVariation(3, x)
					else
						SetPedDrawableVariation(3, y)
					end
				end
			end
		end
	end
end)

RegisterNetEvent('police:dna_results')
AddEventHandler('police:dna_results', function(result, firstname, lastname)
	if result == "sucess" then
		Chat_Message("The results from your DNA Test seem to match one from the Los Santos PD Crime Database. Name: "..firstname.." "..lastname, 255, 0, 0, true)
	end
	if result = "nomatch" then
		Chat_Message("The results come back to a unique DNA Profile, but doesn't match anyone in the Los Santos PD Crime Database.", 255, 0, 0, true)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		RequestAnimDict("mp_common")
		while not HasAnimDictLoaded("mp_common") do
			Citizen.Wait(0)
		end
		local coords = GetEntityCoords(PlayerPedId(), false)
		if PedIsInjured(PlayerPedId()) then
			ApplyPedBloodByZone(PlayerPedId(), coords.x, coords.y, coords.z)
			local blood = {
				ped = PlayerId(),
				x = coords.x,
				y = coords.y,
				z = coords.z
			}
			if #bloodevidence < 1 then
				for k, v in ipairs(bloodevidence) do
					if v.ped ~= PlayerId() and Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) > 50 then
						TriggerServerEvent('police:forensicssync', blood, "blood", "add", 0)
						Citizen.Wait(2000)
					else
						TriggerServerEvent('police:forensicssync', "", "blood", "remove", k)
					end
				end
			else
				TriggerServerEvent('police:forensicssync', blood, "blood", "add", 0)
				Citizen.Wait(4000)
			end
		end
		if isInService then
			for k, v in ipairs(bloodevidence) do
				if Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 10 then
					DrawMarker()
					if Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to collect samples of blood evidence")
						if IsControlJustPressed(1,51) then
							TriggerServerEvent('police:forensicssync', "", "blood", "remove", k)
							TriggerServerEvent('police:forensicssync', v, "pickedupblood", "add", k)
							TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)
							Citizen.Wait(2000)					
						end
					end
				end
			end
			if Vdist(coords.x, coords.y, coords.z, 461.36346435547, -1005.0454711914, 32.809818267822) < 1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to use the microscope")
				if IsControlJustPressed(1, 51) then
					Notify("Please select a piece of evidence through this list! Use /evidence blood [number]", 7400)
					while selectedEvidenceB do
						Citizen.Wait(0)
					end
					if selectedEvidenceB > 0 then
						Notify("Please take the sample over to the chemical desk!")
						if Vdist(coords.x, coords.y, coords.z, lab[1].x, lab[1].y, lab[1].z) < 1 and steps.step1 == true then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to use the lab desk!")
							if IsControlJustPressed(1,51) then
								Notify("You are currently pouring enzymes into a flask to seperate the strands of DNA!")
								Citizen.Wait(60000)
								steps.step2 = true
								steps.step1 = false
							end
						end
						if Vdist(coords.x, coords.y, coords.z, lab[2].x, lab[2].y, lab[2].z) < 1 and steps.step2 == true then
							DisplayHelpText("Press ~INPUT_ CONTEXT~ to add the DNA Stands to a Gel Based Polymer!")
							if IsControlJustPressed(1,51) then
								Ciitzen.Wait(60000)
								steps.step3 = true
								steps.step2 = false
							end
						end
						if Vdist(coords.x, coords.y, coords.z, lab[3].x, lab[3].y, lab[3].z) < 1 and steps.step3 == true then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to add a electrical current to the Gel!")
								if IsControlJustPressed(1,51) then
								Citizen.Wait(60000)
								steps.step4 = true
								steps.step3 = false
							end
						end
						if steps.step4 == true then
							Notify("Your DNA Evidence is being processed!", 600000)
							Citizen.Wait(600000)
							TriggerServerEvent('police:forensics_dna', )
						end
					end
				end
			end
		end
	end
end)
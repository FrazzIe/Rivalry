local Collected_Fingerprints = {}
local Collected_BulletCasings = {}
local UnCollected_Fingerprints = {}
local UnCollected_BulletCasings = {}
local Microscope = vector3(461.35046386719,-1007.7575073242,32.819652557373)
local Computer = vector3(460.87170410156,-1002.9169311523,32.809814453125)
local ClientBulletCasings = {}
local ClientFingerPrints = {}
local Investigating = false

RegisterNetEvent('Forensics.Sync')
AddEventHandler('Forensics.Sync', function(Type, Table)
	if Type == "UnCollectedFingerprints" then
		UnCollected_Fingerprints = Table
	elseif Type == "CollectedFingerprints" then
		Collected_Fingerprints = Table
	end

	if Type == "UnCollectedBulletCasing" then
		UnCollected_BulletCasings = Table
	elseif Type == "CollectedBulletCasing" then
		Collected_BulletCasings = Table
	end
end)

RegisterNetEvent('Police.Forensics.Toggle.InvestigationMode')
AddEventHandler('Police.Forensics.Toggle.InvestigationMode', function()
	Investigating = not Investigating
end)

RegisterNetEvent('Police.Swab.Vehicle')
AddEventHandler('Police.Swab.Vehicle', function(Plate)
	RequestAnimDict("timetable@floyd@clean_kitchen@idle_a")
	while not HasAnimDictLoaded("timetable@floyd@clean_kitchen@idle_a") do
		Wait(0)
	end
	TaskPlayAnim(PlayerPedId(), "timetable@floyd@clean_kitchen@idle_a", "idle_a", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)
	Notify("You are currently swabbing the vehicle!", 10000)
	Citizen.Wait(10000)
	TriggerServerEvent('Police.Swab.Vehicle', Plate)
end)

RegisterNetEvent("Forensics.WeaponName.Return")
AddEventHandler("Forensics.WeaponName.Return", function(Gun)
	Chat_Message("Results", "The bullet was fired from a "..Gun, 255, 0, 0, true)
end)

RegisterNetEvent("Forensics.BulletCasing.Return")
AddEventHandler("Forensics.BulletCasing.Return", function(SerialNumber)
	if SerialNumber ~= nil then
		Chat_Message("Results", "This bullet matches data from a weapon in the Los Santos Ballistics Database. Serial Number: "..SerialNumber, 255, 0, 0, true)
	else
		Chat_Message("Results", "This bullet doesn't match anything in the Los Santos Ballistics Database", 255, 0, 0, true)
	end
end)

RegisterNetEvent("Forensics.FingerPrint.Result")
AddEventHandler("Forensics.FingerPrint.Result", function(Result, Name)
	if Result == "sucess" then
		Chat_Message("This fingerprint matches the same fingerprint of "..Name, 255, 0, 0, true)
	elseif Result == "nomatch" then
		Chat_Message("This fingerprint has no matches!", 255, 0, 0, true)
	end
end)

function BulletCasingNearBy(PlayerPosition)
	if #ClientBulletCasings > 0 then
		for Index = 1, #ClientBulletCasings do
			if #(PlayerPosition - ClientBulletCasings[Index]) < 15 then
				return true
			end
		end
		return false
	else
		return false
	end
end

function IsFingerPrintInCar(Plate)
	if #ClientFingerPrints > 0 then
		for Index = 1, #ClientFingerPrints do
			if Plate == ClientFingerPrints[Index] then
				return true
			end
		end
		return false
	else
		return false
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Ped = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Ped, false)
		if IsPedShooting(Ped) and IsPedAPlayer(Ped) then
			if IsWeaponValid(GetSelectedPedWeapon(Ped)) and GetAmmoInPedWeapon(Ped, GetSelectedPedWeapon(Ped)) > 0 then
				if BulletCasingNearBy(PlayerPosition) == false then
					local Street, Crossing = GetStreetNameAtCoord(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
					local BulletCasing = {
						Player = GetPlayerServerId(PlayerId()),
						WeaponUsed = Weaponhashes[tostring(GetSelectedPedWeapon(Ped))],
						Location = GetStreetNameFromHashKey(Street),
						Coords = vector3(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z),
						SerialNumber = nil,
						Type = "BulletCasing"
					}
					table.insert(ClientBulletCasings, PlayerPosition)
					TriggerServerEvent('Forensics.Sync', BulletCasing, "BulletCasing")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Ped = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Ped, false)
		if IsPedGettingIntoAVehicle(Ped) and GetPedDrawableVariation(Ped, 3) < 16 then
			local Vehicle = GetVehiclePedIsTryingToEnter(Ped)
			local VehicleLicensePlate = GetVehicleNumberPlateText(Vehicle)
			if IsFingerPrintInCar(VehicleLicensePlate) == false then
				local Street, Crossing = GetStreetNameAtCoord(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
				local Fingerprint = {
					Player = GetPlayerServerId(PlayerId()),
					LicensePlate = VehicleLicensePlate,
					Type = "Fingerprint"
				}
				table.insert(ClientFingerPrints, VehicleLicensePlate)
				TriggerServerEvent('Forensics.Sync', Fingerprint, "FingerPrint")
				Citizen.Wait(5000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isInService and Investigating then
			local Ped = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Ped, false)
			for Index = 1, #UnCollected_BulletCasings do
				if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 5 then
					DrawMarker(25, UnCollected_BulletCasings[Index].Coords.x, UnCollected_BulletCasings[Index].Coords.y, UnCollected_BulletCasings[Index].Coords.z-1.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
					if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 1 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to collect bullet casing!")
						if IsControlJustPressed(1,51) then
							TriggerServerEvent('Forensics.PickUp.Evidence', UnCollected_BulletCasings[Index] ,"BulletCasing", 0)
							Citizen.Wait(5000)
						end
					end
				end
			end
		elseif Investigating then
			local Ped = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Ped, false)
			for Index = 1, #UnCollected_BulletCasings do
				if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 5 then
					DrawMarker(25, UnCollected_BulletCasings[Index].Coords.x, UnCollected_BulletCasings[Index].Coords.y, UnCollected_BulletCasings[Index].Coords.z-1.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
					if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 1 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to destroy evidence!")
						if IsControlJustPressed(1,51) then
							TriggerServerEvent('Forensics.PickUp.Evidence', UnCollected_BulletCasings[Index] ,"BulletCasing", 0)
							Notify("You are currently destroying evidence!")
							Citizen.Wait(60000)
							if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 2 then
								Notify("You have destroyed the evidence!", 2600)
								TriggerServerEvent("Forensics.Delete.Evidence", Index)
							else
								Notify("You moved too far from the evidence to destroy it!", 2600)
							end
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isInService then
			local PlayerPed = PlayerPedId()
			local PlayerPosition = GetEntityCoords(PlayerPed, false)
			if #(PlayerPosition - Microscope) < 1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to use the microscope!")
				if IsControlJustPressed(1, 51) then
					Notify("Please select a piece of evidence through the list! Use /evidence wep [number]", 7400)
					if #Collected_BulletCasings < 1 then
						Chat_Message("Evidence Locker", "^0Is empty!")
					else
						for Index = 1, #Collected_BulletCasings do
							Chat_Message("Evidence Locker", "^0["..Index.."] - "..Collected_BulletCasings[Index].Location)
						end
					end
					while SelectedEvidence < 1 do
						Citizen.Wait(0)
					end
					if #Collected_BulletCasings > 0 and Collected_BulletCasings[SelectedEvidence] ~= nil then
						Notify("Examining Ballistics Evidence...", 10000)
						Citizen.Wait(10000)
						local Probability = math.random(1, 100)
						if Probability > 50 then
							TriggerServerEvent('Forensics.BulletCasing.Information', "WeaponName", SelectedEvidence)
						else
							TriggerServerEvent('Forensics.BulletCasing.Information', "SerialNumber", SelectedEvidence)
						end
						SelectedEvidence = 0
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isInService then
			local PlayerPed = PlayerPedId()
			local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
			if #(PlayerPosition - Computer) < 1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to use the computer!")
				if IsControlJustPressed(1, 51) then
					Notify("Please select a piece of evidence through this list! Use /evidence fp [number]")
					if #Collected_Fingerprints < 1 then
						Chat_Message("Evidence Locker", "^0Is empty!")
					else
						for Index = 1, #Collected_Fingerprints do
							Chat_Message("Evidence Locker", "^0["..Index.."] - Plate: "..Collected_Fingerprints[Index].LicensePlate)
						end
					end
					while SelectedEvidenceFP < 1 do
						Citizen.Wait(0)
					end
					Notify("Examining Fingerprint, Cross referencing with Los Santos Criminal Database", 60000)
					Citizen.Wait(60000)
					if #Collected_Fingerprints > 0 and Collected_Fingerprints[SelectedEvidenceFP].Player ~= nil then
						TriggerServerEvent("Forensics.RunPrint", Collected_Fingerprints[SelectedEvidenceFP].Player)
						SelectedEvidenceFP = 0
					end
				end
			end
		end
	end
end)

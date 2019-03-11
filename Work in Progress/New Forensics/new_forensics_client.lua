local Collected_Fingerprints = {}
local Collected_BulletCasing = {}
local UnCollected_Fingerprints = {}
local UnCollected_BulletCasings = {}

RegisterNetEvent('Forensics.Sync')
AddEventHandler('Forensics.Sync', function(Type, Table)
	if Type == "UnCollectedFingerprints" then
		UnCollected_Fingerprints = Table
	elseif Type == "CollectedFingerprints" then
		Collected_Fingerprints = Table
	end

	if Type == "UnCollectedBulletCasings" then
		UnCollected_BulletCasings = Table
	elseif Type == "CollectedBulletCasings" then
		Collected_BulletCasings = Table
	end
end)

RegisterNetEvent('Police.Swab.Vehicle')
AddEventHandler('Police.Swab.Vehicle', function(Plate)
	TriggerServerEvent('Police.Swab.Vehicle', Plate)
end)

Citizen.CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Ped, false)
		if IsPedShooting(Ped) and IsPedAPlayer(Ped) then
			if IsWeaponValid(GetSelectedPedWeapon(Ped)) and GetAmmoInPedWeapon(Ped, GetSelectedPedWeapon(Ped)) > 0 then
				local Street, Crossing = GetStreetNameAtCoord(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
				local BulletCasing = {
					Player = GetPlayerServerId(Ped),
					WeaponUsed = GetSelectedPedWeapon(Ped),
					Location = GetStreetNameFromHashKey(Street),
					Coords = vector3(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z),
					Type = "BulletCasing"
				}
				TriggerServerEvent('Forensics.Sync', BulletCasing)
				Citizen.Wait(10000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Ped, false)
		if IsPedInAnyVehicle(Ped) and GetPedDrawableVariation(Ped, 3) < 16 then
			local Vehicle = GetVehiclePedIsIn(Ped, false)
			local Street, Crossing = GetStreetNameAtCoord(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
			local Fingerprint = {
				Player = GetPlayerServerId(Ped),
				LicensePlate = GetVehicleNumberPlateText(Vehicle),
				Type = "Fingerprint"
			}
			TriggerServerEvent('Forensics.Sync', Fingerprint)
			Citizen.Wait(60000)
		end
	end
end)

Citizen.CreateThread(function()
	while True do
		Citizen.Wait(0)
		if IsInService then
			local Ped = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Ped, false)
			for Index = 1, #UnCollected_BulletCasings do
				if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 5 then
					DrawMarker(25, UnCollected_BulletCasings[Index].Coords.x, UnCollected_BulletCasings[Index].Coords.y, UnCollected_BulletCasings[Index].Coords.z-0.9, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
					if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 1 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to collect bullet casing!")
						if IsControlJustPressed(1,51) then
							TriggerServerEvent('Forensics.PickUp.Evidence', UnCollected_BulletCasings[Index] ,"BulletCasing")
						end
					end
				end
			end
		end
	end
end)
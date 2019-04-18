local Collected_Fingerprints = {}
local Collected_BulletCasings = {}
local UnCollected_Fingerprints = {}
local UnCollected_BulletCasings = {}
local Microscope = vector3(461.35046386719,-1007.7575073242,32.819652557373)
local Computer = vector3(460.87170410156,-1002.9169311523,32.809814453125)
local ClientBulletCasings = {}
local ClientFingerPrints = {}
local Investigating = false
local Collected_Inventory = {}
local Collected_Firearms = {}
local ChosenEvidence = {
	Fingerprints = {},
	Ballistics = {},
	Firearms = {},
	ControlledSubstances = {}
}

RegisterNetEvent('Forensics.Sync')
AddEventHandler('Forensics.Sync', function(Type, Table)
	if Type == "UnCollectedFingerprints" then
		UnCollected_Fingerprints = Table
	elseif Type == "UnCollectedBulletCasing" then
		UnCollected_BulletCasings = Table
	end
end)

RegisterNetEvent("Forensics.Vehicle.Swabs")
AddEventHandler("Forensics.Vehicle.Swabs", function(Table)
	table.insert(Collected_Fingerprints, Table)
end)

--[[RegisterNetEvent('inventory:police_evidence')
RegisterNetEvent("Forensics.Fingerprints")
RegisterNetEvent("Forensics.Ballistics")
RegisterNetEvent('Forensics.Firearms')
RegisterNetEvent("Forensics.Controlled.Substances")
RegisterNetEvent("Evidence:Options")
RegisterNetEvent("Forensics.Store")
RegisterNetEvent("Forensics.Give")
RegisterNetEvent("Forensics.Destroy")
RegisterNetEvent("Forensics.PutInEvidence")
RegisterNetEvent("Forensics.PutWeaponInEvidence")--]]

AddEventHandler("inventory:police_evidence", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Fingerprints", [[TriggerEvent("Forensics.Fingerprints")]])
    exports.ui:addOption("Ballistics", [[TriggerEvent('Forensics.Ballistics')]])
    exports.ui:addOption("Firearms", [[TriggerEvent('Forensics.Firearms')]])
    exports.ui:addOption("Controlled Substances", [[TriggerEvent'Forensics.Controlled.Substances]])
    exports.ui:back([[TriggerEvent("inventory:open")]])
end)

AddEventHandler("Forensics.Fingerprints", function()
	exports.ui:reset()
    exports.ui:open()
    print(tostring(#Collected_Fingerprints))
	for Index = 1, #Collected_Fingerprints do
		exports.ui:addOption(Collected_Fingerprints[Index].LicensePlate, [[TriggerEvent("Forensic:Options")]], Collected_Fingerprints[Index])
	end
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensics.Ballistics", function()
	exports.ui:reset()
    exports.ui:open()
    print(tostring(#Collected_BulletCasings))
	for Index = 1, #Collected_BulletCasings do
		exports.ui:addOption(Collected_BulletCasings[Index].Location, [[TriggerEvent("Forensic:Options")]], Collected_BulletCasings[Index])
	end
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensics.Firearms", function()
	exports.ui:reset()
    exports.ui:open()
	for Index = 1, #Collected_Firearms do
		exports.ui:addOption(Weapons_names[Collected_Firearms[Index].model], [[TriggerEvent("Forensic:Options")]], Collected_Firearms[Index])
	end
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensics.Controlled.Substances", function()
	exports.ui:reset()
    exports.ui:open()
	for Index = 1, #Collected_Inventory do
		exports.ui:addOption(Collected_Inventory[Index].quantity.." | "..Collected_Inventory[Index].name, [[TriggerEvent("Forensic:Options")]], Collected_Inventory[Index])
	end
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensic:Options", function(Data)
	exports.ui:reset()
    exports.ui:open()
	exports.ui:addOption("Storage", "Forensics.Store", Data)
	exports.ui:addOption("Give", "Forensics.Give", Data)
	exports.ui:addOption("Destroy", "Forensics.Destroy", Data)
	exports.ui:back("[[inventory:police_evidence]]")
end)

AddEventHandler("Forensics.Store", function(Data, Which)
	Player = PlayerPedId()
	PlayerPosition = GetEntityCoords(Player, false)
	if #(PlayerPosition - EvidenceLocker) <= 2 then
		local Description = tostring(KeyboardInput("Enter Description:", 1000))
		TriggerServerEvent("Forensics.Store", Data, Description, Data.Type)
	end
end)

AddEventHandler("Forensics.PutInEvidence", function(Data, Which)
	Type = "CDS"
	table.insert(Data, Type)
	table.insert(Collected_Inventory, Data)
end)

AddEventHandler("Forensics,PutWeaponInEvidence", function(Data, Which)
	Type = "Firearm"
	table.insert(Data, Type)
	table.insert(Collected_Firearms, Data)
end)

--[[RegisterNetEvent("Forensics.Locker")
RegisterNetEvent("Forensic.Locker.Options")
RegisterNetEvent("Create.Locker.Fingerprints")
RegisterNetEvent("Create.Locker.Ballistics")
RegisterNetEvent("Create.Locker.Firearms")
RegisterNetEvent("Create.Locker.Controlled.Substances")
RegisterNetEvent("Locker.Options")
RegisterNetEvent("Locker.Description")
RegisterNetEvent("Locker.Destroy")
RegisterNetEvent("Locker.Take")--]]

AddEventHandler("Forensics.Locker", function()
	exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Fingerprints", [[TriggerServerEvent("Retrieve.Fingerprints")]])
    exports.ui:addOption("Ballistics", [[TriggerServerEvent('Retrieve.Ballistics')]])
    exports.ui:addOption("Firearms", [[TriggerServerEvent('Retrieve.Firearms')]])
    exports.ui:addOption("Controlled Substances", [[TriggerServerEvent'Retrieve.Controlled.Substances]])
    exports.ui:back("")
end)

AddEventHandler("Create.Locker.Fingerprints", function(Fingerprints)
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #Fingerprints do
		exports.ui:addOption(Fingerprints[Index].LicensePlate, [[TriggerEvent("Locker.Options")]], Fingerprints[Index], "Fingerprints")
	end
	exports.ui:back([[TriggerEvent("Forensics.Locker")]])
end)

AddEventHandler("Create.Locker.Ballistics", function(Ballistics)
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #Ballistics do
		exports.ui:addOption(Ballistics[Index].Location, [[TriggerEvent("Locker.Options")]], Ballistics[Index], "Ballistics")
	end
	exports.ui:back([[TriggerEvent("Forensics.Locker")]])
end)

AddEventHandler("Create.Locker.Firearms", function(Firearms)
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #Firearms do
		exports.ui:addOption(Weapons_names[Firearms[Index].Model], [[TriggerEvent("Locker.Options")]], Firearms[Index], "Firearms")
	end
	exports.ui:back([[TriggerEvent("Forensics.Locker")]])
end)

AddEventHandler("Create.Locker.Controlled.Substances", function(ControlledSubstances)
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #ControlledSubstances do
		exports.ui:addOption(ControlledSubstances[Index].name, [[TriggerEvent("Locker.Options")]], ControlledSubstances[Index], "CDS")
	end
	exports.ui:back([[TriggerEvent("Forensics.Locker")]])
end)

AddEventHandler("Locker.Options", function(Data)
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Description", [[TriggerEvent("Locker.Description")]], Data.Description)
	exports.ui:addOption("Destroy", [[TriggerServerEvent("Locker.Destroy")]], Data, Which)
	exports.ui:addOption("Take", [[TriggerServerEvent("Locker.Take")]], Data, Which)
end)

AddEventHandler("Locker.Description", function(Description)
	Chat_Message("Description", Description, 255, 0, 0, true)
end)

AddEventHandler("Locker.Take", function(Data, Which)
	if Which == "Fingerprints" then
		table.insert(ChosenEvidence.Fingerprints, Data)
	elseif Which == "Ballistics" then
		table.insert(ChosenEvidence.Ballistics, Data)
	elseif Which == "Firearms" then
		table.insert(ChosenEvidence.Firearms, Data)
	elseif Which == "CDS" then
		table.insert(ChosenEvidence.CDS, Data)
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
			if #UnCollected_BulletCasings > 0 then
				for Index = 1, #UnCollected_BulletCasings do
					if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 5 then
						DrawMarker(25, UnCollected_BulletCasings[Index].Coords.x, UnCollected_BulletCasings[Index].Coords.y, UnCollected_BulletCasings[Index].Coords.z-1.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
						if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 1 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to collect bullet casing!")
							if IsControlJustPressed(1,51) then
								TriggerServerEvent('Forensics.PickUp.Evidence', UnCollected_BulletCasings[Index] ,"BulletCasing", 0)
								UnCollected_BulletCasings[Index].Coords = 0
								table.insert(Collected_BulletCasings, UnCollected_BulletCasings[Index])
								Citizen.Wait(5000)
							end
						end
					end
				end
			end
		elseif Investigating then
			local Ped = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Ped, false)
			if #UnCollected_BulletCasings > 0 then
				for Index = 1, #UnCollected_BulletCasings do
					if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 5 then
						DrawMarker(25, UnCollected_BulletCasings[Index].Coords.x, UnCollected_BulletCasings[Index].Coords.y, UnCollected_BulletCasings[Index].Coords.z-1.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
						if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 1 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to destroy evidence!")
							if IsControlJustPressed(1,51) then
								Notify("You are currently destroying evidence!")
								Citizen.Wait(60000)
								if #(PlayerPosition - UnCollected_BulletCasings[Index].Coords) < 2 then
									Notify("You have destroyed the evidence!", 2600)
									TriggerServerEvent('Forensics.PickUp.Evidence', UnCollected_BulletCasings[Index] ,"DestroyEvidence", 0)
								else
									Notify("You moved too far from the evidence to destroy it!", 2600)
								end
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
					if #ChosenEvidence.Ballistics < 1 then
						Chat_Message("Evidence Locker", "^0Is empty!")
					else
						if #ChosenEvidence.Ballistics > 0 and ChosenEvidence.Ballistics[1] ~= nil then
							Notify("Examining Ballistics Evidence...", 10000)
							Citizen.Wait(10000)
							local Probability = math.random(1, 100)
							if Probability > 25 then
								TriggerServerEvent('Forensics.BulletCasing.Information', "WeaponName", ChosenEvidence.Ballistics[1])
							else
								TriggerServerEvent('Forensics.BulletCasing.Information', "SerialNumber", ChosenEvidence.Ballistics[1])
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
			local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
			if #(PlayerPosition - Computer) < 1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to scan a fingerprint!")
				if IsControlJustPressed(1, 51) then
					if #ChosenEvidence.Fingerprints < 1 then
						Chat_Message("Evidence Locker", "^0Is empty!")
					else
						Notify("Examining Fingerprint, Cross referencing with Los Santos Criminal Database", 60000)
						Citizen.Wait(60000)
						if #ChosenEvidence.Fingerprints > 0 and ChosenEvidence.Fingerprints[1].Player ~= nil then
							TriggerServerEvent("Forensics.RunPrint", ChosenEvidence.Fingerprints[1].Player)
						end
					end
				end
			end
		end
	end
end)

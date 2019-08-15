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
local EvidenceTaken = {}
local EvidenceLocker = vector3(470.86749267578,-984.74786376953,30.689680099487)

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

RegisterNetEvent('inventory:police_evidence')
RegisterNetEvent("Forensics.Fingerprints")
RegisterNetEvent("Forensics.Ballistics")
RegisterNetEvent('Forensics.Firearms')
RegisterNetEvent("Forensics.Controlled.Substances")
RegisterNetEvent("Evidence:Options")
RegisterNetEvent("Forensics.Store")
RegisterNetEvent("Forensics.Give")
RegisterNetEvent("Forensics.Destroy")
RegisterNetEvent("Forensics.PutInEvidence")
RegisterNetEvent("Forensics.PutWeaponInEvidence")
RegisterNetEvent("Forensic:InventoryOptions")
RegisterNetEvent("Forensic:WeaponOptions")

AddEventHandler("inventory:police_evidence", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Fingerprints", [[TriggerEvent("Forensics.Fingerprints")]])
    exports.ui:addOption("Ballistics", [[TriggerEvent('Forensics.Ballistics')]])
    exports.ui:addOption("Firearms", [[TriggerEvent('Forensics.Firearms')]])
    exports.ui:addOption("Controlled Substances", [[TriggerEvent('Forensics.Controlled.Substances')]])
    exports.ui:back([[TriggerEvent("inventory:open")]])
end)

AddEventHandler("Forensics.Fingerprints", function()
	exports.ui:reset()
    exports.ui:open()
    print(tostring(#Collected_Fingerprints))
	for Index = 1, #Collected_Fingerprints do
		exports.ui:addOption(Collected_Fingerprints[Index].licenseplate, "Forensic:Options", Collected_Fingerprints[Index])
	end
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensics.Ballistics", function()
	exports.ui:reset()
    exports.ui:open()
    print(tostring(#Collected_BulletCasings))
	for Index = 1, #Collected_BulletCasings do
		exports.ui:addOption(Collected_BulletCasings[Index].location, "Forensic:Options", Collected_BulletCasings[Index])
	end
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensics.Firearms", function()
	exports.ui:reset()
    exports.ui:open()
	for Index = 1, #Collected_Firearms do
		for IndexTwo = 1, #Collected_Firearms[Index] do
			Collected_Firearms[Index][IndexTwo].CharactersName = Collected_Firearms[Index].CharactersName
		end
		exports.ui:addOption(Collected_Firearms[Index].CharactersName, "Forensic:WeaponOptions", Collected_Firearms[Index])
	end
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensics.Controlled.Substances", function()
	exports.ui:reset()
    exports.ui:open()
	for Index = 1, #Collected_Inventory do
		for IndexTwo = 1, #Collected_Inventory[Index] do
			Collected_Inventory[Index][IndexTwo].CharactersName = Collected_Inventory[Index].CharactersName
		end
		exports.ui:addOption(Collected_Inventory[Index].CharactersName, "Forensic:InventoryOptions", Collected_Inventory[Index])
	end
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensic:WeaponOptions", function(Data)
	exports.ui:reset()
    exports.ui:open()
	for Index = 1, #Data do
		Data[Index].type = "firearms"
		exports.ui:addOption(Weapons_names[Data[Index].model], "Forensic:Options", Data[Index])
	end
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensic:Options", function(Data)
	exports.ui:reset()
    exports.ui:open()
	exports.ui:addOption("Storage", "Forensics.Store", Data)
	exports.ui:addOption("Give", "Forensics.Give", Data)
	exports.ui:addOption("Destroy", "Forensics.Destroy", Data)
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensic:InventoryOptions", function(Data)
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #Data do
		Data[Index].type = "cds"
		exports.ui:addOption(Data[Index].quantity.." | "..Data[Index].name, "Forensic:Options", Data[Index])
	end
	exports.ui:back([[TriggerEvent("Forensics.Controlled.Substances")]])
end)

AddEventHandler("Forensics.Store", function(Data)
	local Player = PlayerPedId()
	local PlayerPosition = GetEntityCoords(Player, false)
	if #(PlayerPosition - EvidenceLocker) <= 2 then
		local Title = tostring(KeyboardInput("Enter Title", "", 1000))
		local Description = tostring(KeyboardInput("Enter Description:", "", 1000))
		if Description ~= nil and Title ~= nil then
			RemoveFromCollected(Data)
			TriggerServerEvent("Forensics.Store", Data, Description, Title, Data.type)
		else
			Notify("Your evidence needs a description to be processed!", 2500)
		end
	end
end)

RegisterNetEvent("Forensics.RemoveClientBulletCasing")
AddEventHandler("Forensics.RemoveClientBulletCasing", function(Data)
	for Index = 1, #ClientBulletCasings do
		if ClientBulletCasings[Index].coords.x == Data.coords.x and ClientBulletCasings[Index].coords.y == Data.coords.y then
			table.remove(ClientBulletCasings, Index)
		end
	end
end)

RegisterNetEvent("Forensics.RemoveClientFingerPrint")
AddEventHandler("Forensics.RemoveClientFingerPrint", function(Data)
	for Index = 1, #ClientFingerPrints do
		if ClientFingerPrints[Index].licenseplate == Data.licenseplate then
			table.remove(ClientFingerPrints, Index)
		end
	end
end)

AddEventHandler("Forensics.Give", function(Data)
	local Player = PlayerPedId()
	local PlayerPosition = GetEntityCoords(Player, false)
	if Data.type == "firearms" then
		local t, distance = GetClosestPlayer()
		if(distance ~= -1 and distance < 3) then
			for Index = 1, #Collected_Firearms do
				if Data.id == Collected_Firearms[Index].id and Data.character_id == Collected_Firearms[Index].character_id then
					TriggerServerEvent("weapon:give", Data.model, t)
					table.remove(Collected_Firearms, Index)
				end
			end
		end
	elseif Data.type == "cds" then
		local t, distance = GetClosestPlayer()
		if(distance ~= -1 and distance < 3) then
			for Index = 1, #Collected_Inventory do
				if Data.id == Collected_Inventory[Index].id and Data.character_id == Collected_Inventory[Index].character_id then
					TriggerServerEvent("inventory:give", Data.item_id, Data.name, Data.quantity, t)
					table.remove(Collected_Inventory, Index)
				end
			end
		end
	end
end)

AddEventHandler("Forensics.Destroy", function(Data)
	if Data.type == "firearms" then
		for Index = 1, #Collected_Firearms do
			if Collected_Firearms[Index].model == Data.model and Collected_Firearms[Index].id == Data.id then

			end
		end
	elseif Data.type == "cds" then
		for Index = 1, #Collected_Inventory do
			if Collected_Inventory[Index].player == Data.player and Collected_Inventory[Index].id == Data.id then

			end
		end
	end
end)

AddEventHandler("Forensics.PutInEvidence", function(Data)
	Data.Type = "cds"
	table.insert(Collected_Inventory, Data)
end)

RegisterNetEvent("Forensics.ConfiscateWeapon")
AddEventHandler("Forensics.ConfiscateWeapon", function(Weapons)
	Weapons.Type = "Weapons"
	table.insert(Collected_Firearms, Weapons)
end)

--RegisterNetEvent("Forensics.Locker")
--RegisterNetEvent("Forensic.Locker.Options")
RegisterNetEvent("Create.Locker.Fingerprints")
RegisterNetEvent("Create.Locker.Ballistics")
RegisterNetEvent("Create.Locker.Firearms")
RegisterNetEvent("Create.Locker.Controlled.Substances")
RegisterNetEvent("Locker.Options")
RegisterNetEvent("Locker.Description")
RegisterNetEvent("Locker.Destroy")
RegisterNetEvent("Locker.Take")

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		if isInService then
			if #(PlayerPosition - EvidenceLocker) < 1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the evidence locker!")
				if IsControlJustPressed(1, 51) then
					TriggerEvent("Forensics.Locker")
				end
			end
		end
	end
end)
AddEventHandler("Forensics.Locker", function()
	exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Fingerprints", [[TriggerServerEvent("Retrieve.Fingerprints")]])
    exports.ui:addOption("Ballistics", [[TriggerServerEvent('Retrieve.Ballistics')]])
    exports.ui:addOption("Firearms", [[TriggerServerEvent('Retrieve.Firearms')]])
    exports.ui:addOption("Controlled Substances", [[TriggerServerEvent('Retrieve.Controlled.Substances')]])
    exports.ui:back("")
end)

AddEventHandler("Create.Locker.Fingerprints", function(Fingerprints)
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #Fingerprints do
		exports.ui:addOption(Fingerprints[Index].licenseplate.." - "..Fingerprints[Index].timestamp, "Locker.Options", Fingerprints[Index])
	end
	exports.ui:back([[TriggerEvent("Forensics.Locker")]])
end)

AddEventHandler("Create.Locker.Ballistics", function(Ballistics)
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #Ballistics do
		exports.ui:addOption(Ballistics[Index].location.." - "..Ballistics[Index].timestamp, "Locker.Options", Ballistics[Index])
	end
	exports.ui:back([[TriggerEvent("Forensics.Locker")]])
end)

AddEventHandler("Create.Locker.Firearms", function(Firearms)
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #Firearms do
		exports.ui:addOption(Firearms[Index].title.." - "..Firearms[Index].timestamp, "Locker.Options", Firearms[Index])
	end
	exports.ui:back([[TriggerEvent("Forensics.Locker")]])
end)

AddEventHandler("Create.Locker.Controlled.Substances", function(ControlledSubstances)
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #ControlledSubstances do
		exports.ui:addOption(ControlledSubstances[Index].title.." - "..ControlledSubstances[Index].timestamp, "Locker.Options", ControlledSubstances[Index])
	end
	exports.ui:back([[TriggerEvent("Forensics.Locker")]])
end)

AddEventHandler("Locker.Options", function(Data)
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Description", "Locker.Description", Data.description)
	exports.ui:addOption("Destroy", "Locker.Destroy", Data)
	exports.ui:addOption("Take", "Locker.Take", Data)
	exports.ui:back([[TriggerEvent("Forensics.Locker")]])
end)

AddEventHandler("Locker.Description", function(Description)
	Chat_Message("Description", Description, 255, 0, 0, true)
end)

AddEventHandler("Locker.Take", function(Data)
	if Data.type == "fingerprints" then
		if not EvidenceTaken[Data.id] then
			table.insert(ChosenEvidence.Fingerprints, Data)
			TriggerServerEvent("Locker.Take", Data)
			Notify("Evidence Taken!", 2600)
		else
			Notify("Evidence Missing!", 2600)
		end
	elseif Data.type == "ballistics" then
		if not EvidenceTaken[Data.id] then
			table.insert(ChosenEvidence.Ballistics, Data)
			TriggerServerEvent("Locker.Take", Data)
			Notify("Evidence Taken!", 2600)
		else
			Notify("Evidence Missing!", 2600)
		end
	elseif Data.type == "firearms" then
		if not EvidenceTaken[Data.id] then
			table.insert(Collected_Firearms, Data)
			TriggerServerEvent("Locker.Take", Data)
			Notify("Evidence Taken!", 2600)
		else
			Notify("Evidence Missing!", 2600)
		end
	elseif Data.type == "cds" then
		if not EvidenceTaken[Data.id] then
			table.insert(ChosenEvidence.CDS, Data)
			TriggerServerEvent("Locker.Take", Data)
			Notify("Evidence Taken!", 2600)
		else
			Notify("Evidence Missing!", 2600)
		end
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
		Chat_Message("Results", "This bullet matches data from a weapon in the Los Santos Ballistics Database. Serial Number: "..serialnumber, 255, 0, 0, true)
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

RegisterNetEvent("Locker.TakeOutEvidence")
AddEventHandler("Locker.TakeOutEvidence", function(Data)
	EvidenceTaken[Data.id] = true
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

function RemoveFromCollected(Data)
	if Data.type == "fingerprints" then
		for Index = 1, #Collected_Fingerprints do
			if Data.player == Collected_Fingerprints[Index].player and Data.licenseplate == Collected_Fingerprints[Index].licenseplate then
				table.remove(Collected_Fingerprints, Index)
			end
		end
	elseif Data.type == "ballistics" then
		for Index = 1, #Collected_BulletCasings do
			if Data.player == Collected_BulletCasings[Index].player and Data.weaponused == Collected_BulletCasings[Index].weaponused then
				table.remove(Collected_BulletCasings, Index)
			end
		end
	elseif Data.type == "firearms" then
		for Index = 1, #Collected_Firearms do
			if Data.CharactersName == Collected_Firearms[Index].CharactersName then
				 for IndexTwo = 1, #Collected_Firearms[Index][IndexTwo] do
					if Collected_Firearms[Index][IndexTwo].model == Data.model then
						table.remove(Collected_Firearms[Index][IndexTwo], IndexTwo)
					end
					if #Collected_Firearms[Index] < 1 then
						table.remove(Collected_Firearms[Index], Index)
					end
				 end
			end
		end
	elseif Data.type == "cds" then
		for Index = 1, #Collected_Inventory do
			if Data.CharactersName == Collected_Inventory[Index].CharactersName then
				for IndexTwo = 1, #Collected_Inventory[Index][IndexTwo] do
				   if Collected_Inventory[Index][IndexTwo].name == Data.name and Collected_Inventory[Index][IndexTwo].quantity == Data.quantity then
					   table.remove(Collected_Inventory[Index][IndexTwo], IndexTwo)
				   end
				   if #Collected_Inventory[Index] < 1 then
					   table.remove(Collected_Inventory[Index], Index)
				   end
				end
		   end
		end
	end
end

local function Draw3DText(x,y,z, text, _size) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        local size = _size or 0.3
        SetTextScale(0.0*scale, size*scale)
        SetTextFont(6)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	local HasWeapon, CurrentWeapon = nil, nil
	while true do
		Citizen.Wait(0)
		local Ped = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Ped, false)
		if IsPedShooting(Ped) and IsPedAPlayer(Ped) then
			HasWeapon, CurrentWeapon = GetCurrentPedWeapon(Ped, 1)
			if CurrentWeapon ~= nil then
				local WeaponString = Weaponhashes[CurrentWeapon] or Weaponhashes[tostring(CurrentWeapon)]
				if WeaponString then
					local WeaponHash = GetHashKey(WeaponString)
					if GetAmmoInPedWeapon(Ped, WeaponHash) > 0 then
						if not BulletCasingNearBy(PlayerPosition) then
							local Street, Crossing = GetStreetNameAtCoord(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
							local BulletCasing = {
								player = GetPlayerServerId(PlayerId()),
								weaponused = Weaponhashes[tostring(GetSelectedPedWeapon(Ped))],
								location = GetStreetNameFromHashKey(Street),
								coords = vector3(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z),
								serialnumber = 0,
								type = "ballistics"
							}
							table.insert(ClientBulletCasings, PlayerPosition)
							TriggerServerEvent('Forensics.Sync', BulletCasing, "bulletcasing")
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
		local Ped = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Ped, false)
		if IsPedGettingIntoAVehicle(Ped) and GetPedDrawableVariation(Ped, 3) < 16 then
			local Vehicle = GetVehiclePedIsTryingToEnter(Ped)
			local VehicleLicensePlate = GetVehicleNumberPlateText(Vehicle)
			if IsFingerPrintInCar(VehicleLicensePlate) == false then
				local Street, Crossing = GetStreetNameAtCoord(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
				local Fingerprint = {
					player = GetPlayerServerId(PlayerId()),
					licenseplate = VehicleLicensePlate,
					type = "fingerprints"
				}
				table.insert(ClientFingerPrints, VehicleLicensePlate)
				TriggerServerEvent('Forensics.Sync', Fingerprint, "fingerprint")
				Citizen.Wait(5000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isInService then
			local Ped = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Ped, false)
			local HasWeapon, WeaponInHand = GetCurrentPedWeapon(Ped, 1)
			if WeaponInHand ~= nil then
				if WeaponInHand == GetHashKey("WEAPON_FLASHLIGHT") then
					if IsPlayerFreeAiming(PlayerId()) then
						if #UnCollected_BulletCasings > 0 then
							for Index = 1, #UnCollected_BulletCasings do
								if #(PlayerPosition - UnCollected_BulletCasings[Index].coords) < 5 then
									DrawMarker(28, UnCollected_BulletCasings[Index].coords.x, UnCollected_BulletCasings[Index].coords.y, UnCollected_BulletCasings[Index].coords.z-1.0, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.1, 255, 239, 0, 11, 0, 0, 2, 0, 0, 0, 0)
									if #(PlayerPosition - UnCollected_BulletCasings[Index].coords) < 3 then
										Draw3DText(UnCollected_BulletCasings[Index].coords.x, UnCollected_BulletCasings[Index].coords.y, UnCollected_BulletCasings[Index].coords.z-1.0, "Bullet Casing", 0.20)
										if #(PlayerPosition - UnCollected_BulletCasings[Index].coords) < 1 then
											DisplayHelpText("Press ~INPUT_CONTEXT~ to collect bullet casing!")
											if IsControlJustPressed(1,51) then
												TriggerServerEvent('Forensics.PickUp.Evidence', UnCollected_BulletCasings[Index] ,"bulletcasing", 0)
												UnCollected_BulletCasings[Index].coords = 0
												table.insert(Collected_BulletCasings, UnCollected_BulletCasings[Index])
												Notify("You have picked up evidence!", 2900)
												Citizen.Wait(5000)
											end
										end
									end
								end
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
					if #(PlayerPosition - UnCollected_BulletCasings[Index].coords) < 5 then
						DrawMarker(25, UnCollected_BulletCasings[Index].coords.x, UnCollected_BulletCasings[Index].coords.y, UnCollected_BulletCasings[Index].coords.z-1.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
						if #(PlayerPosition - UnCollected_BulletCasings[Index].coords) < 1 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to destroy evidence!")
							if IsControlJustPressed(1,51) then
								Notify("You are currently destroying evidence!")
								Citizen.Wait(60000)
								if #(PlayerPosition - UnCollected_BulletCasings[Index].coords) < 2 then
									Notify("You have destroyed the evidence!", 2900)
									TriggerServerEvent('Forensics.PickUp.Evidence', UnCollected_BulletCasings[Index] ,"destroyevidence", 0)
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
					if #ChosenEvidence.Ballistics == 0 then
						Chat_Message("Evidence Locker", "^0Is empty!")
					else
						if #ChosenEvidence.Ballistics == 1 and ChosenEvidence.Ballistics[1] ~= nil then
							Notify("Examining Ballistics Evidence...", 10000)
							Citizen.Wait(10000)
							local Probability = math.random(1, 100)
							if Probability > 25 then
								TriggerServerEvent('Forensics.BulletCasing.Information', "WeaponName", ChosenEvidence.Ballistics[1])
								TriggerServerEvent('Locker.PutBackEvidence', ChosenEvidence.Ballistics[1])
								table.remove(ChosenEvidence.Ballistics, 1)
							else
								TriggerServerEvent('Forensics.BulletCasing.Information', "serialnumber", ChosenEvidence.Ballistics[1])
								TriggerServerEvent('Locker.PutBackEvidence', ChosenEvidence.Ballistics[1])
								table.remove(ChosenEvidence.Ballistics, 1)
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
					if #ChosenEvidence.Fingerprints == 0 then
						Chat_Message("Evidence Locker", "^0Is empty!")
					else
						Notify("Examining Fingerprint, Cross referencing with Los Santos Criminal Database", 60000)
						Citizen.Wait(60000)
						if #ChosenEvidence.Fingerprints == 1 and ChosenEvidence.Fingerprints[1].player ~= nil then
							TriggerServerEvent("Forensics.RunPrint", ChosenEvidence.Fingerprints[1].player)
							TriggerServerEvent('Locker.PutBackEvidence', ChosenEvidence.Fingerprints[1])
							table.remove(ChosenEvidence.Fingerprints, 1)
						end
					end
				end
			end
		end
	end
end)

local ClientEvidence = {
	["Ballistics"] = {},
	["Fingerprints"] = {},
}

local Evidence = {
	["Ballistics"] = {},
	["Fingerprints"] = {},
}

local Seats = {
	[-1] = "Driver",
	[0] = "Passanger",
	[1] = "Back Left",
	[2] = "Back Right",
	[3] = "Back Space",
	[4] = "Super Back Space",
}

local CollectedEvidence = {
	["Ballistics"] = {}
	["Fingerprints"] = {},
	["Firearms"] = {},
	["Items"] = {},
}

function DoesFingerprintExist(LicensePlate)
	local Vehicle = ClientEvidence["Fingerprints"][LicensePlate]
	if #Vehicle > 0 then
		for Index = 1, #Vehicle do
			if Vehicle[Index].Player == GetPlayerServerId(PlayerId()) then
				return true
			end
		end
	else
		return false
	end
	return false
end

function DoBulletCasingsExist(AreaHash, PlayerPosition)
	local BulletCasings = ClientEvidence["Ballistics"][AreaHash]
	if #BulletCasings > 0 then
		for Index = 1, #BulletCasings do
			if BulletCasings[Index] == GetPlayerServerId(PlayerId()) then
				if #(PlayerPosition - BulletCasings[Index].Coords) <= 11.0 then
					return true
				end
			end
		end
	else
		return false
	end
	return false
end

RegisterNetEvent("Inventory.Police.Evidence")
RegisterNetEvent("Forensics.Store")
RegisterNetEvent("Forensics.Fingerprints")
RegisterNetEvent("Forensics.Ballistics")
RegisterNetEvent("Forensics.Firearms")
RegisterNetEvent("Forensics.Items")
RegisterNetEvent("Forensics.Options")
RegisterNetEvent("Forensics.SubOptions")
RegisterNetEvent("Forensics.Store")
RegisterNetEvent("Forensics.Give")
RegisterNetEvent("Forensics.Destroy")

RegisterNetEvent("Forensics.Sync.Uncollected.Evidence")
AddEventHandler("Forensics.Sync.Uncollected.Evidence", function(NewEvidence)
	Evidence = NewEvidence
end)

AddEventHandler("inventory:police_evidence", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Fingerprints", [[TriggerEvent("Forensics.Fingerprints")]])
    exports.ui:addOption("Ballistics", [[TriggerEvent('Forensics.Ballistics')]])
    exports.ui:addOption("Firearms", [[TriggerEvent('Forensics.Firearms')]])
    exports.ui:addOption("Items", [[TriggerEvent('Forensics.Items')]])
    exports.ui:back([[TriggerEvent("inventory:open")]])
end)

AddEventHandler("Forensics.Fingerprints", function()
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #CollectedEvidence["Fingerprints"] do
		exports.ui:addOption(CollectedEvidence["Fingerprints"][Index].LicensePlate.." - "..CollectedEvidence["Fingerprints"][Index].Seat, [[TriggerEvent("Forensics.Options")]], CollectedEvidence["Fingerprints"][Index])
	end
end)

AddEventHandler("Forensics.Ballistics", function()
	exports.ui:reset()
	exports.ui:open()
	for Index = 1, #CollectedEvidence["Ballistics"] do
		exports.ui:addOption(CollectedEvidence["Ballistics"][Index].Label, [[TriggerEvent("Forensics.Options")]], CollectedEvidence["Ballistics"][Index])
	end
end)

AddEventHandler("Forensics.Firearms", function()
	exports.ui:reset()
	exports.ui:open()
	for Key, Value in pairs(CollectedEvidence["Firearms"]) do
		exports.ui:addOption(Value.CharactersName, [[TriggerEvent("Forensics.SubOptions")]], Value)
	end
end)

AddEventHandler("Forensics.Items", function()
	exports.ui:reset()
	exports.ui:open()
	for Key, Value in pairs(CollectedEvidence["Items"]) do
		exports.ui:addOption(Value.CharactersName, [[TriggerEvent("Forensics.SubOptions")]], Value)
	end
end)

AddEventHandler("Forensics.Options", function(Data)
	exports.ui:reset()
    exports.ui:open()
	exports.ui:addOption("Store", [[TriggerEvent("Forensics.Store")]], Data)
	exports.ui:addOption("Give", [[TriggerEvent("Forensics.Give")]], Data)
	exports.ui:addOption("Destroy", [[TriggerEvent("Forensics.Destroy"]], Data)
	exports.ui:back([[TriggerEvent("inventory:police_evidence")]])
end)

AddEventHandler("Forensics.SubOptions", function(Data)
	for Index = 1, #Data do
		if Data[Index].Type = "Firearms" then
			exports.ui:addOption(WeaponNames[Data[Index].model], [[TriggerEvent("Forensics.Options")]], Data[Index])
		elseif Data[Index].Type == "Items" then
			exports.ui:addOption("["..Data[Index].quantity.."]"..Data[Index].name, [[TriggerEvent("Forensics.Options")]], Data[Index])
		end
	end
end

AddEventHandler("Forensics.Store", function(Data)
	local Player = PlayerPedId()
	local PlayerPosition = GetEntityCoords(Player, false)
	if #(PlayerPosition - Data.EvidenceLocker) <= 1.1 then
		TriggerServerEvent("Forensics.Store.Evidence", Data)
	else
		Notify("You must be near the Evidence Locker!")
	end
end)

AddEventHandler("Forensics.Give", function(Data)
	local Target, Distance = GetClosestPlayer()
	if(Distance ~= -1 and Distance < 3) then
		TriggerServerEvent("Forensics.Give", Target, Data)
	end
end)

AddEventHandler("Forensics.Destroy", function(Data)
	if Data.Type == "Ballistics" then
		for Index = 1, #CollectedEvidence[Data.Type] do
			if CollectedEvidence[Data.Type][Index].AreaHash and == Data.AreaHash and CollectedEvidence[Data.Type][Index].Model == Data.Model and CollectedEvidence[Data.Type][Index].Coords.x == Data.Coords.x then
				table.remove(CollectedEvidence[Data.Type][Index], Index)
			end
		end
	elseif Data.Type == "Fingerprints" then 
		for Index = 1, #CollectedEvidence[Data.Type] do
			if CollectedEvidence[Data.Type][Index].LicensePlate == Data.LicensePlate and CollectedEvidence[Data.Type][Index].Seat == Data.Seat and CollectedEvidence[Data.Type][Index].Player == Data.Player then
				table.remove(CollectedEvidence[Data.Type][Index], Index)
			end
		end
	elseif Data.Type == "Firearms" then
		for Key, Value in pairs(CollectedEvidence[Data.Type]) do
			for Index = 1, #Value do
				if Value[Index].id == Data.id and Value[Index].CharactersName == Data.CharactersName then
					table.remove(Value[Index], Index)
				end
			end
		end
	elseif Data.Type == "Items" then
		for Key, Value in pairs(CollectedEvidence[Data.Type]) do
			for Index = 1, #Value do
				if Value.item_id == Data.item_id and Value.CharactersName == Data.CharactersName then
					table.remove(Value[Index], Index)
				end
			end
		end
	end
end)

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
                        local AreaHash = GetHashOfMapAreaAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
						if AreaHash ~= nil then
							if not DoBulletCasingsExist(AreaHash, PlayerPosition) then
								local BulletCasing = {
									Player = GetPlayerServerId(PlayerId()),
									Coords = PlayerPosition,
									AreaHash = AreaHash,
									Weapon = WeaponString,
									SerialNumber = 0,
									Type = "Ballistics",
									Label = ""
								}
								ClientEvidence["Ballistics"][AreaHash] = {}
								table.insert(ClientEvidence["Ballistics"][AreaHash], BulletCasing)
                            	TriggerServerEvent("Forensics.Add.Uncollected.Evidence", BulletCasing)
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
		local Ped = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Ped, false)
		if IsPedGettingIntoAVehicle(Ped) and GetPedDrawableVariation(Ped, 3) < 16 then
			local Vehicle = GetVehiclePedIsTryingToEnter(Ped)
			local VehicleLicensePlate = GetVehicleNumberPlateText(Vehicle)
			local PlayerSeat = GetSeatPedIsTryingToEnter(Ped)
				if not DoesFingerprintExist(VehicleLicensePlate) then
					local Fingerprint = {
						Seat = Seats[PlayerSeat],
						CharacterID = GetPlayerServerId(PlayerId()),
						Player = GetPlayerServerId(PlayerId()),
						LicensePlate = VehicleLicensePlate,
						Type = "Fingerprints"
					}
					ClientEvidence["Fingerprints"][VehicleLicensePlate] = {}
					table.insert(ClientEvidence["Fingerprints"][VehicleLicensePlate], Fingerprint)
					TriggerServerEvent('Forensics.Add.Uncollected.Evidence', Fingerprint)
					Citizen.Wait(5000)
				end
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
						local AreaHash = GetHashOfMapAreaAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
						if Evidence["Ballistics"][AreaHash] ~= nil then
							for Index = 1, #Evidence["Ballistics"][AreaHash] do
								if #(PlayerPosition - Evidence["Ballistics"][AreaHash][Index].coords) < 5 then
									DrawMarker(28, Evidence["Ballistics"][AreaHash][Index].coords.x, Evidence["Ballistics"][AreaHash][Index].coords.y, Evidence["Ballistics"][AreaHash][Index].coords.z-1.0, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.1, 255, 239, 0, 42, 0, 0, 2, 0, 0, 0, 0)
									if #(PlayerPosition - Evidence["Ballistics"][AreaHash][Index].coords) < 3 then
										Draw3DText(Evidence["Ballistics"][AreaHash][Index].coords.x, Evidence["Ballistics"][AreaHash][Index].coords.y, Evidence["Ballistics"][AreaHash][Index].coords.z-1.0, "Bullet Casing", 0.20)
										if #(PlayerPosition - Evidence["Ballistics"][AreaHash][Index].coords) < 1 then
											DisplayHelpText("Press ~INPUT_CONTEXT~ to collect bullet casing!")
											if IsControlJustPressed(1,51) then
												TriggerServerEvent('Forensics.PickUp.Evidence', Evidence["Ballistics"][AreaHash][Index] ,"bulletcasing", 0)
												Evidence["Ballistics"][AreaHash][Index].coords = 0
												table.insert(Collected_BulletCasings, Evidence["Ballistics"][AreaHash][Index])
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
			local AreaHash = GetHashOfMapAreaAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
			if #Evidence["Ballistics"][AreaHash] > 0 then
				for Index = 1, #Evidence["Ballistics"][AreaHash] do
					if #(PlayerPosition - Evidence["Ballistics"][AreaHash][Index].coords) < 5 then
						DrawMarker(25, Evidence["Ballistics"][AreaHash][Index].coords.x, Evidence["Ballistics"][AreaHash][Index].coords.y, Evidence["Ballistics"][AreaHash][Index].coords.z-1.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
						if #(PlayerPosition - Evidence["Ballistics"][AreaHash][Index].coords) < 1 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to destroy evidence!")
							if IsControlJustPressed(1,51) then
								Notify("You are currently destroying evidence!")
								Citizen.Wait(60000)
								if #(PlayerPosition - Evidence["Ballistics"][AreaHash][Index].coords) < 2 then
									Notify("You have destroyed the evidence!", 2900)
									TriggerServerEvent('Forensics.PickUp.Evidence', Evidence["Ballistics"][AreaHash][Index] ,"destroyevidence", 0)
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
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(PlayerPosition - Data.EvidenceLocker) <= 1.1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open Evidence Locker!")
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("Forensics.Open.Evidence.Locker")
				end
			end
		end
	end
end)
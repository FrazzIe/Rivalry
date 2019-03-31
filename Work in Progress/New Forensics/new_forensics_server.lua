local Collected_Fingerprints = {}
local Collected_BulletCasings = {}
local UnCollected_Fingerprints = {}
local UnCollected_BulletCasings = {}

--[[function DoesBulletCasingExist(Evidence)
	for Index = 1, #UnCollected_BulletCasings do
		if UnCollected_BulletCasings[Index].Player == Evidence.Player and #(Evidence.Coords - UnCollected_BulletCasings[Index].Coords) < 20 then
			return true
		end
	end
	return false
end

function DoesFingerPrintExist(Evidence)
	for Index = 1, #UnCollected_Fingerprints do
		if UnCollected_Fingerprints[Index].Player == Evidence.Player and UnCollected_Fingerprints[Index].Vehicle == Evidence.Vehicle then
			return true
		end
	end
	return false
end--]]

function RemoveBulletCasing(Evidence)
	for k, v in pairs(UnCollected_BulletCasings) do
		if v.Player == Evidence.Player and v.Location == Evidence.Location and v.Coords == Evidence.Coords and v.Weapon == Evidence.Weapon then
			table.remove(UnCollected_BulletCasings, k)
			TriggerClientEvent('Forensics.Sync', -1, "UnCollectedBulletCasing", UnCollected_BulletCasings)
			TriggerClientEvent('Forensics.Sync', -1, "CollectedBulletCasing", Collected_BulletCasings)
		end
	end
end

function RemoveFingerPrint(Index)
	table.remove(UnCollected_Fingerprints, Index)
	TriggerClientEvent('Forensics.Sync', -1, "UnCollectedFingerprints", UnCollected_Fingerprints)
	TriggerClientEvent('Forensics.Sync', -1, "CollectedFingerprints", Collected_Fingerprints)
end

RegisterServerEvent('Forensics.Sync')
AddEventHandler('Forensics.Sync', function(Evidence, Type)
	local Source = source
	if Type == "BulletCasing" then
		table.insert(UnCollected_BulletCasings, Evidence)
		TriggerClientEvent('Forensics.Sync', -1 ,"UnCollectedBulletCasing", UnCollected_BulletCasings)
	elseif Type == "FingerPrint" then
		table.insert(UnCollected_Fingerprints, Evidence)
		TriggerClientEvent('Forensics.Sync', -1, "UnCollectedFingerprints", UnCollected_Fingerprints)
	end
end)

RegisterServerEvent('Forensics.PickUp.Evidence')
AddEventHandler('Forensics.PickUp.Evidence', function(Evidence, Type, Index)
	local Source = source
	if Type == "BulletCasing" then
		table.insert(Collected_BulletCasings, Evidence)
		RemoveBulletCasing(Evidence)
	elseif Type == "FingerPrint" then
		table.insert(Collected_Fingerprints, Evidence)
		RemoveFingerPrint(Index)
	end
end)

RegisterServerEvent('Police.Swab.Vehicle')
AddEventHandler('Police.Swab.Vehicle', function(Plate)
	local Fingerprints = {}
	for Index = 1, #UnCollected_Fingerprints do
		if UnCollected_Fingerprints[Index].LicensePlate == Plate then
			table.insert(Fingerprints, Plate)
			TriggerEvent('Forensics.PickUp.Evidence', UnCollected_Fingerprints[Index], "FingerPrint", Index)
		end
	end
	TriggerClientEvent("chatMessage", source, "Evidence", {16, 102, 158}, "You have found " .. tostring(#Fingerprints .. " Fingerprints"))
end)

RegisterServerEvent('Forensics.BulletCasing.Information')
AddEventHandler('Forensics.BulletCasing.Information', function(Type, Gun, Player)
	local Source = source
	local Id = nil
	if Type == "WeaponName" then
		TriggerClientEvent('Forensics.WeaponName.Return', Source, Weapons_names[Gun])
	elseif Type == "SerialNumber" then
		TriggerEvent("weapon:getuser", Player, function(_Weapon)
			for Index = 1, #_Weapon do
				Id = _Weapon[Index].id
			end
		end)
		TriggerClientEvent('Forensics.BulletCasing.Return', Source, Id)
	end
end)

RegisterServerEvent('Forensics.RunPrint')
AddEventHandler('Forensics.RunPrint', function(Player)
	local Source = source
	local CharacterID, FirstName, LastName = 0, "", ""
	local Name = ""
	TriggerEvent("core:getuser", Player, function(User)
		CharacterID = User.get("characterID")
		FirstName = User.get("first_name")
		LastName = User.get("last_name")
		Name = FirstName.." "..LastName
	end)
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_arrests WHERE offender_name=@offender_name", {["@offender_name"] = Name}, function(Result)
		if (#Result > 0) then
			TriggerClientEvent('Forensics.FingerPrint.Result', Source, "sucess", Name)
		else
			TriggerClientEvent('Forensics.FingerPrint.Result', Source, "nomatch", Name)
		end
	end)
end)

RegisterServerEvent("Forensics.List.Evidence")
AddEventHandler("Forensics.List.Evidence", function(Type)
	local Source = source
	if Type == "BulletCasings" then
		TriggerClientEvent("chatMessage", Source, "", {16, 102, 158}, "Forensics Evidence(Ballistics):")
		for Index = 1, #Collected_BulletCasings do
			TriggerClientEvent("chatMessage", Source, "Evidence", {16, 102, 158}, "["..Index.."] - "..Collected_BulletCasings[Index].Location)
		end
	elseif Type == "FingerPrints" then
		TriggerClientEvent("chatMessage", Source, "", {16, 108, 158}, "Forensics Evidence(Fingerprints):")
		for Index = 1, #Collected_Fingerprints do
			TriggerClientEvent("chatMessage", Source, "Evidence", {16, 102, 158}, "["..Index.."] - "..Collected_Fingerprints[Index].LicensePlate)
		end
	end
end)

RegisterServerEvent("Forensics.Remove.Evidence")
AddEventHandler("Forensics.Remove.Evidence", function(Type, Index)
	local Source = source
	if Type == "BulletCasings" then
		if Collected_BulletCasings[Index] ~= nil then
			table.remove(Collected_BulletCasings, Index)
			TriggerClientEvent('Forensics.Sync', -1, "CollectedBulletCasing", Collected_BulletCasings)
			TriggerClientEvent("chatMessage", Source, "Evidence" , {16, 102, 158}, "Evidence Removed!")
		end
	elseif Type == "FingerPrints" then
		if Collected_Fingerprints[Index] ~= nil then
			table.remove(Collected_Fingerprints, Index)
			TriggerClientEvent('Forensics.Sync', -1, "CollectedFingerprints", Collected_Fingerprints)
			TriggerClientEvent("chatMessage", Source, "Evidence", {16, 102, 158}, "Evidence Removed!")
		end
	end
end)
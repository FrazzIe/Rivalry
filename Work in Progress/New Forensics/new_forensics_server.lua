local Collected_Fingerprints = {}
local Collected_BulletCasing = {}
local UnCollected_Fingerprints = {}
local UnCollected_BulletCasings = {}

function DoesBulletCasingExist(Evidence)
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
end

function RemoveBulletCasing(Evidence)
	for k, v in pairs(UnCollected_BulletCasings) do
		if v.Player == Evidence.Player and v.Location == Evidence.Location and v.Coords == Evidence.Coords and v.Weapon == Evidence.Weapon then
			table.remove(UnCollected_BulletCasings, k)
			TriggerClientEvent('Forensics.Sync', "UnCollectedBulletCasing", UnCollected_BulletCasings)
			TriggerClientEvent('Forensics.Sync', "CollectedBulletCasing", Collected_BulletCasing)
		end
	end
end

function RemoveFingerPrint(Index)
	if UnCollected_Fingerprints[Index].Player == Evidence.Player and UnCollected_Fingerprints[Index].Vehicle == Evidence.Vehicle then
		table.remove(UnCollected_Fingerprints, k)
		TriggerClientEvent('Forneiscs.Sync', "UnCollectedFingerprints", UnCollected_Fingerprints)
		TriggerClientEvent('Forneiscs.Sync', "CollectedFingerprints", Collected_Fingerprints)
	end
end

RegisterServerEvent('Forensics.Sync')
AddEventHandler('Forensics.Sync', function(Evidence, Type)
	local Source = source
	if Type == "BulletCasing" then
		if not DoesBulletCasingExist(Evidence) then
			table.insert(UnCollected_BulletCasings, Evidence)
			TriggerClientEvent('Forensics.Sync', "UnCollectedBulletCasing", UnCollected_BulletCasings)
		end
	elseif Type == "FingerPrint" then
		if not DoesFingerPrintExist(Evidence) then
			table.insert(UnCollected_Fingerprints, Evidence)
			TriggerClientEvent('Forneiscs.Sync', "UnCollectedFingerprints", UnCollected_Fingerprints)
		end
	end
end)

RegisterServerEvent('Forensics.PickUp.Evidence')
AddEventHandler('Forensics.PickUp.Evidence', function(Evidence, Type, Index)
	local Source = source
	if Type == "BulletCasing" then
		table.insert(Collected_BulletCasing, Evidence)
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
		if UnCollected_Fingerprints[Index].Vehicle == Plate then
			table.insert(Fingerprints, UnCollected_Fingerprints[Index].Player)
			TriggerEvent('Forensics.PickUp.Evidence', Index, UnCollected_Fingerprints[Index], "FingerPrint")
		end
	end
	TriggerClientEvent("chatMessage", source, "Evidence", {16, 102, 158}, "You have found " .. tostring(#Fingerprints .. "Fingerprints"))
end)
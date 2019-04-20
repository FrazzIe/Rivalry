local UnCollected_Fingerprints = {}
local UnCollected_BulletCasings = {}

function RemoveBulletCasing(Evidence)
	for k, v in pairs(UnCollected_BulletCasings) do
		if v.player == Evidence.player and v.location == Evidence.location and v.coords == Evidence.coords and v.weapon == Evidence.weapon then
			table.remove(UnCollected_BulletCasings, k)
			TriggerClientEvent('Forensics.Sync', -1, "UnCollectedBulletCasing", UnCollected_BulletCasings)
		end
	end
end

function RemoveFingerPrint(Index)
	table.remove(UnCollected_Fingerprints, Index)
	TriggerClientEvent('Forensics.Sync', -1, "UnCollectedFingerprints", UnCollected_Fingerprints)
end

RegisterServerEvent('Forensics.Delete.Evidence')
AddEventHandler('Forensics.Delete.Evidence', function(Index)
	local Source = source
	if UnCollected_BulletCasings[Index] ~= nil then
		table.remove(UnCollected_BulletCasings, Index)
		TriggerClientEvent('Forensics.Sync', -1, "UnCollectedFingerPrints", UnCollected_Fingerprints)
	end
end)

RegisterServerEvent('Forensics.Bleach.Vehicle')
AddEventHandler("Forensics.Bleach.Vehicle", function(Plate)
	local Source = source
	if Plate then
		for Index = 1, #UnCollected_Fingerprints do
			if UnCollected_Fingerprints[Index].licenseplate == Plate then
				table.remove(UnCollected_Fingerprints, Index)
			end
		end
	end
end)

RegisterServerEvent('Forensics.Sync')
AddEventHandler('Forensics.Sync', function(Evidence, Type)
	local Source = source
	if Type == "bulletcasing" then
		TriggerEvent("core:getuser", Evidence.player, function(User)
			Evidence.player = User.get("characterID")
			exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from weapons WHERE character_id=@character_id", {["@character_id"] = Evidence.player}, function(Weapon)
				Evidence.serialnumber = Weapon.id
			end)
		end)
		table.insert(UnCollected_BulletCasings, Evidence)
		TriggerClientEvent('Forensics.Sync', -1 ,"UnCollectedBulletCasing", UnCollected_BulletCasings)
	elseif Type == "fingerprint" then
		TriggerEvent("core:getuser", Evidence.player, function(User)
			Evidence.player = User.get("characterID")
		end)
		table.insert(UnCollected_Fingerprints, Evidence)
		TriggerClientEvent('Forensics.Sync', -1, "UnCollectedFingerprints", UnCollected_Fingerprints)
	end
end)

RegisterServerEvent('Forensics.PickUp.Evidence')
AddEventHandler('Forensics.PickUp.Evidence', function(Evidence, Type, Index)
	local Source = source
	if Type == "bulletcasing" then
		RemoveBulletCasing(Evidence)
	elseif Type == "fingerprint" then
		RemoveFingerPrint(Index)
	elseif Type == "DestroyEvidence" then
		RemoveBulletCasing(Evidence)
	end
end)

RegisterServerEvent('Police.Swab.Vehicle')
AddEventHandler('Police.Swab.Vehicle', function(Plate)
	local Source = source
	local Fingerprints = {}
	for Index = 1, #UnCollected_Fingerprints do
		if UnCollected_Fingerprints[Index] ~= nil then
			if UnCollected_Fingerprints[Index].licenseplate == Plate then
				TriggerClientEvent("Forensics.Vehicle.Swabs", Source, UnCollected_Fingerprints[Index])
				table.insert(Fingerprints, "Found")
				TriggerEvent('Forensics.PickUp.Evidence', UnCollected_Fingerprints[Index], "fingerprint", Index)
			end
		end
	end
	TriggerClientEvent("chatMessage", source, "Evidence", {16, 102, 158}, "You have found " .. tostring(#Fingerprints .. " Fingerprints"))
end)

RegisterServerEvent('Forensics.BulletCasing.Information')
AddEventHandler('Forensics.BulletCasing.Information', function(Type, Evidence)
	local Source = source
	if Type == "WeaponName" then
		TriggerClientEvent('Forensics.WeaponName.Return', Source, Weapon_names[Evidence.weaponused])
	elseif Type == "serialnumber" then
		TriggerClientEvent('Forensics.BulletCasing.Return', Source, Evidence.serialnumber)
	end
end)

RegisterServerEvent('Forensics.RunPrint')
AddEventHandler('Forensics.RunPrint', function(Player)
	local Source = source
	exports['GHMattiMySql']:QueryResultAsync("SELECT * FROM characters WHERE character_id=character_id", {["character_id"] = Player}, function(Character)
		local Name = Character.first_name.." "..Character.last_name
		exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_arrests WHERE offender_name=@offender_name", {["@offender_name"] = Name}, function(Result)
			if (#Result > 0) then
				TriggerClientEvent('Forensics.FingerPrint.Result', Source, "sucess", Name)
			else
				TriggerClientEvent('Forensics.FingerPrint.Result', Source, "nomatch", Name)
			end
		end)
	end)
end)

RegisterServerEvent("Forensics.Store")
AddEventHandler("Forensics.Store", function(Data, Description, Which)
	local Source = source
	if Which == "CDS" then
		exports['GHMattiMySQL']:QueryResult("INSERT INTO police_evidence_cds (`name`,`quantity`,`item_id`,`description`) VALUES (@name,@quantity,@item_id,@description);", { 
	        ['@name'] = Data.name,
	        ['@quantity'] = Data.quantity,
	        ['@item_id'] = Data.item_id,
	        ['@description'] = Description,
	    })
	elseif Which == "Firearm" then
		exports['GHMattiMySQL']:QueryResult("INSERT INTO police_evidence_firearms (`id`, `character_id`, `sellprice`, `model`, `ammo`, `suppressor`, `flashlight`, `extended_clip`, `scope`, `grip`, `advanced_scope`, `skin`, `owner`, `description`) VALUES (@id, @character_id, @sellprice, @model, @ammo, @suppressor, @flashlight, @extended_clip, @scope, @grip, @advanced_scope, @skin, @owner, @description);", { 
	        ['@id'] = Data.id,
	        ['@character_id'] = Data.character_id,
	        ['@sellprice'] = Data.sellprice,
	        ['@model'] = Data.model,
	        ['@ammo'] = Data.ammo,
	        ['@suppressor'] = Data.suppressor,
	        ['@flashlight'] = Data.flashlight,
	        ['@extended_clip'] = Data.extended_clip,
	        ['@scope'] = Data.scope,
	        ['@grip'] = Data.grip,
	        ['@advanced_scope'] = Data.advanced_scope,
	        ['@skin'] = Data.skin,
	        ['@owner'] = Data.owner,
	        ['@description'] = Description,
	    })
	    exports["GHMattiMySQL"]:QueryAsync("DELETE FROM weapons WHERE (character_id=@character_id) AND (model=@model)", {
			["@character_id"] = Data.character_id,
			["@model"] = Data.model,
			['@description'] = Description,
		})
	elseif Which == "Fingerprint" then
		exports['GHMattiMySQL']:QueryResult("INSERT INTO police_evidence_fingerprints (`player`,`licenseplate`,`description`) VALUES (@player,@licenseplate,@description);", { 
	        ['@player'] = Data.player,
	        ['@licenseplate'] = Data.licenseplate,
	        ['@description'] = Description,
	    })
	elseif Which == "BulletCasing" then
		exports['GHMattiMySQL']:QueryResult("INSERT INTO police_evidence_ballistics (`player`, `weaponused`, `location`, `serialnumber`, `description`) VALUES (@player, @weaponused, @location, @serialnumber, @description);", { 
	        ['@player'] = Data.player,
	        ['@weaponused'] = Data.weaponused,
	        ['@location'] = Data.location,
	        ['@serialnumber'] = Data.serialnumber,
	        ['@description'] = Description,
	    })
	end
end)

RegisterServerEvent("Retrieve.Fingerprints")
RegisterServerEvent("Retrieve.Ballistics")
RegisterServerEvent("Retrieve.Firearms")
RegisterServerEvent("Retrieve.Controlled.Substances")

AddEventHandler("Retrieve.Fingerprints", function()
	local Source = source
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_evidence_fingerprints", {}, function(Fingerprints)
		TriggerClientEvent("Create.Locker.Fingerprints", Source, Fingerprints)
	end)
end)

AddEventHandler("Retrieve.Ballistics", function()
	local Source = source
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_evidence_ballistics", {}, function(Ballistics)
		TriggerClientEvent("Create.Locker.Ballistics", Source, Ballistics)
	end)
end)

AddEventHandler("Retrieve.Firearms", function()
	local Source = source
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_evidence_firearms", {}, function(Firearms)
		TriggerClientEvent("Create.Locker.Firearms", Source, Firearms)
	end)
end)

AddEventHandler("Retrieve.Controlled.Substances", function()
	local Source = source
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM police_evidence_cds", {}, function(ControlledSubstances)
		TriggerClientEvent("Create.Locker.Controlled.Substances", Source, ControlledSubstances)
	end)
end)

RegisterServerEvent("Locker.Destroy")

AddEventHandler("Locker.Destroy", function(Data, Which)
	local Source = source
	if Which == "Fingerprints" then
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM police_evidence_fingerprints WHERE (player=@player) AND (id=@id)", {
			["@id"] = Data.id,
			["@player"] = Data.player,
		})
	elseif Which == "Ballistics" then
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM police_evidence_ballistics WHERE (player=@player) AND (id=@id)", {
			["@id"] = Data.id,
			["@player"] = Data.player,
		})
	elseif Which == "Firearms" then
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM police_evidence_firearms WHERE (character_id=@character_id) AND (model=@model)", {
			["@character_id"] = Data.character_id,
			["@model"] = Data.model,
		})
	elseif Which == "CDS" then
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM police_evidence_cds WHERE (character_id=@character_id) AND (model=@model)", {
			["@item_id"] = Data.item_id,
			["@id"] = Data.id,
			['@quantity'] = quantity,
		})
	end
	TriggerClientEvent("Forensics.Locker", Source)
end)

RegisterServerEvent("Locker.Take")
AddEventHandler("Locker.Take", function(Data)
	if Data.type == "fingerprints" then
		exports["GHMattiMySQL"]:QueryAsync("UPDATE police_evidence_fingerprints SET status=@status WHERE (id=@id)", {["@id"] = Data.id, ["@status"] = 1})
	elseif Data.type == "ballistics" then
		exports["GHMattiMySQL"]:QueryAsync("UPDATE police_evidence_ballistics SET status=@status WHERE (id=@id)", {["@id"] = Data.id, ["@status"] = 1})
	elseif Data.type == "firearms" then
		exports["GHMattiMySQL"]:QueryAsync("UPDATE police_evidence_firearms SET status=@status WHERE (id=@id)", {["@id"] = Data.id, ["@status"] = 1})
	elseif Data.type == "cds" then
		exports["GHMattiMySQL"]:QueryAsync("UPDATE police_evidence_cds SET status=@status WHERE (id=@id)", {["@id"] = Data.id, ["@status"] = 1})
	end
end)

RegisterServerEvent("Locker.PutBackEvidence")
AddEventHandler("Locker.PutBackEvidence", function(Data)
	if Data.type == "fingerprints" then
		exports["GHMattiMySQL"]:QueryAsync("UPDATE police_evidence_fingerprints SET status=@status WHERE (id=@id)", {["@id"] = Data.id, ["@status"] = 0})
	elseif Data.type == "ballistics" then
		exports["GHMattiMySQL"]:QueryAsync("UPDATE police_evidence_ballistics SET status=@status WHERE (id=@id)", {["@id"] = Data.id, ["@status"] = 0})
	elseif Data.type == "firearms" then
		exports["GHMattiMySQL"]:QueryAsync("UPDATE police_evidence_firearms SET status=@status WHERE (id=@id)", {["@id"] = Data.id, ["@status"] = 0})
	elseif Data.type == "cds" then
		exports["GHMattiMySQL"]:QueryAsync("UPDATE police_evidence_cds SET status=@status WHERE (id=@id)", {["@id"] = Data.id, ["@status"] = 0})
	end
end)


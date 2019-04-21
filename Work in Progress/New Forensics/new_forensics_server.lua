local UnCollected_Fingerprints = {}
local UnCollected_BulletCasings = {}

function RemoveBulletCasing(Evidence)
	for k, v in pairs(UnCollected_BulletCasings) do
		if v.player == Evidence.player and v.location == Evidence.location and v.coords == Evidence.coords and v.weapon == Evidence.weapon then
			table.remove(UnCollected_BulletCasings, k)
			TriggerClientEvent('Forensics.Sync', -1, "UnCollectedBulletCasing", UnCollected_BulletCasings)
			TriggerClientEvent('Forensics.RemoveClientBulletCasing', Evidence.player, Evidence)
		end
	end
end

function RemoveFingerPrint(Index)
	table.remove(UnCollected_Fingerprints, Index)
	TriggerClientEvent('Forensics.Sync', -1, "UnCollectedFingerprints", UnCollected_Fingerprints)
	TriggerClientEvent('Forensics.RemoveClientFingerPrint', UnCollected_Fingerprints[Index].player, UnCollected_Fingerprints[Index])
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
	elseif Type == "destroyevidence" then
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
	if Which == "cds" then
		exports['GHMattiMySQL']:QueryResult("INSERT INTO police_evidence_inventory (`name`,`quantity`,`item_id`,`description`) VALUES (@name,@quantity,@item_id,@description);", { 
	        ['@name'] = Data.name,
	        ['@quantity'] = Data.quantity,
	        ['@item_id'] = Data.item_id,
	        ['@description'] = Description,
	    })
	elseif Which == "firearm" then
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
	elseif Which == "fingerprints" then
		exports['GHMattiMySQL']:QueryResult("INSERT INTO police_evidence_fingerprints (`player`,`licenseplate`,`description`) VALUES (@player,@licenseplate,@description);", { 
	        ['@player'] = Data.player,
	        ['@licenseplate'] = Data.licenseplate,
	        ['@description'] = Description,
	    })
	elseif Which == "ballistics" then
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
	exports['GHMattiMySQL']:QueryResultAsync("SELECT police_evidence_fingerprints.id, police_evidence_fingerprints.player, police_evidence_fingerprints.licenseplate, police_evidence_fingerprints.description, police_evidence_fingerprints.type, UNIX_TIMESTAMP(police_evidence_fingerprints.timestamp) AS timestamp, police_evidence_fingerprints.status FROM police_evidence_fingerprints", {}, function(Fingerprints)
		local timestamp = os.date("%A %B %d %Y | %I:%M %p", Fingerprints.timestamp)
		TriggerClientEvent("Create.Locker.Fingerprints", Source, Fingerprints, timestamp)
	end)
end)

AddEventHandler("Retrieve.Ballistics", function()
	local Source = source
	exports['GHMattiMySQL']:QueryResultAsync("SELECT police_evidence_ballistics.id, police_evidence_ballistics.player, police_evidence_ballistics.location, police_evidence_ballistics.serialnumber, police_evidence_ballistics.description, police_evidence_ballistics.type, UNIX_TIMESTAMP(police_evidence_ballistics.timestamp) AS timestamp, police_evidence_ballistics.status FROM police_evidence_ballistics", {}, function(Ballistics)
		local timestamp = os.date("%A %B %d %Y | %I:%M %p", Ballistics.timestamp)
		TriggerClientEvent("Create.Locker.Ballistics", Source, Ballistics, timestamp)
	end)
end)

AddEventHandler("Retrieve.Firearms", function()
	local Source = source
	exports['GHMattiMySQL']:QueryResultAsync("SELECT police_evidence_firearms.id, police_evidence_firearms.character_id, police_evidence_firearms.sellprice, police_evidence_firearms.model, police_evidence_firearms.ammo, police_evidence_firearms.suppressor, police_evidence_firearms.flashlight, police_evidence_firearms.extended_clip, police_evidence_firearms.scope, police_evidence_firearms.grip, police_evidence_firearms.advanced_scope, police_evidence_firearms.skin, police_evidence_firearms.owner, police_evidence_firearms.type, UNIX_TIMESTAMP(police_evidence_firearms.timestamp) AS timestamp, police_evidence_firearms.status FROM police_evidence_firearms", {}, function(Firearms)
		local timestamp = os.date("%A %B %d %Y | %I:%M %p", Firearms.timestamp)
		TriggerClientEvent("Create.Locker.Firearms", Source, Firearms, timestamp)
	end)
end)

AddEventHandler("Retrieve.Controlled.Substances", function()
	local Source = source
	exports['GHMattiMySQL']:QueryResultAsync("SELECT police_evidence_inventory.id, police_evidence_inventory.character_id, police_evidence_inventory.item_id, police_evidence_inventory.name, police_evidence_inventory.quantity, police_evidence_inventory.canuse, police_evidence_inventory.description, UNIX_TIMESTAMP(police_evidence_inventory.timestamp) AS timestamp, police_evidence_inventory.type FROM police_evidence_inventory", {}, function(ControlledSubstances)
		local timestamp = os.date("%A %B %d %Y | %I:%M %p", ControlledSubstances.timestamp)
		TriggerClientEvent("Create.Locker.Controlled.Substances", Source, ControlledSubstances, timestamp)
	end)
end)

RegisterServerEvent("Locker.Destroy")

AddEventHandler("Locker.Destroy", function(Data, Which)
	local Source = source
	if Which == "fingerprints" then
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM police_evidence_fingerprints WHERE (player=@player) AND (id=@id)", {
			["@id"] = Data.id,
			["@player"] = Data.player,
		})
	elseif Which == "ballistics" then
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM police_evidence_ballistics WHERE (player=@player) AND (id=@id)", {
			["@id"] = Data.id,
			["@player"] = Data.player,
		})
	elseif Which == "firearms" then
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM police_evidence_firearms WHERE (character_id=@character_id) AND (model=@model)", {
			["@character_id"] = Data.character_id,
			["@model"] = Data.model,
		})
	elseif Which == "cds" then
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM police_evidence_inventory WHERE (item_id=@item_id) AND (id=@id) AND (character_id=@character_id) AND (quantity=@quantity)", {
			["@item_id"] = Data.item_id,
			["@id"] = Data.id,
			["@character_id"] = Data.character_id,
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
		exports["GHMattiMySQL"]:QueryAsync("UPDATE police_evidence_inventory SET status=@status WHERE (id=@id)", {["@id"] = Data.id, ["@status"] = 1})
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
		exports["GHMattiMySQL"]:QueryAsync("UPDATE police_evidence_inventory SET status=@status WHERE (id=@id)", {["@id"] = Data.id, ["@status"] = 0})
	end
end)


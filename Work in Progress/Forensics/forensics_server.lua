local wepevidence = {}
local fpevidence = {}
local bloodevidence = {}
local picked_evidence = {}
local fingerprints = {}
local swab_fingerprints = {}
local bloodevidence = {}
local collectedblood = {}

RegisterServerEvent('police:forensicssyncevidence')
AddEventHandler('police:forensicssyncevidence', function(type, gun, ped)
	local source = source
	local weapons = {}
	if type == "weapon" then
		TriggerEvent("weapon:getuser", ped, function(_weapon)
			for k,v in pairs(_weapon) do
				if v.model == gun then
					table.insert(weapons, v.id)
				end
			end
		end)
		TriggerClientEvent('police:forensics_return', source, weapons)
	end
	if type == "nameofweapon" then
		TriggerClientEvent('police:forensics_weapon', source, Weapons_names[gun])
	end
end)

RegisterServerEvent('police:forensicssync') 
AddEventHandler('police:forensicssync', function(data, type, type2, key)
	local source = source
	if type == "wepevidence" and  type2 == "add" then
		table.insert(wepevidence, data)
		TriggerClientEvent('police:forensicssync_client', -1, "wep" ,wepevidence)
	end
	if type == "wepevidence" and type2 == "remove" then
		if #wepevidence <= 1 then
			wepevidence = {}
		else
			table.remove(wepevidence, key)
		end
		TriggerClientEvent('police:forensicssync_client', -1, "wep" ,wepevidence)
	end
	if type == "pickedupevidence" and  type2 == "add" then
		table.insert(picked_evidence, data)
		TriggerClientEvent('police:forensicssync_client', -1, "pickedupevidence" ,picked_evidence)
	end
	if type == "pickedupevidence" and type2 == "remove" then
		if #picked_evidence < 1 then
			picked_evidence = {}
			TriggerClientEvent('police:forensicssync_client', -1, "pickedupevidence" ,picked_evidence)
		else
			table.remove(picked_evidence, key)
			TriggerClientEvent('police:forensicssync_client', -1, "pickedupevidence" ,picked_evidence)
		end
	end
	if type == "fpevidence" and  type2 == "add" then
		table.insert(fpevidence, data)
		TriggerClientEvent('police:forensicssync_client', -1, "fpevidence" ,fpevidence)
	end
	if type == "fpevidence" and type2 == "remove" then
		if #fpevidence < 1 then
			fpevidence = {}
		else
			table.remove(fpevidence, key)
		end
		TriggerClientEvent('police:forensicssync_client', -1, "fpevidence" ,fpevidence)
	end
	if type == "pickedupfp" and  type2 == "add" then
		table.insert(swab_fingerprints, data)
		TriggerClientEvent('police:forensicssync_client', -1, "pickedupfp" ,swab_fingerprints)
	end
	if type == "pickedupfp" and type2 == "remove" then
		if #swab_fingerprints < 1 then
			swab_fingerprints = {}
			TriggerClientEvent('police:forensicssync_client', -1, "pickedupfp" ,swab_fingerprints)
		else
			table.remove(swab_fingerprints, key)
			TriggerClientEvent('police:forensicssync_client', -1, "pickedupfp" ,swab_fingerprints)
		end
	end
	if type == "wep" then
		TriggerClientEvent("chatMessage", source, "", {16, 102, 158}, "Forensics Evidence(Ballistics):")
		for k, v in ipairs(picked_evidence) do
			TriggerClientEvent("chatMessage", source, "Evidence", {16, 102, 158}, "["..k.."] - "..v.location)
		end
	end
	if type == "fp" then
		TriggerClientEvent("chatMessage", source, "", {16, 102, 158}, "Forensics Evidence(Fingerprints):")
		for k, v in ipairs(swab_fingerprints) do
			TriggerClientEvent("chatMessage", source, "Evidence", {16, 102, 158}, "["..k.."] - "..v.plate)
		end
	end
	--[[if type == "blood" and type2 = "add" then
		table.insert(bloodevidence, data)
		TriggerClientEvent('police:forensicssync_client', source, "blood", bloodevidence)
	end
	if type == "blood" and type2 = "remove" then
		table.remove(bloodevidence, key)
		TriggerClientEvent('police:forensicssync_client', source, "blood", bloodevidence)
	end
	if type == "pickedupblood" and type2 = "add" then
		table.insert(collectedblood, data)
		TriggerClientEvent('police:forensicssync_client', source, "blood", collectedblood)
	end
	if type == "pickedupblood" and type2 = "remove" then
		table.remove(collectedblood, key)
		TriggerClientEvent('police:forensicssync_client', source, "blood", collectedblood)
	end--]]
end)

RegisterServerEvent('police:checkprint')
AddEventHandler('police:checkprint', function(evidence, player, key)
	local source = source
	local character_id = 0
	local firstname, lastname = "",""
	TriggerEvent("core:getuser", player, function(user)
		character_id = user.get("characterID")
		firstname = user.get("first_name")
		lastname = user.get("last_name")
	end)
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM mdt_arrest WHERE offender_character_id=@character_id", {["@character_id"] = character_id}, function(value)
		if (#value > 0) then
			TriggerClientEvent('police:print_results', source, "sucesss" ,firstname, lastname)
		else
			TriggerClientEvent('police:print_results', source, "nomatch", firstname, lastname)
		end
	end)
	TriggerEvent('police:forensicssync', "", "pickedupfp", "remove", key)
end)

--[[RegisterServerEvent('police:forensics_dna')
AddEventHandler('police:forensics_dna', function()
	local source = source
	local character_id, firstname, lastname = 0, "", ""
	TriggerEvent("core:getuser", player, function(user)
		character_id = user.get("charaterID")
		firstname = user.get("first_name")
		lastname = user.get("last_name")
	end)
	exports['GHMattiMySQL']:QueryResultAsync("SELET * from mdt_arrests WHERE offender_character_id=@character_id", {["@character_id" = character_id]}, function(value)
		if (#value > 0) then
			TriggerClientEvent('poilce:dna_results', source, "sucess", firstname, lastname)
		else
			TriggerClientEvent('police:dna_results', source, "nomatch", firstname, lastname)
		end
	end)
end)--]]
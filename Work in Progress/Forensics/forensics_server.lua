local wepevidence = {}
local fpevidence = {}
local bloodevidence = {}
local picked_evidence = {}
local fingerprints = {}
local swab_fingerprints = {}


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
		TriggerClientEvent('police:forensicssync_client', source, "wep" ,wepevidence)
	end
	if type == "wepevidence" and type2 == "remove" then
		table.remove(wepevidence, key)
		TriggerClientEvent('police:forensicssync_client', source, "wep" ,wepevidence)
	end
	if type == "pickedupevidence" and  type2 == "add" then
		table.insert(picked_evidence, data)
		TriggerClientEvent('police:forensicssync_client', source, "pickedupevidence" ,picked_evidence)
	end
	if type == "pickedupevidence" and type2 == "remove" then
		table.remove(picked_evidence, key)
		TriggerClientEvent('police:forensicssync_client', source, "pickedupevidence" ,picked_evidence)
	end
	if type == "fpevidence" and  type2 == "add" then
		table.insert(fpevidence, data)
		TriggerClientEvent('police:forensicssync_client', source, "fpevidence" ,fpevidence)
	end
	if type == "fpevidence" and type2 == "remove" then
		table.remove(fpevidence, key)
		TriggerClientEvent('police:forensicssync_client', source, "fpevidence" ,fpevidence)
	end
	if type == "pickedfp" and  type2 == "add" then
		table.insert(swab_fingerprints, data)
		TriggerClientEvent('police:forensicssync_client', source, "pickedfp" ,swab_fingerprints)
	end
	if type == "pickedfp" and type2 == "remove" then
		table.remove(swab_fingerprints, key)
		TriggerClientEvent('police:forensicssync_client', source, "pickedfp" ,swab_fingerprints)
	end
end)

RegisterServerEvent('police:checkprint')
AddEventHandler('police:checkprint', function(evidence, player)
	local source = source
	local character_id = 0
	local firstname, lastname = "",""
	TriggerEvent("core:getuser", player, function(user)
		character_id = user.get("character_id")
		firstname = user.get("first_name")
		lastname = user.get("last_name")
	end)
	exports['GHMattiMySQL']:QueryResultAsync("SELECT COUNT(*) FROM mdt_arrest WHERE offender_character_id=@character_id", {["@character_id"] = character_id}, function(value)
		if (value[1] > 0) then
			TriggerClientEvent('police:print_results', source, "sucesss" ,firstname, lastname)
		else
			TriggerClientEvent('police:print_results', source, "nomatch", firstname, lastname)
		end
	end)
end)
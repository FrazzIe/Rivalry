RegisterServerEvent('police:forensics')
AddEventHandler('poilce:forensics', function(gun, ped, type)
	local source = source
	if type == "Weapon" then
		TriggerEvent("inventory:getuser", ped, function(_weapon)
			for k, v in ipairs(_weapon) do
				if GetHashKey(v.model) == gun then
					TriggerClientEvent('police:forensics_return', source, v.id)
				end
			end
		end)
	end
	if type == "WeaponName" then
		TriggerClientEvent('police:forensics_weapon', source, Weapon_names[gun])
	end
end)

local wepevidence = {}
local fpevidence = {}
local bloodevidence = {}
local picked_evidence = {}

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
		table.remove(wepevidence, key)
		TriggerClientEvent('police:forensicssync_client', source, "pickedupevidence" ,picked_evidence)
	end
	if type == "pickedupevidence" and type2 == "remove" then
		table.remove(picked_evidence, key)
		TriggerClientEvent('police:forensicssync_client', source, "pickedupevidence" ,picked_evidence)
	end
end)
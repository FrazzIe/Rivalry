--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--Cop blips
inServiceCops = {}
local FriskWeapons = {
    ["WEAPON_PISTOL"] = "You feel a metal L shaped object near the persons waist.",
    ["WEAPON_COMBATPISTOL"] = "You feel a metal L shaped object near the persons waist.",
    ["WEAPON_PISTOL50"] = "You feel a large metal L shaped object near the persons waist.",
    ["WEAPON_SNSPISTOL"] = "You feel a small metal L shaped object near the persons waist.",
    ["WEAPON_VINTAGEPISTOL"] = "You feel an L shaped metal object near the person waist.",
    ["WEAPON_STUNGUN"] = "You feel a thicc plastic object on their waist.",
    ["WEAPON_KNIFE"] = "You feel a very sharp object, with a round base.",
    ["WEAPON_NIGHTSTICK"] = "You feel a long L shaped object.",
    ["WEAPON_HAMMER"] = "You feel a wooden handle, with a metal piece on top.",
    ["WEAPON_BOTTLE"] = "You feel a very sharp glass object on them.",
    ["WEAPON_DAGGER"] = "You feel a long sharp metal object near their waist.",
    ["WEAPON_KNUCKLE"] = "You feel a round metal object, with large holes inside of it.",
    ["WEAPON_FLASHLIGHT"] = "You feel a metal cylinder, with a round head near the persons waist.",
    ["WEAPON_SWITCHBLADE"] = "You feel a small metal object in their pocket.",
	["WEAPON_DBSHOTGUN"] = "You feel a thicc metal object with 2 rounded barrels near their waist.",
	["WEAPON_APPISTOL"] = "You feel a bulky metal L shaped object near the persons waist.",
	["WEAPON_HEAVYPISTOL"] = "You feel a slightly large bulky metal L shaped object near the persons waist.",
	["WEAPON_MACHINEPISTOL"] = "You feel a metal L shaped object with a long barrel near their waist.",
}

RegisterServerEvent('police:setService')
AddEventHandler('police:setService', function(inService)
	local source = source
	TriggerEvent('core:getuser', source, function(Player)
		Player.setSessionVar('policeInService', inService)
	end)
	--if not inService then
	TriggerEvent("blips:set", source, inService, 3)
	--end
	if cops[source] then
		cops[source].onduty = inService
	end
end)

RegisterServerEvent('police:getAllCopsInService')
AddEventHandler('police:getAllCopsInService', function()
	local source = tonumber(source)
	TriggerClientEvent("police:resultAllCopsInService", source, inServiceCops)
end)

AddEventHandler('playerDropped', function()
	local source = tonumber(source)
	if(inServiceCops[source]) then
		inServiceCops[source] = nil		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
	if cops[source] then
		cops[source] = nil
	end
end)
--==============================================================================================================================--
--Cuffing
RegisterServerEvent("police:cuff")
AddEventHandler("police:cuff", function(target, type, cuffer)
	local source = source
	if cops[source] then
		TriggerClientEvent("police:cuff", target, type, cuffer)
		TriggerClientEvent('LIFE_CL:Sound:PlayOnOne', target, "handcuffs", "0.8")
		TriggerClientEvent('LIFE_CL:Sound:PlayOnOne', source, "handcuffs", "0.8")
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)

RegisterServerEvent("police:uncuff")
AddEventHandler("police:uncuff", function(target)
	TriggerClientEvent("police:uncuff", target)
end)
--==============================================================================================================================--
--Dragging
RegisterServerEvent('police:drag')
AddEventHandler('police:drag', function(target)
	local source = source
	if cops[source] then
		TriggerClientEvent('police:drag', target, source)
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)
--==============================================================================================================================--
--Force enter/exit
RegisterServerEvent('police:force')
AddEventHandler('police:force', function(target, type)
	local source = source
	if cops[source] then
		TriggerClientEvent('police:force', target, type)
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)
--==============================================================================================================================--
--Frisk
RegisterServerEvent('police:frisk')
AddEventHandler('police:frisk', function(target)
	local source = source
	if cops[source] then
		TriggerEvent("weapon:getuser", target, function(_weapon)
			if _weapon ~= nil then
				TriggerClientEvent("pNotify:SendNotification", target, {text = "You are being frisked!",type = "alert",queue = "left",timeout = 2500,layout = "centerRight"})
				if tablelength(_weapon) > 0 then
					for k,v in pairs(_weapon) do
						if FriskWeapons[k] then
							TriggerClientEvent("chatMessage", source, "Frisk", {16, 102, 158}, FriskWeapons[k])
						end
					end
				else
					TriggerClientEvent("pNotify:SendNotification", source, {text = "You didn't feel anything funny", type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
				end
			end
		end)
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)
--==============================================================================================================================--
--Search
RegisterServerEvent('police:search')
AddEventHandler('police:search', function(target, type)
	local source = source
	if cops[source] then
		if type == "inventory" then
			local message = ""
			TriggerEvent("inventory:getuser", target, function(_inventory)
				if _inventory ~= nil then
					for k,v in pairs(_inventory) do
						message = message .. "^3" .. v.quantity .. " ^0" .. v.name .. ", "
					end
					if message ~= "" then
						TriggerClientEvent("chatMessage", source, "Items found in pockets: ", {16, 102, 158},"" .. message)
					else
						TriggerClientEvent("pNotify:SendNotification", source, {text = "No items found",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
					end
				end
			end)
		elseif type == "weapons" then
			TriggerEvent("weapon:getuser", target, function(_weapon)
				if _weapon ~= nil then
					if tablelength(_weapon) > 0 then
						for k,v in pairs(_weapon) do
							TriggerClientEvent("chatMessage", source, "Frisk", {16, 102, 158}, "Weapon: "..Weapons_names[k]..", Serial number: "..v.id)
						end
					else
						TriggerClientEvent("pNotify:SendNotification", source, {text = "No weapons found",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
					end
				end
			end)
		elseif type == "wl" then
			TriggerEvent("core:getuser", target, function(_target)
				if _target.get("weapon_license") == "true" then
					TriggerClientEvent("chatMessage", source, "Weapons License:", {16, 102, 158}, " ^2Yes")
				else
					TriggerClientEvent("chatMessage", source, "Weapons License:", {16, 102, 158}, " ^1No")
				end
			end)
		elseif type == "id" then
			TriggerEvent('gc:takeIdentity', source, target)
		elseif type == "wallet" then
			TriggerEvent("core:getuser", target, function(_target)
				TriggerClientEvent("chatMessage", source, "Cash: ", {16, 102, 158}, "^2$^7" .._target.get("wallet"))
				TriggerClientEvent("chatMessage", source, "Dirty: ", {16, 102, 158}, "^1$^7" .. _target.get("dirty"))
				--TriggerClientEvent("pNotify:SendNotification", source, {text = "Cash: <span style='color:lime'>$</span><span style='color:white'>".._target.get("wallet").."</span><br>Dirty cash: <span style='color:lime'>$</span><span style='color:white'>".._target.get("dirty").."</span>",type = "error",queue = "left",timeout = 4000,layout = "centerRight"})
			end)
		elseif type == "dl" then
			TriggerEvent("core:getuser", target, function(_target)
				if _target.get("drivers_license") == "true" then
					TriggerClientEvent("chatMessage", source, "Drivers License:", {16, 102, 158}, " ^2Valid")
				else
					TriggerClientEvent("chatMessage", source, "Drivers License:", {16, 102, 158}, " ^1Suspended")
				end
			end)
		elseif type == "fl" then
			TriggerEvent("core:getuser", target, function(_target)
				if _target.get("fishing_license") == "true" then
					TriggerClientEvent("chatMessage", source, "Fishing License:", {16, 102, 158}, " ^2Yes")
				else
					TriggerClientEvent("chatMessage", source, "Fishing License:", {16, 102, 158}, " ^1No")
				end
			end)		
		end
	else
		TriggerEvent("core:anticheat-ban", source)
	end
	TriggerClientEvent("chatMessage", target, "You are being searched.")
end)

RegisterServerEvent('police:search_vehicle')
AddEventHandler('police:search_vehicle', function(target, type)
	local source = source
	if cops[source] then
		if type == "inventory" then
			local message = ""
			TriggerEvent("inventory:getvehicle", target, type, function(_inventory)
				if _inventory ~= nil then
					for k,v in pairs(_inventory) do
						if k ~= "locked" then
							message = message .. "^3" .. v.quantity .. " ^0" .. v.name .. ", "
						end
					end
					if message ~= "" then
						TriggerClientEvent("chatMessage", source, "Items found in vehicle: ", {16, 102, 158},"" .. message)
					else
						TriggerClientEvent("pNotify:SendNotification", source, {text = "No items found",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
					end
				else
					TriggerClientEvent("pNotify:SendNotification", source, {text = "No items found",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
				end
			end)
		elseif type == "weapons" then
			local message = ""
			TriggerEvent("inventory:getvehicle", target, type, function(_weapon)
				if _weapon ~= nil then
					if _weapon.weapons then
						if tablelength(_weapon.weapons) > 0 then
							for k,v in pairs(_weapon.weapons) do
								TriggerClientEvent("chatMessage", source, "Search", {16, 102, 158}, "Weapon: "..Weapons_names[v.model]..", Serial number: "..v.id)
							end
						else
							TriggerClientEvent("pNotify:SendNotification", source, {text = "No weapons found",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
						end
					else
						TriggerClientEvent("pNotify:SendNotification", source, {text = "No weapons found",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
					end
				else
					TriggerClientEvent("pNotify:SendNotification", source, {text = "No weapons found",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
				end
			end)
		end
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)
--==============================================================================================================================--
--Seize
RegisterServerEvent('police:seize')
AddEventHandler('police:seize', function(target, type)
	local source = source
	if cops[source] then
		if type == "inventory" then
			TriggerEvent("inventory:seize", target)
			TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized their items",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			TriggerClientEvent("pNotify:SendNotification", target, {text = "Your items have been confiscated..",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
		elseif type == "weapons" then
			TriggerEvent("weapon:delete", target)
			TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized their weapons",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			TriggerClientEvent("pNotify:SendNotification", target, {text = "Your weapons have been confiscated..",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
		elseif type == "wl" then
			TriggerEvent("core:getuser", target, function(_target)
				_target.set("weapon_license", "false")
				TriggerClientEvent("weapon:set_license", target, "false")
				TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized their weapons license",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				TriggerClientEvent("pNotify:SendNotification", target, {text = "Your weapons license has been confiscated..",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			end)
		elseif type == "wallet" then
			TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized their cash",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			TriggerClientEvent("pNotify:SendNotification", target, {text = "Your cash has been confiscated..",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			TriggerEvent("core:getuser", target, function(_target)
				_target.wallet(0)
				_target.dirty(0)
			end)
		elseif type == "dl" then
			TriggerEvent("core:getuser", target, function(_target)
				_target.set("drivers_license", "false")
				TriggerClientEvent("interaction:set_drivers_license", target, "false")
				TriggerClientEvent("pNotify:SendNotification", source, {text = "You suspended their drivers license",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				TriggerClientEvent("pNotify:SendNotification", target, {text = "Your drivers license has been suspended..",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			end)
		elseif type == "fl" then
			TriggerEvent("core:getuser", target, function(_target)
				_target.set("fishing_license", "false")
				TriggerClientEvent("interaction:set_fishing_license", target, "false")
				TriggerClientEvent("pNotify:SendNotification", source, {text = "You suspended their fishing license",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				TriggerClientEvent("pNotify:SendNotification", target, {text = "Your fishing license has been suspended..",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			end)
		elseif type == "phone" then
			TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized their phone",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			TriggerClientEvent("pNotify:SendNotification", target, {text = "Your phone was confiscated!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			TriggerEvent("Phone.Set", target, false)
		elseif type == "radio" then
			TriggerEvent("core:getuser", target, function(_target)
				_target.set("radio", "false")
				TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized their radio",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				TriggerClientEvent("pNotify:SendNotification", target, {text = "Your radio was confiscated!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				TriggerClientEvent("Radio.Set", target, false)
			end)
		end
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)

RegisterServerEvent('police:seize_vehicle')
AddEventHandler('police:seize_vehicle', function(target, type)
	local source = source
	if cops[source] then
		if type == "inventory" then
			TriggerEvent("inventory:seize_vehicle", target, type)
			TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized all the items in the vehicle",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
		elseif type == "weapons" then
			TriggerEvent("inventory:delete_vehicle", target, type)
			TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized all the weapons in the vehicle",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
		end
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)
--==============================================================================================================================--
--Check if the car is stolen

RegisterServerEvent('police:check_plate')
AddEventHandler('police:check_plate', function(plate)
	local source = source
	if cops[source] then
		if plate ~= nil then
			if string.sub(plate, 1, 2) == "RR" then
				TriggerClientEvent("pNotify:SendNotification", source, {text = "The plate <span style 'color:lime'>"..plate.."</span> belongs to the rental company!",type = "error",queue = "left",timeout = 4000,layout = "centerRight"})
			elseif string.upper(plate) == "STUDENT" then
			TriggerClientEvent("pNotify:SendNotification", source, {text = "The plate <span style 'color:lime'>"..plate.."</span> belongs to the driver school!",type = "error",queue = "left",timeout = 4000,layout = "centerRight"})
			else
				if tonumber(plate, 16) ~= nil then
					exports['GHMattiMySQL']:QueryResultAsync("SELECT first_name, last_name FROM characters WHERE character_id=(SELECT character_id FROM vehicles WHERE plate=@plate)", {["@plate"] = tonumber(plate, 16)}, function(character)
						if character[1] == nil then
							TriggerClientEvent("pNotify:SendNotification", source, {text = "The plate <span style 'color:lime'>"..plate.."</span> could not be found in the database!",type = "error",queue = "left",timeout = 4000,layout = "centerRight"})
						else
							TriggerClientEvent("pNotify:SendNotification", source, {text = "The plate <span style 'color:lime'>"..plate.."</span> is owned by a <span style 'color:lime'>"..character[1].first_name.." "..character[1].last_name.."</span>",type = "error",queue = "left",timeout = 6000,layout = "centerRight"})
						end
					end)
				else
					TriggerClientEvent("pNotify:SendNotification", source, {text = "The plate <span style 'color:lime'>"..plate.."</span> could not be found in the database!",type = "error",queue = "left",timeout = 4000,layout = "centerRight"})
				end
			end
		else
			TriggerClientEvent("pNotify:SendNotification", source, {text = "An unexpected error occured, please try again!",type = "error",queue = "left",timeout = 4000,layout = "centerRight"})
		end
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)
--==============================================================================================================================--
--Impound
RegisterServerEvent('police:impound')
AddEventHandler('police:impound', function(plate, amount)
	if plate ~= nil then
		local hexPlate = tonumber(plate, 16)

		if hexPlate ~= nil then
			exports['GHMattiMySQL']:QueryAsync("UPDATE vehicles SET state=@state WHERE plate=@plate", {["@state"] = ((amount > 0) and "~b~Impounded" or "~g~Stored"), ["@plate"] = hexPlate})
			exports['GHMattiMySQL']:QueryResultAsync("SELECT characters.identifier FROM vehicles INNER JOIN characters ON vehicles.character_id = characters.character_id WHERE plate=@plate", {["@plate"] = hexPlate}, function(identifier)
				if identifier[1] == nil then
				else
					TriggerEvent("core:getuserfromidentifier", identifier[1].identifier, function(target)
						if target then
							TriggerClientEvent("garage:impound", target, plate, amount)
						end
					end)
				end
			end)
		end
	end
end)
--==============================================================================================================================--
--Fines
RegisterServerEvent('police:finesGranted')
AddEventHandler('police:finesGranted', function(target, amount)
	local source = source
	if cops[source] then
		TriggerClientEvent('police:payFines', target, amount, source)
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)

RegisterServerEvent('police:finesETA')
AddEventHandler('police:finesETA', function(officer, code)
	TriggerEvent("core:getuser", source, function(user)
		if(code==1) then
	        TriggerClientEvent("pNotify:SendNotification", officer, {text = user.get("first_name").." "..user.get("last_name").." already has a request for a fine",type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
		elseif(code==2) then
	        TriggerClientEvent("pNotify:SendNotification", officer, {text = user.get("first_name").." "..user.get("last_name").." did not respond to the request in time",type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
		elseif(code==3) then
	       	TriggerClientEvent("pNotify:SendNotification", officer, {text = user.get("first_name").." "..user.get("last_name").." has refused to pay their fine",type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
		elseif(code==0) then
	       	TriggerClientEvent("pNotify:SendNotification", officer, {text = user.get("first_name").." "..user.get("last_name").." has successfully paid their fine.",type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
		end
	end)
end)

RegisterServerEvent('police:finesForced')
AddEventHandler('police:finesForced', function(target, amount)
	local source = source
	if cops[source] then
		TriggerEvent("core:getuser", target, function(user)
			if user ~= nil then
				user.removeBank(amount)
				TriggerClientEvent("pNotify:SendNotification", target, {text = 'You were fined $'..amount,type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
				TriggerClientEvent("pNotify:SendNotification", source, {text = '' ..GetIdentity(target)..' has successfully paid their fine.',type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
			end
		end)
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)

TriggerEvent("core:addGroupCommand", "runplate", "emergency", function(source, args, rawCommand, data, power, group)
	if cops[source] then
		if args[1] then
			if args[1] ~= nil then
				if string.sub(args[1], 1, 2) == "RR" then
					TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "The plate "..args[1].." belongs to the rental company!")
				else
					if tonumber(args[1], 16) ~= nil then
						exports['GHMattiMySQL']:QueryResultAsync("SELECT first_name, last_name FROM characters WHERE character_id=(SELECT character_id FROM vehicles WHERE plate=@plate)", {["@plate"] = tonumber(args[1], 16)}, function(character)
							if character[1] == nil then
								TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "The plate "..args[1].." has been reported 10-99 stolen! Call for backup.")
							else
								TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "The plate "..args[1].." is owned by a "..character[1].first_name.." "..character[1].last_name)
							end
						end)
					else
						TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "The plate "..args[1].." could not be found in the database!")
					end
				end
			else
				TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "An unexpected error occured, please try again!")
			end
		end
	else
		Notify("You must be on duty to run plates!", 3100)
	end
end, {help = "Run a plate"})

TriggerEvent("core:addGroupCommand", "runserial", "emergency", function(source, args, rawCommand, data, power, group)
	if cops[source] then
		if args[2] then
			if args[1] == "p" or args[1] == "v" or args[1] == "vehicle" or args[1] == "person" then
				if args[1] == "p" or args[1] == "person" then
					if tonumber(args[2]) then
						exports['GHMattiMySQL']:QueryResultAsync("SELECT CONCAT(characters.first_name, ' ', characters.last_name) AS 'name' FROM weapons INNER JOIN characters ON weapons.owner = characters.character_id WHERE id=@id", {["@id"] = tonumber(args[2])}, function(owner)
							if owner[1] ~= nil then
								TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "The weapon with serial number ^3"..tonumber(args[2]).."^0 belongs to "..owner[1].name)
							else
								TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "The weapon with serial number ^3"..tonumber(args[2]).."^0 isn't registered!")
							end
						end)
					else
						TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "An unexpected error occured, please try again!")
					end
				else
					if tonumber(args[2]) then
						exports['GHMattiMySQL']:QueryResultAsync("SELECT CONCAT(characters.first_name, ' ', characters.last_name) AS 'name' FROM vehicle_weapon_inventory INNER JOIN characters ON vehicle_weapon_inventory.owner = characters.character_id WHERE id=@id", {["@id"] = tonumber(args[2])}, function(owner)
							if owner[1] ~= nil then
								TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "The weapon with serial number ^3"..tonumber(args[2]).."^0 belongs to "..owner[1].name)
							else
								TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "The weapon with serial number ^3"..tonumber(args[2]).."^0 isn't registered!")
							end
						end)
					else
						TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "An unexpected error occured, please try again!")
					end
				end
			else
				TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "An unexpected error occured, please try again!")
			end
		end
	else 
		Notify("You must be on duty to run plates!", 3100)	
	end
end, {help = "Run a weapon serial number", params = {{name = "location", help = "p | person | v | vehicle - Is the gun on a person or in a vehicle"},{name = "serial", help = "Serial number"}}})

TriggerEvent("core:addGroupCommand", "checktow", "emergency", function(source, args, rawCommand, data, power, group)
	TriggerEvent("getMechs", function(mechanics)
		TriggerClientEvent("police:checktow", source, mechanics)
	end)
end, {help = "Check if any tows are online"})

RegisterServerEvent("Spikes.Burst")
AddEventHandler("Spikes.Burst", function(Target, Tyre)
	local Source = source
	TriggerClientEvent("Spikes.Burst", Target, Tyre)
end)


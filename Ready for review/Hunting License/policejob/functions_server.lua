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

RegisterServerEvent('playerShot')
AddEventHandler('playerShot', function(source)
    if(exports.policejob:getIsInServer(source) == true)then
    	TriggerClientEvent('markerForCops', true)
    end
end)

RegisterServerEvent('removeMarker')
AddEventHandler('removeMarker', function(source)
    if(exports.policejob:getIsInServer(source) == true)then
      TriggerClientEvent('isACop', true)
    end
end)

local tFingerprints = {}

RegisterServerEvent("police:saveprint")
AddEventHandler("police:saveprint", function(table)
	tFingerprints = table
end) 

RegisterServerEvent("police:lift_print")
AddEventHandler("police:lift_print", function(vehicle)
	local source = source	
	local vehicleMatch = nil
	local vehicleHandle = vehicle
	local playername = nil
	if cops[source] then
	    for k, v in ipairs(tFingerprints) do
		    if(v.veh == vehicleHandle)then
		    	vehicleMatch = vehicleHandle
		    	playername = v.player
		    end
		end
		if(vehicleHandle == vehicleMatch)then
			TriggerClientEvent("pNotify:SendNotification", source, {text = "Fingerprint was lifted, and it appears to come back to a "..playername.."<br>", type = "error",queue = "left",timeout = 10000,layout = "centerRight"})
		else
			TriggerClientEvent("pNotify:SendNotification", source, {text = "No prints were found. Suspect was either wearing gloves, or its been too long.", type = "error",queue = "left",timeout = 10000,layout = "centerRight"})
		end
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
	end
end)

--==============================================================================================================================--
--Cuffing
RegisterServerEvent("police:cuff")
AddEventHandler("police:cuff", function(target, type)
	local source = source
	if cops[source] then
		TriggerClientEvent("police:cuff", target, type)
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
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
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
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
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
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
						message = message .. v.quantity .. " | " .. v.name .. "\n"
					end
					if message ~= "" then
						TriggerClientEvent("pNotify:SendNotification", source, {text = message, type = "error",queue = "left",timeout = 10000,layout = "centerRight"})
						TriggerClientEvent("chatMessage", source, "Police", {0, 255, 0}, message)
					else
						TriggerClientEvent("pNotify:SendNotification", source, {text = "No items found",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
					end
				end
			end)
		elseif type == "weapons" then
			local message = ""
			TriggerEvent("weapon:getuser", target, function(_weapon)
				if _weapon ~= nil then
					for k,v in pairs(_weapon) do
						message = message .. Weapons_names[k] .. "\n"
					end
					if message ~= "" then
						TriggerClientEvent("chatMessage", source, "Police", {0, 255, 0}, message)
					else
						TriggerClientEvent("pNotify:SendNotification", source, {text = "No weapons found",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
					end
				end
			end)
		elseif type == "wl" then
			TriggerEvent("core:getuser", target, function(_target)
				if _target.get("weapon_license") == "true" then
					TriggerClientEvent("pNotify:SendNotification", source, {text = "This person is licensed to carry firearms",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				else
					TriggerClientEvent("pNotify:SendNotification", source, {text = "This person does not have a license!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				end
			end)
		elseif type == "id" then
			TriggerEvent('gc:takeIdentity', source, target)
		elseif type == "wallet" then
			TriggerEvent("core:getuser", target, function(_target)
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Cash: <span style='color:lime'>$</span><span style='color:white'>".._target.get("wallet").."</span><br>Dirty cash: <span style='color:lime'>$</span><span style='color:white'>".._target.get("dirty").."</span>",type = "error",queue = "left",timeout = 4000,layout = "centerRight"})
			end)
		elseif type == "dl" then
			TriggerEvent("core:getuser", target, function(_target)
				if _target.get("drivers_license") == "true" then
					TriggerClientEvent("pNotify:SendNotification", source, {text = "This person is licensed to drive",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				else
					TriggerClientEvent("pNotify:SendNotification", source, {text = "This person does not have a license!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				end
			end)
		elseif type == "hl" then
			TriggerEvent("core:getuser", target, function(_target)
				if _target.get("hunters_license") == "true" then
					TriggerClientEvent("pNotify:SendNotification", source, {text = "This person is licensed to Hunt!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				else
					TriggerClientEvent("pNotify:SendNotification", source, {text = "This person does not have a Hunting License!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				end
			end)		
		end
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
	end
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
							message = message .. v.quantity .. " | " .. v.name .. "\n"
						end
					end
					if message ~= "" then
						TriggerClientEvent("chatMessage", source, "Police", {0, 255, 0}, message)
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
						for k,v in pairs(_weapon.weapons) do
							if k ~= "locked" then
								message = message .. Weapons_names[v.model] .. "\n"
							end
						end
						if message ~= "" then
							TriggerClientEvent("pNotify:SendNotification", source, {text = message,type = "error",queue = "left",timeout = 5000,layout = "centerRight"})
							TriggerClientEvent("chatMessage", source, "Police", {0, 255, 0}, message)
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
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
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
				TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized their drivers license",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				TriggerClientEvent("pNotify:SendNotification", target, {text = "Your drivers license has been confiscated..",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			end)
		elseif type == "phone" then
			TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized their phone",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			TriggerClientEvent("pNotify:SendNotification", target, {text = "Your phone was confiscated!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			TriggerClientEvent("phone:set", target, false)
		end
		elseif type == "hl" then
			TriggerEvent("core:getuser", target, function(_target)
				_target.set("hunters_license", "false")
				TriggerClientEvent("hunters:set_license", target, "false")
				TriggerClientEvent("pNotify:SendNotification", source, {text = "You seized their hunters license",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
				TriggerClientEvent("pNotify:SendNotification", target, {text = "Your hunting license has been confiscated..",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
			end)
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
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
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
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
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
	end
end)
--==============================================================================================================================--
--Impound
RegisterServerEvent('police:impound')
AddEventHandler('police:impound', function(plate, amount)
	if tonumber(plate, 16) ~= nil then
		exports['GHMattiMySQL']:QueryResultAsync("SELECT identifier FROM vehicles WHERE plate=@plate", {["@plate"] = tonumber(plate, 16)}, function(identifier)
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
end)
--==============================================================================================================================--
--Fines
RegisterServerEvent('police:finesGranted')
AddEventHandler('police:finesGranted', function(target, amount)
	local source = source
	if cops[source] then
		TriggerClientEvent('police:payFines', target, amount, source)
	else
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
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
		TriggerEvent("core:ban", source, 99, "Script tampering", true, "Anticheat")
	end
end)
--==============================================================================================================================--
--Charges
RegisterServerEvent('police:showCharges')
AddEventHandler('police:showCharges', function (t, charges)
	local source = source
	local other_name = GetIdentity(t)
    TriggerClientEvent('chatMessage', t, '[GOVERNMENT]', {255, 0, 0},"You have been charged with: "..table.concat(charges))
    TriggerClientEvent('chatMessage', source, '[GOVERNMENT]', {255, 0, 0}, "You have charged.."..other_name.." with: "..table.concat(charges))
    TriggerClientEvent("police:receiveSuspectInfo", source, GetIdentity(source), other_name, getID("steam", t))
end)

TriggerEvent("core:addGroupCommand", "runplate", "emergency", function(source, args, rawCommand, data, power, group)
	if args[1] then
		if args[1] ~= nil then
			if string.sub(args[1], 1, 2) == "RR" then
				TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "The plate "..args[1].." belongs to the rental company!")
			else
				if tonumber(args[1], 16) ~= nil then
					exports['GHMattiMySQL']:QueryResultAsync("SELECT first_name, last_name FROM characters WHERE character_id=(SELECT character_id FROM vehicles WHERE plate=@plate)", {["@plate"] = tonumber(args[1], 16)}, function(character)
						if character[1] == nil then
							TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "The plate "..args[1].." could not be found in the database!")
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
	else
	end
end, {help = "Run a plate"})

TriggerEvent("core:addGroupCommand", "checktow", "emergency", function(source, args, rawCommand, data, power, group)
	TriggerEvent("getMechs", function(mechanics)
		if mechanics > 0 then
			TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "There are "..mechanics.." tows online!")
		else
			TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "Unfortunatly there are no tows in service!")
		end
	end)
end, {help = "Check if any tows are online"})

RegisterServerEvent("Spikes.Burst")
AddEventHandler("Spikes.Burst", function(Target, Tyre)
	local Source = source
	TriggerClientEvent("Spikes.Burst", Target, Tyre)
end)
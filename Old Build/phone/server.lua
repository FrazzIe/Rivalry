--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
local phone_numbers = {}
local phone_numbers_online = {}
local phone_numbers_playerids = {}
local user_phone = {}
local phone_calls = {}
local has_phone = {}

function getID(type, source)
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" and (type == "steam" or type == 1) then
            return v
        elseif string.sub(tostring(v), 1, string.len("license:")) == "license:" and (type == "license" or type == 2) then
            return v
        elseif string.sub(tostring(v), 1, string.len("ip:")) == "ip:" and (type == "ip" or type == 3) then
            return v
        end
    end
    return nil
end

AddEventHandler("playerDropped", function()
    local source = source
    if user_phone[source] then
    	phone_numbers_playerids[user_phone[source].phone_number] = nil
    	phone_numbers_online[user_phone[source].phone_number] = false
    	user_phone[source] = nil
    end
end)

AddEventHandler("phone:set", function(source, value)
	TriggerEvent("core:getuser", source, function(user)
		if user ~= nil then
			local char_id = user.get("characterID")
			if has_phone[source] then
				has_phone[source][tostring(char_id)] = value
			else
				has_phone[source] = {}
				has_phone[source][tostring(char_id)] = value
			end
			TriggerClientEvent("phone:set", source, value)
		end
	end)
end)

AddEventHandler("phone:has", function(source, callback)
	TriggerEvent("core:getuser", source, function(user)
		if user ~= nil then
			if has_phone[source] then
				if has_phone[source][tostring(user.get("characterID"))] then
					callback(true)
				else
					callback(false)
				end
			else
				callback(false)
			end
		else
			callback(false)
		end
	end)
end)

AddEventHandler("phone:number", function(source, callback)
	if user_phone[source] then
		if user_phone[source].phone_number then
			callback(user_phone[source].phone_number)
		else
			callback(nil)
		end
	else
		callback(nil)
	end
end)

AddEventHandler("core:switch", function(source)
    local source = source
    phone_numbers_online[user_phone[source].phone_number] = false
    phone_calls[source] = nil
    user_phone[source] = nil
end)

exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from phone", {}, function(all_phone_numbers)
	if all_phone_numbers[1] == nil then
	else
		for k,v in pairs(all_phone_numbers) do
			phone_numbers[v.phone_number] = v.identifier
			phone_numbers_online[v.phone_number] = false
		end
	end
end)

RegisterServerEvent("phone:initialise")
AddEventHandler("phone:initialise",function(source, identifier, character_id)
	local source = source
	exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM phone WHERE (identifier=@identifier) AND (character_id=@character_id)", {['@identifier'] = identifier, ["@character_id"] = character_id}, function(phone_number)
		if phone_number[1] == nil then
			Citizen.CreateThread(function()
				math.randomseed(os.time())
				math.random(); math.random(); math.random();
				local duplicate_number = true
				while duplicate_number do
					Citizen.Wait(0)
					local new_number = "0"..math.random(1000000000, 9999999999)
					if not phone_numbers[new_number] then
						duplicate_number = false
						phone_numbers[new_number] = identifier
						exports["GHMattiMySQL"]:QueryAsync("INSERT INTO phone (`identifier`,`character_id`,`phone_number`) VALUES (@identifier,@character_id,@phone_number)", {
							["@identifier"] = identifier,
							["@character_id"] = character_id,
							["@phone_number"] = new_number,
						})
						user_phone[source] = {}
						user_phone[source].phone_number = new_number
						user_phone[source].contacts = {}
						user_phone[source].contact_names = {}
						user_phone[source].messages = {}
						user_phone[source].messages.sent = {}
						user_phone[source].messages.received = {}
						user_phone[source].messages.sorted = {}

						phone_numbers_playerids[identifier] = source
						phone_numbers_online[user_phone[source].phone_number] = true

						TriggerEvent("phone:set", source, true)
						TriggerClientEvent("phone:initialise", source, user_phone[source])
					end
				end
			end)
		else
			user_phone[source] = {}
			user_phone[source].phone_number = phone_number[1].phone_number
			user_phone[source].contacts = {}
			user_phone[source].contact_names = {}
			user_phone[source].messages = {}
			user_phone[source].messages.sent = {}
			user_phone[source].messages.received = {}
			user_phone[source].messages.sorted = {}

			phone_numbers_playerids[identifier] = source
			phone_numbers_online[user_phone[source].phone_number] = true

			exports["GHMattiMySQL"]:QueryResultAAsync("SELECT * FROM phone_contacts WHERE character_id=@character_id", {["@character_id"] = character_id}, function(Contacts)
				exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM phone_messages WHERE (source_identifier=@identifier) AND (source_number=@phone_number) AND (owner=@identifier)", {['@identifier'] = identifier, ["@phone_number"] = phone_number}, function(SentMessages)
					exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM phone_messages WHERE (target_identifier=@identifier) AND (target_number=@phone_number) AND (owner=@identifier)", {['@identifier'] = identifier, ["@phone_number"] = phone_number}, function(ReceivedMessages)

					end)
				end)
			end)
			TriggerEvent("phone:set", source, true)
			TriggerClientEvent("phone:initialise", source, user_phone[source])
		end
	end)
end)

RegisterServerEvent("phone:setup_complete")
AddEventHandler("phone:setup_complete", function(_user)
	local source = source
	user_phone[source] = _user
end)

RegisterServerEvent("phone:contact_add")
AddEventHandler("phone:contact_add", function(phone_number, first_name, last_name)
	local source = source
	if user_phone[source] then
		if user_phone[source].contact_names then
			if user_phone[source].contact_names[phone_number] then
				TriggerClientEvent("phone:contact_add", source, user_phone[source], true)
			else
				TriggerEvent("core:getuser", source, function(user)
					exports["GHMattiMySQL"]:Insert("phone_contacts", {
					    {
					        ["character_id"] = user.get("characterID"),
					        ["phone_number"] = phone_number,
					        ["first_name"] = first_name,
					        ["last_name"] = last_name,
					    }
					}, function(contact_id)
					    table.insert(user_phone[source].contacts, {id = contact_id, phone_number = phone_number, first_name = first_name, last_name = last_name})
					    user_phone[source].contact_names[phone_number] = first_name.." "..last_name
					    TriggerClientEvent("phone:contact_add", source, user_phone[source], false)
					end, true)
				end)
			end
		end
	end
end)

RegisterServerEvent("phone:contact_remove")
AddEventHandler("phone:contact_remove", function(id, _user_phone)
	local source = source
	user_phone[source] = _user_phone
	TriggerEvent("core:getuser", source, function(user)
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM phone_contacts WHERE (character_id=@character_id) AND (id=@id)", {
			["@character_id"] = user.get("characterID"),
			["@id"] = id,
		})
	end)
end)

RegisterServerEvent("phone:message_add")
AddEventHandler("phone:message_add", function(target_number, message)
	local source = source
	if not phone_numbers[target_number] then
		TriggerClientEvent("phone:message_add", source, user_phone[source], true, false, user_phone[source].phone_number, target_number)
	else
		exports["GHMattiMySQL"]:Insert("phone_messages", {
		    {
		        ["source_identifier"] = phone_numbers[user_phone[source].phone_number],
		        ["source_number"] = user_phone[source].phone_number,
		        ["message"] = message,
		        ["target_identifier"] = phone_numbers[target_number],
		        ["target_number"] = target_number,
		        ["owner"] = phone_numbers[user_phone[source].phone_number],
		    }
		}, function(message_id)
		    local _message = {id = message_id, source_identifier = phone_numbers[user_phone[source].phone_number], source_number = user_phone[source].phone_number, message = message, target_identifier = phone_numbers[target_number], target_number = target_number, owner = phone_numbers[user_phone[source].phone_number]}
		    table.insert(user_phone[source].messages.sent, _message)
		    if not user_phone[source].messages.sorted[target_number] then
		        user_phone[source].messages.sorted[target_number] = {}
		    end
		    user_phone[source].messages.sorted[target_number][message_id] = _message
		    TriggerClientEvent("phone:message_add", source, user_phone[source], false, false, user_phone[source].phone_number, target_number)
		end, true)
        exports["GHMattiMySQL"]:Insert("phone_messages", {
            {
                ["source_identifier"] = phone_numbers[user_phone[source].phone_number],
                ["source_number"] = user_phone[source].phone_number,
                ["message"] = message,
                ["target_identifier"] = phone_numbers[target_number],
                ["target_number"] = target_number,
                ["owner"] = phone_numbers[target_number],
            }
        }, function(message_id)
            if phone_numbers_playerids[phone_numbers[target_number]] then
                local target_id = tonumber(phone_numbers_playerids[phone_numbers[target_number]])
                local target_identifier = phone_numbers[target_number]
                local source_number = user_phone[source].phone_number
                if user_phone[target_id] then
                    if user_phone[target_id].phone_number then
                        if user_phone[target_id].phone_number == target_number then
                            local _message = {id = message_id, source_identifier = phone_numbers[user_phone[source].phone_number], source_number = user_phone[source].phone_number, message = message, target_identifier = target_identifier, target_number = target_number, owner = target_identifier}
                            if user_phone[target_id].messages.received then
                                table.insert(user_phone[target_id].messages.received, _message)
                                if user_phone[target_id].messages.sorted then
                                    if not user_phone[target_id].messages.sorted[source_number] then
                                        user_phone[target_id].messages.sorted[source_number] = {}
                                    end
                                    user_phone[target_id].messages.sorted[source_number][message_id] = _message
                                    TriggerClientEvent("phone:message_add", target_id, user_phone[target_id], false, true, user_phone[source].phone_number, target_number)
                                end
                            end
                        end
                    end
                end
            end
        end, true)
	end
end)

RegisterServerEvent("phone:message_remove")
AddEventHandler("phone:message_remove", function(id, _user_phone)
	local source = source
	user_phone[source] = _user_phone
	TriggerEvent("core:getuser", source, function(user)
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM phone_messages WHERE id=@id", {
			["@id"] = id,
		})
	end)
end)

RegisterServerEvent("phone:call")
AddEventHandler("phone:call", function(target_number)
	local source = source
	if phone_numbers[target_number] then
		if phone_numbers_playerids[phone_numbers[target_number]] then
			if phone_numbers_online[target_number] then
				if not phone_calls[phone_numbers_playerids[phone_numbers[target_number]]] then
					phone_calls[phone_numbers_playerids[phone_numbers[target_number]]] = user_phone[source].phone_number
					phone_calls[source] = user_phone[source].phone_number
					TriggerClientEvent("phone:call", source, "Dialing...")
					TriggerClientEvent("phone:request", phone_numbers_playerids[phone_numbers[target_number]], user_phone[source].phone_number, source)
				else
					TriggerClientEvent("phone:call", source, "Target is busy!")
				end
			else
				TriggerClientEvent("phone:call", source, "This users phone is switched off!")
			end
		else
			TriggerClientEvent("phone:call", source, "This users phone is switched off!")
		end
	else
		TriggerClientEvent("phone:call", source, "This users phone is switched off!")
	end
end)

RegisterServerEvent("phone:cancel")
AddEventHandler("phone:cancel", function(target_number, call_channel)
	local source = source
	if phone_numbers[target_number] then
		if phone_numbers_playerids[phone_numbers[target_number]] then
			if phone_numbers_online[target_number] then
				if phone_calls[phone_numbers_playerids[phone_numbers[target_number]]] then
					if phone_calls[phone_numbers_playerids[phone_numbers[target_number]]]+10000000000 == call_channel then 
						TriggerClientEvent("phone:cancel", source)
						TriggerClientEvent("phone:cancel", phone_numbers_playerids[phone_numbers[target_number]])
						phone_calls[source] = nil
						phone_calls[phone_numbers_playerids[phone_numbers[target_number]]] = nil
					else
						TriggerClientEvent("phone:cancel", source)
						phone_calls[source] = nil
					end
				else
					TriggerClientEvent("phone:cancel", source)
					phone_calls[source] = nil
				end
			else
				TriggerClientEvent("phone:cancel", source)
				phone_calls[source] = nil
			end
		else
			TriggerClientEvent("phone:cancel", source)
			phone_calls[source] = nil
		end
	else
		TriggerClientEvent("phone:cancel", source)
		phone_calls[source] = nil
	end
end)

RegisterServerEvent("phone:answer")
AddEventHandler("phone:answer", function(target_number)
	local source = source
	if phone_numbers[target_number] then
		if phone_numbers_playerids[phone_numbers[target_number]] then
			if phone_numbers_online[target_number] then
				if phone_calls[phone_numbers_playerids[phone_numbers[target_number]]] then
					if phone_numbers_playerids[phone_numbers[target_number]] then
						TriggerClientEvent("phone:answer", source, target_number)
						TriggerClientEvent("phone:answer", phone_numbers_playerids[phone_numbers[target_number]], target_number)
					else
						TriggerClientEvent("phone:cancel", source)
						phone_calls[source] = nil		
					end
				else
					TriggerClientEvent("phone:cancel", source)
					phone_calls[source] = nil		
				end
			else
				TriggerClientEvent("phone:cancel", source)
				phone_calls[source] = nil		
			end
		else
			TriggerClientEvent("phone:cancel", source)
			phone_calls[source] = nil		
		end
	else
		TriggerClientEvent("phone:cancel", source)
		phone_calls[source] = nil
	end
end)

RegisterServerEvent("phone:onhold")
AddEventHandler("phone:onhold", function(target_number, onhold)
	local source = source
	if phone_numbers[target_number] then
		if phone_numbers_playerids[phone_numbers[target_number]] then
			if phone_numbers_online[target_number] then
				if phone_calls[phone_numbers_playerids[phone_numbers[target_number]]] then
					if onhold then
						TriggerClientEvent("phone:call", phone_numbers_playerids[phone_numbers[target_number]], "On hold")
					else
						TriggerClientEvent("phone:call", phone_numbers_playerids[phone_numbers[target_number]], "Active")
					end
				else
					TriggerClientEvent("phone:cancel", source)
					phone_calls[source] = nil
				end
			else
				TriggerClientEvent("phone:cancel", source)
				phone_calls[source] = nil
			end			
		else
			TriggerClientEvent("phone:cancel", source)
			phone_calls[source] = nil		
		end
	else
		TriggerClientEvent("phone:cancel", source)
		phone_calls[source] = nil
	end
end)

function updatePhone()
    Citizen.SetTimeout(900000, function()
		exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from phone", {}, function(all_phone_numbers)
			if all_phone_numbers[1] == nil then
			else
				for k,v in pairs(all_phone_numbers) do
					if not phone_numbers[v.phone_number] then
						phone_numbers[v.phone_number] = v.identifier
						phone_numbers_online[v.phone_number] = false
					end
				end
			end
		end)
		updatePhone()
    end)
end
updatePhone()
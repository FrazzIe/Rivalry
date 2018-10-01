--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
local has_phone = true
local user_phone = {}
local phone_open = false
local current_page = ""
local back_page = ""

local current_call = nil
local current_call_channel = nil
local answered = false
local caller = ""
local onhold = false
local call_status = ""

local controller = false

local function drawNotification(text, icon, sender, subject)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	SetNotificationMessage(icon, icon, true, 1, sender, subject, text)
	DrawNotification(false, true)
end

local function drawText(text, font, x , y, scale, r, g, b, a, shadow, outline)
    SetTextColour(r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    if shadow then
        SetTextDropShadow(2, 2, 0, 0, 0)
    end    
    if outline then
        SetTextOutline()
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x,y)
end

local function getMax(T)
	local max = 0
	for k,v in pairs(T) do
		if k > max then
			max = k
		end
	end
	return max
end

local function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

local function openPhone()
	if IsPlayerDead(PlayerId()) then
		return
	end
	local dict = "cellphone@"
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		dict = dict .. "in_car@ds"
	end

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end

	SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
	TaskPlayAnim(GetPlayerPed(-1), dict, "cellphone_text_in", 4.0, -1, -1, 50, 0, false, false, false)
end

local function closePhone()
	if IsPlayerDead(PlayerId()) then
		return
	end

	local dict = "cellphone@"
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		dict = dict .. "in_car@ds"
	end

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end

	SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
	TaskPlayAnim(PlayerPedId(), dict, "cellphone_text_out", 4.0, -1, -1, 50, 0, false, false, false)
	Citizen.Wait(700)
	StopAnimTask(PlayerPedId(), dict, "cellphone_text_out", 1.0)
end

local function Notify(Message, Time)
	exports.pNotify:SendNotification({text = Message or "", type = "error", timeout = Time or 3000, layout = "centerRight", queue = "left"})
end

function PlayerHasPhone()
	return has_phone
end

function PlayerSetPhone(value)
	if type(value) == "boolean" then
		has_phone = value
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsEntityDead(PlayerPedId()) then
			if phone_open then
				if current_page ~= "lifealert" then
					phone_open = false
					current_page = "home"
					back_page = ""
					SetNuiFocus(false, false)
					SendNUIMessage({open_phone = false})
					SetPlayerControl(PlayerId(), 1, 0)					
				end
			end
		end
	end
end)

RegisterNetEvent("phone:set")
AddEventHandler("phone:set", function(value)
	PlayerSetPhone(value)
end)

RegisterNetEvent("interaction:controller")
AddEventHandler("interaction:controller", function()
	controller = not controller
end)

RegisterNetEvent("phone:initialise")
AddEventHandler("phone:initialise", function(_phone)
	user_phone = _phone

	for k,v in pairs(user_phone.contacts) do
		user_phone.contact_names[v.phone_number] = v.first_name.." "..v.last_name
	end

	for k,v in pairs(user_phone.messages.sent) do
		user_phone.messages.sorted[v.target_number] = {}
		for i,j in pairs(user_phone.messages.sent) do
			if v.target_number == j.target_number then
				user_phone.messages.sorted[v.target_number][j.id] = j
			end
		end
	end
	
	for k,v in pairs(user_phone.messages.received) do
		if not user_phone.messages.sorted[v.source_number] then
			user_phone.messages.sorted[v.source_number] = {}
		end
		for i,j in pairs(user_phone.messages.received) do
			if v.source_number == j.source_number then
				user_phone.messages.sorted[v.source_number][j.id] = j
			end
		end
	end

	TriggerServerEvent("phone:setup_complete", user_phone)
end)

RegisterNetEvent("phone:contact_add")
AddEventHandler("phone:contact_add", function(_phone, duplicate)
	user_phone = _phone
	if phone_open then
		if not duplicate then
			if current_page == "contacts" then
				SendNUIMessage({open_contacts = true, contacts = user_phone.contacts})
			end
		else
			SendNUIMessage({alert = true, alert_message = "Error: this contact already exists!"})
		end
	end
end)

RegisterNetEvent("phone:message_add")
AddEventHandler("phone:message_add", function(_phone, _ripnumber, _receiver, source_number, target_number)
	user_phone = _phone
	if _ripnumber then
		if phone_open then
			SendNUIMessage({alert = true, alert_message = "The message was not sent as the number does not exist!"})
		end
	end
	if _receiver then
		local sender = user_phone.contact_names[source_number] or source_number
		drawNotification(user_phone.messages.received[tablelength(user_phone.messages.received)].message, "CHAR_CHAT_CALL", sender, "New message")
		if phone_open then
			if current_page == "sub_messages_"..source_number then
				local sub_messages = {}
				for i = 1, getMax(user_phone.messages.sorted[source_number]) do
					if user_phone.messages.sorted[source_number][i] ~= nil then
						table.insert(sub_messages, user_phone.messages.sorted[source_number][i])
					end
				end
				SendNUIMessage({open_sub_messages = true, messages = sub_messages})
			elseif current_page == "messages" then
				local latest_messages = {}
				for k,v in pairs(user_phone.messages.sorted) do
					local latest_message = getMax(user_phone.messages.sorted[k])
					local name = user_phone.contact_names[k] or k
					if user_phone.messages.sorted[k][latest_message] then
						table.insert(latest_messages, {id = latest_message, phone_number = k, sender = name, message = user_phone.messages.sorted[k][latest_message].message})
					end
				end
				SendNUIMessage({open_messages = true, latest_messages = latest_messages})
			end
		end
	else
		local receiver = user_phone.contact_names[target_number] or target_number
		drawNotification(user_phone.messages.sent[tablelength(user_phone.messages.sent)].message, "CHAR_CHAT_CALL", receiver, "Message sent")
		if phone_open then
			if current_page == "sub_messages_"..target_number then
				local sub_messages = {}
				for i = 1, getMax(user_phone.messages.sorted[target_number]) do
					if user_phone.messages.sorted[target_number][i] ~= nil then
						table.insert(sub_messages, user_phone.messages.sorted[target_number][i])
					end
				end
				SendNUIMessage({open_sub_messages = true, messages = sub_messages})
			elseif current_page == "messages" then
				local latest_messages = {}
				for k,v in pairs(user_phone.messages.sorted) do
					local latest_message = getMax(user_phone.messages.sorted[k])
					local name = user_phone.contact_names[k] or k
					if user_phone.messages.sorted[k][latest_message] then
						table.insert(latest_messages, {id = latest_message, phone_number = k, sender = name, message = user_phone.messages.sorted[k][latest_message].message})
					end
				end
				SendNUIMessage({open_messages = true, latest_messages = latest_messages})
			end
		end
	end
end)

RegisterNetEvent("phone:call")
AddEventHandler("phone:call", function(_message)
	call_status = _message
	if phone_open then
		if current_page == "call" then
			SendNUIMessage({open_dial = true, message = _message})
		else
			SendNUIMessage({update_call = true, message = _message})
		end
	else
		SendNUIMessage({update_call = true, message = _message})
	end
	drawNotification("", "CHAR_CHAT_CALL", caller, _message)
end)

RegisterNetEvent("phone:request")
AddEventHandler("phone:request", function(source_number, _source)
	current_call = source_number
	current_call_channel = source_number+10000000000
	caller = user_phone.contact_names[source_number] or source_number
	if exports.core_modules:IsInJail() or exports.policejob:getIsCuffed() or exports.core_modules:isCuffed() or not has_phone then
		SendNUIMessage({update_call = true, message = "The call was cancelled", start = false})
		TriggerServerEvent("phone:cancel", current_call, current_call_channel)
		current_call_channel = nil
		current_call = nil
		answered = false
	else
		Citizen.CreateThread(function()
			while current_call and not answered do
				Citizen.Wait(500)
				PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
				Citizen.Wait(750)
				PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
				if exports.core_modules:IsInJail() or exports.policejob:getIsCuffed() or exports.core_modules:isCuffed() or not has_phone then
					SendNUIMessage({update_call = true, message = "The call was cancelled", start = false})
					TriggerServerEvent("phone:cancel", current_call, current_call_channel)
					current_call_channel = nil
					current_call = nil
					answered = false
				end
			end
		end)
		if phone_open then
			if current_page == "call" then
				SendNUIMessage({open_dial_answer = true, caller_id = caller, start = true})
			else
				SendNUIMessage({update_call = true, message = "Dialing..", start = true})
			end
		else
			SendNUIMessage({update_call = true, message = "Dialing..", start = true})
		end
		drawNotification("", "CHAR_CHAT_CALL", caller, "Incoming call")
	end
end)

RegisterNetEvent("phone:cancel")
AddEventHandler("phone:cancel", function()
	current_call = nil
	current_call_channel = nil
	answered = false
	onhold = false
	call_status = ""
	if phone_open then
		if current_page == "call" then
			SendNUIMessage({update_call = true, message = "The call was cancelled", start = false})
			SendNUIMessage({open_call = true, contacts = user_phone.contacts})
		else
			SendNUIMessage({update_call = true, message = "The call was cancelled", start = false})
		end
	else
		SendNUIMessage({update_call = true, message = "The call was cancelled", start = false})
	end
	drawNotification("", "CHAR_CHAT_CALL", caller, "Call ended")
	NetworkSetVoiceChannel(nil)
	NetworkClearVoiceChannel()
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("phone:answer")
AddEventHandler("phone:answer", function(_vc)
	call_status = "Active"
	current_call_channel = _vc+10000000000
	NetworkSetVoiceChannel(_vc+10000000000)
	if voice_channel == user_phone.phone_number then
		if phone_open then
			if current_page == "call" then
				SendNUIMessage({open_dial = true, message = "Active"})
			else
				SendNUIMessage({update_call = true, message = "Active"})
			end
		else
			SendNUIMessage({update_call = true, message = "Active"})
		end
	else
		if phone_open then
			if current_page == "call" then
				SendNUIMessage({open_dial = true, message = "Active"})
			else
				SendNUIMessage({update_call = true, message = "Active"})
			end
		else
			SendNUIMessage({update_call = true, message = "Active"})
		end
	end
end)

AddEventHandler("phone:open", function()
	if not IsEntityDead(PlayerPedId()) then
		if has_phone then
			openPhone()
			phone_open = true
			back_page = ""
			current_page = "home"
			SendNUIMessage({open_phone = true, phone_number = user_phone.phone_number})
			SetNuiFocus(true, true)
		end
	end
end)

AddEventHandler("phone:close", function()
	phone_open = false
	current_page = "home"
	back_page = ""
	SendNUIMessage({open_phone = false})
	SetNuiFocus(false, false)
	if not IsEntityDead(PlayerPedId()) then
		closePhone()
	end
end)

AddEventHandler("phone:lifealert", function()
	phone_open = true
	back_page = ""
	current_page = "lifealert"
	SetPlayerControl(PlayerId(), 0, 0)
	SendNUIMessage({lifealert = true, officer = officer, phone_number = user_phone.phone_number})
	SetNuiFocus(true, true)
end)

RegisterNUICallback("escape", function(data)
	phone_open = false
	current_page = "home"
	back_page = ""
	SendNUIMessage({open_phone = false})
	SetPlayerControl(PlayerId(), 1, 0)
	SetNuiFocus(false, false)
	closePhone()
end)

RegisterNUICallback("back", function(data)
	if back_page == "messages" then
		back_page = "home"
		current_page = "messages"
		local latest_messages = {}
		for k,v in pairs(user_phone.messages.sorted) do
			local latest_message = getMax(user_phone.messages.sorted[k])
			local name = user_phone.contact_names[k] or k
			if user_phone.messages.sorted[k][latest_message] then
				table.insert(latest_messages, {id = latest_message, phone_number = k, sender = name, message = user_phone.messages.sorted[k][latest_message].message})
			end
		end
		SendNUIMessage({open_messages = true, latest_messages = latest_messages})
	elseif back_page == "sub_messages" then
		back_page = "messages"
		current_page = "sub_messages_"..data.phone_number
		local sub_messages = {}
		for i = 1, getMax(user_phone.messages.sorted[data.phone_number]) do
			if user_phone.messages.sorted[data.phone_number][i] ~= nil then
				table.insert(sub_messages, user_phone.messages.sorted[data.phone_number][i])
			end
		end
		SendNUIMessage({open_sub_messages = true, messages = sub_messages})
	elseif back_page == "contacts" then
		back_page = "home"
		current_page = "contacts"
		SendNUIMessage({open_contacts = true, contacts = user_phone.contacts})
	elseif back_page == "new_messages" then
		back_page = "home"
		current_page = "new_message"
		SendNUIMessage({open_new_messages = true})
	elseif back_page == "home" then
		back_page = ""
		SendNUIMessage({open_phone = true, phone_number = user_phone.phone_number})
	elseif back_page == "services" then
		back_page = "home"
		current_page = "services"
		SendNUIMessage({services = true})
	elseif back_page == "service_police" then
		back_page = "services"
		current_page = "service_police"
		SendNUIMessage({service_police = true})
	elseif back_page == "service_ems" then
		back_page = "services"
		current_page = "service_ems"
		SendNUIMessage({service_ems = true})
	elseif back_page == "service_taxi" then
		back_page = "services"
		current_page = "service_taxi"
		SendNUIMessage({service_taxi = true})
	elseif back_page == "service_mechanic" then
		back_page = "services"
		current_page = "service_mechanic"
		SendNUIMessage({service_mechanic = true})
	elseif back_page == "other_services" then
		back_page = "home"
		current_page = "other_services"
		SendNUIMessage({other_services = true})
	else
		phone_open = false
		current_page = "home"
		back_page = ""
		SetNuiFocus(false, false)
		SendNUIMessage({open_phone = false})
		SetPlayerControl(PlayerId(), 1, 0)
		closePhone()
	end
end)

RegisterNUICallback("open", function(data)
	if data.type == "messages" then
		back_page = "home"
		current_page = "messages"
		local latest_messages = {}
		for k,v in pairs(user_phone.messages.sorted) do
			local latest_message = getMax(user_phone.messages.sorted[k])
			local name = user_phone.contact_names[k] or k
			if user_phone.messages.sorted[k][latest_message] then
				table.insert(latest_messages, {id = latest_message, phone_number = k, sender = name, message = user_phone.messages.sorted[k][latest_message].message})
			end
		end
		SendNUIMessage({open_messages = true, latest_messages = latest_messages})
	elseif data.type == "sub_messages" then
		back_page = "messages"
		current_page = "sub_messages_"..data.phone_number
		local sub_messages = {}
		for i = 1, getMax(user_phone.messages.sorted[data.phone_number]) do
			if user_phone.messages.sorted[data.phone_number][i] ~= nil then
				table.insert(sub_messages, user_phone.messages.sorted[data.phone_number][i])
			end
		end
		SendNUIMessage({open_sub_messages = true, messages = sub_messages})
	elseif data.type == "contacts" then
		back_page = "home"
		current_page = "contacts"
		SendNUIMessage({open_contacts = true, contacts = user_phone.contacts, add = data.add or false})
	elseif data.type == "new_messages" then
		back_page = "home"
		current_page = "new_message"
		SendNUIMessage({open_new_messages = true})
	elseif data.type == "services" then
		back_page = "home"
		current_page = "services"
		SendNUIMessage({services = true})	
	elseif data.type == "service_police" then
		back_page = "services"
		current_page = "service_police"
		SendNUIMessage({service_police = true})
	elseif data.type == "service_ems" then
		back_page = "services"
		current_page = "service_ems"
		SendNUIMessage({service_ems = true})
	elseif data.type == "service_taxi" then
		back_page = "services"
		current_page = "service_taxi"
		SendNUIMessage({service_taxi = true})
	elseif data.type == "service_mechanic" then
		back_page = "services"
		current_page = "service_mechanic"
		SendNUIMessage({service_mechanic = true})
	elseif data.type == "other_services" then
		back_page = "home"
		current_page = "other_services"
		SendNUIMessage({other_services = true})
	elseif data.type == "other_service_helix" then
		back_page = "other_services"
		current_page = "other_service_helix"
		SendNUIMessage({other_service_helix = true})
	elseif data.type == "call" then
		back_page = "home"
		current_page = "call"
		if current_call and answered then
			SendNUIMessage({open_dial = true, message = current_message})
		elseif current_call and not answered then
			SendNUIMessage({open_dial_answer = true, caller_id = caller})
		else
			SendNUIMessage({open_call = true, contacts = user_phone.contacts})
		end
	end
end)

RegisterNUICallback("add", function(data)
	if data.type == "contact" then
		TriggerServerEvent("phone:contact_add", data.phone_number, data.first_name, data.last_name)
	elseif data.type == "message" then
		TriggerServerEvent("phone:message_add", data.phone_number, data.message)
	end
end)

RegisterNUICallback("remove", function(data)
	if data.type == "contact" then
		for k,v in pairs(user_phone.contacts) do
			if v.id == data.id then
				user_phone.contact_names[v.phone_number] = nil
				table.remove(user_phone.contacts, k)
			end
		end
		if phone_open then
			if current_page == "contacts" then
				SendNUIMessage({open_contacts = true, contacts = user_phone.contacts})
			end
		end
		TriggerServerEvent("phone:contact_remove", data.id, user_phone)
	elseif data.type == "messages" then
		if user_phone.messages.sorted[data.phone_number] then
			if user_phone.messages.sorted[data.phone_number][data.id] then
				user_phone.messages.sorted[data.phone_number][data.id] = nil
			end
		end
		local sub_messages = {}
		for i = 1, getMax(user_phone.messages.sorted[data.phone_number]) do
			if user_phone.messages.sorted[data.phone_number][i] ~= nil then
				table.insert(sub_messages, user_phone.messages.sorted[data.phone_number][i])
			end
		end
		if phone_open then
			if current_page == "sub_messages_"..data.phone_number then
				SendNUIMessage({open_sub_messages = true, messages = sub_messages})
			end
		end
		TriggerServerEvent("phone:message_remove", data.id, user_phone)
	end
end)

RegisterNUICallback("service", function(data)
	if data.type == "police" then
		TriggerEvent('police:callPoliceCustom', data.report)
	elseif data.type == "ems" then
		TriggerEvent('paramedic:callAmbulanceCustom', data.report)
	elseif data.type == "taxi" then
		TriggerEvent("taxi:callService", data.report)
	elseif data.type == "mechanic" then
		TriggerEvent("mechanic:callMechanic", data.report)
	end
end)

RegisterNUICallback("other_service", function(data)
	if data.type == "weed" then
		TriggerEvent("weed:setuptrader")
	end
end)

RegisterNUICallback("cancel", function(data)
	if data.type == "police" then
		TriggerEvent("police:cancelCall")
	elseif data.type == "ems" then
		TriggerEvent("paramedic:cancelCall")
	elseif data.type == "taxi" then
		TriggerEvent("taxi:cancelCall")
	elseif data.type == "mechanic" then
		TriggerEvent("mechanic:cancelCall")
	elseif data.type == "weed" then
		TriggerEvent("weed:canceltrader")
	end	
end)

RegisterNUICallback("lifealert", function(data)
	if data.type == "ambulance" then
		if not has_phone then
			Notify("As you technically don't have your phone you can only respawn...", 3000)
		else
			TriggerEvent("paramedic:callAmbulance", "is in a coma!")
			phone_open = false
			current_page = "home"
			back_page = ""
			SetNuiFocus(false, false)
			SendNUIMessage({open_phone = false})
			SetPlayerControl(PlayerId(), 1, 0)
		end
	elseif data.type == "respawn" then
		TriggerEvent("paramedic:respawnCheck")
		phone_open = false
		current_page = "home"
		back_page = ""
		SetNuiFocus(false, false)
		SendNUIMessage({open_phone = false})
		SetPlayerControl(PlayerId(), 1, 0)
	end
end)

RegisterNUICallback("call", function(data)
	if data.type == "start" then
		current_call_channel = user_phone.phone_number
		call_status = "Dialing..."
		current_call = data.phone_number
		answered = true
		caller = user_phone.contact_names[data.phone_number] or data.phone_number
		SendNUIMessage({open_dial = true, message = "Dialing...", start = true})
		current_page = "call"
		back_page = "home"
		TriggerServerEvent("phone:call", data.phone_number)
	elseif data.type == "cancel" then
		SendNUIMessage({open_dial = true, message = "The call was cancelled", start = false})
		TriggerServerEvent("phone:cancel", current_call, current_call_channel)
		current_call_channel = nil
		current_call = nil
		answered = false
		current_page = "call"
		back_page = "home"
	elseif data.type == "answer" then
		if not answered then
			answered = true
			if phone_open then
				if current_page == "call" then
					SendNUIMessage({open_dial = true, message = "Active"})
				else
					SendNUIMessage({update_call = true, message = "Active"})
				end
			else
				SendNUIMessage({update_call = true, message = "Active"})
			end
			TriggerServerEvent("phone:answer", current_call)
		end
	end
end)

Citizen.CreateThread(function()
	local first_tick = true
	RequestAnimDict("cellphone@str")
	while not HasAnimDictLoaded("cellphone@str") do
		Citizen.Wait(1)
	end
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 289) and IsInputDisabled(2) and not controller and not IsPedFalling(PlayerPedId()) and not exports.core_modules:IsInJail() and not exports.policejob:getIsCuffed() and not exports.core_modules:isCuffed() then --F2
			if IsEntityDead(PlayerPedId()) then
				TriggerEvent("phone:lifealert")
			else
				if has_phone then
					TriggerEvent("phone:open")
				end
			end
		end
		if phone_open then
            if first_tick then
                first_tick = false
                TriggerEvent("chat:close")
            end
			DisableControlAction(0, 245, phone_open)
		else
			first_tick = true
		end
		if current_call and answered and current_call_channel then
			if not onhold and not IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "cellphone@str", "cellphone_call_listen_a", 3) then
				TaskPlayAnim(GetPlayerPed(PlayerId()), "cellphone@str", "cellphone_call_listen_a", 8.0, -8, -1, 49, 0, 0, 0, 0)
				SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
			end
			if onhold then
				drawText("[~y~F1~w~]Call with ~y~"..caller..": ~r~On hold ~w~/ ~b~"..call_status, 6, 0.015, 0.77, 0.35, 255, 255, 255, 255, false, true)
			else
				drawText("[~y~F1~w~]Call with ~y~"..caller..": ~g~Active ~w~/ ~b~"..call_status, 6, 0.015, 0.77, 0.35, 255, 255, 255, 255, false, true)
			end
			if IsControlJustPressed(1, 288) and IsInputDisabled(2) and not controller then --F1
				if not onhold then
					ClearPedTasks(PlayerPedId())
					onhold = true
					TriggerServerEvent("phone:onhold", current_call, true)
					NetworkClearVoiceChannel()
				else
					onhold = false
					TriggerServerEvent("phone:onhold", current_call, false)
					NetworkSetVoiceChannel(current_call_channel)
				end
			end
			if IsEntityDead(PlayerPedId()) or not has_phone then
				TriggerServerEvent("phone:cancel", current_call, current_call_channel)
				current_call_channel = nil
				current_call = nil
				answered = false
			end
		end
	end
end)
--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
Phone = {
	Data = {},
	Conversation = {},
	Open = false,
	Page = {
		Current = "",
		Previous = "",
	},
	Call = {
		Number = nil,
		Channel = nil,
		Answered = false,
		Hold = false,
		Caller = "",
		Status = "",
	},
	Animations = {
		Dictionary = {
			Normal = "cellphone@",
			Vehicle = "cellphone@in_car@ds",
			Call = "cellphone@str",
		},
		Open = "cellphone_text_in",
		Close = "cellphone_text_out",
		Call = "cellphone_call_listen_a",
	}
}

Citizen.CreateThread(function()
	for Type, Dictionary in pairs(Phone.Animations.Dictionary) do
		RequestAnimDict(Dictionary)

		while not HasAnimDictLoaded(Dictionary) do
			Citizen.Wait(150)
		end
	end

	Citizen.Trace("Phone: Loaded animations!")
end)

function Phone:DisplayNotification(Text, Icon, Sender, Subject)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(Text)
	SetNotificationMessage(Icon, Icon, true, 1, Sender, Subject, Text)
	DrawNotification(false, true)
end

function Phone:RenderText(Text, X, Y, Font, Scale, R, G, B, A, Alignment, DropShadow, Outline, WordWrap)
	local Text, X, Y = tostring(Text), (tonumber(X) or 0)/1920, (tonumber(Y) or 0)/1080

    SetTextFont(Font or 0)
    SetTextScale(1.0, Scale or 0)
    SetTextColour(tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)

    if DropShadow then
        SetTextDropShadow()
    end

    if Outline then
        SetTextOutline()
    end

    if Alignment ~= nil then
        if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
            SetTextCentre(true)
        elseif Alignment == 2 or Alignment == "Right" then
            SetTextRightJustify(true)
        end
    end

    if tonumber(WordWrap) and tonumber(WordWrap) ~= 0 then
        if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
        	SetTextWrap(X - ((WordWrap/1920)/2), X + ((WordWrap/1920)/2))
        elseif Alignment == 2 or Alignment == "Right" then
        	SetTextWrap(0, X)
        else
        	SetTextWrap(X, X + (WordWrap/1920))
        end
    else
        if Alignment == 2 or Alignment == "Right" then
        	SetTextWrap(0, X)
        end
    end

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(Text) 
    EndTextCommandDisplayText(X, Y)
end

function Phone:Toggle(Display)
	local PlayerPed = PlayerPedId()
	local Dead = IsEntityDead(PlayerPed)

	if Display then
		if self.Data.Has then
			self.Open = true
		else
			self.Open = false
		end
	else
		self.Open = false
	end

	self:Animation(PlayerPed, Dead)

	if Dead and self.Open then
		self.Page.Current = "lifealert"
		self.Page.Back = ""

		SendNUIMessage({lifealert = true, phone_number = self.Data.Number})
	else
		self.Page.Current = "home"
		self.Page.Back = ""

		SendNUIMessage({open_phone = self.Open, phone_number = self.Data.Number})
	end

	SetNuiFocus(self.Open, self.Open)
end

function Phone:Animation(PlayerPed, Dead)
	if not Dead then
		local Dictionary = self.Animations.Dictionary[(IsPedInAnyVehicle(PlayerPed, false) and "Vehicle" or "Normal")]

		SetPedCurrentweapon(PlayerPed, "WEAPON_UNARMED", true)

		if self.Open then
			TaskPlayAnim(PlayerPed, Dictionary, self.Animations.Open, 4.0, -1, -1, 50, 0, false, false, false)
		else
			TaskPlayAnim(PlayerPed, Dictionary, self.Animations.Close, 4.0, -1, -1, 50, 0, false, false, false)
			Citizen.Wait(700)
			StopAnimTask(PlayerPed, Dictionary, self.Animations.Close, 1.0)
		end
	end
end

function Phone:DoesConversationMessageExist(Id)
	for Index = 1, #self.Conversation.Messages do
		if self.Conversation.Messages[Index].id == Id then
			return true
		end
	end

	return false
end

function Phone:GetLatestMessages()
	local Messages = {}

	for Number, Message in pairs(self.Data.Messages) do
		table.insert(Messages, {sender = Phone.Data.ContactNames[Number] or Number, message = Message, phone_number = Number})
	end

	return Messages
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()

		if IsEntityDead(PlayerPed) then
			if Phone.Open then
				if Phone.Page.Current ~= "lifealert" then
					Phone:Toggle(false)
				end
			end
		end
	end
end)

RegisterNetEvent("Phone.Start")
AddEventHandler("Phone.Start", function(Data)
	local Messages = {}

	Data.ContactNames = {}

	for Index = 1, #Data.Contacts do
		Data.ContactNames[Data.Contacts[Index].phone_number] = Data.Contacts[Index].first_name.." "..Data.Contacts[Index].last_name
	end

	for Index = 1, #Data.Messages do
		Messages[Data.Messages[Index].receiver_number] = Data.Messages[Index].message
	end

	Data.Messages = Messages

	Phone.Data = Data

	TriggerServerEvent("Phone.End", Data)
end)

RegisterNetEvent("Phone.Contact.Add")
AddEventHandler("Phone.Contact.Add", function(Data)
	Phone.Data.Contacts = Data.Contacts

	if Phone.Open then
		if Phone.Page.Current == "contacts" then
			SendNUIMessage({open_contacts = true, contacts = Data.Contacts})
		end
	end
end)

RegisterNetEvent("Phone.Message.Add")
AddEventHandler("Phone.Message.Add", function(Exists, Received, Number, Message, Data)
	Phone.Data.Messages = Data
	if not Exists then
		if Phon.Open then
			SendNUIMessage({alert = true, alert_message = "The message was not sent as the number does not exist!"})
		end
	else
		if Received then
			local Sender = Phone.ContactNames[Number] or Number

			Phone:DisplayNotification(Message.message, "CHAR_CHAT_CALL", Sender, "New message")

			if Phone.Open then
				if Phone.Page.Current == "sub_messages_"..Number then
					if Phone.Conversation then
						if Phone.Conversation.Number == Number then
							if Message.id then
								if not Phone:DoesConversationMessageExist(Message.id) then
									table.insert(Phone.Conversation.Messages, Message)
								end
							end
						end

						SendNUIMessage({open_sub_messages = true, messages = Phone.Conversation.Messages})
					end
				elseif current_page == "messages" then
					SendNUIMessage({open_messages = true, latest_messages = GetLatestMessages()})
				end
			end
		else
			local Receiver = Phone.ContactNames[Number] or Number

			Phone:DisplayNotification(Message.message, "CHAR_CHAT_CALL", Receiver, "Message sent")

			if Phone.Open then
				if Phone.Page.Current == "sub_messages_"..Number then
					if Phone.Conversation then
						if Phone.Conversation.Number == Number then
							if Message.id then
								if not Phone:DoesConversationMessageExist(Message.id) then
									table.insert(Phone.Conversation.Messages, Message)
								end
							end
						end

						SendNUIMessage({open_sub_messages = true, messages = Phone.Conversation.Messages})
					end
				elseif current_page == "messages" then
					SendNUIMessage({open_messages = true, latest_messages = GetLatestMessages()})
				end
			end
		end
	end
end)

RegisterNetEvent("Phone.Call.Status")
AddEventHandler("Phone.Call.Status", function(Status)
	Phone.Call.Status = Status

	if Phone.Open then
		if Phone.Page.Current == "call" then
			SendNUIMessage({open_dial = true, message = Status})
		else
			SendNUIMessage({update_call = true, message = Status})
		end
	else
		SendNUIMessage({update_call = true, message = Status})
	end

	Phone:DisplayNotification("", "CHAR_CHAT_CALL", Phone.Call.Caller, Status)
end)

RegisterNetEvent("Phone.Call.Request")
AddEventHandler("Phone.Call.Request", function(Number, Source)
	Phone.Call.Number = Number
	Phone.Call.Channel = Number
	Phone.Call.Caller = Phone.Data.ContactNames[Number] or Number

	if exports.core_modules:IsInJail() or exports.policejob:getIsCuffed() or exports.core_modules:isCuffed() or not Phone.Data.Has then
		SendNUIMessage({update_call = true, message = "The call was cancelled", start = false})

		TriggerServerEvent("Phone.Call.End", Phone.Call.Number, Phone.Call.Channel)

		Phone.Call.Number = nil
		Phone.Call.Channel = nil
		Phone.Call.Answered = false
	else
		Citizen.CreateThread(function()
			while Phone.Call.Number and not Phone.Call.Answered do
				Citizen.Wait(500)
				PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
				Citizen.Wait(750)
				PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)

				if exports.core_modules:IsInJail() or exports.policejob:getIsCuffed() or exports.core_modules:isCuffed() or not Phone.Data.Has then
					SendNUIMessage({update_call = true, message = "The call was cancelled", start = false})
					
					TriggerServerEvent("Phone.Call.End", Phone.Call.Number, Phone.Call.Channel)

					Phone.Call.Number = nil
					Phone.Call.Channel = nil
					Phone.Call.Answered = false
				end
			end
		end)

		if Phone.Open then
			if Phone.Page.Current == "call" then
				SendNUIMessage({open_dial_answer = true, caller_id = Phone.Call.Caller, start = true})
			else
				SendNUIMessage({update_call = true, message = "Dialing..", start = true})
			end
		else
			SendNUIMessage({update_call = true, message = "Dialing..", start = true})
		end

		Phone:DisplayNotification("", "CHAR_CHAT_CALL", Phone.Call.Caller, "Incoming call")
	end
end)

RegisterNetEvent("Phone.Call.End")
AddEventHandler("Phone.Call.End", function()
	Phone.Call.Number = nil
	Phone.Call.Channel = nil
	Phone.Call.Answered = false
	Phone.Call.Hold = false
	Phone.Call.Status = ""

	if Phone.Open then
		if Phone.Page.Current == "call" then
			SendNUIMessage({update_call = true, message = "The call was cancelled", start = false})
			SendNUIMessage({open_call = true, contacts = Phone.Data.Contacts})
		else
			SendNUIMessage({update_call = true, message = "The call was cancelled", start = false})
		end
	else
		SendNUIMessage({update_call = true, message = "The call was cancelled", start = false})
	end

	Phone:DisplayNotification("", "CHAR_CHAT_CALL", Phone.Call.Caller, "Call ended")

	Phone.Call.Caller = ""

	NetworkSetVoiceChannel(nil)
	NetworkClearVoiceChannel()
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("Phone.Call.Answer")
AddEventHandler("Phone.Call.Answer", function(Channel)
	Phone.Call.Status = "Active"
	Phone.Call.Channel = Channel
	
	NetworkSetVoiceChannel(tonumber(Channel))


	if Phone.Open and Phone.Page.Current == "call" then
		SendNUIMessage({open_dial = true, message = "Active"})
	else
		SendNUIMessage({update_call = true, message = "Active"})
	end
end)

RegisterNetEvent("Phone.Conversation.Set")
AddEventHandler("Phone.Conversation.Set", function(Number, Messages)
	Phone.Conversation.Number = Number
	Phone.Conversation.Messages = Messages
	
	if Phone.Open then
		if Phone.Page.Current == "loader" then
			Phone.Page.Previous = "messages"
			Phone.Page.Current = "sub_messages_"..Number

			SendNUIMessage({open_sub_messages = true, messages = Messages})
		end
	end
end)

RegisterNUICallback("escape", function(data)
	Phone:Toggle(false)
end)

RegisterNUICallback("back", function(data)
	if Phone.Page.Previous == "messages" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "messages"
		Phone.Conversation.Number = nil
		Phone.Conversation.Messages = {}
		
		SendNUIMessage({open_messages = true, latest_messages = GetLatestMessages()})
	elseif Phone.Page.Previous == "contacts" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "contacts"

		SendNUIMessage({open_contacts = true, contacts = Phone.Data.Contacts})
	elseif Phone.Page.Previous == "new_messages" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "new_message"

		SendNUIMessage({open_new_messages = true})
	elseif Phone.Page.Previous == "home" then
		Phone.Page.Previous = ""
		SendNUIMessage({open_phone = true, phone_number = Phone.Data.Number})
	elseif Phone.Page.Previous == "services" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "services"

		SendNUIMessage({services = true})
	elseif Phone.Page.Previous == "service_police" then
		Phone.Page.Previous = "services"
		Phone.Page.Current = "service_police"

		SendNUIMessage({service_police = true})
	elseif Phone.Page.Previous == "service_ems" then
		Phone.Page.Previous = "services"
		Phone.Page.Current = "service_ems"

		SendNUIMessage({service_ems = true})
	elseif Phone.Page.Previous == "service_taxi" then
		Phone.Page.Previous = "services"
		Phone.Page.Current = "service_taxi"

		SendNUIMessage({service_taxi = true})
	elseif Phone.Page.Previous == "service_mechanic" then
		Phone.Page.Previous = "services"
		Phone.Page.Current = "service_mechanic"

		SendNUIMessage({service_mechanic = true})
	elseif Phone.Page.Previous == "other_services" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "other_services"

		SendNUIMessage({other_services = true})
	else
		Phone:Toggle(false)
	end
end)

RegisterNUICallback("open", function(data)
	if data.type == "messages" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "messages"

		SendNUIMessage({open_messages = true, latest_messages = GetLatestMessages()})
	elseif data.type == "loader" then
		Phone.Page.Previous = "messages"
		Phone.Page.Current = "loader"

		SendNUIMessage({open_loader = true})

		TriggerServerEvent("Phone.Conversation.Get", data.phone_number)
	elseif data.type == "contacts" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "contacts"

		SendNUIMessage({open_contacts = true, contacts = Phone.Data.Contacts, add = data.add or false})
	elseif data.type == "new_messages" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "new_message"

		SendNUIMessage({open_new_messages = true})
	elseif data.type == "services" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "services"

		SendNUIMessage({services = true})	
	elseif data.type == "service_police" then
		Phone.Page.Previous = "services"
		Phone.Page.Current = "service_police"

		SendNUIMessage({service_police = true})
	elseif data.type == "service_ems" then
		Phone.Page.Previous = "services"
		Phone.Page.Current = "service_ems"

		SendNUIMessage({service_ems = true})
	elseif data.type == "service_taxi" then
		Phone.Page.Previous = "services"
		Phone.Page.Current = "service_taxi"

		SendNUIMessage({service_taxi = true})
	elseif data.type == "service_mechanic" then
		Phone.Page.Previous = "services"
		Phone.Page.Current = "service_mechanic"

		SendNUIMessage({service_mechanic = true})
	elseif data.type == "other_services" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "other_services"

		SendNUIMessage({other_services = true})
	elseif data.type == "other_service_helix" then
		Phone.Page.Previous = "other_services"
		Phone.Page.Current = "other_service_helix"

		SendNUIMessage({other_service_helix = true})
	elseif data.type == "call" then
		Phone.Page.Previous = "home"
		Phone.Page.Current = "call"

		if Phone.Call.Number and Phone.Call.Answered then
			SendNUIMessage({open_dial = true, message = Phone.Call.Status})
		elseif current_call and not answered then
			SendNUIMessage({open_dial_answer = true, caller_id = Phone.Call.Caller})
		else
			SendNUIMessage({open_call = true, contacts = Phone.Data.Contacts})
		end
	end
end)

RegisterNUICallback("add", function(data)
	if data.type == "contact" then
		TriggerServerEvent("Phone.Contact.Add", data.phone_number, data.first_name, data.last_name)
	elseif data.type == "message" then
		TriggerServerEvent("Phone.Message.Add", data.phone_number, data.message)
	end
end)

RegisterNUICallback("remove", function(data)
	if data.type == "contact" then
		for Index = 1, #Phone.Data.Contacts do
			if Phone.Data.Contacts[Index].id == data.id then
				Phone.Data.ContactsNames[Phone.Data.Contacts[Index].phone_number] = nil

				table.remove(Phone.Data.Contacts, Index)

				break
			end
		end

		if Phone.Open then
			if Phone.Page.Current == "contacts" then
				SendNUIMessage({open_contacts = true, contacts = Phone.Data.Contacts})
			end
		end

		TriggerServerEvent("Phone.Contact.Remove", data.id, Phone.Data.Contacts)
	elseif data.type == "messages" then
		if Phone.Conversation then
			if Phone.Conversation.Messages then
				for Index = 1, #Phone.Conversation.Messages do
					if Phone.Conversation.Messages[Index].id == data.id then
						table.remove(Phone.Conversation.Messages, Index)

						break
					end
				end
			end
		end

		if Phone.Open then
			if Phone.Page.Current == "sub_messages_"..data.phone_number then
				SendNUIMessage({open_sub_messages = true, messages = Phone.Conversation.Messages})
			end
		end

		TriggerServerEvent("Phone.Message.Remove", data.id)
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
		if not Phone.Data.Has then
			Notify("As you technically don't have your phone you can only respawn...", 3000)
		else
			TriggerEvent("paramedic:callAmbulance", "is in a coma!")
			Phone:Toggle(false)
		end
	elseif data.type == "respawn" then
		TriggerEvent("paramedic:respawnCheck")
		Phone:Toggle(false)
	end
end)

RegisterNUICallback("call", function(data)
	if data.type == "start" then
		Phone.Call.Number = Phone.Data.Number
		Phone.Call.Channel = Phone.Data.Number
		Phone.Call.Status = "Dialing..."
		Phone.Call.Answered = true
		Phone.Call.Caller = Phone.Data.ContactNames[data.phone_number] or data.phone_number

		SendNUIMessage({open_dial = true, message = Phone.Call.Status, start = true})

		Phone.Page.Current = "call"
		Phone.Page.Previous = "home"

		TriggerServerEvent("Phone.Call.Start", data.phone_number)
	elseif data.type == "cancel" then
		SendNUIMessage({open_dial = true, message = "The call was cancelled", start = false})

		TriggerServerEvent("Phone.Call.End", Phone.Call.Number, Phone.Call.Channel)

		Phone.Call.Number = nil
		Phone.Call.Channel = nil
		Phone.Call.Answered = false
		Phone.Call.Status = ""

		Phone.Page.Current = "call"
		Phone.Page.Back = "home"
	elseif data.type == "answer" then
		if not Phone.Call.Answered then
			Phone.Call.Answered = true
			Phone.Call.Status = "Active"

			if Phone.Open and Phone.Page.Current then
				SendNUIMessage({open_dial = true, message = Phone.Call.Status})
			else
				SendNUIMessage({update_call = true, message = Phone.Call.Status})
			end

			TriggerServerEvent("Phone.Call.Answer", Phone.Call.Number)
		end
	end
end)

Citizen.CreateThread(function()
	local FirstTick = true
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()

		if IsControlJustPressed(0, 289) and IsInputDisabled(2) and not IsPedFalling(PlayerPed) and not exports.core_modules:IsInJail() and not exports.policejob:getIsCuffed() and not exports.core_modules:isCuffed() then -- F2
			Phone:Toggle(true)
		end

		if Phone.Open then
            if FirstTick then
                FirstTick = false

                TriggerEvent("chat:close")
            end

			DisableControlAction(0, 245, Phone.Open)
		else
			FirstTick = true
		end

		if Phone.Call.Number and Phone.Call.Answered and Phone.Call.Channel then
			if not Phone.Call.Hold and not IsEntityPlayingAnim(PlayerPed, Phone.Animations.Dictionary.Call, Phone.Animations.Call, 3) then
				TaskPlayAnim(PlayerPed, Phone.Animations.Dictionary.Call, Phone.Animations.Call, 8.0, -8, -1, 49, 0, 0, 0, 0)

				SetCurrentPedWeapon(PlayerPed, "WEAPON_UNARMED", true)
			end

			ScreenDrawPositionBegin(76, 84)
			ScreenDrawPositionRatio(0, 0, 0, 0)
			
			Phone:RenderText("[~y~F1~w~]Call with ~y~"..Phone.Call.Caller..": "..(Phone.Call.Hold and "~r~On hold" or "~g~Active").."~w~/ ~b~"..Phone.Call.Status, 6, 0.0, 831.6, 0.35, 255, 255, 255, 255, nil, false, true)

			ScreenDrawPositionEnd()

			if IsControlJustPressed(0, 288) and IsInputDisabled(2) then -- F1
				if not Phone.Call.Hold then
					ClearPedTasks(PlayerPed)

					Phone.Call.Hold = true

					TriggerServerEvent("Phone.Call.Hold", Phone.Call.Number, true)

					NetworkClearVoiceChannel()
				else
					Phone.Call.Hold = false

					TriggerServerEvent("Phone.Call.Hold", Phone.Call.Number, false)

					NetworkSetVoiceChannel(Phone.Call.Channel)
				end
			end

			if IsEntityDead(PlayerPed) or not Phone.Data.Has then
				Phone:Toggle(false)

				Phone.Call.Number = nil
				Phone.Call.Channel = nil
				Phone.Call.Answered = false
				Phone.Call.Hold = false
				Phone.Call.Status = ""
			end
		end
	end
end)
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
	LifeAlert = false,
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
	},
	ToggleTwitterNotifications = false,
}

local newContactCallback = nil
local messageCallback = nil
local getConversationCallback = nil

Citizen.CreateThread(function()
	for Type, Dictionary in pairs(Phone.Animations.Dictionary) do
		RequestAnimDict(Dictionary)

		while not HasAnimDictLoaded(Dictionary) do
			Citizen.Wait(150)
		end
	end

	Citizen.Trace("Phone: Loaded animations!")
end)

function Notify(Message, Time)
	exports.pNotify:SendNotification({text = Message or "", type = "error", timeout = Time or 3000, layout = "centerRight", queue = "left"})
end

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
		elseif not Dead then
			self.Open = false
		end
	else
		self.Open = false
	end

	if Dead and self.Open then
		self.LifeAlert = true
		SendNUIMessage({type = "toggleLifeAlert", payload = "true"})
	else
		self.LifeAlert = false
		SendNUIMessage({type = "togglePhone", payload = tostring(self.Open)})
	end

	SetNuiFocus(self.Open, self.Open)

	self:Animation(PlayerPed, Dead)
end

function Phone:Animation(PlayerPed, Dead)
	if not Dead then
		local Dictionary = self.Animations.Dictionary[(IsPedInAnyVehicle(PlayerPed, false) and "Vehicle" or "Normal")]

		SetCurrentPedWeapon(PlayerPed, "WEAPON_UNARMED", true)

		if self.Open then
			TriggerEvent("Phone.Use.Animations", Dictionary, self.Animations.Open)
		else
			TriggerEvent("Phone.Use.Animations", Dictionary, self.Animations.Open)
			Citizen.Wait(700)
			StopAnimTask(PlayerPed, Dictionary, self.Animations.Close, 1.0)
			TriggerEvent("Phone.Stop.Animations")
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

function Phone:DoesMessageExistFromNumber(Number)
	for Index = 1, #self.Phone.Data.Messages do
		if self.Phone.Data.Messages[Index].receiver_number == Number then
			return true, Index
		end
	end

	return false, nil
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()

		if IsEntityDead(PlayerPed) then
			if Phone.Open then
				if not Phone.LifeAlert then
					Phone:Toggle(false)
				end
			end
		end
	end
end)

RegisterNetEvent("Phone.Start")
AddEventHandler("Phone.Start", function(Data)
	Data.ContactNames = {}

	for Index = 1, #Data.Contacts do
		Data.ContactNames[Data.Contacts[Index].contact_number] = Data.Contacts[Index].first_name.." "..Data.Contacts[Index].last_name
	end

	Phone.Data = Data

	local saveData = GetResourceKvpString("phoneData")

	if saveData ~= nil and saveData ~= "" then
		SendNUIMessage({type = "loadSettings", payload = json.decode(saveData)})
	end

	SendNUIMessage({type = "setNumber", payload = Data.Number})
	SendNUIMessage({type = "setContacts", payload = Data.Contacts})
	SendNUIMessage({type = "setMessages", payload = Data.Messages})
	SendNUIMessage({type = "setConversation", payload = {}})

	TriggerServerEvent("Phone.Finish", Data.ContactNames)
end)

Citizen.CreateThread(function()
	local FirstTick = true
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()

		if IsControlJustPressed(0, 289) and IsInputDisabled(2) and not IsPedFalling(PlayerPed) and not exports.core_modules:IsInJail() and not exports.policejob:getIsCuffed() and not exports.core_modules:isCuffed() and not IsControlPressed(0, 21) then -- F2
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
				TriggerEvent("Phone.Use.Animations", "Call", "Animation")
				SetCurrentPedWeapon(PlayerPed, "WEAPON_UNARMED", true)
			end

	
			if not exports.core_modules:HudElementsDisabled() then
				ScreenDrawPositionBegin(76, 84)
				ScreenDrawPositionRatio(0, 0, 0, 0)

				if IsRadarEnabled() then
					Phone:RenderText("[~y~F1~w~]Call with ~y~"..Phone.Call.Caller..": "..(Phone.Call.Hold and "~r~On hold" or "~g~Active").."~w~/~b~"..Phone.Call.Status, 0.0, 831.6, 6, 0.35, 255, 255, 255, 255, nil, false, true)
				else
					Phone:RenderText("[~y~F1~w~]Call with ~y~"..Phone.Call.Caller..": "..(Phone.Call.Hold and "~r~On hold" or "~g~Active").."~w~/~b~"..Phone.Call.Status, 0.0, 990, 6, 0.35, 255, 255, 255, 255, nil, false, true)
				end

				ScreenDrawPositionEnd()
			end

			if IsControlJustPressed(0, 288) and IsInputDisabled(2) and not IsControlPressed(0, 21) then -- F1
				if not Phone.Call.Hold then
					ClearPedTasks(PlayerPed)

					Phone.Call.Hold = true

					TriggerServerEvent("Phone.Call.Hold", Phone.Call.Number, true)

					exports["tokovoip_script"]:removePlayerFromCall()

					TriggerEvent("Phone.Stop.Animations")
				else
					Phone.Call.Hold = false

					TriggerServerEvent("Phone.Call.Hold", Phone.Call.Number, false)

					exports["tokovoip_script"]:addPlayerToCall(Phone.Call.Channel)

					TriggerEvent("Phone.Stop.Animations")
				end
			end

			if IsEntityDead(PlayerPed) or not Phone.Data.Has then
				Phone:Toggle(false)

				if Phone.Call.Number and Phone.Call.Channel then
					TriggerServerEvent("Phone.Call.End", Phone.Call.Number, Phone.Call.Channel)
				end

				Phone.Call.Number = nil
				Phone.Call.Answered = false
				Phone.Call.Hold = false
				Phone.Call.Status = ""
			end
		end
	end
end)

RegisterNetEvent("Phone.Set")
AddEventHandler("Phone.Set", function(Value)
	Phone.Data.Has = Value

	if not Phone.Data.Has and Phone.Open then
		Phone:Toggle(false)
	end
end)

RegisterNetEvent("Phone.Open")
AddEventHandler("Phone.Open", function()
	Phone:Toggle(true)
end)

RegisterNetEvent("Phone.Close")
AddEventHandler("Phone.Close", function()
	Phone:Toggle(false)
end)

function PlayerHasPhone()
	return Phone.Data.Has
end

RegisterNUICallback("addContact", function(data, cb)
	Citizen.Trace("addContact callback: " .. json.encode(data))
	
	newContactCallback = cb

	TriggerServerEvent("Phone.Contact.Add", data)
end)

RegisterNUICallback("sendTweet", function(data, cb)
	Citizen.Trace("addTweet callback: " .. json.encode(data))

	tweetCallback = cb

	TriggerServerEvent("Twitter.Message.Add", data.message)
end)


RegisterNUICallback("sendAdvertisement", function(data, cb)
	Citizen.Trace("addAdvertisement callback: " .. json.encode(data))

	advertisementCallback = cb
	
	TriggerServerEvent("Advertisement.Add", data.message)
end)

RegisterNUICallback("addMessage", function(data, cb)
	Citizen.Trace("addMessage callback: " .. json.encode(data))

	messageCallback = cb

	TriggerServerEvent("Phone.Message.Add", data.phone_number, data.message)
end)

RegisterNUICallback("newMessage", function(data, cb)
	Citizen.Trace("newMessage callback: " .. json.encode(data))

	messageCallback = cb

	TriggerServerEvent("Phone.Message.Add", data.phone_number, data.message)
end)

RegisterNUICallback("getConversation", function(data, cb)
	Citizen.Trace("getConversation callback: " .. json.encode(data))

	getConversationCallback = cb

	TriggerServerEvent("Phone.Conversation.Get", data)
end)

RegisterNUICallback("requestTaxi", function(data, cb)
	TriggerEvent("taxi:callService", data)

	cb("ok")
end)

RegisterNUICallback("requestMechanic", function(data, cb)
	Citizen.Trace("requestMechanic callback: " .. json.encode(data))

	TriggerEvent("mechanic:callMechanic", data)

	cb("ok")
end)

RegisterNUICallback("requestEMT", function(data, cb)
	Citizen.Trace("requestEMT callback: " .. json.encode(data))

	TriggerEvent('paramedic:callAmbulanceCustom', data)

	cb("ok")
end)

RegisterNUICallback("requestPolice", function(data, cb)
	Citizen.Trace("requestPolice callback: " .. json.encode(data))

	TriggerEvent('police:callPoliceCustom', data)

	cb("ok")
end)

RegisterNUICallback("requestWeed", function(data, cb)
	Citizen.Trace("requestWeed callback: " .. json.encode(data))

	TriggerEvent("weed:setuptrader")

end)

RegisterNUICallback("requestWeapons", function(data, cb)
	Citizen.Trace("requestWeapons callback: " .. json.encode(data))

	TriggerEvent("Create.Public.Market.Meeting")

end)

RegisterNUICallback("requestJewelry", function(data, cb)
	Citizen.Trace("requestJewelry callback: " .. json.encode(data))

	TriggerEvent("Create.Jewelry.Meeting")

end)

RegisterNUICallback("cancelTaxi", function(data, cb)
	Citizen.Trace("cancelTaxi callback: " .. json.encode(data))

	TriggerEvent("taxi:cancelCall")

	cb("ok")
end)

RegisterNUICallback("cancelMechanic", function(data, cb)
	Citizen.Trace("cancelMechanic callback: " .. json.encode(data))

	TriggerEvent("mechanic:cancelCall")

	cb("ok")
end)

RegisterNUICallback("cancelEMT", function(data, cb)
	Citizen.Trace("cancelEMT callback: " .. json.encode(data))

	TriggerEvent("paramedic:cancelCall")

	cb("ok")
end)

RegisterNUICallback("cancelPolice", function(data, cb)
	Citizen.Trace("cancelPolice callback: " .. json.encode(data))

	TriggerEvent("police:cancelCall")

	cb("ok")
end)

RegisterNUICallback("cancelWeed", function(data, cb)
	Citizen.Trace("cancelWeed callback: " .. json.encode(data))

	TriggerEvent("weed:canceltrader")

end)

RegisterNUICallback("cancelWeapons", function(data, cb)
	Citizen.Trace("cancelWeapons callback: " .. json.encode(data))

	TriggerEvent("Cancel.Public.Market.Meeting")

end)

RegisterNUICallback("cancelJewelry", function(data, cb)
	Citizen.Trace("cancelJewelry callback: " .. json.encode(data))

	TriggerEvent("Cancel.Jewelry.Meeting")
	
end)

RegisterNUICallback("close", function(data, cb)
	Phone:Toggle(false)
end)

RegisterNUICallback("requestAmbulance", function(data, cb)
	Citizen.Trace("requestAmbulance callback: " .. json.encode(data))

	if not Phone.Data.Has then
		Notify("As you technically don't have your phone you can only respawn...", 3000)
	else
		TriggerEvent("paramedic:callAmbulance", "is in a coma!")
		Phone:Toggle(false)
	end
end)

RegisterNUICallback("requestRespawn", function(data, cb)
	Citizen.Trace("requestRespawn callback: " .. json.encode(data))

	TriggerEvent("paramedic:respawnCheck")
	Phone:Toggle(false)
end)

RegisterNUICallback("startCall", function(data, cb)
	Citizen.Trace("startCall callback: " .. json.encode(data))

	Phone.Call.Number = data
	Phone.Call.Channel = tonumber(Phone.Data.Number)
	Phone.Call.Status = "Dialing..."
	Phone.Call.Answered = true
	Phone.Call.Caller = Phone.Data.ContactNames[data] or data

	TriggerServerEvent("Phone.Call.Start", Phone.Call.Number, Phone.Call.Channel)
end)

RegisterNUICallback("answerCall", function(data, cb)
	Citizen.Trace("answerCall callback: " .. json.encode(data))

	if not Phone.Call.Answered then
		Phone.Call.Answered = true
		Phone.Call.Status = "Active"

		TriggerServerEvent("Phone.Call.Answer", Phone.Call.Number)
	end	
end)

RegisterNUICallback("removeContact", function(id, cb)
	for Index = 1, #Phone.Data.Contacts do
		if Phone.Data.Contacts[Index].id == id then
			Phone.Data.ContactNames[Phone.Data.Contacts[Index].contact_number] = nil

			table.remove(Phone.Data.Contacts, Index)

			break
		end
	end

	TriggerServerEvent("Phone.Contact.Remove", id, Phone.Data.Contacts, Phone.Data.ContactNames)

	cb({type = "setContacts", payload = Phone.Data.Contacts})
end)

RegisterNUICallback("endCall", function(data, cb)
	Citizen.Trace("endCall callback: " .. json.encode(data))

	TriggerServerEvent("Phone.Call.End", Phone.Call.Number, Phone.Call.Channel)

	Phone.Call.Number = nil
	Phone.Call.Answered = false
	Phone.Call.Status = ""	
end)

RegisterNetEvent("Phone.HangUp")
AddEventHandler("Phone.HangUp", function()
	TriggerServerEvent("Phone.Call.End", Phone.Call.Number, Phone.Call.Channel)
	Phone.Call.Number = nil
	Phone.Call.Answered = false
	Phone.Call.Status = ""	
end)

RegisterNetEvent("Phone.PickUp")
AddEventHandler("Phone.PickUp", function()
	if not Phone.Call.Answered then
		Phone.Call.Answered = true
		Phone.Call.Status = "Active"

		TriggerServerEvent("Phone.Call.Answer", Phone.Call.Number)
	end	
end)

RegisterNUICallback("saveSettings", function(data, cb)
	Citizen.Trace("saveSettings callback: " .. json.encode(data))

	SetResourceKvp("phoneData", json.encode(data))

	cb("ok")
end)

RegisterNetEvent("Phone.Contact.Add")
AddEventHandler("Phone.Contact.Add", function(Data)
	Phone.Data.Contacts = Data.Contacts
	Phone.Data.ContactNames = Data.ContactNames
	Phone.Data.Messages = Data.Messages

	SendNUIMessage({type = "setContacts", payload = Data.Contacts})
	SendNUIMessage({type = "setMessages", payload = Data.Messages})

	if newContactCallback ~= nil then
		newContactCallback("ok")
	end
end)

RegisterNetEvent("Phone.Message.Add")
AddEventHandler("Phone.Message.Add", function(Exists, Received, Number, Message, Data)
	if not Exists then
		if Phone.Open then
			if messageCallback ~= nil then
				messageCallback({error = "The message was not sent as the number does not exist!"})
			end
		end
	else
		Phone.Data.Messages = Data.Messages

		SendNUIMessage({type = "setMessages", payload = Phone.Data.Messages})

		if Phone.Conversation then
			if Phone.Conversation.Number == Number then
				if Message.id then
					if not Phone:DoesConversationMessageExist(Message.id) then
						table.insert(Phone.Conversation.Messages, Message)
					end
				end
			end

			SendNUIMessage({type = "setConversation", payload = Phone.Conversation.Messages})
		end

		if not Received then
			if messageCallback ~= nil then
				messageCallback("ok")
			end
		end

		Phone:DisplayNotification(Message.message, "CHAR_CHAT_CALL", Phone.Data.ContactNames[Number] or Number, Received and "New message" or "Message sent")
	end
end)

RegisterNetEvent("Phone.Conversation.Set")
AddEventHandler("Phone.Conversation.Set", function(Number, Messages)
	Phone.Conversation.Number = Number
	Phone.Conversation.Messages = Messages
	
	SendNUIMessage({type = "setConversation", payload = Phone.Conversation.Messages})

	if getConversationCallback ~= nil then
		getConversationCallback("ok")
	end
end)

RegisterNetEvent("Phone.Call.Status")
AddEventHandler("Phone.Call.Status", function(Status)
	Phone.Call.Status = Status

	SendNUIMessage({type = "setCallStatus", payload = Status})

	Phone:DisplayNotification("", "CHAR_CHAT_CALL", Phone.Call.Caller, Status)
end)

RegisterNetEvent("Phone.Call.Request")
AddEventHandler("Phone.Call.Request", function(Number)
	Phone.Call.Number = Number
	Phone.Call.Channel = tonumber(Number)
	Phone.Call.Caller = Phone.Data.ContactNames[Number] or Number

	if exports.core_modules:IsInJail() or exports.policejob:getIsCuffed() or exports.core_modules:isCuffed() or (not Phone.Data.Has) then
		TriggerServerEvent("Phone.Call.End", Phone.Call.Number, Phone.Call.Channel)

		Phone.Call.Number = nil
		Phone.Call.Answered = false
	else
		Citizen.CreateThread(function()
			while Phone.Call.Number and not Phone.Call.Answered do
				Citizen.Wait(500)
				PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
				Citizen.Wait(750)
				PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)

				if exports.core_modules:IsInJail() or exports.policejob:getIsCuffed() or exports.core_modules:isCuffed() or not Phone.Data.Has then
					TriggerServerEvent("Phone.Call.End", Phone.Call.Number, Phone.Call.Channel)

					Phone.Call.Number = nil
					Phone.Call.Answered = false
				end
			end
		end)

		SendNUIMessage({type = "toggleAnswerBtn", payload = "true"})
		SendNUIMessage({type = "setCallStatus", payload = "Incoming call"})
		SendNUIMessage({type = "setCaller", payload = Phone.Call.Caller})

		Phone:DisplayNotification("", "CHAR_CHAT_CALL", Phone.Call.Caller, "Incoming call")
	end
end)

RegisterNetEvent("Phone.Call.End")
AddEventHandler("Phone.Call.End", function()
	if Phone.Call.Channel then
		exports["tokovoip_script"]:removePlayerFromCall()
	end

	Phone.Call.Number = nil
	Phone.Call.Channel = nil
	Phone.Call.Answered = false
	Phone.Call.Hold = false
	Phone.Call.Status = ""

	SendNUIMessage({type = "endCall", payload = "true"})

	Phone:DisplayNotification("", "CHAR_CHAT_CALL", Phone.Call.Caller, "Call ended")

	Phone.Call.Caller = ""

	ClearPedTasks(PlayerPedId())
	TriggerEvent("Phone.Stop.Animations")
end)

RegisterNetEvent("Phone.Call.Answer")
AddEventHandler("Phone.Call.Answer", function(Channel)
	Phone.Call.Status = "Active"
	Phone.Call.Channel = Channel
	
	exports["tokovoip_script"]:addPlayerToCall(Phone.Call.Channel)

	SendNUIMessage({type = "setCallStatus", payload = "Active"})
end)

RegisterNetEvent("Toggle.Twitter.Notifications")
AddEventHandler("Toggle.Twitter.Notifications", function()
	Phone.ToggleTwitterNotifications = not Phone.ToggleTwitterNotifications
end)

RegisterNetEvent("Twitter.Set.Messages")
AddEventHandler("Twitter.Set.Messages", function(Data)
	if Phone.Data.Has then
		if not Phone.ToggleTwitterNotifications then
			local CharacterName = "@"..string.gsub(exports.core:GetCharacterName(GetPlayerServerId(PlayerId())), "%s", "")
			if string.match(Data.Message:lower(), CharacterName:lower()) then
				Notify("Twitter Notification: You have been mentioned!", 3100)
			else
				Notify("Twitter Notification: New Tweet Posted!", 3100)
			end
		end
	end
	SendNUIMessage({type = "setTwitter", payload = Data})
end)

RegisterNetEvent("Yellowpages.Set.Advertisements")
AddEventHandler("Yellowpages.Set.Advertisements", function(Name)
	if Name == "" then
		Notify("Your advertisement has been deleted!")
	elseif Phone.Data.Has then
		Notify("Advertisement published by "..Name.."!")
	end

	if Phone.Open then
		TriggerServerEvent("Advertisement.Update")
	end
end)

RegisterNetEvent("Yellowpages.Update")
AddEventHandler("Yellowpages.Update", function(Data)
	SendNUIMessage({type = "setYellowpages", payload = Data})
end)

RegisterNUICallback("updateAdvertisements", function()
	TriggerServerEvent("Advertisement.Update")
end)
--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
local Phone = {
	PlayerIds = {},
	Players = {},
	Calls = {},
	Areacode = 209,
	Generator = {
		Start = os.time({year = os.date("*t", os.time()).year, month = 1, day = 1}),
		End = os.time({year = 2028, month = 1, day = 1}),
	},
}

function number_to_bool(value)
	return value == 1
end

function bool_to_number(value)
	return value and 1 or 0
end

function math.round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function Phone:FetchNumbers(Value)
	local Digits = tostring(Value)
	local Number = ""

	math.randomseed(os.time())
	math.random()
	math.random()
	math.random()

	for Index = 1, 7 do
		local Random = math.random(1, #Digits)
		Number = Number .. Digits:sub(Random, Random)
	end

	return Number
end

function Phone:GeneratePhoneNumber()
	local Random = math.abs(math.round(999999999999 * (os.time() - self.Generator.Start) / self.Generator.End))

	return self.Areacode .. Phone:FetchNumbers(Random)
end

function Phone:DoesMessageExistFromNumber(Source, Number)
	if self.Players[Source] then
		for Index = 1, #self.Players[Source].Messages do
			if self.Players[Source].Messages[Index].receiver_number == Number then
				return true, Index
			end
		end
	end

	return false, nil
end

-- AddEventHandler("playerDropped", function(reason)
-- 	local Source = Source

-- 	if Phone.Players[Source] then
-- 		Phone.PlayerIds[Phone.Players[Source].Number] = nil
-- 		Phone.Players[Source] = nil
-- 		Phone.Calls[Source] = nil
-- 	end
-- end)

AddEventHandler("core:switch", function(source)
	local Source = source

	if Phone.Players[Source] then
		Phone.PlayerIds[Phone.Players[Source].Number] = nil
		Phone.Players[Source] = nil
		Phone.Calls[Source] = nil
	end
end)

AddEventHandler("Phone.Get", function(Source, Callback)
	if Phone.Players[Source] then
		Callback(Phone.Players[Source])
	else
		Callback(nil)
	end
end)

AddEventHandler("Phone.Start",function(Source, CharacterId)
	exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM phone WHERE character_id=@character_id LIMIT 1", {["@character_id"] = CharacterId}, function(PhoneNumber)
		if PhoneNumber[1] == nil then
			Citizen.CreateThread(function()
				local Duplicate = true
				local CheckingDuplicate = false
				
				while Duplicate do
					Citizen.Wait(0)

					local NewPhoneNumber = Phone:GeneratePhoneNumber()

					if not CheckingDuplicate then
						CheckingDuplicate = true

						exports["GHMattiMySQL"]:QueryResultAsync("SELECT 1 FROM phone WHERE phone_number=@phone_number", {["@phone_number"] = NewPhoneNumber}, function(DupeResult)
							if DupeResult[1] == nil then
								Duplicate = false

								exports["GHMattiMySQL"]:QueryAsync("INSERT INTO phone (`character_id`,`phone_number`) VALUES (@character_id,@phone_number)", {
									["@character_id"] = CharacterId,
									["@phone_number"] = NewPhoneNumber,
								})


								Phone.Players[Source] = {}
								Phone.Players[Source].Has = true
								Phone.Players[Source].Number = NewPhoneNumber
								Phone.Players[Source].Contacts = {}
								Phone.Players[Source].Messages = {}

								Phone.PlayerIds[NewPhoneNumber] = Source

								TriggerClientEvent("Phone.Start", Source, Phone.Players[Source])
							else
								CheckingDuplicate = false
							end
						end)
					end
				end
			end)
		else
			exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM phone_contacts WHERE phone_number=@phone_number", {["@phone_number"] = PhoneNumber[1].phone_number}, function(Contacts)
				exports["GHMattiMySQL"]:QueryResultAsync("SELECT phone_conversation.receiver_number, (SELECT CONCAT(phone_contacts.first_name, ' ', phone_contacts.last_name) FROM phone_contacts WHERE (phone_contacts.contact_number = phone_conversation.receiver_number) AND (phone_contacts.phone_number = phone_conversation.owner_number) LIMIT 1) AS 'contact_name', (SELECT phone_messages.message FROM phone_messages WHERE phone_messages.conversation_id = phone_conversation.id ORDER BY phone_messages.id DESC LIMIT 1) AS 'message' FROM phone_conversation WHERE phone_conversation.owner_number = @phone_number", {["@phone_number"] = PhoneNumber[1].phone_number}, function(Messages)
					Phone.Players[Source] = {}
					Phone.Players[Source].Has = number_to_bool(PhoneNumber[1].has)
					Phone.Players[Source].Number = PhoneNumber[1].phone_number
					Phone.Players[Source].Contacts = Contacts
					Phone.Players[Source].Messages = Messages

					Phone.PlayerIds[Phone.Players[Source].Number] = Source

					TriggerClientEvent("Phone.Start", Source, Phone.Players[Source])

				end)
			end)
		end
	end)
	TriggerClientEvent("Yellowpages.Set.Advertisements", Source, Advertisements)
end)

RegisterServerEvent("Phone.Finish")
AddEventHandler("Phone.Finish", function(ContactNames)
	local Source = source
	
	if Phone.Players[Source] then
		Phone.Players[Source].ContactNames = ContactNames

		TriggerEvent("Phone.Finished", source, Phone.Players[Source])
	end
end)

RegisterServerEvent("Phone.Contact.Add")
AddEventHandler("Phone.Contact.Add", function(Data)
	local Source = source

	if Phone.Players[Source] then
		exports["GHMattiMySQL"]:Insert("phone_contacts", {
			{
				["phone_number"] = Phone.Players[Source].Number,
				["contact_number"] = Data.contact_number,
				["first_name"] = Data.first_name,
				["last_name"] = Data.last_name,
			}
		}, function(ContactID)
			table.insert(Phone.Players[Source].Contacts, {id = ContactID, contact_number = Data.contact_number, first_name = Data.first_name, last_name = Data.last_name})

			Phone.Players[Source].ContactNames[Data.contact_number] = Data.first_name.." "..Data.last_name

			local DoesExist, Index = Phone:DoesMessageExistFromNumber(Source, Data.contact_number)

			if DoesExist then
				Phone.Players[Source].Messages[Index].contact_name = Data.first_name.." "..Data.last_name
			end

			TriggerClientEvent("Phone.Contact.Add", Source, Phone.Players[Source])
		end, true)
	end
end)

RegisterServerEvent("Phone.Contact.Remove")
AddEventHandler("Phone.Contact.Remove", function(Id, Contacts, ContactNames)
	local Source = source

	if Phone.Players[Source] then
		Phone.Players[Source].Contacts = Contacts
		Phone.Players[Source].ContactNames = ContactNames
		
		exports["GHMattiMySQL"]:QueryAsync("DELETE FROM phone_contacts WHERE id=@id", {
			["@id"] = Id,
		})
	end
end)

function ParseConversations(Data, SourceNumber, TargetNumber)
	local SourceConversation, TargetConversation = nil, nil

	for Index = 1, #Data do
		if Data[Index].owner_number == SourceNumber then
			SourceConversation = Data[Index].id
		elseif Data[Index].owner_number == TargetNumber then
			TargetConversation = Data[Index].id
		end
	end

	return SourceConversation, TargetConversation
end

RegisterServerEvent("Phone.Message.Add")
AddEventHandler("Phone.Message.Add", function(PhoneNumber, Message)
	local Source = source
	local CurrentTime = os.time()

	exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM phone WHERE phone_number=@phone_number", {["@phone_number"] = PhoneNumber}, function(Target)
		if Target[1] == nil then
			TriggerClientEvent("Phone.Message.Add", Source, false)
		else
			exports["GHMattiMySQL"]:QueryResultAsync("SELECT id, owner_number FROM phone_conversation WHERE (owner_number=@source AND receiver_number=@target) OR (owner_number=@target AND receiver_number=@source)", {
				["@source"] = Phone.Players[Source].Number,
				["@target"] = Target[1].phone_number,
			}, function(Conversations)
				if Conversations[1] == nil then
					exports["GHMattiMySQL"]:Insert("phone_conversation", {
						{
							["owner_number"] = Phone.Players[Source].Number,
							["receiver_number"] = Target[1].phone_number,
						},
					}, function(ConversationId)

						exports["GHMattiMySQL"]:Insert("phone_messages", {
							{
								["conversation_id"] = ConversationId,
								["creator"] = Phone.Players[Source].Number,
								["message"] = Message,
							}
						}, function(MessageId)
							local NewMessage = {id = MessageId, creator = Phone.Players[Source].Number, message = Message, timestamp = CurrentTime}

							local DoesExist, Index = Phone:DoesMessageExistFromNumber(Source, Target[1].phone_number)

							if DoesExist then
								Phone.Players[Source].Messages[Index].message = Message
							else
								table.insert(Phone.Players[Source].Messages, {receiver_number = Target[1].phone_number, message = Message, contact_name = Phone.Players[Source].ContactNames[Target[1].phone_number] or nil})
							end

							TriggerClientEvent("Phone.Message.Add", Source, true, false, Target[1].phone_number, NewMessage, Phone.Players[Source])
						end, true)
					end, true)

					exports["GHMattiMySQL"]:Insert("phone_conversation", {
						{
							["owner_number"] = Target[1].phone_number,
							["receiver_number"] = Phone.Players[Source].Number,
						},
					}, function(ConversationId)
						exports["GHMattiMySQL"]:Insert("phone_messages", {
							{
								["conversation_id"] = ConversationId,
								["creator"] = Phone.Players[Source].Number,
								["message"] = Message,
							}
						}, function(MessageId)
							if Phone.PlayerIds[Target[1].phone_number] then
								local TargetId = Phone.PlayerIds[Target[1].phone_number]
								if Phone.Players[TargetId] then
									if Phone.Players[TargetId].Number == Target[1].phone_number then
										local NewMessage = {id = MessageId, creator = Phone.Players[Source].Number, message = Message, timestamp = CurrentTime}

										local DoesExist, Index = Phone:DoesMessageExistFromNumber(TargetId, Phone.Players[Source].Number)

										if DoesExist then
											Phone.Players[TargetId].Messages[Index].message = Message											
										else
											table.insert(Phone.Players[TargetId].Messages, {receiver_number = Phone.Players[Source].Number, message = Message, contact_name = Phone.Players[TargetId].ContactNames[Phone.Players[Source].Number] or nil})
										end

										TriggerClientEvent("Phone.Message.Add", TargetId, true, true, Phone.Players[Source].Number, NewMessage, Phone.Players[TargetId])
									end
								end
							end
						end, true)
					end, true)
				else
					local SourceConversation, TargetConversation = ParseConversations(Conversations, Phone.Players[Source].Number, Target[1].phone_number)

					if SourceConversation then
						exports["GHMattiMySQL"]:Insert("phone_messages", {
							{
								["conversation_id"] = SourceConversation,
								["creator"] = Phone.Players[Source].Number,
								["message"] = Message,
							}
						}, function(MessageId)
							local NewMessage = {id = MessageId, creator = Phone.Players[Source].Number, message = Message, timestamp = CurrentTime}

							local DoesExist, Index = Phone:DoesMessageExistFromNumber(Source, Target[1].phone_number)

							if DoesExist then
								Phone.Players[Source].Messages[Index].message = Message
							else
								table.insert(Phone.Players[Source].Messages, {receiver_number = Target[1].phone_number, message = Message, contact_name = Phone.Players[Source].ContactNames[Target[1].phone_number] or nil})
							end

							TriggerClientEvent("Phone.Message.Add", Source, true, false, Target[1].phone_number, NewMessage, Phone.Players[Source])
						end, true)
					end

					if TargetConversation then
						exports["GHMattiMySQL"]:Insert("phone_messages", {
							{
								["conversation_id"] = TargetConversation,
								["creator"] = Phone.Players[Source].Number,
								["message"] = Message,
							}
						}, function(MessageId)
							if Phone.PlayerIds[Target[1].phone_number] then
								local TargetId = Phone.PlayerIds[Target[1].phone_number]
								if Phone.Players[TargetId] then
									if Phone.Players[TargetId].Number == Target[1].phone_number then
										local NewMessage = {id = MessageId, creator = Phone.Players[Source].Number, message = Message, timestamp = CurrentTime}

										local DoesExist, Index = Phone:DoesMessageExistFromNumber(TargetId, Phone.Players[Source].Number)

										if DoesExist then
											Phone.Players[TargetId].Messages[Index].message = Message
										else
											table.insert(Phone.Players[TargetId].Messages, {receiver_number = Phone.Players[Source].Number, message = Message, contact_name = Phone.Players[TargetId].ContactNames[Phone.Players[Source].Number] or nil})
										end

										TriggerClientEvent("Phone.Message.Add", TargetId, true, true, Phone.Players[Source].Number, NewMessage, Phone.Players[TargetId])
									end
								end
							end
						end, true)
					end
				end
			end)
		end
	end)
end)

RegisterServerEvent("Phone.Message.Remove")
AddEventHandler("Phone.Message.Remove", function(Id)
	local Source = source

	exports["GHMattiMySQL"]:QueryAsync("DELETE FROM phone_messages WHERE id=@id", {
		["@id"] = Id,
	})
end)

RegisterServerEvent("Phone.Call.Start")
AddEventHandler("Phone.Call.Start", function(TargetNumber, Channel)
	local Source = source
	local TargetId = Phone.PlayerIds[TargetNumber]

	if TargetId and Phone.Players[Source] then
		if not Phone.Calls[TargetId] then
			Phone.Calls[TargetId] = Channel
			Phone.Calls[Source] = Channel

			TriggerClientEvent("Phone.Call.Status", Source, "Dialing...")
			TriggerClientEvent("Phone.Call.Request", TargetId, Phone.Players[Source].Number, Source)
		else
			TriggerClientEvent("Phone.Call.Status", Source, "Target is busy!")
		end
	else
		TriggerClientEvent("Phone.Call.Status", Source, "This users phone is switched off!")
		Phone.Calls[Source] = nil
	end
end)

RegisterServerEvent("Phone.Call.End")
AddEventHandler("Phone.Call.End", function(TargetNumber, Channel)
	local Source = source
	local TargetId = Phone.PlayerIds[TargetNumber]

	if TargetId then
		if Phone.Calls[TargetId] then
			if tostring(Phone.Calls[TargetId]) == tostring(Channel) then
				TriggerClientEvent("Phone.Call.End", Source)
				TriggerClientEvent("Phone.Call.End", TargetId)

				Phone.Calls[TargetId] = nil
				Phone.Calls[Source] = nil
			else
				TriggerClientEvent("Phone.Call.End", Source)
				Phone.Calls[Source] = nil
			end
		else
			TriggerClientEvent("Phone.Call.End", Source)
			Phone.Calls[Source] = nil
		end
	else
		TriggerClientEvent("Phone.Call.End", Source)
		Phone.Calls[Source] = nil
	end
end)

RegisterServerEvent("Phone.Call.Answer")
AddEventHandler("Phone.Call.Answer", function(TargetNumber)
	local Source = source
	local TargetId = Phone.PlayerIds[TargetNumber]

	if TargetId then
		if Phone.Calls[TargetId] then
			TriggerClientEvent("Phone.Call.Answer", Source, TargetNumber)
			TriggerClientEvent("Phone.Call.Answer", TargetId, TargetNumber)
		else
			TriggerClientEvent("Phone.Call.End", Source)
			Phone.Calls[Source] = nil
		end
	else
		TriggerClientEvent("Phone.Call.End", Source)
		Phone.Calls[Source] = nil
	end
end)

RegisterServerEvent("Phone.Call.Hold")
AddEventHandler("Phone.Call.Hold", function(TargetNumber, OnHold)
	local Source = source
	local TargetId = Phone.PlayerIds[TargetNumber]

	if TargetId then
		if Phone.Calls[TargetId] then
			TriggerClientEvent("Phone.Call.Status", TargetId, OnHold and "On hold" or "Active")
		else
			TriggerClientEvent("Phone.Call.End", Source)
			Phone.Calls[Source] = false
		end
	else
		TriggerClientEvent("Phone.Call.End", Source)
		Phone.Calls[Source] = false
	end
end)

RegisterServerEvent("Phone.Conversation.Get")
AddEventHandler("Phone.Conversation.Get", function(TargetNumber)
	local Source = source

	if Phone.Players[Source] then
		if Phone.Players[Source].Number then
			exports["GHMattiMySQL"]:QueryResultAsync("SELECT phone_messages.id, phone_messages.message, phone_messages.creator, UNIX_TIMESTAMP(phone_messages.timestamp) AS 'timestamp' FROM phone_messages WHERE conversation_id = (SELECT id FROM phone_conversation WHERE owner_number=@owner_number AND receiver_number=@receiver_number) AND ((UNIX_TIMESTAMP() - UNIX_TIMESTAMP(phone_messages.timestamp)) <= 2592000)", {["@owner_number"] = Phone.Players[Source].Number, ["@receiver_number"] = TargetNumber}, function(Messages)
				TriggerClientEvent("Phone.Conversation.Set", Source, TargetNumber, Messages)
			end)
		end
	end
end)

RegisterServerEvent("Phone.Set")
AddEventHandler("Phone.Set", function(Source, Value)
	if Phone.Players[Source] then
		if type(Value) == "boolean" then
			Phone.Players[Source].Has = Value
			exports["GHMattiMySQL"]:QueryAsync("UPDATE phone SET has=@has WHERE phone_number=@number", {["@number"] = Phone.Players[Source].Number, ["@has"] = bool_to_number(Value)})

			TriggerClientEvent("Phone.Set", Source, Value)
		end
	end
end)

RegisterServerEvent("Twitter.Message.Add")
AddEventHandler("Twitter.Message.Add", function(Message)
	local Source = source
	local CharacterName = "@Unknown"
	TriggerEvent("core:getuser", Source, function(User)
		CharacterName = "@"..User.get("first_name")..User.get('last_name')
	end)
	TriggerClientEvent("Twitter.Set.Messages", -1, {
		Name = CharacterName,
		Message = Message,
	})
end)

--local Advertisements = {}

RegisterServerEvent("Advertisement.Add")
AddEventHandler("Advertisement.Add", function(MessageData)
	local Source = source
	local CharacterName = "Unknown"

	TriggerEvent("core:getuser", Source, function(User)
		CharacterName = User.get("first_name").." "..User.get('last_name')
		User.setAd(MessageData)
	end)
	
	if MessageData ~= nil and MessageData ~= "" then
		TriggerClientEvent("Yellowpages.Set.Advertisements", -1, CharacterName)
	else
		TriggerClientEvent("Yellowpages.Set.Advertisements", Source, "")
	end
end)

RegisterServerEvent("Advertisement.Update")
AddEventHandler("Advertisement.Update", function()
	local Source = source
	local Data = {}

	print(tostring(Phone).." "..tostring(#Phone.Players).." "..tostring(#Phone.PlayerIds).." "..tostring(#Phone.Calls))

	for key, peer in ipairs(Phone.Players) do
		if key and peer then
			TriggerEvent("core:getuser", key, function(User)
				if User then
					local name = User.get("first_name").." "..User.get('last_name')
					local text = User.get("ad_text")
					local number = peer.Number

					if text ~= nil and text ~= "" then
						table.insert(Data, { name =  name, text = text, number = number })
					end
				end
			end)
		end
	end

	TriggerClientEvent("Yellowpages.Update", Source, Data)
end)
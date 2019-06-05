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

AddEventHandler("playerDropped", function()
	local Source = source

	if Phone.Players[Source] then
		Phone.PlayerIds[Phone.Players[Source].Number] = nil
		Phone.Players[Source] = nil
		Phone.Calls[Source] = nil
	end
end)

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
	exports["ghmattimysql"]:execute("SELECT * FROM phone WHERE character_id=? LIMIT 1", {CharacterId}, function(PhoneNumber)
		if PhoneNumber[1] == nil then
			Citizen.CreateThread(function()
				local Duplicate = true
				local CheckingDuplicate = false
				
				while Duplicate do
					Citizen.Wait(0)

					local NewPhoneNumber = Phone:GeneratePhoneNumber()

					if not CheckingDuplicate then
						CheckingDuplicate = true

						exports["ghmattimysql"]:execute("SELECT phone.phone_number FROM phone WHERE phone_number=?", {NewPhoneNumber}, function(DupeResult)
							if DupeResult[1] == nil then
								Duplicate = false

								exports["ghmattimysql"]:execute("INSERT INTO phone (`character_id`,`phone_number`) VALUES (?, ?)", {CharacterId, NewPhoneNumber})


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
			exports["ghmattimysql"]:execute("SELECT * FROM phone_contacts WHERE phone_number=?", {PhoneNumber[1].phone_number}, function(Contacts)
				exports["ghmattimysql"]:execute("SELECT receiver_number, (SELECT phone_messages.message FROM phone_messages WHERE phone_messages.conversation_id = phone_conversation.id ORDER BY id DESC LIMIT 1) As 'message' FROM phone_conversation WHERE owner_number = ?", {PhoneNumber[1].phone_number}, function(Messages)
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
end)

RegisterServerEvent("Phone.Finish")
AddEventHandler("Phone.Finish", function(Data)
	local Source = source

	if Phone.Players[Source] then
		Phone.Players[Source] = Data
	end
end)

RegisterServerEvent("Phone.Contact.Add")
AddEventHandler("Phone.Contact.Add", function(Data)
	local Source = source

	if Phone.Players[Source] then
		exports["ghmattimysql"]:execute("INSERT INTO phone_contacts (`phone_number`, `contact_number`, `first_name`, `last_name`) VALUES (?, ?, ?, ?)", {Phone.Players[Source].Number, Data.phone_number, Data.first_name, Data.last_name}, function(rowChanges)
			local rowId = rowChanges.insertId

			table.insert(Phone.Players[Source].Contacts, {id = rowId, contact_number = Data.phone_number, first_name = Data.first_name, last_name = Data.last_name})

			Phone.Players[Source].ContactNames[Data.phone_number] = Data.first_name.." "..Data.last_name

			TriggerClientEvent("Phone.Contact.Add", Source, Phone.Players[Source])			
		end)
	end
end)

RegisterServerEvent("Phone.Contact.Remove")
AddEventHandler("Phone.Contact.Remove", function(Id, Contacts)
	local Source = source

	if Phone.Players[Source] then
		Phone.Players[Source].Contacts = Contacts
		
		exports["ghmattimysql"]:execute("DELETE FROM phone_contacts WHERE id=?", {Id})
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

	exports["ghmattimysql"]:execute("SELECT * FROM phone WHERE phone_number=?", {PhoneNumber}, function(Target)
		if Target[1] == nil then
			TriggerClientEvent("Phone.Message.Add", Source, false)
		else
			exports["ghmattimysql"]:execute("SELECT id, owner_number FROM phone_conversation WHERE (owner_number=@source AND receiver_number=@target) OR (owner_number=@target AND receiver_number=@source)", {
				["@source"] = Phone.Players[Source].Number,
				["@target"] = Target[1].phone_number,
			}, function(Conversations)
				if Conversations[1] == nil then
					exports["ghmattimysql"]:execute("INSERT INTO phone_conversation (`owner_number`, `receiver_number`) VALUES (?, ?)", {Phone.Players[Source].Number, Target[1].phone_number}, function(conversationRowChanges)
						local conversationRowId = conversationRowChanges.insertId

						exports["ghmattimysql"]:execute("INSERT INTO phone_messages (`conversation_id`, `creator`, `message`) VALUES (?, ?, ?)", {conversationRowId, Phone.Players[Source].Number, Message}, function(messageRowChanges)
							local messageRowId = messageRowChanges.insertId

							local NewMessage = {id = messageRowId, creator = Phone.Players[Source].Number, message = Message, timestamp = CurrentTime}

							Phone.Players[Source].Messages[Target[1].phone_number] = Message

							TriggerClientEvent("Phone.Message.Add", Source, true, false, Target[1].phone_number, NewMessage, Phone.Players[Source])							
						end)						
					end)

					exports["ghmattimysql"]:execute("INSERT INTO phone_conversation (`owner_number`, `receiver_number`) VALUES (?, ?)", {Target[1].phone_number, Phone.Players[Source].Number}, function(conversationRowChanges)
						local conversationRowId = conversationRowChanges.insertId

						exports["ghmattimysql"]:execute("INSERT INTO phone_messages (`conversation_id`, `creator`, `message`) VALUES (?, ?, ?)", {conversationRowId, Phone.Players[Source].Number, Message}, function(messageRowChanges)
							local messageRowId = messageRowChanges.insertId

							if Phone.PlayerIds[Target[1].phone_number] then
								local TargetId = Phone.PlayerIds[Target[1].phone_number]
								if Phone.Players[TargetId] then
									if Phone.Players[TargetId].Number == Target[1].phone_number then
										local NewMessage = {id = messageRowId, creator = Phone.Players[Source].Number, message = Message, timestamp = CurrentTime}

										Phone.Players[TargetId].Messages[Phone.Players[Source].Number] = Message

										TriggerClientEvent("Phone.Message.Add", TargetId, true, true, Phone.Players[Source].Number, NewMessage, Phone.Players[TargetId])
									end
								end
							end					
						end)						
					end)
				else
					local SourceConversation, TargetConversation = ParseConversations(Conversations, Phone.Players[Source].Number, Target[1].phone_number)

					if SourceConversation then
						exports["ghmattimysql"]:execute("INSERT INTO phone_messages (`conversation_id`, `creator`, `message`) VALUES (?, ?, ?)", {SourceConversation, Phone.Players[Source].Number, Message}, function(rowChanges)
							local rowId = rowChanges.insertId

							local NewMessage = {id = rowId, creator = Phone.Players[Source].Number, message = Message, timestamp = CurrentTime}

							Phone.Players[Source].Messages[Target[1].phone_number] = Message

							TriggerClientEvent("Phone.Message.Add", Source, true, false, Target[1].phone_number, NewMessage, Phone.Players[Source])				
						end)	
					end

					if TargetConversation then
						exports["ghmattimysql"]:execute("INSERT INTO phone_messages (`conversation_id`, `creator`, `message`) VALUES (?, ?, ?)", {TargetConversation, Phone.Players[Source].Number, Message}, function(rowChanges)
							local rowId = rowChanges.insertId

							if Phone.PlayerIds[Target[1].phone_number] then
								local TargetId = Phone.PlayerIds[Target[1].phone_number]
								if Phone.Players[TargetId] then
									if Phone.Players[TargetId].Number == Target[1].phone_number then
										local NewMessage = {id = rowId, creator = Phone.Players[Source].Number, message = Message, timestamp = CurrentTime}
											
										Phone.Players[TargetId].Messages[Phone.Players[Source].Number] = Message

										TriggerClientEvent("Phone.Message.Add", TargetId, true, true, Phone.Players[Source].Number, NewMessage, Phone.Players[TargetId])
									end
								end
							end					
						end)
					end
				end
			end)
		end
	end)
end)

RegisterServerEvent("Phone.Message.Remove")
AddEventHandler("Phone.Message.Remove", function(Id)
	local Source = source

	exports["ghmattimysql"]:execute("DELETE FROM phone_messages WHERE id=@id", {Id})
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
			if Phone.Calls[TargetId] == Channel then
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
			exports["ghmattimysql"]:execute("SELECT phone_messages.id, phone_messages.message, phone_messages.creator, UNIX_TIMESTAMP(phone_messages.timestamp) As 'timestamp' FROM phone_messages WHERE (conversation_id = (SELECT id FROM phone_conversation WHERE owner_number=? AND receiver_number=?) AND (UNIX_TIMESTAMP(phone_messages.timestamp) < (UNIX_TIMESTAMP() + 2592000)))", {Phone.Players[Source].Number, TargetNumber}, function(Messages)
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
			exports["ghmattimysql"]:execute("UPDATE phone SET has=? WHERE phone_number=?", {bool_to_number(Value), Phone.Players[Source].Number})

			TriggerClientEvent("Phone.Set", Source, Value)
		end
	end
end)
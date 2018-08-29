Chat = {}

if IsDuplicityVersion() then
	Chat.Suggestions = {}
	Chat.Templates = {}
	
	function Chat.Message(Target, Author, Message, R, G, B, Multiline, Template, Radius, Source)
		local Data = {
			color = {tonumber(R) or 255, tonumber(G) or 255,tonumber(B) or 255},
			multiline = Multiline or false,
			args = {},
		}
		if type(Author) == "string" then table.insert(Data.args, Author) end
		if type(Message) == "string" then table.insert(Data.args, Message) end
		if type(Template) == "string" then Data.templateId = Template end

		if tonumber(Radius) and tonumber(Source) then
			TriggerClientEvent("chat:addProxMessage", tonumber(Target) or -1, Data, Radius, Source)
		else
			TriggerClientEvent("chat:addMessage", tonumber(Target) or -1, Data)
		end
	end

	function Chat.Template(TemplateId, HtmlString)
		if type(TemplateId) == "string" and type(HtmlString) == "string" then
			Chat.Templates[TemplateId] = HtmlString
		end
	end

	function Chat.Suggestion(Command, Help, Params)
		if type(Help) ~= "string" then	Help = "" end
		if type(Params) ~= "table" then Params = {} end

		if type(Command) == "string" then
			if not string.starts(Command, "/") then 
				Command = "/" .. Command 
			end

			Chat.Suggestions[Command] = {Help, Params}
		elseif type(Command) == "table" then
			for Index = 1, #Command do
				if not string.starts(Command[Index], "/") then 
					Command[Index] = "/" .. Command 
				end
			end

			for Index = 1, #Command do
				Chat.Suggestions[Command[Index]] = {Help, Params}
			end
		else
			return
		end
	end

	RegisterServerEvent("core:initalise")
	AddEventHandler("core:initalise", function()
		local Source = source
		for Command, Suggestion in pairs(Chat.Suggestions) do
			TriggerClientEvent("chat:addSuggestion", Source, Command, Suggestion[1], Suggestion[2])
		end

		for TemplateId, HtmlString in pairs(Chat.Templates) do
			TriggerClientEvent("chat:addTemplate", Source, TemplateId, HtmlString)
		end
	end)
else
	function Chat.Message(Author, Message, R, G, B, Multiline, Template)
		local Data = {
			color = {tonumber(R) or 255, tonumber(G) or 255,tonumber(B) or 255},
			multiline = Multiline or false,
			args = {},
		}
		if type(Author) == "string" then table.insert(Data.args, Author) end
		if type(Message) == "string" then table.insert(Data.args, Message) end
		if type(Template) == "string" then Data.templateId = Template end
		TriggerEvent("chat:addMessage", Data)
	end

	function Chat.Template(TemplateId, HtmlString)
		if type(TemplateId) == "string" and type(HtmlString) == "string" then
			TriggerEvent("chat:addTemplate", TemplateId, HtmlString)
		end
	end

	function Chat.Suggestion(Command, Help, Params)
		if type(Help) ~= "string" then	Help = "" end
		if type(Params) ~= "table" then Params = {} end

		if type(Command) == "string" then
			if not string.starts(Command, "/") then 
				Command = "/" .. Command 
			end

			TriggerEvent("chat:addSuggestion", Command, Help, Params)
		elseif type(Command) == "table" then
			for Index = 1, #Command do
				if not string.starts(Command[Index], "/") then 
					Command[Index] = "/" .. Command 
				end
			end

			for Index = 1, #Command do
				TriggerEvent("chat:addSuggestion", Command[Index], Help, Params)
			end
		else
			return
		end
	end

	RegisterNetEvent("chat:addProxMessage")
	AddEventHandler("chat:addProxMessage", function(Data, Radius, Source)
		local SourcePlayer = GetPlayerPed(GetPlayerFromServerId(Source))
		if DoesEntityExist(SourcePlayer) then
			local SourceCoordinates = GetEntityCoords(SourcePlayer, false)
			if GetDistanceBetweenCoords(SourceCoordinates.x, SourceCoordinates.y, SourceCoordinates.z, Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, true) <= Radius then
				TriggerEvent("chat:addMessage", Data)
			end
		end
	end)
end

function Chat.Command(Command, Callback, Restricted, Suggestions)
    if type(Command) ~= "string" and type(Command) ~= "table" then
        return Log.Error("Unable to add command!")
    end
    if type(Callback) ~= "function" then return Log.Error("Unable to add command!") end
    if type(Restricted) ~= "boolean" then Restricted = false end

    if type(Command) == "table" then
        for Index = 1, #Command do
            RegisterCommand(Command[Index], function(source, args, fullCommand)
                Callback(source, args, fullCommand)
            end, Restricted)
            
            if Suggestions then
                Chat.Suggestion(Command[Index], Suggestions.Help or "", Suggestions.Params or {})
            end
        end
    else
        RegisterCommand(Command, function(source, args, fullCommand)
            Callback(source, args, fullCommand)
        end, Restricted)

        if Suggestions then
            Chat.Suggestion(Command, Suggestions.Help or "", Suggestions.Params or {})
        end
    end
end
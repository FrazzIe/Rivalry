Group = {
	Data = {},
}

function Group.Exists(Id)
	for Index = 1, #Groups.Data do
		if Group.Data[Index].Id == Id then
			return true
		end
	end
	return false
end

function Group.Create(Id, Power, ...)
	if Group.Exists(Id) or Id == nil or tostring(Id) == nil or Id == "*" then
		return Error.Log("Unable to create group as the Id was invalid")
	end
	if not tonumber(Power) then Power = 0 end

	local _Group = {
		Id = tostring(Id),
		Power = Power,
		Inherits = {},
	}

	local Inherits = { ... }

	for Index = 1, #Inherits do
		if Group.Exists(Inherits[Index]) then
			table.insert(_Group.Inherits, Inherits[Index])
		elseif Inherits[Index] == "*" then
			_Group.Inherits = {}

			for GroupIndex = 1, #Group.Data do
				table.insert(_Group.Inherits, Group.Data[GroupIndex].Id)
			end

			break
		end
	end

	table.insert(Group.Data, _Group)
end

function Group.Get(Id)
	for Index = 1, #Groups.Data do
		if Group.Data[Index].Id == Id then
			return Group.Data[Index]
		end
	end
	return false
end

function Group.Power(Id)
	for Index = 1, #Group.Data do
		if Group.Data[Index].Id == Id then
			return Group.Data[Index].Power
		end
	end
	return 0
end

function Group.CanGroupTargetGroup(Initiator, Target)
	if Group.Exists(Initiator) and Group.Exists(Target) then
		return (Group.Power(Initiator) > Group.Power(Target))
	else
		return false
	end
end

function Group.Command(Command, Groups, Callback, RestrictedToUsers, Suggestions)
	if type(Command) ~= "string" and type(Command) ~= "table" then
		return Log.Error("Unable to add command!")
	end
	if type(Callback) ~= "function" then return Log.Error("Unable to add command!") end
	if type(Groups) ~= "table" then return Log.Error("Unable to add command!") end
	if type(Command) == "table" then
		for Index = 1, #Command do
			RegisterCommand(Command[Index], function(source, args, fullCommand)
				if not ((not RestrictedToUsers) and false or not (source ~= 0)) then
					Callback(source, args, fullCommand)
				else
					RconPrint("[INFO]You cannot use the command \""..Command[Index].."\" in the console!\n")
				end
			end, true)
			
			if Suggestions then
				Chat.Suggestion(Command[Index], Suggestions.Help or "", Suggestions.Params or {})
			end

			for GroupIndex = 1, #Groups do
				ExecuteCommand("add_ace group."..Groups[GroupIndex].." command."..Command[Index].." allow")
			end
		end
	else
		RegisterCommand(Command, function(source, args, fullCommand)
			if not ((not RestrictedToUsers) and false or not (source ~= 0)) then
				Callback(source, args, fullCommand)
			else
				RconPrint("[INFO]You cannot use the command \""..Command.."\" in the console!\n")
			end
		end, true)

		if Suggestions then
			Chat.Suggestion(Command, Suggestions.Help or "", Suggestions.Params or {})
		end
		
		for Index = 1, #Groups do
			ExecuteCommand("add_ace group."..Groups[Index].." command."..Command.." allow")
		end
	end    
end

Group.Create("User", 0)

Group.Create("Police", 1)
Group.Create("Paramedic", 1)
Group.Create("DOJ", 1)

Group.Create("Police Command", 2, "Police")
Group.Create("Paramedic Command", 2, "Paramedic")

Group.Create("DOJ Command", 3, "Police Command", "Paramedic Command")

Group.Create("Admin", 4)

Group.Create("Staff", 5, "Admin")

Group.Create("Founder", 6, "*")
function Core.Groups.Add(Id)
	if tostring(Id) then
		if not Core.Groups[Id] then
			Core.Groups[Id] = {}
		end
	end
end

function Core.Groups.AddInherit(TargetGroup, InheritGroup)
	if Core.Groups[TargetGroup] and Core.Groups[InheritGroup] then
		if not Core.Groups[TargetGroup][InheritGroup] then
			Core.Groups[TargetGroup][InheritGroup] = true
			ExecuteCommand("add_principal group."..TargetGroup.." group."..InheritGroup)
		end
	end
end

function Core.Groups.RemoveInherit(TargetGroup, InheritGroup)
	if Core.Groups[TargetGroup] and Core.Groups[InheritGroup] then
		if Core.Groups[TargetGroup][InheritGroup] then
			Core.Groups[TargetGroup][InheritGroup] = nil
			ExecuteCommand("remove_principal group."..TargetGroup.." group."..InheritGroup)
		end
	end
end

function Core.Groups.AddCommand(Command, Group, Callback, Suggestions)
	if type(Command) ~= "string" and type(Command) ~= "table" then
		return Log.Error("Unable to add command!")
	end

	if type(Callback) ~= "function" then 
		return Log.Error("Unable to add command! (Callback is not a function)") 
	end

	if Core.Groups[Group] then 
		return Log.Error("Unable to add command! (Group doesn't exist)") 
	end

	if type(Command) == "table" then
		for Index = 1, #Command do
			RegisterCommand(Command[Index], function(Source, Args, FullCommand)
				if not (Source ~= 0) then
					Callback(Source, Args, FullCommand)
				else
					RconPrint("[INFO] You cannot use the command \""..Command[Index].."\" in the console!\n")
				end
			end, true)
			
			if Suggestions then
				Chat.Suggestion(Command[Index], Suggestions.Help or "", Suggestions.Params or {})
			end

			ExecuteCommand("add_ace group."..Group.." command."..Command[Index].." allow")
		end
	else
		RegisterCommand(Command, function(Source, Args, FullCommand)
			if not (Source ~= 0) then
				Callback(Source, Args, FullCommand)
			else
				RconPrint("[INFO] You cannot use the command \""..Command.."\" in the console!\n")
			end
		end, true)

		if Suggestions then
			Chat.Suggestion(Command, Suggestions.Help or "", Suggestions.Params or {})
		end
		
		ExecuteCommand("add_ace group."..Group.." command."..Command.." allow")
	end  
end

function Core.Groups.CanGroupTargetGroup(SourceGroup, TargetGroup)
	if Core.Groups[SourceGroup] and Core.Groups[TargetGroup] then
		if Core.Groups[SourceGroup][TargetGroup] then
			if not Core.Groups[TargetGroup][SourceGroup] then
				return true
			else
				return false
			end
		else
			return false
		end
	end
end
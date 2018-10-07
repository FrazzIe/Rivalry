-- Groups

exports("AddGroup", function(Id)
	if tostring(Id) then
		if not Core.Groups[Id] then
			Core.Groups[Id] = {}
		end
	end
end)

exports("AddGroupInherit", function(TargetGroup, InheritGroup)
	if Core.Groups[TargetGroup] and Core.Groups[InheritGroup] then
		if not Core.Groups[TargetGroup][InheritGroup] then
			Core.Groups[TargetGroup][InheritGroup] = true
			ExecuteCommand("add_principal group."..TargetGroup.." group."..InheritGroup)
		end
	end
end)

exports("RemoveGroupInherit", function(TargetGroup, InheritGroup)
	if Core.Groups[TargetGroup] and Core.Groups[InheritGroup] then
		if Core.Groups[TargetGroup][InheritGroup] then
			Core.Groups[TargetGroup][InheritGroup] = nil
			ExecuteCommand("remove_principal group."..TargetGroup.." group."..InheritGroup)
		end
	end
end)

exports("AddGroupCommand", function(Command, Group, Callback, Suggestions)
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
end)

exports("CanGroupTargetGroup", function(SourceGroup, TargetGroup)
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
end)

-- Power

exports("CanPlayerTargetPlayer", function(SourcePlayer, TargetPlayer)
	if Core.Players[SourcePlayer] and Core.Players[TargetPlayer] then
		if Core.Players[SourcePlayer].User and Core.Players[TargetPlayer].User then
			if Core.Players[SourcePlayer].User.Power > Core.Players[TargetPlayer].User.Power then
				return true
			else
				return false
			end
		else
			return false
		end
	end
end)

-- User Get

exports("GetPlayerUserId", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Id
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerSteam", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Steam
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerSteam64", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Steam64
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerSteam32", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Steam32
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerLicense", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.License
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerIP", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.IP
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerUsername", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Username
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerPlaytime", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Playtime
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerTimestamp", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Timestamp
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerPower", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Power
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerGroup", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Group
		else
			return nil
		end
	else
		return nil
	end
end)

-- Character Get

exports("GetPlayerCharacterId", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Id
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerBank", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Bank
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerJob", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Job
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerFirstname", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Firstname
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerLastname", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Lastname
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerName", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Name
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerGender", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Gender
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerPosition", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Position
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerCharacterPlaytime", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Playtime
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerCharacterTimestamp", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Timestamp
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerJailtime", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Jailtime
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerWeaponLicense", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Licenses.Weapon
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerDriversLicense", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Licenses.Drivers
		else
			return nil
		end
	else
		return nil
	end
end)

-- Set User

exports("SetPlayerPlaytime", function(Player, Amount)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].User then
				Log.Info("Set player "..Player.."'s playtime to "..tostring(Amount))

				Core.Players[Player].User.Playtime = Amount

				exports["GHMattiMySQL"]:QueryAsync("UPDATE User SET playtime=@playtime WHERE id=@id", {
					["@id"] = Core.Players[Player].User.Id,
					["@playtime"] = Core.Players[Player].User.Playtime,
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s playtime to "..tostring(Amount))
			end
		else
			Log.Error("Unable to set player "..Player.."'s playtime to "..tostring(Amount))
		end
	else
		Log.Error("Unable to set player "..Player.."'s playtime as the amount "..tostring(Amount).." wasn't a number value")
	end
end)

exports("SetPlayerPower", function(Player, Power)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].User then
				Log.Info("Set player "..Player.."'s power to "..tostring(Power))

				Core.Players[Player].User.Power = Power

				exports["GHMattiMySQL"]:QueryAsync("UPDATE User SET power=@power WHERE id=@id", {
					["@id"] = Core.Players[Player].User.Id,
					["@power"] = Core.Players[Player].User.Power,
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s power to "..tostring(Power))
			end
		else
			Log.Error("Unable to set player "..Player.."'s power to "..tostring(Power))
		end
	else
		Log.Error("Unable to set player "..Player.."'s power as the value "..tostring(Power).." wasn't a number value")
	end
end)

exports("SetPlayerGroup", function(Player, Group)
	if type(Group) == "string" then
		if Core.Groups[Group] then
			if Core.Players[Player] then
				if Core.Players[Player].User then
					Log.Info("Set player "..Player.."'s group to "..tostring(Group))

					Core.Players[Player].User.Group = Group

					exports["GHMattiMySQL"]:QueryAsync("UPDATE User SET group=@group WHERE id=@id", {
						["@id"] = Core.Players[Player].User.Id,
						["@group"] = Core.Players[Player].User.Group,
					})

					TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
				else
					Log.Error("Unable to set player "..Player.."'s group to "..tostring(Group))
				end
			else
				Log.Error("Unable to set player "..Player.."'s group to "..tostring(Group))
			end
		else
			Log.Error("Unable to set player "..Player.."'s group as the value "..tostring(Group).." as isn't a valid group")
		end
	else
		Log.Error("Unable to set player "..Player.."'s group as the value "..tostring(Group).." wasn't a string")
	end
end)

-- Set Character

exports("SetPlayerBank", function(Player, Amount)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s bank to "..tostring(Amount))

				Core.Players[Player].Character.Bank = Amount

				exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET bank=@bank WHERE id=@id", {
					["@id"] = Core.Players[Player].Character.Id,
					["@bank"] = Core.Players[Player].Character.Bank,
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s bank to "..tostring(Amount))
			end
		else
			Log.Error("Unable to set player "..Player.."'s bank to "..tostring(Amount))
		end
	else
		Log.Error("Unable to set player "..Player.."'s bank as the amount "..tostring(Amount).." wasn't a number value")
	end
end)

exports("SetPlayerJob", function(Player, Id)
	if type(Id) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s job to "..tostring(Id))

				Core.Players[Player].Character.Job = Id

				exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET job=@job WHERE id=@id", {
					["@id"] = Core.Players[Player].Character.Id,
					["@job"] = Core.Players[Player].Character.Job,
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s job to "..tostring(Id))
			end
		else
			Log.Error("Unable to set player "..Player.."'s job to "..tostring(Id))
		end
	else
		Log.Error("Unable to set player "..Player.."'s job as the amount "..tostring(Id).." wasn't a number value")
	end
end)

exports("SetPlayerFirstname", function(Player, Str)
	if type(Str) == "string" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s forename to "..tostring(Str))

				Core.Players[Player].Character.Firstname = Str
				Core.Players[Player].Character.Name = Core.Players[Player].Character.Firstname.." "..Core.Players[Player].Character.Lastname

				exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET firstname=@firstname WHERE id=@id", {
					["@id"] = Core.Players[Player].Character.Id,
					["@firstname"] = Core.Players[Player].Character.Firstname,
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s forename to "..tostring(Str))
			end
		else
			Log.Error("Unable to set player "..Player.."'s forename to "..tostring(Str))
		end
	else
		Log.Error("Unable to set player "..Player.."'s forename as the value "..tostring(Str).." wasn't a string value")
	end
end)

exports("SetPlayerLastname", function(Player, Str)
	if type(Str) == "string" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s surname to "..tostring(Str))

				Core.Players[Player].Character.Lastname = Str
				Core.Players[Player].Character.Name = Core.Players[Player].Character.Forename.." "..Core.Players[Player].Character.Lastname

				exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET lastname=@lastname WHERE id=@id", {
					["@id"] = Core.Players[Player].Character.Id,
					["@lastname"] = Core.Players[Player].Character.Lastname,
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s surname to "..tostring(Str))
			end
		else
			Log.Error("Unable to set player "..Player.."'s surname to "..tostring(Str))
		end
	else
		Log.Error("Unable to set player "..Player.."'s surname as the value "..tostring(Str).." wasn't a string value")
	end
end)

exports("SetPlayerGender", function(Player, Str)
	if type(Str) == "string" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s gender to "..tostring(Str))

				Core.Players[Player].Character.Gender = Str

				exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET gender=@gender WHERE id=@id", {
					["@id"] = Core.Players[Player].Character.Id,
					["@gender"] = Core.Players[Player].Character.Gender,
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s gender to "..tostring(Str))
			end
		else
			Log.Error("Unable to set player "..Player.."'s gender to "..tostring(Str))
		end
	else
		Log.Error("Unable to set player "..Player.."'s gender as the value "..tostring(Str).." wasn't a string value")
	end
end)

exports("SetPlayerPosition", function(Player, X, Y, Z)
	if type(X) == "number" or type(Y) == "number" or type(Z) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s position to "..tostring(X)..", "..tostring(Y)..", "..tostring(Z))

				if tonumber(X) then
					Core.Players[Player].Character.Position.x = X
				end

				if tonumber(Y) then
					Core.Players[Player].Character.Position.y = Y
				end

				if tonumber(Z) then
					Core.Players[Player].Character.Position.z = Z
				end

				exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET position_x=@position_x, position_y=@position_y, position_z=@position_z WHERE id=@id", {
					["@id"] = Core.Players[Player].Character.Id,
					["@position_x"] = Core.Players[Player].Character.Position.x,
					["@position_y"] = Core.Players[Player].Character.Position.y,
					["@position_z"] = Core.Players[Player].Character.Position.z,
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s position to to "..tostring(X)..", "..tostring(Y)..", "..tostring(Z))
			end
		else
			Log.Error("Unable to set player "..Player.."'s position to to "..tostring(X)..", "..tostring(Y)..", "..tostring(Z))
		end
	end
end)

exports("SetPlayerCharacterPlaytime", function(Player, Amount)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s playtime to "..tostring(Amount))

				Core.Players[Player].Character.Playtime = Amount

				exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET playtime=@playtime WHERE id=@id", {
					["@id"] = Core.Players[Player].Character.Id,
					["@playtime"] = Core.Players[Player].Character.Playtime,
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s playtime to "..tostring(Amount))
			end
		else
			Log.Error("Unable to set player "..Player.."'s playtime to "..tostring(Amount))
		end
	else
		Log.Error("Unable to set player "..Player.."'s playtime as the amount "..tostring(Amount).." wasn't a number value")
	end
end)

exports("SetPlayerJailtime", function(Player, Amount)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s jailtime to "..tostring(Amount))

				Core.Players[Player].Character.Jailtime = Amount

				exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET jail_time=@jail_time WHERE id=@id", {
					["@id"] = Core.Players[Player].Character.Id,
					["@jail_time"] = Core.Players[Player].Character.Jailtime,
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s jailtime to "..tostring(Amount))
			end
		else
			Log.Error("Unable to set player "..Player.."'s jailtime to "..tostring(Amount))
		end
	else
		Log.Error("Unable to set player "..Player.."'s jailtime as the amount "..tostring(Amount).." wasn't a number value")
	end
end)

exports("SetPlayerWeaponLicense", function(Player, Bool)
	if type(Bool) == "boolean" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s weapon license to "..tostring(Bool))

				Core.Players[Player].Character.Licenses.Weapon = Bool

				exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET weapon_license=@weapon_license WHERE id=@id", {
					["@id"] = Core.Players[Player].Character.Id,
					["@weapon_license"] = Utilities.BoolToNumber(Core.Players[Player].Character.Licenses.Weapon),
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s weapon license to "..tostring(Bool))
			end
		else
			Log.Error("Unable to set player "..Player.."'s weapon license to "..tostring(Bool))
		end
	else
		Log.Error("Unable to set player "..Player.."'s weapon license as the amount "..tostring(Bool).." wasn't a number value")
	end
end)

exports("SetPlayerDriversLicense", function(Player, Bool)
	if type(Bool) == "boolean" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s drivers license to "..tostring(Bool))

				Core.Players[Player].Character.Licenses.Drivers = Bool

				exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET drivers_license=@drivers_license WHERE id=@id", {
					["@id"] = Core.Players[Player].Character.Id,
					["@drivers_license"] = Utilities.BoolToNumber(Core.Players[Player].Character.Licenses.Drivers),
				})

				TriggerClientEvent("Core.Sync", -1, {Groups = Core.Groups, Players = Core.Players})
			else
				Log.Error("Unable to set player "..Player.."'s drivers license to "..tostring(Bool))
			end
		else
			Log.Error("Unable to set player "..Player.."'s drivers license to "..tostring(Bool))
		end
	else
		Log.Error("Unable to set player "..Player.."'s drivers license as the amount "..tostring(Bool).." wasn't a number value")
	end
end)
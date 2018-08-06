-- User Get

function Export_GetPlayerUserId(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Id
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerSteam(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Steam
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerSteam64(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Steam64
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerSteam32(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Steam32
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerLicense(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.License
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerIP(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.IP
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerUsername(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Username
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerPlaytime(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Playtime
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerTimestamp(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Timestamp
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerPower(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Power
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerGroup(Player)
	if Core.Players[Player] then
		if Core.Players[Player].User then
			return Core.Players[Player].User.Group
		else
			return nil
		end
	else
		return nil
	end
end

-- Character Get

function Export_GetPlayerCharacterId(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Id
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerCash(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Cash
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerCounterfeit(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Counterfeit
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerBank(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Bank
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerJob(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Job
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerForename(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Firstname
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerSurname(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Surname
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerName(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Name
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerGender(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Gender
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerPosition(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Position
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerCharacterPlaytime(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Playtime
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerCharacterTimestamp(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Timestamp
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerJailtime(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Jailtime
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerWeaponLicense(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Licenses.Weapon
		else
			return nil
		end
	else
		return nil
	end
end

function Export_GetPlayerDriversLicense(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Licenses.Drivers
		else
			return nil
		end
	else
		return nil
	end
end

-- Set User

function Export_SetPlayerPlaytime(Player, Amount)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].User then
				Log.Info("Set player "..Player.."'s playtime to "..tostring(Amount))

				Core.Players[Player].User.Playtime = Amount
			else
				Log.Error("Unable to set player "..Player.."'s playtime to "..tostring(Amount))
			end
		else
			Log.Error("Unable to set player "..Player.."'s playtime to "..tostring(Amount))
		end
	else
		Log.Error("Unable to set player "..Player.."'s playtime as the amount "..tostring(Amount).." wasn't a number value")
	end
end

function Export_SetPlayerPower(Player, Power)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].User then
				Log.Info("Set player "..Player.."'s power to "..tostring(Power))

				Core.Players[Player].User.Power = Power
			else
				Log.Error("Unable to set player "..Player.."'s power to "..tostring(Power))
			end
		else
			Log.Error("Unable to set player "..Player.."'s power to "..tostring(Power))
		end
	else
		Log.Error("Unable to set player "..Player.."'s power as the value "..tostring(Power).." wasn't a number value")
	end
end

function Export_SetPlayerGroup(Player, Group)
	if type(Group) == "string" then
		if Core.Groups[Group] then
			if Core.Players[Player] then
				if Core.Players[Player].User then
					Log.Info("Set player "..Player.."'s group to "..tostring(Group))

					Core.Players[Player].User.Group = Group
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
end

-- Set Character

function Export_SetPlayerCash(Player, Amount)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s cash to "..tostring(Amount))

				Core.Players[Player].Character.Cash = Amount
			else
				Log.Error("Unable to set player "..Player.."'s cash to "..tostring(Amount))
			end
		else
			Log.Error("Unable to set player "..Player.."'s cash to "..tostring(Amount))
		end
	else
		Log.Error("Unable to set player "..Player.."'s cash as the amount "..tostring(Amount).." wasn't a number value")
	end
end

function Export_SetPlayerCounterfeit(Player, Amount)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s counterfeit to "..tostring(Amount))

				Core.Players[Player].Character.Counterfeit = Amount
			else
				Log.Error("Unable to set player "..Player.."'s counterfeit to "..tostring(Amount))
			end
		else
			Log.Error("Unable to set player "..Player.."'s counterfeit to "..tostring(Amount))
		end
	else
		Log.Error("Unable to set player "..Player.."'s counterfeit as the amount "..tostring(Amount).." wasn't a number value")
	end
end

function Export_SetPlayerBank(Player, Amount)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s bank to "..tostring(Amount))

				Core.Players[Player].Character.Bank = Amount
			else
				Log.Error("Unable to set player "..Player.."'s bank to "..tostring(Amount))
			end
		else
			Log.Error("Unable to set player "..Player.."'s bank to "..tostring(Amount))
		end
	else
		Log.Error("Unable to set player "..Player.."'s bank as the amount "..tostring(Amount).." wasn't a number value")
	end
end

function Export_SetPlayerForename(Player, Str)
	if type(Str) == "string" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s forename to "..tostring(Str))

				Core.Players[Player].Character.Forename = Str
				Core.Players[Player].Character.Name = Core.Players[Player].Character.Forename.." "..Core.Players[Player].Character.Surname
			else
				Log.Error("Unable to set player "..Player.."'s forename to "..tostring(Str))
			end
		else
			Log.Error("Unable to set player "..Player.."'s forename to "..tostring(Str))
		end
	else
		Log.Error("Unable to set player "..Player.."'s forename as the value "..tostring(Str).." wasn't a string value")
	end
end

function Export_SetPlayerSurname(Player, Str)
	if type(Str) == "string" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s surname to "..tostring(Str))

				Core.Players[Player].Character.Surname = Str
				Core.Players[Player].Character.Name = Core.Players[Player].Character.Forename.." "..Core.Players[Player].Character.Surname
			else
				Log.Error("Unable to set player "..Player.."'s surname to "..tostring(Str))
			end
		else
			Log.Error("Unable to set player "..Player.."'s surname to "..tostring(Str))
		end
	else
		Log.Error("Unable to set player "..Player.."'s surname as the value "..tostring(Str).." wasn't a string value")
	end
end

function Export_SetPlayerGender(Player, Str)
	if type(Str) == "string" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s gender to "..tostring(Str))

				Core.Players[Player].Character.Gender = Str
			else
				Log.Error("Unable to set player "..Player.."'s gender to "..tostring(Str))
			end
		else
			Log.Error("Unable to set player "..Player.."'s gender to "..tostring(Str))
		end
	else
		Log.Error("Unable to set player "..Player.."'s gender as the value "..tostring(Str).." wasn't a string value")
	end
end

function Export_SetPlayerPosition(Player, X, Y, Z)
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
			else
				Log.Error("Unable to set player "..Player.."'s position to to "..tostring(X)..", "..tostring(Y)..", "..tostring(Z))
			end
		else
			Log.Error("Unable to set player "..Player.."'s position to to "..tostring(X)..", "..tostring(Y)..", "..tostring(Z))
		end
	end
end

function Export_SetPlayerCharacterPlaytime(Player, Amount)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s playtime to "..tostring(Amount))

				Core.Players[Player].Character.Playtime = Amount
			else
				Log.Error("Unable to set player "..Player.."'s playtime to "..tostring(Amount))
			end
		else
			Log.Error("Unable to set player "..Player.."'s playtime to "..tostring(Amount))
		end
	else
		Log.Error("Unable to set player "..Player.."'s playtime as the amount "..tostring(Amount).." wasn't a number value")
	end
end

function Export_SetPlayerJailtime(Player, Amount)
	if type(Amount) == "number" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s jailtime to "..tostring(Amount))

				Core.Players[Player].Character.Jailtime = Amount
			else
				Log.Error("Unable to set player "..Player.."'s jailtime to "..tostring(Amount))
			end
		else
			Log.Error("Unable to set player "..Player.."'s jailtime to "..tostring(Amount))
		end
	else
		Log.Error("Unable to set player "..Player.."'s jailtime as the amount "..tostring(Amount).." wasn't a number value")
	end
end

function Export_SetPlayerWeaponLicense(Player, Bool)
	if type(Bool) == "boolean" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s weapon license to "..tostring(Bool))

				Core.Players[Player].Character.Licenses.Weapon = Bool
			else
				Log.Error("Unable to set player "..Player.."'s weapon license to "..tostring(Bool))
			end
		else
			Log.Error("Unable to set player "..Player.."'s weapon license to "..tostring(Bool))
		end
	else
		Log.Error("Unable to set player "..Player.."'s weapon license as the amount "..tostring(Bool).." wasn't a number value")
	end
end

function Export_SetPlayerDriversLicense(Player, Bool)
	if type(Bool) == "boolean" then
		if Core.Players[Player] then
			if Core.Players[Player].Character then
				Log.Info("Set player "..Player.."'s drivers license to "..tostring(Bool))

				Core.Players[Player].Character.Licenses.Drivers = Bool
			else
				Log.Error("Unable to set player "..Player.."'s drivers license to "..tostring(Bool))
			end
		else
			Log.Error("Unable to set player "..Player.."'s drivers license to "..tostring(Bool))
		end
	else
		Log.Error("Unable to set player "..Player.."'s drivers license as the amount "..tostring(Bool).." wasn't a number value")
	end
end

-- Exports

-- User Get

function Core.GetPlayerUserId(Player)
	return exports["Rivalry"]:Export_GetPlayerUserId(Player)
end

function Core.GetPlayerSteam(Player)
	return exports["Rivalry"]:Export_GetPlayerSteam(Player)
end

function Core.GetPlayerSteam64(Player)
	return exports["Rivalry"]:Export_GetPlayerSteam64(Player)
end

function Core.GetPlayerSteam32(Player)
	return exports["Rivalry"]:Export_GetPlayerSteam32(Player)
end

function Core.GetPlayerLicense(Player)
	return exports["Rivalry"]:Export_GetPlayerLicense(Player)
end

function Core.GetPlayerIP(Player)
	return exports["Rivalry"]:Export_GetPlayerIP(Player)
end

function Core.GetPlayerUsername(Player)
	return exports["Rivalry"]:Export_GetPlayerUsername(Player)
end

function Core.GetPlayerPlaytime(Player)
	return exports["Rivalry"]:Export_GetPlayerPlaytime(Player)
end

function Core.GetPlayerTimestamp(Player)
	return exports["Rivalry"]:Export_GetPlayerTimestamp(Player)
end

function Core.GetPlayerPower(Player)
	return exports["Rivalry"]:Export_GetPlayerPower(Player)
end

function Core.GetPlayerGroup(Player)
	return exports["Rivalry"]:Export_GetPlayerGroup(Player)
end

-- Character Get

function Core.GetPlayerCharacterId(Player)
	return exports["Rivalry"]:Export_GetPlayerCharacterId(Player)
end

function Core.GetPlayerCash(Player)
	return exports["Rivalry"]:Export_GetPlayerCash(Player)
end

function Core.GetPlayerCounterfeit(Player)
	return exports["Rivalry"]:Export_GetPlayerCounterfeit(Player)
end

function Core.GetPlayerBank(Player)
	return exports["Rivalry"]:Export_GetPlayerBank(Player)
end

function Core.GetPlayerJob(Player)
	return exports["Rivalry"]:Export_GetPlayerJob(Player)
end

function Core.GetPlayerForename(Player)
	return exports["Rivalry"]:Export_GetPlayerForename(Player)
end

function Core.GetPlayerSurname(Player)
	return exports["Rivalry"]:Export_GetPlayerSurname(Player)
end

function Core.GetPlayerName(Player)
	return exports["Rivalry"]:Export_GetPlayerName(Player)
end

function Core.GetPlayerGender(Player)
	return exports["Rivalry"]:Export_GetPlayerGender(Player)
end

function Core.GetPlayerPosition(Player)
	return exports["Rivalry"]:Export_GetPlayerPosition(Player)
end

function Core.GetPlayerCharacterPlaytime(Player)
	return exports["Rivalry"]:Export_GetPlayerCharacterPlaytime(Player)
end

function Core.GetPlayerCharacterTimestamp(Player)
	return exports["Rivalry"]:Export_GetPlayerCharacterTimestamp(Player)
end

function Core.GetPlayerJailtime(Player)
	return exports["Rivalry"]:Export_GetPlayerJailtime(Player)
end

function Core.GetPlayerWeaponLicense(Player)
	return exports["Rivalry"]:Export_GetPlayerWeaponLicense(Player)
end

function Core.GetPlayerDriversLicense(Player)
	return exports["Rivalry"]:Export_GetPlayerDriversLicense(Player)
end

-- Set User

function Core.SetPlayerPlaytime(Player, Amount)
	exports["Rivalry"]:Export_SetPlayerPlaytime(Player, Amount)
end

function Core.SetPlayerPower(Player, Power)
	exports["Rivalry"]:Export_SetPlayerPower(Player, Power)
end

function Core.SetPlayerGroup(Player, Group)
	exports["Rivalry"]:Export_SetPlayerGroup(Player, Group)
end

-- Set Character

function Core.SetPlayerCash(Player, Amount)
	exports["Rivalry"]:Export_SetPlayerCash(Player, Amount)
end

function Core.SetPlayerCounterfeit(Player, Amount)
	exports["Rivalry"]:Export_SetPlayerCounterfeit(Player, Amount)
end

function Core.SetPlayerBank(Player, Amount)
	exports["Rivalry"]:Export_SetPlayerBank(Player, Amount)
end

function Core.SetPlayerForename(Player, Str)
	exports["Rivalry"]:Export_SetPlayerForename(Player, Str)
end

function Core.SetPlayerSurname(Player, Str)
	exports["Rivalry"]:Export_SetPlayerSurname(Player, Str)
end

function Core.SetPlayerGender(Player, Str)
	exports["Rivalry"]:Export_SetPlayerGender(Player, Str)
end

function Core.SetPlayerPosition(Player, X, Y, Z)
	exports["Rivalry"]:Export_SetPlayerPosition(Player, X, Y, Z)
end

function Core.SetPlayerCharacterPlaytime(Player, Amount)
	exports["Rivalry"]:Export_SetPlayerCharacterPlaytime(Player, Amount)
end

function Core.SetPlayerJailtime(Player, Amount)
	exports["Rivalry"]:Export_SetPlayerJailtime(Player, Amount)
end

function Core.SetPlayerWeaponLicense(Player, Bool)
	exports["Rivalry"]:Export_SetPlayerWeaponLicense(Player, Bool)
end

function Core.SetPlayerDriversLicense(Player, Bool)
	exports["Rivalry"]:Export_SetPlayerDriversLicense(Player, Bool)
end
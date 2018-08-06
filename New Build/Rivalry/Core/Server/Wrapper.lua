-- User Get

function Core.GetPlayerUserId(Player)
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

function Core.GetPlayerSteam(Player)
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

function Core.GetPlayerSteam64(Player)
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

function Core.GetPlayerSteam32(Player)
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

function Core.GetPlayerLicense(Player)
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

function Core.GetPlayerIP(Player)
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

function Core.GetPlayerUsername(Player)
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

function Core.GetPlayerPlaytime(Player)
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

function Core.GetPlayerTimestamp(Player)
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

function Core.GetPlayerPower(Player)
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

function Core.GetPlayerGroup(Player)
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

function Core.GetPlayerCharacterId(Player)
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

function Core.GetPlayerCash(Player)
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

function Core.GetPlayerCounterfeit(Player)
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

function Core.GetPlayerBank(Player)
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

function Core.GetPlayerJob(Player)
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

function Core.GetPlayerForename(Player)
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

function Core.GetPlayerSurname(Player)
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

function Core.GetPlayerName(Player)
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

function Core.GetPlayerGender(Player)
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

function Core.GetPlayerPosition(Player)
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

function Core.GetPlayerCharacterPlaytime(Player)
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

function Core.GetPlayerCharacterTimestamp(Player)
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

function Core.GetPlayerJailtime(Player)
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

function Core.GetPlayerWeaponLicense(Player)
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

function Core.GetPlayerDriversLicense(Player)
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

function Core.SetPlayerPlaytime(Player, Amount)
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

function Core.SetPlayerPower(Player, Power)
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

function Core.SetPlayerGroup(Player, Group)
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

function Core.SetPlayerCash(Player, Amount)
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

function Core.SetPlayerCounterfeit(Player, Amount)
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

function Core.SetPlayerBank(Player, Amount)
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

function Core.SetPlayerForename(Player, Str)
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

function Core.SetPlayerSurname(Player, Str)
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

function Core.SetPlayerGender(Player, Str)
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

function Core.SetPlayerPosition(Player, X, Y, Z)
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

function Core.SetPlayerCharacterPlaytime(Player, Amount)
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

function Core.SetPlayerJailtime(Player, Amount)
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

function Core.SetPlayerWeaponLicense(Player, Bool)
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

function Core.SetPlayerDriversLicense(Player, Bool)
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
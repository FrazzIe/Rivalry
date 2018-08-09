function Export_CanGroupTargetGroup(SourceGroup, TargetGroup)
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

-- Power

function Export_CanPlayerTargetPlayer(SourcePlayer, TargetPlayer)
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
end

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

function Export_GetPlayerFirstname(Player)
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

function Export_GetPlayerLastname(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Lastname
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
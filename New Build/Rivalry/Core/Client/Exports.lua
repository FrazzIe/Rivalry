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

exports("GetPlayerCash", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Cash
		else
			return nil
		end
	else
		return nil
	end
end)

exports("GetPlayerCounterfeit", function(Player)
	if Core.Players[Player] then
		if Core.Players[Player].Character then
			return Core.Players[Player].Character.Counterfeit
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
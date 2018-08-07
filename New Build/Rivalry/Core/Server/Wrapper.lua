function Core.CanPlayerTargetPlayer(SourcePlayer, TargetPlayer)
	return exports["Rivalry"]:Export_CanPlayerTargetPlayer(SourcePlayer, TargetPlayer)
end

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
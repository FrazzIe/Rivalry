-- Groups

function Core.AddGroup(Id)
	exports["Rivalry"]:AddGroup(Id)
end

function Core.AddGroupInherit(TargetGroup, InheritGroup)
	exports["Rivalry"]:AddGroupInherit(TargetGroup, InheritGroup)
end

function Core.RemoveGroupInherit(TargetGroup, InheritGroup)
	exports["Rivalry"]:RemoveGroupInherit(TargetGroup, InheritGroup)
end

function Core.AddGroupCommand(Command, Group, Callback, Suggestions)
 	exports["Rivalry"]:AddGroupCommand(Command, Group, Callback, Suggestions)
end

function Core.CanGroupTargetGroup(SourceGroup, TargetGroup)
	return exports["Rivalry"]:CanGroupTargetGroup(SourceGroup, TargetGroup)
end

-- Power

function Core.CanPlayerTargetPlayer(SourcePlayer, TargetPlayer)
	return exports["Rivalry"]:CanPlayerTargetPlayer(SourcePlayer, TargetPlayer)
end

-- User Get

function Core.GetPlayerUserId(Player)
	return exports["Rivalry"]:GetPlayerUserId(Player)
end

function Core.GetPlayerSteam(Player)
	return exports["Rivalry"]:GetPlayerSteam(Player)
end

function Core.GetPlayerSteam64(Player)
	return exports["Rivalry"]:GetPlayerSteam64(Player)
end

function Core.GetPlayerSteam32(Player)
	return exports["Rivalry"]:GetPlayerSteam32(Player)
end

function Core.GetPlayerLicense(Player)
	return exports["Rivalry"]:GetPlayerLicense(Player)
end

function Core.GetPlayerIP(Player)
	return exports["Rivalry"]:GetPlayerIP(Player)
end

function Core.GetPlayerUsername(Player)
	return exports["Rivalry"]:GetPlayerUsername(Player)
end

function Core.GetPlayerPlaytime(Player)
	return exports["Rivalry"]:GetPlayerPlaytime(Player)
end

function Core.GetPlayerTimestamp(Player)
	return exports["Rivalry"]:GetPlayerTimestamp(Player)
end

function Core.GetPlayerPower(Player)
	return exports["Rivalry"]:GetPlayerPower(Player)
end

function Core.GetPlayerGroup(Player)
	return exports["Rivalry"]:GetPlayerGroup(Player)
end

-- Character Get

function Core.GetPlayerCharacterId(Player)
	return exports["Rivalry"]:GetPlayerCharacterId(Player)
end

function Core.GetPlayerCash(Player)
	return exports["Rivalry"]:GetPlayerCash(Player)
end

function Core.GetPlayerCounterfeit(Player)
	return exports["Rivalry"]:GetPlayerCounterfeit(Player)
end

function Core.GetPlayerBank(Player)
	return exports["Rivalry"]:GetPlayerBank(Player)
end

function Core.GetPlayerJob(Player)
	return exports["Rivalry"]:GetPlayerJob(Player)
end

function Core.GetPlayerFirstname(Player)
	return exports["Rivalry"]:GetPlayerFirstname(Player)
end

function Core.GetPlayerLastname(Player)
	return exports["Rivalry"]:GetPlayerLastname(Player)
end

function Core.GetPlayerName(Player)
	return exports["Rivalry"]:GetPlayerName(Player)
end

function Core.GetPlayerGender(Player)
	return exports["Rivalry"]:GetPlayerGender(Player)
end

function Core.GetPlayerPosition(Player)
	return exports["Rivalry"]:GetPlayerPosition(Player)
end

function Core.GetPlayerCharacterPlaytime(Player)
	return exports["Rivalry"]:GetPlayerCharacterPlaytime(Player)
end

function Core.GetPlayerCharacterTimestamp(Player)
	return exports["Rivalry"]:GetPlayerCharacterTimestamp(Player)
end

function Core.GetPlayerJailtime(Player)
	return exports["Rivalry"]:GetPlayerJailtime(Player)
end

function Core.GetPlayerWeaponLicense(Player)
	return exports["Rivalry"]:GetPlayerWeaponLicense(Player)
end

function Core.GetPlayerDriversLicense(Player)
	return exports["Rivalry"]:GetPlayerDriversLicense(Player)
end

-- Set User

function Core.SetPlayerPlaytime(Player, Amount)
	exports["Rivalry"]:SetPlayerPlaytime(Player, Amount)
end

function Core.SetPlayerPower(Player, Power)
	exports["Rivalry"]:SetPlayerPower(Player, Power)
end

function Core.SetPlayerGroup(Player, Group)
	exports["Rivalry"]:SetPlayerGroup(Player, Group)
end

-- Set Character

function Core.SetPlayerCash(Player, Amount)
	exports["Rivalry"]:SetPlayerCash(Player, Amount)
end

function Core.SetPlayerCounterfeit(Player, Amount)
	exports["Rivalry"]:SetPlayerCounterfeit(Player, Amount)
end

function Core.SetPlayerBank(Player, Amount)
	exports["Rivalry"]:SetPlayerBank(Player, Amount)
end

function Core.SetPlayerJob(Player, Id)
	exports["Rivalry"]:SetPlayerJob(Player, Id)
end

function Core.SetPlayerFirstname(Player, Str)
	exports["Rivalry"]:SetPlayerFirstname(Player, Str)
end

function Core.SetPlayerLastname(Player, Str)
	exports["Rivalry"]:SetPlayerlastname(Player, Str)
end

function Core.SetPlayerGender(Player, Str)
	exports["Rivalry"]:SetPlayerGender(Player, Str)
end

function Core.SetPlayerPosition(Player, X, Y, Z)
	exports["Rivalry"]:SetPlayerPosition(Player, X, Y, Z)
end

function Core.SetPlayerCharacterPlaytime(Player, Amount)
	exports["Rivalry"]:SetPlayerCharacterPlaytime(Player, Amount)
end

function Core.SetPlayerJailtime(Player, Amount)
	exports["Rivalry"]:SetPlayerJailtime(Player, Amount)
end

function Core.SetPlayerWeaponLicense(Player, Bool)
	exports["Rivalry"]:SetPlayerWeaponLicense(Player, Bool)
end

function Core.SetPlayerDriversLicense(Player, Bool)
	exports["Rivalry"]:SetPlayerDriversLicense(Player, Bool)
end
exports("GetCharacterName", function(Player)
	local Player = tonumber(Player)

	if Characters[Player] then
		return Characters[Player].get("first_name") .. Characters[Player].get("last_name")
	else
		return nil
	end
end)

exports("GetCharacterId", function(Player)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		return Characters[Player].get("characterID")
	else
		return nil
	end
end)

exports("GetPlayerCash", function(Player)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		return Characters[Player].get("wallet")
	else
		return nil
	end
end)

exports("GetPlayerBank", function(Player)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		return Characters[Player].get("bank")
	else
		return nil
	end
end)

exports("GetPlayerDirty", function(Player)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		return Characters[Player].get("dirty")
	else
		return nil
	end
end)

exports("GetPlayerJob", function(Player)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		return Characters[Player].get("job")
	else
		return nil
	end
end)

exports("SetPlayerCash", function(Player, Amount)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		Characters[Player].wallet(Amount)
	end
end)

exports("AddPlayerCash", function(Player, Amount)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		Characters[Player].addWallet(Amount)
	end
end)

exports("RemovePlayerCash", function(Player, Amount)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		Characters[Player].removeWallet(Amount)
	end
end)

exports("SetPlayerBank", function(Player, Amount)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		Characters[Player].bank(Amount)
	end
end)

exports("AddPlayerBank", function(Player, Amount)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		Characters[Player].addBank(Amount)
	end
end)

exports("RemovePlayerBank", function(Player, Amount)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		Characters[Player].removeBank(Amount)
	end
end)

exports("SetPlayerDirty", function(Player, Amount)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		Characters[Player].dirty(Amount)
	end
end)

exports("AddPlayerDirty", function(Player, Amount)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		Characters[Player].addDirty(Amount)
	end
end)

exports("RemovePlayerDirty", function(Player, Amount)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		Characters[Player].removeDirty(Amount)
	end
end)

exports("SetPlayerJob", function(Player, Id)
	local Player = tonumber(Player)
	
	if Characters[Player] then
		Characters[Player].job(Amount)
	end
end)
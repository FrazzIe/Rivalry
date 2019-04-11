exports("GetCharacterName", function(Player)
	if Characters[Player] then
		return Characters[Player].first_name .. Characters[Player].last_name
	else
		return nil
	end
end)

exports("GetCharacterId", function(Player)
	if Characters[Player] then
		return Characters[Player].characterID
	else
		return nil
	end
end)

exports("GetPlayerCash", function(Player)
	if Characters[Player] then
		return Characters[Player].wallet
	else
		return nil
	end
end)

exports("GetPlayerBank", function(Player)
	if Characters[Player] then
		return Characters[Player].bank
	else
		return nil
	end
end)

exports("GetPlayerDirty", function(Player)
	if Characters[Player] then
		return Characters[Player].dirty
	else
		return nil
	end
end)

exports("GetPlayerJob", function(Player)
	if Characters[Player] then
		return Characters[Player].job
	else
		return nil
	end
end)

exports("SetPlayerCash", function(Player, Amount)
	if Characters[Player] then
		if tonumber(Amount) ~= nil then
			Characters[Player].wallet = math.floor(tonumber(Amount))

			exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET wallet=@wallet WHERE character_id=@id", { ["@id"] = Characters[Player].characterID, ["@wallet"] = Characters[Player].wallet })

			TriggerClientEvent("core:updateMoney", Player, Characters[Player].wallet, "wallet", "set", math.floor(tonumber(Amount)))
		end
	end
end)

exports("AddPlayerCash", function(Player, Amount)
	if Characters[Player] then
		if tonumber(Amount) ~= nil then
			Characters[Player].wallet = Characters[Player].wallet + math.floor(tonumber(Amount))

			exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET wallet=@wallet WHERE character_id=@id", { ["@id"] = Characters[Player].characterID, ["@wallet"] = Characters[Player].wallet })

			TriggerClientEvent("core:updateMoney", Player, Characters[Player].wallet, "wallet", "set", math.floor(tonumber(Amount)))
		end
	end
end)

exports("RemovePlayerCash", function(Player, Amount)
	if Characters[Player] then
		if tonumber(Amount) ~= nil then
			Characters[Player].wallet = Characters[Player].wallet - math.floor(tonumber(Amount))

			exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET wallet=@wallet WHERE character_id=@id", { ["@id"] = Characters[Player].characterID, ["@wallet"] = Characters[Player].wallet })

			TriggerClientEvent("core:updateMoney", Player, Characters[Player].wallet, "wallet", "set", math.floor(tonumber(Amount)))
		end
	end
end)

exports("SetPlayerBank", function(Player, Amount)
	if Characters[Player] then
		if tonumber(Amount) ~= nil then
			Characters[Player].bank= math.floor(tonumber(Amount))

			exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET bank=@bank WHERE character_id=@id", { ["@id"] = Characters[Player].characterID, ["@bank"] = Characters[Player].bank })

			TriggerClientEvent("core:updateMoney", Player, Characters[Player].bank, "bank", "set", math.floor(tonumber(Amount)))
		end
	end
end)

exports("AddPlayerBank", function(Player, Amount)
	if Characters[Player] then
		if tonumber(Amount) ~= nil then
			Characters[Player].bank = Characters[Player].bank + math.floor(tonumber(Amount))

			exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET bank=@bank WHERE character_id=@id", { ["@id"] = Characters[Player].characterID, ["@bank"] = Characters[Player].bank })

			TriggerClientEvent("core:updateMoney", Player, Characters[Player].bank, "bank", "set", math.floor(tonumber(Amount)))
		end
	end
end)

exports("RemovePlayerBank", function(Player, Amount)
	if Characters[Player] then
		if tonumber(Amount) ~= nil then
			Characters[Player].bank = Characters[Player].bank - math.floor(tonumber(Amount))

			exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET bank=@bank WHERE character_id=@id", { ["@id"] = Characters[Player].characterID, ["@bank"] = Characters[Player].bank })

			TriggerClientEvent("core:updateMoney", Player, Characters[Player].bank, "bank", "set", math.floor(tonumber(Amount)))
		end
	end
end)

exports("SetPlayerDirty", function(Player, Amount)
	if Characters[Player] then
		if tonumber(Amount) ~= nil then
			Characters[Player].dirty = math.floor(tonumber(Amount))

			exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET dirty_cash=@dirty_cash WHERE character_id=@id", { ["@id"] = Characters[Player].characterID, ["@dirty_cash"] = Characters[Player].dirty })

			TriggerClientEvent("core:updateMoney", Player, Characters[Player].dirty, "dirty", "set", math.floor(tonumber(Amount)))
		end
	end
end)

exports("AddPlayerDirty", function(Player, Amount)
	if Characters[Player] then
		if tonumber(Amount) ~= nil then
			Characters[Player].dirty = Characters[Player].dirty + math.floor(tonumber(Amount))

			exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET dirty_cash=@dirty_cash WHERE character_id=@id", { ["@id"] = Characters[Player].characterID, ["@dirty_cash"] = Characters[Player].dirty })

			TriggerClientEvent("core:updateMoney", Player, Characters[Player].dirty, "dirty", "set", math.floor(tonumber(Amount)))
		end
	end
end)

exports("RemovePlayerDirty", function(Player, Amount)
	if Characters[Player] then
		if tonumber(Amount) ~= nil then
			Characters[Player].dirty = Characters[Player].dirty - math.floor(tonumber(Amount))

			exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET dirty_cash=@dirty_cash WHERE character_id=@id", { ["@id"] = Characters[Player].characterID, ["@dirty_cash"] = Characters[Player].dirty })

			TriggerClientEvent("core:updateMoney", Player, Characters[Player].dirty, "dirty", "set", math.floor(tonumber(Amount)))
		end
	end
end)

exports("SetPlayerJob", function(Player, Id)
	if Characters[Player] then
		Characters[Player].job = jobs[Id]

		exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET job_id=@job WHERE character_id=@id", { ["@id"] = Characters[Player].characterID, ["@job"] = Characters[Player].job.id })
	end
end)
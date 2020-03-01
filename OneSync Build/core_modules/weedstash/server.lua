DrugDealers = {}

AddEventHandler("DrugDealer:Initialise", function(source, identifier, character_id)
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM drugdealer WHERE character_id = @character_id", {["@character_id"] = character_id}, function(result)
		if result[1] == nil then
			TriggerClientEvent("DrugDealer:Set", source, {}, false, true)
		else
			DrugDealers[source] = result[1]
			TriggerClientEvent("DrugDealer:Set", source, DrugDealers[source], true, true)
		end
	end)
end)

RegisterServerEvent("Open.DrugStash")
AddEventHandler("Open.DrugStash", function(DrugStash)
	local Source = source
	local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM drugstash WHERE stash_id = @stash_id", {["@stash_id"] = DrugStash})
	if #result > 0 then
		TriggerClientEvent("DrugStash.Sync", -1)
		TriggerClientEvent("Open.DrugStash", Source, result)
	else
		TriggerClientEvent("DrugStash.Sync", -1)
		TriggerClientEvent("Open.DrugStash", Source, {})
	end
end)

RegisterServerEvent("Close.DrugStash")
AddEventHandler("Close.DrugStash", function()
	TriggerClientEvent("Close.DrugStash", -1)
end)

RegisterServerEvent("DrugStash.Deposit")
AddEventHandler("DrugStash.Deposit", function(Quantity, StashID)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user_inventory[Source][140] then
			user_inventory[Source][140] = nil
			exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id=@character_id) AND (item_id=@item_id)", {
				["@character_id"] = user.get("characterID"),
				["@item_id"] = 140,
			})
			exports["GHMattiMySQL"]:QueryAsync("UPDATE drugstash SET quantity = quantity + @quantity WHERE stash_id = @stash_id" , {["@stash_id"] = StashID, ["@quantity"] = Quantity})
            TriggerClientEvent("inventory:updateitems", source, user_inventory[Source])
            TriggerClientEvent("inventory:sync", -1, user_inventory)
		end
    end)
end)

RegisterServerEvent("DrugStash.Withdraw")
AddEventHandler("DrugStash.Withdraw", function(Quantity, StashID)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		exports["GHMattiMySQL"]:QueryAsync("UPDATE drugstash SET quantity = quantity - @quantity WHERE stash_id = @stash_id" , {["@stash_id"] = StashID, ["@quantity"] = Quantity})
        TriggerClientEvent("DrugStash.Withdraw", Source, Quantity)
    end)
end)

RegisterServerEvent("Police.Search.DrugStash")
AddEventHandler("Police.Search.DrugStash", function(Index)
	local Source = source
	local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM drugstash WHERE stash_id = @stash_id", {["@stash_id"] = Index})
	TriggerClientEvent("Police.Search.DrugStash", Source, result)
end)
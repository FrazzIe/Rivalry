local Player.InstancedPlayers = {}
local AllInstances = {}
local Properties = {}

RegisterServerEvent("Properties.Instance")
AddEventHandler("Properties,.Instance", function(Instanced)
	local Source = source
	Player.InstancedPlayers[Source] = (Instanced and true, or nil)
	TriggerClientEvent("Properties.Instanced.Sync", -1, Player.InstancedPlayers)
end)

RegisterServerEvent("Properties.Motel.Sync")
AddEventHandler("Properties.Motel.Sync", function(ServerId, NewTable)
	local Source = source
	for Index = 1, #AllInstances do
		if ServerId == AllInstances[Index].ServerId then
			table.remove(AllInstances, Index)
			table.insert(AllInstances, NewTable)
		end
	end
end)

RegisterServerEvent("Properties.Initalize")
AddEventHandler("Properties.Initalize", function()
	local Source = source
	local Result = {}
	TriggerEvent("core:getuser", Source, function(User)
		Result = exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM properties_houses WHERE character_id = @character_id", {
			["@character_id"] = User.get("characterID"),		
		})
	end)
	Properties[Source] = Result
	TriggerClientEvent("Properties.Initalize", Source, Result)
end)

RegisterServerEvent("Storage.Insert")
AddEventHandler("Storage.Insert", function(HouseNumber, Type, Data)
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		local CharacterID = User.get("characterID")
		if Type == "Item" then
			exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_items SET quantity=@quantity WHERE character_id=@character_id and item_id = @item_id", {
			    ["@quantity"] = Data.Quantity,
			    ["@character_id"] = CharacterID,
			    ["@item_id"] = Data.ItemID,
			})
		elseif Type == "Weapon" then
			exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_weapons SET quantity=@quantity WHERE character_id=@character_id and item_id = @item_id", {
			    ["@quantity"] = Data.Quantity,
			    ["@character_id"] = CharacterID,
			    ["@item_id"] = Data.ItemID,
			})
		elseif Type == "General" then
			local Cash = User.get("dirty")
			local DirtyCash = User.get("wallet")
			if Data.Cash > 0 and Cash >= Data.Cash then
				User.removeWallet(Data.Cash)
				exports["GHMattiMySQL"]:QueryAsync("UPDATE properties SET cash = cash + @cash WHERE character_id=@character_id and house_number = @house_number", {
				    ["@cash"] = Data.Cash,
				    ["@character_id"] = CharacterID,
				    ["@house_number"] = HouseNumber,
				})
			elseif Data.Dirty > 0 and DirtyCash >= Data.Dirty then
				User.removeDirty(Data.Dirty)
				exports["GHMattiMySQL"]:QueryAsync("UPDATE properties SET dirty = dirty + @dirty WHERE character_id=@character_id and house_number = @house_number") {
					["@dirty"] = Data.Dirty,
					["@character_id"] = CharacterID,
					["@house_number"] = HouseNumber,
				})
			end
		end
	end)
end)

RegisterServerEvent("Storage.Remove")
AddEventHandler("Storage.Remove", function()
	local Source = source

end)
RegisterServerEvent("Storage.Open")
AddEventHandler("Storage.Open", function(HouseNumber)
	local Source = source
	local GeneralInventory = {}
	local ItemsInventory = {}
	local WeaponsInventory = {}
	TriggerEvent("core:getuser", Source, function(User)
		CharacterID = User.get("characterID")
		exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM properties WHERE character_id = @character_id and house_number = @house_number", {["@character_id"] = CharacterID, ["@house_number"] = HouseNumber}, function(_General)
	    	GeneralInventory = _General
	    end)
	    exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM properties_items WHERE character_id = @character_id and house_number = @house_number", {["@character_id"] = CharacterID, ["@house_number"] = HouseNumber}, function(_Items)
	    	ItemsInventory = _Items
	    end)
	    exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM properties_weapons WHERE character_id = @character_id and house_number = @house_number", {["@character_id"] = CharacterID, ["@house_number"] = HouseNumber}, function(_Weapons)
	    	WeaponsInventory = _Weapons
	    end)
	    local Result = {
	    	General = GeneralInventory,
	    	Items = ItemsInventory,
	    	Weapons = WeaponsInventory
		}
	    TriggerClientEvent("Storage.Open", Source, Result)
	end)
end)

RegisterServerEvent("Outfit.Create")
AddEventHandler("Outfit.Create", function(Model, Outfit, LocationIndex)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user ~= nil then
			exports["ghmattimysql"]:execute("INSERT INTO outfit (`character_id`, `model`, `name`, `clothing_drawable`, `clothing_texture`, `prop_drawable`, `prop_texture`) VALUES (?, ?, ?, ?, ?, ?, ?)", {user.get("characterID"), Model, Outfit.Name, json.encode(Outfit.Clothing.Drawable), json.encode(Outfit.Clothing.Texture), json.encode(Outfit.Props.Drawable), json.encode(Outfit.Props.Texture)}, function(rowChanges)
				local rowId = rowChanges.insertId

            	Outfit.Id = rowId

            	if not PlayerCustomisation.Outfits[Source][Model] then
            		PlayerCustomisation.Outfits[Source][Model] = {}
            	end

            	table.insert(PlayerCustomisation.Outfits[Source][Model], Outfit)

            	TriggerClientEvent("Outfit.Load", Source, PlayerCustomisation.Outfits[Source], LocationIndex)				
			end)
		end
	end)
end)

RegisterServerEvent("Outfit.Update")
AddEventHandler("Outfit.Update", function(Model, Outfit, LocationIndex)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user ~= nil then
			exports["ghmattimysql"]:execute("UPDATE outfit SET clothing_drawable=?, clothing_texture=?, prop_drawable=?, prop_texture=? WHERE id = @id", {json.encode(Outfit.Clothing.Drawable), json.encode(Outfit.Clothing.Texture), json.encode(Outfit.Props.Drawable), json.encode(Outfit.Props.Texture), Outfit.Id})

			for Index = 1, #PlayerCustomisation.Outfits[Source][Model] do
				if PlayerCustomisation.Outfits[Source][Model][Index].Id == Outfit.Id then
					PlayerCustomisation.Outfits[Source][Model][Index] = Outfit
					break
				end
			end

			TriggerClientEvent("Outfit.Load", Source, PlayerCustomisation.Outfits[Source], LocationIndex)
		end
	end)
end)

RegisterServerEvent("Outfit.Delete")
AddEventHandler("Outfit.Delete", function(Model, Id, LocationIndex)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user ~= nil then
			exports["ghmattimysql"]:execute("DELETE FROM outfit WHERE id = ?", {Id})

			for Index = 1, #PlayerCustomisation.Outfits[Source][Model] do
				if PlayerCustomisation.Outfits[Source][Model][Index].Id == Id then
					table.remove(PlayerCustomisation.Outfits[Source][Model], Index)
					break
				end
			end

			TriggerClientEvent("Outfit.Load", Source, PlayerCustomisation.Outfits[Source], LocationIndex)
		end
	end)
end)

AddEventHandler("core:loaded", function(Source, user, power, group)
	exports["ghmattimysql"]:execute("SELECT * FROM outfit WHERE character_id=?", {user.get("characterID")}, function(Outfits)
		if Outfits[1] ~= nil then
			PlayerCustomisation.Outfits[Source] = {}
			for Index = 1, #Outfits do
				if not PlayerCustomisation.Outfits[Source][Outfits[Index].model] then
					PlayerCustomisation.Outfits[Source][Outfits[Index].model] = {}
				end

				table.insert(PlayerCustomisation.Outfits[Source][Outfits[Index].model], {
					Id = Outfits[Index].id,
					Name = Outfits[Index].name,
					Clothing = {
						Drawable = json.decode(Outfits[Index].clothing_drawable),
						Texture = json.decode(Outfits[Index].clothing_texture),
					},
					Props = {
						Drawable = json.decode(Outfits[Index].prop_drawable),
						Texture = json.decode(Outfits[Index].prop_texture),
					},
				})
			end

			TriggerClientEvent("Outfit.Load", Source, PlayerCustomisation.Outfits[Source])
		else
			PlayerCustomisation.Outfits[Source] = {}
		end
	end)
end)
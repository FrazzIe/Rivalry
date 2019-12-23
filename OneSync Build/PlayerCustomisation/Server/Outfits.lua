RegisterServerEvent("Outfit.Create")
AddEventHandler("Outfit.Create", function(Model, Outfit, LocationIndex)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user ~= nil then
			exports["GHMattiMySQL"]:Insert("outfit", {
                {
					["character_id"] = user.get("characterID"),
					["model"] = Model,
					["name"] = Outfit.Name,
					["clothing_drawable"] = json.encode(Outfit.Clothing.Drawable),
					["clothing_texture"] = json.encode(Outfit.Clothing.Texture),
					["prop_drawable"] = json.encode(Outfit.Props.Drawable),
					["prop_texture"] = json.encode(Outfit.Props.Texture),
                }
            }, function(Id)
            	Outfit.Id = Id

            	if not PlayerCustomisation.Outfits[Source][Model] then
            		PlayerCustomisation.Outfits[Source][Model] = {}
            	end

            	table.insert(PlayerCustomisation.Outfits[Source][Model], Outfit)

            	TriggerClientEvent("Outfit.Load", Source, PlayerCustomisation.Outfits[Source], LocationIndex)
            end, true)
		end
	end)
end)

RegisterServerEvent("Outfit.Update")
AddEventHandler("Outfit.Update", function(Model, Outfit, LocationIndex)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user ~= nil then
			exports["GHMattiMySQL"]:QueryAsync("UPDATE outfit SET clothing_drawable=@clothing_drawable, clothing_texture=@clothing_texture, prop_drawable=@prop_drawable, prop_texture=@prop_texture WHERE id = @id", {
				["@id"] = Outfit.Id,
				["@name"] = Outfit.Name,
				["@clothing_drawable"] = json.encode(Outfit.Clothing.Drawable),
				["@clothing_texture"] = json.encode(Outfit.Clothing.Texture),
				["@prop_drawable"] = json.encode(Outfit.Props.Drawable),
				["@prop_texture"] = json.encode(Outfit.Props.Texture),
			})

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
			exports["GHMattiMySQL"]:QueryAsync("DELETE FROM outfit WHERE id = @id", {
				["@id"] = Id,
			})

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
	exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM outfit WHERE character_id=@char_id", {["@char_id"] = user.get("characterID")}, function(Outfits)
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
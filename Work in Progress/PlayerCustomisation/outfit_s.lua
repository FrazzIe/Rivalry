local Outfits = {}

function UpdateOutfit(source, Outfit)
	if Outfits[source] then
		for Index = 1, #Outfits[source] do
			if Outfits[source][Index].id == Outfit.id then 
				Outfits[source][Index] = Outfit
			end
		end
	end
end

function DeleteOutfit(source, Outfit)
	if Outfits[source] then
		for Index = 1, #Outfits[source] do
			if Outfits[source][Index].id == Outfit.id then 
				table.remove(Outfits[source], Index)
			end
		end
	end
end

RegisterServerEvent("Outfit.Save")
AddEventHandler("Outfit.Save", function(Outfit)
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user ~= nil then
			exports["GHMattiMySQL"]:Insert("outfits", {
                {
					["character_id"] = user.get("characterID"),
					["name"] = Outfit.Name,
					["clothing_drawables"] = json.encode(Outfit.Clothing.Drawable),
					["clothing_textures"] = json.encode(Outfit.Clothing.Texture),
					["clothing_palettes"] = json.encode(Outfit.Clothing.Palette),
					["prop_drawables"] = json.encode(Outfit.Props.Drawable),
					["prop_textures"] = json.encode(Outfit.Props.Texture),
                }
            }, function(id)
            	Outfit.id = id
            	table.insert(Outfits[source], Outfit)
            	TriggerClientEvent("Outfit.Load", source, Outfits[source])
            end, true)
		end
	end)
end)

RegisterServerEvent("Outfit.Update")
AddEventHandler("Outfit.Update", function(Outfit)
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user ~= nil then
			UpdateOutfit(source, Outfit)
			exports["GHMattiMySQL"]:QueryAsync("UPDATE outfits SET clothing_drawables=@clothing_drawables, clothing_textures=@clothing_textures, clothing_palettes=@clothing_palettes, prop_drawables=@prop_drawables, prop_textures=@prop_textures WHERE id = @id", {
				["@id"] = Outfit.id,
				["@name"] = Outfit.Name,
				["@clothing_drawables"] = json.encode(Outfit.Clothing.Drawable),
				["@clothing_textures"] = json.encode(Outfit.Clothing.Texture),
				["@clothing_palettes"] = json.encode(Outfit.Clothing.Palette),
				["@prop_drawables"] = json.encode(Outfit.Props.Drawable),
				["@prop_textures"] = json.encode(Outfit.Props.Texture),
			})
			TriggerClientEvent("Outfit.Load", source, Outfits[source])
		end
	end)
end)

RegisterServerEvent("Outfit.Delete")
AddEventHandler("Outfit.Delete", function(Outfit)
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if user ~= nil then
			DeleteOutfit(source, Outfit)
			exports["GHMattiMySQL"]:QueryAsync("DELETE FROM outfits WHERE id = @id", {
				["@id"] = Outfit.id,
			})
			TriggerClientEvent("Outfit.Load", source, Outfits[source])
		end
	end)
end)

RegisterServerEvent("core:loaded")
AddEventHandler("core:loaded", function(source, user, power, group)
	exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM outfits WHERE character_id=@char_id", {["@char_id"] = user.get("characterID")}, function(Data)
		if Data[1] ~= nil then
			local _Outfits = {}
			for Index = 1, #Data do
				table.insert(_Outfits, {
					id = Data[Index].id,
					Name = Data[Index].name,
					Clothing = {
						Drawable = json.decode(Data[Index].clothing_drawables),
						Texture = json.decode(Data[Index].clothing_textures),
						Palette = json.decode(Data[Index].clothing_palettes),
					},
					Props = {
						Drawable = json.decode(Data[Index].prop_drawables),
						Texture = json.decode(Data[Index].prop_textures),
					},
				})
			end
			Outfits[source] = _Outfits
			TriggerClientEvent("Outfit.Load", source, Outfits[source], true)
		else
			Outfits[source] = {}
		end
	end)
end)
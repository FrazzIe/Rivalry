function tobool(input)
	if input == "true" or tonumber(input) == 1 or input == true or input == "on" then
		return true
	else
		return false
	end
end

function bool_to_number(value)
	return value and 1 or 0
end

AddEventHandler("core:loaded", function(Source, user, power, group)
	local char_id = user.get("characterID")
	exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM playercustomisation WHERE character_id=@char_id", {["@char_id"] = char_id}, function(PlayerData)
		PlayerCustomisation.PlayerData[Source] = PlayerCustomisation.DefaultPlayerData
		if PlayerData[1] ~= nil then
			local _PlayerData = {}

			for Index = 1, #PlayerData do
				_PlayerData[PlayerData[Index].type] = PlayerData[Index]
			end

			PlayerData = _PlayerData

			for Type, Data in pairs(PlayerCustomisation.PlayerData[Source].Types) do
				if PlayerData[Type] then
					PlayerCustomisation.PlayerData[Source].Types[Type].Model = PlayerData[Type].model
					PlayerCustomisation.PlayerData[Source].Types[Type].Gender = ((PlayerData[Type].model == "mp_m_freemode_01") and "Male" or ((PlayerData[Type].model == "mp_f_freemode_01") and "Female" or "Hybrid"))
					PlayerCustomisation.PlayerData[Source].Types[Type].Creator = tobool(PlayerData[Type].creator)
					PlayerCustomisation.PlayerData[Source].Types[Type][((PlayerData[Type].model == "mp_m_freemode_01") and "Male" or ((PlayerData[Type].model == "mp_f_freemode_01") and "Female" or "Hybrid"))] = {
						Clothing = {
							Drawable = json.decode(PlayerData[Type].clothing_drawable),
							Texture = json.decode(PlayerData[Type].clothing_texture),
							Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
						},
						Props = {
							Drawable = json.decode(PlayerData[Type].prop_drawable),
							Texture = json.decode(PlayerData[Type].prop_texture),
						},
						Overlay = {
							Drawable = json.decode(PlayerData[Type].overlay_drawable),
							Opacity = json.decode(PlayerData[Type].overlay_opacity),
							Colours = json.decode(PlayerData[Type].overlay_colour),
						},
						FacialFeature = json.decode(PlayerData[Type].facial_feature),
						HeadBlend = json.decode(PlayerData[Type].head_blend),
						HairColour = json.decode(PlayerData[Type].hair_colour),
						EyeColour = PlayerData[Type].eye_colour,
						Highlights = tobool(PlayerData[Type].highlight),
						Tattoos = json.decode(PlayerData[Type].tattoo),
					}
				else
					exports["GHMattiMySQL"]:QueryAsync("INSERT INTO playercustomisation (`character_id`, `type`, `model`, `clothing_drawable`, `clothing_texture`, `prop_drawable`, `prop_texture`, `overlay_drawable`, `overlay_opacity`, `overlay_colour`, `facial_feature`, `head_blend`, `hair_colour`, `eye_colour`, `highlight`, `tattoo`, `creator`) VALUES (@character_id, @type, @model, @clothing_drawable, @clothing_texture, @prop_drawable, @prop_texture, @overlay_drawable, @overlay_opacity, @overlay_colour, @facial_feature, @head_blend, @hair_colour, @eye_colour, @highlight, @tattoo, @creator)", {
						["@character_id"] = char_id,
						["@type"] = Type,
						["@model"] = Data.Model,
						["@clothing_drawable"] = json.encode(Data[Data.Gender].Clothing.Drawable),
						["@clothing_texture"] = json.encode(Data[Data.Gender].Clothing.Texture),
						["@prop_drawable"] = json.encode(Data[Data.Gender].Props.Drawable),
						["@prop_texture"] = json.encode(Data[Data.Gender].Props.Texture),
						["@overlay_drawable"] = json.encode(Data[Data.Gender].Overlay.Drawable),
						["@overlay_opacity"] = json.encode(Data[Data.Gender].Overlay.Opacity),
						["@overlay_colour"] = json.encode(Data[Data.Gender].Overlay.Colours),
						["@facial_feature"] = json.encode(Data[Data.Gender].FacialFeature),
						["@head_blend"] = json.encode(Data[Data.Gender].HeadBlend),
						["@hair_colour"] = json.encode(Data[Data.Gender].HairColour),
						["@eye_colour"] = Data[Data.Gender].EyeColour,
						["@highlight"] = bool_to_number(Data[Data.Gender].Highlights),
						["@tattoo"] = json.encode(Data[Data.Gender].Tattoos),
						["@creator"] = bool_to_number(Data.Creator),
					})					
				end
			end
		else
			for Type, Data in pairs(PlayerCustomisation.PlayerData[Source].Types) do
				exports["GHMattiMySQL"]:QueryAsync("INSERT INTO playercustomisation (`character_id`, `type`, `model`, `clothing_drawable`, `clothing_texture`, `prop_drawable`, `prop_texture`, `overlay_drawable`, `overlay_opacity`, `overlay_colour`, `facial_feature`, `head_blend`, `hair_colour`, `eye_colour`, `highlight`, `tattoo`, `creator`) VALUES (@character_id, @type, @model, @clothing_drawable, @clothing_texture, @prop_drawable, @prop_texture, @overlay_drawable, @overlay_opacity, @overlay_colour, @facial_feature, @head_blend, @hair_colour, @eye_colour, @highlight, @tattoo, @creator)", {
					["@character_id"] = char_id,
					["@type"] = Type,
					["@model"] = Data.Model,
					["@clothing_drawable"] = json.encode(Data[Data.Gender].Clothing.Drawable),
					["@clothing_texture"] = json.encode(Data[Data.Gender].Clothing.Texture),
					["@prop_drawable"] = json.encode(Data[Data.Gender].Props.Drawable),
					["@prop_texture"] = json.encode(Data[Data.Gender].Props.Texture),
					["@overlay_drawable"] = json.encode(Data[Data.Gender].Overlay.Drawable),
					["@overlay_opacity"] = json.encode(Data[Data.Gender].Overlay.Opacity),
					["@overlay_colour"] = json.encode(Data[Data.Gender].Overlay.Colours),
					["@facial_feature"] = json.encode(Data[Data.Gender].FacialFeature),
					["@head_blend"] = json.encode(Data[Data.Gender].HeadBlend),
					["@hair_colour"] = json.encode(Data[Data.Gender].HairColour),
					["@eye_colour"] = Data[Data.Gender].EyeColour,
					["@highlight"] = bool_to_number(Data[Data.Gender].Highlights),
					["@tattoo"] = json.encode(Data[Data.Gender].Tattoos),
					["@creator"] = bool_to_number(Data.Creator),
				})
			end
		end

		TriggerClientEvent("PlayerCustomisation.Sync.PlayerData", Source, PlayerCustomisation.PlayerData[Source], "Default")
	end)
end)

RegisterServerEvent("PlayerCustomisation.Instance")
AddEventHandler("PlayerCustomisation.Instance", function(Enter)
	local Source = source
	
	PlayerCustomisation.InstancedPlayers[Source] = (Enter and true or nil)

	TriggerClientEvent("PlayerCustomisation.Sync", -1, PlayerCustomisation.InstancedPlayers)
end)

RegisterServerEvent("PlayerCustomisation.ModelType")
AddEventHandler("PlayerCustomisation.ModelType", function(Type)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user ~= nil then
			if PlayerCustomisation.PlayerData[Source].Types[Type] then
				PlayerCustomisation.PlayerData[Source].Type = Type
				TriggerClientEvent("PlayerCustomisation.ModelType", Source, Type, user.get("first_name").." "..user.get("last_name"), user.get("characterID"), user.get("gender"))
			else
				PlayerCustomisation.PlayerData[Source].Type = "Default"
				TriggerClientEvent("PlayerCustomisation.ModelType", Source, "Default", user.get("first_name").." "..user.get("last_name"), user.get("characterID"), user.get("gender"))
			end
		end
	end)
end)

RegisterServerEvent("PlayerCustomisation.Update")
AddEventHandler("PlayerCustomisation.Update", function(Type, PlayerData)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user ~= nil then
			if PlayerCustomisation.PlayerData[Source] then
				PlayerCustomisation.PlayerData[Source].Types[Type] = PlayerData
				exports["GHMattiMySQL"]:QueryAsync("UPDATE playercustomisation SET model=@model, clothing_drawable=@clothing_drawable, clothing_texture=@clothing_texture, prop_drawable=@prop_drawable, prop_texture=@prop_texture, overlay_drawable=@overlay_drawable, overlay_opacity=@overlay_opacity, overlay_colour=@overlay_colour, facial_feature=@facial_feature, head_blend=@head_blend, hair_colour=@hair_colour, eye_colour=@eye_colour, highlight=@highlight, tattoo=@tattoo, creator=@creator WHERE (type=@type) AND (character_id=@character_id)", {
					["@type"] = Type,
					["@character_id"] = user.get("characterID"),
					["@model"] = PlayerData.Model,
					["@clothing_drawable"] = json.encode(PlayerData[PlayerData.Gender].Clothing.Drawable),
					["@clothing_texture"] = json.encode(PlayerData[PlayerData.Gender].Clothing.Texture),
					["@prop_drawable"] = json.encode(PlayerData[PlayerData.Gender].Props.Drawable),
					["@prop_texture"] = json.encode(PlayerData[PlayerData.Gender].Props.Texture),
					["@overlay_drawable"] = json.encode(PlayerData[PlayerData.Gender].Overlay.Drawable),
					["@overlay_opacity"] = json.encode(PlayerData[PlayerData.Gender].Overlay.Opacity),
					["@overlay_colour"] = json.encode(PlayerData[PlayerData.Gender].Overlay.Colours),
					["@facial_feature"] = json.encode(PlayerData[PlayerData.Gender].FacialFeature),
					["@head_blend"] = json.encode(PlayerData[PlayerData.Gender].HeadBlend),
					["@hair_colour"] = json.encode(PlayerData[PlayerData.Gender].HairColour),
					["@eye_colour"] = PlayerData[PlayerData.Gender].EyeColour,
					["@highlight"] = bool_to_number(PlayerData[PlayerData.Gender].Highlights),
					["@tattoo"] = json.encode(PlayerData[PlayerData.Gender].Tattoos),
					["@creator"] = bool_to_number(PlayerData.Creator),
				})
			end
		end
	end)
end)
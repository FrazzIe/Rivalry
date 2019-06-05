function to_bool(input)
	if input == "true" or tonumber(input) == 1 or input == true or input == "on" then
		return true
	else
		return false
	end
end

function bool_to_number(value)
	return value and 1 or 0
end

AddEventHandler("PlayerCustomisation.Initialise", function(Source, user, power, group)
	local char_id = user.get("characterID")
	exports["ghmattimysql"]:execute("SELECT * FROM playercustomisation WHERE character_id=?", {char_id}, function(PlayerData)
		PlayerCustomisation.PlayerData[Source] = GetDefaultPlayerData()
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
					PlayerCustomisation.PlayerData[Source].Types[Type].Creator = to_bool(PlayerData[Type].creator)
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
						Highlights = to_bool(PlayerData[Type].highlight),
						Tattoos = json.decode(PlayerData[Type].tattoo),
					}
				else
					exports["ghmattimysql"]:execute("INSERT INTO playercustomisation (`character_id`, `type`, `model`, `clothing_drawable`, `clothing_texture`, `prop_drawable`, `prop_texture`, `overlay_drawable`, `overlay_opacity`, `overlay_colour`, `facial_feature`, `head_blend`, `hair_colour`, `eye_colour`, `highlight`, `tattoo`, `creator`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", {char_id, Type, Data.Model, json.encode(Data[Data.Gender].Clothing.Drawable), json.encode(Data[Data.Gender].Clothing.Texture), json.encode(Data[Data.Gender].Props.Drawable), json.encode(Data[Data.Gender].Props.Texture), json.encode(Data[Data.Gender].Overlay.Drawable), json.encode(Data[Data.Gender].Overlay.Opacity), json.encode(Data[Data.Gender].Overlay.Colours), json.encode(Data[Data.Gender].FacialFeature), json.encode(Data[Data.Gender].HeadBlend), json.encode(Data[Data.Gender].HairColour), Data[Data.Gender].EyeColour, bool_to_number(Data[Data.Gender].Highlights), json.encode(Data[Data.Gender].Tattoos), bool_to_number(Data.Creator)})
				end
			end
		else
			for Type, Data in pairs(PlayerCustomisation.PlayerData[Source].Types) do
				exports["ghmattimysql"]:execute("INSERT INTO playercustomisation (`character_id`, `type`, `model`, `clothing_drawable`, `clothing_texture`, `prop_drawable`, `prop_texture`, `overlay_drawable`, `overlay_opacity`, `overlay_colour`, `facial_feature`, `head_blend`, `hair_colour`, `eye_colour`, `highlight`, `tattoo`, `creator`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", {char_id, Type, Data.Model, json.encode(Data[Data.Gender].Clothing.Drawable), json.encode(Data[Data.Gender].Clothing.Texture), json.encode(Data[Data.Gender].Props.Drawable), json.encode(Data[Data.Gender].Props.Texture), json.encode(Data[Data.Gender].Overlay.Drawable), json.encode(Data[Data.Gender].Overlay.Opacity), json.encode(Data[Data.Gender].Overlay.Colours), json.encode(Data[Data.Gender].FacialFeature), json.encode(Data[Data.Gender].HeadBlend), json.encode(Data[Data.Gender].HairColour), Data[Data.Gender].EyeColour, bool_to_number(Data[Data.Gender].Highlights), json.encode(Data[Data.Gender].Tattoos), bool_to_number(Data.Creator)})
			end
		end

		TriggerClientEvent("PlayerCustomisation.Sync.PlayerData", Source, PlayerCustomisation.PlayerData[Source], "Default")
		TriggerClientEvent("PlayerCustomisation.Sync", -1, PlayerCustomisation.InstancedPlayers)
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
			if PlayerCustomisation.PlayerData[Source] then
				if PlayerCustomisation.PlayerData[Source].Types[Type] then
					PlayerCustomisation.PlayerData[Source].Type = Type
				else
					PlayerCustomisation.PlayerData[Source].Type = "Default"
				end

				TriggerClientEvent("PlayerCustomisation.ModelType", Source, PlayerCustomisation.PlayerData[Source].Type, user.get("coords"), user.get("first_name").." "..user.get("last_name"), user.get("characterID"), user.get("gender"))
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
				exports["ghmattimysql"]:execute("UPDATE playercustomisation SET model=?, clothing_drawable=?, clothing_texture=?, prop_drawable=?, prop_texture=?, overlay_drawable=?, overlay_opacity=?, overlay_colour=?, facial_feature=?, head_blend=?, hair_colour=?, eye_colour=?, highlight=?, tattoo=?, creator=? WHERE (type=?) AND (character_id=?)", {PlayerData.Model, json.encode(PlayerData[PlayerData.Gender].Clothing.Drawable), json.encode(PlayerData[PlayerData.Gender].Clothing.Texture), json.encode(PlayerData[PlayerData.Gender].Props.Drawable), json.encode(PlayerData[PlayerData.Gender].Props.Texture), json.encode(PlayerData[PlayerData.Gender].Overlay.Drawable), json.encode(PlayerData[PlayerData.Gender].Overlay.Opacity), json.encode(PlayerData[PlayerData.Gender].Overlay.Colours), json.encode(PlayerData[PlayerData.Gender].FacialFeature), json.encode(PlayerData[PlayerData.Gender].HeadBlend), json.encode(PlayerData[PlayerData.Gender].HairColour), PlayerData[PlayerData.Gender].EyeColour, bool_to_number(PlayerData[PlayerData.Gender].Highlights), json.encode(PlayerData[PlayerData.Gender].Tattoos), bool_to_number(PlayerData.Creator), Type, user.get("characterID")})
			end
		end
	end)
end)

RegisterServerEvent("PlayerCustomisation.PlasticSurgery")
AddEventHandler("PlayerCustomisation.PlasticSurgery", function()
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user ~= nil then
			if user.get("wallet") >= PlayerCustomisation.PlasticSurgeryCost then
				user.removeWallet(PlayerCustomisation.PlasticSurgeryCost)
				TriggerClientEvent("PlayerCustomisation.OpenCreator", Source, nil, user.get("first_name").." "..user.get("last_name"), user.get("characterID"), user.get("gender"))
			elseif user.get("bank") >= PlayerCustomisation.PlasticSurgeryCost then
				user.removeBank(PlayerCustomisation.PlasticSurgeryCost)
				TriggerClientEvent("PlayerCustomisation.OpenCreator", Source, nil, user.get("first_name").." "..user.get("last_name"), user.get("characterID"), user.get("gender"))
			else
				Notify("Insufficient funds!", 3000, Source)
			end
		end
	end)
end)

RegisterServerEvent("PlayerCustomisation.OpenCreator")
AddEventHandler("PlayerCustomisation.OpenCreator", function()
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user ~= nil then
			TriggerClientEvent("PlayerCustomisation.OpenCreator", Source, user.get("coords"), user.get("first_name").." "..user.get("last_name"), user.get("characterID"), user.get("gender"))
		end
	end)
end)
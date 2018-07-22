RegisterServerEvent("core:loaded")
AddEventHandler("core:loaded", function(Source, user, power, group)
	exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM playercustomisation WHERE character_id=@char_id", {["@char_id"] = user.get("characterID")}, function(PlayerData)
		if PlayerData[1] ~= nil then
			PlayerCustomisation.PlayerData[Source] = PlayerCustomisation.DefaultPlayerData
			for Index = 1, #PlayerData do
				if not PlayerCustomisation.PlayerData[Source][PlayerData[Index].type] then
					PlayerCustomisation.PlayerData[Source][PlayerData[Index].type] = {}
				end
				PlayerCustomisation.PlayerData[Source][PlayerData[Index].type].Model = PlayerData[Index].model
				PlayerCustomisation.PlayerData[Source][PlayerData[Index].type].Gender = ((PlayerData[Index].model == "mp_m_freemode_01") and "Male" or ((PlayerData[Index].model == "mp_f_freemode_01") and "Female" or "Hybrid"))
				PlayerCustomisation.PlayerData[Source][PlayerData[Index].type].Creator = PlayerData[Index].creator
				PlayerCustomisation.PlayerData[Source][PlayerData[Index].type][((PlayerData[Index].model == "mp_m_freemode_01") and "Male" or ((PlayerData[Index].model == "mp_f_freemode_01") and "Female" or "Hybrid"))] = {
					Clothing = {
						Drawable = json.decode(PlayerData[Index].clothing_drawable),
						Texture = json.decode(PlayerData[Index].clothing_texture),
					},
					Props = {
						Drawable = json.decode(PlayerData[Index].prop_drawable),
						Texture = json.decode(PlayerData[Index].prop_texture),
					},
					Overlay = {
						Drawable = json.decode(PlayerData[Index].overlay_drawable),
						Opacity = json.decode(PlayerData[Index].overlay_opacity),
						Colours = json.decode(PlayerData[Index].overlay_colour),
					},
					FacialFeature = json.decode(PlayerData[Index].facial_feature),
					HeadBlend = json.decode(PlayerData[Index].head_blend),
					HairColour = json.decode(PlayerData[Index].hair_colour),
					EyeColour = PlayerData[Index].eye_colour,
					Highlights = PlayerData[Index].highlight,
					Tattoos = json.decode(PlayerData[Index].tattoo),
				}
			end
		else
			PlayerCustomisation.PlayerData[Source] = PlayerCustomisation.DefaultPlayerData
		end
	end)
end)

RegisterServerEvent("PlayerCustomisation.Instance")
AddEventHandler("PlayerCustomisation.Instance", function(Type, Enter)
	local Source = source
	if PlayerCustomisation.Instances[Type] then
		PlayerCustomisation.Instances[Type][Source] = (Enter and true or false)
	end

	TriggerServerEvent("PlayerCustomisation.Sync", -1, PlayerCustomisation.Instances)
end)
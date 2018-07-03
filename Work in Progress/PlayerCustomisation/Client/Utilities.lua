function RenderMarker(Type, X, Y, Z, SX, SY, SZ, R, G, B, A, BobUpAndDown)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		DrawMarker(Type, X, Y, Z - 0.9, 0, 0, 0, 0, 0, 0, SX or 0, SY or 0, SZ or 0, R or 255, G or 255, B or 255, A or 255, BobUpAndDown or false, 0, 2, 0, 0, 0, 0)
	end
end

function GetOverlayColourType(Overlay)
	if Overlay == 1 or Overlay == 2 or Overlay == 10 then
		return 1
	elseif Overlay == 5 or Overlay == 8 then
		return 2
	else
		return 0
	end
end

function SetPedTopless()
	if PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender == "Male" then
		SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
		SetPedComponentVariation(PlayerPedId(), 11, 252, 0, 0)
		SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)
	elseif PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender == "Female" then
		SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
		SetPedComponentVariation(PlayerPedId(), 11, 18, 7, 0)
		SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)		
	end
end

function UpdatePlayer()
	if PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender ~= "Hybrid" then
	    local Resemblance = (PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[3] + 1.0) / 2.0
	    local SkinTone = (PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[4] + 1.0) / 2.0

	    SetPedHeadBlendData(PlayerPedId(), PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1], PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2], 0, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1], PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2], 0, Resemblance, SkinTone, 0.0, false)

	    for Index = 1, #PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature do
	    	SetPedFaceFeature(PlayerPedId(), Index - 1, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[Index])
	    end

		for Index = 0, 12 do
			SetPedHeadOverlay(PlayerPedId(), Index, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[Index + 1] or 255, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[Index + 1] or 1.0)
			SetPedHeadOverlayColor(PlayerPedId(), Index, GetOverlayColourType(Index), PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[Index + 1] or 0, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[Index + 1] or 0)
		end

	    SetPedComponentVariation(PlayerPedId(), 2, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3], 0, 1)
	    SetPedHairColor(PlayerPedId(), PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1], (PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Highlights and PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].HairColour[2] or PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1]))

	    SetPedEyeColor(PlayerPedId(), PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].EyeColour)

	    SetPedComponentVariation(PlayerPedId(), 1, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[2], PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[2], 1)

	    for Index = 3, 11 do
	    	SetPedComponentVariation(PlayerPedId(), Index, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index + 1], PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index + 1], PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Palette[Index + 1])
	    end

	    for Index = 0, 7 do
	    	SetPedPropIndex(PlayerPedId(), Index, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index + 1], PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index + 1], true)
	    end
	else
	    for Index = 0, 11 do
	    	SetPedComponentVariation(PlayerPedId(), Index, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index + 1], PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index + 1], PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Palette[Index + 1])
	    end

	    for Index = 0, 7 do
	    	SetPedPropIndex(PlayerPedId(), Index, PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index + 1], PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index + 1], true)
	    end
	end
end

function UpdateModel(Skin)
    local Model = GetHashKey(Skin)
    if IsModelInCdimage(Model) and IsModelValid(Model) then
        RequestModel(Model)

        while not HasModelLoaded(Model) do
            Citizen.Wait(250)
        end

        SetPlayerModel(PlayerId(), Model)

        if Skin ~= "mp_f_freemode_01" and Skin ~= "mp_m_freemode_01" then
            SetPedRandomComponentVariation(PlayerPedId(), true)
        else
            SetPedComponentVariation(PlayerPedId(), 11, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 11, 6, 1, 0)
        end

        SetModelAsNoLongerNeeded(Model)

        PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender = ((Model == GetHashKey("mp_m_freemode_01")) and "Male" or ((Model == GetHashKey("mp_f_freemode_01")) and "Female" or "Hybrid"))
        PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model = Skin

        UpdatePlayer()
    end
end

function GetFaceIndex(Key, Face)
	for Index = 1, #PlayerCustomisation.Reference.Heritage[Key] do
		if PlayerCustomisation.Reference.Heritage[Key][Index].Value.Face == Face then
			return Index
		end
	end
	return nil
end

function GetPortraitFromFace(Key, Face)
	for Index = 1, #PlayerCustomisation.Reference.Heritage[Key] do
		if PlayerCustomisation.Reference.Heritage[Key][Index].Value.Face == Face then
			return PlayerCustomisation.Reference.Heritage[Key][Index].Value.Portrait
		end
	end
	return nil
end

function GetOutfitIndex()
	for Index = 1, #PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender] do
		for Outfit = 1, #PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index] do
			local Count = 0
			for ClothingIndex = 4, 12 do
				if PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index][Outfit].Value.Drawable[ClothingIndex] == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[ClothingIndex] and PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index][Outfit].Value.Texture[ClothingIndex] == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[ClothingIndex] then
					Count = Count + 1
				end
			end

			if Count == 9 then
				return Index, Outfit
			end
		end
	end
	return nil, nil
end

function GetHatIndex()
	for Index = 1, #PlayerCustomisation.Reference.Apparel.Hat[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender] do
		if PlayerCustomisation.Reference.Apparel.Hat[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Value.Drawable == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[1] and PlayerCustomisation.Reference.Apparel.Hat[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Value.Texture == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[1] then
			return Index
		end
	end
	return nil
end

function GetGlassesIndex()
	for Index = 1, #PlayerCustomisation.Reference.Apparel.Glasses[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender] do
		if PlayerCustomisation.Reference.Apparel.Glasses[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Value.Drawable == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[2] and PlayerCustomisation.Reference.Apparel.Glasses[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Value.Texture == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[2] then
			return Index
		end
	end
	return nil
end

function GetHairIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender] do
		if PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Value == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3] then
			return Index
		end
	end
	return nil
end

function GetBeardIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Beards do
		if PlayerCustomisation.Reference.Appearance.Beards[Index].Value == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[2] then
			return Index
		end
	end
	return nil
end

function GetEyebrowIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Eyebrows do
		if PlayerCustomisation.Reference.Appearance.Eyebrows[Index].Value == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[3] then
			return Index
		end
	end
	return nil
end

function GetChestIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Chest do
		if PlayerCustomisation.Reference.Appearance.Chest[Index].Value == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[11] then
			return Index
		end
	end
	return nil
end

function GetFacePaintIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.FacePaint do
		if PlayerCustomisation.Reference.Appearance.FacePaint[Index].Value == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[5] then
			return Index
		end
	end
	return nil
end

function GetEyeMakeupIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.EyeMakeup do
		if PlayerCustomisation.Reference.Appearance.EyeMakeup[Index].Value == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[5] then
			return Index
		end
	end
	return nil
end

function GetBlushIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Blush do
		if PlayerCustomisation.Reference.Appearance.Blush[Index].Value == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[6] then
			return Index
		end
	end
	return nil
end

function GetLipstickIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Lipstick do
		if PlayerCustomisation.Reference.Appearance.Lipstick[Index].Value == PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[9] then
			return Index
		end
	end
	return nil
end

function GetComponentIndex(Component)
	for Index = 1, #PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender] do
		if Component == PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Name or Component == PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Value then
			return Index
		end
	end
	return nil
end

function GetPropIndex(Prop)
	for Index = 1, #PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender] do
		if Prop == PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Name or Prop == PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Value then
			return Index
		end
	end
	return nil
end

function RetrieveComponents()
	if PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender == "Hybrid" then
		PlayerCustomisation.Reference.Clothing.Options.Hybrid = {}
		for Index = 0, 11 do
			if GetNumberOfPedDrawableVariations(PlayerPedId(), Index) > 0 then
				table.insert(PlayerCustomisation.Reference.Clothing.Options.Hybrid, {Name = PlayerCustomisation.Reference.Clothing.Options.PedComponentNames[tostring(Index)] or "Slot "..Index, Value = Index})
			end
		end
	end

	PlayerCustomisation.Reference.Clothing.Drawables = {}
	PlayerCustomisation.Reference.Clothing.Textures = {}

	for Index = 1, #PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender] do
		PlayerCustomisation.Reference.Clothing.Drawables[PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Name] = {}
		for Drawable = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Value) do
			table.insert(PlayerCustomisation.Reference.Clothing.Drawables[PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Name], Drawable)
		end
	end

	for Component, Drawables in pairs(PlayerCustomisation.Reference.Clothing.Drawables) do
		PlayerCustomisation.Reference.Clothing.Textures[Component] = {}
		for Index = 1, #Drawables do
			table.insert(PlayerCustomisation.Reference.Clothing.Textures[Component], {})
			if PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender ~= "Hybrid" and PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][GetComponentIndex(Component)].Value == 8 and Drawables[Index] == 0 then
				table.insert(PlayerCustomisation.Reference.Clothing.Textures[Component][Index], 240)
			end
			for Texture = 0, GetNumberOfPedTextureVariations(PlayerPedId(), PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][GetComponentIndex(Component)].Value, Drawables[Index]) do
				table.insert(PlayerCustomisation.Reference.Clothing.Textures[Component][Index], Texture)
			end
		end
	end

	for Component, Drawables in pairs(PlayerCustomisation.Reference.Clothing.Drawables) do
		Citizen.Trace(Component.." - "..json.encode(Drawables))
	end

	for Component, Drawables in pairs(PlayerCustomisation.Reference.Clothing.Textures) do
		for Index = 1, #Drawables do
			Citizen.Trace(Component.." - "..Index.." - "..json.encode(Drawables[Index]))
		end
	end
end

function RetrieveProps()
	if PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender == "Hybrid" then
		PlayerCustomisation.Reference.Props.Options.Hybrid = {}
		for Index = 0, 11 do
			if GetNumberOfPedPropDrawableVariations(PlayerPedId(), Index) > 0 then
				table.insert(PlayerCustomisation.Reference.Props.Options.Hybrid, {Name = PlayerCustomisation.Reference.Props.Options.PedPropNames[tostring(Index)] or "Slot "..Index, Value = Index})
			end
		end
	end

	PlayerCustomisation.Reference.Props.Drawables = {}
	PlayerCustomisation.Reference.Props.Textures = {}

	for Index = 1, #PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender] do
		PlayerCustomisation.Reference.Props.Drawables[PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Name] = {-1}
		for Drawable = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Value) do
			table.insert(PlayerCustomisation.Reference.Props.Drawables[PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][Index].Name], Drawable)
		end
	end

	for Prop, Drawables in pairs(PlayerCustomisation.Reference.Props.Drawables) do
		PlayerCustomisation.Reference.Props.Textures[Prop] = {}
		for Index = 1, #Drawables do
			table.insert(PlayerCustomisation.Reference.Props.Textures[Prop], {})

			for Texture = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender][GetPropIndex(Prop)].Value, Drawables[Index]) do
				table.insert(PlayerCustomisation.Reference.Props.Textures[Prop][Index], Texture)
			end
		end
	end

	for Prop, Drawables in pairs(PlayerCustomisation.Reference.Props.Drawables) do
		Citizen.Trace(Prop.." - "..json.encode(Drawables))
	end

	for Prop, Drawables in pairs(PlayerCustomisation.Reference.Props.Textures) do
		for Index = 1, #Drawables do
			Citizen.Trace(Prop.." - "..Index.." - "..json.encode(Drawables[Index]))
		end
	end
end
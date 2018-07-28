function GetGroundZ(X, Y, Z)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		local _, GroundZ = GetGroundZFor_3dCoord(X + 0.0, Y + 0.0, Z + 0.0, Citizen.ReturnResultAnyway())
		return GroundZ
	else
		return 0.0
	end
end

function DestroyObject(Handle)
	Citizen.CreateThread(function()
		local Handle = Handle
		local Start = GetGameTimer()

		NetworkRequestControlOfEntity(Handle)

		while not NetworkHasControlOfEntity(Handle) and Start + 5000 > GetGameTimer() do
			Citizen.Wait(0)
		end

		DeleteObject(Handle)
		SetEntityAsNoLongerNeeded(Handle)

		if DoesEntityExist(Handle) then
			SetEntityCoords(Handle, 601.28948974609, -4396.9853515625, 384.98565673828)
		end
	end)
end

function RenderMarker(Type, X, Y, Z, SX, SY, SZ, R, G, B, A, BobUpAndDown)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		DrawMarker(Type, X, Y, Z - 0.9, 0, 0, 0, 0, 0, 0, SX or 0, SY or 0, SZ or 0, R or 255, G or 255, B or 255, A or 255, BobUpAndDown or false, 0, 2, 0, 0, 0, 0)
	end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLength	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
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
	if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender == "Male" then
		SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
		SetPedComponentVariation(PlayerPedId(), 11, 252, 0, 0)
		SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
		SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)
	elseif PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender == "Female" then
		SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
		SetPedComponentVariation(PlayerPedId(), 11, 18, 7, 0)
		SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
		SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)		
	end
end

function UpdatePlayer()
	if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender ~= "Hybrid" then
	    local Resemblance = (PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[3] + 1.0) / 2.0
	    local SkinTone = (PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[4] + 1.0) / 2.0

	    SetPedHeadBlendData(PlayerPedId(), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2], 0, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2], 0, Resemblance, SkinTone, 0.0, false)

	    for Index = 1, #PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature do
	    	SetPedFaceFeature(PlayerPedId(), Index - 1, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[Index])
	    end

		for Index = 0, 12 do
			SetPedHeadOverlay(PlayerPedId(), Index, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[Index + 1] or 255, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[Index + 1] or 1.0)
			SetPedHeadOverlayColor(PlayerPedId(), Index, GetOverlayColourType(Index), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[Index + 1] or 0, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[Index + 1] or 0)
		end

	    SetPedComponentVariation(PlayerPedId(), 2, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3], 0, 1)
	    SetPedHairColor(PlayerPedId(), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1], (PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights and PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[2] or PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1]))

	    SetPedEyeColor(PlayerPedId(), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].EyeColour)

	    SetPedComponentVariation(PlayerPedId(), 1, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[2], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[2], 1)

	    for Index = 3, 11 do
	    	SetPedComponentVariation(PlayerPedId(), Index, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index + 1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index + 1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Palette[Index + 1])
	    end

	    for Index = 0, 7 do
	    	SetPedPropIndex(PlayerPedId(), Index, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index + 1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index + 1], true)
	    end

	    ClearPedDecorations(PlayerPedId())

	    for Tattoo, Collection in pairs(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos) do
	    	SetPedDecoration(PlayerPedId(), GetHashKey(Collection), GetHashKey(Tattoo))
	   	end
	else
	    for Index = 0, 11 do
	    	SetPedComponentVariation(PlayerPedId(), Index, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index + 1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index + 1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Palette[Index + 1])
	    end

	    for Index = 0, 7 do
	    	SetPedPropIndex(PlayerPedId(), Index, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index + 1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index + 1], true)
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

        PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender = ((Model == GetHashKey("mp_m_freemode_01")) and "Male" or ((Model == GetHashKey("mp_f_freemode_01")) and "Female" or "Hybrid"))
        PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model = Skin

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
	for Index = 1, #PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		for Outfit = 1, #PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index] do
			local Count = 0
			for ClothingIndex = 4, 12 do
				if PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Outfit].Value.Drawable[ClothingIndex] == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[ClothingIndex] and PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Outfit].Value.Texture[ClothingIndex] == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[ClothingIndex] then
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
	for Index = 1, #PlayerCustomisation.Reference.Apparel.Hat[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		if PlayerCustomisation.Reference.Apparel.Hat[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value.Drawable == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[1] and PlayerCustomisation.Reference.Apparel.Hat[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value.Texture == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[1] then
			return Index
		end
	end
	return nil
end

function GetGlassesIndex()
	for Index = 1, #PlayerCustomisation.Reference.Apparel.Glasses[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		if PlayerCustomisation.Reference.Apparel.Glasses[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value.Drawable == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[2] and PlayerCustomisation.Reference.Apparel.Glasses[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value.Texture == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[2] then
			return Index
		end
	end
	return nil
end

function GetHairIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		if PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3] then
			return Index
		end
	end
	return nil
end

function GetBeardIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Beards do
		if PlayerCustomisation.Reference.Appearance.Beards[Index].Value == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[2] then
			return Index
		end
	end
	return nil
end

function GetEyebrowIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Eyebrows do
		if PlayerCustomisation.Reference.Appearance.Eyebrows[Index].Value == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[3] then
			return Index
		end
	end
	return nil
end

function GetChestIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Chest do
		if PlayerCustomisation.Reference.Appearance.Chest[Index].Value == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[11] then
			return Index
		end
	end
	return nil
end

function GetFacePaintIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.FacePaint do
		if PlayerCustomisation.Reference.Appearance.FacePaint[Index].Value == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[5] then
			return Index
		end
	end
	return nil
end

function GetEyeMakeupIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.EyeMakeup do
		if PlayerCustomisation.Reference.Appearance.EyeMakeup[Index].Value == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[5] then
			return Index
		end
	end
	return nil
end

function GetBlushIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Blush do
		if PlayerCustomisation.Reference.Appearance.Blush[Index].Value == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[6] then
			return Index
		end
	end
	return nil
end

function GetLipstickIndex()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Lipstick do
		if PlayerCustomisation.Reference.Appearance.Lipstick[Index].Value == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[9] then
			return Index
		end
	end
	return nil
end

function GetComponentIndex(Component)
	for Index = 1, #PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		if Component == PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Name or Component == PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value then
			return Index
		end
	end
	return nil
end

function GetPropIndex(Prop)
	for Index = 1, #PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		if Prop == PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Name or Prop == PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value then
			return Index
		end
	end
	return nil
end

function GetMaskIndex(Category)
	if PlayerCustomisation.Reference.Masks.List[Category] then
		for Index = 1, #PlayerCustomisation.Reference.Masks.List[Category] do
			if PlayerCustomisation.Reference.Masks.List[Category][Index].Value.Drawable == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[2] and PlayerCustomisation.Reference.Masks.List[Category][Index].Value.Texture == PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[2] then
				return Index
			end
		end
	end
	return nil
end

function RetrieveComponents()
	if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender == "Hybrid" then
		PlayerCustomisation.Reference.Clothing.Options.Hybrid = {}
		for Index = 0, 11 do
			if GetNumberOfPedDrawableVariations(PlayerPedId(), Index) > 0 then
				table.insert(PlayerCustomisation.Reference.Clothing.Options.Hybrid, {Name = PlayerCustomisation.Reference.Clothing.Options.PedComponentNames[tostring(Index)] or "Slot "..Index, Value = Index})
			end
		end
	end

	PlayerCustomisation.Reference.Clothing.Drawables = {}
	PlayerCustomisation.Reference.Clothing.Textures = {}

	for Index = 1, #PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		PlayerCustomisation.Reference.Clothing.Drawables[PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Name] = {}
		for Drawable = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value) do
			table.insert(PlayerCustomisation.Reference.Clothing.Drawables[PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Name], Drawable)
		end
	end

	for Component, Drawables in pairs(PlayerCustomisation.Reference.Clothing.Drawables) do
		PlayerCustomisation.Reference.Clothing.Textures[Component] = {}
		for Index = 1, #Drawables do
			table.insert(PlayerCustomisation.Reference.Clothing.Textures[Component], {})
			if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender ~= "Hybrid" and PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][GetComponentIndex(Component)].Value == 8 and Drawables[Index] == 0 then
				table.insert(PlayerCustomisation.Reference.Clothing.Textures[Component][Index], 240)
			end
			for Texture = 0, GetNumberOfPedTextureVariations(PlayerPedId(), PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][GetComponentIndex(Component)].Value, Drawables[Index]) do
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
	if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender == "Hybrid" then
		PlayerCustomisation.Reference.Props.Options.Hybrid = {}
		for Index = 0, 7 do
			if GetNumberOfPedPropDrawableVariations(PlayerPedId(), Index) > 0 then
				table.insert(PlayerCustomisation.Reference.Props.Options.Hybrid, {Name = PlayerCustomisation.Reference.Props.Options.PedPropNames[tostring(Index)] or "Slot "..Index, Value = Index})
			end
		end
	end

	PlayerCustomisation.Reference.Props.Drawables = {}
	PlayerCustomisation.Reference.Props.Textures = {}

	for Index = 1, #PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		PlayerCustomisation.Reference.Props.Drawables[PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Name] = {-1}
		for Drawable = 0, GetNumberOfPedPropDrawableVariations(PlayerPedId(), PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value) do
			table.insert(PlayerCustomisation.Reference.Props.Drawables[PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Name], Drawable)
		end
	end

	for Prop, Drawables in pairs(PlayerCustomisation.Reference.Props.Drawables) do
		PlayerCustomisation.Reference.Props.Textures[Prop] = {}
		for Index = 1, #Drawables do
			table.insert(PlayerCustomisation.Reference.Props.Textures[Prop], {})

			for Texture = 0, GetNumberOfPedPropTextureVariations(PlayerPedId(), PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][GetPropIndex(Prop)].Value, Drawables[Index]) do
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

Citizen.CreateThread(function()
	AddTextEntry("TAT_FM_008", "Skull")
	AddTextEntry("TAT_FM_009", "Burning Heart")
	AddTextEntry("TAT_FM_010", "Grim Reaper Smoking Gun")
	AddTextEntry("TAT_FM_011", "Blackjack")
	AddTextEntry("TAT_FM_012", "Hustler")
	AddTextEntry("TAT_FM_013", "Angel")
	AddTextEntry("TAT_FM_014", "Skull and Sword")
	AddTextEntry("TAT_FM_015", "Racing Blonde")
	AddTextEntry("TAT_FM_016", "Los Santos Customs")
	AddTextEntry("TAT_FM_017", "Dragon and Dagger")
	AddTextEntry("TAT_FM_018", "Ride or Die")
	AddTextEntry("TAT_FM_019", "Blank Scroll")
	AddTextEntry("TAT_FM_020", "Embellished Scroll")
	AddTextEntry("TAT_FM_021", "Seven Deadly Sins")
	AddTextEntry("TAT_FM_022", "Trust No One")
	AddTextEntry("TAT_FM_023", "Racing Brunette")
	AddTextEntry("TAT_FM_024", "Clown")
	AddTextEntry("TAT_FM_025", "Clown and Gun")
	AddTextEntry("TAT_FM_026", "Clown Dual Wield")
	AddTextEntry("TAT_FM_027", "Clown Dual Wield Dollars")
	AddTextEntry("TAT_FM_100", "Crew Emblem Small")
	AddTextEntry("TAT_FM_101", "Crew Emblem Large")
	AddTextEntry("TAT_FM_102", "Crew Emblem Large")
	AddTextEntry("TAT_FM_103", "Crew Emblem Small")
	AddTextEntry("TAT_FM_201", "Serpents")
	AddTextEntry("TAT_FM_202", "Oriental Mural")
	AddTextEntry("TAT_FM_203", "Zodiac Skull")
	AddTextEntry("TAT_FM_204", "Brotherhood")
	AddTextEntry("TAT_FM_205", "Dragons")
	AddTextEntry("TAT_FM_206", "Dragons and Skull")
	AddTextEntry("TAT_FM_207", "Flower Mural")
	AddTextEntry("TAT_FM_208", "Serpent Skull")
	AddTextEntry("TAT_FM_209", "Melting Skull")
	AddTextEntry("TAT_FM_210", "The Warrior")
	AddTextEntry("TAT_FM_211", "Dragon Mural")
	AddTextEntry("TAT_FM_212", "Tribal")
	AddTextEntry("TAT_FM_213", "Skull on the Cross")
	AddTextEntry("TAT_FM_214", "LS Script")
	AddTextEntry("TAT_FM_215", "Eagle and Serpent")
	AddTextEntry("TAT_FM_216", "Evil Clown")
	AddTextEntry("TAT_FM_217", "The Wages of Sin")
	AddTextEntry("TAT_FM_218", "LS Flames")
	AddTextEntry("TAT_FM_219", "Faith")
	AddTextEntry("TAT_FM_220", "Los Santos Bills")
	AddTextEntry("TAT_FM_221", "Dragon")
	AddTextEntry("TAT_FM_222", "Serpent Skull")
	AddTextEntry("TAT_FM_223", "Fiery Dragon")
	AddTextEntry("TAT_FM_224", "Hottie")
	AddTextEntry("TAT_FM_225", "Flaming Cross")
	AddTextEntry("TAT_FM_226", "LS Bold")
	AddTextEntry("TAT_FM_227", "Smoking Dagger")
	AddTextEntry("TAT_FM_228", "Virgin Mary")
	AddTextEntry("TAT_FM_229", "Mermaid")
	AddTextEntry("TAT_FM_230", "Trinity Knot")
	AddTextEntry("TAT_FM_231", "Lucky Celtic Dogs")
	AddTextEntry("TAT_FM_232", "Lady M")
	AddTextEntry("TAT_FM_233", "Faith")
	AddTextEntry("TAT_FM_234", "Chinese Dragon")
	AddTextEntry("TAT_FM_235", "Flaming Shamrock")
	AddTextEntry("TAT_FM_236", "Dragon")
	AddTextEntry("TAT_FM_237", "Way of the Gun")
	AddTextEntry("TAT_FM_238", "Grim Reaper")
	AddTextEntry("TAT_FM_239", "Dagger")
	AddTextEntry("TAT_FM_240", "Broken Skull")
	AddTextEntry("TAT_FM_241", "Flaming Skull")
	AddTextEntry("TAT_FM_242", "Dope Skull")
	AddTextEntry("TAT_FM_243", "Flaming Scorpion")
	AddTextEntry("TAT_FM_244", "Indian Ram")
	AddTextEntry("TAT_FM_245", "Stone Cross")
	AddTextEntry("TAT_FM_246", "Skulls and Rose")
	AddTextEntry("TAT_FM_247", "Lion")
	AddTextEntry("TAT_TRV_32", "Unzipped")
end)
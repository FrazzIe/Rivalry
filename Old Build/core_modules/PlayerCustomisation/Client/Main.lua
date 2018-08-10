local MenuLogoSprite = NativeUI.CreateSprite("", "")

local MergeOption = SetupMergeOption(CharacterCreatorMenu)
local GenderOption = SetupGenderOption(CharacterCreatorMenu)
local HeritageMenu = SetupHeritageMenu(CharacterCreatorMenu)
local FeaturesMenu = SetupFeaturesMenu(CharacterCreatorMenu)
local AppearanceMenu = SetupAppearanceMenu(CharacterCreatorMenu)
local ApparelMenu = SetupApparelMenu(CharacterCreatorMenu)
local SaveOption = SetupSaveOption(CharacterCreatorMenu)
local ModelMenu = SetupModelMenu(CharacterCreatorMenu)

local HairstyleMenu = SetupHairstylesMenu(BarberMenu)
local BeardMenu = SetupBeardsMenu(BarberMenu)
local EyebrowMenu = SetupEyebrowsMenu(BarberMenu)
local ChestMenu = SetupChestMenu(BarberMenu)
local ContactMenu = SetupContactsMenu(BarberMenu)
local FacePaintMenu = SetupFacePaintsMenu(BarberMenu)
local MakeupMenu = SetupMakeupMenu(BarberMenu)
local EyeMakeupMenu = SetupEyeMakeupMenu(MakeupMenu)
local BlushMenu = SetupBlusherMenu(MakeupMenu)
local LipstickMenu = SetupLipstickMenu(MakeupMenu)

CharacterCreatorMenu.Items[3].Activated = function(ParentMenu, SelectedItem)
	RemoveMask()
	CharacterCreatorMenu.Cameras.Face:Switch(CharacterCreatorMenu.Cameras.Default.Handle, 1000, false, false)
end

CharacterCreatorMenu.Items[4].Activated = function(ParentMenu, SelectedItem)
	RemoveMask()
	CharacterCreatorMenu.Cameras.Face:Switch(CharacterCreatorMenu.Cameras.Default.Handle, 1000, false, false)
end

CharacterCreatorMenu.Items[5].Activated = function(ParentMenu, SelectedItem)
	RemoveMask()
	CharacterCreatorMenu.Cameras.Face:Switch(CharacterCreatorMenu.Cameras.Default.Handle, 1000, false, false)
end

BarberMenu.Items[1].Activated = function(ParentMenu, SelectedItem)
	RemoveMask()
	BarberMenu.Cameras.Face:Switch(BarberMenu.Cameras.Default.Handle, 1000, false, false)
end

BarberMenu.Items[2].Activated = function(ParentMenu, SelectedItem)
	RemoveMask()
	BarberMenu.Cameras.Face:Switch(BarberMenu.Cameras.Default.Handle, 1000, false, false)
end

BarberMenu.Items[3].Activated = function(ParentMenu, SelectedItem)
	ClearPedProp(PlayerPedId(), 1)
	RemoveMask()
	BarberMenu.Cameras.Face:Switch(BarberMenu.Cameras.Default.Handle, 1000, false, false)
end

BarberMenu.Items[4].Activated = SetPedTopless

BarberMenu.Items[5].Activated = function(ParentMenu, SelectedItem)
	ClearPedProp(PlayerPedId(), 1)
	RemoveMask()
	BarberMenu.Cameras.Face:Switch(BarberMenu.Cameras.Default.Handle, 1000, false, false)
end

BarberMenu.Items[6].Activated = function(ParentMenu, SelectedItem)
	ClearPedProp(PlayerPedId(), 1)
	RemoveMask()
	BarberMenu.Cameras.Face:Switch(BarberMenu.Cameras.Default.Handle, 1000, false, false)
end

MakeupMenu.Items[1].Activated = function(ParentMenu, SelectedItem)
	ClearPedProp(PlayerPedId(), 1)
	RemoveMask()
	BarberMenu.Cameras.Face:Switch(BarberMenu.Cameras.Default.Handle, 1000, false, false)
end

MakeupMenu.Items[2].Activated = function(ParentMenu, SelectedItem)
	RemoveMask()
	BarberMenu.Cameras.Face:Switch(BarberMenu.Cameras.Default.Handle, 1000, false, false)
end

MakeupMenu.Items[3].Activated = function(ParentMenu, SelectedItem)
	RemoveMask()
	BarberMenu.Cameras.Face:Switch(BarberMenu.Cameras.Default.Handle, 1000, false, false)
end

PlayerCustomisation.Pool:Add(CharacterCreatorMenu)
PlayerCustomisation.Pool:Add(ModelMenu)
PlayerCustomisation.Pool:Add(BarberMenu)
PlayerCustomisation.Pool:Add(ClothingMenu)
PlayerCustomisation.Pool:Add(MaskMenu)
PlayerCustomisation.Pool:Add(TattooMenu)
PlayerCustomisation.Pool:Add(OutfitMenu)

CharacterCreatorMenu.OnListSelect = function(ParentMenu, SelectedList, NewIndex) 
	if SelectedList == GenderOption then
		SelectedList:Enabled(false)
		local Item = SelectedList:IndexToItem(NewIndex)
		if Item == "Hybrid" then
			ParentMenu:Visible(false)
			ModelMenu:Visible(true)
			for Index = 3, (#ParentMenu.Items - 1) do
				ParentMenu.Items[Index]:Enabled(false)
				ParentMenu.Items[Index]:SetRightBadge(BadgeStyle.Lock)
			end

			ParentMenu.Items[1]:Enabled(false)
		else
			UpdateModel(Item.Value)

			AppearanceMenu.Items[1].Items = PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]
			ApparelMenu.Items[3].Items = PlayerCustomisation.Reference.Apparel.Hat[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]
			ApparelMenu.Items[4].Items = PlayerCustomisation.Reference.Apparel.Glasses[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]

			HeritageMenu.Windows[1]:Index(GetPortraitFromFace("Female", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1]), GetPortraitFromFace("Male", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2]))
			HeritageMenu.Items[1]:Index(GetFaceIndex("Female", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1]))
			HeritageMenu.Items[2]:Index(GetFaceIndex("Male", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2]))
			HeritageMenu.Items[3]:Index(HeritageMenu.Items[3]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[3]))
			HeritageMenu.Items[4]:Index(HeritageMenu.Items[4]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[4]))

			FeaturesMenu.Items[1].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[8], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[7])
			FeaturesMenu.Items[2].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[12], 0.5)
			FeaturesMenu.Items[3].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[2])
			FeaturesMenu.Items[4].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[3], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[4])
			FeaturesMenu.Items[5].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[6], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[5])
			FeaturesMenu.Items[6].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[10], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[9])
			FeaturesMenu.Items[7].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[11], 0.5)
			FeaturesMenu.Items[8].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[13], 0.5)
			FeaturesMenu.Items[9].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[14], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[15])
			FeaturesMenu.Items[10].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[17], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[16])
			FeaturesMenu.Items[11].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[18], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[19])

			AppearanceMenu.Items[1]:Index(AppearanceMenu.Items[1]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3]))
			AppearanceMenu.Items[1].Panels[1]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1], true)
			AppearanceMenu.Items[1].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[2], true)
			AppearanceMenu.Items[2]:Index(AppearanceMenu.Items[2]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[3]))
			AppearanceMenu.Items[2].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[3])
			AppearanceMenu.Items[2].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[3], true)
			AppearanceMenu.Items[3]:Index(AppearanceMenu.Items[3]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[2]))
			AppearanceMenu.Items[3].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[2])
			AppearanceMenu.Items[3].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[2], true)
			AppearanceMenu.Items[4]:Index(AppearanceMenu.Items[4]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[1]))
			AppearanceMenu.Items[4].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[1])
			AppearanceMenu.Items[5]:Index(AppearanceMenu.Items[5]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[4]))
			AppearanceMenu.Items[5].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[4])
			AppearanceMenu.Items[6]:Index(AppearanceMenu.Items[6]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[7]))
			AppearanceMenu.Items[6].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[7])
			AppearanceMenu.Items[7]:Index(AppearanceMenu.Items[7]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[10]))
			AppearanceMenu.Items[7].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[10])
			AppearanceMenu.Items[8]:Index(AppearanceMenu.Items[8]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[8]))
			AppearanceMenu.Items[8].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[8])
			AppearanceMenu.Items[9]:Index(AppearanceMenu.Items[9]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].EyeColour))
			AppearanceMenu.Items[10]:Index(AppearanceMenu.Items[10]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[5]))
			AppearanceMenu.Items[10].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5])
			AppearanceMenu.Items[11]:Index(AppearanceMenu.Items[11]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[6]))
			AppearanceMenu.Items[11].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[6])
			AppearanceMenu.Items[11].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[6], true)
			AppearanceMenu.Items[12]:Index(AppearanceMenu.Items[12]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[9]))
			AppearanceMenu.Items[12].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[9])
			AppearanceMenu.Items[12].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[9], true)

			AppearanceMenu.Items[1].Panels[2]:Enabled(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights)

			local StyleIndex, OutfitIndex = GetOutfitIndex()

			ApparelMenu.Items[2].Items = PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][StyleIndex]
			ApparelMenu.Items[1]:Index(StyleIndex)
			ApparelMenu.Items[2]:Index(OutfitIndex)
			ApparelMenu.Items[3]:Index(GetHatIndex())
			ApparelMenu.Items[4]:Index(GetGlassesIndex())

			for Index = 3, #ParentMenu.Items do
				ParentMenu.Items[Index]:Enabled(true)
				ParentMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
			end

			ParentMenu.Items[1]:Enabled(true)

			SetupTattooMenu(TattooMenu)
			UpdateHairstylesMenu(HairstyleMenu)

			AttachEntityToEntity(PlayerCustomisation.Creator.Board.Handle, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			AttachEntityToEntity(PlayerCustomisation.Creator.Board.RenderTarget.Handle, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			TaskPlayAnim(PlayerPedId(), PlayerCustomisation.Creator.Board.Dictionary, PlayerCustomisation.Creator.Board.Animation, 8.0, -8, -1, 1, 0, 0, 0, 0)
		end

		SetupOutfitMenu(OutfitMenu)

		SelectedList:Enabled(true)
	end
end

MergeOption.OnListSelected = function(ParentMenu, ListItem, NewIndex)
	local ActiveItem = ListItem:IndexToItem(NewIndex)

	for Index = 1, #PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature do
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[Index] = PlayerCustomisation.PlayerData.Types[ActiveItem][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[Index]
	end

	for Index = 1, #PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend do
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[Index] = PlayerCustomisation.PlayerData.Types[ActiveItem][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[Index]
	end

	for Index = 1, #PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable do
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[Index] = PlayerCustomisation.PlayerData.Types[ActiveItem][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[Index]
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[Index] = PlayerCustomisation.PlayerData.Types[ActiveItem][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[Index]
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[Index] = PlayerCustomisation.PlayerData.Types[ActiveItem][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[Index]
	end

	PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos = PlayerCustomisation.PlayerData.Types[ActiveItem][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos

	PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3] = PlayerCustomisation.PlayerData.Types[ActiveItem][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3]
	
	PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1] = PlayerCustomisation.PlayerData.Types[ActiveItem][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1]

	PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[2] = PlayerCustomisation.PlayerData.Types[ActiveItem][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[2]

	PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights = PlayerCustomisation.PlayerData.Types[ActiveItem][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights
	UpdatePlayer()

	AppearanceMenu.Items[1].Items = PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]
	ApparelMenu.Items[3].Items = PlayerCustomisation.Reference.Apparel.Hat[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]
	ApparelMenu.Items[4].Items = PlayerCustomisation.Reference.Apparel.Glasses[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]

	HeritageMenu.Windows[1]:Index(GetPortraitFromFace("Female", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1]), GetPortraitFromFace("Male", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2]))
	HeritageMenu.Items[1]:Index(GetFaceIndex("Female", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1]))
	HeritageMenu.Items[2]:Index(GetFaceIndex("Male", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2]))
	HeritageMenu.Items[3]:Index(HeritageMenu.Items[3]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[3]))
	HeritageMenu.Items[4]:Index(HeritageMenu.Items[4]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[4]))

	FeaturesMenu.Items[1].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[8], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[7])
	FeaturesMenu.Items[2].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[12], 0.5)
	FeaturesMenu.Items[3].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[2])
	FeaturesMenu.Items[4].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[3], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[4])
	FeaturesMenu.Items[5].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[6], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[5])
	FeaturesMenu.Items[6].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[10], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[9])
	FeaturesMenu.Items[7].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[11], 0.5)
	FeaturesMenu.Items[8].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[13], 0.5)
	FeaturesMenu.Items[9].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[14], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[15])
	FeaturesMenu.Items[10].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[17], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[16])
	FeaturesMenu.Items[11].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[18], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[19])

	AppearanceMenu.Items[1]:Index(AppearanceMenu.Items[1]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3]))
	AppearanceMenu.Items[1].Panels[1]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1], true)
	AppearanceMenu.Items[1].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[2], true)
	AppearanceMenu.Items[2]:Index(AppearanceMenu.Items[2]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[3]))
	AppearanceMenu.Items[2].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[3])
	AppearanceMenu.Items[2].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[3], true)
	AppearanceMenu.Items[3]:Index(AppearanceMenu.Items[3]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[2]))
	AppearanceMenu.Items[3].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[2])
	AppearanceMenu.Items[3].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[2], true)
	AppearanceMenu.Items[4]:Index(AppearanceMenu.Items[4]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[1]))
	AppearanceMenu.Items[4].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[1])
	AppearanceMenu.Items[5]:Index(AppearanceMenu.Items[5]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[4]))
	AppearanceMenu.Items[5].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[4])
	AppearanceMenu.Items[6]:Index(AppearanceMenu.Items[6]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[7]))
	AppearanceMenu.Items[6].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[7])
	AppearanceMenu.Items[7]:Index(AppearanceMenu.Items[7]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[10]))
	AppearanceMenu.Items[7].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[10])
	AppearanceMenu.Items[8]:Index(AppearanceMenu.Items[8]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[8]))
	AppearanceMenu.Items[8].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[8])
	AppearanceMenu.Items[9]:Index(AppearanceMenu.Items[9]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].EyeColour))
	AppearanceMenu.Items[10]:Index(AppearanceMenu.Items[10]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[5]))
	AppearanceMenu.Items[10].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5])
	AppearanceMenu.Items[11]:Index(AppearanceMenu.Items[11]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[6]))
	AppearanceMenu.Items[11].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[6])
	AppearanceMenu.Items[11].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[6], true)
	AppearanceMenu.Items[12]:Index(AppearanceMenu.Items[12]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[9]))
	AppearanceMenu.Items[12].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[9])
	AppearanceMenu.Items[12].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[9], true)

	AppearanceMenu.Items[1].Panels[2]:Enabled(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights)

	SetupTattooMenu(TattooMenu)
end

function OpenBarberMenu(LocationIndex)
	IsStanceAllowed = false
	TriggerEvent("chat:disable", true)
	hud_off = true
	
	PlayerCustomisation.Instanced = true
	TriggerServerEvent("PlayerCustomisation.Instance", true)

	if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender == "Hybrid" then
		for Index = 1, #BarberMenu.Items do
			BarberMenu.Items[Index]:Enabled(false)
			BarberMenu.Items[Index]:SetRightBadge(BadgeStyle.Lock)
		end
	else
		for Index = 1, #BarberMenu.Items do
			BarberMenu.Items[Index]:Enabled(true)
			BarberMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
		end

		for Index = 1, #HairstyleMenu.Items do
			HairstyleMenu.Items[Index]:Text(PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Name)
			HairstyleMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
			HairstyleMenu.Items[Index].Panels[1]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1], true)
			HairstyleMenu.Items[Index].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1], true)
			HairstyleMenu.Items[Index].Panels[2]:Enabled(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights)
		end

		HairstyleMenu.Items[GetHairIndex()]:SetRightBadge(BadgeStyle.Barber)

		local BeardIndex = GetBeardIndex() or 1
		local BeardPanelsEnabled = (BeardIndex ~= 1)

		for Index = 1, #BeardMenu.Items do
			BeardMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
			BeardMenu.Items[Index].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[2])
			BeardMenu.Items[Index].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[2], true)
			BeardMenu.Items[Index].Panels[1]:Enabled(BeardPanelsEnabled)
			BeardMenu.Items[Index].Panels[2]:Enabled(BeardPanelsEnabled)
		end

		BeardMenu.Items[BeardIndex]:SetRightBadge(BadgeStyle.Barber)

		local EyebrowIndex = GetEyebrowIndex() or 1
		local EyebrowPanelsEnabled = (EyebrowIndex ~= 1)

		for Index = 1, #BeardMenu.Items do
			EyebrowMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
			EyebrowMenu.Items[Index].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[3])
			EyebrowMenu.Items[Index].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[3], true)
			EyebrowMenu.Items[Index].Panels[1]:Enabled(EyebrowPanelsEnabled)
			EyebrowMenu.Items[Index].Panels[2]:Enabled(EyebrowPanelsEnabled)
		end

		EyebrowMenu.Items[EyebrowIndex]:SetRightBadge(BadgeStyle.Barber)

		if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender == "Male" then
			local ChestIndex = GetChestIndex() or 1
			local ChestPanelsEnabled = (ChestIndex ~= 1)

			for Index = 1, #ChestMenu.Items do
				ChestMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
				ChestMenu.Items[Index].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[11])
				ChestMenu.Items[Index].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[11], true)
				ChestMenu.Items[Index].Panels[1]:Enabled(ChestPanelsEnabled)
				ChestMenu.Items[Index].Panels[2]:Enabled(ChestPanelsEnabled)
			end

			ChestMenu.Items[ChestIndex]:SetRightBadge(BadgeStyle.Barber)
		else
			BarberMenu.Items[4]:Enabled(false)
			BarberMenu.Items[4]:SetRightBadge(BadgeStyle.Lock)
		end

		for Index = 1, #ContactMenu.Items do
			ContactMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
		end

		ContactMenu.Items[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].EyeColour + 1]:SetRightBadge(BadgeStyle.Barber)

		local FacePaintIndex = GetFacePaintIndex() or 1
		local FacePaintPanelsEnabled = (FacePaintIndex ~= 1)

		for Index = 1, #FacePaintMenu.Items do
			FacePaintMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
			FacePaintMenu.Items[Index].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5])
			FacePaintMenu.Items[Index].Panels[1]:Enabled(FacePaintPanelsEnabled)
		end

		FacePaintMenu.Items[FacePaintIndex]:SetRightBadge(BadgeStyle.Makeup)

		local EyeMakeupIndex = GetEyeMakeupIndex() or 1
		local EyeMakeupPanelsEnabled = (FacePaintIndex ~= 1)

		for Index = 1, #EyeMakeupMenu.Items do
			EyeMakeupMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
			EyeMakeupMenu.Items[Index].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5])
			EyeMakeupMenu.Items[Index].Panels[1]:Enabled(EyeMakeupPanelsEnabled)
		end

		EyeMakeupMenu.Items[EyeMakeupIndex]:SetRightBadge(BadgeStyle.Makeup)

		local BlushIndex = GetBlushIndex() or 1
		local BlushPanelsEnabled = (BlushIndex ~= 1)

		for Index = 1, #BlushMenu.Items do
			BlushMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
			BlushMenu.Items[Index].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[6])
			BlushMenu.Items[Index].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[6], true)
			BlushMenu.Items[Index].Panels[1]:Enabled(BlushPanelsEnabled)
			BlushMenu.Items[Index].Panels[2]:Enabled(BlushPanelsEnabled)
		end

		BlushMenu.Items[BlushIndex]:SetRightBadge(BadgeStyle.Makeup)

		local LipstickIndex = GetLipstickIndex() or 1
		local LipstickPanelsEnabled = (LipstickIndex ~= 1)

		for Index = 1, #LipstickMenu.Items do
			LipstickMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
			LipstickMenu.Items[Index].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[9])
			LipstickMenu.Items[Index].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[9], true)
			LipstickMenu.Items[Index].Panels[1]:Enabled(LipstickPanelsEnabled)
			LipstickMenu.Items[Index].Panels[2]:Enabled(LipstickPanelsEnabled)
		end

		LipstickMenu.Items[LipstickIndex]:SetRightBadge(BadgeStyle.Makeup)
	end
	
	SetEntityCoords(PlayerPedId(), PlayerCustomisation.Locations.Barbers[LocationIndex].Marker.x, PlayerCustomisation.Locations.Barbers[LocationIndex].Marker.y, GetGroundZ(PlayerCustomisation.Locations.Barbers[LocationIndex].Marker.x, PlayerCustomisation.Locations.Barbers[LocationIndex].Marker.y, PlayerCustomisation.Locations.Barbers[LocationIndex].Marker.z))
	SetEntityHeading(PlayerPedId(), PlayerCustomisation.Locations.Barbers[LocationIndex].Marker.h)
	FreezeEntityPosition(PlayerPedId(), true)

	BarberMenu.Cameras.Default:Create()
	BarberMenu.Cameras.Default:Position(table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.4)))
	BarberMenu.Cameras.Default:Rotate(0.0, 0.0, PlayerCustomisation.Locations.Barbers[LocationIndex].Marker.h - 180.0)

	BarberMenu.Cameras.Face:Create()
	BarberMenu.Cameras.Face:Position(table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.5, 0.7)))
	BarberMenu.Cameras.Face:Rotate(0.0, 0.0, PlayerCustomisation.Locations.Barbers[LocationIndex].Marker.h - 180.0)

	BarberMenu.Cameras.Default:Activate(false, 2000)

	MenuLogoSprite.TxtDictionary = PlayerCustomisation.Locations.Barbers[LocationIndex].Banner
	MenuLogoSprite.TxtName = PlayerCustomisation.Locations.Barbers[LocationIndex].Banner
	BarberMenu:SetBannerSprite(MenuLogoSprite, true)
	MakeupMenu:SetBannerSprite(MenuLogoSprite, true)

	BarberMenu:Visible(true)
end

function OpenClothingMenu(LocationIndex)
	IsStanceAllowed = false
	TriggerEvent("chat:disable", true)
	hud_off = true

	PlayerCustomisation.Instanced = true
	TriggerServerEvent("PlayerCustomisation.Instance", true)

	RetrieveComponents()
	RetrieveProps()

	if #PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] > 0 then
		ClothingMenu.Items[1].Data.Items = PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]

		ClothingMenu.Items[2].Data.Items = PlayerCustomisation.Reference.Clothing.Drawables[PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][1].Name]
		ClothingMenu.Items[2]:Index(ClothingMenu.Items[2]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][1].Value + 1]))

		ClothingMenu.Items[3].Data.Items = PlayerCustomisation.Reference.Clothing.Textures[PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][1].Name][ClothingMenu.Items[2]:Index()]
		ClothingMenu.Items[3]:Index(ClothingMenu.Items[3]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][1].Value + 1]))

		ClothingMenu.Items[1]:Enabled(true)
		ClothingMenu.Items[2]:Enabled(true)
		ClothingMenu.Items[3]:Enabled(true)
	else
		ClothingMenu.Items[1].Data.Items = {{Name = "None", Value = 0}}
		ClothingMenu.Items[2].Data.Items = {0}
		ClothingMenu.Items[3].Data.Items = {0}

		ClothingMenu.Items[1]:Index(1)
		ClothingMenu.Items[2]:Index(1)
		ClothingMenu.Items[3]:Index(1)

		ClothingMenu.Items[1]:Enabled(false)
		ClothingMenu.Items[2]:Enabled(false)
		ClothingMenu.Items[3]:Enabled(false)
	end

	if #PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] > 0 then
		ClothingMenu.Items[4].Data.Items = PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]

		ClothingMenu.Items[5].Data.Items = PlayerCustomisation.Reference.Props.Drawables[PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][1].Name]
		ClothingMenu.Items[5]:Index(ClothingMenu.Items[5]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][1].Value + 1]))

		ClothingMenu.Items[6].Data.Items = PlayerCustomisation.Reference.Props.Textures[PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][1].Name][ClothingMenu.Items[5]:Index()]
		ClothingMenu.Items[6]:Index(ClothingMenu.Items[6]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][1].Value + 1]))

		ClothingMenu.Items[4]:Enabled(true)
		ClothingMenu.Items[5]:Enabled(true)
		ClothingMenu.Items[6]:Enabled(true)
	else
		ClothingMenu.Items[4].Data.Items = {{Name = "None", Value = 0}}
		ClothingMenu.Items[5].Data.Items = {0}
		ClothingMenu.Items[6].Data.Items = {0}

		ClothingMenu.Items[4]:Index(1)
		ClothingMenu.Items[5]:Index(1)
		ClothingMenu.Items[6]:Index(1)

		ClothingMenu.Items[4]:Enabled(false)
		ClothingMenu.Items[5]:Enabled(false)
		ClothingMenu.Items[6]:Enabled(false)
	end

	SetEntityCoords(PlayerPedId(), PlayerCustomisation.Locations.Clothing[LocationIndex].Marker.x, PlayerCustomisation.Locations.Clothing[LocationIndex].Marker.y, GetGroundZ(PlayerCustomisation.Locations.Clothing[LocationIndex].Marker.x, PlayerCustomisation.Locations.Clothing[LocationIndex].Marker.y, PlayerCustomisation.Locations.Clothing[LocationIndex].Marker.z))
	SetEntityHeading(PlayerPedId(), PlayerCustomisation.Locations.Clothing[LocationIndex].Marker.h)
	FreezeEntityPosition(PlayerPedId(), true)

	for Index = 1, #PlayerCustomisation.Reference.Clothing.Cameras[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		table.insert(ClothingMenu.CameraCoordinates.Clothing, GetOffsetFromEntityInWorldCoords(PlayerPedId(), PlayerCustomisation.Reference.Clothing.Cameras[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].x, PlayerCustomisation.Reference.Clothing.Cameras[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].y, PlayerCustomisation.Reference.Clothing.Cameras[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].z))
	end

	for Index = 1, #PlayerCustomisation.Reference.Props.Cameras[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		table.insert(ClothingMenu.CameraCoordinates.Props, GetOffsetFromEntityInWorldCoords(PlayerPedId(), PlayerCustomisation.Reference.Props.Cameras[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].x, PlayerCustomisation.Reference.Props.Cameras[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].y, PlayerCustomisation.Reference.Props.Cameras[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].z))
	end

	if ClothingMenu:CurrentSelection() < 4 then
		if ParentMenu.Items[1]:Enabled() then
			ClothingMenu.Cameras[1]:Position(table.unpack(ClothingMenu.CameraCoordinates.Clothing[PlayerCustomisation.Reference.Clothing.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][ClothingMenu.Items[1]:Index()].Value + 1]))
		else
			ClothingMenu.Cameras[1]:Position(table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.8, 0.7)))
		end
	else
		if ParentMenu.Items[4]:Enabled() then
			ClothingMenu.Cameras[1]:Position(table.unpack(ClothingMenu.CameraCoordinates.Props[PlayerCustomisation.Reference.Props.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][ClothingMenu.Items[4]:Index()].Value + 1]))
		else
			ClothingMenu.Cameras[1]:Position(table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.8, 0.7)))
		end
	end

	ClothingMenu.Cameras[1]:Rotate(0.0, 0.0, PlayerCustomisation.Locations.Clothing[LocationIndex].Marker.h - 180.0)
	ClothingMenu.Cameras[1]:Create()

	ClothingMenu.Cameras[2]:Rotate(0.0, 0.0, PlayerCustomisation.Locations.Clothing[LocationIndex].Marker.h - 180.0)
	ClothingMenu.Cameras[2]:Create()

	ClothingMenu.Cameras[1]:Activate(false, 2000)

	MenuLogoSprite.TxtDictionary = PlayerCustomisation.Locations.Clothing[LocationIndex].Banner
	MenuLogoSprite.TxtName = PlayerCustomisation.Locations.Clothing[LocationIndex].Banner
	ClothingMenu:SetBannerSprite(MenuLogoSprite, true)

	ClothingMenu:Visible(true)
end

function OpenMaskMenu(LocationIndex)
	IsStanceAllowed = false
	TriggerEvent("chat:disable", true)
	hud_off = true

	PlayerCustomisation.Instanced = true
	TriggerServerEvent("PlayerCustomisation.Instance", true)

	if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender == "Hybrid" then
		for Index = 1, #MaskMenu.Items do
			MaskMenu.Items[Index]:Enabled(false)
			MaskMenu.Items[Index]:SetRightBadge(BadgeStyle.Lock)
		end
	else
		for Index = 1, #MaskMenu.Items do
			MaskMenu.Items[Index]:Enabled(true)
			MaskMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
		end

		for Index = 1, #MaskMenu.Items do
			local Submenu = MaskMenu.Children[MaskMenu.Items[Index]]
			if Submenu then
				for ItemIndex = 1, #Submenu.Items do
					Submenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
				end

				local MaskIndex = GetMaskIndex(Index)

				if MaskIndex ~= nil then
					Submenu.Items[MaskIndex]:SetRightBadge(BadgeStyle.Clothes)
				end
			end
		end
	end

	SetEntityCoords(PlayerPedId(), PlayerCustomisation.Locations.Masks[LocationIndex].Marker.x, PlayerCustomisation.Locations.Masks[LocationIndex].Marker.y, GetGroundZ(PlayerCustomisation.Locations.Masks[LocationIndex].Marker.x, PlayerCustomisation.Locations.Masks[LocationIndex].Marker.y, PlayerCustomisation.Locations.Masks[LocationIndex].Marker.z))
	SetEntityHeading(PlayerPedId(), PlayerCustomisation.Locations.Masks[LocationIndex].Marker.h)
	FreezeEntityPosition(PlayerPedId(), true)

	MaskMenu.Cameras.Default:Position(table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.8, 0.7)))
	MaskMenu.Cameras.Default:Rotate(0.0, 0.0, PlayerCustomisation.Locations.Masks[LocationIndex].Marker.h - 180.0)
	MaskMenu.Cameras.Default:Create()

	MaskMenu.Cameras.Default:Activate(false, 2000)

	MenuLogoSprite.TxtDictionary = PlayerCustomisation.Locations.Masks[LocationIndex].Banner
	MenuLogoSprite.TxtName = PlayerCustomisation.Locations.Masks[LocationIndex].Banner
	MaskMenu:SetBannerSprite(MenuLogoSprite, true)
	MaskMenu:Visible(true)
end

function OpenTattooMenu(LocationIndex)
	IsStanceAllowed = false
	TriggerEvent("chat:disable", true)
	hud_off = true

	PlayerCustomisation.Instanced = true
	TriggerServerEvent("PlayerCustomisation.Instance", true)

	if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender == "Hybrid" then
		for Index = 1, #TattooMenu.Items do
			TattooMenu.Items[Index]:Enabled(false)
			TattooMenu.Items[Index]:SetRightBadge(BadgeStyle.Lock)
		end
	else
		for Index = 1, #TattooMenu.Items do
			TattooMenu.Items[Index]:Enabled(true)
			TattooMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
		end

		for Index = 1, #TattooMenu.Items do
			local Submenu = TattooMenu.Children[TattooMenu.Items[Index]]
			if Submenu then
				for ItemIndex = 1, #Submenu.Items do
					if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos[PlayerCustomisation.Reference.Tattoos.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][ItemIndex].Decoration] then
						Submenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.Tattoo)
					else
						Submenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
					end
				end
			end
		end
	end

	SetEntityCoords(PlayerPedId(), PlayerCustomisation.Locations.Tattoos[LocationIndex].Marker.x, PlayerCustomisation.Locations.Tattoos[LocationIndex].Marker.y, GetGroundZ(PlayerCustomisation.Locations.Tattoos[LocationIndex].Marker.x, PlayerCustomisation.Locations.Tattoos[LocationIndex].Marker.y, PlayerCustomisation.Locations.Tattoos[LocationIndex].Marker.z))
	SetEntityHeading(PlayerPedId(), PlayerCustomisation.Locations.Tattoos[LocationIndex].Marker.h)
	FreezeEntityPosition(PlayerPedId(), true)

	SetPedNaked()

	TattooMenu.Cameras.Default:Position(table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.2, 0.3)))
	TattooMenu.Cameras.Default:Rotate(0.0, 0.0, PlayerCustomisation.Locations.Tattoos[LocationIndex].Marker.h - 180.0)
	
	TattooMenu.Cameras.Face:Position(table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.8, 0.7)))
	TattooMenu.Cameras.Face:Rotate(0.0, 0.0, PlayerCustomisation.Locations.Tattoos[LocationIndex].Marker.h - 180.0)

	TattooMenu.Cameras.Legs:Position(table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.2, -0.3)))
	TattooMenu.Cameras.Legs:Rotate(0.0, 0.0, PlayerCustomisation.Locations.Tattoos[LocationIndex].Marker.h - 180.0)

	TattooMenu.Cameras.Default:Create()
	TattooMenu.Cameras.Face:Create()
	TattooMenu.Cameras.Legs:Create()

	TattooMenu.Cameras.Default:Activate(false, 2000)

	MenuLogoSprite.TxtDictionary = PlayerCustomisation.Locations.Tattoos[LocationIndex].Banner
	MenuLogoSprite.TxtName = PlayerCustomisation.Locations.Tattoos[LocationIndex].Banner

	TattooMenu:SetBannerSprite(MenuLogoSprite, true)
	TattooMenu:Visible(true)
end

function OpenOutfitMenu(LocationIndex)
	IsStanceAllowed = false
	TriggerEvent("chat:disable", true)
	hud_off = true

	PlayerCustomisation.Instanced = true
	TriggerServerEvent("PlayerCustomisation.Instance", true)

	SetEntityCoords(PlayerPedId(), PlayerCustomisation.Locations.Outfits[LocationIndex].Marker.x, PlayerCustomisation.Locations.Outfits[LocationIndex].Marker.y, GetGroundZ(PlayerCustomisation.Locations.Outfits[LocationIndex].Marker.x, PlayerCustomisation.Locations.Outfits[LocationIndex].Marker.y, PlayerCustomisation.Locations.Outfits[LocationIndex].Marker.z))
	SetEntityHeading(PlayerPedId(), PlayerCustomisation.Locations.Outfits[LocationIndex].Marker.h)
	FreezeEntityPosition(PlayerPedId(), true)

	OutfitMenu.Cameras.Default:Position(table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.7, 0.2)))
	OutfitMenu.Cameras.Default:Rotate(-5.0, 0.0, PlayerCustomisation.Locations.Outfits[LocationIndex].Marker.h - 180.0)

	OutfitMenu.Cameras.Default:Create()

	OutfitMenu.Cameras.Default:Activate(false, 2000)

	MenuLogoSprite.TxtDictionary = PlayerCustomisation.Locations.Outfits[LocationIndex].Banner
	MenuLogoSprite.TxtName = PlayerCustomisation.Locations.Outfits[LocationIndex].Banner

	OutfitMenu:SetBannerSprite(MenuLogoSprite, true)
	OutfitMenu:Visible(true)
end

function OpenCharacterCreatorMenu(Coordinates, Name, CharacterId, Gender, Rank)
	IsStanceAllowed = false
	TriggerEvent("chat:disable", true)
	hud_off = true

	if Coordinates == nil then
		Coordinates = GetEntityCoords(PlayerPedId(), false)
	end

	ClearPedTasks()

	if PlayerCustomisation.Creator.Board.Scaleform.Handle == nil then
		PlayerCustomisation.Creator.Board.Scaleform.Handle = RequestScaleformMovie(PlayerCustomisation.Creator.Board.Scaleform.Name)

		while not HasScaleformMovieLoaded(PlayerCustomisation.Creator.Board.Scaleform.Handle) do
			Citizen.Wait(25)
		end
	end

	PushScaleformMovieFunction(PlayerCustomisation.Creator.Board.Scaleform.Handle, "SET_BOARD")

	PushScaleformMovieFunctionParameterString(Name) -- Header
	PushScaleformMovieFunctionParameterString(CharacterId) -- Inmate number
	PushScaleformMovieFunctionParameterString("Rivalry") -- Bottom text
	PushScaleformMovieFunctionParameterString(Gender) -- Top text
	PushScaleformMovieFunctionParameterInt(0) -- Top text colour

	if tonumber(Rank) then
		PushScaleformMovieFunctionParameterInt(Rank) -- Player rank
		PushScaleformMovieFunctionParameterInt(-1) -- Player rank colour
	end

	PopScaleformMovieFunction()

	RequestModel(PlayerCustomisation.Creator.Board.Model)

	while not HasModelLoaded(PlayerCustomisation.Creator.Board.Model) do
		Citizen.Wait(250)
	end

	PlayerCustomisation.Creator.Board.Handle = CreateObject(GetHashKey(PlayerCustomisation.Creator.Board.Model), Coordinates.x, Coordinates.y, Coordinates.z, false, false)

	AttachEntityToEntity(PlayerCustomisation.Creator.Board.Handle, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

	RequestModel(PlayerCustomisation.Creator.Board.RenderTarget.Model)

	while not HasModelLoaded(PlayerCustomisation.Creator.Board.RenderTarget.Model) do
		Citizen.Wait(250)
	end

	PlayerCustomisation.Creator.Board.RenderTarget.Handle = CreateObject(GetHashKey(PlayerCustomisation.Creator.Board.RenderTarget.Model), Coordinates.x, Coordinates.y, Coordinates.z, false, false)

	AttachEntityToEntity(PlayerCustomisation.Creator.Board.RenderTarget.Handle, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

	RequestAnimDict(PlayerCustomisation.Creator.Board.Dictionary)

	while not HasAnimDictLoaded(PlayerCustomisation.Creator.Board.Dictionary) do
		Citizen.Wait(250)
	end

	if not IsNamedRendertargetRegistered(PlayerCustomisation.Creator.Board.RenderTarget.Name) then
		RegisterNamedRendertarget(PlayerCustomisation.Creator.Board.RenderTarget.Name, 0)
	end

	if not IsNamedRendertargetLinked(GetHashKey(PlayerCustomisation.Creator.Board.RenderTarget.Model)) then
		LinkNamedRendertarget(GetHashKey(PlayerCustomisation.Creator.Board.RenderTarget.Model))
	end

	if IsNamedRendertargetRegistered(PlayerCustomisation.Creator.Board.RenderTarget.Name) then
		PlayerCustomisation.Creator.Board.RenderTarget.Id = GetNamedRendertargetRenderId(PlayerCustomisation.Creator.Board.RenderTarget.Name)
	end

	PlayerCustomisation.Creator.Exit = {x = Coordinates.x, y = Coordinates.y, z = Coordinates.z, h = GetEntityHeading(PlayerPedId())}

	PlayerCustomisation.Instanced = true
	TriggerServerEvent("PlayerCustomisation.Instance", true)

	SetEntityCoords(PlayerPedId(), PlayerCustomisation.Creator.Entry.x, PlayerCustomisation.Creator.Entry.y, PlayerCustomisation.Creator.Entry.z)
	SetEntityHeading(PlayerPedId(), PlayerCustomisation.Creator.Entry.h)
	FreezeEntityPosition(PlayerPedId(), true)

	CharacterCreatorMenu.Cameras.Face:Create()
	CharacterCreatorMenu.Cameras.Default:Create()

	CharacterCreatorMenu.Cameras.Default:Activate(false, 2000)

	if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender == "Hybrid" then
		for Index = 3, (#CharacterCreatorMenu.Items - 1) do
			CharacterCreatorMenu.Items[Index]:Enabled(false)
			CharacterCreatorMenu.Items[Index]:SetRightBadge(BadgeStyle.Lock)
		end

		CharacterCreatorMenu.Items[1]:Enabled(false)
	else
		AppearanceMenu.Items[1].Items = PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]
		ApparelMenu.Items[3].Items = PlayerCustomisation.Reference.Apparel.Hat[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]
		ApparelMenu.Items[4].Items = PlayerCustomisation.Reference.Apparel.Glasses[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender]

		HeritageMenu.Windows[1]:Index(GetPortraitFromFace("Female", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1]), GetPortraitFromFace("Male", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2]))
		HeritageMenu.Items[1]:Index(GetFaceIndex("Female", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1]))
		HeritageMenu.Items[2]:Index(GetFaceIndex("Male", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2]))
		HeritageMenu.Items[3]:Index(HeritageMenu.Items[3]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[3]))
		HeritageMenu.Items[4]:Index(HeritageMenu.Items[4]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[4]))

		FeaturesMenu.Items[1].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[8], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[7])
		FeaturesMenu.Items[2].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[12], 0.5)
		FeaturesMenu.Items[3].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[1], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[2])
		FeaturesMenu.Items[4].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[3], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[4])
		FeaturesMenu.Items[5].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[6], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[5])
		FeaturesMenu.Items[6].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[10], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[9])
		FeaturesMenu.Items[7].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[11], 0.5)
		FeaturesMenu.Items[8].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[13], 0.5)
		FeaturesMenu.Items[9].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[14], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[15])
		FeaturesMenu.Items[10].Panels[1]:CirclePosition(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[17], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[16])
		FeaturesMenu.Items[11].Panels[1]:CirclePosition(1.0 - PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[18], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[19])

		AppearanceMenu.Items[1]:Index(AppearanceMenu.Items[1]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3]))
		AppearanceMenu.Items[1].Panels[1]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1], true)
		AppearanceMenu.Items[1].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[2], true)
		AppearanceMenu.Items[2]:Index(AppearanceMenu.Items[2]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[3]))
		AppearanceMenu.Items[2].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[3])
		AppearanceMenu.Items[2].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[3], true)
		AppearanceMenu.Items[3]:Index(AppearanceMenu.Items[3]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[2]))
		AppearanceMenu.Items[3].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[2])
		AppearanceMenu.Items[3].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[2], true)
		AppearanceMenu.Items[4]:Index(AppearanceMenu.Items[4]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[1]))
		AppearanceMenu.Items[4].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[1])
		AppearanceMenu.Items[5]:Index(AppearanceMenu.Items[5]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[4]))
		AppearanceMenu.Items[5].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[4])
		AppearanceMenu.Items[6]:Index(AppearanceMenu.Items[6]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[7]))
		AppearanceMenu.Items[6].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[7])
		AppearanceMenu.Items[7]:Index(AppearanceMenu.Items[7]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[10]))
		AppearanceMenu.Items[7].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[10])
		AppearanceMenu.Items[8]:Index(AppearanceMenu.Items[8]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[8]))
		AppearanceMenu.Items[8].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[8])
		AppearanceMenu.Items[9]:Index(AppearanceMenu.Items[9]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].EyeColour))
		AppearanceMenu.Items[10]:Index(AppearanceMenu.Items[10]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[5]))
		AppearanceMenu.Items[10].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5])
		AppearanceMenu.Items[11]:Index(AppearanceMenu.Items[11]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[6]))
		AppearanceMenu.Items[11].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[6])
		AppearanceMenu.Items[11].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[6], true)
		AppearanceMenu.Items[12]:Index(AppearanceMenu.Items[12]:ItemToIndex(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[9]))
		AppearanceMenu.Items[12].Panels[1]:Percentage(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[9])
		AppearanceMenu.Items[12].Panels[2]:CurrentSelection(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[9], true)

		AppearanceMenu.Items[1].Panels[2]:Enabled(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights)

		local StyleIndex, OutfitIndex = GetOutfitIndex()

		ApparelMenu.Items[2].Items = PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][StyleIndex or 1]
		ApparelMenu.Items[1]:Index(StyleIndex or 1)
		ApparelMenu.Items[2]:Index(OutfitIndex or 1)
		ApparelMenu.Items[3]:Index(GetHatIndex() or 1)
		ApparelMenu.Items[4]:Index(GetGlassesIndex() or 1)

		for Index = 3, #CharacterCreatorMenu.Items do
			CharacterCreatorMenu.Items[Index]:Enabled(true)
			CharacterCreatorMenu.Items[Index]:SetRightBadge(BadgeStyle.None)
		end

		CharacterCreatorMenu.Items[1]:Enabled(true)

		SetupTattooMenu(TattooMenu)
		UpdateHairstylesMenu(HairstyleMenu)
	end

	SetupOutfitMenu(OutfitMenu)

	TaskPlayAnim(PlayerPedId(), PlayerCustomisation.Creator.Board.Dictionary, PlayerCustomisation.Creator.Board.Animation, 8.0, -8, -1, 1, 0, 0, 0, 0)

	RemoveMask()

	CharacterCreatorMenu:Visible(true)
end

PlayerCustomisation.Pool:RefreshIndex()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		PlayerCustomisation.Pool:ProcessMenus()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if PlayerCustomisation.Instanced then
			local PlayerPed = PlayerPedId()

			if IsDisabledControlPressed(0, 51) then
				SetEntityHeading(PlayerPed, GetEntityHeading(PlayerPed) + 2)
			end

			if IsDisabledControlPressed(0, 44) then
				SetEntityHeading(PlayerPed, GetEntityHeading(PlayerPed) - 2)
			end

			if IsEntityDead(PlayerPed) and PlayerCustomisation.Pool:IsAnyMenuOpen() then
				PlayerCustomisation.Pool:CloseAllMenus()
			end

			HideHudAndRadarThisFrame()
		end

		if PlayerCustomisation.Creator.Board.RenderTarget.Id ~= -1 and HasScaleformMovieLoaded(PlayerCustomisation.Creator.Board.Scaleform.Handle) then
			SetTextRenderId(PlayerCustomisation.Creator.Board.RenderTarget.Id)
			DrawScaleformMovie(PlayerCustomisation.Creator.Board.Scaleform.Handle, 0.405, 0.37, 0.81, 0.74, 255, 255, 255, 255)
			SetTextRenderId(1)
		end
	end
end)

Citizen.CreateThread(function()
	for Type, Locations in pairs(PlayerCustomisation.Locations) do
		for Index = 1, #Locations do
			CreateBlip(Locations[Index].Blip.Name, Locations[Index].Blip.Sprite, Locations[Index].Blip.Colour, Locations[Index].Marker.x, Locations[Index].Marker.y, Locations[Index].Marker.z)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPosition = GetEntityCoords(PlayerPedId(), false)

		if not IsEntityDead(PlayerPedId()) and not IsJailed and not exports.policejob:getIsCuffed() and not isCuffed() then
			for Index = 1, #PlayerCustomisation.Locations.Barbers do
				local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, PlayerCustomisation.Locations.Barbers[Index].Marker.x, PlayerCustomisation.Locations.Barbers[Index].Marker.y, PlayerCustomisation.Locations.Barbers[Index].Marker.z, true)
				if Distance < 20 then
					RenderMarker(25, PlayerCustomisation.Locations.Barbers[Index].Marker.x, PlayerCustomisation.Locations.Barbers[Index].Marker.y, PlayerCustomisation.Locations.Barbers[Index].Marker.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if Distance < 1.25 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to get a makeover!")
						if IsControlJustPressed(1, 51) then
							if not BarberMenu:Visible() then
								OpenBarberMenu(Index)
							else
								BarberMenu:Visible(false)
							end
						end
					elseif Distance > 1.25 then
						BarberMenu:Visible(false)
					end
				end
			end

			for Index = 1, #PlayerCustomisation.Locations.Clothing do
				local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, PlayerCustomisation.Locations.Clothing[Index].Marker.x, PlayerCustomisation.Locations.Clothing[Index].Marker.y, PlayerCustomisation.Locations.Clothing[Index].Marker.z, true)
				if Distance < 20 then
					RenderMarker(25, PlayerCustomisation.Locations.Clothing[Index].Marker.x, PlayerCustomisation.Locations.Clothing[Index].Marker.y, PlayerCustomisation.Locations.Clothing[Index].Marker.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if Distance < 1.25 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to change your clothes!")
						if IsControlJustPressed(1, 51) then
							if not ClothingMenu:Visible() then
								OpenClothingMenu(Index)
							else
								ClothingMenu:Visible(false)
							end
						end
					elseif Distance > 1.25 then
						ClothingMenu:Visible(false)
					end
				end
			end

			for Index = 1, #PlayerCustomisation.Locations.Masks do
				local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, PlayerCustomisation.Locations.Masks[Index].Marker.x, PlayerCustomisation.Locations.Masks[Index].Marker.y, PlayerCustomisation.Locations.Masks[Index].Marker.z, true)
				if Distance < 20 then
					RenderMarker(25, PlayerCustomisation.Locations.Masks[Index].Marker.x, PlayerCustomisation.Locations.Masks[Index].Marker.y, PlayerCustomisation.Locations.Masks[Index].Marker.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if Distance < 1.25 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to browse masks!")
						if IsControlJustPressed(1, 51) then
							if not MaskMenu:Visible() then
								OpenMaskMenu(Index)
							else
								MaskMenu:Visible(false)
							end
						end
					elseif Distance > 1.25 then
						MaskMenu:Visible(false)
					end
				end
			end

			for Index = 1, #PlayerCustomisation.Locations.Tattoos do
				local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, PlayerCustomisation.Locations.Tattoos[Index].Marker.x, PlayerCustomisation.Locations.Tattoos[Index].Marker.y, PlayerCustomisation.Locations.Tattoos[Index].Marker.z, true)
				if Distance < 20 then
					RenderMarker(25, PlayerCustomisation.Locations.Tattoos[Index].Marker.x, PlayerCustomisation.Locations.Tattoos[Index].Marker.y, PlayerCustomisation.Locations.Tattoos[Index].Marker.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if Distance < 1.25 then
						if IsControlJustPressed(1, 51) then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to browse tattoos!")
							if not TattooMenu:Visible() then
								OpenTattooMenu(Index)
							else
								TattooMenu:Visible(false)
							end
						end
					elseif Distance > 1.25 then
						TattooMenu:Visible(false)
					end
				end
			end

			for Index = 1, #PlayerCustomisation.Locations.Outfits do
				local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, PlayerCustomisation.Locations.Outfits[Index].Marker.x, PlayerCustomisation.Locations.Outfits[Index].Marker.y, PlayerCustomisation.Locations.Outfits[Index].Marker.z, true)
				if Distance < 20 then
					RenderMarker(25, PlayerCustomisation.Locations.Outfits[Index].Marker.x, PlayerCustomisation.Locations.Outfits[Index].Marker.y, PlayerCustomisation.Locations.Outfits[Index].Marker.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if Distance < 1.25 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to browse your outfits!")
						if IsControlJustPressed(1, 51) then
							if not OutfitMenu:Visible() then
								OpenOutfitMenu(Index)
							else
								OutfitMenu:Visible(false)
							end
						end
					elseif Distance > 1.25 then
						OutfitMenu:Visible(false)
					end
				end
			end

			for Index = 1, #PlayerCustomisation.Locations.PlasticSurgery do
				local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, PlayerCustomisation.Locations.PlasticSurgery[Index].Marker.x, PlayerCustomisation.Locations.PlasticSurgery[Index].Marker.y, PlayerCustomisation.Locations.PlasticSurgery[Index].Marker.z, true)
				if Distance < 20 then
					RenderMarker(25, PlayerCustomisation.Locations.PlasticSurgery[Index].Marker.x, PlayerCustomisation.Locations.PlasticSurgery[Index].Marker.y, PlayerCustomisation.Locations.PlasticSurgery[Index].Marker.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if Distance < 1.25 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to get plastic surgery for $"..PlayerCustomisation.PlasticSurgeryCost.."!")
						if IsControlJustPressed(1, 51) then
							TriggerServerEvent("PlayerCustomisation.PlasticSurgery")
						end
					end
				end
			end

			local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 402.76455688477, -1003.0667114258, -99.004020690918, true)
			if Distance < 20 then
				RenderMarker(25, 402.76455688477, -1003.0667114258, -99.004020690918, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if Distance < 1.25 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to exit!")
					if IsControlJustPressed(1, 51) then
						SetEntityCoords(PlayerPedId(), 318.12850952148, -599.21209716797, 43.291839599609)
						SetEntityHeading(PlayerPedId(), 344.77954101563)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		if PlayerCustomisation.Instanced then
			for Player = 0, 32 do
				if NetworkIsPlayerActive(Player) then
					local OtherPed = GetPlayerPed(Player)
					if OtherPed ~= PlayerPed then
						SetEntityLocallyInvisible(OtherPed)
						SetEntityNoCollisionEntity(PlayerPed, OtherPed, true)
					else
						SetEntityLocallyVisible(PlayerPed)
					end
				end
			end
		else
			for PlayerServerId, _ in pairs(PlayerCustomisation.InstancedPlayers) do
				local Player = GetPlayerFromServerId(PlayerServerId)
				if NetworkIsPlayerActive(Player) then
					local OtherPed = GetPlayerPed(Player)
					if OtherPed ~= PlayerPed then
						SetEntityLocallyInvisible(OtherPed)
						SetEntityNoCollisionEntity(PlayerPed, OtherPed, true)
					else
						SetEntityLocallyVisible(PlayerPed)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("PlayerCustomisation.ModelType")
AddEventHandler("PlayerCustomisation.ModelType", function(Type, Coordinates, Name, CharacterId, Gender)
	if PlayerCustomisation.PlayerData.Types[Type] then
		PlayerCustomisation.PlayerData.Type = Type

		UpdateModel(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model)

		if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender ~= "Hybrid" then
			SetupTattooMenu(TattooMenu)
			UpdateHairstylesMenu(HairstyleMenu)
		end

		SetupOutfitMenu(OutfitMenu)
		UpdateModelMenu(ModelMenu)

		UpdatePlayer()

		if not PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Creator then
			OpenCharacterCreatorMenu(Coordinates, Name, CharacterId, Gender)
		else
			TriggerServerEvent("PlayerCustomisation.ModelLoaded", PlayerCustomisation.PlayerData.Type)
		end
	end
end)

RegisterNetEvent("PlayerCustomisation.Sync")
AddEventHandler("PlayerCustomisation.Sync", function(InstancedPlayers)
	PlayerCustomisation.InstancedPlayers = InstancedPlayers
end)

RegisterNetEvent("PlayerCustomisation.Sync.PlayerData")
AddEventHandler("PlayerCustomisation.Sync.PlayerData", function(PlayerData, Type)
	PlayerCustomisation.PlayerData = PlayerData

	if Type then
		TriggerServerEvent("PlayerCustomisation.ModelType", Type)
	end
end)

RegisterNetEvent("PlayerCustomisation.OpenCreator")
AddEventHandler("PlayerCustomisation.OpenCreator", function(Coordinates, Name, CharacterId, Gender)
	OpenCharacterCreatorMenu(Coordinates, Name, CharacterId, Gender)
end)
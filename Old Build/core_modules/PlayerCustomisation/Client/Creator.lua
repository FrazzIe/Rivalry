CharacterCreatorMenu = NativeUI.CreateMenu("Character Creator", "", 0, 0)

CharacterCreatorMenu.Settings.MouseEdgeEnabled = false
CharacterCreatorMenu.Controls.Back.Enabled = false

CharacterCreatorMenu:RemoveEnabledControl(0, 31)
CharacterCreatorMenu:RemoveEnabledControl(0, 30)
CharacterCreatorMenu:RemoveEnabledControl(0, 22)

CharacterCreatorMenu.Cameras = {
	Default = Camera.New(402.85162353516, -999.0, -98.7002119873047),
	Face = Camera.New(402.85162353516, -997.2, -98.4002119873047),
}

CharacterCreatorMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
CharacterCreatorMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

function SetupGenderOption(ParentMenu)
	local ItemGenderList = NativeUI.CreateListItem("Sex", {{Name = "Male", Value = "mp_m_freemode_01"}, {Name = "Female", Value = "mp_f_freemode_01"}, "Hybrid"}, 1, "Select the gender of your Character.")

	ParentMenu:AddItem(ItemGenderList)

	return ItemGenderList
end

function SetupHeritageMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Heritage", "Select to choose your parents.", true)
	local Window = NativeUI.CreateHeritageWindow(0, 19)
	local ItemMumList = NativeUI.CreateListItem("Mum", PlayerCustomisation.Reference.Heritage.Female, 1, "Select your Mum.")
	local ItemDadList = NativeUI.CreateListItem("Dad", PlayerCustomisation.Reference.Heritage.Male, 1, "Select your Dad.")
	local ItemResemblanceSlider = NativeUI.CreateSliderItem("Resemblance", PlayerCustomisation.Reference.RangeTable, math.round(#PlayerCustomisation.Reference.RangeTable / 2), "Select if your features are influenced more by your Mother or Father.", true)
	local ItemSkinToneSlider = NativeUI.CreateSliderItem("Skin Tone", PlayerCustomisation.Reference.RangeTable, math.round(#PlayerCustomisation.Reference.RangeTable / 2), "Select if your skin tone is influenced more by your Mother or Father.", true)

	ItemMumList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[1] = ActiveItem.Value.Face
		Window:Index(ActiveItem.Value.Portrait, nil)
		UpdatePlayer()
		RemoveMask()
	end
	ItemDadList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[2] = ActiveItem.Value.Face
		Window:Index(nil, ActiveItem.Value.Portrait)
		UpdatePlayer()
		RemoveMask()
	end
	ItemResemblanceSlider.OnSliderChanged = function(ParentMenu, SliderItem, Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[3] = SliderItem:IndexToItem(Index)
		UpdatePlayer()
		RemoveMask()
	end
	ItemSkinToneSlider.OnSliderChanged = function(ParentMenu, SliderItem, Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HeadBlend[4] = SliderItem:IndexToItem(Index)
		UpdatePlayer()
		RemoveMask()
	end

	Menu.Pagination.Total = 7
	Menu.Settings.MouseEdgeEnabled = false
	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	Menu:AddWindow(Window)
	Menu:AddItem(ItemMumList)
	Menu:AddItem(ItemDadList)
	Menu:AddItem(ItemResemblanceSlider)
	Menu:AddItem(ItemSkinToneSlider)

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.OnMenuClosed = function(ParentMenu)
		CharacterCreatorMenu.Cameras.Default:Switch(CharacterCreatorMenu.Cameras.Face.Handle, 1000, false, false)
	end

	return Menu
end

function SetupFeaturesMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Features", "Select to alter your facial Features", true)
	local ItemBrowList = NativeUI.CreateListItem("Brow", PlayerCustomisation.Reference.Features.Brow, 1, "Make changes your physical Features.")
	local ItemEyesList = NativeUI.CreateListItem("Eyes", PlayerCustomisation.Reference.Features.Eyes, 1, "Make changes your physical Features.")
	local ItemNoseList = NativeUI.CreateListItem("Nose", PlayerCustomisation.Reference.Features.Nose, 1, "Make changes your physical Features.")
	local ItemNoseProfileList = NativeUI.CreateListItem("Nose Profile", PlayerCustomisation.Reference.Features.NoseProfile, 1, "Make changes your physical Features.")
	local ItemNoseTipList = NativeUI.CreateListItem("Nose Tip", PlayerCustomisation.Reference.Features.NoseTip, 1, "Make changes your physical Features.")
	local ItemCheekbonesList = NativeUI.CreateListItem("Cheekbones", PlayerCustomisation.Reference.Features.Cheekbones, 1, "Make changes your physical Features.")
	local ItemCheeksList = NativeUI.CreateListItem("Cheeks", PlayerCustomisation.Reference.Features.Cheeks, 1, "Make changes your physical Features.")
	local ItemLipsList = NativeUI.CreateListItem("Lips", PlayerCustomisation.Reference.Features.Lips, 1, "Make changes your physical Features.")
	local ItemJawList = NativeUI.CreateListItem("Jaw", PlayerCustomisation.Reference.Features.Jaw, 1, "Make changes your physical Features.")
	local ItemChinProfileList = NativeUI.CreateListItem("Chin Profile", PlayerCustomisation.Reference.Features.ChinProfile, 1, "Make changes your physical Features.")
	local ItemChinShapeList = NativeUI.CreateListItem("Chin Shape", PlayerCustomisation.Reference.Features.ChinShape, 1, "Make changes your physical Features.")

	ItemBrowList:AddPanel(NativeUI.CreateGridPanel("Up", "In", "Out", "Down"))
	ItemEyesList:AddPanel(NativeUI.CreateGridPanel("", "Squint", "Wide", ""))
	ItemNoseList:AddPanel(NativeUI.CreateGridPanel("Up", "Narrow", "Wide", "Down"))
	ItemNoseProfileList:AddPanel(NativeUI.CreateGridPanel("Crooked", "Short", "Long", "Curved"))
	ItemNoseTipList:AddPanel(NativeUI.CreateGridPanel("Tip Up", "Broken Left", "Broken Right", "Tip Down"))
	ItemCheekbonesList:AddPanel(NativeUI.CreateGridPanel("Up", "In", "Out", "Down"))
	ItemCheeksList:AddPanel(NativeUI.CreateGridPanel("", "Gaunt", "Puffed", ""))
	ItemLipsList:AddPanel(NativeUI.CreateGridPanel("", "Thin", "Fat", ""))
	ItemJawList:AddPanel(NativeUI.CreateGridPanel("Round", "Narrow", "Wide", "Square"))
	ItemChinProfileList:AddPanel(NativeUI.CreateGridPanel("Up", "In", "Out", "Down"))
	ItemChinShapeList:AddPanel(NativeUI.CreateGridPanel("Rounded", "Square", "Pointed", "Bum"))

	ItemBrowList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[8] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[7] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y)

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end
	ItemEyesList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[12] = ((ActiveItem.Panel == true) and (1.0 - ActiveItem.Value[1].X) or (1.0 - ActiveItem.Value.X))

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end
	ItemNoseList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[1] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[2] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y)

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end
	ItemNoseProfileList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[3] = ((ActiveItem.Panel == true) and (1.0 - ActiveItem.Value[1].X) or (1.0 - ActiveItem.Value.X))
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[4] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y)

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end
	ItemNoseTipList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[6] = ((ActiveItem.Panel == true) and (1.0 - ActiveItem.Value[1].X) or (1.0 - ActiveItem.Value.X))
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[5] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y)

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end
	ItemCheekbonesList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[10] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[9] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y)

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end
	ItemCheeksList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[11] = ((ActiveItem.Panel == true) and (1.0 - ActiveItem.Value[1].X) or ActiveItem.Value.X)

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end
	ItemLipsList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[13] = ((ActiveItem.Panel == true) and (1.0 - ActiveItem.Value[1].X) or (1.0 - ActiveItem.Value.X))

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end
	ItemJawList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[14] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[15] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y)

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end
	ItemChinProfileList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[17] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[16] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y)

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end
	ItemChinShapeList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[18] = ((ActiveItem.Panel == true) and (1.0 - ActiveItem.Value[1].X) or (1.0 - ActiveItem.Value.X))
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].FacialFeature[19] = ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y)

		UpdatePlayer()
		RemoveMask()

		if not ActiveItem.Panel then
			ListItem.Panels[1]:CirclePosition(((ActiveItem.Panel == true) and ActiveItem.Value[1].X or ActiveItem.Value.X), ((ActiveItem.Panel == true) and ActiveItem.Value[1].Y or ActiveItem.Value.Y))
		else
			local ResultX, ResultY = ListItem.Panels[1]:CirclePosition()
			if ResultX ~= ((ActiveItem.Value[1].X / 2) + 0.5) or ResultY ~= ((ActiveItem.Value[1].Y / 2) + 0.5) then
				ListItem.Panels[1]:CirclePosition(((ActiveItem.Value[1].X / 2) + 0.5), ((ActiveItem.Value[1].Y / 2) + 0.5))
			end
		end
	end

	Menu.Pagination.Total = 7
	Menu.Settings.MouseEdgeEnabled = false
	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)
	
	Menu:AddItem(ItemBrowList)
	Menu:AddItem(ItemEyesList)
	Menu:AddItem(ItemNoseList)
	Menu:AddItem(ItemNoseProfileList)
	Menu:AddItem(ItemNoseTipList)
	Menu:AddItem(ItemCheekbonesList)
	Menu:AddItem(ItemCheeksList)
	Menu:AddItem(ItemLipsList)
	Menu:AddItem(ItemJawList)
	Menu:AddItem(ItemChinProfileList)
	Menu:AddItem(ItemChinShapeList)

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.OnMenuClosed = function(ParentMenu)
		CharacterCreatorMenu.Cameras.Default:Switch(CharacterCreatorMenu.Cameras.Face.Handle, 1000, false, false)
	end

	return Menu
end

function SetupAppearanceMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Appearance", "Select to to change your Appearance.", true)
	local ItemHairList = NativeUI.CreateListItem("Hair", PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender], 1, "Make changes your Appearance.")
	local ItemEyebrowsList = NativeUI.CreateListItem("Eyebrows", PlayerCustomisation.Reference.Appearance.Eyebrows, 1, "Make changes your Appearance.")
	local ItemFacialHairList = NativeUI.CreateListItem("Facial Hair", PlayerCustomisation.Reference.Appearance.Beards, 1, "Make changes your Appearance.")
	local ItemSkinBlemishesList = NativeUI.CreateListItem("Skin Blemishes", PlayerCustomisation.Reference.Appearance.Blemishes, 1, "Make changes your Appearance.")
	local ItemSkinAgingList = NativeUI.CreateListItem("Skin Aging", PlayerCustomisation.Reference.Appearance.SkinAging, 1, "Make changes your Appearance.")
	local ItemSkinComplexionList = NativeUI.CreateListItem("Skin Complexion", PlayerCustomisation.Reference.Appearance.SkinComplexion, 1, "Make changes your Appearance.")
	local ItemMolesFrecklesList = NativeUI.CreateListItem("Moles & Freckles", PlayerCustomisation.Reference.Appearance.MolesFreckles, 1, "Make changes your Appearance.")
	local ItemSkinDamageList = NativeUI.CreateListItem("Skin Damage", PlayerCustomisation.Reference.Appearance.SkinDamage, 1, "Make changes your Appearance.")
	local ItemEyeColourList = NativeUI.CreateListItem("Eye Colour", PlayerCustomisation.Reference.Appearance.Eyes, 1, "Make changes your Appearance.")
	local ItemEyeMakeupList = NativeUI.CreateListItem("Eye Makeup", PlayerCustomisation.Reference.Appearance.EyeMakeup, 1, "Make changes your Appearance.")
	local ItemBlusherList = NativeUI.CreateListItem("Blusher", PlayerCustomisation.Reference.Appearance.Blush, 1, "Make changes your Appearance.")
	local ItemLipstickList = NativeUI.CreateListItem("Lipstick", PlayerCustomisation.Reference.Appearance.Lipstick, 1, "Make changes your Appearance.")

	local ItemHairColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Hair)
	local ItemHairHighlightColourPanel = NativeUI.CreateColourPanel("Highlight", PlayerCustomisation.Reference.Colours.Hair)
	local ItemEyebrowsPercentagePanel = NativeUI.CreatePercentagePanel()
	local ItemEyebrowsColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Hair)
	local ItemFacialHairPercentagePanel = NativeUI.CreatePercentagePanel()
	local ItemFacialHairColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Hair)
	local ItemSkinBlemishesPercentagePanel = NativeUI.CreatePercentagePanel()
	local ItemSkinAgingPercentagePanel = NativeUI.CreatePercentagePanel()
	local ItemSkinComplexionPercentagePanel = NativeUI.CreatePercentagePanel()
	local ItemMolesFrecklesPercentagePanel = NativeUI.CreatePercentagePanel()
	local ItemSkinDamagePercentagePanel = NativeUI.CreatePercentagePanel()
	local ItemEyeMakeupPercentagePanel = NativeUI.CreatePercentagePanel()
	local ItemBlusherPercentagePanel = NativeUI.CreatePercentagePanel()
	local ItemBlusherColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Lipstick)
	local ItemLipstickPercentagePanel = NativeUI.CreatePercentagePanel()
	local ItemLipstickColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Lipstick)

	ItemHairList:AddPanel(ItemHairColourPanel)
	ItemHairList:AddPanel(ItemHairHighlightColourPanel)
	ItemEyebrowsList:AddPanel(ItemEyebrowsPercentagePanel)
	ItemEyebrowsList:AddPanel(ItemEyebrowsColourPanel)
	ItemFacialHairList:AddPanel(ItemFacialHairPercentagePanel)
	ItemFacialHairList:AddPanel(ItemFacialHairColourPanel)
	ItemSkinBlemishesList:AddPanel(ItemSkinBlemishesPercentagePanel)
	ItemSkinAgingList:AddPanel(ItemSkinAgingPercentagePanel)
	ItemSkinComplexionList:AddPanel(ItemSkinComplexionPercentagePanel)
	ItemMolesFrecklesList:AddPanel(ItemMolesFrecklesPercentagePanel)
	ItemSkinDamageList:AddPanel(ItemSkinDamagePercentagePanel)
	ItemEyeMakeupList:AddPanel(ItemEyeMakeupPercentagePanel)
	ItemBlusherList:AddPanel(ItemBlusherPercentagePanel)
	ItemBlusherList:AddPanel(ItemBlusherColourPanel)
	ItemLipstickList:AddPanel(ItemLipstickPercentagePanel)
	ItemLipstickList:AddPanel(ItemLipstickColourPanel)

	ItemHairHighlightColourPanel:Enabled(false)
	ItemEyebrowsPercentagePanel:Enabled(false)
	ItemEyebrowsColourPanel:Enabled(false)
	ItemFacialHairPercentagePanel:Enabled(false)
	ItemFacialHairColourPanel:Enabled(false)
	ItemSkinBlemishesPercentagePanel:Enabled(false)
	ItemSkinAgingPercentagePanel:Enabled(false)
	ItemMolesFrecklesPercentagePanel:Enabled(false)
	ItemSkinComplexionPercentagePanel:Enabled(false)
	ItemSkinDamagePercentagePanel:Enabled(false)
	ItemEyeMakeupPercentagePanel:Enabled(false)
	ItemBlusherPercentagePanel:Enabled(false)
	ItemBlusherColourPanel:Enabled(false)
	ItemLipstickPercentagePanel:Enabled(false)
	ItemLipstickColourPanel:Enabled(false)

	ItemHairList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3] = ActiveItem.Value
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1) - 1
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[2] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end
	ItemEyebrowsList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if Index == 1 then
			ItemEyebrowsPercentagePanel:Enabled(false)
			ItemEyebrowsColourPanel:Enabled(false)
		else
			ItemEyebrowsPercentagePanel:Enabled(true)
			ItemEyebrowsColourPanel:Enabled(true)		
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[3] = ActiveItem.Value or 255
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[3] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1.0)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[3] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end
	ItemFacialHairList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if Index == 1 then
			ItemFacialHairPercentagePanel:Enabled(false)
			ItemFacialHairColourPanel:Enabled(false)
		else
			ItemFacialHairPercentagePanel:Enabled(true)
			ItemFacialHairColourPanel:Enabled(true)		
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[2] = ActiveItem.Value or 255
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[2] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1.0)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[2] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end
	ItemSkinBlemishesList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if Index == 1 then
			ItemSkinBlemishesPercentagePanel:Enabled(false)
		else
			ItemSkinBlemishesPercentagePanel:Enabled(true)
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[1] = ActiveItem.Value or 255
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[1] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1.0)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[1] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end
	ItemSkinAgingList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if Index == 1 then
			ItemSkinAgingPercentagePanel:Enabled(false)
		else
			ItemSkinAgingPercentagePanel:Enabled(true)
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[4] = ActiveItem.Value or 255
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[4] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1.0)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[4] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end
	ItemSkinComplexionList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if Index == 1 then
			ItemSkinComplexionPercentagePanel:Enabled(false)
		else
			ItemSkinComplexionPercentagePanel:Enabled(true)
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[7] = ActiveItem.Value or 255
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[7] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1.0)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[7] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end
	ItemMolesFrecklesList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if Index == 1 then
			ItemMolesFrecklesPercentagePanel:Enabled(false)
		else
			ItemMolesFrecklesPercentagePanel:Enabled(true)
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[10] = ActiveItem.Value or 255
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[10] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1.0)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[10] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end
	ItemSkinDamageList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if Index == 1 then
			ItemSkinDamagePercentagePanel:Enabled(false)
		else
			ItemSkinDamagePercentagePanel:Enabled(true)
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[8] = ActiveItem.Value or 255
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[8] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1.0)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[8] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end
	ItemEyeColourList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].EyeColour = ActiveItem.Value

		UpdatePlayer()
		RemoveMask()
	end
	ItemEyeMakeupList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if Index == 1 then
			ItemEyeMakeupPercentagePanel:Enabled(false)
		else
			ItemEyeMakeupPercentagePanel:Enabled(true)
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[5] = ActiveItem.Value or 255
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1.0)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[5] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end
	ItemBlusherList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if Index == 1 then
			ItemBlusherPercentagePanel:Enabled(false)
			ItemBlusherColourPanel:Enabled(false)
		else
			ItemBlusherPercentagePanel:Enabled(true)
			ItemBlusherColourPanel:Enabled(true)		
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[6] = ActiveItem.Value or 255
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[6] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1.0)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[6] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end
	ItemLipstickList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if Index == 1 then
			ItemLipstickPercentagePanel:Enabled(false)
			ItemLipstickColourPanel:Enabled(false)
		else
			ItemLipstickPercentagePanel:Enabled(true)
			ItemLipstickColourPanel:Enabled(true)		
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[9] = ActiveItem.Value or 255
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[9] = (ActiveItem.Panels and ActiveItem.Panels[1] or 1.0)
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[9] = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1

		UpdatePlayer()
		RemoveMask()
	end

	Menu.Pagination.Total = 7
	Menu.Settings.MouseEdgeEnabled = false
	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)
	
	Menu:AddItem(ItemHairList)
	Menu:AddItem(ItemEyebrowsList)
	Menu:AddItem(ItemFacialHairList)
	Menu:AddItem(ItemSkinBlemishesList)
	Menu:AddItem(ItemSkinAgingList)
	Menu:AddItem(ItemSkinComplexionList)
	Menu:AddItem(ItemMolesFrecklesList)
	Menu:AddItem(ItemSkinDamageList)
	Menu:AddItem(ItemEyeColourList)
	Menu:AddItem(ItemEyeMakeupList)
	Menu:AddItem(ItemBlusherList)
	Menu:AddItem(ItemLipstickList)

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 22, 0), "Toggle Highlights"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.OnMenuClosed = function(ParentMenu)
		CharacterCreatorMenu.Cameras.Default:Switch(CharacterCreatorMenu.Cameras.Face.Handle, 1000, false, false)
	end
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if IsDisabledControlJustPressed(0, 22) then
				if Menu:CurrentSelection() == 1 then
					if Menu:Visible() then
						PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights = not PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights
						ItemHairHighlightColourPanel:Enabled(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights)
						UpdatePlayer()
						RemoveMask()
					end
				end
			end
		end
	end)

	return Menu
end

function SetupApparelMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Apparel", "Select to to change your Apparel.", true)
	local ItemStyleList = NativeUI.CreateListItem("Style", PlayerCustomisation.Reference.Apparel.Styles, 1, "Make changes your Apparel.")
	local ItemOutfitList = NativeUI.CreateListItem("Outfit", PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][1], 1, "Make changes your Apparel.")
	local ItemHatList = NativeUI.CreateListItem("Hat", PlayerCustomisation.Reference.Apparel.Hat[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender], 1, "Make changes your Apparel.")
	local ItemGlassesList = NativeUI.CreateListItem("Glasses", PlayerCustomisation.Reference.Apparel.Glasses[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender], 1, "Make changes your Apparel.")

	ItemStyleList.OnListChanged = function(ParentMenu, ListItem, NewIndex)
		ItemOutfitList.Items = PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][NewIndex]
		ItemOutfitList:Index(1)

		for Index = 3, 11 do
			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index + 1] = PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][NewIndex][1].Value.Drawable[Index + 1]
			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index + 1] = PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][NewIndex][1].Value.Texture[Index + 1]
			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Palette[Index + 1] = PlayerCustomisation.Reference.Apparel.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][NewIndex][1].Value.Palette[Index + 1]
		end

		UpdatePlayer()		
	end
	ItemOutfitList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		for Index = 3, 11 do
			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index + 1] = ActiveItem.Value.Drawable[Index + 1]
			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index + 1] = ActiveItem.Value.Texture[Index + 1]
			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Palette[Index + 1] = ActiveItem.Value.Palette[Index + 1]
		end

		UpdatePlayer()
	end
	ItemHatList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if ActiveItem.Name == "Off" then
			ClearPedProp(PlayerPedId(), 0)
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[1] = ActiveItem.Value.Drawable
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[1] = ActiveItem.Value.Texture

		UpdatePlayer()
	end
	ItemGlassesList.OnListChanged = function(ParentMenu, ListItem, Index)
		local ActiveItem = ListItem:IndexToItem(Index)

		if ActiveItem.Name == "Off" then
			ClearPedProp(PlayerPedId(), 1)
		end

		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[2] = ActiveItem.Value.Drawable
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[2] = ActiveItem.Value.Texture

		UpdatePlayer()
	end

	Menu.Pagination.Total = 7
	Menu.Settings.MouseEdgeEnabled = false
	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)
	
	Menu:AddItem(ItemStyleList)
	Menu:AddItem(ItemOutfitList)
	Menu:AddItem(ItemHatList)
	Menu:AddItem(ItemGlassesList)

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	return Menu
end

function SetupSaveOption(ParentMenu)
	local ItemSaveList = NativeUI.CreateItem("Save & Continue", "Finish creating your Character.")

	ItemSaveList.Activated = function(ParentMenu, SelectedItem)
		IsStanceAllowed = true
		TriggerEvent("chat:disable", false)
		hud_off = false
		
		TriggerServerEvent("PlayerCustomisation.Instance", false)

		PlayerCustomisation.Instanced = false
		PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Creator = true

		TriggerServerEvent("PlayerCustomisation.Update", PlayerCustomisation.PlayerData.Type, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type])

		TriggerServerEvent("PlayerCustomisation.ModelLoaded", PlayerCustomisation.PlayerData.Type)
		
		CharacterCreatorMenu.Cameras.Face:Deactivate()
		CharacterCreatorMenu.Cameras.Default:Deactivate()

		CharacterCreatorMenu.Cameras.Face:Destroy()
		CharacterCreatorMenu.Cameras.Default:Destroy()

		ParentMenu:Visible(false)

		FreezeEntityPosition(PlayerPedId(), false)
		SetEntityCoords(PlayerPedId(), PlayerCustomisation.Creator.Exit.x, PlayerCustomisation.Creator.Exit.y, PlayerCustomisation.Creator.Exit.z)
		SetEntityHeading(PlayerPedId(), PlayerCustomisation.Creator.Exit.h)

		if DoesEntityExist(PlayerCustomisation.Creator.Board.Handle) then
			DetachEntity(PlayerCustomisation.Creator.Board.Handle, true, false)
			DestroyObject(PlayerCustomisation.Creator.Board.Handle)
		end

		if DoesEntityExist(PlayerCustomisation.Creator.Board.RenderTarget.Handle) then
			DetachEntity(PlayerCustomisation.Creator.Board.RenderTarget.Handle, true, false)
			DestroyObject(PlayerCustomisation.Creator.Board.RenderTarget.Handle)
		end

		if IsNamedRendertargetRegistered(PlayerCustomisation.Creator.Board.RenderTarget.Name) then
			ReleaseNamedRendertarget(PlayerCustomisation.Creator.Board.RenderTarget.Id)
		end

		PlayerCustomisation.Creator.Board.Handle = nil
		PlayerCustomisation.Creator.Board.RenderTarget.Handle = nil
		PlayerCustomisation.Creator.Board.RenderTarget.Id = -1

		ClearPedTasks()

		UpdatePlayer()
	end

	ParentMenu:AddItem(ItemSaveList)

	return ItemSaveList
end

function SetupMergeOption(ParentMenu)
	local MergeList = {}

	for Type, _ in pairs(PlayerCustomisation.PlayerData.Types) do
		table.insert(MergeList, Type)
	end

	local MergeListItem = NativeUI.CreateListItem("Merge with", MergeList, 1, "Merge your characters features (e.g. copy your off-duty face)")

	ParentMenu:AddItem(MergeListItem)

	return MergeListItem
end

function SetupModelMenu(ParentMenu)
	local Menu = NativeUI.CreateMenu("Ped Models", "Select a model", 0, 0)
	for Index = 1, #PlayerCustomisation.Reference.Models[PlayerCustomisation.PlayerData.Type] do
		local ModelItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Models[PlayerCustomisation.PlayerData.Type][Index], "Change your character to "..PlayerCustomisation.Reference.Models[PlayerCustomisation.PlayerData.Type][Index])
		ModelItem.Activated = function(ParentMenu, SelectedItem)
			UpdateModel(PlayerCustomisation.Reference.Models[PlayerCustomisation.PlayerData.Type][Index])

			AttachEntityToEntity(PlayerCustomisation.Creator.Board.Handle, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			AttachEntityToEntity(PlayerCustomisation.Creator.Board.RenderTarget.Handle, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			TaskPlayAnim(PlayerPedId(), PlayerCustomisation.Creator.Board.Dictionary, PlayerCustomisation.Creator.Board.Animation, 8.0, -8, -1, 1, 0, 0, 0, 0)
		end
		Menu:AddItem(ModelItem)
	end

	Menu.Pagination.Total = 7
	Menu.Settings.MouseEdgeEnabled = false
	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)	
	Menu.ParentMenu = ParentMenu

	return Menu
end

function UpdateModelMenu(Menu)
	Menu:Clear()

	for Index = 1, #PlayerCustomisation.Reference.Models[PlayerCustomisation.PlayerData.Type] do
		local ModelItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Models[PlayerCustomisation.PlayerData.Type][Index], "Change your character to "..PlayerCustomisation.Reference.Models[PlayerCustomisation.PlayerData.Type][Index])
		ModelItem.Activated = function(ParentMenu, SelectedItem)
			UpdateModel(PlayerCustomisation.Reference.Models[PlayerCustomisation.PlayerData.Type][Index])

			AttachEntityToEntity(PlayerCustomisation.Creator.Board.Handle, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			AttachEntityToEntity(PlayerCustomisation.Creator.Board.RenderTarget.Handle, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			TaskPlayAnim(PlayerPedId(), PlayerCustomisation.Creator.Board.Dictionary, PlayerCustomisation.Creator.Board.Animation, 8.0, -8, -1, 1, 0, 0, 0, 0)
		end
		Menu:AddItem(ModelItem)
	end

	Menu:RefreshIndex()
end
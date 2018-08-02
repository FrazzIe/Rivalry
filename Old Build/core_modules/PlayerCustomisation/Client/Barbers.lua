BarberMenu = NativeUI.CreateMenu("", "CATEGORIES", 0, 0)

BarberMenu.Settings.MouseEdgeEnabled = false

BarberMenu:RemoveEnabledControl(0, 31)
BarberMenu:RemoveEnabledControl(0, 30)
BarberMenu:RemoveEnabledControl(0, 22)

BarberMenu.Cameras = {
	Default = Camera.New(),
	Face = Camera.New(),
}

BarberMenu.OnMenuClosed = function(ParentMenu)
	IsStanceAllowed = true
	TriggerEvent("chat:disable", false)
	hud_off = false
	
	PlayerCustomisation.Instanced = false
	TriggerServerEvent("PlayerCustomisation.Instance", false)
	TriggerServerEvent("PlayerCustomisation.Update", PlayerCustomisation.PlayerData.Type, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type])

	FreezeEntityPosition(PlayerPedId(), false)

	BarberMenu.Cameras.Default:Deactivate()
	BarberMenu.Cameras.Face:Deactivate()
	BarberMenu.Cameras.Default:Destroy()
	BarberMenu.Cameras.Face:Destroy()
end

BarberMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
BarberMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

function SetupHairstylesMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Hairstyles", "", true)
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		local HairstyleItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Name, "")
		local HairstyleColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Hair)
		local HairstyleHighlightPanel = NativeUI.CreateColourPanel("Highlight", PlayerCustomisation.Reference.Colours.Hair)
		HairstyleItem:AddPanel(HairstyleColourPanel)
		HairstyleItem:AddPanel(HairstyleHighlightPanel)
		HairstyleItem.Activated = function(ParentMenu, SelectedItem)
			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3] = PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value
			
			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 0)
			RemoveMask()

			for ItemIndex = 1, #ParentMenu.Items do
				ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
			end

			SelectedItem:SetRightBadge(BadgeStyle.Barber)
		end
		HairstyleItem.ActivatedPanel = function(ParentMenu, SelectedItem, Panel, PanelValue)
			if Panel == HairstyleColourPanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1] = PanelValue - 1

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[1]:CurrentSelection(PanelValue - 1, true)
				end
			elseif Panel == HairstyleHighlightPanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[2] = PanelValue - 1

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[2]:CurrentSelection(PanelValue - 1, true)
				end
			end

			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 0)
			RemoveMask()
		end
		Menu:AddItem(HairstyleItem)
	end

	Menu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedComponentVariation(PlayerPedId(), 2, PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][NewIndex].Value, 0, 1)
	end
	Menu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	Menu.Settings.MouseEdgeEnabled = false

	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 22, 0), "Toggle Highlights"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if IsDisabledControlJustPressed(0, 22) then
				if Menu:Visible() then
					PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights = not PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights
					
					for Index = 1, #Menu.Items do
						Menu.Items[Index].Panels[2]:Enabled(PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Highlights)
					end

					UpdatePlayer()
					ClearPedProp(PlayerPedId(), 0)
					RemoveMask()
				end
			end
		end
	end)

	return Menu
end

function UpdateHairstylesMenu(Menu)
	Menu:Clear()
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender] do
		local HairstyleItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Name, "")
		local HairstyleColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Hair)
		local HairstyleHighlightPanel = NativeUI.CreateColourPanel("Highlight", PlayerCustomisation.Reference.Colours.Hair)
		HairstyleItem:AddPanel(HairstyleColourPanel)
		HairstyleItem:AddPanel(HairstyleHighlightPanel)
		HairstyleItem.Activated = function(ParentMenu, SelectedItem)
			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3] = PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index].Value
			
			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 0)
			RemoveMask()

			for ItemIndex = 1, #ParentMenu.Items do
				ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
			end

			SelectedItem:SetRightBadge(BadgeStyle.Barber)
		end
		HairstyleItem.ActivatedPanel = function(ParentMenu, SelectedItem, Panel, PanelValue)
			if Panel == HairstyleColourPanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[1] = PanelValue - 1

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[1]:CurrentSelection(PanelValue - 1, true)
				end
			elseif Panel == HairstyleHighlightPanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].HairColour[2] = PanelValue - 1

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[2]:CurrentSelection(PanelValue - 1, true)
				end
			end

			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 0)
			RemoveMask()
		end
		Menu:AddItem(HairstyleItem)
	end
	Menu:RefreshIndex()
end

function SetupBeardsMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Beards", "", true)
	for Index = 1, #PlayerCustomisation.Reference.Appearance.Beards do
		local BeardItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Appearance.Beards[Index].Name, "")
		local BeardPercentagePanel = NativeUI.CreatePercentagePanel()
		local BeardColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Hair)

		BeardItem:AddPanel(BeardPercentagePanel)
		BeardItem:AddPanel(BeardColourPanel)
		BeardItem.Activated = function(ParentMenu, SelectedItem)

			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[2] = PlayerCustomisation.Reference.Appearance.Beards[Index].Value or 255
			
			UpdatePlayer()
			RemoveMask()

			local PanelsEnabled = (Index ~= 1)

			for ItemIndex = 1, #ParentMenu.Items do
				ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
				ParentMenu.Items[ItemIndex].Panels[1]:Enabled(PanelsEnabled)
				ParentMenu.Items[ItemIndex].Panels[2]:Enabled(PanelsEnabled)
			end

			SelectedItem:SetRightBadge(BadgeStyle.Barber)
		end
		BeardItem.ActivatedPanel = function(ParentMenu, SelectedItem, Panel, PanelValue)
			if Panel == BeardPercentagePanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[2] = PanelValue or 1.0

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[1]:Percentage(PanelValue)
				end
			elseif Panel == BeardColourPanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[2] = PanelValue - 1

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[2]:CurrentSelection(PanelValue - 1, true)
				end
			end

			UpdatePlayer()
			RemoveMask()
		end

		Menu:AddItem(BeardItem)
	end

	Menu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 1, PlayerCustomisation.Reference.Appearance.Beards[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[2])
		SetPedHeadOverlayColor(PlayerPedId(), 1, GetOverlayColourType(1), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[2], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[2])
	end

	Menu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.Settings.MouseEdgeEnabled = false

	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	return Menu
end

function SetupEyebrowsMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Eyebrows", "", true)

	for Index = 1, #PlayerCustomisation.Reference.Appearance.Eyebrows do
		local EyebrowItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Appearance.Eyebrows[Index].Name, "")
		local EyebrowPercentagePanel = NativeUI.CreatePercentagePanel()
		local EyebrowColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Hair)

		EyebrowItem:AddPanel(EyebrowPercentagePanel)
		EyebrowItem:AddPanel(EyebrowColourPanel)
		EyebrowItem.Activated = function(ParentMenu, SelectedItem)

			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[3] = PlayerCustomisation.Reference.Appearance.Eyebrows[Index].Value or 255
			
			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 1)
			RemoveMask()

			local PanelsEnabled = (Index ~= 1)

			for ItemIndex = 1, #ParentMenu.Items do
				ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
				ParentMenu.Items[ItemIndex].Panels[1]:Enabled(PanelsEnabled)
				ParentMenu.Items[ItemIndex].Panels[2]:Enabled(PanelsEnabled)
			end

			SelectedItem:SetRightBadge(BadgeStyle.Barber)
		end
		EyebrowItem.ActivatedPanel = function(ParentMenu, SelectedItem, Panel, PanelValue)
			if Panel == EyebrowPercentagePanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[3] = PanelValue or 1.0

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[1]:Percentage(PanelValue)
				end
			elseif Panel == EyebrowColourPanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[3] = PanelValue - 1

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[2]:CurrentSelection(PanelValue - 1, true)
				end
			end

			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 1)
			RemoveMask()
		end

		Menu:AddItem(EyebrowItem)
	end

	Menu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 2, PlayerCustomisation.Reference.Appearance.Eyebrows[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[3])
		SetPedHeadOverlayColor(PlayerPedId(), 2, GetOverlayColourType(2), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[3], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[3])
	end
	Menu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.Settings.MouseEdgeEnabled = false

	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	return Menu
end

function SetupChestMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Chest", "", true)

	for Index = 1, #PlayerCustomisation.Reference.Appearance.Chest do
		local ChestItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Appearance.Chest[Index].Name, "")
		local ChestPercentagePanel = NativeUI.CreatePercentagePanel()
		local ChestColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Hair)

		ChestItem:AddPanel(ChestPercentagePanel)
		ChestItem:AddPanel(ChestColourPanel)
		ChestItem.Activated = function(ParentMenu, SelectedItem)

			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[11] = PlayerCustomisation.Reference.Appearance.Chest[Index].Value or 255
			
			UpdatePlayer()
			SetPedTopless()

			local PanelsEnabled = (Index ~= 1)

			for ItemIndex = 1, #ParentMenu.Items do
				ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
				ParentMenu.Items[ItemIndex].Panels[1]:Enabled(PanelsEnabled)
				ParentMenu.Items[ItemIndex].Panels[2]:Enabled(PanelsEnabled)
			end

			SelectedItem:SetRightBadge(BadgeStyle.Barber)
		end
		ChestItem.ActivatedPanel = function(ParentMenu, SelectedItem, Panel, PanelValue)
			if Panel == ChestPercentagePanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[11] = PanelValue or 1.0

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[1]:Percentage(PanelValue)
				end
			elseif Panel == ChestColourPanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[11] = PanelValue - 1

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[2]:CurrentSelection(PanelValue - 1, true)
				end
			end

			UpdatePlayer()
			SetPedTopless()
		end

		Menu:AddItem(ChestItem)
	end

	Menu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 10, PlayerCustomisation.Reference.Appearance.Chest[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[11])
		SetPedHeadOverlayColor(PlayerPedId(), 10, GetOverlayColourType(10), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[11], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[11])
	end
	Menu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()
	end

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.Settings.MouseEdgeEnabled = false

	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	return Menu
end

function SetupContactsMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Contacts", "", true)

	for Index = 1, #PlayerCustomisation.Reference.Appearance.Contacts do
		local ContactItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Appearance.Contacts[Index].Name, "")

		ContactItem.Activated = function(ParentMenu, SelectedItem)

			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].EyeColour = PlayerCustomisation.Reference.Appearance.Contacts[Index].Value or 0
			
			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 1)
			RemoveMask()

			for ItemIndex = 1, #ParentMenu.Items do
				ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
			end

			SelectedItem:SetRightBadge(BadgeStyle.Barber)
		end

		Menu:AddItem(ContactItem)
	end

	Menu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedEyeColor(PlayerPedId(), PlayerCustomisation.Reference.Appearance.Contacts[NewIndex].Value)
	end
	Menu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.Settings.MouseEdgeEnabled = false

	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	return Menu
end

function SetupFacePaintsMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Face Paints", "", true)

	for Index = 1, #PlayerCustomisation.Reference.Appearance.FacePaint do
		local FacePaintItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Appearance.FacePaint[Index].Name, "")
		local FacePaintPercentagePanel = NativeUI.CreatePercentagePanel()

		FacePaintItem:AddPanel(FacePaintPercentagePanel)

		FacePaintItem.Activated = function(ParentMenu, SelectedItem)

			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[5] = PlayerCustomisation.Reference.Appearance.FacePaint[Index].Value or 255
			
			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 1)
			RemoveMask()

			local PanelsEnabled = (Index ~= 1)

			for ItemIndex = 1, #ParentMenu.Items do
				ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
				ParentMenu.Items[ItemIndex].Panels[1]:Enabled(PanelsEnabled)
			end

			SelectedItem:SetRightBadge(BadgeStyle.Makeup)
		end
		FacePaintItem.ActivatedPanel = function(ParentMenu, SelectedItem, Panel, PanelValue)
			if Panel == FacePaintPercentagePanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5] = PanelValue or 1.0

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[1]:Percentage(PanelValue)
				end
			end

			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 1)
			RemoveMask()
		end

		Menu:AddItem(FacePaintItem)
	end

	Menu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 4, PlayerCustomisation.Reference.Appearance.FacePaint[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5])
		SetPedHeadOverlayColor(PlayerPedId(), 4, GetOverlayColourType(4), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[5], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[5])
	end
	Menu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.Settings.MouseEdgeEnabled = false

	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	return Menu
end

function SetupEyeMakeupMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Eye Makeup", "", true)

	for Index = 1, #PlayerCustomisation.Reference.Appearance.EyeMakeup do
		local EyeMakeupItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Appearance.EyeMakeup[Index].Name, "")
		local EyeMakeupPercentagePanel = NativeUI.CreatePercentagePanel()

		EyeMakeupItem:AddPanel(EyeMakeupPercentagePanel)

		EyeMakeupItem.Activated = function(ParentMenu, SelectedItem)

			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[5] = PlayerCustomisation.Reference.Appearance.EyeMakeup[Index].Value or 255
			
			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 1)
			RemoveMask()

			local PanelsEnabled = (Index ~= 1)

			for ItemIndex = 1, #ParentMenu.Items do
				ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
				ParentMenu.Items[ItemIndex].Panels[1]:Enabled(PanelsEnabled)
			end

			SelectedItem:SetRightBadge(BadgeStyle.Makeup)
		end
		EyeMakeupItem.ActivatedPanel = function(ParentMenu, SelectedItem, Panel, PanelValue)
			if Panel == EyeMakeupPercentagePanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5] = PanelValue or 1.0

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[1]:Percentage(PanelValue)
				end
			end

			UpdatePlayer()
			ClearPedProp(PlayerPedId(), 1)
			RemoveMask()
		end

		Menu:AddItem(EyeMakeupItem)
	end

	Menu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 4, PlayerCustomisation.Reference.Appearance.EyeMakeup[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5])
		SetPedHeadOverlayColor(PlayerPedId(), 4, GetOverlayColourType(4), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[5], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[5])
	end
	Menu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.Settings.MouseEdgeEnabled = false

	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	return Menu
end

function SetupBlusherMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Blusher", "", true)

	for Index = 1, #PlayerCustomisation.Reference.Appearance.Blush do
		local BlushItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Appearance.Blush[Index].Name, "")
		local BlushPercentagePanel = NativeUI.CreatePercentagePanel()
		local BlushColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Blusher)

		BlushItem:AddPanel(BlushPercentagePanel)
		BlushItem:AddPanel(BlushColourPanel)
		BlushItem.Activated = function(ParentMenu, SelectedItem)

			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[6] = PlayerCustomisation.Reference.Appearance.Blush[Index].Value or 255
			
			UpdatePlayer()
			RemoveMask()

			local PanelsEnabled = (Index ~= 1)

			for ItemIndex = 1, #ParentMenu.Items do
				ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
				ParentMenu.Items[ItemIndex].Panels[1]:Enabled(PanelsEnabled)
				ParentMenu.Items[ItemIndex].Panels[2]:Enabled(PanelsEnabled)
			end

			SelectedItem:SetRightBadge(BadgeStyle.Makeup)
		end
		BlushItem.ActivatedPanel = function(ParentMenu, SelectedItem, Panel, PanelValue)
			if Panel == BlushPercentagePanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[6] = PanelValue or 1.0

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[1]:Percentage(PanelValue)
				end
			elseif Panel == BlushColourPanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[6] = PanelValue - 1

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[2]:CurrentSelection(PanelValue - 1, true)
				end
			end

			UpdatePlayer()
			RemoveMask()
		end

		Menu:AddItem(BlushItem)
	end

	Menu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 5, PlayerCustomisation.Reference.Appearance.Blush[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[6])
		SetPedHeadOverlayColor(PlayerPedId(), 5, GetOverlayColourType(5), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[6], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[6])
	end
	Menu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.Settings.MouseEdgeEnabled = false

	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	return Menu
end

function SetupLipstickMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Lipstick", "", true)

	for Index = 1, #PlayerCustomisation.Reference.Appearance.Lipstick do
		local LipstickItem = NativeUI.CreateItem(PlayerCustomisation.Reference.Appearance.Lipstick[Index].Name, "")
		local LipstickPercentagePanel = NativeUI.CreatePercentagePanel()
		local LipstickColourPanel = NativeUI.CreateColourPanel("Colour", PlayerCustomisation.Reference.Colours.Lipstick)

		LipstickItem:AddPanel(LipstickPercentagePanel)
		LipstickItem:AddPanel(LipstickColourPanel)
		LipstickItem.Activated = function(ParentMenu, SelectedItem)

			PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Drawable[9] = PlayerCustomisation.Reference.Appearance.Lipstick[Index].Value or 255
			
			UpdatePlayer()
			RemoveMask()

			local PanelsEnabled = (Index ~= 1)

			for ItemIndex = 1, #ParentMenu.Items do
				ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
				ParentMenu.Items[ItemIndex].Panels[1]:Enabled(PanelsEnabled)
				ParentMenu.Items[ItemIndex].Panels[2]:Enabled(PanelsEnabled)
			end

			SelectedItem:SetRightBadge(BadgeStyle.Makeup)
		end
		LipstickItem.ActivatedPanel = function(ParentMenu, SelectedItem, Panel, PanelValue)
			if Panel == LipstickPercentagePanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[9] = PanelValue or 1.0

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[1]:Percentage(PanelValue)
				end
			elseif Panel == LipstickColourPanel then
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[9] = PanelValue - 1

				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex].Panels[2]:CurrentSelection(PanelValue - 1, true)
				end
			end

			UpdatePlayer()
			RemoveMask()
		end

		Menu:AddItem(LipstickItem)
	end

	Menu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 8, PlayerCustomisation.Reference.Appearance.Blush[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[9])
		SetPedHeadOverlayColor(PlayerPedId(), 8, GetOverlayColourType(8), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[9], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[9])
	end
	Menu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Menu.Settings.MouseEdgeEnabled = false

	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	return Menu
end

function SetupMakeupMenu(ParentMenu)
	local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, "Makeup", "", true)

	Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})
	
	Menu.Settings.MouseEdgeEnabled = false
	
	Menu:RemoveEnabledControl(0, 31)
	Menu:RemoveEnabledControl(0, 30)
	Menu:RemoveEnabledControl(0, 22)

	return Menu
end
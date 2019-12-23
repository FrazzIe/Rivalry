local BarbersMenuActive = false

function CreateBarberMenu()
	PlayerCustomisation.Pool = NativeUI.CreatePool()

	BarbersMenuActive = true

	local BarberMenu = NativeUI.CreateMenu("", "CATEGORIES", 0, 0)

	BarberMenu.Settings.MouseEdgeEnabled = false

	BarberMenu:RemoveEnabledControl(0, 31)
	BarberMenu:RemoveEnabledControl(0, 30)
	BarberMenu:RemoveEnabledControl(0, 22)

	BarberMenu.Cameras = {
		Default = Camera.New(),
		Face = Camera.New(),
	}

	BarberMenu.OnMenuClosed = function(ParentMenu)
		exports["core_modules"]:StanceAllowed(true)
		exports["core_modules"]:TurnOffHudElements(false)
		TriggerEvent("chat:disable", false)
		
		PlayerCustomisation.Instanced = false
		TriggerServerEvent("PlayerCustomisation.Instance", false)
		TriggerServerEvent("PlayerCustomisation.Update", PlayerCustomisation.PlayerData.Type, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type])

		FreezeEntityPosition(PlayerPedId(), false)

		BarberMenu.Cameras.Default:Deactivate()
		BarberMenu.Cameras.Face:Deactivate()
		BarberMenu.Cameras.Default:Destroy()
		BarberMenu.Cameras.Face:Destroy()

		BarbersMenuActive = false

		PlayerCustomisation.Pool:Remove()

		collectgarbage()
	end

	BarberMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	BarberMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	local HairstyleMenu = PlayerCustomisation.Pool:AddSubMenu(BarberMenu, "Hairstyles", "", true)

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
		HairstyleMenu:AddItem(HairstyleItem)
	end

	HairstyleMenu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedComponentVariation(PlayerPedId(), 2, PlayerCustomisation.Reference.Appearance.Hairstyles[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][NewIndex].Value, 0, 1)
	end
	HairstyleMenu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	HairstyleMenu.Settings.MouseEdgeEnabled = false

	HairstyleMenu:RemoveEnabledControl(0, 31)
	HairstyleMenu:RemoveEnabledControl(0, 30)
	HairstyleMenu:RemoveEnabledControl(0, 22)

	HairstyleMenu:AddInstructionButton({GetControlInstructionalButton(0, 22, 0), "Toggle Highlights"})
	HairstyleMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	HairstyleMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	Citizen.CreateThread(function()
		while BarbersMenuActive do
			Citizen.Wait(0)
			if IsDisabledControlJustPressed(0, 22) then
				if HairstyleMenu:Visible() then
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

	local BeardMenu = PlayerCustomisation.Pool:AddSubMenu(BarberMenu, "Beards", "", true)

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

		BeardMenu:AddItem(BeardItem)
	end

	BeardMenu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 1, PlayerCustomisation.Reference.Appearance.Beards[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[2])
		SetPedHeadOverlayColor(PlayerPedId(), 1, GetOverlayColourType(1), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[2], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[2])
	end

	BeardMenu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	BeardMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	BeardMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	BeardMenu.Settings.MouseEdgeEnabled = false

	BeardMenu:RemoveEnabledControl(0, 31)
	BeardMenu:RemoveEnabledControl(0, 30)
	BeardMenu:RemoveEnabledControl(0, 22)

	local EyebrowMenu = PlayerCustomisation.Pool:AddSubMenu(BarberMenu, "Eyebrows", "", true)

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

		EyebrowMenu:AddItem(EyebrowItem)
	end

	EyebrowMenu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 2, PlayerCustomisation.Reference.Appearance.Eyebrows[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[3])
		SetPedHeadOverlayColor(PlayerPedId(), 2, GetOverlayColourType(2), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[3], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[3])
	end
	
	EyebrowMenu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	EyebrowMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	EyebrowMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	EyebrowMenu.Settings.MouseEdgeEnabled = false

	EyebrowMenu:RemoveEnabledControl(0, 31)
	EyebrowMenu:RemoveEnabledControl(0, 30)
	EyebrowMenu:RemoveEnabledControl(0, 22)

	local ChestMenu = PlayerCustomisation.Pool:AddSubMenu(BarberMenu, "Chest", "", true)

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

		ChestMenu:AddItem(ChestItem)
	end

	ChestMenu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 10, PlayerCustomisation.Reference.Appearance.Chest[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[11])
		SetPedHeadOverlayColor(PlayerPedId(), 10, GetOverlayColourType(10), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[11], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[11])
	end
	ChestMenu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()
	end

	ChestMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	ChestMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	ChestMenu.Settings.MouseEdgeEnabled = false

	ChestMenu:RemoveEnabledControl(0, 31)
	ChestMenu:RemoveEnabledControl(0, 30)
	ChestMenu:RemoveEnabledControl(0, 22)

	local ContactMenu = PlayerCustomisation.Pool:AddSubMenu(BarberMenu, "Contacts", "", true)

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

		ContactMenu:AddItem(ContactItem)
	end

	ContactMenu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedEyeColor(PlayerPedId(), PlayerCustomisation.Reference.Appearance.Contacts[NewIndex].Value)
	end
	ContactMenu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	ContactMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	ContactMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	ContactMenu.Settings.MouseEdgeEnabled = false

	ContactMenu:RemoveEnabledControl(0, 31)
	ContactMenu:RemoveEnabledControl(0, 30)
	ContactMenu:RemoveEnabledControl(0, 22)

	local FacePaintMenu = PlayerCustomisation.Pool:AddSubMenu(BarberMenu, "Face Paints", "", true)

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

		FacePaintMenu:AddItem(FacePaintItem)
	end

	FacePaintMenu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 4, PlayerCustomisation.Reference.Appearance.FacePaint[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5])
		SetPedHeadOverlayColor(PlayerPedId(), 4, GetOverlayColourType(4), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[5], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[5])
	end
	FacePaintMenu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	FacePaintMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	FacePaintMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	FacePaintMenu.Settings.MouseEdgeEnabled = false

	FacePaintMenu:RemoveEnabledControl(0, 31)
	FacePaintMenu:RemoveEnabledControl(0, 30)
	FacePaintMenu:RemoveEnabledControl(0, 22)

	local MakeupMenu = PlayerCustomisation.Pool:AddSubMenu(BarberMenu, "Makeup", "", true)

	MakeupMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	MakeupMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})
	
	MakeupMenu.Settings.MouseEdgeEnabled = false
	
	MakeupMenu:RemoveEnabledControl(0, 31)
	MakeupMenu:RemoveEnabledControl(0, 30)
	MakeupMenu:RemoveEnabledControl(0, 22)

	local EyeMakeupMenu = PlayerCustomisation.Pool:AddSubMenu(MakeupMenu, "Eye Makeup", "", true)

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

		EyeMakeupMenu:AddItem(EyeMakeupItem)
	end

	EyeMakeupMenu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 4, PlayerCustomisation.Reference.Appearance.EyeMakeup[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[5])
		SetPedHeadOverlayColor(PlayerPedId(), 4, GetOverlayColourType(4), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[5], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[5])
	end
	EyeMakeupMenu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	EyeMakeupMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	EyeMakeupMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	EyeMakeupMenu.Settings.MouseEdgeEnabled = false

	EyeMakeupMenu:RemoveEnabledControl(0, 31)
	EyeMakeupMenu:RemoveEnabledControl(0, 30)
	EyeMakeupMenu:RemoveEnabledControl(0, 22)

	local BlusherMenu = PlayerCustomisation.Pool:AddSubMenu(MakeupMenu, "Blusher", "", true)

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

		BlusherMenu:AddItem(BlushItem)
	end

	BlusherMenu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 5, PlayerCustomisation.Reference.Appearance.Blush[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[6])
		SetPedHeadOverlayColor(PlayerPedId(), 5, GetOverlayColourType(5), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[6], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[6])
	end
	BlusherMenu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	BlusherMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	BlusherMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	BlusherMenu.Settings.MouseEdgeEnabled = false

	BlusherMenu:RemoveEnabledControl(0, 31)
	BlusherMenu:RemoveEnabledControl(0, 30)
	BlusherMenu:RemoveEnabledControl(0, 22)

	local LipstickMenu = PlayerCustomisation.Pool:AddSubMenu(MakeupMenu, "Lipstick", "", true)

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

		LipstickMenu:AddItem(LipstickItem)
	end

	LipstickMenu.OnIndexChange = function(ParentMenu, NewIndex)
		SetPedHeadOverlay(PlayerPedId(), 8, PlayerCustomisation.Reference.Appearance.Blush[NewIndex].Value, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Opacity[9])
		SetPedHeadOverlayColor(PlayerPedId(), 8, GetOverlayColourType(8), PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[9], PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Overlay.Colours[9])
	end

	LipstickMenu.OnMenuClosed = function(ParentMenu)
		UpdatePlayer()

		BarberMenu.Cameras.Default:Switch(BarberMenu.Cameras.Face.Handle, 1000, false, false)
	end

	LipstickMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	LipstickMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	LipstickMenu.Settings.MouseEdgeEnabled = false

	LipstickMenu:RemoveEnabledControl(0, 31)
	LipstickMenu:RemoveEnabledControl(0, 30)
	LipstickMenu:RemoveEnabledControl(0, 22)

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

	PlayerCustomisation.Pool:Add(BarberMenu)
	PlayerCustomisation.Pool:RefreshIndex()

	return BarberMenu, HairstyleMenu, BeardMenu, EyebrowMenu, ChestMenu, ContactMenu, FacePaintMenu, MakeupMenu, EyeMakeupMenu, BlusherMenu, LipstickMenu
end
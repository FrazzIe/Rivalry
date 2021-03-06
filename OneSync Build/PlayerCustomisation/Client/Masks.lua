function CreateMaskMenu()
	PlayerCustomisation.Pool = NativeUI.CreatePool()
	
	local MaskMenu = NativeUI.CreateMenu("", "MASKS", 0, 0)

	MaskMenu.Settings.MouseEdgeEnabled = false

	MaskMenu:RemoveEnabledControl(0, 31)
	MaskMenu:RemoveEnabledControl(0, 30)
	MaskMenu:RemoveEnabledControl(0, 22)

	MaskMenu.Cameras = {
		Default = Camera.New(),
	}

	MaskMenu.OnMenuClosed = function(ParentMenu)
		exports["core_modules"]:StanceAllowed(true)
		exports["core_modules"]:TurnOffHudElements(false)
		TriggerEvent("chat:disable", false)
		
		PlayerCustomisation.Instanced = false
		TriggerServerEvent("PlayerCustomisation.Instance", false)
		TriggerServerEvent("PlayerCustomisation.Update", PlayerCustomisation.PlayerData.Type, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type])

		FreezeEntityPosition(PlayerPedId(), false)

		MaskMenu.Cameras.Default:Deactivate()
		MaskMenu.Cameras.Default:Destroy()

		PlayerCustomisation.Pool:Remove()

		collectgarbage()
	end

	MaskMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	MaskMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

	for Index = 1, #PlayerCustomisation.Reference.Masks.Categories do
		local Menu = PlayerCustomisation.Pool:AddSubMenu(MaskMenu, PlayerCustomisation.Reference.Masks.Categories[Index], "", true)
		for Mask = 1, #PlayerCustomisation.Reference.Masks.List[Index] do
			local Item = NativeUI.CreateItem(PlayerCustomisation.Reference.Masks.List[Index][Mask].Name, "")
			Item.Activated = function(ParentMenu, SelectedItem)
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[2] = PlayerCustomisation.Reference.Masks.List[Index][Mask].Value.Drawable
				PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[2] = PlayerCustomisation.Reference.Masks.List[Index][Mask].Value.Texture
				
				for MenuItems = 1, #ParentMenu.ParentMenu.Items do
					local Submenu = ParentMenu.ParentMenu.Children[ParentMenu.ParentMenu.Items[MenuItems]]
					if Submenu then
						for ItemIndex = 1, #Submenu.Items do
							Submenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
						end
					end
				end

				if PlayerCustomisation.Reference.Masks.List[Index][Mask].Value.Drawable == 0 and PlayerCustomisation.Reference.Masks.List[Index][Mask].Value.Texture == 0 then
					for MenuItems = 1, #ParentMenu.ParentMenu.Items do
						local Submenu = ParentMenu.ParentMenu.Children[ParentMenu.ParentMenu.Items[MenuItems]]
						if Submenu then
							Submenu.Items[1]:SetRightBadge(BadgeStyle.Clothes)
						end
					end
				else
					SelectedItem:SetRightBadge(BadgeStyle.Clothes)
				end

				UpdatePlayer()
			end

			Menu:AddItem(Item)
		end

		Menu.OnIndexChange = function(ParentMenu, NewIndex)
			SetPedComponentVariation(PlayerPedId(), 1, PlayerCustomisation.Reference.Masks.List[Index][NewIndex].Value.Drawable, PlayerCustomisation.Reference.Masks.List[Index][NewIndex].Value.Texture, 1)
		end

		Menu.OnMenuClosed = function(ParentMenu)
			UpdatePlayer()
		end

		Menu.Settings.MouseEdgeEnabled = false
		
		Menu:RemoveEnabledControl(0, 31)
		Menu:RemoveEnabledControl(0, 30)
		Menu:RemoveEnabledControl(0, 22)

		Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
		Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})
	end

	PlayerCustomisation.Pool:Add(MaskMenu)
	PlayerCustomisation.Pool:RefreshIndex()

	return MaskMenu
end
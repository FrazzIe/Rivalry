TattooMenu = NativeUI.CreateMenu("", "BODY PARTS", 0, 0)

TattooMenu.Settings.MouseEdgeEnabled = false

TattooMenu:RemoveEnabledControl(0, 31)
TattooMenu:RemoveEnabledControl(0, 30)
TattooMenu:RemoveEnabledControl(0, 22)

TattooMenu.Cameras = {
	Default = Camera.New(),
	Face = Camera.New(),
	Legs = Camera.New(),
}

TattooMenu.OnMenuClosed = function(ParentMenu)
	UpdatePlayer()

	IsStanceAllowed = true
	TriggerEvent("chat:disable", false)
	hud_off = false
	
	PlayerCustomisation.Instanced = false
	TriggerServerEvent("PlayerCustomisation.Instance", false)
	TriggerServerEvent("PlayerCustomisation.Update", PlayerCustomisation.PlayerData.Type, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type])

	FreezeEntityPosition(PlayerPedId(), false)

	TattooMenu.Cameras.Default:Deactivate()
	TattooMenu.Cameras.Face:Deactivate()
	TattooMenu.Cameras.Legs:Deactivate()

	TattooMenu.Cameras.Default:Destroy()
	TattooMenu.Cameras.Face:Destroy()
	TattooMenu.Cameras.Legs:Destroy()
end

function SetupTattooMenu(ParentMenu)
	ParentMenu:Clear()
	for Index = 1, #PlayerCustomisation.Reference.Tattoos.Categories do
		local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, PlayerCustomisation.Reference.Tattoos.Categories[Index], "", true)
		Menu.Subtitle.Text:Text("TATTOOS")
		Menu.Subtitle.BackupText = "TATTOOS"
		for Tattoo = 1, #PlayerCustomisation.Reference.Tattoos.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index] do
			local Item = NativeUI.CreateItem(GetLabelText(PlayerCustomisation.Reference.Tattoos.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Tattoo].Name), "")
			Item.Activated = function(ParentSubMenu, SelectedItem)
				SelectedItem:Enabled(false)

				if not PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos[PlayerCustomisation.Reference.Tattoos.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Tattoo].Decoration] then
					PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos[PlayerCustomisation.Reference.Tattoos.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Tattoo].Decoration] = PlayerCustomisation.Reference.Tattoos.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Tattoo].Collection
					SelectedItem:SetRightBadge(BadgeStyle.Tattoo)
				else
					PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos[PlayerCustomisation.Reference.Tattoos.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Tattoo].Decoration] = nil
					SelectedItem:SetRightBadge(BadgeStyle.None)
				end

				SelectedItem:Enabled(true)

				UpdatePlayer()
				SetPedNaked()
			end

			Menu:AddItem(Item)
		end

		Menu.OnIndexChange = function(CurrentMenu, NewIndex)
			UpdatePlayer()
			SetPedNaked()

			if not PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos[PlayerCustomisation.Reference.Tattoos.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][NewIndex].Decoration] then
				SetPedDecoration(PlayerPedId(), GetHashKey(PlayerCustomisation.Reference.Tattoos.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][NewIndex].Collection), GetHashKey(PlayerCustomisation.Reference.Tattoos.Options[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][NewIndex].Decoration))
			end
		end

		Menu.OnMenuClosed = function(CurrentMenu)
			UpdatePlayer()
			SetPedNaked()

			if Index == 4 then
				ParentMenu.Cameras.Default:Switch((ParentMenu.Cameras.Face.Handle), 250, false, false)
			elseif Index == 7 or Index == 8 then
				ParentMenu.Cameras.Default:Switch((ParentMenu.Cameras.Legs.Handle), 250, false, false)
			end
		end

		Menu.Settings.MouseEdgeEnabled = false

		Menu:RemoveEnabledControl(0, 31)
		Menu:RemoveEnabledControl(0, 30)
		Menu:RemoveEnabledControl(0, 22)

		Menu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
		Menu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

		Menu:RefreshIndex()
	end

	TattooMenu.Items[4].Activated = function(ParentMenu, SelectedItem)
		ParentMenu.Cameras.Face:Switch((ParentMenu.Cameras.Default.Handle), 250, false, false)
	end

	TattooMenu.Items[7].Activated = function(ParentMenu, SelectedItem)
		ParentMenu.Cameras.Legs:Switch((ParentMenu.Cameras.Default.Handle), 250, false, false)
	end

	TattooMenu.Items[8].Activated = function(ParentMenu, SelectedItem)
		ParentMenu.Cameras.Legs:Switch((ParentMenu.Cameras.Default.Handle), 250, false, false)
	end
	TattooMenu:RefreshIndex()
end

SetupTattooMenu(TattooMenu)
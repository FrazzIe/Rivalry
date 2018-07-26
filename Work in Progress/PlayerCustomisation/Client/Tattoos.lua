TattooMenu = NativeUI.CreateMenu("", "BODY PARTS", 0, 0)

TattooMenu.OnMenuClosed = function(ParentMenu)
	TriggerServerEvent("PlayerCustomisation.Update", PlayerCustomisation.PlayerData.Type, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type])
end

function SetupTattooMenu(ParentMenu)
	TattooMenu:Clear()
	for Index = 1, #PlayerCustomisation.Reference.Tattoos.Categories do
		local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, PlayerCustomisation.Reference.Tattoos.Categories[Index], "", true)
		Menu.Subtitle.Text:Text("TATTOOS")
		Menu.Subtitle.BackupText = "TATTOOS"
		for Tattoo = 1, #PlayerCustomisation.Reference.Tattoos[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index] do
			local Item = NativeUI.CreateItem(GetLabelText(PlayerCustomisation.Reference.Tattoos[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Tattoo].Name), "")
			Item.Activated = function(ParentSubMenu, SelectedItem)
				SelectedItem:Enabled(false)

				if not PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos[PlayerCustomisation.Reference.Tattoos[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Tattoo].Decoration] then
					PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos[PlayerCustomisation.Reference.Tattoos[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Tattoo].Decoration] = PlayerCustomisation.Reference.Tattoos[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Tattoo].Collection
					SelectedItem:SetRightBadge(BadgeStyle.Tattoo)
				else
					PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos[PlayerCustomisation.Reference.Tattoos[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][Tattoo].Decoration] = nil
					SelectedItem:SetRightBadge(BadgeStyle.None)
				end

				SelectedItem:Enabled(true)

				UpdatePlayer()
			end

			Menu:AddItem(Item)
		end

		Menu.OnIndexChange = function(ParentMenu, NewIndex)
			UpdatePlayer()

			if not PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Tattoos[PlayerCustomisation.Reference.Tattoos[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][NewIndex].Decoration] then
				SetPedDecoration(PlayerPedId(), GetHashKey(PlayerCustomisation.Reference.Tattoos[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][NewIndex].Collection), GetHashKey(PlayerCustomisation.Reference.Tattoos[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender][Index][NewIndex].Decoration))
			end
		end

		Menu.OnMenuClosed = function(ParentMenu)
			UpdatePlayer()
		end

		Menu:RefreshIndex()
	end
	TattooMenu:RefreshIndex()
end

SetupTattooMenu(TattooMenu)
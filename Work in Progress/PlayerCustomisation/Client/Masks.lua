MaskMenu = NativeUI.CreateMenu("", "MASKS", 0, 0)
Masks = {
	Drawables = {},
	Textures = {},
}

function SetupMaskMenu(ParentMenu)
	--[[
	local MaskDrawableItem = NativeUI.CreateProgressItem("Mask Drawables", {}, 1, "", false)
	local MaskTextureItem = NativeUI.CreateProgressItem("Mask Textures", {}, 1, "", false)

	MaskDrawableItem.OnProgressChanged = function(ParentMenu, SelectedItem, NewIndex)
		local Item = SelectedItem:IndexToItem(NewIndex)

		PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[2] = Item

		MaskTextureItem.Data.Items = Masks.Textures[NewIndex]
		MaskTextureItem:Index(1)

		PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[2] = MaskTextureItem.Data.Items[1]

		UpdatePlayer()
	end
	MaskTextureItem.OnProgressChanged = function(ParentMenu, SelectedItem, NewIndex)
		local Item = SelectedItem:IndexToItem(NewIndex)

		PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[2] = Item
		
		UpdatePlayer()
	end

	ParentMenu:AddItem(MaskDrawableItem)
	ParentMenu:AddItem(MaskTextureItem)
	--]]
	for Index = 1, #PlayerCustomisation.Reference.Masks.Categories do
		local Menu = Pool:AddSubMenu(ParentMenu, PlayerCustomisation.Reference.Masks.Categories[Index], "", true)
		for Mask = 1, #PlayerCustomisation.Reference.Masks.List[Index] do
			local Item = NativeUI.CreateItem(PlayerCustomisation.Reference.Masks.List[Index][Mask].Name, "")
			Item.Activated = function(ParentMenu, SelectedItem)
				PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[2] = PlayerCustomisation.Reference.Masks.List[Index][Mask].Value.Drawable
				PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[2] = PlayerCustomisation.Reference.Masks.List[Index][Mask].Value.Texture
				
				for ItemIndex = 1, #ParentMenu.Items do
					ParentMenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
				end

				SelectedItem:SetRightBadge(BadgeStyle.Clothes)
			end
		end

		Menu.OnIndexChange = function(ParentMenu, NewIndex)
			SetPedComponentVariation(PlayerPedId(), 1, PlayerCustomisation.Reference.Masks.List[NewIndex][Mask].Value.Drawable, PlayerCustomisation.Reference.Masks.List[Index][NewIndex].Value.Texture, 1)
		end

		Menu.OnMenuClosed = function(ParentMenu)
			UpdatePlayer()
		end
	end
end

SetupMaskMenu(MaskMenu)


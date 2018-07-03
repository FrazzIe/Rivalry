MaskMenu = NativeUI.CreateMenu("", "MASKS", 0, 0)
Masks = {
	Drawables = {},
	Textures = {},
}

function SetupMaskMenu(ParentMenu)
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
end

SetupMaskMenu(MaskMenu)


MaskMenu = NativeUI.CreateMenu("", "MASKS", 0, 0)
Masks = {
	Drawables = {},
	Textures = {},
}

function SetupMaskMenu(ParentMenu)
	for Index = 1, #PlayerCustomisation.Reference.Masks.Categories do
		local Menu = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, PlayerCustomisation.Reference.Masks.Categories[Index], "", true)
		for Mask = 1, #PlayerCustomisation.Reference.Masks.List[Index] do
			local Item = NativeUI.CreateItem(PlayerCustomisation.Reference.Masks.List[Index][Mask].Name, "")
			Item.Activated = function(ParentSubMenu, SelectedItem)
				PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[2] = PlayerCustomisation.Reference.Masks.List[Index][Mask].Value.Drawable
				PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[2] = PlayerCustomisation.Reference.Masks.List[Index][Mask].Value.Texture
				
				for MenuItems = 1, #ParentMenu.Items do
					local Submenu = ParentMenu.Children[ParentMenu.Items[MenuItems]]
					if Submenu then
						for ItemIndex = 1, #Submenu.Items do
							Submenu.Items[ItemIndex]:SetRightBadge(BadgeStyle.None)
						end
					end
				end

				if PlayerCustomisation.Reference.Masks.List[Index][Mask].Value.Drawable == 0 and PlayerCustomisation.Reference.Masks.List[Index][Mask].Value.Texture == 0 then
					for MenuItems = 1, #ParentMenu.Items do
						local Submenu = ParentMenu.Children[ParentMenu.Items[MenuItems]]
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
	end
end

SetupMaskMenu(MaskMenu)


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

function OpenMaskMenu(LocationIndex)
	Masks.Drawables = {}
	Masks.Textures = {}
	for Drawable = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 1) do
		table.insert(Masks.Drawables, Drawable)
	end

	for Index = 1, #Masks.Drawables do
		table.insert(Masks.Textures, {})
		for Texture = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 1, Masks.Drawables[Index]) do
			table.insert(Masks.Textures[Index], Texture)
		end
	end

	Citizen.Trace(json.encode(Masks.Drawables))
	MaskMenu.Items[1].Data.Items = Masks.Drawables
	MaskMenu.Items[1]:Index(MaskMenu.Items[1]:ItemToIndex(PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[2]))

	MaskMenu.Items[2].Data.Items = Masks.Textures[MaskMenu.Items[1]:Index()]
	MaskMenu.Items[2]:Index(MaskMenu.Items[2]:ItemToIndex(PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[2]))

	MaskMenu:Visible(true)
end
--]]
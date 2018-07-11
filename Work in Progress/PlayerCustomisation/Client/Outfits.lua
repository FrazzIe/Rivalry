OutfitMenu = NativeUI.CreateMenu("", "OUTFITS", 0, 0)

function SetupOutfitMenu(ParentMenu)
	ParentMenu:Clear()
	local SaveItem = NativeUI.CreateItem("Save Outfit", "Save an outfit")
	SaveItem.Activated = function(ParentMenu, SelectedItem)
		for Index = 1, #ParentMenu.Items do
			ParentMenu.Items[Index]:Enabled(false)
		end

		local Outfit = {
			Name = "",
			Clothing = {
				Drawable = {},
				Texture = {},
			},
			Props = {
				Drawable = {},
				Texture = {},
			},
		}

		for Index = 1, 12 do
			Outfit.Clothing.Drawable[Index] = PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index]
			Outfit.Clothing.Texture[Index] = PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index]
		end

		for Index = 1, 8 do
			Outfit.Props.Drawable[Index] = PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index]
			Outfit.Props.Texture[Index] = PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index]
		end

		Outfit.Name = KeyboardInput("Outfit Name", "", 30) or "Outfit #"..#PlayerCustomisation.Outfits

		TriggerServerEvent("Outfit.Create", PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model, Outfit)
	end

	ParentMenu:AddItem(SaveItem)

	if PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model] then
		for OutfitIndex = 1, #PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model] do
			local Outfit = PlayerCustomisation.Pool:AddSubMenu(ParentMenu, PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Name, "Do something with this outfit", true)
			local LoadItem = NativeUI.CreateItem("Load "..PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Name, "")
			local UpdateItem = NativeUI.CreateItem("Update "..PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Name, "")
			local DeleteItem = NativeUI.CreateItem("Delete "..PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Name, "")

			LoadItem.Activated = function(ParentMenu, SelectedItem)
				for Index = 1, #ParentMenu.Items do
					ParentMenu.Items[Index]:Enabled(false)
				end

				if PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender ~= "Hybrid" then
					PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Drawable[3]
					PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[3] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Texture[3]

					for Index = 4, 12 do
						PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Drawable[Index]
						PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Texture[Index]
					end

					for Index = 1, 8 do
						PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Drawable[Index]
						PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Texture[Index]
						
						if PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Drawable[Index] == -1 then
							ClearPedProp(PlayerPedId(), Index - 1)
						end
					end

					UpdatePlayer()
				else
					for Index = 1, 12 do
						PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Drawable[Index]
						PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Texture[Index]
					end

					for Index = 1, 8 do
						PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Drawable[Index]
						PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Texture[Index]
					end

					UpdatePlayer()
				end

				for Index = 1, #ParentMenu.Items do
					ParentMenu.Items[Index]:Enabled(true)
				end
			end
			UpdateItem.Activated = function(ParentMenu, SelectedItem)
				for Index = 1, #ParentMenu.Items do
					ParentMenu.Items[Index]:Enabled(false)
				end

				for Index = 1, 12 do
					PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Drawable[Index] = PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index]
					PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Texture[Index] = PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index]
				end

				for Index = 1, 8 do
					PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Drawable[Index] = PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index]
					PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Texture[Index] = PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index]
				end

				TriggerServerEvent("Outfit.Update", PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model, PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex])
			end
			DeleteItem.Activated = function(ParentMenu, SelectedItem)
				for Index = 1, #ParentMenu.Items do
					ParentMenu.Items[Index]:Enabled(false)
				end

				TriggerServerEvent("Outfit.Delete", PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model, PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Id)
			end

			Outfit:AddItem(LoadItem)
			Outfit:AddItem(UpdateItem)
			Outfit:AddItem(DeleteItem)
			Outfit:RefreshIndex()
		end
	end
	ParentMenu:RefreshIndex()
end

SetupOutfitMenu(OutfitMenu)

RegisterNetEvent("Outfit.Load")
AddEventHandler("Outfit.Load", function(Outfits)
	PlayerCustomisation.Outfits = Outfits

	if OutfitMenu:Visible() then
		OutfitMenu:Visible(false)
		SetupOutfitMenu(OutfitMenu)
		OutfitMenu:Visible(true)
	else
		SetupOutfitMenu(OutfitMenu)
	end
end)
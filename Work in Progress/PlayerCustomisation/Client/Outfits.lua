OutfitMenu = NativeUI.CreateMenu("", "OUTFITS", 0, 0)

PlayerCustomisation.Outfits = {}

Citizen.CreateThread(function()
	local Player = {
		Coordinates = GetEntityCoords(PlayerPedId(), false)
	}
	while true do
		Citizen.Wait(0)
		Player.Coordinates = GetEntityCoords(PlayerPedId(), false)
		for Index = 1, #PlayerCustomisation.Locations.Outfits do
			if Vdist2(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, PlayerCustomisation.Locations.Outfits[Index].Marker.x, PlayerCustomisation.Locations.Outfits[Index].Marker.y, PlayerCustomisation.Locations.Outfits[Index].Marker.z) < 20 then
				RenderMarker(25, PlayerCustomisation.Locations.Outfits[Index].Marker.x, PlayerCustomisation.Locations.Outfits[Index].Marker.y, PlayerCustomisation.Locations.Outfits[Index].Marker.z, 2.0, 2.0, 2.5, 255, 255, 0, 255)
				if Vdist2(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, PlayerCustomisation.Locations.Outfits[Index].Marker.x, PlayerCustomisation.Locations.Outfits[Index].Marker.y, PlayerCustomisation.Locations.Outfits[Index].Marker.z) < 2 then
					if IsControlJustPressed(1, 51) then
						if not OutfitMenu:Visible() then
							OpenOutfitMenu(Index)
						else
							OutfitMenu:Visible(false)
						end
					end
				end
			end
		end
	end
end)

function OpenOutfitMenu(LocationIndex)

end

function SetupOutfitMenu(ParentMenu)
	ParentMenu:Clear()
	local SaveItem = NativeUI.CreateItem("Save Outfit", "Save an outfit")
	SaveItem.Activated = function(ParentItem, SelectedItem)

	end

	for Index = 1, #PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model] do
		local Outfit = Pool:AddSubMenu(ParentMenu, PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Name, "Do something with this outfit", true)
		local LoadItem = NativeUI.CreateItem("Load "..PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Name, "")
		local UpdateItem = NativeUI.CreateItem("Update "..PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Name, "")
		local DeleteItem = NativeUI.CreateItem("Delete "..PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Name, "")

		LoadItem.Activated = function(ParentItem, SelectedItem)
			SelectedItem:Enabled(false)

			if PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender ~= "Hybrid" then
				PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[3] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Clothing.Drawable[3]
				PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[3] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Clothing.Texture[3]

				for Index = 4, 12 do
					PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Clothing.Drawable[Index]
					PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Clothing.Texture[Index]
				end

				for Index = 1, 8 do
					PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Props.Drawable[Index]
					PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Props.Texture[Index]
				end

				UpdatePlayer()
			else
			    for Index = 1, 12 do
					PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Clothing.Drawable[Index]
					PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Clothing.Texture[Index]
				end

			    for Index = 1, 8 do
					PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Props.Drawable[Index]
					PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model][Index].Props.Texture[Index]
			    end

			    UpdatePlayer()
			end
		end
		UpdateItem.Activated = function(ParentItem, SelectedItem)
			SelectedItem:Enabled(false)
			TriggerServerEvent("Outfit.Update", PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model, Index)
		end
		DeleteItem.Activated = function(ParentItem, SelectedItem)
			SelectedItem:Enabled(false)
			TriggerServerEvent("Outfit.Delete", PlayerCustomisation.PlayerData[PlayerCustomisation.PlayerData.Type].Model, Index)
		end

		Outfit:AddItem(LoadItem)
		Outfit:AddItem(UpdateItem)
		Outfit:AddItem(DeleteItem)
	end
	ParentMenu:RefreshIndex()
end
local OutfitMenu = nil

function DestoryOutfitMenu()
	exports["core_modules"]:StanceAllowed(true)
	exports["core_modules"]:TurnOffHudElements(false)
	TriggerEvent("chat:disable", false)
	
	PlayerCustomisation.Instanced = false
	TriggerServerEvent("PlayerCustomisation.Instance", false)
	TriggerServerEvent("PlayerCustomisation.Update", PlayerCustomisation.PlayerData.Type, PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type])

	FreezeEntityPosition(PlayerPedId(), false)

	if OutfitMenu ~= nil then
		OutfitMenu.Cameras.Default:Deactivate()
		OutfitMenu.Cameras.Default:Destroy()

		OutfitMenu:Visible(false)
	end

	PlayerCustomisation.Pool:Remove()

	OutfitMenu = nil

	collectgarbage()
end

function CreateOutfitMenu(LocationIndex)
	OutfitMenu = NativeUI.CreateMenu("", "OUTFITS", 0, 0)

	OutfitMenu.Settings.MouseEdgeEnabled = false

	OutfitMenu:RemoveEnabledControl(0, 31)
	OutfitMenu:RemoveEnabledControl(0, 30)
	OutfitMenu:RemoveEnabledControl(0, 22)

	OutfitMenu.Cameras = {
		Default = Camera.New(),
	}

	OutfitMenu.OnMenuClosed = DestoryOutfitMenu

	OutfitMenu:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
	OutfitMenu:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})

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
			Outfit.Clothing.Drawable[Index] = PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index]
			Outfit.Clothing.Texture[Index] = PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index]
		end

		for Index = 1, 8 do
			Outfit.Props.Drawable[Index] = PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index]
			Outfit.Props.Texture[Index] = PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index]
		end

		Outfit.Name = KeyboardInput("Outfit Name", "", 30) or "Outfit #"..#PlayerCustomisation.Outfits

		TriggerServerEvent("Outfit.Create", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model, Outfit, LocationIndex)
	end

	OutfitMenu:AddItem(SaveItem)

	if PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model] then
		for OutfitIndex = 1, #PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model] do
			local Outfit = PlayerCustomisation.Pool:AddSubMenu(OutfitMenu, PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Name, "Do something with this outfit", true)
			local LoadItem = NativeUI.CreateItem("Load "..PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Name, "")
			local UpdateItem = NativeUI.CreateItem("Update "..PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Name, "")
			local DeleteItem = NativeUI.CreateItem("Delete "..PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Name, "")

			LoadItem.Activated = function(ParentMenu, SelectedItem)
				for Index = 1, #ParentMenu.Items do
					ParentMenu.Items[Index]:Enabled(false)
				end

				if PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender ~= "Hybrid" then
					PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[2] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Drawable[2]
					PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[2] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Texture[2]

					for Index = 4, 12 do
						PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Drawable[Index]
						PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Texture[Index]
					end

					for Index = 1, 8 do
						PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Drawable[Index]
						PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Texture[Index]
						
						if PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Drawable[Index] == -1 then
							ClearPedProp(PlayerPedId(), Index - 1)
						end
					end

					UpdatePlayer()
				else
					for Index = 1, 12 do
						PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Drawable[Index]
						PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Texture[Index]
					end

					for Index = 1, 8 do
						PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Drawable[Index]
						PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index] = PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Texture[Index]
					end

					UpdatePlayer()
				end

				for Index = 1, #ParentMenu.Items do
					ParentMenu.Items[Index]:Enabled(true)
				end
			end
			UpdateItem.Activated = function(ParentMenu, SelectedItem)
				ParentMenu:Visible(false)

				for Index = 1, 12 do
					PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Drawable[Index] = PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Drawable[Index]
					PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Clothing.Texture[Index] = PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Clothing.Texture[Index]
				end

				for Index = 1, 8 do
					PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Drawable[Index] = PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Drawable[Index]
					PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Props.Texture[Index] = PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type][PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Gender].Props.Texture[Index]
				end

				TriggerServerEvent("Outfit.Update", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model, PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex], LocationIndex)
			end
			DeleteItem.Activated = function(ParentMenu, SelectedItem)
				ParentMenu:Visible(false)

				TriggerServerEvent("Outfit.Delete", PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model, PlayerCustomisation.Outfits[PlayerCustomisation.PlayerData.Types[PlayerCustomisation.PlayerData.Type].Model][OutfitIndex].Id, LocationIndex)
			end

			Outfit:AddItem(LoadItem)
			Outfit:AddItem(UpdateItem)
			Outfit:AddItem(DeleteItem)

			Outfit.Settings.MouseEdgeEnabled = false

			Outfit:RemoveEnabledControl(0, 31)
			Outfit:RemoveEnabledControl(0, 30)
			Outfit:RemoveEnabledControl(0, 22)

			Outfit:AddInstructionButton({GetControlInstructionalButton(0, 51, 0), "Turn Right"})
			Outfit:AddInstructionButton({GetControlInstructionalButton(0, 44, 0), "Turn Left"})
		end
	end

	PlayerCustomisation.Pool:Add(OutfitMenu)
	PlayerCustomisation.Pool:RefreshIndex()

	return OutfitMenu
end

RegisterNetEvent("Outfit.Load")
AddEventHandler("Outfit.Load", function(Outfits, LocationIndex)
	PlayerCustomisation.Outfits = Outfits

	if LocationIndex then
		DestoryOutfitMenu()
		OpenOutfitMenu(LocationIndex)
	end
end)
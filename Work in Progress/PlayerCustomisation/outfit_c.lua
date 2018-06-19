local Pool = NativeUI.CreatePool()
local OutfitMenu = NativeUI.CreateMenu("Outfits", "", 45, 45)
local Outfits = {}

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLength	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end

function CreateOutfit()
	local Outfit = {
		Clothing = {
			Drawable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			Texture = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			Palette = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
		},
		Props = {
			Drawable = {0, 0, 0, 0, 0, 0, 0},
			Texture = {0, 0, 0, 0, 0, 0, 0},
		},
	}

	for Index = 0, 11 do
		Outfit.Clothing.Drawable[Index + 1] = GetPedDrawableVariation(PlayerPedId(), Index)
		Outfit.Clothing.Texture[Index + 1] = GetPedTextureVariation(PlayerPedId(), Index)
		Outfit.Clothing.Palette[Index + 1] = GetPedPaletteVariation(PlayerPedId(), Index)
	end

	for Index = 0, 7 do
		Outfit.Props.Drawable[Index + 1] = GetPedPropIndex(PlayerPedId(), Index)
		Outfit.Props.Texture[Index + 1] = GetPedPropTextureIndex(PlayerPedId(), Index)
	end

	Outfit.Name = KeyboardInput("Outfit Name", "", 50) or "Outfit #"..#Outfits

	TriggerServerEvent("Outfit.Save", Outfit)
end

function LoadOutfit(Outfit)
	for Index = 0, 11 do
		if Index ~= 0 and Index ~= 2 then
			SetPedComponentVariation(PlayerPedId(), Index, Outfit.Clothing.Drawable[Index + 1], Outfit.Clothing.Texture[Index + 1], Outfit.Clothing.Palette[Index + 1])
		end
	end

	for Index = 0, 7 do
		SetPedPropIndex(PlayerPedId(), Index, Outfit.Props.Drawable[Index + 1], Outfit.Props.Texture[Index + 1], true)
	end
end

function SetupOutfitMenu(ParentMenu)
	ParentMenu:Clear()
	local SaveItem = NativeUI.CreateItem("Save Outfit", "Save an outfit")
	SaveItem.Activated = function(ParentItem, SelectedItem)
		SelectedItem:Enabled(false)
		CreateOutfit()
		SelectedItem:Enabled(true)		
	end
	ParentMenu:AddItem(SaveItem)
	for Index = 1, #Outfits do
		local Menu = Pool:AddSubMenu(ParentMenu, Outfits[Index].Name, "Do something with this outfit", true)
		local LoadItem = NativeUI.CreateItem("Load "..Outfits[Index].Name, "")
		local UpdateItem = NativeUI.CreateItem("Update "..Outfits[Index].Name, "")
		local DeleteItem = NativeUI.CreateItem("Delete "..Outfits[Index].Name, "")

		LoadItem.Activated = function(ParentItem, SelectedItem)
			SelectedItem:Enabled(false)
			LoadOutfit(Outfits[Index])
		end
		UpdateItem.Activated = function(ParentItem, SelectedItem)
			SelectedItem:Enabled(false)
			TriggerServerEvent("Outfit.Update", Outfits[Index])
		end
		DeleteItem.Activated = function(ParentItem, SelectedItem)
			SelectedItem:Enabled(false)
			TriggerServerEvent("Outfit.Delete", Outfits[Index])
		end

		Menu:AddItem(LoadItem)
		Menu:AddItem(UpdateItem)
		Menu:AddItem(DeleteItem)
	end
	Pool:RefreshIndex()
end

Pool:Add(OutfitMenu)
SetupOutfitMenu(OutfitMenu)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		Pool:ProcessMenus()
		if IsControlJustPressed(1, 74) then
			OutfitMenu:Visible(not OutfitMenu:Visible())
		end
	end
end)

RegisterNetEvent("Outfit.Load")
AddEventHandler("Outfit.Load", function(_Outfits, first)
	Outfits = _Outfits
	if not first then
		Pool:CloseAllMenus()
		SetupOutfitMenu(OutfitMenu)
		OutfitMenu:Visible(true)
	end
end)
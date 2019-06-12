local Rivalry = {
	Supplier = vector3(),
	Gangs = {
		Russian = vector3(),
		Italian = vector3(),
		Ballers = vector3()
	}
}
local OpenMenu = false
-- Russian Market
Citizen.CreateThread(function()
	while true do
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		if #(PlayerPosition - Rivalry.Gangs.Russian) <= 1.0 then
			DisplayHelpText("Press ~INPUT_CONTEXT~ to open stash!")
			if IsControlJustPressed(1, 51) then
				TriggerServerEvent("Open.Stash.Russian")
			end
		end
	end
end)

-- Italian Market
Citizen.CreateThread(function()
	while true do
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		if #(PlayerPosition - Rivalry.Gangs.Italian) <= 1.0 then
			TriggerServerEvent("Open.Stash.Italian")
		end
	end
end)

-- Ballers Market
Citizen.CreateThread(function()
	while true do
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		if #(PlayerPosition - Rivalry.Gangs.Ballers) <= 1.0 then
			TriggerServerEvent("Open.Stash.Ballers")
		end
	end
end)

RegisterNetEvent("Open.Stash")
AddEventHandler("Open.Stash", function(Inventory)
	if not WarMenu.IsMenuOpened("Stash") then
		if not WarMenu.DoesMenuExist("Stash") then
			WarMenu.CreateMenu("Stash", "Convenience store")
			WarMenu.SetSpriteTitle("Stash", "shopui_title_conveniencestore")
			WarMenu.SetSubTitle("Stash", "CATEGORIES")
			WarMenu.SetMenuX("Stash", 0.6)
			WarMenu.SetMenuY("Stash", 0.15)
			WarMenu.SetTitleBackgroundColor("Stash", 0, 107, 87)
			WarMenu.SetTitle("Stash_Deposit", "Deposit")
			WarMenu.CreateSubMenu("Withdraw", "Stash", "WIRTHDRAW SECTION")
			for Index = 1, #Inventory do
				WarMenu.CreateSubMenu(Inventory[Index].Model, "Withdraw", tostring(Index))
			end
			WarMenu.OpenMenu("Stash")
		else
			currentItemIndex = 1
			WarMenu.OpenMenu("Stash")
		end
	else
		WarMenu.CloseMenu()
	end
	OpenMenu = true
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if OpenMenu then
			if WarMenu.IsMenuOpened("Stash_Deposit") then
				WarMenu.Display()
			end
		end
		for Index = 1, #Inventory do
			if WarMenu.IsMenuOpened(Inventory[Index].Model, "Withdraw", tostring(Index)) then
				WarMenu.Display()
			end
		end
	end
end)
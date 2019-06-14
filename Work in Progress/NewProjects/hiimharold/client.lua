local Rivalry = {
	Supplier = vector3(),
	Gangs = {
		Russian = vector3(1053.0560302734,-3097.1311035156,-38.999919891357),
		Italian = vector3(1103.9210205078,-3098.408203125,-38.999961853027),
		Ballers = vector3()
	}
	Teleporters = {
		Italian = {
			OutsideDoor = vector3(-44.018558502197,-2519.8591308594,7.3945479393005)
			OutsideDoorHeading = 236.03332519531,
			InsideDoor = vector3(1087.3448486328,-3099.4184570313,-38.999961853027),
			InsideDoorHeading = 269.36706542969
		},
		Russian = {

		},
		Ballers = {
		OutsideDoor = vector3(-150.23551940918, -1625.5727539063,36.848297119141),
		OutsideDoorHeading = 50.321853637695,
		InsideDoor = vecotr3(151.41645812988,-1008.0470581055,-99.000022888184),
		InsideDoorHeading = 1.0677021741867
		}
	}
}
local OpenMenu = false
local Inventory = {}
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
AddEventHandler("Open.Stash", function()
	if not WarMenu.IsMenuOpened("Stash") then
		if not WarMenu.DoesMenuExist("Stash") then
			WarMenu.CreateMenu("Stash", "Convenience store")
			WarMenu.SetSpriteTitle("Stash", "shopui_title_conveniencestore")
			WarMenu.SetSubTitle("Stash", "CATEGORIES")
			WarMenu.SetMenuX("Stash", 0.6)
			WarMenu.SetMenuY("Stash", 0.15)
			WarMenu.SetTitleBackgroundColor("Stash", 0, 107, 87)
			WarMenu.SetTitle("Stash_Deposit", "Deposit")
			WarMenu.CreateSubMenu("Stash_Withdraw", "Stash", "WIRTHDRAW SECTION")
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

RegisterNetEvent("Stash.Sync")
AddEventHandler("Stash.Sync", function(_Inventory)
	Inventory = _Inventory
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if OpenMenu then
			if WarMenu.IsMenuOpened("Stash_Deposit") then
				for k, v in pairs(user_weapons) do
					if WarMenu.Button(Weapon_names[k].." ["..v.ammo.."]", "Deposit") then
						TriggerServerEvent("Stash.Deposit", CurrentGang, v)
					end
				end
				WarMenu.Display()
			end
			if WarMenu.IsMenuOpened("Stash_Withdraw") then
				for Index = 1, #Inventory do
					if WarMenu.Button(Weapon_names[Inventory[Index].model], tostring(Index)) then
						TriggerServerEvent("Stash.Withdraw", CurrentGang, Index, Inventory[Index])
					end
				end
			end
		end
	end
end)
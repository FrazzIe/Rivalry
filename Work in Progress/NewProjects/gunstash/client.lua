local Rivalry = {
	--Supplier = vector3(),
	Gangs = {
		[1] = vector3(0,0,0),
		[2] = vector3(1095.060546875,-3098.2133789063,-38.999923706055),
		[3] = vector3(1053.0560302734,-3097.1311035156,-38.999919891357),
	},
	Teleporters = {
		Italian = {
			[1] = {
				OutsideDoor = vector3(-44.018558502197,-2519.8591308594,7.3945479393005),
				OutsideDoorHeading = 236.03332519531,
			},
			[2] = {
				InsideDoor = vector3(1087.3448486328,-3099.4184570313,-38.999961853027),
				InsideDoorHeading = 269.36706542969
			}
		},
		-- Russian = {

		-- },
		Ballers = {
			[1] = {
				OutsideDoor = vector3(-150.23551940918, -1625.5727539063,36.848297119141),
				OutsideDoorHeading = 50.321853637695,
			},
			[2] = {
				InsideDoor = vector3(151.41645812988,-1008.0470581055,-99.000022888184),
				InsideDoorHeading = 1.0677021741867
			}
		}
	}
}
local OpenMenu = false
local IsOpened = false
local Inventory = {}
Dealer = {}
Dealer.IsDealer = false
Dealer.Gang = nil

function DisplayHelpText(Str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(Str or "")
	EndTextCommandDisplayHelp(0, 0, 0, -1)
end

function Notify(Message, Time)
	exports.pNotify:SendNotification({text = Message or "", type = "error", timeout = Time or 3000, layout = "centerRight", queue = "left"})
end

RegisterNetEvent("Stash.Sync")
AddEventHandler("Stash.Sync", function()
	IsOpened = true
end)

RegisterNetEvent("Open.Stash")
AddEventHandler("Open.Stash", function(Inv)
	Inventory = Inv
	OpenMenu = true
end)

RegisterNetEvent("Close.Stash")
AddEventHandler("Close.Stash", function()
	IsOpened = false
end)

RegisterNetEvent("Dealer:Set")
AddEventHandler("Dealer:Set", function(_Data, _Dealer, first)
	Dealer.IsDealer = _Dealer

	if not Dealer.IsDealer then
		Dealer.Gang = nil
	else
		if _Data ~= nil then
			if _Data.gang ~= nil then
				Dealer.Gang = _Data.gang
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Dealer.IsDealer then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			for Index = 1, #Rivalry.Gangs do
				if #(PlayerPosition - Rivalry.Gangs[Index]) <= 1.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to open stash!")
					if IsControlJustPressed(1, 51) then
						if not IsOpened then
							TriggerServerEvent("Open.Stash", Dealer.Gang)
						else
							Notify("One person at a time please! For now...", 3100)
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Dealer.IsDealer and Dealer.Gang == "italian" then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			for Index = 1, #Rivalry.Teleporters.Italian do
				if Index == 1 then
					if #(PlayerPosition - Rivalry.Teleporters.Italian[Index].OutsideDoor) <= 1.0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
						if IsControlJustPressed(1, 51) then
							TeleportPlayer(Rivalry.Teleporters.Italian[Index + 1].InsideDoor.x, Rivalry.Teleporters.Italian[Index + 1].InsideDoor.y, Rivalry.Teleporters.Italian[Index + 1].InsideDoor.z, Rivalry.Teleporters.Italian[Index + 1].InsideDoorHeading)
						end
					end
				else
					if #(PlayerPosition - Rivalry.Teleporters.Italian[Index].InsideDoor) <= 1.0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
						if IsControlJustPressed(1, 51) then
							TeleportPlayer(Rivalry.Teleporters.Italian[Index - 1].OutsideDoor.x, Rivalry.Teleporters.Italian[Index - 1].OutsideDoor.y, Rivalry.Teleporters.Italian[Index - 1].OutsideDoor.z, Rivalry.Teleporters.Italian[Index - 1].OutsideDoorHeading)
						end
					end
				end
			end
		end
		if Dealer.IsDealer and Dealer.Gang == "ballers" then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			for Index = 1, #Rivalry.Teleporters.Ballers do
				if Index == 1 then
					if #(PlayerPosition - Rivalry.Teleporters.Ballers[Index].OutsideDoor) <= 1.0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
						if IsControlJustPressed(1, 51) then
							TeleportPlayer(Rivalry.Teleporters.Ballers[Index + 1].InsideDoor.x, Rivalry.Teleporters.Ballers[Index + 1].InsideDoor.y, Rivalry.Teleporters.Ballers[Index + 1].InsideDoor.z, Rivalry.Teleporters.Ballers[Index + 1].InsideDoorHeading)
						end
					end
				else
					if #(PlayerPosition - Rivalry.Teleporters.Ballers[Index].InsideDoor) <= 1.0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
						if IsControlJustPressed(1, 51) then
							TeleportPlayer(Rivalry.Teleporters.Ballers[Index - 1].OutsideDoor.x, Rivalry.Teleporters.Ballers[Index - 1].OutsideDoor.y, Rivalry.Teleporters.Ballers[Index - 1].OutsideDoor.z, Rivalry.Teleporters.Ballers[Index - 1].OutsideDoorHeading)
						end
					end
				end
			end
		end
		-- if Dealer.IsDealer and Dealer.Gang == "russian" then
		-- 	local Player = PlayerPedId()
		-- 	local PlayerPosition = GetEntityCoords(Player, false)
		-- 	for Index = 1, #Rivalry.Teleporters.Russian do
		-- 		if Index == 1 then
		-- 			if #(PlayerPosition - Rivalry.Teleporters.Russian[Index].OutsideDoor) <= 1.0 then
		-- 				DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
		-- 				if IsControlJustPressed(1, 51) then
		-- 					TeleportPlayer(Rivalry.Teleporters.Russian[Index + 1].InsideDoor.x, Rivalry.Teleporters.Russian[Index + 1].InsideDoor.y, Rivalry.Teleporters.Russian[Index + 1].InsideDoor.z, Rivalry.Teleporters.Russian[Index + 1].InsideDoorHeading)
		-- 				end
		-- 			end
		-- 		else
		-- 			if #(PlayerPosition - Rivalry.Teleporters.Russian[Index].InsideDoor) <= 1.0 then
		-- 				DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
		-- 				if IsControlJustPressed(1, 51) then
		--					TeleportPlayer(Rivalry.Teleporters.Russian[Index - 1].OutsideDoor.x, Rivalry.Teleporters.Russian[Index - 1].OutsideDoor.y, Rivalry.Teleporters.Russian[Index - 1].OutsideDoor.z, Rivalry.Teleporters.Russian[Index - 1].OutsideDoorHeading)
		-- 				end
		-- 			end
		-- 		end
		-- 	end
		-- end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if OpenMenu then
			if not WarMenu.IsMenuOpened("Stash") then
				if not WarMenu.DoesMenuExist("Stash") then
					WarMenu.CreateMenu("Stash", "Gun Stash")
					WarMenu.SetSpriteTitle("Stash", "shopui_title_gr_gunmod")
					WarMenu.SetSubTitle("Stash", "CATEGORIES")
					WarMenu.SetMenuX("Stash", 0.6)
					WarMenu.SetMenuY("Stash", 0.15)
					WarMenu.SetTitleBackgroundColor("Stash", 0, 107, 87)
					WarMenu.CreateSubMenu("Stash_Deposit", "Stash", "DEPOSIT SECTION")
					WarMenu.CreateSubMenu("Stash_Withdraw", "Stash", "WITHDRAW SECTION")
					WarMenu.OpenMenu("Stash")
				else
					currentItemIndex = 1
					WarMenu.OpenMenu("Stash")
				end
			else
				WarMenu.CloseMenu()
			end
			OpenMenu = false
		end
		if WarMenu.IsMenuOpened("Stash") then
			if WarMenu.Button("Deposit") then
				WarMenu.OpenMenu("Stash_Deposit")
			end
			if WarMenu.Button("Withdraw") then
				WarMenu.OpenMenu("Stash_Withdraw")
			end
			if WarMenu.Button("Close") then
				WarMenu.CloseMenu()
				TriggerServerEvent("Close.Stash")
			end
			if IsControlJustPressed(1, 177) then
				WarMenu.CloseMenu()
				TriggerServerEvent("Close.Stash")
			end
			WarMenu.Display()
		end
		if WarMenu.IsMenuOpened("Stash_Deposit") then
			for k, v in pairs(user_weapons) do
				if WarMenu.Button(Weapons_names[k].." ["..v.ammo.."]", "Deposit") then
					TriggerServerEvent("Stash.Deposit", user_weapons[k])
					WarMenu.CloseMenu()
					TriggerServerEvent("Close.Stash")
				end
			end
			WarMenu.Display()
		end
		if WarMenu.IsMenuOpened("Stash_Withdraw") then
			for k, v in pairs(Inventory) do
				if WarMenu.Button(Weapons_names[v.model], v.id) then
					TriggerServerEvent("Stash.Withdraw", v.id, Inventory[k], Dealer.Gang)
					WarMenu.CloseMenu()
					TriggerServerEvent("Close.Stash")
				end
			end
			WarMenu.Display()
		end
	end
end)

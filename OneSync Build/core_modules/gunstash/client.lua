local Rivalry = {
	Gangs = {
		[1] = vector3(1067.7310791016,-3104.767578125,-38.999946594238), -- Russian
		[2] = vector3(1095.060546875,-3098.2133789063,-38.999923706055), -- Italian
		[3] = vector3(151.70854187012,-1001.5127563477,-98.999984741211), -- Ballers
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
		Russian = {
			[1] = {
				OutsideDoor = vector3(1019.092956543,-2511.5534667969,28.483037948608),
				OutsideDoorHeading = 83.333290100098,
			},
			[2] = {
				InsideDoor = vector3(1048.0213623047,-3097.1501464844,-38.999908447266),
				InsideDoorHeading = 267.96685791016,
			}
		},
		Ballers = {
			[1] = {
				OutsideDoor = vector3(-150.23551940918, -1625.5727539063,36.848297119141),
				OutsideDoorHeading = 50.321853637695,
			},
			[2] = {
				InsideDoor = vector3(151.41645812988,-1008.0470581055,-99.000022888184),
				InsideDoorHeading = 1.0677021741867
			}
		},
		Supplier = {
			[1] = {
				OutsideDoor = vector3(-676.60150146484,-2458.1594238281,13.94439125061),
				OutsideDoorHeading = 147.26322937012,
			},
			[2] = {
				InsideDoor = vector3(992.27966308594,-3097.8132324219,-38.995861053467),
				InsideDoorHeading = 273.26727294922,
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
SupplierGang = ""

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

RegisterNetEvent("Police.Search.Stash")
AddEventHandler("Police.Search.Stash", function(Stash)
	TriggerEvent('chatMessage', "Stash:", {255, 0, 0}, "")
	for k, v in pairs(Stash) do
		TriggerEvent('chatMessage', tostring(v.id), {0, 0, 255}, tostring(Weapons_names[v.model]))
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Dealer.IsDealer or exports.policejob:getIsInService() then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			for Index = 1, #Rivalry.Gangs do
				if #(PlayerPosition - Rivalry.Gangs[Index]) <= 1.0 then
					if exports.policejob:getIsInService() then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to search the stash!")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to open stash!")
					end
					if IsControlJustPressed(1, 51) then
						if exports.policejob:getIsInService() then
							TriggerServerEvent("Police.Search.Stash", Index)
						else
							if not IsOpened then
								if Dealer.Gang == "supplier" then
									if Index == 1 then
										TriggerServerEvent("Open.Stash", "russian")
										SupplierGang = "russian"
									elseif Index == 2 then
										TriggerServerEvent("Open.Stash", "italian")
										SupplierGang = "italian"
									elseif Index == 3 then
										TriggerServerEvent("Open.Stash", "ballers")
										SupplierGang = "ballers"
									end
								else
									TriggerServerEvent("Open.Stash", Dealer.Gang)
								end
							else
								Notify("One person at a time please! For now...", 3100)
							end
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
		for Index = 1, #Rivalry.Teleporters.Russian do
	 		if Index == 1 then
	 			if #(PlayerPosition - Rivalry.Teleporters.Russian[Index].OutsideDoor) <= 1.0 then
	 				DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
	 				if IsControlJustPressed(1, 51) then
	 					TeleportPlayer(Rivalry.Teleporters.Russian[Index + 1].InsideDoor.x, Rivalry.Teleporters.Russian[Index + 1].InsideDoor.y, Rivalry.Teleporters.Russian[Index + 1].InsideDoor.z, Rivalry.Teleporters.Russian[Index + 1].InsideDoorHeading)
	 				end
	 			end
	 		else
	 			if #(PlayerPosition - Rivalry.Teleporters.Russian[Index].InsideDoor) <= 1.0 then
	 				DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
	 				if IsControlJustPressed(1, 51) then
						TeleportPlayer(Rivalry.Teleporters.Russian[Index - 1].OutsideDoor.x, Rivalry.Teleporters.Russian[Index - 1].OutsideDoor.y, Rivalry.Teleporters.Russian[Index - 1].OutsideDoor.z, Rivalry.Teleporters.Russian[Index - 1].OutsideDoorHeading)
	 				end
	 			end
	 		end
	 	end
		for Index = 1, #Rivalry.Teleporters.Supplier do
	 		if Index == 1 then
	 			if #(PlayerPosition - Rivalry.Teleporters.Supplier[Index].OutsideDoor) <= 1.0 then
	 				DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
	 				if IsControlJustPressed(1, 51) then
	 					TeleportPlayer(Rivalry.Teleporters.Supplier[Index + 1].InsideDoor.x, Rivalry.Teleporters.Supplier[Index + 1].InsideDoor.y, Rivalry.Teleporters.Supplier[Index + 1].InsideDoor.z, Rivalry.Teleporters.Supplier[Index + 1].InsideDoorHeading)
	 				end
	 			end
	 		else
	 			if #(PlayerPosition - Rivalry.Teleporters.Supplier[Index].InsideDoor) <= 1.0 then
	 				DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
	 				if IsControlJustPressed(1, 51) then
						TeleportPlayer(Rivalry.Teleporters.Supplier[Index - 1].OutsideDoor.x, Rivalry.Teleporters.Supplier[Index - 1].OutsideDoor.y, Rivalry.Teleporters.Supplier[Index - 1].OutsideDoor.z, Rivalry.Teleporters.Supplier[Index - 1].OutsideDoorHeading)
	 				end
	 			end
	 		end
	 	end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Dealer.IsDealer then
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
						if Dealer.Gang == "supplier" then
							TriggerServerEvent("Stash.Deposit", user_weapons[k], SupplierGang)
							WarMenu.CloseMenu()
							TriggerServerEvent("Close.Stash")
						else
							TriggerServerEvent("Stash.Deposit", user_weapons[k], Dealer.Gang)
							WarMenu.CloseMenu()
							TriggerServerEvent("Close.Stash")
						end
					end
				end
				WarMenu.Display()
			end
			if WarMenu.IsMenuOpened("Stash_Withdraw") then
				for k, v in pairs(Inventory) do
					if WarMenu.Button(Weapons_names[v.model], v.id) then
						if Dealer.Gang == "supplier" then
							TriggerServerEvent("Stash.Withdraw", v.id, Inventory[k], SupplierGang)
							WarMenu.CloseMenu()
							TriggerServerEvent("Close.Stash")
						else
							TriggerServerEvent("Stash.Withdraw", v.id, Inventory[k], Dealer.Gang)
							WarMenu.CloseMenu()
							TriggerServerEvent("Close.Stash")
						end
					end
				end
				WarMenu.Display()
			end
		end
	end
end)

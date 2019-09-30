--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
local currentItemIndex = 1
local selectedItemIndex = 1
local quantity = {}

local AmmoTypes = {
	["9mm"] = 83,
	[".45mm"] = 84,
	[".50mm"] = 85,
	["5.56mm"] = 86,
	["7.62mm"] = 87,
	[".44mm"] = 88,
	["12g"] = 89,
	["11g"] = 90
}

for k,v in pairs(Blackmarket_Weapons) do
	if v.Category == "Illegal" then
		for i,j in pairs(v.Items) do
			j.Quantity = {}
			for index = 1, j.Max do j.Quantity[#j.Quantity+1] = tostring(index) end
		end
	end
end

RegisterNetEvent("bm:armour")
AddEventHandler("bm:armour", function()
	SetPedArmour(PlayerPedId(), 100)
end)

RegisterNetEvent("Refill.Ammo")
AddEventHandler("Refill.Ammo", function(SelectedWeapon, Item)
	local Player = PlayerPedId()
	for k, v in pairs(Blackmarket_Weapons) do
		for i, j in pairs(v.Items) do
			if v.Category ~= "Melee" then
				if SelectedWeapon == GetHashKey(j.Weapon) then
					if AmmoTypes[j.AmmoType] == Item then
						TriggerServerEvent("weapon:refillammo", j.Weapon)
					else
						Notify("Invalid Ammotype for this weapon!", 3100)
						TriggerEvent("inventory:addQty", Item, 1)
					end
				end
			end
		end
	end	
end)

local Data = {
    HasJobTask = false,
    Meeting = nil,
    PedestrianModel = nil,
    MeetingPed = nil,
    MeetingVehicle = nil,
    Dialogue = {
        [1] = "What's cracking cuh. You didn't have the cops follow you now did you?",
        [2] = "Good... Well I have some inventory, but it's a bit limited. We don't get the big toys.",
        [3] = "As well we have a lot of customers, so our stock runs out often.",
        [4] = "Anyways.. Check out the goods. Everytihng is in the trunk.",
    },
    DialogueCompeted = false,
    OpenMenu = false,
},

local Meetings = {
    [1] = { -- Ghetto Area
		VehicleTaskCoord = vector3(68.527618408203,-1434.1994628906,28.828746795654),
		VehicleTaskCoordHeading = 141.74494934082,
		PedTaskCoord = vector3(70.65601348877,-1433.3870849609,29.311664581299),
		PedTaskHeading = 235.28324890137,
		CarModel = "oracle2",
		PedModel = -459818001,
		PedName = "Tyrone",
	},
	[2] = { -- Ghetto Area
		VehicleTaskCoord = vector3(-56.684638977051,-1420.5627441406,28.841323852539),
		VehicleTaskCoordHeading = 269.96051025391,
		PedTaskCoord = vector3(-58.642837524414,-1419.3937988281,29.326471328735), 
		PedTaskHeading = 0.071580804884434,
		CarModel = "buffalo",
		PedModel = -459818001,
		PedName = "George",
	},
	[3] = { -- Vinewood Hills
		VehicleTaskCoord = vector3(-467.49334716797,73.980682373047,58.181781768799), 
		VehicleTaskCoordHeading = 314.72985839844,
		PedTaskCoord = vector3(-469.59292602539,73.564575195313,58.661449432373), 
		PedTaskHeading = 41.771751403809,
		CarModel = "ocelot2",
		PedModel = 1182012905,
		PedName = "Adam",
	},
	[4] = { -- Rockford Hills
		VehicleTaskCoord = vector3(-863.73602294922,-240.89419555664,39.008407592773), 
		VehicleTaskCoordHeading = 206.2218170166,
		PedTaskCoord = vector3(-863.60601806641,-238.53485107422,39.519733428955), 
		PedTaskHeading = 300.31268310547,
		CarModel = "rumpo",
		PedModel = 1182012905,
		PedName = "Jake",
	},
},

RegisterNetEvent("Create.Public.Market.Meeting")
AddEventHandler("Create.Public.Market.Meeting", function()
	if Data.Meeting == nil and Data.HasJobTask == false then
		Data.Meeting = math.random(1, #Meetings)
		Data.HasJobTask = true
		Notify("The dealer has sent you a location!")
	else
		if DoesEntityExist(Data.MeetingPed) then
			DeletePed(Data.MeetingPed)
		end
		if DoesEntityExist(Data.MeetingVehicle) then
			DestroyVehicle(Data.MeetingVehicle)
		end
		Data.Meeting = math.random(1, #Meetings)
		Data.HasJobTask = true
		Notify("The dealer has sent you a new location!")
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local Player = PlayerPedId()
        local PlayerPosition = GetEntityCoords(Player, false)
        if Data.HasJobTask then
            if Data.Meeting ~= nil then
                if #(PlayerPosition - Meetings[Data.Meeting].PedTaskCoord) <= 47.0)
					if not DoesEntityExist(Data.MeetingPed) and not DoesEntityExist(Data.MeetingVehicle) then
						Data.MeetingVehicle = exports["core"]:SpawnVehicle(Meetings[Data.Meeting].CarModel, Meetings[Data.Meeting].VehicleTaskCoord, Meetings[Data.Meeting].VehicleTaskCoordHeading, false)
						Data.MeetingPed = CreatePedInsideVehicle(Data.MeetingVehicle, 1, Meetings[Data.Meeting].PedModel, -1, true, false)
                    else
                        if #(PlayerPosition - Data.Meeting) <= 6.0 then
                            TaskPedOutOfVehicle(Data.MeetingPed)
                            Citizen.Wait(4000)
                            TaskGoStraightToCoord(Data.MeetingPed, Meetings[Data.Meeting].PedTaskCoord.x, Meetings[Data.Meeting].PedTaskCoord.y, Meetings[Data.Meeting].PedTaskCoord.z, 1.0, 0, Meetings[Data.Meeting].PedTaskHeading, 0.0)
                            if DoesEntityExist(Data.MeetingVehicle) then
                                SedVehicleDoorOpen(Data.MeetingVehicle, 2)
                                if #(PlayerPosition - Meetings[Data.Meeting].PedTaskCoord) <= 2.2 then
                                    for Index = 1, #Data.Dialogue do
                                        TriggerEvent("chatMessage", Meetings[Data.Meeting].PedName, {255,255,255}, Data.Dialogue[Index])
                                        Citizen.Wait(8000)
                                        if Index == #Data.Dialogue then
                                            Data.DialogueCompleted = true    
                                        end
                                    end
                                    if Data.DialogueCompleted then
                                        DisplayHelpText("Press ~INPUT_CONTEXT~ to view weapon stock")
                                        if IsControlJustPressed(1, 51) then
                                            Data.OpenMenu = true    
                                        end
                                    end
                                end
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
        if Data.OpenMenu then
            if not WarMenu.IsMenuOpened("Blackmarket_Public_Stash_Shit") then
				if not WarMenu.DoesMenuExist("Blackmarket_Public_Stash_Shit") then
					WarMenu.CreateMenu("Blackmarket_Public_Stash_Shit", "Trunk Stash")
					WarMenu.SetSpriteTitle("Blackmarket_Public_Stash_Shit", {"shopui_title_blackmarket","shopui_title_gunclub"})
					WarMenu.SetSubTitle("Blackmarket_Public_Stash_Shit", "WEAPONS")
					WarMenu.SetMenuX("Blackmarket_Public_Stash_Shit", 0.6)
					WarMenu.SetMenuY("Blackmarket_Public_Stash_Shit", 0.15)
					for k,v in pairs(Public_Blackmarket_Weapons) do
						WarMenu.CreateSubMenu(v.Category.."_BLACKMARKET_PUBLIC_STASH", "Blackmarket_Public_Stash_Shit", v.Category)
						if v.Category == "Illegal" then
							for i,j in pairs(v.Items) do
								WarMenu.CreateSubMenu(j.Name.."_BLACKMARKET_PUBLIC_STASH", v.Category.."_BLACKMARKET_PUBLIC_STASH", j.Name.." SHOPPING CART")
							end
						else
						    for i,j in pairs(v.Items) do
								WarMenu.CreateSubMenu(j.Weapon.."_BLACKMARKET_PUBLIC_STASH", v.Category.."_BLACKMARKET_PUBLIC_STASH", j.Name.." UPGRADES")
							end
						end
					end
					WarMenu.OpenMenu("Blackmarket_Public_Stash_Shit")
				else
					currentItemIndex = 1
					WarMenu.OpenMenu("Blackmarket_Public_Stash_Shit")
				end
			end
            if WarMenu.IsMenuOpened("Blackmarket_Public_Stash_Shit") then
                for k,v in pairs(Public_Blackmarket_Weapons) do
                    if WarMenu.MenuButton(v.Category, v.Category.."_BLACKMARKET_PUBLIC_STASH") then
                    end
                end
                if WarMenu.Button("Close") then
                    WarMenu.CloseMenu()
                end
                WarMenu.Display()
            end
            for k,v in pairs(Public_Blackmarket_Weapons) do
                if WarMenu.IsMenuOpened(v.Category.."_BLACKMARKET_PUBLIC_STASH") then
                    if v.Category == "Illegal" then
                        for i,j in pairs(v.Items) do
                            if WarMenu.Button(j.Name, "$"..j.Cost) then
                                TriggerServerEvent("bmitem:buy", j.Id, 1)
                            end
                        end
                    else
                        for i,j in pairs(v.Items) do
                            if user_weapons[j.Weapon] ~= nil then
                                if WarMenu.MenuButton(j.Name, j.Weapon.."_BLACKMARKET_PUBLIC_STASH") then
                                    
                                end
                            else
                                if WarMenu.Button(j.Name, "$"..j.Cost) then
                                    TriggerServerEvent("weapon:buy_illegal", j.Weapon)
                                end
                            end
                        end
                    end
                    WarMenu.Display()
                end
            end
            for k,v in pairs(Public_Blackmarket_Weapons) do
                for i,j in pairs(v.Items) do
                    if user_weapons[j.Weapon] ~= nil then
                        if WarMenu.IsMenuOpened(j.Weapon.."_BLACKMARKET_PUBLIC_STASH") then
                            if Ammo[j.Weapon] then
                                if WarMenu.Button("Current Ammo", GetAmmoInPedWeapon(PlayerPed, GetHashKey(j.Weapon)).."/"..Ammo[j.Weapon].Max) then
                                end
                                if GetAmmoInPedWeapon(PlayerPed, GetHashKey(j.Weapon)) < Ammo[j.Weapon].Max then
                                    if WarMenu.Button(Ammo[j.Weapon].Name..Ammo[j.Weapon].Amount, "$"..Ammo[j.Weapon].Cost) then
                                        TriggerServerEvent("weapon:buyammo", j.Weapon)
                                    end
                                else
                                    if WarMenu.Button(Ammo[j.Weapon].Name..Ammo[j.Weapon].Amount, "FULL") then
                                    end
                                end
                            end
                            if Attachments[j.Weapon] then
                                for a,attachment in pairs(Attachments[j.Weapon]) do
                                    if attachment.Name ~= "Yusuf Amir Luxury Finish" and attachment.Name ~= "Platinum Pearl Deluxe Finish" and attachment.Name ~= "Etched Wood Grip Finish" and attachment.Name ~= "Gilded Gun Metal Finish" and attachment.Name ~= "Eteched Gun Metal Finish" and attachment.Name ~= "Bodyguard Variant" and attachment.Name ~= "VIP Variant" and attachment.Name ~= "Base Model" and attachment.Name ~= "The Pimp" and attachment.Name ~= "The Ballas" and attachment.Name ~= "The Hustler" and attachment.Name ~= "The Rock" and attachment.Name ~= "The Hater" and attachment.Name ~= "The Lover" and attachment.Name ~= "The Player" and attachment.Name ~= "The King" and attachment.Name ~= "The Vagos" then
                                        local key = attachment.Name:lower()
                                        key = string.gsub(key, " ", "_")
                                        if user_weapons[j.Weapon][key] == "false" then
                                            if WarMenu.Button(attachment.Name, "$"..math.floor(attachment.Cost)) then
                                                TriggerServerEvent("weapon:buyattachment", j.Weapon, attachment.Name, math.floor(attachment.Cost), attachment.Hash)
                                            end
                                        else
                                            if WarMenu.Button(attachment.Name) then
                                            end
                                        end
                                    else
                                        if user_weapons[j.Weapon].skin == attachment.Hash then
                                            if WarMenu.Button(attachment.Name) then
                                            end			        			
                                        else
                                            if WarMenu.Button(attachment.Name, "$"..math.floor(attachment.Cost)) then
                                                TriggerServerEvent("weapon:buyattachment", j.Weapon, attachment.Name, math.floor(attachment.Cost), attachment.Hash)
                                            end			        			
                                        end
                                    end
                                end
                            end
                            for a,tint in pairs(Tints) do
                                if v.Category ~= "Melee" and v.Category ~= "Throwables" and v.Category ~= "Specials" and j.Weapon ~= "GADGET_PARACHUTE" then
                                    if user_weapons[j.Weapon].skin == tint.Index then
                                        if WarMenu.Button(tint.Name) then
                                        end			        			
                                    else
                                        if WarMenu.Button(tint.Name, "$"..math.floor(tint.Cost)) then
                                            TriggerServerEvent("weapon:buyattachment", j.Weapon, tint.Name, math.floor(tint.Cost), tint.Index)
                                        end
                                    end
                                end        				
                            end
                            for _, tint in pairs(ParachuteTints) do
                                if j.Weapon == "GADGET_PARACHUTE" then
                                    if user_weapons[j.Weapon].skin == tint.Index then
                                        if WarMenu.Button(tint.Name) then
                                        end			        			
                                    else
                                        if WarMenu.Button(tint.Name, "$"..math.floor(tint.Cost)) then
                                            TriggerServerEvent("weapon:buyattachment", j.Weapon, tint.Name, math.floor(tint.Cost), tint.Index)
                                        end
                                    end
                                end											
                            end
                            if WarMenu.Button("Sell", "$"..math.floor(tonumber(user_weapons[j.Weapon].sellprice))) then
                                TriggerServerEvent("weapon:sell", j.Weapon)
                            end
                            WarMenu.Display()
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("Create.Job.Task")
AddEventHandler("Create.Job.Task", function()
    local Randomizer = math.random(1, #Meetings)
    Data.Meeting = Meetings[Randomizer].Coordinates
    Data.PedestrianModel = Meetings[Randomizer].Model
    Data.HasJobTask = true
end)

weapon_license = "false"
Citizen.CreateThread(function()
	for k,v in pairs(ammu_nation.normal) do
		addBlip(v)
	end
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local pos = GetEntityCoords(PlayerPed, false)

		for k,v in ipairs(ammu_nation.normal) do
			local Distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true)
			if Distance < 15.0 then
				RenderMarker(25, v.x, v.y, v.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if Distance < 1.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to buy weapons!")
					if IsControlJustPressed(1, 51) then
						if not WarMenu.IsMenuOpened("Weapons") then
							if not WarMenu.DoesMenuExist("Weapons") then
								WarMenu.CreateMenu("Weapons", "Gun store")
								WarMenu.SetSpriteTitle("Weapons", "shopui_title_gunclub")
								WarMenu.SetSubTitle("Weapons", "WEAPONS")
								WarMenu.SetMenuX("Weapons", 0.6)
								WarMenu.SetMenuY("Weapons", 0.15)
								for k,v in pairs(Weapons) do
									WarMenu.CreateSubMenu(v.Category, "Weapons", v.Category)
									for i,j in pairs(v.Items) do
										WarMenu.CreateSubMenu(j.Weapon, v.Category, j.Name.." UPGRADES")
									end
								end
								WarMenu.OpenMenu("Weapons")
							else
								WarMenu.OpenMenu("Weapons")
							end
						else
							WarMenu.CloseMenu()
						end
					end
					if WarMenu.IsMenuOpened("Weapons") then
						for k,v in pairs(Weapons) do
							local addCategory = true
							if v.License then
								if weapon_license ~= "true" then
									addCategory = false
								end
							end

							if addCategory then
								if WarMenu.MenuButton(v.Category, v.Category) then
								end
							end
						end
						if WarMenu.Button("Close") then
							WarMenu.CloseMenu()
						end
						WarMenu.Display()
					end
					for k,v in pairs(Weapons) do
						if WarMenu.IsMenuOpened(v.Category) then
							for i,j in pairs(v.Items) do
								if user_weapons[j.Weapon] ~= nil then
									if WarMenu.MenuButton(j.Name, j.Weapon) then
									end
								else
									if WarMenu.Button(j.Name, "$"..j.Cost) then
										TriggerServerEvent("weapon:buy", j.Weapon)
									end
								end
							end
							WarMenu.Display()
						end
					end
					for k,v in pairs(Weapons) do
						for i,j in pairs(v.Items) do
							if user_weapons[j.Weapon] ~= nil then
								if WarMenu.IsMenuOpened(j.Weapon) then
									if Ammo[j.Weapon] then
										if WarMenu.Button("Current Ammo", GetAmmoInPedWeapon(PlayerPed, GetHashKey(j.Weapon)).."/"..Ammo[j.Weapon].Max) then
										end
										if GetAmmoInPedWeapon(PlayerPed, GetHashKey(j.Weapon)) < Ammo[j.Weapon].Max then
											if WarMenu.Button(Ammo[j.Weapon].Name..Ammo[j.Weapon].Amount, "$"..Ammo[j.Weapon].Cost) then
												TriggerServerEvent("weapon:buyammo", j.Weapon)
											end
										else
											if WarMenu.Button(Ammo[j.Weapon].Name..Ammo[j.Weapon].Amount, "FULL") then
											end
										end
									end
									if Attachments[j.Weapon] then
										for a,attachment in pairs(Attachments[j.Weapon]) do
											if attachment.Name ~= "Yusuf Amir Luxury Finish" and attachment.Name ~= "Platinum Pearl Deluxe Finish" and attachment.Name ~= "Etched Wood Grip Finish" and attachment.Name ~= "Gilded Gun Metal Finish" and attachment.Name ~= "Eteched Gun Metal Finish" and attachment.Name ~= "Bodyguard Variant" and attachment.Name ~= "VIP Variant" and attachment.Name ~= "Base Model" and attachment.Name ~= "The Pimp" and attachment.Name ~= "The Ballas" and attachment.Name ~= "The Hustler" and attachment.Name ~= "The Rock" and attachment.Name ~= "The Hater" and attachment.Name ~= "The Lover" and attachment.Name ~= "The Player" and attachment.Name ~= "The King" and attachment.Name ~= "The Vagos" then
												local key = attachment.Name:lower()
												key = string.gsub(key, " ", "_")
												if user_weapons[j.Weapon][key] == "false" then
													if WarMenu.Button(attachment.Name, "$"..math.floor(attachment.Cost)) then
														TriggerServerEvent("weapon:buyattachment", j.Weapon, attachment.Name, math.floor(attachment.Cost), attachment.Hash)
													end
												else
													if WarMenu.Button(attachment.Name) then
													end
												end
											else
												if user_weapons[j.Weapon].skin == attachment.Hash then
													if WarMenu.Button(attachment.Name) then
													end			        			
												else
													if WarMenu.Button(attachment.Name, "$"..math.floor(attachment.Cost)) then
														TriggerServerEvent("weapon:buyattachment", j.Weapon, attachment.Name, math.floor(attachment.Cost), attachment.Hash)
													end			        			
												end
											end
										end
									end
									for a,tint in pairs(Tints) do
										if v.Category ~= "Melee" and v.Category ~= "Throwables" and v.Category ~= "Specials" and j.Weapon ~= "GADGET_PARACHUTE" then
											if user_weapons[j.Weapon].skin == tint.Index then
												if WarMenu.Button(tint.Name) then
												end			        			
											else
												if WarMenu.Button(tint.Name, "$"..math.floor(tint.Cost)) then
													TriggerServerEvent("weapon:buyattachment", j.Weapon, tint.Name, math.floor(tint.Cost), tint.Index)
												end
											end
										end        				
									end
									for _, tint in pairs(ParachuteTints) do
										if j.Weapon == "GADGET_PARACHUTE" then
											if user_weapons[j.Weapon].skin == tint.Index then
												if WarMenu.Button(tint.Name) then
												end			        			
											else
												if WarMenu.Button(tint.Name, "$"..math.floor(tint.Cost)) then
													TriggerServerEvent("weapon:buyattachment", j.Weapon, tint.Name, math.floor(tint.Cost), tint.Index)
												end
											end
										end											
									end
									if WarMenu.Button("Sell", "$"..math.floor(tonumber(user_weapons[j.Weapon].sellprice))) then
										TriggerServerEvent("weapon:sell", j.Weapon)
									end
									WarMenu.Display()
								end
							end
						end
					end
				elseif Distance > 1.0 then
					if WarMenu.IsMenuOpened("Weapons") then
						WarMenu.CloseMenu()
					end
				end
			end
		end
		--Blackmarket
		if ( Dealer.IsDealer and Dealer.Gang == "supplier" ) or ( Dealer.IsDealer and Dealer.Gang == "italian" ) or ( Dealer.IsDealer and Dealer.Gang == "russian" ) or ( Dealer.IsDealer and Dealer.Gang == "ballers" ) then
			for k,v in ipairs(ammu_nation.blackmarket) do
				if Dealer.Gang == v.Gang then
					local Distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true)
					if Distance < 15.0 then
						RenderMarker(25, v.x, v.y, v.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
						if Distance < 1.0 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to buy illegal items!")
							if IsControlJustPressed(1, 51) then
								if not WarMenu.IsMenuOpened("Blackmarket_Weapons") then
									if not WarMenu.DoesMenuExist("Blackmarket_Weapons") then
										WarMenu.CreateMenu("Blackmarket_Weapons", "Gun store")
										WarMenu.SetSpriteTitle("Blackmarket_Weapons", {"shopui_title_blackmarket","shopui_title_gunclub"})
										WarMenu.SetSubTitle("Blackmarket_Weapons", "WEAPONS")
										WarMenu.SetMenuX("Blackmarket_Weapons", 0.6)
										WarMenu.SetMenuY("Blackmarket_Weapons", 0.15)
										for k,v in pairs(Blackmarket_Weapons) do
											WarMenu.CreateSubMenu(v.Category.."_BLACKMARKET", "Blackmarket_Weapons", v.Category)
											if v.Category == "Illegal" then
												for i,j in pairs(v.Items) do
													WarMenu.CreateSubMenu(j.Name.."_BLACKMARKET", v.Category.."_BLACKMARKET", j.Name.." SHOPPING CART")
												end
											else
												for i,j in pairs(v.Items) do
													WarMenu.CreateSubMenu(j.Weapon.."_BLACKMARKET", v.Category.."_BLACKMARKET", j.Name.." UPGRADES")
												end
											end
										end
										WarMenu.OpenMenu("Blackmarket_Weapons")
									else
										currentItemIndex = 1
										WarMenu.OpenMenu("Blackmarket_Weapons")
									end
								else
									WarMenu.CloseMenu()
								end
							end
							if WarMenu.IsMenuOpened("Blackmarket_Weapons") then
								for k,v in pairs(Blackmarket_Weapons) do
									if WarMenu.MenuButton(v.Category, v.Category.."_BLACKMARKET") then
									end
								end
								if WarMenu.Button("Close") then
									WarMenu.CloseMenu()
								end
								WarMenu.Display()
							end
							for k,v in pairs(Blackmarket_Weapons) do
								if WarMenu.IsMenuOpened(v.Category.."_BLACKMARKET") then
									if v.Category == "Illegal" then
										for i,j in pairs(v.Items) do
											if WarMenu.Button(j.Name, "$"..j.Cost) then
												TriggerServerEvent("bmitem:buy", j.Id, 1)
											end
										end
									else
										for i,j in pairs(v.Items) do
											if user_weapons[j.Weapon] ~= nil then
												if ( Dealer.Gang == j.Gang and Dealer.IsDealer ) or ( Dealer.Gang == j.SecondaryGang and Dealer.IsDealer ) or ( j.Gang == "all" and Dealer.IsDealer ) then
													if WarMenu.MenuButton(j.Name, j.Weapon.."_BLACKMARKET") then
													end
												end
											else
												if ( Dealer.Gang == j.Gang and Dealer.IsDealer ) or ( Dealer.Gang == j.SecondaryGang and Dealer.IsDealer ) or ( j.Gang == "all" and Dealer.IsDealer ) then
													if WarMenu.Button(j.Name, "$"..j.Cost) then
														TriggerServerEvent("weapon:buy_illegal", j.Weapon)
													end
												end
											end
										end
									end
									WarMenu.Display()
								end
							end
							for k,v in pairs(Blackmarket_Weapons) do
								for i,j in pairs(v.Items) do
									if user_weapons[j.Weapon] ~= nil then
										if WarMenu.IsMenuOpened(j.Weapon.."_BLACKMARKET") then
											if Ammo[j.Weapon] then
												if WarMenu.Button("Current Ammo", GetAmmoInPedWeapon(PlayerPed, GetHashKey(j.Weapon)).."/"..Ammo[j.Weapon].Max) then
												end
												if GetAmmoInPedWeapon(PlayerPed, GetHashKey(j.Weapon)) < Ammo[j.Weapon].Max then
													if WarMenu.Button(Ammo[j.Weapon].Name..Ammo[j.Weapon].Amount, "$"..Ammo[j.Weapon].Cost) then
														TriggerServerEvent("weapon:buyammo", j.Weapon)
													end
												else
													if WarMenu.Button(Ammo[j.Weapon].Name..Ammo[j.Weapon].Amount, "FULL") then
													end
												end
											end
											if Attachments[j.Weapon] then
												for a,attachment in pairs(Attachments[j.Weapon]) do
													if attachment.Name ~= "Yusuf Amir Luxury Finish" and attachment.Name ~= "Platinum Pearl Deluxe Finish" and attachment.Name ~= "Etched Wood Grip Finish" and attachment.Name ~= "Gilded Gun Metal Finish" and attachment.Name ~= "Eteched Gun Metal Finish" and attachment.Name ~= "Bodyguard Variant" and attachment.Name ~= "VIP Variant" and attachment.Name ~= "Base Model" and attachment.Name ~= "The Pimp" and attachment.Name ~= "The Ballas" and attachment.Name ~= "The Hustler" and attachment.Name ~= "The Rock" and attachment.Name ~= "The Hater" and attachment.Name ~= "The Lover" and attachment.Name ~= "The Player" and attachment.Name ~= "The King" and attachment.Name ~= "The Vagos" then
														local key = attachment.Name:lower()
														key = string.gsub(key, " ", "_")
														if user_weapons[j.Weapon][key] == "false" then
															if WarMenu.Button(attachment.Name, "$"..math.floor(attachment.Cost)) then
																TriggerServerEvent("weapon:buyattachment", j.Weapon, attachment.Name, math.floor(attachment.Cost), attachment.Hash)
															end
														else
															if WarMenu.Button(attachment.Name) then
															end
														end
													else
														if user_weapons[j.Weapon].skin == attachment.Hash then
															if WarMenu.Button(attachment.Name) then
															end			        			
														else
															if WarMenu.Button(attachment.Name, "$"..math.floor(attachment.Cost)) then
																TriggerServerEvent("weapon:buyattachment", j.Weapon, attachment.Name, math.floor(attachment.Cost), attachment.Hash)
															end			        			
														end
													end
												end
											end
											for a,tint in pairs(Tints) do
												if v.Category ~= "Melee" and v.Category ~= "Throwables" and v.Category ~= "Specials" and j.Weapon ~= "GADGET_PARACHUTE" then
													if user_weapons[j.Weapon].skin == tint.Index then
														if WarMenu.Button(tint.Name) then
														end			        			
													else
														if WarMenu.Button(tint.Name, "$"..math.floor(tint.Cost)) then
															TriggerServerEvent("weapon:buyattachment", j.Weapon, tint.Name, math.floor(tint.Cost), tint.Index)
														end
													end
												end        				
											end
											for _, tint in pairs(ParachuteTints) do
												if j.Weapon == "GADGET_PARACHUTE" then
													if user_weapons[j.Weapon].skin == tint.Index then
														if WarMenu.Button(tint.Name) then
														end			        			
													else
														if WarMenu.Button(tint.Name, "$"..math.floor(tint.Cost)) then
															TriggerServerEvent("weapon:buyattachment", j.Weapon, tint.Name, math.floor(tint.Cost), tint.Index)
														end
													end
												end											
											end
											if WarMenu.Button("Sell", "$"..math.floor(tonumber(user_weapons[j.Weapon].sellprice))) then
												TriggerServerEvent("weapon:sell", j.Weapon)
											end
											WarMenu.Display()
										end
									end
								end
							end
						elseif Distance > 1.0 then
							if WarMenu.IsMenuOpened("Blackmarket_Weapons") then
								WarMenu.CloseMenu()
							end
						end
					end
				end
			end
		end
		--[[
		if weapon_license == "false" then
			for k,v in ipairs(ammu_nation.license) do
				if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
					RenderMarker(25, v.x, v.y, v.z 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to purchase a weapon license! (~g~$~b~10000~w~)")
						if IsControlJustPressed(1, 51) then
							TriggerServerEvent("weapon:buylicense")
						end
					end
				end
			end
		end
		-]]
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not exports.policejob:getIsInService() and not exports.emsjob:getIsInService() and not isAdmin then
        	local PlayerPed = PlayerPedId()
            local hasWeapon, currentWeapon = GetCurrentPedWeapon(PlayerPed, 1)
            if currentWeapon ~= nil then
                if IsPedArmed(PlayerPed, 7) then
                	local Weaponstring = Weaponhashes[currentWeapon] or Weaponhashes[tostring(currentWeapon)]
                	local Weaponhash = GetHashKey(Weaponstring)
                    if user_weapons[Weaponstring] then
                        if IsPedShooting(PlayerPed) then
                            local ammo = GetAmmoInPedWeapon(PlayerPed, Weaponhash)
                            if ammo ~= user_weapons[Weaponstring].ammo and ammo >= 0 then
                                user_weapons[Weaponstring].ammo = ammo
                                TriggerServerEvent("weapon:updateammo", Weaponstring, ammo)
                            end
                        end
                    else
                        if Weaponstring ~= "WEAPON_ANIMAL" then
                        	RemoveWeaponFromPed(PlayerPed, currentWeapon)
                        elseif Weaponstring == "WEAPON_ANIMAL" and IsPedHuman(PlayerPed) then
                        	RemoveWeaponFromPed(PlayerPed, currentWeapon)
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("weapon:set")
AddEventHandler("weapon:set", function(tbl)
	user_weapons = tbl
	if exports.ui:currentmenu() == "weapons" or exports.ui:currentmenu() == "deposit_weapons" then
		TriggerEvent("interaction:weapons")
	end
end)

RegisterNetEvent("weapon:set_license")
AddEventHandler("weapon:set_license", function(license)
	weapon_license = license
end)

RegisterNetEvent("weapon:sync")
AddEventHandler("weapon:sync", function(tbl)
	server_weapons = tbl
    if exports.ui:currentmenu() == "rob_weapons" then
        TriggerEvent("interaction:rob")
    end
end)

RegisterNetEvent("weapon:give")
AddEventHandler("weapon:give", function()
	local PlayerPed = PlayerPedId()
	RemoveAllPedWeapons(PlayerPed, 0)

	if not IsPedHuman(PlayerPed) then
		GiveWeaponToPed(PlayerPed, GetHashKey("WEAPON_ANIMAL"), 0, 0, true)
	end

	for k,v in pairs(user_weapons) do
		local Weaponhash = GetHashKey(k)
		GiveWeaponToPed(PlayerPed, Weaponhash, tonumber(v.ammo), 0, false)
		if v.suppressor ~= "false" then
			GiveWeaponComponentToPed(PlayerPed, Weaponhash, tonumber(v.suppressor))
		end
		if v.flashlight ~= "false" then
			GiveWeaponComponentToPed(PlayerPed, Weaponhash, tonumber(v.flashlight))
		end
		if v.extended_clip ~= "false" then
			GiveWeaponComponentToPed(PlayerPed, Weaponhash, tonumber(v.extended_clip))
		end
		if v.scope ~= "false" then
			GiveWeaponComponentToPed(PlayerPed, Weaponhash, tonumber(v.scope))
		end
		if v.grip ~= "false" then
			GiveWeaponComponentToPed(PlayerPed, Weaponhash, tonumber(v.grip))
		end
		if v.advanced_scope ~= "false" then
			GiveWeaponComponentToPed(PlayerPed, Weaponhash, tonumber(v.advanced_scope))
		end
		if k ~= "GADGET_PARACHUTE" then
			if string.len(v.skin) > 1 then
				GiveWeaponComponentToPed(PlayerPed, Weaponhash, tonumber(v.skin))
			else
				SetPedWeaponTintIndex(PlayerPed, Weaponhash, tonumber(v.skin))
			end
		else
			SetPlayerParachuteTintIndex(PlayerId(), tonumber(v.skin))
		end
	end
	TriggerEvent("aw:load")
end)
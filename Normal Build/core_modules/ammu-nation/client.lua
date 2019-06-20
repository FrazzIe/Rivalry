--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
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

local currentItemIndex = 1
local selectedItemIndex = 1
local quantity = {}
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
		if Dealer.IsDealer and Dealer.Gang == "supplier" then
			for k,v in ipairs(ammu_nation.blackmarket) do
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
											if WarMenu.MenuButton(j.Name, j.Weapon.."_BLACKMARKET") then
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
                	local Weaponstring = Weaponhashes[tostring(currentWeapon)]
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
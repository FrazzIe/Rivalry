--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
weapon_license = "false"
Citizen.CreateThread(function()
	for k,v in pairs(ammu_nation.normal) do
		addBlip(v)
	end
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId(), false)
		if weapon_license == "true" then
			for k,v in ipairs(ammu_nation.normal) do
				if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
					DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
					if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
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
								if WarMenu.MenuButton(v.Category, v.Category) then
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
											if WarMenu.Button("Current Ammo", GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(j.Weapon)).."/"..Ammo[j.Weapon].Max) then
											end
											if GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(j.Weapon)) < Ammo[j.Weapon].Max then
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
					elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
						if WarMenu.IsMenuOpened("Weapons") then
							WarMenu.CloseMenu()
						end
					end
				end
			end
		end
		--Blackmarket
		for k,v in ipairs(ammu_nation.blackmarket) do
			if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to buy weapons!")
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
									for i,j in pairs(v.Items) do
										WarMenu.CreateSubMenu(j.Weapon.."_BLACKMARKET", v.Category.."_BLACKMARKET", j.Name.." UPGRADES")
									end
								end
								WarMenu.OpenMenu("Blackmarket_Weapons")
							else
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
							WarMenu.Display()
						end
					end
					for k,v in pairs(Blackmarket_Weapons) do
						for i,j in pairs(v.Items) do
							if user_weapons[j.Weapon] ~= nil then
								if WarMenu.IsMenuOpened(j.Weapon.."_BLACKMARKET") then
									if Ammo[j.Weapon] then
										if WarMenu.Button("Current Ammo", GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(j.Weapon)).."/"..Ammo[j.Weapon].Max) then
										end
										if GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(j.Weapon)) < Ammo[j.Weapon].Max then
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
				elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
					if WarMenu.IsMenuOpened("Blackmarket_Weapons") then
						WarMenu.CloseMenu()
					end
				end
			end
		end
		--[[
		if weapon_license == "false" then
			for k,v in ipairs(ammu_nation.license) do
				if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
					DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 177, 202, 223,255, 0, 0, 0,0)
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
            local hasWeapon, currentWeapon = GetCurrentPedWeapon(PlayerPedId(), 1)
            if currentWeapon ~= nil then
                if IsPedArmed(PlayerPedId(), 7) then
                    if user_weapons[Weaponhashes[tostring(currentWeapon)]] then
                        if IsPedShooting(PlayerPedId()) then
                            local ammo = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(Weaponhashes[tostring(currentWeapon)]))
                            if ammo ~= user_weapons[Weaponhashes[tostring(currentWeapon)]].ammo and ammo >= 0 then
                                user_weapons[Weaponhashes[tostring(currentWeapon)]].ammo = ammo
                                TriggerServerEvent("weapon:updateammo", Weaponhashes[tostring(currentWeapon)], ammo)
                            end
                        end
                    else
                        RemoveWeaponFromPed(PlayerPedId(), currentWeapon)
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
	RemoveAllPedWeapons(PlayerPedId(), 0)
	for k,v in pairs(user_weapons) do
		GiveWeaponToPed(PlayerPedId(), GetHashKey(k), tonumber(v.ammo), 0, false)
		if v.suppressor ~= "false" then
			GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(k), tonumber(v.suppressor))
		end
		if v.flashlight ~= "false" then
			GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(k), tonumber(v.flashlight))
		end
		if v.extended_clip ~= "false" then
			GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(k), tonumber(v.extended_clip))
		end
		if v.scope ~= "false" then
			GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(k), tonumber(v.scope))
		end
		if v.grip ~= "false" then
			GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(k), tonumber(v.grip))
		end
		if v.advanced_scope ~= "false" then
			GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(k), tonumber(v.advanced_scope))
		end
		if k ~= "GADGET_PARACHUTE" then
			if string.len(v.skin) > 1 then
				GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(k), tonumber(v.skin))
			else
				SetPedWeaponTintIndex(PlayerPedId(), GetHashKey(k), tonumber(v.skin))
			end
		else
			SetPlayerParachuteTintIndex(PlayerId(), tonumber(v.skin))
		end
	end
	TriggerEvent("aw:load")
end)
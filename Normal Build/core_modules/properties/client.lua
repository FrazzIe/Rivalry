local properties_identifier, properties_char_id = "", 0
local properties_synced = false
local properties = {}
local time_to_pay_house_rent = 2 -- Hours
local time_to_pay_buisness_rent = 8 --Hours
local currentRentIndex, selectedRentIndex = 1, 1
local currentMoneyIndex, selectedMoneyIndex = 1, 1
local currentDirtyMoneyIndex, selectedDirtyMoneyIndex = 1, 1
local currentWeaponIndex, selectedWeaponIndex = 1, 1
local isRobbing = false
local shownHelp, shownInsideHelp, shownVaultHelp = false, false, false
local firstspawn = true
local Faggots = {7,8,9,10,11,12,13,14}

local function willPlayerLockpick()
	if getPercentage() > 40 then
		return true
	else
		return false
	end
end

RegisterNetEvent("properties:halt")
AddEventHandler("properties:halt", function()
	properties_synced = false
end)

RegisterNetEvent("properties:sync")
AddEventHandler("properties:sync", function(_properties)
	properties = _properties
	properties_synced = true
end)

RegisterNetEvent("properties:setup")
AddEventHandler("properties:setup", function(_properties, identifier, char_id)
	properties_identifier, properties_char_id = identifier, tonumber(char_id)
	properties = _properties
	properties_synced = true
	for k,v in pairs(_properties.houses.normal) do
		if firstspawn then
			addBlip({name = "Houses | Normal", sprite = 40, x = v.coordinates.x, y = v.coordinates.y, z = v.coordinates.z})
		end
	end
	for k,v in pairs(_properties.houses.enterable) do
		if firstspawn then
			addBlip({name = "Houses | Enterable", sprite = 350, x = v.coordinates.outside.x, y = v.coordinates.outside.y, z = v.coordinates.outside.z})
		end
	end
	for k,v in pairs(_properties.businesses.normal) do
		if firstspawn then
			addBlip({name = "Businesses | Normal", sprite = 374, x = v.coordinates.x, y = v.coordinates.y, z = v.coordinates.z})
		end
	end
	for k,v in pairs(_properties.businesses.enterable) do
		if firstspawn then
			addBlip({name = "Businesses | Enterable", sprite = 375, x = v.coordinates.outside.x, y = v.coordinates.outside.y, z = v.coordinates.outside.z})
		end
	end
	firstspawn = false
end)

RegisterNetEvent('play:animation')
AddEventHandler('play:animation', function()
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 1, false)
	Citizen.Wait(10000)
	ClearPedTasks(PlayerPedId())
end)

Citizen.CreateThread(function()
	WarMenu.CreateMenu("properties_menu", "Property")
	WarMenu.SetSubTitle("properties_menu", "OPTIONS")
	WarMenu.SetMenuX("properties_menu", 0.6)
	WarMenu.SetMenuY("properties_menu", 0.15)
	WarMenu.CreateSubMenu("properties_menu_rent", "properties_menu", "Rent")
	WarMenu.CreateSubMenu("properties_menu_tax", "properties_menu", "Tax")
	WarMenu.CreateSubMenu("properties_menu_information", "properties_menu", "Information")
	WarMenu.CreateSubMenu("properties_menu_vault", "properties_menu", "Vault")
	WarMenu.CreateSubMenu("properties_menu_vault_weapons_deposit", "properties_menu_vault", "Deposit")
	WarMenu.CreateSubMenu("properties_menu_vault_weapons_withdraw", "properties_menu_vault", "Withdraw")

	WarMenu.CreateMenu("properties_menu_inside", "Property")
	WarMenu.SetSubTitle("properties_menu_inside", "OPTIONS")
	WarMenu.SetMenuX("properties_menu_inside", 0.6)
	WarMenu.SetMenuY("properties_menu_inside", 0.15)
	
	WarMenu.CreateMenu("properties_vault", "Property")
	WarMenu.SetSubTitle("properties_vault", "Vault")
	WarMenu.SetMenuX("properties_vault", 0.6)
	WarMenu.SetMenuY("properties_vault", 0.15)
	WarMenu.CreateSubMenu("properties_vault_weapons_deposit", "properties_vault", "Deposit")
	WarMenu.CreateSubMenu("properties_vault_weapons_withdraw", "properties_vault", "Withdraw")
	while true do
		Citizen.Wait(0)
		if properties_synced then
			local pos = GetEntityCoords(PlayerPedId(), false)
			for k,v in pairs(properties.houses.normal) do
				if #(v.coordinates - pos) < 10 then
					RenderMarker(25, v.coordinates.x, v.coordinates.y, v.coordinates.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(v.coordinates - pos) <= 2 then
						if not shownHelp then
							shownHelp = true
							DisplayHelpText("Press ~INPUT_CONTEXT~ to view property")
						end
						if IsControlJustPressed(1, 51) then
							if not WarMenu.IsMenuOpened("properties_menu") then
								properties_synced = false
								TriggerServerEvent("properties:fetch", "houses", "normal", k)
								WarMenu.OpenMenu("properties_menu")
								WarMenu.SetTitle("properties_menu", v.property_name)
								WarMenu.SetTitle("properties_menu_rent", v.property_name)
								WarMenu.SetTitle("properties_menu_information", v.property_name)
								WarMenu.SetTitle("properties_menu_vault", v.property_name)
								WarMenu.SetTitle("properties_menu_vault_weapons_withdraw", v.property_name)
								WarMenu.SetTitle("properties_menu_vault_weapons_deposit", v.property_name)
								currentRentIndex, selectedRentIndex = 1, 1
								currentMoneyIndex, selectedMoneyIndex = 1, 1
								currentDirtyMoneyIndex, selectedDirtyMoneyIndex = 1, 1
								currentWeaponIndex, selectedWeaponIndex = 1, 1
							else
								WarMenu.CloseMenu("properties_menu")
								ClearPedTasks(PlayerPedId())
							end
						end
						if properties_synced then
							if WarMenu.IsMenuOpened("properties_menu") then
								if v.owner.identifier == "no" then --If no one owns it
									WarMenu.MenuButton("Rent", "properties_menu_rent")
									WarMenu.MenuButton("Information", "properties_menu_information")
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									if GetCurrentServerTime() < (tonumber(v.expire) + (time_to_pay_house_rent*60*60)) and GetCurrentServerTime() > tonumber(v.expire) then
										WarMenu.MenuButton("Rent", "properties_menu_rent")
									end
									if v.locked then
										if WarMenu.Button("Unlock") then
											TriggerServerEvent("properties:lock", "houses", "normal", k, "door", false)
										end
									else
										if WarMenu.Button("Lock") then
											TriggerServerEvent("properties:lock", "houses", "normal", k, "door", true)
										end
									end
									WarMenu.MenuButton("Enter", "properties_menu_vault")
									WarMenu.MenuButton("Information", "properties_menu_information")
								else --If someone owns it but it the person doesn't own it
									if not v.locked then
										WarMenu.MenuButton("Enter", "properties_menu_vault")
									else
										if WarMenu.Button("Rob") then
											TriggerServerEvent("properties:rob", "houses", "normal", k)
										end
									end
									WarMenu.MenuButton("Information", "properties_menu_information")
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_menu_rent") then
								if v.owner.identifier == "no" then --If no one owns it
									if WarMenu.Button("Rent for "..Faggots[currentRentIndex].." days", "$"..v.rent*Faggots[currentRentIndex]) then
										TriggerServerEvent("properties:rent", "houses", "normal", k, Faggots[currentRentIndex])
										TriggerEvent('play:animation')
									end
									if WarMenu.ComboBox("No. of Days", {"7","8","9","10","11","12","13","14"}, currentRentIndex, selectedRentIndex, function(currentIndex, selectedIndex)
	                    					currentRentIndex = currentIndex
	                    					selectedRentIndex = selectedIndex

	                    					-- Do your stuff here if current index was changed (don't forget to check it)
	               						end) then
	                    					-- Do your stuff here if current item was activated
	                    			end								
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									if GetCurrentServerTime() < (tonumber(v.expire) + (time_to_pay_house_rent*60*60)) and GetCurrentServerTime() > tonumber(v.expire) then
										if WarMenu.Button("Rent for "..Faggots[currentRentIndex].." days", "$"..v.rent*Faggots[currentRentIndex]) then
											TriggerServerEvent("properties:rent", "houses", "normal", k, Faggots[currentRentIndex])
											TriggerEvent('play:animation')
										end
										if WarMenu.ComboBox("No. of Days", {"7","8","9","10","11","12","13", "14"}, currentRentIndex, selectedHouseRentIndex, function(currentIndex, selectedIndex)
		                    					currentRentIndex = currentIndex
		                    					selectedRentIndex = selectedIndex

		                    					-- Do your stuff here if current index was changed (don't forget to check it)
		               						end) then
		                    					-- Do your stuff here if current item was activated
		                    			end									
									else
										WarMenu.Button("This property already belongs to you")
										WarMenu.Button("You will have a 2 hour window")
										WarMenu.Button("to re-rent the property")
									end
								else --If someone owns it but it the person doesn't own it
									WarMenu.Button("This property already belongs to someone")
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_menu_information") then
								if v.owner.identifier == "no" then --If no one owns it
									WarMenu.Button("Rent:", "$"..v.rent)
									WarMenu.Button("Due in:", "N/A")
									WarMenu.Button("Storage Type", "~w~Max")
									WarMenu.Button("Cash:", "$"..v.storage.max.cash)
									WarMenu.Button("Dirty cash:", "$"..v.storage.max.dirty)
									WarMenu.Button("Weapons:", v.storage.max.weapons)
									if exports.policejob:getIsInService() then
										if WarMenu.Button("Check Owner") then
											TriggerServerEvent("properties:check", "houses", "normal", k)
										end
									end
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									WarMenu.Button("Rent:", "$"..v.rent)
									WarMenu.Button("Due in:", GetTimeRemaining(GetCurrentServerTime(), v.expire, "short"))
									WarMenu.Button("Storage Type", "~w~Current / Max")
									WarMenu.Button("Cash:", "$"..v.storage.current.cash.."/$"..v.storage.max.cash)
									WarMenu.Button("Dirty cash:", "$"..v.storage.current.dirty.."/$"..v.storage.max.dirty)
									WarMenu.Button("Weapons:", tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons)
									if exports.policejob:getIsInService() then
										if WarMenu.Button("Check Owner") then
											TriggerServerEvent("properties:check", "houses", "normal", k)
										end
									end
								else --If someone owns it but it the person doesn't own it
									WarMenu.Button("Rent:", "$"..v.rent)
									WarMenu.Button("Due in:", GetTimeRemaining(GetCurrentServerTime(), v.expire, "short"))
									WarMenu.Button("Storage Type", "~w~Max")
									WarMenu.Button("Cash:", "$"..v.storage.max.cash)
									WarMenu.Button("Dirty cash:", "$"..v.storage.max.dirty)
									WarMenu.Button("Weapons:", v.storage.max.weapons)
									if exports.policejob:getIsInService() then
										if WarMenu.Button("Check Owner") then
											TriggerServerEvent("properties:check", "houses", "normal", k)
										end
									end
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_menu_vault") then
								if v.owner.identifier == "no" then --If no one owns it
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									if WarMenu.ComboBox("Cash ["..v.storage.current.cash.."/"..v.storage.max.cash.."]", {"Deposit", "Withdraw"}, currentMoneyIndex, selectedMoneyIndex, function(currentIndex, selectedIndex)
	                    					currentMoneyIndex = currentIndex
	                    					selectedMoneyIndex = selectedIndex

	                    					-- Do your stuff here if current index was changed (don't forget to check it)
	               						end) then
	                    					-- Do your stuff here if current item was activated
	                    					if currentMoneyIndex == 1 then
	                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
	                    						if amount ~= nil then
	                    							if math.floor(amount) > 0 then
	                    								TriggerServerEvent("properties:deposit", "houses", "normal", "cash", k, {amount = math.floor(amount)})
	                    							end
	                    						end
	                    					elseif currentMoneyIndex == 2 then
	                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
	                    						if amount ~= nil then
	                    							if math.floor(amount) > 0 then
	                    								TriggerServerEvent("properties:withdraw", "houses", "normal", "cash", k, {amount = math.floor(amount)})
	                    							end
	                    						end
	                    					end
	                    			end
									if WarMenu.ComboBox("Dirty cash ["..v.storage.current.dirty.."/"..v.storage.max.dirty.."]", {"Deposit", "Withdraw"}, currentDirtyMoneyIndex, selectedDirtyMoneyIndex, function(currentIndex, selectedIndex)
	                    					currentDirtyMoneyIndex = currentIndex
	                    					selectedDirtyMoneyIndex = selectedIndex

	                    					-- Do your stuff here if current index was changed (don't forget to check it)
	               						end) then
	                    					-- Do your stuff here if current item was activated
	                    					if currentDirtyMoneyIndex == 1 then
	                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
	                    						if amount ~= nil then
	                    							if math.floor(amount) > 0 then
	                    								TriggerServerEvent("properties:deposit", "houses", "normal", "dirty", k, {amount = math.floor(amount)})
	                    							end
	                    						end
	                    					elseif currentDirtyMoneyIndex == 2 then
	                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
	                    						if amount ~= nil then
	                    							if math.floor(amount) > 0 then
	                    								TriggerServerEvent("properties:withdraw", "houses", "normal", "dirty", k, {amount = math.floor(amount)})
	                    							end
	                    						end
	                    					end
	                    			end
									if WarMenu.ComboBox("Weapons ["..tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons.."]", {"Deposit", "Withdraw"}, currentWeaponIndex, selectedWeaponIndex, function(currentIndex, selectedIndex)
		                    				currentWeaponIndex = currentIndex
		                    				selectedWeaponIndex = selectedIndex

		                    					-- Do your stuff here if current index was changed (don't forget to check it)
		               					end) then
		                    					-- Do your stuff here if current item was activated
		                    				if currentWeaponIndex == 1 then
		                    					WarMenu.OpenMenu("properties_menu_vault_weapons_deposit")
		                    				elseif currentWeaponIndex == 2 then
		                    					WarMenu.OpenMenu("properties_menu_vault_weapons_withdraw")
		                    				end
		                    		end
								else --If someone owns it but it the person doesn't own it
									if not v.locked then
										if WarMenu.ComboBox("Cash ["..v.storage.current.cash.."/"..v.storage.max.cash.."]", {"Deposit", "Withdraw"}, currentMoneyIndex, selectedMoneyIndex, function(currentIndex, selectedIndex)
		                    					currentMoneyIndex = currentIndex
		                    					selectedMoneyIndex = selectedIndex

		                    					-- Do your stuff here if current index was changed (don't forget to check it)
		               						end) then
		                    					-- Do your stuff here if current item was activated
		                    					if currentMoneyIndex == 1 then
		                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:deposit", "houses", "normal", "cash", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					elseif currentMoneyIndex == 2 then
		                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:withdraw", "houses", "normal", "cash", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					end
		                    			end
										if WarMenu.ComboBox("Dirty cash ["..v.storage.current.dirty.."/"..v.storage.max.dirty.."]", {"Deposit", "Withdraw"}, currentDirtyMoneyIndex, selectedDirtyMoneyIndex, function(currentIndex, selectedIndex)
		                    					currentDirtyMoneyIndex = currentIndex
		                    					selectedDirtyMoneyIndex = selectedIndex

		                    					-- Do your stuff here if current index was changed (don't forget to check it)
		               						end) then
		                    					-- Do your stuff here if current item was activated
		                    					if currentDirtyMoneyIndex == 1 then
		                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:deposit", "houses", "normal", "dirty", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					elseif currentDirtyMoneyIndex == 2 then
		                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:withdraw", "houses", "normal", "dirty", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					end
		                    			end
										if WarMenu.ComboBox("Weapons ["..tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons.."]", {"Deposit", "Withdraw"}, currentWeaponIndex, selectedWeaponIndex, function(currentIndex, selectedIndex)
			                    				currentWeaponIndex = currentIndex
			                    				selectedWeaponIndex = selectedIndex

			                    					-- Do your stuff here if current index was changed (don't forget to check it)
			               					end) then
			                    					-- Do your stuff here if current item was activated
			                    				if currentWeaponIndex == 1 then
			                    					WarMenu.OpenMenu("properties_menu_vault_weapons_deposit")
			                    				elseif currentWeaponIndex == 2 then
			                    					WarMenu.OpenMenu("properties_menu_vault_weapons_withdraw")
			                    				end
			                    		end
			                    	end
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_menu_vault_weapons_deposit") then
								if v.owner.identifier == "no" then --If no one owns it
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									for i,j in pairs(user_weapons) do
										if WarMenu.Button(Weapons_names[i].." ["..j.ammo.."]", "Deposit") then
											TriggerServerEvent("properties:deposit", "houses", "normal", "weapons", k, j)
										end
									end
								else --If someone owns it but it the person doesn't own it
									if not v.locked then
										for i,j in pairs(user_weapons) do
											if WarMenu.Button(Weapons_names[i].." ["..j.ammo.."]", "Deposit") then
												TriggerServerEvent("properties:deposit", "houses", "normal", "weapons", k, j)
											end
										end
									end
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_menu_vault_weapons_withdraw") then
								if v.owner.identifier == "no" then --If no one owns it
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									for i,j in pairs(v.storage.current.weapons) do
										if WarMenu.Button(Weapons_names[j.model].." ["..j.ammo.."]", "Withdraw") then
											TriggerServerEvent("properties:withdraw", "houses", "normal", "weapons", k, {weapon_id = i, weapon = j})
										end
									end
								else --If someone owns it but it the person doesn't own it
									if not v.locked then
										for i,j in pairs(v.storage.current.weapons) do
											if WarMenu.Button(Weapons_names[j.model].." ["..j.ammo.."]", "Withdraw") then
												TriggerServerEvent("properties:withdraw", "houses", "normal", "weapons", k, {weapon_id = i, weapon = j})
											end
										end
									end
								end
								WarMenu.Display()
							end
						end
					elseif #(v.coordinates - pos) > 2 then
						shownHelp = false
						if WarMenu.IsMenuOpened("properties_menu") then
							WarMenu.CloseMenu("properties_menu")
							ClearPedTasks(PlayerPedId())
						end
						if WarMenu.IsMenuOpened("properties_menu_vault") then
							WarMenu.CloseMenu("properties_menu_vault")
							ClearPedTasks(PlayerPedId())
						end
						if WarMenu.IsMenuOpened("properties_menu_vault_weapons_withdraw") then
							WarMenu.CloseMenu("properties_menu_vault_weapons_withdraw")
							ClearPedTasks(PlayerPedId())
						end
						if WarMenu.IsMenuOpened("properties_menu_vault_weapons_deposit") then
							WarMenu.CloseMenu("properties_menu_vault_weapons_deposit")
							ClearPedTasks(PlayerPedId())
						end
						if WarMenu.IsMenuOpened("properties_menu_rent") then
							WarMenu.CloseMenu("properties_menu_rent")
							ClearPedTasks(PlayerPedId())
						end
						if WarMenu.IsMenuOpened("properties_menu_information") then
							WarMenu.CloseMenu("properties_menu_information")
							ClearPedTasks(PlayerPedId())
						end
					end
				end
			end
			for k,v in pairs(properties.houses.enterable) do
				if #(v.coordinates.outside - pos) < 10 then
					RenderMarker(25, v.coordinates.outside.x, v.coordinates.outside.y, v.coordinates.outside.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(v.coordinates.outside - pos) < 2 then
						if not shownHelp then
							shownHelp = true
							DisplayHelpText("Press ~INPUT_CONTEXT~ to view property")
						end
						if IsControlJustPressed(1, 51) then
							if not WarMenu.IsMenuOpened("properties_menu") then
								properties_synced = false
								TriggerServerEvent("properties:fetch", "houses", "enterable", k)
								WarMenu.OpenMenu("properties_menu")
								WarMenu.SetTitle("properties_menu", v.property_name)
								WarMenu.SetTitle("properties_menu_rent", v.property_name)
								WarMenu.SetTitle("properties_menu_information", v.property_name)
							else
								WarMenu.CloseMenu("properties_menu")
								ClearPedTasks(PlayerPedId())
							end
						end
						if properties_synced then
							if WarMenu.IsMenuOpened("properties_menu") then
								if v.owner.identifier == "no" then --If no one owns it
									if WarMenu.Button("View") then
										teleportPlayer(v.coordinates.inside, v.coordinates.insideheading)
									end
									WarMenu.MenuButton("Rent", "properties_menu_rent")
									WarMenu.MenuButton("Information", "properties_menu_information")
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									if GetCurrentServerTime() < (tonumber(v.expire) + (time_to_pay_house_rent*60*60)) and GetCurrentServerTime() > tonumber(v.expire) then
										WarMenu.MenuButton("Rent", "properties_menu_rent")
									end
									if v.locked then
										if WarMenu.Button("Unlock") then
											TriggerServerEvent("properties:lock", "houses", "enterable", k, "door", false)
										end
									else
										if WarMenu.Button("Lock") then
											TriggerServerEvent("properties:lock", "houses", "enterable", k, "door", true)
										end
									end
									if WarMenu.Button("Enter") then
										teleportPlayer(v.coordinates.inside, v.coordinates.insideheading)
									end
									WarMenu.MenuButton("Information", "properties_menu_information")
								else --If someone owns it but it the person doesn't own it
									if not v.locked then
										if WarMenu.Button("Enter") then
											teleportPlayer(v.coordinates.inside, v.coordinates.insideheading)
										end
									else
										if WarMenu.Button("Attempt to pick the lock") then
											TriggerServerEvent("properties:lockpick", "houses", "enterable", k)
										end
									end
									WarMenu.MenuButton("Information", "properties_menu_information")
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_menu_rent") then
								if v.owner.identifier == "no" then --If no one owns it
									if WarMenu.Button("Rent for "..Faggots[currentRentIndex].." days", "$"..v.rent*Faggots[currentRentIndex]) then
										TriggerServerEvent("properties:rent", "houses", "enterable", k, Faggots[currentRentIndex])
										TriggerEvent('play:animation')
									end
									if WarMenu.ComboBox("No. of Days", {"7","8","9","10","11","12","13", "14"}, currentRentIndex, selectedRentIndex, function(currentIndex, selectedIndex)
	                    					currentRentIndex = currentIndex
	                    					selectedRentIndex = selectedIndex

	                    					-- Do your stuff here if current index was changed (don't forget to check it)
	               						end) then
	                    					-- Do your stuff here if current item was activated
	                    			end								
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									if GetCurrentServerTime() < (tonumber(v.expire) + (time_to_pay_house_rent*60*60)) and GetCurrentServerTime() > tonumber(v.expire) then
										if WarMenu.Button("Rent for "..Faggots[currentRentIndex].." days", "$"..v.rent*Faggots[currentRentIndex]) then
											TriggerServerEvent("properties:rent", "houses", "enterable", k, Faggots[currentRentIndex])
											TriggerEvent('play:animation')
										end
										if WarMenu.ComboBox("No. of Days", {"7","8","9","10","11","12","13", "14"}, currentRentIndex, selectedRentIndex, function(currentIndex, selectedIndex)
		                    					currentRentIndex = currentIndex
		                    					selectedRentIndex = selectedIndex

		                    					-- Do your stuff here if current index was changed (don't forget to check it)
		               						end) then
		                    					-- Do your stuff here if current item was activated
		                    			end									
									else
										WarMenu.Button("This property already belongs to you")
										WarMenu.Button("You will have a 2 hour window")
										WarMenu.Button("to re-rent the property")
									end
								else --If someone owns it but it the person doesn't own it
									WarMenu.Button("This property already belongs to someone")
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_menu_information") then
								if v.owner.identifier == "no" then --If no one owns it
									WarMenu.Button("Rent:", "$"..v.rent)
									WarMenu.Button("Due in:", "N/A")
									WarMenu.Button("Storage Type", "~w~Max")
									WarMenu.Button("Cash:", "$"..v.storage.max.cash)
									WarMenu.Button("Dirty cash:", "$"..v.storage.max.dirty)
									WarMenu.Button("Weapons:", v.storage.max.weapons)
									if exports.policejob:getIsInService() then
										if WarMenu.Button("Check Owner") then
											TriggerServerEvent("properties:check", "houses", "enterable", k)
										end
									end
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									WarMenu.Button("Rent:", "$"..v.rent)
									WarMenu.Button("Due in:", GetTimeRemaining(GetCurrentServerTime(), v.expire, "short"))
									WarMenu.Button("Storage Type", "~w~Current / Max")
									WarMenu.Button("Cash:", "$"..v.storage.current.cash.."/$"..v.storage.max.cash)
									WarMenu.Button("Dirty cash:", "$"..v.storage.current.dirty.."/$"..v.storage.max.dirty)
									WarMenu.Button("Weapons:", tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons)
									if exports.policejob:getIsInService() then
										if WarMenu.Button("Check Owner") then
											TriggerServerEvent("properties:check", "houses", "enterable", k)
										end
									end
								else --If someone owns it but it the person doesn't own it
									WarMenu.Button("Rent:", "$"..v.rent)
									WarMenu.Button("Due in:", GetTimeRemaining(GetCurrentServerTime(), v.expire, "short"))
									WarMenu.Button("Storage Type", "~w~Max")
									WarMenu.Button("Cash:", "$"..v.storage.max.cash)
									WarMenu.Button("Dirty cash:", "$"..v.storage.max.dirty)
									WarMenu.Button("Weapons:", v.storage.max.weapons)
									if exports.policejob:getIsInService() then
										if WarMenu.Button("Check Owner") then
											TriggerServerEvent("properties:check", "houses", "enterable", k)
										end
									end
								end
								WarMenu.Display()
							end
						end
					elseif #(v.coordinates.outside - pos) > 2 then
						shownHelp = false
						if WarMenu.IsMenuOpened("properties_menu") then
							WarMenu.CloseMenu("properties_menu")
							ClearPedTasks(PlayerPedId())
						end
						if WarMenu.IsMenuOpened("properties_menu_rent") then
							WarMenu.CloseMenu("properties_menu_rent")
							ClearPedTasks(PlayerPedId())
						end
						if WarMenu.IsMenuOpened("properties_menu_information") then
							WarMenu.CloseMenu("properties_menu_information")
							ClearPedTasks(PlayerPedId())
						end
					end
				end
				if #(v.coordinates.inside - pos) < 10 then
					RenderMarker(25, v.coordinates.inside.x, v.coordinates.inside.y, v.coordinates.inside.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(v.coordinates.inside - pos) < 2 then
						if not shownInsideHelp then
							shownInsideHelp = true
							DisplayHelpText("Press ~INPUT_CONTEXT~ to view property")
						end
						if IsControlJustPressed(1, 51) then
							if not WarMenu.IsMenuOpened("properties_menu_inside") then
								WarMenu.SetTitle("properties_menu_inside", v.property_name)
								WarMenu.OpenMenu("properties_menu_inside")
							else
								WarMenu.CloseMenu("properties_menu_inside")
								ClearPedTasks(PlayerPedId())
							end
						end
						if WarMenu.IsMenuOpened("properties_menu_inside") then
							if v.owner.identifier == "no" then --If no one owns it
								if WarMenu.Button("Exit") then
									teleportPlayer(v.coordinates.outside, v.coordinates.outsideheading)
								end
							elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
								if v.locked then
									if WarMenu.Button("Unlock") then
										TriggerServerEvent("properties:lock", "houses", "enterable", k, "door", false)
									end
								else
									if WarMenu.Button("Lock") then
										TriggerServerEvent("properties:lock", "houses", "enterable", k, "door", true)
									end
								end
								if WarMenu.Button("Exit") then
									teleportPlayer(v.coordinates.outside, v.coordinates.outsideheading)
								end
							else --If someone owns it but it the person doesn't own it
								if WarMenu.Button("Exit") then
									teleportPlayer(v.coordinates.outside, v.coordinates.outsideheading)
								end
							end
							WarMenu.Display()
						end
					elseif #(v.coordinates.inside - pos) > 2 then
						shownInsideHelp = false
						if WarMenu.IsMenuOpened("properties_menu_inside") then
							WarMenu.CloseMenu("properties_menu_inside")
							ClearPedTasks(PlayerPedId())
						end
					end					
				end
				if  #(v.coordinates.vault - pos) < 10 then
					RenderMarker(25, v.coordinates.vault.x, v.coordinates.vault.y, v.coordinates.vault.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(v.coordinates.vault - pos) < 2 then
						if not shownVaultHelp then
							shownVaultHelp = true
							DisplayHelpText("Press ~INPUT_CONTEXT~ to open vault")
						end
						if IsControlJustPressed(1, 51) then
							if not WarMenu.IsMenuOpened("properties_vault") then
								properties_synced = false
								TriggerServerEvent("properties:fetch", "houses", "enterable", k)
								WarMenu.SetTitle("properties_vault", v.property_name)
								WarMenu.SetTitle("properties_vault_weapons_withdraw", v.property_name)
								WarMenu.SetTitle("properties_vault_weapons_deposit", v.property_name)
								currentRentIndex, selectedHouseRentIndex = 1, 1
								currentMoneyIndex, selectedMoneyIndex = 1, 1
								currentDirtyMoneyIndex, selectedDirtyMoneyIndex = 1, 1
								currentWeaponIndex, selectedWeaponIndex = 1, 1
								WarMenu.OpenMenu("properties_vault")
							else
								WarMenu.CloseMenu("properties_vault")
							end
						end
						if properties_synced then
							if WarMenu.IsMenuOpened("properties_vault") then
								if v.owner.identifier == "no" then --If no one owns it
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									if v.storage.locked then
										if WarMenu.Button("Unlock") then
											TriggerServerEvent("properties:lock", "houses", "enterable", k, "vault", false)
										end
									else
										if WarMenu.Button("Lock") then
											TriggerServerEvent("properties:lock", "houses", "enterable", k, "vault", true)
										end
									end
									if WarMenu.ComboBox("Cash ["..v.storage.current.cash.."/"..v.storage.max.cash.."]", {"Deposit", "Withdraw"}, currentMoneyIndex, selectedMoneyIndex, function(currentIndex, selectedIndex)
	                    					currentMoneyIndex = currentIndex
	                    					selectedMoneyIndex = selectedIndex

	                    					-- Do your stuff here if current index was changed (don't forget to check it)
	               						end) then
	                    					-- Do your stuff here if current item was activated
	                    					if currentMoneyIndex == 1 then
	                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
	                    						if amount ~= nil then
	                    							if math.floor(amount) > 0 then
	                    								TriggerServerEvent("properties:deposit", "houses", "enterable", "cash", k, {amount = math.floor(amount)})
	                    							end
	                    						end
	                    					elseif currentMoneyIndex == 2 then
	                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
	                    						if amount ~= nil then
	                    							if math.floor(amount) > 0 then
	                    								TriggerServerEvent("properties:withdraw", "houses", "enterable", "cash", k, {amount = math.floor(amount)})
	                    							end
	                    						end
	                    					end
	                    			end
									if WarMenu.ComboBox("Dirty cash ["..v.storage.current.dirty.."/"..v.storage.max.dirty.."]", {"Deposit", "Withdraw"}, currentDirtyMoneyIndex, selectedDirtyMoneyIndex, function(currentIndex, selectedIndex)
	                    					currentDirtyMoneyIndex = currentIndex
	                    					selectedDirtyMoneyIndex = selectedIndex

	                    					-- Do your stuff here if current index was changed (don't forget to check it)
	               						end) then
	                    					-- Do your stuff here if current item was activated
	                    					if currentDirtyMoneyIndex == 1 then
	                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
	                    						if amount ~= nil then
	                    							if math.floor(amount) > 0 then
	                    								TriggerServerEvent("properties:deposit", "houses", "enterable", "dirty", k, {amount = math.floor(amount)})
	                    							end
	                    						end
	                    					elseif currentDirtyMoneyIndex == 2 then
	                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
	                    						if amount ~= nil then
	                    							if math.floor(amount) > 0 then
	                    								TriggerServerEvent("properties:withdraw", "houses", "enterable", "dirty", k, {amount = math.floor(amount)})
	                    							end
	                    						end
	                    					end
	                    			end
									if WarMenu.ComboBox("Weapons ["..tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons.."]", {"Deposit", "Withdraw"}, currentWeaponIndex, selectedWeaponIndex, function(currentIndex, selectedIndex)
		                    				currentWeaponIndex = currentIndex
		                    				selectedWeaponIndex = selectedIndex

		                    					-- Do your stuff here if current index was changed (don't forget to check it)
		               					end) then
		                    					-- Do your stuff here if current item was activated
		                    				if currentWeaponIndex == 1 then
		                    					WarMenu.OpenMenu("properties_vault_weapons_deposit")
		                    				elseif currentWeaponIndex == 2 then
		                    					WarMenu.OpenMenu("properties_vault_weapons_withdraw")
		                    				end
		                    		end
								else --If someone owns it but it the person doesn't own it
									if not v.storage.locked then
										if WarMenu.ComboBox("Cash ["..v.storage.current.cash.."/"..v.storage.max.cash.."]", {"Deposit", "Withdraw"}, currentMoneyIndex, selectedMoneyIndex, function(currentIndex, selectedIndex)
		                    					currentMoneyIndex = currentIndex
		                    					selectedMoneyIndex = selectedIndex

		                    					-- Do your stuff here if current index was changed (don't forget to check it)
		               						end) then
		                    					-- Do your stuff here if current item was activated
		                    					if currentMoneyIndex == 1 then
		                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:deposit", "houses", "enterable", "cash", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					elseif currentMoneyIndex == 2 then
		                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:withdraw", "houses", "enterable", "cash", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					end
		                    			end
										if WarMenu.ComboBox("Dirty cash ["..v.storage.current.dirty.."/"..v.storage.max.dirty.."]", {"Deposit", "Withdraw"}, currentDirtyMoneyIndex, selectedDirtyMoneyIndex, function(currentIndex, selectedIndex)
		                    					currentDirtyMoneyIndex = currentIndex
		                    					selectedDirtyMoneyIndex = selectedIndex

		                    					-- Do your stuff here if current index was changed (don't forget to check it)
		               						end) then
		                    					-- Do your stuff here if current item was activated
		                    					if currentDirtyMoneyIndex == 1 then
		                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:deposit", "houses", "enterable", "dirty", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					elseif currentDirtyMoneyIndex == 2 then
		                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:withdraw", "houses", "enterable", "dirty", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					end
		                    			end
										if WarMenu.ComboBox("Weapons ["..tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons.."]", {"Deposit", "Withdraw"}, currentWeaponIndex, selectedWeaponIndex, function(currentIndex, selectedIndex)
			                    				currentWeaponIndex = currentIndex
			                    				selectedWeaponIndex = selectedIndex

			                    					-- Do your stuff here if current index was changed (don't forget to check it)
			               					end) then
			                    					-- Do your stuff here if current item was activated
			                    				if currentWeaponIndex == 1 then
			                    					WarMenu.OpenMenu("properties_vault_weapons_deposit")
			                    				elseif currentWeaponIndex == 2 then
			                    					WarMenu.OpenMenu("properties_vault_weapons_withdraw")
			                    				end
			                    		end
			                    	else
			                    		if WarMenu.Button("Crack vault") then
											TriggerServerEvent("properties:rob", "houses", "enterable", k)
										end
			                    	end
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_vault_weapons_deposit") then
								if v.owner.identifier == "no" then --If no one owns it
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									for i,j in pairs(user_weapons) do
										if WarMenu.Button(Weapons_names[i].." ["..j.ammo.."]", "Deposit") then
											TriggerServerEvent("properties:deposit", "houses", "enterable", "weapons", k, j)
										end
									end
								else --If someone owns it but it the person doesn't own it
									if not v.storage.locked then
										for i,j in pairs(user_weapons) do
											if WarMenu.Button(Weapons_names[i].." ["..j.ammo.."]", "Deposit") then
												TriggerServerEvent("properties:deposit", "houses", "enterable", "weapons", k, j)
											end
										end
									end
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_vault_weapons_withdraw") then
								if v.owner.identifier == "no" then --If no one owns it
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									for i,j in pairs(v.storage.current.weapons) do
										if WarMenu.Button(Weapons_names[j.model].." ["..j.ammo.."]", "Withdraw") then
											TriggerServerEvent("properties:withdraw", "houses", "enterable", "weapons", k, {weapon_id = i, weapon = j})
										end
									end
								else --If someone owns it but it the person doesn't own it
									if not v.storage.locked then
										for i,j in pairs(v.storage.current.weapons) do
											if WarMenu.Button(Weapons_names[j.model].." ["..j.ammo.."]", "Withdraw") then
												TriggerServerEvent("properties:withdraw", "houses", "enterable", "weapons", k, {weapon_id = i, weapon = j})
											end
										end
									end
								end
								WarMenu.Display()
							end
						end
					elseif #(v.coordinates.vault - pos) > 2 then
						shownVaultHelp = false
						if WarMenu.IsMenuOpened("properties_vault") then
							WarMenu.CloseMenu("properties_vault")
						end
						if WarMenu.IsMenuOpened("properties_vault_weapons_deposit") then
							WarMenu.CloseMenu("properties_vault_weapons_deposit")
						end
						if WarMenu.IsMenuOpened("properties_vault_weapons_withdraw") then
							WarMenu.CloseMenu("properties_vault_weapons_withdraw")
						end
					end
				end
			end
			for k,v in pairs(properties.businesses.normal) do
				if #(v.coordinates - pos) < 10 then
					RenderMarker(25, v.coordinates.x, v.coordinates.y, v.coordinates.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(v.coordinates - pos) < 2 then
						if not shownHelp then
							shownHelp = true
							DisplayHelpText("Press ~INPUT_CONTEXT~ to view property")
						end
						if IsControlJustPressed(1, 51) then
							properties_synced = false
							TriggerServerEvent("properties:fetch", "businesses", "normal", k)
							if not v.overdue then
								if not WarMenu.IsMenuOpened("properties_menu") then
									WarMenu.SetTitle("properties_menu", v.property_name)
									WarMenu.SetTitle("properties_menu_tax", v.property_name)
									WarMenu.SetTitle("properties_menu_information", v.property_name)
									WarMenu.SetTitle("properties_menu_vault", v.property_name)
									WarMenu.SetTitle("properties_menu_vault_weapons_withdraw", v.property_name)
									WarMenu.SetTitle("properties_menu_vault_weapons_deposit", v.property_name)
									currentRentIndex, selectedRentIndex = 1, 1
									currentMoneyIndex, selectedMoneyIndex = 1, 1
									currentDirtyMoneyIndex, selectedDirtyMoneyIndex = 1, 1
									currentWeaponIndex, selectedWeaponIndex = 1, 1
									WarMenu.OpenMenu("properties_menu")
								else
									WarMenu.CloseMenu("properties_menu")
								end
							else
								if not WarMenu.IsMenuOpened("properties_menu") then
									TriggerServerEvent("properties:fetch", "businesses", "normal", k)
									WarMenu.SetTitle("properties_menu", v.property_name)
									WarMenu.SetTitle("properties_menu_tax", v.property_name)
									WarMenu.SetTitle("properties_menu_information", v.property_name)
									currentRentIndex, selectedRentIndex = 1, 1
									currentMoneyIndex, selectedMoneyIndex = 1, 1
									currentDirtyMoneyIndex, selectedDirtyMoneyIndex = 1, 1
									currentWeaponIndex, selectedWeaponIndex = 1, 1
									WarMenu.OpenMenu("properties_menu")
								else
									WarMenu.CloseMenu("properties_menu")
								end
							end
						end
						if properties_synced then
							if WarMenu.IsMenuOpened("properties_menu") then
								if v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									if GetCurrentServerTime() > tonumber(v.expire) then
										WarMenu.MenuButton("Tax", "properties_menu_tax")
									end
									if not v.overdue then
										if v.locked then
											if WarMenu.Button("Unlock") then
												TriggerServerEvent("properties:lock", "businesses", "normal", k, "door", false)
											end
										else
											if WarMenu.Button("Lock") then
												TriggerServerEvent("properties:lock", "businesses", "normal", k, "door", true)
											end
										end
									end
									if not v.overdue then
										WarMenu.MenuButton("Enter", "properties_menu_vault")
									end
									WarMenu.MenuButton("Information", "properties_menu_information")
								else --If someone owns it but it the person doesn't own it
									if not v.locked and not v.overdue then
										WarMenu.MenuButton("Enter", "properties_menu_vault")
									else
										if WarMenu.Button("Rob") then
											TriggerServerEvent("properties:rob", "businesses", "normal", k)
										end
									end
									WarMenu.MenuButton("Information", "properties_menu_information")
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_menu_tax") then						
								if v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									if GetCurrentServerTime() > tonumber(v.expire) then
										if WarMenu.Button("Pay tax for 28 days", "$"..v.rent*28) then
											TriggerServerEvent("properties:rent", "businesses", "normal", k, 28)
											TriggerEvent('play:animation')
										end								
									else
										WarMenu.Button("This property already belongs to you")
										WarMenu.Button("You will have a 8 hour window")
										WarMenu.Button("to pay taxes when due")
									end
								else --If someone owns it but it the person doesn't own it
									WarMenu.Button("This property already belongs to someone")
								end
								WarMenu.Display()
							end
							if WarMenu.IsMenuOpened("properties_menu_information") then
								if v.owner.identifier == "no" then --If no one owns it
									WarMenu.Button("Tax:", "$"..v.rent)
									WarMenu.Button("Due in:", "N/A")
									WarMenu.Button("Income:", "$"..v.income)
									WarMenu.Button("Storage Type", "~w~Max")
									WarMenu.Button("Cash:", "$"..v.storage.max.cash)
									WarMenu.Button("Dirty cash:", "$"..v.storage.max.dirty)
									WarMenu.Button("Weapons:", v.storage.max.weapons)
									if exports.policejob:getIsInService() then
										if WarMenu.Button("Check Owner") then
											TriggerServerEvent("properties:check", "businesses", "normal", k)
										end
									end
								elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
									WarMenu.Button("Tax:", "$"..v.rent)
									WarMenu.Button("Due in:", GetTimeRemaining(GetCurrentServerTime(), v.expire, "short"))
									WarMenu.Button("Income:", "$"..v.income)
									WarMenu.Button("Storage Type", "~w~Current / Max")
									WarMenu.Button("Cash:", "$"..v.storage.current.cash.."/$"..v.storage.max.cash)
									WarMenu.Button("Dirty cash:", "$"..v.storage.current.dirty.."/$"..v.storage.max.dirty)
									WarMenu.Button("Weapons:", tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons)
									if exports.policejob:getIsInService() then
										if WarMenu.Button("Check Owner") then
											TriggerServerEvent("properties:check", "businesses", "normal", k)
										end
									end
								else --If someone owns it but it the person doesn't own it
									WarMenu.Button("Tax:", "$"..v.rent)
									WarMenu.Button("Due in:", GetTimeRemaining(GetCurrentServerTime(), v.expire, "short"))
									WarMenu.Button("Income:", "$"..v.income)
									WarMenu.Button("Storage Type", "~w~Max")
									WarMenu.Button("Cash:", "$"..v.storage.max.cash)
									WarMenu.Button("Dirty cash:", "$"..v.storage.max.dirty)
									WarMenu.Button("Weapons:", v.storage.max.weapons)
									if exports.policejob:getIsInService() then
										if WarMenu.Button("Check Owner") then
											TriggerServerEvent("properties:check", "businesses", "normal", k)
										end
									end
								end
								WarMenu.Display()
							end
							if not v.overdue then
								if WarMenu.IsMenuOpened("properties_menu_vault") then
									if v.owner.identifier == "no" then --If no one owns it
									elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
										if WarMenu.ComboBox("Cash ["..v.storage.current.cash.."/"..v.storage.max.cash.."]", {"Deposit", "Withdraw"}, currentMoneyIndex, selectedMoneyIndex, function(currentIndex, selectedIndex)
		                    					currentMoneyIndex = currentIndex
		                    					selectedMoneyIndex = selectedIndex

		                    					-- Do your stuff here if current index was changed (don't forget to check it)
		               						end) then
		                    					-- Do your stuff here if current item was activated
		                    					if currentMoneyIndex == 1 then
		                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:deposit", "businesses", "normal", "cash", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					elseif currentMoneyIndex == 2 then
		                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:withdraw", "businesses", "normal", "cash", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					end
		                    			end
										if WarMenu.ComboBox("Dirty cash ["..v.storage.current.dirty.."/"..v.storage.max.dirty.."]", {"Deposit", "Withdraw"}, currentDirtyMoneyIndex, selectedDirtyMoneyIndex, function(currentIndex, selectedIndex)
		                    					currentDirtyMoneyIndex = currentIndex
		                    					selectedDirtyMoneyIndex = selectedIndex

		                    					-- Do your stuff here if current index was changed (don't forget to check it)
		               						end) then
		                    					-- Do your stuff here if current item was activated
		                    					if currentDirtyMoneyIndex == 1 then
		                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:deposit", "businesses", "normal", "dirty", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					elseif currentDirtyMoneyIndex == 2 then
		                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
		                    						if amount ~= nil then
		                    							if math.floor(amount) > 0 then
		                    								TriggerServerEvent("properties:withdraw", "businesses", "normal", "dirty", k, {amount = math.floor(amount)})
		                    							end
		                    						end
		                    					end
		                    			end
										if WarMenu.ComboBox("Weapons ["..tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons.."]", {"Deposit", "Withdraw"}, currentWeaponIndex, selectedWeaponIndex, function(currentIndex, selectedIndex)
			                    				currentWeaponIndex = currentIndex
			                    				selectedWeaponIndex = selectedIndex

			                    					-- Do your stuff here if current index was changed (don't forget to check it)
			               					end) then
			                    					-- Do your stuff here if current item was activated
			                    				if currentWeaponIndex == 1 then
			                    					WarMenu.OpenMenu("properties_menu_vault_weapons_deposit")
			                    				elseif currentWeaponIndex == 2 then
			                    					WarMenu.OpenMenu("properties_menu_vault_weapons_withdraw")
			                    				end
			                    		end
									else --If someone owns it but it the person doesn't own it
										if not v.locked then
											if WarMenu.ComboBox("Cash ["..v.storage.current.cash.."/"..v.storage.max.cash.."]", {"Deposit", "Withdraw"}, currentMoneyIndex, selectedMoneyIndex, function(currentIndex, selectedIndex)
			                    					currentMoneyIndex = currentIndex
			                    					selectedMoneyIndex = selectedIndex

			                    					-- Do your stuff here if current index was changed (don't forget to check it)
			               						end) then
			                    					-- Do your stuff here if current item was activated
			                    					if currentMoneyIndex == 1 then
			                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
			                    						if amount ~= nil then
			                    							if math.floor(amount) > 0 then
			                    								TriggerServerEvent("properties:deposit", "businesses", "normal", "cash", k, {amount = math.floor(amount)})
			                    							end
			                    						end
			                    					elseif currentMoneyIndex == 2 then
			                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
			                    						if amount ~= nil then
			                    							if math.floor(amount) > 0 then
			                    								TriggerServerEvent("properties:withdraw", "businesses", "normal", "cash", k, {amount = math.floor(amount)})
			                    							end
			                    						end
			                    					end
			                    			end
											if WarMenu.ComboBox("Dirty cash ["..v.storage.current.dirty.."/"..v.storage.max.dirty.."]", {"Deposit", "Withdraw"}, currentDirtyMoneyIndex, selectedDirtyMoneyIndex, function(currentIndex, selectedIndex)
			                    					currentDirtyMoneyIndex = currentIndex
			                    					selectedDirtyMoneyIndex = selectedIndex

			                    					-- Do your stuff here if current index was changed (don't forget to check it)
			               						end) then
			                    					-- Do your stuff here if current item was activated
			                    					if currentDirtyMoneyIndex == 1 then
			                    						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
			                    						if amount ~= nil then
			                    							if math.floor(amount) > 0 then
			                    								TriggerServerEvent("properties:deposit", "businesses", "normal", "dirty", k, {amount = math.floor(amount)})
			                    							end
			                    						end
			                    					elseif currentDirtyMoneyIndex == 2 then
			                    						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
			                    						if amount ~= nil then
			                    							if math.floor(amount) > 0 then
			                    								TriggerServerEvent("properties:withdraw", "businesses", "normal", "dirty", k, {amount = math.floor(amount)})
			                    							end
			                    						end
			                    					end
			                    			end
											if WarMenu.ComboBox("Weapons ["..tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons.."]", {"Deposit", "Withdraw"}, currentWeaponIndex, selectedWeaponIndex, function(currentIndex, selectedIndex)
				                    				currentWeaponIndex = currentIndex
				                    				selectedWeaponIndex = selectedIndex

				                    					-- Do your stuff here if current index was changed (don't forget to check it)
				               					end) then
				                    					-- Do your stuff here if current item was activated
				                    				if currentWeaponIndex == 1 then
				                    					WarMenu.OpenMenu("properties_menu_vault_weapons_deposit")
				                    				elseif currentWeaponIndex == 2 then
				                    					WarMenu.OpenMenu("properties_menu_vault_weapons_withdraw")
				                    				end
				                    		end
				                    	end
									end
									WarMenu.Display()
								end
								if WarMenu.IsMenuOpened("properties_menu_vault_weapons_deposit") and not v.overdue then
									if v.owner.identifier == "no" then --If no one owns it
									elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
										for i,j in pairs(user_weapons) do
											if WarMenu.Button(Weapons_names[i].." ["..j.ammo.."]", "Deposit") then
												TriggerServerEvent("properties:deposit", "businesses", "normal", "weapons", k, j)
											end
										end
									else --If someone owns it but it the person doesn't own it
										if not v.locked then
											for i,j in pairs(user_weapons) do
												if WarMenu.Button(Weapons_names[i].." ["..j.ammo.."]", "Deposit") then
													TriggerServerEvent("properties:deposit", "businesses", "normal", "weapons", k, j)
												end
											end
										end
									end
									WarMenu.Display()
								end
								if WarMenu.IsMenuOpened("properties_menu_vault_weapons_withdraw") and not v.overdue then
									if v.owner.identifier == "no" then --If no one owns it
									elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
										for i,j in pairs(v.storage.current.weapons) do
											if WarMenu.Button(Weapons_names[j.model].." ["..j.ammo.."]", "Withdraw") then
												TriggerServerEvent("properties:withdraw", "businesses", "normal", "weapons", k, {weapon_id = i, weapon = j})
											end
										end
									else --If someone owns it but it the person doesn't own it
										if not v.locked then
											for i,j in pairs(v.storage.current.weapons) do
												if WarMenu.Button(Weapons_names[j.model].." ["..j.ammo.."]", "Withdraw") then
													TriggerServerEvent("properties:withdraw", "businesses", "normal", "weapons", k, {weapon_id = i, weapon = j})
												end
											end
										end
									end
									WarMenu.Display()
								end
							end
						end
					elseif #(v.coordinates - pos) > 2 then
						shownHelp = false
						if WarMenu.IsMenuOpened("properties_menu") then
							WarMenu.CloseMenu("properties_menu")
						end
						if WarMenu.IsMenuOpened("properties_menu_vault") then
							WarMenu.CloseMenu("properties_menu_vault")
						end
						if WarMenu.IsMenuOpened("properties_menu_vault_weapons_withdraw") then
							WarMenu.CloseMenu("properties_menu_vault_weapons_withdraw")
						end
						if WarMenu.IsMenuOpened("properties_menu_vault_weapons_deposit") then
							WarMenu.CloseMenu("properties_menu_vault_weapons_deposit")
						end
						if WarMenu.IsMenuOpened("properties_menu_tax") then
							WarMenu.CloseMenu("properties_menu_tax")
						end
						if WarMenu.IsMenuOpened("properties_menu_information") then
							WarMenu.CloseMenu("properties_menu_information")
						end
					end
				end
			end
			-- for k,v in pairs(properties.businesses.enterable) do
			-- 	local OutsideDistance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coordinates.outside.x, v.coordinates.outside.y, v.coordinates.outside.z, true)
			-- 	local InsideDistance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coordinates.inside.x, v.coordinates.inside.y, v.coordinates.inside.z, true)
			-- 	local VaultDistance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coordinates.vault.x, v.coordinates.vault.y, v.coordinates.vault.z, true)

			-- 	if OutsideDistance < 10 then
			-- 		RenderMarker(25, v.coordinates.outside.x, v.coordinates.outside.y, v.coordinates.outside.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
			-- 		if OutsideDistance < 2 then
			-- 			if not shownHelp then
			-- 				shownHelp = true
			-- 				DisplayHelpText("Press ~INPUT_CONTEXT~ to view property")
			-- 			end
			-- 			if IsControlJustPressed(1, 51) then
			-- 				properties_synced = false
			-- 				TriggerServerEvent("properties:fetch", "businesses", "enterable", k)
			-- 				if not WarMenu.IsMenuOpened("properties_menu") then
			-- 					WarMenu.OpenMenu("properties_menu")
			-- 					WarMenu.SetTitle("properties_menu", v.property_name)
			-- 					WarMenu.SetTitle("properties_menu_tax", v.property_name)
			-- 					WarMenu.SetTitle("properties_menu_information", v.property_name)
			-- 				else
			-- 					WarMenu.CloseMenu("properties_menu")
			-- 				end
			-- 			end
			-- 			if properties_synced then
			-- 				if WarMenu.IsMenuOpened("properties_menu") then
			-- 					if v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
			-- 						if GetCurrentServerTime() > tonumber(v.expire) then
			-- 							WarMenu.MenuButton("Tax", "properties_menu_tax")
			-- 						end
			-- 						if not v.overdue then
			-- 							if v.locked then
			-- 								if WarMenu.Button("Unlock") then
			-- 									TriggerServerEvent("properties:lock", "businesses", "enterable", k, "door", false)
			-- 								end
			-- 							else
			-- 								if WarMenu.Button("Lock") then
			-- 									TriggerServerEvent("properties:lock", "businesses", "enterable", k, "door", true)
			-- 								end
			-- 							end
			-- 							if WarMenu.Button("Enter") then
			-- 								teleportPlayer(v.coordinates.inside)
			-- 							end
			-- 						end
			-- 						WarMenu.MenuButton("Information", "properties_menu_information")
			-- 					else --If someone owns it but it the person doesn't own it
			-- 						if not v.overdue then
			-- 							if not v.locked then
			-- 								if WarMenu.Button("Enter") then
			-- 									teleportPlayer(v.coordinates.inside)
			-- 								end
			-- 							end
			-- 						end
			-- 						if WarMenu.Button("Attempt to pick the lock") then
			-- 							TriggerServerEvent("properties:lockpick", "businesses", "enterable", k)
			-- 						end
			-- 						WarMenu.MenuButton("Information", "properties_menu_information")
			-- 					end
			-- 					WarMenu.Display()
			-- 				end
			-- 				if WarMenu.IsMenuOpened("properties_menu_tax") then						
			-- 					if v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
			-- 						if GetCurrentServerTime() > tonumber(v.expire) then
			-- 							if WarMenu.Button("Pay tax for 28 days", "$"..v.rent*28) then
			-- 								TriggerServerEvent("properties:rent", "businesses", "enterable", k, 28)
			-- 								TriggerEvent('play:animation')
			-- 							end								
			-- 						else
			-- 							WarMenu.Button("This property already belongs to you")
			-- 							WarMenu.Button("You will have a 8 hour window")
			-- 							WarMenu.Button("to pay taxes when due")
			-- 						end
			-- 					else --If someone owns it but it the person doesn't own it
			-- 						WarMenu.Button("This property already belongs to someone")
			-- 					end
			-- 					WarMenu.Display()
			-- 				end
			-- 				if WarMenu.IsMenuOpened("properties_menu_information") then
			-- 					if v.owner.identifier == "no" then --If no one owns it
			-- 						WarMenu.Button("Tax:", "$"..v.rent)
			-- 						WarMenu.Button("Due in:", "N/A")
			-- 						WarMenu.Button("Income:", "$"..v.income)
			-- 						WarMenu.Button("Storage Type", "~w~Max")
			-- 						WarMenu.Button("Cash:", "$"..v.storage.max.cash)
			-- 						WarMenu.Button("Dirty cash:", "$"..v.storage.max.dirty)
			-- 						WarMenu.Button("Weapons:", v.storage.max.weapons)
			-- 						if exports.policejob:getIsInService() then
			-- 							if WarMenu.Button("Check Owner") then
			-- 								TriggerServerEvent("properties:check", "businesses", "enterable", k)
			-- 							end
			-- 						end
			-- 					elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
			-- 						WarMenu.Button("Tax:", "$"..v.rent)
			-- 						WarMenu.Button("Due in:", GetTimeRemaining(GetCurrentServerTime(), v.expire, "short"))
			-- 						WarMenu.Button("Income:", "$"..v.income)
			-- 						WarMenu.Button("Storage Type", "~w~Current / Max")
			-- 						WarMenu.Button("Cash:", "$"..v.storage.current.cash.."/$"..v.storage.max.cash)
			-- 						WarMenu.Button("Dirty cash:", "$"..v.storage.current.dirty.."/$"..v.storage.max.dirty)
			-- 						WarMenu.Button("Weapons:", tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons)
			-- 						if exports.policejob:getIsInService() then
			-- 							if WarMenu.Button("Check Owner") then
			-- 								TriggerServerEvent("properties:check", "businesses", "enterable", k)
			-- 							end
			-- 						end
			-- 					else --If someone owns it but it the person doesn't own it
			-- 						WarMenu.Button("Tax:", "$"..v.rent)
			-- 						WarMenu.Button("Due in:", GetTimeRemaining(GetCurrentServerTime(), v.expire, "short"))
			-- 						WarMenu.Button("Income:", "$"..v.income)
			-- 						WarMenu.Button("Storage Type", "~w~Max")
			-- 						WarMenu.Button("Cash:", "$"..v.storage.max.cash)
			-- 						WarMenu.Button("Dirty cash:", "$"..v.storage.max.dirty)
			-- 						WarMenu.Button("Weapons:", v.storage.max.weapons)
			-- 						if exports.policejob:getIsInService() then
			-- 							if WarMenu.Button("Check Owner") then
			-- 								TriggerServerEvent("properties:check", "businesses", "enterable", k)
			-- 							end
			-- 						end
			-- 					end
			-- 					WarMenu.Display()
			-- 				end
			-- 			end
			-- 		elseif OutsideDistance > 2 then
			-- 			shownHelp = false
			-- 			if WarMenu.IsMenuOpened("properties_menu") then
			-- 				WarMenu.CloseMenu("properties_menu")
			-- 			end
			-- 			if WarMenu.IsMenuOpened("properties_menu_tax") then
			-- 				WarMenu.CloseMenu("properties_menu_tax")
			-- 			end
			-- 			if WarMenu.IsMenuOpened("properties_menu_information") then
			-- 				WarMenu.CloseMenu("properties_menu_information")
			-- 			end
			-- 		end
			-- 	end
			-- 	if InsideDistance < 10 then
			-- 		RenderMarker(25, v.coordinates.inside.x, v.coordinates.inside.y, v.coordinates.inside.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
			-- 		if InsideDistance < 2 then
			-- 			if not shownInsideHelp then
			-- 				shownInsideHelp = true
			-- 				DisplayHelpText("Press ~INPUT_CONTEXT~ to view property")
			-- 			end
			-- 			if IsControlJustPressed(1, 51) then
			-- 				if not WarMenu.IsMenuOpened("properties_menu_inside") then
			-- 					WarMenu.SetTitle("properties_menu_inside", v.property_name)
			-- 					WarMenu.OpenMenu("properties_menu_inside")
			-- 				else
			-- 					WarMenu.CloseMenu("properties_menu_inside")
			-- 				end
			-- 			end
			-- 			if WarMenu.IsMenuOpened("properties_menu_inside") then
			-- 				if v.owner.identifier == "no" then --If no one owns it
			-- 					if WarMenu.Button("Exit") then
			-- 						teleportPlayer(v.coordinates.outside)
			-- 					end
			-- 				elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
			-- 					if not v.overdue then
			-- 						if v.locked then
			-- 							if WarMenu.Button("Unlock") then
			-- 								TriggerServerEvent("properties:lock", "businesses", "enterable", k, "door", false)
			-- 							end
			-- 						else
			-- 							if WarMenu.Button("Lock") then
			-- 								TriggerServerEvent("properties:lock", "businesses", "enterable", k, "door", true)
			-- 							end
			-- 						end
			-- 					end
			-- 					if WarMenu.Button("Exit") then
			-- 						teleportPlayer(v.coordinates.outside)
			-- 					end
			-- 				else --If someone owns it but it the person doesn't own it
			-- 					if WarMenu.Button("Exit") then
			-- 						teleportPlayer(v.coordinates.outside)
			-- 					end
			-- 				end
			-- 				WarMenu.Display()
			-- 			end
			-- 		elseif InsideDistance > 2 then
			-- 			shownInsideHelp = false
			-- 			if WarMenu.IsMenuOpened("properties_menu_inside") then
			-- 				WarMenu.CloseMenu("properties_menu_inside")
			-- 			end
			-- 		end					
			-- 	end
			-- 	if VaultDistance < 10 then
			-- 		RenderMarker(25, v.coordinates.vault.x, v.coordinates.vault.y, v.coordinates.vault.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
			-- 		if VaultDistance < 2 then
			-- 			if not shownVaultHelp then
			-- 				shownVaultHelp = true
			-- 				DisplayHelpText("Press ~INPUT_CONTEXT~ to open vault")
			-- 			end
			-- 			if IsControlJustPressed(1, 51) then
			-- 				properties_synced = false
			-- 				TriggerServerEvent("properties:fetch", "businesses", "enterable", k)
			-- 				if not v.overdue then
			-- 					if not WarMenu.IsMenuOpened("properties_vault") then
			-- 						WarMenu.SetTitle("properties_vault", v.property_name)
			-- 						WarMenu.SetTitle("properties_vault_weapons_withdraw", v.property_name)
			-- 						WarMenu.SetTitle("properties_vault_weapons_deposit", v.property_name)
			-- 						currentRentIndex, selectedRentIndex = 1, 1
			-- 						currentMoneyIndex, selectedMoneyIndex = 1, 1
			-- 						currentDirtyMoneyIndex, selectedDirtyMoneyIndex = 1, 1
			-- 						currentWeaponIndex, selectedWeaponIndex = 1, 1
			-- 						WarMenu.OpenMenu("properties_vault")
			-- 					else
			-- 						WarMenu.CloseMenu("properties_vault")
			-- 					end
			-- 				else
			-- 					if not WarMenu.IsMenuOpened("properties_vault") then
			-- 						currentRentIndex, selectedRentIndex = 1, 1
			-- 						currentMoneyIndex, selectedMoneyIndex = 1, 1
			-- 						currentDirtyMoneyIndex, selectedDirtyMoneyIndex = 1, 1
			-- 						currentWeaponIndex, selectedWeaponIndex = 1, 1
			-- 						WarMenu.OpenMenu("properties_vault")
			-- 					else
			-- 						WarMenu.CloseMenu("properties_vault")
			-- 					end
			-- 				end
			-- 			end
			-- 			if properties_synced then
			-- 				if not v.overdue then
			-- 					if WarMenu.IsMenuOpened("properties_vault") then
			-- 						if v.owner.identifier == "no" then --If no one owns it
			-- 						elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
			-- 							if v.storage.locked then
			-- 								if WarMenu.Button("Unlock") then
			-- 									TriggerServerEvent("properties:lock", "businesses", "enterable", k, "vault", false)
			-- 								end
			-- 							else
			-- 								if WarMenu.Button("Lock") then
			-- 									TriggerServerEvent("properties:lock", "businesses", "enterable", k, "vault", true)
			-- 								end
			-- 							end
			-- 							if WarMenu.ComboBox("Cash ["..v.storage.current.cash.."/"..v.storage.max.cash.."]", {"Deposit", "Withdraw"}, currentMoneyIndex, selectedMoneyIndex, function(currentIndex, selectedIndex)
		    --                 					currentMoneyIndex = currentIndex
		    --                 					selectedMoneyIndex = selectedIndex

		    --                 					-- Do your stuff here if current index was changed (don't forget to check it)
		    --            						end) then
		    --                 					-- Do your stuff here if current item was activated
		    --                 					if currentMoneyIndex == 1 then
		    --                 						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
		    --                 						if amount ~= nil then
		    --                 							if math.floor(amount) > 0 then
		    --                 								TriggerServerEvent("properties:deposit", "businesses", "enterable", "cash", k, {amount = math.floor(amount)})
		    --                 							end
		    --                 						end
		    --                 					elseif currentMoneyIndex == 2 then
		    --                 						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
		    --                 						if amount ~= nil then
		    --                 							if math.floor(amount) > 0 then
		    --                 								TriggerServerEvent("properties:withdraw", "businesses", "enterable", "cash", k, {amount = math.floor(amount)})
		    --                 							end
		    --                 						end
		    --                 					end
		    --                 			end
			-- 							if WarMenu.ComboBox("Dirty cash ["..v.storage.current.dirty.."/"..v.storage.max.dirty.."]", {"Deposit", "Withdraw"}, currentDirtyMoneyIndex, selectedDirtyMoneyIndex, function(currentIndex, selectedIndex)
		    --                 					currentDirtyMoneyIndex = currentIndex
		    --                 					selectedDirtyMoneyIndex = selectedIndex

		    --                 					-- Do your stuff here if current index was changed (don't forget to check it)
		    --            						end) then
		    --                 					-- Do your stuff here if current item was activated
		    --                 					if currentDirtyMoneyIndex == 1 then
		    --                 						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
		    --                 						if amount ~= nil then
		    --                 							if math.floor(amount) > 0 then
		    --                 								TriggerServerEvent("properties:deposit", "businesses", "enterable", "dirty", k, {amount = math.floor(amount)})
		    --                 							end
		    --                 						end
		    --                 					elseif currentDirtyMoneyIndex == 2 then
		    --                 						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
		    --                 						if amount ~= nil then
		    --                 							if math.floor(amount) > 0 then
		    --                 								TriggerServerEvent("properties:withdraw", "businesses", "enterable", "dirty", k, {amount = math.floor(amount)})
		    --                 							end
		    --                 						end
		    --                 					end
		    --                 			end
			-- 							if WarMenu.ComboBox("Weapons ["..tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons.."]", {"Deposit", "Withdraw"}, currentWeaponIndex, selectedWeaponIndex, function(currentIndex, selectedIndex)
			--                     				currentWeaponIndex = currentIndex
			--                     				selectedWeaponIndex = selectedIndex

			--                     					-- Do your stuff here if current index was changed (don't forget to check it)
			--                					end) then
			--                     					-- Do your stuff here if current item was activated
			--                     				if currentWeaponIndex == 1 then
			--                     					WarMenu.OpenMenu("properties_vault_weapons_deposit")
			--                     				elseif currentWeaponIndex == 2 then
			--                     					WarMenu.OpenMenu("properties_vault_weapons_withdraw")
			--                     				end
			--                     		end
			-- 						else --If someone owns it but it the person doesn't own it
			-- 							if not v.storage.locked then
			-- 								if WarMenu.ComboBox("Cash ["..v.storage.current.cash.."/"..v.storage.max.cash.."]", {"Deposit", "Withdraw"}, currentMoneyIndex, selectedMoneyIndex, function(currentIndex, selectedIndex)
			--                     					currentMoneyIndex = currentIndex
			--                     					selectedMoneyIndex = selectedIndex

			--                     					-- Do your stuff here if current index was changed (don't forget to check it)
			--                						end) then
			--                     					-- Do your stuff here if current item was activated
			--                     					if currentMoneyIndex == 1 then
			--                     						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
			--                     						if amount ~= nil then
			--                     							if math.floor(amount) > 0 then
			--                     								TriggerServerEvent("properties:deposit", "businesses", "enterable", "cash", k, {amount = math.floor(amount)})
			--                     							end
			--                     						end
			--                     					elseif currentMoneyIndex == 2 then
			--                     						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
			--                     						if amount ~= nil then
			--                     							if math.floor(amount) > 0 then
			--                     								TriggerServerEvent("properties:withdraw", "businesses", "enterable", "cash", k, {amount = math.floor(amount)})
			--                     							end
			--                     						end
			--                     					end
			--                     			end
			-- 								if WarMenu.ComboBox("Dirty cash ["..v.storage.current.dirty.."/"..v.storage.max.dirty.."]", {"Deposit", "Withdraw"}, currentDirtyMoneyIndex, selectedDirtyMoneyIndex, function(currentIndex, selectedIndex)
			--                     					currentDirtyMoneyIndex = currentIndex
			--                     					selectedDirtyMoneyIndex = selectedIndex

			--                     					-- Do your stuff here if current index was changed (don't forget to check it)
			--                						end) then
			--                     					-- Do your stuff here if current item was activated
			--                     					if currentDirtyMoneyIndex == 1 then
			--                     						local amount = tonumber(KeyboardInput("How much will you be depositing?", 1000, 11))
			--                     						if amount ~= nil then
			--                     							if math.floor(amount) > 0 then
			--                     								TriggerServerEvent("properties:deposit", "businesses", "enterable", "dirty", k, {amount = math.floor(amount)})
			--                     							end
			--                     						end
			--                     					elseif currentDirtyMoneyIndex == 2 then
			--                     						local amount = tonumber(KeyboardInput("How much will you be withdrawing?", 1000, 11))
			--                     						if amount ~= nil then
			--                     							if math.floor(amount) > 0 then
			--                     								TriggerServerEvent("properties:withdraw", "businesses", "enterable", "dirty", k, {amount = math.floor(amount)})
			--                     							end
			--                     						end
			--                     					end
			--                     			end
			-- 								if WarMenu.ComboBox("Weapons ["..tablelength(v.storage.current.weapons).."/"..v.storage.max.weapons.."]", {"Deposit", "Withdraw"}, currentWeaponIndex, selectedWeaponIndex, function(currentIndex, selectedIndex)
			-- 	                    				currentWeaponIndex = currentIndex
			-- 	                    				selectedWeaponIndex = selectedIndex

			-- 	                    					-- Do your stuff here if current index was changed (don't forget to check it)
			-- 	               					end) then
			-- 	                    					-- Do your stuff here if current item was activated
			-- 	                    				if currentWeaponIndex == 1 then
			-- 	                    					WarMenu.OpenMenu("properties_vault_weapons_deposit")
			-- 	                    				elseif currentWeaponIndex == 2 then
			-- 	                    					WarMenu.OpenMenu("properties_vault_weapons_withdraw")
			-- 	                    				end
			-- 	                    		end
			-- 	                    	else
			-- 	                    		if WarMenu.Button("Crack vault") then
			-- 									TriggerServerEvent("properties:rob", "businesses", "enterable", k)
			-- 								end
			-- 	                    	end
			-- 						end
			-- 						WarMenu.Display()
			-- 					end
			-- 				end
			-- 				if WarMenu.IsMenuOpened("properties_vault_weapons_deposit") then
			-- 					if v.owner.identifier == "no" then --If no one owns it
			-- 					elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
			-- 						for i,j in pairs(user_weapons) do
			-- 							if WarMenu.Button(Weapons_names[i].." ["..j.ammo.."]", "Deposit") then
			-- 								TriggerServerEvent("properties:deposit", "businesses", "enterable", "weapons", k, j)
			-- 							end
			-- 						end
			-- 					else --If someone owns it but it the person doesn't own it
			-- 						if not v.storage.locked then
			-- 							for i,j in pairs(user_weapons) do
			-- 								if WarMenu.Button(Weapons_names[i].." ["..j.ammo.."]", "Deposit") then
			-- 									TriggerServerEvent("properties:deposit", "businesses", "enterable", "weapons", k, j)
			-- 								end
			-- 							end
			-- 						end
			-- 					end
			-- 					WarMenu.Display()
			-- 				end
			-- 				if WarMenu.IsMenuOpened("properties_vault_weapons_withdraw") then
			-- 					if v.owner.identifier == "no" then --If no one owns it
			-- 					elseif v.owner.id == GetPlayerServerId(PlayerId()) then --If the person owns it
			-- 						for i,j in pairs(v.storage.current.weapons) do
			-- 							if WarMenu.Button(Weapons_names[j.model].." ["..j.ammo.."]", "Withdraw") then
			-- 								TriggerServerEvent("properties:withdraw", "businesses", "enterable", "weapons", k, {weapon_id = i, weapon = j})
			-- 							end
			-- 						end
			-- 					else --If someone owns it but it the person doesn't own it
			-- 						if not v.storage.locked  then
			-- 							for i,j in pairs(v.storage.current.weapons) do
			-- 								if WarMenu.Button(Weapons_names[j.model].." ["..j.ammo.."]", "Withdraw") then
			-- 									TriggerServerEvent("properties:withdraw", "businesses", "enterable", "weapons", k, {weapon_id = i, weapon = j})
			-- 								end
			-- 							end
			-- 						end
			-- 					end
			-- 					WarMenu.Display()
			-- 				end
			-- 			end
			-- 		elseif VaultDistance > 2 then
			-- 			shownVaultHelp = false
			-- 			if WarMenu.IsMenuOpened("properties_vault") then
			-- 				WarMenu.CloseMenu("properties_vault")
			-- 			end
			-- 			if WarMenu.IsMenuOpened("properties_vault_weapons_deposit") then
			-- 				WarMenu.CloseMenu("properties_vault_weapons_deposit")
			-- 			end
			-- 			if WarMenu.IsMenuOpened("properties_vault_weapons_withdraw") then
			-- 				WarMenu.CloseMenu("properties_vault_weapons_withdraw")
			-- 			end
			-- 		end
			-- 	end
			-- end
		end
	end
end)
RegisterNetEvent("properties:rob")
AddEventHandler("properties:rob", function(property_type, property_variant, property_id, phase, phase_max)
	WarMenu.CloseMenu()
	isRobbing = true
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start", GetRandomIntInRange(3, 9), properties[property_type][property_variant][property_id]["robbing"]["time"]/phase_max, "Starting Hack.. Phase "..phase.." of "..phase_max,function(success)
		if success then
			if phase == phase_max then
				isRobbing = false
				TriggerServerEvent("properties:rob_finish", property_type, property_variant, property_id, {cash = getPercentage(), dirty = getPercentage()}, true)
				TriggerEvent("mhacking:hide")
			else
				TriggerEvent("properties:rob", property_type, property_variant, property_id, phase+1, phase_max)
			end
		else
			isRobbing = false
			TriggerEvent("mhacking:hide")
			TriggerServerEvent("properties:rob_finish", property_type, property_variant, property_id, {cash = getPercentage(), dirty = getPercentage()}, false)
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isRobbing then
			if IsEntityDead(PlayerPedId()) then
				TriggerEvent("mhacking:fail")
				isRobbing = false
			end
			if exports.policejob:getIsCuffed() then
				TriggerEvent("mhacking:fail")
				isRobbing = false
			end
			if IsPedSittingInAnyVehicle(PlayerPedId()) then
				TriggerEvent("mhacking:fail")
				isRobbing = false
			end
		end
	end
end)

RegisterNetEvent("properties:lockpick")
AddEventHandler("properties:lockpick", function(property_type, property_variant, property_id)
	WarMenu.CloseMenu()
	TriggerEvent("dispatch:lockpick_property")
	Citizen.CreateThread(function()
		local endTime = GetGameTimer() + 25000
		while endTime > GetGameTimer() do
		DisableControlAction(1, 51, true)
		Citizen.Wait(0)
			RequestAnimDict("mini@safe_cracking")
			if not HasAnimDictLoaded("mini@safe_cracking") then
				Citizen.Wait(0)
			end
			if not IsEntityPlayingAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_anti_fast", 3) then
				TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_anti_fast", 8.0, -4.0, -1, 9, 0, false, false, false)
			end
		end
		ClearPedTasks(PlayerPedId())
		if willPlayerLockpick() then
			PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
			TriggerServerEvent("properties:lock", property_type, property_variant, property_id, "door", false)
		else
			PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
		end
	end)
end)
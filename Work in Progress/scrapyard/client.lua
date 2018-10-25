local IsScrap = true
local OnDuty = false
local isSearching = false
local Scrap = {
	Data = {
		Doors = {
			{x = -589.53009033203, y = -1621.603515625, z = 33.161777496338, h = 174.73043823242, model = 812467272},
			{x = -590.82397460938, y = -1621.5015869141, z = 33.162761688232, h = 354.52551269531, model = 812467272},
			{x = -1048.2850341797, y = -236.81707763672, z = 44.170997619629, h = 117.5, model = -1821777087},
			{x = -1047.0837402344, y = -239.12460327148, z = 44.170997619629, h = 297.50003051758, model = -1821777087},
		},
		Blips = {},
		Sand = 0,
		Service = {x = -618.65423583984, y = -1623.2392578125, z = 33.010543823242, h = 174.02153015137},
		Items = {
		    [1] = {name = "Aluminum Can", item_id = 66},
		    [2] = {name = "Copper Wire", item_id = 67},
		    [3] = {name = "Light Iron", item_id = 68},
		    [4] = {name = "Copper Tubing", item_id = 69},
		    [5] = {name = "Brass Scrap", item_id = 70},
		    [6] = {name = "Bronze Scrap", item_id = 71},
		    [7] = {name = "Golden Ring", item_id = 72},
		    [8] = {name = "Silver Necklace", item_id = 73},
		    [9] = {name = "Silver Earing", item_id = 74},
		},
		Container = {
		    {Category = "Scrapyard Stockpile", Items = {
		    	[1] = {Name = "Scrap", Id = 75, price = 300, Max = 20, sellprice = 150},
		    }},
		},
		Recycle = {x = -602.00280761719, y = -1602.7091064453, z = 30.405181884766, h = 266.00207519531},
		MarketLocation = {x = -593.80462646484, y = -1608.1984863281, z = 27.010789871216, h = 353.60125732422},
		Chop = {x = -525.25061035156, y = -1722.2807617188, z = 19.123287200928, h = 228.57734680176},
		MetalObjects = {},
	},
},

local Stockpile = {}

RegisterNetEvent('scrapyard:sync')
AddEventHandler('scrapyard:sync', function(table)
	Stockpile = table
end)

RegisterNetEvent("scrapyard:set")
AddEventHandler("scrapyard:set", function(_IsScrap)
	OnDuty = false
	IsScrap = _IsScrap
end)

function DrawJobBlips()
	for k, v in ipairs(--[[INSERT TABLE--]]) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 316)
		SetBlipColour(blip, 11)
		SetBlipAsShortRange(blip, true)
		SetBlipScale(blip, 0.85)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(--[["INSERT NAME"--]])
		EndTextCommandSetBlipName(blip)
		table.insert(Scrap.Data.Blips, blip)
	end
end

function DeleteJobBlips()
	for k, v in ipairs(Scrap.Data.Blips) do
		RemoveBlip(v)
		table.remove(Scrap.Data.Blips, k)
	end
end

Citizen.CreateThread(function()
	CreateBlip("Rogers Salvage & Scrap", 356, 68, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z)
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId(), 0)
		for k, v in ipairs(Scrap.Data.Doors) do
			local entity = GetClosestObjectOfType(v.x, v.y, v.z, 5.0, v.model, 0, 1, 1)
			SetEntityAsMissionEntity(entity, true, true)
			DeleteEntity(entity)
		end
		if IsScrap then
			if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z) < 10 then
				DrawMarker(25, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z) < 1 then
					if OnDuty then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to sign off duty")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to sign on duty")
					end
					if IsControlJustPressed(1, 51) then
						OnDuty = not OnDuty
					end
				end
			end
			if OnDuty then
				if Vdist(pos.x pos.y, pos.z, Scrap.Data.Recycle.x, Scrap.Data.Recycle.y, Scrap.Data.Recycle.z) < 10 then
					DrawMarker(25, Scrap.Data.Recycle.x, Scrap.Data.Recycle.y, Scrap.Data.Recycle.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
					if Vdist(pos.x pos.y, pos.z, Scrap.Data.Recycle.x, Scrap.Data.Recycle.y, Scrap.Data.Recycle.z) < 1 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to use the recycler!")
						if IsControlJustPressed(1, 51) then
							for k, v in ipairs(Scrap.Data.Items) do
								if GetItemQuantity(v.item_id) > 0 then
									TriggerEvent('inventory:removeQty', v.item_id, GetItemQuantity(v.item_id))
									TriggerServerEvent('scrapyard:addStock', math.floor((GetItemQuantity(v.item_id)/10)))
								end
							end
						end
					end
				end
				if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Chop.x, Scrap.Data.Chop.y, Scrap.Data.Chop.z) < 20 then
					drawMarker(25, Scrap.Data.Chop.x, Scrap.Data.Chop.y, Scrap.Data.Chop.z, 3.0, 3.0, 3.5, 255, 255, 0, 255)
					if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Chop.x, Scrap.Data.Chop.y, Scrap.Data.Chop.z) < 2 then
						if IsPedSittingInAnyVehicle(PlayerPedId()) then
							local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
							if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
								DisplayHelpText("Press ~INPUT_CONTEXT~ to chop for clean money!\nPress ~INPUT_DETONATE~ to chop for dirty money!")
								if IsControlJustPressed(1, 51) then
									local owned = false
									local playervehicle = false
									for k,v in pairs(user_vehicles) do
										if v.plate == GetVehicleNumberPlateText(vehicle) then
											playervehicle = true
											break
										end
									end
									if not owned then
										local class = GetVehicleClass(vehicle)
									    for seat = -1, GetVehicleMaxNumberOfPassengers(vehicle) do
									        if not IsVehicleSeatFree(vehicle, seat) then
									            TaskLeaveVehicle(GetPedInVehicleSeat(vehicle, seat), vehicle, 0)
									        end
									    end
									    NetworkRequestControlOfEntity(vehicle)
									    while not NetworkHasControlOfEntity(vehicle) do
									        Citizen.Wait(0)
									    end
									    SetEntityAsMissionEntity(vehicle, true, true)
									    while IsPedInAnyVehicle(PlayerPedId(), true) do
									        Citizen.Wait(0)
									    end
									    DestroyVehicle(vehicle)
									    if playervehicle then
											TriggerServerEvent("chopshop:pay", "clean", class)
										else
											TriggerServerEvent("chopshop:pay", "clean", 22)
										end
									else
										Notify("We don't accept that type of vehicle!", 3000)
									end
								end
								if IsControlJustPressed(1, 47) then
									local owned = false
									local playervehicle = false
									for k,v in pairs(user_vehicles) do
										if v.plate == GetVehicleNumberPlateText(vehicle) then
											playervehicle = true
											break
										end
									end
									if not owned then
										local class = GetVehicleClass(vehicle)
									    for seat = -1, GetVehicleMaxNumberOfPassengers(vehicle) do
									        if not IsVehicleSeatFree(vehicle, seat) then
									            TaskLeaveVehicle(GetPedInVehicleSeat(vehicle, seat), vehicle, 0)
									        end
									    end
									    NetworkRequestControlOfEntity(vehicle)
									    while not NetworkHasControlOfEntity(vehicle) do
									        Citizen.Wait(0)
									    end
									    SetEntityAsMissionEntity(vehicle, true, true)
									    while IsPedInAnyVehicle(PlayerPedId(), true) do
									        Citizen.Wait(0)
									    end
									    DestroyVehicle(vehicle)
									    if playervehicle then
											TriggerServerEvent("chopshop:pay", "dirty", class)
										else
											TriggerServerEvent("chopshop:pay", "dirty", 22)
										end
									else
										Notify("We don't accept that type of vehicle!", 3000)
									end
								end
							end
						end
					end
				end
				--[[for k, v in ipairs(Scrap.Data.MetalObjects) do
					local entity = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1, v, 0, 1, 1)
					if entity then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to pick up this item!")
						if IsControlJustPressed(1, 51) then
							RequestAnimDict("anim@heists@box_carry@")
							while not HasAnimDictLoaded("anim@heists@box_carry@") do
								Citizen.Wait(0)
							end
							TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "walk", -4.0, 4.0, -1, 49, 0, false, false, false)
							if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "walk", 0) then
								TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "walk", -4.0, 4.0, -1, 49, 0, false, false, false)
							end
							AttachEntityToEntity(entity1, entity2, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, vertexIndex, fixedRot)
						end
					end
				end--]]
			end
		end
	end
end)

for k,v in pairs(Scrap.Data.Container) do
		for i,j in pairs(v.Items) do
			j.Quantity = {}
			for index = 1, j.Max do j.Quantity[#j.Quantity+1] = tostring(index) end
		end
	end

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			for k,v in ipairs(Scrap.Data.MarketLocation) do
				if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
					DrawMarker(25,v.x, v.y, v.z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
						if IsControlJustPressed(1, 51) then
							if not WarMenu.IsMenuOpened("ScrapMarket") then
								if not WarMenu.DoesMenuExist("ScrapMarket") then
									WarMenu.CreateMenu("ScrapMarket", "Scrap Stockpile")
									WarMenu.SetSpriteTitle("ScrapMarket", "shopui_title_graphics_sale")
									WarMenu.SetSubTitle("ScrapMarket", "Welcome to the Scrapyard!")
									WarMenu.SetMenuX("ScrapMarket", 0.6)
									WarMenu.SetMenuY("ScrapMarket", 0.15)
									WarMenu.SetTitleBackgroundColor("ScrapMarket", 0, 107, 87)
									for k,v in pairs(Scrap.Data.Container) do
										WarMenu.CreateSubMenu(v.Category, "ScrapMarket", v.Category.." SECTION")
										for i,j in pairs(v.Items) do
											WarMenu.CreateSubMenu(j.Name, v.Category, j.Name)
										end
									end
									WarMenu.OpenMenu("ScrapMarket")
								else
									currentItemIndex = 1
									WarMenu.OpenMenu("ScrapMarket")
								end
							else
								WarMenu.CloseMenu()
							end		
						end
						if WarMenu.IsMenuOpened("ScrapMarket") then
							for k,v in pairs(Scrap.Data.Container) do
								WarMenu.MenuButton(v.Category, v.Category)
							end
							if WarMenu.Button("Close") then
								WarMenu.CloseMenu()
							end
							WarMenu.Display()
						end
						for k,v in pairs(Scrap.Data.Container) do
							if WarMenu.IsMenuOpened(v.Category) then
								for i,j in pairs(v.Items) do
									if WarMenu.MenuButton(j.Name, j.Name) then
										currentItemIndex = 1
									end
								end
								WarMenu.Display()
							end
						end
						for k,v in pairs(Scrap.Data.Container) do
							for i,j in pairs(v.Items) do
								if WarMenu.IsMenuOpened(j.Name) then
									if WarMenu.Button("Buy "..currentItemIndex.." "..j.Name.."(s)", "$"..j.price*currentItemIndex) then
										if GetItemQuantity(j.Id) > 0 then
											TriggerServerEvent('scrapyard:giveScrap', j.id, currentItemIndex)
										else
											TriggerEvent('chatMessage', "You don't have that amount of scrap!")
										end
									end
									if WarMenu.Button("Sell "..currentItemIndex.." "..j.Name.."(s)", "$"..j.sellprice*currentItemIndex) then
										if GetItemQuantity(j.Id) > 0 and currentItemIndex <= GetItemQuantity(j.Id) then
											TriggerEvent('inventory:removeQty', j.Id, currentItemIndex)
											TriggerServerEvent('addScrap', currentItemIndex)
										else
											TriggerEvent('chatMessage', "You don't have that amount of scrap!")
										end
									end
									if WarMenu.ComboBox("Quantity", j.Quantity, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
										currentItemIndex = currentIndex
										selectedItemIndex = selectedIndex
									end) then
									end
									WarMenu.Display()
								end
							end
						end
					elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
						if WarMenu.IsMenuOpened("ScrapMarket") then
							WarMenu.CloseMenu()
						end
					end
				end
			end
		end
	end)
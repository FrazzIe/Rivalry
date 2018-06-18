local Pool, ShopMenu = NativeUI.CreatePool(), NativeUI.CreateMenu("", "Categories", 1300, 300)
local Preview, PreviewHandles = {}, {}
local LastItemSelected = nil

Pool:Add(ShopMenu)

local function CreateCategory(Title)
	local Item = NativeUI.CreateItem(Title, "")
	ShopMenu:AddItem(Item)
	local Menu = UIMenu.New("", Title, ShopMenu.Position.X, ShopMenu.Position.Y)
	Pool:Add(Menu)
	ShopMenu:BindMenuToItem(Menu, Item)
	return Item, Menu
end

local function CreateVehicleItem(SubMenu, Name, Price)
	local Item = NativeUI.CreateItem(Name,  "The "..Name.." can be purchased for $"..Price)
	SubMenu:AddItem(Item)
	local Menu = UIMenu.New("", Name, SubMenu.Position.X, SubMenu.Position.Y)
	Pool:Add(Menu)
	SubMenu:BindMenuToItem(Menu, Item)
	return Item, Menu
end

function GetStockVehicle()
	local Neon, Mods = {}, {}

	for i = 0, 3, 1 do
		Neon[i+1] = false
	end

	for i = 0, 48, 1 do
		if (i <= 16 or i >= 23) and i ~= 47 and i ~= 9 then
			Mods[tostring(i)] = -1
		end
	end

	local StockVehicle = {
		Mods = Mods,
		Wheels = {
			Type = 7,
			Bulletproof = false,
			Front = {
				Handle = -1,
				Custom = false,
			},
			Rear = {
				Handle = -1,
				Custom = false,
			},
		},
		Neon = Neon,
		Turbo = false,
		TyreSmoke = false,
		XenonLights = false,
		Colour = {
			Primary = 12,
			Secondary = 12,
			Pearlescent = 12,
			Wheel = 35,
			Neon = {Red = 255, Green = 255, Blue = 255},
			Smoke = {Red = 255, Green = 255, Blue = 255},
			Tint = -1,
			Plate = 0,
		},
		Health = {
			Engine = 1000,
			Petrol = 1000,
			Vehicle = 1000,
			Body = 1000,
		},
	}

	return StockVehicle
end

function PackVehicle(Vehicle)
	if not DoesEntityExist(Vehicle) then return GetStockVehicle() end
	local Primary, Secondary = GetVehicleColours(Vehicle)
	local Pearlescent, Wheel = GetVehicleExtraColours(Vehicle)
	local SmokeColour, NeonColour = table.pack(GetVehicleTyreSmokeColor(Vehicle)), table.pack(GetVehicleNeonLightsColour(Vehicle))
	local Neon, Mods = {}, {}

	for i = 0, 3, 1 do
		Neon[i+1] = tobool(IsVehicleNeonLightEnabled(Vehicle, i))
	end

	for i = 0, 48, 1 do
		if (i <= 16 or i >= 23) and i ~= 47 and i ~= 9 then
			Mods[tostring(i)] = GetVehicleMod(Vehicle, i)
		end
	end
	local PackedVehicle = {
		Mods = Mods,
		Wheels = {
			Type = GetVehicleWheelType(Vehicle),
			Bulletproof = tobool(not GetVehicleTyresCanBurst(Vehicle)),
			Front = {
				Handle = GetVehicleMod(Vehicle, 23),
				Custom = tobool(GetVehicleModVariation(Vehicle, 23)),
			},
			Rear = {
				Handle = GetVehicleMod(Vehicle, 24),
				Custom = tobool(GetVehicleModVariation(Vehicle, 24)),
			},
		},
		Neon = Neon,
		Turbo = tobool(IsToggleModOn(Vehicle, 18)),
		TyreSmoke = tobool(IsToggleModOn(Vehicle, 20)),
		XenonLights = tobool(IsToggleModOn(Vehicle, 22)),
		Colour = {
			Primary = Primary,
			Secondary = Secondary,
			Pearlescent = Pearlescent,
			Wheel = Wheel,
			Neon = {Red = NeonColour[1], Green = NeonColour[2], Blue = NeonColour[3]},
			Smoke = {Red = SmokeColour[1], Green = SmokeColour[2], Blue = SmokeColour[3]},
			Tint = GetVehicleWindowTint(Vehicle),
			Plate = GetVehicleNumberPlateTextIndex(Vehicle),
		},
		Health = {
			Engine = GetVehicleEngineHealth(Vehicle),
			Petrol = GetVehiclePetrolTankHealth(Vehicle),
			Vehicle = GetEntityHealth(Vehicle),
			Body = GetVehicleBodyHealth(Vehicle),
		},
	}

	return PackedVehicle
end

function OpenShop(Type, Location)
	SetEntityVisible(Player.Ped, false)
	SetEntityInvincible(Player.Ped, true)
	FreezeEntityPosition(Player.Ped, true)
	SetEntityCoords(Player.Ped, Location.Inside.x, Location.Inside.y, GetGroundZ(Location.Inside.x, Location.Inside.y, Location.Inside.z))
	SetEntityHeading(Player.Ped, Location.Inside.h)
	SetFollowVehicleCamZoomLevel(2)
	SetFollowPedCamViewMode(2)
	ShopMenu:Clear()
	ShopMenu:SetBannerSprite(NativeUI.CreateSprite(Config.Dealership.Sprites[Type].Dictionary, Config.Dealership.Sprites[Type].Texture))
	ShopMenu.OnMenuClosed = function(Menu)
		SetEntityVisible(Player.Ped, true)
		SetEntityInvincible(Player.Ped, false)
		FreezeEntityPosition(Player.Ped, false)
		SetEntityCoords(Player.Ped, Location.Marker.x, Location.Marker.y, Location.Marker.z)
		SetEntityHeading(Player.Ped, Location.Marker.h)
		if Preview.Handle then
			if Preview.Handle ~= 0 then
				DeleteVehicle(Preview.Handle)
				Preview = {}
			end
		end
		for i = 1, #PreviewHandles do
			SetEntityCoords(PreviewHandles[i], 601.28948974609, -4396.9853515625, 384.98565673828)
		end
		PreviewHandles = {}
	end
	for Index = 1, #Config.Dealership.Vehicles[Type] do
		local SubMenuItem, SubMenu = CreateCategory(Config.Dealership.Vehicles[Type][Index].Title)
		SubMenu:SetBannerSprite(NativeUI.CreateSprite(Config.Dealership.Sprites[Type].Dictionary, Config.Dealership.Sprites[Type].Texture))
		SubMenuItem.Activated = function(ParentMenu, SelectedItem)
			Citizen.CreateThread(function()
				local ThreadStart = GetGameTimer()
				if Config.Dealership.Vehicles[Type][Index].Items[SubMenu:CurrentSelection()] then
					if Preview.Model ~= Config.Dealership.Vehicles[Type][Index].Items[SubMenu:CurrentSelection()].Model then
						if Preview.Handle then
							if Preview.Handle ~= 0 then
								DeleteVehicle(Preview.Handle)
								Preview = {}
							end
						end
						Preview = Config.Dealership.Vehicles[Type][Index].Items[SubMenu:CurrentSelection()]
						local model = GetHashKey(Preview.Model)
						RequestModel(model)
						while not HasModelLoaded(model) and ThreadStart + 40000 > GetGameTimer() do
							Citizen.Wait(0)
						end
						if ThreadStart + 40000 > GetGameTimer() then
							Preview.Handle = CreateVehicle(model, Location.Inside.x, Location.Inside.y, Location.Inside.z, Location.Inside.h, false, false)
							table.insert(PreviewHandles, Preview.Handle)
							while not DoesEntityExist(Preview.Handle) and ThreadStart + 40000 > GetGameTimer() do
								Citizen.Wait(0)
							end
							if ThreadStart + 40000 > GetGameTimer() then
								FreezeEntityPosition(Preview.Handle, true)
								SetEntityInvincible(Preview.Handle, true)
								SetVehicleDoorsLocked(Preview.Handle, 4)
								TaskWarpPedIntoVehicle(Player.Ped, Preview.Handle, -1)
								SetModelAsNoLongerNeeded(model)
								SetVehicleModKit(Preview.Handle, 0)
								for i = 0, 48 do
									SetVehicleMod(Preview.Handle, i, -1, false)
									ToggleVehicleMod(Preview.Handle, i, false)
								end
								SetFollowVehicleCamZoomLevel(2)
							end
						end
					end
				end
			end)
		end
		SubMenu.OnIndexChange = function(ParentMenu, NewIndex)
			Citizen.CreateThread(function()
				local ThreadStart = GetGameTimer()
				ParentMenu:Visible(false)
				if Preview.Handle then
					if Preview.Handle ~= 0 then
						DeleteVehicle(Preview.Handle)
						Preview = {}
					end
				end
				Preview = Config.Dealership.Vehicles[Type][Index].Items[NewIndex]
				local model = GetHashKey(Preview.Model)
				RequestModel(model)
				while not HasModelLoaded(model) and ThreadStart + 40000 > GetGameTimer() do
					Citizen.Wait(0)
				end
				if ThreadStart + 40000 > GetGameTimer() then
					Preview.Handle = CreateVehicle(model, Location.Inside.x, Location.Inside.y, Location.Inside.z, Location.Inside.h, false, false)
					table.insert(PreviewHandles, Preview.Handle)
					while not DoesEntityExist(Preview.Handle) and ThreadStart + 40000 > GetGameTimer() do
						Citizen.Wait(0)
					end
					if ThreadStart + 40000 > GetGameTimer() then
						FreezeEntityPosition(Preview.Handle, true)
						SetEntityInvincible(Preview.Handle, true)
						SetVehicleDoorsLocked(Preview.Handle, 4)
						TaskWarpPedIntoVehicle(Player.Ped, Preview.Handle, -1)
						SetModelAsNoLongerNeeded(model)
						SetVehicleModKit(Preview.Handle, 0)
						for i = 0, 48 do
							SetVehicleMod(Preview.Handle, i, -1, false)
							ToggleVehicleMod(Preview.Handle, i, false)
						end
						SetFollowVehicleCamZoomLevel(2)
					end
				end
				ParentMenu:Visible(true)
			end)
		end
		for Vehicle = 1, #Config.Dealership.Vehicles[Type][Index].Items do
			local SubSubMenuItem, SubSubMenu = CreateVehicleItem(SubMenu, Config.Dealership.Vehicles[Type][Index].Items[Vehicle].Name, Config.Dealership.Vehicles[Type][Index].Items[Vehicle].Price)
			SubSubMenu:SetBannerSprite(NativeUI.CreateSprite(Config.Dealership.Sprites[Type].Dictionary, Config.Dealership.Sprites[Type].Texture))
			SubSubMenuItem:RightLabel("$"..Config.Dealership.Vehicles[Type][Index].Items[Vehicle].Price)
			local PurchaseItem = NativeUI.CreateItem("Purchase", "The "..Config.Dealership.Vehicles[Type][Index].Items[Vehicle].Name.." can be purchased for $"..Config.Dealership.Vehicles[Type][Index].Items[Vehicle].Price)
			PurchaseItem:RightLabel("$"..Config.Dealership.Vehicles[Type][Index].Items[Vehicle].Price)
			PurchaseItem.Activated = function(ParentMenu, SelectedItem)
				if SelectedItem:Enabled() then
					SelectedItem:Enabled(false)
					LastItemSelected = SelectedItem
					TriggerServerEvent("Shop.Vehicle.Buy", Type, Index, Vehicle, GetAvailableGarageId(Type), PackVehicle(Preview.Handle), Location.Exit)
				end
			end
			local TestItem = NativeUI.CreateItem("Test drive", "Selecting this will give you 30 seconds to test drive the vehicle!")
			TestItem.Activated = function(ParentMenu, SelectedItem)
				Citizen.CreateThread(function()
					ParentMenu:Visible(false)
					FreezeEntityPosition(Player.Ped, false)
					FreezeEntityPosition(Preview.Handle, false)
					SetEntityCoords(Preview.Handle, Config.Dealership.Test.Coordinates.x, Config.Dealership.Test.Coordinates.y, Config.Dealership.Test.Coordinates.z)
					SetEntityHeading(Preview.Handle, Config.Dealership.Test.Coordinates.h)
					Config.Dealership.Test.Time = 30
					Citizen.Wait(30500)
					FreezeEntityPosition(Player.Ped, true)
					FreezeEntityPosition(Preview.Handle, true)
					SetEntityCoords(Preview.Handle, Location.Inside.x, Location.Inside.y, Location.Inside.z)
					SetEntityHeading(Player.Ped, Location.Inside.h)
					SetEntityHeading(Preview.Handle, Location.Inside.h)
					SetVehicleFixed(Preview.Handle)
					SetFollowVehicleCamZoomLevel(2)
					ParentMenu:Visible(true)
				end)
			end
			SubSubMenu:AddItem(PurchaseItem)
			SubSubMenu:AddItem(TestItem)
		end
	end
	Pool:RefreshIndex()
	Pool:MouseControlsEnabled(false)
	Pool:ControlDisablingEnabled(false)
	ShopMenu:Visible(true)
end

Citizen.CreateThread(function()
	for Type, Locations in pairs(Config.Dealership.Locations) do
		for Index = 1, #Locations do
			CreateBlip(Locations[Index].Blip.Name, Locations[Index].Blip.Sprite, Locations[Index].Blip.Colour, Locations[Index].Marker.x, Locations[Index].Marker.y, Locations[Index].Marker.z)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Player.Ready then
			Pool:ProcessMenus()
			for Type, Locations in pairs(Config.Dealership.Locations) do
				for Index = 1, #Locations do
					if Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, Locations[Index].Marker.x, Locations[Index].Marker.y, Locations[Index].Marker.z) < 20 then
						RenderMarker(25, Locations[Index].Marker.x, Locations[Index].Marker.y, Locations[Index].Marker.z, 1.0, 1.0, 1.5, 255, 255, 0, 255)
						if Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, Locations[Index].Marker.x, Locations[Index].Marker.y, Locations[Index].Marker.z) < 1 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to open the shop!")
							if IsControlJustPressed(1, 51) then
								if ShopMenu:Visible() then
									ShopMenu:Visible(false)
								else
									OpenShop(Type, Locations[Index])
								end
							end
						end
					end
				end
			end
			if Config.Dealership.Test.Time > 0 then
				ScreenDrawPositionBegin(82, 67)
				ScreenDrawPositionRatio(0, 0, 0, 0)
				UI.RenderSprite("timerbars", "all_black_bg", 0, -20, 100, 38, 0)
				UI.RenderText(((Config.Dealership.Test.Time <= 9) and "0" or "")..tostring(Config.Dealership.Test.Time), 1875, 155, 0.35, 255, 255, 255, 255, 0, nil, false, false, 0)
				ScreenDrawPositionEnd()
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Config.Dealership.Test.Time > 0 then
			Citizen.Wait(1000)
			Config.Dealership.Test.Time = Config.Dealership.Test.Time - 1
		end
	end
end)

RegisterNetEvent("Shop.Vehicle.Reset")
AddEventHandler("Shop.Vehicle.Reset", function()
	LastItemSelected:Enabled(true)
end)

RegisterNetEvent("Shop.Vehicle.Purchased")
AddEventHandler("Shop.Vehicle.Purchased", function(Vehicle, Location)
	Pool:CloseAllMenus()
	SetEntityVisible(Player.Ped, true)
	SetEntityInvincible(Player.Ped, false)
	FreezeEntityPosition(Player.Ped, false)
	if Preview.Handle then
		if Preview.Handle ~= 0 then
			DeleteVehicle(Preview.Handle)
			Preview = {}
		end
	end

	for i = 1, #PreviewHandles do
		SetEntityCoords(PreviewHandles[i], 601.28948974609, -4396.9853515625, 384.98565673828)
	end
	
	PreviewHandles = {}

	local Model = GetHashKey(Vehicle.Model)

	RequestModel(Model)

	while not HasModelLoaded(Model) do
		Citizen.Wait(0)
	end

	Vehicle.Handle = CreateVehicle(Model, Location.x, Location.y, Location.z, Location.h, true, false)

	while not DoesEntityExist(Vehicle.Handle) do
		Citizen.Wait(0)
	end

	SetVehicleHasBeenOwnedByPlayer(Vehicle.Handle, true)
	SetVehicleNumberPlateText(Vehicle.Handle, Vehicle.Plate)

	NetworkRegisterEntityAsNetworked(Vehicle.Handle)
	Vehicle.NetworkHandle = NetworkGetNetworkIdFromEntity(Vehicle.Handle)
	SetNetworkIdCanMigrate(Vehicle.NetworkHandle, true)
	SetNetworkIdExistsOnAllMachines(Vehicle.NetworkHandle, true)

	SetVehicleOnGroundProperly(Vehicle.Handle)

	SetVehicleModKit(Vehicle.Handle, 0)

	for Index = 0, 48 do
		if Vehicle.Mods[tostring(Index)] then
			SetVehicleMod(Vehicle.Handle, Index, Vehicle.Mods[tostring(Index)])
		end
	end

	ToggleVehicleMod(Vehicle.Handle, 18, tobool(Vehicle.Turbo))
	ToggleVehicleMod(Vehicle.Handle, 20, tobool(Vehicle.TyreSmoke))
	ToggleVehicleMod(Vehicle.Handle, 22, tobool(Vehicle.XenonLights))

	SetVehicleWheelType(Vehicle.Handle, tonumber(Vehicle.Wheels.Type))

	SetVehicleMod(Vehicle.Handle, 23, tonumber(Vehicle.Wheels.Front.Handle), tobool(Vehicle.Wheels.Front.Custom))

	if IsThisModelABike(Model) then
		SetVehicleMod(Vehicle.Handle, 24, tonumber(Vehicle.Wheels.Rear.Handle), tobool(Vehicle.Wheels.Rear.Custom))
	end

	for i = 0, 3 do
		SetVehicleNeonLightEnabled(Vehicle.Handle, i, tobool(Vehicle.Neon[i+1]))
	end

	SetVehicleTyresCanBurst(Vehicle.Handle, tobool(Vehicle.Wheels.Bulletproof))

	SetVehicleWindowTint(Vehicle.Handle, tonumber(Vehicle.Colour.Tint))
	SetVehicleColours(Vehicle.Handle, Vehicle.Colour.Primary, Vehicle.Colour.Secondary)
	SetVehicleExtraColours(Vehicle.Handle, Vehicle.Colour.Pearlescent, Vehicle.Colour.Wheel)
	SetVehicleNeonLightsColour(Vehicle.Handle, Vehicle.Colour.Neon.Red, Vehicle.Colour.Neon.Green, Vehicle.Colour.Neon.Blue)
	SetVehicleTyreSmokeColor(Vehicle.Handle, Vehicle.Colour.Smoke.Red, Vehicle.Colour.Smoke.Green, Vehicle.Colour.Smoke.Blue)
	SetVehicleNumberPlateTextIndex(Vehicle.Handle, Vehicle.Colour.Plate)

	SetModelAsNoLongerNeeded(Model)

	TaskWarpPedIntoVehicle(Player.Ped, Vehicle.Handle, -1)

	Vehicle.State = "Missing"
	TriggerServerEvent("Garages.Out", Vehicle)
end)
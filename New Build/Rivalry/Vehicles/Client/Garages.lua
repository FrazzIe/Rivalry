PlayerVehicles, PlayerGarages = {}, {}
PersonalVehicles, PersonalGarages = {}, {}
local Pool, VehicleMenu = NativeUI.CreatePool(), NativeUI.CreateMenu("Garage", "Options", 1300, 300)
local InsuranceMenu = NativeUI.CreateMenu("Insurance", "Vehicles", 1300, 300)
local SlotPrice, ImpoundPrice = 5000, 5000
local DisabledItems = {}

Pool:Add(VehicleMenu)
Pool:Add(InsuranceMenu)

function IsVehicleOwned(Plate)
	local IsOwned = false
	for Index = 1, #PersonalVehicles do
		if Plate == PersonalVehicles[Index].Plate then
			IsOwned = true
			break
		end
	end
	return IsOwned
end

function IsGarageOwned(Type, GarageId)
	local IsOwned = false
	for Index = 1, #PersonalGarages do
		if GarageId == PersonalGarages[Index].GarageId and Type == PersonalGarages[Index].Type then
			IsOwned = true
			break
		end
	end
	return IsOwned
end

function GetVehicleIndex(Plate)
	for Index = 1, #PersonalVehicles do
		if Plate == PersonalVehicles[Index].Plate then
			return Index
		end
	end
	return nil
end

function GetGarageIndex(Type, GarageId)
	for Index = 1, #PersonalGarages do
		if GarageId == PersonalGarages[Index].GarageId and Type == PersonalGarages[Index].Type then
			return Index
		end
	end
	return nil
end

function GetGarageCount(Type, GarageId)
	local Count = 0
	for Index = 1, #PersonalVehicles do
		if GarageId == PersonalVehicles[Index].GarageId and Type == PersonalVehicles[Index].Type then
			Count = Count + 1
		end
	end
	return Count
end

function GetOwnedGaragesOfType(Type)
	local GaragesFound = {}
	for Index = 1, #PersonalGarages do
		if Type == PersonalGarages[Index].Type then
			table.insert(GaragesFound, PersonalGarages[Index])
		end
	end
	return GaragesFound
end

function GetAvailableGarageId(Type)
	local PossibleGarages = GetOwnedGaragesOfType(Type)
	for Index = 1, #PossibleGarages do
		if GetGarageCount(Type, PossibleGarages[Index].GarageId) < PossibleGarages[Index].Slots then
			return PossibleGarages[Index].GarageId
		end
	end
	return nil
end

function SpawnVehicle(Vehicle)
	if type(Vehicle) ~= "table" then return Log.Error("Vehicle must be a table value") end
	local Model = GetHashKey(Vehicle.Model)

	RequestModel(Model)

	while not HasModelLoaded(Model) do
		Citizen.Wait(0)
	end

	Vehicle.Handle = CreateVehicle(Model, Config.Garages[Vehicle.Type][Vehicle.GarageId].Coordinates.x, Config.Garages[Vehicle.Type][Vehicle.GarageId].Coordinates.y, Config.Garages[Vehicle.Type][Vehicle.GarageId].Coordinates.z, Config.Garages[Vehicle.Type][Vehicle.GarageId].Coordinates.h, true, false)

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
end

function StoreVehicle(Vehicle, Type, GarageId)
	if DoesEntityExist(Vehicle) then
		local Plate = GetVehicleNumberPlateText(Vehicle)
		if IsVehicleOwned(Plate) then
			local Index = GetVehicleIndex(Plate)
			if Type == PersonalVehicles[Index].Type then
				if GetGarageCount(Type, GarageId) < Config.Garages[Type][GarageId].Slots or (GetGarageCount(Type, GarageId) >= Config.Garages[Type][GarageId].Slots and PersonalVehicles[Index].GarageId == GarageId) then
					PersonalVehicles[Index].Colour.Primary, PersonalVehicles[Index].Colour.Secondary = GetVehicleColours(Vehicle)
					PersonalVehicles[Index].Colour.Pearlescent, PersonalVehicles[Index].Colour.Wheel = GetVehicleExtraColours(Vehicle)
					PersonalVehicles[Index].Colour.Smoke.Red, PersonalVehicles[Index].Colour.Smoke.Green, PersonalVehicles[Index].Colour.Smoke.Blue = GetVehicleTyreSmokeColor(Vehicle)
					PersonalVehicles[Index].Colour.Neon.Red, PersonalVehicles[Index].Colour.Neon.Green, PersonalVehicles[Index].Colour.Neon.Blue = GetVehicleNeonLightsColour(Vehicle)
					PersonalVehicles[Index].Colour.Plate, PersonalVehicles[Index].Colour.Tint = GetVehicleNumberPlateTextIndex(Vehicle), GetVehicleWindowTint(Vehicle)
					PersonalVehicles[Index].Wheels.Type, PersonalVehicles[Index].Wheels.Front.Custom, PersonalVehicles[Index].Wheels.Rear.Custom = GetVehicleWheelType(Vehicle), tobool(GetVehicleModVariation(Vehicle, 23)), tobool(GetVehicleModVariation(Vehicle, 24))
					PersonalVehicles[Index].Wheels.Front.Handle, PersonalVehicles[Index].Wheels.Rear.Handle, PersonalVehicles[Index].Bulletproof = GetVehicleMod(Vehicle, 23), GetVehicleMod(Vehicle, 24), tobool(not GetVehicleTyresCanBurst(Vehicle))
					PersonalVehicles[Index].Turbo, PersonalVehicles[Index].TyreSmoke, PersonalVehicles[Index].XenonLights = tobool(IsToggleModOn(Vehicle, 18)), tobool(IsToggleModOn(Vehicle, 20)), tobool(IsToggleModOn(Vehicle, 22))
					PersonalVehicles[Index].Handle, PersonalVehicles[Index].State, PersonalVehicles[Index].Type, PersonalVehicles[Index].GarageId = nil, "Available", Type, GarageId

					for i = 0, 3, 1 do
						PersonalVehicles[Index].Neon[i+1] = tobool(IsVehicleNeonLightEnabled(Vehicle, i))
					end

					for i = 0, 48, 1 do
						if PersonalVehicles[Index].Mods[tostring(i)] then
							PersonalVehicles[Index].Mods[tostring(i)] = GetVehicleMod(Vehicle, i)
						end
					end

					DestroyVehicle(Vehicle)

					TriggerServerEvent("Garages.Store", PersonalVehicles[Index])
				end
			end
		else
			PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		end
	else
		PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	end
end

function OpenGarage(Type, GarageId)
	VehicleMenu:Clear()
	VehicleMenu.Subtitle.Text:Label("Options")
	if IsGarageOwned(Type, GarageId) then
		local GarageIndex = GetGarageIndex(Type, GarageId)
		local StoreItem = NativeUI.CreateItem("Store", "Store a vehicle in the garage!")
		StoreItem.Activated = function(ParentMenu, SelectedItem)
			local Vehicle, Position = GetNearestVehicleAtCoords(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, 10)
			StoreVehicle(Vehicle, Type, GarageId)
		end
		VehicleMenu:AddItem(StoreItem)
		for Index = 1, #PersonalVehicles do
			local VehicleItem = NativeUI.CreateItem(PersonalVehicles[Index].Name, ((PersonalVehicles[Index].State == "Available") and "Take this vehicle out?" or ((PersonalVehicles[Index].State == "Missing") and "This vehicle is missing!" or "This vehicle was impounded, it will cost you $"..ImpoundPrice.." to get access to it!")))
			VehicleItem:RightLabel(PersonalVehicles[Index].State, ((PersonalVehicles[Index].State == "Available") and Colour.Green or ((PersonalVehicles[Index].State == "Missing") and Colour.Red or Colour.Blue)))
			VehicleItem.Activated = function(ParentMenu, SelectedItem)
				if PersonalVehicles[Index].State == "Available" then
					ParentMenu:Visible(false)
					SpawnVehicle(PersonalVehicles[Index])
				elseif PersonalVehicles[Index].State == "Impounded" then
					if SelectedItem:Enabled() then
						SelectedItem:Enabled(false)
						table.insert(DisabledItems, SelectedItem)
						TriggerServerEvent("Garages.Impound", PersonalVehicles[Index].Plate)
					end
				end
				SelectedItem:Description(((PersonalVehicles[Index].State == "Available") and "Take this vehicle out?" or ((PersonalVehicles[Index].State == "Missing") and "This vehicle is missing!" or "This vehicle was impounded, it will cost you $"..ImpoundPrice.." to get access to it!")))
				ParentMenu:DrawCalculations()
			end
			VehicleMenu:AddItem(VehicleItem)
		end
		if GetGarageCount(Type, GarageId) < PersonalGarages[GarageIndex].Slots then
			for Index = 1, PersonalGarages[GarageIndex].Slots - GetGarageCount(Type, GarageId) do
				local EmptyItem = NativeUI.CreateItem("Empty slot", "An empty slot?")
				EmptyItem.Activated = function(ParentMenu, SelectedItem)
					PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				end
				VehicleMenu:AddItem(EmptyItem)
			end
		end
		if PersonalGarages[GarageIndex].Slots < Config.Garages[PersonalGarages[GarageIndex].Type][PersonalGarages[GarageIndex].GarageId].Slots then
			for Index = 1, Config.Garages[PersonalGarages[GarageIndex].Type][PersonalGarages[GarageIndex].GarageId].Slots - PersonalGarages[GarageIndex].Slots do
				local UpgradeItem = NativeUI.CreateItem("Purchase slot", "A slot in the garage that you can purchase?")
				UpgradeItem:RightLabel("$"..math.floor(SlotPrice))
				UpgradeItem.Activated = function(ParentMenu, SelectedItem)
					if SelectedItem:Enabled() then
						SelectedItem:Enabled(false)
						table.insert(DisabledItems, SelectedItem)
						TriggerServerEvent("Garages.Upgrade", Type, GarageId)
					end
				end
				VehicleMenu:AddItem(UpgradeItem)
			end
		end
		if GetGarageCount(Type, GarageId) == 0 then
			local SellItem = NativeUI.CreateItem("Sell", "Sell your garage!")
			SellItem:RightLabel("$"..math.floor(PersonalGarages[GarageIndex].Cost))
			SellItem.Activated = function(ParentMenu, SelectedItem)
				VehicleMenu:Clear()
				VehicleMenu.Subtitle.Text:Text("Are you sure you want to sell your garage?")
				local DeclineItem = NativeUI.CreateItem("No", "Don't sell your garage!")
				DeclineItem.Activated = function(ParentMenu, SelectedItem)
					OpenGarage(Type, GarageId)
				end
				local AcceptItem = NativeUI.CreateItem("Yes", "Sell your garage!")
				AcceptItem.Activated = function(ParentMenu, SelectedItem)
					if SelectedItem:Enabled() then
						SelectItem:Enabled(true)
						table.insert(DisabledItems, SelectedItem)
						TriggerServerEvent("Garages.Sell", Type, GarageId)
					end
				end
				VehicleMenu:AddItem(DeclineItem)
				VehicleMenu:AddItem(AcceptItem)
				VehicleMenu:RefreshIndex()
			end
			VehicleMenu:AddItem(SellItem)
		else
			local SellItem = NativeUI.CreateItem("Garage must be empty to sell it!", "Your garage must be empty to sell it!")
			VehicleMenu:AddItem(SellItem)
		end
	else
		local SlotItems = {}
		for i = 1, Config.Garages[Type][GarageId].Slots do table.insert(SlotItems, i) end
		local BuyItem = NativeUI.CreateItem("Purchase", "Purchase this garage!")
		local SlotItem = NativeUI.CreateListItem("Slots", SlotItems, 1, "Amount of vehicles you can store in your garage!")
		BuyItem:RightLabel("$"..Config.Garages[Type][GarageId].Cost)
		BuyItem.Activated = function(ParentMenu, SelectedItem)
			if SelectedItem:Enabled() then
				SelectedItem:Enabled(false)
				table.insert(DisabledItems, SelectedItem)
				TriggerServerEvent("Garages.Buy", Type, GarageId, 1)
			end
		end
		SlotItem.OnListChanged = function(ParentMenu, SelectedListItem, NewIndex)
			BuyItem.Activated = function(ParentMenu, SelectedItem)
				if SelectedItem:Enabled() then
					SelectedItem:Enabled(false)
					table.insert(DisabledItems, SelectedItem)
					TriggerServerEvent("Garages.Buy", Type, GarageId, SelectedListItem:IndexToItem(NewIndex))
				end
			end
			BuyItem:RightLabel("$"..Config.Garages[Type][GarageId].Cost + (SlotPrice * SelectedListItem:IndexToItem(NewIndex)))
		end 
		VehicleMenu:AddItem(BuyItem)
		VehicleMenu:AddItem(SlotItem)
	end
	VehicleMenu:RefreshIndex()
	VehicleMenu:Visible(true)
end

function OpenInsurance()
	InsuranceMenu:Clear()
	for Index = 1, #PersonalVehicles do
		if PersonalVehicles[Index].Insurance == true and PersonalVehicles[Index].State == "Missing" then
			local Item = NativeUI.CreateItem(PersonalVehicles[Index].Name, "Once you claim a vehicle it will go back into your garage!")
			Item:RightLabel("Claim", Colour.Blue)
			Item.Activated = function(ParentMenu, SelectedItem)
				if SelectedItem:Enabled() then
					SelectedItem:Enabled(true)
					table.insert(DisabledItems, SelectedItem)
					DestroyVehicle(PersonalVehicles[Index].Handle)
					TriggerServerEvent("Garages.Claim", PersonalVehicles[Index].Plate)
				end
			end
			InsuranceMenu:AddItem(Item)
		elseif PersonalVehicles[Index].Insurance == false then
			local Item = NativeUI.CreateItem(PersonalVehicles[Index].Name, "You can insure this vehicle for $"..math.floor(PersonalVehicles[Index].Cost/10))
			Item:RightLabel("Uninsured", Colour.Red)
			Item.Activated = function(ParentMenu, SelectedItem)
				if SelectedItem:Enabled() then
					SelectedItem:Enabled(true)
					table.insert(DisabledItems, SelectedItem)
					TriggerServerEvent("Garages.Insurance", PersonalVehicles[Index].Plate)
				end
			end
			InsuranceMenu:AddItem(Item)
		else
			local Item = NativeUI.CreateItem(PersonalVehicles[Index].Name, "This vehicle is already insured and stored in the garage!")
			Item:RightLabel("Insured", Colour.Green)
			InsuranceMenu:AddItem(Item)			
		end
	end
	InsuranceMenu:RefreshIndex()
	InsuranceMenu:Visible(true)
end

Citizen.CreateThread(function()
	for Type, Garages in pairs(Config.Garages) do
		for Index = 1, #Garages do
			CreateBlip(Garages[Index].Blip.Name, Garages[Index].Blip.Sprite, Garages[Index].Blip.Colour, Garages[Index].Coordinates.x, Garages[Index].Coordinates.y, Garages[Index].Coordinates.z)
		end
	end
	for Index = 1, #Config.Insurance do
		CreateBlip(Config.Insurance[Index].Blip.Name, Config.Insurance[Index].Blip.Sprite, Config.Insurance[Index].Blip.Colour, Config.Insurance[Index].Coordinates.x, Config.Insurance[Index].Coordinates.y, Config.Insurance[Index].Coordinates.z)
	end
	for Index = 1, #Config.Selling do
		CreateBlip(Config.Selling[Index].Blip.Name, Config.Selling[Index].Blip.Sprite, Config.Selling[Index].Blip.Colour, Config.Selling[Index].Coordinates.x, Config.Selling[Index].Coordinates.y, Config.Selling[Index].Coordinates.z)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Player.Ready then
			Pool:ProcessMenus()
			for Type, Garages in pairs(Config.Garages) do
				for Index = 1, #Garages do
					local Distance = Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, Garages[Index].Coordinates.x, Garages[Index].Coordinates.y, Garages[Index].Coordinates.z)
					if Distance < 20 then
						RenderMarker(25, Garages[Index].Coordinates.x, Garages[Index].Coordinates.y, Garages[Index].Coordinates.z, 3.0, 3.0, 3.5, 255, 255, 0, 255)
						if Distance < 3 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to open the garage!")
							if IsControlJustPressed(1, 51) then
								if VehicleMenu:Visible() then
									VehicleMenu:Visible(false)
								else
									OpenGarage(Type, Index)
								end
							end
						end
					end
				end
			end
			for Index = 1, #Config.Insurance do
				local Distance = Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, Config.Insurance[Index].Coordinates.x, Config.Insurance[Index].Coordinates.y, Config.Insurance[Index].Coordinates.z)
				if Distance < 20 then
					RenderMarker(25, Config.Insurance[Index].Coordinates.x, Config.Insurance[Index].Coordinates.y, Config.Insurance[Index].Coordinates.z, 2.0, 2.0, 2.5, 255, 255, 0, 255)
					if Distance < 2 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to open the insurance centre!")
						if IsControlJustPressed(1, 51) then
							if InsuranceMenu:Visible() then
								InsuranceMenu:Visible(false)
							else
								OpenInsurance()
							end
						end
					end
				end
			end
			for Index = 1, #Config.Selling do
				local Distance = Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, Config.Selling[Index].Coordinates.x, Config.Selling[Index].Coordinates.y, Config.Selling[Index].Coordinates.z)
				if Distance < 20 then
					RenderMarker(25, Config.Selling[Index].Coordinates.x, Config.Selling[Index].Coordinates.y, Config.Selling[Index].Coordinates.z, 2.0, 2.0, 2.5, 255, 255, 0, 255)
					if Distance < 2 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to sell your vehicle!")
						if IsControlJustPressed(1, 51) then
							local Vehicle, Position = GetNearestVehicleAtCoords(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, 10)
							if Vehicle ~= 0 then
								TriggerServerEvent("Garages.Sell.Vehicle", Vehicle, GetVehicleNumberPlateText(Vehicle))
							else
								Notify("No vehicles found nearby!", 3000)
							end
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("Garages.Reset")
AddEventHandler("Garages.Reset", function()
	for Index = 1, #DisabledItems do
		DisabledItems[Index]:Enabled(true)
	end
	DisabledItems = {}
end)

RegisterNetEvent("Garages.Sync.All")
AddEventHandler("Garages.Sync.All", function(_PlayerVehicles, _PlayerGarages)
	PlayerVehicles, PlayerGarages = _PlayerVehicles, _PlayerGarages
end)

RegisterNetEvent("Garages.Sync.Client")
AddEventHandler("Garages.Sync.Client", function(_PersonalVehicles, _PersonalGarages, Vehicle)
	PersonalVehicles, PersonalGarages = _PersonalVehicles, _PersonalGarages
	if VehicleMenu:Visible() then
		for Type, Garages in pairs(Config.Garages) do
			for Index = 1, #Garages do
				if Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, Garages[Index].Coordinates.x, Garages[Index].Coordinates.y, Garages[Index].Coordinates.z) < 3 then
					OpenGarage(Type, Index)
				end
			end
		end
	end
	if InsuranceMenu:Visible() then
		for Index = 1, #Config.Insurance do
			if Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, Config.Insurance[Index].Coordinates.x, Config.Insurance[Index].Coordinates.y, Config.Insurance[Index].Coordinates.z) < 2 then
				OpenInsurance()
			end
		end
	end
	if Vehicle then
		if DoesEntityExist(Vehicle) then
			DestroyVehicle(Vehicle)
		end
	end
end)
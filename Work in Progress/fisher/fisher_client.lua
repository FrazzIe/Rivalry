Fishing = {
	Data = {
		IsFisher = false,
		OnDuty = false,
		Locations = {
			Service = {x = 2243.458984375, y = 5154.3515625, z = 57.887111663818, h = 147.62580871582},
			Boat = {},
		},
		Pier = {
			{
				{
					id=316, x = -3428.0222167969, y = 967.11779785156, z = 8.3466835021973, distanceBetweenCoords=3.5, distanceMarker=3.5, defaultTime=10000, name="Pier Fishing and Boat Rental"
				},
				{
					id=316, x = -279.17889404297, y = 6637.1352539063, z = 7.5514869689941, distanceBetweenCoords=3.5, distanceMarker=3.5, defaultTime=10000,
				},
				{
					id=316, x = 711.97161865234, y = 4100.2075195313, z = 35.785236358643, distanceBetweenCoords=3.5, distanceMarker=3.5, defaultTime=10000, name="Pier Fishing and Boat Rental"
				},
			},
		},
		DeepSea = {
			{ 
			 	id=404, x = 3991.8015136719, y = 2428.513671875, z = 2.90869140625, distanceBetweenCoords=20.5, distanceMarker=20.5, defaultTime=10000, name="Deep Sea Fishing"
			},
			{
				id=404, x = 3069.6108398438, y = -2130.59375, z = 3.9801769256592, distanceBetweenCoords=20.5, distanceMarker=20.5, defaultTime=10000, name="Deep Sea Fishing"
			},
			{
				id=404, x = -2301.1547851563, y = -1236.6251220703, z = 4.5, distanceBetweenCoords=20.5, distanceMarker=20.5, defaultTime=10000, name="Deep Sea Fishing"
			},
			{
				id=404, x = -3516.1176757813, y = 2906.3083496094, z = 7.090615272522, distanceBetweenCoords=20.5, distanceMarker=20.5, defaultTime=10000, name="Deep Sea Fishing"
			},
			{
				id=404, x = -1787.2473144531, y = 6095.6254882813, z = 2.2088184356689, distanceBetweenCoords=20.5, distanceMarker=20.5, defaultTime=10000, name="Deep Sea Fishing"
			},
			{
				id=404, x = 1251.6247558594, y = 7330.8481445313, z = 3.8822541236877, distanceBetweenCoords=20.5, distanceMarker=20.5, defaultTime=10000, name="Deep Sea Fishing"
			},
		},
		Bar = {
			StartFishing_KEY = 51,
			Caught_KEY = 201,
			SuccessLimit = 0.09,
			AnimationSpeed = 0.0015,
			ShowChatMSG = true,
			IsFishing = false,
			FishingRodInHand = false,
			CFish = false,
			BarAnimation = 0,
			Faketimer = 0,
			RunCodeOnly1Time = true,
			PosX = 0.5,
			PosY = 0.1,
		 	TimerAnimation = 0.1,
			whichgarage = 0,
		},
		Price = {
			priceSnook = 50,
			pricePompano = 50,
			priceSnapper = 50,
			priceRedfish = 50,
			priceBass = 50,
			priceMackerel = 150,
			priceHerring = 175,
			priceSalmon = 200,
			priceBarracuda = 225,
			priceTuna = 250,
			priceYellowtail = 275,
		},
		Store = {
		    {Category = "Freshly Caught Fish", Items = {
		    	[1] = {Name = "Snook", Id = 53, price = priceSnook, Max = 100, sold = 0},
		        [2] = {Name = "Pompano", Id = 54, price = pricePompano, Max = 100, sold = 0},
		        [3] = {Name = "Snapper", Id = 55, price = priceSnapper, Max = 100, sold = 0},
		        [4] = {Name = "Redfish", Id = 56, price = priceRedfish, Max = 100, sold = 0},
		        [5] = {Name = "Bass", Id = 57, price = priceBass, Max = 100, sold = 0},
		        [6] = {Name = "Mackerel", Id = 58, price = priceMackerel, Max = 100, sold = 0},
		        [7] = {Name = "Herring", Id = 59, price = priceHerring, Max = 100, sold = 0},
		        [8] = {Name = "Salmon", Id = 60, price = priceSalmon, Max = 100, sold = 0},
		        [9] = {Name = "Barracuda", Id = 61, price = priceBarracuda, Max = 100, sold = 0},
		        [10] = {Name = "Tuna", Id = 62, price = priceTuna, Max = 100, sold = 0},
		        [11] = {Name = "Yellowtail", Id = 63, price = priceYellowtail, Max = 100, sold = 0},
		    }},
		},
		Vehicles ={
			Model = "tug"
		},
	},
}

local peds = {}
--Functions
function startFishing(typeOfFishing)
	IsFishing = true
	RunCodeOnly1Time = true
	BarAnimation = 0
	if FishingRodInHand == false then
		FishRod = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
	end
	FishingRodInHand = true
	while IsFishing do
		local time = 4*3000
		TaskStandStill(GetPed(), time+7000)
		PlayAnim(GetPed(),'amb@world_human_stand_fishing@base','base',4,3000)
		Citizen.Wait(time)
		CFish = true
		IsFishing = false
	end
	while CFish do
		Citizen.Wait(1)
		FishGUI(true)
		if RunCodeOnly1Time then
			Faketimer = 1
			PlayAnim(GetPed(),'amb@world_human_stand_fishing@idle_a','idle_c',1,0) -- 10sec
			RunCodeOnly1Time = false
		end
		if TimerAnimation <= 0 then
			CFish = false
			TimerAnimation = 0.1
			StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',2.0)
			Citizen.Wait(200)
		end
		if IsControlJustPressed(1, Caught_KEY) then
			if BarAnimation >= SuccessLimit then
				CFish = false
				TimerAnimation = 0.1
				StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',2.0)
				Citizen.Wait(200)
				DetachEntity(FishRod, true, true)
				DeleteEntity(FishRod)
				GetPedNearbyPeds(PlayerPedId(), peds)
				if( typeOfFishing == "Deep")
					TriggerServerEvent('caughtFish', "Deep", #peds)
				else
					TriggerServerEvent('caughtFish', "Pier", #peds)
				end
			else
				CFish = false
				TimerAnimation = 0.1
				StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',2.0)
				Citizen.Wait(200)
				TriggerEvent('chatMessage', "The fish slipped away! You need to be more focused!")
				DetachEntity(FishRod, true, true)
				DeleteEntity(FishRod)
			end
		end
	else
		FishingRodInHand = false
	end
end
-- Networking Events
	RegisterNetEvent('fisher:set')
	AddEventHandler("fisher:set", function(_isFisher)
		Fishing.Data.isFisher = false
		Fishing.Data.OnDuty = _isFisher
	end)

	RegisterNetEvent('fisher:boat')
	AddEventHandler('fisher:boat', function()
		Citizen.CreateThread(function()
			RequestModel(Fishing.Data.Vehicles.Model)
			while not HasModelLoaded(Fishing.Data.Vehicles.Model) do
				Citizen.Wait(0)
			end
			Fisher.Data.Vehicles.Boat = CreateVehicle(Fishing.Data.Vehicles.Model, Fishing.Data.Locations.Boat, true, false)
			local plate = "FISH"..GetVehicleNumberPlateText(Fisher.Data.Vehicles.Boat)
			SetVehicleNumberPlateText(Fisher.Data.Vehicles.Boat, plate)
			SetEntityInvincible(Fisher.Data.Vehicles.Boat, false)
			SetPedIntoVehicle(PlayerPedId(), Fisher.Data.Vehicles.Boat, -1)
			SetModelAsNoLongerNeeded(model)
			DecorSetBool(Fisher.Data.Vehicles.Boat, "hotwire", true)
		end)
	end)

	Citizen.CreateThread(function()
		CreateBlip("Turtle Head Fishing", 477, 21, locations.service.x, locations.service.y, locations.service.z)
		while true do
			Citizen.Wait(0)
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped, false)
			if Fishing.Data.isFisher then
				if(Vdist(pos.x, pos.y, pos.z, Fishing.Data.Location.Service) < 10) then
					DrawMarker(25, Fishing.Data.Location.Service.x, Fishing.Data.Location.Service.y, Fishing.Data.Location.Service.z, 1.0, 1.0, 1.5, 0, 255, 0, 255)
					if Vdist(pos.x, pos.y, pos.z, Fishing.Data.Location.Service) < 1 then
						DisplayHelpTesk("Press ~INPUT_CONTEXT~ to sign on duty!")
						if(IsControlJustPressed(1,51)) then
							Fishing.Data.OnDuty = not Fishing.Data.OnDuty
						end
					end	
				end
				if Fishing.Data.OnDuty then
					while i = 1, i < #Fishing.Data.Piers do
						if(Vdist(pos.x, pos.y, pos.z, Fishing.Data.Pier[i]) < 5) then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to start fishing!")
							if	(IsControlJustPressed(1,51)) then
								startFishing("Pier")
							end
						end
						if(Vdist(post.x, pos.y, pos.z, Fishing.Data.Deep[i]))then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to start fishing!")
							if IsControlJustPressed(1,51) then
								startFishing("Deep")
							end
						end
					end
				end
			end
		end
	end)

	for k,v in pairs(Store) do
		for i,j in pairs(v.Items) do
			j.Quantity = {}
			for index = 1, j.Max do j.Quantity[#j.Quantity+1] = tostring(index) end
		end
	end

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			for k,v in ipairs(fishmarkets) do
				if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
					DrawMarker(25,v.x, v.y, v.z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
						if IsControlJustPressed(1, 51) then
							if not WarMenu.IsMenuOpened("FishSell") then
								if not WarMenu.DoesMenuExist("FishSell") then
									WarMenu.CreateMenu("FishSell", "Fish Market")
									WarMenu.SetSpriteTitle("FishSell", "shopui_title_conveniencestore")
									WarMenu.SetSubTitle("FishSell", "Hello, what are you coming to sell today?")
									WarMenu.SetMenuX("FishSell", 0.6)
									WarMenu.SetMenuY("FishSell", 0.15)
									WarMenu.SetTitleBackgroundColor("FishSell", 0, 107, 87)
									for k,v in pairs(Store) do
										WarMenu.CreateSubMenu(v.Category, "FishSell", v.Category.." SECTION")
										for i,j in pairs(v.Items) do
											WarMenu.CreateSubMenu(j.Name, v.Category, j.Name)
										end
									end
									WarMenu.OpenMenu("FishSell")
								else
									currentItemIndex = 1
									WarMenu.OpenMenu("FishSell")
								end
							else
								WarMenu.CloseMenu()
							end		
						end
						if WarMenu.IsMenuOpened("FishSell") then
							for k,v in pairs(Store) do
								WarMenu.MenuButton(v.Category, v.Category)
							end
							if WarMenu.Button("Close") then
								WarMenu.CloseMenu()
							end
							WarMenu.Display()
						end
						for k,v in pairs(Store) do
							if WarMenu.IsMenuOpened(v.Category) then
								for i,j in pairs(v.Items) do
									if WarMenu.MenuButton(j.Name, j.Name) then
										currentItemIndex = 1
									end
								end
								WarMenu.Display()
							end
						end
						for k,v in pairs(Store) do
							for i,j in pairs(v.Items) do
								if WarMenu.IsMenuOpened(j.Name) then
									if WarMenu.Button("Sell "..currentItemIndex.." "..j.Name.."(s)", "$"..j.price*currentItemIndex) then
										TriggerEvent('inventory:removeQty', j.Id, currentItemIndex)
										TriggerServerEvent('sellFish', currentItemIndex)
										j.sold = j.sold + 1
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
						if WarMenu.IsMenuOpened("FishSell") then
							WarMenu.CloseMenu()
						end
					end
				end
			end
		end
	end)

Citizen.CreateThread(function() -- Thread for  timer
	while true do 
		Citizen.Wait(1000)
		Faketimer = Faketimer + 1 
	end 
end)
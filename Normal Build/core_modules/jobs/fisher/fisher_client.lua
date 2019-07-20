local IsFisher, OnDuty, Help = true, false, false
local HasBeenNotified = false
local durability = 3
Fishing = {
	Data = {
		Locations = {
			Service = {
				vector3(-184.28717041016,6540.859375,11.097846984863), -- Paleto Pier
				vector3(-3277.7512207031,965.70672607422,8.3471603393555), -- Great Ocean
				vector3(1333.0826416016,4325.9921875,38.052536010742), -- Sandy Shores
			},
			Boat = {},
		},
		Pier = {
			vector3(-3428.0222167969,967.11779785156,8.3466835021973),
			vector3(-279.17889404297,6637.1352539063,7.5514869689941),
			vector3(1300.0290527344,4219.9711914063,33.908679962158),
		}, 
		DeepSea = {
			vector3(631.90112304688,3879.9125976563,29.931606292725),
			vector3(1227.7028808594,3996.6350097656,30.743522644043),
			vector3(1580.1213378906,4136.0771484375,30.743522644043),
			vector3(2009.5021972656,4322.4462890625,30.743522644043)
		},
		Blips = {},
		Bar = {
			StartFishing_KEY = 51,
			Caught_KEY = 201,
			SuccessLimit = 0.09,
			AnimationSpeed = 0.0015,
			ShowChatMSG = true,
			IsFishing = true,
			FishingRodInHand = false,
			CFish = false,
			BarAnimation = 0,
			RunCodeOnly1Time = true,
			PosX = 0.5,
			PosY = 0.1,
			TimerAnimation = 0.1,
			whichgarage = 0,
			FishRod = "prop_fishing_rod_01",
			up = false,
			obj = nil,
		},
		Price = {
			priceSnook = 10,
			pricePompano = 15,
			priceSnapper = 20,
			priceRedfish = 25,
			priceBass = 30,
			priceMackerel = 50,
			priceHerring = 60,
			priceSalmon = 70,
			priceBarracuda = 80,
			priceTuna = 90,
			priceYellowtail = 99,
		},
		SellPoint = {
			[1] = {Name = "Snook", Id = 54, price = 10, Max = 100, sold = 0},
			[2] = {Name = "Pompano", Id = 55, price = 15, Max = 100, sold = 0},
			[3] = {Name = "Snapper", Id = 56, price = 20, Max = 100, sold = 0},
			[4] = {Name = "Redfish", Id = 57, price = 25, Max = 100, sold = 0},
			[5] = {Name = "Bass", Id = 58, price = 30, Max = 100, sold = 0},
			[6] = {Name = "Mackerel", Id = 59, price = 50, Max = 100, sold = 0},
			[7] = {Name = "Herring", Id = 60, price = 60, Max = 100, sold = 0},
			[8] = {Name = "Salmon", Id = 61, price = 70, Max = 100, sold = 0},
			[9] = {Name = "Barracuda", Id = 62, price = 80, Max = 100, sold = 0},
			[10] = {Name = "Tuna", Id = 63, price = 90, Max = 100, sold = 0},
			[11] = {Name = "Yellowtail", Id = 64, price = 99, Max = 100, sold = 0},
		},
		Vehicles ={
			Model = "tug"
		},
		fishmarkets = {
			vector3(3801.9970703125, 4475.5908203125, 5.9926862716675),
			vector3(-1039.3817138672, -1352.6844482422, 5.553192615509),
		},
	},
}

local peds = {}

function fisherBlips()
	for k, v in ipairs(Fishing.Data.DeepSea) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 316)
		SetBlipColour(blip, 11)
		SetBlipAsShortRange(blip, true)
		SetBlipScale(blip, 0.85)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Deep Sea Fishing")
		EndTextCommandSetBlipName(blip)
		table.insert(Fishing.Data.Blips, blip)
	end
	for k, v in ipairs(Fishing.Data.Pier) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 316)
		SetBlipColour(blip, 11)
		SetBlipAsShortRange(blip, true)
		SetBlipScale(blip, 0.85)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Pier Fishing")
		EndTextCommandSetBlipName(blip)
		table.insert(Fishing.Data.Blips, blip)
	end
	for k, v in ipairs(Fishing.Data.fishmarkets) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 356)
		SetBlipColour(blip, 11)
		SetBlipAsShortRange(blip, true)
		SetBlipScale(blip, 0.85)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Fishing Market")
		EndTextCommandSetBlipName(blip)
		table.insert(Fishing.Data.Blips, blip)
	end
end

function removeBlips()
	for k, v in ipairs(Fishing.Data.Blips) do
		RemoveBlip(v)
		table.remove(Fishing.Data.Blips, k)
	end
end

local function drawHelpJobF()
	local lines = {
		{ text = '~o~Fishing Information', isTitle = true, isCenter = true},
		{ text = '~g~Your job is to make a living by fishing.', isCenter = true, addY = 0.04},
		{ text = ' - Go to one of the fishing piers!'},
		{ text = ' - Make sure to buy fishing rods at your local general store'},
		{ text = ' - Once you are there, use "E" to interact and start fishing'},
		{ text = ' - If you cannot do that then you are not on duty'},
		{ text = ' - The type of fish you can catch from the piers'},
		{ text = ' - Snook, Pompano, Snapper, Redfish, Bass'},
		{ text = ' - The type of fish you can catch from the deep sea'},
		{ text = ' - Mackerel, Herring, Salmon, Barracuda, Tuna, Yellowtail'},
		{ text = ' - If you would like to fish out in the sea, you can rent a tug boat to do so'},
		{ text = ' - Remember to return the tug boat'},
		
		{ text = '~b~How to fish: ', size = 0.4, addY = 0.04 },
		{ text = ' - Press "ENTER" when the bar reaches the edges of the bar'},
		{ text = ' - The bar will turn green when you can catch a fish'},
		{ text = ' - Hit "ENTER" at the right time and you will catch some fish'},
		{ text = ' - Hit "ENTER" too late, and the fish will escape'},
		{ text = ' - Fishing with friends gives a higher chance to catch rare fish!'},
		{ text = '~b~ Fishing Boats :', size = 0.4, addY = 0.04 },
		{ text = ' - Anything you can afford to rent!'},
		{ text = '~d~If you find problems, use the forum to let us know', isCenter = true, addY = 0.06},
		{ text = '~b~Thank You & Good Fishing', isCenter = true},
	}
	DrawRect(0.5, 0.5, 0.48, 0.9, 0,0,0, 225)
	local y = 0.06 - 0.025
	local defaultAddY = 0.025
	local addY = 0.025
	for _, line in pairs(lines) do 
		y = y + addY
		local caddY = defaultAddY
		local x = 0.275
		local defaultSize = 0.32
		local defaultFont = 8
		if line.isTitle == true then
			defaultFont = 1
			defaultSize = 0.8
			caddY = 0.06
		end
		SetTextFont(line.font or defaultFont)
		SetTextScale(0.0,line.size or defaultSize)
		SetTextCentre(line.isCenter == true)
		if line.isCenter == true then
			x = 0.5
		end
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
		SetTextColour(255, 255, 255, 255)
		SetTextEntry("STRING")
		AddTextComponentString(line.text)
		DrawText(x, y)
		addY = line.addY or caddY
	end
	--SetTextComponentFormat("STRING")
	--AddTextComponentString('~INPUT_CELLPHONE_CANCEL~ ~g~Ferme l\'aide')
	--DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Help == true then
			drawHelpJobF()
			if IsControlJustPressed(0, 177) then
				Help = false
			end
		end
	end
end)

RegisterNetEvent('caughtFish:success')
AddEventHandler('caughtFish:success', function(index, quantity, result)
	if result == "caught" then
		for k, v in ipairs(Fishing.Data.SellPoint) do
			if v.Id == index then
				Notify("You caught "..quantity.." "..v.Name, 7400)
			end
		end
	else
		Notify("Looks like the fish aren't biting. Cast another line.", 7400)
	end
end)

function text(x,y,scale,text)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(255,255,255,255)
	SetTextDropShadow(0,0,0,0,255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function FishGUI(bool)
	if not bool then return end
	DrawRect(Fishing.Data.Bar.PosX,Fishing.Data.Bar.PosY+0.005,Fishing.Data.Bar.TimerAnimation,0.005,255,255,0,255)
	DrawRect(Fishing.Data.Bar.PosX,Fishing.Data.Bar.PosY,0.1,0.01,0,0,0,255)
	Fishing.Data.Bar.TimerAnimation = Fishing.Data.Bar.TimerAnimation - 0.0001025
	if Fishing.Data.Bar.BarAnimation >= Fishing.Data.Bar.SuccessLimit then
		DrawRect(Fishing.Data.Bar.PosX,Fishing.Data.Bar.PosY,Fishing.Data.Bar.BarAnimation,0.01,102,255,102,150)
	else
		DrawRect(Fishing.Data.Bar.PosX,Fishing.Data.Bar.PosY,Fishing.Data.Bar.BarAnimation,0.01,255,51,51,150)
	end
	if Fishing.Data.Bar.BarAnimation <= 0 then
		Fishing.Data.Bar.up = true
	end
	if Fishing.Data.Bar.BarAnimation >= Fishing.Data.Bar.PosY then
		Fishing.Data.Bar.up = false
	end
	if not Fishing.Data.Bar.up then
		Fishing.Data.Bar.BarAnimation = Fishing.Data.Bar.BarAnimation - Fishing.Data.Bar.AnimationSpeed
	else
		Fishing.Data.Bar.BarAnimation = Fishing.Data.Bar.BarAnimation + Fishing.Data.Bar.AnimationSpeed
	end
end

function PlayAnim(ped,base,sub,nr,time) 
	Citizen.CreateThread(function() 
		RequestAnimDict(base) 
		while not HasAnimDictLoaded(base) do 
			Citizen.Wait(1) 
		end
		if IsEntityPlayingAnim(ped, base, sub, 3) then
			ClearPedSecondaryTask(ped) 
		else 
			for i = 1,nr do 
				TaskPlayAnim(ped, base, sub, 8.0, -8, -1, 16, 0, 0, 0, 0) 
				Citizen.Wait(time) 
			end 
		end 
	end) 
end

function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)
	Fishing.Data.Bar.obj = CreateObject(GetHashKey(prop),  1729.73,  6403.90,  34.56,  true,  true,  true)
	vX,vY,vZ = table.unpack(GetEntityCoords(PlayerPedId()))
	xRot, yRot, zRot = table.unpack(GetEntityRotation(PlayerPedId(),2))
	AttachEntityToEntity(Fishing.Data.Bar.obj, PlayerPedId(), bone_ID, x,y,z, RotX,RotY,RotZ,  false, false, false, false, 2, true)
	return Fishing.Data.Bar.obj
end

local peds = {}
--Functions
function startFishing(typeOfFishing)
	Fishing.Data.Bar.IsFishing = true
	Fishing.Data.Bar.RunCodeOnly1Time = true
	Fishing.Data.Bar.BarAnimation = 0
	if Fishing.Data.Bar.FishingRodInHand == false then
		AttachEntityToPed(Fishing.Data.Bar.FishRod, GetPedBoneIndex(PlayerPedId(), 60309), 0,0,0, 0,0,0)
	end
	Fishing.Data.Bar.FishingRodInHand = true
	while Fishing.Data.Bar.IsFishing == true do
		local time = 4*3000
		TaskStandStill(PlayerPedId(), time+7000)
		PlayAnim(PlayerPedId(),'amb@world_human_stand_fishing@base','base', 4,3000)
		Citizen.Wait(time)
		Fishing.Data.Bar.CFish = true
		Fishing.Data.Bar.IsFishing = false
	end
	while Fishing.Data.Bar.CFish == true do
		Citizen.Wait(1)
		FishGUI(true)
		if Fishing.Data.Bar.RunCodeOnly1Time then
			PlayAnim(PlayerPedId(),'amb@world_human_stand_fishing@idle_a','idle_c', 1, 0)
			Fishing.Data.Bar.RunCodeOnly1Time = false
		end
		if Fishing.Data.Bar.TimerAnimation <= 0 then
			Fishing.Data.Bar.CFish = false
			Fishing.Data.Bar.TimerAnimation = 0.1
			StopAnimTask(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a','idle_c', 2.0)
			Citizen.Wait(200)
			DeleteEntity(Fishing.Data.Bar.obj)
		end
		if IsControlJustPressed(1, Fishing.Data.Bar.Caught_KEY) then
			if Fishing.Data.Bar.BarAnimation >= Fishing.Data.Bar.SuccessLimit then
				Fishing.Data.Bar.CFish = false
				Fishing.Data.Bar.TimerAnimation = 0.1
				StopAnimTask(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a','idle_c', 4.0, -4, -1, 1, 0, false, false, false)
				Citizen.Wait(200)
				DetachEntity(Fishing.Data.Bar.obj, true, true)
				DeleteEntity(Fishing.Data.Bar.obj)
				peds = FindNearbyPlayers(15)
				if( typeOfFishing == "Deep") then
					TriggerServerEvent('caughtFish', "Deep", #peds)
				else
					TriggerServerEvent('caughtFish', "Pier", #peds)
				end
			else
				Fishing.Data.Bar.CFish = false
				Fishing.Data.Bar.TimerAnimation = 0.1
				StopAnimTask(PlayerPedId(), 'amb@world_human_stand_fishing@idle_a','idle_c', 2.0)
				Citizen.Wait(200)
				Notify("The fish slipped away! You need to be more focused!", 7500)
				--[[local rng = math.random(1,5)
				if rng == 3 then
					durability = durability - 1
				end--]]
				durability = durability - 1
				if durability < 1 then
					Notify("Your fishing rod just snapped!", 7500)
					TriggerEvent('inventory:removeQty', 76, 1)
					durability = 6
				end
				DetachEntity(Fishing.Data.Bar.obj, true, true)
				DeleteEntity(Fishing.Data.Bar.obj)
				FishGUI(false)
			end
		else
			Fishing.Data.Bar.FishingRodInHand = false
		end
	end
end
-- Networking Events
	RegisterNetEvent('fisher:set')
	AddEventHandler('fisher:set', function(var)
		OnDuty = false
		IsFisher = var
	end)

	RegisterNetEvent('fisher:boat')
	AddEventHandler('fisher:boat', function()
		Citizen.CreateThread(function()
			Fisher.Data.Vehicles.Boat = exports["core"]:SpawnVehicle(Fishing.Data.Vehicles.Model, Fishing.Data.Locations.Boat, 0, false)
			
			if Fisher.Data.Vehicles.Boat ~= nil and Fisher.Data.Vehicles.Boat ~= 0 then
				local plate = "FISH"..GetVehicleNumberPlateText(Fisher.Data.Vehicles.Boat)
				SetVehicleNumberPlateText(Fisher.Data.Vehicles.Boat, plate)
				SetEntityInvincible(Fisher.Data.Vehicles.Boat, false)
				SetPedIntoVehicle(PlayerPedId(), Fisher.Data.Vehicles.Boat, -1)
				DecorSetBool(Fisher.Data.Vehicles.Boat, "hotwire", true)
			end
		end)
	end)

	Citizen.CreateThread(function()
		CreateBlip("Turtle Head Fishing", 356, 68, Fishing.Data.Locations.Service[1].x, Fishing.Data.Locations.Service[1].y, Fishing.Data.Locations.Service[1].z)
		CreateBlip("Turtle Head Fishing", 356, 68, Fishing.Data.Locations.Service[2].x, Fishing.Data.Locations.Service[2].y, Fishing.Data.Locations.Service[2].z)
		CreateBlip("Turtle Head Fishing", 356, 68, Fishing.Data.Locations.Service[3].x, Fishing.Data.Locations.Service[3].y, Fishing.Data.Locations.Service[3].z)
		while true do
			Citizen.Wait(0)
			local Ped = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Ped, false)
			if IsFisher then
				for Index = 1, #Fishing.Data.Locations.Service do
					if #(PlayerPosition - Fishing.Data.Locations.Service[Index]) < 10 then
						RenderMarker(25, Fishing.Data.Locations.Service[Index].x, Fishing.Data.Locations.Service[Index].y, Fishing.Data.Locations.Service[Index].z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
						if #(PlayerPosition - Fishing.Data.Locations.Service[Index]) < 1 then
							if OnDuty then
								DisplayHelpText("Press ~INPUT_CONTEXT~ to sign off duty!")
							else
								DisplayHelpText("Press ~INPUT_CONTEXT~ to sign on duty!")
							end
							if(IsControlJustPressed(1,51)) then
								if OnDuty then
									Help = false
								else
									Help = true
								end
								OnDuty = not OnDuty
								fisherBlips()
							end
						end	
					end
				end
				if OnDuty then
					for Index = 1, #Fishing.Data.Pier do
						if #(PlayerPosition - Fishing.Data.Pier[Index]) < 10 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to start fishing!")
							if (IsControlJustPressed(1,51)) then
								Fishing.Data.Bar.IsFishing = true
								if not IsPedSwimming(PlayerPedId()) then
									if GetItemQuantity(76) > 0 then
										startFishing("Pier")
									else
										Notify("How are you gonna fish without a rod? Head to a general store.", 7500)
									end
								else
									Notify("You cant fish while swimming or swim while fishing! Come on..", 7500)
								end
							end
						end
					end
					for Index = 1, #Fishing.Data.DeepSea do
						if #(PlayerPosition - Fishing.Data.DeepSea[Index]) < 100 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to start fishing!")
							if IsControlJustPressed(1,51) then
								Fishing.Data.Bar.IsFishing = true
								if not IsPedSwimming(PlayerPedId()) then
									if GetItemQuantity(76) > 0 then
										startFishing("Deep")
									else
										Notify("How are you gonna fish without a rod? Head to a general store.", 7500)
									end
								else
									Notify("You cant fish while swimming or swim while fishing! Come on..", 7500)
								end
							end
						end
					end
				else
					removeBlips()
				end
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			local PlayerPed = PlayerPedId()
			local PlayerPosition = GetEntityCoords(PlayerPed, false)

			for Market = 1, #Fishing.Data.fishmarkets do
				local Distance = #(Fishing.Data.fishmarkets[Market] - PlayerPosition)

				if Distance < 15.0 then
					RenderMarker(25, Fishing.Data.fishmarkets[Market].x, Fishing.Data.fishmarkets[Market].y, Fishing.Data.fishmarkets[Market].z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if Distance < 1.0 then
						
						if IsControlJustPressed(1, 51) then
							if not WarMenu.IsMenuOpened("FishSell") then
								if not WarMenu.DoesMenuExist("FishSell") then
									WarMenu.CreateMenu("FishSell", "Fish Market")
									WarMenu.SetSpriteTitle("FishSell", "shopui_title_conveniencestore")
									WarMenu.SetSubTitle("FishSell", "Welcome fellow fisher!")
									WarMenu.SetMenuX("FishSell", 0.6)
									WarMenu.SetMenuY("FishSell", 0.15)
									WarMenu.SetTitleBackgroundColor("FishSell", 0, 107, 87)
									WarMenu.OpenMenu("FishSell")
								else
									WarMenu.OpenMenu("FishSell")
								end
							else
								WarMenu.CloseMenu()
							end		
						end

						if WarMenu.IsMenuOpened("FishSell") then
							local SellTotal = 0
							local ItemIds = {}

							for Index = 1, #Fishing.Data.SellPoint do
								local ItemQuantity = GetItemQuantity(Fishing.Data.SellPoint[Index].Id)
								if ItemQuantity > 0 then
									if WarMenu.Button(Fishing.Data.SellPoint[Index].Name.." ($"..Fishing.Data.SellPoint[Index].price..")", "$"..(Fishing.Data.SellPoint[Index].price * ItemQuantity)) then
									end

									SellTotal = SellTotal + (Fishing.Data.SellPoint[Index].price * ItemQuantity)
									table.insert(ItemIds, Fishing.Data.SellPoint[Index].Id)
								end
							end
							
							if SellTotal > 0 then
								if WarMenu.Button("Sell", "$"..SellTotal) then
									Notify("You just sold all your fish for $"..SellTotal)
									TriggerServerEvent("Fish.Sell", ItemIds)
									WarMenu.CloseMenu()
								end
							end

							WarMenu.Display()
						end
					elseif Distance > 1.0 then
						if WarMenu.IsMenuOpened("FishSell") then
							WarMenu.CloseMenu()
						end
					end
				end
			end
		end
	end)

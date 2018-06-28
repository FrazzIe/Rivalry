	local Fisher_blipsTemp = {}
	local Fisher_markerBool = false
	local existingVeh = nil
	local isInServiceFisher = false
	local inRangeX = 0
	local inRangeY = 0
	local inRangeZ = 0
	local inRangeDistanceBetweenCoords = 0
	local inRangeTime = 0
	local inRangeXD = 0
	local inRangeYD = 0
	local inRangeZD = 0
	local inRangeDistanceBetweenCoordsD = 0
	local inRangeTimeD = 0
	local soldSnook = 0
	local soldPompano = 0
	local soldSnapper = 0
	local soldRedfish = 0
	local soldBass = 0
	local soldMackerel = 0
	local soldHerring = 0
	local soldSalmon = 0
	local soldBarracuda = 0
	local soldTuna = 0
	local soldYellowtail = 0
	local StartFishing_KEY = 51 -- E
	local Caught_KEY = 201 -- ENTER
	local SuccessLimit = 0.09 -- Maxim 0.1 (high value, low success chances)
	local AnimationSpeed = 0.0015
	local ShowChatMSG = true -- or false
	local IsFishing = false
	local CFish = false
	local BarAnimation = 0
	local Faketimer = 0
	local RunCodeOnly1Time = true
	local PosX = 0.5
	local PosY = 0.1
	local TimerAnimation = 0.1

	local tableOfFish = {
		["Snook"] = {name = "Snook", sold = 0, price = 50},
		["Pompano"] = {name = "Pompano", sold = 0, price = 50},
		["Snapper"] = {name = "Snapper", sold = 0, price = 50},
		["Redfish"] = {name = "Snook", sold = 0, price = 50},
		["Bass"] = {name = "Bass", sold = 0, price = 50},
		["Mackerel"] = {name = "Mackerel", sold = 0, price = 150},
		["Herring"] = {name = "Herring", sold = 0, price = 175},
		["Salmon"] = {name = "Salmon", sold = 0, price = 200},
		["Barracuda"] = {name = "Baracuda", sold = 0, price = 225},
		["Tuna"] = {name = "Tuna", sold = 0, price = 250},
		["Yellowtail"] = {name = "Yellowtail", sold = 0, price = 275},
	}
	RegisterNetEvent('sendUpdatedMarket')
	AddEventHandler('sendUpdatedMarket', function(newtable)
	tableOfFish = {
		["Snook"] = {name = "Snook", sold = newtable["Snook"].sold, price = newtable["Snook"].price},
		["Pompano"] = {name = "Pompano", sold = newtable["Pompano"].sold, price = newtable["Pompano"].price},
		["Snapper"] = {name = "Snapper", sold = newtable["Snapper"].sold, price = newtable["Snapper"].price},
		["Redfish"] = {name = "Snook", sold = newtable["Redfish"].sold, price = newtable["Redfish"].price},
		["Bass"] = {name = "Bass", sold = newtable["Bass"].sold, price = newtable["Bass"].price},
		["Mackerel"] = {name = "Mackerel", sold = newtable["Mackerel"].sold, price = newtable["Mackerel"].price},
		["Herring"] = {name = "Herring", sold = newtable["Herring"].sold, price = newtable["Herring"].price},
		["Salmon"] = {name = "Salmon", sold = newtable["Salmon"].sold, price = newtable["Salmon"].price},
		["Barracuda"] = {name = "Baracuda", sold = newtable["Barracuda"].sold, price = newtable["Barracuda"].price},
		["Tuna"] = {name = "Tuna", sold = newtable["Tuna"].sold, price = newtable["Tuna"].price},
		["Yellowtail"] = {name = "Yellowtail", sold = newtable["Yellowtail"].sold, price = newtable["Yellowtail"].price},
	}
end)
	fishing_menu = false
	function Fisher_callSE(evt)
		fishing_menu = false
		TriggerServerEvent(evt)
	end

	function Fisher_InitMenuVehicules()
	    Menu.SetupMenu("fishing_menu","Fishing Garage")
	    Menu.Switch(nil,"fishing_menu")
		Menu.addOption("fishing_menu", function()
		    if(Menu.Option("Boat"))then
		        Fisher_callSE('Fisher:Car')
		    end
		end)
		Menu.addOption("fishing_menu", function()
		    if(Menu.Option("Van"))then
		        Fisher_callSE('Fisher:Car2')
		    end
		end)	
	end


	RegisterNetEvent('Fisher:drawBlips')
	AddEventHandler('Fisher:drawBlips', function () 
		for key, item in pairs(Fisher_blips) do
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, item.id)
			SetBlipAsShortRange(item.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(item.name)
			EndTextCommandSetBlipName(item.blip)
		end
		Fisher_blipsTemp = Fisher_blip
	end)

	RegisterNetEvent('Fisher:deleteBlips')
	AddEventHandler('Fisher:deleteBlips', function ()
		Fisher_markerBool = false
		for _, item in pairs(Fisher_blipsTemp) do
			RemoveBlip(item.blip)
		end
	end)

	RegisterNetEvent('Fisher:drawMarker')
	AddEventHandler('Fisher:drawMarker', function (boolean) 
		Fisher_markerBool = boolean
		Citizen.CreateThread(function()
			while Fisher_markerBool == true do
				Wait(0)
				for k, v in ipairs(Piers) do
					if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) <= v.distanceBetweenCoords then
						inRangeX = v.x
						inRangeY = v.y
						inRangeZ = v.z
						inRangeTime = v.defaultTime
						inRangeDistanceBetweenCoords = v.distanceBetweenCoords
					end	
				end

				for k, v in ipairs(DeepSeaFishing) do
					if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) <= v.distanceBetweenCoords then
						inRangeXD = v.x
						inRangeYD = v.y
						inRangeZD = v.z
						inRangeTimeD = v.defaultTime
						inRangeDistanceBetweenCoordsD = v.distanceBetweenCoords
					end
				end

				if isInServiceFisher then
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fisher_blips["Garage"].x, Fisher_blips["Garage"].y, Fisher_blips["Garage"].z, true) <= Fisher_blips["Garage"].distanceMarker then
						DrawMarker(1, Fisher_blips["Garage"].x, Fisher_blips["Garage"].y, Fisher_blips["Garage"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
						ClearPrints()
						SetTextEntry_2("STRING")
						if(existingVeh ~= nil) then
							AddTextComponentString("Press ~g~E~s~ to store your ~b~vehicle.")
						else
							AddTextComponentString("Press ~g~E~s~ to retrieve your ~b~vehicle.")
						end
						DrawSubtitleTimed(2000, 1)
						if IsControlJustPressed(1, 51) then
							if(existingVeh ~= nil) then
								SetEntityAsMissionEntity(existingVeh, true, true)
								Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
								existingVeh = nil
							else
								Fisher_InitMenuVehicules()
								fishing_menu = not fishing_menu
							end
						end
					end
				end

				if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), inRangeX, inRangeY, inRangeZ, true) <= inRangeDistanceBetweenCoords then
					SetTextEntry_2("STRING")
					AddTextComponentString("Press ~g~E~s~ to cast your fishing rod")
					DrawSubtitleTimed(2000, 1)
					if IsControlJustPressed(1, StartFishing_KEY) then
						IsFishing = true
						RunCodeOnly1Time = true
						BarAnimation = 0
						FishRod = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
					end
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
							DetachEntity(FishRod, true, true)
							DeleteEntity(FishRod)
							DeleteObject(FishRod)
						end
						if TimerAnimation <= 0 then
							CFish = false
							TimerAnimation = 0.1
							StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',2.0)
							Citizen.Wait(200)
							DetachEntity(FishRod, true, true)
							DeleteEntity(FishRod)
							DeleteObject(FishRod)
						end
						if IsControlJustPressed(1, Caught_KEY) then
							if BarAnimation >= SuccessLimit then
								CFish = false
								TimerAnimation = 0.1
								StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',2.0)
								Citizen.Wait(200)
								DetachEntity(FishRod, true, true)
								DeleteEntity(FishRod)
								DeleteObject(FishRod)
								TriggerServerEvent('Fisher:serverRequest', "GetPoisson")
							else
								CFish = false
								TimerAnimation = 0.1
								StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',2.0)
								TriggerEvent('chatMessage', "The fish slipped away! You need to be more focused!")
								Citizen.Wait(200)
								DetachEntity(FishRod, true, true)
								DeleteEntity(FishRod)
								DeleteObject(FishRod)
							end
						end
					end
				end

				if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), inRangeXD, inRangeYD, inRangeZD, true) <= inRangeDistanceBetweenCoordsD then
					SetTextEntry_2("STRING")
					AddTextComponentString("Press ~g~E~s~ to cast your fishing rod")
					DrawSubtitleTimed(2000, 1)
					if IsControlJustPressed(1, StartFishing_KEY) then
						IsFishing = true
						RunCodeOnly1Time = true
						BarAnimation = 0
						FishRod = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
					end
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
							DetachEntity(FishRod, true, true)
							DeleteEntity(FishRod)
							DeleteObject(FishRod)
						end
						if TimerAnimation <= 0 then
							CFish = false
							TimerAnimation = 0.1
							StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',2.0)
							Citizen.Wait(200)
							DetachEntity(FishRod, true, true)
							DeleteEntity(FishRod)
							DeleteObject(FishRod)
							
						end
						if IsControlJustPressed(1, Caught_KEY) then
							if BarAnimation >= SuccessLimit then
								CFish = false
								TimerAnimation = 0.1
								StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',2.0)
								Citizen.Wait(200)
								DetachEntity(FishRod, true, true)
								DeleteEntity(FishRod)
								DeleteObject(FishRod)
								TriggerServerEvent('Fisher:serverRequest', "GetPoissonDeep")								
							else
								CFish = false
								TimerAnimation = 0.1
								StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',2.0)
								Citizen.Wait(200)
								TriggerEvent('chatMessage', "The fish slipped away! You need to be more focused!")
								DetachEntity(FishRod, true, true)
								DeleteEntity(FishRod)
								DeleteObject(FishRod)
							end
						end
					end
					TriggerServerEvent('Fisher:serverRequest', "GetPoisson")
				end

				if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fisher_blips["Fish Shop"].x,Fisher_blips["Fish Shop"].y,Fisher_blips["Fish Shop"].z, true) <= Fisher_blips["Fish Shop"].distanceBetweenCoords then
					TriggerServerEvent('Fisher:serverRequest', "GetFilet")
					Citizen.Wait(Fisher_blips["Fish Shop"].defaultTime)
				end
			
				if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fisher_blips["Point of Sale"].x,Fisher_blips["Point of Sale"].y,Fisher_blips["Point of Sale"].z, true) <= Fisher_blips["Point of Sale"].distanceBetweenCoords then
					TriggerServerEvent('Fisher:serverRequest', "SellFilet")
					Citizen.Wait(Fisher_blips["Point of Sale"].defaultTime)
				end

			end
		end)
	end)

	RegisterNetEvent('Fisher:marker')
	AddEventHandler('Fisher:marker', function ()
		Citizen.CreateThread(function () 
			while Fisher_markerBool == true do
				Citizen.Wait(1)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fisher_blips["Entreprise"].x, Fisher_blips["Entreprise"].y, Fisher_blips["Entreprise"].z, true) <= Fisher_blips["Entreprise"].distanceMarker then
					DrawMarker(25, Fisher_blips["Entreprise"].x, Fisher_blips["Entreprise"].y, Fisher_blips["Entreprise"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					ClearPrints()
					SetTextEntry_2("STRING")
					if isInServiceFisher then
						AddTextComponentString("Press ~g~E~s~ to go on ~b~break.")
					else
						AddTextComponentString("Press ~g~E~s~ to continue ~b~fishing")
					end
					DrawSubtitleTimed(2000, 1)
					if IsControlJustPressed(1, 51) then
						GetServiceFisher()
					end
				end
				if isInServiceFisher then
						for k, v in ipairs(Piers) do
							if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) <= v.distanceMarker then
								DrawMarker(25, v.x, v.y, v.z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
							end
						end

						for k, v in ipairs(DeepSeaFishing) do
							if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) <= v.distanceMarker then
								DrawMarker(25, v.x, v.y, v.z+1, 0, 0, 0, 0, 0, 0, 25.001, 25.0001, 2.5001, 0, 155, 255, 0, 0, 0, 0, 0)
							end
						end
			        if fishing_menu then
			        	job_menu = false
			        	brewer_menu = false
			        	farmer_menu = false
			        	lumberjack_menu = false
			        	miner_menu = false
			        	wine_menu = false
			            Menu.DisplayCurMenu()
			        end

					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fisher_blips["Fish Shop"].x,Fisher_blips["Fish Shop"].y,Fisher_blips["Fish Shop"].z, true) <= Fisher_blips["Fish Shop"].distanceMarker then
						DrawMarker(25,Fisher_blips["Fish Shop"].x,Fisher_blips["Fish Shop"].y,Fisher_blips["Fish Shop"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end

					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fisher_blips["Point of Sale"].x,Fisher_blips["Point of Sale"].y,Fisher_blips["Point of Sale"].z, true) <= Fisher_blips["Point of Sale"].distanceMarker then
						DrawMarker(25,Fisher_blips["Point of Sale"].x,Fisher_blips["Point of Sale"].y,Fisher_blips["Point of Sale"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
				end
			end
		end)
	end)

function GetServiceFisher()
	local playerPed = GetPlayerPed(-1)
	if isInServiceFisher then
		notif("Enjoy your break!")
		TriggerServerEvent("clothes:spawn")
	else
		notif("Get to work!")
		TriggerEvent("Fisher:getSkin")
	end
	isInServiceFisher = not isInServiceFisher
	TriggerServerEvent('Fisher:setService', isInServiceFisher)
end
	RegisterNetEvent('Fisher:getSkin')
	AddEventHandler('Fisher:getSkin', function (source)
	local hashSkin = GetHashKey("mp_m_freemode_01")
	Citizen.CreateThread(function()
		if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			SetPedComponentVariation(GetPlayerPed(-1), 11, 124, 0, 2)  -- Top
			SetPedComponentVariation(GetPlayerPed(-1), 8, 24, 1, 2)   -- under coat
			SetPedComponentVariation(GetPlayerPed(-1), 4, 47, 1, 2)   -- Pants
			SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2)   -- shoes
			SetPedComponentVariation(GetPlayerPed(-1), 3, 108, 0, 2)   -- under skin
		else
			SetPedComponentVariation(GetPlayerPed(-1), 11, 63, 3, 2)  -- Top
			SetPedComponentVariation(GetPlayerPed(-1), 8, 44, 1, 2)   -- under coat
			SetPedComponentVariation(GetPlayerPed(-1), 4, 11, 14, 2)   -- Pants
			SetPedComponentVariation(GetPlayerPed(-1), 6, 36, 0, 2)   -- shoes
			SetPedComponentVariation(GetPlayerPed(-1), 3, 78, 0, 2)   -- under skin
		end
	end)
	end)

	RegisterNetEvent('Fisher:getCar')
	AddEventHandler('Fisher:getCar', function (source)
		local vehiculeDetected = GetClosestVehicle(Fisher_car.x, Fisher_car.y, Fisher_car.z, 6.0, 0, 70)
		if not DoesEntityExist(vehiculeDetected) then
			local myPed = GetPlayerPed(-1)
			local player = PlayerId()
			local vehicle = GetHashKey('tug')
			RequestModel(vehicle)
			while not HasModelLoaded(vehicle) do
				Wait(1)
			end
			local plate = math.random(100, 900)
			existingVeh = CreateVehicle(vehicle,Fisher_car.x, Fisher_car.y, Fisher_car.z,-90.0, true, false)
			SetVehicleHasBeenOwnedByPlayer(existingVeh,true)
			local id = NetworkGetNetworkIdFromEntity(existingVeh)
			SetNetworkIdCanMigrate(id, true)
			SetEntityInvincible(existingVeh, false)
			SetVehicleOnGroundProperly(existingVeh)
			TaskWarpPedIntoVehicle(myPed, existingVeh, -1)
			SetModelAsNoLongerNeeded(vehicle)
			DecorSetBool(existingVeh, "hotwire", true)
			Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(existingVeh))
		else
			notif("Area is congested.")
		end
		
	end)

	RegisterNetEvent('Fisher:getCar2')
	AddEventHandler('Fisher:getCar2', function (source)
		local vehiculeDetected = GetClosestVehicle(Fisher_car2.x, Fisher_car2.y, Fisher_car2.z, 6.0, 0, 70)
		if not DoesEntityExist(vehiculeDetected) then
			local myPed = GetPlayerPed(-1)
			local player = PlayerId()
			local vehicle = GetHashKey('paradise')
			RequestModel(vehicle)
			while not HasModelLoaded(vehicle) do
				Wait(1)
			end
			local plate = math.random(100, 900)
			existingVeh = CreateVehicle(vehicle,Fisher_car2.x, Fisher_car2.y, Fisher_car2.z,110.5, true, false)
			SetVehicleHasBeenOwnedByPlayer(existingVeh,true)
			local id = NetworkGetNetworkIdFromEntity(existingVeh)
			SetNetworkIdCanMigrate(id, true)
			SetEntityInvincible(existingVeh, false)
			SetVehicleOnGroundProperly(existingVeh)
			TaskWarpPedIntoVehicle(myPed, existingVeh, -1)
			SetModelAsNoLongerNeeded(vehicle)
			DecorSetBool(existingVeh, "hotwire", true)
			Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(existingVeh))
		else
			notif("Area is congested.")
		end
		
	end)

	local isPlaying = 0
	RegisterNetEvent('Fisher:drawGetPoisson')
	AddEventHandler('Fisher:drawGetPoisson', function (qtePoisson)
		if(qtePoisson == nil) then
			qtePoisson = 0
		end
		if isPlaying == 0 then
			TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", 0, false)
			isPlaying = 1
		end
		if IsPedActiveInScenario(PlayerPedId()) then
			isPlaying = 1
		else
			isPlaying = 0
		end
		local typeOfFish = math.random(1,5)
		local fish = 0
		local name = ""
		if(typeOfFish == 1)then
			fish =  21
			name = "Snook"
		elseif typeOfFish == 2 then
			fish =  50
			name = "Pompano"
		elseif typeOfFish == 3 then
			fish = 52
			name = "Snapper"
		elseif typeOfFish == 4 then
			fish = 54
			name = "Redfish"
		elseif typeOfFish == 5 then
			fish = 56
			name = "Bass"
		end
		TriggerEvent('inventory:addQty',fish, 5)
		ClearPrints()
		TriggerEvent('chatMessage', "You caught a "..name.."!")
	end)

	RegisterNetEvent('Fisher:drawGetPoissonDeep')
	AddEventHandler('Fisher:drawGetPoissonDeep', function (qtePoisson)
		if(qtePoisson == nil) then
			qtePoisson = 0
		end
		if isPlaying == 0 then
			TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", 0, false)
			isPlaying = 1
		end
		local typeOfFish = math.random(1,6)
		local fish = 0
		local name = ""
		if(typeOfFish == 1)then
			fish =  58
			name = "Mackerel"
		elseif typeOfFish == 2 then
			fish =  60
			name = "Herring"
		elseif typeOfFish == 3 then
			fish = 62
			name = "Salmon"
		elseif typeOfFish == 4 then
			fish = 64
			name = "Barracuda"
		elseif typeOfFish == 5 then
			fish = 66
			name = "Tuna"
		elseif typeOfFish == 6 then
			fish = 68
			name = "Yellowtail"
		end
		TriggerEvent('inventory:addQty',fish, 2)
		ClearPrints()
		TriggerEvent('chatMessage', "You caught a "..name.."!")
	end)

	local beingSold = 1
	RegisterNetEvent('Fisher:drawSellFilet')
	AddEventHandler('Fisher:drawSellFilet', function (qte, qte2, qte3, qte4, qte5, qte6, qte7, qte8, qte9, qte10, qte11)
		if(qte == nil) then
			qte = 0
		end
		if qte > 0  or qte2 > 0 or qte3 > 0 or qte4 > 0 or qte5 > 0 or qte6 > 0 or qte7 > 0 or qte8 > 0 or qte9 > 0 or qte10 > 0 or qte11 > 0 then
			if(qte >= 1)then
				TriggerEvent('inventory:removeQty',21, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Snook"].price)
				tableOfFish["Snook"].sold = tableOfFish["Snook"].sold + 1
			end
			if(qte2 >= 1)then
				TriggerEvent('inventory:removeQty',50, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Pompano"].price)
				tableOfFish["Pompano"].sold = tableOfFish["Pompano"].sold + 1
			end
			if(qte3 >= 1)then
				TriggerEvent('inventory:removeQty',52, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Snapper"].price)
				tableOfFish["Snapper"].sold = tableOfFish["Snapper"].sold + 1
			end
			if	(qte4 >= 1)then
				TriggerEvent('inventory:removeQty',54, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Redfish"].price)
				tableOfFish["Redfish"].sold = tableOfFish["Redfish"].sold + 1
			end
			if (qte5 >= 1)then
				TriggerEvent('inventory:removeQty',56, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Bass"].price)
				tableOfFish["Bass"].sold = tableOfFish["Bass"].sold + 1
			end
			if (qte6 >= 1)then
				TriggerEvent('inventory:removeQty',58, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Mackerel"].price)
				tableOfFish["Mackerel"].sold = tableOfFish["Mackerel"].sold + 1
			end
			if (qte7 >= 1)then
				TriggerEvent('inventory:removeQty',60, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Herring"].price)
				tableOfFish["Herring"].sold = tableOfFish["Herring"].sold + 1
			end
			if (qte8 >= 1)then
				TriggerEvent('inventory:removeQty',62, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Salmon"].price)
				tableOfFish["Salmon"].sold = tableOfFish["Salmon"].sold + 1
			end
			if (qte9 >= 1)then
				TriggerEvent('inventory:removeQty',64, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Barracuda"].price)
				tableOfFish["Barracuda"].sold = tableOfFish["Barracuda"].sold + 1
			end
			if (qte10 >= 1)then	
				TriggerEvent('inventory:removeQty',66, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Tuna"].price)
				tableOfFish["Tuna"].sold = tableOfFish["Tuna"].sold + 1
			end
			if (qte11 >= 1)then
				TriggerEvent('inventory:removeQty',68, 1)
				TriggerServerEvent('mission:completed', tableOfFish["Yellowtail"].price)
				tableOfFish["Yellowtail"].sold = tableOfFish["Yellowtail"].sold + 1
			end
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~g~You sold a fish!")
			DrawSubtitleTimed(2000, 1)
			fluxiateMarket()
		else
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~r~You have no fish left to sell.")
			beingSold = beingSold + 1
			DrawSubtitleTimed(2000, 1)
		end
	end)

function fluxiateMarket()
	local fish, fish2 = 0, 0
	local maxShallow = math.max(tableOfFish["Snook"].sold, tableOfFish["Pompano"].sold, tableOfFish["Snapper"].sold, tableOfFish["Redfish"].sold , tableOfFish["Bass"].sold)
	local maxDeep = math.max(tableOfFish["Mackerel"].sold, tableOfFish["Herring"].sold, tableOfFish["Salmon"].sold, tableOfFish["Barracuda"].sold , tableOfFish["Tuna"].sold, tableOfFish["Yellowtail"].sold)
	local minShallow = math.min(tableOfFish["Snook"].sold, tableOfFish["Pompano"].sold, tableOfFish["Snapper"].sold, tableOfFish["Redfish"].sold , tableOfFish["Bass"].sold)
	local minDeep = math.min(tableOfFish["Mackerel"].sold, tableOfFish["Herring"].sold, tableOfFish["Salmon"].sold, tableOfFish["Barracuda"].sold , tableOfFish["Tuna"].sold, tableOfFish["Yellowtail"].sold)
	for k, v in ipairs(tableOfFish)do
		if(v.sold == maxShallow) then
			v.price = v.price * .75
		elseif(v.sold == maxDeep) then
			v.price = v.price * .75
		elseif(v.sold == minShallow) then
			v.price = v.price / .5
		elseif(v.sold == minDeep)then
			v.price = v.price / .5
		end
	end
	TriggerServerEvent('fluxiateMarket', tableOfFish)
end

Citizen.CreateThread(function() -- Thread for  timer
	while true do 
		Citizen.Wait(1000)
		Faketimer = Faketimer + 1 
	end 
end)

-- F  U  N  C  T  I  O  N  S 
function GetCar() return GetVehiclePedIsIn(GetPlayerPed(-1),false) end
function GetPed() return GetPlayerPed(-1) end
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
	DrawRect(PosX,PosY+0.005,TimerAnimation,0.005,255,255,0,255)
	DrawRect(PosX,PosY,0.1,0.01,0,0,0,255)
	TimerAnimation = TimerAnimation - 0.0001025
	if BarAnimation >= SuccessLimit then
		DrawRect(PosX,PosY,BarAnimation,0.01,102,255,102,150)
	else
		DrawRect(PosX,PosY,BarAnimation,0.01,255,51,51,150)
	end
	if BarAnimation <= 0 then
		up = true
	end
	if BarAnimation >= PosY then
		up = false
	end
	if not up then
		BarAnimation = BarAnimation - AnimationSpeed
	else
		BarAnimation = BarAnimation + AnimationSpeed
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
	BoneID = GetPedBoneIndex(GetPed(), bone_ID)
	obj = CreateObject(GetHashKey(prop),  1729.73,  6403.90,  34.56,  true,  true,  true)
	vX,vY,vZ = table.unpack(GetEntityCoords(GetPed()))
	xRot, yRot, zRot = table.unpack(GetEntityRotation(GetPed(),2))
	AttachEntityToEntity(obj,  GetPed(),  BoneID, x,y,z, RotX,RotY,RotZ,  false, false, false, false, 2, true)
	return obj
end
function Chat(text)
	TriggerEvent("chatMessage", 'SYSTEM', { 255,255,0}, text)
end

	local Fisher_blipsTemp = {}
	local Fisher_blipsTemp2 = {}
	local Fisher_blipsTemp3 = {}
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
	local whichgarage = 0
	local tableOfFish2 = {
		["Snook"] = {price = 50},
		["Pompano"] = {price = 50},
		["Snapper"] = {price = 50},
		["Redfish"] = {price = 50},
		["Bass"] = {price = 50},
		["Mackerel"] = {price = 150},
		["Herring"] = {price = 175},
		["Salmon"] = {price = 200},
		["Barracuda"] = {price = 225},
		["Tuna"] = {price = 250},
		["Yellowtail"] = {price = 275},
	}

	RegisterNetEvent("fish:sync")
		AddEventHandler("fish:sync", function(newtable)
			tableOfFish = {
			soldSnook = newtable.snooksold,
			soldPompano = newtable.pompanosold,
			soldSnapper = newtable.snappersold,
			soldRedfish = newtable.redfishsold,
			soldBass = newtable.basssold,
			soldMackerel = newtable.mackerelsold,
			soldHerring = newtable.herringsold,
			soldSalmon = newtable.salmonsold,
			soldBarracuda = newtable.barracudasold,
			soldTuna = newtable.tunasold,
			soldYellowtail = newtable.yellowtailsold,
			}
	end)

	local tableOfFish = {
		["Snook"] = {name = "Snook", sold = soldSnook, price = tableOfFish2["Snook"].price},
		["Pompano"] = {name = "Pompano", sold = soldPompano, price = tableOfFish2["Pompano"].price},
		["Snapper"] = {name = "Snapper", sold = soldSnapper, price = tableOfFish2["Snapper"].price},
		["Redfish"] = {name = "Redfish", sold = soldRedfish, price = tableOfFish2["Redfish"].price},
		["Bass"] = {name = "Bass", sold = soldBass, price = tableOfFish2["Bass"].price},
		["Mackerel"] = {name = "Mackerel", sold = soldMackerel, price = tableOfFish2["Mackerel"].price},
		["Herring"] = {name = "Herring", sold = soldHerring, price = tableOfFish2["Herring"].price},
		["Salmon"] = {name = "Salmon", sold = soldSalmon, price = tableOfFish2["Salmon"].price},
		["Barracuda"] = {name = "Baracuda", sold = soldBarracuda, price = tableOfFish2["Barracuda"].price},
		["Tuna"] = {name = "Tuna", sold = soldTuna, price = tableOfFish2["Tuna"].price},
		["Yellowtail"] = {name = "Yellowtail", sold = soldYellowtail, price = tableOfFish2["Yellowtail"].price},
	}

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
		for key, item in pairs(Piers) do
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, item.id)
			SetBlipAsShortRange(item.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(item.name)
			EndTextCommandSetBlipName(item.blip)
		end
		for key, item in pairs(DeepSeaFishing) do
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, item.id)
			SetBlipAsShortRange(item.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(item.name)
			EndTextCommandSetBlipName(item.blip)
		end
		Fisher_blipsTemp = Fisher_blips
		Fisher_blipsTemp2 = Piers
		Fisher_blipsTemp3 = DeepSeaFishing
	end)

	RegisterNetEvent('Fisher:deleteBlips')
	AddEventHandler('Fisher:deleteBlips', function ()
		Fisher_markerBool = false
		for _, item in pairs(Fisher_blipsTemp) do
			RemoveBlip(item.blip)
		end
		for _, item in pairs(Fisher_blipsTemp2) do
			RemoveBlip(item.blip)
		end
		for _, item in pairs(Fisher_blipsTemp3) do
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
					if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, true) <= v.distanceBetweenCoords then
						inRangeX = v.x
						inRangeY = v.y
						inRangeZ = v.z
						inRangeTime = v.defaultTime
						inRangeDistanceBetweenCoords = v.distanceBetweenCoords
					end	
				end

				for k, v in ipairs(DeepSeaFishing) do
					if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, true) <= v.distanceBetweenCoords then
						inRangeXD = v.x
						inRangeYD = v.y
						inRangeZD = v.z
						inRangeTimeD = v.defaultTime
						inRangeDistanceBetweenCoordsD = v.distanceBetweenCoords
					end
				end

				if isInServiceFisher then
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Garages["Garage"].x, Garages["Garage"].y, Garages["Garage"].z, true) <= Garages["Garage"].distanceMarker then
						DrawMarker(25, Garages["Garage"].x, Garages["Garage"].y, Garages["Garage"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
						ClearPrints()
						SetTextEntry_2("STRING")
						if(existingVeh ~= nil) then
							AddTextComponentString("Press ~g~E~s~ to store your ~b~vehicle.")
						else
							AddTextComponentString("Press ~g~E~s~ to retrieve your ~b~vehicle.")
						end
						DrawSubtitleTimed(2000, 1)
						if IsControlJustPressed(1, 51) then
							whichgarage = 0
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
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Garages["Garage2"].x, Garages["Garage2"].y, Garages["Garage2"].z, true) <= Garages["Garage2"].distanceMarker then
						DrawMarker(25, Garages["Garage2"].x, Garages["Garage2"].y, Garages["Garage2"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
						ClearPrints()
						SetTextEntry_2("STRING")
						if(existingVeh ~= nil) then
							AddTextComponentString("Press ~g~E~s~ to store your ~b~vehicle.")
						else
							AddTextComponentString("Press ~g~E~s~ to retrieve your ~b~vehicle.")
						end
						DrawSubtitleTimed(2000, 1)
						if IsControlJustPressed(1, 51) then
							whichgarage = 1
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
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Garages["Garage3"].x, Garages["Garage3"].y, Garages["Garage3"].z, true) <= Garages["Garage3"].distanceMarker then
						DrawMarker(25, Garages["Garage3"].x, Garages["Garage3"].y, Garages["Garage3"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
						ClearPrints()
						SetTextEntry_2("STRING")
						if(existingVeh ~= nil) then
							AddTextComponentString("Press ~g~E~s~ to store your ~b~vehicle.")
						else
							AddTextComponentString("Press ~g~E~s~ to retrieve your ~b~vehicle.")
						end
						DrawSubtitleTimed(2000, 1)
						if IsControlJustPressed(1, 51) then
							whichgarage = 2
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

				if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), inRangeX, inRangeY, inRangeZ, true) <= inRangeDistanceBetweenCoords then
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
								TriggerServerEvent('Fisher:serverRequest', "GetPoisson")
								DetachEntity(FishRod, true, true)
								DeleteEntity(FishRod)
								DeleteObject(FishRod)
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
							DetachEntity(FishRod, true, true)
							DeleteEntity(FishRod)
							DeleteObject(FishRod)
						end
					end
				end

				if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), inRangeXD, inRangeYD, inRangeZD, true) <= inRangeDistanceBetweenCoordsD then
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
							DetachEntity(FishRod, true, true)
							DeleteEntity(FishRod)
							DeleteObject(FishRod)
						end
					end
				end
			
				if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Fisher_blips["Point of Sale"].x,Fisher_blips["Point of Sale"].y,Fisher_blips["Point of Sale"].z, true) <= Fisher_blips["Point of Sale"].distanceBetweenCoords then
					TriggerServerEvent('Fisher:serverRequest', "SellFilet")
					Citizen.Wait(Fisher_blips["Point of Sale"].defaultTime)
				end

				if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Fisher_blips["Point of Sale 2"].x,Fisher_blips["Point of Sale 2"].y,Fisher_blips["Point of Sale 2"].z, true) <= Fisher_blips["Point of Sale 2"].distanceBetweenCoords then
					TriggerServerEvent('Fisher:serverRequest', "SellFilet")
					Citizen.Wait(Fisher_blips["Point of Sale 2"].defaultTime)
				end

				if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Fisher_blips["Point of Sale 3"].x,Fisher_blips["Point of Sale 3"].y,Fisher_blips["Point of Sale 3"].z, true) <= Fisher_blips["Point of Sale 3"].distanceBetweenCoords then
					TriggerServerEvent('Fisher:serverRequest', "SellFilet")
					Citizen.Wait(Fisher_blips["Point of Sale 3"].defaultTime)
				end

			end
		end)
	end)

	RegisterNetEvent('Fisher:marker')
	AddEventHandler('Fisher:marker', function ()
		Citizen.CreateThread(function () 
			while Fisher_markerBool == true do
				Citizen.Wait(1)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Fisher_blips["Entreprise"].x, Fisher_blips["Entreprise"].y, Fisher_blips["Entreprise"].z, true) <= Fisher_blips["Entreprise"].distanceMarker then
					DrawMarker(25, Fisher_blips["Entreprise"].x, Fisher_blips["Entreprise"].y, Fisher_blips["Entreprise"].z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
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
						TriggerServerEvent("fish:initialise", source)
					end
				end
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Fisher_blips["Entreprise2"].x, Fisher_blips["Entreprise2"].y, Fisher_blips["Entreprise2"].z, true) <= Fisher_blips["Entreprise2"].distanceMarker then
					DrawMarker(25, Fisher_blips["Entreprise2"].x, Fisher_blips["Entreprise2"].y, Fisher_blips["Entreprise2"].z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
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
						TriggerServerEvent("fish:initialise", source)
					end
				end
				if isInServiceFisher then
						for k, v in ipairs(Piers) do
							if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z, true) <= v.distanceMarker then
								DrawMarker(25, v.x, v.y, v.z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
							end
						end

						for k, v in ipairs(DeepSeaFishing) do
							if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z, true) <= v.distanceMarker then
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

					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Fisher_blips["Point of Sale"].x,Fisher_blips["Point of Sale"].y,Fisher_blips["Point of Sale"].z, true) <= Fisher_blips["Point of Sale"].distanceMarker then
						DrawMarker(25,Fisher_blips["Point of Sale"].x,Fisher_blips["Point of Sale"].y,Fisher_blips["Point of Sale"].z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Fisher_blips["Point of Sale 2"].x,Fisher_blips["Point of Sale 2"].y,Fisher_blips["Point of Sale 2"].z, true) <= Fisher_blips["Point of Sale 2"].distanceMarker then
						DrawMarker(25,Fisher_blips["Point of Sale 2"].x,Fisher_blips["Point of Sale 2"].y,Fisher_blips["Point of Sale 2"].z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Fisher_blips["Point of Sale 3"].x,Fisher_blips["Point of Sale 3"].y,Fisher_blips["Point of Sale 3"].z, true) <= Fisher_blips["Point of Sale 3"].distanceMarker then
						DrawMarker(25,Fisher_blips["Point of Sale 3"].x,Fisher_blips["Point of Sale 3"].y,Fisher_blips["Point of Sale 3"].z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
				end
			end
		end)
	end)

function GetServiceFisher()
	local playerPed = PlayerPedId()
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
		if(GetEntityModel(PlayerPedId()) == hashSkin) then
			SetPedComponentVariation(PlayerPedId(), 11, 124, 0, 2)  -- Top
			SetPedComponentVariation(PlayerPedId(), 8, 24, 1, 2)   -- under coat
			SetPedComponentVariation(PlayerPedId(), 4, 47, 1, 2)   -- Pants
			SetPedComponentVariation(PlayerPedId(), 6, 25, 0, 2)   -- shoes
			SetPedComponentVariation(PlayerPedId(), 3, 108, 0, 2)   -- under skin
		else
			SetPedComponentVariation(PlayerPedId(), 11, 63, 3, 2)  -- Top
			SetPedComponentVariation(PlayerPedId(), 8, 44, 1, 2)   -- under coat
			SetPedComponentVariation(PlayerPedId(), 4, 11, 14, 2)   -- Pants
			SetPedComponentVariation(PlayerPedId(), 6, 36, 0, 2)   -- shoes
			SetPedComponentVariation(PlayerPedId(), 3, 78, 0, 2)   -- under skin
		end
	end)
	end)

	RegisterNetEvent('Fisher:getCar')
	AddEventHandler('Fisher:getCar', function (source)
		if whichgarage == 1 then
			garageX = Fisher_car1.x
			garageY = Fisher_car1.y
			garageZ = Fisher_car1.z
		elseif whichgarage == 2 then
			garageX = Fisher_car2.x
			garageY = Fisher_car2.y
			garageZ = Fisher_car2.z
		else
			garageX = Fisher_car.x
			garageY = Fisher_car.y
			garageZ = Fisher_car.z
		end
		local vehiculeDetected = GetClosestVehicle(garageX, garageY, garageZ, 6.0, 0, 70)
		if not DoesEntityExist(vehiculeDetected) then
			local myPed = PlayerPedId()
			local player = PlayerId()
			local vehicle = GetHashKey('tug')
			RequestModel(vehicle)
			while not HasModelLoaded(vehicle) do
				Wait(1)
			end
			local plate = math.random(100, 900)
			existingVeh = CreateVehicle(vehicle,garageX, garageY, garageZ,-90.0, true, false)
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
		fluxiateMarket()
		if(qte == nil) then
			qte = 0
		end
		if qte > 0  or qte2 > 0 or qte3 > 0 or qte4 > 0 or qte5 > 0 or qte6 > 0 or qte7 > 0 or qte8 > 0 or qte9 > 0 or qte10 > 0 or qte11 > 0 then
			if(qte >= 1)then
				TriggerEvent('inventory:removeQty',21, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Snook"].price)
				tableOfFish["Snook"].sold = tableOfFish["Snook"].sold + 1
			end
			if(qte2 >= 1)then
				TriggerEvent('inventory:removeQty',50, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Pompano"].price)
				tableOfFish["Pompano"].sold = tableOfFish["Pompano"].sold + 1
			end
			if(qte3 >= 1)then
				TriggerEvent('inventory:removeQty',52, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Snapper"].price)
				tableOfFish["Snapper"].sold = tableOfFish["Snapper"].sold + 1
			end
			if	(qte4 >= 1)then
				TriggerEvent('inventory:removeQty',54, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Redfish"].price)
				tableOfFish["Redfish"].sold = tableOfFish["Redfish"].sold + 1
			end
			if (qte5 >= 1)then
				TriggerEvent('inventory:removeQty',56, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Bass"].price)
				tableOfFish["Bass"].sold = tableOfFish["Bass"].sold + 1
			end
			if (qte6 >= 1)then
				TriggerEvent('inventory:removeQty',58, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Mackerel"].price)
				tableOfFish["Mackerel"].sold = tableOfFish["Mackerel"].sold + 1
			end
			if (qte7 >= 1)then
				TriggerEvent('inventory:removeQty',60, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Herring"].price)
				tableOfFish["Herring"].sold = tableOfFish["Herring"].sold + 1
			end
			if (qte8 >= 1)then
				TriggerEvent('inventory:removeQty',62, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Salmon"].price)
				tableOfFish["Salmon"].sold = tableOfFish["Salmon"].sold + 1
			end
			if (qte9 >= 1)then
				TriggerEvent('inventory:removeQty',64, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Barracuda"].price)
				tableOfFish["Barracuda"].sold = tableOfFish["Barracuda"].sold + 1
			end
			if (qte10 >= 1)then	
				TriggerEvent('inventory:removeQty',66, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Tuna"].price)
				tableOfFish["Tuna"].sold = tableOfFish["Tuna"].sold + 1
			end
			if (qte11 >= 1)then
				TriggerEvent('inventory:removeQty',68, 1)
				TriggerServerEvent('mission:completed', tableOfFish2["Yellowtail"].price)
				tableOfFish["Yellowtail"].sold = tableOfFish["Yellowtail"].sold + 1
			end
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~g~You sold a fish!")
			DrawSubtitleTimed(2000, 1)
			fluxiateMarket()
			TriggerServerEvent('fluxiateMarket', tableOfFish)
		else
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~r~You have no fish left to sell.")
			beingSold = beingSold + 1
			DrawSubtitleTimed(2000, 1)
		end
	end)

function fluxiateMarket()
	local maxShallow = math.max(tableOfFish["Snook"].sold, tableOfFish["Pompano"].sold, tableOfFish["Snapper"].sold, tableOfFish["Redfish"].sold , tableOfFish["Bass"].sold)
	local maxDeep = math.max(tableOfFish["Mackerel"].sold, tableOfFish["Herring"].sold, tableOfFish["Salmon"].sold, tableOfFish["Barracuda"].sold , tableOfFish["Tuna"].sold, tableOfFish["Yellowtail"].sold)
	local minShallow = math.min(tableOfFish["Snook"].sold, tableOfFish["Pompano"].sold, tableOfFish["Snapper"].sold, tableOfFish["Redfish"].sold , tableOfFish["Bass"].sold)
	local minDeep = math.min(tableOfFish["Mackerel"].sold, tableOfFish["Herring"].sold, tableOfFish["Salmon"].sold, tableOfFish["Barracuda"].sold , tableOfFish["Tuna"].sold, tableOfFish["Yellowtail"].sold)
	for k, v in ipairs(tableOfFish)do
		if(v.sold == maxShallow) then
			local newprice = tableOfFish2[v.name].price * .75
			tableOfFish2[v.name].price = newprice
		end
		if(v.sold == maxDeep) then
			local newprice = tableOfFish2[v.name].price * .75
			tableOfFish2[v.name].price = newprice
		end
		if(v.sold == minShallow) then
			local newprice = tableOfFish2[v.name].price / .5
			tableOfFish2[v.name].price = newprice
		end
		if(v.sold == minDeep)then
			local newprice = tableOfFish2[v.name].price / .5
			tableOfFish2[v.name].price = newprice
		end
	end
	TriggerServerEvent("fish:initialise", source)
end

Citizen.CreateThread(function() -- Thread for  timer
	while true do 
		Citizen.Wait(1000)
		Faketimer = Faketimer + 1 
	end 
end)

-- F  U  N  C  T  I  O  N  S 
function GetCar() return GetVehiclePedIsIn(PlayerPedId(),false) end
function GetPed() return PlayerPedId() end
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

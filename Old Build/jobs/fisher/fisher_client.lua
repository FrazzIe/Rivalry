	local Fisher_blipsTemp
	local Fisher_markerBool = false
	local existingVeh = nil
	local isInServiceFisher = false
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
		Fisher_blipsTemp = Fisher_blips

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
				
				if isInServiceFisher and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fisher_blips["Fish"].x,Fisher_blips["Fish"].y,Fisher_blips["Fish"].z, true) <= Fisher_blips["Fish"].distanceBetweenCoords then
					TriggerServerEvent('Fisher:serverRequest', "GetPoisson")
					Citizen.Wait(Fisher_blips["Fish"].defaultTime)
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
					DrawMarker(1, Fisher_blips["Entreprise"].x, Fisher_blips["Entreprise"].y, Fisher_blips["Entreprise"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
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
			        if fishing_menu then
			        	job_menu = false
			        	brewer_menu = false
			        	farmer_menu = false
			        	lumberjack_menu = false
			        	miner_menu = false
			        	wine_menu = false
			            Menu.DisplayCurMenu()
			        end
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fisher_blips["Fish"].x, Fisher_blips["Fish"].y, Fisher_blips["Fish"].z, true) <= Fisher_blips["Fish"].distanceMarker then
						DrawMarker(1, Fisher_blips["Fish"].x, Fisher_blips["Fish"].y, Fisher_blips["Fish"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end

					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fisher_blips["Fish Shop"].x,Fisher_blips["Fish Shop"].y,Fisher_blips["Fish Shop"].z, true) <= Fisher_blips["Fish Shop"].distanceMarker then
						DrawMarker(1,Fisher_blips["Fish Shop"].x,Fisher_blips["Fish Shop"].y,Fisher_blips["Fish Shop"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end

					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fisher_blips["Point of Sale"].x,Fisher_blips["Point of Sale"].y,Fisher_blips["Point of Sale"].z, true) <= Fisher_blips["Point of Sale"].distanceMarker then
						DrawMarker(1,Fisher_blips["Point of Sale"].x,Fisher_blips["Point of Sale"].y,Fisher_blips["Point of Sale"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
				end
			end
		end)
	end)

function GetServiceFisher()
	local playerPed = GetPlayerPed(-1)
	if isInServiceFisher then
		notif("Enjoy your break!")
		TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
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

	RegisterNetEvent('Fisher:drawGetPoisson')
	AddEventHandler('Fisher:drawGetPoisson', function (qtePoisson)
		if(qtePoisson == nil) then
			qtePoisson = 0
		end

		TriggerEvent('inventory:addQty',21, 1)
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString("~g~You caught fish!")
		DrawSubtitleTimed(4500, 1)
	end)

	RegisterNetEvent('Fisher:drawGetFilet')
	AddEventHandler('Fisher:drawGetFilet', function(qtePoisson, qteFilet)
		if(qtePoisson == nil) then
			qtePoisson = 0
		end
		
		if(qteFilet == nil) then
			qteFilet = 0
		end

		if qtePoisson > 0 then
			TriggerEvent('inventory:removeQty',21, 1)
			TriggerEvent('inventory:addQty',22, 1)
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~g~Processing fish..")
			DrawSubtitleTimed(4500, 1)
		else
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~r~You have processed all the fish!")
			DrawSubtitleTimed(2000, 1)
		end
	end)

	RegisterNetEvent('Fisher:drawSellFilet')
	AddEventHandler('Fisher:drawSellFilet', function (qte)
		if(qte == nil) then
			qte = 0
		end

		if qte > 0 then
			TriggerEvent('inventory:removeQty',22, 1)
			local salaire = math.random(Fisher_pay.minimum, Fisher_pay.maximum)
			TriggerServerEvent('mission:completed', salaire)
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~g~You sold a fish!")
			DrawSubtitleTimed(2000, 1)
		else
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~r~You have no fish left to sell.")
			DrawSubtitleTimed(2000, 1)
		end
	end)
		
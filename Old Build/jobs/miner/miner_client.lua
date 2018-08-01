	local Miner_blipsTemp
	local Miner_markerBool = false
	local existingVeh = nil
	local isInServiceMiner = false
	miner_menu = false
	function Miner_callSE(evt)
		miner_menu = false
		TriggerServerEvent(evt)
	end

	function Miner_InitMenuVehicules()
	    Menu.SetupMenu("miner_menu","Miner Garage")
	    Menu.Switch(nil,"miner_menu")
		Menu.addOption("miner_menu", function()
		    if(Menu.Option("Vehicle 1"))then
		        Miner_callSE('Miner:Car1')
		    end
		end)
		Menu.addOption("miner_menu", function()
		    if(Menu.Option("Vehicle 2"))then
		        Miner_callSE('Miner:Car2')
		    end
		end)
		Menu.addOption("miner_menu", function()
		    if(Menu.Option("Vehicle 3"))then
		        Miner_callSE('Miner:Car3')
		    end
		end)
	end

	RegisterNetEvent('Miner:drawBlips')
	AddEventHandler('Miner:drawBlips', function () 
		for key, item in pairs(Miner_blips) do
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, item.id)
			SetBlipAsShortRange(item.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(item.name)
			EndTextCommandSetBlipName(item.blip)
		end
		Miner_blipsTemp = Miner_blips
	end)

	RegisterNetEvent('Miner:deleteBlips')
	AddEventHandler('Miner:deleteBlips', function ()
		Miner_markerBool = false
		for _, item in pairs(Miner_blipsTemp) do
			RemoveBlip(item.blip)
		end
	end)

	RegisterNetEvent('Miner:drawMarker')
	AddEventHandler('Miner:drawMarker', function (boolean) 
		Miner_markerBool = boolean
		Citizen.CreateThread(function()
			while Miner_markerBool == true do
				Wait(0)
				if isInServiceMiner and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Miner_blips["Mine"].x,Miner_blips["Mine"].y,Miner_blips["Mine"].z, true) <= Miner_blips["Mine"].distanceBetweenCoords then
					TriggerServerEvent('Miner:serverRequest', "GetMinerai")
					Citizen.Wait(Miner_blips["Mine"].defaultTime)
				end	
				if isInServiceMiner and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Miner_blips["Foundry"].x,Miner_blips["Foundry"].y,Miner_blips["Foundry"].z, true) <= Miner_blips["Foundry"].distanceBetweenCoords then
					TriggerServerEvent('Miner:serverRequest', "GetMetal")
					Citizen.Wait(Miner_blips["Foundry"].defaultTime)
				end
				if isInServiceMiner and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Miner_blips["Point of Sale"].x,Miner_blips["Point of Sale"].y,Miner_blips["Point of Sale"].z, true) <= Miner_blips["Point of Sale"].distanceBetweenCoords then
					TriggerServerEvent('Miner:serverRequest', "SellMetal")
					Citizen.Wait(Miner_blips["Point of Sale"].defaultTime)
				end
			end
		end)
	end)

	RegisterNetEvent('Miner:marker')
	AddEventHandler('Miner:marker', function ()
		Citizen.CreateThread(function () 
			while Miner_markerBool == true do
				Citizen.Wait(1)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Miner_blips["Entreprise"].x, Miner_blips["Entreprise"].y, Miner_blips["Entreprise"].z, true) <= Miner_blips["Entreprise"].distanceMarker then
					DrawMarker(1, Miner_blips["Entreprise"].x, Miner_blips["Entreprise"].y, Miner_blips["Entreprise"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					ClearPrints()
					SetTextEntry_2("STRING")
					if isInServiceMiner then
						AddTextComponentString("Press ~g~E~s~ to go on ~b~break.")
					else
						AddTextComponentString("Press ~g~E~s~ to continue ~b~mining")
					end
					DrawSubtitleTimed(2000, 1)
					if IsControlJustPressed(1, 51) then
						GetServiceMiner()
					end
				end	
				if isInServiceMiner then
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Miner_blips["Garage"].x, Miner_blips["Garage"].y, Miner_blips["Garage"].z, true) <= Miner_blips["Garage"].distanceMarker+5 then
						DrawMarker(1, Miner_blips["Garage"].x, Miner_blips["Garage"].y, Miner_blips["Garage"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
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
								Miner_InitMenuVehicules()
								miner_menu = not miner_menu
							end
						end
					end	
				    if miner_menu then
				        job_menu = false
				        brewer_menu = false
				        farmer_menu = false
				        fishing_menu = false
				        lumberjack_menu = false
				        wine_menu = false
				        Menu.DisplayCurMenu()
				    end					
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Miner_blips["Mine"].x,Miner_blips["Mine"].y,Miner_blips["Mine"].z, true) <= Miner_blips["Mine"].distanceMarker then
						DrawMarker(1,Miner_blips["Mine"].x,Miner_blips["Mine"].y,Miner_blips["Mine"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Miner_blips["Foundry"].x,Miner_blips["Foundry"].y,Miner_blips["Foundry"].z, true) <= Miner_blips["Foundry"].distanceMarker then
						DrawMarker(1,Miner_blips["Foundry"].x,Miner_blips["Foundry"].y,Miner_blips["Foundry"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Miner_blips["Point of Sale"].x,Miner_blips["Point of Sale"].y,Miner_blips["Point of Sale"].z, true) <= Miner_blips["Point of Sale"].distanceMarker then
						DrawMarker(1,Miner_blips["Point of Sale"].x,Miner_blips["Point of Sale"].y,Miner_blips["Point of Sale"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
				end
			end
		end)
	end)

function GetServiceMiner()
	local playerPed = GetPlayerPed(-1)
	if isInServiceMiner then
		notif("Enjoy your break!")
		TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
	else
		notif("Get to work!")
		TriggerEvent("Miner:getSkin")
	end
	isInServiceMiner = not isInServiceMiner
	TriggerServerEvent('Miner:setService', isInServiceMiner)
end
	
	RegisterNetEvent('Miner:getSkin')
	AddEventHandler('Miner:getSkin', function (source)
	local hashSkin = GetHashKey("mp_m_freemode_01")
	Citizen.CreateThread(function()
		if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			SetPedComponentVariation(GetPlayerPed(-1), 11, 5, 0, 2)  -- Top
			SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 2)   -- under coat
			SetPedComponentVariation(GetPlayerPed(-1), 4, 0, 12, 2)   -- Pants
			SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2)   -- shoes
			SetPedComponentVariation(GetPlayerPed(-1), 3, 34, 0, 2)   -- under skin
		else
			SetPedComponentVariation(GetPlayerPed(-1), 11, 11, 2, 2)  -- Top
			SetPedComponentVariation(GetPlayerPed(-1), 8, 36, 0, 2)   -- under coat
			SetPedComponentVariation(GetPlayerPed(-1), 4, 35, 0, 2)   -- Pants
			SetPedComponentVariation(GetPlayerPed(-1), 6, 26, 0, 2)   -- shoes
			SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)   -- under skin
		end
	end)
	end)
	
RegisterNetEvent('Miner:getCar1')
AddEventHandler('Miner:getCar1', function (source)
	local vehiculeDetected = GetClosestVehicle(Miner_car.x, Miner_car.y, Miner_car.z, 6.0, 0, 70)
	if not DoesEntityExist(vehiculeDetected) then
		local myPed = GetPlayerPed(-1)
		local player = PlayerId()
		local vehicle = GetHashKey('tiptruck')
		RequestModel(vehicle)
		while not HasModelLoaded(vehicle) do
			Wait(1)
		end
		local plate = math.random(100, 900)
		existingVeh = CreateVehicle(vehicle,Miner_car.x, Miner_car.y, Miner_car.z,90.0, true, false)
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

RegisterNetEvent('Miner:getCar2')
AddEventHandler('Miner:getCar2', function (source)
	local vehiculeDetected = GetClosestVehicle(Miner_car.x, Miner_car.y, Miner_car.z, 6.0, 0, 70)
	if not DoesEntityExist(vehiculeDetected) then
		local myPed = GetPlayerPed(-1)
		local player = PlayerId()
		local vehicle = GetHashKey('tiptruck2')
		RequestModel(vehicle)
		while not HasModelLoaded(vehicle) do
			Wait(1)
		end
		local plate = math.random(100, 900)
		existingVeh = CreateVehicle(vehicle,Miner_car.x, Miner_car.y, Miner_car.z,90.0, true, false)
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

	RegisterNetEvent('Miner:getCar3')
	AddEventHandler('Miner:getCar3', function (source)
		local vehiculeDetected = GetClosestVehicle(Miner_car.x, Miner_car.y, Miner_car.z, 6.0, 0, 70)
	if not DoesEntityExist(vehiculeDetected) then
		local myPed = GetPlayerPed(-1)
		local player = PlayerId()
		local vehicle = GetHashKey('rubble')
		RequestModel(vehicle)
		while not HasModelLoaded(vehicle) do
			Wait(1)
		end
		local plate = math.random(100, 900)
		existingVeh = CreateVehicle(vehicle,Miner_car.x, Miner_car.y, Miner_car.z,90.0, true, false)
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

	RegisterNetEvent('Miner:drawGetMinerai')
	AddEventHandler('Miner:drawGetMinerai', function (qteMinerai)
		if(qteMinerai == nil) then
			qteMinerai = 0
		end

		TriggerEvent('inventory:addQty',1, 1)
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString("~g~Gathering ore...")
		DrawSubtitleTimed(4500, 1)
	end)

	RegisterNetEvent('Miner:drawGetMetal')
	AddEventHandler('Miner:drawGetMetal', function(qteMinerai, qteMetal)
		if(qteMinerai == nil) then
			qteMinerai = 0
		end
		
		if(qteMetal == nil) then
			qteMetal = 0
		end

		if qteMinerai > 0 then
			TriggerEvent('inventory:removeQty',1, 1)
			TriggerEvent('inventory:addQty',2, 1)
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~g~Unloading ore and loading on metal...")
			DrawSubtitleTimed(4500, 1)
		else
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~r~No more metal to load!")
			DrawSubtitleTimed(2000, 1)
		end
	end)

	RegisterNetEvent('Miner:drawSellMetal')
	AddEventHandler('Miner:drawSellMetal', function (qte)
		if(qte == nil) then
			qte = 0
		end

		if qte > 0 then
			TriggerEvent('inventory:removeQty',2, 1)
			local salaire = math.random(Miner_pay.minimum, Miner_pay.maximum)
			TriggerServerEvent('mission:completed', salaire)
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~g~Selling metal...")
			DrawSubtitleTimed(2000, 1)
		else
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~r~No more metal to sell!")
			DrawSubtitleTimed(2000, 1)
		end
	end)

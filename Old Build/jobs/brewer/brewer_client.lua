	local Brewer_blipsTemp
	local Brewer_markerBool = false
	local existingVeh = nil
	local isInServiceBrewer = false
	farmer_menu = false

	function Brewer_callSE(evt)
		brewer_menu = false
		TriggerServerEvent(evt)
	end

	function Brewer_InitMenuVehicules()
	    Menu.SetupMenu("brewer_menu","Brewer Garage")
	    Menu.Switch(nil,"brewer_menu")
		Menu.addOption("brewer_menu", function()
		    if(Menu.Option("Vehicle 1"))then
		        Brewer_callSE('Brewer:Car')
		    end
		end)
	end

	RegisterNetEvent('Brewer:drawBlips')
	AddEventHandler('Brewer:drawBlips', function () 
		for key, item in pairs(Brewer_blips) do
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, item.id)
			SetBlipAsShortRange(item.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(item.name)
			EndTextCommandSetBlipName(item.blip)
		end
		Brewer_blipsTemp = Brewer_blips
	end)
	
	RegisterNetEvent('Brewer:deleteBlips')
	AddEventHandler('Brewer:deleteBlips', function ()
		Brewer_markerBool = false
		for _, item in pairs(Brewer_blipsTemp) do
			RemoveBlip(item.blip)
		end
	end)

	RegisterNetEvent('Brewer:drawMarker')
	AddEventHandler('Brewer:drawMarker', function (boolean) 
		Brewer_markerBool = boolean
		Citizen.CreateThread(function()
			while Brewer_markerBool == true do
				Wait(0)
				if isInServiceBrewer and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Brewer_blips["Field"].x,Brewer_blips["Field"].y,Brewer_blips["Field"].z, true) <= Brewer_blips["Field"].distanceBetweenCoords then
					TriggerServerEvent('Brewer:serverRequest', "GetOrge")
					Citizen.Wait(Brewer_blips["Field"].defaultTime)
				end	
				if isInServiceBrewer and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Brewer_blips["Brewery"].x,Brewer_blips["Brewery"].y,Brewer_blips["Brewery"].z, true) <= Brewer_blips["Brewery"].distanceBetweenCoords then
					TriggerServerEvent('Brewer:serverRequest', "GetBiere")
					Citizen.Wait(Brewer_blips["Brewery"].defaultTime)
				end
			
				if isInServiceBrewer and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Brewer_blips["Point of Sale"].x,Brewer_blips["Point of Sale"].y,Brewer_blips["Point of Sale"].z, true) <= Brewer_blips["Point of Sale"].distanceBetweenCoords then
					TriggerServerEvent('Brewer:serverRequest', "SellBiere")
					Citizen.Wait(Brewer_blips["Point of Sale"].defaultTime)
				end
			end
		end)
	end)
	
	RegisterNetEvent('Brewer:marker')
	AddEventHandler('Brewer:marker', function ()
		Citizen.CreateThread(function () 
			while Brewer_markerBool == true do
				Citizen.Wait(1)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Brewer_blips["Entreprise"].x, Brewer_blips["Entreprise"].y, Brewer_blips["Entreprise"].z, true) <= Brewer_blips["Entreprise"].distanceMarker then
					DrawMarker(1, Brewer_blips["Entreprise"].x, Brewer_blips["Entreprise"].y, Brewer_blips["Entreprise"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					ClearPrints()
					SetTextEntry_2("STRING")
					if isInServiceBrewer then
						AddTextComponentString("Press ~g~E~s~ to go on ~b~break.")
					else
						AddTextComponentString("Press ~g~E~s~ to continue ~b~brewing")
					end
					DrawSubtitleTimed(2000, 1)
					if IsControlJustPressed(1, 51) then
						GetServiceBrewer()
					end
				end

				if isInServiceBrewer then
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Brewer_blips["Garage"].x, Brewer_blips["Garage"].y, Brewer_blips["Garage"].z, true) <= Brewer_blips["Garage"].distanceMarker+5 then
						DrawMarker(1, Brewer_blips["Garage"].x, Brewer_blips["Garage"].y, Brewer_blips["Garage"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
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
								Brewer_InitMenuVehicules()
								brewer_menu = not brewer_menu
							end
						end
					end
			        if brewer_menu then
			        	job_menu = false
			        	farmer_menu = false
			        	fishing_menu = false
			        	lumberjack_menu = false
			        	miner_menu = false
			        	wine_menu = false
			            Menu.DisplayCurMenu()
			        end
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Brewer_blips["Garage"].x,Brewer_blips["Garage"].y,Brewer_blips["Garage"].z, true) <= Brewer_blips["Garage"].distanceMarker then
						DrawMarker(1,Brewer_blips["Garage"].x,Brewer_blips["Garage"].y,Brewer_blips["Garage"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end

					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Brewer_blips["Field"].x,Brewer_blips["Field"].y,Brewer_blips["Field"].z, true) <= Brewer_blips["Field"].distanceMarker then
						DrawMarker(1,Brewer_blips["Field"].x,Brewer_blips["Field"].y,Brewer_blips["Field"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
		
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Brewer_blips["Brewery"].x,Brewer_blips["Brewery"].y,Brewer_blips["Brewery"].z, true) <= Brewer_blips["Brewery"].distanceMarker then
						DrawMarker(1,Brewer_blips["Brewery"].x,Brewer_blips["Brewery"].y,Brewer_blips["Brewery"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end

					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Brewer_blips["Point of Sale"].x,Brewer_blips["Point of Sale"].y,Brewer_blips["Point of Sale"].z, true) <= Brewer_blips["Point of Sale"].distanceMarker then
						DrawMarker(1,Brewer_blips["Point of Sale"].x,Brewer_blips["Point of Sale"].y,Brewer_blips["Point of Sale"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
				end
			end
		end)
	end)
	
function GetServiceBrewer()
	local playerPed = GetPlayerPed(-1)
	if isInServiceBrewer then
		notif("Enjoy your break!")
		TriggerServerEvent("clothes:spawn")
	else
		notif("Get to work!")
		TriggerEvent("Brewer:getSkin")
	end
	isInServiceBrewer = not isInServiceBrewer
	TriggerServerEvent('Brewer:setService', isInServiceBrewer)
end

RegisterNetEvent('Brewer:getSkin')
AddEventHandler('Brewer:getSkin', function (source)
	local hashSkin = GetHashKey("mp_m_freemode_01")
	Citizen.CreateThread(function()
	if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
		SetPedComponentVariation(GetPlayerPed(-1), 11, 41, 0, 2)  -- Top
		SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 2)   -- under coat
		SetPedComponentVariation(GetPlayerPed(-1), 4, 7, 0, 2)   -- Pants
		SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2)   -- shoes
		SetPedComponentVariation(GetPlayerPed(-1), 3, 66, 0, 2)   -- under skin
	else
		SetPedComponentVariation(GetPlayerPed(-1), 11, 76, 2, 2)  -- Top
		SetPedComponentVariation(GetPlayerPed(-1), 8, 14, 0, 2)   -- under coat
		SetPedComponentVariation(GetPlayerPed(-1), 4, 4, 8, 2)   -- Pants
		SetPedComponentVariation(GetPlayerPed(-1), 6, 4, 0, 2)   -- shoes
		SetPedComponentVariation(GetPlayerPed(-1), 3, 22, 0, 2)   -- under skin
	end
	end)
end)

RegisterNetEvent('Brewer:getCar')
AddEventHandler('Brewer:getCar', function (source)
	local vehiculeDetected = GetClosestVehicle(Brewer_car.x, Brewer_car.y, Brewer_car.z, 6.0, 0, 70)
	if not DoesEntityExist(vehiculeDetected) then
		local myPed = GetPlayerPed(-1)
		local player = PlayerId()
		local vehicle = GetHashKey('pounder')
		RequestModel(vehicle)
		while not HasModelLoaded(vehicle) do
			Wait(1)
		end
		local plate = math.random(100, 900)
		existingVeh = CreateVehicle(vehicle,Brewer_car.x, Brewer_car.y, Brewer_car.z,-50.0, true, false)
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

	RegisterNetEvent('Brewer:drawGetOrge')
	AddEventHandler('Brewer:drawGetOrge', function (qteBase)
		if(qteBase == nil) then
			qteBase = 0
		end

		TriggerEvent('inventory:addQty',Brewer_ressourceBase, 1)
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString("~g~You harvested barley")
		DrawSubtitleTimed(4500, 1)
	end)
	
	RegisterNetEvent('Brewer:drawGetBiere')
	AddEventHandler('Brewer:drawGetBiere', function(qteBase, qteTraite)
		if(qteBase == nil) then
			qteBase = 0
		end
		
		if(qteTraite == nil) then
			qteTraite = 0
		end

		if qteBase > 0 then
			TriggerEvent('inventory:removeQty',Brewer_ressourceBase, 1)
			TriggerEvent('inventory:addQty',Brewer_ressourceTraite, 1)
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~g~Brewing beer..")
			DrawSubtitleTimed(4500, 1)
		else
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~r~You have brewed all the beer possible!")
			DrawSubtitleTimed(2000, 1)
		end
	end)
	
	RegisterNetEvent('Brewer:drawSellBiere')
	AddEventHandler('Brewer:drawSellBiere', function (qte)
		if(qte == nil) then
			qte = 0
		end

		if qte > 0 then
			TriggerEvent('inventory:removeQty',Brewer_ressourceTraite, 1)
			local salaire = math.random(Brewer_pay.minimum, Brewer_pay.maximum)
			TriggerServerEvent('mission:completed', salaire)
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~g~You sold a beer!")
			DrawSubtitleTimed(2000, 1)
		else
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~r~You have no beer to sell!")
			DrawSubtitleTimed(2000, 1)
		end
	end)
	

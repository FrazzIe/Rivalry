	local Farmer_blipsTemp
	local Farmer_markerBool = false
	local existingVeh = nil
	local isInServiceFarmer = false

	function Farmer_callSE(evt)
		farmer_menu = false
		TriggerServerEvent(evt)
	end

	function Farmer_InitMenuVehicules()
	    Menu.SetupMenu("farmer_menu","Farmer Garage")
	    Menu.Switch(nil,"farmer_menu")
		Menu.addOption("farmer_menu", function()
		    if(Menu.Option("Vehicle 1"))then
		        Farmer_callSE('Farmer:Car')
		    end
		end)
	end

	RegisterNetEvent('Farmer:drawBlips')
	AddEventHandler('Farmer:drawBlips', function () 
		for key, item in pairs(Farmer_blips) do
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, item.id)
			SetBlipAsShortRange(item.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(item.name)
			EndTextCommandSetBlipName(item.blip)
		end
		Farmer_blipsTemp = Farmer_blips
	end)

	RegisterNetEvent('Farmer:deleteBlips')			
	AddEventHandler('Farmer:deleteBlips', function ()
		Farmer_markerBool = false
		for _, item in pairs(Farmer_blipsTemp) do
			RemoveBlip(item.blip)
		end
	end)

	RegisterNetEvent('Farmer:drawMarker')	
	AddEventHandler('Farmer:drawMarker', function (boolean)
		Farmer_markerBool = boolean
		Citizen.CreateThread(function()
			while Farmer_markerBool == true do
				Wait(0)
				if isInServiceFarmer and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Farmer_blips["Field"].x,Farmer_blips["Field"].y,Farmer_blips["Field"].z, true) <= Farmer_blips["Field"].distanceBetweenCoords then
					TriggerServerEvent('Farmer:serverRequest', "GetBle")
					Citizen.Wait(Farmer_blips["Field"].defaultTime)
				end	

				if isInServiceFarmer and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Farmer_blips["Mill"].x,Farmer_blips["Mill"].y,Farmer_blips["Mill"].z, true) <= Farmer_blips["Mill"].distanceBetweenCoords then
					TriggerServerEvent('Farmer:serverRequest', "GetFarine")
					Citizen.Wait(Farmer_blips["Mill"].defaultTime)
				end

				if isInServiceFarmer and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Farmer_blips["Point of Sale"].x,Farmer_blips["Point of Sale"].y,Farmer_blips["Point of Sale"].z, true) <= Farmer_blips["Point of Sale"].distanceBetweenCoords then
					TriggerServerEvent('Farmer:serverRequest', "SellFarine")
					Citizen.Wait(Farmer_blips["Point of Sale"].defaultTime)
				end
			end
		end)
	end)

	RegisterNetEvent('Farmer:marker')
	AddEventHandler('Farmer:marker', function ()
		Citizen.CreateThread(function () 
			while Farmer_markerBool == true do
				Citizen.Wait(1)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Farmer_blips["Entreprise"].x, Farmer_blips["Entreprise"].y, Farmer_blips["Entreprise"].z, true) <= Farmer_blips["Entreprise"].distanceMarker then
					DrawMarker(1, Farmer_blips["Entreprise"].x, Farmer_blips["Entreprise"].y, Farmer_blips["Entreprise"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					ClearPrints()
					SetTextEntry_2("STRING")
					if isInServiceFarmer then
						AddTextComponentString("Press ~g~E~s~ to go on ~b~break.")
					else
						AddTextComponentString("Press ~g~E~s~ to continue ~b~farming")
					end
					DrawSubtitleTimed(2000, 1)
					if IsControlJustPressed(1, 51) then
						GetServiceFarmer()
					end
				end
				if isInServiceFarmer then
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Farmer_blips["Garage"].x, Farmer_blips["Garage"].y, Farmer_blips["Garage"].z, true) <= Farmer_blips["Garage"].distanceMarker+5 then
						DrawMarker(1, Farmer_blips["Garage"].x, Farmer_blips["Garage"].y, Farmer_blips["Garage"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
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
								Farmer_InitMenuVehicules()
								farmer_menu = not farmer_menu
							end
						end
					end
			        if farmer_menu then
			        	job_menu = false
			        	brewer_menu = false
			        	fishing_menu = false
			        	lumberjack_menu = false
			        	miner_menu = false
			        	wine_menu = false
			            Menu.DisplayCurMenu()
			        end
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Farmer_blips["Field"].x,Farmer_blips["Field"].y,Farmer_blips["Field"].z, true) <= Farmer_blips["Field"].distanceMarker then
						DrawMarker(1, Farmer_blips["Field"].x, Farmer_blips["Field"].y, Farmer_blips["Field"].z, 0, 0, 0, 0, 0, 0, 20.001, 20.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Farmer_blips["Mill"].x,Farmer_blips["Mill"].y,Farmer_blips["Mill"].z, true) <= Farmer_blips["Mill"].distanceMarker then
						DrawMarker(1,Farmer_blips["Mill"].x,Farmer_blips["Mill"].y,Farmer_blips["Mill"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Farmer_blips["Point of Sale"].x,Farmer_blips["Point of Sale"].y,Farmer_blips["Point of Sale"].z, true) <= Farmer_blips["Point of Sale"].distanceMarker then
						DrawMarker(1,Farmer_blips["Point of Sale"].x,Farmer_blips["Point of Sale"].y,Farmer_blips["Point of Sale"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
					end
				end
			end
		end)
	end)

function GetServiceFarmer()
	local playerPed = GetPlayerPed(-1)
	if isInServiceFarmer then
		notif("Enjoy your break!")
		TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
	else
		notif("Get to work!")
		TriggerEvent("Farmer:getSkin")
	end
	isInServiceFarmer = not isInServiceFarmer
	TriggerServerEvent('Farmer:setService', isInServiceFarmer)
end

	RegisterNetEvent('Farmer:getSkin')	
	AddEventHandler('Farmer:getSkin', function (source)
		local hashSkin = GetHashKey("mp_m_freemode_01")
		Citizen.CreateThread(function()
		if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			SetPedComponentVariation(GetPlayerPed(-1), 11, 97, 0, 2)  -- Top
			SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)   -- under coat
			SetPedComponentVariation(GetPlayerPed(-1), 4, 62, 1, 2)   -- Pants
			SetPedComponentVariation(GetPlayerPed(-1), 6, 12, 6, 2)   -- shoes
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)   -- under skin
		else	
			SetPedComponentVariation(GetPlayerPed(-1), 11, 37, 4, 2)  -- Top
			SetPedComponentVariation(GetPlayerPed(-1), 8, 6, 0, 2)   -- under coat
			SetPedComponentVariation(GetPlayerPed(-1), 4, 62, 0, 2)   -- Pants
			SetPedComponentVariation(GetPlayerPed(-1), 6, 38, 1, 2)   -- shoes
			SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)   -- under skin
		end
		end)
		--TriggerServerEvent("mm:otherspawn")
		--RemoveAllPedWeapons(GetPlayerPed(-1), true)
	end)

	RegisterNetEvent('Farmer:getCar')	
	AddEventHandler('Farmer:getCar', function (source)
		local vehiculeDetected = GetClosestVehicle(Farmer_car.x, Farmer_car.y, Farmer_car.z, 6.0, 0, 70)
		if not DoesEntityExist(vehiculeDetected) then
			local myPed = GetPlayerPed(-1)
			local player = PlayerId()
			local vehicle = GetHashKey('benson')
			RequestModel(vehicle)
			while not HasModelLoaded(vehicle) do
				Wait(1)
			end
			local plate = math.random(100, 900)
			existingVeh = CreateVehicle(vehicle,Farmer_car.x, Farmer_car.y, Farmer_car.z,120.0, true, false)
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

	RegisterNetEvent('Farmer:drawGetBle')
	AddEventHandler('Farmer:drawGetBle', function (qteBle)
		if(qteBle == nil) then
			qteBle = 0
		end

		TriggerEvent('inventory:addQty',10, 1)
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString("~g~You harvested wheat")
		DrawSubtitleTimed(4500, 1)
	end)

	RegisterNetEvent('Farmer:drawGetFarine')
	AddEventHandler('Farmer:drawGetFarine', function(qteBle, qteFarine)
		if (qteBle == nil) then
			qteBle = 0
		end
		if (qteFarine == nil) then
			qteFarine = 0
		end
		if qteBle > 0 then
			TriggerEvent('inventory:removeQty',10, 1)
			TriggerEvent('inventory:addQty',5, 1)
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~g~Turning wheat into flour!")
			DrawSubtitleTimed(4500, 1)
		else
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~r~You have made all the flour possible!")
			DrawSubtitleTimed(2000, 1)
		end
	end)

	RegisterNetEvent('Farmer:drawSellFarine')
	AddEventHandler('Farmer:drawSellFarine', function (qte)
		if(qte == nil) then
			qte = 0
		end
		Citizen.Trace(tonumber(qte))
		if qte > 0 then
			TriggerEvent('inventory:removeQty',5, 1)
			local salaire = math.random(Farmer_pay.minimum, Farmer_pay.maximum)
			TriggerServerEvent('mission:completed', salaire)
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~g~Selling goods...")
			DrawSubtitleTimed(2000, 1)
		else
			ClearPrints()
			SetTextEntry_2("STRING")
			AddTextComponentString("~r~No more goods to sell..")
			DrawSubtitleTimed(2000, 1)
		end
	end)
	
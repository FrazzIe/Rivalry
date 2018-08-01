local bucheron_blipsTemp
local bucheron_markerBool = false
local existingVeh = nil
local isInServiceBucheron = false
lumberjack_menu = false

function bucheron_callSE(evt)
	lumberjack_menu = false
	TriggerServerEvent(evt)
end

function bucheron_InitMenuVehicules()
	Menu.SetupMenu("lumberjack_menu","Lumber Garage")
	Menu.Switch(nil,"lumberjack_menu")
	Menu.addOption("lumberjack_menu", function()
		if(Menu.Option("Vehicle 1"))then
			bucheron_callSE('bucheron:Car')
		end
	end)
end

RegisterNetEvent('bucheron:drawBlips')
AddEventHandler('bucheron:drawBlips', function () 
	for key, item in pairs(bucheron_blips) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(key)
		EndTextCommandSetBlipName(item.blip)
	end
	bucheron_blipsTemp = bucheron_blips
end)

RegisterNetEvent('bucheron:deleteBlips')
AddEventHandler('bucheron:deleteBlips', function ()
	bucheron_markerBool = false
	for _, item in pairs(bucheron_blipsTemp) do
		RemoveBlip(item.blip)
	end
end)

RegisterNetEvent('bucheron:drawMarker')
AddEventHandler('bucheron:drawMarker', function (boolean) 
	bucheron_markerBool = boolean
	Citizen.CreateThread(function()
		while bucheron_markerBool == true do
			Wait(0)
			if isInServiceBucheron and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bucheron_blips["Cut Trees"].x,bucheron_blips["Cut Trees"].y,bucheron_blips["Cut Trees"].z, true) <= bucheron_blips["Cut Trees"].distanceBetweenCoords then
				TriggerServerEvent('bucheron:serverRequest', "GetBois")
				Citizen.Wait(bucheron_blips["Cut Trees"].defaultTime)
			end	
			if isInServiceBucheron and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bucheron_blips["Sawmill"].x,bucheron_blips["Sawmill"].y,bucheron_blips["Sawmill"].z, true) <= bucheron_blips["Sawmill"].distanceBetweenCoords then
				TriggerServerEvent('bucheron:serverRequest', "GetPlanche")
				Citizen.Wait(bucheron_blips["Sawmill"].defaultTime)
			end
		
			if isInServiceBucheron and  GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bucheron_blips["Point of Sale"].x,bucheron_blips["Point of Sale"].y,bucheron_blips["Point of Sale"].z, true) <= bucheron_blips["Point of Sale"].distanceBetweenCoords then
				TriggerServerEvent('bucheron:serverRequest', "SellPlanche")
				Citizen.Wait(bucheron_blips["Point of Sale"].defaultTime)
			end
		end
	end)
end)
	
RegisterNetEvent('bucheron:marker')
AddEventHandler('bucheron:marker', function ()
	Citizen.CreateThread(function () 
		while bucheron_markerBool == true do
			Citizen.Wait(1)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bucheron_blips["Entreprise"].x, bucheron_blips["Entreprise"].y, bucheron_blips["Entreprise"].z, true) <= bucheron_blips["Entreprise"].distanceMarker then
				DrawMarker(1, bucheron_blips["Entreprise"].x, bucheron_blips["Entreprise"].y, bucheron_blips["Entreprise"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
				ClearPrints()
				SetTextEntry_2("STRING")
				if isInServiceBrasseur then
					AddTextComponentString("Press ~g~E~s~ to go on ~b~break.")
				else
					AddTextComponentString("Press ~g~E~s~ to continue ~b~chopping trees")
				end
				DrawSubtitleTimed(2000, 1)
				if IsControlJustPressed(1, 51) then
					GetServiceBucheron()
				end
			end

			if isInServiceBucheron then
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bucheron_blips["Garage"].x, bucheron_blips["Garage"].y, bucheron_blips["Garage"].z, true) <= bucheron_blips["Garage"].distanceMarker+5 then
						DrawMarker(1, bucheron_blips["Garage"].x, bucheron_blips["Garage"].y, bucheron_blips["Garage"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
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
								bucheron_InitMenuVehicules()
								lumberjack_menu = not lumberjack_menu
							end
						end
					end
			    if lumberjack_menu then
			        job_menu = false
			        brewer_menu = false
			        farmer_menu = false
			        fishing_menu = false
			        miner_menu = false
			        wine_menu = false
			        Menu.DisplayCurMenu()
			    end					
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bucheron_blips["Cut Trees"].x,bucheron_blips["Cut Trees"].y,bucheron_blips["Cut Trees"].z, true) <= bucheron_blips["Cut Trees"].distanceMarker then
					DrawMarker(1,bucheron_blips["Cut Trees"].x,bucheron_blips["Cut Trees"].y,bucheron_blips["Cut Trees"].z, 0, 0, 0, 0, 0, 0, 10.001, 10.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
				end
	
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bucheron_blips["Sawmill"].x,bucheron_blips["Sawmill"].y,bucheron_blips["Sawmill"].z, true) <= bucheron_blips["Sawmill"].distanceMarker then
					DrawMarker(1,bucheron_blips["Sawmill"].x,bucheron_blips["Sawmill"].y,bucheron_blips["Sawmill"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
				end

				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bucheron_blips["Point of Sale"].x,bucheron_blips["Point of Sale"].y,bucheron_blips["Point of Sale"].z, true) <= bucheron_blips["Point of Sale"].distanceMarker then
					DrawMarker(1,bucheron_blips["Point of Sale"].x,bucheron_blips["Point of Sale"].y,bucheron_blips["Point of Sale"].z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
				end
			end
		end
	end)
end)

function notif(message)
	Citizen.CreateThread(function()
		Wait(10)
		SetNotificationTextEntry("STRING")
		AddTextComponentString(message)
		DrawNotification(false, false)
	end)
end

function GetServiceBucheron()
	local playerPed = GetPlayerPed(-1)
	if isInServiceBucheron then
		notif("Enjoy your break!")
		TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
	else
		notif("Get to work!")
		TriggerEvent("bucheron:getSkin")
	end
	isInServiceBucheron = not isInServiceBucheron
	TriggerServerEvent('bucheron:setService', isInServiceBucheron)
end
	
	RegisterNetEvent('bucheron:getSkin')
	AddEventHandler('bucheron:getSkin', function (source)
		local hashSkin = GetHashKey("mp_m_freemode_01")
		Citizen.CreateThread(function()
		if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			SetPedComponentVariation(GetPlayerPed(-1), 11, 41, 0, 2)  -- Top
			SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 2)   -- under coat
			SetPedComponentVariation(GetPlayerPed(-1), 4, 7, 0, 2)   -- Pants
			SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2)   -- shoes
			SetPedComponentVariation(GetPlayerPed(-1), 3, 66, 0, 2)   -- under skin
		else
			SetPedComponentVariation(GetPlayerPed(-1), 11, 109, 0, 2)  -- Top
			SetPedComponentVariation(GetPlayerPed(-1), 8, 1, 0, 2)   -- under coat
			SetPedComponentVariation(GetPlayerPed(-1), 4, 45, 2, 2)   -- Pants
			SetPedComponentVariation(GetPlayerPed(-1), 6, 36, 0, 2)   -- shoes
			SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)   -- under skin
		end
		end)
	end)
	
RegisterNetEvent('bucheron:getCar')
AddEventHandler('bucheron:getCar', function (source)
	local vehiculeDetected = GetClosestVehicle(bucheron_car.x, bucheron_car.y, bucheron_car.z, 6.0, 0, 70)
	if not DoesEntityExist(vehiculeDetected) then
		local myPed = GetPlayerPed(-1)
		local player = PlayerId()
		local vehicle = GetHashKey('hauler')
		RequestModel(vehicle)
		while not HasModelLoaded(vehicle) do
			Wait(1)
		end
		local plate = math.random(100, 900)
		existingVeh = CreateVehicle(vehicle,bucheron_car.x, bucheron_car.y, bucheron_car.z,0.0, true, false)
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


RegisterNetEvent('bucheron:drawGetBois')
AddEventHandler('bucheron:drawGetBois', function (qteBois)
	if(qteBois == nil) then
		qteBois = 0
	end

	TriggerEvent('inventory:addQty',19, 1)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString("~g~Collecting wood...")
	DrawSubtitleTimed(4500, 1)
end)

RegisterNetEvent('bucheron:drawGetPlanche')
AddEventHandler('bucheron:drawGetPlanche', function(qteBois, qtePlanche)
	if(qteBois == nil) then
		qteBois = 0
	end
	
	if(qtePlanche == nil) then
		qtePlanche = 0
	end

	if qteBois > 0 then
		TriggerEvent('inventory:removeQty',19, 1)
		TriggerEvent('inventory:addQty',20, 1)
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString("~g~Unloading wood and loading planks...")
		DrawSubtitleTimed(4500, 1)
	else
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString("~r~No more planks to load...")
		DrawSubtitleTimed(2000, 1)
	end
end)

RegisterNetEvent('bucheron:drawSellPlanche')
AddEventHandler('bucheron:drawSellPlanche', function (qte)
	if(qte == nil) then
		qte = 0
	end

	if qte > 0 then
		TriggerEvent('inventory:removeQty',20, 1)
		local salaire = math.random(bucheron_pay.minimum, bucheron_pay.maximum)
		TriggerServerEvent('mission:completed', salaire)
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString("~g~Exporting planks...")
		DrawSubtitleTimed(2000, 1)
	else
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString("~r~You have no planks to export!")
		DrawSubtitleTimed(2000, 1)
	end
end)


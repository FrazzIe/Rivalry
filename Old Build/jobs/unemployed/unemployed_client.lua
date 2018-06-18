	local Unemployed_markerBool = false
	local existingVeh = nil

	RegisterNetEvent('Unemployed:drawBlips')
	AddEventHandler('Unemployed:drawBlips', function () 

	end)

	RegisterNetEvent('Unemployed:deleteBlips')
	AddEventHandler('Unemployed:deleteBlips', function ()
		Unemployed_markerBool = false
	end)
	
	RegisterNetEvent('Unemployed:drawMarker')
	AddEventHandler('Unemployed:drawMarker', function (boolean) 
		Unemployed_markerBool = boolean
	end)

	RegisterNetEvent('Unemployed:marker')
	AddEventHandler('Unemployed:marker', function ()
	TriggerServerEvent("clothes:spawn")
		
	end)

	RegisterNetEvent('Unemployed:getSkin')
	AddEventHandler('Unemployed:getSkin', function (source)
		-- local playerPed = GetPlayerPed(-1)
			
		-- SetPedComponentVariation(playerPed, 11, 5, 0, 2)  -- Top
		-- SetPedComponentVariation(playerPed, 8, 59, 0, 2)   -- under coat
		-- SetPedComponentVariation(playerPed, 4, 0, 12, 2)   -- Pants
		-- SetPedComponentVariation(playerPed, 6, 25, 0, 2)   -- shoes
		-- SetPedComponentVariation(playerPed, 3, 34, 0, 2)   -- under skin
		TriggerServerEvent("clothes:spawn")
		--RemoveAllPedWeapons(GetPlayerPed(-1), true)
		existingVeh = nil
	end)
	

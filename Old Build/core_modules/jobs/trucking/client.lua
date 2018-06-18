local isTrucker = true
local isTruckerInService = false
local trucker_rent = 500
local trucker_truck = nil
local trucker_trailer = nil
local trucker_job = nil
local trucker_trailer_blip, trucker_blip = nil, nil
local trucker_marker = {x = 1196.5891113281, y = -3253.5249023438, z = 7.0951862335205, h = 88.152191162109}
local trucker_vehicle = {x = 1201.2165527344, y = -3239.5495605469, z = 6.0287671089172, h = 0.35804972052574}
local trucker_destination = {x = 1148.7821044922, y = -3271.9758300781, z = 5.9008107185364, h = 172.70553588867}
local trucker_trailers = { --trailers models that are good: trailers, trailers2, trailers3, trailers4, armytanker, armytrailer2, tr4, tanker, tanker2, trailerlogs, tvtrailer, tr3
    [1] = {
        model = "trailers", --Type of trailer
        marker = {x = 161.37777709961, y = 6624.5771484375, z = 31.84666633606, h = 137.6727142334}, -- Marker that spawns the trailer
        trailer = {x = 145.77363586426, y = 6627.9658203125, z = 31.692535400391, h = 229.3152923584}, -- Spawn location of trailer
    },
    [2] = {
        model = "trailers2", --Type of trailer
        marker = {x = 45.273567199707, y = 6302.728515625, z = 31.224903106689, h = 23.050148010254}, -- Marker that spawns the trailer
        trailer = {x = 66.931526184082, y = 6303.0048828125, z = 31.262371063232, h = 117.21352386475}, -- Spawn location of trailer
    },
    [3] = {
        model = "trailers4", --Type of trailer
        marker = {x = -193.54783630371, y = -2649.7568359375, z = 6.0010299682617, h = 87.278770446777}, -- Marker that spawns the trailer
        trailer = {x = -201.67970275879, y = -2663.3920898438, z = 6.0002965927124, h = 359.96130371094}, -- Spawn location of trailer
    },
    [4] = {
        model = "armytrailer2", --Type of trailer
        marker = {x = 1007.5075073242, y = -1855.4534912109, z = 31.039817810059, h = 174.54495239258}, -- Marker that spawns the trailer
        trailer = {x = 1019.7686767578, y = -1861.7971191406, z = 30.889837265015, h = 84.36474609375}, -- Spawn location of trailer
    },
    [5] = {
        model = "tr4", --Type of trailer
        marker = {x = -219.24816894531, y = -1163.6983642578, z = 23.020027160645, h = 110.17881011963}, -- Marker that spawns the trailer
        trailer = {x = -237.30056762695, y = -1176.5506591797, z = 22.957164764404, h = 270.33145141602}, -- Spawn location of trailer
    },
}

RegisterNetEvent("trucker:set")
AddEventHandler("trucker:set", function(_isTrucker)
	isTruckerInService = false
	isTrucker = _isTrucker
end)

RegisterNetEvent("trucker:rent")
AddEventHandler("trucker:rent", function()
	Citizen.CreateThread(function()
		local model = "phantom"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		trucker_truck = CreateVehicle(model, trucker_vehicle.x, trucker_vehicle.y, trucker_vehicle.z, trucker_vehicle.h, true, false)
		local plate = "TT"..GetVehicleNumberPlateText(trucker_truck)
		SetVehicleNumberPlateText(trucker_truck, plate)
		SetEntityInvincible(trucker_truck, false)
		SetPedIntoVehicle(PlayerPedId(), trucker_truck, -1)
		SetModelAsNoLongerNeeded(model)
		DecorSetBool(trucker_truck, "hotwire", true)
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isTrucker then
			local pos = GetEntityCoords(PlayerPedId(), false)
			if Vdist(pos.x, pos.y, pos.z, trucker_marker.x, trucker_marker.y, trucker_marker.z) < 20 then
				drawMarker(25, trucker_marker.x, trucker_marker.y, trucker_marker.z, 1.0, 1.0, 1.5, 0, 255, 0, 255)
				if Vdist(pos.x, pos.y, pos.z, trucker_marker.x, trucker_marker.y, trucker_marker.z) < 1 then
					if isTruckerInService then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~r~off duty")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~g~on duty")
					end
					if IsControlJustPressed(1, 51) then
						isTruckerInService = not isTruckerInService
					end
				end
			end
			if isTruckerInService then
				if Vdist(pos.x, pos.y, pos.z, trucker_vehicle.x, trucker_vehicle.y, trucker_vehicle.z) < 20 then
					drawMarker(25, trucker_vehicle.x, trucker_vehicle.y, trucker_vehicle.z, 3.0, 3.0, 3.5, 0, 255, 0, 255)
					if Vdist(pos.x, pos.y, pos.z, trucker_vehicle.x, trucker_vehicle.y, trucker_vehicle.z) < 3 then
						if trucker_truck and trucker_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to return a truck\nPress ~INPUT_INTERACTION_MENU~ to cancel job")
						elseif trucker_truck and not trucker_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to return a truck\nPress ~INPUT_INTERACTION_MENU~ to accept job")
						elseif not trucker_truck and trucker_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a truck [$"..trucker_rent.."]\nPress ~INPUT_INTERACTION_MENU~ to cancel job")
						elseif not trucker_truck and not trucker_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a truck [$"..trucker_rent.."]\nPress ~INPUT_INTERACTION_MENU~ to accept job")
						end
						if IsControlJustPressed(1, 51) then
							if trucker_truck then
								SetEntityAsMissionEntity(trucker_truck, true, true)
								DeleteVehicle(trucker_truck)
								trucker_truck = nil
							else
								TriggerServerEvent("trucker:rent")
							end
						end
						if IsControlJustPressed(1, 244) then
							if trucker_job then
								trucker_job = nil
							else
								trucker_job = GetRandomIntInRange(1, #trucker_trailers+1)
							end
						end
					end
				end

				if trucker_truck and trucker_job then
					if not trucker_trailer then
						if not DoesBlipExist(trucker_trailer_blip) then
							trucker_trailer_blip = AddBlipForCoord(trucker_trailers[trucker_job].marker.x, trucker_trailers[trucker_job].marker.y, trucker_trailers[trucker_job].marker.z)
							SetBlipSprite(trucker_trailer_blip, 1)
							SetBlipColour(trucker_trailer_blip, 60)
							SetBlipAsShortRange(trucker_trailer_blip, true)
							SetBlipScale(trucker_trailer_blip, 0.85)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString("Trailer Collection")
							EndTextCommandSetBlipName(trucker_trailer_blip)
							SetBlipRoute(trucker_trailer_blip, true)
						end
						if Vdist(pos.x, pos.y, pos.z, trucker_trailers[trucker_job].marker.x, trucker_trailers[trucker_job].marker.y, trucker_trailers[trucker_job].marker.z) < 20 then
							drawMarker(25, trucker_trailers[trucker_job].marker.x, trucker_trailers[trucker_job].marker.y, trucker_trailers[trucker_job].marker.z, 1.0, 1.0, 1.5, 0, 255, 0, 255)
							if Vdist(pos.x, pos.y, pos.z, trucker_trailers[trucker_job].marker.x, trucker_trailers[trucker_job].marker.y, trucker_trailers[trucker_job].marker.z) < 1 then
								if not IsPedSittingInAnyVehicle(PlayerPedId()) then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to get a trailer!")
									if IsControlJustPressed(1, 51) then
										Citizen.CreateThread(function()
											local model = trucker_trailers[trucker_job].model
											RequestModel(model)
											while not HasModelLoaded(model) do
												Citizen.Wait(0)
											end
											trucker_trailer = CreateVehicle(model, trucker_trailers[trucker_job].trailer.x, trucker_trailers[trucker_job].trailer.y, trucker_trailers[trucker_job].trailer.z, trucker_trailers[trucker_job].trailer.h, true, false)
											local plate = "TR"..GetVehicleNumberPlateText(trucker_truck)
											SetVehicleNumberPlateText(trucker_truck, plate)
											SetEntityInvincible(trucker_truck, false)
											SetModelAsNoLongerNeeded(model)
										end)											
									end
								end
							end
						end						
					else
						local isAttached, Trailer = GetVehicleTrailerVehicle(trucker_truck, trucker_trailer)
						if isAttached and Trailer == trucker_trailer then
							if IsEntityDead(trucker_trailer) then
								trucker_trailer = nil
								Notify("The trailer was destroyed, go get a new one!", 3000)
							end
							if IsEntityDead(trucker_truck) then
								trucker_truck = nil
								Notify("The truck was destroyed, go get a new one!", 3000)
							end
							if DoesBlipExist(trucker_trailer_blip) then
								RemoveBlip(trucker_trailer_blip)
								SetBlipRoute(trucker_trailer_blip, false)
								trucker_trailer_blip = nil
							end
							if not DoesBlipExist(trucker_blip) then
								trucker_blip = AddBlipForCoord(trucker_destination.x, trucker_destination.y, trucker_destination.z)
								SetBlipSprite(trucker_blip, 1)
								SetBlipColour(trucker_blip, 60)
								SetBlipAsShortRange(trucker_blip, true)
								SetBlipScale(trucker_blip, 0.85)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("Delivery Destination")
								EndTextCommandSetBlipName(trucker_blip)
								SetBlipRoute(trucker_blip, true)
							end
							if Vdist(pos.x, pos.y, pos.z, trucker_destination.x, trucker_destination.y, trucker_destination.z) < 20 then
								drawMarker(25, trucker_destination.x, trucker_destination.y, trucker_destination.z, 6.0, 6.0, 6.5, 0, 255, 0, 255)
								if Vdist(pos.x, pos.y, pos.z, trucker_destination.x, trucker_destination.y, trucker_destination.z) < 6 then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to complete the delivery!")
									if IsControlJustPressed(1, 51) then
										TriggerServerEvent("trucker:complete", trucker_job)
										SetEntityAsMissionEntity(trucker_trailer, true, true)
										DeleteVehicle(trucker_trailer)
										trucker_trailer = nil
										trucker_job = nil
									end
								end
							end
						else
							if IsEntityDead(trucker_trailer) then
								trucker_trailer = nil
								Notify("The trailer was destroyed, go get a new one!", 3000)
							end
							if IsEntityDead(trucker_truck) then
								trucker_truck = nil
								Notify("The truck was destroyed, go get a new one!", 3000)
							end
							if trucker_blip then
								RemoveBlip(trucker_blip)
								SetBlipRoute(trucker_blip, false)
								trucker_blip = nil
							end
						end
					end
				else
					if trucker_blip then
						RemoveBlip(trucker_blip)
						SetBlipRoute(trucker_blip, false)
						trucker_blip = nil
					end
					if trucker_trailer_blip then
						RemoveBlip(trucker_trailer_blip)
						SetBlipRoute(trucker_trailer_blip, false)
						trucker_trailer_blip = nil
					end
				end			
			end
		end
	end
end)
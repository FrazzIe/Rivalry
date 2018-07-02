local isBus = true
local isBusInService = false
local bus_rent = 200
local bus = nil
local bus_job = nil
local bus_route = 1
local i = 0
local BusTimer = 0
local locations = {
	bus = {x = 467.40051269531, y = -614.87091064453, z = 28.499477386475, h = 171.64529418945},
	trailer = {
		marker = {x = 1176.8137207031, y = -3205.3762207031, z = 6.028039932251, h = 322.41110229492},
		spawn = {x = 1189.1647949219, y = -3200.1545410156, z = 6.0280385017395, h = 89.505523681641},
	},
	service = {x = 468.0881652832, y = -594.76745605469, z = 28.499509811401, h = 167.41741943359},
}

bus_destinations = {
    [1] = {
        [1] = {name = "LSIA Terminal 2", x = -1048.877930, y = -2540.111572, z = 12.505210},
        [2] = {name = "Maze Bank Arena", 		x = -307.695801, y = -1844.940430, z = 23.845625},
        [3] = {name = "Strawberry Avenue", 	x = -43.776791, y = -1648.477661, z = 28.033178},
        [4] = {name = "Carson Avenue", 		x = 50.928295, y = -1536.593506, z = 28.018265},
        [5] = {name = "Adam's Apple Blv", 	x = 98.416206, y = -1055.010620, z = 28.118307},
        [6] = {name = "San Andreas Avenue", 	x = 115.008423, y = -784.036377, z = 30.126572},
        [7] = {name = "San Vitus Blvd", 		x = -256.629272, y = -330.119690, z = 28.699272},
        [8] = {name = "Boulevard Del Perro", 	x = -490.618530, y = 20.407391, z = 43.791027},
        [9] = {name = "Strangeways Drive", 	x = -693.450562, y = -5.167409, z = 37.019169},
        [10] = {name = "Mad Wayne Thunder Dr", x = -931.669128, y = -126.633087, z = 36.415554},
        [11] = {name = "Marathon Avenue", 		x = -1047.878540, y = -389.459473, z = 36.419994},
        [12] = {name = "Rockford Hills", 		x = -679.639771, y = -376.881226, z = 33.043865},
        [13] = {name = "Ginger Street", 		x = -652.388367, y = -607.065369, z = 32.059444},
        [14] = {name = "Vespucci Blvd", 		x = -558.416321, y = -846.186951, z = 26.312037},
        [15] = {name = "La Puerta Fwy", 		x = -250.537796, y = -883.167053, z = 29.415934},
        [16] = {name = "Innocence Blvd", 		x = -302.779999, y = -1476.822632, z = 29.369450},
    },
    [2] = {
        [1] = {name = "Textile City", x = 307.135803, y = -766.019043, z = 28.227528},
        [2] = {name = "Strawberry Metro Station", x = 261.568085, y = -1217.424927, z = 28.424841},
        [3] = {name = "Davis Sherrif's Office", x = 364.583069, y = -1568.484009, z = 28.203512},
        [4] = {name = "Billingsgate Motel", x = 574.867859, y = -1734.191040, z = 28.182583},
        [5] = {name = "Little Bighorn Ave", x = 774.118408, y = -1752.040039, z = 28.409100},
        [6] = {name = "Popular Street", x = 879.431213, y = -1766.265015, z = 28.894323},
        [7] = {name = "Amarillo Vista", x = 1303.761475, y = -1648.289551, z = 50.393467},
        [8] = {name = "El Burro Heights Gas Station", x = 1191.970215, y = -1421.047852, z = 34.044270},
        [9] = {name = "Olympic Fwy", x = 806.741638, y = -1353.140259, z = 25.286720},
        [10] = {name = "Popular Street", x = 785.882019, y = -775.321411, z = 25.329002},
        [11] = {name = "Occupation Avenue", x = 428.806915, y = -359.720764, z = 46.116802},
        [12] = {name = "Power Street", x = 160.195572, y = -372.077209, z = 41.672024},
        [13] = {name = "Union Depository", x = 41.333294, y = -706.174377, z = 43.126556},
        [14] = {name = "Downtown Parking Garage", x = -335.592316, y = -683.291138, z = 31.849171},
        [15] = {name = "Alta Street", x = -86.832825, y = -652.732300, z = 35.105892},
        [16] = {name = "Low Power Street", x = 70.441124, y = -627.019653, z = 30.579842},
        [17] = {name = "Vespucci Blvd", x = 62.284081, y = -996.830688, z = 28.256859},
    },
    [3] = {   
        [1] = {name = "Vespucci Beach", x = -1456.489258, y = -967.370056, z = 6.261691},
        [2] = {name = "Vespucci Beach", x = -1352.111206, y = -1113.946533, z = 3.407488},
        [3] = {name = "Vespucci Beach", x = -1321.315552, y = -1292.585571, z = 3.940287},
        [4] = {name = "Vespucci Beach", x = -1286.420532, y = -1396.484009, z = 3.523031},
        [5] = {name = "Aguja Street", x = -1167.743652, y = -1472.403931, z = 3.280961},
        [6] = {name = "Melanoma Street", x = -1087.516235, y = -1586.963745, z = 3.321031},
        [7] = {name = "La Puerta Apartments", x = -944.724731, y = -1527.015015, z = 4.056648},
       	[8] = {name = "La Puerta Apartments", x = -993.357361, y = -1441.655884, z = 4.072592},
        [9] = {name = "Vista Del Mar Apartments", x = -1037.417603, y = -1532.505371, z = 4.053168},
        [10] = {name = "The Wiseroy", x = -830.088196, y = -1218.166382, z = 5.931358},
        [11] = {name = "La Puerta Marina", x = -800.468201, y = -1332.293945, z = 3.997653},
        [12] = {name = "Higgins Helitours", x = -716.186951, y = -1405.214233, z = 3.997248},
        [13] = {name = "Little Seoul Gas Station", x = -524.743774, y = -1198.608643, z = 17.541819},
        [14] = {name = "Little Seoul Tram Station", x = -521.956665, y = -1302.051392, z = 27.012049},
        [15] = {name = "La Puerta Gas Station", x = -322.942200, y = -1443.668823, z = 29.714195},
        [16] = {name = "Carson Avenue", x = -21.008894, y = -1378.070068, z = 28.275986},
        [17] = {name = "Olympic Fwy Underpass", x = 77.380333, y = -1214.512207, z = 28.123667},
        [18] = {name = "Adam's Apple Blvd", x = 95.186195, y = -1061.527832, z = 28.265455},
        [19] = {name = "San Andreas Avenue", x = 115.118439, y = -783.993042, z = 30.291632},
        [20] = {name = "Little Seoul Parking Complex", x = -466.381317, y = -649.065796, z = 31.306229},
        [21] = {name = "Ginger Street", x = -770.386658, y = -647.734436, z = 28.840813},
        [22] = {name = "Weazel Plaza", x = -931.685364, y = -465.941254, z = 36.085449},
        [23] = {name = "Lifeinvader HQ", x = -1077.113647, y = -264.329651, z = 36.719830},
        [24] = {name = "Morningwood Blvd", x = -1280.407349, y = -321.272278, z = 35.672688},
        [25] = {name = "North Rockford Drive", x = -1417.084595, y = -399.028290, z = 35.194302},
        [26] = {name = "Prosperity Street", x = -1525.448242, y = -465.898956, z = 34.293213},
        [27] = {name = "Bay City Avenue", x = -1538.372559, y = -683.898926, z = 27.764669},
        [28] = {name = "Del Perro Pier", x = -1629.170898, y = -999.052368, z = 12.034500},
    },
    [4] = {
        [1] = {name = "Pillbox Hill Medical Center", x = 290.073639, y = -588.705994, z = 42.999905},
        [2] = {name = "Alta", x = 393.089783, y = -198.228836, z = 59.249481},
        [3] = {name = "Vinewood Plaza", x = 546.343018, y = 154.992188, z = 98.938354},
        [4] = {name = "Vinewood Hills Arena", x = 707.297607, y = 661.271912, z = 128.741226},
        [5] = {name = "North Conker Avenue", x = 340.571075, y = 473.769196, z = 149.536407},
        [6] = {name = "Sisyphus Theater", x = 233.522186, y = 1175.608643, z = 225.289536},
        [7] = {name = "Lake Vinewood", x = -75.519508, y = 893.577209, z = 235.406143},
        [8] = {name = "North Sheldon Avenue", x = -718.873962, y = 960.467590, z = 237.414627},
        [9] = {name = "Normandy Drive", x = -918.196106, y = 793.625732, z = 183.889343},
        [10] = {name = "Hillcrest Avenue", x = -917.567871, y = 697.311035, z = 151.466461},
        [11] = {name = "Hillcrest Avenue", x = -686.764465, y = 604.516663, z = 143.481186},
        [12] = {name = "Normandy Drive", x = -629.844666, y = 685.028870, z = 150.348328},
        [13] = {name = "Didion Drive", x = -510.327759, y = 569.082642, z = 118.609016},
        [14] = {name = "Hillcrest Ridge Access Road", x = -696.260254, y = 489.169250, z = 109.245049},
        [15] = {name = "Dunstable Lane", x = -837.081909, y = 292.296692, z = 86.154709},
        [16] = {name = "The Generic", x = -481.763062, y = 224.086395, z = 82.916214},
        [17] = {name = "Eclipse Lodge", x = -256.527252, y = 12.497521, z = 52.772953},
        [18] = {name = "Cancer Way", x = -296.263885, y = -271.570099, z = 31.390156},
        [19] = {name = "Daily Globe International", x = -286.271729, y = -616.369568, z = 33.201347},
        [20] = {name = "Power Street", x = 119.872200, y = -812.574402, z = 30.998062},
    }
}

RegisterNetEvent("bus:set")
AddEventHandler("bus:set", function(_isBus)
	isBusInService = false
	isBus = _isBus
end)

RegisterNetEvent("bus:rent")
AddEventHandler("bus:rent", function()
	Citizen.CreateThread(function()
		local model = "bus"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		bus = CreateVehicle(model, locations.bus.x, locations.bus.y, locations.bus.z, locations.bus.h, true, false)
		local plate = "BUS"..GetVehicleNumberPlateText(bus)
		SetVehicleNumberPlateText(bus, plate)
		SetEntityInvincible(bus, false)
		SetPedIntoVehicle(PlayerPedId(), bus, -1)
		SetModelAsNoLongerNeeded(model)
		DecorSetBool(bus, "hotwire", true)
	end)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if BusTimer > 0 then
			BusTimer = BusTimer - 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if BusTimer > 0 then
			Notify("You have "..BusTimer.." seconds left")
		end
	end
end)

Citizen.CreateThread(function()
	CreateBlip("Department of Transportation", 513, 66, locations.service.x, locations.service.y, locations.service.z)
	while true do
		Citizen.Wait(0)
		if isBus then
			local pos = GetEntityCoords(PlayerPedId(), false)
			if Vdist(pos.x, pos.y, pos.z, locations.service.x, locations.service.y, locations.service.z) < 20 then
				drawMarker(25, locations.service.x, locations.service.y, locations.service.z, 1.0, 1.0, 1.5, 0, 255, 0, 255)
				if Vdist(pos.x, pos.y, pos.z, locations.service.x, locations.service.y, locations.service.z) < 1 then
					if isBusInService then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~r~off duty")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~g~on duty")
					end
					if IsControlJustPressed(1, 51) then
						isBusInService = not isBusInService
					end
				end
			end
			if isBusInService then
				if Vdist(pos.x, pos.y, pos.z, locations.bus.x, locations.bus.y, locations.bus.z) < 20 then
					drawMarker(25, locations.bus.x, locations.bus.y, locations.bus.z, 3.0, 3.0, 3.5, 0, 255, 0, 255)
					if Vdist(pos.x, pos.y, pos.z, locations.bus.x, locations.bus.y, locations.bus.z) < 3 then
						if bus and bus_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to return a bus\nPress ~INPUT_DETONATE~ to cancel job")
						elseif bus and not bus_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to return a bus\nPress ~INPUT_DETONATE~ to accept job")
						elseif not bus and bus_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a bus [$"..bus_rent.."]\nPress ~INPUT_DETONATE~ to cancel job")
						elseif not bus and not bus_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a bus [$"..bus_rent.."]\nPress ~INPUT_DETONATE~ to accept job")
						end
						if IsControlJustPressed(1, 51) then
							if bus then
								SetEntityAsMissionEntity(bus, true, true)
								DeleteVehicle(bus)
								bus = nil
							else
								TriggerServerEvent("bus:rent")
							end
						end
						if IsControlJustPressed(1, 47) then
							if bus_job then
								bus_job = nil
							else
								bus_job = GetRandomIntInRange(1, 4)
								BusTimer = 180
								Notify("You have "..BusTimer.." seconds left")
							end
						end
					end
				end

				if bus and bus_job then
					if not bus then
						if not DoesBlipExist(bus_blip) then
							bus_blip = AddBlipForCoord(bus_destinations[bus_job][bus_route].x, bus_destinations[bus_job][bus_route].y, bus_destinations[bus_job][bus_route].z)
							SetBlipSprite(bus_blip, 1)
							SetBlipColour(bus_blip, 60)
							SetBlipAsShortRange(bus_blip, true)
							SetBlipScale(bus_blip, 0.85)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(bus_destinations[bus_job][bus_route].name)
							EndTextCommandSetBlipName(bus_blip)
							SetBlipRoute(bus_blip, true)
						end						
					else
							if IsEntityDead(bus) and bus ~= nil then
								bus = nil
								Notify("The bus was destroyed, go get a new one!", 3000)
							end
							if not DoesBlipExist(bus_blip) then
								bus_blip = AddBlipForCoord(bus_destinations[bus_job][bus_route].x, bus_destinations[bus_job][bus_route].y, bus_destinations[bus_job][bus_route].z)
								SetBlipSprite(bus_blip, 1)
								SetBlipColour(bus_blip, 60)
								SetBlipAsShortRange(bus_blip, true)
								SetBlipScale(bus_blip, 0.85)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(bus_destinations[bus_job][bus_route].name)
								EndTextCommandSetBlipName(bus_blip)
								SetBlipRoute(bus_blip, true)
							end
							if Vdist(pos.x, pos.y, pos.z, bus_destinations[bus_job][bus_route].x, bus_destinations[bus_job][bus_route].y, bus_destinations[bus_job][bus_route].z) < 20 then
								RenderMarker(25, bus_destinations[bus_job][bus_route].x, bus_destinations[bus_job][bus_route].y, bus_destinations[bus_job][bus_route].z, 6.0, 6.0, 6.5, 0, 255, 0, 255)
								if Vdist(pos.x, pos.y, pos.z, bus_destinations[bus_job][bus_route].x, bus_destinations[bus_job][bus_route].y, bus_destinations[bus_job][bus_route].z) < 6 then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to complete your stop!")
									if IsControlJustPressed(1, 51) then
										local vehiclestopped = IsVehicleStopped(bus)
										if BusTimer > 0 then
											if vehiclestopped then
												TriggerServerEvent("bus:complete")
												if(i < #bus_destinations[bus_job])then
													RemoveBlip(bus_blip)
													bus_route = bus_route + 1
													bus_blip  = AddBlipForCoord(bus_destinations[bus_job][bus_route].x, bus_destinations[bus_job][bus_route].y, bus_destinations[bus_job][bus_route].z)
													SetBlipSprite(bus_blip, 1)
													SetBlipColour(bus_blip, 60)
													SetBlipAsShortRange(bus_blip, true)
													SetBlipScale(bus_blip, 0.85)
													BeginTextCommandSetBlipName("STRING")
													AddTextComponentString(bus_destinations[bus_job][bus_route].name)
													EndTextCommandSetBlipName(bus_blip)
													SetBlipRoute(bus_blip, true)
													i = i + 1
													BusTimer = 180
												else
													RemoveBlip(bus_blip)
													Notify("You have finished your route! Return to the Bus Depot for another task.")
													BusTimer = 0
												end
											else
												Notify("You need to be stopped!")
											end 
										else
											Notify("You ran out of time!")
											RemoveBlip(bus_blip)
											bus_job = nil
											bus_route = nil
										end
									end
								end
							end
							if IsEntityDead(bus) then
								bus = nil
								Notify("The bus was destroyed, go get a new one!", 3000)
							end
--[[							if bus_blip then
								RemoveBlip(bus_blip)
								SetBlipRoute(bus_blip, false)
								bus_blip = nil
							end--]]
					end
				else
					if bus_blip then
						RemoveBlip(bus_blip)
						SetBlipRoute(bus_blip, false)
						bus_blip = nil
					end
				end
			end
		end
	end
end)
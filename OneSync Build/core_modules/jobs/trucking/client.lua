local isTrucker = true
local isTruckerInService = false
local trucker_rent = 250
local trucker_truck = nil
local trucker_trailer = nil
local trucker_job = nil
local trucker_trailer_blip, trucker_blip = nil, nil
local locations = {
	truck = vector3(1201.2165527344,-3239.5495605469,6.0287671089172),--0.35804972052574 = Heading
	trailer = {
		marker = vector3(1176.8137207031,-3205.3762207031,6.028039932251),--322.41110229492} = Heading
		spawn = vector3(1189.1647949219,-3200.1545410156,6.0280385017395),--89.505523681641
	},
	service = vector3(1196.5891113281,-3253.5249023438,7.0951862335205),--88.152191162109
}
local trucker_destinations = { --trailers models that are good: trailers, trailers2, trailers3, trailers4, armytanker, armytrailer2, tr4, tanker, tanker2, trailerlogs, tvtrailer, tr3
	{
		Destination = vector3(147.07858276367,-1462.3930664063,29.141599655151),
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = vector3(188.80735778809,-1459.5190429688,29.141622543335),
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = vector3(-167.63006591797,-1436.1223144531,31.247339248657),
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = vector3(-665.08831787109,-892.82263183594,24.54599571228),
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = vector3(-558.14373779297,302.66333007813,83.220695495605),
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = vector3(96.789001464844,279.65631103516,109.9340133667),
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = vector3(184.93792724609,-218.31448364258,53.872371673584),
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = vector3(1192.1411132813,-402.35092163086,67.829292297363),
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = vector3(1965.705078125,3757.5270996094,32.237976074219),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(1377.5512695313,3604.0078125,34.891986846924),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(560.25280761719,2678.92578125,42.121398925781),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {vector3(2565.7619628906,391.96539306641,108.46299743652),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(-1820.6522216797,806.35900878906,138.72241210938),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(142.09608459473,-1275.0654296875,29.159107208252),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(-1222.4432373047,-891.92633056641,12.403017997742),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(-724.36608886719,-914.63366699219,19.013904571533),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(-24.754581451416,-1354.4033203125,29.153381347656),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(1689.0723876953,4917.2397460938,42.078136444092),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(-3249.8337402344,989.64501953125,12.489533424377),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(-3046.2875976563,598.83386230469,7.4617681503296),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(1165.7854003906,2694.73046875,37.83960723877),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(1718.9201660156,6421.3178710938,33.401309967041),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(1133.7065429688,-974.13665771484,46.581489562988),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(-58.529609680176,-1744.5052490234,29.356561660767),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(-1506.6971435547,-383.31210327148,40.818824768066),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(367.07543945313,335.7829284668,103.38278961182),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(2662.6447753906,3259.5646972656,55.240520477295),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(-2963.1079101563,400.93740844727,15.069319725037),
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = vector3(431.04672241211,6467.4189453125,28.768754959106),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-1989.7738037109,550.68121337891,110.16765594482),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-892.94616699219,412.08633422852,85.836479187012),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-929.79681396484,172.83804321289,66.307960510254),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-391.85604858398,394.93658447266,108.59880828857),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(127.32681274414,-408.95657348633,41.06042098999),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(17.330871582031,-394.55059814453,39.509296417236),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-98.259201049805,-1018.9482421875,27.273578643799),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-136.20190429688,-1105.001953125,21.685255050659),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-488.15496826172,-969.48937988281,23.550556182861),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-1095.2667236328,-1638.1287841797,4.3984236717224),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(1296.4202880859,-1731.4213867188,53.717426300049),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(1054.4891357422,-405.73962402344,66.869537353516),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(993.88232421875,-484.10470581055,61.8293800354),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(945.80987548828,-571.58447265625,58.184722900391),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(1605.6531982422,3611.6931152344,35.146289825439),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(1534.7393798828,3604.0590820313,35.255783081055),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(1901.6546630859,4918.181640625,48.710025787354),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(1945.2406005859,4638.0200195313,40.555744171143),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(1353.7619628906,4371.1323242188,44.310749053955),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(717.90283203125,4179.1181640625,40.709190368652),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-3172.0493164063,1300.1324462891,14.727311134338),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-3053.8308105469,441.86306762695,6.3617038726807),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(-510.33810424805,5240.7973632813,80.304084777832),
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = vector3(631.4739,282.8075,103.2208),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(1153.5305175781,-331.64242553711,68.8681640625),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(826.01831054688,-1049.0705566406,27.753950119019),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(1200.3819580078,-1383.86328125,35.226955413818),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(1224.4202880859,-1516.6595458984,34.692562103271),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-60.702255249023,-2526.8957519531,6.0121812820435),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-59.351810455322,-1745.6217041016,29.354942321777),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(179.89334106445,-1547.9525146484,29.15767288208),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-335.82962036133,-1493.3955078125,30.630931854248),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(293.97183227539,-1246.3718261719,29.290744781494),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-518.37274169922,-1221.1595458984,18.291185379028),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-723.04473876953,-920.60083007813,19.013999938965),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-1432.5651855469,-249.32447814941,46.353832244873),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-2068.1018066406,-304.18740844727,13.149713516235),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-1817.2364501953,806.62017822266,138.62257385254),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-2536.9858398438,2325.6931152344,33.059902191162),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(41.683433532715,2801.2265625,57.878124237061),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(1026.3043212891,2656.4147949219,39.551139831543),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(1206.716796875,2639.0991210938,37.809928894043),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(2535.3991699219,2583.4584960938,37.944828033447),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(1784.3669433594,3318.9340820313,41.468753814697),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(1991.1534423828,3775.333984375,32.180812835693),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(2566.48046875,400.3596496582,108.46235656738),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(2536.0888671875,2581.564453125,37.944869995117),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(1687.9085693359,4916.494140625,42.078140258789),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(1716.0020751953,6418.0874023438,33.209869384766),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(197.29220581055,6616.333984375,31.755296707153),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-95.194450378418,6394.876953125,31.452095031738),
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = vector3(-15.986042976379,-1085.6513671875,26.672069549561),
		Tier = 5,
		Trailer = "tr4"
	},
	{
		Destination = vector3(-821.55657958984,-2353.6005859375,14.570617675781),
		Tier = 5,
		Trailer = "tr4"
	},
	{
		Destination = vector3(1212.0620117188,2722.9533691406,38.004173278809),
		Tier = 5,
		Trailer = "tr4"
	},
}}

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
		trucker_truck = CreateVehicle(model, locations.truck.x, locations.truck.y, locations.truck.z, 140, true, false)
		local plate = "TT"..GetVehicleNumberPlateText(trucker_truck)
		SetVehicleNumberPlateText(trucker_truck, plate)
		SetEntityInvincible(trucker_truck, false)
		SetPedIntoVehicle(Ped, trucker_truck, -1)
		SetModelAsNoLongerNeeded(model)
		DecorSetBool(trucker_truck, "hotwire", true)
	end)
end)

local randomizer = nil
local missionRandomizer = nil

function checkTier(missionTier)
	local possibleTierMissions = {}
	for Index = 1, #trucker_destinations do
		if trucker_destinations[Index].Tier == missionTier then
			table.insert(possibleTierMissions, Index)
		end
	end
	if #possibleTierMissions ~= 0 then
		local Randomizer = math.random(1, #possibleTierMissions)
	else
		local Randomizer = 1
	end
	local Index = possibleTierMissions[Randomizer]
	trucker_job = Index
	Notify("Tier "..missionTier.." has been selected!", 2500)
end

function TruckingInitMenu()
	Menu.SetupMenu("trucking_menu","Trucking Menu")
    Menu.Switch(nil,"trucking_menu")
	Menu.addOption("trucking_menu", function()
	    if(Menu.Option("General Store"))then
	        checkTier(1)
	    end
	    if(Menu.Option("Food Delivery"))then
	        checkTier(2)
	    end
	    if(Menu.Option("Wood Delivery"))then
	        checkTier(3)
	    end
	    if(Menu.Option("Gas Delivery"))then
	        checkTier(4)
	    end
	    if(Menu.Option("Car Delivery"))then
	        checkTier(5)
	    end
	end)		
end

Citizen.CreateThread(function()
	CreateBlip("Jetsam Trucking", 477, 21, locations.service.x, locations.service.y, locations.service.z)
	while true do
		Citizen.Wait(0)
		if isTrucker then
			local Ped = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Ped, false)
			if #(PlayerPosition - locations.service) < 20 then
				RenderMarker(25, locations.service.x, locations.service.y, locations.service.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if #(PlayerPosition - locations.service) < 1 then
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
				if #(PlayerPosition - locations.truck) < 20 then
					RenderMarker(25, locations.truck.x, locations.truck.y, locations.truck.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(PlayerPosition - locations.truck) < 3 then
						if trucker_truck and trucker_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to return a truck\nPress ~INPUT_DETONATE~ to cancel job")
						elseif trucker_truck and not trucker_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to return a truck\nPress ~INPUT_DETONATE~ to accept job")
						elseif not trucker_truck and trucker_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a truck [$"..trucker_rent.."]\nPress ~INPUT_DETONATE~ to cancel job")
						elseif not trucker_truck and not trucker_job then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a truck [$"..trucker_rent.."]\nPress ~INPUT_DETONATE~ to accept job")
						end
						if IsControlJustPressed(1, 51) then
							if trucker_truck then
								SetEntityAsMissionEntity(trucker_truck, true, true)
								DeleteVehicle(trucker_truck)
								trucker_truck = nil
							else
								if tobool(drivers_license) then
									TriggerServerEvent("trucker:rent")
								else
									Notify("You do not have a valid drivers license!", 2500)
								end
							end
						end
						if IsControlJustPressed(1, 47) then
							if trucker_job then
								trucker_job = nil
								trucker_trailer = nil
							else
								TruckingInitMenu()
								trucking_menu = not trucking_menu
							end
						end
					end
				end
				if trucker_truck and trucker_job then
					if not trucker_trailer then
						if not DoesBlipExist(trucker_trailer_blip) then
							trucker_trailer_blip = AddBlipForCoord(locations.trailer.marker.x, locations.trailer.marker.y, locations.trailer.marker.z)
							SetBlipSprite(trucker_trailer_blip, 1)
							SetBlipColour(trucker_trailer_blip, 60)
							SetBlipAsShortRange(trucker_trailer_blip, true)
							SetBlipScale(trucker_trailer_blip, 0.85)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString("Trailer Collection")
							EndTextCommandSetBlipName(trucker_trailer_blip)
							SetBlipRoute(trucker_trailer_blip, true)
						end
						if #(PlayerPosition - locations.trailer.marker) < 20 then
							RenderMarker(25, locations.trailer.marker.x, locations.trailer.marker.y, locations.trailer.marker.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
							if #(PlayerPosition - locations.trailer.marker) < 1 then
								if not IsPedSittingInAnyVehicle(Ped) then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to get a trailer!")
									if IsControlJustPressed(1, 51) then
										Citizen.CreateThread(function()
											local model = possibleTierMissions[trucker_job].Trailer
											RequestModel(model)
											while not HasModelLoaded(model) do
												Citizen.Wait(0)
											end
											trucker_trailer = CreateVehicle(model, locations.trailer.spawn.x, locations.trailer.spawn.y, locations.trailer.spawn.z, 100.0123542, true, false)
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
							if IsEntityDead(trucker_trailer) and trucker_trailer ~= nil then
								trucker_trailer = nil
								Notify("The trailer was destroyed, go get a new one!", 3000)
							end
							if IsEntityDead(trucker_truck) and trucker_truck ~= nil then
								trucker_truck = nil
								Notify("The truck was destroyed, go get a new one!", 3000)
							end
							if DoesBlipExist(trucker_trailer_blip) then
								RemoveBlip(trucker_trailer_blip)
								SetBlipRoute(trucker_trailer_blip, false)
								trucker_trailer_blip = nil
							end
							if not DoesBlipExist(trucker_blip) then
								trucker_blip = AddBlipForCoord(possibleTierMissions[trucker_job].Destination.x, possibleTierMissions[trucker_job].Destination.y, possibleTierMissions[trucker_job].Destination.z)
								SetBlipSprite(trucker_blip, 1)
								SetBlipColour(trucker_blip, 60)
								SetBlipAsShortRange(trucker_blip, true)
								SetBlipScale(trucker_blip, 0.85)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("Delivery Destination")
								EndTextCommandSetBlipName(trucker_blip)
								SetBlipRoute(trucker_blip, true)
							end
							if #(PlayerPosition - possibleTierMissions[trucker_job].Destination) < 20 then
								RenderMarker(25, possibleTierMissions[trucker_job].Destination.x, possibleTierMissions[trucker_job].Destination.y, possibleTierMissions[trucker_job].Destination.z, 6.0, 6.0, 6.5, 0, 255, 0, 255)
								if #(PlayerPosition - possibleTierMissions[trucker_job].Destination) < 6 then
									if #(GetEntityCoords(trucker_trailer, false) - possibleTierMissions[trucker_job].Destination) < 10 then
										DisplayHelpText("Press ~INPUT_CONTEXT~ to complete the delivery!")
										if IsControlJustPressed(1, 51) then
											local distance = #(PlayerPosition - locations.truck)
											TriggerServerEvent("trucker:complete", possibleTierMissions[trucker_job].Tier, distance)
											DestroyVehicle(trucker_trailer)
											trucker_trailer = nil
											trucker_job = nil
											possibleTierMissions = {}
										end
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

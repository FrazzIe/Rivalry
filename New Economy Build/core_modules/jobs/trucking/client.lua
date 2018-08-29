local isTrucker = true
local isTruckerInService = false
local trucker_rent = 500
local trucker_truck = nil
local trucker_trailer = nil
local trucker_job = nil
local trucker_trailer_blip, trucker_blip = nil, nil
local locations = {
	truck = {x = 1201.2165527344, y = -3239.5495605469, z = 6.0287671089172, h = 0.35804972052574},
	trailer = {
		marker = {x = 1176.8137207031, y = -3205.3762207031, z = 6.028039932251, h = 322.41110229492},
		spawn = {x = 1189.1647949219, y = -3200.1545410156, z = 6.0280385017395, h = 89.505523681641},
	},
	service = {x = 1196.5891113281, y = -3253.5249023438, z = 7.0951862335205, h = 88.152191162109},
}
local trucker_destinations = { --trailers models that are good: trailers, trailers2, trailers3, trailers4, armytanker, armytrailer2, tr4, tanker, tanker2, trailerlogs, tvtrailer, tr3
	{ -- Restraunts
		Destination = {x = 147.07858276367, y = -1462.3930664063, z = 29.141599655151},
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = {x = 188.80735778809, y = -1459.5190429688, z = 29.141622543335},
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = {x = -167.63006591797, y = -1436.1223144531, z = 31.247339248657},
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = {x = -665.08831787109, y = -892.82263183594, z = 24.54599571228},
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = {x = -558.14373779297, y = 302.66333007813, z = 83.220695495605},
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = {x = 96.789001464844, y = 279.65631103516, z = 109.9340133667},
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = {x = 184.93792724609, y = -218.31448364258, z = 53.872371673584},
		Tier = 1,
		Trailer = "trailers2"
	},
	{
		Destination = {x = 1192.1411132813, y = -402.35092163086, z = 67.829292297363},
		Tier = 1,
		Trailer = "trailers2"
	},
	{ -- 24/7"s
		Destination = {x = 1965.705078125, y = 3757.5270996094, z = 32.237976074219},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 1377.5512695313, y = 3604.0078125, z = 34.891986846924},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 560.25280761719, y = 2678.92578125, z = 42.121398925781},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 2565.7619628906, y = 391.96539306641, z = 108.46299743652},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = -1820.6522216797, y = 806.35900878906, z = 138.72241210938},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 142.09608459473, y = -1275.0654296875, z = 29.159107208252},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = -1222.4432373047, y = -891.92633056641, z = 12.403017997742},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = -724.36608886719, y = -914.63366699219, z = 19.013904571533},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 15.56547164917, y = -1341.5375976563, z = 29.285680770874},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 1689.0723876953, y = 4917.2397460938, z = 42.078136444092},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = -3249.8337402344, y = 989.64501953125, z = 12.489533424377},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = -3046.2875976563, y = 598.83386230469, z = 7.4617681503296},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 1165.7854003906, y = 2694.73046875, z = 37.83960723877},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 1718.9201660156, y = 6421.3178710938, z = 33.401309967041},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 1133.7065429688, y = -974.13665771484, z = 46.581489562988},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = -58.529609680176, y = -1744.5052490234, z = 29.356561660767},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = -1506.6971435547, y = -383.31210327148, z = 40.818824768066},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 367.07543945313, y = 335.7829284668, z = 103.38278961182},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = 2662.6447753906, y = 3259.5646972656, z = 55.240520477295},
		Tier = 2,
		Trailer = "trailers3"
	},
	{
		Destination = {x = -2963.1079101563, y = 400.93740844727, z = 15.069319725037},
		Tier = 2,
		Trailer = "trailers3"
	},
	{ -- Wood Deliverys
		Destination = {x = 431.04672241211, y = 6467.4189453125, z = 28.768754959106},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -1989.7738037109, y = 550.68121337891, z = 110.16765594482},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -892.94616699219, y = 412.08633422852, z = 85.836479187012},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -929.79681396484, y = 172.83804321289, z = 66.307960510254},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -391.85604858398, y = 394.93658447266, z = 108.59880828857},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 127.32681274414, y = -408.95657348633, z = 41.06042098999},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 17.330871582031, y = -394.55059814453, z = 39.509296417236},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -98.259201049805, y = -1018.9482421875, z = 27.273578643799},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -136.20190429688, y = -1105.001953125, z = 21.685255050659},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -488.15496826172, y = -969.48937988281, z = 23.550556182861},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -1095.2667236328, y = -1638.1287841797, z = 4.3984236717224},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 1296.4202880859, y = -1731.4213867188, z = 53.717426300049},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 1054.4891357422, y = -405.73962402344, z = 66.869537353516},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 993.88232421875, y = -484.10470581055, z = 61.8293800354},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 945.80987548828, y = -571.58447265625, z = 58.184722900391},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 1605.6531982422, y = 3611.6931152344, z = 35.146289825439},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 1534.7393798828, y = 3604.0590820313, z = 35.255783081055},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 1901.6546630859, y = 4918.181640625, z = 48.710025787354},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 1945.2406005859, y = 4638.0200195313, z = 40.555744171143},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 1353.7619628906, y = 4371.1323242188, z = 44.310749053955},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = 717.90283203125, y = 4179.1181640625, z = 40.709190368652},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -3172.0493164063, y = 1300.1324462891, z = 14.727311134338},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -3053.8308105469, y = 441.86306762695, z = 6.3617038726807},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{
		Destination = {x = -510.33810424805, y = 5240.7973632813, z = 80.304084777832},
		Tier = 3,
		Trailer = "trailerlogs"
	},
	{ -- Gas Stations
		Destination = {x = 631.4739, y = 282.8075, z = 103.2208},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 1153.5305175781, y = -331.64242553711, z = 68.8681640625},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 826.01831054688, y = -1049.0705566406, z = 27.753950119019},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 1200.3819580078, y = -1383.86328125, z = 35.226955413818},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 1224.4202880859, y = -1516.6595458984, z = 34.692562103271},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = -60.702255249023, y = -2526.8957519531, z = 6.0121812820435},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = -59.351810455322, y = -1745.6217041016, z = 29.354942321777},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 179.89334106445, y = -1547.9525146484, z = 29.15767288208},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = -335.82962036133, y = -1493.3955078125, z = 30.630931854248},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 293.97183227539, y = -1246.3718261719, z = 29.290744781494},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = -518.37274169922, y = -1221.1595458984, z = 18.291185379028},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = -723.04473876953, y = -920.60083007813, z = 19.013999938965},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = -1432.5651855469, y = -249.32447814941, z = 46.353832244873},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = -2068.1018066406, y = -304.18740844727, z = 13.149713516235},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = -1817.2364501953, y = 806.62017822266, z = 138.62257385254},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = -2536.9858398438, y = 2325.6931152344, z = 33.059902191162},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 41.683433532715, y = 2801.2265625, z = 57.878124237061},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 1026.3043212891, y = 2656.4147949219, z = 39.551139831543},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 1206.716796875, y = 2639.0991210938, z = 37.809928894043},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 2535.3991699219, y = 2583.4584960938, z = 37.944828033447},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 1784.3669433594, y = 3318.9340820313, z = 41.468753814697},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 1991.1534423828, y = 3775.333984375, z = 32.180812835693},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 2566.48046875, y = 400.3596496582, z = 108.46235656738},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 2536.0888671875, y = 2581.564453125, z = 37.944869995117},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 1687.9085693359, y = 4916.494140625, z = 42.078140258789},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 1716.0020751953, y = 6418.0874023438, z = 33.209869384766},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = 197.29220581055, y = 6616.333984375, z = 31.755296707153},
		Tier = 4,
		Trailer = "tanker"
	},
	{
		Destination = {x = -95.194450378418, y = 6394.876953125, z = 31.452095031738},
		Tier = 4,
		Trailer = "tanker"
	},
	{ -- Car Deliverys
		Destination = {x = -15.986042976379, y = -1085.6513671875, z = 26.672069549561},
		Tier = 5,
		Trailer = "tr4"
	},
	{
		Destination = {x = -895.73071289063, y = -2334.0769042969, z = 6.7090282440186},
		Tier = 5,
		Trailer = "tr4"
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
		trucker_truck = CreateVehicle(model, locations.truck.x, locations.truck.y, locations.truck.z, locations.truck.h, true, false)
		local plate = "TT"..GetVehicleNumberPlateText(trucker_truck)
		SetVehicleNumberPlateText(trucker_truck, plate)
		SetEntityInvincible(trucker_truck, false)
		SetPedIntoVehicle(PlayerPedId(), trucker_truck, -1)
		SetModelAsNoLongerNeeded(model)
		DecorSetBool(trucker_truck, "hotwire", true)
	end)
end)

local possibleTierMissions = {}
local randomizer = nil
local missionRandomizer = nil

function checkTier(missionTier)
	possibleTierMissions = {}
	for k, v in ipairs(trucker_destinations) do
		if v.Tier == missionTier then
			table.insert(possibleTierMissions, v)
		end
	end
	randomizer = math.random(1, #possibleTierMissions)
	trucker_job = randomizer

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
			local pos = GetEntityCoords(PlayerPedId(), false)
			if Vdist(pos.x, pos.y, pos.z, locations.service.x, locations.service.y, locations.service.z) < 20 then
				drawMarker(25, locations.service.x, locations.service.y, locations.service.z, 1.0, 1.0, 1.5, 0, 255, 0, 255)
				if Vdist(pos.x, pos.y, pos.z, locations.service.x, locations.service.y, locations.service.z) < 1 then
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
				if Vdist(pos.x, pos.y, pos.z, locations.truck.x, locations.truck.y, locations.truck.z) < 20 then
					drawMarker(25, locations.truck.x, locations.truck.y, locations.truck.z, 3.0, 3.0, 3.5, 0, 255, 0, 255)
					if Vdist(pos.x, pos.y, pos.z, locations.truck.x, locations.truck.y, locations.truck.z) < 3 then
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
								TriggerServerEvent("trucker:rent")
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
						if Vdist(pos.x, pos.y, pos.z, locations.trailer.marker.x, locations.trailer.marker.y, locations.trailer.marker.z) < 20 then
							drawMarker(25, locations.trailer.marker.x, locations.trailer.marker.y, locations.trailer.marker.z, 1.0, 1.0, 1.5, 0, 255, 0, 255)
							if Vdist(pos.x, pos.y, pos.z, locations.trailer.marker.x, locations.trailer.marker.y, locations.trailer.marker.z) < 1 then
								if not IsPedSittingInAnyVehicle(PlayerPedId()) then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to get a trailer!")
									if IsControlJustPressed(1, 51) then
										Citizen.CreateThread(function()
											local model = possibleTierMissions[trucker_job].Trailer
											RequestModel(model)
											while not HasModelLoaded(model) do
												Citizen.Wait(0)
											end
											trucker_trailer = CreateVehicle(model, locations.trailer.spawn.x, locations.trailer.spawn.y, locations.trailer.spawn.z, locations.trailer.spawn.h, true, false)
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
							if Vdist(pos.x, pos.y, pos.z, possibleTierMissions[trucker_job].Destination.x, possibleTierMissions[trucker_job].Destination.y, possibleTierMissions[trucker_job].Destination.z) < 20 then
								RenderMarker(25, possibleTierMissions[trucker_job].Destination.x, possibleTierMissions[trucker_job].Destination.y, possibleTierMissions[trucker_job].Destination.z, 6.0, 6.0, 6.5, 0, 255, 0, 255)
								if Vdist(pos.x, pos.y, pos.z, possibleTierMissions[trucker_job].Destination.x, possibleTierMissions[trucker_job].Destination.y, possibleTierMissions[trucker_job].Destination.z) < 6 then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to complete the delivery!")
									if IsControlJustPressed(1, 51) then
										local distance = Vdist(pos.x, pos.y, pos.z, locations.truck.x, locations.truck.y, locations.truck.z)
										TriggerServerEvent("trucker:complete", possibleTierMissions[trucker_job].Tier, distance)
										DestroyVehicle(trucker_trailer)
										trucker_trailer = nil
										trucker_job = nil
										possibleTierMissions = {}
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
function LocalPed()
	return GetPlayerPed(-1)
end

function DrawMissionText(m_text, showtime)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

--Don't mess with these, changing stuff goes below
local visits = 1
local l = 0
local area = 0
local onjob = false
local spawned_car = nil
local spawned_car2 = nil
local distance = 0

local destination = {
--Restraunts
{ x = 147.07858276367, y = -1462.3930664063, z = 29.141599655151, money = 250, trailer = 'Trailers2'},
{ x = 188.80735778809, y = -1459.5190429688, z = 29.141622543335, money = 250, trailer = 'Trailers2'},
{ x = -167.63006591797, y = -1436.1223144531, z = 31.247339248657, money = 250, trailer = 'Trailers2'},
{ x = -665.08831787109, y = -892.82263183594, z = 24.54599571228, money = 250, trailer = 'Trailers2'},
{ x = -558.14373779297, y = 302.66333007813, z = 83.220695495605, money = 250, trailer = 'Trailers2'},
{ x = 96.789001464844, y = 279.65631103516, z = 109.9340133667, money = 250, trailer = 'Trailers2'},
{ x = 184.93792724609, y = -218.31448364258, z = 53.872371673584, money = 250, trailer = 'Trailers2'},
{ x = 1192.1411132813, y = -402.35092163086, z = 67.829292297363, money = 250, trailer = 'Trailers2'},
--24/7's
{ x = 1965.705078125, y = 3757.5270996094, z = 32.237976074219, money = 400, trailer = 'Trailers3'},
{ x = 1377.5512695313, y = 3604.0078125, z = 34.891986846924, money = 400, trailer = 'Trailers3'},
{ x = 560.25280761719, y = 2678.92578125, z = 42.121398925781, money = 400, trailer = 'Trailers3'},
{ x = 2565.7619628906, y = 391.96539306641, z = 108.46299743652, money = 400, trailer = 'Trailers3'},
{ x = -1820.6522216797, y = 806.35900878906, z = 138.72241210938, money = 400, trailer = 'Trailers3'},
{ x = 142.09608459473, y = -1275.0654296875, z = 29.159107208252, money = 400, trailer = 'Trailers3'},
{ x = -1222.4432373047, y = -891.92633056641, z = 12.403017997742, money = 400, trailer = 'Trailers3'},
{ x = -724.36608886719, y = -914.63366699219, z = 19.013904571533, money = 400, trailer = 'Trailers3'},
{ x = 15.56547164917, y = -1341.5375976563, z = 29.285680770874, money = 400, trailer = 'Trailers3'},
{ x = 1689.0723876953, y = 4917.2397460938, z = 42.078136444092, money = 400, trailer = 'Trailers3'},
{ x = -3249.8337402344, y = 989.64501953125, z = 12.489533424377, money = 400, trailer = 'Trailers3'},
{ x = -3046.2875976563, y = 598.83386230469, z = 7.4617681503296, money = 400, trailer = 'Trailers3'},
{ x = 1165.7854003906, y = 2694.73046875, z = 37.83960723877, money = 400, trailer = 'Trailers3'},
{ x = 1718.9201660156, y = 6421.3178710938, z = 33.401309967041, money = 400, trailer = 'Trailers3'},
{ x = 1133.7065429688, y = -974.13665771484, z = 46.581489562988, money = 400, trailer = 'Trailers3'},
{ x = -58.529609680176, y = -1744.5052490234, z = 29.356561660767, money = 400, trailer = 'Trailers3'},
{ x = -1506.6971435547, y = -383.31210327148, z = 40.818824768066, money = 400, trailer = 'Trailers3'},
{ x = 367.07543945313, y = 335.7829284668, z = 103.38278961182, money = 400, trailer = 'Trailers3'},
{ x = 2662.6447753906, y = 3259.5646972656, z = 55.240520477295, money = 400, trailer = 'Trailers3'},
{ x = -2963.1079101563, y = 400.93740844727, z = 15.069319725037, money = 400, trailer = 'Trailers3'},
-- Wood Deliverys
{ x = 431.04672241211, y = 6467.4189453125, z = 28.768754959106, money = 500, trailer = 'TrailerLogs'},
{ x = -1989.7738037109, y = 550.68121337891, z = 110.16765594482, money = 500, trailer = 'TrailerLogs'},
{ x = -892.94616699219, y = 412.08633422852, z = 85.836479187012, money = 500, trailer = 'TrailerLogs'},
{ x = -929.79681396484, y = 172.83804321289, z = 66.307960510254, money = 500, trailer = 'TrailerLogs'},
{ x = -391.85604858398, y = 394.93658447266, z = 108.59880828857, money = 500, trailer = 'TrailerLogs'},
{ x = 127.32681274414, y = -408.95657348633, z = 41.06042098999, money = 500, trailer = 'TrailerLogs'},
{ x = 17.330871582031, y = -394.55059814453, z = 39.509296417236, money = 500, trailer = 'TrailerLogs'},
{ x = -98.259201049805, y = -1018.9482421875, z = 27.273578643799, money = 500, trailer = 'TrailerLogs'},
{ x = -136.20190429688, y = -1105.001953125, z = 21.685255050659, money = 500, trailer = 'TrailerLogs'},
{ x = -488.15496826172, y = -969.48937988281, z = 23.550556182861, money = 500, trailer = 'TrailerLogs'},
{ x = -1095.2667236328, y = -1638.1287841797, z = 4.3984236717224, money = 500, trailer = 'TrailerLogs'},
{ x = 1296.4202880859, y = -1731.4213867188, z = 53.717426300049, money = 500, trailer = 'TrailerLogs'},
{ x = 1054.4891357422, y = -405.73962402344, z = 66.869537353516, money = 500, trailer = 'TrailerLogs'},
{ x = 993.88232421875, y = -484.10470581055, z = 61.8293800354, money = 500, trailer = 'TrailerLogs'},
{ x = 945.80987548828, y = -571.58447265625, z = 58.184722900391, money = 500, trailer = 'TrailerLogs'},
{ x = 1605.6531982422, y = 3611.6931152344, z = 35.146289825439, money = 500, trailer = 'TrailerLogs'},
{ x = 1534.7393798828, y = 3604.0590820313, z = 35.255783081055, money = 500, trailer = 'TrailerLogs'},
{ x = 1901.6546630859, y = 4918.181640625, z = 48.710025787354, money = 500, trailer = 'TrailerLogs'},
{ x = 1945.2406005859, y = 4638.0200195313, z = 40.555744171143, money = 500, trailer = 'TrailerLogs'},
{ x = 1353.7619628906, y = 4371.1323242188, z = 44.310749053955, money = 500, trailer = 'TrailerLogs'},
{ x = 717.90283203125, y = 4179.1181640625, z = 40.709190368652, money = 500, trailer = 'TrailerLogs'},
{ x = -3172.0493164063, y = 1300.1324462891, z = 14.727311134338, money = 500, trailer = 'TrailerLogs'},
{ x = -3053.8308105469, y = 441.86306762695, z = 6.3617038726807, money = 500, trailer = 'TrailerLogs'},
{ x = -510.33810424805, y = 5240.7973632813, z = 80.304084777832, money = 500, trailer = 'TrailerLogs'},
-- Gas Stations
{ x = 631.4739, y = 282.8075, z = 103.2208, money = 600, trailer = 'Tanker'},
{ x = 1153.5305175781, y = -331.64242553711, z = 68.8681640625, money = 600, trailer = 'Tanker'},
{ x = 826.01831054688, y = -1049.0705566406, z = 27.753950119019, money = 600, trailer = 'Tanker'},
{ x = 1200.3819580078, y = -1383.86328125, z = 35.226955413818, money = 600, trailer = 'Tanker'},
{ x = 1224.4202880859, y = -1516.6595458984, z = 34.692562103271, money = 600, trailer = 'Tanker'},
{ x = -60.702255249023, y = -2526.8957519531, z = 6.0121812820435, money = 600, trailer = 'Tanker'},
{ x = -59.351810455322, y = -1745.6217041016, z = 29.354942321777, money = 600, trailer = 'Tanker'},
{ x = 179.89334106445, y = -1547.9525146484, z = 29.15767288208, money = 600, trailer = 'Tanker'},
{ x = -335.82962036133, y = -1493.3955078125, z = 30.630931854248, money = 600, trailer = 'Tanker'},
{ x = 293.97183227539, y = -1246.3718261719, z = 29.290744781494, money = 600, trailer = 'Tanker'},
{ x = -518.37274169922, y = -1221.1595458984, z = 18.291185379028, money = 600, trailer = 'Tanker'},
{ x = -723.04473876953, y = -920.60083007813, z = 19.013999938965, money = 600, trailer = 'Tanker'},
{ x = -1432.5651855469, y = -249.32447814941, z = 46.353832244873, money = 600, trailer = 'Tanker'},
{ x = -2068.1018066406, y = -304.18740844727, z = 13.149713516235, money = 600, trailer = 'Tanker'},
{ x = -1817.2364501953, y = 806.62017822266, z = 138.62257385254, money = 600, trailer = 'Tanker'},
{ x = -2536.9858398438, y = 2325.6931152344, z = 33.059902191162, money = 600, trailer = 'Tanker'},
{ x = 41.683433532715, y = 2801.2265625, z = 57.878124237061, money = 600, trailer = 'Tanker'},
{ x = 1026.3043212891, y = 2656.4147949219, z = 39.551139831543, money = 600, trailer = 'Tanker'},
{ x = 1206.716796875, y = 2639.0991210938, z = 37.809928894043, money = 600, trailer = 'Tanker'},
{ x = 2535.3991699219, y = 2583.4584960938, z = 37.944828033447, money = 600, trailer = 'Tanker'},
{ x = 1784.3669433594, y = 3318.9340820313, z = 41.468753814697, money = 600, trailer = 'Tanker'},
{ x = 1991.1534423828, y = 3775.333984375, z = 32.180812835693, money = 600, trailer = 'Tanker'},
{ x = 2566.48046875, y = 400.3596496582, z = 108.46235656738, money = 600, trailer = 'Tanker'},
{ x = 2536.0888671875, y = 2581.564453125, z = 37.944869995117, money = 600, trailer = 'Tanker'},
{ x = 1687.9085693359, y = 4916.494140625, z = 42.078140258789, money = 600, trailer = 'Tanker'},
{ x = 1716.0020751953, y = 6418.0874023438, z = 33.209869384766, money = 600, trailer = 'Tanker'},
{ x = 197.29220581055, y = 6616.333984375, z = 31.755296707153, money = 600, trailer = 'Tanker'},
{ x = -95.194450378418, y = 6394.876953125, z = 31.452095031738, money = 600, trailer = 'Tanker'},
-- Car Deliverys
{ x = -15.986042976379, y = -1085.6513671875, z = 26.672069549561, money = 750, trailer = 'TR4'},
{ x = -895.73071289063, y = -2334.0769042969, z = 6.7090282440186, money = 750, trailer = 'TR4'},
}

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

RegisterNetEvent("trucking:deliveryfalse")
AddEventHandler("trucking:deliveryfalse", function()
	SetNotificationTextEntry("STRING");
	AddTextComponentString("~r~You are not a delivery guy" );
	DrawNotification(false, true);
end)

RegisterNetEvent("trucking:deliverytrue")
AddEventHandler("trucking:deliverytrue", function()
    SpawnTruck()
	SetNotificationTextEntry("STRING");
	AddTextComponentString("~g~Have a good route" );
	DrawNotification(false, true);
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(25, 803.03729248047, -3022.7150878906, 5.8015251159668 - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)
		if GetDistanceBetweenCoords(803.03729248047, -3022.7150878906, 5.8015251159668, GetEntityCoords(LocalPed())) < 2.0 then
			basiccheck()
		end
		if onjob == true then 
			if GetDistanceBetweenCoords(destination[l].x,destination[l].y,destination[l].z, GetEntityCoords(GetPlayerPed(-1))) < 3.0 then
				if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("phantom"))  then
					drawTxt('Press ~g~H~s~ to deliver your ~b~ package', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
					if (IsControlJustReleased(1, 74)) then
						deliverysuccess(distance)
					end
				end
			end
		end
	end
end)

function basiccheck()
	if onjob == false then 
		if (IsInVehicle()) then
			if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("phantom")) then
				drawTxt('Press ~g~E~s~ to get a new trailer for your~b~ truck', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
				if (IsControlJustReleased(1, 38)) then
					TriggerServerEvent('trucking:checkjob')
				end
			else
				drawTxt('Press ~g~E~s~ to get your~b~ truck', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
				if (IsControlJustReleased(1, 38)) then
					TriggerServerEvent('trucking:checkjob')
				end
			end	
		else
			drawTxt('Press ~g~E~s~ to get your~b~ truck', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
			if (IsControlJustReleased(1, 38)) then
				TriggerServerEvent('trucking:checkjob')
			end
		end
	else
		drawTxt('Press ~g~H~s~ to cancel the last truck~b~ at cost', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
		if (IsControlJustReleased(1, 74)) then
			TriggerServerEvent('trucking:fail', destination[l].money)
			onjob = false
			RemoveBlip(deliveryblip)
			SetWaypointOff()
			visits = 1
			DeleteVehicle(spawned_car)
			DeleteVehicle(spawned_car2)
		end
	end
end

function IsInVehicle()
 local ply = GetPlayerPed(-1)
 if IsPedSittingInAnyVehicle(ply) then
 return true
 else
 return false
 end
end

function startjob()
	DrawMissionText("Drive to the marked ~g~destination~w~.", 10000)
	onjob = true
		l = GetRandomIntInRange(1, 82)
		distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), destination[l].x,destination[l].y,destination[l].z, true)
		deliveryblip = (AddBlipForCoord(destination[l].x,destination[l].y,destination[l].z))
		SetBlipSprite(deliveryblip, 479)
		SetNewWaypoint(destination[l].x,destination[l].y)
end

function SpawnTruck()
	if (IsInVehicle()) then
		if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("phantom")) then
			startjob()
		else
			local currentVeh = GetVehiclePedIsIn(GetPlayerPed(-1))
			SetEntityAsMissionEntity(currentVeh, true, true)
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentVeh))
			Citizen.Wait(0)
			local myPed = GetPlayerPed(-1)
			local player = PlayerId()
			local vehicle = GetHashKey('phantom')

			RequestModel(vehicle)

			while not HasModelLoaded(vehicle) do
				Wait(1)
			end

			local plate = math.random(100, 900)
			local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
			spawned_car3 = CreateVehicle(vehicle, coords, 180, true, false)
			SetVehicleOnGroundProperly(spawned_car)
			SetPedIntoVehicle(myPed, spawned_car, - 1)
			SetModelAsNoLongerNeeded(vehicle)
			DecorSetBool(spawned_car, "hotwire", true)
			Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
			startjob()
		end
	else
		Citizen.Wait(0)
		local myPed = GetPlayerPed(-1)
		local player = PlayerId()
		local vehicle = GetHashKey('phantom')

		RequestModel(vehicle)

		while not HasModelLoaded(vehicle) do
			Wait(1)
		end

		local plate = math.random(100, 900)
		local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
		spawned_car = CreateVehicle(vehicle, coords, 180, true, false)
		SetVehicleOnGroundProperly(spawned_car)
		SetPedIntoVehicle(myPed, spawned_car, - 1)
		SetModelAsNoLongerNeeded(vehicle)
		DecorSetBool(spawned_car, "hotwire", true)
		Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
		startjob()
	end
		Citizen.Wait(0)
		local myPed = GetPlayerPed(-1)
		local player = PlayerId()
		local vehicle2 = GetHashKey(destination[l].trailer)

		RequestModel(vehicle2)

		while not HasModelLoaded(vehicle2) do
			Wait(1)
		end

		local plate = math.random(100, 900)
		spawned_car2 = CreateVehicle(vehicle2, 805.78771972656, -3039.8269042969, 5.7421274185181, 180, true, false)
		SetVehicleOnGroundProperly(spawned_car)
		SetModelAsNoLongerNeeded(vehicle)
		Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end

function deliverysuccess(distance)
local dtraveled = distance
TriggerServerEvent('trucking:success', dtraveled)
	if visits == 1 then --change 3 to however many runs you want a person to be able to make before having to return to the depot
		RemoveBlip(deliveryblip)
		onjob = false
		visits = 1
		DrawMissionText("You can return to the ~g~depot~w~ to pick up more packages.", 10000)
	else
		RemoveBlip(deliveryblip)
		startjob()
		visits = visits + 1
	end
end

local blips = {
	{title="Jetsam Trucking", colour=21, id=477, x=821.99206542969, y=-3036.3386230469, z=5.7421269416809},
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.7)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
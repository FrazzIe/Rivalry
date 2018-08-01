local bin_locations = {
	{enteringbin = {-322.247,-1545.958,30.01993}, innutile2 = {-322.247,-1545.958,30.01993}, outsidebin= {-326.9868,-1521.877,27.53701}},
}

local bin_blips ={}
local inrangeofbin= false
local inrangeofbin3 = false
local currentlocation = nil
local boughtcar = false
local distance = 0
local existingVeh = nil
local function LocalPed()
	return GetPlayerPed(-1)
end

function drawTxtbin(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerinrangeofbin()
	return inrangeofbin
end

function IsPlayerinrangeofbin3()
	return inrangeofbin3
end

function ShowbinBlips(bool)
	if bool and #bin_blips == 0 then
		for station,pos in pairs(bin_locations) do
			local loc = pos
			pos = pos.outsidebin
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,318)
			SetBlipColour(blip, 2)
			SetBlipScale(blip, 0.6)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Garbage')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(bin_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #bin_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				local inrange3 = false
				for i,b in ipairs(bin_blips) do
					if IsPedInAnyVehicle(LocalPed(), true) == false and GetDistanceBetweenCoords(b.pos.enteringbin[1],b.pos.enteringbin[2],b.pos.enteringbin[3],GetEntityCoords(LocalPed()),true) > 0 then
						DrawMarker(1,-315.74,-1531.069,26.500,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
						currentlocation = b
						if GetDistanceBetweenCoords(-315.74,-1531.069,27.09734,GetEntityCoords(LocalPed()),true) < 3 then
							ShowInfoJobBin("Press ~INPUT_CONTEXT~ to get your ~b~Truck~w~.", 0)
							inrange3 = true
						end
					end
				end
				inrangeofbin = inrange
				inrangeofbin3 = inrange3
			end
		end)
	elseif bool == false and #bin_blips > 0 then
		for i,b in ipairs(bin_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		bin_blips = {}
	end
end

local ShowMsgtime = { msg = "", time = 0 }
local myjob = 0


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ShowMsgtime.time ~= 0 then
      drawTxtbin(ShowMsgtime.msg, 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
      ShowMsgtime.time = ShowMsgtime.time - 1
    end
  end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,51) and inrangeofbin3 then
			TriggerServerEvent("garbage:getplayerjob")
			Wait(1000)
			if myjob == 21 then
				SetPedComponentVariation(GetPlayerPed(-1), 11, 56, 0, 0)
				SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 0)
				SetPedComponentVariation(GetPlayerPed(-1), 3, 99, 0, 0)
				SetPedComponentVariation(GetPlayerPed(-1), 4, 36, 0, 0)
				SetPedComponentVariation(GetPlayerPed(-1), 6, 12, 6, 0)
				--TriggerServerEvent('CheckPoolVehi')
				--TriggerServerEvent('SetPlateJob')
				--local car = 0xC703DB5F
				Wait(100)

				Citizen.CreateThread(function()
					Citizen.Wait(10)
					if(existingVeh ~= nil) then
						SetEntityAsMissionEntity(existingVeh, true, true)
						Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
						existingVeh = nil
					else
						local vehiculeDetected = GetClosestVehicle(-324.254, -1530.044, 27.54, 6.0, 0, 70)
						if not DoesEntityExist(vehiculeDetected) then
							local car = GetHashKey("trash")
							local bplate = "TRASH" .. math.random(100,900)
							local cplate = string.upper(bplate)

							RequestModel(car)
							while not HasModelLoaded(car) do
								Citizen.Wait(0)
							end
							existingVeh = CreateVehicle(car, -324.254, -1530.044, 27.54, 0.0, true, false)
							SetEntityVelocity(existingVeh, 2000)
							SetVehicleOnGroundProperly(existingVeh)
							SetVehicleHasBeenOwnedByPlayer(existingVeh,true)
							local id = NetworkGetNetworkIdFromEntity(existingVeh)
							SetNetworkIdCanMigrate(id, true)
							SetVehRadioStation(existingVeh, "OFF")
							SetVehicleColours(existingVeh, 64,64)
							SetVehicleLivery(existingVeh, 1)
							SetPedIntoVehicle(GetPlayerPed(-1),existingVeh,-1)
							SetModelAsNoLongerNeeded(car)
							DecorSetBool(existingVeh, "hotwire", true)
						else
							DrawMissionTextbin("~h~~y~Area is congested~w~.", 6000)
						end
					end
				end)
				clientjobID = 46 -- Piscine
				inrangeofbin3 = false
				inrange3 = false
			else
				DrawMissionTextbin("You must be a ~h~~y~Garbage man~w~.", 6000)
			end
		end
	end
end)

onJobBin = 0

bin = {flag = {}, blip = {}, veh = {}, coords = {cx={}, cy={}, cz={}}}

function StartJobBin()
	showLoadingPromtbin("Setting GPS...", 4000, 3)
	bin.coords.cx[1],bin.coords.cy[1],bin.coords.cz[1] = -337.6367,-2786.992,4.000239
	bin.coords.cx[2],bin.coords.cy[2],bin.coords.cz[2] = 1050.857,-2391.396,29.28452
	bin.coords.cx[3],bin.coords.cy[3],bin.coords.cz[3] = 1005.835,-2067.349,30.13629
	bin.coords.cx[4],bin.coords.cy[4],bin.coords.cz[4] = 957.2108,-1912.296,30.14571
	bin.coords.cx[5],bin.coords.cy[5],bin.coords.cz[5] = 770.9854,-1902.144,28.26986
	bin.coords.cx[6],bin.coords.cy[6],bin.coords.cz[6] = 969.3815,-945.3486,41.29815
	bin.coords.cx[7],bin.coords.cy[7],bin.coords.cz[7] = 776.6561,-1054.236,26.05088
	bin.coords.cx[8],bin.coords.cy[8],bin.coords.cz[8] = 787.1,-1323.691,25.06788
	bin.coords.cx[9],bin.coords.cy[9],bin.coords.cz[9] = 1089.071,-449.5304,64.72475
	bin.coords.cx[10],bin.coords.cy[10],bin.coords.cz[10] = 617.2553,70.19471,89.7544
	bin.coords.cx[11],bin.coords.cy[11],bin.coords.cz[11] = 560.3558,171.2989,99.2312
	bin.coords.cx[12],bin.coords.cy[12],bin.coords.cz[12] = 384.0609,238.476,102.0361
	bin.coords.cx[13],bin.coords.cy[13],bin.coords.cz[13] = 10.20545,4.926725,69.6499
	bin.coords.cx[14],bin.coords.cy[14],bin.coords.cz[14] = 197.3791,-1092.112,28.2783
	bin.coords.cx[15],bin.coords.cy[15],bin.coords.cz[15] = 199.9383,-1296.267,28.32153
	bin.coords.cx[16],bin.coords.cy[16],bin.coords.cz[16] = 272.633,-1499.289,28.2916
	bin.coords.cx[17],bin.coords.cy[17],bin.coords.cz[17] = 263.7913,-1677.058,28.30527
	bin.coords.cx[18],bin.coords.cy[18],bin.coords.cz[18] = 224.064,-1836.624,25.95535
	bin.coords.cx[19],bin.coords.cy[19],bin.coords.cz[19] = 161.0778,-1876.63,22.9732
	bin.coords.cx[20],bin.coords.cy[20],bin.coords.cz[20] = 41.75639,-1879.637,21.21154
	bin.coords.cx[21],bin.coords.cy[21],bin.coords.cz[21] = -28.13282,-1640.856,28.29198
	bin.coords.cx[22],bin.coords.cy[22],bin.coords.cz[22] = -171.739,-1459.672,30.68687
	bin.coords.cx[23],bin.coords.cy[23],bin.coords.cz[23] = -717.054,-1171.374,9.46338
	bin.coords.cx[24],bin.coords.cy[24],bin.coords.cz[24] = -1075.155,-1273.394,4.829365
	bin.coords.cx[25],bin.coords.cy[25],bin.coords.cz[25] = -1076.804,-1498.936,4.104791
	bin.coords.cx[26],bin.coords.cy[26],bin.coords.cz[26] = -1054.713,-1610.139,3.399037
	bin.coords.cx[27],bin.coords.cy[27],bin.coords.cz[27] = -1264.468,-1374.695,3.17067
	bin.coords.cx[28],bin.coords.cy[28],bin.coords.cz[28] = -1277.544,-1210.355,3.724486
	bin.coords.cx[29],bin.coords.cy[29],bin.coords.cz[29] = -1071.163,-1029.759,1.091357
	bin.coords.cx[30],bin.coords.cy[30],bin.coords.cz[30] = -1018.297,-1119.402,1.120266
	bin.coords.cx[31],bin.coords.cy[31],bin.coords.cz[31] = -1622.477,-1081.264,12.01845
	bin.coords.cx[32],bin.coords.cy[32],bin.coords.cz[32] = -1801.939,-410.1487,43.5813
	bin.coords.cx[33],bin.coords.cy[33],bin.coords.cz[33] = -1753.204,-377.5302,44.74607
	bin.coords.cx[34],bin.coords.cy[34],bin.coords.cz[34] = -964.1352,-185.0301,36.80095
	bin.coords.cx[35],bin.coords.cy[35],bin.coords.cz[35] = -1481.334,59.09226,52.53588
	bin.coords.cx[36],bin.coords.cy[36],bin.coords.cz[36] = -1629.261,77.69003,60.94693
	bin.coords.cx[37],bin.coords.cy[37],bin.coords.cz[37] = -1892.951,185.2168,81.59013
	bin.coords.cx[38],bin.coords.cy[38],bin.coords.cz[38] = -1466.232,518.6081,116.9691
	bin.coords.cx[39],bin.coords.cy[39],bin.coords.cz[39] = -1298.72,627.9941,136.7925
	bin.coords.cx[40],bin.coords.cy[40],bin.coords.cz[40] = -1256.728,653.576,139.9319
	bin.coords.cx[41],bin.coords.cy[41],bin.coords.cz[41] = -1177.898,722.7534,150.6435
	bin.coords.cx[42],bin.coords.cy[42],bin.coords.cz[42] = -1111.839,775.9818,161.6958
	bin.coords.cx[43],bin.coords.cy[43],bin.coords.cz[43] = -979.8621,694.6163,155.8505
	bin.coords.cx[44],bin.coords.cy[44],bin.coords.cz[44] = -680.5673,605.562,142.9354
	bin.coords.cx[45],bin.coords.cy[45],bin.coords.cz[45] = -619.3099,682.4254,148.8345
	bin.coords.cx[46],bin.coords.cy[46],bin.coords.cz[46] = -509.0829,575.6403,118.847
	bin.coords.cx[47],bin.coords.cy[47],bin.coords.cz[47] = -345.6455,429.374,109.4156
	bin.coords.cx[48],bin.coords.cy[48],bin.coords.cz[48] = -194.7099,419.3295,108.9558
	bin.coords.cx[49],bin.coords.cy[49],bin.coords.cz[49] = -215.4222,276.3777,91.04716
	bin.coords.cx[50],bin.coords.cy[50],bin.coords.cz[50] = -468.5767,272.7403,82.26152
	bin.coords.cx[51],bin.coords.cy[51],bin.coords.cz[51] = -343.4309,103.5678,65.67259
	bin.coords.cx[52],bin.coords.cy[52],bin.coords.cz[52] = -287.9857,-95.30598,46.21479
	bin.coords.cx[53],bin.coords.cy[53],bin.coords.cz[53] = -359.5632,-145.9291,37.24692
	bin.coords.cx[54],bin.coords.cy[54],bin.coords.cz[54] = -147.5077,-747.1575,32.89324
	bin.coords.cx[55],bin.coords.cy[55],bin.coords.cz[55] = -246.4445,-1128.171,22.06822
	bin.coords.cx[56],bin.coords.cy[56],bin.coords.cz[56] = -294.119,-1357.757,30.31021
	bin.coords.cx[57],bin.coords.cy[57],bin.coords.cz[57] = -894.062,-2750.131,12.94431
	bin.coords.cx[58],bin.coords.cy[58],bin.coords.cz[58] = -1052.065,-2086.243,12.34221
	bin.coords.cx[59],bin.coords.cy[59],bin.coords.cz[59] = -1148.458,-1987.686,12.16035
	bin.coords.cx[60],bin.coords.cy[60],bin.coords.cz[60] = -589.994,-1737.421,21.75804
	bin.coords.cx[61],bin.coords.cy[61],bin.coords.cz[61] = -240.9282,-1473.415,30.4771
	bin.coords.cx[62],bin.coords.cy[62],bin.coords.cz[62] = -171.5853,-1461.888,30.79383
	bin.veh[1] = GetVehiclePedIsUsing(GetPlayerPed(-1))
	bin.flag[1] = 1
	bin.flag[2] = GetRandomIntInRange(1, 62)
	Wait(2000)
	DrawMissionTextbin("Drive and go pick up the ~h~~y~Garbage~w~.", 10000)
	onJobBin = 1
end

function DrawMissionTextbin(m_text, showtime)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function showLoadingPromtbin(showText, showTime, showType)
	Citizen.CreateThread(function()
		Citizen.Wait(0)
		N_0xaba17d7ce615adbf("STRING") -- set type
		AddTextComponentString(showText) -- sets the text
		N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
		Citizen.Wait(showTime) -- show time
		N_0x10d373323e5b9c0d() -- remove promt
	end)
end

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function ShowInfoJobBin(text, state)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function StopJobBin()
	if bin.blip[1] ~= nil and DoesBlipExist(bin.blip[1]) then
		Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bin.blip[1]))
		bin.blip[1] = nil
	end
	onJobBin = 0
	clientjobID = 0
	bin.veh[1] = nil
	bin.flag[1] = nil
	bin.flag[2] = nil
end

function StopJobBinDistance()
	if bin.blip[1] ~= nil and DoesBlipExist(bin.blip[1]) then
		Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bin.blip[1]))
		bin.blip[1] = nil
	end
	onJobBin = 0
	clientjobID = 46
	bin.veh[1] = nil
	bin.flag[1] = nil
	bin.flag[2] = nil
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if onJobBin == 0 then
			if (clientjobID == 46) then -- JOB pool
				if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					if IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("trash", _r)) then
						TriggerServerEvent("garbage:getplayerjob")
						Wait(1000)
						if myjob == 21 then
							StartJobBin(1)
						else
							DrawMissionTextbin("You must be a ~h~~y~Garbage man~w~.", 6000)
						end
					end
				end
			end
		elseif onJobBin == 1 then
			if DoesEntityExist(bin.veh[1]) and IsVehicleDriveable(bin.veh[1], 0) then

				if bin.flag[1] == 1 then
					bin.flag[2] = GetRandomIntInRange(1, 62)
					bin.blip[1] = AddBlipForCoord(bin.coords.cx[bin.flag[2]],bin.coords.cy[bin.flag[2]],bin.coords.cz[bin.flag[2]])
					N_0x80ead8e2e1d5d52e(bin.blip[1])
					SetBlipRoute(bin.blip[1], 1)
					distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bin.coords.cx[bin.flag[2]],bin.coords.cy[bin.flag[2]],bin.coords.cz[bin.flag[2]], true)
					bin.flag[1] = 2
				end
				if bin.flag[1] == 2 then
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bin.coords.cx[bin.flag[2]],bin.coords.cy[bin.flag[2]],bin.coords.cz[bin.flag[2]], true) > 2.0001 then
						DrawMarker(1, bin.coords.cx[bin.flag[2]],bin.coords.cy[bin.flag[2]],bin.coords.cz[bin.flag[2]]-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
					else
						if bin.blip[1] ~= nil and DoesBlipExist(bin.blip[1]) then
							Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(bin.blip[1]))
							bin.blip[1] = nil
						end
						if IsPedInAnyVehicle(LocalPed(), true) == false then
							ShowInfoJobBin("Press ~INPUT_CONTEXT~ to ~b~pick up~w~ the trash.", 0)
							if IsControlJustPressed(1,38) then
								local dict = "pickup_object"
								local anim = "pickup_low"
								RequestAnimDict(dict)

								while not HasAnimDictLoaded(dict) do
									Citizen.Wait(0)
								end

								local myPed = PlayerPedId()
								local animation = anim
								local flags = 16 -- only play the animation on the upper body

								TaskPlayAnim(myPed, dict, animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
								Wait(2000)
								DrawMissionTextbin("~h~You have picked up ~g~Trash!", 5000)
								TriggerServerEvent('garbage:success', distance)
								--TriggerServerEvent('CheckPool')
								Wait(2000)
								bin.flag[1] = 1
								bin.flag[2] = GetRandomIntInRange(1, 62)
							end
						end
					end
				end

				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(bin.veh[1]), true) > 350.0001 then
					if clientjobID == 46 then
						StopJobBinDistance(1)
						DrawMissionTextbin("~r~Return to your vehicle to resume your work!", 6000)
					end
				else

				end

			else
				StopJobBin(1)
				DrawMissionTextbin("Your truck is ~h~~r~out of service~w~.", 5000)
			end
		end
	end
end)


AddEventHandler('playerSpawned', function(spawn)
	ShowbinBlips(true)
	StopJobBin(1)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ShowMsgtime.time ~= 0 then
      drawTxtpool(ShowMsgtime.msg, 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
      ShowMsgtime.time = ShowMsgtime.time - 1
    end
  end
end)

Citizen.CreateThread(function()
  while true do
  	Citizen.Wait(0)
	if IsEntityDead(GetPlayerPed(-1)) then
		clientjobID = 0
		Citizen.Wait(5000)
	end
  end
end)
RegisterNetEvent("garbage:result")
AddEventHandler("garbage:result", function(job)
	myjob = job
end)

RegisterNetEvent("garbage:playerleft")
AddEventHandler("garbage:playerleft", function(source)
	StopJobBin(1)
end)

RegisterNetEvent("garbage:changedjob")
AddEventHandler("garbage:changedjob", function(source)
	if clientjobID == 46 then
		DrawMissionTextpool("You are no longer a ~h~~y~Garbage man~w~.", 6000)
		TriggerClientEvent("mm:otherspawn")
		StopJobBin(1)
	end
end)
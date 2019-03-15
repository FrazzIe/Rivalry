local clientjobID = 0
local myjob = nil

job = {
	plate = 0,
}

local pool_locations = {
	{enteringpool = {722.0145,-909.5587,24.43356}, innutile2 = {722.0145,-909.5587,24.43356}, outsidepool= {717.3234,-894.7209,24.0391}},
}

local pool_blips ={}
local inrangeofpool= false
local inrangeofpool3 = false
local currentlocation = nil
local boughtcar = false
local existingVeh = nil
local function LocalPed()
	return GetPlayerPed(-1)
end

function drawTxtpool(text,font,centre,x,y,scale,r,g,b,a)
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

function IsPlayerInRangeOfpool()
	return inrangeofpool
end

function IsPlayerInRangeOfpool3()
	return inrangeofpool3
end

function ShowpoolBlips(bool)
	if bool and #pool_blips == 0 then
		for station,pos in pairs(pool_locations) do
			local loc = pos
			pos = pos.outsidepool
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,399)
			SetBlipColour(blip, 2)
			SetBlipScale(blip, 0.6)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Clean Pools Job')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(pool_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #pool_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				local inrange3 = false
				for i,b in ipairs(pool_blips) do
					if IsPedInAnyVehicle(LocalPed(), true) == false and GetDistanceBetweenCoords(b.pos.enteringpool[1],b.pos.enteringpool[2],b.pos.enteringpool[3],GetEntityCoords(LocalPed()),true) > 0 then
						DrawMarker(1,711.4304,-893.3711,23.05157-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
						currentlocation = b
						if GetDistanceBetweenCoords(711.4304,-893.3711,23.05157,GetEntityCoords(LocalPed()),true) < 3 then
							ShowInfoJobPool("Press ~INPUT_CONTEXT~ to get your ~b~Truck($500)~w~.", 0)
							inrange3 = true
						end
					end
				end
				inrangeofpool = inrange
				inrangeofpool3 = inrange3
			end
		end)
	elseif bool == false and #pool_blips > 0 then
		for i,b in ipairs(pool_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		pool_blips = {}
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,38) and inrangeofpool3 then
			TriggerServerEvent("pool:getplayerjob")
			Wait(1000)
			if myjob == 20 then
				SetPedComponentVariation(GetPlayerPed(-1), 11, 123, 1, 0)
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 0)
				SetPedComponentVariation(GetPlayerPed(-1), 4, 17, 6, 0)
				SetPedComponentVariation(GetPlayerPed(-1), 6, 8, 0, 0)
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0)
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
							local car = GetHashKey("utillitruck3")
							local bplate = "POOL " .. math.random(100,900)
							local cplate = string.upper(bplate)

							RequestModel(car)
							while not HasModelLoaded(car) do
								Citizen.Wait(0)
							end
							existingVeh = CreateVehicle(car, 740.328552246094,-877.556884765625,25.038875579834, -90.0, true, false)
							SetEntityVelocity(existingVeh, 2000)
							SetVehicleOnGroundProperly(existingVeh)
							SetVehicleHasBeenOwnedByPlayer(existingVeh,true)
							local id = NetworkGetNetworkIdFromEntity(existingVeh)
							SetNetworkIdCanMigrate(id, true)
							SetVehRadioStation(existingVeh, "OFF")
							SetVehicleColours(existingVeh, 64,64)
							SetVehicleLivery(existingVeh, 1)
							SetPedIntoVehicle(GetPlayerPed(-1),  existingVeh,  -1)
							SetModelAsNoLongerNeeded(car)
							DecorSetBool(existingVeh, "hotwire", true)
							exports.pNotify:SendNotification({
            					text = "You better clean those pools like your life depends on it!",
            					type = "error",
           						timeout = 5000,
            					layout = "bottomCenter",
            					queue = "left"
        					})
						else
							DrawMissionTextbin("~h~~y~Area is congested~w~.", 6000)
						end
					end
				end)
				clientjobID = 45 -- Piscine
				inrangeofpool3 = false
				inrange3 = false
			else
				DrawMissionTextpool("You must be a ~h~~y~Pool Cleaner~w~.", 6000)
			end
		end
	end
end)

onJobPool = 0

daily = {flag = {}, blip = {}, veh = {}, coords = {cx={}, cy={}, cz={}}}

function StartJobPool()
	showLoadingPromtpool("Setting GPS...", 3000, 3)
	daily.coords.cx[1], daily.coords.cy[1], daily.coords.cz[1] = -303.661682128906,-1086.890625,30.385066986084
	daily.coords.cx[2], daily.coords.cy[2], daily.coords.cz[2] = -738.929504394531,-1001.42248535156,18.1769104003906
	daily.coords.cx[3], daily.coords.cy[3], daily.coords.cz[3] = -979.689331054688,-1499.07653808594,5.58674478530884
	daily.coords.cx[4], daily.coords.cy[4], daily.coords.cz[4] = -1316.59814453125,-1048.72253417969,12.4786081314087
	daily.coords.cx[5], daily.coords.cy[5], daily.coords.cz[5] = -1349.1513671875,-928.871337890625,11.7529716491699
	daily.coords.cx[6], daily.coords.cy[6], daily.coords.cz[6] = 950.528198242188,-688.87255859375,57.5051918029785
	daily.coords.cx[7], daily.coords.cy[7], daily.coords.cz[7] = 917.773559570313,-654.479614257813,57.9147567749023
	daily.coords.cx[8], daily.coords.cy[8], daily.coords.cz[8] = -1660.48107910156,-421.920166015625,41.6179161071777
	daily.coords.cx[9], daily.coords.cy[9], daily.coords.cz[9] = 906.0537109375,-641.011352539063,58.0660133361816
	daily.coords.cx[10], daily.coords.cy[10], daily.coords.cz[10] = 877.856262207031,-617.921936035156,56.6520385742188
	daily.coords.cx[11], daily.coords.cy[11], daily.coords.cz[11] = 841.294250488281,-581.756225585938,57.2155075073242
	daily.coords.cx[12], daily.coords.cy[12], daily.coords.cz[12] = 827.415588378906,-532.004211425781,56.469123840332
	daily.coords.cx[13], daily.coords.cy[13], daily.coords.cz[13] = 852.127380371094,-500.040161132813,54.8360176086426
	daily.coords.cx[14], daily.coords.cy[14], daily.coords.cz[14] = -1860.73413085938,-350.519195556641,55.8096160888672
	daily.coords.cx[15], daily.coords.cy[15], daily.coords.cz[15] = 902.229919433594,-465.024230957031,59.0920791625977
	daily.coords.cx[16], daily.coords.cy[16], daily.coords.cz[16] = -1546.62854003906,-267.386596679688,46.7072334289551
	daily.coords.cx[17], daily.coords.cy[17], daily.coords.cz[17] = 917.226196289063,-461.550964355469,60.6280632019043
	daily.coords.cx[18], daily.coords.cy[18], daily.coords.cz[18] = -1536.68811035156,-113.272468566895,53.7628211975098
	daily.coords.cx[19], daily.coords.cy[19], daily.coords.cz[19] = 935.613708496094,-448.359924316406,61.2502975463867
	daily.coords.cx[20], daily.coords.cy[20], daily.coords.cz[20] = -1491.96154785156,-60.7673263549805,54.615852355957
	daily.coords.cx[21], daily.coords.cy[21], daily.coords.cz[21] = -1476.49975585938,10.6081628799438,54.0265998840332
	daily.coords.cx[22], daily.coords.cy[22], daily.coords.cz[22] = 954.409240722656,-437.870727539063,62.4910926818848
	daily.coords.cx[23], daily.coords.cy[23], daily.coords.cz[23] = -1538.25463867188,-4.20401763916016,56.4208221435547
	daily.coords.cx[24], daily.coords.cy[24], daily.coords.cz[24] = -1580.49780273438,4.59697198867798,60.8923759460449
	daily.coords.cx[25], daily.coords.cy[25], daily.coords.cz[25] = 1005.43011474609,-408.125579833984,64.4217300415039
	daily.coords.cx[26], daily.coords.cy[26], daily.coords.cz[26] = -1633.92993164063,-1.20869052410126,61.5918731689453
	daily.coords.cx[27], daily.coords.cy[27], daily.coords.cz[27] = -1478.93176269531,188.168075561523,56.6722755432129
	daily.coords.cx[28], daily.coords.cy[28], daily.coords.cz[28] = -1351.06921386719,345.849487304688,64.0796966552734
	daily.coords.cx[29], daily.coords.cy[29], daily.coords.cz[29] = -1201.46704101563,312.805389404297,69.457145690918
	daily.coords.cx[30], daily.coords.cy[30], daily.coords.cz[30] = -1156.6201171875,372.440368652344,69.3967132568359
	daily.coords.cx[31], daily.coords.cy[31], daily.coords.cz[31] = -1015.17376708984,218.781234741211,65.0348663330078
	daily.coords.cx[32], daily.coords.cy[32], daily.coords.cz[32] = -1004.45294189453,124.732749938965,55.6578636169434
	daily.coords.cx[33], daily.coords.cy[33], daily.coords.cz[33] = -897.607421875,99.3576049804688,54.9156227111816
	daily.coords.cx[34], daily.coords.cy[34], daily.coords.cz[34] = -887.100646972656,-41.2655944824219,38.2400054931641
	daily.coords.cx[35], daily.coords.cy[35], daily.coords.cz[35] = -552.524963378906,-780.969421386719,30.6982593536377
	daily.coords.cx[36], daily.coords.cy[36], daily.coords.cz[36] = -789.099731445313,-773.860229492188,27.8723220825195
	daily.coords.cx[37], daily.coords.cy[37], daily.coords.cz[37] = -303.476440429688,-1087.5947265625,30.385066986084
	daily.coords.cx[38], daily.coords.cy[38], daily.coords.cz[38] = 304.965698242188,461.374420166016,142.93147277832
	daily.coords.cx[39], daily.coords.cy[39], daily.coords.cz[39] = 152.631607055664,-266.453460693359,46.3132209777832
	daily.coords.cx[40], daily.coords.cy[40], daily.coords.cz[40] = 106.846817016602,-249.71354675293,47.4159736633301
	daily.coords.cx[41], daily.coords.cy[41], daily.coords.cz[41] = 78.3297348022461,-247.510314941406,48.1881980895996
	daily.coords.cx[42], daily.coords.cy[42], daily.coords.cz[42] = -7.55549907684326,-34.7861785888672,68.9975891113281
	daily.coords.cx[43], daily.coords.cy[43], daily.coords.cz[43] = 291.779205322266,498.020751953125,148.174057006836
	daily.coords.cx[44], daily.coords.cy[44], daily.coords.cz[44] = -59.1110610961914,106.590705871582,81.4988327026367
	daily.coords.cx[45], daily.coords.cy[45], daily.coords.cz[45] = -16.5135955810547,327.158050537109,113.160850524902
	daily.coords.cx[46], daily.coords.cy[46], daily.coords.cz[46] = 510.74951171875,220.847747802734,104.744125366211
	daily.coords.cx[47], daily.coords.cy[47], daily.coords.cz[47] = 301.10009765625,528.569213867188,152.61701965332
	daily.coords.cx[48], daily.coords.cy[48], daily.coords.cz[48] = 156.422988891602,455.139099121094,140.726470947266
	daily.coords.cx[49], daily.coords.cy[49], daily.coords.cz[49] = 107.286636352539,438.130065917969,142.215042114258
	daily.coords.cx[50], daily.coords.cy[50], daily.coords.cz[50] = 29.7740650177002,433.651519775391,142.915161132813
	daily.coords.cx[51], daily.coords.cy[51], daily.coords.cz[51] = 255.622131347656,43.274097442627,88.4741821289063
	daily.coords.cx[52], daily.coords.cy[52], daily.coords.cz[52] = -75.3174514770508,471.676330566406,137.637756347656
	daily.coords.cx[53], daily.coords.cy[53], daily.coords.cz[53] = -110.303680419922,477.961273193359,137.031356811523
	daily.coords.cx[54], daily.coords.cy[54], daily.coords.cz[54] = -175.799423217773,476.318237304688,133.767761230469
	daily.coords.cx[55], daily.coords.cy[55], daily.coords.cz[55] = -244.389114379883,457.448455810547,126.823036193848
	daily.coords.cx[56], daily.coords.cy[56], daily.coords.cz[56] = -1336.69714355469,-926.82763671875,11.7527828216553
	daily.coords.cx[57], daily.coords.cy[57], daily.coords.cz[57] = -276.601531982422,460.2333984375,110.788360595703
	daily.coords.cx[58], daily.coords.cy[58], daily.coords.cz[58] = -1490.43249511719,-682.102905273438,28.3159046173096
	daily.coords.cx[59], daily.coords.cy[59], daily.coords.cz[59] = -1314.8125,-439.642547607422,35.2772674560547
	daily.coords.cx[60], daily.coords.cy[60], daily.coords.cz[60] = -314.761505126953,520.200805664063,120.157096862793
	daily.coords.cx[61], daily.coords.cy[61], daily.coords.cz[61] = -97.7950744628906,956.085754394531,232.808700561523
	daily.coords.cx[62], daily.coords.cy[62], daily.coords.cz[62] = -210.357131958008,984.626037597656,231.537094116211
	daily.coords.cx[63], daily.coords.cy[63], daily.coords.cz[63] = -158.738723754883,866.390441894531,233.010482788086
	daily.coords.cx[64], daily.coords.cy[64], daily.coords.cz[64] = -394.572570800781,475.525054931641,120.193588256836
	daily.coords.cx[65], daily.coords.cy[65], daily.coords.cz[65] = 1419.34240722656,1152.24865722656,114.673942565918
	daily.coords.cx[66], daily.coords.cy[66], daily.coords.cz[66] = -437.207458496094,502.355102539063,119.571662902832
	daily.coords.cx[67], daily.coords.cy[67], daily.coords.cz[67] = -463.696258544922,503.896697998047,121.461494445801
	daily.coords.cx[68], daily.coords.cy[68], daily.coords.cz[68] = -500.706176757813,493.524139404297,107.772003173828
	daily.coords.cx[69], daily.coords.cy[69], daily.coords.cz[69] = 1565.02648925781,3574.251953125,33.5366401672363
	daily.coords.cx[70], daily.coords.cy[70], daily.coords.cz[70] = -531.058837890625,456.836730957031,103.201553344727
	daily.coords.cx[71], daily.coords.cy[71], daily.coords.cz[71] = -178.719573974609,6424.923828125,30.6170845031738
	daily.coords.cx[72], daily.coords.cy[72], daily.coords.cz[72] = -569.805297851563,583.734008789063,115.01634979248
	daily.coords.cx[73], daily.coords.cy[73], daily.coords.cz[73] = -557.953857421875,567.756652832031,112.853759765625
	daily.coords.cx[74], daily.coords.cy[74], daily.coords.cz[74] = -618.055969238281,550.924011230469,112.14421081543
	daily.coords.cx[75], daily.coords.cy[75], daily.coords.cz[75] = -2802.77270507813,1456.18469238281,100.818603515625
	daily.coords.cx[76], daily.coords.cy[76], daily.coords.cz[76] = -655.738708496094,548.187805175781,111.453056335449
	daily.coords.cx[77], daily.coords.cy[77], daily.coords.cz[77] = -2996.90649414063,753.58154296875,26.6873474121094
	daily.coords.cx[78], daily.coords.cy[78], daily.coords.cz[78] = -671.852233886719,530.052795410156,110.77986907959
	daily.coords.cx[79], daily.coords.cy[79], daily.coords.cz[79] = -2955.87084960938,701.185913085938,28.5931587219238
	daily.coords.cx[80], daily.coords.cy[80], daily.coords.cz[80] = -2945.57348632813,642.242736816406,24.1792964935303
	daily.coords.cx[81], daily.coords.cy[81], daily.coords.cz[81] = -755.120727539063,481.256652832031,107.473083496094
	daily.coords.cx[82], daily.coords.cy[82], daily.coords.cz[82] = -3042.42749023438,39.6450157165527,10.1178512573242
	daily.coords.cx[83], daily.coords.cy[83], daily.coords.cz[83] = -651.872802734375,458.988922119141,110.490898132324
	daily.coords.cx[84], daily.coords.cy[84], daily.coords.cz[84] = -702.292358398438,424.937347412109,106.944129943848
	daily.coords.cx[85], daily.coords.cy[85], daily.coords.cz[85] = -2013.12878417969,-290.556732177734,32.0963401794434
	daily.coords.cx[86], daily.coords.cy[86], daily.coords.cz[86] = -792.6884765625,415.536346435547,91.6127853393555
	daily.coords.cx[87], daily.coords.cy[87], daily.coords.cz[87] = -1714.65356445313,-197.835693359375,57.6977310180664
	daily.coords.cx[88], daily.coords.cy[88], daily.coords.cz[88] = -819.223937988281,458.750823974609,90.1694793701172
	daily.veh[1] = GetVehiclePedIsUsing(GetPlayerPed(-1))
	daily.flag[1] = 1
	daily.flag[2] = GetRandomIntInRange(1, 88)
	Wait(2000)
	DrawMissionTextpool("Drive to the area and clean the ~h~~y~Pools~w~.", 10000)
	onJobPool = 1
end

function DrawMissionTextpool(m_text, showtime)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function showLoadingPromtpool(showText, showTime, showType)
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

function ShowInfoJobPool(text, state)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function StopJobPool()
	if daily.blip[1] ~= nil and DoesBlipExist(daily.blip[1]) then
		Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(daily.blip[1]))
		daily.blip[1] = nil
	end
	onJobPool = 0
	clientjobID = 0
	daily.veh[1] = nil
	daily.flag[1] = nil
	daily.flag[2] = nil
end

function StopJobPoolDistance()
	if daily.blip[1] ~= nil and DoesBlipExist(daily.blip[1]) then
		Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(daily.blip[1]))
		daily.blip[1] = nil
	end
	onJobPool = 0
	clientjobID = 45
	daily.veh[1] = nil
	daily.flag[1] = nil
	daily.flag[2] = nil
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if onJobPool == 0 then
			if (clientjobID == 45) then -- JOB pool
				if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					if IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("utillitruck3", _r)) then
					--if IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), 0x58B3979C) then
						TriggerServerEvent("pool:getplayerjob")
						Wait(1000)
						if myjob == 20 then
							StartJobPool(1)
						else
							DrawMissionTextpool("You must be a ~h~~y~Pool Cleaner~w~.",6000)
						end
					end
				end
			end
		elseif onJobPool == 1 then
			if DoesEntityExist(daily.veh[1]) and IsVehicleDriveable(daily.veh[1], 0) then

				if daily.flag[1] == 1 then
					daily.flag[2] = GetRandomIntInRange(1, 88)
					daily.blip[1] = AddBlipForCoord(daily.coords.cx[daily.flag[2]],daily.coords.cy[daily.flag[2]],daily.coords.cz[daily.flag[2]])
					N_0x80ead8e2e1d5d52e(daily.blip[1])
					SetBlipRoute(daily.blip[1], 1)
					distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), daily.coords.cx[daily.flag[2]],daily.coords.cy[daily.flag[2]],daily.coords.cz[daily.flag[2]], true)
					daily.flag[1] = 2
				end
				if daily.flag[1] == 2 then
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), daily.coords.cx[daily.flag[2]],daily.coords.cy[daily.flag[2]],daily.coords.cz[daily.flag[2]], true) > 5.0001 then
						--DrawMarker(1, daily.coords.cx[daily.flag[2]],daily.coords.cy[daily.flag[2]],daily.coords.cz[daily.flag[2]]-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
					else
						local plyCoords = GetEntityCoords(GetPlayerPed(-1))
						if math.abs(plyCoords['z'] - daily.coords.cz[daily.flag[2]]) < 1 then
							if daily.blip[1] ~= nil and DoesBlipExist(daily.blip[1]) then
								Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(daily.blip[1]))
								daily.blip[1] = nil
							end
							if IsPedInAnyVehicle(LocalPed(), true) == false then
								ShowInfoJobPool("Press ~INPUT_CONTEXT~ to ~b~clean~w~ the pool.", 0)
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
									DrawMissionTextpool("~h~You ~g~clean~w~ a swimming pool!", 5000)
									TriggerServerEvent('job:success', distance)
									--TriggerServerEvent('CheckPool')
									Wait(1000)
									daily.flag[1] = 1
									daily.flag[2] = GetRandomIntInRange(1, 88)
								end
							end
						end
					end
				end

				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(daily.veh[1]), true) > 60.00 then

					if clientjobID == 45 then
						StopJobPoolDistance(1)
						DrawMissionTextpool("~r~Return to your vehicle to resume your work!", 6000)
					end
				else

				end

			else
				StopJobPool(1)
				DrawMissionTextpool("Your truck is ~h~~r~out of service~w~.", 5000)
			end
		end
	end

end)

AddEventHandler('playerSpawned', function(spawn)
	ShowpoolBlips(true)
	StopJobPool(1)
	--TriggerServerEvent('pool:getplayerjob')
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
RegisterNetEvent("pool:result")
AddEventHandler("pool:result", function(job)
	myjob = job
end)

RegisterNetEvent("js:playerleft")
AddEventHandler("js:playerleft", function(source)
	StopJobPool(1)
end)

RegisterNetEvent("pool:changedjob")
AddEventHandler("pool:changedjob", function(source)
	if clientjobID == 45 then
		DrawMissionTextpool("You are no longer a ~h~~y~Pool Cleaner~w~.", 6000)
		TriggerClientEvent("mm:otherspawn")
		StopJobPool(1)
	end
end)
local IsGarbage, OnDuty, Help = true, false, false
local garbage_truck = nil
local garbage_job = nil
local garbage_blip = nil
local garbagebag = nil
local completed = 0
Garbage = {
	Data = {
		Service = {
			[1] = vector3(-322.11968994141,-1545.8243408203,31.019908905029),
		},
		Dumpster = {
			[1] = vector3(-337.6367,-2786.992,4.000239),
			[2] = vector3(1050.857,-2391.396,29.28452),
			[3] = vector3(1005.835,-2067.349,30.13629),
			[4] = vector3(957.2108,-1912.296,30.14571),
			[5] = vector3(770.9854,-1902.144,28.26986),
			[6] = vector3(969.3815,-945.3486,41.29815),
			[7] = vector3(776.6561,-1054.236,26.05088),
			[8] = vector3(787.1,-1323.691,25.06788),
			[9] = vector3(1089.071,-449.5304,64.72475),
			[10] = vector3(617.2553,70.19471,89.7544),
			[11] = vector3(560.3558,171.2989,99.2312),
			[12] = vector3(384.0609,238.476,102.0361),
			[13] = vector3(10.20545,4.926725,69.6499),
			[14] = vector3(197.3791,-1092.112,28.2783),
			[15] = vector3(199.9383,-1296.267,28.32153),
			[16] = vector3(272.633,-1499.289,28.2916),
			[17] = vector3(263.7913,-1677.058,28.30527),
			[18] = vector3(224.064,-1836.624,25.95535),
			[19] = vector3(161.0778,-1876.63,22.9732),
			[20] = vector3(41.75639,-1879.637,21.21154),
			[21] = vector3(-28.13282,-1640.856,28.29198),
			[22] = vector3(-171.739,-1459.672,30.68687),
			[23] = vector3(-717.054,-1171.374,9.46338),
			[24] = vector3(-1075.155,-1273.394,4.829365),
			[25] = vector3(-1076.804,-1498.936,4.104791),
			[26] = vector3(-1054.713,-1610.139,3.399037),
			[27] = vector3(-1264.468,-1374.695,3.17067),
			[28] = vector3(-1277.544,-1210.355,3.724486),
			[29] = vector3(-1071.163,-1029.759,1.091357),
			[30] = vector3(-1018.297,-1119.402,1.120266),
			[31] = vector3(-1622.477,-1081.264,12.01845),
			[32] = vector3(-1801.939,-410.1487,43.5813),
			[33] = vector3(-1753.204,-377.5302,44.74607),
			[34] = vector3(-964.1352,-185.0301,36.80095),
			[35] = vector3(-1481.334,59.09226,52.53588),
			[36] = vector3(-1629.261,77.69003,60.94693),
			[37] = vector3(-1892.951,185.2168,81.59013),
			[38] = vector3(-1466.232,518.6081,116.9691),
			[39] = vector3(-1298.72,627.9941,136.7925),
			[40] = vector3(-1256.728,653.576,139.9319),
			[41] = vector3(-1177.898,722.7534,150.6435),
			[42] = vector3(-1111.839,775.9818,161.6958),
			[43] = vector3(-979.8621,694.6163,155.8505),
			[44] = vector3(-680.5673,605.562,142.9354),
			[45] = vector3(-619.3099,682.4254,148.8345),
			[46] = vector3(-509.0829,575.6403,118.847),
			[47] = vector3(-345.6455,429.374,109.4156),
			[48] = vector3(-194.7099,419.3295,108.9558),
			[49] = vector3(-215.4222,276.3777,91.04716),
			[50] = vector3(-468.5767,272.7403,82.26152),
			[51] = vector3(-343.4309,103.5678,65.67259),
			[52] = vector3(-287.9857,-95.30598,46.21479),
			[53] = vector3(-359.5632,-145.9291,37.24692),
			[54] = vector3(-147.5077,-747.1575,32.89324),
			[55] = vector3(-246.4445,-1128.171,22.06822),
			[56] = vector3(-294.119,-1357.757,30.31021),
			[57] = vector3(-894.062,-2750.131,12.94431),
			[58] = vector3(-1052.065,-2086.243,12.34221),
			[59] = vector3(-1148.458,-1987.686,12.16035),
			[60] = vector3(-589.994,-1737.421,21.75804),
			[61] = vector3(-240.9282,-1473.415,30.4771),
			[62] = vector3(-171.5853,-1461.888,30.79383),
		},
		Blips = {},
		Vehicles = {
			Model = "Trash",
			Location = vector3(-333.72787475586,-1530.5367431641,27.547882080078),
			Spawn = vector3(-330.57705688477,-1527.9936523438,27.729866027832),
		},
		Animations = {
			Dictionary = "missfbi4prepp1",
			PickUp = "_bag_pickup_garbage_man",
			Idle = "_idle_garbage_man",
			Throw = "_bag_throw_garbage_man",
		},
	},
}

-- Functions --

function startJob()
	randomizer = math.random(1, #Garbage.Data.Dumpster)
	garbage_job = randomizer
end

local function PlayAnimation(number)
	Citizen.CreateThread(function()
		local dictionary = Garbage.Data.Animations.Dictionary
		RequestAnimDict(dictionary)
		while not HasAnimDictLoaded(dictionary) do
			Citizen.Wait(0)
		end
		if number == 1 then
			TaskPlayAnim(PlayerPedId(), dictionary, Garbage.Data.Animations.PickUp, 8.0, 8.0, 800, 49, 0, false, false, false)
			Citizen.Wait(800)
			TaskPlayAnim(PlayerPedId(), dictionary, Garbage.Data.Animations.Idle, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
		end
		if number == 2 then
			TaskPlayAnim(PlayerPedId(), dictionary, Garbage.Data.Animations.Throw, 8.0, 8.0, 800, 49, 0, false, false, false)
		end
	end)
end

-- Networking Events -- 

RegisterNetEvent("garbage:set")
AddEventHandler("garbage:set", function(_isGarbage)
	OnDuty = false
	IsGarbage = _isGarbage
end)

RegisterNetEvent("garbage:rent")
AddEventHandler("garbage:rent", function()
	Citizen.CreateThread(function()
		local model = Garbage.Data.Vehicles.Model
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		garbage_truck = CreateVehicle(model, Garbage.Data.Vehicles.Spawn.x, Garbage.Data.Vehicles.Spawn.y, Garbage.Data.Vehicles.Spawn.z, 357.81948852539, true, false)
		local plate = "GB"..GetVehicleNumberPlateText(garbage_truck)
		SetVehicleNumberPlateText(garbage_truck, plate)
		SetEntityInvincible(garbage_truck, false)
		SetPedIntoVehicle(Ped, garbage_truck, -1)
		SetModelAsNoLongerNeeded(model)
		DecorSetBool(garbage_truck, "hotwire", true)
		startJob()
	end)
end)

-- Threads --

Citizen.CreateThread(function()
	CreateBlip("Little Pricks Garbage Collection", 318, 18, Garbage.Data.Service[1].x, Garbage.Data.Service[1].y, Garbage.Data.Service[1].z)
	while true do
		Citizen.Wait(0)
		if IsGarbage then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped, false)
			for Index = 1, #Garbage.Data.Service do
				if(Vdist(pos.x, pos.y, pos.z, Garbage.Data.Service[Index].x, Garbage.Data.Service[Index].y, Garbage.Data.Service[Index].z) < 10) then
					DrawMarker(25, Garbage.Data.Service[Index].x, Garbage.Data.Service[Index].y, Garbage.Data.Service[Index].z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
					if Vdist(pos.x, pos.y, pos.z, Garbage.Data.Service[Index].x, Garbage.Data.Service[Index].y, Garbage.Data.Service[Index].z) < 1 then
						if OnDuty then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to sign off duty!")
						else
							DisplayHelpText("Press ~INPUT_CONTEXT~ to sign on duty!")
						end
						if IsControlJustPressed(1, 51) then
							if OnDuty then
								Help = false
							else
								Help = true
							end
							OnDuty = not OnDuty
						end
					end
				end
			end
			if OnDuty then
				if Vdist(pos.x, pos.y, pos.z, Garbage.Data.Vehicles.Location.x, Garbage.Data.Vehicles.Location.y, Garbage.Data.Vehicles.Location.z) < 10 then
					DrawMarker(25, Garbage.Data.Vehicles.Location.x, Garbage.Data.Vehicles.Location.y, Garbage.Data.Vehicles.Location.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
					if Vdist(pos.x, pos.y, pos.z, Garbage.Data.Vehicles.Location.x, Garbage.Data.Vehicles.Location.y, Garbage.Data.Vehicles.Location.z) < 1 then
						if garbage_truck then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to return your Garbage Truck!")
						else
							DisplayHelpText("Press ~INPUT_CONTEXT~ to claim your Garbage Truck!")
						end
						if IsControlJustPressed(1,51) then
							if garbage_truck then
								SetEntityAsMissionEntity(garbage_truck, true, true)
								DeleteVehicle(garbage_truck)
								garbage_truck = nil
								garbage_job = nil
							else
								if tobool(drivers_license) then
									TriggerServerEvent("garbage:rent")
								else
									Notify("You do not have a valid drivers license!", 2500)
								end
							end
						end
					end
				end
				if garbage_job and garbage_truck then
					if IsEntityDead(garbage_truck) then
						garbage_truck = nil
						Notify("The garbage truck was destroyed, go get a new one!", 3000)
						if garbage_blip then
							RemoveBlip(garbage_blip)
							SetBlipRoute(garbage_blip, false)
							garbage_blip = nil
						end
					end
					if not DoesBlipExist(garbage_blip) then
						garbage_blip = AddBlipForCoord(Garbage.Data.Dumpster[garbage_job].x, Garbage.Data.Dumpster[garbage_job].y, Garbage.Data.Dumpster[garbage_job].z)
						SetBlipSprite(garbage_blip, 1)
						SetBlipColour(garbage_blip, 60)
						SetBlipAsShortRange(garbage_blip, true)
						SetBlipScale(garbage_blip, 0.85)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Dumpster")
						EndTextCommandSetBlipName(garbage_blip)
						SetBlipRoute(garbage_blip, true)
					end
					if Vdist(pos.x, pos.y, pos.z, Garbage.Data.Dumpster[garbage_job].x, Garbage.Data.Dumpster[garbage_job].y, Garbage.Data.Dumpster[garbage_job].z) < 10 then
						if Vdist(pos.x, pos.y, pos.z, Garbage.Data.Dumpster[garbage_job].x, Garbage.Data.Dumpster[garbage_job].y, Garbage.Data.Dumpster[garbage_job].z) < 3 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to pick up the trash!")
							if not IsPedInAnyVehicle(ped, false) then
								if IsControlJustPressed(1, 51) then
									local model = GetHashKey("prop_cs_rub_binbag_01")
									RequestModel(model)
									while not HasModelLoaded(model) do
										Citizen.Wait(0)
									end
									PlayAnimation(1)
									Citizen.Wait(800)
									garbagebag = CreateObject(model, Garbage.Data.Dumpster[garbage_job].x, Garbage.Data.Dumpster[garbage_job].y, Garbage.Data.Dumpster[garbage_job].z, true, false, false)
									AttachEntityToEntity(garbagebag, ped, GetPedBoneIndex(ped, 28422), 0.02700003, 0.06399997, 0.3449997, 0.2150002, 2.226021, 0.8569925, true, true, false, true, 1, true)
									Notify("Throw the garbage in the back of the truck!", 1000)
								end
							end
						end
					end
					if DoesEntityExist(garbagebag) then
						local coords = vector3(GetEntityCoords(garbage_truck, false))
						local distance = vector3(coords + (GetEntityForwardVector(garbage_truck) * -6.1125))
						if Vdist(pos.x, pos.y, pos.z, distance.x, distance.y, distance.z) < 2 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to throw trash into the back!")
							if IsControlJustPressed(1, 51) then
								PlayAnimation(2)
								Citizen.Wait(1000)
								DestroyObject(garbagebag)
								completed = completed + 1
								TriggerServerEvent('garbage:success', 100)
							end
						end
					end
					if completed == 3 then
						startJob()
						RemoveBlip(garbage_blip)
						SetBlipRoute(garbage_blip, false)
						garbage_blip = nil
						completed = 0
					end
				else
					if garbage_blip then
						RemoveBlip(garbage_blip)
						SetBlipRoute(garbage_blip, false)
						garbage_blip = nil
					end
				end
			end
		end
	end
end)
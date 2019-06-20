--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
function initFuelRandom(drf_veh)
  local randomFuel = math.random(60000,99000)
  DecorRegister("_Fuel_Level", 3);
  DecorSetInt(drf_veh, "_Fuel_Level", randomFuel)
  --Citizen.Trace("fuel level set")
  --Citizen.Trace(randomFuel)
end

function fuelCheckEmpty(drf_veh)
  local currentFuel = DecorGetInt(drf_veh, "_Fuel_Level")
  local veh = drf_veh
  if currentFuel < 1 then
	SetVehicleEngineOn(veh, false, true, false) --engine instant off
	SetVehicleUndriveable(veh, true) --not driveable
  end
end

function burnFuel(drf_veh)
  if engineon then
	local currentFuel = DecorGetInt(drf_veh, "_Fuel_Level")
	--Citizen.Trace(currentFuel)
	local speed = GetEntitySpeed(drf_veh)
	local speedMph = math.ceil(speed * 2.236936)
	--Citizen.Trace(speedMph)
	if speedMph < 5 then
	  burnRate = 5
	elseif speedMph >80 then
	  burnRate = (speedMph * 2)
	elseif speedMph >60 then
	  burnRate = math.ceil(speedMph * 1.5)
	else
	  burnRate = speedMph
	end
	local afterFuelBurn = (currentFuel - burnRate)
	DecorSetInt(drf_veh, "_Fuel_Level", afterFuelBurn)
  end
end

Citizen.CreateThread(function()
  while true do
	local playerPed = GetPlayerPed(-1)
	if playerPed then
	  local veh = GetVehiclePedIsIn(playerPed, false)
	  drf_veh = veh
	  --Citizen.Trace("veh detected")
	  if drf_veh and GetPedInVehicleSeat(drf_veh, -1) == playerPed then
		if not DecorExistOn(drf_veh, "_Fuel_Level") then
		  initFuelRandom(drf_veh)
		  --Citizen.Trace("veh fuel init")
		else
		  burnFuel(drf_veh)
		  --Citizen.Trace("veh fuel burned")
		end
	  end
	end
	fuelCheckEmpty(drf_veh)
	Wait(1000)
  end
end)

local refilling = false
engineon = true
RegisterNetEvent('fuel:stopEngineaddFuel')
AddEventHandler('fuel:stopEngineaddFuel', function(source)
	local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	SetVehicleEngineOn(veh,false,true,true)
	SetVehicleUndriveable(veh, true)
	SetHornEnabled(veh, false)
	refilling = true
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if refilling then
			local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			local currentFuel = DecorGetInt(veh, "_Fuel_Level")
			local add = currentFuel + 200
			DecorSetInt(veh, "_Fuel_Level", tonumber(add))
			if DecorGetInt(veh, "_Fuel_Level") == 100000 then
				refilling = false
				hold = false
				TriggerEvent('fuel:stopFuelbeingAdded')
			elseif DecorGetInt(veh, "_Fuel_Level") > 100000 then
				refilling = false
				hold = false
				DecorSetInt(veh, "_Fuel_Level", 100000)
				TriggerEvent('fuel:stopFuelbeingAdded')
			end
		end
	end
end)

RegisterNetEvent('fuel:stopFuelbeingAdded')
AddEventHandler('fuel:stopFuelbeingAdded', function(source)
	refilling = false
end)

RegisterNetEvent('fuel:enableEngine')
AddEventHandler('fuel:enableEngine', function(source)
	local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	SetVehicleEngineOn(veh,true,true,true)
	SetVehicleUndriveable(veh, false) --driveable
	SetHornEnabled(veh, true)
end)

RegisterNetEvent('fuel:removeFuel')
AddEventHandler('fuel:removeFuel', function(veh,nfuel)
	Citizen.Trace("Fuel removed")
	DecorSetInt(veh, "_Fuel_Level", tonumber(nfuel))
end)

fuelLocations = {
{49.49921,  2778.912,  58.04399},
{263.1732,  2606.515,  44.98524},
{265.0739,  2606.9,    44.98524},
{1043.286,  2668.316,  39.6953},
{1035.779,  2667.884,  39.59842},
{1035.363,  2674.146,  39.6953},
{1043.228,  2674.727,  39.69259},
{1208.803,  2659.41,   38.29295},
{1209.382,  2658.55,   38.29296},
{1206.164,  2662.243,  38.29296},
{2540.046,  2594.93,   37.94114},
{2680.892,  3266.344,  55.15651},
{2678.446,  3262.312,  55.15682},
{2009.208,  3776.832,  32.14758},
{2006.241,  3775.01,   32.15149},
{2003.921,  3773.584,  32.14502},
{2001.484,  3772.196,  32.1467},
{1684.636,  4931.696,  41.92953},
{1690.169,  4927.816,  41.91949},
{1701.729,  6416.423,  32.9883},
{1697.702,  6418.276,  32.39661},
{1705.75,   6414.476,  32.47131},
{172.1167,  6603.46,   31.76759},
{179.7492,  6604.962,  31.75048},
{187.0439,  6606.254,  31.75101},
{-97.03368, 6416.826,  31.3868},
{-91.31594, 6422.506,  31.34267},
{-2551.421, 2327.216,  33.01744},
{-2558.018, 2327.195,  33.07804},
{-2558.608, 2334.411,  32.96354},
{-2552.72,  2334.706,  32.97265},
{-2552.41,  2341.949,  33.0052},
{-2558.843, 2340.989,  33.01099},
{-1796.294, 811.6018,  138.5058},
{-1790.871, 806.3741,  138.2029},
{-1797.151, 800.7207,  138.3891},
{-1802.28,  806.3079,  138.3751},
{-1808.657, 799.9904,  138.427},
{-1803.637, 794.5114,  138.4097},
{-1444.34,  -274.1886, 46.11931},
{-1435.39,  -284.6255, 46.12236},
{-1428.981, -278.9675, 46.10809},
{-1438.003, -268.3987, 46.07535},
{-2089.24,  -327.3728, 13.02895},
{-2088.456, -320.8316, 12.97422},
{-2087.033, -312.7974, 12.90649},
{-2095.933, -311.9274, 12.90725},
{-2096.466, -320.4183, 13.02885},
{-2097.336, -326.3977, 12.88916},
{-2105.951, -325.589,  12.93521},
{-2105.103, -319.0184, 12.8779},
{-2104.42,  -311.009,  12.93345},
{-715.0432, -932.5638, 19.07506},
{-715.4774, -939.2256, 19.35049},
{-723.86,   -939.2936, 18.86283},
{-723.7555, -932.4474, 19.40245},
{-732.3931, -932.5628, 19.41346},
{-732.47,   -939.5462, 18.94506},
{-518.4993, -1209.443, 18.07783},
{-521.2747, -1208.402, 18.06198},
{-526.1282, -1206.402, 18.06817},
{-528.546,  -1204.938, 18.08993},
{-532.3412, -1212.774, 18.07594},
{-529.4606, -1213.783, 18.07589},
{-524.9258, -1216.442, 18.03981},
{-522.1807, -1217.371, 18.07601},
{-63.78423, -1767.807, 29.58496},
{-61.21217, -1760.783, 29.57397},
{-69.46559, -1758.157, 29.25509},
{-72.02878, -1765.13,  29.23874},
{-80.31097, -1762.165, 29.50828},
{-77.66983, -1755.077, 29.52769},
{273.8892,  -1268.606, 29.50896},
{273.9102,  -1261.341, 29.45841},
{273.9552,  -1253.555, 29.00463},
{265.0881,  -1253.459, 29.53489},
{264.5976,  -1261.261, 29.44312},
{265.1926,  -1268.503, 29.06948},
{256.4616,  -1268.626, 29.55151},
{256.5174,  -1261.287, 28.94805},
{256.4725,  -1253.449, 29.55769},
{826.7513,  -1026.165, 26.35728},
{826.7982,  -1030.967, 26.42957},
{819.1411,  -1030.997, 26.22982},
{819.1501,  -1026.369, 26.18121},
{810.8204,  -1026.367, 26.15119},
{810.869,   -1031.196, 26.1582},
{1210.227,  -1407.065, 35.11445},
{1213.007,  -1404.079, 35.09584},
{1207.081,  -1398.296, 35.15728},
{1204.209,  -1401.101, 35.13186},
{1186.456,  -338.1484, 69.52541},
{1179.055,  -339.3943, 69.68567},
{1177.467,  -331.1775, 68.97179},
{1184.804,  -329.9716, 69.48991},
{1183.224,  -321.369,  69.19594},
{1175.643,  -322.2696, 68.98219},
{629.5554,  263.8569,  103.0224},
{629.3791,  273.9546,  102.9987},
{620.7898,  273.8886,  102.9988},
{612.3482,  274.0847,  103.0043},
{612.2713,  263.8885,  102.9918},
{620.9271,  263.8311,  103.0251},
{2588.463,  358.539,   108.3958},
{2589.129,  363.9044,  108.3995},
{2581.266,  364.2455,  108.3998},
{2581.088,  358.8944,  108.3724},
{2573.717,  359.0278,  108.3615},
{2573.844,  364.6972,  108.3958},
{1785.895,  3330.168,  41.34562},
{1785.145,  3331.252,  41.38123}
}

function fuelPumpNear(pveh)
  pumpNear = false
  for k,v in pairs(fuelLocations) do
	local x1,y1,z1 = table.unpack(v)
	local x2,y2,z2 = table.unpack(GetEntityCoords(pveh,true))
	local distanceToPump = GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, false)
	if distanceToPump < 5 then
		pumpNear = true
	end
  end
  if pumpNear then
	return true
  else
	return false
  end
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
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

gasblips = {
	{name="Gas Station", sprite=361, colour = 1, x=49.4187,   y=2778.793,  z=58.043},
	{name="Gas Station", sprite=361, colour = 1, x=263.894,   y=2606.463,  z=44.983},
	{name="Gas Station", sprite=361, colour = 1, x=1039.958,  y=2671.134,  z=39.550},
	{name="Gas Station", sprite=361, colour = 1, x=1207.260,  y=2660.175,  z=37.899},
	{name="Gas Station", sprite=361, colour = 1, x=2539.685,  y=2594.192,  z=37.944},
	{name="Gas Station", sprite=361, colour = 1, x=2679.858,  y=3263.946,  z=55.240},
	{name="Gas Station", sprite=361, colour = 1, x=2005.055,  y=3773.887,  z=32.403},
	{name="Gas Station", sprite=361, colour = 1, x=1687.156,  y=4929.392,  z=42.078},
	{name="Gas Station", sprite=361, colour = 1, x=1701.314,  y=6416.028,  z=32.763},
	{name="Gas Station", sprite=361, colour = 1, x=179.857,   y=6602.839,  z=31.868},
	{name="Gas Station", sprite=361, colour = 1, x=-94.4619,  y=6419.594,  z=31.489},
	{name="Gas Station", sprite=361, colour = 1, x=-2554.996, y=2334.40,  z=33.078},
	{name="Gas Station", sprite=361, colour = 1, x=-1800.375, y=803.661,  z=138.651},
	{name="Gas Station", sprite=361, colour = 1, x=-1437.622, y=-276.747,  z=46.207},
	{name="Gas Station", sprite=361, colour = 1, x=-2096.243, y=-320.286,  z=13.168},
	{name="Gas Station", sprite=361, colour = 1, x=-724.619, y=-935.1631,  z=19.213},
	{name="Gas Station", sprite=361, colour = 1, x=-526.019, y=-1211.003,  z=18.184},
	{name="Gas Station", sprite=361, colour = 1, x=-70.2148, y=-1761.792,  z=29.534},
	{name="Gas Station", sprite=361, colour = 1, x=265.648,  y=-1261.309,  z=29.292},
	{name="Gas Station", sprite=361, colour = 1, x=819.653,  y=-1028.846,  z=26.403},
	{name="Gas Station", sprite=361, colour = 1, x=1208.951, y= -1402.567, z=35.224},
	{name="Gas Station", sprite=361, colour = 1, x=1181.381, y= -330.847,  z=69.316},
	{name="Gas Station", sprite=361, colour = 1, x=620.843,  y= 269.100,  z=103.089},
	{name="Gas Station", sprite=361, colour = 1, x=2581.321, y=362.039, z=108.468},
}
local hold = false
local pfuelcount = 0
Citizen.CreateThread(function()
	for k,v in pairs(gasblips) do
	  addBlip(v)
	end
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
			local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			local playerPed = GetPlayerPed(-1)
			if(fuelPumpNear(veh)) then
				if veh and GetPedInVehicleSeat(veh, -1) == playerPed then
					local fuelcount = DecorGetInt(veh, "_Fuel_Level")
					--drawTxt("Current Fuel: "..fuelcount,0,1,0.5,0.75,0.6,255,255,255,255)
					if IsControlJustReleased(1, 51) then
						engineon = true
						hold = false
						TriggerEvent('fuel:stopFuelbeingAdded')
						TriggerEvent('fuel:enableEngine')
						if fuelcount > pfuelcount and pfuelcount ~= 0 then
							Citizen.Trace("Vehicle: "..veh.." BeforeRefuel: "..pfuelcount.." After refuel: "..fuelcount)
							TriggerServerEvent('fuel:pay', veh, pfuelcount, fuelcount)
						end
					end
					if fuelcount < 100000 then
						if not hold then
							drawTxt("Hold ~g~E~w~ to refuel!",6,1,0.5,0.8,0.6,255,255,255,255)
						end
						if IsControlJustPressed(1, 51) then
							engineon = false
							hold = true
							pfuelcount = DecorGetInt(veh, "_Fuel_Level")
							TriggerEvent('fuel:stopEngineaddFuel')
						end
						if hold then
							drawTxt("~g~Refueling...",6,1,0.5,0.8,0.6,255,255,255,255)
						end
					else
						drawTxt("~r~Tank is full!",6,1,0.5,0.8,0.6,255,255,255,255)
					end
				end
			else
				engineon = true
				hold = false
			end
		end
	end
end)
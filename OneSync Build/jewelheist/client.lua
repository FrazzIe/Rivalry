--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local RobbedCaseTable = {false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false}
local smashVariations = {"smash_case_b", "smash_case", "smash_case_tray_b", "smash_case_tray_a", "fp_smash_case_d", "smash_case_necklace", "fp_smash_case_tray_b", "fp_smash_case_tray_a", "smash_case_f", "smash_case_e", "smash_case_d", "fp_smash_case_e", "smash_case_c", "fp_smash_case_necklace"}
local robbers = {
	{ID=0, current_capacity=0, capacity=100,leader=false},
	{ID=0, current_capacity=0, capacity=100,leader=false},
	{ID=0, current_capacity=0, capacity=100,leader=false},
	{ID=0, current_capacity=0, capacity=100,leader=false},
}
local jewelryCases = {
	{-626.723205566406,-238.476425170898,38.0570297241211, 213.388565063477},
	{-625.736755371094,-237.790115356445,38.0570297241211, 211.764266967773},
	{-626.828979492188,-235.452087402344,38.0570297241211, 29.5053939819336},
	{-625.773315429688,-234.694534301758,38.0570297241211, 31.6770801544189},
	{-626.931945800781,-233.052383422852,38.0570297241211, 211.779754638672},
	{-627.981567382813,-233.814849853516,38.0570297241211, 208.080093383789},
	{-624.516052246094,-231.095855712891,38.0570297241211, 300.710815429688},
	{-624.046264648438,-228.107147216797,38.0570297241211, 213.283203125},
	{-620.985900878906,-228.528289794922,38.0570297241211, 121.893600463867},
	{-619.63037109375,-230.397644042969,38.0570297241211, 123.570205688477},
	{-620.066650390625,-233.38737487793,38.0570297241211, 37.5486297607422},
	{-623.174743652344,-232.946990966797,38.0570297241211, 299.057556152344},
	{-624.977294921875,-227.949020385742,38.0570297241211, 31.3687305450439},
	{-623.833923339844,-227.111999511719,38.0570297241211, 33.231071472168},
	{-620.517944335938,-226.569366455078,38.0569839477539, 301.749877929688},
	{-619.716918945313,-227.691833496094,38.0569953918457, 301.633514404297},
	{-618.377868652344,-229.529678344727,38.0570106506348, 302.269439697266},
	{-617.534912109375,-230.569931030273,38.0570106506348, 304.598083496094},
	{-619.251342773438,-233.650253295898,38.0903091430664, 214.646026611328},
	{-620.246215820313,-234.367828369141,38.0570526123047, 209.349624633789},
}
local jewelryVehicles = {
	{x=2808.6450195313, y=-729.73773193359, z=4.165789604187, h=286.25817871094, capacity=160, model=GetHashKey("GBURRITO2")},
	{x=2805.7319335938, y=-720.81597900391, z=4.913179397583, h=203.75129699707, capacity=80, model=GetHashKey("OMNIS")},
	{x=2808.6403808594, y=-708.66461181641, z=2.6693477630615, h=312.3987121582, capacity=80, model=GetHashKey("OMNIS")},
	{x=2811.8142089844, y=-714.21655273438, z=2.6319415569305, h=305.42797851563, capacity=160, model=GetHashKey("GBURRITO2")},
}
local jewelryTrucks = {
	{x=425.43966674805, y=6538.810546875, z=27.728923797607, h=349.30358886719, model=GetHashKey("phantom")},
	{x=131.65698242188, y=6374.509765625, z=31.260181427002, h=38.558502197266, model=GetHashKey("phantom")},
	{x=-35.629768371582, y=6301.9916992188, z=31.295791625977, h=34.729797363281, model=GetHashKey("phantom")},
	{x=-293.07376098633, y=6046.2373046875, z=31.500318527222, h=46.995803833008, model=GetHashKey("phantom")},
}
local jewelryTrailers = {
	{x=423.42074584961, y=6529.69921875, z=27.590534210205, h=358.09677124023, model=GetHashKey("trailers3")},
	{x=141.40232849121, y=6358.1103515625, z=31.378046035767, h=27.652439117432, model=GetHashKey("trailers3")},
	{x=-25.493825912476, y=6284.80078125, z=31.235088348389, h=33.509170532227, model=GetHashKey("trailers3")},
	{x=-280.21960449219, y=6033.7138671875, z=31.51096534729, h=42.575710296631, model=GetHashKey("trailers3")},
}
local jewelryPeds = {
	{
		spawn = {x=-1146.5457763672, y=4940.578125, z=222.2686920166, h=185.34864807129},
		marker = {x=-1146.7856445313, y=4939.6206054688, z=222.2686920166},
	},
	{
		spawn = {x=-1144.2077636719, y=4908.3134765625, z=220.96881103516, h=34.856430053711},
		marker = {x=-1144.8165283203, y=4909.1987304688, z=220.96881103516},
	},
	{
		spawn = {x=-1124.0466308594, y=4893.046875, z=218.47244262695, h=25.439281463623},
		marker = {x=-1124.5030517578, y=4894.0595703125, z=218.47244262695},
	},
	{
		spawn = {x=-1139.4527587891, y=4964.9096679688, z=222.24354553223, h=242.46705627441},
		marker = {x=-1138.0848388672, y=4964.4389648438, z=221.89492797852},
	},
}
local startPosition = {x=-605.00823974609, y=-292.15463256836, z=36.779251098633}
local jewelryStoreLoc = {x=-636.54217529297, y=-241.42794799805, z=38.10795211792}
local jewelryVehicleLocation = {x=2802.1557617188, y=-701.41668701172, z=3.1743474006653}
local guardLocations = {
	{-633.647705078125,-235.848876953125,38.0027046203613, 122.656997680664},
	{-630.460632324219,-240.16796875,38.1455039978027, 124.390579223633},
	{-642.317138671875,-243.94026184082,38.1150398254395, 307.016418457031},
	{-644.884033203125,-228.973724365234,37.7559471130371, 201.918518066406},
	{-627.749145507813,-239.48030090332,38.0570487976074, 347.970001220703},
	{-632.200622558594,-233.718368530273,38.0570335388184, 261.997406005859},
	{-629.279479980469,-230.999938964844,38.0570602416992, 215.326080322266},
	{-623.356567382813,-236.831771850586,38.057056427002, 35.4523162841797},
	{-616.52734375,-231.113388061523,38.0570335388184, 119.89949798584},
	{-618.628784179688,-228.143768310547,38.0570068359375, 123.552253723145},
	{-620.480834960938,-225.434478759766,38.0569229125977, 121.213081359863},
	{-624.629272460938,-224.811477661133,38.0570411682129, 216.187088012695},
	{-626.840637207031,-226.823867797852,38.0570411682129, 215.811325073242},
	{-631.486877441406,-235.29768371582,38.0570411682129, 305.773010253906},
	{-629.277404785156,-238.33757019043,38.0570411682129, 306.534118652344},
	{-620.872192382813,-232.232894897461,38.0570411682129, 203.177703857422},
	{-623.132751464844,-229.215972900391,38.0570411682129, 37.6335678100586},
	{-623.290771484375,-230.486175537109,38.0570411682129, 126.041763305664},
	{-636.234069824219,-252.107879638672,38.5097732543945, 300.040740966797},
	{-629.832458496094,-249.324356079102,38.4511260986328, 297.468170166016},
}
local allGuards = {}
local guardLocationSelections = {}
local guardCount = 10
local guardCountVariation = 0
local guardsHostile = false
local gangLocations = {
	{x=2804.4765625, y=-726.63238525391, z=4.7397704124451},
	{x=2809.2443847656, y=-720.9580078125, z=4.6262221336365},
	{x=2822.75390625, y=-727.20526123047, z=2.4888536930084},
	{x=2823.1394042969, y=-750.65869140625, z=1.9665384292603},
	{x=2823.4926757813, y=-737.19213867188, z=1.9347159862518},
	{x=2819.3937988281, y=-710.71228027344, z=2.4060459136963},
	{x=2811.5424804688, y=-697.4248046875, z=2.1440436840057},
	{x=2796.09765625, y=-692.34875488281, z=4.0166025161743},
	{x=2805.6293945313, y=-686.60083007813, z=3.9385402202606},
	{x=2829.6767578125, y=-695.32330322266, z=1.6202857494354},
	{x=2784.5004882813, y=-731.57672119141, z=6.8211164474487},
	{x=2769.1997070313, y=-733.84020996094, z=9.0486249923706},
	{x=2829.6042480469, y=-749.09851074219, z=17.153100967407},
	{x=2825.29296875, y=-746.60949707031, z=17.438066482544},
	{x=2827.6687011719, y=-744.51989746094, z=17.410869598389},
	{x=2797.9436035156, y=-696.00067138672, z=3.3479182720184},
	{x=2803.0642089844, y=-695.87762451172, z=2.8628137111664},
	{x=2807.4919433594, y=-695.361328125, z=2.3797845840454},
	{x=2811.7055664063, y=-695.17321777344, z=2.0504415035248},
	{x=2814.4689941406, y=-712.10516357422, z=2.5194931030273},
}
local gangLocationSelections = {}
local allGangs = {}
local gangModels = {
	"g_m_y_mexgoon_01",
	"g_m_y_mexgoon_02",
	"g_m_y_mexgoon_03",
}
local gangWeapons = {
	"WEAPON_PISTOL",
	"WEAPON_SMG",
	"WEAPON_COMBATMG",
}
local gangCount = 10
local gangCountVariation = 0

local robber_vehicles = {}
local robber_trucks = {}
local Heistleader = nil

local guardGroup
local gangGroup
local heistGroup

local PartOne = false
local PartTwo = false
local PartThree = false
local TruckEnding = false

local HeistVehicle = nil
local HeistTruck = nil
local HeistTrailer = nil
local HeistTruckDriver = nil

local HeistActive = false

local cityCameras = {
	{784.353088378906,-1005.27600097656,25.6527767181396, 94.677604675293},
	{223.694885253906,-1040.59167480469,28.8767967224121, 62.378173828125},
	{-37.257999420166,-943.666259765625,28.928653717041, 71.5499725341797},
	{-504.138824462891,-837.026916503906,29.9943675994873, 89.5957336425781},
	{-742.892700195313,-836.920288085938,22.2205505371094, 87.85888671875},
	{-1078.59790039063,-765.257751464844,18.860387802124, 37.3000144958496},
	{-1225.94445800781,-592.38623046875,26.7952575683594, 51.7979583740234},
	{-1384.16345214844,-391.589965820313,36.2012634277344, 47.5407524108887},
	{-1496.93139648438,-256.789672851563,49.8842353820801, 56.1923370361328},
	{-1566.62377929688,-178.044647216797,55.0403366088867, 40.225212097168},
	{-1469.84851074219,-103.59375,50.3908653259277, 311.701080322266},
	{-1303.43920898438,-343.979644775391,36.2439155578613, 224.096725463867},
	{-1649.34875488281,-578.279174804688,33.2079086303711, 152.670822143555},
	{-1290.49780273438,-912.126770019531,10.9101800918579, 212.981857299805},
	{-1157.18151855469,-1341.07604980469,4.62396478652954, 178.635162353516},
	{-771.457092285156,-1117.79272460938,10.2161588668823, 354.948516845703},
	{-638.809753417969,-957.388366699219,21.0177593231201, 1.60537207126617},
	{-651.909790039063,-1460.0234375,10.175742149353, 186.596725463867},
	{-1081.83386230469,264.307189941406,63.4517440795898, 79.2034530639648},
	{-884.664916992188,-116.859001159668,37.4720001220703, 213.356170654297},
	{-1032.13598632813,-192.253219604492,37.3590049743652, 118.607238769531},
	{-635.456359863281,-365.076293945313,34.3290634155273, 260.012878417969},
	{-556.828918457031,3.19479846954346,43.8862419128418, 347.794281005859},
	{-541.363098144531,255.761779785156,82.5815200805664, 15.7118864059448},
	{-222.882278442383,260.049621582031,91.5894165039063, 273.848571777344},
	{-254.890548706055,-45.5543975830078,49.057689666748, 178.222274780273},
	{228.815444946289,-220.215866088867,53.546875, 255.453125},
	{396.671081542969,-128.753219604492,64.4407653808594, 263.298278808594},
	{466.123596191406,-313.610748291016,46.8073959350586, 257.831970214844},
	{960.9775390625,-286.622009277344,66.4887008666992, 309.426361083984},
	{1020.84210205078,-200.687530517578,69.7568588256836, 313.175689697266},
	{1179.66479492188,-509.921142578125,64.6276245117188, 172.003128051758},
	{1256.18041992188,-1429.07556152344,34.613582611084, 201.156631469727},
	{1241.98852539063,-2055.25659179688,43.8659820556641, 124.925071716309},
	{338.719635009766,-1327.09643554688,32.3778114318848, 319.042724609375},
	{-385.195098876953,-1829.35131835938,21.1903018951416, 228.772369384766},
	{795.37890625,-1430.67834472656,26.7072448730469, 181.318115234375},
	{827.118347167969,-1746.89978027344,28.986083984375, 187.324844360352},
	{539.697814941406,-1431.99462890625,28.8534927368164, 94.0945663452148},
	{-272.573883056641,-1140.73986816406,22.4451522827148, 87.3228149414063},
	{-184.222839355469,-894.624572753906,28.6998157501221, 326.385803222656},
	{-117.894187927246,-712.510620117188,34.1800765991211, 338.447174072266}
}

function RequestAndDelete(entity, detach)
    if DoesEntityExist(entity) then
        NetworkRequestControlOfEntity(entity)
        while not NetworkHasControlOfEntity(entity) do
            Citizen.Wait(1)
        end
        if detach then
            DetachEntity(entity, 0, false)
        end
        SetEntityHealth(entity, 0)
        SetEntityCollision(entity, false, false)
        SetEntityAlpha(entity, 0.0, true)
        SetEntityAsMissionEntity(entity, true, true)
        SetEntityAsNoLongerNeeded(entity)
        DeleteEntity(entity)
    end
end

function addBlip()
	Citizen.CreateThread(function()
		ablip = AddBlipForCoord(startPosition.x, startPosition.y, startPosition.z)
		SetBlipSprite(ablip, 304)
		SetBlipScale(ablip, 0.8)
		SetBlipAsShortRange(ablip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Jewelry Heist")
		EndTextCommandSetBlipName(ablip)
	end)
end

addBlip()

function getGuardSpawnCoords()
	local ready = false
	local index = -1
	while not ready do
		index = GetRandomIntInRange(1, #guardLocations)

		local indexFound = false
		for i=1,#guardLocationSelections do
			if index == guardLocationSelections[i] then
				indexFound = true
			end
		end

		if not indexFound then
			guardLocationSelections[#guardLocationSelections+1] = indexFound
			ready = true
		end
	end
	return guardLocations[index]
end

function createSecurityGuard()
	Citizen.CreateThread(function()
		local guardSpawnLocation = getGuardSpawnCoords()

		local hash = GetHashKey("u_m_m_jewelsec_01")
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Citizen.Wait(1)
		end
		local guard = CreatePed(4, hash, guardSpawnLocation[1], guardSpawnLocation[2], guardSpawnLocation[3], guardSpawnLocation[4], true, false)
		while not DoesEntityExist(guard) do
			Citizen.Wait(1)
		end
		NetworkRegisterEntityAsNetworked(guard)		
		local id = NetworkGetNetworkIdFromEntity(guard)
		SetNetworkIdCanMigrate(id, true)
		SetNetworkIdExistsOnAllMachines(id, true)
		SetPedAsGroupMember(guard, guardGroup)
		SetPedCanSwitchWeapon(guard,  true)
		GiveWeaponToPed(guard, GetHashKey("WEAPON_PISTOL"), 500, true, true)
		SetPedRelationshipGroupHash(guard, GetHashKey("SECURITY_GUARD"))
		SetPedArmour(guard, 100)
		SetPedDropsWeaponsWhenDead(guard, false)
		SetEntityInvincible(guard, false)
		SetEntityVisible(guard, true, 0)
		allGuards[#allGuards+1] = guard
	end)
end

function createGuards()
	for i = 1, guardCount + GetRandomIntInRange(1, guardCountVariation) do
		createSecurityGuard()
	end
end

function getGangSpawnCoords()
	local ready = false
	local index = -1
	while not ready do
		index = GetRandomIntInRange(1, #gangLocations)

		local indexFound = false
		for i=1,#gangLocationSelections do
			if index == gangLocationSelections[i] then
				indexFound = true
			end
		end

		if not indexFound then
			gangLocationSelections[#gangLocationSelections+1] = indexFound
			ready = true
		end
	end
	return gangLocations[index]
end

function createGangMember()
	Citizen.CreateThread(function()
		local gangSpawnLocation = getGangSpawnCoords()
		local hash = GetHashKey(gangModels[GetRandomIntInRange(1, 3)])
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Citizen.Wait(1)
		end
		local gang = CreatePed(4, hash, gangSpawnLocation.x, gangSpawnLocation.y, gangSpawnLocation.z, 90.0, true, false)
		while not DoesEntityExist(gang) do
			Citizen.Wait(1)
		end
		NetworkRegisterEntityAsNetworked(gang)
		local id = NetworkGetNetworkIdFromEntity(gang)
		SetNetworkIdCanMigrate(id, true)
		SetNetworkIdExistsOnAllMachines(id, true)
		SetPedAsGroupMember(gang, gangGroup)
		SetPedCanSwitchWeapon(gang,  true)
		GiveWeaponToPed(gang, GetHashKey(gangWeapons[GetRandomIntInRange(1, 3)]), 500, true, true)
		SetPedRelationshipGroupHash(gang, GetHashKey("AMBIENT_GANG_MEXICAN"))
		SetPedArmour(gang, 100)
		SetPedDropsWeaponsWhenDead(gang, false)
		SetEntityInvincible(gang, false)
		SetEntityVisible(gang, true, 0)
		allGangs[#allGangs+1] = gang
	end)
end

function createGang()
	for i = 1, gangCount + GetRandomIntInRange(1, gangCountVariation) do
		createGangMember()
	end
end

function createDriver()
	local hash = GetHashKey(gangModels[GetRandomIntInRange(1, 3)])
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		Citizen.Wait(1)
	end
	HeistTruckDriver = CreatePedInsideVehicle(HeistTruck, 4, hash, -1, true, true)
	while not DoesEntityExist(HeistTruckDriver) do
		Citizen.Wait(1)
	end
	NetworkRegisterEntityAsNetworked(HeistTruckDriver)
	local id = NetworkGetNetworkIdFromEntity(HeistTruckDriver)
	SetNetworkIdCanMigrate(id, true)
	SetNetworkIdExistsOnAllMachines(id, true)
	AddArmourToPed(HeistTruckDriver, 100)
	SetPedAlertness(HeistTruckDriver, 0)
	SetPedAccuracy(HeistTruckDriver, 100)
	SetPedCanSwitchWeapon(HeistTruckDriver, true)
	SetEntityHealth(HeistTruckDriver,  400)
	SetPedFleeAttributes(HeistTruckDriver, 0, 0)
	SetPedCombatAttributes(HeistTruckDriver, 1, true)
	SetPedCombatAttributes(HeistTruckDriver, 2, true)
	SetPedCombatAbility(HeistTruckDriver,  2)
	SetPedCombatRange(HeistTruckDriver, 1)
	SetPedPathAvoidFire(HeistTruckDriver,  1)
	SetPedPathPreferToAvoidWater(HeistTruckDriver, 1)
	GiveWeaponToPed(HeistTruckDriver, GetHashKey("WEAPON_SMG"), 5000, true, true)
	SetPedDropsWeaponsWhenDead(HeistTruckDriver, false)
end

function createTrader()
	local playerID = getYourId()
	local hash = GetHashKey(gangModels[GetRandomIntInRange(1, 3)])
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		Citizen.Wait(1)
	end
	local HeistTrader = CreatePed(4, hash, jewelryPeds[playerID].spawn.x, jewelryPeds[playerID].spawn.y, jewelryPeds[playerID].spawn.z, jewelryPeds[playerID].spawn.h, true, false)
	while not DoesEntityExist(HeistTrader) do
		Citizen.Wait(1)
	end
	NetworkRegisterEntityAsNetworked(HeistTrader)
	local id = NetworkGetNetworkIdFromEntity(HeistTrader)
	SetNetworkIdCanMigrate(id, true)
	SetNetworkIdExistsOnAllMachines(id, true)
	AddArmourToPed(HeistTrader, 100)
	SetPedAlertness(HeistTrader, 0)
	SetPedAccuracy(HeistTrader, 100)
	SetPedCanSwitchWeapon(HeistTrader, true)
	SetEntityHealth(HeistTrader,  400)
	SetPedFleeAttributes(HeistTrader, 0, 0)
	SetPedCombatAttributes(HeistTrader, 1, true)
	SetPedCombatAttributes(HeistTrader, 2, true)
	SetPedCombatAbility(HeistTrader,  2)
	SetPedCombatRange(HeistTrader, 1)
	SetPedPathAvoidFire(HeistTrader,  1)
	SetPedPathPreferToAvoidWater(HeistTrader, 1)
	GiveWeaponToPed(HeistTrader, GetHashKey("WEAPON_SMG"), 5000, true, true)
	SetPedDropsWeaponsWhenDead(HeistTrader, false)
	SetModelAsNoLongerNeeded(hash)
	SetNewWaypoint(jewelryPeds[playerID].spawn.x, jewelryPeds[playerID].spawn.y)
end

function findNearestCaseIndex()
	local index = -1

	for i = 1, #jewelryCases do
		if GetDistanceBetweenCoords(jewelryCases[i], GetEntityCoords(-1)) < 0.2 then
			index = i
		end
	end
	return index
end

function DrawTimerBar(startT, endT, r, g, b)
	local value = math.floor(((startT + endT) - GetGameTimer())*0.001)
	local maxvalue = math.floor(endT*0.001)
	local width = 0.2
	local height = 0.025
	local xvalue = 0.38
	local yvalue = 0.05
	local outlinecolour = {0, 0, 0, 150}
	local barcolour = {r, g, b}
	local minutes = math.floor(value/60)
	local time = ""..minutes.." minutes and "..math.floor(value - (minutes*60)).." seconds"
	DrawRect(xvalue + (width/2), yvalue, width + 0.004, height + 0.006705, outlinecolour[1], outlinecolour[2], outlinecolour[3], outlinecolour[4]) -- Box that creates outline
	drawHelpTxt(xvalue + (((maxvalue/2)/((maxvalue/2)/width))/2), yvalue + 0.0275, 0.1, 0.1, 0.5, time, 255, 255, 255, 255, 6) -- Text display of timer
	DrawRect(xvalue + (width/2), yvalue, width, height, barcolour[1], barcolour[2], barcolour[3], 75) --  Static full bar
	DrawRect(xvalue + ((value/(maxvalue/width))/2), yvalue, value/(maxvalue/width), height, barcolour[1], barcolour[2], barcolour[3], 255) -- Moveable Bar  
end

function drawTimedWastedScaleform(heading, desc, time)
	Citizen.CreateThread(function()
		local startTime = GetGameTimer()
		local scaleform = RequestScaleformMovie("mp_big_message_freemode")
		while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
		end
		while startTime + time > GetGameTimer() do
			Citizen.Wait(0)
			PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
			PushScaleformMovieFunctionParameterString(heading)
			PushScaleformMovieFunctionParameterString(desc)
			PopScaleformMovieFunctionVoid()

			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
	end)
end

function drawTimedMissionScaleform(heading, desc, time)
	Citizen.CreateThread(function()
		local startTime = GetGameTimer()
		local scaleform = RequestScaleformMovie("mission_quit")
		while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
		end
		while startTime + time > GetGameTimer() do
			Citizen.Wait(0)
			PushScaleformMovieFunction(scaleform, "SET_TEXT")
			PushScaleformMovieFunctionParameterString(heading)
			PushScaleformMovieFunctionParameterString(desc)
			PopScaleformMovieFunctionVoid()

			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
	end)
end

function activeRobbers()
	local count = 0
	for k,v in pairs(robbers) do
		if v.ID ~= 0 then
			count = count + 1
		end
	end
	return count
end

function activeVehicles()
	local count = 0
	for k,v in pairs(robber_vehicles) do
		if v.ID ~= 0 then
			if GetVehicleEngineHealth(NetToVeh(v.networkID)) < 150 then
				count = count + 1
			end
		end
	end
	return count
end

function getYourId()
	for k,v in pairs(robbers) do
		if v.ID == GetPlayerServerId(PlayerId()) then
			return k
		end
	end
end

function getVehicleId(id)
	for k,v in pairs(robbers) do
		if v.ID == tonumber(id) then
			return k
		end
	end
end

function FindNearestPlayer(distance)

  local result
  local lastDistance = 1000
  for i=-1,250 do
	if NetworkIsPlayerConnected(i) and GetPlayerPed(i) ~= nil then
	  local targetPed = GetPlayerPed(i)
	  local targetDistance = GetDistanceBetweenCoords(GetEntityCoords(targetPed),GetEntityCoords(GetPlayerPed(-1)))
	  if targetDistance < distance then
		if GetPlayerPed(-1) ~= GetPlayerPed(i) then
		  if lastDistance > targetDistance then
			result = {ped = targetPed, pedID = i}
			lastDistance = targetDistance
		  end
		end
	  end
	end
  end

  return result
end

function FindNearbyPlayers(distance)

  local results = {{ped = PlayerPedId(), pedID = PlayerId()}}
  for i=-1,250 do
	if NetworkIsPlayerConnected(i) and GetPlayerPed(i) ~= nil then
	  local targetPed = GetPlayerPed(i)
	  if GetDistanceBetweenCoords(GetEntityCoords(targetPed),GetEntityCoords(GetPlayerPed(-1))) < distance then
		if GetPlayerPed(-1) ~= GetPlayerPed(i) then
		  results[#results+1] = {ped = targetPed, pedID = i};
		end
	  end
	end
  end

  return results
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

function drawHelpTxt(x,y ,width,height,scale, text, r,g,b,a,font)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

--TEMP
Weapons = {"WEAPON_KNIFE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB", "WEAPON_CROWBAR","WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50", "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_ASSAULTRIFLE", "WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_PUMPSHOTGUN", "WEAPON_SAWNOFFSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_BULLPUPSHOTGUN","WEAPON_STUNGUN", "WEAPON_SNIPERRIFLE", "WEAPON_SMOKEGRENADE", "WEAPON_BZGAS", "WEAPON_MOLOTOV", "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_SNSPISTOL", "WEAPON_SPECIALCARBINE", "WEAPON_HEAVYPISTOL", "WEAPON_BULLPUPRIFLE", "WEAPON_HOMINGLAUNCHER", "WEAPON_PROXMINE", "WEAPON_SNOWBALL", "WEAPON_VINTAGEPISTOL", "WEAPON_DAGGER", "WEAPON_FIREWORK", "WEAPON_MUSKET", "WEAPON_MARKSMANRIFLE", "WEAPON_HEAVYSHOTGUN", "WEAPON_GUSENBERG", "WEAPON_HATCHET", "WEAPON_COMBATPDW", "WEAPON_KNUCKLE", "WEAPON_MARKSMANPISTOL", "WEAPON_BOTTLE", "WEAPON_FLAREGUN", "WEAPON_FLARE", "WEAPON_REVOLVER", "WEAPON_SWITCHBLADE", "WEAPON_MACHETE", "WEAPON_FLASHLIGHT", "WEAPON_MACHINEPISTOL", "WEAPON_DBSHOTGUN", "WEAPON_COMPACTRIFLE"}

function startPartOne()
	local setTokill = false
	Citizen.CreateThread(function()
		local startTime = GetGameTimer()
		local endTime = 600000
		while PartOne == true and startTime + endTime >= GetGameTimer() and HeistActive do
			Citizen.Wait(0)

			DrawTimerBar(startTime, endTime, 255, 0, 0)

			if not setTokill then
				setTokill = true
				for i = 1, #allGangs do
					 if allGangs[i] ~= nil then
						if not IsEntityDead(allGangs[i]) then
							for k,v in pairs(robbers) do
								if v.ID ~= 0 then
									TaskCombatPed(allGangs[i], GetPlayerPed(GetPlayerFromServerId(v.ID)),  0,  16)
								end
							end
						end
					end
				end
			end

			for i = 1, #allGangs do
				if allGangs[i] ~= nil then
					if IsEntityDead(allGangs[i]) then
						if allGangs[i] then
							RequestAndDelete(allGangs[i], false)
							allGangs[i] = nil
						end
					else
						SetEntityVisible(allGangs[i], true, 0)
						SetEntityInvincible(allGangs[i], false)
					end
				end
			end

			for k,v in pairs(robbers) do
				if v.ID ~= 0 then
					if IsPedSittingInAnyVehicle(GetPlayerPed(GetPlayerFromServerId(v.ID))) then
						local currentVeh = GetVehiclePedIsUsing(GetPlayerPed(GetPlayerFromServerId(v.ID)), false)
						for _, vehicle in pairs(robber_vehicles) do
							if vehicle.ID ~= 0 then
								if currentVeh == NetToVeh(vehicle.networkID) then
									TriggerServerEvent("jewel-heist:part-one-complete")
									PartOne = false
								end
							end
						end
					end
				end
			end
		end
		if startTime + endTime < GetGameTimer() and HeistActive then
			if GetPlayerFromServerId(Heistleader) == PlayerId() then
				TriggerServerEvent("jewel-heist:failed", {heading="~r~Mission failed", desc="The leader did not retrieve their vehicle in time!"})
			else
				TriggerServerEvent("jewel-heist:cancel", GetPlayerServerId(PlayerId()), {heading="~r~Mission failed", desc="You did not retrieve your vehicle in time!"})
			end
		end
	end)
end

function startPartTwo()
	local setTokill = false
	local calledCops = false
	Citizen.CreateThread(function()

		local startTime = GetGameTimer()
		local endTime = 300000
		RequestIpl("post_hiest_unload")
		RemoveIpl("jewel2fake")
		RemoveIpl("bh1_16_refurb")

		while PartTwo == true and startTime + endTime >= GetGameTimer() and HeistActive do 
			Citizen.Wait(0)
			DrawTimerBar(startTime, endTime, 255, 0, 0)  

			if GetPlayerFromServerId(Heistleader) == PlayerId() then
				if not calledCops then
					calledCops = true
					TriggerServerEvent("jewel-heist:notify", "The cops have been alerted!")
					TriggerServerEvent("jewel-heist:notifycop", "The vangelico jewelry store is being robbed! Guards are on scene engaging the suspects, but need backup now!")
				end
			end

			if not setTokill then
				setTokill = true
				for i = 1, #allGuards do
					if allGuards[i] ~= nil then
						if not IsEntityDead(allGuards[i]) then
							SetEntityInvincible(allGuards[i], false)
							SetEntityVisible(allGuards[i], true, 0)
							for k,v in pairs(robbers) do
								if v.ID ~= 0 then
									TaskCombatPed(allGuards[i], GetPlayerPed(GetPlayerFromServerId(v.ID)),  0,  16)
								end
							end
						end
					end
				end
			end

			if GetPlayerFromServerId(Heistleader) == PlayerId() then
				local totalrobbers = {}
				for k,v in pairs(robbers) do
					if v.ID ~= 0 then
						totalrobbers[#totalrobbers+1] = GetPlayerPed(GetPlayerFromServerId(v.ID))
					end
				end

				if #totalrobbers == 1 then
					if GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 150 and HeistActive then
						PartTwo = false
					end
				elseif #totalrobbers == 2 then
					if GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 150 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[2],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 150 and HeistActive then
						PartTwo = false
					end
				elseif #totalrobbers == 3 then
					if GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 150 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[2],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 150 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[3],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 150 and HeistActive then
						PartTwo = false
					end
				else
					if GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 150 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[2],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 150 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[3],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 150 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[4],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 150 and HeistActive then
						PartTwo = false
					end
				end
			end

			local hasWeapon = false
			for i=1, #Weapons do
				if GetCurrentPedWeapon(PlayerPedId(), GetHashKey(Weapons[i]), 1) then
					hasWeapon = true
				end
			end

			for i = 1, #allGuards do
				if allGuards[i] ~= nil then
					if IsEntityDead(allGuards[i]) then
						if allGuards[i] then
							RequestAndDelete(allGuards[i], false)
							allGuards[i] = nil
						end
					else
						SetEntityInvincible(allGuards[i], false)
						SetEntityVisible(allGuards[i], true, 0)
					end
				end
			end

			for i = 1, #jewelryCases do
				if GetDistanceBetweenCoords(jewelryCases[i][1], jewelryCases[i][2], jewelryCases[i][3], GetEntityCoords(GetPlayerPed(-1))) < 0.3 then
					if RobbedCaseTable[i] == false then
						local nearestPlayer = FindNearestPlayer(1)
						if (nearestPlayer) or nearestPlayer == nil then 
							if hasWeapon then
								drawTxt('Press ~b~E~w~ to smash and grab',6,1,0.5,0.8,0.6,255,255,255,255)    
								if IsControlJustPressed(1, 51) then                       
									TriggerServerEvent("jewel-heist:setCaseSmashed", i) -- FIRST! So that it can go ahead and go across the network, since are already doing the animation
									SetEntityCoords(GetPlayerPed(-1),  jewelryCases[i][1], jewelryCases[i][2], jewelryCases[i][3] - 1,  0.0, 0.0, 0.0)
									SetEntityHeading(GetPlayerPed(-1),  jewelryCases[i][4])
									TriggerEvent("jewel-heist:smashAnimation")
									Wait(2500)
									local stealAmount = GetRandomIntInRange(12, 24)
									TriggerServerEvent("jewel-heist:receiveJewelry", stealAmount)
									PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
									TriggerEvent("customNotification", "Stole <font color='#00ea1b'>" .. stealAmount .. "</font> Jewelry")
								end
							end
						end
					end
				end
			end
		end
		PartTwo = false
		if GetPlayerFromServerId(Heistleader) == PlayerId() then
			TriggerServerEvent("jewel-heist:part-three")
		end
	end)
end

function startPartThree()
	Citizen.CreateThread(function()
		if HeistActive then
			local vid = getVehicleId(GetPlayerServerId(PlayerId()))
			if DoesEntityExist(NetToVeh(robber_vehicles[vid].networkID)) then
				if GetVehicleEngineHealth(NetToVeh(robber_vehicles[vid].networkID)) >= 150 then
					drawTimedMissionScaleform("Part Three A", "Head to the waypoint and deliver your vehicle", 2000)
					TruckEnding = true
					RequestModel(jewelryTrucks[vid].model)
					while not HasModelLoaded(jewelryTrucks[vid].model) do
						Citizen.Wait(0)
					end
					RequestModel(jewelryTrailers[vid].model)
					while not HasModelLoaded(jewelryTrailers[vid].model) do
						Citizen.Wait(0)
					end                                      
					HeistTruck = CreateVehicle(jewelryTrucks[vid].model, jewelryTrucks[vid].x, jewelryTrucks[vid].y, jewelryTrucks[vid].z, jewelryTrucks[vid].h, true, false)
					HeistTrailer = CreateVehicle(jewelryTrailers[vid].model, jewelryTrailers[vid].x, jewelryTrailers[vid].y, jewelryTrailers[vid].z, jewelryTrailers[vid].h, true, false)
					local truckid = NetworkGetNetworkIdFromEntity(HeistTruck)
					local trailerid = NetworkGetNetworkIdFromEntity(HeistTrailer)
					local HeistTruck_blip = AddBlipForEntity(HeistTruck)
					SetBlipSprite(HeistTruck_blip, 1)
					SetBlipColour(HeistTruck_blip, 2)

					SetNewWaypoint(jewelryTrucks[vid].x, jewelryTrucks[vid].y)

					SetNetworkIdCanMigrate(truckid, true)
					SetNetworkIdExistsOnAllMachines(truckid, true)

					SetNetworkIdCanMigrate(trailerid, true)
					SetNetworkIdExistsOnAllMachines(trailerid, true)

					SetEntityAsMissionEntity(HeistTruck, true, false)
					SetEntityAsMissionEntity(HeistTrailer, true, false)
					
					print("Network ID: "..truckid.." | Client ID: "..HeistTruck.." | NetToVeh: "..NetToVeh(truckid).." | VehToNet: "..VehToNet(HeistTruck).." |")
					print("Network ID: "..trailerid.." | Client ID: "..HeistTrailer.." | NetToVeh: "..NetToVeh(trailerid).." | VehToNet: "..VehToNet(HeistTrailer).." |")

					--SetVehicleNumberPlateText(HeistTruck, "JEWEL0"..vid)
					SetVehicleDirtLevel(HeistTruck, 0)

					--SetVehicleNumberPlateText(HeistTrailer, "JEWEL0"..vid)
					SetVehicleDirtLevel(HeistTrailer, 0)

					AttachVehicleToTrailer(HeistTruck, HeistTrailer, 10.0)
					SetVehicleDoorOpen(HeistTrailer, 5, false, false)

					createDriver()

					TriggerServerEvent("jewel-heist:storeHeistTruck", VehToNet(HeistTruck), VehToNet(HeistTrailer))
				end
			end
			if not TruckEnding then
				drawTimedMissionScaleform("Part Three B", "Head to the waypoint and deliver your jewels", 2000)
				createTrader()
			end
			local startTime = GetGameTimer()
			local endTime = 600000
			while PartThree == true and startTime + endTime > GetGameTimer() and HeistActive do
				Citizen.Wait(0)
				DrawTimerBar(startTime, endTime, 0, 255, 0)
			end
			if PartThree == true then	
				PartThree = false
				if TruckEnding then
					TriggerServerEvent("jewel-heist:cancel", GetPlayerServerId(PlayerId()), {heading="~r~Mission failed", desc="You did not deliver your vehicle in time!!"})
				else
					TriggerServerEvent("jewel-heist:cancel", GetPlayerServerId(PlayerId()), {heading="~r~Mission failed", desc="You did not hand over the jewels in time!"})
				end
			end
		end
	end) 
end

RegisterNetEvent("jewel-heist:setCaseSmashed")
AddEventHandler("jewel-heist:setCaseSmashed", function(i)
	RobbedCaseTable[i] = true
	if getYourId() then
		PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1);
	end
end)

AddEventHandler("jewel-heist:smashAnimation", function()
	if DoesEntityExist(PlayerPedId()) then
		Citizen.CreateThread(function()
			RequestAnimDict("missheist_jewel")
			while not HasAnimDictLoaded("missheist_jewel") do
				Citizen.Wait(100)
			end

			local randSmash = smashVariations[GetRandomIntInRange(1, #smashVariations)]
			TaskPlayAnim(PlayerPedId(), "missheist_jewel", randSmash, 4.0, -4, -1, 0, 0, 0, 0, 0)
		end)
	end
end)

AddEventHandler("jewel-heist:deleteGuards", function()
	Citizen.CreateThread(function()
		Wait(5000)
		for i = 1, #allGuards do
			if allGuards[i] ~= nil then
				Citizen.InvokeNative(0x9614299DCB53E54B,allGuards[i])
			end
		end
	end)
end)

AddEventHandler("jewel-heist:storeAnimation", function()
	if DoesEntityExist(PlayerPedId()) then
		Citizen.CreateThread(function()
			RequestAnimDict("missexile3")
			while not HasAnimDictLoaded("missexile3") do
				Citizen.Wait(1)
			end
			TaskPlayAnim(PlayerPedId(), "missexile3", "ex03_dingy_search_case_base_michael", 4.0, -4, -1, 0, 0, 0, 0, 0)
		end)
	end
end)

RegisterNetEvent("jewel-heist:check")
AddEventHandler("jewel-heist:check", function()
	TriggerServerEvent("jewel-heist:start", robbers)
end)

RegisterNetEvent("jewel-heist:start")
AddEventHandler("jewel-heist:start", function(carID, current_robbers)
	drawTimedMissionScaleform("Part one", "Head to the waypoint and collect your vehicle\nEach person must only use their assigned car (marked with a red blip)", 8000)
	HeistActive = true
	robbers = current_robbers

	for k,v in pairs(robbers) do
		if v.leader == true then
			Heistleader = v.ID
		end
	end
	local startTime = GetGameTimer()
	local endTime = 900000
	Citizen.CreateThread(function()
		Citizen.Wait(0)
		SetNewWaypoint(jewelryVehicleLocation.x, jewelryVehicleLocation.y)
		while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(),0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 180 and startTime + endTime >= GetGameTimer() and HeistActive and PartOne == false do
			DrawTimerBar(startTime, endTime, 0, 255, 0)
			Citizen.Wait(0)
		end
		if startTime + endTime < GetGameTimer() then
			if GetPlayerFromServerId(Heistleader) == PlayerId() then
				TriggerServerEvent("jewel-heist:failed", {heading="~r~Mission failed", desc="The leader did not retrieve their vehicle in time!"})
			else
				TriggerServerEvent("jewel-heist:cancel", GetPlayerServerId(PlayerId()), {heading="~r~Mission failed", desc="You did not retrieve your vehicle in time!"})
			end
		else
			RequestModel(jewelryVehicles[carID].model)
			while not HasModelLoaded(jewelryVehicles[carID].model) do
				Citizen.Wait(0)
			end
			HeistVehicle = CreateVehicle(jewelryVehicles[carID].model, jewelryVehicles[carID].x, jewelryVehicles[carID].y, jewelryVehicles[carID].z, jewelryVehicles[carID].h, true, false)
			while not DoesEntityExist(HeistVehicle) do
				Citizen.Wait(0)
			end
			NetworkRegisterEntityAsNetworked(HeistVehicle)
			local id = NetworkGetNetworkIdFromEntity(HeistVehicle)
			local HeistVehicle_blip = AddBlipForEntity(HeistVehicle)
			SetBlipSprite(HeistVehicle_blip, 1)
			SetBlipColour(HeistVehicle_blip, 1)
			print("Network ID: "..id.." | Client ID: "..HeistVehicle.." | NetToVeh: "..NetToVeh(id).." | VehToNet: "..VehToNet(HeistVehicle).." |")
			SetNetworkIdCanMigrate(id, true)
			SetNetworkIdExistsOnAllMachines(id, true)
			ClearVehicleCustomPrimaryColour(HeistVehicle)
			ClearVehicleCustomSecondaryColour(HeistVehicle)
			SetVehicleModKit(HeistVehicle, 0)
			SetVehicleWheelType(HeistVehicle, 7)
			for i = 0, 13 do
				SetVehicleMod(HeistVehicle, i, GetNumVehicleMods(HeistVehicle, i) - 1, false)
			end
			SetVehicleMod(HeistVehicle, 14, 16, false)
			SetVehicleMod(HeistVehicle, 15, GetNumVehicleMods(HeistVehicle, 15) - 2, false)
			SetVehicleMod(HeistVehicle, 16, GetNumVehicleMods(HeistVehicle, 16) - 1, false)
			for i = 17, 22 do 
				ToggleVehicleMod(HeistVehicle, i, true)
			end
			SetVehicleMod(HeistVehicle, 23, 1, false)
			SetVehicleMod(HeistVehicle, 24, 1, false)
			SetVehicleMod(HeistVehicle, 25, GetNumVehicleMods(HeistVehicle, 25) - 1, false)
			SetVehicleMod(HeistVehicle, 27, GetNumVehicleMods(HeistVehicle, 27) - 1, false)
			SetVehicleMod(HeistVehicle, 28, GetNumVehicleMods(HeistVehicle, 28) - 1, false)
			SetVehicleMod(HeistVehicle, 30, GetNumVehicleMods(HeistVehicle, 30) - 1, false)
			SetVehicleMod(HeistVehicle, 33, GetNumVehicleMods(HeistVehicle, 33) - 1, false)
			SetVehicleMod(HeistVehicle, 34, GetNumVehicleMods(HeistVehicle, 34) - 1, false)
			SetVehicleMod(HeistVehicle, 35, GetNumVehicleMods(HeistVehicle, 35) - 1, false)
			SetVehicleMod(HeistVehicle, 38, GetNumVehicleMods(HeistVehicle, 38) - 1, true)
			SetVehicleTyreSmokeColor(HeistVehicle, 0, 0, 127)
			SetVehicleWindowTint(HeistVehicle, 1)
			SetVehicleTyresCanBurst(HeistVehicle, true)
			SetVehicleNumberPlateTextIndex(HeistVehicle, 5)
			SetVehicleModColor_1(HeistVehicle, 4, 12, 0)
			SetVehicleModColor_2(HeistVehicle, 4, 12)
			SetVehicleColours(HeistVehicle, 12, 12)
			SetVehicleExtraColours(HeistVehicle, 70, 141)
			SetVehicleDirtLevel(HeistVehicle, 0)
			DecorSetBool(HeistVehicle, "hotwire", true)
			TriggerServerEvent("jewel-heist:storeHeistVeh", VehToNet(HeistVehicle))
		end
	end)
	if startTime + endTime < GetGameTimer() then
		if GetPlayerFromServerId(Heistleader) == PlayerId() then
			TriggerServerEvent("jewel-heist:failed", {heading="~r~Mission failed", desc="The leader did not retrieve their vehicle in time!"})
		else
			TriggerServerEvent("jewel-heist:cancel", GetPlayerServerId(PlayerId()), {heading="~r~Mission failed", desc="You did not retrieve your vehicle in time!"})
		end
	else
		if GetPlayerFromServerId(Heistleader) == PlayerId() then
			createGang()
			Citizen.CreateThread(function()
				local totalrobbers = {}
				for k,v in pairs(robbers) do
					if v.ID ~= 0 then
					   totalrobbers[#totalrobbers+1] = GetPlayerPed(GetPlayerFromServerId(v.ID))
					end
				end
				if #totalrobbers == 1 then
					while GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 90 and startTime + endTime >= GetGameTimer() and HeistActive do
						DrawTimerBar(startTime, endTime, 0, 255, 0)
						Citizen.Wait(0)
					end
				elseif #totalrobbers == 2 then
					while GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 90 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[2],0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 90 and startTime + endTime >= GetGameTimer() and HeistActive do
						DrawTimerBar(startTime, endTime, 0, 255, 0)
						Citizen.Wait(0)
					end
				elseif #totalrobbers == 3 then
					while GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 90 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[2],0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 90 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[3],0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 90 and startTime + endTime >= GetGameTimer() and HeistActive do
						DrawTimerBar(startTime, endTime, 0, 255, 0)
						Citizen.Wait(0)
					end
				else
					while GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 90 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[2],0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 90 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[3],0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 90 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[4],0), jewelryVehicleLocation.x, jewelryVehicleLocation.y, jewelryVehicleLocation.z, true) > 90 and startTime + endTime >= GetGameTimer() and HeistActive do
						DrawTimerBar(startTime, endTime, 0, 255, 0)
						Citizen.Wait(0)
					end
				end
				if startTime + endTime < GetGameTimer() then
					TriggerServerEvent("jewel-heist:failed", {heading="~r~Mission failed", desc="The leader did not retrieve their vehicle in time!"})
				else
					print("Set Angry")
					relationHash = AddRelationshipGroup("KORTZ_SECURITY")
					SetPedRelationshipGroupHash(heistGroup, 5)
					SetRelationshipBetweenGroups(5, gangGroup, heistGroup)
					SetRelationshipBetweenGroups(5, heistGroup, gangGroup)
					TriggerServerEvent("jewel-heist:part-one")
				end
			end)
		else
			Citizen.CreateThread(function()
				while PartOne == false and startTime + endTime >= GetGameTimer() and HeistActive do
					Citizen.Wait(0)
					DrawTimerBar(startTime, endTime, 0, 255, 0)
				end
				if startTime + endTime < GetGameTimer() then
					TriggerServerEvent("jewel-heist:cancel", GetPlayerServerId(PlayerId()), {heading="~r~Mission failed", desc="You did not retrieve your vehicle in time!"})
				end
			end)
		end
	end
end)

RegisterNetEvent("jewel-heist:notifycop")
AddEventHandler("jewel-heist:notifycop",function(message)
	if exports.policejob:getIsInService() then
		TriggerEvent("customNotification", message)
	end
end)

RegisterNetEvent("jewel-heist:cancel")
AddEventHandler("jewel-heist:cancel",function(reason)
	drawTimedWastedScaleform(reason.heading, reason.desc, 10000)
	if HeistVehicle then
		RemoveBlip(GetBlipFromEntity(HeistVehicle))
		DeleteVehicle(HeistVehicle)
	end
	if HeistTruck then
		RemoveBlip(GetBlipFromEntity(HeistTruck))
		DeleteVehicle(HeistTruck)
		DeleteVehicle(HeistTrailer)
	end
	robbers = {
		{ID=0, current_capacity=0, capacity=100,leader=false},
		{ID=0, current_capacity=0, capacity=100,leader=false},
		{ID=0, current_capacity=0, capacity=100,leader=false},
		{ID=0, current_capacity=0, capacity=100,leader=false},
	}
	robber_vehicles = {}
	robber_trucks = {}
	Heistleader = nil
	guardLocationSelections = {}
	guardsHostile = false
	PartOne = false
	PartTwo = false
	PartThree = false
	HeistVehicle = nil
	HeistTruck = nil
	HeistTrailer = nil
	HeistTruckDriver = nil
	HeistActive = false
	TruckEnding = false
	for i = 1, #allGuards do
		if allGuards[i] ~= nil then
			if allGuards[i] then
				RequestAndDelete(allGuards[i], false)
				allGuards[i] = nil
			end
		end
	end
	for i = 1, #allGangs do
		if allGangs[i] ~= nil then
			if allGangs[i] then
				print("delete gang "..i)
				RequestAndDelete(allGangs[i], false)
				allGangs[i] = nil
			end
		end
	end
	allGuards = {}
	allGangs = {}
end)

RegisterNetEvent("jewel-heist:storeHeistVeh")
AddEventHandler("jewel-heist:storeHeistVeh", function(currentVehicles)
	robber_vehicles = currentVehicles
end)

RegisterNetEvent("jewel-heist:storeHeistTruck")
AddEventHandler("jewel-heist:storeHeistTruck", function(currentTrucks)
	robber_trucks = currentTrucks
end)

RegisterNetEvent("jewel-heist:part-one")
AddEventHandler("jewel-heist:part-one",function()
	PartOne = true
	startPartOne()
end)

RegisterNetEvent("jewel-heist:part-two")
AddEventHandler("jewel-heist:part-two",function()
	PartTwo = true
	startPartTwo()
end)

RegisterNetEvent("jewel-heist:part-three")
AddEventHandler("jewel-heist:part-three",function()
	PartTwo = false
	PartThree = true
	startPartThree()
end)

RegisterNetEvent("jewel-heist:syncJewelry")
AddEventHandler("jewel-heist:syncJewelry",function(current_robbers, currentVehicles)
	robbers = current_robbers
	robber_vehicles = currentVehicles
end)

RegisterNetEvent("jewel-heist:part-one-complete")
AddEventHandler("jewel-heist:part-one-complete",function()
	PartOne = false
	drawTimedMissionScaleform("Part Two", "Head to the waypoint and steal as much jewels as possible", 6000)
	SetNewWaypoint(startPosition.x, startPosition.y)
	local startTime = GetGameTimer()
	local endTime = 900000
	Citizen.CreateThread(function()
		while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(),0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 100 and startTime + endTime >= GetGameTimer() and HeistActive and PartTwo == false do
			DrawTimerBar(startTime, endTime, 0, 255, 0)
			Citizen.Wait(0)
		end
	end)
	if startTime + endTime < GetGameTimer() then
		if GetPlayerFromServerId(Heistleader) == PlayerId() then
			TriggerServerEvent("jewel-heist:failed", {heading="~r~Mission failed", desc="The leader took to long to arrive at the jewelry store!"})
		else
			TriggerServerEvent("jewel-heist:cancel", GetPlayerServerId(PlayerId()), {heading="~r~Mission failed", desc="You took to long to arrive at the jewelry store!"})
		end
	else
		if GetPlayerFromServerId(Heistleader) == PlayerId() then
			print("You are the leader 2")
			createGuards()
			Citizen.CreateThread(function()
				local totalrobbers = {}
				local totalvehicles = {}
				for k,v in pairs(robbers) do
					if v.ID ~= 0 then
						totalrobbers[#totalrobbers+1] = GetPlayerPed(GetPlayerFromServerId(v.ID))
					end
				end
				for k,v in pairs(robber_vehicles) do
					if v.ID ~= 0 then
						totalvehicles[#totalvehicles+1] = NetToVeh(v.networkID)
					end
				end
				if #totalrobbers == 1 then
					while GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalvehicles[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and startTime + endTime >= GetGameTimer() and HeistActive do
						DrawTimerBar(startTime, endTime, 0, 255, 0)
						Citizen.Wait(0)
					end
				elseif #totalrobbers == 2 then
					while GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[2],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalvehicles[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalvehicles[2],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and startTime + endTime >= GetGameTimer() and HeistActive do
						DrawTimerBar(startTime, endTime, 0, 255, 0)
						Citizen.Wait(0)
					end
				elseif #totalrobbers == 3 then
					while GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[2],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[3],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalvehicles[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalvehicles[2],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalvehicles[3],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and startTime + endTime >= GetGameTimer() and HeistActive do
						DrawTimerBar(startTime, endTime, 0, 255, 0)
						Citizen.Wait(0)
					end
				else
					while GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[2],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[3],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalrobbers[4],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalvehicles[1],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalvehicles[2],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalvehicles[3],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and GetDistanceBetweenCoords(GetEntityCoords(totalvehicles[4],0), jewelryStoreLoc.x, jewelryStoreLoc.y, jewelryStoreLoc.z, true) > 50 and startTime + endTime >= GetGameTimer() and HeistActive do
						DrawTimerBar(startTime, endTime, 0, 255, 0)
						Citizen.Wait(0)
					end
				end
				if startTime + endTime < GetGameTimer() then
					TriggerServerEvent("jewel-heist:failed", {heading="~r~Mission failed", desc="The leader took to long to arrive at the jewelry store!"})
				else
					TriggerServerEvent("jewel-heist:notify", "You are Robbing the Jewelry Store! the cops will be alerted soon!")
					relationHash = AddRelationshipGroup("KORTZ_SECURITY")
					SetPedRelationshipGroupHash(heistGroup, 5)
					SetRelationshipBetweenGroups(5, guardGroup, heistGroup)
					SetRelationshipBetweenGroups(5, heistGroup, guardGroup)
					TriggerServerEvent("jewel-heist:part-two")
				end
			end)
		else
			Citizen.CreateThread(function()
				while PartTwo == false and startTime + endTime >= GetGameTimer() and HeistActive do
					Citizen.Wait(0)
					DrawTimerBar(startTime, endTime, 0, 255, 0)
				end
				if startTime + endTime < GetGameTimer() then
					TriggerServerEvent("jewel-heist:cancel", GetPlayerServerId(PlayerId()), {heading="~r~Mission failed", desc="You took to long to arrive at the jewelry store!"})
				end
			end)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if GetDistanceBetweenCoords(startPosition.x,startPosition.y,startPosition.z,GetEntityCoords(GetPlayerPed(-1))) < 50 then
			if not HeistActive then
				DrawMarker(1,startPosition.x,startPosition.y,startPosition.z-1,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
				if GetDistanceBetweenCoords(startPosition.x,startPosition.y,startPosition.z,GetEntityCoords(GetPlayerPed(-1))) < 5 then
					drawTxt('Press ~b~ENTER~s~ to start the jewelry heist',6,1,0.48,0.8,0.6,255,255,255,255)
					if IsControlJustPressed(1,201) then -- Enter Key    
						local nearbyPlayers = FindNearbyPlayers(8)
						if #nearbyPlayers <= 4 then
							robber_vehicles = {}
							robber_trucks = {}
							robbers = {
								{ID=0, current_capacity=0, capacity=100,leader=false},
								{ID=0, current_capacity=0, capacity=100,leader=false},
								{ID=0, current_capacity=0, capacity=100,leader=false},
								{ID=0, current_capacity=0, capacity=100,leader=false},
							}
							for i,v in ipairs(nearbyPlayers) do
								SetPedAsGroupMember(nearbyPlayers[i].ped, heistGroup)
								robbers[i].ID = GetPlayerServerId(nearbyPlayers[i].pedID)
								if nearbyPlayers[i].pedID == PlayerId() then
									robbers[i].leader = true
								end
							end

							TriggerServerEvent("jewel-heist:check", robbers)

							Wait(500)
						else
							TriggerEvent("customNotification", "You can only try this heist with 4 people total")
						end               
					end
				end
			end
		end 
		if HeistActive then
			if exports.policejob:getIsCuffed() == true then
				if GetPlayerFromServerId(Heistleader) == PlayerId() then
					if PartThree then
						TriggerServerEvent("jewel-heist:cancel", v.ID, {heading="~r~Mission failed", desc="You were arrested!"})
					else
						TriggerServerEvent("jewel-heist:failed", {heading="~r~Mission failed", desc="The leader was arrested!"})
					end
				else
					TriggerServerEvent("jewel-heist:cancel", v.ID, {heading="~r~Mission failed", desc="You were arrested!"})
				end
			end
			if GetPlayerFromServerId(Heistleader) == PlayerId() then
				for k,v in pairs(robbers) do
					if v.ID ~= 0 then
						if IsEntityDead(GetPlayerPed(GetPlayerFromServerId(v.ID))) then
							if v.leader ~= true then
								TriggerServerEvent("jewel-heist:cancel", v.ID, {heading="~r~Mission failed", desc="You died!"})
							else
								if PartThree then
									TriggerServerEvent("jewel-heist:cancel", v.ID, {heading="~r~Mission failed", desc="You died!"})
								else
									TriggerServerEvent("jewel-heist:failed", {heading="~r~Mission failed", desc="The leader died!"})
								end
							end
							robbers[k].ID = 0
						end
					end
				end
			end
		end
	end
end)

local doors = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if HeistActive then
			if #robber_vehicles >=1 then
				for k,v in pairs(robber_vehicles) do
					if v.ID ~= 0 then
						local cVeh = NetToVeh(v.networkID)
						if DoesEntityExist(cVeh) then
							if not IsEntityDead(cVeh) then
								if not IsPedSittingInAnyVehicle(PlayerPedId()) then
									local pos = GetEntityCoords(PlayerPedId(), true)
									if GetEntityModel(cVeh) == GetHashKey("GBURRITO2") then
										local entitypos = GetOffsetFromEntityInWorldCoords(cVeh, 0.0, -3.0, 0.0)
										if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, entitypos.x, entitypos.y, entitypos.z, true) < 1 then
											if doors then
												drawTxt('Press ~b~ENTER~s~ to close the doors',6,1,0.48,0.75,0.6,255,255,255,255)
												drawTxt('Press ~b~E~s~ to store jewelry',6,1,0.48,0.7,0.6,255,255,255,255)
												if IsControlJustPressed(1, 201) then
													doors = false
													SetVehicleDoorShut(cVeh, 2, false)
													SetVehicleDoorShut(cVeh, 3, false)
												end
												if IsControlJustPressed(1, 51) then
													local amount = 0
													DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", robbers[getYourId()].current_capacity , "", "", "", 1000)
													while (UpdateOnscreenKeyboard() == 0) do
														DisableAllControlActions(0);
														Wait(0);
													end
													if (GetOnscreenKeyboardResult()) then
														local res = tonumber(GetOnscreenKeyboardResult())
														if(res ~= nil and res ~= 0 and res > 0) then
															amount = res
														end
													end
													if amount > 0 then
														TriggerEvent("jewel-heist:storeAnimation")
														TriggerServerEvent("jewel-heist:storeJewelry", v.ID, amount)
													end
												end
											else
												drawTxt('Press ~b~ENTER~s~ to open the doors',6,1,0.48,0.75,0.6,255,255,255,255)
												if IsControlJustPressed(1, 201) then
													doors = true
													SetVehicleDoorOpen(cVeh, 2, false, false)
													SetVehicleDoorOpen(cVeh, 3, false, false)
												end
											end                            
										end
									else
										local entitypos = GetOffsetFromEntityInWorldCoords(cVeh, 0.5, 0.0, 0.0)
										if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, entitypos.x, entitypos.y, entitypos.z, true) < 2 then
											if doors then
												drawTxt('Press ~b~ENTER~s~ to close the door',6,1,0.48,0.75,0.6,255,255,255,255)
												drawTxt('Press ~b~E~s~ to store jewelry',6,1,0.48,0.7,0.6,255,255,255,255)
												if IsControlJustPressed(1, 201) then
													doors = false
													SetVehicleDoorShut(cVeh, 1, false)
												end
												if IsControlJustPressed(1, 51) then
													local amount = 0
													DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", robbers[getYourId()].current_capacity , "", "", "", 1000)
													while (UpdateOnscreenKeyboard() == 0) do
														DisableAllControlActions(0);
														Wait(0);
													end
													if (GetOnscreenKeyboardResult()) then
														local res = tonumber(GetOnscreenKeyboardResult())
														if(res ~= nil and res ~= 0 and res > 0) then
															amount = res
														end
													end
													if amount > 0 then
														TriggerEvent("jewel-heist:storeAnimation")
														TriggerServerEvent("jewel-heist:storeJewelry", v.ID, amount)
													end
												end
											else
												drawTxt('Press ~b~ENTER~s~ to open the door',6,1,0.48,0.75,0.6,255,255,255,255)
												if IsControlJustPressed(5, 201) then
													doors = true
													SetVehicleDoorOpen(cVeh, 1, false, false)
												end
											end                            
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

local enRoute = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if HeistActive then
			if PartThree then
				if TruckEnding then
					if #robber_trucks >=1 then
						for k,v in pairs(robber_trucks) do
							if v.ID ~= 0 and v.ID == GetPlayerServerId(PlayerId()) then
								for _, vehicle in pairs(robber_vehicles) do
									if v.ID ~= 0 and v.ID == GetPlayerServerId(PlayerId()) then
										if vehicle.ID ~= 0 and vehicle.ID == GetPlayerServerId(PlayerId()) then
											local cVehicle = NetToVeh(vehicle.networkID)
											local cTruck = NetToVeh(v.truck_networkID)
											local cTrailer = NetToVeh(v.trailer_networkID)
											if DoesEntityExist(cTruck) and DoesEntityExist(cTrailer) and DoesEntityExist(cVehicle) then
												if not IsEntityDead(cTruck) and not IsEntityDead(cTrailer) and not IsEntityDead(cVehicle) then
													local carpos = GetEntityCoords(cVehicle, true)
													local entitypos = GetOffsetFromEntityInWorldCoords(cTrailer, 0.0, -12.0, -2.0)
													local otherentitypos = GetOffsetFromEntityInWorldCoords(cTrailer, 0.0, 0.0, -0.5)
													if GetDistanceBetweenCoords(carpos.x, carpos.y, carpos.z, entitypos.x, entitypos.y, entitypos.z, true) < 20 then
														DrawMarker(1, otherentitypos.x, otherentitypos.y, otherentitypos.z - 1, 0, 0, 0, 0, 0, 0, 2.5001, 2.5001, 0.5001, 1555, 0, 0,165, 0, 0, 0,0)
													end
													if not enRoute then
														if GetDistanceBetweenCoords(carpos.x, carpos.y, carpos.z, otherentitypos.x, otherentitypos.y, otherentitypos.z, true) < 0.8 then
															enRoute = true
															SetEntityCoords(PlayerPedId(), otherentitypos.x-5.0, otherentitypos.y, otherentitypos.z-2.0)
															SetVehicleHandbrake(cVehicle, true)
															SetVehicleEngineOn(cVehicle, false, true, false)
															SetVehicleFixed(cTrailer)
															TaskVehicleDriveToCoordLongrange(HeistTruckDriver, HeistTruck, -34.552, -673.060, 31.944, 20.0,  447, 1.0)
															RemoveBlip(GetBlipFromEntity(cVehicle))
															RemoveBlip(GetBlipFromEntity(cTruck))
															DeleteVehicle(cVehicle)
															if DoesEntityExist(cVehicle) then
																SetEntityCoords(cVehicle, 401.71649169922, -1631.1243896484, -2.7080497741699)
															end
															SetVehicleFixed(cTrailer)
															TriggerServerEvent("jewel-heist:complete", 1)
															robbers = {
																{ID=0, current_capacity=0, capacity=100,leader=false},
																{ID=0, current_capacity=0, capacity=100,leader=false},
																{ID=0, current_capacity=0, capacity=100,leader=false},
																{ID=0, current_capacity=0, capacity=100,leader=false},
															}
															robber_vehicles = {}
															robber_trucks = {}
															Heistleader = nil
															guardLocationSelections = {}
															guardsHostile = false
															PartOne = false
															PartTwo = false
															PartThree = false
															HeistVehicle = nil
															HeistTruck = nil
															HeistTrailer = nil
															HeistTruckDriver = nil
															HeistActive = false
															TruckEnding = false
															for i = 1, #allGuards do
																if allGuards[i] ~= nil then
																	if allGuards[i] then
																		RequestAndDelete(allGuards[i], false)
																		allGuards[i] = nil
																	end
																end
															end
															for i = 1, #allGangs do
																if allGangs[i] ~= nil then
																	if allGangs[i] then
																		print("delete gang "..i)
																		RequestAndDelete(allGangs[i], false)
																		allGangs[i] = nil
																	end
																end
															end
															allGuards = {}
															allGangs = {}
															drawTimedWastedScaleform("~g~Mission completed", "The money has been wired to your account!", 10000)
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				else
					for k,v in pairs(robbers) do
						if v.ID ~= 0 and v.ID == GetPlayerServerId(PlayerId()) then
							local pos = GetEntityCoords(PlayerPedId(), true)
							if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, jewelryPeds[k].marker.x, jewelryPeds[k].marker.y, jewelryPeds[k].marker.z, true) < 20 then
								DrawMarker(1, jewelryPeds[k].marker.x, jewelryPeds[k].marker.y, jewelryPeds[k].marker.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 1555, 0, 0,165, 0, 0, 0,0)
								if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, jewelryPeds[k].marker.x, jewelryPeds[k].marker.y, jewelryPeds[k].marker.z, true) < 1.5001 then
									if IsControlJustPressed(1, 51) then
										TriggerServerEvent("jewel-heist:complete", 2)
										RemoveBlip(GetBlipFromEntity(HeistVehicle))
										robbers = {
											{ID=0, current_capacity=0, capacity=100,leader=false},
											{ID=0, current_capacity=0, capacity=100,leader=false},
											{ID=0, current_capacity=0, capacity=100,leader=false},
											{ID=0, current_capacity=0, capacity=100,leader=false},
										}
										robber_vehicles = {}
										robber_trucks = {}
										Heistleader = nil
										allGuards = {}
										guardLocationSelections = {}
										guardsHostile = false
										allGangs = {}
										PartOne = false
										PartTwo = false
										PartThree = false
										HeistVehicle = nil
										HeistTruck = nil
										HeistTrailer = nil
										HeistTruckDriver = nil
										HeistActive = false
										TruckEnding = false	
										drawTimedWastedScaleform("~g~Mission completed", "here's your money!", 10000)						
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		if HeistActive then
			if #robber_vehicles >=1 then
				if GetPlayerFromServerId(Heistleader) == PlayerId() then
					for k,v in pairs(robber_vehicles) do
						if v.ID ~= 0 then
							if v.current_capacity > 0 then
								local cVeh = NetToVeh(v.networkID)
								local pos = GetEntityCoords(cVeh, true)
								local vehicleModel = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(cVeh)))
								local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
								local directions = { [0] = 'North', [45] = 'North West', [90] = 'West', [135] = 'South West', [180] = 'South', [225] = 'South East', [270] = 'East', [315] = 'North East', [360] = 'North'} 
								local direction
								for k,v in pairs(directions) do
									direction = GetEntityHeading(cVeh)
									if(math.abs(direction - k) < 22.5) then
										direction = v
										break;
									end
								end
								local speed = GetEntitySpeed(cVeh) * 2.236936
								local chance =GetRandomIntInRange(1,100)
								if speed > 50 and chance >= 20 then
									for i=1,#cityCameras do
										if GetDistanceBetweenCoords(pos, cityCameras[i][1], cityCameras[i][2], cityCameras[i][3], true) < 30 then
											if direction == nil then
												TriggerServerEvent("jewel-heist:notifycop",  "A " .. vehicleModel .. " from the jewel heist has been spotted on " .. tostring(GetStreetNameFromHashKey(var2)) .. " going " .. math.floor(speed) .. " MPH by camera: "..i)
											else
												TriggerServerEvent("jewel-heist:notifycop",  "A " .. vehicleModel .. " from the jewel heist has been spotted headed " .. direction ..  " on " .. tostring(GetStreetNameFromHashKey(var2)) .. " going " .. math.floor(speed) .. " MPH by camera: "..i)
											end
											Wait(2000)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if HeistActive then
			if #robber_vehicles >=1 then
				local count = 0
				for _, robber in pairs(robbers) do
					if robber.ID ~= 0 then
						local vid = getVehicleId(robber.ID)
						if robber_vehicles[vid].ID ~= 0 then
							DrawRect(0.32 + count, 0.925, 0.1, 0.1, 0,0,0,225)
							if GetPlayerFromServerId(robber.ID) == PlayerId() then
								if GetPlayerFromServerId(Heistleader) == PlayerId() then
									drawHelpTxt(0.32 + count, 0.918, 0.1, 0.1, 0.4, "~b~Leader (~g~You~b~)", 255, 255, 255, 255, 6)
								else
									drawHelpTxt(0.32 + count, 0.918, 0.1, 0.1, 0.4, "~g~You", 255, 255, 255, 255, 6)
								end
							else
								if Heistleader == robber.ID then
									drawHelpTxt(0.32 + count, 0.918, 0.1, 0.1, 0.4, "~b~Leader (~g~"..robber.ID.."~b~)", 255, 255, 255, 255, 6)
								else
									drawHelpTxt(0.32 + count, 0.918, 0.1, 0.1, 0.4, "~b~ID: ~g~"..robber.ID.."", 255, 255, 255, 255, 6)
								end
							end
							local robber_percentage = ((robber.current_capacity/robber.capacity)*100)
							if robber_percentage == 0 then
								robber_percentage = "~g~Empty!"
							elseif robber_percentage == 100 then
								robber_percentage = "~r~Full!"
							elseif robber_percentage < 60 then
								robber_percentage = "~g~"..((robber.current_capacity/robber.capacity)*100).."%"
							elseif robber_percentage < 85 then
								robber_percentage = "~o~"..((robber.current_capacity/robber.capacity)*100).."%"
							elseif robber_percentage > 84 then
								robber_percentage = "~r~"..((robber.current_capacity/robber.capacity)*100).."%"
							end
							drawHelpTxt(0.32 + count, 0.938, 0.1, 0.1, 0.5, "~b~Capacity: "..robber_percentage, 255, 255, 255, 255, 6)
							local vehicleStatus = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(NetToVeh(robber_vehicles[vid].networkID))))
							if robber_vehicles[vid].networkID == 0 then
								vehicleStatus = "Not Spawned"
							else
								if GetVehicleEngineHealth(NetToVeh(robber_vehicles[vid].networkID)) < 150 or not DoesEntityExist(NetToVeh(robber_vehicles[vid].networkID)) then
									vehicleStatus = "~r~Destroyed!"
									if robber_vehicles[vid].ID == GetPlayerServerId(PlayerId()) then
										RemoveBlip(GetBlipFromEntity(NetToVeh(robber_vehicles[vid].networkID)))
										if PartThree then
											if TruckEnding then
												createTrader()
												TruckEnding = false
												drawTimedMissionScaleform("Part Three B", "Head to the new waypoint and deliver your jewels", 2000)
												if HeistTruck then
													RemoveBlip(GetBlipFromEntity(HeistTruck))
													DeleteVehicle(HeistTruck)
													DeleteVehicle(HeistTrailer)
												end
											end
										end
									end
								end
							end
							drawHelpTxt(0.32 + count, 0.965, 0.1, 0.1, 0.4, "~b~Vehicle: ~g~"..vehicleStatus.."", 255, 255, 255, 255, 6)
							local car_percentage = ((robber_vehicles[vid].current_capacity/robber_vehicles[vid].capacity)*100)
							if car_percentage == 0 then
								car_percentage = "~g~Empty!"
							elseif car_percentage == 100 then
								car_percentage = "~r~Full!"
							elseif car_percentage < 60 then
								car_percentage = "~g~"..((robber_vehicles[vid].current_capacity/robber_vehicles[vid].capacity)*100).."%"
							elseif car_percentage < 85 then
								car_percentage = "~o~"..((robber_vehicles[vid].current_capacity/robber_vehicles[vid].capacity)*100).."%"
							 elseif car_percentage > 84 then
								car_percentage = "~r~"..((robber_vehicles[vid].current_capacity/robber_vehicles[vid].capacity)*100).."%"
							end
							drawHelpTxt(0.32 + count, 0.985, 0.1, 0.1, 0.5, "~b~Capacity: "..car_percentage, 255, 255, 255, 255, 6)
							count = count + (0.06*2)
						end
					end
				end
			end
		end
	end
end)
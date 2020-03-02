Weed = {
	Pay = {
		Minimum = 100,
		Maximum = 149,
	},
	Growthtime = {
		Minimum = 120,
		Maximum = 300,
	},
	Items = {
		Joint = 8,
		Weed = 4,
	},
	Plants = {},
}

function Weed:CalculateGrowth(current_time, plant_start, plant_end)
    local total_seconds = plant_end - plant_start
    local elapsed_seconds = current_time - plant_start
    if math.floor((elapsed_seconds/total_seconds) * 100) > 100 then
        return 100
    else
        return math.floor((elapsed_seconds/total_seconds) * 100)
    end
end

function Weed:GetGrowthInformation(current_growth)
    if current_growth >= 100 then
        return "Ready", 5, 50
    elseif current_growth >= 80 then
        return "Flowering", 3, 30
    elseif current_growth >= 70 then
        return "Vegetative", 2, 20
    elseif current_growth >= 50 then
        return "Germination", 1, 10
    elseif current_growth >= 30 then
        return "Seedling", 0, 0
    else
        return "Seed", 0, 0
    end
end

if not IsDuplicityVersion() then
	Weed.Cooldown = 10 -- Seconds
	Weed.Plants = {
		{Coordinates = vector3(2215.85, 5575.36, 53.69), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2216.24, 5577.55, 53.78), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2218.19, 5575.20, 53.70), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2221.00, 5575.00, 53.71), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2222.70, 5574.80, 53.73), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2227.30, 5574.60, 53.79), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2230.70, 5574.40, 53.90), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2232.43, 5576.30, 53.97), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2230.22, 5576.55, 53.93), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2227.74, 5576.66, 53.86), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2225.44, 5576.90, 53.85), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2223.05, 5577.12, 53.83), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2220.60, 5577.06, 53.83), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2218.60, 5577.26, 53.85), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2219.00, 5579.42, 53.89), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2223.80, 5579.30, 53.91), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2225.40, 5578.94, 53.88), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2230.15, 5579.00, 53.97), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(2233.90, 5578.70, 54.11), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1049.8557128906,-3205.4877929688,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1050.0383300781,-3207.1975097656,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.3432617188,-3205.2707519531,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.5675048828,-3206.8696289063,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1053.0446777344,-3205.5710449219,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1053.0485839844,-3207.2214355469,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1055.3449707031,-3204.3786621094,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1054.9425048828,-3205.677734375,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1055.1345214844,-3207.2255859375,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1056.7016601563,-3207.3432617188,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1056.5012207031,-3205.8796386719,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1057.0433349609,-3204.4895019531,-40.042900085449), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1058.6223144531,-3204.5654296875,-40.042900085449), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1058.3033447266,-3205.9606933594,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1058.3151855469,-3207.3920898438,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1059.8625488281,-3207.4104003906,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1059.9562988281,-3206.0368652344,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1060.1484375,-3204.6765136719,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1061.9710693359,-3204.6838378906,-40.042900085449), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1061.9490966797,-3206.3854980469,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1063.4294433594,-3205.1501464844,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1063.267578125,-3206.7194824219,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1064.8032226563,-3206.4467773438,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1064.8929443359,-3204.8728027344,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1055.8714599609,-3201.8293457031,-40.083171844482), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1057.2377929688,-3202.2124023438,-40.161407470703), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1058.6473388672,-3201.8735351563,-40.051074981689), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1058.7337646484,-3199.8505859375,-40.068519592285), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1057.4205322266,-3200.2001953125,-40.161972045898), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1055.8991699219,-3200.4409179688,-40.061992645264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1058.7716064453,-3197.9802246094,-40.056735992432), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1057.4205322266,-3198.3859863281,-40.161972045898), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1056.1529541016,-3197.5456542969,-40.061992645264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1061.9641113281,-3203.1030273438,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1063.4158935547,-3203.3464355469,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1064.8572998047,-3203.2587890625,-40.042900085449), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1061.9951171875,-3201.5732421875,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1063.3636474609,-3201.6938476563,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1064.7403564453,-3201.7155761719,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1061.5288085938,-3200.1586914063,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1063.1334228516,-3200.0583496094,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1064.8131103516,-3199.6904296875,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1061.2259521484,-3198.4260253906,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1062.7556152344,-3198.6032714844,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1064.3205566406,-3198.2060546875,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1061.3587646484,-3196.9401855469,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1062.8686523438,-3196.8791503906,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1064.5087890625,-3196.6955566406,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1053.1141357422,-3200.6164550781,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1053.1485595703,-3199.1091308594,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.5323486328,-3200.6975097656,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.5310058594,-3199.3515625,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1050.0133056641,-3200.533203125,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1050.0971679688,-3199.06640625,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1052.7733154297,-3197.5119628906,-40.134414672852), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1052.7733154297,-3195.9296875,-40.134414672852), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1052.7733154297,-3194.47265625,-40.134414672852), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.1705322266,-3197.6079101563,-40.134414672852), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.1705322266,-3196.0256347656,-40.134414672852), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.1705322266,-3194.5686035156,-40.134414672852), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1049.9442138672,-3194.4543457031,-40.167102813721), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1049.9442138672,-3195.9716796875,-40.167102813721), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1049.9611816406,-3197.4660644531,-40.153900146484), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1052.7855224609,-3192.6088867188,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1052.9473876953,-3191.0959472656,-40.042900085449), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1052.9986572266,-3189.4821777344,-40.042900085449), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1052.8817138672,-3187.9387207031,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.5051269531,-3188.1223144531,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1050.1364746094,-3187.7673339844,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.5572509766,-3189.5695800781,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1050.2329101563,-3189.3264160156,-40.042900085449), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1050.2021484375,-3190.7131347656,-40.042900085449), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.5708007813,-3191.0266113281,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1049.9185791016,-3192.6088867188,-40.042896270752), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1051.4089355469,-3192.9428710938,-40.15198135376), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1054.8132324219,-3191.3981933594,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1056.2799072266,-3191.6701660156,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1057.8669433594,-3191.5317382813,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1054.89453125,-3189.8894042969,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1054.8659667969,-3188.2392578125,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1056.3520507813,-3188.5686035156,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1056.6002197266,-3190.1640625,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1058.0843505859,-3189.9248046875,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1057.8762207031,-3188.2177734375,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1061.4069824219,-3191.7805175781,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1061.435546875,-3193.4306640625,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1061.3542480469,-3194.9396972656,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1062.8930664063,-3192.1101074219,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1063.1413574219,-3193.7053222656,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1062.8209228516,-3195.2116699219,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1064.5744628906,-3195.0732421875,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1064.6253662109,-3193.4663085938,-40.147930145264), Time = {Start = 0, End = 0}},
		{Coordinates = vector3(1064.4172363281,-3191.7592773438,-40.147930145264), Time = {Start = 0, End = 0}},
	}
	Weed.Traders = {
		{
			Model = "g_m_y_lost_03",
			Ped = {
				Coordinates = vector3(966.1474609375, -1620.4439697266, 30.110685348511),
				Heading = 264.15948486328,
			},
			Marker = vector3(967.06030273438, -1620.4417724609, 30.110685348511),
		}, -- Sandy shores
		{
			Model = "a_m_y_beach_02",
			Ped = {
				Coordinates = vector3(-1162.34765625, -1566.4310302734, 4.4249238967896),
				Heading = 302.57464599609,
			},
			Marker = vector3(-1161.7086181641, -1565.9797363281, 4.4265594482422),
		}, -- Beach
		{
			Model = "a_m_y_beach_02",
			Ped = {
				Coordinates = vector3(-1822.6064453125, -1203.9437255859, 19.164642333984),
				Heading = 335.11407470703,
			},
			Marker = vector3(-1822.6064453125, -1203.9437255859, 19.164642333984),
		}, -- Beach
		{
			Model = "a_m_y_beach_02",
			Ped = {
				Coordinates = vector3(-1629.0004882813, -1029.5299072266, 5.9618558883667),
				Heading = 129.71435546875,
			},
			Marker = vector3(-1629.7355957031, -1030.3135986328, 5.9027328491211),
		},
		{
			Model = "a_m_y_beach_02",
			Ped = {
				Coordinates = vector3(-1889.751953125, -591.72735595703, 18.331005096436),
				Heading = 141.96781921387,
			},
			Marker = vector3(-1890.3259277344, -592.46343994141, 18.331005096436),
		}, -- Beach
		{
			Model = "g_m_y_lost_03",
			Ped = {
				Coordinates = vector3(1790.7663574219, 3895.560546875, 34.389263153076),
				Heading = 94.902809143066,
			},
			Marker = vector3(1789.869140625, 3895.3481445313, 34.389263153076),
		}, -- Sandy shores
		{
			Model = "g_m_y_lost_03",
			Ped = {
				Coordinates = vector3(1414.744140625, 3823.8518066406, 32.009101867676),
				Heading = 160.28286743164,
			},
			Marker = vector3(1414.4262695313, 3822.8994140625, 32.047939300537),
		},
		{
			Model = "g_m_y_lost_03",
			Ped = {
				Coordinates = vector3(-11.311979293823, -1430.8831787109, 31.10146522522),
				Heading = 175.85705566406,
			},
			Marker = vector3(-11.271890640259, -1432.0723876953, 31.116764068604),
		}, -- Sandy shores
		{
			Model = "g_m_y_lost_03",
			Ped = {
				Coordinates = vector3(71.604370117188, -1974.7972412109, 20.860677719116),
				Heading = 333.85516357422,
			},
			Marker = vector3(72.142684936523, -1974.1370849609, 20.821695327759),
		}, -- Grove street
		{
			Model = "g_m_y_lost_03",
			Ped = {
				Coordinates = vector3(843.07501220703, -2185.8581542969, 30.308256149292),
				Heading = 264.65069580078,
			},
			Marker = vector3(844.01770019531, -2185.9035644531, 30.308437347412),
		}, -- Orchardville Avenue and El Rancho Blvd
		{
			Model = "g_m_y_lost_03",
			Ped = {
				Coordinates = vector3(-565.30908203125, 302.17816162109, 83.150939941406),
				Heading = 259.66613769531,
			},
			Marker = vector3(-564.109375, 302.22872924805, 83.159049987793),
		}, -- Vinewood, behind Tequi-la-la
		{
			Model = "g_m_y_lost_01",
			Ped = {
				Coordinates = vector3(975.49450683594, -97.277130126953, 74.84642791748),
				Heading = 290.23361206055,
			},
			Marker = vector3(976.61743164063, -96.703575134277, 74.845603942871),
		}, -- Lost hideout
	}

	for Index = 1, #Weed.Traders do
		Weed.Traders[Index].Model = GetHashKey(Weed.Traders[Index].Model)
		Weed.Traders[Index].Rate = GetRandomIntInRange(60, 101)
	end

	Weed.Zones = { 
		["AIRP"] = 10, -- Los Santos International Airport
		["ALAMO"] = 10, -- Alamo Sea
		["ALTA"] = 10, -- Alta
		["ARMYB"] = 10, -- Fort Zancudo"
		["BANHAMC"] = 10, -- Banham Canyon Dr
		["BANNING"] = 10, -- Banning
		["BEACH"] = 50, -- Vespucci Beach 
		["BHAMCA"] = 10, -- Banham Canyon
		["BRADP"] = 10, -- Braddock Pass
		["BRADT"] = 10, -- Braddock Tunnel
		["BURTON"] = 10, -- Burton
		["CALAFB"] = 10, -- Calafia Bridge
		["CANNY"] = 10, -- Raton Canyon
		["CCREAK"] = 10, -- Cassidy Creek
		["CHAMH"] = 70, -- Chamberlain Hills
		["CHIL"] = 10, -- Vinewood Hills
		["CHU"] = 10, -- Chumash
		["CMSW"] = 10, -- Chiliad Mountain State Wilderness 
		["CYPRE"] = 70, -- Cypress Flats
		["DAVIS"] = 70, -- Davis 
		["DELBE"] = 50, -- Del Perro Beach 
		["DELPE"] = 10, -- Del Perro
		["DELSOL"] = 50, -- La Puerta
		["DESRT"] = 10, -- Grand Senora Desert
		["DOWNT"] = 10, -- Downtown
		["DTVINE"] = 10, -- Downtown Vinewood
		["EAST_V"] = 10, -- East Vinewood
		["EBURO"] = 10, -- El Burro Heights
		["ELGORL"] = 10, -- El Gordo Lighthouse
		["ELYSIAN"] = 10, -- Elysian Island
		["GALFISH"] = 10, -- Galilee
		["GOLF"] = 10, -- GWC and Golfing Society
		["GRAPES"] = 70, -- Grapeseed 
		["GREATC"] = 10, -- Great Chaparral
		["HARMO"] = 50, -- Harmony
		["HAWICK"] = 10, -- Hawick
		["HORS"] = 10, -- Vinewood Racetrack
		["HUMLAB"] = 0, -- Humane Labs and Research"
		["JAIL"] = 0, -- Bolingbroke Penitentiary"
		["KOREAT"] = 70, -- Little Seoul 
		["LACT"] = 10, -- Land Act Reservoir
		["LAGO"] = 10, -- Lago Zancudo
		["LDAM"] = 10, -- Land Act Dam
		["LEGSQU"] = 10, -- Legion Square
		["LMESA"] = 70, -- La Mesa
		["LOSPUER"] = 50, -- La Puerta
		["MIRR"] = 10, -- Mirror Park 
		["MORN"] = 10, -- Morningwood
		["MOVIE"] = 10, -- Richards Majestic
		["MTCHIL"] = 10, -- Mount Chiliad
		["MTGORDO"] = 10, -- Mount Gordo
		["MTJOSE"] = 10, -- Mount Josiah
		["MURRI"] = 10, -- Murrieta Heights
		["NCHU"] = 10, -- North Chumash
		["NOOSE"] = 0, -- N.O.O.S.E"
		["OCEANA"] = 10, -- Pacific Ocean
		["PALCOV"] = 10, -- Paleto Cove
		["PALETO"] = 70, -- Paleto Bay
		["PALFOR"] = 50, -- Paleto Forest
		["PALHIGH"] = 10, -- Palomino Highlands
		["PALMPOW"] = 10, -- Palmer-Taylor Power Station
		["PBLUFF"] = 10, -- Pacific Bluffs
		["PBOX"] = 10, -- Pillbox Hill
		["PROCOB"] = 10, -- Procopio Beach
		["RANCHO"] = 70, -- Rancho
		["RGLEN"] = 10, -- Richman Glen
		["RICHM"] = 10, -- Richman
		["ROCKF"] = 10, -- Rockford Hills
		["RTRAK"] = 10, -- Redwood Lights Track
		["SANAND"] = 50, -- San Andreas
		["SANCHIA"] = 10, -- San Chianski Mountain Range
		["SANDY"] = 50, -- Sandy Shores
		["SKID"] = 10, -- Mission Row
		["SLAB"] = 70, -- Stab City
		["STAD"] = 10, -- Maze Bank Arena
		["STRAW"] = 70, -- Strawberry 
		["TATAMO"] = 10, -- Tataviam Mountains
		["TERMINA"] = 10, -- Terminal
		["TEXTI"] = 10, -- Textile City
		["TONGVAH"] = 10, -- Tongva Hills
		["TONGVAV"] = 10, -- Tongva Valley
		["VCANA"] = 10, -- Vespucci Canals
		["VESP"] = 10, -- Vespucci
		["VINE"] = 10, -- Vinewood
		["WINDF"] = 10, -- Ron Alternates Wind Farm
		["WVINE"] = 10, -- West Vinewood
		["ZANCUDO"] = 10, -- Zancudo River
		["ZP_ORT"] = 10, -- Port of South Los Santos
		["ZQ_UAR"] = 10, -- Davis Quartz
	}

	Weed.Animation = {Dictionary = "mp_safehousevagos@", Player = "package_dropoff", Ped = "givetake1_b"}
	Weed.Scenario = "WORLD_HUMAN_GARDENER_PLANT"
	Weed.Bag = {
		Model = GetHashKey("prop_meth_bag_01"),
		Bone = 64096,
		Offset = vector3(0.0, 0.0, 0.020),
		Rotation = vector3(90.0, -10.0, -130.0),
		Handle = nil
	}
	Weed.Trading = {
		Is = false,
		Blip = nil,
		Index = nil,
	}

	AddAnimDictionary(Weed.Animation.Dictionary)
else
	for Index = 1, 112 do
		Weed.Plants[Index] = {Start = 0, End = 0}
	end
end

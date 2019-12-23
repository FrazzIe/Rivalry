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

	Weed.Animation = {Dictionary = "mp_common", Player = "givetake1_a", Ped = "givetake1_b"}
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
	for Index = 1, 19 do
		Weed.Plants[Index] = {Start = 0, End = 0}
	end
end

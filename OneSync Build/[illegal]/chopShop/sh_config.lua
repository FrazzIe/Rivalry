Config = {
	CarsPerList = { Min = 7, Max = 10 },
	ListDuration = { Min = 25, Max = 35 },
	Cops = { Min = 2, Max = 10, MaxRate = 2.0 },
	Zones = {
		--[[ Chop Zones ]]--
		-- Hayes Auto.
		{ Type = 0, Visibility = 10.0, Radius = 3.0, Chance = 100, Coords = vector3(494.64892578125, -1328.0593261719, 29.339990615845) },

		-- Boneyard
		{ Type = 0, Visibility = 10.0, Radius = 3.0, Chance = 100, Coords = vector3(2342.3835449219, 3052.4152832031, 48.151817321777) },

		--[[ Informants ]]--
		-- Hayes Auto.
		{ Type = 1, Visibility = 50.0, Radius = 1.5, Chance = 100, Coords = vector3(474.52053833008, -1309.7144775391, 29.206663131714), Peds = {
			{ Model = "g_m_importexport_01" },
			{ Model = "g_m_m_mexboss_02" },
			{ Model = "g_m_y_armgoon_02" },
			{ Model = "g_m_y_azteca_01" },
		}, Heading = 190.47058105469},

		-- La Puerta Scrap Yard
		{ Type = 1, Visibility = 50.0, Radius = 1.5, Chance = 50, Coords = vector3(-542.38568115234, -1636.5914306641, 19.062301635742), Peds = {
			{ Model = "g_m_m_armboss_01" },
		}, Heading = 94.182029724121},
		
		-- La Puerta Garbage Disposal
		{ Type = 1, Visibility = 50.0, Radius = 1.5, Chance = 50, Coords = vector3(-332.68402099609, -1554.4663085938, 27.718605041504), Peds = {
			{ Model = "cs_brad" },
		}, Heading = 324.99084472656},
		
		-- Boneyard
		{ Type = 1, Visibility = 50.0, Radius = 1.5, Chance = 75, Coords = vector3(2401.2541503906, 3124.6650390625, 48.152935028076), Peds = {
			{ Model = "ig_cletus" },
		}, Heading = 204.67668151855},
		
		-- Joshua Road
		{ Type = 1, Visibility = 50.0, Radius = 1.5, Chance = 50, Coords = vector3(183.25653076172, 2791.0148925781, 45.603225708008), Peds = {
			{ Model = "s_m_y_construct_01" },
		}, Heading = 312.94845581055},
		
		-- Senora Road Gas Station
		{ Type = 1, Visibility = 50.0, Radius = 1.5, Chance = 50, Coords = vector3(264.29803466797, 2591.90625, 45.0563621521), Peds = {
			{ Model = "s_m_m_autoshop_02" },
		}, Heading = 164.7827911377},
	},
	Cars = {
		{ Model = "Adder", BasePrice = 5000, Chance = 10 },
		{ Model = "Akuma", BasePrice = 1500, Chance = 80 },
		{ Model = "Alpha", BasePrice = 1875, Chance = 30 },
		{ Model = "Asea", BasePrice = 1500, Chance = 50 },
		{ Model = "Bagger", BasePrice = 1500, Chance = 90 },
		{ Model = "Banshee", BasePrice = 1875, Chance = 10 },
		{ Model = "Banshee2", BasePrice = 1875, Chance = 10 },
		{ Model = "Bati", BasePrice = 1500, Chance = 30 },
		{ Model = "Bifta", BasePrice = 1500, Chance = 50 },
		{ Model = "Bjxl", BasePrice = 1500, Chance = 50 },
		{ Model = "Buffalo", BasePrice = 1875, Chance = 90 },
		{ Model = "Bullet", BasePrice = 2625, Chance = 10 },
		{ Model = "Caddy", BasePrice = 1500, Chance = 20 },
		{ Model = "Caddy2", BasePrice = 1500, Chance = 20 },
		{ Model = "Coquette", BasePrice = 2250, Chance = 20 },
		{ Model = "Dilettante", BasePrice = 1500, Chance = 50 },
		{ Model = "Dubsta", BasePrice = 1875, Chance = 40 },
		{ Model = "Dubsta2", BasePrice = 2250, Chance = 40 },
		{ Model = "Enduro", BasePrice = 1500, Chance = 40 },
		{ Model = "Esskey", BasePrice = 1500, Chance = 45 },
		{ Model = "F620", BasePrice = 1500, Chance = 40 },
		{ Model = "Faction", BasePrice = 1500, Chance = 50 },
		{ Model = "Felon", BasePrice = 1500, Chance = 30 },
		{ Model = "Feltzer2", BasePrice = 2250, Chance = 85 },
		{ Model = "Fusilade", BasePrice = 1875, Chance = 20 },
		{ Model = "Glendale", BasePrice = 1500, Chance = 50 },
		{ Model = "Granger", BasePrice = 1500, Chance = 50 },
		{ Model = "Habanero", BasePrice = 1500, Chance = 50 },
		{ Model = "Issi2", BasePrice = 1500, Chance = 50 },
		{ Model = "Jester", BasePrice = 2250, Chance = 40 },
		{ Model = "Jester2", BasePrice = 3000, Chance = 40 },
		{ Model = "Kalahari", BasePrice = 1500, Chance = 50 },
		{ Model = "Massacro", BasePrice = 2250, Chance = 30 },
		{ Model = "Mesa", BasePrice = 1500, Chance = 45 },
		{ Model = "Mesa3", BasePrice = 1500, Chance = 50 },
		{ Model = "Mower", BasePrice = 1500, Chance = 20 },
		{ Model = "Ninef", BasePrice = 2250, Chance = 20 },
		{ Model = "Ninef2", BasePrice = 2625, Chance = 25 },
		{ Model = "Oracle", BasePrice = 1500, Chance = 50 },
		{ Model = "Panto", BasePrice = 1500, Chance = 50 },
		{ Model = "Patriot", BasePrice = 1500, Chance = 60 },
		{ Model = "Phoenix", BasePrice = 1500, Chance = 50 },
		{ Model = "Premier", BasePrice = 1500, Chance = 50 },
		{ Model = "Rebel", BasePrice = 1500, Chance = 40 },
		{ Model = "Rebel2", BasePrice = 1500, Chance = 50 },
		{ Model = "Regina", BasePrice = 1500, Chance = 50 },
		{ Model = "Rentalbus", BasePrice = 1500, Chance = 70 },
		{ Model = "Rhapsody", BasePrice = 1500, Chance = 50 },
		{ Model = "Rocoto", BasePrice = 1500, Chance = 50 },
		{ Model = "Sabregt", BasePrice = 2250, Chance = 60 },
		{ Model = "Sandking", BasePrice = 1500, Chance = 50 },
		{ Model = "Sandking2", BasePrice = 1500, Chance = 40 },
		{ Model = "Schafter2", BasePrice = 2250, Chance = 50 },
		{ Model = "Schafter3", BasePrice = 1800, Chance = 20 },
		{ Model = "Schafter4", BasePrice = 1800, Chance = 30 },
		{ Model = "Seminole", BasePrice = 1500, Chance = 35 },
		{ Model = "Sentinel", BasePrice = 2250, Chance = 50 },
		{ Model = "Sentinel2", BasePrice = 2250, Chance = 100 },
		{ Model = "Sovereign", BasePrice = 1500, Chance = 80 },
		{ Model = "Speedo", BasePrice = 1500, Chance = 70 },
		{ Model = "Stretch", BasePrice = 2250, Chance = 20 },
		{ Model = "Sultan", BasePrice = 1875, Chance = 80 },
		{ Model = "Superd", BasePrice = 3750, Chance = 50 },
		{ Model = "Taco", BasePrice = 1500, Chance = 70 },
		{ Model = "Tourbus", BasePrice = 1500, Chance = 70 },
		{ Model = "Turismor", BasePrice = 3000, Chance = 10 },
		{ Model = "Voltic", BasePrice = 3000, Chance = 10 },
		{ Model = "Voodoo", BasePrice = 1500, Chance = 60 },
		{ Model = "Washington", BasePrice = 1500, Chance = 70 },
		{ Model = "Xls", BasePrice = 1500, Chance = 45 },
		{ Model = "Youga", BasePrice = 1500, Chance = 60 },
		{ Model = "Zentorno", BasePrice = 5000, Chance = 10 },
	},
	-- The object informants hold.
	HeldObject = {
		Model = "prop_notepad_01",
		Rot = vector3(90.0, 0.0, 0.0),
		Pos = vector3(-0.1, 0.01, 0.0),
	},
	-- The animation informants perform.
	Anim = {
		Dict = "misslsdhsclipboard@idle_a",
		Name = "idle_c",
	}
}
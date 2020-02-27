Config = {
	CarsPerList = { Min = 10, Max = 15 },
	ChopsPerCar = 1,
	ListDuration = { Min = 30, Max = 40 },
	Cops = { Min = 2, Max = 10, MaxRate = 1.5 },
	Components = {
		{ Name = "engine", Type = -1, Index = 0, Offset = vector3(0, 0, -0.5) },
		{ Name = "door_dside_f", Type = 0, Index = 0, Offset = vector3(0.5, 0.5, 0) },
		{ Name = "door_dside_r", Type = 0, Index = 2, Offset = vector3(0.5, 0.5, 0) },
		{ Name = "door_pside_f", Type = 0, Index = 1, Offset = vector3(-0.5, 0.5, 0) },
		{ Name = "door_pside_r", Type = 0, Index = 3, Offset = vector3(-0.5, 0.5, 0) },
		{ Name = "bonnet", Type = 0, Index = 4, Offset = vector3(0, -1.5, 0) },
		{ Name = "boot", Type = 0, Index = 5, Offset = vector3(0, 1.0, 0) },
		{ Name = "wheel_lf", Type = 1, Index = 0, Offset = vector3(0.5, 0, 0) },
		{ Name = "wheel_lr", Type = 1, Index = 4, Offset = vector3(0.5, 0, 0) },
		{ Name = "wheel_rf", Type = 1, Index = 1, Offset = vector3(-0.5, 0, 0) },
		{ Name = "wheel_rr", Type = 1, Index = 5, Offset = vector3(-0.5, 0, 0) },
		-- { Name = "wheel_lm1", Type = 1, Index = 0 },
		-- { Name = "wheel_lm2", Type = 1, Index = 0 },
		-- { Name = "wheel_lm3", Type = 1, Index = 0 },
		-- { Name = "wheel_rm1", Type = 1, Index = 0 },
		-- { Name = "wheel_rm2", Type = 1, Index = 0 },
		-- { Name = "wheel_rm3", Type = 1, Index = 0 },
	},
	ComponentRange = 1.5,
	Zones = {
		--[[ Chop Zones ]]--
		-- Hayes Auto.
		{ Type = 0, Visibility = 10.0, Radius = 5.0, Chance = 100, Coords = vector3(481.17077636719, -1317.1510009766, 29.202482223511) },
		-- { Type = 0, Visibility = 10.0, Radius = 5.0, Chance = 100, Coords = vector3(493.9108581543, -1333.1116943359, 29.333877563477) }, -- DEBUG

		-- Boneyard
		{ Type = 0, Visibility = 10.0, Radius = 5.0, Chance = 100, Coords = vector3(2342.3835449219, 3052.4152832031, 48.151817321777) },

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
		{ Model = "Akuma", BasePrice = 1000 },
		{ Model = "Alpha", BasePrice = 1875 },
		{ Model = "Asea", BasePrice = 1000 },
		{ Model = "Bagger", BasePrice = 1000 },
		{ Model = "Banshee", BasePrice = 2000 },
		{ Model = "Banshee2", BasePrice = 2000 },
		{ Model = "Bati", BasePrice = 1000 },
		{ Model = "Bifta", BasePrice = 1000 },
		{ Model = "Bjxl", BasePrice = 1000 },
		{ Model = "Buffalo", BasePrice = 1500 },
		{ Model = "Bullet", BasePrice = 2500 },
		{ Model = "Bullet", BasePrice = 3000 },
		{ Model = "Caddy", BasePrice = 2000 },
		{ Model = "Caddy2", BasePrice = 2000 },
		{ Model = "Comet2", BasePrice = 2000 },
		{ Model = "Coquette", BasePrice = 2500 },
		{ Model = "Dilettante", BasePrice = 1000 },
		{ Model = "Dubsta2", BasePrice = 2000 },
		{ Model = "Enduro", BasePrice = 1000 },
		{ Model = "Esskey", BasePrice = 1000 },
		{ Model = "F620", BasePrice = 1000 },
		{ Model = "Faction", BasePrice = 1000 },
		{ Model = "Felon", BasePrice = 1000 },
		{ Model = "Feltzer2", BasePrice = 1750 },
		{ Model = "Fusilade", BasePrice = 1500 },
		{ Model = "Glendale", BasePrice = 1000 },
		{ Model = "Granger", BasePrice = 1000 },
		{ Model = "Habanero", BasePrice = 1000 },
		{ Model = "Infernus", BasePrice = 3000 },
		{ Model = "Ingot", BasePrice = 1000 },
		{ Model = "Issi2", BasePrice = 1000 },
		{ Model = "Jester", BasePrice = 2250 },
		{ Model = "Kalahari", BasePrice = 1000 },
		{ Model = "Massacro", BasePrice = 2250 },
		{ Model = "Mesa", BasePrice = 1000 },
		{ Model = "Mesa3", BasePrice = 1000 },
		{ Model = "Mower", BasePrice = 3000 },
		{ Model = "Ninef", BasePrice = 2250 },
		{ Model = "Ninef2", BasePrice = 2625 },
		{ Model = "Oracle", BasePrice = 1000 },
		{ Model = "Panto", BasePrice = 1000 },
		{ Model = "Patriot", BasePrice = 1000 },
		{ Model = "Phoenix", BasePrice = 1000 },
		{ Model = "Premier", BasePrice = 1000 },
		{ Model = "Rebel", BasePrice = 1000 },
		{ Model = "Rebel2", BasePrice = 1000 },
		{ Model = "Regina", BasePrice = 1000 },
		{ Model = "Rentalbus", BasePrice = 1000 },
		{ Model = "Rhapsody", BasePrice = 1000 },
		{ Model = "Rocoto", BasePrice = 1000 },
		{ Model = "Sabregt", BasePrice = 1500 },
		{ Model = "Sandking", BasePrice = 1500 },
		{ Model = "Sandking2", BasePrice = 1500 },
		{ Model = "Schafter2", BasePrice = 1750 },
		{ Model = "Schafter3", BasePrice = 1750 },
		{ Model = "Schafter4", BasePrice = 1750 },
		{ Model = "Seminole", BasePrice = 1000 },
		{ Model = "Sentinel", BasePrice = 2000 },
		{ Model = "Sentinel2", BasePrice = 2050 },
		{ Model = "Sovereign", BasePrice = 1000 },
		{ Model = "Speedo", BasePrice = 1000 },
		{ Model = "Stretch", BasePrice = 2250 },
		{ Model = "Sultan", BasePrice = 1750 },
		{ Model = "Superd", BasePrice = 3500 },
		{ Model = "Taco", BasePrice = 1000 },
		{ Model = "Tourbus", BasePrice = 1000 },
		{ Model = "Turismor", BasePrice = 3000 },
		{ Model = "Voltic", BasePrice = 3000 },
		{ Model = "Voodoo", BasePrice = 1000 },
		{ Model = "Washington", BasePrice = 1000 },
		{ Model = "Xls", BasePrice = 1000 },
		{ Model = "Youga", BasePrice = 1500 },
		{ Model = "Zentorno", BasePrice = 5000 },
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
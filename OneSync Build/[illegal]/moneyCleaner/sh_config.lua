Config = {
	-- Machine cleaning progress is communicated via markers.
	Marker = {
		DefaultColor = {r=0,g=0,b=0},
		FinishedColor = {r=32,g=220,b=32},
		Size = 1.2,
		Thickness = 0.3,
	},
	-- Settings for how money is cleaned.
	Cleaning = {
		MaxDirty = 10000, -- How much dirty can fit into a single machine.
		Duration = 9, -- In minutes, time to clean.
		MinDuration = 2, -- In seconds, the lowest time for everything when cleaning $1.
		StartDuration = 30, -- In seconds, time to put money in.
		EndDuration = 30, -- In seconds, time to take money out.
	},
	-- The zone in which players receive script data.
	Interior = {
		Coords = vector3(1129.5407714844, -3196.5239257813, -39.665668487549),
		Radius = 20,
	},
	-- Vectors for the positions of each machine.
	Machines = {
		vector3(1122.3518066406, -3194.9654296875, -40.401798248291),
		vector3(1123.7712402344, -3194.9654296875, -40.402084350586),
		vector3(1125.5189208984, -3194.923828125, -40.401298522949),
		vector3(1126.9539794922, -3194.923828125, -40.400913238525),
	},
}
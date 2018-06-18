Config = {
	Garages = {
		["Car"] = {
			[1] = {
				Name = "",
				Cost = 30000,
				Slots = 20,
				Blip = {Name = "Garage", Colour = 1, Sprite = 357},
				Coordinates = {x = -326.56234741211, y = -764.39398193359, z = 33.965507507324, h = 146.33236694336},
			},
		},
		["Bicycle"] = {},
		["Helicopter"] = {},
		["Plane"] = {},
		["Boat"] = {},
	},
	Insurance = {
		[1] = {
			Blip = {Name = "Garage", Colour = 69, Sprite = 498},
			Coordinates = {x = -302.34985351563, y = -766.90270996094, z = 33.966426849365, h = 253.88024902344},
		},
	},
	Selling = {
		[1] = {
			Blip = {Name = "Sell Vehicle", Colour = 1, Sprite = 225},
			Coordinates = {x = -44.919033050537, y = -1082.6441650391, z = 26.685247421265, h = 253.88024902344},
		},
	},
	Dealership = {
		Locations = {
			["Car"] = {
				[1] = {
					Marker = {x = -33.491161346436, y = -1102.2437744141, z = 26.422353744507, h = 0}, 
					Inside = {x = -46.56327, y = -1097.382, z = 25.99875, h = 120.1953}, 
					Exit = {x = -55.709060668945, y = -1109.1584472656, z = 26.435792922974, h = 72.441734313965},
					Blip = {Name = "Automobile store", Colour = 69, Sprite = 225},
				},
			},
			["Bicycle"] = {},
			["Helicopter"] = {},
			["Plane"] = {
				[1] = {
					Marker = {x = -986.94775390625, y = -2950.6008300781, z = 13.945072174072, h = 60.374202728271},
					Inside = {x = -957.62414550781, y = -2987.89453125, z = 13.945081710815, h = 240.56701660156}, 
					Exit = {x = -55.709060668945, y = -1109.1584472656, z = 26.435792922974, h = 72.441734313965},
					Blip = {Name = "Aircraft store", Colour = 69, Sprite = 307},
				},
			},
			["Boat"] = {},
		},
		Vehicles = {
			["Car"] = {
				[1] = {
					Title = "Super",
					Items = {
						[1] = {Name = "Tursimor", Price = 1, Model = "turismor"},
						[2] = {Name = "Visione", Price = 1, Model = "visione"},
					},
				},
			},
			["Bicycle"] = {},
			["Helicopter"] = {},
			["Plane"] = {
				[1] = {
					Title = "Buckingham",
					Items = {
						[1] = {Name = "Alpha-Z1", Price = 0, Model = "alphaz1"},
						[2] = {Name = "Howard NX-25", Price = 0, Model = "howard"},
						[3] = {Name = "Luxor", Price = 0, Model = "luxor"},
						[4] = {Name = "Luxor Deluxe", Price = 0, Model = "luxor2"},
						[5] = {Name = "Miljet", Price = 0, Model = "miljet"},
						[6] = {Name = "Nimbus", Price = 0, Model = "nimbus"},
						[7] = {Name = "Pyro", Price = 0, Model = "pyro"},
						[8] = {Name = "Shamal", Price = 0, Model = "shamal"},
						[9] = {Name = "Vestra", Price = 0, Model = "vestra"},
					},
				},
				[2] = {
					Title = "Jobuilt",
					Items = {
						[1] = {Name = "Mammatus", Price = 0, Model = "mammatus"},
						[2] = {Name = "P-996 LAZER", Price = 0, Model = "lazer"},
						[3] = {Name = "Velum", Price = 0, Model = "velum"},
					},
				},
				[3] = {
					Title = "Mammoth",
					Items = {
						[1] = {Name = "Hydra", Price = 0, Model = "hydra"},
						[2] = {Name = "Mogul", Price = 0, Model = "mogul"},
						[3] = {Name = "Tula", Price = 0, Model = "tula"},
					},
				},
				[4] = {
					Title = "Western",
					Items = {
						[1] = {Name = "Besra", Price = 0, Model = "besra"},
						[2] = {Name = "Cuban 800", Price = 0, Model = "cuban800"},
						[3] = {Name = "Duster", Price = 0, Model = "duster"},
						[4] = {Name = "Mallard", Price = 0, Model = "stunt"},
						[5] = {Name = "Rogue", Price = 0, Model = "rogue"},
						[6] = {Name = "Seabreeze", Price = 0, Model = "seabreeze"},
					},
				},
				[5] = {
					Title = "Other",
					Items = {
						[1] = {Name = "Atomic Blimp", Price = 0, Model = "blimp"},
						[2] = {Name = "Avenger", Price = 0, Model = "avenger"},
						[3] = {Name = "Cargo Plane", Price = 0, Model = "cargoplane"},
						[4] = {Name = "Dodo", Price = 0, Model = "dodo"},
						[5] = {Name = "Jet", Price = 0, Model = "jet"},
						[6] = {Name = "LF-22 Starling", Price = 0, Model = "starling"},
						[7] = {Name = "Nagasaki Ultralight", Price = 0, Model = "microlight"},
						[8] = {Name = "P-45 Nokota", Price = 0, Model = "nokota"},
						[9] = {Name = "RM-10 Bombushka", Price = 0, Model = "bombushka"},
						[10] = {Name = "Titan", Price = 0, Model = "titan"},
						[11] = {Name = "V-65 Molotok", Price = 0, Model = "molotok"},
						[12] = {Name = "Volatol", Price = 0, Model = "volatol"},
					},
				},
			},
			["Boat"] = {},
		},
		Sprites = {
			["Car"] = {
				Dictionary = "shopui_title_ie_modgarage",
				Texture = "shopui_title_ie_modgarage",
			},
			["Helicopter"] = {
				Dictionary = "",
				Texture = "",
			},
			["Plane"] = {
				Dictionary = "shopui_title_sm_hangar",
				Texture = "shopui_title_sm_hangar",
			},
			["Boat"] = {
				Dictionary = "dock_dlc_banner",
				Texture = "yacht_banner_5",
			},
		},
		Test = {
			Coordinates = {x = 3010.5366210938, y = -4619.1669921875, z = 14.841909408569, h = 205.14440917969},
			Time = 0,
		},
	},
}
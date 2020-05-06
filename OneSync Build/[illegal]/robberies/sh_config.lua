Config = {
	--[[
		Most times are converted to seconds or minutes.
	]]--
	Debug = false,
	DefaultCops = 4,
	DispatchCooldown = 90,
	BlackMarket = {
		{
			Coords = vector4(707.3759765625, -966.97192382813, 30.41284942627, 175.78880310059),
			Items = { {134,500} },
			Text = "Sell Jewelery",
			Label = "Placing The Order",
			Duration = 60,
			Anim = {
				animDict = "anim@amb@warehouse@laptop@",
				anim = "idle_a",
				flags = 17,
			},
		},
	},
	Cameras = {
		["hei_prop_bank_cctv_01"] = { Heading = 180 },
		["hei_prop_bank_cctv_02"] = { Heading = 180 },
		["p_cctv_s"] = { Heading = 180 },
		["prop_cctv_cam_01a"] = { Heading = 180, Offset = vector3(0.0, -0.4, -0.4) },
		["prop_cctv_cam_01b"] = { Heading = 180 },
		["prop_cctv_cam_02a"] = { Heading = 180 },
		["prop_cctv_cam_03a"] = { Heading = 180 },
		["prop_cctv_cam_04a"] = { Heading = 180 },
		["prop_cctv_cam_04b"] = { Heading = 180 },
		["prop_cctv_cam_04c"] = { Heading = 180 },
		["prop_cctv_cam_05a"] = { Heading = 180 },
		["prop_cctv_cam_06a"] = { Heading = 180 },
		["prop_cctv_cam_07a"] = { Heading = 180 },
		["prop_cctv_pole_01a"] = { Heading = 180 },
		["prop_cctv_pole_02"] = { Heading = 180 },
		["prop_cctv_pole_03"] = { Heading = 180 },
		["prop_cctv_pole_04"] = { Heading = 180 },
		["prop_cs_cctv"] = { Heading = 180 },
		["prop_snow_cam_03a"] = { Heading = 180 },
	},
	StatusErrors = {
		[-1] = "There's an increase in security right now...",
		[-2] = "Nothing...",
		[-3] = "Somebody is already robbing that...",
		[-4] = "There's an order to everything...",
		[-5] = "Temporarily on lockdown...",
	},
	GlobalCooldowns = {
		["Small"] = 20,
		["Large"] = 40,
	},
	Robbables = {
		["Register"] = {
			Armed = true,
			Stages = {
				{
					Duration = 5,
					Text = "Breaking",
					Anim = {
						animDict = "missheist_jewel",
						anim = "smash_case",
						flags = 16,
					},
				},
				{
					Duration = 60,
					Text = "Taking",
					Anim = {
						animDict = "oddjobs@shop_robbery@rob_till",
						anim = "loop",
					},
					Payouts = {1000/60*5,2000/60*5},
					PayoutInterval = 5.0,
					CooldownOnCancel = true,
				},
			},
			Models = {
				["p_till_01_s"] = {},
				["prop_till_01_dam"] = {},
				["prop_till_01"] = {},
				["prop_till_02"] = {},
			},
			Offset = vector3(0.0, -0.4, 0.0),
		},
		["Register2"] = {
			Stages = {
				{
					Minigame = {
						Type = "Hacking",
						Phases = 1,
						Length = 4,
						Duration = 15,
					},
					Duration = 1,
					Anim = {
						animDict = "anim@heists@humane_labs@emp@hack_door",
						anim = "hack_loop",
					},
				},
				{
					Duration = 60,
					Text = "Taking",
					Anim = {
						animDict = "oddjobs@shop_robbery@rob_till",
						anim = "loop",
					},
					Payouts = {1000/60*5,2000/60*5},
					PayoutInterval = 5.0,
					CooldownOnCancel = true,
				},
			},
			Models = {
				["prop_till_03"] = {},
			},
			Offset = vector3(0.0, -0.4, 0.0),
		},
		["SafeE"] = {
			Stages = {
				{
					Minigame = {
						Type = "Hacking",
						Phases = 6,
						Length = 4,
						Duration = 30,
					},
					Anim = {
						animDict = "anim@heists@humane_labs@emp@hack_door",
						anim = "hack_loop",
					},
				},
				{
					Duration = 210,
					Text = "Taking",
					Anim = {
						animDict = "oddjobs@shop_robbery@rob_till",
						anim = "loop",
					},
					Payouts = {9000/240*5,13000/240*5},
					PayoutInterval = 5.0,
					PayoutItems = { {199, 1, 0.4}, {203, 1, 0.2}, {206, 1, 0.02}, {200, 1, 0.01}, {118, 1, 0.1} },
					Dirty = {0.0,0.5},
					CooldownOnCancel = true,
				},
			}
		},
		["Safe"] = {
			Stages = {
				{
					Duration = 130,
					Text = "Cracking",
					Anim = {
						animDict = "mini@safe_cracking",
						anim = "dial_turn_clock_fast",
					},
				},
				{
					Duration = 90,
					Text = "Taking",
					Anim = {
						animDict = "oddjobs@shop_robbery@rob_till",
						anim = "loop",
					},
					Payouts = {6000/90*5,8000/90*5},
					PayoutInterval = 5.0,
					PayoutItems = { {199, 1, 0.02}, {203, 1, 0.15}, {206, 1, 0.3}, {200, 1, 0.02}, {41, 1, 0.1} },
					Dirty = {0.0,0.5},
					CooldownOnCancel = true,
				},
			}
		},
		["KeypadCard"] = {
			Text = "Swipe Keycard",
			Duration = 2,
			Minigame = {
				Type = "Hacking",
				Phases = 10,
				Length = 4,
				Duration = 30,
			},
			Anim = {
				animDict = "anim@heists@humane_labs@emp@hack_door",
				anim = "hack_loop",
			},
		},
		["Keypad"] = {
			Text = "Hack",
			Duration = 2,
			Minigame = {
				Type = "Hacking",
				Phases = 10,
				Length = 4,
				Duration = 30,
			},
			Anim = {
				animDict = "anim@heists@humane_labs@emp@hack_door",
				anim = "hack_loop",
			},
		},
		["Lockbox"] = {
			Text = "Lockpick",
			Label = "Lockpicking",
			Duration = 30,
			Anim = {
				animDict = "mini@safe_cracking",
				anim = "dial_turn_clock_fast",
			},
			Payouts = {9000,11000},
			PayoutItems = { {200, 1, 0.06}, {202, 1, 0.001} },
			Dirty = {1.0,1.0},
			Items = { 36 },
		},
		["Jewelry"] = {
			Offset = vector3(0.0, -0.8, 0.0),
			Stages = {
				{
					Duration = 6,
					Armed = true,
					Label = "Smashing",
					Anim = {
						animDict = "missheist_jewel",
						anim = "smash_case",
						flags = 16,
					},
				},
				{
					Duration = 10,
					Label = "Grabbing",
					Anim = {
						animDict = "oddjobs@shop_robbery@rob_till",
						anim = "loop",
					},
					PayoutItems = { {131, 1, 0.001}, {134, {6,8}, 1.0} },
				}
			},
			Models = {
				["prop_j_disptray_01"] = {},
				["prop_j_disptray_01_dam"] = {},
				["prop_j_disptray_01b"] = {},
				["prop_j_disptray_05"] = {},
				["prop_j_disptray_05b"] = {},
				["prop_j_disptray_02_dam"] = {},
				["prop_j_disptray_02"] = {},
				["prop_j_disptray_03"] = {},
				["prop_j_disptray_04b"] = {},
				["prop_j_disptray_04"] = {},
				["prop_j_disptray_03_dam"] = {},
				["des_jewel_cab_start"] = {},
				["des_jewel_cab2_start"] = {},
				["des_jewel_cab3_start"] = {},
				["des_jewel_cab4_start"] = {},
			},
		},
		["JewelryKey"] = {
			Text = "Use Key",
			Label = "Using Key",
			Anim = {
				animDict = "anim@heists@keycard@",
				anim = "idle_a",
				flags = 16,
			},
		},
		["Doors"] = {
			Text = "Blowtorch",
			Label = "Blowtorching",
			Duration = 15,
			IsDoor = true,
			LockTo = false,
			Items = { 82 },
			Offset = vector3(1.2, 0.0, 0.0),
			Models = {
				["v_ilev_gb_vaubar"] = {},
				["v_ilev_cbankvaulgate01"] = { Flipped = true },
				["v_ilev_cbankvaulgate02"] = {},
				["hei_v_ilev_bk_gate_pris"] = {},
				["hei_v_ilev_bk_safegate_pris"] = { Flipped = true },
				["v_ilev_bk_door"] = { Flipped = true },
				["hei_v_ilev_bk_gate2_pris"] = { Hide = true },
				["p_jewel_door_r1"] = { Hide = true },
				["p_jewel_door_l"] = { Hide = true },

				["v_ilev_gb_vauldr"] = {
					Hide = true,
					IsVault = true,
					Banks = {
						["Legion Square Fleeca"] = { closed = 249.84617614746, opened = 159.84617614746 },
						["Hawick Alta Fleeca"] = { closed = 249.86596679688, opened = 159.86596679688 },
						["Boulevard Del Perro Fleeca"] = { closed = 296.86370849609, opened = 206.86370849609 },
						["Hawick Burton Fleeca"] = { closed = 250.85983276367, opened = 160.85983276367 },
						["Route 68 Fleeca"] = { closed = 90.0, opened = 1.0 },
					}
				},

				["hei_prop_heist_sec_door"] = {
					Hide = true,
					IsVault = true,
					Banks = {
						["Great Ocean Highway Fleeca"] = { closed = 357.54205322266, opened = 267.54205322266 },
					}
				},

				["v_ilev_bk_vaultdoor"] = {
					IsVault = true,
					Hide = true,
					Banks = {
						["Pacific Standard"] = { closed = 159.99998474121, opened = 9.99998474121 },
					}
				},

				["v_ilev_cbankvauldoor01"] = {
					IsVault = true,
					Hide = true,
					Banks = {
						["Blaine County Savings"] = { closed = 45.45747375488, opened = 150.45747375488 },
					}
				},
			},
			Anim = {
				task = "WORLD_HUMAN_WELDING",
			},
		},
	},
	Robberies = {
		--[[ Jewelry ]]--
		{
			Name = "Vangelico",
			Type = "Jewelry",
			Size = "Large",
			Cooldown = 1,
			Coords = vector3(-623.96948242188, -232.09579467773, 38.057037353516),
			Dist = 40.0,
			EssentialOrder = true,
			Robbables = {
				{ Id = "JewelryKey", Coords = { vector4(-631.59637451172, -237.74882507324, 38.076557159424, 308.51892089844) }, Unlocks = { vector3(-631.95538330078, -236.33326721191, 38.206531524658), vector3(-630.42651367188, -238.43754577637, 38.206531524658) }, Items = { 203 } },
				"Jewelry",
				"Register2",
			},
		},
		--[[ Convenience ]]--
		{
			Name = "Downtown Vinewood",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(377.9775390625, 326.87213134766, 103.56639099121),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(378.15478515625, 333.39312744141, 103.56637573242, -18.432706832886),
				}},
			},
		},
		{
			Name = "Chiliad",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(1733.0947265625, 6415.427734375, 35.162433624268),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(1734.8751220703, 6420.8642578125, 35.037261962891, 332.57153320313),
				}},
			},
		},
		{
			Name = "Banham Canyon",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(-3043.2700195313, 588.60424804688, 7.9089293479919),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(-3047.8376464844, 585.74182128906, 7.9089279174805, 108.51442718506),
				}},
			},
		},
		{
			Name = "Grapeseed",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(1702.4029541016, 4926.0805664063, 42.063629150391),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(1707.9051513672, 4920.4638671875, 42.063629150391, 335.17602539063),
				}},
			},
		},
		{
			Name = "Sandy Shores",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(1963.2877197266, 3744.7551269531, 32.343738555908),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(1959.3488769531, 3749.017578125, 32.343738555908, 43.164211273193),
				}},
			},
		},
		{
			Name = "Harmony",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(544.38342285156, 2668.4165039063, 42.156490325928),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(546.46301269531, 2662.7673339844, 42.156490325928, 183.9690246582),
				}},
			},
		},
		{
			Name = "Senora Fwy",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(2678.2565917969, 3285.1193847656, 55.241123199463),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(2672.75390625, 3286.7185058594, 55.24112701416, 59.721073150635),
				}},
			},
		},
		{
			Name = "Palomino Fwy",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(2555.1096191406, 386.06909179688, 108.62293243408),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(2549.1882324219, 384.95104980469, 108.62293243408, 90.071022033691),
				}},
			},
		},
		{
			Name = "Palomino Fwy",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(2555.1096191406, 386.06909179688, 108.62293243408),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(2549.1882324219, 384.95104980469, 108.62293243408, 90.071022033691),
				}},
			},
		},
		{
			Name = "Richman Glen",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(-1825.4011230469, 792.63500976563, 138.19227600098),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(-1829.2590332031, 798.82141113281, 138.19187927246, 139.10377502441),
				}},
			},
		},
		{
			Name = "Mirror Park",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(1159.365234375, -321.47192382813, 69.205047607422),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(1159.5002441406, -313.97952270508, 69.205047607422, 112.25310516357),
				}},
			},
		},
		{
			Name = "Grove Street",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(-48.604434967041, -1753.2189941406, 29.421014785767),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(-43.508350372314, -1748.3840332031, 29.421020507813, 50.213455200195),
				}},
			},
		},
		{
			Name = "Little Seoul",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(-711.10052490234, -911.84265136719, 19.215585708618),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(-709.68237304688, -904.16809082031, 19.215585708618, 87.91544342041),
				}},
			},
		},
		{
			Name = "Innocence Blvd",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(29.453075408936, -1344.6448974609, 29.497024536133),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(28.228527069092, -1339.2299804688, 29.497024536133, 2.1247074604034),
				}},
			},
		},
		{
			Name = "Chumash",
			Type = "Convenience",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(-3244.5666503906, 1004.6326904297, 12.830706596375),
			Cops = 3,
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(-3249.6889648438, 1004.3167114258, 12.830706596375, 74.851501464844),
				}},
			},
		},
		--[[ Liquor Store ]]--
		{
			Name = "Prosperity",
			Type = "Liquor",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(-1483.0372314453, -376.53033447266, 40.163425445557),
			Cops = 2,
			Robbables = {
				"Register",
				{ Id = "Safe", Coords = {
					vector4(-1478.9112548828, -375.37426757813, 39.16340637207, -134.67640686035),
				}}
			},
		},
		{
			Name = "Great Ocean Highway",
			Type = "Liquor",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(-2966.4519042969, 390.80426025391, 15.043314933777),
			Cops = 2,
			Robbables = {
				"Register",
				{ Id = "Safe", Coords = {
					vector4(-2959.6799316406, 387.05981445313, 14.043293952942, 177.80445861816),
				}}
			},
		},
		{
			Name = "El Rancho Blvd",
			Type = "Liquor",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(1134.2449951172, -982.60424804688, 46.415798187256),
			Cops = 2,
			Robbables = {
				"Register",
				{ Id = "Safe", Coords = {
					vector4(1126.7998046875, -980.05847167969, 45.415832519531, 12.381150245667),
				}}
			},
		},
		{
			Name = "Vespucci Canals",
			Type = "Liquor",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(-1222.0015869141, -908.29229736328, 12.326356887817),
			Cops = 2,
			Robbables = {
				"Register",
				{ Id = "Safe", Coords = {
					vector4(-1220.8616943359, -916.07708740234, 11.326334953308, 125.43096923828),
				}}
			},
		},
		{
			Name = "Route 68",
			Type = "Liquor",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(1166.4122314453, 2710.94140625, 38.157699584961),
			Cops = 2,
			Robbables = {
				"Register",
				{ Id = "Safe", Coords = {
					vector4(1169.1762695313, 2717.88671875, 37.157646179199, 266.54766845703),
				}}
			},
		},
		--[[ Banks ]]--
		{
			Name = "Pacific Standard",
			Type = "Bank",
			Size = "Large",
			Cooldown = 60,
			Coords = vector3(251.68597412109, 220.39694213867, 107.4554901123),
			Cops = 5,
			Dist = 30.0,
			EssentialOrder = true,
			Robbables = {
				"Doors",
				{ Id = "KeypadCard", Coords = { vector4(261.94366455078, 223.14025878906, 106.28412628174, 253.68258666992) }, Unlocks = { vector3(262.19808959961, 222.51879882813, 106.42955780029), vector3(256.31155395508, 220.65785217285, 106.42955780029) }, Items = { 200 } },
				{ Id = "Keypad", Coords = { vector4(253.24989318848, 228.38319396973, 101.68328094482, 69.527816772461) }, Unlocks = { vector3(255.22825622559, 223.97601318359, 102.39321899414) }, Opens = true },
				{ Id = "Drill", Coords = { vector4(0,0,0,0) }, Unlocks = {  }, Opens = true, Items = { 205 } },
				{ Id = "Lockbox", Coords = {
					vector4(258.17916870117, 218.10890197754, 101.68346405029, 342.15524291992),
					vector4(259.59515380859, 217.49711608887, 101.68346405029, 340.09521484375),
					vector4(261.09252929688, 217.11462402344, 101.68346405029, 349.02883911133),
					vector4(263.34353637695, 216.32708740234, 101.68346405029, 347.9567565918),
					vector4(264.60192871094, 215.78988647461, 101.68346405029, 346.51644897461),
					vector4(266.06744384766, 215.23239135742, 101.68346405029, 356.45422363281),
					vector4(266.10479736328, 214.73373413086, 101.68346405029, 256.79290771484),
					vector4(265.71151733398, 213.4893951416, 101.68346405029, 258.72463989258),
					vector4(265.30511474609, 212.37396240234, 101.68346405029, 253.91473388672),
					vector4(264.61572265625, 212.26393127441, 101.68346405029, 158.12306213379),
					vector4(263.43124389648, 212.58543395996, 101.68346405029, 176.6276550293),
					vector4(262.21124267578, 213.1026763916, 101.68346405029, 158.48345947266),
					vector4(259.837890625, 213.98301696777, 101.68346405029, 165.41535949707),
					vector4(258.37365722656, 214.53475952148, 101.68346405029, 161.1852722168),
					vector4(256.83331298828, 215.05879211426, 101.68346405029, 171.20146179199),
				}},
			}
		},
		{
			Name = "Blaine County Savings",
			Type = "Bank",
			Size = "Large",
			Cooldown = 60,
			Coords = vector3(-108.1021194458, 6471.7890625, 31.626708984375),
			Cops = 4,
			Dist = 40.0,
			EssentialOrder = true,
			Robbables = {
				"Doors",
				{ Id = "Keypad", Required = true, Coords = { vector4(-105.6590423584, 6471.8740234375, 31.626710891724, 44.672233581543) }, Unlocks = { vector3(-104.60489654541, 6473.4438476563, 31.795324325562) }, Items = { 206 }, Opens = true },
				{ Id = "Lockbox", Coords = {
					vector4(-106.83989715576, 6473.7822265625, 31.62671661377, 129.49356079102),
					vector4(-107.54365539551, 6475.4375, 31.62671661377, 44.569351196289),
					vector4(-105.64981842041, 6478.2983398438, 31.626724243164, 42.255214691162),
					vector4(-104.14318847656, 6478.65625, 31.626714706421, 317.42749023438),
					vector4(-102.8226776123, 6477.3671875, 31.648992538452, 313.60803222656),
					vector4(-103.23392486572, 6475.8081054688, 31.650077819824, 226.50801086426),
				}},
			},
		},
		{
			Name = "Legion Square Fleeca",
			Type = "Bank",
			Size = "Large",
			Cooldown = 60,
			Coords = vector3(146.76416015625, -1042.3675537109, 29.35502243042),
			Cops = 4,
			EssentialOrder = true,
			Robbables = {
				"Doors",
				{ Id = "KeypadCard", Coords = { vector4(146.65238952637, -1045.9155273438, 29.368062973022, 237.57504272461) }, Unlocks = { vector3(148.02661132813, -1044.3638916016, 29.506931304932) }, Opens = true, Items = { 199 } },
				{ Id = "Lockbox", Coords = {
					vector4(150.45735168457, -1049.0686035156, 29.346368789673, 251.63217163086),
					vector4(150.03422546387, -1050.2464599609, 29.346395492554, 245.88400268555),
					vector4(149.00352478027, -1050.4237060547, 29.346382141113, 161.39410400391),
					vector4(147.64898681641, -1050.1656494141, 29.346380233765, 156.41217041016),
					vector4(147.09817504883, -1049.2528076172, 29.346334457397, 70.42049407959),
					vector4(147.44898986816, -1048.1478271484, 29.346305847168, 70.905654907227),
					vector4(150.86470031738, -1046.4660644531, 29.346321105957, 248.17013549805),
					vector4(149.79965209961, -1045.1959228516, 29.346292495728, 337.58755493164),
				}},
			},
		},
		{
			Name = "Great Ocean Highway Fleeca",
			Type = "Bank",
			Size = "Large",
			Cooldown = 60,
			Coords = vector3(-2960.1005859375, 481.53509521484, 15.694672584534),
			Cops = 4,
			Dist = 30.0,
			EssentialOrder = true,
			Robbables = {
				"Doors",
				{ Id = "KeypadCard", Required = true, Coords = { vector4(-2956.8181152344, 481.52600097656, 15.69704914093, 325.39584350586) }, Unlocks = { vector3(-2958.5385742188, 482.27056884766, 15.83594417572) }, Opens = true, Items = { 199 } },
				{ Id = "Lockbox", Coords = {
					vector4(-2958.1977539063, 484.18240356445, 15.675290107727, 88.88117980957),
					vector4(-2957.3857421875, 485.54675292969, 15.675330162048, 4.1140117645264),
					vector4(-2954.6391601563, 486.0475769043, 15.675391197205, 0.35716944932938),
					vector4(-2953.3537597656, 486.06213378906, 15.675423622131, 346.54940795898),
					vector4(-2952.7182617188, 485.13607788086, 15.675386428833, 280.10342407227),
					vector4(-2952.8420410156, 483.36663818359, 15.675375938416, 262.89129638672),
					vector4(-2953.4077148438, 482.64279174805, 15.675329208374, 178.95722961426),
					vector4(-2954.9208984375, 482.74066162109, 15.675303459167, 192.57048034668),
				}},
			},
		},
		{
			Name = "Route 68 Fleeca",
			Type = "Bank",
			Size = "Large",
			Cooldown = 60,
			Coords = vector3(1177.2100830078, 2713.5444335938, 38.066242218018),
			Cops = 4,
			Dist = 30.0,
			EssentialOrder = true,
			Robbables = {
				"Doors",
				{ Id = "KeypadCard", Required = true, Coords = { vector4(1175.9929199219, 2712.7785644531, 38.088035583496, 64.560249328613) }, Unlocks = { vector3(1175.5421142578, 2710.861328125, 38.226890563965) }, Opens = true, Items = { 199 } },
				{ Id = "Lockbox", Coords = {
					vector4(1173.7165527344, 2711.0847167969, 38.066242218018, 184.42008972168),
					vector4(1172.2393798828, 2712.0085449219, 38.066253662109, 94.273643493652),
					vector4(1171.4698486328, 2714.439453125, 38.066314697266, 101.4554977417),
					vector4(1171.6336669922, 2716.0073242188, 38.066349029541, 92.728149414063),
					vector4(1172.3608398438, 2716.5727539063, 38.066345214844, 353.20568847656),
					vector4(1174.1638183594, 2716.6079101563, 38.066345214844, 14.104368209839),
					vector4(1174.9188232422, 2715.8000488281, 38.066299438477, 267.8542175293),
					vector4(1174.9547119141, 2714.2900390625, 38.066265106201, 273.181640625),
				}},
			},
		},
		{
			Name = "Hawick Alta Fleeca",
			Type = "Bank",
			Size = "Large",
			Cooldown = 60,
			Coords = vector3(310.90866088867, -284.16845703125, 54.164768218994),
			Cops = 4,
			Dist = 30.0,
			EssentialOrder = true,
			Robbables = {
				"Doors",
				{ Id = "KeypadCard", Required = true, Coords = { vector4(310.90866088867, -284.16845703125, 54.164768218994, 234.42242431641) }, Unlocks = { vector3(312.35800170898, -282.73013305664, 54.303646087646) }, Opens = true, Items = { 199 } },
				{ Id = "Lockbox", Coords = {
					vector4(314.00421142578, -283.51763916016, 54.142993927002, 339.26080322266),
					vector4(315.21215820313, -284.92947387695, 54.143009185791, 254.87409973145),
					vector4(314.94000244141, -287.47549438477, 54.143070220947, 259.13903808594),
					vector4(314.40521240234, -288.8176574707, 54.143100738525, 258.46829223633),
					vector4(313.54635620117, -289.19934082031, 54.143100738525, 164.82737731934),
					vector4(311.68103027344, -288.42895507813, 54.143081665039, 166.41595458984),
					vector4(311.25888061523, -287.63150024414, 54.143054962158, 80.424499511719),
					vector4(311.72146606445, -286.26651000977, 54.143020629883, 68.955718994141),
				}},
			},
		},
		{
			Name = "Boulevard Del Perro Fleeca",
			Type = "Bank",
			Size = "Large",
			Cooldown = 60,
			Coords = vector3(-1211.0947265625, -336.43792724609, 37.781017303467),
			Cops = 4,
			Dist = 30.0,
			EssentialOrder = true,
			Robbables = {
				"Doors",
				{ Id = "KeypadCard", Required = true, Coords = { vector4(-1211.0947265625, -336.43792724609, 37.781017303467, 273.5866394043) }, Unlocks = { vector3(-1211.2609863281, -334.55960083008, 37.919891357422) }, Opens = true, Items = { 199 } },
				{ Id = "Lockbox", Coords = {
					vector4(-1209.4451904297, -333.88812255859, 37.759254455566, 23.263771057129),
					vector4(-1207.7529296875, -333.98846435547, 37.759258270264, 309.41271972656),
					vector4(-1206.0979003906, -335.83090209961, 37.759311676025, 309.61437988281),
					vector4(-1205.3218994141, -337.37734985352, 37.759346008301, 304.36184692383),
					vector4(-1205.7510986328, -338.0583190918, 37.759346008301, 197.81100463867),
					vector4(-1207.623046875, -338.98324584961, 37.759330749512, 212.63702392578),
					vector4(-1208.3920898438, -338.61978149414, 37.759300231934, 122.75311279297),
					vector4(-1209.0201416016, -337.46514892578, 37.759273529053, 114.67604064941),
				}},
			},
		},
		{
			Name = "Hawick Burton Fleeca",
			Type = "Bank",
			Size = "Large",
			Cooldown = 60,
			Coords = vector3(-354.10775756836, -55.036827087402, 49.036552429199),
			Cops = 4,
			Dist = 30.0,
			EssentialOrder = true,
			Robbables = {
				"Doors",
				{ Id = "KeypadCard", Required = true, Coords = { vector4(-354.10775756836, -55.036827087402, 49.036552429199, 233.99066162109) }, Unlocks = { vector3(-352.73651123047, -53.572479248047, 49.175434112549) }, Opens = true, Items = { 199 } },
				{ Id = "Lockbox", Coords = {
					vector4(-350.94677734375, -54.46981048584, 49.014789581299, 343.78894042969),
					vector4(-349.96099853516, -55.579711914063, 49.014793395996, 258.28460693359),
					vector4(-350.13784790039, -58.35179901123, 49.01485824585, 261.11868286133),
					vector4(-350.75845336914, -59.694267272949, 49.014877319336, 254.62622070313),
					vector4(-351.4665222168, -59.964466094971, 49.014877319336, 169.87905883789),
					vector4(-353.44491577148, -59.279731750488, 49.014869689941, 168.26387023926),
					vector4(-353.79632568359, -58.557247161865, 49.014835357666, 79.18229675293),
					vector4(-353.23724365234, -57.21964263916, 49.014820098877, 74.189987182617),
				}},
			},
		},
	},
}

--[[ Caching ]]--
for name, robbable in pairs(Config.Robbables) do
	if robbable.Models ~= nil then
		robbable.ModelCache = {}
		for model, modelInfo in pairs(robbable.Models) do
			robbable.ModelCache[GetHashKey(model)] = model
		end
	end
end

Config.CameraCache = {}
for model, camera in pairs(Config.Cameras) do
	Config.CameraCache[GetHashKey(model)] = model
end
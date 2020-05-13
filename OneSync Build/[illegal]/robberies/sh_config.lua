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
			Label = "Placing Order",
			Duration = 60,
			Anim = {
				animDict = "anim@amb@warehouse@laptop@",
				anim = "idle_a",
				flags = 17,
			},
		},
		{
			Coords = vector4(569.47454833984, -3126.8127441406, 18.768585205078, 180.95831298828),
			Items = { {211,75000} },
			Text = "Sell Vial",
			Label = "Placing Order",
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
		["Small"] = 30,
		["Large"] = 45,
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
					PayoutItems = { {199, 1, 0.43}, {203, 1, 0.23}, {206, 1, 0.022}, {200, 1, 0.05}, {118, 1, 0.1} },
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
					PayoutItems = { {199, 1, 0.023}, {203, 1, 0.23}, {206, 1, 0.44}, {200, 1, 0.03}, {41, 1, 0.1} },
					Dirty = {0.0,0.5},
					CooldownOnCancel = true,
				},
			}
		},
		["KeypadCard"] = {
			Text = "Swipe Keycard",
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
		["WireBox"] = {
			Text = "Tamper",
			Label = "Blowtorching",
			Duration = 30,
			Anim = {
				task = "WORLD_HUMAN_WELDING",
			},
			Items = { 82 },
		},
		["WireBox2"] = {
			Text = "Tamper",
			Label = "Cutting Wires",
			Duration = 30,
			Anim = {
				task = "WORLD_HUMAN_WELDING",
			},
			Items = { 208 },
		},
		["Locker"] = {
			Text = "Lockpick",
			Label = "Lockpicking",
			Duration = 60,
			Anim = {
				animDict = "mini@safe_cracking",
				anim = "dial_turn_clock_fast",
			},
			Payouts = {0,750},
			PayoutItems = { {208, {1,2}, 0.2}, {39, {1,2}, 0.5}, {34, {1,4}, 0.5} },
			Dirty = {0.0,1.0},
			Items = { 36 },
		},
		["Lockbox"] = {
			Text = "Lockpick",
			Label = "Lockpicking",
			Duration = 60,
			Anim = {
				animDict = "mini@safe_cracking",
				anim = "dial_turn_clock_fast",
			},
			Payouts = {9000,11000},
			PayoutItems = { {200, 1, 0.1125}, {202, 1, 0.01} },
			Dirty = {1.0,1.0},
			Items = { 36 },
		},
		["Lockbox2"] = {
			Text = "Lockpick",
			Label = "Lockpicking",
			Duration = 60,
			Anim = {
				animDict = "mini@safe_cracking",
				anim = "dial_turn_clock_fast",
			},
			Payouts = {9000,11000},
			PayoutItems = { {200, 1, 0.02}, {202, 1, 0.065} },
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
					PayoutItems = { {134, {6,8}, 1.0} },
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
		["LaptopHack"] = {
			Text = "Connect Laptop",
			Minigame = {
				Type = "Hacking",
				Phases = 10,
				Length = 6,
				Duration = 30,
			},
			Anim = {
				animDict = "anim@amb@warehouse@laptop@",
				anim = "idle_a",
			},
			Items = { 209 },
			PayoutItems = { {210,1,1} },
		},
		["LaptopUse"] = {
			Text = "Decrypt Data",
			Minigame = {
				Type = "Hacking",
				Phases = 10,
				Length = 6,
				Duration = 30,
			},
			Anim = {
				animDict = "anim@amb@warehouse@laptop@",
				anim = "idle_a",
			},
			Items = { 209 },
			PayoutItems = { {210,1,1} },
		},
		["Vials"] = {
			Text = "Fill Vials",
			Label = "Filling Vials",
			Duration = 120,
			Anim = {
				animDict = "anim@gangops@morgue@table@",
				anim = "player_search",
				flags = 17,
			},
			PayoutItems = { {211, 1, 1} },
		},
		["Doors"] = {
			Text = "Blowtorch",
			Label = "Blowtorching",
			Duration = 45,
			IsDoor = true,
			LockTo = false,
			Items = { 82 },
			Offset = vector3(1.2, 0.0, 0.0),
			Models = {
				-- ["v_ilev_door_orangesolid"] = { Flipped = true  },
				-- ["v_ilev_gtdoor02"] = {},
				-- ["v_ilev_bl_shutter1"] = { Hide = true },
				-- ["v_ilev_bl_shutter2"] = { Hide = true },
				["v_ilev_serv_door01"] = {},
				["v_ilev_bl_doorsl_l"] = { Hide = true, Size = 2.5 },
				["v_ilev_bl_doorsl_r"] = { Hide = true, Size = 2.5 },
				["v_ilev_bl_door_l"] = { Hide = true },
				["v_ilev_bl_door_r"] = { Hide = true },
				["v_ilev_bl_doorpool"] = {},
				["v_ilev_gb_vaubar"] = {},
				["v_ilev_cbankvaulgate01"] = { Flipped = true },
				["v_ilev_cbankvaulgate02"] = {},
				["hei_v_ilev_bk_gate_pris"] = {},
				["hei_v_ilev_bk_safegate_pris"] = { Flipped = true },
				["v_ilev_bk_door"] = { Flipped = true },
				["hei_v_ilev_bk_gate2_pris"] = { Hide = true },
				["p_jewel_door_r1"] = { Hide = true },
				["p_jewel_door_l"] = { Hide = true },

				-- ["v_ilev_fin_vaultdoor"] = {
				-- 	Hide = true
				-- 	IsVault = true,
				-- 	Banks = {
				-- 		["Union Depository"] = { closed = 0.0, opened = 0.0 }
				-- 	}
				-- },

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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Convenience Store",
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
			Type = "Liquor Store",
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
			Type = "Liquor Store",
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
			Type = "Liquor Store",
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
			Type = "Liquor Store",
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
			Type = "Liquor Store",
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
		-- {
		-- 	Name = "Maze Bank Arena",
		-- 	Type = "",
		-- 	Size = "Large",
		-- 	Cooldown = 60,
		-- 	Coords = vector3(-253.06726074219, -2007.0499267578, 29.872577667236),
		-- 	Cops = 5,
		-- 	Dist = 30.0,
		-- 	EssentialOrder = true,
		-- 	Robbables = {
		-- 		"Doors",
		-- 		{ Id = "LaptopUse", Coords = { vector4(-226.38526916504, -1999.5289306641, 24.685373306274, 345.65093994141) }, Items = { 210 } },
		-- 	}
		-- },
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
				-- { Id = "Drill", Coords = { vector4(0,0,0,0) }, Unlocks = {  }, Opens = true, Items = { 205 } },
				{ Id = "Lockbox2", Coords = {
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
				{ Id = "KeypadCard", Required = true, Coords = { vector4(-105.6590423584, 6471.8740234375, 31.626710891724, 44.672233581543) }, Unlocks = { vector3(-104.60489654541, 6473.4438476563, 31.795324325562) }, Items = { 206 }, Opens = true },
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
		--[[ Ammunations ]]--
		{
			Name = "Adam's Apple",
			Type = "Ammunation",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(18.507177352905, -1107.9122314453, 29.797029495239),
			Cops = 4,
			Dist = 20.0,
			EssentialOrder = true,
			Robbables = {
				{ Id = "WireBox", Coords = {
					vector4(5.7877473831177, -1113.8707275391, 28.826890945435, 340.7041015625),
				}},
				"Register",
				{ Id = "Locker", Coords = {
					vector4(3.9461178779602, -1107.6217041016, 29.797023773193, 70.313499450684),
					vector4(4.6115851402283, -1105.9359130859, 29.797023773193, 71.242607116699),
					vector4(4.5173196792603, -1108.9681396484, 29.797023773193, 162.13676452637),
					vector4(6.2016434669495, -1109.6038818359, 29.797023773193, 162.26623535156),
				}},
			},
		},
		{
			Name = "Cypress",
			Type = "Ammunation",
			Size = "Small",
			Cooldown = 30,
			Coords = vector3(810.55737304688, -2180.1789550781, 38.313011169434),
			Cops = 4,
			Dist = 80.0,
			EssentialOrder = true,
			Robbables = {
				{ Id = "WireBox", Coords = {
					vector4(826.66644287109, -2230.154296875, 29.977523803711, 351.5364074707),
				}},
				"Register",
				{ Id = "Locker", Coords = {
					vector4(827.11102294922, -2152.9609375, 29.618993759155, 270.86605834961),
					vector4(827.01446533203, -2150.8000488281, 29.618993759155, 269.36056518555),
					vector4(826.23876953125, -2149.6228027344, 29.618993759155, 359.76379394531),
					vector4(824.10748291016, -2149.4328613281, 29.618993759155, 358.16613769531),
				}},
			},
			
		},
		-- Life Invader
		-- {
		-- 	Name = "Rockford",
		-- 	Type = "Life Invader",
		-- 	Size = "Small",
		-- 	Cooldown = 30,
		-- 	Coords = vector3(-1061.7335205078, -239.6499786377, 41.753101348877),
		-- 	Cops = 4,
		-- 	Dist = 20.0,
		-- 	EssentialOrder = true,
		-- 	Robbables = {
		-- 		"Doors",
		-- 		{ Id = "LaptopHack", Coords = {
		-- 			vector4(-1054.0523681641, -230.82221984863, 44.020946502686, 210.08010864258),
		-- 		}},
		-- 	},
		-- },
		-- Humane Labs
		{
			Name = "Humane Labs and Research",
			Type = "",
			Size = "Large",
			Cooldown = 60,
			Coords = vector3(3572.009765625, 3701.9650878906, 32.965393066406),
			Cops = 6,
			Dist = 100.0,
			EssentialOrder = true,
			Robbables = {
				"Doors",
				{ Id = "WireBox2", Coords = {
					vector4(3637.9357910156, 3747.6203613281, 28.515710830688, 146.64166259766),
				}, Unlocks = {
					vector3(3586.2897949219, 3699.4545898438, 28.971439361572),
					vector3(3584.1589355469, 3700.9465332031, 28.971439361572),
					vector3(3598.5114746094, 3688.9765625, 28.97162437439),
					vector3(3596.3806152344, 3690.4685058594, 28.97162437439),
					vector3(3569.1611328125, 3695.8703613281, 28.271549224854),
					vector3(3568.7094726563, 3693.3088378906, 28.271549224854),
					vector3(3544.8068847656, 3643.9963378906, 28.271835327148),
					vector3(3545.2585449219, 3646.5578613281, 28.271835327148),
					vector3(3538.7575683594, 3645.0627441406, 28.271831512451),
					vector3(3539.2092285156, 3647.6242675781, 28.271831512451),
					vector3(3601.9997558594, 3717.8835449219, 29.839624404907),
					vector3(3599.8688964844, 3719.3754882813, 29.839624404907),
				}},
				{ Id = "KeypadCard", Coords = {
					vector4(3620.5144042969, 3743.7275390625, 28.69010925293, 323.8662109375),
				}, Unlocks = {
					vector3(3567.63671875, 3684.2880859375, 27.120679855347),
					vector3(3565.072265625, 3684.7416992188, 27.118797302246),
					vector3(3551.5769042969, 3658.3388671875, 27.117881774902),
					vector3(3549.0119628906, 3658.7897949219, 27.117881774902),
				}, Items = { 199 }},
				{ Id = "KeypadCard", Coords = {
					vector4(3611.25390625, 3728.4438476563, 29.689393997192, 325.65466308594),
				}, Unlocks = {
					vector3(3555.4370117188, 3664.8020019531, 27.117881774902),
					vector3(3552.8723144531, 3665.25390625, 27.117881774902),
					vector3(3558.3088378906, 3681.0891113281, 27.117883682251),
					vector3(3555.7438964844, 3681.5397949219, 27.117881774902),
					vector3(3532.9724121094, 3665.8679199219, 27.121780395508),
					vector3(3532.5209960938, 3663.3071289063, 27.121778488159),
				}, Items = { 200 }},
				{ Id = "KeypadCard", Coords = {
					vector4(3536.259765625, 3659.3645019531, 28.12188911438, 164.63688659668),
				}, Unlocks = {
					vector3(3557.5532226563, 3669.1940917969, 27.12158203125),
				}, Items = { 202 }},
				{ Id = "Vials", Coords ={
					vector4(3561.2355957031, 3676.0603027344, 28.12188911438, 351.76058959961),
					vector4(3562.0476074219, 3675.98828125, 28.12188911438, 349.01019287109),
					vector4(3562.955078125, 3671.9992675781, 28.12188911438, 252.67050170898),
				}},
				{ Id = "KeypadCard", Coords = {
					vector4(3536.9155273438, 3668.5712890625, 28.12188911438, 353.07238769531),
				}, Unlocks = {
					vector3(3530.5322265625, 3671.064453125, 27.121238708496),
					vector3(3533.0930175781, 3670.6127929688, 27.121242523193),
				}, Items = { 206 }},
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
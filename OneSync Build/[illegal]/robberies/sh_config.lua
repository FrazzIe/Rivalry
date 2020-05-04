Config = {
	--[[
		Most times are converted to seconds or minutes.
	]]--
	DefaultCops = 4,
	DispatchCooldown = 90,
	StatusErrors = {
		[-1] = "There's an increase in security right now...",
		[-2] = "It's empty...",
		[-3] = "Somebody is already robbing that...",
	},
	Robbables = {
		["Register"] = {
			Armed = true,
			Stages = {
				{
					Duration = 5,
					Text = "Breaking",
					Anim = {
						Dict = "missheist_jewel",
						Name = "smash_case",
						Flag = 16,
					},
				},
				{
					Duration = 60,
					Text = "Taking",
					Anim = {
						Dict = "oddjobs@shop_robbery@rob_till",
						Name = "loop",
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
			-- Items = { 36 },
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
						Dict = "anim@heists@humane_labs@emp@hack_door",
						Name = "hack_loop",
					},
				},
				{
					Duration = 210,
					Text = "Taking",
					Anim = {
						Dict = "oddjobs@shop_robbery@rob_till",
						Name = "loop",
					},
					Payouts = {9000/240*5,13000/240*5},
					PayoutInterval = 5.0,
					CooldownOnCancel = true,
				},
			}
			-- Items = { 36 },
		},
		["Safe"] = {
			Duration = 180,
			Anim = {
				Dict = "mini@safe_cracking",
				Name = "dial_turn_clock_fast",
			},
			Payouts = {6000,7000},
			-- Items = { 36 },
		},
		["Keypad"] = {
			Text = "Hack",
			Duration = 2,
			-- Minigame = {
			-- 	Type = "Hacking",
			-- 	Phases = 10,
			-- 	Length = 4,
			-- 	Duration = 30,
			-- },
			Anim = {
				Dict = "anim@heists@humane_labs@emp@hack_door",
				Name = "hack_loop",
			},
		},
		["Lockbox"] = {
			Duration = 6,
			Anim = {
				Dict = "mini@safe_cracking",
				Name = "dial_turn_clock_fast",
			},
			Payouts = {10000,20000},
			Items = { 36 },
		},
		["Jewelry"] = {
			Armed = true,
			Duration = 6,
			Payouts = {100,200},
			Anim = {
				Dict = "missheist_jewel",
				Name = "smash_case",
				Flag = 0,
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
		["JewelryBox"] = {
			Text = "Tamper",
		},
		["Doors"] = {
			Text = "Unlock",
			Models = {
				["v_ilev_cbankvaulgate01"] = {},
				["v_ilev_cbankvaulgate02"] = {},
				["hei_v_ilev_bk_gate_pris"] = {},
				["hei_v_ilev_bk_gate2_pris"] = {},
				["hei_v_ilev_bk_safegate_pris"] = {},
				["v_ilev_bk_door"] = {},
				
				["v_ilev_bk_vaultdoor"] = {
					IsVault = true,
					Hide = true,
					Banks = {
						[""] = {},
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
		},
	},
	Robberies = {
		--[[ Jewelry ]]--
		-- {
		-- 	Name = "Vangelico",
		-- 	Type = "Jewelry",
		-- 	Cooldown = 60,
		-- 	Dist = 30.0,
		-- 	Coords = vector3(-623.96948242188, -232.09579467773, 38.057037353516),
		-- 	Robbables = { "Jewelry", { Id = "JewelryBox", Coords = { vector4(-616.17303466797, -241.53866577148, 51.320960998535, 26.204074859619) } } },
		-- },
		--[[ Convenience ]]--
		{
			Name = "Downtown Vinewood",
			Type = "Convenience",
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(377.9775390625, 326.87213134766, 103.56639099121),
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector3(378.15478515625, 333.39312744141, 103.56637573242),
				}},
			},
		},
		{
			Name = "Chiliad",
			Type = "Convenience",
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(1733.0947265625, 6415.427734375, 35.162433624268),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(-3043.2700195313, 588.60424804688, 7.9089293479919),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(1702.4029541016, 4926.0805664063, 42.063629150391),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(1963.2877197266, 3744.7551269531, 32.343738555908),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(544.38342285156, 2668.4165039063, 42.156490325928),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(2678.2565917969, 3285.1193847656, 55.241123199463),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(2555.1096191406, 386.06909179688, 108.62293243408),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(2555.1096191406, 386.06909179688, 108.62293243408),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(-1825.4011230469, 792.63500976563, 138.19227600098),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(1159.365234375, -321.47192382813, 69.205047607422),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(-48.604434967041, -1753.2189941406, 29.421014785767),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(-711.10052490234, -911.84265136719, 19.215585708618),
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
			Cops = 3,
			Cooldown = 30,
			Coords = vector3(29.453075408936, -1344.6448974609, 29.497024536133),
			Robbables = {
				"Register",
				{ Id = "SafeE", Coords = {
					vector4(28.228527069092, -1339.2299804688, 29.497024536133, 2.1247074604034),
				}},
			},
		},
		--[[ Liquor Store ]]--
		{
			Name = "Prosperity",
			Type = "Liquor",
			Cops = 2,
			Cooldown = 30,
			Coords = vector3(-1483.0372314453, -376.53033447266, 40.163425445557),
			Robbables = {
				"Register",
				{ Id = "Safe", Coords = {
					vector3(-1478.9112548828, -375.37426757813, 39.16340637207),
				}}
			},
		},
		{
			Name = "Great Ocean Highway",
			Type = "Liquor",
			Cops = 2,
			Cooldown = 30,
			Coords = vector3(-2966.4519042969, 390.80426025391, 15.043314933777),
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
			Cops = 2,
			Cooldown = 30,
			Coords = vector3(1134.2449951172, -982.60424804688, 46.415798187256),
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
			Cops = 2,
			Cooldown = 30,
			Coords = vector3(-1222.0015869141, -908.29229736328, 12.326356887817),
			Robbables = {
				"Register",
				{ Id = "Safe", Coords = {
					vector4(-1220.8616943359, -916.07708740234, 11.326334953308, 125.43096923828),
				}}
			},
		},
		--[[ Banks ]]--
		-- {
		-- 	Name = "Pacific Standard",
		-- 	Type = "Bank",
		-- 	Cops = 0,--5,
		-- 	Cooldown = 60,
		-- 	Coords = vector3(251.68597412109, 220.39694213867, 107.4554901123),
		-- 	Dist = 30.0,
		-- 	Robbables = {
		-- 		"Doors",
		-- 		{ Id = "Lockbox", Coords = {
		-- 			vector3(256.52255249023,214.84797668457,101.68339538574),
		-- 			vector3(259.54159545898,213.76419067383,101.68339538574),
		-- 			vector3(261.85623168945,212.89897155762,101.68339538574),
		-- 			vector3(263.76330566406,212.10447692871,101.68339538574),
		-- 			vector3(265.60952758789,212.37365722656,101.68339538574),
		-- 			vector3(266.42230224609,214.45140075684,101.68339538574),
		-- 			vector3(265.42904663086,215.8120880127,101.68339538574),
		-- 			vector3(263.45260620117,216.49617004395,101.68339538574),
		-- 			vector3(260.89764404297,217.47621154785,101.68339538574),
		-- 			vector3(258.17596435547,218.52362060547,101.68339538574),
		-- 		}},
		-- 	}
		-- },
		-- {
		-- 	Name = "Legion Square Fleeca",
		-- 	Type = "Bank",
		-- 	Cops = 0,
		-- 	Cooldown = 60,
		-- 	Coords = vector3(146.76416015625, -1042.3675537109, 29.35502243042),
		-- 	Robbables = {
		-- 		"Doors",
		-- 		{ Id = "Lockbox", Coords = {
					
		-- 		}},
		-- 	},
		-- },
		-- {
		-- 	Name = "Blaine County Savings",
		-- 	Type = "Bank",
		-- 	Cops = 0,
		-- 	Cooldown = 60,
		-- 	Coords = vector3(-108.1021194458, 6471.7890625, 31.626708984375),
		-- 	Dist = 40.0,
		-- 	Robbables = {
		-- 		"Doors",
		-- 		{ Id = "Keypad", Required = true, ControlVault = true, Coords = { vector4(-105.6590423584, 6471.8740234375, 31.626710891724, 44.672233581543) } },
		-- 		{ Id = "Lockbox", Coords = {
					
		-- 		}},
		-- 	},
		-- },
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
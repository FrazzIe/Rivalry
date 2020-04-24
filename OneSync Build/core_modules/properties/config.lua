--[[
	Basic explanation
	properties/houses/normal - These are properties with 1 coordinate, no interior no teleport a circle where u press E (for non-enterable houses)
	properties/houses/enterable - These are for properties with 3 cooordinates, they require a tp to get inside (they have an interior) 1 coordinate for the outside, 1 coordinate for the inside and another which is for the vault (preferrably inside)
  
	properties/businesses/normal -- same as above, but they have an income
	properties/businesses/enterable -- same as above, but they have an income
--]]
properties = {
	houses = {
		normal = {
			[1] = {
				property_name = "10236 Americano Way", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-1541.1848144531,92.128402709961,53.897403717041), -- The location of the property
				rent = 5000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[2] = {
				property_name = "41 Forum Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-10.622609138489,-1428.7703857422,31.101453781128), -- The location of the property
				rent = 2500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[3] = {
				property_name = "2677 Whispymound Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-5.1676306724548,522.70458984375,174.62725830078), -- The location of the property
				rent = 5000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[4] = {
				property_name = "2144 S. Mo Milton Dr.", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-874.56011962891,561.56439208984,96.61930847168), -- The location of the property
				rent = 3000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[5] = {
				property_name = "2862 Hillcrest Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-687.80926513672,597.47955322266,143.64202880859), -- The location of the property
				rent = 5000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[6] = {
				property_name = "3657 Wild Oats Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-109.58322906494,504.18048095703,143.32385253906), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[7] = {
			  property_name = "27 Amarillo Vista", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1273.9063720703,-1709.2525634766,54.771488189697), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[8] = {
				property_name = "4287 Kimble Hill Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-293.64105224609,601.70745849609,181.57548522949), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[9] = {
				property_name = "112 Spanish Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-110.5061,8.684491,70.51956), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[10] = {
				property_name = "7611 Goma Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-1147.9143066406,-1512.1651611328,10.632730484009), -- The location of the property
				rent = 2500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
             			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 250, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[11] = {
				property_name = "48 Magellen Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
				    identifier = "no", --Default (don't touch)
				    char_id = 0, --Default (don't touch)
				    id = 0, --Default (don't touch)
				},
				coordinates = vector3(-1246.8986816406,-1358.9464111328,7.820433139801), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
				    current = {
					cash = 0, --Default (don't touch)
					dirty = 0, --Default (don't touch)
					weapons = {}, --Default (don't touch)
				    },
				    	max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
                	},
              		robbing = {
                    		cooldown = 2700, --Robbery cooldown time in seconds
                    		last_robbed = 0, --Default (don't touch)
                    		being_robbed = false, --Default (don't touch)
                    		time = 180, --The total time the robber has to hack the vault
                    		max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
                		},
                		expire = 1 --Default (don't touch)
            		},
			[12] = {
				property_name = "328 Grove Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-50.729301452637,-1783.642578125,28.300817489624), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[13] = {
				property_name = "334 Grove Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-20.934959411621,-1858.5444335938,25.408670425415), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[14] = {
				property_name = "340 Grove Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(45.59850692749,-1864.7054443359,23.278276443481), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[15] = {
				property_name = "937 Covenant Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(171.11489868164,-1871.2814941406,24.400232315063), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
             			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[16] = {
				property_name = "1532 Roy Lowenstein Blvd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(280.91455078125,-1897.8674316406,26.887641906738), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[17] = {
				property_name = "1582 Roy Lowenstein Blvd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(349.32568359375,-1819.98046875,28.894096374512), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[18] = {
				property_name = "1573 Roy Lowenstein Blvd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(299.49032592773,-1784.9488525391,28.438663482666), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 3, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[19] = {
				property_name = "1738 Brouge Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(269.47137451172,-1713.2081298828,29.668771743774), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[20] = {
				property_name = "1337 Jamestown Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(474.80480957031,-1757.6700439453,29.092624664307), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[21] = {
				property_name = "1356 Jamestown Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(496.01403808594,-1822.4757080078,28.869703292847), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[22] = {
				property_name = "1127 Nikola Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(963.25720214844,-595.94689941406,59.902702331543), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[23] = {
				property_name = "1343 West Mirror Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(861.56988525391,-582.49072265625,58.156490325928), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[24] = {
				property_name = "1435 West Mirror Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(979.74169921875,-627.20623779297,59.235836029053), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[25] = {
				property_name = "1439 West Mirror Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(922.28070068359, -478.60290527344,61.083583831787), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[26] = {
				property_name = "1128 Nikola Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(920.23712158203,-570.53887939453,58.366363525391), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[27] = {
				property_name = "2720 Mirror Place", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1001.1132202148,-594.14642333984,59.232391357422), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[28] = {
				property_name = "2863 Bridge Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1046.2370605469,-497.13256835938,64.079315185547), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[29] = {
				property_name = "2869 Bridge Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1098.4874267578,-465.08499145508,67.319396972656), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[30] = {
				property_name = "3241 East Mirror Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1270.7966308594,-682.783203125,66.031616210938), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[31] = {
				property_name = "3289 East Mirror Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1251.3123779297,-515.60803222656,69.349052429199), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[32] = {
				property_name = "3295 East Mirror Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1263.5560302734,-429.26174926758,69.800323486328), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[33] = {
				property_name = "O'Neils Farm", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(2435.7275390625,4966.2797851563,42.347606658936), -- The location of the property
				rent = 2500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[34] = {
				property_name = "7617 Zancudo Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1978.2546386719,3819.4265136719,33.450054168701), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
		      		robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[35] = {
				property_name = "7509 Cholla Springs Ave", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1803.0750732422,3913.681640625,37.057018280029), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[36] = {
				property_name = "7715 Algonquin Blvd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1781.9161376953,3744.7509765625,34.656623840332), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[37] = {
				property_name = "7527 Cholla Springs Ave", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1651.0162353516,3806.7937011719,35.013919830322), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[38] = {
				property_name = "7735 Algonquin Blvd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1639.7318115234,3731.7133789063,35.067100524902), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[39] = {
				property_name = "52 Calafia Rd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(52.523105621338,3740.5842285156,39.589405059814), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[40] = {
				property_name = "227 Joshua Rd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(195.34185791016,3031.1162109375,43.886692047119), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[41] = {
				property_name = "2127 Grapeseed Main St", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1724.4509277344,4641.951171875,43.875457763672), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[42] = {
				property_name = "2132 Grapeseed Main St", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1663.0693359375,4776.2231445313,42.007556915283), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[43] = {
				property_name = "2195 Grapeseed Main St", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1984.9240722656,5175.1635742188,47.639125823975), -- The location of the property
				rent = 2500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[44] = {
				property_name = "1001 Catfish View", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(3311.2243652344,5176.1728515625,19.614582061768), -- The location of the property
				rent = 2500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[45] = {
				property_name = "1031 Catfish View", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(3688.7797851563,4562.9462890625,25.183052062988), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[46] = {
				property_name = "1607 North Calafia Way", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1365.9959716797,4358.8271484375,44.500511169434), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[47] = {
				property_name = "1925 North Calafia Way", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(741.68121337891,4170.390625,41.087860107422), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[48] = {
				property_name = "1930 North Calafia Way", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(722.92016601563,4187.0991210938,40.882667541504), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
             			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[49] = {
				property_name = "758 Joshua Rd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(436.2356262207,2997.0383300781,41.283229827881), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[50] = {
				property_name = "761 Joshua Rd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(412.08709716797,2965.7241210938,41.888053894043), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[51] = {
				property_name = "245 Joshua Rd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(180.46072387695,3087.2543945313,43.262702941895), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[52] = {
				property_name = "258 Joshua Rd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(240.93174743652,3107.90625,42.487194061279), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[53] = {
				property_name = "1837 Baytree Canyon Rd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-34.51997756958,1951.2297363281,190.35537719727), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[54] = {
				property_name = "2142 Baytree Canyon Rd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(791.92803955078,2177.1506347656,52.648387908936), -- The location of the property
				rent = 2500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[55] = {
				property_name = "334 Grove St", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-33.481433868408,-1847.3713378906,26.193550109863), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[56] = {
				property_name = "336 Grove St", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-5.2547397613525,-1871.6096191406,24.1510181427), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[57] = {
				property_name = "34 Steele Way", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-949.37628173828,196.32981872559,67.390480041504), -- The location of the property
				rent = 5000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, -- Mark marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[58] = {
				property_name = "58 Portola Dr", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-811.47985839844,167.77639770508,72.227897644043), -- The location of the property
				rent = 5000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, -- Mark marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
      			[59] = {
				property_name = "503 Carson Avenue Apt 7", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-132.39100646973,-1462.7392578125,36.992134094238), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)

			},
			[60] = {
				property_name = "501 Carson Avenue Apt 13", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-19.607872009277,-1550.8292236328,33.821388244629), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[61] = {
				property_name = "47 Forum Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-64.129989624023,-1449.578125,32.524906158447), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[62] = {
				property_name = "207 Grove Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(126.75737762451,-1929.7243652344,21.382423400879), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[63] = {
				property_name = "205 Grove Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(75.601333618164,-1967.0650634766,21.117897033691), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[64] = {
				property_name = "3507 Didion Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-371.76879882813,343.6799621582,109.94268798828), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[65] = {
				property_name = "6085 North Milton Road", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-658.56628417969,886.91680908203,229.24890136719), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[66] = {
				property_name = "1220 Sam Austin Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-1464.7447509766,-33.984531402588,55.050327301025), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[67] = {
				property_name = "4420 Lake Vinewood Estates", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-168.10064697266,916.34545898438,235.6555480957), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[68] = {
				property_name = "1380 South Mo Milton Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-881.65075683594,363.97253417969,85.362693786621), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[69] = {
				property_name = "6442 Buen Vino Road", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-2587.7463378906,1911.298828125,167.49890136719), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[70] = {
				property_name = "1350 Inseno Road", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-3059.2497558594,454.14767456055,6.3550028800964), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[71] = {
				property_name = "1520 Inseno Road", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-3107.5363769531,718.90008544922,20.646457672119), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[72] = {
				property_name = "2642 Barbareno Road", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-3190.6044921875,1297.5294189453,19.06739616394), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[73] = {
				property_name = "4756 Route 68", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(471.25119018555,2607.8793945313,44.477191925049), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[74] = {
				property_name = "7688 Route 68", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(858.8984375,2876.841796875,57.982616424561), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[75] = {
				property_name = "6444 Senora Road", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(1535.7348632813,2232.0788574219,77.699073791504), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[76] = {
				property_name = "1920 East Joshua Road", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(2639.5302734375,4246.3354492188,44.753509521484), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[77] = {
				property_name = "1100 Paleto Boulevard", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(25.744293212891,6602.3432617188,32.470455169678), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[78] = {
				property_name = "1450 Procopio Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-407.03759765625,6313.8188476563,28.942161560059), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[79] = {
				property_name = "2872 Procopio Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-14.911129951477,6557.7412109375,33.240463256836), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[80] = {
				property_name = "208 Fudge Lane", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(1360.5001220703,-1555.7717285156,56.341423034668), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[81] = {
				property_name = "219 Fudge Lane", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(1411.6381835938,-1490.7341308594,60.657409667969), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[82] = {
				property_name = "106 Fudge Lane", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(1261.3873291016,-1616.44140625,54.742874145508), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[83] = {
				property_name = "103 Fudge Lane", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(1210.6195068359,-1606.9620361328,50.736507415771), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[84] = {
				property_name = "16 Amarillo Vista", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(1259.2507324219,-1761.4506835938,49.658252716064), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[85] = {
				property_name = "36 Amarillo Vista", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(1365.4884033203,-1721.302734375,65.634101867676), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[86] = {
				property_name = "1722 Roy Lowenstein Blvd Apt 6", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(471.39886474609,-1561.8111572266,32.792301177979), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[87] = {
				property_name = "1722 Roy Lowenstein Blvd Apt 7", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(442.3971862793,-1569.4049072266,32.792285919189), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[88] = {
				property_name = "2520 Palomino Ave Apt 3", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-712.11029052734,-1028.6617431641,16.424047470093), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[89] = {
				property_name = "2520 Palomino Ave Apt 2", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-699.21520996094,-1032.4124755859,16.418918609619), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[90] = {
				property_name = "408 Ginger Street Apt", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-815.11804199219,-957.5654296875,15.466663360596), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[91] = {
				property_name = "308 Invention Court", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-942.99798583984,-1075.6263427734,2.745269536972), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[92] = {
				property_name = "303 Invention Court", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-991.61370849609,-1103.7797851563,2.1503117084503), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[93] = {
				property_name = "205 Invention Court", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-1047.8273925781,-1123.2091064453,2.1585984230042), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[94] = {
				property_name = "102 Imagination Court Apt 4", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-1160.9432373047,-1101.5782470703,6.5313601493835), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[95] = {
				property_name = "302 Imagination Court", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-1022.548828125,-1022.6267700195,2.1503598690033), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[96] = {
				property_name = "4430 Lake Vinewood Estates", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-111.59775543213,1000.1704101563,235.75880432129), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[97] = {
				property_name = "108 Forum Drive Apt 4", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-191.87155151367,-1559.3280029297,34.954601287842), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[98] = {
				property_name = "207 Occupation Avenue Apt 3", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(142.86106872559,-280.38284301758,50.449626922607), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[99] = {
				property_name = "103 Occupation Avenue Apt 2", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(98.019378662109,-255.47189331055,47.416328430176), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[100] = {
				property_name = "202 Alta Place Apt 1", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(202.22776794434,-133.30009460449,63.494342803955), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[101] = {
				property_name = "1446 Procopio Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-447.99917602539,6260.0659179688,30.047973632813), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[102] = {
				property_name = "8235 Great Ocean Hwy", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-3017.0334472656,746.69622802734,27.782585144043), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[103] = {
				property_name = "2301 Portola Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-842.00866699219,-25.179723739624,40.398445129395), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[104] = {
				property_name = "4440 Lake Vinewood Estates", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-85.617546081543,834.84765625,235.92008972168), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[105] = {
				property_name = "844 Mirror Park Blvd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(1222.6003417969,-697.06573486328,60.806297302246), -- The location of the property
				rent = 1500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 12, --Max weapons the property can hold
					},
				},
              			robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[106] = {
				property_name = "209 Grove Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(56.624691009521,-1922.7537841797,21.911247253418), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[107] = {
				property_name = "336 Jamestown St Apt 102", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(313.45455932617,-2040.4252929688,20.936477661133), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[108] = {
				property_name = "336 Jamestown St Apt 306", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(372.44467163086,-2055.9868164063,21.744539260864), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[109] = {
				property_name = "37 Forum Dr", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(16.475744247437,-1443.8037109375,30.949287414551), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[110] = {
				property_name = "206 Grove Street", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(121.71436309814,-1971.2358398438,21.327577590942), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[111] = {
				property_name = "118 Vespucci Beach", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-1098.5015869141,-1678.6925048828,4.3563928604126), -- The location of the property
				rent = 2500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[112] = {
				property_name = "10239 Americano Way", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-1515.3416748047,24.505289077759,56.820720672607), -- The location of the property
				rent = 5000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[113] = {
				property_name = "10300 Americano Way", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-1570.5196533203,23.276092529297,59.55383682251), -- The location of the property
				rent = 5000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[114] = {
				property_name = "400 Steele Way", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-1039.0823974609,222.11077880859,64.37565612793), -- The location of the property
				rent = 5000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[115] = {
				property_name = "6 Calafia Rd", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(97.887825012207,3682.9501953125,39.733028411865), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[116] = {
				property_name = "110 Fudge Lane", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(1445.390625,-1488.4273681641,63.703075408936), -- The location of the property
				rent = 500, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 4, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[117] = {
				property_name = "1600 Procopio Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-9.0505838394165,6652.876953125,31.114051818848), -- The location of the property
				rent = 1000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[118] = {
				property_name = "10500 Americano Way", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
              			coordinates = vector3(-9.0505838394165,6652.876953125,31.114051818848), -- The location of the property
				rent = 2000, --How much it costs to rent the property (PER DAY)
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 16, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
		},
		enterable = {
			[1] = {
				property_name = "623 Eclipse Towers", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-761.84692382813,352.1750793457,87.997917175293), -- The marker outside (used for teleporting inside)
					outsideheading = 177.28384399414,
					inside = vector3(-784.75231933594,323.61608886719,211.99726867676), -- The marker inside (used for teleporting outside)
					insideheading = 283.5973815918,
					vault = vector3(-765.59680175781,327.7966003418,211.396484375), -- The marker for the vault
					outfit = { coords = vector3(-793.46234130859, 326.71600341797, 210.79656982422), heading = 4.1511254310608 },
				},
				rent = 7500, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 100000, --Max cash the property can hold
						dirty = 1000000, --Max marked bills the property can hold
						weapons = 100, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[2] = {
				property_name = "621 Eclipse Towers", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-773.74420166016,311.87872314453,85.698234558105), -- The marker outside (used for teleporting inside)
					outsideheading = 358.59246826172,
					inside = vector3(-781.81390380859,326.27362060547,176.80383300781), -- The marker inside (used for teleporting outside)
					insideheading = 179.322265625,
					vault = vector3(-773.29376220703,326.64651489258,176.81155395508), -- The marker for the vault
					outfit = { coords = vector3(-760.35125732422, 325.41180419922, 170.60707092285), heading = 267.22537231445 },
				},
				rent = 7000, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 100000, --Max cash the property can hold
						dirty = 1000000, --Max marked bills the property can hold
						weapons = 100, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[3] = {
				property_name = "550 Tinsel Towers", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-618.09936523438,36.833522796631,43.57621383667), -- The marker outside (used for teleporting inside)
					outsideheading = 358.09335327148,
					inside = vector3(-603.44000244141,58.969806671143,98.2001953125), -- The marker inside (used for teleporting outside)
					insideheading = 96.099281311035,
					vault = vector3(-622.85327148438,54.74146270752,97.599494934082), -- The marker for the vault
					outfit = { coords = vector3(-594.68609619141, 56.971042633057, 96.999534606934), heading = 183.02235412598 },
				},
				rent = 6800, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 10000000, --Max marked bills the property can hold
						weapons = 100, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[4] = {
				property_name = "37 Magellan Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-1150.7808837891,-1474.0367431641,4.3797407150269), -- The marker outside (used for teleporting inside)
					outsideheading = 301.61361694336, 
					inside = vector3(266.0615234375,-1007.2471313477,-101.00849914551), -- The marker inside (used for teleporting outside)
					insideheading = 177.8150177002,
					vault = vector3(259.7912902832,-1003.4866943359,-99.00853729248), -- The marker for the vault
					outfit = { coords = vector3(262.97994995117, -1002.5584106445, -99.008628845215), heading = 130.49055480957 },
				},
				rent = 6400, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[5] = {
				property_name = "117 Vespucci Beach", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-1098.0579833984,-1673.5573730469,8.3939523696899), -- The marker outside (used for teleporting inside)
					outsideheading = 299.7341003418,
					inside = vector3(346.63479614258,-1012.7304077148,-99.196174621582), -- The marker inside (used for teleporting outside)
					insideheading = 351.94812011719,
					vault = vector3(351.9665222168,-994.28277587891,-99.196128845215), -- The marker for the vault
					outfit = { coords = vector3(351.14907836914, -998.60400390625, -99.196220397949), heading = 8.1840496063232 },
				},
				rent = 5900, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 5, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[6] = {
				property_name = "3655 Wild Oats Drive", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-175.1568,502.5597,137.4205), -- The marker outside (used for teleporting inside)
					ousideheading = 274.7941,
					inside = vector3(-174.0973,497.194,137.667), -- The marker inside (used for teleporting outside)
					insideheading = 222.1987,
					vault = vector3(-175.24800109863,492.56127929688,130.04359436035), -- The marker for the vault
					outfit = { coords = vector3(-167.29689025879, 486.89996337891, 133.84371948242), heading = 196.37260437012 },
				},
				rent = 8400, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[7] = {
				property_name = "La Fuente Blanca", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(1394.5866699219,1141.7231445313,114.61329650879), -- The marker outside (used for teleporting inside)
					outsideheading = 266.94152832031,
					inside = vector3(1397.9954833984,1141.7806396484,114.33367156982), -- The marker inside (used for teleporting outside)
					insideheading = 91.478500366211,
					vault = vector3(1398.7845458984,1164.8054199219,114.33367156982), -- The marker for the vault
					outfit = { coords = vector3(1401.4949951172, 1134.0328369141, 114.33367919922), heading = 148.47058105469 },
				},
				rent = 9000, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 8, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[8] = {
				property_name = "Del Perro Heights", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-1447.2314453125,-537.86743164063,34.740283966064), -- The marker outside (used for teleporting inside)
					outsideheading = 29.66982460022,
					inside = vector3(-1452.3041992188,-540.70257568359,74.044326782227), -- The marker inside (used for teleporting outside)
					insideheading = 30.716178894043,
					vault = vector3(-1466.970703125,-527.34332275391,73.443649291992), -- The marker for the vault
					outfit = { coords = vector3(-1449.6156005859, -548.95849609375, 72.843757629395), heading = 124.10266113281 },
				},
				rent = 6800, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[9] = {
				property_name = "2044 North Conker Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(346.87228393555,440.48822021484,147.70236206055), -- The marker outside (used for teleporting inside)
					outsideheading = 297.46057128906,
					inside = vector3(341.88668823242,437.70236206055,149.39407348633), -- The marker inside (used for teleporting outside)
					insideheading = 112.42232513428,
					vault = vector3(336.96505737305,437.0129699707,141.7707824707), -- The marker for the vault
					outfit = { coords = vector3(333.19348144531, 427.91906738281, 145.57080078125), heading = 112.82019805908 },
				},
				rent = 7200, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},  
			[10] = {
				property_name = "2045 North Conker Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(372.83941650391,428.42868041992,145.68545532227), -- The marker outside (used for teleporting inside)
					outsideheading = 27.829916000366,
					inside = vector3(373.44293212891,422.17086791992,145.90786743164), -- The marker inside (used for teleporting outside)
					insideheading = 166.06129455566,
					vault = vector3(378.92767333984,430.19302368164,138.30014038086), -- The marker for the vault
					outfit = { coords = vector3(374.03070068359, 409.98815917969, 142.10018920898), heading = 173.87084960938 },
				},
				rent = 7300, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},  
			[11] = {
				property_name = "2133 Mad Wayne Thunder", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-1294.3826904297,454.62731933594,97.528312683105), -- The marker outside (used for teleporting inside)
					outsideheading = 10.007172584534,
					inside = vector3(-1289.8400878906,449.45440673828,97.902503967285), -- The marker inside (used for teleporting outside)
					insideheading = 180.92395019531,
					vault = vector3(-1286.1497802734,457.09368896484,90.29468536377), -- The marker for the vault
					outfit = { coords = vector3(-1286.1539306641, 436.60934448242, 94.094779968262), heading = 186.20181274414 },
				},
				rent = 7600, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},  
			[12] = {
				property_name = "2862 Hillcrest Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-704.32666015625,589.54858398438,141.93055725098), -- The marker outside (used for teleporting inside)
					outsideheading = 83.275207519531,
					inside = vector3(-682.41345214844,592.49420166016,145.39202880859), -- The marker inside (used for teleporting outside)
					insideheading = 219.58547973633,
					vault = vector3(-681.16217041016,586.90997314453,137.76972961426), -- The marker for the vault
					outfit = { coords = vector3(-671.29089355469, 587.04840087891, 141.5699005127), heading = 221.00025939941 },
				},
				rent = 6700, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},  
			[13] = {
				property_name = "2868 Hillcrest Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-751.87976074219,620.81994628906,142.22148132324), -- The marker outside (used for teleporting inside)
					outsideheading = 286.69158935547,
					inside = vector3(-758.46026611328,619.11779785156,144.1537322998), -- The marker inside (used for teleporting outside)
					insideheading = 110.82205963135,
					vault = vector3(-764.01904296875,619.67431640625,136.53062438965), -- The marker for the vault
					outfit = { coords = vector3(-768.73809814453, 610.58837890625, 140.3306427002), heading = 119.80745697021 },
				},
				rent = 6800, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},  
			[14] = {
				property_name = "2874 Hillcrest Avenue", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-852.92742919922,695.83508300781,148.78746032715), -- The marker outside (used for teleporting inside)
					outsideheading = 4.3718523979187,
					inside = vector3(-860.21350097656,691.0048828125,152.86070251465), -- The marker inside (used for teleporting outside)
					insideheading = 193.40473937988,
					vault = vector3(-856.89422607422,699.02001953125,145.25294494629), -- The marker for the vault
					outfit = { coords = vector3(-855.2392578125, 678.50317382813, 149.05303955078), heading = 192.51000976563 },
				},
				rent = 6900, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[15] = {
				property_name = "Lost MC - Paleto Bay", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = vector3(-379.6051,6062.196,31.50013), -- The marker outside (used for teleporting inside)
					outsideheading = 222.5358,
					inside = vector3(1120.963,-3152.196,-37.06273), -- The marker inside (used for teleporting outside)
					insideheading = 222.8231,
					vault = vector3(1112.419,-3145.239,-37.06273), -- The marker for the vault
					outfit = { coords = vector3(1116.833984375,-3162.8041992188,-36.870498657227), heading = 185.3567199707 },
				},
				rent = 6900, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			--[[[15] = {
				property_name = "Eclipse Towers Suite 3", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = {x = -770.60601806641, y = 312.38662719727, z = 85.698120117188, h = 178.87382507324}, -- The marker outside (used for teleporting inside)
					inside = {x = -787.04553222656, y = 315.70971679688, z = 217.63854980469, h = 271.10702514648}, -- The marker inside (used for teleporting outside)
					vault = {x = -796.31213378906, y = 327.95443725586, z = 217.03817749023, h = 358.63342285156}, -- The marker for the vault
				},
				rent = 6900, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[16] = {
				property_name = "Eclipse Towers Suite 4", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = {x = -776.96978759766, y = 319.39965820313, z = 85.662658691406, h = 180.13366699219}, -- The marker outside (used for teleporting inside)
					inside = {x = -773.91912841797, y = 342.04846191406, z = 196.68618774414, h = 88.26774597168}, -- The marker inside (used for teleporting outside)
					vault = {x = -764.60382080078, y = 329.92166137695, z = 196.08601379395, h = 176.91903686523}, -- The marker for the vault
				},
				rent = 6900, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[17] = {
				property_name = "Eclipse Towers Suite 5", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = {x = -771.01837158203, y = 319.60760498047, z = 85.662658691406, h = 177.56271362305}, -- The marker outside (used for teleporting inside)
					inside = {x = -787.19079589844, y = 315.70843505859, z = 187.91346740723, h = 270.94097900391}, -- The marker inside (used for teleporting outside)
					vault = {x = -796.55810546875, y = 327.93563842773, z = 187.31323242188, h = 2.0378932952881}, -- The marker for the vault
				},
				rent = 6900, --How much it costs to rent the property (PER DAY)
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 150000, --Max marked bills the property can hold
						weapons = 6, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Cooldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},      --]]
		},
	},
	businesses = {
		normal = {
			[1] = {
				property_name = "Vanilla Unicorn", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				overdue = false,
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(93.631385803223,-1291.7485351563,29.268758773804), -- The location of the property
				rent = 1600, --How much it costs to rent the property (PER DAY)
				income = 500, --How much money the owner is payed WHILE they are online, they get paid this amount every 15 minutes by default
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 25000, --Max cash the property can hold
						dirty = 50000, --Max marked bills the property can hold
						weapons = 1, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 3600, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},
			[2] = {
				property_name = "The Bean Machine", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				overdue = false,
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = vector3(-627.96807861328,223.9681854248,81.881530761719), -- The location of the property
				rent = 1600, --How much it costs to rent the property (PER DAY)
				income = 500, --How much money the owner is payed WHILE they are online, they get paid this amount every 15 minutes by default
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 25000, --Max cash the property can hold
						dirty = 25000, --Max marked bills the property can hold
						weapons = 1, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 3600, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			}
			--[[[2] = {
				property_name = "Tequi-la-la", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				overdue = false,
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {x = -561.79840087891, y = 289.189453125, z = 82.17643737793, h = 355.47973632813}, -- The location of the property
				rent = 2800, --How much it costs to rent the property (PER DAY)
				income = 250, --How much money the owner is payed WHILE they are online, they get paid this amount every 15 minutes by default
				storage = {
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 4000,--Max cash the property can hold
						dirty = 4000,--Max marked bills the property can hold
						weapons = 1, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				expire = 1 --Default (don't touch)
			},--]]
		},
		enterable = {
			-- [1] = {
			-- 	property_name = "Warehouse 1", -- Name of the property (used as the title of the menu)
			-- 	locked = false, --Default (don't touch)
			-- 	overdue = false,
			-- 	owner =  {
			-- 		identifier = "no", --Default (don't touch)
			-- 		char_id = 0, --Default (don't touch)
			-- 		id = 0, --Default (don't touch)
			-- 	},
			-- 	coordinates = {
			-- 		outside = {x = 714.0797, y = -718.3225, z = 26.09685, h = 359.4313}, -- The marker outside (used for teleporting inside)
			-- 		inside = {x = 992.7667, y = -3098.174, z = -38.99586, h = 228.594}, -- The marker inside (used for teleporting outside)
			-- 		vault = {x = 1014.362, y = -3105.95, z = -38.99986, h = 267.0504}, -- The marker for the vault
			-- 	},
			-- 	rent = 8000, --How much it costs to rent the property (PER DAY)
			-- 	income = 500, --How much money the owner is payed WHILE they are online, they get paid this amount every 15 minutes by default
			-- 	storage = {
			-- 		locked = false, --Default (don't touch)
			-- 		current = {
			-- 			cash = 0, --Default (don't touch)
			-- 			dirty = 0, --Default (don't touch)
			-- 			weapons = {}, --Default (don't touch)
			-- 		},
			-- 		max = {
			-- 			cash = 10000, --Max cash the property can hold
			-- 			dirty = 10000, --Max marked bills the property can hold
			-- 			weapons = 6, --Max weapons the property can hold
			-- 		},
			-- 	},
			-- 	robbing = {
			-- 		cooldown = 2700, --Robbery cooldown time in seconds
			-- 		last_robbed = 0, --Default (don't touch)
			-- 		being_robbed = false, --Default (don't touch)
			-- 		time = 300, --The total time the robber has to hack the vault
			-- 		max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
			-- 	},
			-- 	lockpicking = {
			-- 		cooldown = 300, --Colldown between lockpicking attempts
			-- 		last_picked = 0, --Default (don't touch)
			-- 	},
			-- 	expire = 1 --Default (don't touch)
			-- },
			-- [2] = {
			-- 	property_name = "MC Clubhouse", -- Name of the property (used as the title of the menu)
			-- 	locked = false, --Default (don't touch)
			-- 	overdue = false,
			-- 	owner =  {
			-- 		identifier = "no", --Default (don't touch)
			-- 		char_id = 0, --Default (don't touch)
			-- 		id = 0, --Default (don't touch)
			-- 	},
			-- 	coordinates = {
			-- 		outside = {x = 2471.213, y = 4110.867, z = 38.06467, h = 247.3684}, -- The marker outside (used for teleporting inside)
			-- 		inside = {x = 997.0413, y = -3158.019, z = -38.90715, h = 247.4221}, -- The marker inside (used for teleporting outside)
			-- 		vault = {x = 1001.748, y = -3167.127, z = -34.07746, h = 263.3291}, -- The marker for the vault
			-- 	},
			-- 	rent = 7500, --How much it costs to rent the property (PER DAY)
			-- 	income = 500, --How much money the owner is payed WHILE they are online, they get paid this amount every 15 minutes by default
			-- 	storage = {
			-- 		locked = false, --Default (don't touch)
			-- 		current = {
			-- 			cash = 0, --Default (don't touch)
			-- 			dirty = 0, --Default (don't touch)
			-- 			weapons = {}, --Default (don't touch)
			-- 		},
			-- 		max = {
			-- 			cash = 10000, --Max cash the property can hold
			-- 			dirty = 10000, --Max marked bills the property can hold
			-- 			weapons = 6, --Max weapons the property can hold
			-- 		},
			-- 	},
			-- 	robbing = {
			-- 		cooldown = 2700, --Robbery cooldown time in seconds
			-- 		last_robbed = 0, --Default (don't touch)
			-- 		being_robbed = false, --Default (don't touch)
			-- 		time = 300, --The total time the robber has to hack the vault
			-- 		max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
			-- 	},
			-- 	lockpicking = {
			-- 		cooldown = 300, --Colldown between lockpicking attempts
			-- 		last_picked = 0, --Default (don't touch)
			-- 	},
			-- 	expire = 1 --Default (don't touch)
			-- },
			-- [3] = {
			-- 	property_name = "MC Clubhouse 2", -- Name of the property (used as the title of the menu)
			-- 	locked = false, --Default (don't touch)
			-- 	overdue = false,
			-- 	owner =  {
			-- 		identifier = "no", --Default (don't touch)
			-- 		char_id = 0, --Default (don't touch)
			-- 		id = 0, --Default (don't touch)
			-- 	},
			-- 	coordinates = {
			-- 		outside = {x = -379.6051, y = 6062.196, z = 31.50013, h = 222.5358}, -- The marker outside (used for teleporting inside)
			-- 		inside = {x = 1120.963, y = -3152.196, z = -37.06273, h = 222.8231}, -- The marker inside (used for teleporting outside)
			-- 		vault = {x = 1112.419, y = -3145.239, z = -37.06273, h = 235.9401}, -- The marker for the vault
			-- 	},
			-- 	rent = 7500, --How much it costs to rent the property (PER DAY)
			-- 	income = 500, --How much money the owner is payed WHILE they are online, they get paid this amount every 15 minutes by default
			-- 	storage = {
			-- 		locked = false, --Default (don't touch)
			-- 		current = {
			-- 			cash = 0, --Default (don't touch)
			-- 			dirty = 0, --Default (don't touch)
			-- 			weapons = {}, --Default (don't touch)
			-- 		},
			-- 		max = {
			-- 			cash = 10000, --Max cash the property can hold
			-- 			dirty = 10000, --Max marked bills the property can hold
			-- 			weapons = 6, --Max weapons the property can hold
			-- 		},
			-- 	},
			-- 	robbing = {
			-- 		cooldown = 2700, --Robbery cooldown time in seconds
			-- 		last_robbed = 0, --Default (don't touch)
			-- 		being_robbed = false, --Default (don't touch)
			-- 		time = 300, --The total time the robber has to hack the vault
			-- 		max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
			-- 	},
			-- 	lockpicking = {
			-- 		cooldown = 300, --Colldown between lockpicking attempts
			-- 		last_picked = 0, --Default (don't touch)
			-- 	},
			-- 	expire = 1 --Default (don't touch)
			-- },
			[1] = {
				property_name = "Bahama Mamas", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				overdue = false,
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = {x = -1388.762, y = -586.2709, z = 30.21918, h = 210.0018}, -- The marker outside (used for teleporting inside)
					inside = {x = -1387.151, y = -589.4478, z = 30.31952, h = 128.8528}, -- The marker inside (used for teleporting outside)
					vault = {x = -1375.394, y = -624.3627, z = 30.81958, h = 295.184}, -- The marker for the vault
				},
				rent = 5000, --How much it costs to rent the property (PER DAY)
				income = 500, --How much money the owner is payed WHILE they are online, they get paid this amount every 15 minutes by default
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 100000, --Max cash the property can hold
						dirty = 250000, --Max marked bills the property can hold
						weapons = 13, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 13, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Colldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[2] = {
				property_name = "Galaxy Nightclub", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				overdue = false,
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = {x = -15.761074066162, y = 216.64323425293, z = 106.7442779541, h = 83.192993164063}, -- The marker outside (used for teleporting inside)
        			inside = {x = -1569.3054199219, y = -3016.9519042969, z = -74.406150817871, h = 2.6814656257629}, -- The marker inside (used for teleporting outside)
					vault = {x = -1581.7600097656, y = -3018.3195800781, z = -79.005935668945, h = 91.424942016602}, -- The marker for the vault
				},
				rent = 4000, --How much it costs to rent the property (PER DAY)
				income = 500, --How much money the owner is payed WHILE they are online, they get paid this amount every 15 minutes by default
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 10000, --Max marked bills the property can hold
						weapons = 1, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Colldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
			[3] = {
				property_name = "Lom Bank Offices", -- Name of the property (used as the title of the menu)
				locked = false, --Default (don't touch)
				overdue = false,
				owner =  {
					identifier = "no", --Default (don't touch)
					char_id = 0, --Default (don't touch)
					id = 0, --Default (don't touch)
				},
				coordinates = {
					outside = {x = -1581.3356933594, y = -558.00543212891, z = 34.95316696167, h = 36.511291503906}, -- The marker outside (used for teleporting inside)
        			inside = {x = -1579.693, y = -564.8981, z = 108.5229, h = 0.0}, -- The marker inside (used for teleporting outside)
					vault = {x = 0.0, y = 0.0, z = -20.0, h = 91.424942016602}, -- The marker for the vault
				},
				rent = 2000, --How much it costs to rent the property (PER DAY)
				income = 500, --How much money the owner is payed WHILE they are online, they get paid this amount every 15 minutes by default
				storage = {
					locked = false, --Default (don't touch)
					current = {
						cash = 0, --Default (don't touch)
						dirty = 0, --Default (don't touch)
						weapons = {}, --Default (don't touch)
					},
					max = {
						cash = 10000, --Max cash the property can hold
						dirty = 10000, --Max marked bills the property can hold
						weapons = 1, --Max weapons the property can hold
					},
				},
				robbing = {
					cooldown = 2700, --Robbery cooldown time in seconds
					last_robbed = 0, --Default (don't touch)
					being_robbed = false, --Default (don't touch)
					time = 300, --The total time the robber has to hack the vault
					max_phases = 6, --How many levels of security the property has, basically how much times the minigame is replayed (the time is used here, per phase the time gets split, time/max_phases)
				},
				lockpicking = {
					cooldown = 300, --Colldown between lockpicking attempts
					last_picked = 0, --Default (don't touch)
				},
				expire = 1 --Default (don't touch)
			},
		},
	},
}
PlayerCustomisation = {}

PlayerCustomisation.Pool = NativeUI.CreatePool()

PlayerCustomisation.PlayerData = {
	Type = "Default",
	Default = {
		Gender = "Male",
		Model = "mp_m_freemode_01",
		Male = {
			Clothing = {
				Drawable = {0, 0, 37, 6, 12, 0, 8, 0, 5, 0, 0, 3},
				Texture = {0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0},
				Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			},
			Props = {
				Drawable = {-1, -1, -1, -1, -1, -1, -1},
				Texture = {-1, -1, -1, -1, -1, -1, -1},
			},
			Overlay = {
				Drawable = {255, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255},
				Opacity = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0},
				Colours = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			},
			FacialFeature = {0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5},
			HeadBlend = {21, 19, 0.0, 0.0},
			HairColour = {0, 0},
			EyeColour = 0,
			Highlights = false,
			Tattoo = {},
		},
		Female = {
			Clothing = {
				Drawable = {45, 0, 42, 4, 3, 0, 4, 0, 0, 0, 0, 32},
				Texture = {0, 0, 0, 0, 8, 0, 1, 0, 240, 0, 0, 0},
				Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			},
			Props = {
				Drawable = {-1, -1, -1, -1, -1, -1, -1},
				Texture = {-1, -1, -1, -1, -1, -1, -1},
			},
			Overlay = {
				Drawable = {255, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255},
				Opacity = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0},
				Colours = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			},
			FacialFeature = {0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5},
			HeadBlend = {21, 19, 0.0, 0.0},
			HairColour = {0, 0},
			EyeColour = 0,
			Highlights = false,
			Tattoo = {},
		},
		Hybrid = {
			Clothing = {
				Drawable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				Texture = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			},
			Props = {
				Drawable = {-1, -1, -1, -1, -1, -1, -1},
				Texture = {-1, -1, -1, -1, -1, -1, -1},
			},
		},
	},
}

PlayerCustomisation.Locations = {
	Clothing = {},
	Barbers = {
        [1] = {
            Blip = {
                Name = "Tattoo Store", 
                Sprite = 75, 
                Colour = 0,
            },
            Marker = {
                x = 1322.645,
                y = -1651.976,
                z = 52.275,
            },
            Banner = "shopui_title_barber",
        },
	},
	Tattoos = {},
}

PlayerCustomisation.Reference = {
	RangeTable = {-1.0, -0.9, -0.8, -0.7, -0.6, -0.5, -0.4, -0.3, -0.2, -0.1, 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0},
	Colours = {
		Hair = {
			[1] = {44, 41, 35},
			[2] = {65, 56, 50},
			[3] = {95, 70, 55},
			[4] = {99, 56, 39},
			[5] = {117, 55, 34},
			[6] = {156, 78, 44},
			[7] = {170, 98, 60},
			[8] = {185, 124, 87},
			[9] = {197, 148, 107},
			[10] = {212, 171, 120},
			[11] = {216, 172, 125},
			[12] = {225, 189, 137},
			[13] = {230, 197, 143},
			[14] = {236, 194, 120},
			[15] = {241, 204, 134},
			[16] = {255, 220, 166},
			[17] = {211, 163, 115},
			[18] = {193, 121, 81},
			[19] = {161, 64, 45},
			[20] = {144, 18, 19},
			[21] = {170, 28, 21},
			[22] = {188, 32, 26},
			[23] = {203, 49, 22},
			[24] = {245, 94, 40},
			[25] = {210, 103, 61},
			[26] = {225, 102, 44},
			[27] = {155, 128, 114},
			[28] = {192, 169, 155},
			[29] = {223, 204, 190},
			[30] = {247, 229, 216},
			[31] = {132, 94, 115},
			[32] = {156, 101, 132},
			[33] = {184, 88, 126},
			[34] = {254, 95, 233},
			[35] = {255, 97, 176},
			[36] = {249, 177, 185},
			[37] = {17, 177, 167},
			[38] = {1, 139, 156},
			[39] = {17, 86, 141},
			[40] = {119, 192, 120},
			[41] = {70, 175, 126},
			[42] = {42, 123, 106},
			[43] = {191, 201, 50},
			[44] = {175, 209, 35},
			[45] = {97, 181, 30},
			[46] = {254, 217, 115},
			[47] = {253, 214, 25},
			[48] = {255, 181, 16},
			[49] = {255, 138, 49},
			[50] = {255, 132, 43},
			[51] = {242, 87, 35},
			[52] = {235, 46, 14},
			[53] = {215, 12, 18},
			[54] = {187, 13, 20},
			[55] = {39, 26, 21},
			[56] = {60, 33, 24},
			[57] = {75, 47, 36},
			[58] = {86, 51, 40},
			[59] = {74, 40, 30},
			[60] = {75, 39, 25},
			[61] = {48, 29, 22},
			[62] = {7, 11, 13},
			[63] = {222, 186, 135},
			[64] = {220, 174, 119},
		},
		Lipstick = {
			[1] = {153, 37, 50},
			[2] = {201, 57, 93},
			[3] = {189, 81, 107},
			[4] = {184, 99, 122},
			[5] = {167, 81, 106},
			[6] = {177, 67, 78},
			[7] = {128, 49, 52},
			[8] = {164, 99, 95},
			[9] = {193, 135, 121},
			[10] = {162, 128, 119},
			[11] = {167, 166, 114},
			[12] = {137, 89, 77},
			[13] = {141, 77, 65},
			[14] = {134, 62, 40},
			[15] = {145, 90, 96},
			[16] = {163, 102, 117},
			[17] = {190, 126, 153},
			[18] = {184, 94, 130},
			[19] = {222, 61, 129},
			[20] = {181, 75, 111},
			[21] = {113, 38, 58},
			[22] = {79, 32, 42},
			[23] = {170, 34, 48},
			[24] = {221, 32, 52},
			[25] = {208, 8, 19},
			[26] = {229, 84, 113},
			[27] = {220, 62, 181},
			[28] = {194, 39, 177},
			[29] = {161, 28, 169},
			[30] = {109, 24, 115},
			[31] = {115, 20, 101},
			[32] = {85, 22, 92},
			[33] = {42, 26, 113},
			[34] = {18, 33, 85},
			[35] = {18, 40, 121},
			[36] = {26, 56, 126},
			[37] = {20, 82, 155},
			[38] = {23, 88, 143},
			[39] = {27, 96, 112},
			[40] = {26, 85, 89},
			[41] = {28, 70, 53},
			[42] = {20, 50, 36},
			[43] = {41, 83, 56},
			[44] = {65, 102, 44},
			[45] = {58, 85, 28},
			[46] = {79, 101, 37},
			[47] = {83, 90, 39},
			[48] = {118, 87, 40},
			[49] = {122, 55, 31},
			[50] = {116, 79, 62},
			[51] = {185, 171, 140},
			[52] = {200, 193, 187},
			[53] = {194, 190, 202},
			[54] = {161, 164, 176},
			[55] = {139, 142, 152},
			[56] = {49, 47, 64},
			[57] = {27, 22, 23},
			[58] = {68, 114, 128},
			[59] = {85, 97, 113},
			[60] = {31, 31, 53},
			[61] = {141, 103, 80},
			[62] = {138, 97, 82},
			[63] = {120, 84, 71},
			[64] = {58, 43, 36},
		},
		Blusher = {
			[1] = {153, 37, 50},
			[2] = {201, 57, 93},
			[3] = {189, 80, 109},
			[4] = {184, 99, 122},
			[5] = {166, 82, 106},
			[6] = {177, 67, 76},
			[7] = {128, 49, 52},
			[8] = {164, 99, 95},
			[9] = {193, 135, 121},
			[10] = {162, 128, 119},
			[11] = {159, 115, 115},
			[12] = {137, 89, 79},
			[13] = {141, 77, 65},
			[14] = {134, 61, 42},
			[15] = {145, 90, 96},
			[16] = {163, 102, 117},
			[17] = {190, 126, 153},
			[18] = {184, 94, 130},
			[19] = {222, 61, 129},
			[20] = {181, 75, 111},
			[21] = {113, 38, 58},
			[22] = {79, 32, 42},
			[23] = {171, 33, 48},
			[24] = {229, 84, 113},
			[25] = {200, 62, 181},
			[26] = {249, 230, 190},
			[27] = {161, 126, 107},
		},
	},
	Heritage = {
		Female = {
			{Name = "Hannah", Value = {Face = 21, Portrait = 0}},
			{Name = "Violet", Value = {Face = 30, Portrait = 9}},
			{Name = "Giselle", Value = {Face = 24, Portrait = 3}},
			{Name = "Misty", Value = {Face = 45, Portrait = 21}},
			{Name = "Brianna", Value = {Face = 36, Portrait = 15}},
			{Name = "Grace", Value = {Face = 35, Portrait = 14}},
			{Name = "Ava", Value = {Face = 28, Portrait = 7}},
			{Name = "Olvia", Value = {Face = 38, Portrait = 17}},
			{Name = "Camila", Value = {Face = 29, Portrait = 8}},
			{Name = "Ashley", Value = {Face = 34, Portrait = 13}},
			{Name = "Zoe", Value = {Face = 27, Portrait = 6}},
			{Name = "Natalie", Value = {Face = 37, Portrait = 16}},
			{Name = "Isabella", Value = {Face = 26, Portrait = 5}},
			{Name = "Evelyn", Value = {Face = 32, Portrait = 11}},
			{Name = "Amelia", Value = {Face = 25, Portrait = 4}},
			{Name = "Elizabeth", Value = {Face = 39, Portrait = 18}},			
			{Name = "Audrey", Value = {Face = 22, Portrait = 1}},
			{Name = "Sophia", Value = {Face = 31, Portrait = 10}},
			{Name = "Jasmine", Value = {Face = 23, Portrait = 2}},
			{Name = "Emma", Value = {Face = 41, Portrait = 20}},
			{Name = "Nicole", Value = {Face = 33, Portrait = 12}},
			{Name = "Charlotte", Value = {Face = 40, Portrait = 19}},
		},
		Male = {
			{Name = "Samuel", Value = {Face = 19, Portrait = 19}},
			{Name = "Santiago", Value = {Face = 16, Portrait = 16}},
			{Name = "Vincent", Value = {Face = 10, Portrait = 10}},
			{Name = "Andrew", Value = {Face = 4, Portrait = 4}},
			{Name = "Isaac", Value = {Face = 7, Portrait = 7}},
			{Name = "Daniel", Value = {Face = 1, Portrait = 1}},
			{Name = "John", Value = {Face = 44, Portrait = 23}},
			{Name = "Angel", Value = {Face = 11, Portrait = 11}},
			{Name = "Evan", Value = {Face = 8, Portrait = 8}},
			{Name = "Noah", Value = {Face = 3, Portrait = 3}},
			{Name = "Ethan", Value = {Face = 9, Portrait = 9}},
			{Name = "Benjamin", Value = {Face = 0, Portrait = 0}},
			{Name = "Michael", Value = {Face = 15, Portrait = 15}},
			{Name = "Claude", Value = {Face = 42, Portrait = 21}},
			{Name = "Niko", Value = {Face = 43, Portrait = 22}},
			{Name = "Anthony", Value = {Face = 20, Portrait = 20}},
			{Name = "Adrian", Value = {Face = 13, Portrait = 13}},
			{Name = "Gabriel", Value = {Face = 14, Portrait = 14}},
			{Name = "Kevin", Value = {Face = 17, Portrait = 17}},
			{Name = "Juan", Value = {Face = 5, Portrait = 5}},
			{Name = "Joshua", Value = {Face = 2, Portrait = 2}},
			{Name = "Louis", Value = {Face = 18, Portrait = 18}},
			{Name = "Alex", Value = {Face = 6, Portrait = 6}},
			{Name = "Diego", Value = {Face = 12, Portrait = 12}},
		},
	},
	Features = {
		Brow = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Protruding", Value = {X = 0.8, Y = 0.6}}, 
			{Name = "Shallow", Value = {X = 0.35, Y = 0.5}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
		Eyes = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Wide", Value = {X = 0.81, Y = 0.5}}, 
			{Name = "Squint", Value = {X = 0.19, Y = 0.5}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
		Nose = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Large", Value = {X = 0.81, Y = 0.7}}, 
			{Name = "Small", Value = {X = 0.19, Y = 0.3}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
		NoseProfile = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Crooked", Value = {X = 0.58, Y = 0.19}}, 
			{Name = "Curved", Value = {X = 0.42, Y = 0.81}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
		NoseTip = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Broken", Value = {X = 0.19, Y = 0.5}}, 
			{Name = "Up Turned", Value = {X = 0.5, Y = 0.22}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
		Cheekbones = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Large", Value = {X = 0.65, Y = 0.65}}, 
			{Name = "Small", Value = {X = 0.35, Y = 0.35}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
		Cheeks = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Fat", Value = {X = 0.81, Y = 0.5}}, 
			{Name = "Thin", Value = {X = 0.19, Y = 0.5}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
		Lips = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Large", Value = {X = 0.81, Y = 0.5}}, 
			{Name = "Small", Value = {X = 0.19, Y = 0.5}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
		Jaw = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Square", Value = {X = 0.5, Y = 0.81}}, 
			{Name = "Round", Value = {X = 0.5, Y = 0.19}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
		ChinProfile = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Large", Value = {X = 0.81, Y = 0.74}}, 
			{Name = "Small", Value = {X = 0.23, Y = 0.23}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
		ChinShape = {
			{Name = "Standard", Value = {X = 0.5, Y = 0.5}}, 
			{Name = "Pointed", Value = {X = 0.78, Y = 0.5}}, 
			{Name = "Round", Value = {X = 0.35, Y = 0.25}}, 
			{Name = "Custom", Value = {[1] = {X = 0.5, Y = 0.5}}, Panel = true}
		},
	},
	Appearance = {
		Hairstyles = {
			Male = {
				{Name = "Bald", Value = 0},
				{Name = "Buzzcut", Value = 37},
				{Name = "Faux Hawk", Value = 38},
				{Name = "Hipster", Value = 39},
				{Name = "Side Parting", Value = 40},
				{Name = "Shorter Cut", Value = 41},
				{Name = "Biker", Value = 42},
				{Name = "Ponytail", Value = 43},
				{Name = "Cornrows", Value = 44},
				{Name = "Slicked", Value = 45},
				{Name = "Short Brushed", Value = 46},
				{Name = "Spikey", Value = 47},
				{Name = "Caesar", Value = 48},
				{Name = "Chopped", Value = 49},
				{Name = "Dreads", Value = 50},
				{Name = "Long Hair", Value = 51},
				{Name = "Shaggy Curls", Value = 52},
				{Name = "Surfer Dude", Value = 53},
				{Name = "Short Side Part", Value = 54},
				{Name = "High Slicked Sides", Value = 55},
				{Name = "Long Slicked", Value = 56},
				{Name = "Hipster Youth", Value = 57},
				{Name = "Mullet", Value = 58},
				{Name = "Classic Cornrows", Value = 59},
				{Name = "Palm Cornrows", Value = 60},
				{Name = "Lightning Cornrows", Value = 61},
				{Name = "Whipped Cornrows", Value = 62},
				{Name = "Zig Zag Cornrows", Value = 63},
				{Name = "Snail Cornrows", Value = 64},
				{Name = "Hightop", Value = 65},
				{Name = "Loose Swept Back", Value = 66},
				{Name = "Undercut Swept Back", Value = 67},
				{Name = "Undercut Swept Side", Value = 68},
				{Name = "Spiked Mohawk", Value = 69},
				{Name = "Mod", Value = 70},
				{Name = "Layered Mod", Value = 71},
				{Name = "Flattop", Value = 72},
				{Name = "Military Buzzcut", Value = 73},
			},
			Female = {
				{Name = "Bald", Value = 0},
				{Name = "Short", Value = 39},
				{Name = "Layered Bob", Value = 40},
				{Name = "Pigtails", Value = 41},
				{Name = "Ponytail", Value = 42},
				{Name = "Braided Mohawk", Value = 43},
				{Name = "Braids", Value = 44},
				{Name = "Bob", Value = 45},
				{Name = "Faux Hawk", Value = 46},
				{Name = "French Twist", Value = 47},
				{Name = "Long Bob", Value = 48},
				{Name = "Loose Tied", Value = 49},
				{Name = "Pixie", Value = 50},
				{Name = "Shaved Bangs", Value = 51},
				{Name = "Top Knot", Value = 52},
				{Name = "Wavy Bob", Value = 53},
				{Name = "Messy Bun", Value = 55},
				{Name = "Pin Up Girl", Value = 54},
				{Name = "Tight Bun", Value = 57},
				{Name = "Twisted Bob", Value = 58},
				{Name = "Flapper Bob", Value = 56},
				{Name = "Big Bangs", Value = 59},
				{Name = "Braided Top Knot", Value = 60},
				{Name = "Mullet", Value = 61},
				{Name = "Pinched Cornrows", Value = 62},
				{Name = "Leaf Cornrows", Value = 63},
				{Name = "Zig Zag Cornrows", Value = 64},
				{Name = "Pigtail Bangs", Value = 65},
				{Name = "Wave Braids", Value = 66},
				{Name = "Coil Braids", Value = 67},
				{Name = "Rolled Quiff", Value = 68},
				{Name = "Loose Swept Back", Value = 69},
				{Name = "Undercut Swept Back", Value = 70},
				{Name = "Undercut Swept Side", Value = 71},
				{Name = "Spiked Mohawk", Value = 72},
				{Name = "Bandana and Braid", Value = 73},
				{Name = "Layered Mod", Value = 75},
				{Name = "Skinbyrd", Value = 74},
				{Name = "Neat Bun", Value = 76},
				{Name = "Short Bob", Value = 77},
			},
		},
		Eyebrows = {
			{Name = "None", Value = 255},
		},
		Beards = {
			{Name = "Clean Shaven", Value = 255},
			{Name = "Light Stubble", Value = 0},
			{Name = "Balbo", Value = 1},
			{Name = "Circle Beard", Value = 2},
			{Name = "Goatee", Value = 3},
			{Name = "Chin", Value = 4},
			{Name = "Chin Fuzz", Value = 5},
			{Name = "Pencil Chin Strap", Value = 6},
			{Name = "Scruffy", Value = 7},
			{Name = "Musketeer", Value = 8},
			{Name = "Mustache", Value = 9},
			{Name = "Trimmed Beard", Value = 10},
			{Name = "Stubble", Value = 11},
			{Name = "Thin Circle Beard", Value = 12},
			{Name = "Horseshoe", Value = 13},
			{Name = "Pencil and 'Chops", Value = 14},
			{Name = "Chin Strap Beard", Value = 15},
			{Name = "Balbo and Sideburns", Value = 16},
			{Name = "Mutton Chops", Value = 17},
			{Name = "Scruffy Beard", Value = 18},
			{Name = "Curly", Value = 19},
			{Name = "Curly & Deep Stranger", Value = 20},
			{Name = "Handlebar", Value = 21},
			{Name = "Faustic", Value = 22},
			{Name = "Otto & Patch", Value = 23},
			{Name = "Otto & Full Stranger", Value = 24},
			{Name = "Light Franz", Value = 25},
			{Name = "The Hampstead", Value = 26},
			{Name = "The Ambrose", Value = 27},
			{Name = "Lincoln Curtain", Value = 28},
		},
		Blemishes = {
			{Name = "None", Value = 255},
			{Name = "Measles", Value = 0},
			{Name = "Pimples", Value = 1},
			{Name = "Spots", Value = 2},
			{Name = "Break Out", Value = 3},
			{Name = "Blackheads", Value = 4},
			{Name = "Build Up", Value = 5},
			{Name = "Pustules", Value = 6},
			{Name = "Zits", Value = 7},
			{Name = "Full Acne", Value = 8},
			{Name = "Acne", Value = 9},
			{Name = "Cheek Rash", Value = 10},
			{Name = "Face Rash", Value = 11},
			{Name = "Picker", Value = 12},
			{Name = "Puberty", Value = 13},
			{Name = "Eyesore", Value = 14},
			{Name = "Chin Rash", Value = 15},
			{Name = "Two Face", Value = 16},
			{Name = "T-zone", Value = 17},
			{Name = "Greasy", Value = 18},
			{Name = "Marked", Value = 19},
			{Name = "Acne Scarring", Value = 20},
			{Name = "Full Acne Scarring", Value = 21},
			{Name = "Cold Sores", Value = 22},
			{Name = "Impetigo", Value = 23},
		},
		SkinAging = {
			{Name = "None", Value = 255},
			{Name = "Corw's Feet", Value = 0},
			{Name = "First Signs", Value = 1},
			{Name = "Middle Aged", Value = 2},
			{Name = "Worry Lines", Value = 3},
			{Name = "Depression", Value = 4},
			{Name = "Distinguished", Value = 5},
			{Name = "Aged", Value = 6},
			{Name = "Weathered", Value = 7},
			{Name = "Wrinkled", Value = 8},
			{Name = "Sagging", Value = 9},
			{Name = "Tough Life", Value = 10},
			{Name = "Vintage", Value = 11},
			{Name = "Retired", Value = 12},
			{Name = "Junkie", Value = 13},
			{Name = "Geriatric", Value = 14},
		},
		SkinComplexion = {
			{Name = "None", Value = 255},
			{Name = "Rosy Cheeks", Value = 0},
			{Name = "Stubble Rash", Value = 1},
			{Name = "Hot Flush", Value = 2},
			{Name = "Sun Burn", Value = 3},
			{Name = "Bruised", Value = 4},
			{Name = "Alcoholic", Value = 5},
			{Name = "Patchy", Value = 6},
			{Name = "Totem", Value = 7},
			{Name = "Blood Vessels", Value = 8},
			{Name = "Damaged", Value = 9},
			{Name = "Pale", Value = 10},
			{Name = "Ghostly", Value = 11},
		},
		MolesFreckles = {
			{Name = "None", Value = 255},
			{Name = "Cherub", Value = 0},
			{Name = "All Over", Value = 1},
			{Name = "Irregular", Value = 2},
			{Name = "Dot Dash", Value = 3},
			{Name = "Over The Bridge", Value = 4},
			{Name = "Baby Doll", Value = 5},
			{Name = "Pixie", Value = 6},
			{Name = "Sun Kissed", Value = 7},
			{Name = "Beauty Marks", Value = 8},
			{Name = "Line Up", Value = 9},
			{Name = "Modelesque", Value = 10},
			{Name = "Occasional", Value = 11},
			{Name = "Speckled", Value = 12},
			{Name = "Rain Drops", Value = 13},
			{Name = "Double Dip", Value = 14},
			{Name = "One Sided", Value = 15},
			{Name = "Pairs", Value = 16},
			{Name = "Growth", Value = 17},
		},
		SkinDamage = {
			{Name = "None", Value = 255},
			{Name = "Uneven", Value = 0},
			{Name = "Sandpaper", Value = 1},
			{Name = "Patchy", Value = 2},
			{Name = "Rough", Value = 3},
			{Name = "Leathery", Value = 4},
			{Name = "Textured", Value = 5},
			{Name = "Coarse", Value = 6},
			{Name = "Rugged", Value = 7},
			{Name = "Creased", Value = 8},
			{Name = "Cracked", Value = 9},
			{Name = "Gritty", Value = 10},
		},
		Contacts = {},
		Eyes = {},
		FacePaint = {
			{Name = "None", Value = 255},
		},
		EyeMakeup = {
			{Name = "None", Value = 255},
		},
		Blush = {
			{Name = "None", Value = 255},
		},
		Lipstick = {
			{Name = "None", Value = 255},
		},
		Chest = {
			{Name = "Shaved", Value = 255},
		},
	},
	Apparel = {
		Styles  = {
			"Street",
			"Flashy",
			"Party",
			"Beach",
			"Smart",
			"Sporty",
			"Eccentric",
			"Casual",
		},
		Outfits = {
			Male = {
				[1] = {
					[1] = {
						Name = "The Hombre",
						Value = {						
							Drawable = {0,0,37,6,12,0,8,0,5,0,0,3},
							Texture = {0,0,0,0,7,0,0,0,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Man",
						Value = {						
							Drawable = {0,0,37,0,15,0,12,86,0,0,0,22},
							Texture = {0,0,0,0,9,0,12,0,240,0,0,1},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Felon",
						Value = {						
							Drawable = {0,0,37,0,7,0,1,0,1,0,0,7},
							Texture = {0,0,0,0,15,0,1,0,0,0,0,1},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Corner",
						Value = {						
							Drawable = {0,0,37,0,64,0,6,94,0,0,0,1},
							Texture = {0,0,0,0,2,0,0,1,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Hustler",
						Value = {						
							Drawable = {0,0,37,5,7,0,12,94,0,0,0,5},
							Texture = {0,0,0,0,4,0,4,1,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Shady",
						Value = {						
							Drawable = {0,0,37,6,5,0,12,94,111,0,0,3},
							Texture = {0,0,0,0,12,0,12,0,4,0,0,12},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Ready",
						Value = {						
							Drawable = {0,0,37,6,15,0,6,0,115,0,0,7},
							Texture = {0,0,0,0,12,0,0,0,1,0,0,1},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Gangsta",
						Value = {						
							Drawable = {0,0,37,0,1,0,8,92,0,0,0,22},
							Texture = {0,0,0,0,15,0,0,0,240,0,0,1},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[2] = {
					[1] = {
						Name = "The Blues",
						Value = {						
							Drawable = {0,0,0,1,24,0,10,12,31,0,0,31},
							Texture = {0,0,0,0,2,0,0,2,0,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Mr Frost",
						Value = {						
							Drawable = {0,0,0,1,4,0,10,12,4,0,0,24},
							Texture = {0,0,0,0,2,0,12,2,0,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Devil Chic",
						Value = {						
							Drawable = {0,0,0,1,4,0,20,12,4,0,0,24},
							Texture = {0,0,0,0,0,0,7,2,0,0,0,3},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Smooth Black Suit",
						Value = {						
							Drawable = {0,0,0,1,24,0,10,0,32,0,0,29},
							Texture = {0,0,0,0,0,0,0,0,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Royal",
						Value = {						
							Drawable = {0,0,0,6,26,0,20,0,5,0,0,4},
							Texture = {0,0,0,0,0,0,3,0,2,0,0,14},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Smooth White Suit",
						Value = {						
							Drawable = {0,0,0,1,24,0,10,0,32,0,0,29},
							Texture = {0,0,0,0,5,0,0,0,0,0,0,5},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Musician",
						Value = {						
							Drawable = {0,0,3,6,0,0,10,0,5,37,0,4},
							Texture = {0,0,0,0,1,0,0,0,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The V.I.P",
						Value = {						
							Drawable = {0,0,3,6,10,0,10,27,35,37,0,30},
							Texture = {0,0,0,0,0,0,0,2,1,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[3] = {
					[1] = {
						Name = "The Eco",
						Value = {						
							Drawable = {0,0,37,11,26,0,22,22,0,0,0,42},
							Texture = {0,0,0,0,3,0,7,3,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Aficionado",
						Value = {						
							Drawable = {0,0,37,12,26,0,22,0,38,0,16,35},
							Texture = {0,0,0,0,11,0,8,0,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The DJ",
						Value = {						
							Drawable = {0,0,37,0,27,0,1,0,0,0,0,0},
							Texture = {0,0,0,0,4,0,9,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Elitist",
						Value = {						
							Drawable = {0,0,37,0,26,0,23,0,43,0,0,35},
							Texture = {0,0,0,0,7,0,6,0,3,0,0,3},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Urban Hippy",
						Value = {						
							Drawable = {0,0,37,8,26,0,22,30,0,0,0,38},
							Texture = {0,0,0,0,0,0,3,3,240,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Natural",
						Value = {						
							Drawable = {0,0,37,12,26,0,22,0,38,0,0,35},
							Texture = {0,0,0,0,6,0,0,0,1,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Sky High",
						Value = {						
							Drawable = {0,0,37,0,26,0,7,0,0,0,0,44},
							Texture = {0,0,0,0,1,0,0,0,240,0,0,3},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The All Night",
						Value = {						
							Drawable = {0,0,37,0,26,0,22,39,0,0,0,35},
							Texture = {0,0,0,0,8,0,11,0,0,0,0,6},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[4] = {
					[1] = {
						Name = "The Dude",
						Value = {						
							Drawable = {0,0,3,5,15,0,16,0,0,37,0,17},
							Texture = {0,0,0,0,0,0,5,0,240,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Paradise",
						Value = {						
							Drawable = {0,0,3,0,18,0,1,0,0,37,0,1},
							Texture = {0,0,0,0,2,0,3,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Surfer",
						Value = {						
							Drawable = {0,0,3,5,16,0,16,0,0,37,0,17},
							Texture = {0,0,0,0,7,0,6,0,240,0,0,5},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Skimpy",
						Value = {						
							Drawable = {0,0,3,15,18,0,5,0,0,37,0,252},
							Texture = {0,0,0,0,11,0,3,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Summer Rays",
						Value = {						
							Drawable = {0,0,3,5,16,0,16,92,0,37,0,17},
							Texture = {0,0,0,0,2,0,8,0,240,0,0,3},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Heat",
						Value = {						
							Drawable = {0,0,3,5,18,0,16,0,0,37,0,5},
							Texture = {0,0,0,0,3,0,4,0,240,0,0,7},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Bare Chest",
						Value = {						
							Drawable = {0,0,3,15,16,0,1,81,0,37,0,252},
							Texture = {0,0,0,0,1,0,7,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Tidal Wave",
						Value = {						
							Drawable = {0,0,3,0,6,0,16,0,0,37,0,44},
							Texture = {0,0,0,0,10,0,6,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[5] = {
					[1] = {
						Name = "The Anchor",
						Value = {						
							Drawable = {0,0,0,1,22,0,11,38,28,0,0,24},
							Texture = {0,0,0,0,5,0,9,12,0,0,0,5},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Sharp Gray Suit",
						Value = {						
							Drawable = {0,0,0,6,25,0,11,0,32,0,0,31},
							Texture = {0,0,0,0,1,0,12,0,0,0,0,1},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Mogul",
						Value = {						
							Drawable = {0,0,0,11,22,0,20,27,6,0,0,25},
							Texture = {0,0,0,0,7,0,2,11,11,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Panther",
						Value = {						
							Drawable = {0,0,0,6,10,0,10,27,35,0,0,28},
							Texture = {0,0,0,0,0,0,0,2,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Grind",
						Value = {						
							Drawable = {0,0,0,0,10,0,21,21,15,0,0,26},
							Texture = {0,0,0,0,0,0,0,11,0,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Alligator",
						Value = {						
							Drawable = {0,0,0,2,22,0,21,12,28,0,0,23},
							Texture = {0,0,0,0,7,0,10,2,2,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Tycoon",
						Value = {						
							Drawable = {0,0,0,1,13,0,10,24,4,0,0,28},
							Texture = {0,0,0,0,2,0,0,14,2,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Collector",
						Value = {						
							Drawable = {0,0,0,11,48,0,21,24,6,0,0,25},
							Texture = {0,0,0,0,0,0,6,13,12,0,0,9},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[6] = {
					[1] = {
						Name = "The Jock",
						Value = {						
							Drawable = {0,0,3,6,3,0,2,0,0,37,0,3},
							Texture = {0,0,0,0,15,0,6,0,3,0,0,15},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Health Kick",
						Value = {						
							Drawable = {0,0,3,0,5,0,2,0,0,37,0,1},
							Texture = {0,0,0,0,6,0,6,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Brand",
						Value = {						
							Drawable = {0,0,3,0,15,0,2,0,0,37,0,9},
							Texture = {0,0,0,0,8,0,13,0,240,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Trainer",
						Value = {						
							Drawable = {0,0,3,8,14,0,2,0,0,37,0,38},
							Texture = {0,0,0,0,1,0,13,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Vibe",
						Value = {						
							Drawable = {0,0,3,1,7,0,35,0,115,37,0,7},
							Texture = {0,0,0,0,12,0,0,0,0,0,0,5},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Sweats",
						Value = {						
							Drawable = {0,0,3,1,3,0,7,0,41,37,0,7},
							Texture = {0,0,0,0,4,0,15,0,3,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Athlete",
						Value = {						
							Drawable = {0,0,3,0,18,0,9,0,0,37,0,39},
							Texture = {0,0,0,0,1,0,7,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Pro",
						Value = {						
							Drawable = {0,0,3,0,6,0,9,0,0,37,0,9},
							Texture = {0,0,0,0,0,0,0,0,240,0,0,10},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[7] = {
					[1] = {
						Name = "The Ironic",
						Value = {						
							Drawable = {0,0,53,0,26,0,20,11,93,0,0,40},
							Texture = {0,0,0,0,9,0,0,2,1,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Pop Up",
						Value = {						
							Drawable = {0,0,53,0,24,0,18,30,15,0,0,33},
							Texture = {0,0,0,0,4,0,0,4,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Tally-Ho",
						Value = {						
							Drawable = {0,0,53,1,22,0,20,25,4,0,0,24},
							Texture = {0,0,0,0,11,0,6,4,1,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Cool Cat",
						Value = {						
							Drawable = {0,0,53,0,7,0,14,0,0,0,0,0},
							Texture = {0,0,0,0,8,0,1,0,240,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Discotheque",
						Value = {						
							Drawable = {0,0,53,4,20,0,15,25,26,0,0,23},
							Texture = {0,0,0,0,0,0,0,0,12,0,0,3},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Animal",
						Value = {						
							Drawable = {0,0,53,4,26,0,15,23,10,0,0,35},
							Texture = {0,0,0,0,9,0,0,7,10,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Dork",
						Value = {						
							Drawable = {0,0,53,4,3,0,23,22,26,0,0,35},
							Texture = {0,0,0,0,3,0,2,6,6,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Prince",
						Value = {						
							Drawable = {0,0,53,4,26,0,23,0,0,0,60,24},
							Texture = {0,0,0,0,10,0,8,0,0,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[8] = {
					[1] = {
						Name = "The Plain White",
						Value = {						
							Drawable = {0,0,3,0,0,0,0,0,0,37,0,1},
							Texture = {0,0,0,0,2,0,10,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Skater",
						Value = {						
							Drawable = {0,0,0,0,1,0,1,0,0,0,0,14},
							Texture = {0,0,0,0,15,0,9,0,240,0,0,11},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Roller",
						Value = {						
							Drawable = {0,0,0,1,4,0,0,0,1,0,0,7},
							Texture = {0,0,0,0,2,0,10,0,5,0,0,15},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Simple",
						Value = {						
							Drawable = {0,0,0,0,1,0,1,0,15,0,0,22},
							Texture = {0,0,0,0,0,0,1,0,0,0,0,1},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Mellow",
						Value = {						
							Drawable = {0,0,0,1,1,0,1,0,15,0,0,41},
							Texture = {0,0,0,0,14,0,4,0,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Denims",
						Value = {						
							Drawable = {0,0,0,8,4,0,4,0,15,0,0,38},
							Texture = {0,0,0,0,4,0,1,0,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Worker",
						Value = {						
							Drawable = {0,0,0,8,8,0,1,0,15,0,0,14},
							Texture = {0,0,0,0,3,0,8,0,0,0,0,3},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Hangout",
						Value = {						
							Drawable = {0,0,0,0,0,0,1,0,15,0,0,33},
							Texture = {0,0,0,0,9,0,0,0,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
			},
			Female = {
				[1] = {
					[1] = {
						Name = "The Mamacita",
						Value = {						
							Drawable = {45,0,4,4,3,0,4,0,0,0,0,32},
							Texture = {0,0,0,0,8,0,1,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Convict",
						Value = {						
							Drawable = {45,0,4,3,3,0,3,0,0,0,0,3},
							Texture = {0,0,0,0,15,0,15,0,240,0,0,1},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Hoochie",
						Value = {						
							Drawable = {45,0,4,4,27,0,11,0,0,0,0,5},
							Texture = {0,0,0,0,0,0,1,0,240,0,0,9},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Community",
						Value = {						
							Drawable = {45,0,4,3,11,0,3,0,0,0,0,3},
							Texture = {0,0,0,0,0,0,1,0,240,0,0,12},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Chica",
						Value = {						
							Drawable = {45,0,4,4,3,0,4,0,0,0,0,5},
							Texture = {0,0,0,0,1,0,2,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Bad Influence",
						Value = {						
							Drawable = {45,0,4,4,4,0,3,0,0,0,0,32},
							Texture = {0,0,0,0,10,0,8,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Militia",
						Value = {						
							Drawable = {45,0,11,4,30,0,25,5,0,0,0,4},
							Texture = {0,0,0,0,1,0,0,4,240,0,0,14},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Fugitive",
						Value = {						
							Drawable = {45,0,11,3,11,0,7,0,0,0,0,43},
							Texture = {0,0,0,0,10,0,6,0,240,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[2] = {
					[1] = {
						Name = "The A List",
						Value = {						
							Drawable = {45,0,4,5,8,0,19,0,13,0,0,35},
							Texture = {0,0,0,0,4,0,3,0,0,0,0,5},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Egyptian",
						Value = {						
							Drawable = {45,0,4,4,9,0,42,4,0,0,0,13},
							Texture = {0,0,0,0,15,0,2,3,240,0,0,6},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Stylish",
						Value = {						
							Drawable = {45,0,4,5,23,0,42,7,13,0,0,24},
							Texture = {0,0,0,0,0,0,4,1,0,0,0,9},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Vanquish",
						Value = {						
							Drawable = {45,0,4,5,8,0,19,6,25,0,0,24},
							Texture = {0,0,0,0,0,0,3,1,4,0,0,6},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Spring Break",
						Value = {						
							Drawable = {45,0,4,5,9,0,14,6,13,0,0,8},
							Texture = {0,0,0,0,6,0,11,1,3,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Leopard",
						Value = {						
							Drawable = {45,0,4,5,24,0,42,0,13,0,0,25},
							Texture = {0,0,0,0,8,0,2,0,0,0,0,9},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Benefit",
						Value = {						
							Drawable = {45,0,4,5,8,0,8,0,5,0,0,8},
							Texture = {0,0,0,0,12,0,0,0,7,0,0,1},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Upmarket",
						Value = {						
							Drawable = {45,0,4,5,9,0,42,6,0,0,0,6},
							Texture = {0,0,0,0,8,0,2,0,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[3] = {
					[1] = {
						Name = "The Yuppie",
						Value = {						
							Drawable = {45,0,11,5,27,0,22,0,28,0,0,31},
							Texture = {0,0,0,0,6,0,0,0,0,0,0,6},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Butterfly",
						Value = {						
							Drawable = {45,0,4,12,8,0,7,9,0,0,0,4},
							Texture = {0,0,0,0,11,0,0,0,240,0,0,14},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Palms",
						Value = {						
							Drawable = {45,0,4,5,27,0,22,14,26,0,0,31},
							Texture = {0,0,0,0,10,0,10,2,1,0,0,3},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Kitten",
						Value = {						
							Drawable = {45,0,4,4,75,0,42,0,0,0,0,13},
							Texture = {0,0,0,0,0,0,2,0,240,0,0,7},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Jungle",
						Value = {						
							Drawable = {45,0,4,5,27,0,3,0,28,0,0,34},
							Texture = {0,0,0,0,2,0,10,0,3,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Bubblegum",
						Value = {						
							Drawable = {45,0,4,5,27,0,22,14,28,0,0,35},
							Texture = {0,0,0,0,11,0,4,3,6,0,0,3},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Stripe",
						Value = {						
							Drawable = {45,0,4,5,27,0,19,4,28,0,0,31},
							Texture = {0,0,0,0,7,0,1,2,1,0,0,6},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Spirit",
						Value = {						
							Drawable = {45,0,4,4,0,0,20,11,0,0,0,33},
							Texture = {0,0,0,0,7,0,5,0,240,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[4] = {
					[1] = {
						Name = "The Siesta",
						Value = {						
							Drawable = {45,0,4,15,25,0,16,0,0,0,0,18},
							Texture = {0,0,0,0,2,0,9,0,240,0,0,10},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Tropical",
						Value = {						
							Drawable = {45,0,4,9,16,0,15,14,0,0,0,17},
							Texture = {0,0,0,0,0,0,1,1,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Bather",
						Value = {						
							Drawable = {45,0,4,11,17,0,16,0,0,0,0,36},
							Texture = {0,0,0,0,7,0,8,0,240,0,0,3},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Beach Babe",
						Value = {						
							Drawable = {45,0,4,15,12,0,3,11,0,0,0,1},
							Texture = {0,0,0,0,14,0,13,1,240,0,0,9},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Chalet",
						Value = {						
							Drawable = {45,0,4,14,16,0,13,4,0,0,0,9},
							Texture = {0,0,0,0,8,0,5,3,240,0,0,3},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Sun Kissed",
						Value = {						
							Drawable = {45,0,4,15,16,0,16,9,0,0,0,18},
							Texture = {0,0,0,0,8,0,1,0,240,0,0,6},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Lifeguard",
						Value = {						
							Drawable = {45,0,4,15,17,0,16,3,0,0,0,36},
							Texture = {0,0,0,0,8,0,7,1,240,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Day Tripper",
						Value = {						
							Drawable = {45,0,4,5,16,0,16,10,16,0,0,31},
							Texture = {0,0,0,0,10,0,3,0,4,0,0,5},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[5] = {
					[1] = {
						Name = "The Ball-buster",
						Value = {						
							Drawable = {0,0,0,1,23,0,0,0,13,0,0,24},
							Texture = {0,0,0,0,4,0,0,0,0,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The 9-5",
						Value = {						
							Drawable = {0,0,0,0,24,0,19,13,0,0,0,27},
							Texture = {0,0,0,0,4,0,0,0,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Networker",
						Value = {						
							Drawable = {0,0,0,0,23,0,19,0,16,0,0,24},
							Texture = {0,0,0,0,0,0,3,0,5,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Suit",
						Value = {						
							Drawable = {0,0,0,5,23,0,13,6,23,0,0,7},
							Texture = {0,0,0,0,10,0,0,0,3,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Trader",
						Value = {						
							Drawable = {0,0,0,0,7,0,19,6,24,0,0,28},
							Texture = {0,0,0,0,2,0,9,0,3,0,0,10},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Boardroom",
						Value = {						
							Drawable = {0,0,0,0,6,0,42,6,16,0,0,6},
							Texture = {0,0,0,0,2,0,3,4,2,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Campaign",
						Value = {						
							Drawable = {0,0,0,0,7,0,20,6,13,0,0,25},
							Texture = {0,0,0,0,0,0,0,0,0,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Liberty",
						Value = {						
							Drawable = {0,0,0,0,23,0,42,13,0,0,0,27},
							Texture = {0,0,0,0,4,0,5,2,240,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[6] = {
					[1] = {
						Name = "The Competitor",
						Value = {						
							Drawable = {45,0,4,14,2,0,10,0,0,0,0,14},
							Texture = {0,0,0,0,0,0,2,0,240,0,0,7},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Jogger",
						Value = {						
							Drawable = {45,0,4,15,2,0,10,3,2,0,0,11},
							Texture = {0,0,0,0,2,0,2,3,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Olympian",
						Value = {						
							Drawable = {45,0,4,14,12,0,10,3,2,0,0,14},
							Texture = {0,0,0,0,8,0,3,4,0,0,0,10},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Energize",
						Value = {						
							Drawable = {45,0,4,7,14,0,11,0,2,0,0,10},
							Texture = {0,0,0,0,9,0,0,0,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Ball Girl",
						Value = {						
							Drawable = {45,0,4,14,14,0,3,3,2,0,0,14},
							Texture = {0,0,0,0,8,0,1,5,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Stretch",
						Value = {						
							Drawable = {45,0,4,15,10,0,1,0,5,0,0,10},
							Texture = {0,0,0,0,2,0,13,0,0,0,0,10},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Winner",
						Value = {						
							Drawable = {45,0,4,14,12,0,4,0,0,0,0,14},
							Texture = {0,0,0,0,0,0,2,0,240,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Pump",
						Value = {						
							Drawable = {45,0,4,7,2,0,11,0,16,0,0,10},
							Texture = {0,0,0,0,2,0,1,0,1,0,0,7},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[7] = {
					[1] = {
						Name = "The Creative",
						Value = {						
							Drawable = {0,0,0,5,24,0,20,6,23,0,0,24},
							Texture = {0,0,0,0,0,0,9,1,0,0,0,10},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Spooky",
						Value = {						
							Drawable = {0,0,0,12,27,0,8,0,0,0,0,13},
							Texture = {0,0,0,0,5,0,3,0,240,0,0,8},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The 90s",
						Value = {						
							Drawable = {0,0,0,5,27,0,22,14,28,0,0,35},
							Texture = {0,0,0,0,13,0,3,2,8,0,0,1},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Roar",
						Value = {						
							Drawable = {0,0,0,4,27,0,22,11,0,0,0,33},
							Texture = {0,0,0,0,8,0,7,0,240,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Art Attack",
						Value = {						
							Drawable = {0,0,0,4,0,0,19,0,16,0,0,10},
							Texture = {0,0,0,0,14,0,3,0,1,0,0,15},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Fresco",
						Value = {						
							Drawable = {0,0,0,4,24,0,20,7,0,0,0,24},
							Texture = {0,0,0,0,5,0,7,0,15,0,0,8},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Pretty Kitty",
						Value = {						
							Drawable = {0,0,0,12,27,0,20,10,0,0,0,26},
							Texture = {0,0,0,0,9,0,8,1,240,0,0,11},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Amazon",
						Value = {						
							Drawable = {0,0,0,15,24,0,8,11,0,0,0,33},
							Texture = {0,0,0,0,9,0,8,0,240,0,0,8},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
				[8] = {
					[1] = {
						Name = "The Daily",
						Value = {						
							Drawable = {45,0,10,0,4,0,13,0,0,0,0,9},
							Texture = {0,0,0,0,9,0,12,0,240,0,0,9},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[2] = {
						Name = "The Comfort",
						Value = {						
							Drawable = {45,0,10,2,2,0,2,5,0,0,0,2},
							Texture = {0,0,0,0,2,0,14,4,240,0,0,6},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Laid Back",
						Value = {						
							Drawable = {45,0,10,2,3,0,16,5,0,0,0,3},
							Texture = {0,0,0,0,7,0,1,4,240,0,0,10},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Indie Heart",
						Value = {						
							Drawable = {45,0,10,5,8,0,15,0,0,0,0,31},
							Texture = {0,0,0,0,8,0,1,0,4,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Homebody",
						Value = {						
							Drawable = {45,0,10,11,3,0,16,0,0,0,0,2},
							Texture = {0,0,0,0,7,0,11,0,240,0,0,15},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[6] = {
						Name = "The Easy",
						Value = {						
							Drawable = {45,0,10,3,2,0,16,0,0,0,0,3},
							Texture = {0,0,0,0,0,0,6,0,240,0,0,11},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Casual",
						Value = {						
							Drawable = {0,0,0,0,16,0,2,0,0,0,0,0},
							Texture = {0,0,0,0,4,0,5,0,240,0,0,11},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[8] = {
						Name = "The Cougar",
						Value = {						
							Drawable = {0,0,0,2,0,0,42,6,0,0,0,30},
							Texture = {0,0,0,0,8,0,0,2,240,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
				},
			},
		},
		Hat = {
			Male = {
				{
					Name = "Off", 
					Value = {
						Drawable = -1,
						Texture = -1,
					}
				},
				{
					Name = "Black Winter Hat", 
					Value = {
						Drawable = 2,
						Texture = 0,
					}
				},
				{
					Name = "Rasta Winter Hat", 
					Value = {
						Drawable = 2,
						Texture = 3,
					}
				},
				{
					Name = "Maroon Winter Hat", 
					Value = {
						Drawable = 2,
						Texture = 7,
					}
				},
				{
					Name = "Black LS Fitted Cap", 
					Value = {
						Drawable = 4,
						Texture = 0,
					}
				},
				{
					Name = "Gray LS Fitted Cap", 
					Value = {
						Drawable = 4,
						Texture = 1,
					}
				},
				{
					Name = "Black Saggy Beanie", 
					Value = {
						Drawable = 5,
						Texture = 0,
					}
				},
				{
					Name = "Blue Saggy Beanie", 
					Value = {
						Drawable = 28,
						Texture = 0,
					}
				},
				{
					Name = "Red Saggy Beanie", 
					Value = {
						Drawable = 28,
						Texture = 2,
					}
				},
				{
					Name = "Green Army Cap", 
					Value = {
						Drawable = 6,
						Texture = 0,
					}
				},
				{
					Name = "Woodland Army Cap", 
					Value = {
						Drawable = 6,
						Texture = 5,
					}
				},
				{
					Name = "Ranch Brown Army Cap", 
					Value = {
						Drawable = 6,
						Texture = 7,
					}
				},
				{
					Name = "White Flat Cap", 
					Value = {
						Drawable = 7,
						Texture = 0,
					}
				},
				{
					Name = "Black Flat Cap", 
					Value = {
						Drawable = 7,
						Texture = 2,
					}
				},
				{
					Name = "Brown Flat Cap", 
					Value = {
						Drawable = 7,
						Texture = 5,
					}
				},
				{
					Name = "Fruntalot Green Cap", 
					Value = {
						Drawable = 9,
						Texture = 5,
					}
				},
				{
					Name = "Stank Purple Cap", 
					Value = {
						Drawable = 9,
						Texture = 7,
					}
				},
				{
					Name = "Fruntalot Green Cap", 
					Value = {
						Drawable = 10,
						Texture = 5,
					}
				},
				{
					Name = "Stank Purple Cap", 
					Value = {
						Drawable = 10,
						Texture = 7,
					}
				},
				{
					Name = "Black Fedora", 
					Value = {
						Drawable = 12,
						Texture = 0,
					}
				},
				{
					Name = "White Fedora", 
					Value = {
						Drawable = 12,
						Texture = 1,
					}
				},
				{
					Name = "Red Fedora", 
					Value = {
						Drawable = 30,
						Texture = 0,
					}
				},
				{
					Name = "Black Cowboy Hat", 
					Value = {
						Drawable = 13,
						Texture = 0,
					}
				},
				{
					Name = "Brown Cowboy Hat", 
					Value = {
						Drawable = 13,
						Texture = 1,
					}
				},
				{
					Name = "Chocolate Cowboy Hat", 
					Value = {
						Drawable = 13,
						Texture = 2,
					}
				},
				{
					Name = "White Paisley Bandana", 
					Value = {
						Drawable = 14,
						Texture = 0,
					}
				},
				{
					Name = "Black Paisley Bandana", 
					Value = {
						Drawable = 14,
						Texture = 1,
					}
				},
				{
					Name = "Camo Bandana", 
					Value = {
						Drawable = 14,
						Texture = 6,
					}
				},
				{
					Name = "Beat Off White Headphones", 
					Value = {
						Drawable = 15,
						Texture = 0,
					}
				},
				{
					Name = "Beat Off Black Headphones", 
					Value = {
						Drawable = 15,
						Texture = 1,
					}
				},
				{
					Name = "Beat Off Red Headphones", 
					Value = {
						Drawable = 15,
						Texture = 2,
					}
				},
				{
					Name = "Red Canvas Hat", 
					Value = {
						Drawable = 20,
						Texture = 3,
					}
				},
				{
					Name = "Floral Canvas Hat", 
					Value = {
						Drawable = 20,
						Texture = 4,
					}
				},
				{
					Name = "Woodland Canvas Hat", 
					Value = {
						Drawable = 20,
						Texture = 5,
					}
				},
				{
					Name = "Tan Pork Pie", 
					Value = {
						Drawable = 21,
						Texture = 0,
					}
				},
				{
					Name = "Ushero Purple Pork Pie", 
					Value = {
						Drawable = 21,
						Texture = 4,
					}
				},
				{
					Name = "Black Pork Pie", 
					Value = {
						Drawable = 21,
						Texture = 5,
					}
				},
				{
					Name = "Black Bowler Hat", 
					Value = {
						Drawable = 26,
						Texture = 0,
					}
				},
				{
					Name = "Vintage Bowler Hat", 
					Value = {
						Drawable = 26,
						Texture = 8,
					}
				},
				{
					Name = "Ash Bowler Hat", 
					Value = {
						Drawable = 26,
						Texture = 9,
					}
				},
				{
					Name = "Black Top Hat", 
					Value = {
						Drawable = 27,
						Texture = 0,
					}
				},
				{
					Name = "Vintage Top Hat", 
					Value = {
						Drawable = 27,
						Texture = 8,
					}
				},
				{
					Name = "Ash Top Hat", 
					Value = {
						Drawable = 27,
						Texture = 9,
					}
				},
				{
					Name = "Cream Trilby", 
					Value = {
						Drawable = 29,
						Texture = 3,
					}
				},
				{
					Name = "Black & Red Trilby", 
					Value = {
						Drawable = 29,
						Texture = 5,
					}
				},
				{
					Name = "Blue Trilby", 
					Value = {
						Drawable = 29,
						Texture = 7,
					}
				},				
			},
			Female = {
				{
					Name = "Off", 
					Value = {
						Drawable = -1,
						Texture = -1,
					}
				},
				{
					Name = "Black LS Fitted Cap", 
					Value = {
						Drawable = 4,
						Texture = 0,
					}
				},
				{
					Name = "Broker Fitted Cap", 
					Value = {
						Drawable = 4,
						Texture = 2,
					}
				},
				{
					Name = "Stank Fitted Cap", 
					Value = {
						Drawable = 4,
						Texture = 5,
					}
				},
				{
					Name = "Rearwall Black Beanie", 
					Value = {
						Drawable = 5,
						Texture = 0,
					}
				},
				{
					Name = "Crevis Ash Beanie", 
					Value = {
						Drawable = 5,
						Texture = 1,
					}
				},
				{
					Name = "Hawaiian Snow Plaid Beanie", 
					Value = {
						Drawable = 5,
						Texture = 7,
					}
				},
				{
					Name = "Black Military Cap", 
					Value = {
						Drawable = 6,
						Texture = 0,
					}
				},
				{
					Name = "Tan Military Cap", 
					Value = {
						Drawable = 6,
						Texture = 3,
					}
				},
				{
					Name = "Woodland Camo Military Cap", 
					Value = {
						Drawable = 6,
						Texture = 7,
					}
				},
				{
					Name = "Navy Flat Cap", 
					Value = {
						Drawable = 7,
						Texture = 0,
					}
				},
				{
					Name = "Gray Plaid Flat Cap", 
					Value = {
						Drawable = 7,
						Texture = 2,
					}
				},
				{
					Name = "Brown Plaid Flat Cap", 
					Value = {
						Drawable = 7,
						Texture = 3,
					}
				},
				{
					Name = "Fruit Cap", 
					Value = {
						Drawable = 9,
						Texture = 0,
					}
				},
				{
					Name = "US Post LS Cap", 
					Value = {
						Drawable = 9,
						Texture = 3,
					}
				},
				{
					Name = "Peachy Chics Leopard Cap", 
					Value = {
						Drawable = 9,
						Texture = 7,
					}
				},
				{
					Name = "Black Sun Hat", 
					Value = {
						Drawable = 11,
						Texture = 1,
					}
				},
				{
					Name = "Black Bowler Hat", 
					Value = {
						Drawable = 26,
						Texture = 0,
					}
				},
				{
					Name = "Vintage Bowler Hat", 
					Value = {
						Drawable = 26,
						Texture = 8,
					}
				},
				{
					Name = "Black Saggy Beanie", 
					Value = {
						Drawable = 12,
						Texture = 0,
					}
				},
				{
					Name = "Yeti Saggy Beanie", 
					Value = {
						Drawable = 12,
						Texture = 7,
					}
				},	
				{
					Name = "Fuchsia Saggy Beanie", 
					Value = {
						Drawable = 29,
						Texture = 2,
					}
				},
				{
					Name = "Tan Straw Hat", 
					Value = {
						Drawable = 13,
						Texture = 0,
					}
				},
				{
					Name = "Safari Straw Hat", 
					Value = {
						Drawable = 13,
						Texture = 3,
					}
				},
				{
					Name = "Navy Straw Hat", 
					Value = {
						Drawable = 13,
						Texture = 7,
					}
				},
				{
					Name = "Black Beret", 
					Value = {
						Drawable = 14,
						Texture = 0,
					}
				},
				{
					Name = "Cherry Beret", 
					Value = {
						Drawable = 14,
						Texture = 1,
					}
				},
				{
					Name = "Grey Beret", 
					Value = {
						Drawable = 14,
						Texture = 4,
					}
				},
				{
					Name = "Beat Off White Headphones", 
					Value = {
						Drawable = 15,
						Texture = 0,
					}
				},
				{
					Name = "Beat Off Black Headphones", 
					Value = {
						Drawable = 15,
						Texture = 1,
					}
				},
				{
					Name = "Beat Off Red Headphones", 
					Value = {
						Drawable = 15,
						Texture = 2,
					}
				},	
				{
					Name = "Tan Cowgirl Hat", 
					Value = {
						Drawable = 20,
						Texture = 0,
					}
				},
				{
					Name = "Farshtunken Black Cowgirl Hat", 
					Value = {
						Drawable = 20,
						Texture = 2,
					}
				},
				{
					Name = "MyMy Pink Cowgirl Hat", 
					Value = {
						Drawable = 20,
						Texture = 3,
					}
				},
				{
					Name = "CaCa Pink Canvas Hat", 
					Value = {
						Drawable = 21,
						Texture = 0,
					}
				},
				{
					Name = "Crevis Blue Canvas Hat", 
					Value = {
						Drawable = 21,
						Texture = 1,
					}
				},
				{
					Name = "Red Canvas Hat", 
					Value = {
						Drawable = 21,
						Texture = 3,
					}
				},
				{
					Name = "Cream Sun Hat", 
					Value = {
						Drawable = 22,
						Texture = 1,
					}
				},
				{
					Name = "MyMy Wild Sun Hat", 
					Value = {
						Drawable = 22,
						Texture = 6,
					}
				},
				{
					Name = "Ash Bowler Hat", 
					Value = {
						Drawable = 26,
						Texture = 10,
					}
				},
				{
					Name = "Black Top Hat", 
					Value = {
						Drawable = 27,
						Texture = 0,
					}
				},
				{
					Name = "Vintage Top Hat", 
					Value = {
						Drawable = 27,
						Texture = 8,
					}
				},
				{
					Name = "Ash Top Hat", 
					Value = {
						Drawable = 27,
						Texture = 10,
					}
				},
				{
					Name = "Cream Fedora", 
					Value = {
						Drawable = 28,
						Texture = 1,
					}
				},
				{
					Name = "Black Fedora", 
					Value = {
						Drawable = 28,
						Texture = 3,
					}
				},
				{
					Name = "Brown Plaid Fedora", 
					Value = {
						Drawable = 28,
						Texture = 6,
					}
				},
			},
		},
		Glasses = {
			Male = {
				{
					Name = "Off", 
					Value = {
						Drawable = -1,
						Texture = -1,
					}
				},
				{
					Name = "Black Wraparounds", 
					Value = {
						Drawable = 16,
						Texture = 6,
					}
				},
				{
					Name = "Broker Purple Wraparounds", 
					Value = {
						Drawable = 16,
						Texture = 1,
					}
				},
				{
					Name = "Broker Lime Wraparounds", 
					Value = {
						Drawable = 16,
						Texture = 5,
					}
				},
				{
					Name = "Black Winter Shades", 
					Value = {
						Drawable = 2,
						Texture = 0,
					}
				},
				{
					Name = "White Silver Shades", 
					Value = {
						Drawable = 2,
						Texture = 6,
					}
				},
				{
					Name = "Green Polarized Shades", 
					Value = {
						Drawable = 2,
						Texture = 7,
					}
				},
				{
					Name = "State Janitor Frames", 
					Value = {
						Drawable = 3,
						Texture = 0,
					}
				},
				{
					Name = "Ash Janitor Frames", 
					Value = {
						Drawable = 3,
						Texture = 3,
					}
				},
				{
					Name = "Tan Janitor Frames", 
					Value = {
						Drawable = 3,
						Texture = 4,
					}
				},
				{
					Name = "Enema Gray Glasses", 
					Value = {
						Drawable = 4,
						Texture = 1,
					}
				},
				{
					Name = "Enema Black Glasses", 
					Value = {
						Drawable = 4,
						Texture = 2,
					}
				},
				{
					Name = "Enema Tortoiseshell Glasses", 
					Value = {
						Drawable = 4,
						Texture = 3,
					}
				},
				{
					Name = "Gold Aviators", 
					Value = {
						Drawable = 5,
						Texture = 0,
					}
				},
				{
					Name = "Steel Aviators", 
					Value = {
						Drawable = 5,
						Texture = 1,
					}
				},
				{
					Name = "Steel Aviators, Blue Tint", 
					Value = {
						Drawable = 5,
						Texture = 6,
					}
				},
				{
					Name = "Black Casuals", 
					Value = {
						Drawable = 7,
						Texture = 0,
					}
				},
				{
					Name = "Tortoiseshell Casuals", 
					Value = {
						Drawable = 7,
						Texture = 2,
					}
				},
				{
					Name = "Blood Casuals", 
					Value = {
						Drawable = 7,
						Texture = 7,
					}
				},
				{
					Name = "Brown Eyewear", 
					Value = {
						Drawable = 8,
						Texture = 0,
					}
				},
				{
					Name = "Coffee Cop Frames", 
					Value = {
						Drawable = 8,
						Texture = 2,
					}
				},
				{
					Name = "Charcoal Cop Frames", 
					Value = {
						Drawable = 8,
						Texture = 1,
					}
				},
				{
					Name = "Hawaiian Snow Black", 
					Value = {
						Drawable = 9,
						Texture = 0,
					}
				},
				{
					Name = "Hawaiian Snow White", 
					Value = {
						Drawable = 9,
						Texture = 2,
					}
				},
				{
					Name = "Hawaiian Snow Tortoiseshell", 
					Value = {
						Drawable = 9,
						Texture = 6,
					}
				},
				{
					Name = "Gold Bull Emic", 
					Value = {
						Drawable = 10,
						Texture = 0,
					}
				},
				{
					Name = "Gray Bull Emic", 
					Value = {
						Drawable = 10,
						Texture = 1,
					}
				},
				{
					Name = "White Bull Emic", 
					Value = {
						Drawable = 10,
						Texture = 2,
					}
				},
				{
					Name = "Gray Elvis", 
					Value = {
						Drawable = 12,
						Texture = 1,
					}
				},
				{
					Name = "Slate Elvis", 
					Value = {
						Drawable = 12,
						Texture = 2,
					}
				},
				{
					Name = "Copper Elvis", 
					Value = {
						Drawable = 12,
						Texture = 7,
					}
				},
				{
					Name = "Broker Black Hipsters", 
					Value = {
						Drawable = 13,
						Texture = 0,
					}
				},
				{
					Name = "Choco Polarized Hipsters", 
					Value = {
						Drawable = 13,
						Texture = 2,
					}
				},
				{
					Name = "Gold Polarized Hipsters", 
					Value = {
						Drawable = 13,
						Texture = 6,
					}
				},
				{
					Name = "Yellow Guns", 
					Value = {
						Drawable = 15,
						Texture = 0,
					}
				},
				{
					Name = "White Guns", 
					Value = {
						Drawable = 15,
						Texture = 1,
					}
				},
				{
					Name = "Pink Guns", 
					Value = {
						Drawable = 15,
						Texture = 7,
					}
				},
				{
					Name = "Silver Refined", 
					Value = {
						Drawable = 17,
						Texture = 0,
					}
				},
				{
					Name = "Brown Refined", 
					Value = {
						Drawable = 17,
						Texture = 2,
					}
				},
				{
					Name = "Black Refined", 
					Value = {
						Drawable = 17,
						Texture = 7,
					}
				},
				{
					Name = "Gold Superior", 
					Value = {
						Drawable = 18,
						Texture = 0,
					}
				},
				{
					Name = "Steel Superior", 
					Value = {
						Drawable = 18,
						Texture = 1,
					}
				},
				{
					Name = "Black Superior", 
					Value = {
						Drawable = 18,
						Texture = 2,
					}
				},
				{
					Name = "Black & Gold Trends", 
					Value = {
						Drawable = 19,
						Texture = 0,
					}
				},
				{
					Name = "Silver Dipped Trends", 
					Value = {
						Drawable = 19,
						Texture = 2,
					}
				},
				{
					Name = "White & Gold Trends", 
					Value = {
						Drawable = 19,
						Texture = 7,
					}
				},
				{
					Name = "Sunset Docks", 
					Value = {
						Drawable = 20,
						Texture = 0,
					}
				},
				{
					Name = "Crimson Docks", 
					Value = {
						Drawable = 20,
						Texture = 6,
					}
				},
				{
					Name = "Yellow Docks", 
					Value = {
						Drawable = 20,
						Texture = 7,
					}
				},
			},
			Female = {
				{
					Name = "Off", 
					Value = {
						Drawable = -1,
						Texture = -1,
					}
				},
				{
					Name = "Two-Tone Sports Shades", 
					Value = {
						Drawable = 0,
						Texture = 1,
					}
				},
				{
					Name = "Blue Sports Shades", 
					Value = {
						Drawable = 0,
						Texture = 3,
					}
				},
				{
					Name = "Beige Sports Shades", 
					Value = {
						Drawable = 0,
						Texture = 7,
					}
				},
				{
					Name = "Copper Marbles", 
					Value = {
						Drawable = 1,
						Texture = 0,
					}
				},
				{
					Name = "Black Marbles", 
					Value = {
						Drawable = 1,
						Texture = 2,
					}
				},
				{
					Name = "Teal Marbles", 
					Value = {
						Drawable = 1,
						Texture = 4,
					}
				},
				{
					Name = "Marble Mademoiselles", 
					Value = {
						Drawable = 2,
						Texture = 0,
					}
				},
				{
					Name = "Orange Tint Mademoiselles", 
					Value = {
						Drawable = 2,
						Texture = 2,
					}
				},
				{
					Name = "Black Mademoiselles", 
					Value = {
						Drawable = 2,
						Texture = 5,
					}
				},
				{
					Name = "Zebra Shields", 
					Value = {
						Drawable = 3,
						Texture = 0,
					}
				},
				{
					Name = "Flame Shields", 
					Value = {
						Drawable = 3,
						Texture = 2,
					}
				},
				{
					Name = "Sun Shields", 
					Value = {
						Drawable = 3,
						Texture = 4,
					}
				},
				{
					Name = "Marble Retro", 
					Value = {
						Drawable = 4,
						Texture = 1,
					}
				},
				{
					Name = "Black Retro", 
					Value = {
						Drawable = 4,
						Texture = 5,
					}
				},
				{
					Name = "Red Retro", 
					Value = {
						Drawable = 4,
						Texture = 7,
					}
				},
				{
					Name = "Purple Tint Bugs", 
					Value = {
						Drawable = 6,
						Texture = 0,
					}
				},
				{
					Name = "DS Brown Bugs", 
					Value = {
						Drawable = 16,
						Texture = 0,
					}
				},
				{
					Name = "DS Pink Bugs", 
					Value = {
						Drawable = 16,
						Texture = 5,
					}
				},
				{
					Name = "Champagne Figure 8s", 
					Value = {
						Drawable = 7,
						Texture = 0,
					}
				},
				{
					Name = "Amethyst Figure 8s", 
					Value = {
						Drawable = 7,
						Texture = 3,
					}
				},
				{
					Name = "White Figure 8s", 
					Value = {
						Drawable = 7,
						Texture = 5,
					}
				},
				{
					Name = "Orange Tint Squared", 
					Value = {
						Drawable = 8,
						Texture = 0,
					}
				},
				{
					Name = "Tan Squared", 
					Value = {
						Drawable = 17,
						Texture = 4,
					}
				},
				{
					Name = "White Squared", 
					Value = {
						Drawable = 17,
						Texture = 6,
					}
				},
				{
					Name = "Line Tint Shooters", 
					Value = {
						Drawable = 9,
						Texture = 0,
					}
				},
				{
					Name = "Blue Shooters", 
					Value = {
						Drawable = 9,
						Texture = 2,
					}
				},
				{
					Name = "Tropic Shooters", 
					Value = {
						Drawable = 9,
						Texture = 3,
					}
				},
				{
					Name = "Black Sports", 
					Value = {
						Drawable = 10,
						Texture = 1,
					}
				},
				{
					Name = "Blue Pattern Sports", 
					Value = {
						Drawable = 10,
						Texture = 6,
					}
				},
				{
					Name = "Pink Pattern Sports", 
					Value = {
						Drawable = 10,
						Texture = 7,
					}
				},
				{
					Name = "Pewter Aviators", 
					Value = {
						Drawable = 11,
						Texture = 0,
					}
				},
				{
					Name = "Steel Aviators", 
					Value = {
						Drawable = 11,
						Texture = 1,
					}
				},
				{
					Name = "Bronze Aviators", 
					Value = {
						Drawable = 11,
						Texture = 2,
					}
				},
				{
					Name = "Black Cat Eyes", 
					Value = {
						Drawable = 14,
						Texture = 0,
					}
				},
				{
					Name = "Brown Marble Cat Eyes", 
					Value = {
						Drawable = 14,
						Texture = 1,
					}
				},
				{
					Name = "Red Cat Eyes", 
					Value = {
						Drawable = 14,
						Texture = 4,
					}
				},
				{
					Name = "Steel Slim Glasses", 
					Value = {
						Drawable = 18,
						Texture = 0,
					}
				},
				{
					Name = "Gold Slim Glasses", 
					Value = {
						Drawable = 18,
						Texture = 2,
					}
				},
				{
					Name = "Black Slim Glasses", 
					Value = {
						Drawable = 18,
						Texture = 3,
					}
				},
				{
					Name = "Black Plastic Frames", 
					Value = {
						Drawable = 19,
						Texture = 0,
					}
				},
				{
					Name = "Marbled Plastic Frames", 
					Value = {
						Drawable = 19,
						Texture = 3,
					}
				},
				{
					Name = "Vixen Plastic Frames", 
					Value = {
						Drawable = 19,
						Texture = 5,
					}
				},
				{
					Name = "Black Retro Classics", 
					Value = {
						Drawable = 20,
						Texture = 0,
					}
				},
				{
					Name = "Red Marble Retro Classics", 
					Value = {
						Drawable = 20,
						Texture = 2,
					}
				},
				{
					Name = "Baby Blue Retro Classics", 
					Value = {
						Drawable = 20,
						Texture = 5,
					}
				},
				{
					Name = "Black Hipsters", 
					Value = {
						Drawable = 21,
						Texture = 0,
					}
				},
				{
					Name = "Dipped Hipsters", 
					Value = {
						Drawable = 21,
						Texture = 3,
					}
				},
				{
					Name = "Brown Hipsters", 
					Value = {
						Drawable = 21,
						Texture = 7,
					}
				},
			},
		},
	},
	Tattoos = {},
	Models = {
		"a_f_m_beach_01",
		"a_f_m_bevhills_01",
		"a_f_m_bevhills_02",
		"a_f_m_bodybuild_01",
		"a_f_m_business_02",
		"a_f_m_downtown_01",
		"a_f_m_eastsa_01",
		"a_f_m_eastsa_02",
		"a_f_m_fatbla_01",
		"a_f_m_fatcult_01",
		"a_f_m_fatwhite_01",
		"a_f_m_ktown_01",
		"a_f_m_ktown_02",
		"a_f_m_prolhost_01",
		"a_f_m_salton_01",
		"a_f_m_skidrow_01",
		"a_f_m_soucentmc_01",
		"a_f_m_soucent_01",
		"a_f_m_soucent_02",
		"a_f_m_tourist_01",
		"a_f_m_trampbeac_01",
		"a_f_m_tramp_01",
		"a_f_o_genstreet_01",
		"a_f_o_indian_01",
		"a_f_o_ktown_01",
		"a_f_o_salton_01",
		"a_f_o_soucent_01",
		"a_f_o_soucent_02",
		"a_f_y_beach_01",
		"a_f_y_bevhills_01",
		"a_f_y_bevhills_02",
		"a_f_y_bevhills_03",
		"a_f_y_bevhills_04",
		"a_f_y_business_01",
		"a_f_y_business_02",
		"a_f_y_business_03",
		"a_f_y_business_04",
		"a_f_y_eastsa_01",
		"a_f_y_eastsa_02",
		"a_f_y_eastsa_03",
		"a_f_y_epsilon_01",
		"a_f_y_fitness_01",
		"a_f_y_fitness_02",
		"a_f_y_genhot_01",
		"a_f_y_golfer_01",
		"a_f_y_hiker_01",
		"a_f_y_hippie_01",
		"a_f_y_hipster_01",
		"a_f_y_hipster_02",
		"a_f_y_hipster_03",
		"a_f_y_hipster_04",
		"a_f_y_indian_01",
		"a_f_y_juggalo_01",
		"a_f_y_runner_01",
		"a_f_y_rurmeth_01",
		"a_f_y_scdressy_01",
		"a_f_y_skater_01",
		"a_f_y_soucent_01",
		"a_f_y_soucent_02",
		"a_f_y_soucent_03",
		"a_f_y_tennis_01",
		"a_f_y_topless_01",
		"a_f_y_tourist_01",
		"a_f_y_tourist_02",
		"a_f_y_vinewood_01",
		"a_f_y_vinewood_02",
		"a_f_y_vinewood_03",
		"a_f_y_vinewood_04",
		"a_f_y_yoga_01",
		"a_m_m_acult_01",
		"a_m_m_afriamer_01",
		"a_m_m_beach_01",
		"a_m_m_beach_02",
		"a_m_m_bevhills_01",
		"a_m_m_bevhills_02",
		"a_m_m_business_01",
		"a_m_m_eastsa_01",
		"a_m_m_eastsa_02",
		"a_m_m_farmer_01",
		"a_m_m_fatlatin_01",
		"a_m_m_genfat_01",
		"a_m_m_genfat_02",
		"a_m_m_golfer_01",
		"a_m_m_hasjew_01",
		"a_m_m_hillbilly_01",
		"a_m_m_hillbilly_02",
		"a_m_m_indian_01",
		"a_m_m_ktown_01",
		"a_m_m_malibu_01",
		"a_m_m_mexcntry_01",
		"a_m_m_mexlabor_01",
		"a_m_m_og_boss_01",
		"a_m_m_paparazzi_01",
		"a_m_m_polynesian_01",
		"a_m_m_prolhost_01",
		"a_m_m_rurmeth_01",
		"a_m_m_salton_01",
		"a_m_m_salton_02",
		"a_m_m_salton_03",
		"a_m_m_salton_04",
		"a_m_m_skater_01",
		"a_m_m_skidrow_01",
		"a_m_m_socenlat_01",
		"a_m_m_soucent_01",
		"a_m_m_soucent_02",
		"a_m_m_soucent_03",
		"a_m_m_soucent_04",
		"a_m_m_stlat_02",
		"a_m_m_tennis_01",
		"a_m_m_tourist_01",
		"a_m_m_trampbeac_01",
		"a_m_m_tramp_01",
		"a_m_m_tranvest_01",
		"a_m_m_tranvest_02",
		"a_m_o_acult_01",
		"a_m_o_acult_02",
		"a_m_o_beach_01",
		"a_m_o_genstreet_01",
		"a_m_o_ktown_01",
		"a_m_o_salton_01",
		"a_m_o_soucent_01",
		"a_m_o_soucent_02",
		"a_m_o_soucent_03",
		"a_m_o_tramp_01",
		"a_m_y_acult_01",
		"a_m_y_acult_02",
		"a_m_y_beachvesp_01",
		"a_m_y_beachvesp_02",
		"a_m_y_beach_01",
		"a_m_y_beach_02",
		"a_m_y_beach_03",
		"a_m_y_bevhills_01",
		"a_m_y_bevhills_02",
		"a_m_y_breakdance_01",
		"a_m_y_busicas_01",
		"a_m_y_business_01",
		"a_m_y_business_02",
		"a_m_y_business_03",
		"a_m_y_cyclist_01",
		"a_m_y_dhill_01",
		"a_m_y_downtown_01",
		"a_m_y_eastsa_01",
		"a_m_y_eastsa_02",
		"a_m_y_epsilon_01",
		"a_m_y_epsilon_02",
		"a_m_y_gay_01",
		"a_m_y_gay_02",
		"a_m_y_genstreet_01",
		"a_m_y_genstreet_02",
		"a_m_y_golfer_01",
		"a_m_y_hasjew_01",
		"a_m_y_hiker_01",
		"a_m_y_hippy_01",
		"a_m_y_hipster_01",
		"a_m_y_hipster_02",
		"a_m_y_hipster_03",
		"a_m_y_indian_01",
		"a_m_y_jetski_01",
		"a_m_y_juggalo_01",
		"a_m_y_ktown_01",
		"a_m_y_ktown_02",
		"a_m_y_latino_01",
		"a_m_y_methhead_01",
		"a_m_y_mexthug_01",
		"a_m_y_motox_01",
		"a_m_y_motox_02",
		"a_m_y_musclbeac_01",
		"a_m_y_musclbeac_02",
		"a_m_y_polynesian_01",
		"a_m_y_roadcyc_01",
		"a_m_y_runner_01",
		"a_m_y_runner_02",
		"a_m_y_salton_01",
		"a_m_y_skater_01",
		"a_m_y_skater_02",
		"a_m_y_soucent_01",
		"a_m_y_soucent_02",
		"a_m_y_soucent_03",
		"a_m_y_soucent_04",
		"a_m_y_stbla_01",
		"a_m_y_stbla_02",
		"a_m_y_stlat_01",
		"a_m_y_stwhi_01",
		"a_m_y_stwhi_02",
		"a_m_y_sunbathe_01",
		"a_m_y_surfer_01",
		"a_m_y_vindouche_01",
		"a_m_y_vinewood_01",
		"a_m_y_vinewood_02",
		"a_m_y_vinewood_03",
		"a_m_y_vinewood_04",
		"a_m_y_yoga_01",
		"csb_abigail",
		"csb_anita",
		"csb_anton",
		"csb_ballasog",
		"csb_bride",
		"csb_burgerdrug",
		"csb_car3guy1",
		"csb_car3guy2",
		"csb_chef",
		"csb_chin_goon",
		"csb_cletus",
		"csb_cop",
		"csb_customer",
		"csb_denise_friend",
		"csb_fos_rep",
		"csb_groom",
		"csb_grove_str_dlr",
		"csb_g",
		"csb_hao",
		"csb_hugh",
		"csb_imran",
		"csb_janitor",
		"csb_maude",
		"csb_mweather",
		"csb_ortega",
		"csb_oscar",
		"csb_porndudes",
		"csb_prologuedriver",
		"csb_prolsec",
		"csb_ramp_gang",
		"csb_ramp_hic",
		"csb_ramp_hipster",
		"csb_ramp_marine",
		"csb_ramp_mex",
		"csb_reporter",
		"csb_roccopelosi",
		"csb_screen_writer",
		"csb_stripper_01",
		"csb_stripper_02",
		"csb_tonya",
		"csb_trafficwarden",
		"g_f_y_ballas_01",
		"g_f_y_families_01",
		"g_f_y_lost_01",
		"g_f_y_vagos_01",
		"g_m_m_armboss_01",
		"g_m_m_armgoon_01",
		"g_m_m_armlieut_01",
		"g_m_m_chemwork_01",
		"g_m_m_chiboss_01",
		"g_m_m_chicold_01",
		"g_m_m_chigoon_01",
		"g_m_m_chigoon_02",
		"g_m_m_korboss_01",
		"g_m_m_mexboss_01",
		"g_m_m_mexboss_02",
		"g_m_y_armgoon_02",
		"g_m_y_azteca_01",
		"g_m_y_ballaeast_01",
		"g_m_y_ballaorig_01",
		"g_m_y_ballasout_01",
		"g_m_y_famca_01",
		"g_m_y_famdnf_01",
		"g_m_y_famfor_01",
		"g_m_y_korean_01",
		"g_m_y_korean_02",
		"g_m_y_korlieut_01",
		"g_m_y_lost_01",
		"g_m_y_lost_02",
		"g_m_y_lost_03",
		"g_m_y_mexgang_01",
		"g_m_y_mexgoon_01",
		"g_m_y_mexgoon_02",
		"g_m_y_mexgoon_03",
		"g_m_y_pologoon_01",
		"g_m_y_pologoon_02",
		"g_m_y_salvaboss_01",
		"g_m_y_salvagoon_01",
		"g_m_y_salvagoon_02",
		"g_m_y_salvagoon_03",
		"g_m_y_strpunk_01",
		"g_m_y_strpunk_02",
		"hc_driver",
		"hc_gunman",
		"hc_hacker",
		"ig_abigail",
		"ig_amandatownley",
		"ig_andreas",
		"ig_ashley",
		"ig_ballasog",
		"ig_bankman",
		"ig_barry",
		"ig_bestmen",
		"ig_beverly",
		"ig_brad",
		"ig_bride",
		"ig_car3guy1",
		"ig_car3guy2",
		"ig_casey",
		"ig_chef",
		"ig_chengsr",
		"ig_chrisformage",
		"ig_claypain",
		"ig_clay",
		"ig_cletus",
		"ig_dale",
		"ig_davenorton",
		"ig_denise",
		"ig_devin",
		"ig_dom",
		"ig_dreyfuss",
		"ig_drfriedlander",
		"ig_fabien",
		"ig_fbisuit_01",
		"ig_floyd",
		"ig_groom",
		"ig_hao",
		"ig_hunter",
		"ig_janet",
		"ig_jay_norris",
		"ig_jewelass",
		"ig_jimmyboston",
		"ig_jimmydisanto",
		"ig_joeminuteman",
		"ig_johnnyklebitz",
		"ig_josef",
		"ig_josh",
		"ig_kerrymcintosh",
		"ig_lamardavis",
		"ig_lazlow",
		"ig_lestercrest",
		"ig_lifeinvad_01",
		"ig_lifeinvad_02",
		"ig_magenta",
		"ig_manuel",
		"ig_marnie",
		"ig_maryann",
		"ig_maude",
		"ig_michelle",
		"ig_milton",
		"ig_molly",
		"ig_mrk",
		"ig_mrsphillips",
		"ig_mrs_thornhill",
		"ig_natalia",
		"ig_nervousron",
		"ig_nigel",
		"ig_old_man1a",
		"ig_old_man2",
		"ig_omega",
		"ig_oneil",
		"ig_orleans",
		"ig_ortega",
		"ig_paper",
		"ig_patricia",
		"ig_priest",
		"ig_prolsec_02",
		"ig_ramp_gang",
		"ig_ramp_hic",
		"ig_ramp_hipster",
		"ig_ramp_mex",
		"ig_roccopelosi",
		"ig_russiandrunk",
		"ig_screen_writer",
		"ig_siemonyetarian",
		"ig_solomon",
		"ig_stevehains",
		"ig_stretch",
		"ig_talina",
		"ig_tanisha",
		"ig_taocheng",
		"ig_taostranslator",
		"ig_tenniscoach",
		"ig_terry",
		"ig_tomepsilon",
		"ig_tonya",
		"ig_tracydisanto",
		"ig_trafficwarden",
		"ig_tylerdix",
		"ig_wade",
		"ig_zimbor",
		"mp_f_deadhooker",
		"mp_f_misty_01",
		"mp_f_stripperlite",
		"mp_g_m_pros_01",
		"mp_m_claude_01",
		"mp_m_exarmy_01",
		"mp_m_famdd_01",
		"mp_m_fibsec_01",
		"mp_m_marston_01",
		"mp_m_niko_01",
		"mp_m_shopkeep_01",
		"mp_s_m_armoured_01",
		"player_one",
		"player_two",
		"player_zero",
		"s_f_m_fembarber",
		"s_f_m_maid_01",
		"s_f_m_shop_high",
		"s_f_m_sweatshop_01",
		"s_f_y_airhostess_01",
		"s_f_y_bartender_01",
		"s_f_y_baywatch_01",
		"s_f_y_cop_01",
		"s_f_y_factory_01",
		"s_f_y_hooker_01",
		"s_f_y_hooker_02",
		"s_f_y_hooker_03",
		"s_f_y_migrant_01",
		"s_f_y_movprem_01",
		"s_f_y_ranger_01",
		"s_f_y_scrubs_01",
		"s_f_y_sheriff_01",
		"s_f_y_shop_low",
		"s_f_y_shop_mid",
		"s_f_y_stripperlite",
		"s_f_y_stripper_01",
		"s_f_y_stripper_02",
		"s_f_y_sweatshop_01",
		"s_m_m_ammucountry",
		"s_m_m_armoured_01",
		"s_m_m_armoured_02",
		"s_m_m_autoshop_01",
		"s_m_m_autoshop_02",
		"s_m_m_bouncer_01",
		"s_m_m_chemsec_01",
		"s_m_m_ciasec_01",
		"s_m_m_cntrybar_01",
		"s_m_m_dockwork_01",
		"s_m_m_doctor_01",
		"s_m_m_fiboffice_01",
		"s_m_m_fiboffice_02",
		"s_m_m_gaffer_01",
		"s_m_m_gardener_01",
		"s_m_m_gentransport",
		"s_m_m_hairdress_01",
		"s_m_m_highsec_01",
		"s_m_m_highsec_02",
		"s_m_m_janitor",
		"s_m_m_lathandy_01",
		"s_m_m_lifeinvad_01",
		"s_m_m_linecook",
		"s_m_m_lsmetro_01",
		"s_m_m_mariachi_01",
		"s_m_m_marine_01",
		"s_m_m_marine_02",
		"s_m_m_migrant_01",
		"s_m_m_movalien_01",
		"s_m_m_movprem_01",
		"s_m_m_movspace_01",
		"s_m_m_paramedic_01",
		"s_m_m_pilot_01",
		"s_m_m_pilot_02",
		"s_m_m_postal_01",
		"s_m_m_postal_02",
		"s_m_m_prisguard_01",
		"s_m_m_scientist_01",
		"s_m_m_security_01",
		"s_m_m_snowcop_01",
		"s_m_m_strperf_01",
		"s_m_m_strpreach_01",
		"s_m_m_strvend_01",
		"s_m_m_trucker_01",
		"s_m_m_ups_01",
		"s_m_m_ups_02",
		"s_m_o_busker_01",
		"s_m_y_airworker",
		"s_m_y_ammucity_01",
		"s_m_y_armymech_01",
		"s_m_y_autopsy_01",
		"s_m_y_barman_01",
		"s_m_y_baywatch_01",
		"s_m_y_blackops_01",
		"s_m_y_blackops_02",
		"s_m_y_busboy_01",
		"s_m_y_chef_01",
		"s_m_y_clown_01",
		"s_m_y_construct_01",
		"s_m_y_construct_02",
		"s_m_y_cop_01",
		"s_m_y_dealer_01",
		"s_m_y_devinsec_01",
		"s_m_y_dockwork_01",
		"s_m_y_doorman_01",
		"s_m_y_dwservice_01",
		"s_m_y_dwservice_02",
		"s_m_y_factory_01",
		"s_m_y_fireman_01",
		"s_m_y_garbage",
		"s_m_y_grip_01",
		"s_m_y_hwaycop_01",
		"s_m_y_marine_01",
		"s_m_y_marine_02",
		"s_m_y_marine_03",
		"s_m_y_mime",
		"s_m_y_pestcont_01",
		"s_m_y_pilot_01",
		"s_m_y_prismuscl_01",
		"s_m_y_prisoner_01",
		"s_m_y_ranger_01",
		"s_m_y_robber_01",
		"s_m_y_sheriff_01",
		"s_m_y_shop_mask",
		"s_m_y_strvend_01",
		"s_m_y_swat_01",
		"s_m_y_uscg_01",
		"s_m_y_valet_01",
		"s_m_y_waiter_01",
		"s_m_y_winclean_01",
		"s_m_y_xmech_01",
		"s_m_y_xmech_02",
		"u_f_m_corpse_01",
		"u_f_m_miranda",
		"u_f_m_promourn_01",
		"u_f_o_moviestar",
		"u_f_o_prolhost_01",
		"u_f_y_bikerchic",
		"u_f_y_comjane",
		"u_f_y_corpse_01",
		"u_f_y_corpse_02",
		"u_f_y_hotposh_01",
		"u_f_y_jewelass_01",
		"u_f_y_mistress",
		"u_f_y_poppymich",
		"u_f_y_princess",
		"u_f_y_spyactress",
		"u_m_m_aldinapoli",
		"u_m_m_bankman",
		"u_m_m_bikehire_01",
		"u_m_m_fibarchitect",
		"u_m_m_filmdirector",
		"u_m_m_glenstank_01",
		"u_m_m_griff_01",
		"u_m_m_jesus_01",
		"u_m_m_jewelsec_01",
		"u_m_m_jewelthief",
		"u_m_m_markfost",
		"u_m_m_partytarget",
		"u_m_m_prolsec_01",
		"u_m_m_promourn_01",
		"u_m_m_rivalpap",
		"u_m_m_spyactor",
		"u_m_m_willyfist",
		"u_m_o_finguru_01",
		"u_m_o_taphillbilly",
		"u_m_o_tramp_01",
		"u_m_y_abner",
		"u_m_y_antonb",
		"u_m_y_babyd",
		"u_m_y_baygor",
		"u_m_y_burgerdrug_01",
		"u_m_y_chip",
		"u_m_y_cyclist_01",
		"u_m_y_fibmugger_01",
		"u_m_y_guido_01",
		"u_m_y_gunvend_01",
		"u_m_y_hippie_01",
		"u_m_y_imporage",
		"u_m_y_justin",
		"u_m_y_mani",
		"u_m_y_militarybum",
		"u_m_y_paparazzi",
		"u_m_y_party_01",
		"u_m_y_pogo_01",
		"u_m_y_prisoner_01",
		"u_m_y_proldriver_01",
		"u_m_y_rsranger_01",
		"u_m_y_sbike",
		"u_m_y_staggrm_01",
		"u_m_y_tattoo_01",
		"u_m_y_zombie_01",
	},
}

for Index = 0, GetNumHeadOverlayValues(8) - 1 do
	table.insert(PlayerCustomisation.Reference.Appearance.Lipstick, {Name = GetLabelText("CC_LIPSTICK_"..Index), Value = Index})
end

for Index = 0, GetNumHeadOverlayValues(2) - 1 do
	table.insert(PlayerCustomisation.Reference.Appearance.Eyebrows, {Name = GetLabelText("CC_EYEBRW_"..Index), Value = Index})
end

for Index = 1, GetNumHeadOverlayValues(10) do
	table.insert(PlayerCustomisation.Reference.Appearance.Chest, {Name = GetLabelText("CC_BODY_1_"..Index), Value = Index - 1})
end

for Index = 0, 31 do
	table.insert(PlayerCustomisation.Reference.Appearance.Contacts, {Name = GetLabelText("FACE_E_C_"..Index), Value = Index})
end

for Index = 0, 8 do
	table.insert(PlayerCustomisation.Reference.Appearance.Eyes, {Name = GetLabelText("FACE_E_C_"..Index), Value = Index})
end

for Index = 0, GetNumHeadOverlayValues(4) - 1 do
	if (Index >= 0 and Index <= 15) or (Index == 32) or (Index >= 34 and Index <= 41) then
		table.insert(PlayerCustomisation.Reference.Appearance.EyeMakeup, {Name = GetLabelText("CC_MKUP_"..Index), Value = Index})
	elseif (Index >= 16 and Index <= 21) or (Index >= 26 and Index <= 31) or (Index == 33) or (Index >= 42 and Index <= 71) then -- 22-25 -> Unamed face paint
		table.insert(PlayerCustomisation.Reference.Appearance.FacePaint, {Name = GetLabelText("CC_MKUP_"..Index), Value = Index})
	end 
end

for Index = 0, GetNumHeadOverlayValues(5) - 1 do
	table.insert(PlayerCustomisation.Reference.Appearance.Blush, {Name = GetLabelText("CC_BLUSH_"..Index), Value = Index})
end
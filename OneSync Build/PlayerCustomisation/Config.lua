PlayerCustomisation = {}

PlayerCustomisation.Outfits = {}

PlayerCustomisation.InstancedPlayers = {}

PlayerCustomisation.PlasticSurgeryCost = 300

if IsDuplicityVersion() then

PlayerCustomisation.PlayerData = {}

function GetDefaultPlayerData()
	return {
		Type = "Default",
		Types = {
			Default = {
				Gender = "Male",
				Model = "mp_m_freemode_01",
				Creator = false,
				Male = {
					Clothing = {
						Drawable = {0, 0, 37, 6, 12, 0, 8, 0, 5, 0, 0, 3},
						Texture = {0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0},
						Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					},
					Props = {
						Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
						Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
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
					Tattoos = {},
				},
				Female = {
					Clothing = {
						Drawable = {45, 0, 42, 4, 3, 0, 4, 0, 0, 0, 0, 32},
						Texture = {0, 0, 0, 0, 8, 0, 1, 0, 240, 0, 0, 0},
						Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					},
					Props = {
						Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
						Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
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
					Tattoos = {},
				},
				Hybrid = {
					Clothing = {
						Drawable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
						Texture = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
						Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					},
					Props = {
						Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
						Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
					},
					Overlay = {
						Drawable = {},
						Opacity = {},
						Colours = {},
					},
					FacialFeature = {},
					HeadBlend = {},
					HairColour = {},
					EyeColour = 0,
					Highlights = false,
					Tattoos = {},
				},
			},
			Police = {
				Gender = "Male",
				Model = "mp_m_freemode_01",
				Creator = false,
				Male = {
					Clothing = {
						Drawable = {0, 0, 47, 19, 31, 0, 25, 0, 122, 38, 0, 55},
						Texture = {0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0},
						Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					},
					Props = {
						Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
						Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
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
					Tattoos = {},
				},
				Female = {
					Clothing = {
						Drawable = {45, 0, 42, 31, 30, 0, 25, 0, 152, 0, 0, 48},
						Texture = {0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0},
						Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					},
					Props = {
						Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
						Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
					},
					Overlay = {
						Drawable = {255, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255},
						Opacity = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0},
						Colours = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					},
					FacialFeature = {0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5},
					HeadBlend = {21, 16, -1.0, -1.0},
					HairColour = {0, 0},
					EyeColour = 0,
					Highlights = false,
					Tattoos = {},
				},
				Hybrid = {
					Clothing = {
						Drawable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
						Texture = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
						Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					},
					Props = {
						Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
						Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
					},
					Overlay = {
						Drawable = {},
						Opacity = {},
						Colours = {},
					},
					FacialFeature = {},
					HeadBlend = {},
					HairColour = {},
					EyeColour = 0,
					Highlights = false,
					Tattoos = {},
				},
			},
			Paramedic = {
				Gender = "Male",
				Model = "mp_m_freemode_01",
				Creator = false,
				Male = {
					Clothing = {
						Drawable = {0, 0, 10, 85, 37, 45, 25, 126, 0, 0, 58, 250},
						Texture = {0, 0, 3, 0, 2, 0, 0, 0, 240, 0, 0, 0},
						Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					},
					Props = {
						Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
						Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
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
					Tattoos = {},
				},
				Female = {
					Clothing = {
						Drawable = {25, 121, 4, 109, 99, 44, 25, 96, 159, 0, 66, 258},
						Texture = {0, 0, 56, 0, 1, 0, 0, 0, 240, 0, 0, 1},
						Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					},
					Props = {
						Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
						Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
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
					Tattoos = {},
				},
				Hybrid = {
					Clothing = {
						Drawable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
						Texture = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
						Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					},
					Props = {
						Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
						Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
					},
					Overlay = {
						Drawable = {},
						Opacity = {},
						Colours = {},
					},
					FacialFeature = {},
					HeadBlend = {},
					HairColour = {},
					EyeColour = 0,
					Highlights = false,
					Tattoos = {},
				},
			},
		},
	}
end

else

PlayerCustomisation.Pool = NativeUI.CreatePool()

PlayerCustomisation.Instanced = false

PlayerCustomisation.Creator = {
	Entry = {x = 402.84613037109, y = -996.60723876953, z = -100.006462097168, h = 180.80046081543},
	Exit = {x = 0.0, y = 0.0, z = 0.0, h = 180.0},
	Board = {
		Scaleform = {
			Name = "mugshot_board_01",
			Handle = nil,
		},
		Dictionary = "mp_character_creation@customise@male_a",
		Animation = "loop",
		RenderTarget = {
			Name = "ID_Text",
			Model = "prop_police_id_text",
			Id = -1,
			Handle = nil,
		},
		Model = "prop_police_id_board",
		Handle = nil,
	},
}

PlayerCustomisation.PlayerData = {
	Type = "Default",
	Types = {
		Default = {
			Gender = "Male",
			Model = "mp_m_freemode_01",
			Creator = false,
			Male = {
				Clothing = {
					Drawable = {0, 0, 37, 6, 12, 0, 8, 0, 5, 0, 0, 3},
					Texture = {0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0},
					Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				},
				Props = {
					Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
					Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
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
				Tattoos = {},
			},
			Female = {
				Clothing = {
					Drawable = {45, 0, 42, 4, 3, 0, 4, 0, 0, 0, 0, 32},
					Texture = {0, 0, 0, 0, 8, 0, 1, 0, 240, 0, 0, 0},
					Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				},
				Props = {
					Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
					Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
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
				Tattoos = {},
			},
			Hybrid = {
				Clothing = {
					Drawable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					Texture = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				},
				Props = {
					Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
					Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
				},
				Overlay = {
					Drawable = {},
					Opacity = {},
					Colours = {},
				},
				FacialFeature = {},
				HeadBlend = {},
				HairColour = {},
				EyeColour = 0,
				Highlights = false,
				Tattoos = {},
			},
		},
		Police = {
			Gender = "Male",
			Model = "mp_m_freemode_01",
			Creator = false,
			Male = {
				Clothing = {
					Drawable = {0, 0, 47, 19, 31, 0, 25, 0, 122, 38, 0, 55},
					Texture = {0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0},
					Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				},
				Props = {
					Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
					Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
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
				Tattoos = {},
			},
			Female = {
				Clothing = {
					Drawable = {45, 0, 42, 31, 30, 0, 25, 0, 152, 0, 0, 48},
					Texture = {0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0},
					Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				},
				Props = {
					Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
					Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
				},
				Overlay = {
					Drawable = {255, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255},
					Opacity = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0},
					Colours = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				},
				FacialFeature = {0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5},
				HeadBlend = {21, 16, -1.0, -1.0},
				HairColour = {0, 0},
				EyeColour = 0,
				Highlights = false,
				Tattoos = {},
			},
			Hybrid = {
				Clothing = {
					Drawable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					Texture = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				},
				Props = {
					Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
					Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
				},
				Overlay = {
					Drawable = {},
					Opacity = {},
					Colours = {},
				},
				FacialFeature = {},
				HeadBlend = {},
				HairColour = {},
				EyeColour = 0,
				Highlights = false,
				Tattoos = {},
			},
		},
		Paramedic = {
			Gender = "Male",
			Model = "mp_m_freemode_01",
			Creator = false,
			Male = {
				Clothing = {
					Drawable = {0, 0, 10, 85, 37, 45, 25, 126, 0, 0, 58, 250},
					Texture = {0, 0, 3, 0, 2, 0, 0, 0, 240, 0, 0, 0},
					Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				},
				Props = {
					Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
					Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
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
				Tattoos = {},
			},
			Female = {
				Clothing = {
					Drawable = {25, 121, 4, 109, 99, 44, 25, 96, 159, 0, 66, 258},
					Texture = {0, 0, 56, 0, 1, 0, 0, 0, 240, 0, 0, 1},
					Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				},
				Props = {
					Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
					Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
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
				Tattoos = {},
			},
			Hybrid = {
				Clothing = {
					Drawable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					Texture = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
					Palette = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
				},
				Props = {
					Drawable = {-1, -1, -1, -1, -1, -1, -1, -1},
					Texture = {-1, -1, -1, -1, -1, -1, -1, -1},
				},
				Overlay = {
					Drawable = {},
					Opacity = {},
					Colours = {},
				},
				FacialFeature = {},
				HeadBlend = {},
				HairColour = {},
				EyeColour = 0,
				Highlights = false,
				Tattoos = {},
			},
		},
	},
}

PlayerCustomisation.Locations = {
	Clothing = {
		[1] = {
			Blip = {
				Name = "Clothing store", 
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = -1451.3239746094, y = -237.0061340332, z = 49.808544158936, h = 56.556392669678},
			Banner = "shopui_title_highendfashion",
		},
		[2] = {
			Blip = {
				Name = "Clothing store", 
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = -1193.5999755859, y = -772.41784667969, z = 17.324451446533, h = 132.22706604004},
			Banner = "shopui_title_midfashion",
		},
		[3] = {
			Blip = {
				Name = "Clothing store", 
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = -827.17553710938, y = -1077.5642089844, z = 11.339604377747, h = 302.01776123047},
			Banner = "shopui_title_lowendfashion2",
		},
		[4] = {
			Blip = {
				Name = "Clothing store", 
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = -711.35375976563, y = -155.12893676758, z = 37.415130615234, h = 117.94968414307},
			Banner = "shopui_title_highendfashion",
		},
		[5] = {
			Blip = {
				Name = "Clothing store", 
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = -161.01217651367, y = -302.53005981445, z = 39.733276367188, h = 248.8092956543},
			Banner = "shopui_title_highendfashion",
		},
		[6] = {
			Blip = {
				Name = "Clothing store", 
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = 123.67450714111, y = -220.03996276855, z = 54.55782699585, h = 341.53039550781},
			Banner = "shopui_title_midfashion",
		},
		[7] = {
			Blip = {
				Name = "Clothing store", 
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = 424.42245483398, y = -800.12078857422, z = 29.502624511719, h = 185.56736755371},
			Banner = "shopui_title_lowendfashion2",
		},
		[8] = {
			Blip = {
				Name = "Clothing store", 
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = 76.497146606445, y = -1399.1009521484, z = 29.387624740601, h = 4.151665687561},
			Banner = "shopui_title_lowendfashion",
		},
		[9] = {
			Blip = {
				Name = "Clothing store", 
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = -3172.3991699219, y = 1047.9254150391, z = 20.863208770752, h = 335.62139892578},
			Banner = "shopui_title_midfashion",
		},
		[10] = {
			Blip = {
				Name = "Clothing store",
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = -1105.2303466797, y = 2705.5537109375, z = 19.119344711304, h = 308.94387817383},
			Banner = "shopui_title_lowendfashion",
		},
		[11] = {
			Blip = {
				Name = "Clothing store", 
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = 617.75219726563, y = 2760.1447753906, z = 42.088092803955, h = 185.84266662598},
			Banner = "shopui_title_midfashion",
		},
		[12] = {
			Blip = {
				Name = "Clothing store",
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = 1190.4864501953, y = 2709.076171875, z = 38.234088897705, h = 272.40292358398},
			Banner = "shopui_title_lowendfashion",
		},
		[13] = {
			Blip = {
				Name = "Clothing store",
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = 1691.966796875, y = 4828.8134765625, z = 42.074573516846, h = 186.94140625},
			Banner = "shopui_title_lowendfashion",
		},
		[14] = {
			Blip = {
				Name = "Clothing store",
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = 8.5836572647095, y = 6517.4526367188, z = 31.889331817627, h = 129.09069824219},
			Banner = "shopui_title_lowendfashion",
		},
		[15] = { -- Mission Row
			Blip = {
				Name = "Clothing store",
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = 454.44635009766, y = -988.86938476563, z = 30.689607620239, h = 172.5439453125},
			Banner = "shopui_title_midfashion",
		},
		[16] = { -- Pillbox Hospital
			Blip = {
				Name = "Clothing store",
				Sprite = 73, 
				Colour = 0,
			},
			Marker = {x = 336.98593139648, y = -581.65216064453, z = 28.791465759277, h = 68.848915100098},
			Banner = "shopui_title_midfashion",
		},
		[17] = { -- Sandy Shores
			Blip = {
				Name = "Clothing store",
				Sprite = 73,
				Colour = 0,
			},
			Marker = {x = 1859.2769775391, y = 3695.3620605469, z = 34.235237121582, h = 161.56106567383},
			Banner = "shopui_title_midfashion",
		},
	},
	Barbers = {
		[1] = {
			Blip = {
				Name = "Barbers", 
				Sprite = 71, 
				Colour = 0,
			},
			Marker = {x = -33.027969360352, y = -152.4655456543, z = 57.076545715332, h = 339.44464111328},
			Banner = "shopui_title_barber4",
		},
		[2] = {
			Blip = {
				Name = "Barbers", 
				Sprite = 71, 
				Colour = 0,
			},
			Marker = {x = -1282.4963378906, y = -1117.1075439453, z = 6.9901118278503, h = 92.022262573242},
			Banner = "shopui_title_barber2",
		},
		[3] = {
			Blip = {
				Name = "Barbers", 
				Sprite = 71, 
				Colour = 0,
			},
			Marker = {x = 137.12803649902, y = -1707.8559570313, z = 29.291624069214, h = 137.43272399902},
			Banner = "shopui_title_barber",
		},
		[4] = {
			Blip = {
				Name = "Barbers", 
				Sprite = 71, 
				Colour = 0,
			},
			Marker = {x = -812.86358642578, y = -183.17976379395, z = 37.568912506104, h = 119.62373352051},
			Banner = "shopui_title_highendsalon",
		},
		[5] = {
			Blip = {
				Name = "Barbers", 
				Sprite = 71, 
				Colour = 0,
			},
			Marker = {x = 1213.5350341797, y = -473.13397216797, z = 66.2080078125, h = 75.476364135742},
			Banner = "shopui_title_barber",
		},
		[6] = {
			Blip = {
				Name = "Barbers", 
				Sprite = 71, 
				Colour = 0,
			},
			Marker = {x = 1931.224609375, y = 3731.0048828125, z = 32.844425201416, h = 210.06588745117},
			Banner = "shopui_title_barber3",
		},
		[7] = {
			Blip = {
				Name = "Barbers", 
				Sprite = 71, 
				Colour = 0,
			},
			Marker = {x = -277.47912597656, y = 6227.6870117188, z = 31.695518493652, h = 44.93936920166},
			Banner = "shopui_title_barber",
		},
	},
	Masks = {
		[1] = {
			Blip = {
				Name = "Vespucci Movie Masks", 
				Sprite = 362,
				Colour = 0,
			},
			Marker = {x = -1337.6094970703, y = -1278.38671875, z = 4.8686590194702, h = 104.41195678711},
			Banner = "shopui_title_movie_masks",
		},
		[2] = {
			Blip = {
				Name = "Vespucci Movie Masks", 
				Sprite = 362,
				Colour = 0,
			},
			Marker = {x = -143.76780700684, y = 230.12971496582, z = 94.939735412598, h = 356.40725708008},
			Banner = "shopui_title_movie_masks",
		},
	},
	Tattoos = {
		[1] = {
			Blip = {
				Name = "Tattoo Store", 
				Sprite = 75, 
				Colour = 0,
			},
			Marker = {x = -1153.7528076172, y = -1425.9929199219, z = 4.9544625282288, h = 35.740077972412},
			Banner = "shopui_title_tattoos3",
		},
		[2] = {
			Blip = {
				Name = "Tattoo Store", 
				Sprite = 75, 
				Colour = 0,
			},
			Marker = {x = 1323.1416015625, y = -1652.0681152344, z = 52.275257110596, h = 38.177295684814},
			Banner = "shopui_title_tattoos4",
		},
		[3] = {
			Blip = {
				Name = "Tattoo Store", 
				Sprite = 75, 
				Colour = 0,
			},
			Marker = {x = 321.95895385742, y = 181.09732055664, z = 103.58659362793, h = 157.62791442871},
			Banner = "shopui_title_tattoos",
		},
		[4] = {
			Blip = {
				Name = "Tattoo Store", 
				Sprite = 75, 
				Colour = 0,
			},
			Marker = {x = -3170.7250976563, y = 1075.4510498047, z = 20.829181671143, h = 246.61485290527},
			Banner = "shopui_title_tattoos5",
		},
		[5] = {
			Blip = {
				Name = "Tattoo Store", 
				Sprite = 75, 
				Colour = 0,
			},
			Marker = {x = 1864.0344238281, y = 3747.6811523438, z = 33.031887054443, h = 24.157457351685},
			Banner = "shopui_title_tattoos2",
		},
		[6] = {
			Blip = {
				Name = "Tattoo store", 
				Sprite = 75, 
				Colour = 0,
			},
			Marker = {x = -293.67370605469, y = 6199.8295898438, z = 31.487766265869, h = 224.98065185547},
			Banner = "shopui_title_tattoos2",
		},
	},
	Outfits = {
		[1] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = -1447.5682373047, y = -242.62252807617, z = 49.821376800537, h = 91.470123291016},
			Banner = "shopui_title_highendfashion",
		},
		[2] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = -1188.5400390625, y = -765.29608154297, z = 17.319789886475, h = 153.77807617188},
			Banner = "shopui_title_midfashion",
		},
		[3] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = -829.79449462891, y = -1073.0186767578, z = 11.328110694885, h = 258.48608398438},
			Banner = "shopui_title_lowendfashion2",
		},
		[4] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = -704.10363769531, y = -151.93183898926, z = 37.415172576904, h = 167.39991760254},
			Banner = "shopui_title_highendfashion",
		},
		[5] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = -167.92247009277, y = -299.22479248047, z = 39.733329772949, h = 291.93658447266},
			Banner = "shopui_title_highendfashion",
		},
		[6] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 123.40650177002, y = -228.5167388916, z = 54.557819366455, h = 19.497718811035},
			Banner = "shopui_title_midfashion",
		},
		[7] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 429.52029418945, y = -800.22686767578, z = 29.491146087646, h = 135.32809448242},
			Banner = "shopui_title_lowendfashion2",
		},
		[8] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 71.288703918457, y = -1399.19140625, z = 29.376150131226, h = 311.35946655273},
			Banner = "shopui_title_lowendfashion",
		},
		[9] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = -3173.2937011719, y = 1038.9517822266, z = 20.863235473633, h = 22.860702514648},
			Banner = "shopui_title_midfashion",
		},
		[10] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = -1108.6082763672, y = 2709.5749511719, z = 19.107873916626, h = 268.25854492188},
			Banner = "shopui_title_lowendfashion",
		},
		[11] = {
			Blip = {
				Name = "Outfits", 
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 614.50579833984, y = 2768.1318359375, z = 42.088092803955, h = 220.76393127441},
			Banner = "shopui_title_midfashion",
		},
		[12] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 1190.5087890625, y = 2714.2431640625, z = 38.222633361816, h = 225.85957336426},
			Banner = "shopui_title_lowendfashion",
		},
		[13] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 1697.2181396484, y = 4829.5947265625, z = 42.063129425049, h = 142.3412322998},
			Banner = "shopui_title_lowendfashion",
		},
		[14] = {
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 12.202723503113, y = 6513.6069335938, z = 31.877857208252, h = 87.736679077148},
			Banner = "shopui_title_lowendfashion",
		},
		[15] = { -- Strip club
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 105.67861938477, y = -1303.0101318359, z = 28.768802642822, h = 300.53588867188},
			Banner = "shopui_title_lowendfashion",
		},
		[16] = { -- Mission Row PD
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 451.21685791016, y = -991.98986816406, z = 30.689580917358, h = 313.52288818359},
			Banner = "shopui_title_midfashion",
		},
		[17] = { -- Pillbox Hospital
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 337.25042724609, y = -580.20056152344, z = 28.791465759277, h = 165.14468383789},
			Banner = "shopui_title_midfashion",
		},
		[18] = { -- Sandy Shores PD
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 1855.6212158203, y = 3691.4108886719, z = 34.224033355713, h = 18.346286773682},
			Banner = "shopui_title_midfashion",
		},
		[19] = { -- Sandy Shores Medical Center
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = 1839.0506591797, y = 3689.3781738281, z = 34.27006149292, h = 150.83392333984},
			Banner = "shopui_title_midfashion",
		},
		[20] = { -- Paleto Bay Medical Center
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = -254.04301452637, y = 6313.8842773438, z = 32.436405181885, h = 45.609973907471},
			Banner = "shopui_title_midfashion",
		},
		[21] = { -- Paleto Bay Sheriff Office
			Blip = {
				Name = "Outfits",
				Sprite = 366, 
				Colour = 0,
			},
			Marker = {x = -435.57461547852, y = 6004.6850585938, z = 31.716251373291, h = 33.369319915771},
			Banner = "shopui_title_midfashion",
		},
	},
	PlasticSurgery = {
		[1] = {
			Blip = {
				Name = "Plastic Surgery",
				Sprite = 102, 
				Colour = 0,
			},
			Marker = {x = 318.15679931641, y = -598.37371826172, z = 43.291828155518, h = 159.2621307373},
			Banner = "",
		},
	},
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
			Hybrid = {},
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
			{Name = "Crow's Feet", Value = 0},
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
							Drawable = {0,0,37,12,26,0,22,0,38,0,16,28},
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
							Drawable = {0,0,37,0,26,0,23,0,43,0,0,23},
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
							Drawable = {0,0,37,12,26,0,22,0,38,0,0,59},
							Texture = {0,0,0,0,6,0,0,0,1,0,0,0},
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
							Drawable = {0,0,0,6,24,0,11,0,32,0,0,31},
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
							Drawable = {0,0,0,0,10,0,21,21,15,0,0,13},
							Texture = {0,0,0,0,0,0,0,11,0,0,0,0},
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
							Drawable = {0,0,3,0,18,0,9,0,0,37,0,47},
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
							Drawable = {0,0,53,0,26,0,20,11,94,0,0,28},
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
							Drawable = {0,0,53,4,26,0,15,23,10,0,0,23},
							Texture = {0,0,0,0,9,0,0,7,10,0,0,4},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Dork",
						Value = {						
							Drawable = {0,0,53,4,3,0,23,22,26,0,0,23},
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
							Drawable = {45,0,11,4,30,0,25,6,0,0,0,4},
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
							Drawable = {45,0,4,5,24,0,42,0,13,0,0,35},
							Texture = {0,0,0,0,8,0,2,0,0,0,0,4},
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
							Texture = {0,0,0,0,2,0,3,2,2,0,0,2},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[7] = {
						Name = "The Campaign",
						Value = {						
							Drawable = {0,0,0,0,7,0,20,6,13,0,0,24},
							Texture = {0,0,0,0,0,0,0,0,0,0,0,0},
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
							Drawable = {45,0,4,15,2,0,10,3,3,0,0,11},
							Texture = {0,0,0,0,2,0,2,3,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Olympian",
						Value = {						
							Drawable = {45,0,4,14,12,0,10,3,3,0,0,14},
							Texture = {0,0,0,0,8,0,3,4,0,0,0,10},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[4] = {
						Name = "The Energize",
						Value = {						
							Drawable = {45,0,4,7,14,0,11,0,3,0,0,10},
							Texture = {0,0,0,0,9,0,0,0,0,0,0,0},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[5] = {
						Name = "The Ball Girl",
						Value = {						
							Drawable = {45,0,4,14,14,0,3,3,3,0,0,14},
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
							Drawable = {45,0,10,2,2,0,2,6,0,0,0,2},
							Texture = {0,0,0,0,2,0,14,4,240,0,0,6},
							Palette = {0,0,0,0,0,0,0,0,0,0,0,0},
						},
					},
					[3] = {
						Name = "The Laid Back",
						Value = {						
							Drawable = {45,0,10,2,3,0,16,6,0,0,0,3},
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
	Clothing = {
		Options = {
			PedComponentNames = {
				["0"] = "Face",
				["2"] = "Hair",
				["3"] = "Shirts",
				["4"] = "Pants",
				["8"] = "Neck",
			},
			Male = {
				{Name = "Neck", Value = 7},
				{Name = "Shirts and Jackets", Value = 11},
				{Name = "Undershirts", Value = 8},
				{Name = "Arms", Value = 3},
				{Name = "Pants", Value = 4},
				{Name = "Shoes", Value = 6},
				{Name = "Parachutes, Vests and Bags", Value = 5},
				{Name = "Tactical Vests", Value = 9},
				{Name = "Decals", Value = 10},
			},
			Female = {
				{Name = "Neck", Value = 7},
				{Name = "Shirts, Jackets and Dresses", Value = 11},
				{Name = "Undershirts", Value = 8},
				{Name = "Arms", Value = 3},
				{Name = "Pants", Value = 4},
				{Name = "Shoes", Value = 6},
				{Name = "Parachutes, Vests and Bags", Value = 5},
				{Name = "Tactical Vests", Value = 9},
				{Name = "Decals", Value = 10},
			},
			Hybrid = {},
		},
		Cameras = {
			Male = {
				[1] = {x = 0.0, y = 0.0, z = 0.0},
				[2] = {x = 0.0, y = 0.0, z = 0.0},
				[3] = {x = 0.0, y = 0.0, z = 0.0},
				[4] = {x = 0.0, y = 1.2, z = 0.3},
				[5] = {x = 0.0, y = 1.2, z = -0.3},
				[6] = {x = 0.0, y = 1.2, z = 0.3},
				[7] = {x = 0.0, y = 0.6, z = -0.8},
				[8] = {x = 0.0, y = 1.2, z = 0.3},
				[9] = {x = 0.0, y = 1.2, z = 0.3},
				[10] = {x = 0.0, y = 1.2, z = 0.3},
				[11] = {x = 0.0, y = 1.2, z = 0.3},
				[12] = {x = 0.0, y = 1.2, z = 0.3},
			},
			Female = {
				[1] = {x = 0.0, y = 0.0, z = 0.0},
				[2] = {x = 0.0, y = 0.0, z = 0.0},
				[3] = {x = 0.0, y = 0.0, z = 0.0},
				[4] = {x = 0.0, y = 1.2, z = 0.3},
				[5] = {x = 0.0, y = 1.2, z = -0.3},
				[6] = {x = 0.0, y = 1.2, z = 0.3},
				[7] = {x = 0.0, y = 0.6, z = -0.8},
				[8] = {x = 0.0, y = 1.2, z = 0.3},
				[9] = {x = 0.0, y = 1.2, z = 0.3},
				[10] = {x = 0.0, y = 1.2, z = 0.3},
				[11] = {x = 0.0, y = 1.2, z = 0.3},
				[12] = {x = 0.0, y = 1.2, z = 0.3},
			},
			Hybrid = {
				[1] = {x = 0.0, y = 0.8, z = 0.7},
				[2] = {x = 0.0, y = 1.2, z = 0.3},
				[3] = {x = 0.0, y = 0.8, z = 0.7},
				[4] = {x = 0.0, y = 1.2, z = 0.3},
				[5] = {x = 0.0, y = 1.2, z = -0.3},
				[6] = {x = 0.0, y = 1.2, z = 0.3},
				[7] = {x = 0.0, y = 1.2, z = 0.3},
				[8] = {x = 0.0, y = 1.2, z = 0.3},
				[9] = {x = 0.0, y = 1.2, z = 0.3},
				[10] = {x = 0.0, y = 1.2, z = 0.3},
				[11] = {x = 0.0, y = 1.2, z = 0.3},
				[12] = {x = 0.0, y = 1.2, z = 0.3},
			},
		},
		Drawables = {},
		Textures = {},
	},
	Props = {
		Options = {
			PedPropNames = {
				["0"] = "Hats and Helmets",
				["1"] = "Glasses",
				["2"] = "Earrings",
			},
			Male = {
				{Name = "Hats and Helmets", Value = 0},
				{Name = "Glasses", Value = 1},
				{Name = "Earrings", Value = 2},
				{Name = "Left wrist", Value = 6},
				{Name = "Right wrist", Value = 7},
			},
			Female = {
				{Name = "Hats and Helmets", Value = 0},
				{Name = "Glasses", Value = 1},
				{Name = "Earrings", Value = 2},
				{Name = "Left wrist", Value = 6},
				{Name = "Right wrist", Value = 7},
			},
			Hybrid = {},
		},
		Cameras = {
			Male = {
				[1] = {x = 0.0, y = 0.8, z = 0.7},
				[2] = {x = 0.0, y = 0.8, z = 0.7},
				[3] = {x = 0.0, y = 0.8, z = 0.7},
				[4] = {x = 0.0, y = 1.2, z = 0.3},
				[5] = {x = 0.0, y = 1.2, z = 0.3},
				[6] = {x = 0.0, y = 1.2, z = 0.3},
				[7] = {x = -0.3, y = 0.6, z = 0.0},
				[8] = {x = 0.3, y = 0.6, z = 0.0},
			},
			Female = {
				[1] = {x = 0.0, y = 0.8, z = 0.7},
				[2] = {x = 0.0, y = 0.8, z = 0.7},
				[3] = {x = 0.0, y = 0.8, z = 0.7},
				[4] = {x = 0.0, y = 1.2, z = 0.3},
				[5] = {x = 0.0, y = 1.2, z = 0.3},
				[6] = {x = 0.0, y = 1.2, z = 0.3},
				[7] = {x = -0.3, y = 0.6, z = 0.0},
				[8] = {x = 0.3, y = 0.6, z = 0.0},
			},
			Hybrid = {
				[1] = {x = 0.0, y = 0.8, z = 0.7},
				[2] = {x = 0.0, y = 0.8, z = 0.7},
				[3] = {x = 0.0, y = 0.8, z = 0.7},
				[4] = {x = 0.0, y = 1.2, z = 0.3},
				[5] = {x = 0.0, y = 1.2, z = 0.3},
				[6] = {x = 0.0, y = 1.2, z = 0.3},
				[7] = {x = 0.0, y = 1.2, z = 0.3},
				[8] = {x = 0.0, y = 1.2, z = 0.3},
			},
		},
		Drawables = {},
		Textures = {},
	},
	Masks = {
		Categories = {
			"Animals",
			"Balaclavas",
			"Biker",
			"Characters",
			"Clowns",
			"Crime",
			"Cultural",
			"Festive",
			"Gas",
			"Headscarves",
			"Intimidation",
			"Monsters",
			"Paper Bags",
			"Ski Masks",
			"Sports",
			"Tactical",
			"Valentines",
			"Zombies",
		},
		List = {
			[1] = {
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Black and Tan Pug",
					Value = {
						Drawable = 100,
						Texture = 5,
					},
				},
				{
					Name = "Josephine Pug",
					Value = {
						Drawable = 100,
						Texture = 4,
					},
				},
				{
					Name = "Brown Pug",
					Value = {
						Drawable = 100,
						Texture = 3,
					},
				},
				{
					Name = "Gray Pug",
					Value = {
						Drawable = 100,
						Texture = 2,
					},
				},
				{
					Name = "Black Pug",
					Value = {
						Drawable = 100,
						Texture = 1,
					},
				},
				{
					Name = "Moe Pug",
					Value = {
						Drawable = 100,
						Texture = 0,
					},
				},
				{
					Name = "Zebra",
					Value = {
						Drawable = 97,
						Texture = 5,
					},
				},
				{
					Name = "Pinto Horse",
					Value = {
						Drawable = 97,
						Texture = 4,
					},
				},
				{
					Name = "Brown Horse",
					Value = {
						Drawable = 97,
						Texture = 3,
					},
				},
				{
					Name = "Gray Horse",
					Value = {
						Drawable = 97,
						Texture = 2,
					},
				},
				{
					Name = "Black Horse",
					Value = {
						Drawable = 97,
						Texture = 1,
					},
				},
				{
					Name = "Chestnut Horse",
					Value = {
						Drawable = 97,
						Texture = 0,
					},
				},
				{
					Name = "Albino Crazed Ape",
					Value = {
						Drawable = 96,
						Texture = 3,
					},
				},
				{
					Name = "Gray Crazed Ape",
					Value = {
						Drawable = 96,
						Texture = 2,
					},
				},
				{
					Name = "Orangutan Crazed Ape",
					Value = {
						Drawable = 96,
						Texture = 1,
					},
				},
				{
					Name = "Silverback Crazed Ape",
					Value = {
						Drawable = 96,
						Texture = 0,
					},
				},
				{
					Name = "Danger Dino",
					Value = {
						Drawable = 93,
						Texture = 5,
					},
				},
				{
					Name = "Rainforest Dino",
					Value = {
						Drawable = 93,
						Texture = 4,
					},
				},
				{
					Name = "Earth Dino",
					Value = {
						Drawable = 93,
						Texture = 3,
					},
				},
				{
					Name = "Tropical Dino",
					Value = {
						Drawable = 93,
						Texture = 2,
					},
				},
				{
					Name = "Gray Dino",
					Value = {
						Drawable = 93,
						Texture = 1,
					},
				},
				{
					Name = "Striped Dino",
					Value = {
						Drawable = 93,
						Texture = 0,
					},
				},
				{
					Name = "Black Wolf",
					Value = {
						Drawable = 26,
						Texture = 1,
					},
				},
				{
					Name = "Grey Wolf",
					Value = {
						Drawable = 26,
						Texture = 0,
					},
				},
				{
					Name = "Black Vulture",
					Value = {
						Drawable = 25,
						Texture = 1,
					},
				},
				{
					Name = "Pink Vulture",
					Value = {
						Drawable = 25,
						Texture = 0,
					},
				},
				{
					Name = "White Eagle",
					Value = {
						Drawable = 24,
						Texture = 1,
					},
				},
				{
					Name = "Brown Eagle",
					Value = {
						Drawable = 24,
						Texture = 0,
					},
				},
				{
					Name = "Brown Bull",
					Value = {
						Drawable = 23,
						Texture = 1,
					},
				},
				{
					Name = "Black Bull",
					Value = {
						Drawable = 23,
						Texture = 0,
					},
				},
				{
					Name = "Golden Bison",
					Value = {
						Drawable = 22,
						Texture = 1,
					},
				},
				{
					Name = "Brown Bison",
					Value = {
						Drawable = 22,
						Texture = 0,
					},
				},
				{
					Name = "Grey Bear",
					Value = {
						Drawable = 21,
						Texture = 1,
					},
				},
				{
					Name = "Brown Bear",
					Value = {
						Drawable = 21,
						Texture = 0,
					},
				},
				{
					Name = "Black Racoon",
					Value = {
						Drawable = 20,
						Texture = 1,
					},
				},
				{
					Name = "Gray Racoon",
					Value = {
						Drawable = 20,
						Texture = 0,
					},
				},
				{
					Name = "White Owl",
					Value = {
						Drawable = 19,
						Texture = 1,
					},
				},
				{
					Name = "Brown Owl",
					Value = {
						Drawable = 19,
						Texture = 0,
					},
				},
				{
					Name = "Brown Fox",
					Value = {
						Drawable = 18,
						Texture = 1,
					},
				},
				{
					Name = "Red Fox",
					Value = {
						Drawable = 18,
						Texture = 0,
					},
				},
				{
					Name = "Tabby Cat",
					Value = {
						Drawable = 17,
						Texture = 1,
					},
				},
				{
					Name = "Gray Cat",
					Value = {
						Drawable = 17,
						Texture = 0,
					},
				},
				{
					Name = "Pink Pig",
					Value = {
						Drawable = 1,
						Texture = 0,
					},
				},
				{
					Name = "Brown Pig",
					Value = {
						Drawable = 1,
						Texture = 1,
					},
				},
				{
					Name = "Bloody Pig",
					Value = {
						Drawable = 1,
						Texture = 2,
					},
				},
				{
					Name = "Black Pig",
					Value = {
						Drawable = 1,
						Texture = 3,
					},
				},
				{
					Name = "Tan Ape",
					Value = {
						Drawable = 5,
						Texture = 0,
					},
				},
				{
					Name = "Brown Ape",
					Value = {
						Drawable = 5,
						Texture = 2,
					},
				},
				{
					Name = "Green Ape",
					Value = {
						Drawable = 5,
						Texture = 2,
					},
				},
				{
					Name = "Pink Ape",
					Value = {
						Drawable = 5,
						Texture = 3,
					},
				},
			},
			[2] = {
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Dark Neon Scruffy",
					Value = {
						Drawable = 119,
						Texture = 24,
					},
				},
				{
					Name = "Pretty Scruffy",
					Value = {
						Drawable = 119,
						Texture = 23,
					},
				},
				{
					Name = "Gray Woodland Scruffy",
					Value = {
						Drawable = 119,
						Texture = 22,
					},
				},
				{
					Name = "Gray Digital Scruffy",
					Value = {
						Drawable = 119,
						Texture = 21,
					},
				},
				{
					Name = "Aqua Camo Scruffy",
					Value = {
						Drawable = 119,
						Texture = 20,
					},
				},
				{
					Name = "Pink Scruffy",
					Value = {
						Drawable = 119,
						Texture = 19,
					},
				},
				{
					Name = "Skate Scruffy",
					Value = {
						Drawable = 119,
						Texture = 18,
					},
				},
				{
					Name = "Vibrant Scruffy",
					Value = {
						Drawable = 119,
						Texture = 17,
					},
				},
				{
					Name = "Magenta Leopard Scruffy",
					Value = {
						Drawable = 119,
						Texture = 16,
					},
				},
				{
					Name = "Orange Stripe Scruffy",
					Value = {
						Drawable = 119,
						Texture = 15,
					},
				},
				{
					Name = "Triplet Stripe Scruffy",
					Value = {
						Drawable = 119,
						Texture = 14,
					},
				},
				{
					Name = "Rasta Stripe Scruffy",
					Value = {
						Drawable = 119,
						Texture = 13,
					},
				},
				{
					Name = "Beige Stripe Scruffy",
					Value = {
						Drawable = 119,
						Texture = 12,
					},
				},
				{
					Name = "Bright Green Scruffy",
					Value = {
						Drawable = 119,
						Texture = 11,
					},
				},
				{
					Name = "Dark Red Scruffy",
					Value = {
						Drawable = 119,
						Texture = 6,
					},
				},
				{
					Name = "Hessian Scruffy",
					Value = {
						Drawable = 119,
						Texture = 5,
					},
				},
				{
					Name = "Blue Scruffy",
					Value = {
						Drawable = 119,
						Texture = 4,
					},
				},
				{
					Name = "Chocolate Scruffy",
					Value = {
						Drawable = 119,
						Texture = 3,
					},
				},
				{
					Name = "Charcoal Scruffy",
					Value = {
						Drawable = 119,
						Texture = 2,
					},
				},
				{
					Name = "Ash Scruffy",
					Value = {
						Drawable = 119,
						Texture = 1,
					},
				},
				{
					Name = "Skull Scruffy",
					Value = {
						Drawable = 119,
						Texture = 0,
					},
				},
				{
					Name = "Green Luchador Knit",
					Value = {
						Drawable = 117,
						Texture = 20,
					},
				},
				{
					Name = "Blue Luchador Knit",
					Value = {
						Drawable = 117,
						Texture = 19,
					},
				},
				{
					Name = "Stars & Stripes Knit",
					Value = {
						Drawable = 117,
						Texture = 18,
					},
				},
				{
					Name = "Dark Pattern Knit",
					Value = {
						Drawable = 117,
						Texture = 17,
					},
				},
				{
					Name = "Leopard Knit",
					Value = {
						Drawable = 117,
						Texture = 16,
					},
				},
				{
					Name = "Tiger Knit",
					Value = {
						Drawable = 117,
						Texture = 15,
					},
				},
				{
					Name = "Green Stripe Knit",
					Value = {
						Drawable = 117,
						Texture = 14,
					},
				},
				{
					Name = "Black & Red Knit",
					Value = {
						Drawable = 117,
						Texture = 13,
					},
				},
				{
					Name = "Primary Stripe Knit",
					Value = {
						Drawable = 117,
						Texture = 12,
					},
				},
				{
					Name = "Aqua Camo Knit",
					Value = {
						Drawable = 117,
						Texture = 11,
					},
				},
				{
					Name = "Bright Green Knit",
					Value = {
						Drawable = 117,
						Texture = 10,
					},
				},
				{
					Name = "Wine Stripe Knit",
					Value = {
						Drawable = 117,
						Texture = 9,
					},
				},
				{
					Name = "Skull Knit",
					Value = {
						Drawable = 117,
						Texture = 8,
					},
				},
				{
					Name = "Red Stripe Knit",
					Value = {
						Drawable = 117,
						Texture = 7,
					},
				},
				{
					Name = "Brown Digital Knit",
					Value = {
						Drawable = 117,
						Texture = 6,
					},
				},
				{
					Name = "Gray Woodland Knit",
					Value = {
						Drawable = 117,
						Texture = 5,
					},
				},
				{
					Name = "Gray Digital Knit",
					Value = {
						Drawable = 117,
						Texture = 4,
					},
				},
				{
					Name = "Sunrise Knit",
					Value = {
						Drawable = 117,
						Texture = 3,
					},
				},
				{
					Name = "Green & Beige Knit",
					Value = {
						Drawable = 117,
						Texture = 2,
					},
				},
				{
					Name = "Dark Red Knit",
					Value = {
						Drawable = 117,
						Texture = 1,
					},
				},
				{
					Name = "Bright Stripe Knit",
					Value = {
						Drawable = 117,
						Texture = 0,
					},
				},
				{
					Name = "Pink Stripe Knit Balaclava",
					Value = {
						Drawable = 58,
						Texture = 9,
					},
				},
				{
					Name = "Black Stripe Knit Balaclava",
					Value = {
						Drawable = 58,
						Texture = 8,
					},
				},
				{
					Name = "Blue Stripe Knit Balaclava",
					Value = {
						Drawable = 58,
						Texture = 7,
					},
				},
				{
					Name = "Pogo Balaclava",
					Value = {
						Drawable = 58,
						Texture = 6,
					},
				},
				{
					Name = "Impotent Rage Balaclava",
					Value = {
						Drawable = 58,
						Texture = 5,
					},
				},
				{
					Name = "Orange Camo Knit Balaclava",
					Value = {
						Drawable = 58,
						Texture = 4,
					},
				},
				{
					Name = "Pink Camo Knit Balaclava",
					Value = {
						Drawable = 58,
						Texture = 3,
					},
				},
				{
					Name = "Neon Camo Knit Balaclava",
					Value = {
						Drawable = 58,
						Texture = 2,
					},
				},
				{
					Name = "Nature Knit Balaclava",
					Value = {
						Drawable = 58,
						Texture = 1,
					},
				},
				{
					Name = "Bandit Knit Balaclava",
					Value = {
						Drawable = 58,
						Texture = 0,
					},
				},
				{
					Name = "Purple Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 21,
					},
				},
				{
					Name = "Orange Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 20,
					},
				},
				{
					Name = "Green Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 19,
					},
				},
				{
					Name = "Red Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 18,
					},
				},
				{
					Name = "Blue Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 17,
					},
				},
				{
					Name = "White Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 16,
					},
				},
				{
					Name = "Sessanta Nove Balaclava",
					Value = {
						Drawable = 57,
						Texture = 15,
					},
				},
				{
					Name = "Perseus Balaclava",
					Value = {
						Drawable = 57,
						Texture = 14,
					},
				},
				{
					Name = "Perseus Band Balaclava",
					Value = {
						Drawable = 57,
						Texture = 13,
					},
				},
				{
					Name = "Didier Sachs Balaclava",
					Value = {
						Drawable = 57,
						Texture = 12,
					},
				},
				{
					Name = "Princess Balaclava",
					Value = {
						Drawable = 57,
						Texture = 11,
					},
				},
				{
					Name = "Flying Bravo Balaclava",
					Value = {
						Drawable = 57,
						Texture = 10,
					},
				},
				{
					Name = "Flying Bravo FB Balaclava",
					Value = {
						Drawable = 57,
						Texture = 9,
					},
				},
				{
					Name = "Pink Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 8,
					},
				},
				{
					Name = "Dirty Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 7,
					},
				},
				{
					Name = "Woodland Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 6,
					},
				},
				{
					Name = "Rainbow Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 5,
					},
				},
				{
					Name = "Brown Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 4,
					},
				},
				{
					Name = "Gray Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 3,
					},
				},
				{
					Name = "Copper Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 2,
					},
				},
				{
					Name = "Army Green Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 1,
					},
				},
				{
					Name = "Black Knit Balaclava",
					Value = {
						Drawable = 57,
						Texture = 0,
					},
				},
				{
					Name = "Split Loose Balaclava",
					Value = {
						Drawable = 56,
						Texture = 8,
					},
				},
				{
					Name = "Outback Loose Balaclava",
					Value = {
						Drawable = 56,
						Texture = 7,
					},
				},
				{
					Name = "Red Loose Balaclava",
					Value = {
						Drawable = 56,
						Texture = 6,
					},
				},
				{
					Name = "Woodland Loose Balaclava",
					Value = {
						Drawable = 56,
						Texture = 5,
					},
				},
				{
					Name = "Bloody Loose Balaclava",
					Value = {
						Drawable = 56,
						Texture = 4,
					},
				},
				{
					Name = "Khaki Loose Balaclava",
					Value = {
						Drawable = 56,
						Texture = 3,
					},
				},
				{
					Name = "Skull Loose Balaclava",
					Value = {
						Drawable = 56,
						Texture = 2,
					},
				},
				{
					Name = "Black Loose Balaclava",
					Value = {
						Drawable = 56,
						Texture = 1,
					},
				},
				{
					Name = "Blue Loose Balaclava",
					Value = {
						Drawable = 56,
						Texture = 0,
					},
				},
				{
					Name = "Scruffy Balaclava",
					Value = {
						Drawable = 37,
						Texture = 0,
					},
				},
			},
			[3] = {
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Sand Vent",
					Value = {
						Drawable = 107,
						Texture = 19,
					},
				},
				{
					Name = "Moss Vent",
					Value = {
						Drawable = 107,
						Texture = 18,
					},
				},
				{
					Name = "Light Woodland Vent",
					Value = {
						Drawable = 107,
						Texture = 17,
					},
				},
				{
					Name = "Flecktarn Vent",
					Value = {
						Drawable = 107,
						Texture = 16,
					},
				},
				{
					Name = "Brushstroke Vent",
					Value = {
						Drawable = 107,
						Texture = 15,
					},
				},
				{
					Name = "Peach Camo Vent",
					Value = {
						Drawable = 107,
						Texture = 14,
					},
				},
				{
					Name = "Cobble Vent",
					Value = {
						Drawable = 107,
						Texture = 13,
					},
				},
				{
					Name = "Contrast Camo Vent",
					Value = {
						Drawable = 107,
						Texture = 12,
					},
				},
				{
					Name = "Splinter Vent",
					Value = {
						Drawable = 107,
						Texture = 11,
					},
				},
				{
					Name = "Aqua Camo Vent",
					Value = {
						Drawable = 107,
						Texture = 10,
					},
				},
				{
					Name = "Gray Woodland Vent",
					Value = {
						Drawable = 107,
						Texture = 9,
					},
				},
				{
					Name = "Moss Digital Vent",
					Value = {
						Drawable = 107,
						Texture = 8,
					},
				},
				{
					Name = "Crosshatch Vent",
					Value = {
						Drawable = 107,
						Texture = 7,
					},
				},
				{
					Name = "Dark Woodland Vent",
					Value = {
						Drawable = 107,
						Texture = 6,
					},
				},
				{
					Name = "Fall Vent",
					Value = {
						Drawable = 107,
						Texture = 5,
					},
				},
				{
					Name = "Peach Digital Vent",
					Value = {
						Drawable = 107,
						Texture = 4,
					},
				},
				{
					Name = "Gray Digital Vent",
					Value = {
						Drawable = 107,
						Texture = 3,
					},
				},
				{
					Name = "Green Digital Vent",
					Value = {
						Drawable = 107,
						Texture = 2,
					},
				},
				{
					Name = "Brown Digital Vent",
					Value = {
						Drawable = 107,
						Texture = 1,
					},
				},
				{
					Name = "Blue Digital Vent",
					Value = {
						Drawable = 107,
						Texture = 0,
					},
				},
				{
					Name = "Tan Dome Vent",
					Value = {
						Drawable = 90,
						Texture = 7,
					},
				},
				{
					Name = "Black Dome Vent",
					Value = {
						Drawable = 90,
						Texture = 6,
					},
				},
				{
					Name = "Chocolate Dome Vent",
					Value = {
						Drawable = 90,
						Texture = 5,
					},
				},
				{
					Name = "Ox Blood Dome Vent",
					Value = {
						Drawable = 90,
						Texture = 4,
					},
				},
				{
					Name = "Tan Dome Filter",
					Value = {
						Drawable = 90,
						Texture = 3,
					},
				},
				{
					Name = "Black Dome Filter",
					Value = {
						Drawable = 90,
						Texture = 2,
					},
				},
				{
					Name = "Chocolate Dome Filter",
					Value = {
						Drawable = 90,
						Texture = 1,
					},
				},
				{
					Name = "Ox Blood Dome Filter",
					Value = {
						Drawable = 90,
						Texture = 0,
					},
				},
			},
			[4] = {
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Gothic False Face",
					Value = {
						Drawable = 128,
						Texture = 11,
					},
				},
				{
					Name = "Green Pattern False Face",
					Value = {
						Drawable = 128,
						Texture = 10,
					},
				},
				{
					Name = "Stars & Stripes False Face",
					Value = {
						Drawable = 128,
						Texture = 9,
					},
				},
				{
					Name = "Opera False Face",
					Value = {
						Drawable = 128,
						Texture = 8,
					},
				},
				{
					Name = "Rising Sun False Face",
					Value = {
						Drawable = 128,
						Texture = 7,
					},
				},
				{
					Name = "Cobble Woodland False Face",
					Value = {
						Drawable = 128,
						Texture = 6,
					},
				},
				{
					Name = "Striped Woodland False Face",
					Value = {
						Drawable = 128,
						Texture = 5,
					},
				},
				{
					Name = "Brown Digital False Face",
					Value = {
						Drawable = 128,
						Texture = 4,
					},
				},
				{
					Name = "Splinter False Face",
					Value = {
						Drawable = 128,
						Texture = 3,
					},
				},
				{
					Name = "Headline False Face",
					Value = {
						Drawable = 128,
						Texture = 2,
					},
				},
				{
					Name = "Aqua Camo False Face",
					Value = {
						Drawable = 128,
						Texture = 1,
					},
				},
				{
					Name = "Gray Woodland False Face",
					Value = {
						Drawable = 128,
						Texture = 0,
					},
				},
				{
					Name = "Mime Plastic Face",
					Value = {
						Drawable = 50,
						Texture = 9,
					},
				},
				{
					Name = "Puppet Plastic Face",
					Value = {
						Drawable = 50,
						Texture = 8,
					},
				},
				{
					Name = "Doll Plastic Face",
					Value = {
						Drawable = 50,
						Texture = 7,
					},
				},
				{
					Name = "Mannequin Plastic Face",
					Value = {
						Drawable = 50,
						Texture = 6,
					},
				},
				{
					Name = "Brown Plastic Face",
					Value = {
						Drawable = 50,
						Texture = 5,
					},
				},
				{
					Name = "Black Plastic Face",
					Value = {
						Drawable = 50,
						Texture = 4,
					},
				},
				{
					Name = "Clown Plastic Face",
					Value = {
						Drawable = 50,
						Texture = 3,
					},
				},
				{
					Name = "Pink Plastic Face",
					Value = {
						Drawable = 50,
						Texture = 2,
					},
				},
				{
					Name = "The Don Plastic Face",
					Value = {
						Drawable = 50,
						Texture = 1,
					},
				},
				{
					Name = "Green Plastic Face",
					Value = {
						Drawable = 50,
						Texture = 0,
					},
				},
				{
					Name = "Moorehead",
					Value = {
						Drawable = 45,
						Texture = 0,
					},
				},
				{
					Name = "Princess Robot Bubblegum",
					Value = {
						Drawable = 44,
						Texture = 0,
					},
				},
				{
					Name = "Impotent Rage",
					Value = {
						Drawable = 43,
						Texture = 0,
					},
				},
				{
					Name = "Pogo",
					Value = {
						Drawable = 3,
						Texture = 0,
					},
				},
			},
			[5] = {
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Sinister Clown",
					Value = {
						Drawable = 95,
						Texture = 7,
					},
				},
				{
					Name = "Franken Clown",
					Value = {
						Drawable = 95,
						Texture = 6,
					},
				},
				{
					Name = "Neon Clown",
					Value = {
						Drawable = 95,
						Texture = 5,
					},
				},
				{
					Name = "Scavenger Clown",
					Value = {
						Drawable = 95,
						Texture = 4,
					},
				},
				{
					Name = "Orange Clown",
					Value = {
						Drawable = 95,
						Texture = 3,
					},
				},
				{
					Name = "Green Clown",
					Value = {
						Drawable = 95,
						Texture = 2,
					},
				},
				{
					Name = "Blue Clown",
					Value = {
						Drawable = 95,
						Texture = 1,
					},
				},
				{
					Name = "Red Clown",
					Value = {
						Drawable = 95,
						Texture = 0,
					},
				},	
			},
			[6] = {
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Pink Pattern T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 25,
					},
				},
				{
					Name = "Green Pattern T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 24,
					},
				},
				{
					Name = "Orange Pattern T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 23,
					},
				},
				{
					Name = "Pink Tie Dye T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 22,
					},
				},
				{
					Name = "Far Out Tie Dye T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 21,
					},
				},
				{
					Name = "Aqua Tie Dye T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 20,
					},
				},
				{
					Name = "SA Republic T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 19,
					},
				},
				{
					Name = "Black Stars & Stripes T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 18,
					},
				},
				{
					Name = "Stars & Stripes T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 17,
					},
				},
				{
					Name = "Green & Pink T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 16,
					},
				},
				{
					Name = "OJ Squash T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 15,
					},
				},
				{
					Name = "Primary T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 14,
					},
				},
				{
					Name = "Gray Bihness T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 13,
					},
				},
				{
					Name = "Red Bigness T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 12,
					},
				},
				{
					Name = "Black Bigness T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 11,
					},
				},
				{
					Name = "Camo Bigness T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 10,
					},
				},
				{
					Name = "Red Camo T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 9,
					},
				},
				{
					Name = "Aqua Camo T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 8,
					},
				},
				{
					Name = "Gray Digital T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 7,
					},
				},
				{
					Name = "Multicolor Leaves T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 6,
					},
				},
				{
					Name = "Navy Painted T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 5,
					},
				},
				{
					Name = "Magenta Leopard T-Shirt",
					Value = {
						Drawable = 118,
						Texture = 4,
					},
				},
				{
					Name = "Bright Pattern Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 25,
					},
				},
				{
					Name = "Dark Pattern Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 24,
					},
				},
				{
					Name = "Zebra Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 23,
					},
				},
				{
					Name = "Contrast Camo Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 22,
					},
				},
				{
					Name = "Fractal Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 21,
					},
				},
				{
					Name = "Painted Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 20,
					},
				},
				{
					Name = "Stars & Stripes Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 19,
					},
				},
				{
					Name = "Off-White Broker Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 18,
					},
				},
				{
					Name = "Black Broker Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 17,
					},
				},
				{
					Name = "Orange Broker Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 16,
					},
				},
				{
					Name = "White Broker Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 15,
					},
				},
				{
					Name = "Skulls Manor Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 14,
					},
				},
				{
					Name = "Black Manor Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 13,
					},
				},
				{
					Name = "Red Manor Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 12,
					},
				},
				{
					Name = "Blue Leaves Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 11,
					},
				},
				{
					Name = "Green Leaves Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 10,
					},
				},
				{
					Name = "Red Bigness Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 9,
					},
				},
				{
					Name = "Splinter Bigness Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 8,
					},
				},
				{
					Name = "Geometric Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 7,
					},
				},
				{
					Name = "Bold Abstract Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 6,
					},
				},
				{
					Name = "Red Blagueurs Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 5,
					},
				},
				{
					Name = "Blue Blagueurs Face Bandana",
					Value = {
						Drawable = 111,
						Texture = 4,
					},
				},
				{
					Name = "LSPD T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 10,
					},
				},
				{
					Name = "Pink Camo T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 9,
					},
				},
				{
					Name = "TPI T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 8,
					},
				},
				{
					Name = "Love Fist T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 7,
					},
				},
				{
					Name = "Stripy T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 6,
					},
				},
				{
					Name = "Woodland T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 5,
					},
				},
				{
					Name = "Justice T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 4,
					},
				},
				{
					Name = "Benders T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 3,
					},
				},
				{
					Name = "Tan T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 2,
					},
				},
				{
					Name = "White T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 1,
					},
				},
				{
					Name = "Black T-Shirt Mask",
					Value = {
						Drawable = 54,
						Texture = 0,
					},
				},
				{
					Name = "Electric Skull Face Bandana",
					Value = {
						Drawable = 51,
						Texture = 9,
					},
				},
				{
					Name = "Yellow Face Bandana",
					Value = {
						Drawable = 51,
						Texture = 8,
					},
				},
				{
					Name = "Paisley Face Bandana",
					Value = {
						Drawable = 51,
						Texture = 7,
					},
				},
				{
					Name = "Purple Face Bandana",
					Value = {
						Drawable = 51,
						Texture = 6,
					},
				},
				{
					Name = "Green Face Bandana",
					Value = {
						Drawable = 51,
						Texture = 5,
					},
				},
				{
					Name = "Forest Face Bandana",
					Value = {
						Drawable = 51,
						Texture = 4,
					},
				},
				{
					Name = "Desert Face Bandana",
					Value = {
						Drawable = 51,
						Texture = 3,
					},
				},
				{
					Name = "Urban Face Bandana",
					Value = {
						Drawable = 51,
						Texture = 2,
					},
				},
				{
					Name = "Skull Face Bandana",
					Value = {
						Drawable = 51,
						Texture = 1,
					},
				},
				{
					Name = "Black Face Bandana",
					Value = {
						Drawable = 51,
						Texture = 0,
					},
				},
				{
					Name = "Electrical Duct Tape",
					Value = {
						Drawable = 48,
						Texture = 3,
					},
				},
				{
					Name = "White Duct Tape",
					Value = {
						Drawable = 48,
						Texture = 2,
					},
				},
				{
					Name = "Dark Gray Duct Tape",
					Value = {
						Drawable = 48,
						Texture = 1,
					},
				},
				{
					Name = "Light Gray Duct Tape",
					Value = {
						Drawable = 48,
						Texture = 0,
					},
				},
				{
					Name = "Red Arrow Tape",
					Value = {
						Drawable = 47,
						Texture = 3,
					},
				},
				{
					Name = "Hazard Tape",
					Value = {
						Drawable = 47,
						Texture = 2,
					},
				},
				{
					Name = "Black Arrow Tape",
					Value = {
						Drawable = 47,
						Texture = 1,
					},
				},
				{
					Name = "Crime Scene Tape",
					Value = {
						Drawable = 47,
						Texture = 0,
					},
				},
			},
			[7] = {
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Iwazaru Neon",
					Value = {
						Drawable = 124,
						Texture = 23,
					},
				},
				{
					Name = "Iwazaru Electric",
					Value = {
						Drawable = 124,
						Texture = 22,
					},
				},
				{
					Name = "Iwazaru Luminous",
					Value = {
						Drawable = 124,
						Texture = 21,
					},
				},
				{
					Name = "Tribal Neon",
					Value = {
						Drawable = 124,
						Texture = 20,
					},
				},
				{
					Name = "Tribal Luminous",
					Value = {
						Drawable = 124,
						Texture = 19,
					},
				},
				{
					Name = "Tribal Electric",
					Value = {
						Drawable = 124,
						Texture = 18,
					},
				},
				{
					Name = "Transcendent Neon",
					Value = {
						Drawable = 124,
						Texture = 17,
					},
				},
				{
					Name = "Transcendent Electric",
					Value = {
						Drawable = 124,
						Texture = 16,
					},
				},
				{
					Name = "Transcendent Luminous",
					Value = {
						Drawable = 124,
						Texture = 15,
					},
				},
				{
					Name = "Peaceful Luminous",
					Value = {
						Drawable = 124,
						Texture = 14,
					},
				},
				{
					Name = "Peaceful Electric",
					Value = {
						Drawable = 124,
						Texture = 13,
					},
				},
				{
					Name = "Peaceful Neon",
					Value = {
						Drawable = 124,
						Texture = 12,
					},
				},
				{
					Name = "Pleased Electric",
					Value = {
						Drawable = 124,
						Texture = 11,
					},
				},
				{
					Name = "Pleased Luminous",
					Value = {
						Drawable = 124,
						Texture = 10,
					},
				},
				{
					Name = "Pleased Neon",
					Value = {
						Drawable = 124,
						Texture = 9,
					},
				},
				{
					Name = "Furious Neon",
					Value = {
						Drawable = 124,
						Texture = 8,
					},
				},
				{
					Name = "Furious Electric",
					Value = {
						Drawable = 124,
						Texture = 7,
					},
				},
				{
					Name = "Furious Luminous",
					Value = {
						Drawable = 124,
						Texture = 6,
					},
				},
				{
					Name = "Amused Neon",
					Value = {
						Drawable = 124,
						Texture = 5,
					},
				},
				{
					Name = "Amused Luminous",
					Value = {
						Drawable = 124,
						Texture = 4,
					},
				},
				{
					Name = "Amused Electric",
					Value = {
						Drawable = 124,
						Texture = 3,
					},
				},
				{
					Name = "Manic Neon",
					Value = {
						Drawable = 124,
						Texture = 2,
					},
				},
				{
					Name = "Manic Electric",
					Value = {
						Drawable = 124,
						Texture = 1,
					},
				},
				{
					Name = "Manic Luminous",
					Value = {
						Drawable = 124,
						Texture = 0,
					},
				},
				{
					Name = "Purple Oni",
					Value = {
						Drawable = 105,
						Texture = 23,
					},
				},
				{
					Name = "Sea Green Oni",
					Value = {
						Drawable = 105,
						Texture = 22,
					},
				},
				{
					Name = "Stone Oni",
					Value = {
						Drawable = 105,
						Texture = 21,
					},
				},
				{
					Name = "Gray and Gold Oni",
					Value = {
						Drawable = 105,
						Texture = 20,
					},
				},
				{
					Name = "White Possessed Oni",
					Value = {
						Drawable = 105,
						Texture = 19,
					},
				},
				{
					Name = "Fray and Orange Oni",
					Value = {
						Drawable = 105,
						Texture = 18,
					},
				},
				{
					Name = "Black and Gold Oni",
					Value = {
						Drawable = 105,
						Texture = 17,
					},
				},
				{
					Name = "Gray Oni",
					Value = {
						Drawable = 105,
						Texture = 16,
					},
				},
				{
					Name = "Stone Possessed Oni",
					Value = {
						Drawable = 105,
						Texture = 15,
					},
				},
				{
					Name = "Gold Stone Possessed Oni",
					Value = {
						Drawable = 105,
						Texture = 14,
					},
				},
				{
					Name = "Orange Oni",
					Value = {
						Drawable = 105,
						Texture = 13,
					},
				},
				{
					Name = "Black and Yellow Oni",
					Value = {
						Drawable = 105,
						Texture = 12,
					},
				},
				{
					Name = "Grayscale Oni",
					Value = {
						Drawable = 105,
						Texture = 11,
					},
				},
				{
					Name = "Plum Oni",
					Value = {
						Drawable = 105,
						Texture = 10,
					},
				},
				{
					Name = "Yellow Oni",
					Value = {
						Drawable = 105,
						Texture = 9,
					},
				},
				{
					Name = "Brown Oni",
					Value = {
						Drawable = 105,
						Texture = 8,
					},
				},
				{
					Name = "Black Possessed Oni",
					Value = {
						Drawable = 105,
						Texture = 7,
					},
				},
				{
					Name = "Black Painted Oni",
					Value = {
						Drawable = 105,
						Texture = 6,
					},
				},
				{
					Name = "Red Painted Oni",
					Value = {
						Drawable = 105,
						Texture = 5,
					},
				},
				{
					Name = "Gold Painted Oni",
					Value = {
						Drawable = 105,
						Texture = 4,
					},
				},
				{
					Name = "White Painted Oni",
					Value = {
						Drawable = 105,
						Texture = 3,
					},
				},
				{
					Name = "Sandstone Oni",
					Value = {
						Drawable = 105,
						Texture = 2,
					},
				},
				{
					Name = "Weathered Oni",
					Value = {
						Drawable = 105,
						Texture = 1,
					},
				},
				{
					Name = "Obsidian Oni",
					Value = {
						Drawable = 105,
						Texture = 0,
					},
				},
				{
					Name = "Black Ornate Skull",
					Value = {
						Drawable = 99,
						Texture = 5,
					},
				},
				{
					Name = "White Ornate Skull",
					Value = {
						Drawable = 99,
						Texture = 4,
					},
				},
				{
					Name = "Teal Ornate Skull",
					Value = {
						Drawable = 99,
						Texture = 3,
					},
				},
				{
					Name = "Blue Ornate Skull",
					Value = {
						Drawable = 99,
						Texture = 2,
					},
				},
				{
					Name = "Silver Ornate Skull",
					Value = {
						Drawable = 99,
						Texture = 1,
					},
				},
				{
					Name = "Red Ornate Skull",
					Value = {
						Drawable = 99,
						Texture = 0,
					},
				},
				{
					Name = "Green Oni",
					Value = {
						Drawable = 94,
						Texture = 5,
					},
				},
				{
					Name = "Gold Oni",
					Value = {
						Drawable = 94,
						Texture = 4,
					},
				},
				{
					Name = "Black Oni",
					Value = {
						Drawable = 94,
						Texture = 3,
					},
				},
				{
					Name = "White Oni",
					Value = {
						Drawable = 94,
						Texture = 2,
					},
				},
				{
					Name = "Blue Oni",
					Value = {
						Drawable = 94,
						Texture = 1,
					},
				},
				{
					Name = "Red Oni",
					Value = {
						Drawable = 94,
						Texture = 0,
					},
				},
				{
					Name = "Fashion Hockey",
					Value = {
						Drawable = 14,
						Texture = 10,
					},
				},
				{
					Name = "Tourist Hockey",
					Value = {
						Drawable = 14,
						Texture = 2,
					},
				},
				{
					Name = "Vinewood Hockey",
					Value = {
						Drawable = 14,
						Texture = 1,
					},
				},
				{
					Name = "Green Carnival",
					Value = {
						Drawable = 6,
						Texture = 0,
					},
				},
				{
					Name = "Blue Carnival",
					Value = {
						Drawable = 6,
						Texture = 2,
					},
				},
				{
					Name = "Black Carnival",
					Value = {
						Drawable = 6,
						Texture = 3,
					},
				},
				{
					Name = "White Carnival",
					Value = {
						Drawable = 6,
						Texture = 1,
					},
				},
			},
			[8] = {
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Latino Mrs Claus",
					Value = {
						Drawable = 88,
						Texture = 2,
					},
				},
				{
					Name = "Black Mrs Claus",
					Value = {
						Drawable = 88,
						Texture = 1,
					},
				},
				{
					Name = "White Mrs Claus",
					Value = {
						Drawable = 88,
						Texture = 0,
					},
				},
				{
					Name = "Badass Bad Elf",
					Value = {
						Drawable = 87,
						Texture = 2,
					},
				},
				{
					Name = "Gangsta Bad Elf",
					Value = {
						Drawable = 87,
						Texture = 1,
					},
				},
				{
					Name = "Rebel Bad Elf",
					Value = {
						Drawable = 87,
						Texture = 0,
					},
				},
				{
					Name = "High Mrs Claus",
					Value = {
						Drawable = 86,
						Texture = 2,
					},
				},
				{
					Name = "Smashed Mrs Claus",
					Value = {
						Drawable = 86,
						Texture = 1,
					},
				},
				{
					Name = "Wasted Mrs Claus",
					Value = {
						Drawable = 86,
						Texture = 0,
					},
				},
				{
					Name = "Burnt Turkey",
					Value = {
						Drawable = 85,
						Texture = 2,
					},
				},
				{
					Name = "Cooked Turkey",
					Value = {
						Drawable = 85,
						Texture = 1,
					},
				},
				{
					Name = "Raw Turkey",
					Value = {
						Drawable = 85,
						Texture = 0,
					},
				},
				{
					Name = "Light Pudding",
					Value = {
						Drawable = 78,
						Texture = 1,
					},
				},
				{
					Name = "Dark Pudding",
					Value = {
						Drawable = 78,
						Texture = 0,
					},
				},
				{
					Name = "Purple Festive Luchador",
					Value = {
						Drawable = 77,
						Texture = 5,
					},
				},
				{
					Name = "Red Festive Luchador",
					Value = {
						Drawable = 77,
						Texture = 4,
					},
				},
				{
					Name = "White Festive Luchador",
					Value = {
						Drawable = 77,
						Texture = 3,
					},
				},
				{
					Name = "Black Festive Luchador",
					Value = {
						Drawable = 77,
						Texture = 2,
					},
				},
				{
					Name = "Dark Green Festive Luchador",
					Value = {
						Drawable = 77,
						Texture = 1,
					},
				},
				{
					Name = "Green Festive Luchador",
					Value = {
						Drawable = 77,
						Texture = 0,
					},
				},
				{
					Name = "Filthy Bad Santa",
					Value = {
						Drawable = 76,
						Texture = 2,
					},
				},
				{
					Name = "Grumpy Bad Santa",
					Value = {
						Drawable = 76,
						Texture = 1,
					},
				},
				{
					Name = "Bruised Bad Santa",
					Value = {
						Drawable = 76,
						Texture = 0,
					},
				},
				{
					Name = "Brown Crazy Gingerbread",
					Value = {
						Drawable = 75,
						Texture = 2,
					},
				},
				{
					Name = "Blue Crazy Gingerbread",
					Value = {
						Drawable = 75,
						Texture = 1,
					},
				},
				{
					Name = "Pink Crazy Gingerbread",
					Value = {
						Drawable = 75,
						Texture = 0,
					},
				},
				{
					Name = "Angry Gingerbread",
					Value = {
						Drawable = 74,
						Texture = 2,
					},
				},
				{
					Name = "Mad Gingerbread",
					Value = {
						Drawable = 74,
						Texture = 1,
					},
				},
				{
					Name = "Manic Gingerbread",
					Value = {
						Drawable = 74,
						Texture = 0,
					},
				},
				{
					Name = "Latino Elf",
					Value = {
						Drawable = 34,
						Texture = 2,
					},
				},
				{
					Name = "Black Elf",
					Value = {
						Drawable = 34,
						Texture = 1,
					},
				},
				{
					Name = "White Elf",
					Value = {
						Drawable = 34,
						Texture = 0,
					},
				},
				{
					Name = "Gingerbread",
					Value = {
						Drawable = 33,
						Texture = 0,
					},
				},
				{
					Name = "Penguin",
					Value = {
						Drawable = 31,
						Texture = 0,
					},
				},
				{
					Name = "Snowman Mask",
					Value = {
						Drawable = 10,
						Texture = 0,
					},
				},
				{
					Name = "Reindeer Mask",
					Value = {
						Drawable = 9,
						Texture = 0,
					},
				},
				{
					Name = "Latino Santa",
					Value = {
						Drawable = 8,
						Texture = 2,
					},
				},
				{
					Name = "Black Santa",
					Value = {
						Drawable = 8,
						Texture = 1,
					},
				},
				{
					Name = "White Santa",
					Value = {
						Drawable = 8,
						Texture = 0,
					},
				},
				{
					Name = "Abominable Snowman",
					Value = {
						Drawable = 84,
						Texture = 0,
					},
				},
				{
					Name = "Stocking",
					Value = {
						Drawable = 32,
						Texture = 0,
					},
				},
				{
					Name = "Odious Krampus",
					Value = {
						Drawable = 131,
						Texture = 2,
					},
				},
			},
			[9] = {
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Crosshatch Respirator",
					Value = {
						Drawable = 130,
						Texture = 14,
					},
				},
				{
					Name = "Viper Respirator",
					Value = {
						Drawable = 130,
						Texture = 13,
					},
				},
				{
					Name = "Contrast Camo Respirator",
					Value = {
						Drawable = 130,
						Texture = 12,
					},
				},
				{
					Name = "Cobble Respirator",
					Value = {
						Drawable = 130,
						Texture = 11,
					},
				},
				{
					Name = "Gray Woodland Respirator",
					Value = {
						Drawable = 130,
						Texture = 10,
					},
				},
				{
					Name = "Brushstroke Respirator",
					Value = {
						Drawable = 130,
						Texture = 9,
					},
				},
				{
					Name = "Green Digital Respirator",
					Value = {
						Drawable = 130,
						Texture = 8,
					},
				},
				{
					Name = "Moss Striped Respirator",
					Value = {
						Drawable = 130,
						Texture = 7,
					},
				},
				{
					Name = "Tiger Striped Respirator",
					Value = {
						Drawable = 130,
						Texture = 6,
					},
				},
				{
					Name = "Gray Splinter Respirator",
					Value = {
						Drawable = 130,
						Texture = 5,
					},
				},
				{
					Name = "Splinter Respirator",
					Value = {
						Drawable = 130,
						Texture = 4,
					},
				},
				{
					Name = "Aqua Camo Respirator",
					Value = {
						Drawable = 130,
						Texture = 3,
					},
				},
				{
					Name = "Gray Digital Respirator",
					Value = {
						Drawable = 130,
						Texture = 2,
					},
				},
				{
					Name = "Flacktarn Respirator",
					Value = {
						Drawable = 130,
						Texture = 1,
					},
				},
				{
					Name = "Black Respirator",
					Value = {
						Drawable = 130,
						Texture = 0,
					},
				},
				{
					Name = "Orange Industrial Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 13,
					},
				},
				{
					Name = "Yellow Industrial Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 12,
					},
				},
				{
					Name = "White Industrial Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 11,
					},
				},
				{
					Name = "Skull Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 10,
					},
				},
				{
					Name = "Woodland Digital Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 9,
					},
				},
				{
					Name = "Peach Camo Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 8,
					},
				},
				{
					Name = "Moss Striped Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 7,
					},
				},
				{
					Name = "Gray Striped Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 6,
					},
				},
				{
					Name = "Gray Splinter Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 5,
					},
				},
				{
					Name = "Splinter Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 4,
					},
				},
				{
					Name = "Aqua Camo Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 3,
					},
				},
				{
					Name = "Tan Digital Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 2,
					},
				},
				{
					Name = "Carbon Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 1,
					},
				},
				{
					Name = "Gray Gas Mask",
					Value = {
						Drawable = 129,
						Texture = 0,
					},
				},
				{
					Name = "Gas Mask",
					Value = {
						Drawable = 38,
						Texture = 0,
					},
				},
			},
			[10] = {
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Jolly Roger Snood",
					Value = {
						Drawable = 116,
						Texture = 21,
					},
				},
				{
					Name = "Flecktarn Snood",
					Value = {
						Drawable = 116,
						Texture = 20,
					},
				},
				{
					Name = "Brushstroke Snood",
					Value = {
						Drawable = 116,
						Texture = 19,
					},
				},
				{
					Name = "Peach Camo Snood",
					Value = {
						Drawable = 116,
						Texture = 18,
					},
				},
				{
					Name = "Weapon Pattern Snood",
					Value = {
						Drawable = 116,
						Texture = 17,
					},
				},
				{
					Name = "Red Pattern Snood",
					Value = {
						Drawable = 116,
						Texture = 16,
					},
				},
				{
					Name = "Splinter Snood",
					Value = {
						Drawable = 116,
						Texture = 15,
					},
				},
				{
					Name = "Yellow Pattern Snood",
					Value = {
						Drawable = 116,
						Texture = 14,
					},
				},
				{
					Name = "Gray Woodland Snood",
					Value = {
						Drawable = 116,
						Texture = 13,
					},
				},
				{
					Name = "Purple Pattern Snood",
					Value = {
						Drawable = 116,
						Texture = 12,
					},
				},
				{
					Name = "Blue Pattern Snood",
					Value = {
						Drawable = 116,
						Texture = 11,
					},
				},
				{
					Name = "Dark Woodland Snood",
					Value = {
						Drawable = 116,
						Texture = 10,
					},
				},
				{
					Name = "Fall Snood",
					Value = {
						Drawable = 116,
						Texture = 9,
					},
				},
				{
					Name = "Peach Digital Snood",
					Value = {
						Drawable = 116,
						Texture = 8,
					},
				},
				{
					Name = "Orange Pattern Snood",
					Value = {
						Drawable = 116,
						Texture = 7,
					},
				},
				{
					Name = "Dark Red Pattern Snood",
					Value = {
						Drawable = 116,
						Texture = 6,
					},
				},
				{
					Name = "Brown Digital Snood",
					Value = {
						Drawable = 116,
						Texture = 5,
					},
				},
				{
					Name = "Turquoise Snood",
					Value = {
						Drawable = 116,
						Texture = 4,
					},
				},
				{
					Name = "Yellow Snood",
					Value = {
						Drawable = 116,
						Texture = 3,
					},
				},	
				{
					Name = "Green Snood",
					Value = {
						Drawable = 116,
						Texture = 2,
					},
				},
				{
					Name = "Teal Snood",
					Value = {
						Drawable = 116,
						Texture = 1,
					},
				},
				{
					Name = "Brown Snood",
					Value = {
						Drawable = 116,
						Texture = 0,
					},
				},
				{
					Name = "Purple Pattern Wrapped",
					Value = {
						Drawable = 115,
						Texture = 21,
					},
				},
				{
					Name = "Flecktarn Wrapped",
					Value = {
						Drawable = 115,
						Texture = 20,
					},
				},
				{
					Name = "Brushstroke Wrapped",
					Value = {
						Drawable = 115,
						Texture = 19,
					},
				},
				{
					Name = "Peach Camo Wrapped",
					Value = {
						Drawable = 115,
						Texture = 18,
					},
				},
				{
					Name = "Orange Pattern Wrapped",
					Value = {
						Drawable = 115,
						Texture = 17,
					},
				},
				{
					Name = "Dark Red Pattern Wrapped",
					Value = {
						Drawable = 115,
						Texture = 16,
					},
				},
				{
					Name = "Splinter Wrapped",
					Value = {
						Drawable = 115,
						Texture = 15,
					},
				},	
				{
					Name = "Dark Pattern Wrapped",
					Value = {
						Drawable = 115,
						Texture = 14,
					},
				},
				{
					Name = "Gray Woodland Wrapped",
					Value = {
						Drawable = 115,
						Texture = 13,
					},
				},
				{
					Name = "Blue Pattern Wrapped",
					Value = {
						Drawable = 115,
						Texture = 12,
					},
				},
				{
					Name = "Weapon Pattern Wrapped",
					Value = {
						Drawable = 115,
						Texture = 11,
					},
				},
				{
					Name = "Dark Woodland Wrapped",
					Value = {
						Drawable = 115,
						Texture = 10,
					},
				},
				{
					Name = "Fall Wrapped",
					Value = {
						Drawable = 115,
						Texture = 9,
					},
				},
				{
					Name = "Peach Digital Wrapped",
					Value = {
						Drawable = 115,
						Texture = 8,
					},
				},
				{
					Name = "Jolly Roger Wrapped",
					Value = {
						Drawable = 115,
						Texture = 7,
					},
				},
				{
					Name = "Red Pattern Wrapped",
					Value = {
						Drawable = 115,
						Texture = 6,
					},
				},
				{
					Name = "Brown Digital Wrapped",
					Value = {
						Drawable = 115,
						Texture = 5,
					},
				},	
				{
					Name = "Turquoise Wrapped",
					Value = {
						Drawable = 115,
						Texture = 4,
					},
				},
				{
					Name = "Yellow Wrapped",
					Value = {
						Drawable = 115,
						Texture = 3,
					},
				},
				{
					Name = "Green Wrapped",
					Value = {
						Drawable = 115,
						Texture = 2,
					},
				},
				{
					Name = "Teal Wrapped",
					Value = {
						Drawable = 115,
						Texture = 1,
					},
				},
				{
					Name = "Brown Wrapped",
					Value = {
						Drawable = 115,
						Texture = 0,
					},
				},
				{
					Name = "Weapon Pattern Loose",
					Value = {
						Drawable = 114,
						Texture = 21,
					},
				},
				{
					Name = "Flecktarn Loose",
					Value = {
						Drawable = 114,
						Texture = 20,
					},
				},
				{
					Name = "Brushstroke Loose",
					Value = {
						Drawable = 114,
						Texture = 19,
					},
				},
				{
					Name = "Peach Camo Loose",
					Value = {
						Drawable = 114,
						Texture = 18,
					},
				},
				{
					Name = "Jolly Roger Loose",
					Value = {
						Drawable = 114,
						Texture = 17,
					},
				},
				{
					Name = "Purple Pattern Loose",
					Value = {
						Drawable = 114,
						Texture = 16,
					},
				},
				{
					Name = "Splinter Loose",
					Value = {
						Drawable = 114,
						Texture = 15,
					},
				},
				{
					Name = "Blue Pattern Loose",
					Value = {
						Drawable = 114,
						Texture = 14,
					},
				},
				{
					Name = "Gray Woodland Loose",
					Value = {
						Drawable = 114,
						Texture = 13,
					},
				},
				{
					Name = "Red Pattern Loose",
					Value = {
						Drawable = 114,
						Texture = 12,
					},
				},
				{
					Name = "Orange Pattern Loose",
					Value = {
						Drawable = 114,
						Texture = 11,
					},
				},
				{
					Name = "Dark Woodland Loose",
					Value = {
						Drawable = 114,
						Texture = 10,
					},
				},
				{
					Name = "Fall Loose",
					Value = {
						Drawable = 114,
						Texture = 9,
					},
				},
				{
					Name = "Peach Digital Loose",
					Value = {
						Drawable = 114,
						Texture = 8,
					},
				},
				{
					Name = "Dark Red Pattern Loose",
					Value = {
						Drawable = 114,
						Texture = 7,
					},
				},
				{
					Name = "Yellow Pattern Loose",
					Value = {
						Drawable = 114,
						Texture = 6,
					},
				},
				{
					Name = "Brown Digital Loose",
					Value = {
						Drawable = 114,
						Texture = 5,
					},
				},
				{
					Name = "Turquoise Loose",
					Value = {
						Drawable = 114,
						Texture = 4,
					},
				},
				{
					Name = "Yellow Loose",
					Value = {
						Drawable = 114,
						Texture = 3,
					},
				},
				{
					Name = "Green Loose",
					Value = {
						Drawable = 114,
						Texture = 2,
					},
				},
				{
					Name = "Teal Loose",
					Value = {
						Drawable = 114,
						Texture = 1,
					},
				},
				{
					Name = "Brown Loose",
					Value = {
						Drawable = 114,
						Texture = 0,
					},
				},
			},
			[11] = { -- Intimidation
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "White Mandible",
					Value = {
						Drawable = 112,
						Texture = 21,
					},
				},
				{
					Name = "Zebra Mandible",
					Value = {
						Drawable = 112,
						Texture = 20,
					},
				},
				{
					Name = "Yellow Mandible",
					Value = {
						Drawable = 112,
						Texture = 19,
					},
				},
				{
					Name = "Orange Striped Mandible",
					Value = {
						Drawable = 112,
						Texture = 18,
					},
				},
				{
					Name = "Moss Striped Mandible",
					Value = {
						Drawable = 112,
						Texture = 17,
					},
				},
				{
					Name = "Blue Striped Mandible",
					Value = {
						Drawable = 112,
						Texture = 16,
					},
				},
				{
					Name = "Light Woodland Mandible",
					Value = {
						Drawable = 112,
						Texture = 15,
					},
				},
				{
					Name = "Flecktarn Mandible",
					Value = {
						Drawable = 112,
						Texture = 14,
					},
				},
				{
					Name = "Brushstroke Mandible",
					Value = {
						Drawable = 112,
						Texture = 13,
					},
				},
				{
					Name = "Peach Camo Mandible",
					Value = {
						Drawable = 112,
						Texture = 12,
					},
				},
				{
					Name = "Cobble Mandible",
					Value = {
						Drawable = 112,
						Texture = 11,
					},
				},
				{
					Name = "Contrast Camo Mandible",
					Value = {
						Drawable = 112,
						Texture = 10,
					},
				},
				{
					Name = "Splinter Mandible",
					Value = {
						Drawable = 112,
						Texture = 9,
					},
				},
				{
					Name = "Aqua Camo Mandible",
					Value = {
						Drawable = 112,
						Texture = 8,
					},
				},
				{
					Name = "Gray Woodland Mandible",
					Value = {
						Drawable = 112,
						Texture = 7,
					},
				},
				{
					Name = "Crosshatch Mandible",
					Value = {
						Drawable = 112,
						Texture = 6,
					},
				},
				{
					Name = "Dark Woodland Mandible",
					Value = {
						Drawable = 112,
						Texture = 5,
					},
				},
				{
					Name = "Fall Mandible",
					Value = {
						Drawable = 112,
						Texture = 4,
					},
				},
				{
					Name = "Green Digital Mandible",
					Value = {
						Drawable = 112,
						Texture = 3,
					},
				},
				{
					Name = "Brown Digital Mandible",
					Value = {
						Drawable = 112,
						Texture = 2,
					},
				},
				{
					Name = "Blue Digital Mandible",
					Value = {
						Drawable = 112,
						Texture = 1,
					},
				},
				{
					Name = "Black Mandible",
					Value = {
						Drawable = 112,
						Texture = 0,
					},
				},
				{
					Name = "White Robo",
					Value = {
						Drawable = 110,
						Texture = 21,
					},
				},
				{
					Name = "Zebra Robo",
					Value = {
						Drawable = 110,
						Texture = 20,
					},
				},
				{
					Name = "Yellow Robo",
					Value = {
						Drawable = 110,
						Texture = 19,
					},
				},
				{
					Name = "Orange Striped Robo",
					Value = {
						Drawable = 110,
						Texture = 18,
					},
				},
				{
					Name = "Moss Striped Robo",
					Value = {
						Drawable = 110,
						Texture = 17,
					},
				},
				{
					Name = "Blue Striped Robo",
					Value = {
						Drawable = 110,
						Texture = 16,
					},
				},
				{
					Name = "Light Woodland Robo",
					Value = {
						Drawable = 110,
						Texture = 15,
					},
				},
				{
					Name = "Flecktarn Robo",
					Value = {
						Drawable = 110,
						Texture = 14,
					},
				},
				{
					Name = "Brushstroke Robo",
					Value = {
						Drawable = 110,
						Texture = 13,
					},
				},
				{
					Name = "Peach Camo Robo",
					Value = {
						Drawable = 110,
						Texture = 12,
					},
				},
				{
					Name = "Cobble Robo",
					Value = {
						Drawable = 110,
						Texture = 11,
					},
				},
				{
					Name = "Contrast Camo Robo",
					Value = {
						Drawable = 110,
						Texture = 10,
					},
				},
				{
					Name = "Splinter Robo",
					Value = {
						Drawable = 110,
						Texture = 9,
					},
				},
				{
					Name = "Aqua Camo Robo",
					Value = {
						Drawable = 110,
						Texture = 8,
					},
				},
				{
					Name = "Gray Woodland Robo",
					Value = {
						Drawable = 110,
						Texture = 7,
					},
				},
				{
					Name = "Crosshatch Robo",
					Value = {
						Drawable = 110,
						Texture = 6,
					},
				},
				{
					Name = "Dark Woodland Robo",
					Value = {
						Drawable = 110,
						Texture = 5,
					},
				},
				{
					Name = "Fall Robo",
					Value = {
						Drawable = 110,
						Texture = 4,
					},
				},
				{
					Name = "Green Digital Robo",
					Value = {
						Drawable = 110,
						Texture = 3,
					},
				},
				{
					Name = "Brown Digital Robo",
					Value = {
						Drawable = 110,
						Texture = 2,
					},
				},
				{
					Name = "Blue Digital Robo",
					Value = {
						Drawable = 110,
						Texture = 1,
					},
				},
				{
					Name = "Black Robo",
					Value = {
						Drawable = 110,
						Texture = 0,
					},
				},
				{
					Name = "Wooden Warrior",
					Value = {
						Drawable = 16,
						Texture = 8,
					},
				},
				{
					Name = "Lightning Warrior",
					Value = {
						Drawable = 16,
						Texture = 7,
					},
				},
				{
					Name = "Stone Warrior",
					Value = {
						Drawable = 16,
						Texture = 6,
					},
				},
				{
					Name = "Deadeye Warrior",
					Value = {
						Drawable = 16,
						Texture = 5,
					},
				},
				{
					Name = "Carbon Warrior",
					Value = {
						Drawable = 16,
						Texture = 4,
					},
				},
				{
					Name = "Neon Warrior",
					Value = {
						Drawable = 16,
						Texture = 3,
					},
				},
				{
					Name = "Molten Warrior",
					Value = {
						Drawable = 16,
						Texture = 2,
					},
				},
				{
					Name = "Circuit Warrior",
					Value = {
						Drawable = 16,
						Texture = 1,
					},
				},
				{
					Name = "Metal Warrior",
					Value = {
						Drawable = 16,
						Texture = 0,
					},
				},
				{
					Name = "Bear Hockey",
					Value = {
						Drawable = 14,
						Texture = 6,
					},
				},
				{
					Name = "Beast Hockey",
					Value = {
						Drawable = 14,
						Texture = 5,
					},
				},
				{
					Name = "Wolf Hockey",
					Value = {
						Drawable = 14,
						Texture = 4,
					},
				},
				{
					Name = "Hound Hockey",
					Value = {
						Drawable = 140,
						Texture = 3,
					},
				},
				{
					Name = "Bullet Hockey",
					Value = {
						Drawable = 14,
						Texture = 0,
					},
				},
				{
					Name = "White Hockey",
					Value = {
						Drawable = 4,
						Texture = 0,
					},
				},
				{
					Name = "Black Bloody Hocket",
					Value = {
						Drawable = 4,
						Texture = 2,
					},
				},
			},
			[12] = { -- Monsters
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Striped Skull",
					Value = {
						Drawable = 108,
						Texture = 23,
					},
				},
				{
					Name = "Terracotta Skull",
					Value = {
						Drawable = 108,
						Texture = 22,
					},
				},
				{
					Name = "Leather Solar-Eyed Skull",
					Value = {
						Drawable = 108,
						Texture = 21,
					},
				},
				{
					Name = "Orange Swirl-Eyed Skull",
					Value = {
						Drawable = 108,
						Texture = 20,
					},
				},
				{
					Name = "Mustard Painted Skull",
					Value = {
						Drawable = 108,
						Texture = 19,
					},
				},
				{
					Name = "Green Painted Skull",
					Value = {
						Drawable = 108,
						Texture = 18,
					},
				},
				{
					Name = "Pink Painted Skull",
					Value = {
						Drawable = 108,
						Texture = 17,
					},
				},
				{
					Name = "Blue Painted Skull",
					Value = {
						Drawable = 108,
						Texture = 16,
					},
				},
				{
					Name = "Tattooed Skull",
					Value = {
						Drawable = 108,
						Texture = 15,
					},
				},
				{
					Name = "Wide-Eyed Skull",
					Value = {
						Drawable = 108,
						Texture = 14,
					},
				},
				{
					Name = "Possessed Skull",
					Value = {
						Drawable = 108,
						Texture = 13,
					},
				},
				{
					Name = "Orange Open-Eyed Skull",
					Value = {
						Drawable = 108,
						Texture = 12,
					},
				},
				{
					Name = "Chocolate Leather Skull",
					Value = {
						Drawable = 108,
						Texture = 11,
					},
				},
				{
					Name = "Tan Leather Skull",
					Value = {
						Drawable = 108,
						Texture = 10,
					},
				},
				{
					Name = "Stained Skull",
					Value = {
						Drawable = 108,
						Texture = 9,
					},
				},
				{
					Name = "Inked Skull",
					Value = {
						Drawable = 108,
						Texture = 8,
					},
				},
				{
					Name = "Sand Skull",
					Value = {
						Drawable = 108,
						Texture = 7,
					},
				},
				{
					Name = "Moss Skull",
					Value = {
						Drawable = 108,
						Texture = 6,
					},
				},
				{
					Name = "Fleshy Skull",
					Value = {
						Drawable = 108,
						Texture = 5,
					},
				},
				{
					Name = "Fresh Skull",
					Value = {
						Drawable = 108,
						Texture = 4,
					},
				},
				{
					Name = "Venom Skull",
					Value = {
						Drawable = 108,
						Texture = 3,
					},
				},
				{
					Name = "Aged Skull",
					Value = {
						Drawable = 108,
						Texture = 2,
					},
				},
				{
					Name = "Weathered Skull",
					Value = {
						Drawable = 108,
						Texture = 1,
					},
				},
				{
					Name = "Clean Skull",
					Value = {
						Drawable = 108,
						Texture = 0,
					},
				},
				{
					Name = "Infernal Sea Beast",
					Value = {
						Drawable = 92,
						Texture = 5,
					},
				},
				{
					Name = "Deity Sea Beast",
					Value = {
						Drawable = 92,
						Texture = 4,
					},
				},
				{
					Name = "Otherworldly Sea Beast",
					Value = {
						Drawable = 92,
						Texture = 3,
					},
				},
				{
					Name = "Reptilian Sea Beast",
					Value = {
						Drawable = 92,
						Texture = 2,
					},
				},
				{
					Name = "Alien Sea Beast",
					Value = {
						Drawable = 92,
						Texture = 1,
					},
				},
				{
					Name = "Amphibian Sea Beast",
					Value = {
						Drawable = 92,
						Texture = 0,
					},
				},
				{
					Name = "Black Bearded Lucifer",
					Value = {
						Drawable = 72,
						Texture = 2,
					},
				},
				{
					Name = "Orange Bearded Lucifer",
					Value = {
						Drawable = 72,
						Texture = 1,
					},
				},
				{
					Name = "Red Bearded Lucifer",
					Value = {
						Drawable = 72,
						Texture = 0,
					},
				},
				{
					Name = "White Haggard Witch",
					Value = {
						Drawable = 71,
						Texture = 2,
					},
				},
				{
					Name = "Gray Haggard Witch",
					Value = {
						Drawable = 71,
						Texture = 1,
					},
				},
				{
					Name = "Yellow Haggard Witch",
					Value = {
						Drawable = 71,
						Texture = 0,
					},
				},
				{
					Name = "Red Hypnotic Alien",
					Value = {
						Drawable = 70,
						Texture = 2,
					},
				},
				{
					Name = "Green Hypnotic Alien",
					Value = {
						Drawable = 70,
						Texture = 1,
					},
				},
				{
					Name = "Blue Hypnotic Alien",
					Value = {
						Drawable = 70,
						Texture = 0,
					},
				},
				{
					Name = "Black Sack Slasher",
					Value = {
						Drawable = 69,
						Texture = 2,
					},
				},
				{
					Name = "Bloody Sack Slasher",
					Value = {
						Drawable = 69,
						Texture = 1,
					},
				},
				{
					Name = "Classic Sack Slasher",
					Value = {
						Drawable = 69,
						Texture = 0,
					},
				},
				{
					Name = "Black Classic Lucifer",
					Value = {
						Drawable = 68,
						Texture = 2,
					},
				},
				{
					Name = "Orange Classic Lucifer",
					Value = {
						Drawable = 68,
						Texture = 1,
					},
				},
				{
					Name = "Red Classic Lucifer",
					Value = {
						Drawable = 68,
						Texture = 0,
					},
				},
				{
					Name = "Scabby Sewer Creature",
					Value = {
						Drawable = 67,
						Texture = 2,
					},
				},
				{
					Name = "Rotten Sewer Creature",
					Value = {
						Drawable = 67,
						Texture = 1,
					},
				},
				{
					Name = "Dirty Sewer Creature",
					Value = {
						Drawable = 67,
						Texture = 0,
					},
				},
				{
					Name = "Purple Toxic Insect",
					Value = {
						Drawable = 66,
						Texture = 2,
					},
				},
				{
					Name = "Red Toxic Insect",
					Value = {
						Drawable = 66,
						Texture = 1,
					},
				},
				{
					Name = "Green Toxic Insect",
					Value = {
						Drawable = 66,
						Texture = 0,
					},
				},
				{
					Name = "Gray Lycanthrope",
					Value = {
						Drawable = 65,
						Texture = 2,
					},
				},
				{
					Name = "Dark Lycanthrope",
					Value = {
						Drawable = 65,
						Texture = 1,
					},
				},
				{
					Name = "Pale Lycanthrope",
					Value = {
						Drawable = 65,
						Texture = 0,
					},
				},
				{
					Name = "Cream Skull Burst",
					Value = {
						Drawable = 64,
						Texture = 2,
					},
				},
				{
					Name = "Red Skull Burst",
					Value = {
						Drawable = 64,
						Texture = 1,
					},
				},
				{
					Name = "White Skull Burst",
					Value = {
						Drawable = 64,
						Texture = 0,
					},
				},
				{
					Name = "Gray Flayed Demon",
					Value = {
						Drawable = 63,
						Texture = 2,
					},
				},
				{
					Name = "Green Flayed Demon",
					Value = {
						Drawable = 63,
						Texture = 1,
					},
				},
				{
					Name = "Red Flayed Demon",
					Value = {
						Drawable = 63,
						Texture = 0,
					},
				},
				{
					Name = "Black Scalded Psycho",
					Value = {
						Drawable = 62,
						Texture = 2,
					},
				},
				{
					Name = "Bloody Scalded Psycho",
					Value = {
						Drawable = 62,
						Texture = 1,
					},
				},
				{
					Name = "White Scalded Psycho",
					Value = {
						Drawable = 62,
						Texture = 0,
					},
				},
				{
					Name = "Rotten Butler",
					Value = {
						Drawable = 61,
						Texture = 2,
					},
				},
				{
					Name = "Dead Butler",
					Value = {
						Drawable = 61,
						Texture = 1,
					},
				},
				{
					Name = "Creepy Butler",
					Value = {
						Drawable = 61,
						Texture = 0,
					},
				},
				{
					Name = "Nasty Watermelon",
					Value = {
						Drawable = 60,
						Texture = 2,
					},
				},
				{
					Name = "Rotten Pumpkin",
					Value = {
						Drawable = 60,
						Texture = 1,
					},
				},
				{
					Name = "Evil Pumpkin",
					Value = {
						Drawable = 60,
						Texture = 0,
					},
				},
				{
					Name = "Gray Frank",
					Value = {
						Drawable = 42,
						Texture = 1,
					},
				},
				{
					Name = "Pale Frank",
					Value = {
						Drawable = 42,
						Texture = 0,
					},
				},
				{
					Name = "Blue Vampyr",
					Value = {
						Drawable = 41,
						Texture = 1,
					},
				},
				{
					Name = "White Vampyr",
					Value = {
						Drawable = 41,
						Texture = 0,
					},
				},
				{
					Name = "Green Mummy",
					Value = {
						Drawable = 40,
						Texture = 1,
					},
				},
				{
					Name = "White Mummy",
					Value = {
						Drawable = 40,
						Texture = 0,
					},
				},
				{
					Name = "Brown Infected",
					Value = {
						Drawable = 39,
						Texture = 1,
					},
				},
				{
					Name = "Pink Infected",
					Value = {
						Drawable = 39,
						Texture = 0,
					},
				},
				{
					Name = "Green Skeletal",
					Value = {
						Drawable = 29,
						Texture = 4,
					},
				},
				{
					Name = "Tan Skeletal",
					Value = {
						Drawable = 29,
						Texture = 3,
					},
				},
				{
					Name = "Charcoal Skeletal",
					Value = {
						Drawable = 29,
						Texture = 2,
					},
				},
				{
					Name = "Gray Skeletal",
					Value = {
						Drawable = 29,
						Texture = 1,
					},
				},
				{
					Name = "Black Skeletal",
					Value = {
						Drawable = 29,
						Texture = 0,
					},
				},
				{
					Name = "Pale Stitched Hockey",
					Value = {
						Drawable = 15,
						Texture = 2,
					},
				},
				{
					Name = "Stitched Hockey",
					Value = {
						Drawable = 15,
						Texture = 1,
					},
				},
				{
					Name = "Skull Hockey",
					Value = {
						Drawable = 15,
						Texture = 0,
					},
				},
				{
					Name = "Electric Skull Hockey",
					Value = {
						Drawable = 14,
						Texture = 15,
					},
				},
				{
					Name = "Nightmare Skull Hockey",
					Value = {
						Drawable = 14,
						Texture = 14,
					},
				},
				{
					Name = "Flame Skull Hockey",
					Value = {
						Drawable = 14,
						Texture = 13,
					},
				},
				{
					Name = "Rotten Zombie Hockey",
					Value = {
						Drawable = 14,
						Texture = 12,
					},
				},
				{
					Name = "Vile Zombie Hockey",
					Value = {
						Drawable = 14,
						Texture = 11,
					},
				},
				{
					Name = "Silver Skull",
					Value = {
						Drawable = 2,
						Texture = 0,
					},
				},
				{
					Name = "Gray Skull",
					Value = {
						Drawable = 2,
						Texture = 2,
					},
				},
				{
					Name = "Black Skull",
					Value = {
						Drawable = 2,
						Texture = 3,
					},
				},
				{
					Name = "Bone Skull",
					Value = {
						Drawable = 2,
						Texture = 1,
					},
				},
				{
					Name = "Green Monster",
					Value = {
						Drawable = 7,
						Texture = 0,
					},
				},
				{
					Name = "Red Monster",
					Value = {
						Drawable = 7,
						Texture = 1,
					},
				},
				{
					Name = "Black Monster",
					Value = {
						Drawable = 7,
						Texture = 2,
					},
				},
				{
					Name = "White Monster",
					Value = {
						Drawable = 7,
						Texture = 3,
					},
				},
			},
			[13] = { -- Paper Bags
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Blackout Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 25,
					},
				},
				{
					Name = "Love Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 24,
					},
				},
				{
					Name = "Modernist Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 23,
					},
				},
				{
					Name = "Sticker Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 22,
					},
				},
				{
					Name = "Dapper Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 21,
					},
				},
				{
					Name = "The Bird Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 20,
					},
				},
				{
					Name = "Puzzle Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 19,
					},
				},
				{
					Name = "Help Me Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 18,
					},
				},
				{
					Name = "Alien Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 17,
					},
				},
				{
					Name = "Pink Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 16,
					},
				},
				{
					Name = "Dog Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 15,
					},
				},
				{
					Name = "Skull Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 14,
					},
				},
				{
					Name = "Zigzag Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 13,
					},
				},
				{
					Name = "Fury Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 12,
					},
				},
				{
					Name = "Monster Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 11,
					},
				},
				{
					Name = "Cop Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 10,
					},
				},
				{
					Name = "Diabolic Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 9,
					},
				},
				{
					Name = "Kill Me Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 8,
					},
				},
				{
					Name = "Burger Shot Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 7,
					},
				},
				{
					Name = "Shy Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 6,
					},
				},
				{
					Name = "Mouth Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 5,
					},
				},
				{
					Name = "Fat Cat Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 4,
					},
				},
				{
					Name = "Happy Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 3,
					},
				},
				{
					Name = "Sad Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 2,
					},
				},
				{
					Name = "Manic Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 1,
					},
				},
				{
					Name = "Up-n-Atom Paper Bag",
					Value = {
						Drawable = 49,
						Texture = 0,
					},
				},
			},
			[14] = { -- Ski Masks
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Camo Bigness Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 21,
					},
				},
				{
					Name = "Bold Abstract Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 20,
					},
				},
				{
					Name = "Black & Red Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 19,
					},
				},
				{
					Name = "Black Stars & Stripes Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 18,
					},
				},
				{
					Name = "SA Republic Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 17,
					},
				},
				{
					Name = "White Skull Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 12,
					},
				},
				{
					Name = "Black Skull Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 11,
					},
				},
				{
					Name = "Stars & Stripes Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 10,
					},
				},
				{
					Name = "Mustard Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 9,
					},
				},
				{
					Name = "Blue Bigness Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 8,
					},
				},
				{
					Name = "Vibrant Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 7,
					},
				},
				{
					Name = "Orange & Red Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 6,
					},
				},
				{
					Name = "Gray Bigness Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 5,
					},
				},
				{
					Name = "Red Stripe Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 4,
					},
				},
				{
					Name = "Tropical Xero Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 3,
					},
				},
				{
					Name = "Lime Xero Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 2,
					},
				},
				{
					Name = "Multicolor Leaves Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 1,
					},
				},
				{
					Name = "Skate Tight Ski",
					Value = {
						Drawable = 113,
						Texture = 0,
					},
				},
				{
					Name = "Skull Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 25,
					},
				},
				{
					Name = "Olive Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 24,
					},
				},
				{
					Name = "Sand Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 19,
					},
				},
				{
					Name = "Moss Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 18,
					},
				},
				{
					Name = "Light Woodland Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 17,
					},
				},
				{
					Name = "Flecktarn Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 16,
					},
				},
				{
					Name = "Brushstroke Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 15,
					},
				},
				{
					Name = "Peach Camo Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 14,
					},
				},
				{
					Name = "Cobble Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 13,
					},
				},
				{
					Name = "Contrast Camo Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 12,
					},
				},
				{
					Name = "Splinter Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 11,
					},
				},
				{
					Name = "Aqua Camo Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 10,
					},
				},
				{
					Name = "Gray Woodland Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 9,
					},
				},
				{
					Name = "Moss Digital Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 8,
					},
				},
				{
					Name = "Crosshatch Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 7,
					},
				},
				{
					Name = "Dark Woodland Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 6,
					},
				},
				{
					Name = "Fall Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 5,
					},
				},
				{
					Name = "Peach Digital Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 4,
					},
				},
				{
					Name = "Gray Digital Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 3,
					},
				},
				{
					Name = "Green Digital Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 2,
					},
				},
				{
					Name = "Brown Digital Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 1,
					},
				},
				{
					Name = "Blue Digital Tactical Ski",
					Value = {
						Drawable = 104,
						Texture = 0,
					},
				},
				{
					Name = "Blue Camo Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 15,
					},
				},
				{
					Name = "Gray Leopard Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 14,
					},
				},
				{
					Name = "Gray Abstract Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 13,
					},
				},
				{
					Name = "Pale Abstract Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 12,
					},
				},
				{
					Name = "Bold Abstract Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 11,
					},
				},
				{
					Name = "Zebra Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 10,
					},
				},
				{
					Name = "Black Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 9,
					},
				},
				{
					Name = "Geo Camo Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 8,
					},
				},
				{
					Name = "Gray Camo Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 7,
					},
				},
				{
					Name = "Camo Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 6,
					},
				},
				{
					Name = "Gray Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 5,
					},
				},
				{
					Name = "Fall Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 4,
					},
				},
				{
					Name = "Yellow Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 3,
					},
				},
				{
					Name = "Magenta Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 2,
					},
				},
				{
					Name = "Blue Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 1,
					},
				},
				{
					Name = "Orange Bigness Face",
					Value = {
						Drawable = 101,
						Texture = 0,
					},
				},
				{
					Name = "Khaki Toggle Ski",
					Value = {
						Drawable = 55,
						Texture = 1,
					},
				},
				{
					Name = "Charcoal Toggle Ski",
					Value = {
						Drawable = 55,
						Texture = 0,
					},
				},
				{
					Name = "Skull Hooded Ski",
					Value = {
						Drawable = 53,
						Texture = 8,
					},
				},
				{
					Name = "Urban Hooded Ski",
					Value = {
						Drawable = 53,
						Texture = 7,
					},
				},
				{
					Name = "Forest Hooded Ski",
					Value = {
						Drawable = 53,
						Texture = 6,
					},
				},
				{
					Name = "Charcoal Hooded Ski",
					Value = {
						Drawable = 53,
						Texture = 5,
					},
				},
				{
					Name = "Khaki Hooded Ski",
					Value = {
						Drawable = 53,
						Texture = 4,
					},
				},
				{
					Name = "Green Hooded Ski",
					Value = {
						Drawable = 53,
						Texture = 3,
					},
				},
				{
					Name = "White Hooded Ski",
					Value = {
						Drawable = 53,
						Texture = 2,
					},
				},
				{
					Name = "Gray Hooded Ski",
					Value = {
						Drawable = 53,
						Texture = 1,
					},
				},
				{
					Name = "Black Hooded Ski",
					Value = {
						Drawable = 53,
						Texture = 0,
					},
				},
				{
					Name = "Skull Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 10,
					},
				},
				{
					Name = "Yellow Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 9,
					},
				},
				{
					Name = "Blue Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 8,
					},
				},
				{
					Name = "Urban Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 7,
					},
				},
				{
					Name = "Forest Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 6,
					},
				},
				{
					Name = "Charcoal Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 5,
					},
				},
				{
					Name = "Khaki Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 4,
					},
				},
				{
					Name = "Green Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 3,
					},
				},
				{
					Name = "White Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 2,
					},
				},
				{
					Name = "Gray Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 1,
					},
				},
				{
					Name = "Black Tight Ski",
					Value = {
						Drawable = 52,
						Texture = 0,
					},
				},
			},
			[15] = { -- Sports
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Crossed Rampage Hockey",
					Value = {
						Drawable = 15,
						Texture = 3,
					},
				},
				{
					Name = "Royal Hockey",
					Value = {
						Drawable = 14,
						Texture = 9,
					},
				},
				{
					Name = "Striped Rampage Hockey",
					Value = {
						Drawable = 14,
						Texture = 8,
					},
				},
				{
					Name = "Dust Devils Hockey",
					Value = {
						Drawable = 14,
						Texture = 7,
					},
				},
				{
					Name = "Red Hockey",
					Value = {
						Drawable = 4,
						Texture = 1,
					},
				},
				{
					Name = "Dust Devils Hockey",
					Value = {
						Drawable = 4,
						Texture = 3,
					},
				},
			},
			[16] = { -- Tactical
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Skull Night Vision",
					Value = {
						Drawable = 132,
						Texture = 21,
					},
				},
				{
					Name = "White Camo Night Vision",
					Value = {
						Drawable = 132,
						Texture = 20,
					},
				},
				{
					Name = "Moss Striped Night Vision",
					Value = {
						Drawable = 132,
						Texture = 19,
					},
				},
				{
					Name = "Cobble Night Vision",
					Value = {
						Drawable = 132,
						Texture = 18,
					},
				},
				{
					Name = "Contrast Camo Night Vision",
					Value = {
						Drawable = 132,
						Texture = 17,
					},
				},
				{
					Name = "Crosshatch Night Vision",
					Value = {
						Drawable = 132,
						Texture = 16,
					},
				},
				{
					Name = "Gray Woodland Night Vision",
					Value = {
						Drawable = 132,
						Texture = 15,
					},
				},
				{
					Name = "Woodland Night Vision",
					Value = {
						Drawable = 132,
						Texture = 14,
					},
				},
				{
					Name = "Brown Digital Night Vision",
					Value = {
						Drawable = 132,
						Texture = 13,
					},
				},
				{
					Name = "Dazzle Night Vision",
					Value = {
						Drawable = 132,
						Texture = 12,
					},
				},
				{
					Name = "Splinter Night Vision",
					Value = {
						Drawable = 132,
						Texture = 11,
					},
				},
				{
					Name = "Green Digital Night Vision",
					Value = {
						Drawable = 132,
						Texture = 10,
					},
				},
				{
					Name = "White Digital Night Vision",
					Value = {
						Drawable = 132,
						Texture = 9,
					},
				},
				{
					Name = "Gray Camo Night Vision",
					Value = {
						Drawable = 132,
						Texture = 8,
					},
				},
				{
					Name = "Aqua Camo Night Vision",
					Value = {
						Drawable = 132,
						Texture = 7,
					},
				},
				{
					Name = "Brown Camo Night Vision",
					Value = {
						Drawable = 132,
						Texture = 6,
					},
				},
				{
					Name = "Moss Night Vision",
					Value = {
						Drawable = 132,
						Texture = 5,
					},
				},
				{
					Name = "Tan Night Vision",
					Value = {
						Drawable = 132,
						Texture = 4,
					},
				},
				{
					Name = "Blue Night Vision",
					Value = {
						Drawable = 132,
						Texture = 3,
					},
				},
				{
					Name = "Gray Night Vision",
					Value = {
						Drawable = 132,
						Texture = 2,
					},
				},
				{
					Name = "White Night Vision",
					Value = {
						Drawable = 132,
						Texture = 1,
					},
				},
				{
					Name = "Black Night Vision",
					Value = {
						Drawable = 132,
						Texture = 0,
					},
				},
				{
					Name = "Opera Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 13,
					},
				},
				{
					Name = "Striped Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 12,
					},
				},
				{
					Name = "Ornate Skull Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 11,
					},
				},
				{
					Name = "LSPD Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 10,
					},
				},
				{
					Name = "Electric Skull Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 9,
					},
				},
				{
					Name = "Dark Woodland Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 8,
					},
				},
				{
					Name = "Gray Woodland Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 7,
					},
				},
				{
					Name = "Mono Splinter Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 6,
					},
				},
				{
					Name = "Splinter Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 5,
					},
				},
				{
					Name = "Aqua Camo Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 4,
					},
				},
				{
					Name = "Tan Digital Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 3,
					},
				},
				{
					Name = "Scale Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 2,
					},
				},
				{
					Name = "Carbon Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 1,
					},
				},
				{
					Name = "Black Spec Ops",
					Value = {
						Drawable = 126,
						Texture = 0,
					},
				},
				{
					Name = "Fall Ballistic",
					Value = {
						Drawable = 125,
						Texture = 25,
					},
				},
				{
					Name = "Brown Digital Ballistic",
					Value = {
						Drawable = 125,
						Texture = 24,
					},
				},
				{
					Name = "Red Ballistic",
					Value = {
						Drawable = 125,
						Texture = 23,
					},
				},
				{
					Name = "Off White & Red Ballistic",
					Value = {
						Drawable = 125,
						Texture = 22,
					},
				},
				{
					Name = "Black Stripe Ballistic",
					Value = {
						Drawable = 125,
						Texture = 21,
					},
				},
				{
					Name = "Red Stripe Ballistic",
					Value = {
						Drawable = 125,
						Texture = 20,
					},
				},
				{
					Name = "White & Black Ballistic",
					Value = {
						Drawable = 125,
						Texture = 19,
					},
				},
				{
					Name = "Orange & Black Ballistic",
					Value = {
						Drawable = 125,
						Texture = 18,
					},
				},
				{
					Name = "Yellow & Black Ballistic",
					Value = {
						Drawable = 125,
						Texture = 17,
					},
				},
				{
					Name = "Blue & Black Ballistic",
					Value = {
						Drawable = 125,
						Texture = 16,
					},
				},
				{
					Name = "Red & Black Ballistic",
					Value = {
						Drawable = 125,
						Texture = 15,
					},
				},
				{
					Name = "Splinter Ballistic",
					Value = {
						Drawable = 125,
						Texture = 14,
					},
				},
				{
					Name = "Flecktarn Ballistic",
					Value = {
						Drawable = 125,
						Texture = 13,
					},
				},
				{
					Name = "Cranial Ballistic",
					Value = {
						Drawable = 125,
						Texture = 12,
					},
				},
				{
					Name = "Sand Carbon Ballistic",
					Value = {
						Drawable = 125,
						Texture = 11,
					},
				},
				{
					Name = "Black Carbon Ballistic",
					Value = {
						Drawable = 125,
						Texture = 10,
					},
				},
				{
					Name = "Red Googled Ballistic",
					Value = {
						Drawable = 125,
						Texture = 9,
					},
				},
				{
					Name = "Sand Googled Ballistic",
					Value = {
						Drawable = 125,
						Texture = 8,
					},
				},
				{
					Name = "Sand Mono Ballistic",
					Value = {
						Drawable = 125,
						Texture = 3,
					},
				},
				{
					Name = "White Mono Ballistic",
					Value = {
						Drawable = 125,
						Texture = 2,
					},
				},
				{
					Name = "Gray Mono Ballistic",
					Value = {
						Drawable = 125,
						Texture = 1,
					},
				},
				{
					Name = "Black Mono Ballistic",
					Value = {
						Drawable = 125,
						Texture = 0,
					},
				},
				{
					Name = "White Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 25,
					},
				},
				{
					Name = "Red Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 24,
					},
				},
				{
					Name = "Sand Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 19,
					},
				},
				{
					Name = "Moss Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 18,
					},
				},
				{
					Name = "Light Woodland Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 17,
					},
				},
				{
					Name = "Flecktarn Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 16,
					},
				},
				{
					Name = "Brushstroke Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 15,
					},
				},
				{
					Name = "Peach Camo Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 14,
					},
				},
				{
					Name = "Cobble Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 13,
					},
				},
				{
					Name = "Contrast Camo Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 12,
					},
				},
				{
					Name = "Splinter Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 11,
					},
				},
				{
					Name = "Aqua Camo Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 10,
					},
				},
				{
					Name = "Gray Woodland Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 9,
					},
				},
				{
					Name = "Moss Digital Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 8,
					},
				},
				{
					Name = "Crosshatch Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 7,
					},
				},
				{
					Name = "Dark Woodland Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 6,
					},
				},
				{
					Name = "Fall Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 5,
					},
				},
				{
					Name = "Peach Digital Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 4,
					},
				},
				{
					Name = "Gray Digital Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 3,
					},
				},
				{
					Name = "Green Digital Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 2,
					},
				},
				{
					Name = "Brown Digital Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 1,
					},
				},
				{
					Name = "Blue Digital Snake Skull",
					Value = {
						Drawable = 106,
						Texture = 0,
					},
				},
				{
					Name = "Forest Combat Mask",
					Value = {
						Drawable = 89,
						Texture = 4,
					},
				},
				{
					Name = "Tan Combat Mask",
					Value = {
						Drawable = 89,
						Texture = 3,
					},
				},
				{
					Name = "Charcoal Combat Mask",
					Value = {
						Drawable = 89,
						Texture = 2,
					},
				},
				{
					Name = "Gray Combat Mask",
					Value = {
						Drawable = 89,
						Texture = 1,
					},
				},
				{
					Name = "Black Combat Mask",
					Value = {
						Drawable = 89,
						Texture = 0,
					},
				},
			},
			[17] = { -- Valentine
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Cupid",
					Value = {
						Drawable = 13,
						Texture = 0,
					},
				},
				{
					Name = "Black & Gold Masquerade",
					Value = {
						Drawable = 12,
						Texture = 2,
					},
				},
				{
					Name = "Silver Masquerade",
					Value = {
						Drawable = 12,
						Texture = 1,
					},
				},
				{
					Name = "Bronze Masquerade",
					Value = {
						Drawable = 12,
						Texture = 0,
					},
				},
				{
					Name = "Black Masquerade",
					Value = {
						Drawable = 11,
						Texture = 2,
					},
				},
				{
					Name = "Red Masquerade",
					Value = {
						Drawable = 11,
						Texture = 1,
					},
				},
				{
					Name = "White Masquerade",
					Value = {
						Drawable = 11,
						Texture = 0,
					},
				},
			},
			[18] = { -- Zombie
				{
					Name = "No Mask",
					Value = {
						Drawable = 0,
						Texture = 0,
					},
				},
				{
					Name = "Moss Camo Putrefied Zombie",
					Value = {
						Drawable = 103,
						Texture = 25,
					},
				},
				{
					Name = "Woodland Putrefied Zombie",
					Value = {
						Drawable = 103,
						Texture = 24,
					},
				},
				{
					Name = "Green Putrefied Zombie",
					Value = {
						Drawable = 103,
						Texture = 23,
					},
				},
				{
					Name = "Stone Putrefied Zombie",
					Value = {
						Drawable = 103,
						Texture = 22,
					},
				},
				{
					Name = "Slate Putrefied Zombie",
					Value = {
						Drawable = 103,
						Texture = 21,
					},
				},
				{
					Name = "Black Putrefied Zombie",
					Value = {
						Drawable = 103,
						Texture = 20,
					},
				},
				{
					Name = "Sand Zombie",
					Value = {
						Drawable = 103,
						Texture = 19,
					},
				},
				{
					Name = "Moss Zombie",
					Value = {
						Drawable = 103,
						Texture = 18,
					},
				},
				{
					Name = "Light Woodland Zombie",
					Value = {
						Drawable = 103,
						Texture = 17,
					},
				},
				{
					Name = "Flecktarn Zombie",
					Value = {
						Drawable = 103,
						Texture = 16,
					},
				},
				{
					Name = "Brushstroke Zombie",
					Value = {
						Drawable = 103,
						Texture = 15,
					},
				},
				{
					Name = "Peach Camo Zombie",
					Value = {
						Drawable = 103,
						Texture = 14,
					},
				},
				{
					Name = "Cobble Zombie",
					Value = {
						Drawable = 103,
						Texture = 13,
					},
				},
				{
					Name = "Contrast Camo Zombie",
					Value = {
						Drawable = 103,
						Texture = 12,
					},
				},
				{
					Name = "Splinter Zombie",
					Value = {
						Drawable = 103,
						Texture = 11,
					},
				},
				{
					Name = "Aqua Camo Zombie",
					Value = {
						Drawable = 103,
						Texture = 10,
					},
				},
				{
					Name = "Gray Woodland Zombie",
					Value = {
						Drawable = 103,
						Texture = 9,
					},
				},
				{
					Name = "Moss Digital Zombie",
					Value = {
						Drawable = 103,
						Texture = 8,
					},
				},
				{
					Name = "Crosshatch Zombie",
					Value = {
						Drawable = 103,
						Texture = 7,
					},
				},
				{
					Name = "Dark Woodland Zombie",
					Value = {
						Drawable = 103,
						Texture = 6,
					},
				},
				{
					Name = "Fall Zombie",
					Value = {
						Drawable = 103,
						Texture = 5,
					},
				},
				{
					Name = "Peach Digital Zombie",
					Value = {
						Drawable = 103,
						Texture = 4,
					},
				},
				{
					Name = "Gray Digital Zombie",
					Value = {
						Drawable = 103,
						Texture = 3,
					},
				},
				{
					Name = "Green Digital Zombie",
					Value = {
						Drawable = 103,
						Texture = 2,
					},
				},
				{
					Name = "Brown Digital Zombie",
					Value = {
						Drawable = 103,
						Texture = 1,
					},
				},
				{
					Name = "Blue Digital Zombie",
					Value = {
						Drawable = 103,
						Texture = 1,
					},
				},
			},
		},
	},
	Tattoos = {
		Categories = {
			"Torso - Back",
			"Torso - Chest",
			"Torso - Stomach",
			"Head",
			"Left Arm",
			"Right Arm",
			"Left Leg",
			"Right Leg",
		},
		Options = {
			Male = {
				[1] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_005", Name = "TAT_X2_005"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_006", Name = "TAT_X2_006"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_011", Name = "TAT_X2_011"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_015", Name = "TAT_X2_015"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_009_M", Name = "TAT_S1_009"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_010_M", Name = "TAT_S1_010"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_014_M", Name = "TAT_S1_014"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_021_M", Name = "TAT_S1_021"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_006_M", Name = "TAT_LX_006"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_024_M", Name = "TAT_LX_024"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_001_M", Name = "TAT_AR_001"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_002_M", Name = "TAT_AR_002"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_004_M", Name = "TAT_AR_004"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_005_M", Name = "TAT_AR_005"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_007_M", Name = "TAT_AR_007"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_006_M", Name = "TAT_BI_006"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_008_M", Name = "TAT_BI_008"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_011_M", Name = "TAT_BI_011"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_017_M", Name = "TAT_BI_017"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_021_M", Name = "TAT_BI_021"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_030_M", Name = "TAT_BI_030"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_043_M", Name = "TAT_BI_043"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_002_M", Name = "TAT_H27_002"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_005_M", Name = "TAT_H27_005"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_009_M", Name = "TAT_H27_009"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_010_M", Name = "TAT_H27_010"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_011_M", Name = "TAT_H27_011"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_015_M", Name = "TAT_H27_015"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_016_M", Name = "TAT_H27_016"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_021_M", Name = "TAT_H27_021"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_022_M", Name = "TAT_H27_022"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_024_M", Name = "TAT_H27_024"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_027_M", Name = "TAT_H27_027"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_000_M", Name = "TAT_GR_000"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_001_M", Name = "TAT_GR_001"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_009_M", Name = "TAT_GR_009"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_013_M", Name = "TAT_GR_013"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_014_M", Name = "TAT_GR_014"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_018_M", Name = "TAT_GR_018"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_019_M", Name = "TAT_GR_019"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_022_M", Name = "TAT_GR_022"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_000_M", Name = "TAT_IE_000"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_001_M", Name = "TAT_IE_001"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_002_M", Name = "TAT_IE_002"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_009_M", Name = "TAT_IE_009"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_010_M", Name = "TAT_IE_010"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_011_M", Name = "TAT_IE_011"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_000_M", Name = "TAT_S2_000"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_008_M", Name = "TAT_S2_008"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_031_M", Name = "TAT_S2_031"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_032_M", Name = "TAT_S2_032"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_022_M", Name = "TAT_L2_022"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_029_M", Name = "TAT_L2_029"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_003_M", Name = "TAT_SM_003"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_006_M", Name = "TAT_SM_006"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_009_M", Name = "TAT_SM_009"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_013_M", Name = "TAT_SM_013"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_016_M", Name = "TAT_SM_016"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_017_M", Name = "TAT_SM_017"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_018_M", Name = "TAT_SM_018"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_022_M", Name = "TAT_SM_022"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_024_M", Name = "TAT_SM_024"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_025_M", Name = "TAT_SM_025"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_024_M", Name = "TAT_ST_024"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_026_M", Name = "TAT_ST_026"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_029_M", Name = "TAT_ST_029"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_030_M", Name = "TAT_ST_030"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_034_M", Name = "TAT_ST_034"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_037_M", Name = "TAT_ST_037"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_040_M", Name = "TAT_ST_040"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_041_M", Name = "TAT_ST_041"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_046_M", Name = "TAT_ST_046"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_048_M", Name = "TAT_ST_048"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_000", Name = "TAT_HP_000"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_024", Name = "TAT_HP_024"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_025", Name = "TAT_HP_025"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_030", Name = "TAT_HP_030"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_031", Name = "TAT_HP_031"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_032", Name = "TAT_HP_032"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_041", Name = "TAT_HP_041"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_046", Name = "TAT_HP_046"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_Back_000", Name = "TAT_BUS_000"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_Back_000", Name = "TAT_BB_018"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_005", Name = "TAT_FM_013"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_008", Name = "TAT_FM_016"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_014", Name = "TAT_FM_022"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_016", Name = "TAT_FM_024"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_017", Name = "TAT_FM_025"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_018", Name = "TAT_FM_026"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_019", Name = "TAT_FM_027"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_009", Name = "TAT_FM_213"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_011", Name = "TAT_FM_214"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_013", Name = "TAT_FM_215"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_016", Name = "TAT_FM_216"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_019", Name = "TAT_FM_217"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_020", Name = "TAT_FM_221"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_030", Name = "TAT_FM_231"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_045", Name = "TAT_FM_246"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_046", Name = "TAT_TRV_32"},
				},
				[2] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_009", Name = "TAT_X2_009"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_016", Name = "TAT_X2_016"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_017", Name = "TAT_X2_017"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_018", Name = "TAT_X2_018"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_019", Name = "TAT_X2_019"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_002_M", Name = "TAT_S1_002"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_013_M", Name = "TAT_S1_013"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_026_M", Name = "TAT_S1_026"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_007_M", Name = "TAT_LX_007"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_008_M", Name = "TAT_LX_008"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_014_M", Name = "TAT_LX_014"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_015_M", Name = "TAT_LX_015"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_000_M", Name = "TAT_AR_000"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_000_M", Name = "TAT_BI_000"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_001_M", Name = "TAT_BI_001"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_005_M", Name = "TAT_BI_005"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_013_M", Name = "TAT_BI_013"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_018_M", Name = "TAT_BI_018"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_019_M", Name = "TAT_BI_019"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_023_M", Name = "TAT_BI_023"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_026_M", Name = "TAT_BI_026"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_029_M", Name = "TAT_BI_029"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_032_M", Name = "TAT_BI_032"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_034_M", Name = "TAT_BI_034"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_041_M", Name = "TAT_BI_041"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_050_M", Name = "TAT_BI_050"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_058_M", Name = "TAT_BI_058"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_059_M", Name = "TAT_BI_059"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_060_M", Name = "TAT_BI_060"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_000_M", Name = "TAT_H27_000"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_003_M", Name = "TAT_H27_003"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_019_M", Name = "TAT_H27_019"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_020_M", Name = "TAT_H27_020"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_026_M", Name = "TAT_H27_026"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_012_M", Name = "TAT_GR_012"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_017_M", Name = "TAT_GR_017"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_020_M", Name = "TAT_GR_020"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_028_M", Name = "TAT_GR_028"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_012_M", Name = "TAT_S2_012"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_019_M", Name = "TAT_S2_019"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_002_M", Name = "TAT_L2_002"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_012_M", Name = "TAT_L2_012"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_025_M", Name = "TAT_L2_025"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_027_M", Name = "TAT_L2_027"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_000_M", Name = "TAT_SM_000"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_007_M", Name = "TAT_SM_007"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_019_M", Name = "TAT_SM_019"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_021_M", Name = "TAT_SM_021"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_011_M", Name = "TAT_ST_011"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_018_M", Name = "TAT_ST_018"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_019_M", Name = "TAT_ST_019"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_027_M", Name = "TAT_ST_027"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_033_M", Name = "TAT_ST_033"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_044_M", Name = "TAT_ST_044"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_002", Name = "TAT_HP_002"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_006", Name = "TAT_HP_006"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_013", Name = "TAT_HP_013"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_033", Name = "TAT_HP_033"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_047", Name = "TAT_HP_047"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_Chest_000", Name = "TAT_BUS_001"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_Chest_001", Name = "TAT_BUS_002"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_Chest_000", Name = "TAT_BB_019"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_Chest_001", Name = "TAT_BB_020"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_003", Name = "TAT_FM_011"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_011", Name = "TAT_FM_019"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_012", Name = "TAT_FM_020"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_013", Name = "TAT_FM_021"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_010", Name = "TAT_FM_218"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_024", Name = "TAT_FM_225"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_025", Name = "TAT_FM_226"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_034", Name = "TAT_FM_235"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_044", Name = "TAT_FM_245"},
				},
				[3] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_013", Name = "TAT_X2_013"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_028", Name = "TAT_X2_028"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_004_M", Name = "TAT_S1_004"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_003_M", Name = "TAT_LX_003"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_006_M", Name = "TAT_AR_006"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_003_M", Name = "TAT_BI_003"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_010_M", Name = "TAT_BI_010"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_031_M", Name = "TAT_BI_031"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_039_M", Name = "TAT_BI_039"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_052_M", Name = "TAT_BI_052"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_008_M", Name = "TAT_H27_008"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_010_M", Name = "TAT_GR_010"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_029_M", Name = "TAT_GR_029"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_011_M", Name = "TAT_S2_011"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_016_M", Name = "TAT_S2_016"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_002_M", Name = "TAT_SM_002"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_010_M", Name = "TAT_SM_010"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_015_M", Name = "TAT_SM_015"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_012_M", Name = "TAT_ST_012"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_014_M", Name = "TAT_ST_014"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_029", Name = "TAT_HP_029"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_035", Name = "TAT_HP_035"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_Stomach_000", Name = "TAT_BUS_011"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_Stom_000", Name = "TAT_BB_023"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_Stom_001", Name = "TAT_BB_032"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_004", Name = "TAT_FM_012"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_004", Name = "TAT_FM_219"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_012", Name = "TAT_FM_220"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_029", Name = "TAT_FM_230"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_036", Name = "TAT_FM_237"},
				},
				[4] = {
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_012_M", Name = "TAT_SM_012"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_011_M", Name = "TAT_SM_011"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_003_M", Name = "TAT_GR_003"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_051_M", Name = "TAT_BI_051"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_038_M", Name = "TAT_BI_038"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_009_M", Name = "TAT_BI_009"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_042_M", Name = "TAT_ST_042"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_017_M", Name = "TAT_ST_017"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_006_M", Name = "TAT_ST_006"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_004_M", Name = "TAT_ST_004"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_000_M", Name = "TAT_ST_000"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_007", Name = "TAT_X2_007"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_024", Name = "TAT_X2_024"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_025", Name = "TAT_X2_025"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_029", Name = "TAT_X2_029"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_021", Name = "TAT_HP_021"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_005", Name = "TAT_HP_005"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_Neck_000", Name = "TAT_BUS_005"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_Neck_001", Name = "TAT_BUS_006"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_Neck_002", Name = "TAT_BUS_007"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_Neck_003", Name = "TAT_BUS_008"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_Head_000", Name = "TAT_BB_021"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_Head_001", Name = "TAT_BB_022"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_Head_002", Name = "TAT_BB_031"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_000", Name = "TAT_FM_008"},
				},
				[5] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_000", Name = "TAT_X2_000"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_010", Name = "TAT_X2_010"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_012", Name = "TAT_X2_012"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_020", Name = "TAT_X2_020"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_021", Name = "TAT_X2_021"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_005_M", Name = "TAT_S1_005"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_027_M", Name = "TAT_S1_027"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_033_M", Name = "TAT_S1_033"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_009_M", Name = "TAT_LX_009"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_020_M", Name = "TAT_LX_020"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_021_M", Name = "TAT_LX_021"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_003_M", Name = "TAT_AR_003"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_012_M", Name = "TAT_BI_012"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_016_M", Name = "TAT_BI_016"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_020_M", Name = "TAT_BI_020"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_024_M", Name = "TAT_BI_024"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_025_M", Name = "TAT_BI_025"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_035_M", Name = "TAT_BI_035"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_045_M", Name = "TAT_BI_045"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_053_M", Name = "TAT_BI_053"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_055_M", Name = "TAT_BI_055"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_001_M", Name = "TAT_H27_001"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_004_M", Name = "TAT_H27_004"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_007_M", Name = "TAT_H27_007"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_013_M", Name = "TAT_H27_013"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_025_M", Name = "TAT_H27_025"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_029_M", Name = "TAT_H27_029"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_004_M", Name = "TAT_GR_004"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_008_M", Name = "TAT_GR_008"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_015_M", Name = "TAT_GR_015"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_016_M", Name = "TAT_GR_016"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_025_M", Name = "TAT_GR_025"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_027_M", Name = "TAT_GR_027"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_004_M", Name = "TAT_IE_004"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_008_M", Name = "TAT_IE_008"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_006_M", Name = "TAT_S2_006"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_018_M", Name = "TAT_S2_018"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_022_M", Name = "TAT_S2_022"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_005_M", Name = "TAT_L2_005"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_016_M", Name = "TAT_L2_016"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_018_M", Name = "TAT_L2_018"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_028_M", Name = "TAT_L2_028"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_031_M", Name = "TAT_L2_031"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_004_M", Name = "TAT_SM_004"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_008_M", Name = "TAT_SM_008"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_014_M", Name = "TAT_SM_014"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_001_M", Name = "TAT_ST_001"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_002_M", Name = "TAT_ST_002"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_008_M", Name = "TAT_ST_008"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_022_M", Name = "TAT_ST_022"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_023_M", Name = "TAT_ST_023"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_035_M", Name = "TAT_ST_035"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_039_M", Name = "TAT_ST_039"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_043_M", Name = "TAT_ST_043"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_003", Name = "TAT_HP_003"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_007", Name = "TAT_HP_007"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_015", Name = "TAT_HP_015"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_016", Name = "TAT_HP_016"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_026", Name = "TAT_HP_026"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_027", Name = "TAT_HP_027"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_028", Name = "TAT_HP_028"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_034", Name = "TAT_HP_034"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_037", Name = "TAT_HP_037"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_039", Name = "TAT_HP_039"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_043", Name = "TAT_HP_043"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_048", Name = "TAT_HP_048"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_LeftArm_000", Name = "TAT_BUS_003"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_LeftArm_001", Name = "TAT_BUS_004"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_001", Name = "TAT_FM_009"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_007", Name = "TAT_FM_015"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_015", Name = "TAT_FM_023"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_005", Name = "TAT_FM_201"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_006", Name = "TAT_FM_202"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_015", Name = "TAT_FM_203"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_031", Name = "TAT_FM_232"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_041", Name = "TAT_FM_242"},
				},
				[6] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_003", Name = "TAT_X2_003"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_004", Name = "TAT_X2_004"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_008", Name = "TAT_X2_008"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_022", Name = "TAT_X2_022"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_023", Name = "TAT_X2_023"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_026", Name = "TAT_X2_026"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_027", Name = "TAT_X2_027"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_015_M", Name = "TAT_S1_015"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_004_M", Name = "TAT_LX_004"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_013_M", Name = "TAT_LX_013"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_019_M", Name = "TAT_LX_019"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_007_M", Name = "TAT_BI_007"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_014_M", Name = "TAT_BI_014"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_033_M", Name = "TAT_BI_033"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_042_M", Name = "TAT_BI_042"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_046_M", Name = "TAT_BI_046"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_047_M", Name = "TAT_BI_047"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_049_M", Name = "TAT_BI_049"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_054_M", Name = "TAT_BI_054"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_006_M", Name = "TAT_H27_006"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_012_M", Name = "TAT_H27_012"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_014_M", Name = "TAT_H27_014"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_017_M", Name = "TAT_H27_017"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_018_M", Name = "TAT_H27_018"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_023_M", Name = "TAT_H27_023"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_028_M", Name = "TAT_H27_028"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_002_M", Name = "TAT_GR_002"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_021_M", Name = "TAT_GR_021"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_024_M", Name = "TAT_GR_024"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_003_M", Name = "TAT_IE_003"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_005_M", Name = "TAT_IE_005"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_006_M", Name = "TAT_IE_006"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_007_M", Name = "TAT_IE_007"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_003_M", Name = "TAT_S2_003"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_028_M", Name = "TAT_S2_028"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_035_M", Name = "TAT_S2_035"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_010_M", Name = "TAT_L2_010"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_017_M", Name = "TAT_L2_017"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_026_M", Name = "TAT_L2_026"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_030_M", Name = "TAT_L2_030"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_001_M", Name = "TAT_SM_001"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_005_M", Name = "TAT_SM_005"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_023_M", Name = "TAT_SM_023"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_003_M", Name = "TAT_ST_003"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_009_M", Name = "TAT_ST_009"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_010_M", Name = "TAT_ST_010"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_016_M", Name = "TAT_ST_016"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_036_M", Name = "TAT_ST_036"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_038_M", Name = "TAT_ST_038"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_049_M", Name = "TAT_ST_049"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_001", Name = "TAT_HP_001"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_004", Name = "TAT_HP_004"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_008", Name = "TAT_HP_008"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_010", Name = "TAT_HP_010"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_014", Name = "TAT_HP_014"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_017", Name = "TAT_HP_017"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_018", Name = "TAT_HP_018"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_020", Name = "TAT_HP_020"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_022", Name = "TAT_HP_022"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_023", Name = "TAT_HP_023"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_036", Name = "TAT_HP_036"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_044", Name = "TAT_HP_044"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_045", Name = "TAT_HP_045"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_RightArm_000", Name = "TAT_BUS_009"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_M_RightArm_001", Name = "TAT_BUS_010"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_RArm_000", Name = "TAT_BB_026"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_RArm_001", Name = "TAT_BB_030"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_002", Name = "TAT_FM_010"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_010", Name = "TAT_FM_018"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_000", Name = "TAT_FM_204"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_001", Name = "TAT_FM_205"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_003", Name = "TAT_FM_206"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_014", Name = "TAT_FM_207"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_018", Name = "TAT_FM_208"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_027", Name = "TAT_FM_228"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_028", Name = "TAT_FM_229"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_038", Name = "TAT_FM_239"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_047", Name = "TAT_FM_247"},
				},
				[7] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_001", Name = "TAT_X2_001"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_002", Name = "TAT_X2_002"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_007_M", Name = "TAT_S1_007"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_020_M", Name = "TAT_S1_020"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_001", Name = "TAT_X2_001"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_002", Name = "TAT_X2_002"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_007_M", Name = "TAT_S1_007"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_000_M", Name = "TAT_LX_000"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_002_M", Name = "TAT_BI_002"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_015_M", Name = "TAT_BI_015"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_027_M", Name = "TAT_BI_027"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_036_M", Name = "TAT_BI_036"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_037_M", Name = "TAT_BI_037"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_044_M", Name = "TAT_BI_044"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_056_M", Name = "TAT_BI_056"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_057_M", Name = "TAT_BI_057"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_005_M", Name = "TAT_GR_005"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_007_M", Name = "TAT_GR_007"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_011_M", Name = "TAT_GR_011"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_023_M", Name = "TAT_GR_023"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_029_M", Name = "TAT_S2_029"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_011_M", Name = "TAT_L2_011"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_007_M", Name = "TAT_ST_007"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_013_M", Name = "TAT_ST_013"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_021_M", Name = "TAT_ST_021"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_028_M", Name = "TAT_ST_028"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_031_M", Name = "TAT_ST_031"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_040", Name = "TAT_HP_040"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_009", Name = "TAT_HP_009"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_019", Name = "TAT_HP_019"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_Lleg_000", Name = "TAT_BB_027"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_009", Name = "TAT_FM_017"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_002", Name = "TAT_FM_209"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_008", Name = "TAT_FM_211"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_021", Name = "TAT_FM_208"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_023", Name = "TAT_FM_224"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_026", Name = "TAT_FM_227"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_032", Name = "TAT_FM_219"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_033", Name = "TAT_FM_234"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_035", Name = "TAT_FM_236"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_037", Name = "TAT_FM_238"},
				},
				[8] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_M_Tat_014", Name = "TAT_X2_014"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_017_M", Name = "TAT_S1_017"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_023_M", Name = "TAT_S1_023"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_001_M", Name = "TAT_LX_001"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_004_M", Name = "TAT_BI_004"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_022_M", Name = "TAT_BI_022"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_028_M", Name = "TAT_BI_028"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_040_M", Name = "TAT_BI_040"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_048_M", Name = "TAT_BI_048"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_006_M", Name = "TAT_GR_006"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_026_M", Name = "TAT_GR_026"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_030_M", Name = "TAT_GR_030"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_030_M", Name = "TAT_S2_030"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_023_M", Name = "TAT_L2_023"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_020_M", Name = "TAT_SM_020"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_005_M", Name = "TAT_ST_005"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_015_M", Name = "TAT_ST_015"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_020_M", Name = "TAT_ST_020"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_025_M", Name = "TAT_ST_025"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_032_M", Name = "TAT_ST_032"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_045_M", Name = "TAT_ST_045"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_047_M", Name = "TAT_ST_047"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_038", Name = "TAT_HP_038"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_M_Tat_042", Name = "TAT_HP_042"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_M_Rleg_000", Name = "TAT_BB_025"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_M_006", Name = "TAT_FM_014"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_007", Name = "TAT_FM_210"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_017", Name = "TAT_FM_212"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_022", Name = "TAT_FM_223"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_039", Name = "TAT_FM_240"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_040", Name = "TAT_FM_241"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_042", Name = "TAT_FM_243"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_M_043", Name = "TAT_FM_244"},
				},
			},
			Female = {
				[1] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_005", Name = "TAT_X2_005"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_006", Name = "TAT_X2_006"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_011", Name = "TAT_X2_011"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_015", Name = "TAT_X2_015"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_009_F", Name = "TAT_S1_009"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_010_F", Name = "TAT_S1_010"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_014_F", Name = "TAT_S1_014"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_021_F", Name = "TAT_S1_021"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_006_F", Name = "TAT_LX_006"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_024_F", Name = "TAT_LX_024"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_001_F", Name = "TAT_AR_001"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_002_F", Name = "TAT_AR_002"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_004_F", Name = "TAT_AR_004"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_005_F", Name = "TAT_AR_005"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_007_F", Name = "TAT_AR_007"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_006_F", Name = "TAT_BI_006"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_008_F", Name = "TAT_BI_008"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_011_F", Name = "TAT_BI_011"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_017_F", Name = "TAT_BI_017"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_021_F", Name = "TAT_BI_021"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_030_F", Name = "TAT_BI_030"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_043_F", Name = "TAT_BI_043"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_002_F", Name = "TAT_H27_002"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_005_F", Name = "TAT_H27_005"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_009_F", Name = "TAT_H27_009"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_010_F", Name = "TAT_H27_010"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_011_F", Name = "TAT_H27_011"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_015_F", Name = "TAT_H27_015"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_016_F", Name = "TAT_H27_016"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_021_F", Name = "TAT_H27_021"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_022_F", Name = "TAT_H27_022"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_024_F", Name = "TAT_H27_024"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_027_F", Name = "TAT_H27_027"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_000_F", Name = "TAT_GR_000"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_001_F", Name = "TAT_GR_001"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_009_F", Name = "TAT_GR_009"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_013_F", Name = "TAT_GR_013"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_014_F", Name = "TAT_GR_014"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_018_F", Name = "TAT_GR_018"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_019_F", Name = "TAT_GR_019"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_022_F", Name = "TAT_GR_022"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_000_F", Name = "TAT_IE_000"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_001_F", Name = "TAT_IE_001"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_002_F", Name = "TAT_IE_002"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_009_F", Name = "TAT_IE_009"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_010_F", Name = "TAT_IE_010"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_011_F", Name = "TAT_IE_011"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_000_F", Name = "TAT_S2_000"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_008_F", Name = "TAT_S2_008"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_011_F", Name = "TAT_S2_011"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_031_F", Name = "TAT_S2_031"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_032_F", Name = "TAT_S2_032"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_022_F", Name = "TAT_L2_022"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_029_F", Name = "TAT_L2_029"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_003_F", Name = "TAT_SM_003"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_006_F", Name = "TAT_SM_006"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_009_F", Name = "TAT_SM_009"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_013_F", Name = "TAT_SM_013"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_016_F", Name = "TAT_SM_016"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_017_F", Name = "TAT_SM_017"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_018_F", Name = "TAT_SM_018"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_022_F", Name = "TAT_SM_022"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_024_F", Name = "TAT_SM_024"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_025_F", Name = "TAT_SM_025"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_024_F", Name = "TAT_ST_024"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_026_F", Name = "TAT_ST_026"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_029_F", Name = "TAT_ST_029"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_030_F", Name = "TAT_ST_030"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_034_F", Name = "TAT_ST_034"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_037_F", Name = "TAT_ST_037"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_040_F", Name = "TAT_ST_040"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_041_F", Name = "TAT_ST_041"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_046_F", Name = "TAT_ST_046"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_048_F", Name = "TAT_ST_048"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_000", Name = "TAT_HP_000"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_024", Name = "TAT_HP_024"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_025", Name = "TAT_HP_025"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_030", Name = "TAT_HP_030"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_031", Name = "TAT_HP_031"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_032", Name = "TAT_HP_032"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_041", Name = "TAT_HP_041"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_046", Name = "TAT_HP_046"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_Back_000", Name = "TAT_BUS_F_000"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_Back_001", Name = "TAT_BUS_F_001"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Back_000", Name = "TAT_BB_003"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Back_001", Name = "TAT_BB_001"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Back_002", Name = "TAT_BB_005"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Should_000", Name = "TAT_BB_011"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Should_001", Name = "TAT_BB_004"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_005", Name = "TAT_FM_013"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_008", Name = "TAT_FM_016"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_014", Name = "TAT_FM_022"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_016", Name = "TAT_FM_024"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_017", Name = "TAT_FM_025"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_018", Name = "TAT_FM_026"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_019", Name = "TAT_FM_027"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_009", Name = "TAT_FM_213"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_011", Name = "TAT_FM_214"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_013", Name = "TAT_FM_215"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_016", Name = "TAT_FM_216"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_019", Name = "TAT_FM_217"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_020", Name = "TAT_FM_221"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_030", Name = "TAT_FM_231"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_045", Name = "TAT_FM_246"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_046", Name = "TAT_TRV_32"},
				},
				[2] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_009", Name = "TAT_X2_009"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_013", Name = "TAT_X2_013"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_016", Name = "TAT_X2_016"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_017", Name = "TAT_X2_017"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_018", Name = "TAT_X2_018"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_019", Name = "TAT_X2_019"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_001_F", Name = "TAT_S1_001"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_002_F", Name = "TAT_S1_002"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_013_F", Name = "TAT_S1_013"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_026_F", Name = "TAT_S1_026"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_007_F", Name = "TAT_LX_007"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_008_F", Name = "TAT_LX_008"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_014_F", Name = "TAT_LX_014"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_015_F", Name = "TAT_LX_015"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_000_F", Name = "TAT_AR_000"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_000_F", Name = "TAT_BI_000"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_001_F", Name = "TAT_BI_001"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_005_F", Name = "TAT_BI_005"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_013_F", Name = "TAT_BI_013"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_018_F", Name = "TAT_BI_018"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_019_F", Name = "TAT_BI_019"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_023_F", Name = "TAT_BI_023"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_026_F", Name = "TAT_BI_026"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_029_F", Name = "TAT_BI_029"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_032_F", Name = "TAT_BI_032"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_034_F", Name = "TAT_BI_034"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_041_F", Name = "TAT_BI_041"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_050_F", Name = "TAT_BI_050"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_058_F", Name = "TAT_BI_058"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_059_F", Name = "TAT_BI_059"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_060_F", Name = "TAT_BI_060"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_000_F", Name = "TAT_H27_000"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_003_F", Name = "TAT_H27_003"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_019_F", Name = "TAT_H27_019"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_020_F", Name = "TAT_H27_020"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_026_F", Name = "TAT_H27_026"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_012_F", Name = "TAT_GR_012"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_017_F", Name = "TAT_GR_017"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_020_F", Name = "TAT_GR_020"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_028_F", Name = "TAT_GR_028"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_012_F", Name = "TAT_S2_012"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_019_F", Name = "TAT_S2_019"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_002_F", Name = "TAT_L2_002"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_012_F", Name = "TAT_L2_012"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_025_F", Name = "TAT_L2_025"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_027_F", Name = "TAT_L2_027"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_000_F", Name = "TAT_SM_000"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_007_F", Name = "TAT_SM_007"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_019_F", Name = "TAT_SM_019"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_021_F", Name = "TAT_SM_021"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_011_F", Name = "TAT_ST_011"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_018_F", Name = "TAT_ST_018"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_019_F", Name = "TAT_ST_019"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_027_F", Name = "TAT_ST_027"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_033_F", Name = "TAT_ST_033"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_044_F", Name = "TAT_ST_044"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_002", Name = "TAT_HP_002"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_013", Name = "TAT_HP_013"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_033", Name = "TAT_HP_033"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_047", Name = "TAT_HP_047"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_Chest_000", Name = "TAT_BUS_F_002"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_Chest_001", Name = "TAT_BUS_F_003"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_Chest_002", Name = "TAT_BUS_F_004"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Chest_000", Name = "TAT_BB_012"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Chest_001", Name = "TAT_BB_013"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Chest_002", Name = "TAT_BB_000"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_003", Name = "TAT_FM_011"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_011", Name = "TAT_FM_019"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_012", Name = "TAT_FM_020"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_013", Name = "TAT_FM_021"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_010", Name = "TAT_FM_218"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_024", Name = "TAT_FM_225"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_025", Name = "TAT_FM_226"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_034", Name = "TAT_FM_235"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_044", Name = "TAT_FM_245"},
				},
				[3] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_028", Name = "TAT_X2_028"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_004_F", Name = "TAT_S1_004"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_003_F", Name = "TAT_LX_003"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_006_F", Name = "TAT_AR_006"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_003_F", Name = "TAT_BI_003"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_010_F", Name = "TAT_BI_010"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_031_F", Name = "TAT_BI_031"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_039_F", Name = "TAT_BI_039"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_052_F", Name = "TAT_BI_052"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_008_F", Name = "TAT_H27_008"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_010_F", Name = "TAT_GR_010"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_029_F", Name = "TAT_GR_029"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_016_F", Name = "TAT_S2_016"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_002_F", Name = "TAT_SM_002"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_010_F", Name = "TAT_SM_010"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_015_F", Name = "TAT_SM_015"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_012_F", Name = "TAT_ST_012"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_014_F", Name = "TAT_ST_014"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_006", Name = "TAT_HP_006"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_029", Name = "TAT_HP_029"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_035", Name = "TAT_HP_035"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_Stom_000", Name = "TAT_BUS_F_011"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_Stom_001", Name = "TAT_BUS_F_012"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_Stom_002", Name = "TAT_BUS_F_013"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_RSide_000", Name = "TAT_BB_006"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Stom_000", Name = "TAT_BB_014"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Stom_001", Name = "TAT_BB_009"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Stom_002", Name = "TAT_BB_010"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_004", Name = "TAT_FM_012"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_004", Name = "TAT_FM_219"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_012", Name = "TAT_FM_220"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_029", Name = "TAT_FM_230"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_036", Name = "TAT_FM_237"},
				},
				[4] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_007", Name = "TAT_X2_007"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_024", Name = "TAT_X2_024"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_025", Name = "TAT_X2_025"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_029", Name = "TAT_X2_029"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_009_F", Name = "TAT_BI_009"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_038_F", Name = "TAT_BI_038"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_051_F", Name = "TAT_BI_051"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_003_F", Name = "TAT_GR_003"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_011_F", Name = "TAT_SM_011"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_012_F", Name = "TAT_SM_012"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_000_F", Name = "TAT_ST_000"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_004_F", Name = "TAT_ST_004"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_006_F", Name = "TAT_ST_006"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_017_F", Name = "TAT_ST_017"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_042_F", Name = "TAT_ST_042"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_005", Name = "TAT_HP_005"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_011", Name = "TAT_HP_011"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_012", Name = "TAT_HP_012"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_021", Name = "TAT_HP_021"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_Neck_000", Name = "TAT_BUS_F_007"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_Neck_001", Name = "TAT_BUS_F_008"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_Neck_000", Name = "TAT_BB_008"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_000", Name = "TAT_FM_008"},
				},
				[5] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_000", Name = "TAT_X2_000"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_010", Name = "TAT_X2_010"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_012", Name = "TAT_X2_012"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_020", Name = "TAT_X2_020"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_021", Name = "TAT_X2_021"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_005_F", Name = "TAT_S1_005"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_027_F", Name = "TAT_S1_027"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_033_F", Name = "TAT_S1_033"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_009_F", Name = "TAT_LX_009"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_020_F", Name = "TAT_LX_020"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_021_F", Name = "TAT_LX_021"},
					{Collection = "mpAirRaces_overlays", Decoration = "MP_AirRaces_Tattoo_003_F", Name = "TAT_AR_003"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_012_F", Name = "TAT_BI_012"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_016_F", Name = "TAT_BI_016"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_020_F", Name = "TAT_BI_020"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_024_F", Name = "TAT_BI_024"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_025_F", Name = "TAT_BI_025"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_035_F", Name = "TAT_BI_035"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_045_F", Name = "TAT_BI_045"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_053_F", Name = "TAT_BI_053"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_055_F", Name = "TAT_BI_055"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_001_F", Name = "TAT_H27_001"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_004_F", Name = "TAT_H27_004"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_007_F", Name = "TAT_H27_007"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_013_F", Name = "TAT_H27_013"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_025_F", Name = "TAT_H27_025"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_029_F", Name = "TAT_H27_029"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_004_F", Name = "TAT_GR_004"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_008_F", Name = "TAT_GR_008"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_015_F", Name = "TAT_GR_015"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_016_F", Name = "TAT_GR_016"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_025_F", Name = "TAT_GR_025"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_027_F", Name = "TAT_GR_027"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_004_F", Name = "TAT_IE_004"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_008_F", Name = "TAT_IE_008"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_006_F", Name = "TAT_S2_006"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_018_F", Name = "TAT_S2_018"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_022_F", Name = "TAT_S2_022"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_005_F", Name = "TAT_L2_005"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_016_F", Name = "TAT_L2_016"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_018_F", Name = "TAT_L2_018"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_028_F", Name = "TAT_L2_028"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_031_F", Name = "TAT_L2_031"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_004_F", Name = "TAT_SM_004"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_008_F", Name = "TAT_SM_008"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_014_F", Name = "TAT_SM_014"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_001_F", Name = "TAT_ST_001"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_002_F", Name = "TAT_ST_002"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_008_F", Name = "TAT_ST_008"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_022_F", Name = "TAT_ST_022"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_023_F", Name = "TAT_ST_023"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_035_F", Name = "TAT_ST_035"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_039_F", Name = "TAT_ST_039"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_043_F", Name = "TAT_ST_043"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_003", Name = "TAT_HP_003"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_007", Name = "TAT_HP_007"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_015", Name = "TAT_HP_015"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_016", Name = "TAT_HP_016"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_026", Name = "TAT_HP_026"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_027", Name = "TAT_HP_027"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_028", Name = "TAT_HP_028"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_034", Name = "TAT_HP_034"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_037", Name = "TAT_HP_037"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_039", Name = "TAT_HP_039"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_043", Name = "TAT_HP_043"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_048", Name = "TAT_HP_048"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_LArm_000", Name = "TAT_BUS_F_005"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_LArm_000", Name = "TAT_BB_002"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_LArm_001", Name = "TAT_BB_016"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_001", Name = "TAT_FM_009"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_009", Name = "TAT_FM_015"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_015", Name = "TAT_FM_023"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_005", Name = "TAT_FM_201"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_006", Name = "TAT_FM_202"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_015", Name = "TAT_FM_203"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_031", Name = "TAT_FM_232"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_041", Name = "TAT_FM_242"},
				},
				[6] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_003", Name = "TAT_X2_003"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_004", Name = "TAT_X2_004"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_008", Name = "TAT_X2_008"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_022", Name = "TAT_X2_022"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_023", Name = "TAT_X2_023"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_026", Name = "TAT_X2_026"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_027", Name = "TAT_X2_027"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_015_F", Name = "TAT_S1_015"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_004_F", Name = "TAT_LX_004"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_013_F", Name = "TAT_LX_013"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_019_F", Name = "TAT_LX_019"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_007_F", Name = "TAT_BI_007"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_014_F", Name = "TAT_BI_014"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_033_F", Name = "TAT_BI_033"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_042_F", Name = "TAT_BI_042"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_046_F", Name = "TAT_BI_046"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_047_F", Name = "TAT_BI_047"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_049_F", Name = "TAT_BI_049"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_054_F", Name = "TAT_BI_054"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_006_F", Name = "TAT_H27_006"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_012_F", Name = "TAT_H27_012"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_014_F", Name = "TAT_H27_014"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_017_F", Name = "TAT_H27_017"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_018_F", Name = "TAT_H27_018"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_023_F", Name = "TAT_H27_023"},
					{Collection = "mpChristmas2017_overlays", Decoration = "MP_Christmas2017_Tattoo_028_F", Name = "TAT_H27_028"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_002_F", Name = "TAT_GR_002"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_021_F", Name = "TAT_GR_021"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_024_F", Name = "TAT_GR_024"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_003_F", Name = "TAT_IE_003"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_005_F", Name = "TAT_IE_005"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_006_F", Name = "TAT_IE_006"},
					{Collection = "mpImportExport_overlays", Decoration = "MP_MP_ImportExport_Tat_007_F", Name = "TAT_IE_007"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_003_F", Name = "TAT_S2_003"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_028_F", Name = "TAT_S2_028"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_035_F", Name = "TAT_S2_035"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_010_F", Name = "TAT_L2_010"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_017_F", Name = "TAT_L2_017"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_026_F", Name = "TAT_L2_026"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_030_F", Name = "TAT_L2_030"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_001_F", Name = "TAT_SM_001"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_005_F", Name = "TAT_SM_005"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_023_F", Name = "TAT_SM_023"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_003_F", Name = "TAT_ST_003"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_009_F", Name = "TAT_ST_009"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_010_F", Name = "TAT_ST_010"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_016_F", Name = "TAT_ST_016"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_036_F", Name = "TAT_ST_036"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_038_F", Name = "TAT_ST_038"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_049_F", Name = "TAT_ST_049"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_001", Name = "TAT_HP_001"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_004", Name = "TAT_HP_004"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_008", Name = "TAT_HP_008"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_010", Name = "TAT_HP_010"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_014", Name = "TAT_HP_014"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_017", Name = "TAT_HP_017"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_018", Name = "TAT_HP_018"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_020", Name = "TAT_HP_020"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_022", Name = "TAT_HP_022"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_023", Name = "TAT_HP_023"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_036", Name = "TAT_HP_036"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_044", Name = "TAT_HP_044"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_045", Name = "TAT_HP_045"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_RArm_000", Name = "TAT_BUS_F_009"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_RArm_001", Name = "TAT_BB_015"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_002", Name = "TAT_FM_010"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_010", Name = "TAT_FM_018"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_001", Name = "TAT_FM_205"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_003", Name = "TAT_FM_206"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_014", Name = "TAT_FM_207"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_018", Name = "TAT_FM_208"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_027", Name = "TAT_FM_228"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_028", Name = "TAT_FM_229"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_038", Name = "TAT_FM_239"},
				},
				[7] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_001", Name = "TAT_X2_001"},
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_002", Name = "TAT_X2_002"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_007_F", Name = "TAT_S1_007"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_020_F", Name = "TAT_S1_020"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_000_F", Name = "TAT_LX_000"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_002_F", Name = "TAT_BI_002"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_015_F", Name = "TAT_BI_015"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_027_F", Name = "TAT_BI_027"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_036_F", Name = "TAT_BI_036"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_037_F", Name = "TAT_BI_037"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_044_F", Name = "TAT_BI_044"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_056_F", Name = "TAT_BI_056"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_057_F", Name = "TAT_BI_057"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_005_F", Name = "TAT_GR_005"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_007_F", Name = "TAT_GR_007"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_011_F", Name = "TAT_GR_011"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_023_F", Name = "TAT_GR_023"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_029_F", Name = "TAT_S2_029"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_011_F", Name = "TAT_L2_011"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_007_F", Name = "TAT_ST_007"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_013_F", Name = "TAT_ST_013"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_021_F", Name = "TAT_ST_021"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_028_F", Name = "TAT_ST_028"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_031_F", Name = "TAT_ST_031"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_009", Name = "TAT_HP_009"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_019", Name = "TAT_HP_019"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_040", Name = "TAT_HP_040"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_LLeg_000", Name = "TAT_BUS_F_006"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_009", Name = "TAT_FM_017"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_002", Name = "TAT_FM_211"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_008", Name = "TAT_FM_208"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_021", Name = "TAT_FM_224"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_023", Name = "TAT_FM_227"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_026", Name = "TAT_FM_219"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_032", Name = "TAT_FM_234"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_033", Name = "TAT_FM_236"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_035", Name = "TAT_FM_238"},
				},
				[8] = {
					{Collection = "mpChristmas2_overlays", Decoration = "MP_Xmas2_F_Tat_014", Name = "TAT_X2_014"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_017_F", Name = "TAT_S1_017"},
					{Collection = "mpLowrider_overlays", Decoration = "MP_LR_Tat_023_F", Name = "TAT_S1_023"},
					{Collection = "mpLuxe_overlays", Decoration = "MP_Luxe_Tat_001_F", Name = "TAT_LX_001"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_004_F", Name = "TAT_BI_004"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_022_F", Name = "TAT_BI_022"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_028_F", Name = "TAT_BI_028"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_040_F", Name = "TAT_BI_040"},
					{Collection = "mpBiker_overlays", Decoration = "MP_MP_Biker_Tat_048_F", Name = "TAT_BI_048"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_006_F", Name = "TAT_GR_006"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_026_F", Name = "TAT_GR_026"},
					{Collection = "mpGunrunning_overlays", Decoration = "MP_Gunrunning_Tattoo_030_F", Name = "TAT_GR_030"},
					{Collection = "mpLowrider2_overlays", Decoration = "MP_LR_Tat_030_F", Name = "TAT_S2_030"},
					{Collection = "mpLuxe2_overlays", Decoration = "MP_Luxe_Tat_023_F", Name = "TAT_L2_023"},
					{Collection = "mpSmuggler_overlays", Decoration = "MP_Smuggler_Tattoo_020_F", Name = "TAT_SM_020"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_005_F", Name = "TAT_ST_005"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_015_F", Name = "TAT_ST_015"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_020_F", Name = "TAT_ST_020"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_025_F", Name = "TAT_ST_025"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_032_F", Name = "TAT_ST_032"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_045_F", Name = "TAT_ST_045"},
					{Collection = "mpStunt_overlays", Decoration = "MP_MP_Stunt_Tat_047_F", Name = "TAT_ST_047"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_038", Name = "TAT_HP_038"},
					{Collection = "mpHipster_overlays", Decoration = "FM_Hip_F_Tat_042", Name = "TAT_HP_042"},
					{Collection = "mpbusiness_overlays", Decoration = "MP_Buis_F_RLeg_000", Name = "TAT_BUS_F_010"},
					{Collection = "mpbeach_overlays", Decoration = "MP_Bea_F_RLeg_000", Name = "TAT_BB_007"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_Award_F_006", Name = "TAT_FM_014"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_007", Name = "TAT_FM_210"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_017", Name = "TAT_FM_212"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_022", Name = "TAT_FM_223"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_039", Name = "TAT_FM_240"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_040", Name = "TAT_FM_241"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_042", Name = "TAT_FM_243"},
					{Collection = "multiplayer_overlays", Decoration = "FM_Tat_F_043", Name = "TAT_FM_244"},
				},
			},
			Hybrid = {
				{},
				{},
				{},
				{},
				{},
				{},
				{},
				{},
			},
		},
	},
	Models = {
		Default = {
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
		Police = {
			"s_m_y_cop_01",
			"s_f_y_cop_01",
			"s_m_y_hwaycop_01",
			"s_m_m_ciasec_01",
			"s_m_y_swat_01",
			"s_m_y_blackops_01",
		},
		Paramedic = {
		    "s_m_m_paramedic_01",
		    "s_f_y_scrubs_01",
			"s_m_y_autopsy_01",
			"s_m_m_doctor_01",
		},
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


function IsInstanced()
	return PlayerCustomisation.Instanced
end

end
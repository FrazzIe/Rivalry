function math.round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function string.starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

NativeUI = {}
NativeUI.Menus = setmetatable({}, NativeUI.Menus)
NativeUI.Menus.__call = function() return true end
NativeUI.Menus.__index = NativeUI.Menus
NativeUI.CurrentMenu = nil
NativeUI.NextMenu = nil
NativeUI.Options = 0
NativeUI.ItemOffset = 0
NativeUI.Settings = {
	Controls = {
		Up = {
			Enabled = true,
			Active = false,
			Pressed = false,
			Keys = {
				{0, 172},
				{1, 172},
				{2, 172},
				{0, 241},
				{1, 241},
				{2, 241},
			},
		},
		Down = {
			Enabled = true,
			Active = false,
			Pressed = false,
			Keys = {
				{0, 173},
				{1, 173},
				{2, 173},
				{0, 242},
				{1, 242},
				{2, 242},
			},
		},
		Left = {
			Enabled = true,
			Active = false,
			Pressed = false,
			Keys = {
				{0, 174},
				{1, 174},
				{2, 174},
			},
		},
		Right = {
			Enabled = true,
			Pressed = false,
			Active = false,
			Keys = {
				{0, 175},
				{1, 175},
				{2, 175},
			},
		},
		Select = {
			Enabled = true,
			Pressed = false,
			Active = false,
			Keys = {
				{0, 201},
				{1, 201},
				{2, 201},
			},
		},
		Back = {
			Enabled = true,
			Active = false,
			Pressed = false,
			Keys = {
				{0, 177},
				{1, 177},
				{2, 177},
				{0, 199},
				{1, 199},
				{2, 199},
			},
		},
		Click = {
			Enabled = true,
			Active = false,
			Pressed = false,
			Keys = {
				{0, 24},
			},
		},
		Enabled = {
			Controller = {
				{0, 2}, -- Look Up and Down
				{0, 1}, -- Look Left and Right
				{0, 25}, -- Aim
				{0, 24}, -- Attack
			},
			Keyboard = {
				{0, 201}, -- Select
				{0, 195}, -- X axis
				{0, 196}, -- Y axis
				{0, 187}, -- Down
				{0, 188}, -- Up
				{0, 189}, -- Left
				{0, 190}, -- Right
				{0, 202}, -- Back
				{0, 217}, -- Select
				{0, 242}, -- Scroll down
				{0, 241}, -- Scroll up
				{0, 239}, -- Cursor X
				{0, 240}, -- Cursor Y
				{0, 31}, -- Move Up and Down
				{0, 30}, -- Move Left and Right
				{0, 21}, -- Sprint
				{0, 22}, -- Jump
				{0, 23}, -- Enter
				{0, 75}, -- Exit Vehicle
				{0, 71}, -- Accelerate Vehicle
				{0, 72}, -- Vehicle Brake
				{0, 59}, -- Move Vehicle Left and Right
				{0, 89}, -- Fly Yaw Left
				{0, 9}, -- Fly Left and Right
				{0, 8}, -- Fly Up and Down
				{0, 90}, -- Fly Yaw Right
				{0, 76}, -- Vehicle Handbrake
			},
		},
	},
	Audio = {
		Library = "HUD_FRONTEND_DEFAULT_SOUNDSET",
		UpDown = "NAV_UP_DOWN",
		LeftRight = "NAV_LEFT_RIGHT",
		Select = "SELECT",
		Back = "BACK",
		Error = "ERROR",
		Slider = "CONTINUOUS_SLIDER",
		Id = nil,
	},
	Items = {
		Title = {
			Background = {Width = 431, Height = 107},
			Text = {X = 215, Y = 20, Scale = 1.15},
		},
		Subtitle = {
			Background = {Width = 431, Height = 37},
			Text = {X = 8, Y = 3, Scale = 0.35},
			PreText = {X = 425, Y = 3, Scale = 0.35},
		},
		Background = {Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 0, Width = 431},
		Navigation = {
			Rectangle = {Width = 431, Height = 18},
			Arrows = {Dictionary = "commonmenu", Texture = "shop_arrows_upanddown", X = 190, Y = -6, Width = 50, Height = 50},
		},
		Description = {
			Bar = {Y = 4, Width = 431, Height = 4},
			Background = {Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 30},
			Text = {X = 8, Y = 10, Scale = 0.35},
		},
		Button = {
			Rectangle = {Y = 0, Width = 431, Height = 38},
			Text = {X = 8, Y = 3, Scale = 0.33},
			LeftBadge = {Y = -2, Width = 40, Height = 40},
			RightBadge = {X = 385, Y = -2, Width = 40, Height = 40},
			RightText = {X = 420, Y = 4, Scale = 0.35},
			SelectedSprite = {Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38},
		},
		Checkbox = {Dictionary = "commonmenu", Textures = {"shop_box_blankb", "shop_box_tickb", "shop_box_blank", "shop_box_tick"}, X = 380, Y = -6, Width = 50, Height = 50},
		List = {
			LeftArrow = {Dictionary = "commonmenu", Texture = "arrowleft", X = 378, Y = 3, Width = 30, Height = 30},
			RightArrow = {Dictionary = "commonmenu", Texture = "arrowright", X = 400, Y = 3, Width = 30, Height = 30},
			Text = {X = 403, Y = 3, Scale = 0.35},
		},
		Slider = {
			Background = {X = 250, Y = 14.5, Width = 150, Height = 9},
			Slider = {X = 250, Y = 14.5, Width = 75, Height = 9},
			Divider = {X = 323.5, Y = 9, Width = 2.5, Height = 20},
			LeftArrow = {Dictionary = "commonmenutu", Texture = "arrowleft", X = 235, Y = 11.5, Width = 15, Height = 15},
			RightArrow = {Dictionary = "commonmenutu", Texture = "arrowright", X = 400, Y = 11.5, Width = 15, Height = 15},
		},
		Progress = {
			Background = {X = 8, Y = 33, Width = 415, Height = 20},
			Bar = {X = 11.75, Y = 36.75, Width = 407.5, Height = 12.5},
			Height = 60
		},
	},
	Panels = {
		Grid = {
			Background = {Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275},
			Grid = {Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", X = 115.5, Y = 47.5, Width = 200, Height = 200},
			Circle = {Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20},
			Text = {
				Top = {X = 215.5, Y = 15, Scale = 0.35},
				Bottom = {X = 215.5, Y = 250, Scale = 0.35},
				Left = {X = 57.75, Y = 130, Scale = 0.35},
				Right = {X = 373.25, Y = 130, Scale = 0.35},
			},
		},
		Colour = {
			Background = {Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 112},
			LeftArrow = {Dictionary = "commonmenu", Texture = "arrowleft", X = 7.5, Y = 15, Width = 30, Height = 30},
			RightArrow = {Dictionary = "commonmenu", Texture = "arrowright", X = 393.5, Y = 15, Width = 30, Height = 30},
			Header = {X = 215.5, Y = 15, Scale = 0.35},
			Box = {X = 15, Y = 55, Width = 44.5, Height = 44.5},
			SelectedRectangle = {X = 15, Y = 47, Width = 44.5, Height = 8},
		},
		Percentage = {
			Background = {Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 76},
			Bar = {X = 9, Y = 50, Width = 413, Height = 10},
			Text = {
				Left = {X = 25, Y = 15, Scale = 0.35},
				Middle = {X = 215.5, Y = 15, Scale = 0.35},
				Right = {X = 398, Y = 15, Scale = 0.35},
			},
		},
	},
	Windows = {
		Heritage = {
			Background = {Dictionary = "pause_menu_pages_char_mom_dad", Texture = "mumdadbg", Width = 431, Height = 228},
			Mum = {Dictionary = "char_creator_portraits", X = 25, Width = 228, Height = 228},
			Dad = {Dictionary = "char_creator_portraits", X = 195, Width = 228, Height = 228},
		},
	},
}
NativeUI.BadgeStyle = {
	None = 1,
	BronzeMedal = 2,
	GoldMedal = 3,
	SilverMedal = 4,
	Alert = 5,
	Crown = 6,
	Ammo = 7,
	Armour = 8,
	Barber = 9,
	Clothes = 10,
	Franklin = 11,
	Bike = 12,
	Car = 13,
	Gun = 14,
	Heart = 15,
	Makeup = 16,
	Mask = 17,
	Michael = 18,
	Star = 19,
	Tattoo = 20,
	Trevor = 21, 
	Lock = 22,
	Tick = 23
}
NativeUI.BadgeTexture = {
    [1] = function() return "" end,
    [2] = function() return "mp_medal_bronze" end,
    [3] = function() return "mp_medal_gold" end,
    [4] = function() return "medal_silver" end,
    [5] = function() return "mp_alerttriangle" end,
    [6] = function() return "mp_hostcrown" end,
    [7] = function(Selected) if Selected then return "shop_ammo_icon_b" else return "shop_ammo_icon_a" end end,
    [8] = function(Selected) if Selected then return "shop_armour_icon_b" else return "shop_armour_icon_a" end end,
    [9] = function(Selected) if Selected then return "shop_barber_icon_b" else return "shop_barber_icon_a"  end end,
    [10] = function(Selected) if Selected then return "shop_clothing_icon_b" else return "shop_clothing_icon_a" end end,
    [11] = function(Selected) if Selected then return "shop_franklin_icon_b" else return "shop_franklin_icon_a" end end,
    [12] = function(Selected) if Selected then return "shop_garage_bike_icon_b" else return "shop_garage_bike_icon_a" end end,
    [13] = function(Selected) if Selected then return "shop_garage_icon_b" else return "shop_garage_icon_a" end end,
    [14] = function(Selected) if Selected then return "shop_gunclub_icon_b" else return "shop_gunclub_icon_a" end end,
    [15] = function(Selected) if Selected then return "shop_health_icon_b" else return "shop_health_icon_a" end end,
    [16] = function(Selected) if Selected then return "shop_makeup_icon_b" else return "shop_makeup_icon_a" end end,
    [17] = function(Selected) if Selected then return "shop_mask_icon_b" else return "shop_mask_icon_a" end end,
    [18] = function(Selected) if Selected then return "shop_michael_icon_b" else return "shop_michael_icon_a" end end,
    [19] = function() return "shop_new_star" end,
    [20] = function(Selected) if Selected then return "shop_tattoos_icon_b" else return "shop_tattoos_icon_a" end end,
    [21] = function(Selected) if Selected then return "shop_trevor_icon_b" else return "shop_trevor_icon_a" end end,
    [22] = function() return "shop_lock" end,
    [23] = function() return "shop_tick_icon" end,
}
NativeUI.BadgeDictionary = {
	[1] = function(Selected) if Selected then return "commonmenu" else return "commonmenu" end end,
}
NativeUI.BadgeColour = {
    [6] = function(Selected) if Selected then return 0, 0, 0, 255 else return 255, 255, 255, 255 end end,
    [22] = function(Selected) if Selected then return 0, 0, 0, 255 else return 255, 255, 255, 255 end end,
    [23] = function(Selected) if Selected then return 0, 0, 0, 255 else return 255, 255, 255, 255 end end,
}

function NativeUI.IsMouseInBounds(X, Y, Width, Height)
	local MX, MY = math.round(GetControlNormal(0, 239) * 1920)/1920, math.round(GetControlNormal(0, 240) * 1080)/1080
    X, Y = X/1920, Y/1080
    Width, Height = Width/1920, Height/1080
	return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function NativeUI.GetSafeZoneBounds()
	local SafeSize = GetSafeZoneSize()
	SafeSize = math.round(SafeSize, 2)
	SafeSize = (SafeSize * 100) - 90
	SafeSize = 10 - SafeSize

	local W, H = 1920, 1080

	return {X = math.round(SafeSize * ((W/H) * 5.4)), Y = math.round(SafeSize * 5.4)}
end

function NativeUI.MeasureStringWidth(str, font, scale)
    BeginTextCommandWidth("STRING")
    AddTextComponentSubstringPlayerName(str)
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0)
    return EndTextCommandGetWidth(true) * 1920
end

function NativeUI.GetBadgeTexture(Badge, Selected)
	if NativeUI.BadgeTexture[Badge] then
		return NativeUI.BadgeTexture[Badge](Selected)
	else
		return ""
	end
end

function NativeUI.GetBadgeDictionary(Badge, Selected)
	if NativeUI.BadgeDictionary[Badge] then
		return NativeUI.BadgeDictionary[Badge](Selected)
	else
		return "commonmenu"
	end
end

function NativeUI.GetBadgeColour(Badge, Selected)
	if NativeUI.BadgeColour[Badge] then
		return NativeUI.BadgeColour[Badge](Selected)
	else
		return 255, 255, 255, 255
	end
end

function NativeUI.PlaySound(Library, Sound, IsLooped)
	if not IsLooped then
		PlaySoundFrontend(-1, Sound, Library, true)
	else
		if not NativeUI.Settings.Audio.Id then
			Citizen.CreateThread(function()
				NativeUI.Settings.Audio.Id = GetSoundId()

				PlaySoundFrontend(NativeUI.Settings.Audio.Id, Sound, Library, true)

				Citizen.Wait(0.01)

				StopSound(NativeUI.Settings.Audio.Id)

				ReleaseSoundId(NativeUI.Settings.Audio.Id)

				NativeUI.Settings.Audio.Id = nil
			end)
		end
	end
end

function NativeUI.RenderSprite(TextureDictionary, TextureName, X, Y, Width, Height, Heading, R, G, B, A)
	local X, Y, Width, Height = (tonumber(X) or 0)/1920, (tonumber(Y) or 0)/1080, (tonumber(Width) or 0)/1920, (tonumber(Height) or 0)/1080

	if not HasStreamedTextureDictLoaded(TextureDictionary) then
		RequestStreamedTextureDict(TextureDictionary, true)
	end

	DrawSprite(TextureDictionary, TextureName, X + Width * 0.5, Y + Height * 0.5, Width, Height, Heading or 0, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

function NativeUI.RenderRectangle(X, Y, Width, Height, R, G, B, A)
	local X, Y, Width, Height = (tonumber(X) or 0)/1920, (tonumber(Y) or 0)/1080, (tonumber(Width) or 0)/1920, (tonumber(Height) or 0)/1080

	DrawRect(X + Width * 0.5, Y + Height * 0.5, Width, Height, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

function NativeUI.RenderText(Text, X, Y, Font, Scale, R, G, B, A, Alignment, DropShadow, Outline, WordWrap)
	local Text, X, Y = tostring(Text), (tonumber(X) or 0)/1920, (tonumber(Y) or 0)/1080

    SetTextFont(Font or 0)
    SetTextScale(1.0, Scale or 0)
    SetTextColour(tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)

    if DropShadow then
        SetTextDropShadow()
    end

    if Outline then
        SetTextOutline()
    end

    if Alignment ~= nil then
        if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
            SetTextCentre(true)
        elseif Alignment == 2 or Alignment == "Right" then
            SetTextRightJustify(true)
        end
    end

    if tonumber(WordWrap) and tonumber(WordWrap) ~= 0 then
        if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
        	SetTextWrap(X - ((WordWrap/1920)/2), X + ((WordWrap/1920)/2))
        elseif Alignment == 2 or Alignment == "Right" then
        	SetTextWrap(0, X)
        else
        	SetTextWrap(X, X + (WordWrap/1920))
        end
    else
        if Alignment == 2 or Alignment == "Right" then
        	SetTextWrap(0, X)
        end
    end

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(Text) 
    EndTextCommandDisplayText(X, Y)
end

function NativeUI.GetLineCount(Text, X, Y, Font, Scale, R, G, B, A, Alignment, DropShadow, Outline, WordWrap)
	local Text, X, Y = tostring(Text), (tonumber(X) or 0)/1920, (tonumber(Y) or 0)/1080

    SetTextFont(Font or 0)
    SetTextScale(1.0, Scale or 0)
    SetTextColour(tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)

    if DropShadow then
        SetTextDropShadow()
    end

    if Outline then
        SetTextOutline()
    end

    if Alignment ~= nil then
        if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
            SetTextCentre(true)
        elseif Alignment == 2 or Alignment == "Right" then
            SetTextRightJustify(true)
        end
    end

    if tonumber(WordWrap) and tonumber(WordWrap) ~= 0 then
        if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
        	SetTextWrap(X - ((WordWrap/1920)/2), X + ((WordWrap/1920)/2))
        elseif Alignment == 2 or Alignment == "Right" then
        	SetTextWrap(0, X)
        else
        	SetTextWrap(X, X + (WordWrap/1920))
        end
    else
        if Alignment == 2 or Alignment == "Right" then
        	SetTextWrap(0, X)
        end
    end

	BeginTextCommandLineCount("STRING")
	AddTextComponentSubstringPlayerName(Text)
	return GetTextScreenLineCount(X, Y)
end

function NativeUI.CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName)
	local Menu = {}

	Menu.Title = Title or ""
	Menu.Subtitle = Subtitle or ""
	Menu.SubtitleHeight = -37
	Menu.Description = ""
	Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height
	Menu.X = X or 0
	Menu.Y = Y or 0
	Menu.Parent = nil
	Menu.WidthOffset = 0
	Menu.Open = false
	Menu.Controls = NativeUI.Settings.Controls
	Menu.Index = 1
	Menu.Sprite = {Dictionary = TextureDictionary or "commonmenu", Texture = Texture or "interaction_bgd"}
	Menu.Rectangle = nil
	Menu.Pagination = {Minimum = 1, Maximum = 10, Total = 10}
	Menu.Safezone = false
	Menu.SafeZoneSize = nil
	Menu.Options = 0

	if string.starts(Menu.Subtitle, "~") then
		Menu.PageCounterColour = string.sub(Menu.Subtitle, 1, 3)
	else
		Menu.PageCounterColour = ""
	end

	if Menu.Subtitle ~= "" then
		local SubtitleLineCount = NativeUI.GetLineCount(Menu.Subtitle, Menu.X + NativeUI.Settings.Items.Subtitle.Text.X, Menu.Y + NativeUI.Settings.Items.Subtitle.Text.Y, 0, NativeUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, NativeUI.Settings.Items.Subtitle.Background.Width + Menu.WidthOffset)

		if SubtitleLineCount > 1 then
			Menu.SubtitleHeight = 18 * SubtitleLineCount
		else
			Menu.SubtitleHeight = 0
		end
	end

	return setmetatable(Menu, NativeUI.Menus)
end

function NativeUI.CreateSubMenu(ParentMenu, Title, Subtitle, X, Y, TextureDictionary, TextureName)
	if ParentMenu ~= nil then
		if ParentMenu() then
			local Menu = {}

			Menu.Title = Title or ParentMenu.Title
			Menu.Subtitle = Subtitle or ParentMenu.Subtitle
			Menu.SubtitleHeight = -37
			Menu.Description = ""
			Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height
			Menu.X = X or ParentMenu.X
			Menu.Y = Y or ParentMenu.Y
			Menu.Parent = ParentMenu
			Menu.WidthOffset = ParentMenu.WidthOffset
			Menu.Open = false
			Menu.Controls = NativeUI.Settings.Controls
			Menu.Index = 1
			Menu.Pagination = {Minimum = 1, Maximum = 10, Total = 10}
			Menu.Safezone = ParentMenu.Safezone
			Menu.SafeZoneSize = nil
			Menu.Options = 0

			if string.starts(Menu.Subtitle, "~") then
				Menu.PageCounterColour = string.sub(Menu.Subtitle, 1, 3)
			else
				Menu.PageCounterColour = ""
			end

			if Menu.Subtitle ~= "" then
				local SubtitleLineCount = NativeUI.GetLineCount(Menu.Subtitle, Menu.X + NativeUI.Settings.Items.Subtitle.Text.X, Menu.Y + NativeUI.Settings.Items.Subtitle.Text.Y, 0, NativeUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, NativeUI.Settings.Items.Subtitle.Background.Width + Menu.WidthOffset)

				if SubtitleLineCount > 1 then
					Menu.SubtitleHeight = 18 * SubtitleLineCount
				else
					Menu.SubtitleHeight = 0
				end
			end

			if ParentMenu.Sprite then
				Menu.Sprite = {Dictionary = TextureDictionary or ParentMenu.Sprite.Dictionary, Texture = Texture or ParentMenu.Sprite.Texture}
			else
				Menu.Rectangle = ParentMenu.Rectangle
			end

			return setmetatable(Menu, NativeUI.Menus)
		else
			return nil
		end
	else
		return nil
	end
end

function NativeUI.Visible(Menu, Value)
	if Menu ~= nil then
		if Menu() then
			if type(Value) == "boolean" then
				Menu.Open = Value

				if Menu.Open then
					NativeUI.CurrentMenu = Menu
					NativeUI.Options = 0
					NativeUI.ItemOffset = 0
				else
					NativeUI.CurrentMenu = nil
					NativeUI.Options = 0
					NativeUI.ItemOffset = 0
				end
			else
				return Menu.Open
			end
		end
	end
end

function NativeUI.GoUp(Options)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			if Options > NativeUI.CurrentMenu.Pagination.Total then
				if NativeUI.CurrentMenu.Index <= NativeUI.CurrentMenu.Pagination.Minimum then
					if NativeUI.CurrentMenu.Index == 1 then
						NativeUI.CurrentMenu.Pagination.Minimum = Options - (NativeUI.CurrentMenu.Pagination.Total - 1)
						NativeUI.CurrentMenu.Pagination.Maximum = Options
						NativeUI.CurrentMenu.Index = Options
					else
						NativeUI.CurrentMenu.Pagination.Minimum = NativeUI.CurrentMenu.Pagination.Minimum - 1
						NativeUI.CurrentMenu.Pagination.Maximum = NativeUI.CurrentMenu.Pagination.Maximum - 1
						NativeUI.CurrentMenu.Index = NativeUI.CurrentMenu.Index - 1
					end
				else
					NativeUI.CurrentMenu.Index = NativeUI.CurrentMenu.Index - 1
				end
			else
				if NativeUI.CurrentMenu.Index == 1 then
					NativeUI.CurrentMenu.Pagination.Minimum = Options - (NativeUI.CurrentMenu.Pagination.Total - 1)
					NativeUI.CurrentMenu.Pagination.Maximum = Options
					NativeUI.CurrentMenu.Index = Options
				else
					NativeUI.CurrentMenu.Index = NativeUI.CurrentMenu.Index - 1
				end
			end

			NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.UpDown)
		end
	end
end

function NativeUI.GoDown(Options)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			if Options > NativeUI.CurrentMenu.Pagination.Total then
				if NativeUI.CurrentMenu.Index >= NativeUI.CurrentMenu.Pagination.Maximum then
					if NativeUI.CurrentMenu.Index == Options then
						NativeUI.CurrentMenu.Pagination.Minimum = 1
						NativeUI.CurrentMenu.Pagination.Maximum = NativeUI.CurrentMenu.Pagination.Total
						NativeUI.CurrentMenu.Index = 1
					else
						NativeUI.CurrentMenu.Pagination.Maximum = NativeUI.CurrentMenu.Pagination.Maximum + 1
						NativeUI.CurrentMenu.Pagination.Minimum = NativeUI.CurrentMenu.Pagination.Maximum - (NativeUI.CurrentMenu.Pagination.Total - 1)
						NativeUI.CurrentMenu.Index = NativeUI.CurrentMenu.Index + 1
					end
				else
					NativeUI.CurrentMenu.Index = NativeUI.CurrentMenu.Index + 1
				end
			else
				if NativeUI.CurrentMenu.Index == Options then
					NativeUI.CurrentMenu.Pagination.Minimum = 1
					NativeUI.CurrentMenu.Pagination.Maximum = NativeUI.CurrentMenu.Pagination.Total
					NativeUI.CurrentMenu.Index = 1
				else
					NativeUI.CurrentMenu.Index = NativeUI.CurrentMenu.Index + 1
				end
			end

			NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.UpDown)
		end
	end
end

function NativeUI.Controls()
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			if NativeUI.CurrentMenu.Open then
				local Options = NativeUI.Options

				DisableAllControlActions(2)

		        if not IsInputDisabled(2) then
		            for Index = 1, #NativeUI.CurrentMenu.Controls.Enabled.Controller do
		                EnableControlAction(NativeUI.CurrentMenu.Controls.Enabled.Controller[Index][1], NativeUI.CurrentMenu.Controls.Enabled.Controller[Index][2], true)
		            end
		        else
		            for Index = 1, #NativeUI.CurrentMenu.Controls.Enabled.Keyboard do
		                EnableControlAction(NativeUI.CurrentMenu.Controls.Enabled.Keyboard[Index][1], NativeUI.CurrentMenu.Controls.Enabled.Keyboard[Index][2], true)
		            end
		        end

				if NativeUI.CurrentMenu.Controls.Up.Enabled then
					for Index = 1, #NativeUI.CurrentMenu.Controls.Up.Keys do
						if not NativeUI.CurrentMenu.Controls.Up.Pressed then
							if IsDisabledControlJustPressed(NativeUI.CurrentMenu.Controls.Up.Keys[Index][1], NativeUI.CurrentMenu.Controls.Up.Keys[Index][2]) then
								NativeUI.CurrentMenu.Controls.Up.Pressed = true

								Citizen.CreateThread(function()
									NativeUI.GoUp(Options)

									Citizen.Wait(175)

									while NativeUI.CurrentMenu.Controls.Up.Enabled and IsDisabledControlPressed(NativeUI.CurrentMenu.Controls.Up.Keys[Index][1], NativeUI.CurrentMenu.Controls.Up.Keys[Index][2]) do
										NativeUI.GoUp(Options)

										Citizen.Wait(125)
									end

									NativeUI.CurrentMenu.Controls.Up.Pressed = false
								end)

								break
							end
						end
					end
				end

				if NativeUI.CurrentMenu.Controls.Down.Enabled then
					for Index = 1, #NativeUI.CurrentMenu.Controls.Down.Keys do
						if not NativeUI.CurrentMenu.Controls.Down.Pressed then
							if IsDisabledControlJustPressed(NativeUI.CurrentMenu.Controls.Down.Keys[Index][1], NativeUI.CurrentMenu.Controls.Down.Keys[Index][2]) then
								NativeUI.CurrentMenu.Controls.Down.Pressed = true

								Citizen.CreateThread(function()
									NativeUI.GoDown(Options)

									Citizen.Wait(175)
												
									while NativeUI.CurrentMenu.Controls.Down.Enabled and IsDisabledControlPressed(NativeUI.CurrentMenu.Controls.Down.Keys[Index][1], NativeUI.CurrentMenu.Controls.Down.Keys[Index][2]) do
										NativeUI.GoDown(Options)
													
										Citizen.Wait(125)
									end

									NativeUI.CurrentMenu.Controls.Down.Pressed = false
								end)

								break
							end
						end
					end
				end

				if NativeUI.CurrentMenu.Controls.Left.Enabled then
					for Index = 1, #NativeUI.CurrentMenu.Controls.Left.Keys do
						if not NativeUI.CurrentMenu.Controls.Left.Pressed then
							if IsDisabledControlJustPressed(NativeUI.CurrentMenu.Controls.Left.Keys[Index][1], NativeUI.CurrentMenu.Controls.Left.Keys[Index][2]) then
								NativeUI.CurrentMenu.Controls.Left.Pressed = true

								Citizen.CreateThread(function()
									NativeUI.CurrentMenu.Controls.Left.Active = true

									Citizen.Wait(0.01)

									NativeUI.CurrentMenu.Controls.Left.Active = false

									Citizen.Wait(174.99)
												
									while NativeUI.CurrentMenu.Controls.Left.Enabled and IsDisabledControlPressed(NativeUI.CurrentMenu.Controls.Left.Keys[Index][1], NativeUI.CurrentMenu.Controls.Left.Keys[Index][2]) do
										NativeUI.CurrentMenu.Controls.Left.Active = true

										Citizen.Wait(0.01)

										NativeUI.CurrentMenu.Controls.Left.Active = false

										Citizen.Wait(124.99)
									end

									NativeUI.CurrentMenu.Controls.Left.Pressed = false
								end)

								break
							end
						end
					end
				end

				if NativeUI.CurrentMenu.Controls.Right.Enabled then
					for Index = 1, #NativeUI.CurrentMenu.Controls.Right.Keys do
						if not NativeUI.CurrentMenu.Controls.Right.Pressed then
							if IsDisabledControlJustPressed(NativeUI.CurrentMenu.Controls.Right.Keys[Index][1], NativeUI.CurrentMenu.Controls.Right.Keys[Index][2]) then
								NativeUI.CurrentMenu.Controls.Right.Pressed = true

								Citizen.CreateThread(function()
									NativeUI.CurrentMenu.Controls.Right.Active = true

									Citizen.Wait(0.01)

									NativeUI.CurrentMenu.Controls.Right.Active = false

									Citizen.Wait(174.99)
												
									while NativeUI.CurrentMenu.Controls.Right.Enabled and IsDisabledControlPressed(NativeUI.CurrentMenu.Controls.Right.Keys[Index][1], NativeUI.CurrentMenu.Controls.Right.Keys[Index][2]) do
										NativeUI.CurrentMenu.Controls.Right.Active = true

										Citizen.Wait(1)

										NativeUI.CurrentMenu.Controls.Right.Active = false

										Citizen.Wait(124.99)
									end

									NativeUI.CurrentMenu.Controls.Right.Pressed = false
								end)

								break
							end
						end
					end
				end

				if NativeUI.CurrentMenu.Controls.Select.Enabled then
					for Index = 1, #NativeUI.CurrentMenu.Controls.Select.Keys do
						if not NativeUI.CurrentMenu.Controls.Select.Pressed then
							if IsDisabledControlJustPressed(NativeUI.CurrentMenu.Controls.Select.Keys[Index][1], NativeUI.CurrentMenu.Controls.Select.Keys[Index][2]) then
								NativeUI.CurrentMenu.Controls.Select.Pressed = true

								Citizen.CreateThread(function()
									NativeUI.CurrentMenu.Controls.Select.Active = true

									Citizen.Wait(0.01)

									NativeUI.CurrentMenu.Controls.Select.Active = false

									Citizen.Wait(174.99)
												
									while NativeUI.CurrentMenu.Controls.Select.Enabled and IsDisabledControlPressed(NativeUI.CurrentMenu.Controls.Select.Keys[Index][1], NativeUI.CurrentMenu.Controls.Select.Keys[Index][2]) do
										NativeUI.CurrentMenu.Controls.Select.Active = true

										Citizen.Wait(0.01)

										NativeUI.CurrentMenu.Controls.Select.Active = false

										Citizen.Wait(124.99)
									end

									NativeUI.CurrentMenu.Controls.Select.Pressed = false
								end)

								break
							end
						end
					end
				end

				if NativeUI.CurrentMenu.Controls.Click.Enabled then
					for Index = 1, #NativeUI.CurrentMenu.Controls.Click.Keys do
						if not NativeUI.CurrentMenu.Controls.Click.Pressed then
							if IsDisabledControlJustPressed(NativeUI.CurrentMenu.Controls.Click.Keys[Index][1], NativeUI.CurrentMenu.Controls.Click.Keys[Index][2]) then
								NativeUI.CurrentMenu.Controls.Click.Pressed = true

								Citizen.CreateThread(function()
									NativeUI.CurrentMenu.Controls.Click.Active = true

									Citizen.Wait(0.01)

									NativeUI.CurrentMenu.Controls.Click.Active = false

									Citizen.Wait(174.99)
												
									while NativeUI.CurrentMenu.Controls.Click.Enabled and IsDisabledControlPressed(NativeUI.CurrentMenu.Controls.Click.Keys[Index][1], NativeUI.CurrentMenu.Controls.Click.Keys[Index][2]) do
										NativeUI.CurrentMenu.Controls.Click.Active = true

										Citizen.Wait(0.01)

										NativeUI.CurrentMenu.Controls.Click.Active = false

										Citizen.Wait(124.99)
									end

									NativeUI.CurrentMenu.Controls.Click.Pressed = false
								end)

								break
							end
						end
					end
				end

				if NativeUI.CurrentMenu.Controls.Back.Enabled then
					for Index = 1, #NativeUI.CurrentMenu.Controls.Back.Keys do
						if not NativeUI.CurrentMenu.Controls.Back.Pressed then
							if IsDisabledControlJustPressed(NativeUI.CurrentMenu.Controls.Back.Keys[Index][1], NativeUI.CurrentMenu.Controls.Back.Keys[Index][2]) then
								NativeUI.CurrentMenu.Controls.Back.Pressed = true
								break
							end
						end
					end
				end
			end
		end
	end
end

function NativeUI.Title()
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			if not NativeUI.CurrentMenu.SafeZoneSize then
				NativeUI.CurrentMenu.SafeZoneSize = {X = 0, Y = 0}

				if NativeUI.CurrentMenu.Safezone then
					NativeUI.CurrentMenu.SafeZoneSize = NativeUI.GetSafeZoneBounds()

					ScreenDrawPositionBegin(76, 84)
					ScreenDrawPositionRatio(0, 0, 0, 0)
				end
			end

			if NativeUI.CurrentMenu.Sprite then
				NativeUI.RenderSprite(NativeUI.CurrentMenu.Sprite.Dictionary, NativeUI.CurrentMenu.Sprite.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y, NativeUI.Settings.Items.Title.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Title.Background.Height)
			else
				NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y, NativeUI.Settings.Items.Title.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Title.Background.Height, NativeUI.CurrentMenu.Rectangle.R, NativeUI.CurrentMenu.Rectangle.G, NativeUI.CurrentMenu.Rectangle.B, NativeUI.CurrentMenu.Rectangle.A)
			end

			NativeUI.RenderText(NativeUI.CurrentMenu.Title, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Title.Text.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Title.Text.Y, 1, NativeUI.Settings.Items.Title.Text.Scale, 255, 255, 255, 255, 1)

			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Title.Background.Height
		end
	end
end

function NativeUI.Subtitle()
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			if not NativeUI.CurrentMenu.SafeZoneSize then
				NativeUI.CurrentMenu.SafeZoneSize = {X = 0, Y = 0}

				if NativeUI.CurrentMenu.Safezone then
					NativeUI.CurrentMenu.SafeZoneSize = NativeUI.GetSafeZoneBounds()

					ScreenDrawPositionBegin(76, 84)
					ScreenDrawPositionRatio(0, 0, 0, 0)
				end
			end

			if NativeUI.CurrentMenu.Subtitle ~= "" then
				NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Subtitle.Background.Width + NativeUI.CurrentMenu.WidthOffset,  NativeUI.Settings.Items.Subtitle.Background.Height + NativeUI.CurrentMenu.SubtitleHeight, 0, 0, 0, 255)
				NativeUI.RenderText(NativeUI.CurrentMenu.Subtitle, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Subtitle.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Subtitle.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, NativeUI.Settings.Items.Subtitle.Background.Width + NativeUI.CurrentMenu.WidthOffset)
					
				if NativeUI.CurrentMenu.Options >= NativeUI.CurrentMenu.Pagination.Total + 1 then
					NativeUI.RenderText(NativeUI.CurrentMenu.PageCounterColour..NativeUI.CurrentMenu.Index.." / "..NativeUI.CurrentMenu.Options, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Subtitle.PreText.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Subtitle.PreText.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Subtitle.Background.Height
			end
		end
	end
end

function NativeUI.Background()
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			if not NativeUI.CurrentMenu.SafeZoneSize then
				NativeUI.CurrentMenu.SafeZoneSize = {X = 0, Y = 0}

				if NativeUI.CurrentMenu.Safezone then
					NativeUI.CurrentMenu.SafeZoneSize = NativeUI.GetSafeZoneBounds()

					ScreenDrawPositionBegin(76, 84)
					ScreenDrawPositionRatio(0, 0, 0, 0)
				end
			end

			SetUiLayer(0)
			NativeUI.RenderSprite(NativeUI.Settings.Items.Background.Dictionary, NativeUI.Settings.Items.Background.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Background.Y + NativeUI.CurrentMenu.SubtitleHeight, NativeUI.Settings.Items.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.ItemOffset, 0, 0, 0, 255)
			SetUiLayer(1)
		end
	end
end

function NativeUI.Navigation()
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			if NativeUI.Options > NativeUI.CurrentMenu.Pagination.Total then
				local UpHovered = false
				local DownHovered = false

				if not NativeUI.CurrentMenu.SafeZoneSize then
					NativeUI.CurrentMenu.SafeZoneSize = {X = 0, Y = 0}

					if NativeUI.CurrentMenu.Safezone then
						NativeUI.CurrentMenu.SafeZoneSize = NativeUI.GetSafeZoneBounds()

						ScreenDrawPositionBegin(76, 84)
						ScreenDrawPositionRatio(0, 0, 0, 0)
					end
				end

				UpHovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.CurrentMenu.SafeZoneSize.X, NativeUI.CurrentMenu.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Navigation.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Navigation.Rectangle.Height)
				DownHovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.CurrentMenu.SafeZoneSize.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Navigation.Rectangle.Height + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Navigation.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Navigation.Rectangle.Height)

				if NativeUI.CurrentMenu.Controls.Click.Active then
					if UpHovered then
						NativeUI.GoUp(NativeUI.Options)
					elseif DownHovered then
						NativeUI.GoDown(NativeUI.Options)
					end
				end

				if UpHovered then
					NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Navigation.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
				else
					NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Navigation.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
				end

				if DownHovered then
					NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Navigation.Rectangle.Height + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Navigation.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
				else
					NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Navigation.Rectangle.Height + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Navigation.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
				end

				NativeUI.RenderSprite(NativeUI.Settings.Items.Navigation.Arrows.Dictionary, NativeUI.Settings.Items.Navigation.Arrows.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Navigation.Arrows.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Navigation.Arrows.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Navigation.Arrows.Width, NativeUI.Settings.Items.Navigation.Arrows.Height)

				NativeUI.ItemOffset = NativeUI.ItemOffset + (NativeUI.Settings.Items.Navigation.Rectangle.Height * 2)
			end
		end
	end
end

function NativeUI.Description()
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			if not NativeUI.CurrentMenu.SafeZoneSize then
				NativeUI.CurrentMenu.SafeZoneSize = {X = 0, Y = 0}

				if NativeUI.CurrentMenu.Safezone then
					NativeUI.CurrentMenu.SafeZoneSize = NativeUI.GetSafeZoneBounds()

					ScreenDrawPositionBegin(76, 84)
					ScreenDrawPositionRatio(0, 0, 0, 0)
				end
			end

			NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Description.Bar.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Description.Bar.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Description.Bar.Height, 0, 0, 0, 255)
			NativeUI.RenderSprite(NativeUI.Settings.Items.Description.Background.Dictionary, NativeUI.Settings.Items.Description.Background.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Description.Background.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Description.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.DescriptionHeight, 0, 0, 0, 255)
			NativeUI.RenderText(NativeUI.CurrentMenu.Description, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Description.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Description.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + NativeUI.CurrentMenu.WidthOffset)

			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.CurrentMenu.DescriptionHeight + NativeUI.Settings.Items.Description.Bar.Y
		end
	end
end

function NativeUI.Render()
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then

			if NativeUI.CurrentMenu.Safezone then
				ScreenDrawPositionEnd()
			end

			NativeUI.CurrentMenu.Options = NativeUI.Options
			NativeUI.CurrentMenu.SafeZoneSize = nil

			NativeUI.Controls()

			NativeUI.Options = 0
			NativeUI.ItemOffset = 0

			if NativeUI.CurrentMenu.Controls.Back.Pressed then
				NativeUI.CurrentMenu.Controls.Back.Pressed = false

				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Back)

				if NativeUI.CurrentMenu.Parent ~= nil then
					if NativeUI.CurrentMenu.Parent() then
						NativeUI.NextMenu = NativeUI.CurrentMenu.Parent
					else
						NativeUI.NextMenu = nil
						NativeUI.Visible(NativeUI.CurrentMenu, false)
					end
				else
					NativeUI.NextMenu = nil
					NativeUI.Visible(NativeUI.CurrentMenu, false)
				end
			end

			if NativeUI.NextMenu ~= nil then
				if NativeUI.NextMenu() then
					NativeUI.Visible(NativeUI.CurrentMenu, false)
					NativeUI.Visible(NativeUI.NextMenu, true)
					NativeUI.CurrentMenu.Controls.Select.Active = false
				end
			end
		end
	end
end

function NativeUI.Button(Label, Description, RightLabel, LeftBadge, RightBadge, Enabled, Callback, Submenu)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			local Option = NativeUI.Options + 1

			if NativeUI.CurrentMenu.Pagination.Minimum <= Option and NativeUI.CurrentMenu.Pagination.Maximum >= Option then
				local Selected = NativeUI.CurrentMenu.Index == Option
				local Hovered = false

				if not NativeUI.CurrentMenu.SafeZoneSize then
					NativeUI.CurrentMenu.SafeZoneSize = {X = 0, Y = 0}

					if NativeUI.CurrentMenu.Safezone then
						NativeUI.CurrentMenu.SafeZoneSize = NativeUI.GetSafeZoneBounds()

						ScreenDrawPositionBegin(76, 84)
						ScreenDrawPositionRatio(0, 0, 0, 0)
					end
				end

				Hovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.CurrentMenu.SafeZoneSize.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)
				
				local LeftBadgeOffset = ((LeftBadge == NativeUI.BadgeStyle.None or tonumber(LeftBadge) == nil) and 0 or 27)
				local RightBadgeOffset =  ((RightBadge == NativeUI.BadgeStyle.None or tonumber(RightBadge) == nil) and 0 or 27)

				if Hovered and not Selected then
					NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)
					
					if NativeUI.CurrentMenu.Controls.Click.Active then
						NativeUI.CurrentMenu.Index = Option
						NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Error)
					end
				end

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
				end

				if LeftBadge ~= NativeUI.BadgeStyle.None and tonumber(LeftBadge) ~= nil then
					NativeUI.RenderSprite(NativeUI.GetBadgeDictionary(LeftBadge, Selected), NativeUI.GetBadgeTexture(LeftBadge, Selected), NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.LeftBadge.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.LeftBadge.Width, NativeUI.Settings.Items.Button.LeftBadge.Height, NativeUI.GetBadgeColour(LeftBadge, Selected))
				end

				if RightBadge ~= NativeUI.BadgeStyle.None and tonumber(RightBadge) ~= nil then
					NativeUI.RenderSprite(NativeUI.GetBadgeDictionary(RightBadge, Selected), NativeUI.GetBadgeTexture(RightBadge, Selected), NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.RightBadge.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.RightBadge.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.RightBadge.Width, NativeUI.Settings.Items.Button.RightBadge.Height, NativeUI.GetBadgeColour(RightBadge, Selected))
				end

				if Enabled == true or Enabled == nil then
					if Selected then
						if RightLabel ~= nil and RightLabel ~= "" then
							NativeUI.RenderText(RightLabel, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.RightText.X - RightBadgeOffset + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 0, 0, 0, 255, 2)
						end

						NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)
					else
						if RightLabel ~= nil and RightLabel ~= "" then
							NativeUI.RenderText(RightLabel, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.RightText.X - RightBadgeOffset + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 245, 245, 245, 255, 2)
						end

						NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
					end
				else
					if RightLabel ~= nil and RightLabel ~= "" then
						NativeUI.RenderText(RightLabel, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.RightText.X - RightBadgeOffset + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 163, 159, 148, 255, 2)
					end

					NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height

				if Selected and NativeUI.CurrentMenu.Description ~= Description then
					NativeUI.CurrentMenu.Description = Description or ""

					local DescriptionLineCount = NativeUI.GetLineCount(NativeUI.CurrentMenu.Description, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Description.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Description.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + NativeUI.CurrentMenu.WidthOffset)
					
					if DescriptionLineCount > 1 then
						NativeUI.CurrentMenu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * DescriptionLineCount
					else
						NativeUI.CurrentMenu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height + 7
					end
				end

				Callback(Hovered, Selected, ((NativeUI.CurrentMenu.Controls.Select.Active or (Hovered and NativeUI.CurrentMenu.Controls.Click.Active)) and Selected))

				if Selected and (NativeUI.CurrentMenu.Controls.Select.Active or (Hovered and NativeUI.CurrentMenu.Controls.Click.Active)) then
					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)

					if Submenu ~= nil then
						if Submenu() then
							NativeUI.NextMenu = Submenu
						end
					end
				end
			end

			NativeUI.Options = NativeUI.Options + 1
		end
	end
end

function NativeUI.Checkbox(Label, Description, Checked, Enabled, Callback)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			local Option = NativeUI.Options + 1

			if NativeUI.CurrentMenu.Pagination.Minimum <= Option and NativeUI.CurrentMenu.Pagination.Maximum >= Option then	
				local Selected = NativeUI.CurrentMenu.Index == Option
				local Hovered = false

				if not NativeUI.CurrentMenu.SafeZoneSize then
					NativeUI.CurrentMenu.SafeZoneSize = {X = 0, Y = 0}

					if NativeUI.CurrentMenu.Safezone then
						NativeUI.CurrentMenu.SafeZoneSize = NativeUI.GetSafeZoneBounds()

						ScreenDrawPositionBegin(76, 84)
						ScreenDrawPositionRatio(0, 0, 0, 0)
					end
				end

				Hovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.CurrentMenu.SafeZoneSize.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)

				if Hovered and not Selected then
					NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)

					if NativeUI.CurrentMenu.Controls.Click.Active then
						NativeUI.CurrentMenu.Index = Option
						NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Error)
						 NativeUI.CurrentMenu.Controls.Click.Active = false
					end
				end

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
				end

				if Enabled == true or Enabled == nil then
					if Selected then
						NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)
					else
						NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
					end
				else
					NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)
				end

				if Selected then
					if Checked then
						NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[1], NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Checkbox.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Checkbox.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
					else
						NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[2], NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Checkbox.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Checkbox.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
					end
				else
					if Checked then
						NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[3], NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Checkbox.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Checkbox.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
					else
						NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[4], NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Checkbox.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Checkbox.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
					end
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height
			
				if Selected and NativeUI.CurrentMenu.Description ~= Description then
					NativeUI.CurrentMenu.Description = Description or ""

					local DescriptionLineCount = NativeUI.GetLineCount(NativeUI.CurrentMenu.Description, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Description.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Description.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + NativeUI.CurrentMenu.WidthOffset)
					
					if DescriptionLineCount > 1 then
						NativeUI.CurrentMenu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * DescriptionLineCount
					else
						NativeUI.CurrentMenu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height + 7
					end
				end

				if Selected and (NativeUI.CurrentMenu.Controls.Select.Active or (Hovered and NativeUI.CurrentMenu.Controls.Click.Active)) then
					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)

					Checked = not Checked
				end

				Callback(Hovered, Selected, ((NativeUI.CurrentMenu.Controls.Select.Active or (Hovered and NativeUI.CurrentMenu.Controls.Click.Active)) and Selected), Checked)
			end

			NativeUI.Options = NativeUI.Options + 1
		end
	end
end

function NativeUI.List(Label, Items, Index, Description, Enabled, Callback)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			local Option = NativeUI.Options + 1

			if NativeUI.CurrentMenu.Pagination.Minimum <= Option and NativeUI.CurrentMenu.Pagination.Maximum >= Option then		
				local Selected = NativeUI.CurrentMenu.Index == Option
				local Hovered = false
				local LeftArrowHovered, RightArrowHovered = false, false

				if not NativeUI.CurrentMenu.SafeZoneSize then
					NativeUI.CurrentMenu.SafeZoneSize = {X = 0, Y = 0}

					if NativeUI.CurrentMenu.Safezone then
						NativeUI.CurrentMenu.SafeZoneSize = NativeUI.GetSafeZoneBounds()

						ScreenDrawPositionBegin(76, 84)
						ScreenDrawPositionRatio(0, 0, 0, 0)
					end
				end

				Hovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.CurrentMenu.SafeZoneSize.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)
				
				local ListText = (type(Items[Index]) == "table") and tostring(Items[Index].Name) or tostring(Items[Index]) or "NIL"
				local TextOffset = NativeUI.MeasureStringWidth(ListText, 0, 0.35)

				if Hovered and not Selected then
					NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)

					if NativeUI.CurrentMenu.Controls.Click.Active then
						NativeUI.CurrentMenu.Index = Option
						NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Error)
					end				
				end

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
					LeftArrowHovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.List.LeftArrow.X - TextOffset + NativeUI.CurrentMenu.SafeZoneSize.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.List.LeftArrow.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.LeftArrow.Width, NativeUI.Settings.Items.List.LeftArrow.Height)
					RightArrowHovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.List.RightArrow.X + NativeUI.CurrentMenu.SafeZoneSize.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.List.RightArrow.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.RightArrow.Width, NativeUI.Settings.Items.List.RightArrow.Height)
				end

				if Enabled == true or Enabled == nil then
					if Selected then
						NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)

						NativeUI.RenderSprite(NativeUI.Settings.Items.List.LeftArrow.Dictionary, NativeUI.Settings.Items.List.LeftArrow.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.List.LeftArrow.X - TextOffset + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.List.LeftArrow.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.LeftArrow.Width, NativeUI.Settings.Items.List.LeftArrow.Height, 0, 0, 0, 0, 255)
						NativeUI.RenderSprite(NativeUI.Settings.Items.List.RightArrow.Dictionary, NativeUI.Settings.Items.List.RightArrow.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.List.RightArrow.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.List.RightArrow.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.RightArrow.Width, NativeUI.Settings.Items.List.RightArrow.Height, 0, 0, 0, 0, 255)
						
						NativeUI.RenderText(ListText, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.List.Text.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.List.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 0, 0, 0, 255, 2)
					else
						NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
						
						NativeUI.RenderText(ListText, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.List.Text.X + 15 + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.List.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 245, 245, 245, 255, 2)
					end
				else
					NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)
					
					if Selected then
						NativeUI.RenderSprite(NativeUI.Settings.Items.List.LeftArrow.Dictionary, NativeUI.Settings.Items.List.LeftArrow.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.List.LeftArrow.X - TextOffset + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.List.LeftArrow.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.LeftArrow.Width, NativeUI.Settings.Items.List.LeftArrow.Height, 0, 163, 159, 148, 255)
						NativeUI.RenderSprite(NativeUI.Settings.Items.List.RightArrow.Dictionary, NativeUI.Settings.Items.List.RightArrow.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.List.RightArrow.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.List.RightArrow.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.RightArrow.Width, NativeUI.Settings.Items.List.RightArrow.Height, 0, 163, 159, 148, 255)

						NativeUI.RenderText(ListText, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.List.Text.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.List.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 163, 159, 148, 255, 2)
					else
						NativeUI.RenderText(ListText, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.List.Text.X + 15 + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.List.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 163, 159, 148, 255, 2)
					end
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height

				if Selected and NativeUI.CurrentMenu.Description ~= Description then
					NativeUI.CurrentMenu.Description = Description or ""

					local DescriptionLineCount = NativeUI.GetLineCount(NativeUI.CurrentMenu.Description, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Description.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Description.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + NativeUI.CurrentMenu.WidthOffset)
					
					if DescriptionLineCount > 1 then
						NativeUI.CurrentMenu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * DescriptionLineCount
					else
						NativeUI.CurrentMenu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height + 7
					end
				end


				if Selected and (NativeUI.CurrentMenu.Controls.Left.Active or (NativeUI.CurrentMenu.Controls.Click.Active and LeftArrowHovered)) and not (NativeUI.CurrentMenu.Controls.Right.Active or (NativeUI.CurrentMenu.Controls.Click.Active and RightArrowHovered)) then
					Index = Index - 1

					if Index < 1 then
						Index = #Items
					end

					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
				elseif Selected and (NativeUI.CurrentMenu.Controls.Right.Active or (NativeUI.CurrentMenu.Controls.Click.Active and RightArrowHovered)) and not (NativeUI.CurrentMenu.Controls.Left.Active or (NativeUI.CurrentMenu.Controls.Click.Active and LeftArrowHovered)) then
					Index = Index + 1

					if Index > #Items then
						Index = 1
					end

					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
				end

				if Selected and (NativeUI.CurrentMenu.Controls.Select.Active or ((Hovered and NativeUI.CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)
				end

				Callback(Hovered, Selected, ((NativeUI.CurrentMenu.Controls.Select.Active or ((Hovered and NativeUI.CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) and Selected), Index)
			end

			NativeUI.Options = NativeUI.Options + 1
		end
	end
end

function NativeUI.Slider(Label, Items, Index, Description, Divider, Enabled, Callback)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			local Option = NativeUI.Options + 1

			if NativeUI.CurrentMenu.Pagination.Minimum <= Option and NativeUI.CurrentMenu.Pagination.Maximum >= Option then
				local Selected = NativeUI.CurrentMenu.Index == Option
				local Hovered = false
				local LeftArrowHovered, RightArrowHovered = false, false

				if not NativeUI.CurrentMenu.SafeZoneSize then
					NativeUI.CurrentMenu.SafeZoneSize = {X = 0, Y = 0}

					if NativeUI.CurrentMenu.Safezone then
						NativeUI.CurrentMenu.SafeZoneSize = NativeUI.GetSafeZoneBounds()

						ScreenDrawPositionBegin(76, 84)
						ScreenDrawPositionRatio(0, 0, 0, 0)
					end
				end

			

				Hovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.CurrentMenu.SafeZoneSize.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)

				if Hovered and not Selected then
					NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)
					
					if NativeUI.CurrentMenu.Controls.Click.Active then
						NativeUI.CurrentMenu.Index = Option
						NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Error)
					end
				end

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
					LeftArrowHovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Slider.LeftArrow.X + NativeUI.CurrentMenu.SafeZoneSize.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Slider.LeftArrow.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.LeftArrow.Width, NativeUI.Settings.Items.Slider.LeftArrow.Height)
					RightArrowHovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Slider.RightArrow.X + NativeUI.CurrentMenu.SafeZoneSize.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Slider.RightArrow.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.RightArrow.Width, NativeUI.Settings.Items.Slider.RightArrow.Height)
				end

				if Enabled == true or Enabled == nil then
					if Selected then
						NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)

						NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.LeftArrow.Dictionary, NativeUI.Settings.Items.Slider.LeftArrow.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Slider.LeftArrow.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Slider.LeftArrow.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.LeftArrow.Width, NativeUI.Settings.Items.Slider.LeftArrow.Height, 0, 0, 0, 0, 255)
						NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.RightArrow.Dictionary, NativeUI.Settings.Items.Slider.RightArrow.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Slider.RightArrow.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Slider.RightArrow.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.RightArrow.Width, NativeUI.Settings.Items.Slider.RightArrow.Height, 0, 0, 0, 0, 255)
					else
						NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
					end
				else
					NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)

					if Selected then
						NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.LeftArrow.Dictionary, NativeUI.Settings.Items.Slider.LeftArrow.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Slider.LeftArrow.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Slider.LeftArrow.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.LeftArrow.Width, NativeUI.Settings.Items.Slider.LeftArrow.Height, 163, 159, 148, 255)
						NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.RightArrow.Dictionary, NativeUI.Settings.Items.Slider.RightArrow.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Slider.RightArrow.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Slider.RightArrow.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.RightArrow.Width, NativeUI.Settings.Items.Slider.RightArrow.Height, 163, 159, 148, 255)
					end
				end

				NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Slider.Background.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Slider.Background.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Slider.Background.Width, NativeUI.Settings.Items.Slider.Background.Height, 4, 32, 57, 255)
				NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Slider.Slider.X + (((NativeUI.Settings.Items.Slider.Background.Width - NativeUI.Settings.Items.Slider.Slider.Width)/(#Items - 1)) * (Index - 1)) + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Slider.Slider.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Slider.Slider.Width, NativeUI.Settings.Items.Slider.Slider.Height, 57, 116, 200, 255)
				
				if Divider then
					NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Slider.Divider.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Slider.Divider.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Slider.Divider.Width, NativeUI.Settings.Items.Slider.Divider.Height, 245, 245, 245, 255)
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height

				if Selected and NativeUI.CurrentMenu.Description ~= Description then
					NativeUI.CurrentMenu.Description = Description or ""

					local DescriptionLineCount = NativeUI.GetLineCount(NativeUI.CurrentMenu.Description, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Description.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Description.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + NativeUI.CurrentMenu.WidthOffset)
					
					if DescriptionLineCount > 1 then
						NativeUI.CurrentMenu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * DescriptionLineCount
					else
						NativeUI.CurrentMenu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height + 7
					end
				end

				if Selected and (NativeUI.CurrentMenu.Controls.Left.Active or (NativeUI.CurrentMenu.Controls.Click.Active and LeftArrowHovered)) and not (NativeUI.CurrentMenu.Controls.Right.Active or (NativeUI.CurrentMenu.Controls.Click.Active and RightArrowHovered)) then
					Index = Index - 1

					if Index < 1 then
						Index = #Items
					end

					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
				elseif Selected and (NativeUI.CurrentMenu.Controls.Right.Active or (NativeUI.CurrentMenu.Controls.Click.Active and RightArrowHovered)) and not (NativeUI.CurrentMenu.Controls.Left.Active or (NativeUI.CurrentMenu.Controls.Click.Active and LeftArrowHovered)) then
					Index = Index + 1

					if Index > #Items then
						Index = 1
					end

					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
				end

				if Selected and (NativeUI.CurrentMenu.Controls.Select.Active or ((Hovered and NativeUI.CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)
				end

				Callback(Hovered, Selected, ((NativeUI.CurrentMenu.Controls.Select.Active or ((Hovered and NativeUI.CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) and Selected), Index)
			end

			NativeUI.Options = NativeUI.Options + 1
		end
	end
end

function NativeUI.Progress(Label, Items, Index, Description, Counter, Enabled, Callback)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			local Option = NativeUI.Options + 1	

			if NativeUI.CurrentMenu.Pagination.Minimum <= Option and NativeUI.CurrentMenu.Pagination.Maximum >= Option then		
				local Selected = NativeUI.CurrentMenu.Index == Option
				local Hovered = false
				local ProgressHovered = false

				if not NativeUI.CurrentMenu.SafeZoneSize then
					NativeUI.CurrentMenu.SafeZoneSize = {X = 0, Y = 0}

					if NativeUI.CurrentMenu.Safezone then
						NativeUI.CurrentMenu.SafeZoneSize = NativeUI.GetSafeZoneBounds()

						ScreenDrawPositionBegin(76, 84)
						ScreenDrawPositionRatio(0, 0, 0, 0)
					end
				end

				Hovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.CurrentMenu.SafeZoneSize.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Progress.Height)
					
				local ProgressText = (Counter and Index.."/"..#Items or (type(Items[Index]) == "table") and tostring(Items[Index].Name) or tostring(Items[Index]))

				if Hovered and not Selected then
					NativeUI.RenderRectangle(NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Progress.Height, 255, 255, 255, 20)

					if NativeUI.CurrentMenu.Controls.Click.Active then
						NativeUI.CurrentMenu.Index = Option
						NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Error)
					end
				end

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Progress.Height)
					ProgressHovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Progress.Bar.X + NativeUI.CurrentMenu.SafeZoneSize.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Progress.Bar.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset - 12, NativeUI.Settings.Items.Progress.Bar.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Progress.Bar.Height + 24)
				end

				if Enabled == true or Enabled == nil then
					if Selected then
						NativeUI.RenderText(ProgressText, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.RightText.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 0, 0, 0, 255, 2)

						NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)

						NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Progress.Background.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Progress.Background.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 0, 0, 0, 255)
						NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Progress.Bar.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Progress.Bar.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, ((Index/#Items) * (NativeUI.Settings.Items.Progress.Bar.Width + NativeUI.CurrentMenu.WidthOffset)), NativeUI.Settings.Items.Progress.Bar.Height, 240, 240, 240, 255)
					else
						NativeUI.RenderText(ProgressText, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.RightText.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 245, 245, 245, 255, 2)

						NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)

						NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Progress.Background.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Progress.Background.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 240, 240, 240, 255)
						NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Progress.Bar.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Progress.Bar.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, ((Index/#Items) * (NativeUI.Settings.Items.Progress.Bar.Width + NativeUI.CurrentMenu.WidthOffset)), NativeUI.Settings.Items.Progress.Bar.Height, 0, 0, 0, 255)
					end
				else
					NativeUI.RenderText(ProgressText, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.RightText.X + NativeUI.CurrentMenu.WidthOffset, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 163, 159, 148, 255, 2)

					NativeUI.RenderText(Label, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Button.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)				
						
					if Selected then
						NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Progress.Background.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Progress.Background.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 0, 0, 0, 255)
					else
						NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Progress.Background.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Progress.Background.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 240, 240, 240, 255)
					end
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Progress.Height

				if Selected and NativeUI.CurrentMenu.Description ~= Description then
					NativeUI.CurrentMenu.Description = Description or ""

					local DescriptionLineCount = NativeUI.GetLineCount(NativeUI.CurrentMenu.Description, NativeUI.CurrentMenu.X + NativeUI.Settings.Items.Description.Text.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Items.Description.Text.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + NativeUI.CurrentMenu.WidthOffset)
						
					if DescriptionLineCount > 1 then
						NativeUI.CurrentMenu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * DescriptionLineCount
					else
						NativeUI.CurrentMenu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height + 7
					end
				end

				if Selected and NativeUI.CurrentMenu.Controls.Left.Active and not NativeUI.CurrentMenu.Controls.Right.Active then
					Index = Index - 1

					if Index < 1 then
						Index = #Items
					end

					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
				elseif Selected and NativeUI.CurrentMenu.Controls.Right.Active and not NativeUI.CurrentMenu.Controls.Left.Active then
					Index = Index + 1

					if Index > #Items then
						Index = 1
					end

					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
				end

				if Selected and (NativeUI.CurrentMenu.Controls.Select.Active or ((Hovered and NativeUI.CurrentMenu.Controls.Click.Active) and not ProgressHovered)) then
					NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)
				elseif Selected and (Hovered and NativeUI.CurrentMenu.Controls.Click.Active and ProgressHovered) then
					local Progress = (math.round(GetControlNormal(0, 239) * 1920) - NativeUI.CurrentMenu.SafeZoneSize.X) - NativeUI.Settings.Items.Progress.Bar.X
					local Barsize = NativeUI.Settings.Items.Progress.Bar.Width + NativeUI.CurrentMenu.WidthOffset

					if Progress > Barsize then
						Progress = Barsize
					elseif Progress < 0 then
						Progress = 0
					end

					Index = math.round(#Items * (Progress/Barsize))

					if Index > #Items or Index < 1 then
						Index = 1
					end
				end

				Callback(Hovered, Selected, ((NativeUI.CurrentMenu.Controls.Select.Active or ((Hovered and NativeUI.CurrentMenu.Controls.Click.Active) and not ProgressHovered)) and Selected), Index)
			end

			NativeUI.Options = NativeUI.Options + 1
		end
	end
end

function NativeUI.GridPanel(X, Y, TopText, BottomText, LeftText, RightText, Callback)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			local Hovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Grid.X + NativeUI.CurrentMenu.SafeZoneSize.X + 20, NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Grid.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset + 20, NativeUI.Settings.Panels.Grid.Grid.Width + NativeUI.CurrentMenu.WidthOffset - 40, NativeUI.Settings.Panels.Grid.Grid.Height - 40)
			local Selected = false
			local CircleX = NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Grid.X + (NativeUI.CurrentMenu.WidthOffset/2) + 20
			local CircleY = NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Grid.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset + 20

			if X < 0.0 or X > 1.0 then
				X = 0.0
			end

			if Y < 0.0 or Y > 1.0 then
				Y = 0.0
			end

			CircleX = CircleX + ((NativeUI.Settings.Panels.Grid.Grid.Width - 40) * X) - (NativeUI.Settings.Panels.Grid.Circle.Width/2)
			CircleY = CircleY + ((NativeUI.Settings.Panels.Grid.Grid.Height - 40) * Y) - (NativeUI.Settings.Panels.Grid.Circle.Height/2)

			NativeUI.RenderSprite(NativeUI.Settings.Panels.Grid.Background.Dictionary, NativeUI.Settings.Panels.Grid.Background.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Background.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Grid.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Panels.Grid.Background.Height)
			NativeUI.RenderSprite(NativeUI.Settings.Panels.Grid.Grid.Dictionary, NativeUI.Settings.Panels.Grid.Grid.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Grid.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Grid.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Grid.Grid.Width, NativeUI.Settings.Panels.Grid.Grid.Height)
			NativeUI.RenderSprite(NativeUI.Settings.Panels.Grid.Circle.Dictionary, NativeUI.Settings.Panels.Grid.Circle.Texture, CircleX, CircleY, NativeUI.Settings.Panels.Grid.Circle.Width, NativeUI.Settings.Panels.Grid.Circle.Height)
			
			NativeUI.RenderText(TopText or "", NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Text.Top.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Text.Top.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Panels.Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
			NativeUI.RenderText(BottomText or "", NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Text.Bottom.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Text.Bottom.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Panels.Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
			NativeUI.RenderText(LeftText or "", NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Text.Left.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Text.Left.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Panels.Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
			NativeUI.RenderText(RightText or "", NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Text.Right.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Text.Right.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Panels.Grid.Text.Right.Scale, 245, 245, 245, 255, 1)

			if Hovered then
				if IsDisabledControlPressed(0, 24) then
					Selected = true

					CircleX = math.round(GetControlNormal(0, 239) * 1920) - NativeUI.CurrentMenu.SafeZoneSize.X - (NativeUI.Settings.Panels.Grid.Circle.Width/2)
					CircleY = math.round(GetControlNormal(0, 240) * 1080) - NativeUI.CurrentMenu.SafeZoneSize.Y - (NativeUI.Settings.Panels.Grid.Circle.Height/2)



					if CircleX > (NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Grid.X + (NativeUI.CurrentMenu.WidthOffset/2) + 20 + NativeUI.Settings.Panels.Grid.Grid.Width - 40) then
						CircleX = NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Grid.X + (NativeUI.CurrentMenu.WidthOffset/2) + 20 + NativeUI.Settings.Panels.Grid.Grid.Width - 40
					elseif CircleX < (NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Grid.X + 20 - (NativeUI.Settings.Panels.Grid.Circle.Width/2)) then
						CircleX = NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Grid.X + 20 - (NativeUI.Settings.Panels.Grid.Circle.Width/2)
					end

					if CircleY > (NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Grid.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset + 20 + NativeUI.Settings.Panels.Grid.Grid.Height - 40) then
						CircleY = NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Grid.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset + 20 + NativeUI.Settings.Panels.Grid.Grid.Height - 40
					elseif CircleY < (NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Grid.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset + 20 - (NativeUI.Settings.Panels.Grid.Circle.Height/2)) then
						CircleY = NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Grid.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset + 20 - (NativeUI.Settings.Panels.Grid.Circle.Height/2)
					end

					X = math.round((CircleX - (NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Grid.X + (NativeUI.CurrentMenu.WidthOffset/2) + 20) + (NativeUI.Settings.Panels.Grid.Circle.Width/2)) / (NativeUI.Settings.Panels.Grid.Grid.Width - 40), 2)
					Y = math.round((CircleY - (NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Grid.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset + 20) + (NativeUI.Settings.Panels.Grid.Circle.Height/2)) / (NativeUI.Settings.Panels.Grid.Grid.Height - 40), 2)

					if X > 1.0 then X = 1.0 end
					if Y > 1.0 then Y = 1.0 end
				end
			end

			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Panels.Grid.Background.Height + NativeUI.Settings.Panels.Grid.Background.Y

			if Hovered and Selected then
				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Slider, true)
			end

			Callback(Hovered, Selected, X, Y)
		end
	end
end

function NativeUI.ColourPanel(Title, Colours, MinimumIndex, CurrentIndex, Callback)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			local Maximum = (#Colours > 9) and 9 or #Colours
			local Hovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Colour.Box.X + NativeUI.CurrentMenu.SafeZoneSize.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Colour.Box.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, (NativeUI.Settings.Panels.Colour.Box.Width * Maximum), NativeUI.Settings.Panels.Colour.Box.Height)
			local LeftArrowHovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Colour.LeftArrow.X + NativeUI.CurrentMenu.SafeZoneSize.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Colour.LeftArrow.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Colour.LeftArrow.Width, NativeUI.Settings.Panels.Colour.LeftArrow.Height) 
			local RightArrowHovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Colour.RightArrow.X + NativeUI.CurrentMenu.SafeZoneSize.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Colour.RightArrow.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Colour.RightArrow.Width, NativeUI.Settings.Panels.Colour.RightArrow.Height) 
			local Selected = false

			NativeUI.RenderSprite(NativeUI.Settings.Panels.Colour.Background.Dictionary, NativeUI.Settings.Panels.Colour.Background.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Colour.Background.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Colour.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Panels.Colour.Background.Height)
			NativeUI.RenderSprite(NativeUI.Settings.Panels.Colour.LeftArrow.Dictionary, NativeUI.Settings.Panels.Colour.LeftArrow.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Colour.LeftArrow.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Colour.LeftArrow.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Colour.LeftArrow.Width, NativeUI.Settings.Panels.Colour.LeftArrow.Height)
			NativeUI.RenderSprite(NativeUI.Settings.Panels.Colour.RightArrow.Dictionary, NativeUI.Settings.Panels.Colour.RightArrow.Texture, NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Colour.RightArrow.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Colour.RightArrow.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Colour.RightArrow.Width, NativeUI.Settings.Panels.Colour.RightArrow.Height)

			NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Colour.SelectedRectangle.X + (NativeUI.Settings.Panels.Colour.Box.Width * (CurrentIndex - MinimumIndex)) + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Colour.SelectedRectangle.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Colour.SelectedRectangle.Width, NativeUI.Settings.Panels.Colour.SelectedRectangle.Height, 245, 245, 245, 255)

			for Index = 1, Maximum do
				NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Colour.Box.X + (NativeUI.Settings.Panels.Colour.Box.Width * (Index - 1)) + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Colour.Box.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Colour.Box.Width, NativeUI.Settings.Panels.Colour.Box.Height, table.unpack(Colours[MinimumIndex + Index - 1]))
			end

			NativeUI.RenderText((Title and Title or "").." ("..CurrentIndex.." of "..#Colours..")", NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Grid.Text.Top.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Grid.Text.Top.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Panels.Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
			
			if Hovered or LeftArrowHovered or RightArrowHovered then
				if NativeUI.Settings.Controls.Click.Active then
					Selected = true

					if LeftArrowHovered then
						CurrentIndex = CurrentIndex - 1

						if CurrentIndex < 1 then
							CurrentIndex = #Colours
							MinimumIndex = #Colours - Maximum + 1
						elseif CurrentIndex < MinimumIndex then
							MinimumIndex = MinimumIndex - 1
						end
					elseif RightArrowHovered then
						CurrentIndex = CurrentIndex + 1

						if CurrentIndex > #Colours then
							CurrentIndex = 1
							MinimumIndex = 1
						elseif CurrentIndex > MinimumIndex + Maximum - 1 then
							MinimumIndex = MinimumIndex + 1
						end
					elseif Hovered then
						for Index = 1, Maximum do
							if NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Colour.Box.X + (NativeUI.Settings.Panels.Colour.Box.Width * (Index - 1)) + NativeUI.CurrentMenu.SafeZoneSize.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Colour.Box.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Colour.Box.Width, NativeUI.Settings.Panels.Colour.Box.Height) then
								CurrentIndex = MinimumIndex + Index - 1
							end
						end
					end
				end
			end	

			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Panels.Colour.Background.Height + NativeUI.Settings.Panels.Colour.Background.Y

			if (Hovered or LeftArrowHovered or RightArrowHovered) and NativeUI.Settings.Controls.Click.Active then
				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)
			end

			Callback((Hovered or LeftArrowHovered or RightArrowHovered), Selected, MinimumIndex, CurrentIndex)
		end
	end
end

function NativeUI.PercentagePanel(Percent, HeaderText, MinText, MaxText, Callback)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			local Hovered = NativeUI.IsMouseInBounds(NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Percentage.Bar.X + NativeUI.CurrentMenu.SafeZoneSize.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Percentage.Bar.Y + NativeUI.CurrentMenu.SafeZoneSize.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset - 4, NativeUI.Settings.Panels.Percentage.Bar.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Panels.Percentage.Bar.Height + 8)
			local Selected = false
			local Progress = NativeUI.Settings.Panels.Percentage.Bar.Width

			if Percent < 0.0 then
				Percent = 0.0
			elseif Percent > 1.0 then
				Percent = 1.0
			end

			Progress = Progress * Percent

			NativeUI.RenderSprite(NativeUI.Settings.Panels.Percentage.Background.Dictionary, NativeUI.Settings.Panels.Percentage.Background.Texture, NativeUI.CurrentMenu.X, NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Percentage.Background.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Percentage.Background.Width + NativeUI.CurrentMenu.WidthOffset, NativeUI.Settings.Panels.Percentage.Background.Height)
			NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Percentage.Bar.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Percentage.Bar.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Panels.Percentage.Bar.Width, NativeUI.Settings.Panels.Percentage.Bar.Height, 87, 87, 87, 255)
			NativeUI.RenderRectangle(NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Percentage.Bar.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Percentage.Bar.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, Progress, NativeUI.Settings.Panels.Percentage.Bar.Height, 245, 245, 245, 255)

			NativeUI.RenderText(HeaderText or "Opacity", NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Percentage.Text.Middle.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Percentage.Text.Middle.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Panels.Percentage.Text.Middle.Scale, 245, 245, 245, 255, 1)
			NativeUI.RenderText(MinText or "0%", NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Percentage.Text.Left.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Percentage.Text.Left.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Panels.Percentage.Text.Left.Scale, 245, 245, 245, 255, 1)
			NativeUI.RenderText(MaxText or "100%", NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Percentage.Text.Right.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.Settings.Panels.Percentage.Text.Right.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Panels.Percentage.Text.Right.Scale, 245, 245, 245, 255, 1)

			if Hovered then
				if IsDisabledControlPressed(0, 24) then
					Selected = true

					Progress = math.round(GetControlNormal(0, 239) * 1920) - NativeUI.CurrentMenu.SafeZoneSize.X - (NativeUI.CurrentMenu.X + NativeUI.Settings.Panels.Percentage.Bar.X + (NativeUI.CurrentMenu.WidthOffset/2))

					if Progress < 0 then
						Progress = 0
					elseif Progress > (NativeUI.Settings.Panels.Percentage.Bar.Width) then
						Progress = NativeUI.Settings.Panels.Percentage.Bar.Width
					end

					Percent = math.round(Progress/NativeUI.Settings.Panels.Percentage.Bar.Width, 2)
				end
			end	

			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Panels.Percentage.Background.Height + NativeUI.Settings.Panels.Percentage.Background.Y

			if Hovered and Selected then
				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Slider, true)
			end

			Callback(Hovered, Selected, Percent)
		end
	end
end

function NativeUI.HeritageWindow(Mum, Dad)
	if NativeUI.CurrentMenu ~= nil then
		if NativeUI.CurrentMenu() then
			if Mum < 0 or Mum > 21 then
				Mum = 0
			end

			if Dad < 0 or Dad > 23 then
				Dad = 0
			end

			if Mum == 21 then
				Mum = "special_female_"..(tonumber(string.sub(Mum, 2, 2)) - 1)
			else
				Mum = "female_"..Mum
			end

			if Dad >= 21 then
				Dad = "special_male_"..(tonumber(string.sub(Dad, 2, 2)) - 1)
			else
				Dad = "male_"..Dad
			end

			NativeUI.RenderSprite(NativeUI.Settings.Windows.Heritage.Background.Dictionary, NativeUI.Settings.Windows.Heritage.Background.Texture, NativeUI.CurrentMenu.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Windows.Heritage.Background.Width, NativeUI.Settings.Windows.Heritage.Background.Height)
			NativeUI.RenderSprite(NativeUI.Settings.Windows.Heritage.Dad.Dictionary, Dad, NativeUI.CurrentMenu.X + NativeUI.Settings.Windows.Heritage.Dad.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Windows.Heritage.Dad.Width, NativeUI.Settings.Windows.Heritage.Dad.Height)
			NativeUI.RenderSprite(NativeUI.Settings.Windows.Heritage.Mum.Dictionary, Mum, NativeUI.CurrentMenu.X + NativeUI.Settings.Windows.Heritage.Mum.X + (NativeUI.CurrentMenu.WidthOffset/2), NativeUI.CurrentMenu.Y + NativeUI.CurrentMenu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Windows.Heritage.Mum.Width, NativeUI.Settings.Windows.Heritage.Mum.Height)

			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Windows.Heritage.Background.Height
		end
	end
end

function NativeUI.Menus:SetTitle(Title)
	self.Title = Title
end

function NativeUI.Menus:SetSubtitle(Subtitle)
	self.Subtitle = Subtitle or self.Subtitle

	if string.starts(self.Subtitle, "~") then
		self.PageCounterColour = string.sub(self.Subtitle, 1, 3)
	else
		self.PageCounterColour = ""
	end

	if self.Subtitle ~= "" then
		local SubtitleLineCount = NativeUI.GetLineCount(self.Subtitle, self.X + NativeUI.Settings.Items.Subtitle.Text.X, self.Y + NativeUI.Settings.Items.Subtitle.Text.Y, 0, NativeUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, NativeUI.Settings.Items.Subtitle.Background.Width + self.WidthOffset)

		if SubtitleLineCount > 1 then
			self.SubtitleHeight = 18 * SubtitleLineCount
		else
			self.SubtitleHeight = 0
		end
	else
		self.SubtitleHeight = -37
	end
end

function NativeUI.Menus:SetPosition(X, Y)
	self.X = tonumber(X) or self.X
	self.Y = tonumber(Y) or self.Y
end

function NativeUI.Menus:SetTotalItemsPerPage(Value)
	self.Pagination.Total = tonumber(Value) or self.Pagination.Total
end

function NativeUI.Menus:SetRectangleBanner(R, G, B, A)
	self.Rectangle = {R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255}
	self.Sprite = nil
end

function NativeUI.Menus:SetSpriteBanner(TextureDictionary, Texture)
	self.Sprite = {Dictionary = TextureDictionary or "commonmenu", Texture = Texture or "interaction_bgd"}
	self.Rectangle = nil
end

Citizen.CreateThread(function()
	local NewMenu = NativeUI.CreateMenu("Title", "Subtitle", 1920/2 - (431/2) - 100, 0)
	NewMenu.Safezone = true
	NewMenu.WidthOffset = 100

	local NewMenu2 = NativeUI.CreateSubMenu(NewMenu, "Title2", "Subtitle2")
	NewMenu2:SetSubtitle("LOLLLLLLLLLLLLLLLLLLLLLLLLLLL")
	local Indexes = {1,1,2,1,1,1}
	local Checkedboxes = {true, false, true}
	local Grid = {X = 0.5, Y = 0.5}
	local Percentage = 0.5
	local Colour = {1,1}
	local Mum, Dad = 0, 0

	while true do
		Citizen.Wait(0)

		if IsControlJustPressed(1, 51) then
			NativeUI.Visible(NewMenu, not NativeUI.Visible(NewMenu))
		end

		if NativeUI.Visible(NewMenu) then
			ShowCursorThisFrame()

			--NativeUI.Title()
			NativeUI.Subtitle()

			--NativeUI.HeritageWindow(Mum, Dad)

			NativeUI.List("List", {1, 2, 3}, Indexes[1], "Save your current settings. All saving is done on the client side, if you re-install windows you will lose your settings. Settings are shared across all servers using vMenu.", true, function(Hovered, Active, Selected, Index)
				Indexes[1] = Index
			end)

			NativeUI.List("List", {0, 0, 0}, Indexes[2], "Save your current settings. All saving is done on the client side, if you re-install windows you will lose your settings. Settings are shared across all servers using vMenu.", true, function(Hovered, Active, Selected, Index)
				Indexes[2] = Index
			end)

			NativeUI.Button("HelloHello", "LMAO", "WorldWorld", NativeUI.BadgeStyle.BronzeMedal, NativeUI.BadgeStyle.GoldMedal, true, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello") end
			end, NewMenu2)

			NativeUI.Button("Hello", "LMAO", "World", NativeUI.BadgeStyle.BronzeMedal, nil, false, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello2") end
			end)

			NativeUI.Button("Hello", "LMAO", "World", NativeUI.BadgeStyle.BronzeMedal, nil, false, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello2") end
			end)

			NativeUI.Button("Hello", "LMAO", "World", NativeUI.BadgeStyle.BronzeMedal, nil, false, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello2") end
			end)

			NativeUI.Button("Hello", "LMAO", "World", NativeUI.BadgeStyle.BronzeMedal, nil, false, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello2") end
			end)

			NativeUI.Button("Hello", "LMAO", "World", NativeUI.BadgeStyle.BronzeMedal, nil, false, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello2") end
			end)

			NativeUI.Button("Hello", "LMAO", "World", NativeUI.BadgeStyle.BronzeMedal, nil, false, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello2") end
			end)

			NativeUI.Button("Hello", "LMAO", "World", NativeUI.BadgeStyle.BronzeMedal, nil, false, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello2") end
			end)

			NativeUI.Checkbox("Meep", "LMAO", Checkedboxes[1], true, function(Hovered, Active, Selected, Checked)
				if Selected then
					Checkedboxes[1] = Checked
				end
			end)

			NativeUI.Checkbox("Meep", "LMAO", Checkedboxes[2], true, function(Hovered, Active, Selected, Checked)
				if Selected then
					Checkedboxes[2] = Checked
				end
			end)

			NativeUI.Checkbox("Meep", "LMAO", Checkedboxes[3], false, function(Hovered, Active, Selected, Checked)
				if Selected then
					Checkedboxes[3] = Checked
				end
			end)
			
			NativeUI.Background()

			NativeUI.Navigation()

			NativeUI.Description()

			--[[
			NativeUI.GridPanel(Grid.X, Grid.Y, "TopText", "BottomText", "LeftText", "RightText", function(Hovered, Active, X, Y)
				Grid.X = X
				Grid.Y = Y
			end)

			NativeUI.PercentagePanel(Percentage, nil, nil, nil, function(Hovered, Active, Percent)
				Percentage = Percent
			end)

			NativeUI.ColourPanel("Colour", {{255, 0, 0}, {0, 255, 0}, {255, 255, 0}, {0, 255, 255}, {255, 0, 0}, {0, 255, 0}, {255, 255, 0}, {0, 255, 255}, {255, 255, 0}, {0, 255, 255}}, Colour[1], Colour[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
				Colour[1] = MinimumIndex
				Colour[2] = CurrentIndex
			end)
			--]]
			NativeUI.Render()
		elseif NativeUI.Visible(NewMenu2) then
			ShowCursorThisFrame()

			NativeUI.Title()
			NativeUI.Subtitle()
			NativeUI.Button("Hello", "LMAO", "World", NativeUI.BadgeStyle.BronzeMedal, nil, false, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello2") end
			end)
			NativeUI.Background()
			NativeUI.Navigation()
			NativeUI.Description()
			NativeUI.Render()
		end
	end
end)
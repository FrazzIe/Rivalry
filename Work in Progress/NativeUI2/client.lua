--[[
	TODO:
	 - Make Description calcs only when an option on a key press
--]]
NativeUI = {}
NativeUI.Menus = {
	__call = function() return "Menu" end,
}
NativeUI.CurrentMenu = nil
NativeUI.Options = 0
NativeUI.ItemOffset = 0
NativeUI.Settings = {
	Controls = {
		Up = {
			Enabled = true,
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
			Keys = {
				{0, 175},
				{1, 175},
				{2, 175},
			},
		},
		Select = {
			Enabled = true,
			Pressed = false,
			Keys = {
				{0, 201},
				{1, 201},
				{2, 201},
			},
		},
		Back = {
			Enabled = true,
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
	},
	Items = {
		Title = {
			Background = {Width = 431, Height = 107},
			Text = {X = 215, Y = 20, Scale = 1.15},
		},
		Subtitle = {
			Background = {Y = 107, Width = 431, Height = 37},
			Text = {X = 8, Y = 110, Scale = 0.35},
			PreText = {X = 425, Y = 110, Scale = 0.35},
		},
		Background = {Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 144, Width = 431},
		Description = {
			Bar = {Y = 149, Width = 431, Height = 4},
			Background = {Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 149, Width = 431, Height = 30},
			Text = {X = 8, Y = 155, Scale = 0.35},
		},
		Button = {
			Rectangle = {Y = 144, Width = 431, Height = 38},
			Text = {X = 8, Y = 147, Scale = 0.33},
			LeftBadge = {Y = 142, Width = 40, Height = 40},
			RightBadge = {X = 385, Y = 142, Width = 40, Height = 40},
			RightText = {X = 420, Y = 148, Scale = 0.35},
			SelectedSprite = {Dictionary = "commonmenu", Texture = "gradient_nav", Y = 144, Width = 431, Height = 38},
		},
		Checkbox = {Dictionary = "commonmenu", Textures = {"shop_box_blankb", "shop_box_tickb", "shop_box_blank", "shop_box_tick"}, X = 380, Y = 138, Width = 50, Height = 50},
		List = {
			LeftArrow = {Dictionary = "commonmenu", Texture = "arrowleft", X = 378, Y = 147, Width = 30, Height = 30},
			RightArrow = {Dictionary = "commonmenu", Texture = "arrowright", X = 400, Y = 147, Width = 30, Height = 30},
			Text = {X = 403, Y = 147, Scale = 0.35},
		},
		Slider = {
			Background = {X = 250, Y = 158.5, Width = 150, Height = 9},
			Slider = {X = 250, Y = 158.5, Width = 75, Height = 9},
			Divider = {X = 323.5, Y = 153, Width = 2.5, Height = 20},
			LeftArrow = {Dictionary = "commonmenutu", Texture = "arrowleft", X = 235, Y = 155.5, Width = 15, Height = 15},
			RightArrow = {Dictionary = "commonmenutu", Texture = "arrowright", X = 400, Y = 155.5, Width = 15, Height = 15},
		},
		Progress = {
			Background = {X = 8, Y = 177, Width = 415, Height = 20},
			Bar = {X = 11.75, Y = 180.75, Width = 407.5, Height = 12.5},
			Height = 60
		},
	},
}

function string.starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
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

    if tonumber(WordWrap) then
        if tonumber(WordWrap) ~= 0 then
        	if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
        		SetTextWrap(X - ((WordWrap/1920)/2), X + ((WordWrap/1920)/2))
        	elseif Alignment == 2 or Alignment == "Right" then
        		SetTextWrap(0, X)
        	else
        		SetTextWrap(X, X + (WordWrap/1920))
        	end
        end
    end

    BeginTextCommandDisplayText("STRING")
    AddLongString(Text) 
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

    if tonumber(WordWrap) then
        if tonumber(WordWrap) ~= 0 then
        	if Alignment == 1 or Alignment == "Center" or Alignment == "Centre" then
        		SetTextWrap(X - ((WordWrap/1920)/2), X + ((WordWrap/1920)/2))
        	elseif Alignment == 2 or Alignment == "Right" then
        		SetTextWrap(0, X)
        	else
        		SetTextWrap(X, X + (WordWrap/1920))
        	end
        end
    end

	BeginTextCommandLineCount("STRING")
	AddLongString(Text)
	return GetTextScreenLineCount(X, Y)
end

function NativeUI.CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName)
	local Menu = {}

	Menu.Title = Title or ""
	Menu.Subtitle = Subtitle or ""
	Menu.Description = ""
	Menu.X = X or 0
	Menu.Y = Y or 0
	Menu.Parent = nil
	Menu.WidthOffset = 0
	Menu.Controls = NativeUI.Settings.Controls
	Menu.Open = false
	Menu.Controls = {}
	Menu.Index = 1
	Menu.Sprite = {Dictionary = TextureDictionary or "commonmenu", Texture = Texture or "interaction_bgd"}
	Menu.Rectangle = nil
	Menu.Pagination = {Minimum = 0, Maximum = 9, Total = 9}
	Menu.Safezone = false

	if string.starts(Menu.Subtitle, "~") then
		Menu.PageCounterColour = string.sub(Menu.Subtitle, 1, 3)
	else
		Menu.PageCounterColour = ""
	end

	return setmetatable(Menu, NativeUI.Menus)
end

function NativeUI.Visible(Menu, Value)
	if Menu ~= nil then
		if Menu() == "Menu" then
			if type(Value) == "boolean" then
				Menu.Open = Value

				if Menu.Open then
					NativeUI.CurrentMenu = Menu
					NativeUI.Options = 0
					NativeUI.ItemOffset = 0
				else
					if Menu.Parent ~= nil then
						if Menu.Parent() == "Menu" then
							NativeUI.CurrentMenu = Menu.Parent
						else
							NativeUI.CurrentMenu = nil
						end
					else
						NativeUI.CurrentMenu = nil
					end
				end
			else
				return Menu.Open
			end
		end
	end
end

function NativeUI.Title(Menu)
	if Menu ~= nil then
		if Menu() == "Menu" then
			if Menu.Safezone then
				ScreenDrawPositionBegin(76, 84)
				ScreenDrawPositionRatio(0, 0, 0, 0)
			end

			if Menu.Sprite then
				NativeUI.RenderSprite(Menu.Sprite.Dictionary, Menu.Sprite.Texture, Menu.X, Menu.Y, NativeUI.Settings.Items.Title.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Title.Background.Height)
			else
				NativeUI.RenderRectangle(Menu.X, Menu.Y, NativeUI.Settings.Items.Title.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Title.Background.Height, Menu.Rectangle.R, Menu.Rectangle.G, Menu.Rectangle.B, Menu.Rectangle.A)
			end

			NativeUI.RenderText(Menu.Title, Menu.X + NativeUI.Settings.Items.Title.Text.X + (Menu.WidthOffset/2), Menu.Y + NativeUI.Settings.Items.Title.Text.Y, 1, NativeUI.Settings.Items.Title.Text.Scale, 255, 255, 255, 255, 1)

			if Menu.Subtitle ~= "" then
				NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Subtitle.Background.Y,  NativeUI.Settings.Items.Subtitle.Background.Width + Menu.WidthOffset,  NativeUI.Settings.Items.Subtitle.Background.Height, 0, 0, 0, 255)
				NativeUI.RenderText(Menu.Subtitle, Menu.X + NativeUI.Settings.Items.Subtitle.Text.X, Menu.Y + NativeUI.Settings.Items.Subtitle.Text.Y, 0, NativeUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255)
				
				if NativeUI.Options >= Menu.Pagination.Total + 1 then
					NativeUI.RenderText(Menu.PageCounterColour..Menu.Index.." / "..NativeUI.Options, Menu.X + NativeUI.Settings.Items.Subtitle.PreText.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Subtitle.PreText.Y, 0, NativeUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
				end
			end

			if Menu.Safezone then
				ScreenDrawPositionEnd()
			end
		end
	end
end

function NativeUI.Background(Menu)
	if Menu ~= nil then
		if Menu() == "Menu" then
			if Menu.Safezone then
				ScreenDrawPositionBegin(76, 84)
				ScreenDrawPositionRatio(0, 0, 0, 0)
			end

			SetUiLayer(0)
			NativeUI.RenderSprite(NativeUI.Settings.Items.Background.Dictionary, NativeUI.Settings.Items.Background.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Background.Y, NativeUI.Settings.Items.Background.Width + Menu.WidthOffset, NativeUI.ItemOffset, 0, 0, 0, 255)
			SetUiLayer(1)

			if Menu.Safezone then
				ScreenDrawPositionEnd()
			end
		end
	end
end

function NativeUI.Description(Menu)
	if Menu ~= nil then
		if Menu() == "Menu" then
			local DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * NativeUI.GetLineCount(Menu.Description, Menu.X + NativeUI.Settings.Items.Description.Text.X, Menu.Y + NativeUI.Settings.Items.Description.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + Menu.WidthOffset)
			
			if Menu.Safezone then
				ScreenDrawPositionBegin(76, 84)
				ScreenDrawPositionRatio(0, 0, 0, 0)
			end

			NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Description.Bar.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Description.Bar.Width + Menu.WidthOffset, NativeUI.Settings.Items.Description.Bar.Height, 0, 0, 0, 255)
			NativeUI.RenderSprite(NativeUI.Settings.Items.Description.Background.Dictionary, NativeUI.Settings.Items.Description.Background.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Description.Background.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Description.Background.Width + Menu.WidthOffset, DescriptionHeight, 0, 0, 0, 255)
			NativeUI.RenderText(Menu.Description, Menu.X + NativeUI.Settings.Items.Description.Text.X, Menu.Y + NativeUI.Settings.Items.Description.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + Menu.WidthOffset)

			if Menu.Safezone then
				ScreenDrawPositionEnd()
			end

			NativeUI.ItemOffset = NativeUI.ItemOffset + DescriptionHeight
		end
	end
end

function NativeUI.Render(Menu)
	if Menu ~= nil then
		if Menu() == "Menu" then
			NativeUI.Title(Menu)
			NativeUI.Background(Menu)
			NativeUI.Description(Menu)
			
			NativeUI.Options = 0
			NativeUI.ItemOffset = 0
		end
	end
end

function NativeUI.Button(Menu, Label, Description, RightLabel, LeftBadge, RightBadge, Enabled)
	if Menu ~= nil then
		if Menu() == "Menu" then
			local Selected = Menu.Index == (NativeUI.Options + 1)
			local SafeZone = {X = 0, Y = 0}
			
			if Menu.Safezone then
				SafeZone = GetSafeZoneBounds()

				ScreenDrawPositionBegin(76, 84)
				ScreenDrawPositionRatio(0, 0, 0, 0)
			end

			local Hovered = IsMouseInBounds(Menu.X + SafeZone.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + SafeZone.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)
			local LeftBadgeOffset = ((LeftBadge == NativeUI.BadgeStyle.None or tonumber(LeftBadge) == nil) and 0 or 27)
			local RightBadgeOffset =  ((RightBadge == NativeUI.BadgeStyle.None or tonumber(RightBadge) == nil) and 0 or 27)

			if Hovered and not Selected then
				NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)
			end

			if Selected then
				NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
			end

			if LeftBadge ~= NativeUI.BadgeStyle.None and tonumber(LeftBadge) ~= nil then
				NativeUI.RenderSprite(NativeUI.GetBadgeDictionary(LeftBadge, Selected), NativeUI.GetBadgeTexture(LeftBadge, Selected), Menu.X, Menu.Y + NativeUI.Settings.Items.Button.LeftBadge.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.LeftBadge.Width, NativeUI.Settings.Items.Button.LeftBadge.Height, NativeUI.GetBadgeColour(LeftBadge, Selected))
			end

			if RightBadge ~= NativeUI.BadgeStyle.None and tonumber(RightBadge) ~= nil then
				NativeUI.RenderSprite(NativeUI.GetBadgeDictionary(RightBadge, Selected), NativeUI.GetBadgeTexture(RightBadge, Selected), Menu.X + NativeUI.Settings.Items.Button.RightBadge.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightBadge.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.RightBadge.Width, NativeUI.Settings.Items.Button.RightBadge.Height, NativeUI.GetBadgeColour(RightBadge, Selected))
			end

			if Enabled == true or Enabled == nil then
				if Selected then
					if RightLabel ~= nil and RightLabel ~= "" then
						NativeUI.RenderText(RightLabel, Menu.X + NativeUI.Settings.Items.Button.RightText.X - RightBadgeOffset + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 0, 0, 0, 255, 2)
					end

					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)
				else
					if RightLabel ~= nil and RightLabel ~= "" then
						NativeUI.RenderText(RightLabel, Menu.X + NativeUI.Settings.Items.Button.RightText.X - RightBadgeOffset + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 245, 245, 245, 255, 2)
					end

					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
				end
			else
				if RightLabel ~= nil and RightLabel ~= "" then
					NativeUI.RenderText(RightLabel, Menu.X + NativeUI.Settings.Items.Button.RightText.X - RightBadgeOffset + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 163, 159, 148, 255, 2)
				end

				NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)
			end

			if Menu.Safezone then
				ScreenDrawPositionEnd()
			end

			if Selected then
				Menu.Description = Description or ""
			end

			NativeUI.Options = NativeUI.Options + 1
			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height
		end
	end
end

function NativeUI.Checkbox(Menu, Label, Description, Checked, Enabled)
	if Menu ~= nil then
		if Menu() == "Menu" then
			local Selected = Menu.Index == (NativeUI.Options + 1)
			local SafeZone = {X = 0, Y = 0}
			
			if Menu.Safezone then
				SafeZone = GetSafeZoneBounds()

				ScreenDrawPositionBegin(76, 84)
				ScreenDrawPositionRatio(0, 0, 0, 0)
			end

			local Hovered = IsMouseInBounds(Menu.X + SafeZone.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + SafeZone.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)

			if Hovered and not Selected then
				NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)
			end

			if Selected then
				NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
			end

			if Enabled == true or Enabled == nil then
				if Selected then
					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)
				else
					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
				end
			else
				NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)
			end

			if Selected then
				if Checked then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[1], Menu.X + NativeUI.Settings.Items.Checkbox.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Checkbox.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
				else
					NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[2], Menu.X + NativeUI.Settings.Items.Checkbox.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Checkbox.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
				end
			else
				if Checked then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[3], Menu.X + NativeUI.Settings.Items.Checkbox.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Checkbox.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
				else
					NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[4], Menu.X + NativeUI.Settings.Items.Checkbox.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Checkbox.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
				end
			end

			if Menu.Safezone then
				ScreenDrawPositionEnd()
			end

			if Selected then
				Menu.Description = Description or ""
			end

			NativeUI.Options = NativeUI.Options + 1
			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height
		end
	end
end

function NativeUI.List(Menu, Label, Items, Index, Description, Enabled)
	if Menu ~= nil then
		if Menu() == "Menu" then
			local Selected = Menu.Index == (NativeUI.Options + 1)
			local SafeZone = {X = 0, Y = 0}

			if Menu.Safezone then
				SafeZone = GetSafeZoneBounds()

				ScreenDrawPositionBegin(76, 84)
				ScreenDrawPositionRatio(0, 0, 0, 0)
			end

			local Hovered = IsMouseInBounds(Menu.X + SafeZone.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + SafeZone.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)
			local ListText = (type(Items[Index]) == "table") and tostring(Items[Index].Name) or tostring(Items[Index]) or "NIL"
			local TextOffset = MeasureStringWidth(ListText, 0, 0.35)

			if Hovered and not Selected then
				NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)
			end

			if Selected then
				NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
			end

			if Enabled == true or Enabled == nil then
				if Selected then
					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)

					NativeUI.RenderSprite(NativeUI.Settings.Items.List.LeftArrow.Dictionary, NativeUI.Settings.Items.List.LeftArrow.Texture, Menu.X + NativeUI.Settings.Items.List.LeftArrow.X - TextOffset + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.LeftArrow.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.List.LeftArrow.Width, NativeUI.Settings.Items.List.LeftArrow.Height, 0, 0, 0, 0, 255)
					NativeUI.RenderSprite(NativeUI.Settings.Items.List.RightArrow.Dictionary, NativeUI.Settings.Items.List.RightArrow.Texture, Menu.X + NativeUI.Settings.Items.List.RightArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.RightArrow.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.List.RightArrow.Width, NativeUI.Settings.Items.List.RightArrow.Height, 0, 0, 0, 0, 255)
					
					NativeUI.RenderText(ListText, Menu.X + NativeUI.Settings.Items.List.Text.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 0, 0, 0, 255, 2)
				else
					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
					
					NativeUI.RenderText(ListText, Menu.X + NativeUI.Settings.Items.List.Text.X + 15 + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 245, 245, 245, 255, 2)
				end
			else
				NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)
				
				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.List.LeftArrow.Dictionary, NativeUI.Settings.Items.List.LeftArrow.Texture, Menu.X + NativeUI.Settings.Items.List.LeftArrow.X - TextOffset + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.LeftArrow.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.List.LeftArrow.Width, NativeUI.Settings.Items.List.LeftArrow.Height, 0, 163, 159, 148, 255)
					NativeUI.RenderSprite(NativeUI.Settings.Items.List.RightArrow.Dictionary, NativeUI.Settings.Items.List.RightArrow.Texture, Menu.X + NativeUI.Settings.Items.List.RightArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.RightArrow.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.List.RightArrow.Width, NativeUI.Settings.Items.List.RightArrow.Height, 0, 163, 159, 148, 255)

					NativeUI.RenderText(ListText, Menu.X + NativeUI.Settings.Items.List.Text.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 163, 159, 148, 255, 2)
				else
					NativeUI.RenderText(ListText, Menu.X + NativeUI.Settings.Items.List.Text.X + 15 + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 163, 159, 148, 255, 2)
				end
			end

			if Menu.Safezone then
				ScreenDrawPositionEnd()
			end

			if Selected then
				Menu.Description = Description or ""
			end

			NativeUI.Options = NativeUI.Options + 1
			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height
		end
	end
end

function NativeUI.Slider(Menu, Label, Items, Index, Description, Divider, Enabled)
	if Menu ~= nil then
		if Menu() == "Menu" then
			local Selected = Menu.Index == (NativeUI.Options + 1)
			local SafeZone = {X = 0, Y = 0}
			
			if Menu.Safezone then
				SafeZone = GetSafeZoneBounds()

				ScreenDrawPositionBegin(76, 84)
				ScreenDrawPositionRatio(0, 0, 0, 0)
			end

			local Hovered = IsMouseInBounds(Menu.X + SafeZone.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + SafeZone.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)

			if Hovered and not Selected then
				NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)
			end

			if Selected then
				NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
			end

			if Enabled == true or Enabled == nil then
				if Selected then
					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)

					NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.LeftArrow.Dictionary, NativeUI.Settings.Items.Slider.LeftArrow.Texture, Menu.X + NativeUI.Settings.Items.Slider.LeftArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.LeftArrow.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.LeftArrow.Width, NativeUI.Settings.Items.Slider.LeftArrow.Height, 0, 0, 0, 0, 255)
					NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.RightArrow.Dictionary, NativeUI.Settings.Items.Slider.RightArrow.Texture, Menu.X + NativeUI.Settings.Items.Slider.RightArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.RightArrow.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.RightArrow.Width, NativeUI.Settings.Items.Slider.RightArrow.Height, 0, 0, 0, 0, 255)
				else
					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)

					NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.LeftArrow.Dictionary, NativeUI.Settings.Items.Slider.LeftArrow.Texture, Menu.X + NativeUI.Settings.Items.Slider.LeftArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.LeftArrow.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.LeftArrow.Width, NativeUI.Settings.Items.Slider.LeftArrow.Height, 245, 245, 245, 255)
					NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.RightArrow.Dictionary, NativeUI.Settings.Items.Slider.RightArrow.Texture, Menu.X + NativeUI.Settings.Items.Slider.RightArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.RightArrow.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.RightArrow.Width, NativeUI.Settings.Items.Slider.RightArrow.Height, 245, 245, 245, 255)
				end
			else
				NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.LeftArrow.Dictionary, NativeUI.Settings.Items.Slider.LeftArrow.Texture, Menu.X + NativeUI.Settings.Items.Slider.LeftArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.LeftArrow.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.LeftArrow.Width, NativeUI.Settings.Items.Slider.LeftArrow.Height, 163, 159, 148, 255)
					NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.RightArrow.Dictionary, NativeUI.Settings.Items.Slider.RightArrow.Texture, Menu.X + NativeUI.Settings.Items.Slider.RightArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.RightArrow.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.RightArrow.Width, NativeUI.Settings.Items.Slider.RightArrow.Height, 163, 159, 148, 255)
				end
			end

			NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Slider.Background.X, Menu.Y + NativeUI.Settings.Items.Slider.Background.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Slider.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Slider.Background.Height, 255, 255, 255, 20)
			NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Slider.Slider.X + (((NativeUI.Settings.Items.Slider.Background.Width - NativeUI.Settings.Items.Slider.Slider.Width)/(#Items - 1)) * (Index - 1)), Menu.Y + NativeUI.Settings.Items.Slider.Slider.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Slider.Slider.Width + Menu.WidthOffset, NativeUI.Settings.Items.Slider.Slider.Height, 255, 255, 255, 20)
			
			if Divider then
				NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Slider.Divider.X, Menu.Y + NativeUI.Settings.Items.Slider.Divider.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Slider.Divider.Width + Menu.WidthOffset, NativeUI.Settings.Items.Slider.Divider.Height, 255, 255, 255, 20)
			end

			if Menu.Safezone then
				ScreenDrawPositionEnd()
			end

			if Selected then
				Menu.Description = Description or ""
			end

			NativeUI.Options = NativeUI.Options + 1
			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height
		end
	end
end

function NativeUI.Progress(Menu, Label, Items, Index, Description, Counter, Enabled)
	if Menu ~= nil then
		if Menu() == "Menu" then
			local Selected = Menu.Index == (NativeUI.Options + 1)
			local SafeZone = {X = 0, Y = 0}

			if Menu.Safezone then
				SafeZone = GetSafeZoneBounds()

				ScreenDrawPositionBegin(76, 84)
				ScreenDrawPositionRatio(0, 0, 0, 0)
			end

			local Hovered = IsMouseInBounds(Menu.X + SafeZone.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + SafeZone.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Height)
			local ProgressText = (Counter and Index.."/"..#Items or (type(Items[Index]) == "table") and tostring(Items[Index].Name) or tostring(Items[Index]))

			if Hovered and not Selected then
				NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Height, 255, 255, 255, 20)
			end

			if Selected then
				NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Height)
			end

			if Enabled == true or Enabled == nil then
				if Selected then
					NativeUI.RenderText(ProgressText, Menu.X + NativeUI.Settings.Items.Button.RightText.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 0, 0, 0, 255, 2)

					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)

					NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Background.X, Menu.Y + NativeUI.Settings.Items.Progress.Background.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 0, 0, 0, 255)
					NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Bar.X, Menu.Y + NativeUI.Settings.Items.Progress.Bar.Y + NativeUI.ItemOffset, ((Index/#Items) * NativeUI.Settings.Items.Progress.Bar.Width) + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Bar.Height, 240, 240, 240, 255)
				else
					NativeUI.RenderText(ProgressText, Menu.X + NativeUI.Settings.Items.Button.RightText.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 245, 245, 245, 255, 2)

					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)

					NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Background.X, Menu.Y + NativeUI.Settings.Items.Progress.Background.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 240, 240, 240, 255)
					NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Bar.X, Menu.Y + NativeUI.Settings.Items.Progress.Bar.Y + NativeUI.ItemOffset, ((Index/#Items) * NativeUI.Settings.Items.Progress.Bar.Width) + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Bar.Height, 0, 0, 0, 255)
				end
			else
				NativeUI.RenderText(ProgressText, Menu.X + NativeUI.Settings.Items.Button.RightText.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 163, 159, 148, 255, 2)

				NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)				
				
				if Selected then
					NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Background.X, Menu.Y + NativeUI.Settings.Items.Progress.Background.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 0, 0, 0, 255)
				else
					NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Background.X, Menu.Y + NativeUI.Settings.Items.Progress.Background.Y + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 240, 240, 240, 255)
				end
			end

			if Menu.Safezone then
				ScreenDrawPositionEnd()
			end

			if Selected then
				Menu.Description = Description or ""
			end

			NativeUI.Options = NativeUI.Options + 1
			NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Progress.Height
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Menu = NativeUI.CurrentMenu
		if Menu ~= nil then
			if Menu() == "Menu" then
				if Menu.Open then
					for Index = 1, #Menu.Controls.Up.Keys do
						if IsControlPressed(Menu.Controls.Up.Keys[Index][1], Menu.Controls.Up.Keys[Index][2]) then
							break
						end
					end

					for Index = 1, #Menu.Controls.Down.Keys do
						if IsControlPressed(Menu.Controls.Down.Keys[Index][1], Menu.Controls.Down.Keys[Index][2]) then
							break
						end
					end

					for Index = 1, #Menu.Controls.Left.Keys do
						if IsControlPressed(Menu.Controls.Left.Keys[Index][1], Menu.Controls.Left.Keys[Index][2]) then
							break
						end
					end

					for Index = 1, #Menu.Controls.Right.Keys do
						if IsControlPressed(Menu.Controls.Right.Keys[Index][1], Menu.Controls.Right.Keys[Index][2]) then
							break
						end
					end

					for Index = 1, #Menu.Controls.Select.Keys do
						if IsControlPressed(Menu.Controls.Select.Keys[Index][1], Menu.Controls.Select.Keys[Index][2]) then
							break
						end
					end

					for Index = 1, #Menu.Controls.Up.Keys do
						if IsControlPressed(Menu.Controls.Back.Keys[Index][1], Menu.Controls.Back.Keys[Index][2]) then
							break
						end
					end
				end
			end
		end
	end
end)
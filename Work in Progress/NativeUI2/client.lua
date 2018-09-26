NativeUI = {}
NativeUI.Menus = {__call = function() return true end}
NativeUI.CurrentMenu = nil
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

function NativeUI.PlaySound(Library, Sound)
	PlaySoundFrontend(-1, Sound, Library, true)
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
	Menu.SafeZoneSize = {X = 0, Y = 0}

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
					if Menu.Parent ~= nil then
						if Menu.Parent() then
							NativeUI.Visible(Menu.Parent, true)
						else
							NativeUI.CurrentMenu = nil
							NativeUI.Options = 0
							NativeUI.ItemOffset = 0
						end
					else
						NativeUI.CurrentMenu = nil
						NativeUI.Options = 0
						NativeUI.ItemOffset = 0
					end
				end
			else
				return Menu.Open
			end
		end
	end
end

function NativeUI.GoUp(Menu, Options)
	if Menu ~= nil then
		if Menu() then
			if Options > Menu.Pagination.Total then
				if Menu.Index <= Menu.Pagination.Minimum then
					if Menu.Index == 1 then
						Menu.Pagination.Minimum = Options - (Menu.Pagination.Total - 1)
						Menu.Pagination.Maximum = Options
						Menu.Index = Options
					else
						Menu.Pagination.Minimum = Menu.Pagination.Minimum - 1
						Menu.Pagination.Maximum = Menu.Pagination.Maximum - 1
						Menu.Index = Menu.Index - 1
					end
				else
					Menu.Index = Menu.Index - 1
				end
			else
				if Menu.Index == 1 then
					Menu.Pagination.Minimum = Options - (Menu.Pagination.Total - 1)
					Menu.Pagination.Maximum = Options
					Menu.Index = Options
				else
					Menu.Index = Menu.Index - 1
				end
			end

			NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.UpDown)
		end
	end
end

function NativeUI.GoDown(Menu, Options)
	if Menu ~= nil then
		if Menu() then
			if Options > Menu.Pagination.Total then
				if Menu.Index >= Menu.Pagination.Maximum then
					if Menu.Index == Options then
						Menu.Pagination.Minimum = 1
						Menu.Pagination.Maximum = Menu.Pagination.Total
						Menu.Index = 1
					else
						Menu.Pagination.Maximum = Menu.Pagination.Maximum + 1
						Menu.Pagination.Minimum = Menu.Pagination.Maximum - (Menu.Pagination.Total - 1)
						Menu.Index = Menu.Index + 1
					end
				else
					Menu.Index = Menu.Index + 1
				end
			else
				if Menu.Index == Options then
					Menu.Pagination.Minimum = 1
					Menu.Pagination.Maximum = Menu.Pagination.Total
					Menu.Index = 1
				else
					Menu.Index = Menu.Index + 1
				end
			end

			NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.UpDown)
		end
	end
end

function NativeUI.Controls(Menu)
	if Menu.Open then
		local Options = NativeUI.Options

		DisableAllControlActions(2)

        if Controller() then
            for Index = 1, #Menu.Controls.Enabled.Controller do
                EnableControlAction(Menu.Controls.Enabled.Controller[Index][1], Menu.Controls.Enabled.Controller[Index][2], true)
            end
        else
            for Index = 1, #Menu.Controls.Enabled.Keyboard do
                EnableControlAction(Menu.Controls.Enabled.Keyboard[Index][1], Menu.Controls.Enabled.Keyboard[Index][2], true)
            end
        end
        
		if Menu.Controls.Up.Enabled then
			for Index = 1, #Menu.Controls.Up.Keys do
				if not Menu.Controls.Up.Pressed then
					if IsControlPressed(Menu.Controls.Up.Keys[Index][1], Menu.Controls.Up.Keys[Index][2]) then
						Menu.Controls.Up.Pressed = true

						Citizen.CreateThread(function()
							NativeUI.GoUp(Menu, Options)

							Citizen.Wait(175)

							while Menu.Controls.Up.Enabled and IsControlPressed(Menu.Controls.Up.Keys[Index][1], Menu.Controls.Up.Keys[Index][2]) do
								NativeUI.GoUp(Menu, Options)

								Citizen.Wait(125)
							end

							Menu.Controls.Up.Pressed = false
						end)

						break
					end
				end
			end
		end

		if Menu.Controls.Down.Enabled then
			for Index = 1, #Menu.Controls.Down.Keys do
				if not Menu.Controls.Down.Pressed then
					if IsControlPressed(Menu.Controls.Down.Keys[Index][1], Menu.Controls.Down.Keys[Index][2]) then
						Menu.Controls.Down.Pressed = true

						Citizen.CreateThread(function()
							NativeUI.GoDown(Menu, Options)

							Citizen.Wait(175)
										
							while Menu.Controls.Down.Enabled and IsControlPressed(Menu.Controls.Down.Keys[Index][1], Menu.Controls.Down.Keys[Index][2]) do
								NativeUI.GoDown(Menu, Options)
											
								Citizen.Wait(125)
							end

							Menu.Controls.Down.Pressed = false
						end)

						break
					end
				end
			end
		end

		if Menu.Controls.Left.Enabled then
			for Index = 1, #Menu.Controls.Left.Keys do
				if not Menu.Controls.Left.Pressed then
					if IsControlPressed(Menu.Controls.Left.Keys[Index][1], Menu.Controls.Left.Keys[Index][2]) then
						Menu.Controls.Left.Pressed = true

						Citizen.CreateThread(function()
							Menu.Controls.Left.Active = true

							Citizen.Wait(0.01)

							Menu.Controls.Left.Active = false

							Citizen.Wait(174.99)
										
							while Menu.Controls.Left.Enabled and IsControlPressed(Menu.Controls.Left.Keys[Index][1], Menu.Controls.Left.Keys[Index][2]) do
								Menu.Controls.Left.Active = true

								Citizen.Wait(0.01)

								Menu.Controls.Left.Active = false

								Citizen.Wait(124.99)
							end

							Menu.Controls.Left.Pressed = false
						end)

						break
					end
				end
			end
		end

		if Menu.Controls.Right.Enabled then
			for Index = 1, #Menu.Controls.Right.Keys do
				if not Menu.Controls.Right.Pressed then
					if IsControlPressed(Menu.Controls.Right.Keys[Index][1], Menu.Controls.Right.Keys[Index][2]) then
						Menu.Controls.Right.Pressed = true

						Citizen.CreateThread(function()
							Menu.Controls.Right.Active = true

							Citizen.Wait(0.01)

							Menu.Controls.Right.Active = false

							Citizen.Wait(174.99)
										
							while Menu.Controls.Right.Enabled and IsControlPressed(Menu.Controls.Right.Keys[Index][1], Menu.Controls.Right.Keys[Index][2]) do
								Menu.Controls.Right.Active = true

								Citizen.Wait(1)

								Menu.Controls.Right.Active = false

								Citizen.Wait(124.99)
							end

							Menu.Controls.Right.Pressed = false
						end)

						break
					end
				end
			end
		end

		if Menu.Controls.Select.Enabled then
			for Index = 1, #Menu.Controls.Select.Keys do
				if not Menu.Controls.Select.Pressed then
					if IsControlPressed(Menu.Controls.Select.Keys[Index][1], Menu.Controls.Select.Keys[Index][2]) then
						Menu.Controls.Select.Pressed = true

						Citizen.CreateThread(function()
							Menu.Controls.Select.Active = true

							Citizen.Wait(0.01)

							Menu.Controls.Select.Active = false

							Citizen.Wait(174.99)
										
							while Menu.Controls.Select.Enabled and IsControlPressed(Menu.Controls.Select.Keys[Index][1], Menu.Controls.Select.Keys[Index][2]) do
								Menu.Controls.Select.Active = true

								Citizen.Wait(0.01)

								Menu.Controls.Select.Active = false

								Citizen.Wait(124.99)
							end

							Menu.Controls.Select.Pressed = false
						end)

						break
					end
				end
			end
		end

		if Menu.Controls.Click.Enabled then
			for Index = 1, #Menu.Controls.Click.Keys do
				if not Menu.Controls.Click.Pressed then
					if IsControlPressed(Menu.Controls.Click.Keys[Index][1], Menu.Controls.Click.Keys[Index][2]) then
						Menu.Controls.Click.Pressed = true

						Citizen.CreateThread(function()
							Menu.Controls.Click.Active = true

							Citizen.Wait(0.01)

							Menu.Controls.Click.Active = false

							Citizen.Wait(174.99)
										
							while Menu.Controls.Click.Enabled and IsControlPressed(Menu.Controls.Click.Keys[Index][1], Menu.Controls.Click.Keys[Index][2]) do
								Menu.Controls.Click.Active = true

								Citizen.Wait(0.01)

								Menu.Controls.Click.Active = false

								Citizen.Wait(124.99)
							end

							Menu.Controls.Click.Pressed = false
						end)

						break
					end
				end
			end
		end

		if Menu.Controls.Back.Enabled then
			for Index = 1, #Menu.Controls.Back.Keys do
				if not Menu.Controls.Back.Pressed then
					if IsControlPressed(Menu.Controls.Back.Keys[Index][1], Menu.Controls.Back.Keys[Index][2]) then
						Menu.Controls.Back.Pressed = true

						NativeUI.Visible(Menu, false)

						Menu.Controls.Back.Pressed = false

						break
					end
				end
			end
		end
	end
end

function NativeUI.Title(Menu)
	if Menu.Sprite then
		NativeUI.RenderSprite(Menu.Sprite.Dictionary, Menu.Sprite.Texture, Menu.X, Menu.Y, NativeUI.Settings.Items.Title.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Title.Background.Height)
	else
		NativeUI.RenderRectangle(Menu.X, Menu.Y, NativeUI.Settings.Items.Title.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Title.Background.Height, Menu.Rectangle.R, Menu.Rectangle.G, Menu.Rectangle.B, Menu.Rectangle.A)
	end

	NativeUI.RenderText(Menu.Title, Menu.X + NativeUI.Settings.Items.Title.Text.X + (Menu.WidthOffset/2), Menu.Y + NativeUI.Settings.Items.Title.Text.Y, 1, NativeUI.Settings.Items.Title.Text.Scale, 255, 255, 255, 255, 1)

	if Menu.Subtitle ~= "" then
		NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Subtitle.Background.Y,  NativeUI.Settings.Items.Subtitle.Background.Width + Menu.WidthOffset,  NativeUI.Settings.Items.Subtitle.Background.Height + Menu.SubtitleHeight, 0, 0, 0, 255)
		NativeUI.RenderText(Menu.Subtitle, Menu.X + NativeUI.Settings.Items.Subtitle.Text.X, Menu.Y + NativeUI.Settings.Items.Subtitle.Text.Y, 0, NativeUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, NativeUI.Settings.Items.Subtitle.Background.Width + Menu.WidthOffset)
			
		if NativeUI.Options >= Menu.Pagination.Total + 1 then
			NativeUI.RenderText(Menu.PageCounterColour..Menu.Index.." / "..NativeUI.Options, Menu.X + NativeUI.Settings.Items.Subtitle.PreText.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Subtitle.PreText.Y, 0, NativeUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
		end
	end
end

function NativeUI.Background(Menu)
	SetUiLayer(0)
	NativeUI.RenderSprite(NativeUI.Settings.Items.Background.Dictionary, NativeUI.Settings.Items.Background.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Background.Y + Menu.SubtitleHeight, NativeUI.Settings.Items.Background.Width + Menu.WidthOffset, NativeUI.ItemOffset, 0, 0, 0, 255)
	SetUiLayer(1)
end

function NativeUI.Description(Menu)
	NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Description.Bar.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Description.Bar.Width + Menu.WidthOffset, NativeUI.Settings.Items.Description.Bar.Height, 0, 0, 0, 255)
	NativeUI.RenderSprite(NativeUI.Settings.Items.Description.Background.Dictionary, NativeUI.Settings.Items.Description.Background.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Description.Background.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Description.Background.Width + Menu.WidthOffset, Menu.DescriptionHeight, 0, 0, 0, 255)
	NativeUI.RenderText(Menu.Description, Menu.X + NativeUI.Settings.Items.Description.Text.X, Menu.Y + NativeUI.Settings.Items.Description.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + Menu.WidthOffset)

	NativeUI.ItemOffset = NativeUI.ItemOffset + Menu.DescriptionHeight
end

function NativeUI.Render(Menu)
	if Menu ~= nil then
		if Menu() then
			NativeUI.Title(Menu)
			NativeUI.Background(Menu)
			NativeUI.Description(Menu)

			if Menu.Safezone then
				ScreenDrawPositionEnd()
			end

			NativeUI.Controls(Menu)

			NativeUI.Options = 0
			NativeUI.ItemOffset = 0
		end
	end
end

function NativeUI.Button(Menu, Label, Description, RightLabel, LeftBadge, RightBadge, Enabled, Callback)
	if Menu ~= nil then
		if Menu() then
			local Option = NativeUI.Options + 1	
			local Selected = Menu.Index == Option
			local Hovered = false

			if NativeUI.Options == 0 then
				Menu.SafeZoneSize = {X = 0, Y = 0}

				if Menu.Safezone then
					Menu.SafeZoneSize = GetSafeZoneBounds()

					ScreenDrawPositionBegin(76, 84)
					ScreenDrawPositionRatio(0, 0, 0, 0)
				end
			end

			if Menu.Pagination.Minimum <= Option and Menu.Pagination.Maximum >= Option then
				Hovered = IsMouseInBounds(Menu.X + Menu.SafeZoneSize.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + Menu.SafeZoneSize.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)
				
				local LeftBadgeOffset = ((LeftBadge == NativeUI.BadgeStyle.None or tonumber(LeftBadge) == nil) and 0 or 27)
				local RightBadgeOffset =  ((RightBadge == NativeUI.BadgeStyle.None or tonumber(RightBadge) == nil) and 0 or 27)

				if Hovered and not Selected then
					NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)
					
					if Menu.Controls.Click.Active then
						Menu.Index = Option
						NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Error)
					end
				end

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
				end

				if LeftBadge ~= NativeUI.BadgeStyle.None and tonumber(LeftBadge) ~= nil then
					NativeUI.RenderSprite(NativeUI.GetBadgeDictionary(LeftBadge, Selected), NativeUI.GetBadgeTexture(LeftBadge, Selected), Menu.X, Menu.Y + NativeUI.Settings.Items.Button.LeftBadge.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.LeftBadge.Width, NativeUI.Settings.Items.Button.LeftBadge.Height, NativeUI.GetBadgeColour(LeftBadge, Selected))
				end

				if RightBadge ~= NativeUI.BadgeStyle.None and tonumber(RightBadge) ~= nil then
					NativeUI.RenderSprite(NativeUI.GetBadgeDictionary(RightBadge, Selected), NativeUI.GetBadgeTexture(RightBadge, Selected), Menu.X + NativeUI.Settings.Items.Button.RightBadge.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightBadge.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.RightBadge.Width, NativeUI.Settings.Items.Button.RightBadge.Height, NativeUI.GetBadgeColour(RightBadge, Selected))
				end

				if Enabled == true or Enabled == nil then
					if Selected then
						if RightLabel ~= nil and RightLabel ~= "" then
							NativeUI.RenderText(RightLabel, Menu.X + NativeUI.Settings.Items.Button.RightText.X - RightBadgeOffset + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 0, 0, 0, 255, 2)
						end

						NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)
					else
						if RightLabel ~= nil and RightLabel ~= "" then
							NativeUI.RenderText(RightLabel, Menu.X + NativeUI.Settings.Items.Button.RightText.X - RightBadgeOffset + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 245, 245, 245, 255, 2)
						end

						NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
					end
				else
					if RightLabel ~= nil and RightLabel ~= "" then
						NativeUI.RenderText(RightLabel, Menu.X + NativeUI.Settings.Items.Button.RightText.X - RightBadgeOffset + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 163, 159, 148, 255, 2)
					end

					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X + LeftBadgeOffset, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height
			end

			if Selected and Menu.Description ~= Description then
				Menu.Description = Description or ""

				local DescriptionLineCount = NativeUI.GetLineCount(Menu.Description, Menu.X + NativeUI.Settings.Items.Description.Text.X, Menu.Y + NativeUI.Settings.Items.Description.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + Menu.WidthOffset)
				
				if DescriptionLineCount > 1 then
					Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * DescriptionLineCount
				else
					Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height + 7
				end
			end

			NativeUI.Options = NativeUI.Options + 1

			if Selected and (Menu.Controls.Select.Active or (Hovered and Menu.Controls.Click.Active)) then
				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)
			end

			Callback(Hovered, Selected, ((Menu.Controls.Select.Active or (Hovered and Menu.Controls.Click.Active)) and Selected))
		end
	end
end

function NativeUI.Checkbox(Menu, Label, Description, Checked, Enabled, Callback)
	if Menu ~= nil then
		if Menu() then
			local Option = NativeUI.Options + 1			
			local Selected = Menu.Index == Option
			local Hovered = false

			if NativeUI.Options == 0 then
				Menu.SafeZoneSize = {X = 0, Y = 0}

				if Menu.Safezone then
					Menu.SafeZoneSize = GetSafeZoneBounds()

					ScreenDrawPositionBegin(76, 84)
					ScreenDrawPositionRatio(0, 0, 0, 0)
				end
			end

			if Menu.Pagination.Minimum <= Option and Menu.Pagination.Maximum >= Option then

				Hovered = IsMouseInBounds(Menu.X + Menu.SafeZoneSize.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + Menu.SafeZoneSize.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)

				if Hovered and not Selected then
					NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)

					if Menu.Controls.Click.Active then
						Menu.Index = Option
						NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Error)
						 Menu.Controls.Click.Active = false
					end
				end

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
				end

				if Enabled == true or Enabled == nil then
					if Selected then
						NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)
					else
						NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
					end
				else
					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)
				end

				if Selected then
					if Checked then
						NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[1], Menu.X + NativeUI.Settings.Items.Checkbox.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Checkbox.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
					else
						NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[2], Menu.X + NativeUI.Settings.Items.Checkbox.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Checkbox.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
					end
				else
					if Checked then
						NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[3], Menu.X + NativeUI.Settings.Items.Checkbox.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Checkbox.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
					else
						NativeUI.RenderSprite(NativeUI.Settings.Items.Checkbox.Dictionary, NativeUI.Settings.Items.Checkbox.Textures[4], Menu.X + NativeUI.Settings.Items.Checkbox.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Checkbox.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Checkbox.Width, NativeUI.Settings.Items.Checkbox.Height)
					end
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height
			end
			
			if Selected and Menu.Description ~= Description then
				Menu.Description = Description or ""

				local DescriptionLineCount = NativeUI.GetLineCount(Menu.Description, Menu.X + NativeUI.Settings.Items.Description.Text.X, Menu.Y + NativeUI.Settings.Items.Description.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + Menu.WidthOffset)
				
				if DescriptionLineCount > 1 then
					Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * DescriptionLineCount
				else
					Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height + 7
				end
			end

			NativeUI.Options = NativeUI.Options + 1

			if Selected and (Menu.Controls.Select.Active or (Hovered and Menu.Controls.Click.Active)) then
				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)

				Checked = not Checked
			end

			Callback(Hovered, Selected, ((Menu.Controls.Select.Active or (Hovered and Menu.Controls.Click.Active)) and Selected), Checked)
		end
	end
end

function NativeUI.List(Menu, Label, Items, Index, Description, Enabled, Callback)
	if Menu ~= nil then
		if Menu() then
			local Option = NativeUI.Options + 1			
			local Selected = Menu.Index == Option
			local Hovered = false
			local LeftArrowHovered, RightArrowHovered = false, false

			if NativeUI.Options == 0 then
				Menu.SafeZoneSize = {X = 0, Y = 0}

				if Menu.Safezone then
					Menu.SafeZoneSize = GetSafeZoneBounds()

					ScreenDrawPositionBegin(76, 84)
					ScreenDrawPositionRatio(0, 0, 0, 0)
				end
			end

			if Menu.Pagination.Minimum <= Option and Menu.Pagination.Maximum >= Option then

				Hovered = IsMouseInBounds(Menu.X + Menu.SafeZoneSize.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + Menu.SafeZoneSize.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)
				
				local ListText = (type(Items[Index]) == "table") and tostring(Items[Index].Name) or tostring(Items[Index]) or "NIL"
				local TextOffset = MeasureStringWidth(ListText, 0, 0.35)

				if Hovered and not Selected then
					NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)

					if Menu.Controls.Click.Active then
						Menu.Index = Option
						NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Error)
					end				
				end

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
					LeftArrowHovered = IsMouseInBounds(Menu.X + NativeUI.Settings.Items.List.LeftArrow.X - TextOffset + Menu.SafeZoneSize.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.LeftArrow.Y + Menu.SafeZoneSize.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.LeftArrow.Width, NativeUI.Settings.Items.List.LeftArrow.Height)
					RightArrowHovered = IsMouseInBounds(Menu.X + NativeUI.Settings.Items.List.RightArrow.X + Menu.SafeZoneSize.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.RightArrow.Y + Menu.SafeZoneSize.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.RightArrow.Width, NativeUI.Settings.Items.List.RightArrow.Height)
				end

				if Enabled == true or Enabled == nil then
					if Selected then
						NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)

						NativeUI.RenderSprite(NativeUI.Settings.Items.List.LeftArrow.Dictionary, NativeUI.Settings.Items.List.LeftArrow.Texture, Menu.X + NativeUI.Settings.Items.List.LeftArrow.X - TextOffset + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.LeftArrow.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.LeftArrow.Width, NativeUI.Settings.Items.List.LeftArrow.Height, 0, 0, 0, 0, 255)
						NativeUI.RenderSprite(NativeUI.Settings.Items.List.RightArrow.Dictionary, NativeUI.Settings.Items.List.RightArrow.Texture, Menu.X + NativeUI.Settings.Items.List.RightArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.RightArrow.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.RightArrow.Width, NativeUI.Settings.Items.List.RightArrow.Height, 0, 0, 0, 0, 255)
						
						NativeUI.RenderText(ListText, Menu.X + NativeUI.Settings.Items.List.Text.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 0, 0, 0, 255, 2)
					else
						NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
						
						NativeUI.RenderText(ListText, Menu.X + NativeUI.Settings.Items.List.Text.X + 15 + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 245, 245, 245, 255, 2)
					end
				else
					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)
					
					if Selected then
						NativeUI.RenderSprite(NativeUI.Settings.Items.List.LeftArrow.Dictionary, NativeUI.Settings.Items.List.LeftArrow.Texture, Menu.X + NativeUI.Settings.Items.List.LeftArrow.X - TextOffset + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.LeftArrow.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.LeftArrow.Width, NativeUI.Settings.Items.List.LeftArrow.Height, 0, 163, 159, 148, 255)
						NativeUI.RenderSprite(NativeUI.Settings.Items.List.RightArrow.Dictionary, NativeUI.Settings.Items.List.RightArrow.Texture, Menu.X + NativeUI.Settings.Items.List.RightArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.RightArrow.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.List.RightArrow.Width, NativeUI.Settings.Items.List.RightArrow.Height, 0, 163, 159, 148, 255)

						NativeUI.RenderText(ListText, Menu.X + NativeUI.Settings.Items.List.Text.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 163, 159, 148, 255, 2)
					else
						NativeUI.RenderText(ListText, Menu.X + NativeUI.Settings.Items.List.Text.X + 15 + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.List.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.List.Text.Scale, 163, 159, 148, 255, 2)
					end
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height
			end

			if Selected and Menu.Description ~= Description then
				Menu.Description = Description or ""

				local DescriptionLineCount = NativeUI.GetLineCount(Menu.Description, Menu.X + NativeUI.Settings.Items.Description.Text.X, Menu.Y + NativeUI.Settings.Items.Description.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + Menu.WidthOffset)
				
				if DescriptionLineCount > 1 then
					Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * DescriptionLineCount
				else
					Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height + 7
				end
			end

			NativeUI.Options = NativeUI.Options + 1

			if Selected and (Menu.Controls.Left.Active or (Menu.Controls.Click.Active and LeftArrowHovered)) and not (Menu.Controls.Right.Active or (Menu.Controls.Click.Active and RightArrowHovered)) then
				Index = Index - 1

				if Index < 1 then
					Index = #Items
				end

				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
			elseif Selected and (Menu.Controls.Right.Active or (Menu.Controls.Click.Active and RightArrowHovered)) and not (Menu.Controls.Left.Active or (Menu.Controls.Click.Active and LeftArrowHovered)) then
				Index = Index + 1

				if Index > #Items then
					Index = 1
				end

				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
			end

			if Selected and (Menu.Controls.Select.Active or ((Hovered and Menu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)
			end

			Callback(Hovered, Selected, ((Menu.Controls.Select.Active or ((Hovered and Menu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) and Selected), Index)
		end
	end
end

function NativeUI.Slider(Menu, Label, Items, Index, Description, Divider, Enabled, Callback)
	if Menu ~= nil then
		if Menu() then
			local Option = NativeUI.Options + 1			
			local Selected = Menu.Index == Option
			local Hovered = false
			local LeftArrowHovered, RightArrowHovered = false, false

			if NativeUI.Options == 0 then
				Menu.SafeZoneSize = {X = 0, Y = 0}

				if Menu.Safezone then
					Menu.SafeZoneSize = GetSafeZoneBounds()

					ScreenDrawPositionBegin(76, 84)
					ScreenDrawPositionRatio(0, 0, 0, 0)
				end
			end

			if Menu.Pagination.Minimum <= Option and Menu.Pagination.Maximum >= Option then

				Hovered = IsMouseInBounds(Menu.X + Menu.SafeZoneSize.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + Menu.SafeZoneSize.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height)

				if Hovered and not Selected then
					NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.Rectangle.Height, 255, 255, 255, 20)
					
					if Menu.Controls.Click.Active then
						Menu.Index = Option
						NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Error)
					end
				end

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + Menu.WidthOffset, NativeUI.Settings.Items.Button.SelectedSprite.Height)
					LeftArrowHovered = IsMouseInBounds(Menu.X + NativeUI.Settings.Items.Slider.LeftArrow.X + Menu.SafeZoneSize.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.LeftArrow.Y + Menu.SafeZoneSize.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.LeftArrow.Width, NativeUI.Settings.Items.Slider.LeftArrow.Height)
					RightArrowHovered = IsMouseInBounds(Menu.X + NativeUI.Settings.Items.Slider.RightArrow.X + Menu.SafeZoneSize.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.RightArrow.Y + Menu.SafeZoneSize.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.RightArrow.Width, NativeUI.Settings.Items.Slider.RightArrow.Height)
				end

				if Enabled == true or Enabled == nil then
					if Selected then
						NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)

						NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.LeftArrow.Dictionary, NativeUI.Settings.Items.Slider.LeftArrow.Texture, Menu.X + NativeUI.Settings.Items.Slider.LeftArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.LeftArrow.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.LeftArrow.Width, NativeUI.Settings.Items.Slider.LeftArrow.Height, 0, 0, 0, 0, 255)
						NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.RightArrow.Dictionary, NativeUI.Settings.Items.Slider.RightArrow.Texture, Menu.X + NativeUI.Settings.Items.Slider.RightArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.RightArrow.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.RightArrow.Width, NativeUI.Settings.Items.Slider.RightArrow.Height, 0, 0, 0, 0, 255)
					else
						NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)
					end
				else
					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)

					if Selected then
						NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.LeftArrow.Dictionary, NativeUI.Settings.Items.Slider.LeftArrow.Texture, Menu.X + NativeUI.Settings.Items.Slider.LeftArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.LeftArrow.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.LeftArrow.Width, NativeUI.Settings.Items.Slider.LeftArrow.Height, 163, 159, 148, 255)
						NativeUI.RenderSprite(NativeUI.Settings.Items.Slider.RightArrow.Dictionary, NativeUI.Settings.Items.Slider.RightArrow.Texture, Menu.X + NativeUI.Settings.Items.Slider.RightArrow.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.RightArrow.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Slider.RightArrow.Width, NativeUI.Settings.Items.Slider.RightArrow.Height, 163, 159, 148, 255)
					end
				end

				NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Slider.Background.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.Background.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Slider.Background.Width, NativeUI.Settings.Items.Slider.Background.Height, 4, 32, 57, 255)
				NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Slider.Slider.X + (((NativeUI.Settings.Items.Slider.Background.Width - NativeUI.Settings.Items.Slider.Slider.Width)/(#Items - 1)) * (Index - 1)) + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.Slider.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Slider.Slider.Width, NativeUI.Settings.Items.Slider.Slider.Height, 57, 116, 200, 255)
				
				if Divider then
					NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Slider.Divider.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Slider.Divider.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Slider.Divider.Width, NativeUI.Settings.Items.Slider.Divider.Height, 245, 245, 245, 255)
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Button.Rectangle.Height
			end

			if Selected and Menu.Description ~= Description then
				Menu.Description = Description or ""

				local DescriptionLineCount = NativeUI.GetLineCount(Menu.Description, Menu.X + NativeUI.Settings.Items.Description.Text.X, Menu.Y + NativeUI.Settings.Items.Description.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + Menu.WidthOffset)
				
				if DescriptionLineCount > 1 then
					Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * DescriptionLineCount
				else
					Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height + 7
				end
			end

			NativeUI.Options = NativeUI.Options + 1

			if Selected and (Menu.Controls.Left.Active or (Menu.Controls.Click.Active and LeftArrowHovered)) and not (Menu.Controls.Right.Active or (Menu.Controls.Click.Active and RightArrowHovered)) then
				Index = Index - 1

				if Index < 1 then
					Index = #Items
				end

				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
			elseif Selected and (Menu.Controls.Right.Active or (Menu.Controls.Click.Active and RightArrowHovered)) and not (Menu.Controls.Left.Active or (Menu.Controls.Click.Active and LeftArrowHovered)) then
				Index = Index + 1

				if Index > #Items then
					Index = 1
				end

				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
			end

			if Selected and (Menu.Controls.Select.Active or ((Hovered and Menu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)
			end

			Callback(Hovered, Selected, ((Menu.Controls.Select.Active or ((Hovered and Menu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) and Selected), Index)
		end
	end
end

function NativeUI.Progress(Menu, Label, Items, Index, Description, Counter, Enabled, Callback)
	if Menu ~= nil then
		if Menu() then
			local Option = NativeUI.Options + 1			
			local Selected = Menu.Index == Option
			local Hovered = false
			local ProgressHovered = false

			if NativeUI.Options == 0 then
				Menu.SafeZoneSize = {X = 0, Y = 0}

				if Menu.Safezone then
					Menu.SafeZoneSize = GetSafeZoneBounds()

					ScreenDrawPositionBegin(76, 84)
					ScreenDrawPositionRatio(0, 0, 0, 0)
				end
			end

			if Menu.Pagination.Minimum <= Option and Menu.Pagination.Maximum >= Option then

				Hovered = IsMouseInBounds(Menu.X + Menu.SafeZoneSize.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + Menu.SafeZoneSize.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Height)
				
				local ProgressText = (Counter and Index.."/"..#Items or (type(Items[Index]) == "table") and tostring(Items[Index].Name) or tostring(Items[Index]))

				if Hovered and not Selected then
					NativeUI.RenderRectangle(Menu.X, Menu.Y + NativeUI.Settings.Items.Button.Rectangle.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Button.Rectangle.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Height, 255, 255, 255, 20)

					if Menu.Controls.Click.Active then
						Menu.Index = Option
						NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Error)
					end
				end

				if Selected then
					NativeUI.RenderSprite(NativeUI.Settings.Items.Button.SelectedSprite.Dictionary, NativeUI.Settings.Items.Button.SelectedSprite.Texture, Menu.X, Menu.Y + NativeUI.Settings.Items.Button.SelectedSprite.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, NativeUI.Settings.Items.Button.SelectedSprite.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Height)
					ProgressHovered = IsMouseInBounds(Menu.X + NativeUI.Settings.Items.Progress.Bar.X + Menu.SafeZoneSize.X, Menu.Y + NativeUI.Settings.Items.Progress.Bar.Y + Menu.SafeZoneSize.Y + Menu.SubtitleHeight + NativeUI.ItemOffset - 12, NativeUI.Settings.Items.Progress.Bar.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Bar.Height + 24)
				end

				if Enabled == true or Enabled == nil then
					if Selected then
						NativeUI.RenderText(ProgressText, Menu.X + NativeUI.Settings.Items.Button.RightText.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 0, 0, 0, 255, 2)

						NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 0, 0, 0, 255)

						NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Background.X, Menu.Y + NativeUI.Settings.Items.Progress.Background.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 0, 0, 0, 255)
						NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Bar.X, Menu.Y + NativeUI.Settings.Items.Progress.Bar.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, ((Index/#Items) * (NativeUI.Settings.Items.Progress.Bar.Width + Menu.WidthOffset)), NativeUI.Settings.Items.Progress.Bar.Height, 240, 240, 240, 255)
					else
						NativeUI.RenderText(ProgressText, Menu.X + NativeUI.Settings.Items.Button.RightText.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 245, 245, 245, 255, 2)

						NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 245, 245, 245, 255)

						NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Background.X, Menu.Y + NativeUI.Settings.Items.Progress.Background.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 240, 240, 240, 255)
						NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Bar.X, Menu.Y + NativeUI.Settings.Items.Progress.Bar.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, ((Index/#Items) * (NativeUI.Settings.Items.Progress.Bar.Width + Menu.WidthOffset)), NativeUI.Settings.Items.Progress.Bar.Height, 0, 0, 0, 255)
					end
				else
					NativeUI.RenderText(ProgressText, Menu.X + NativeUI.Settings.Items.Button.RightText.X + Menu.WidthOffset, Menu.Y + NativeUI.Settings.Items.Button.RightText.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.RightText.Scale, 163, 159, 148, 255, 2)

					NativeUI.RenderText(Label, Menu.X + NativeUI.Settings.Items.Button.Text.X, Menu.Y + NativeUI.Settings.Items.Button.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Button.Text.Scale, 163, 159, 148, 255)				
					
					if Selected then
						NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Background.X, Menu.Y + NativeUI.Settings.Items.Progress.Background.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 0, 0, 0, 255)
					else
						NativeUI.RenderRectangle(Menu.X + NativeUI.Settings.Items.Progress.Background.X, Menu.Y + NativeUI.Settings.Items.Progress.Background.Y + Menu.SubtitleHeight + NativeUI.ItemOffset,  NativeUI.Settings.Items.Progress.Background.Width + Menu.WidthOffset, NativeUI.Settings.Items.Progress.Background.Height, 240, 240, 240, 255)
					end
				end

				NativeUI.ItemOffset = NativeUI.ItemOffset + NativeUI.Settings.Items.Progress.Height
			end

			if Selected and Menu.Description ~= Description then
				Menu.Description = Description or ""

				local DescriptionLineCount = NativeUI.GetLineCount(Menu.Description, Menu.X + NativeUI.Settings.Items.Description.Text.X, Menu.Y + NativeUI.Settings.Items.Description.Text.Y + Menu.SubtitleHeight + NativeUI.ItemOffset, 0, NativeUI.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, NativeUI.Settings.Items.Description.Background.Width + Menu.WidthOffset)
				
				if DescriptionLineCount > 1 then
					Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height * DescriptionLineCount
				else
					Menu.DescriptionHeight = NativeUI.Settings.Items.Description.Background.Height + 7
				end
			end

			NativeUI.Options = NativeUI.Options + 1

			if Selected and Menu.Controls.Left.Active and not Menu.Controls.Right.Active then
				Index = Index - 1

				if Index < 1 then
					Index = #Items
				end

				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
			elseif Selected and Menu.Controls.Right.Active and not Menu.Controls.Left.Active then
				Index = Index + 1

				if Index > #Items then
					Index = 1
				end

				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.LeftRight)
			end

			if Selected and (Menu.Controls.Select.Active or ((Hovered and Menu.Controls.Click.Active) and not ProgressHovered)) then
				NativeUI.PlaySound(NativeUI.Settings.Audio.Library, NativeUI.Settings.Audio.Select)
			elseif Selected and (Hovered and Menu.Controls.Click.Active and ProgressHovered) then
				local Progress = (math.round(GetControlNormal(0, 239) * 1920) - Menu.SafeZoneSize.X) - NativeUI.Settings.Items.Progress.Bar.X
				local Barsize = NativeUI.Settings.Items.Progress.Bar.Width + Menu.WidthOffset

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

			Callback(Hovered, Selected, ((Menu.Controls.Select.Active or ((Hovered and Menu.Controls.Click.Active) and not ProgressHovered)) and Selected), Index)
		end
	end
end

Citizen.CreateThread(function()
	local NewMenu = NativeUI.CreateMenu("Title", "Subtitle", 0, 0)
	NewMenu.Safezone = true
	NewMenu.WidthOffset = 500
	local Indexes = {1,1,2,1,1,1}
	local Checkedboxes = {true, false, true}
	while true do
		Citizen.Wait(0)

		if IsControlJustPressed(1, 51) then
			NativeUI.Visible(NewMenu, not NativeUI.Visible(NewMenu))
		end

		if NativeUI.Visible(NewMenu) then
			ShowCursorThisFrame()

			NativeUI.List(NewMenu, "List", {1, 2, 3}, Indexes[1], "Save your current settings. All saving is done on the client side, if you re-install windows you will lose your settings. Settings are shared across all servers using vMenu.", true, function(Hovered, Active, Selected, Index)
				Indexes[1] = Index
			end)

			NativeUI.List(NewMenu, "List", {0, 0, 0}, Indexes[2], "Save your current settings. All saving is done on the client side, if you re-install windows you will lose your settings. Settings are shared across all servers using vMenu.", true, function(Hovered, Active, Selected, Index)
				Indexes[2] = Index
			end)

			NativeUI.Button(NewMenu, "HelloHello", "LMAO", "WorldWorld", NativeUI.BadgeStyle.BronzeMedal, NativeUI.BadgeStyle.GoldMedal, true, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello") end
			end)

			NativeUI.Button(NewMenu, "Hello", "LMAO", "World", NativeUI.BadgeStyle.BronzeMedal, nil, false, function(Hovered, Active, Selected)
				if Selected then Citizen.Trace("Ello2") end
			end)

			NativeUI.Checkbox(NewMenu, "Meep", "LMAO", Checkedboxes[1], true, function(Hovered, Active, Selected, Checked)
				if Selected then
					Checkedboxes[1] = Checked
				end
			end)

			NativeUI.Checkbox(NewMenu, "Meep", "LMAO", Checkedboxes[2], true, function(Hovered, Active, Selected, Checked)
				if Selected then
					Checkedboxes[2] = Checked
				end
			end)

			NativeUI.Checkbox(NewMenu, "Meep", "LMAO", Checkedboxes[3], false, function(Hovered, Active, Selected, Checked)
				if Selected then
					Checkedboxes[3] = Checked
				end
			end)

			NativeUI.Slider(NewMenu, "Meep", {1, 2, 3}, Indexes[3], "LMAO", true, true, function(Hovered, Active, Selected, Index)
				Indexes[3] = Index
			end)

			NativeUI.Progress(NewMenu, "Meep", {1, 2, 3}, Indexes[4], "LMAO", true, true, function(Hovered, Active, Selected, Index)
				Indexes[4] = Index
			end)

			NativeUI.Slider(NewMenu, "Meep", {1, 2, 3}, Indexes[5], "LMAO", false, true, function(Hovered, Active, Selected, Index)
				Indexes[5] = Index
			end)

			NativeUI.Progress(NewMenu, "Meep", {1, 2, 3}, Indexes[6], "LMAO", false, true, function(Hovered, Active, Selected, Index)
				Indexes[6] = Index
			end)

			NativeUI.Render(NewMenu)
		end
	end
end)
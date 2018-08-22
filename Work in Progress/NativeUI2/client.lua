NativeUI = {}
NativeUI.Menus = {}
NativeUI.CurrentMenu = nil
NativeUI.Settings = {
	Keys = {
		Up = {
			{0, 172},
			{1, 172},
			{2, 172},
			{0, 241},
			{1, 241},
			{2, 241},
			{2, 241},
		},
		Down = {
			{0, 173},
			{1, 173},
			{2, 173},
			{0, 242},
			{1, 242},
			{2, 242},
		},
		Left = {
			{0, 174},
			{1, 174},
			{2, 174},
		},
		Right = {
			{0, 175},
			{1, 175},
			{2, 175},
		},
		Select = {
			{0, 201},
			{1, 201},
			{2, 201},
		},
		Back = {
			{0, 177},
			{1, 177},
			{2, 177},
			{0, 199},
			{1, 199},
			{2, 199},
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
	EnabledControls = {
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
}

function NativeUI.CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName)
	local Menu = {}

	Menu.Title = Title or ""
	Menu.Subtitle = Subtitle or ""
	Menu.Position = {X = X or 0, Y = Y or 0}
	Menu.Parent = nil
	Menu.WidthOffset = 0
	Menu.Open = false
	Menu.Controls = {}
	Menu.Index = 1

	if string.starts(Menu.Subtitle, "~") then
		Menu.PageCounterColour = string.sub(Menu.Subtitle, 1, 3)
	end

	return setmetatable(Menu, NativeUI.Menus)
end

function NativeUI.Menus:Visible(Value)
	if type(Value) == "boolean" then
		Menu.Open = Value
	else
		return Menu.Open
	end
end
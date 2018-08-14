UI = {}

UI.Text = setmetatable({}, UI.Text)
UI.Rectangle = setmetatable({}, UI.Rectangle)
UI.Sprite = setmetatable({}, UI.Sprite)
UI.Scaleform = setmetatable({}, UI.Scaleform)

UI.Text.__index = UI.Text
UI.Rectangle.__index = UI.Rectangle
UI.Sprite.__index = UI.Sprite
UI.Scaleform.__index = UI.Scaleform

UI.Text.__call = function() return "Text" end
UI.Rectangle.__call = function() return "Rectangle" end
UI.Sprite.__call = function() return "Sprite" end
UI.Scaleform.__call = function() return "Scaleform" end

UI.Colours = {
	PureWhite = function() return 255, 255, 255, 255 end,
	White = function() return 240, 240, 240, 255 end,
	Black = function() return 0, 0, 0, 255 end,
	Grey = function() return 155, 155, 155, 255 end,
	GreyLight = function() return 205, 205, 205, 255 end,
	GreyDark = function() return 77, 77, 77, 255 end,
	Red = function() return 224, 50, 50, 255 end,
	RedLight = function() return 240, 153, 153, 255 end,
	RedDark = function() return 112, 25, 25, 255 end,
	Blue = function() return 93, 182, 229, 255 end,
	BlueLight = function() return 174, 219, 242, 255 end,
	BlueDark = function() return 47, 92, 115, 255 end,
	Yellow = function() return 240, 200, 80, 255 end,
	YellowLight = function() return 254, 235, 169, 255 end,
	YellowDark = function() return 126, 107, 41, 255 end,
	Orange = function() return 255, 133, 85, 255 end,
	OrangeLight = function() return 255, 194, 170, 255 end,
	OrangeDark = function() return 127, 66, 42, 255 end,
	Green = function() return 114, 204, 114, 255 end,
	GreenLight = function() return 185, 230, 185, 255 end,
	GreenDark = function() return 57, 102, 57, 255 end,
	Purple = function() return 132, 102, 226, 255 end,
	PurpleLight = function() return 192, 179, 239, 255 end,
	PurpleDark = function() return 67, 57, 111, 255 end,
	Pink = function() return 203, 54, 148, 255 end,
	RadarHealth = function() return 53, 154, 71, 255 end,
	RadarArmour = function() return 93, 182, 229, 255 end,
	RadarDamage = function() return 235, 36, 39, 255 end,
	NetPlayer1 = function() return 194, 80, 80, 255 end,
	NetPlayer2 = function() return 156, 110, 175, 255 end,
	NetPlayer3 = function() return 255, 123, 196, 255 end,
	NetPlayer4 = function() return 247, 159, 123, 255 end,
	NetPlayer5 = function() return 178, 144, 132, 255 end,
	NetPlayer6 = function() return 141, 206, 167, 255 end,
	NetPlayer7 = function() return 113, 169, 175, 255 end,
	NetPlayer8 = function() return 211, 209, 231, 255 end,
	NetPlayer9 = function() return 144, 127, 153, 255 end,
	NetPlayer10 = function() return 106, 196, 191, 255 end,
	NetPlayer11 = function() return 214, 196, 153, 255 end,
	NetPlayer12 = function() return 234, 142, 80, 255 end,
	NetPlayer13 = function() return 152, 203, 234, 255 end,
	NetPlayer14 = function() return 178, 98, 135, 255 end,
	NetPlayer15 = function() return 144, 142, 122, 255 end,
	NetPlayer16 = function() return 166, 117, 94, 255 end,
	NetPlayer17 = function() return 175, 168, 168, 255 end,
	NetPlayer18 = function() return 232, 142, 155, 255 end,
	NetPlayer19 = function() return 187, 214, 91, 255 end,
	NetPlayer20 = function() return 12, 123, 86, 255 end,
	NetPlayer21 = function() return 123, 196, 255, 255 end,
	NetPlayer22 = function() return 171, 60, 230, 255 end,
	NetPlayer23 = function() return 206, 169, 13, 255 end,
	NetPlayer24 = function() return 71, 99, 173, 255 end,
	NetPlayer25 = function() return 42, 166, 185, 255 end,
	NetPlayer26 = function() return 186, 157, 125, 255 end,
	NetPlayer27 = function() return 201, 225, 255, 255 end,
	NetPlayer28 = function() return 240, 240, 150, 255 end,
	NetPlayer29 = function() return 237, 140, 161, 255 end,
	NetPlayer30 = function() return 249, 138, 138, 255 end,
	NetPlayer31 = function() return 252, 239, 166, 255 end,
	NetPlayer32 = function() return 240, 240, 240, 255 end,
	SimpleBlipDefault = function() return 159, 201, 166, 255 end,
	MenuBlue = function() return 140, 140, 140, 255 end,
	MenuGreyLight = function() return 140, 140, 140, 255 end,
	MenuBlueExtraDark = function() return 40, 40, 40, 255 end,
	MenuYellow = function() return 240, 160, 0, 255 end,
	MenuYellowDark = function() return 240, 160, 0, 255 end,
	MenuGreen = function() return 240, 160, 0, 255 end,
	MenuGrey = function() return 140, 140, 140, 255 end,
	MenuGreyDark = function() return 60, 60, 60, 255 end,
	MenuHighlight = function() return 30, 30, 30, 255 end,
	MenuStandard = function() return 140, 140, 140, 255 end,
	MenuDimmed = function() return 75, 75, 75, 255 end,
	MenuExtraDimmed = function() return 50, 50, 50, 255 end,
	BriefTitle = function() return 95, 95, 95, 255 end,
	MidGreyMp = function() return 100, 100, 100, 255 end,
	NetPlayer1Dark = function() return 93, 39, 39, 255 end,
	NetPlayer2Dark = function() return 77, 55, 89, 255 end,
	NetPlayer3Dark = function() return 124, 62, 99, 255 end,
	NetPlayer4Dark = function() return 120, 80, 80, 255 end,
	NetPlayer5Dark = function() return 87, 72, 66, 255 end,
	NetPlayer6Dark = function() return 74, 103, 83, 255 end,
	NetPlayer7Dark = function() return 60, 85, 88, 255 end,
	NetPlayer8Dark = function() return 105, 105, 64, 255 end,
	NetPlayer9Dark = function() return 72, 63, 76, 255 end,
	NetPlayer10Dark = function() return 53, 98, 95, 255 end,
	NetPlayer11Dark = function() return 107, 98, 76, 255 end,
	NetPlayer12Dark = function() return 117, 71, 40, 255 end,
	NetPlayer13Dark = function() return 76, 101, 117, 255 end,
	NetPlayer14Dark = function() return 65, 35, 47, 255 end,
	NetPlayer15Dark = function() return 72, 71, 61, 255 end,
	NetPlayer16Dark = function() return 85, 58, 47, 255 end,
	NetPlayer17Dark = function() return 87, 84, 84, 255 end,
	NetPlayer18Dark = function() return 116, 71, 77, 255 end,
	NetPlayer19Dark = function() return 93, 107, 45, 255 end,
	NetPlayer20Dark = function() return 6, 61, 43, 255 end,
	NetPlayer21Dark = function() return 61, 98, 127, 255 end,
	NetPlayer22Dark = function() return 85, 30, 115, 255 end,
	NetPlayer23Dark = function() return 103, 84, 6, 255 end,
	NetPlayer24Dark = function() return 35, 49, 86, 255 end,
	NetPlayer25Dark = function() return 21, 83, 92, 255 end,
	NetPlayer26Dark = function() return 93, 98, 62, 255 end,
	NetPlayer27Dark = function() return 100, 112, 127, 255 end,
	NetPlayer28Dark = function() return 120, 120, 75, 255 end,
	NetPlayer29Dark = function() return 152, 76, 93, 255 end,
	NetPlayer30Dark = function() return 124, 69, 69, 255 end,
	NetPlayer31Dark = function() return 10, 43, 50, 255 end,
	NetPlayer32Dark = function() return 95, 95, 10, 255 end,
	Bronze = function() return 180, 130, 97, 255 end,
	Silver = function() return 150, 153, 161, 255 end,
	Gold = function() return 214, 181, 99, 255 end,
	Platinum = function() return 166, 221, 190, 255 end,
	Gang1 = function() return 29, 100, 153, 255 end,
	Gang2 = function() return 214, 116, 15, 255 end,
	Gang3 = function() return 135, 125, 142, 255 end,
	Gang4 = function() return 229, 119, 185, 255 end,
	SameCrew = function() return 252, 239, 166, 255 end,
	Freemode = function() return 45, 110, 185, 255 end,
	PauseBg = function() return 0, 0, 0, 255 end,
	Friendly = function() return 93, 182, 229, 255 end,
	Enemy = function() return 194, 80, 80, 255 end,
	Location = function() return 240, 200, 80, 255 end,
	Pickup = function() return 114, 204, 114, 255 end,
	PauseSingleplayer = function() return 114, 204, 114, 255 end,
	FreemodeDark = function() return 22, 55, 92, 255 end,
	InactiveMission = function() return 154, 154, 154, 255 end,
	Damage = function() return 194, 80, 80, 255 end,
	PinkLight = function() return 252, 115, 201, 255 end,
	PmMitemHighlight = function() return 252, 177, 49, 255 end,
	ScriptVariable = function() return 0, 0, 0, 255 end,
	Yoga = function() return 109, 247, 204, 255 end,
	Tennis = function() return 241, 101, 34, 255 end,
	Golf = function() return 214, 189, 97, 255 end,
	ShootingRange = function() return 112, 25, 25, 255 end,
	FlightSchool = function() return 47, 92, 115, 255 end,
	NorthBlue = function() return 93, 182, 229, 255 end,
	SocialClub = function() return 234, 153, 28, 255 end,
	PlatformBlue = function() return 11, 55, 123, 255 end,
	PlatformGreen = function() return 146, 200, 62, 255 end,
	PlatformGrey = function() return 234, 153, 28, 255 end,
	FacebookBlue = function() return 66, 89, 148, 255 end,
	IngameBg = function() return 0, 0, 0, 255 end,
	Darts = function() return 114, 204, 114, 255 end,
	Waypoint = function() return 164, 76, 242, 255 end,
	Michael = function() return 101, 180, 212, 255 end,
	Franklin = function() return 171, 237, 171, 255 end,
	Trevor = function() return 255, 163, 87, 255 end,
	GolfP1 = function() return 240, 240, 240, 255 end,
	GolfP2 = function() return 235, 239, 30, 255 end,
	GolfP3 = function() return 255, 149, 14, 255 end,
	GolfP4 = function() return 246, 60, 161, 255 end,
	WaypointLight = function() return 210, 166, 249, 255 end,
	WaypointDark = function() return 82, 38, 121, 255 end,
	PanelLight = function() return 0, 0, 0, 255 end,
	MichaelDark = function() return 72, 103, 116, 255 end,
	FranklinDark = function() return 85, 118, 85, 255 end,
	TrevorDark = function() return 127, 81, 43, 255 end,
	ObjectiveRoute = function() return 240, 200, 80, 255 end,
	PausemapTint = function() return 0, 0, 0, 255 end,
	PauseDeselect = function() return 100, 100, 100, 255 end,
	PmWeaponsPurchasable = function() return 45, 110, 185, 255 end,
	PmWeaponsLocked = function() return 240, 240, 240, 255 end,
	EndScreenBg = function() return 0, 0, 0, 255 end,
	Chop = function() return 224, 50, 50, 255 end,
	PausemapTintHalf = function() return 0, 0, 0, 255 end,
	NorthBlueOfficial = function() return 0, 71, 133, 255 end,
	ScriptVariable2 = function() return 0, 0, 0, 255 end,
	H = function() return 33, 118, 37, 255 end,
	HDark = function() return 37, 102, 40, 255 end,
	T = function() return 234, 153, 28, 255 end,
	TDark = function() return 225, 140, 8, 255 end,
	HShard = function() return 20, 40, 0, 255 end,
	ControllerMichael = function() return 48, 255, 255, 255 end,
	ControllerFranklin = function() return 48, 255, 0, 255 end,
	ControllerTrevor = function() return 176, 80, 0, 255 end,
	ControllerChop = function() return 127, 0, 0, 255 end,
	VideoEditorVideo = function() return 53, 166, 224, 255 end,
	VideoEditorAudio = function() return 162, 79, 157, 255 end,
	VideoEditorText = function() return 104, 192, 141, 255 end,
	HbBlue = function() return 29, 100, 153, 255 end,
	HbYellow = function() return 234, 153, 28, 255 end,
	VideoEditorScore = function() return 240, 160, 1, 255 end,
	VideoEditorAudioFadeout = function() return 59, 34, 57, 255 end,
	VideoEditorTextFadeout = function() return 41, 68, 53, 255 end,
	VideoEditorScoreFadeout = function() return 82, 58, 10, 255 end,
	HeistBackground = function() return 37, 102, 40, 255 end,
	VideoEditorAmbient = function() return 240, 200, 80, 255 end,
	VideoEditorAmbientFadeout = function() return 80, 70, 34, 255 end,
	Gb = function() return 255, 133, 85, 255 end,
	G = function() return 255, 194, 170, 255 end,
	B = function() return 255, 133, 85, 255 end,
	LowFlow = function() return 240, 200, 80, 255 end,
	LowFlowDark = function() return 126, 107, 41, 255 end,
	G1 = function() return 247, 159, 123, 255 end,
	G2 = function() return 226, 134, 187, 255 end,
	G3 = function() return 239, 238, 151, 255 end,
	G4 = function() return 113, 169, 175, 255 end,
	G5 = function() return 160, 140, 193, 255 end,
	G6 = function() return 141, 206, 167, 255 end,
	G7 = function() return 181, 214, 234, 255 end,
	G8 = function() return 178, 144, 132, 255 end,
	G9 = function() return 0, 132, 114, 255 end,
	G10 = function() return 216, 85, 117, 255 end,
	G11 = function() return 30, 100, 152, 255 end,
	G12 = function() return 43, 181, 117, 255 end,
	G13 = function() return 233, 141, 79, 255 end,
	G14 = function() return 137, 210, 215, 255 end,
	G15 = function() return 134, 125, 141, 255 end,
	Adversary = function() return 109, 34, 33, 255 end,
	DegenRed = function() return 255, 0, 0, 255 end,
	DegenYellow = function() return 255, 255, 0, 255 end,
	DegenGreen = function() return 0, 255, 0, 255 end,
	DegenCyan = function() return 0, 255, 255, 255 end,
	DegenBlue = function() return 0, 0, 255, 255 end,
	DegenMagenta = function() return 255, 0, 255, 255 end,
	Stunt1 = function() return 38, 136, 234, 255 end,
	Stunt2 = function() return 224, 50, 50, 255 end,
}

UI.CharacterMap = { [' '] = 6, ['!'] = 6, ['"'] = 6, ['#'] = 11,['$'] = 10, ['%'] = 17,['&'] = 13, ['\\'] = 4,['('] = 6, [')'] = 6,['*'] = 7, ['+'] = 10, [','] = 4, ['-'] = 6,  ['.'] = 4,  ['/'] = 7,  ['0'] = 12, ['1'] = 7,  ['2'] = 11, ['3'] = 11, ['4'] = 11, ['5'] = 11, ['6'] = 12, ['7'] = 10, ['8'] = 11, ['9'] = 11, [':'] = 5,  [';'] = 4,  ['<'] = 9,  ['='] = 9,  ['>'] = 9,  ['?'] = 10, ['@'] = 15, ['A'] = 12, ['B'] = 13, ['C'] = 14, ['D'] = 14, ['E'] = 12, ['F'] = 12, ['G'] = 15, ['H'] = 14, ['I'] = 5,  ['J'] = 11, ['K'] = 13, ['L'] = 11, ['M'] = 16, ['N'] = 14, ['O'] = 16, ['P'] = 12, ['Q'] = 15, ['R'] = 13, ['S'] = 12, ['T'] = 11, ['U'] = 13, ['V'] = 12, ['W'] = 18, ['X'] = 11, ['Y'] = 11, ['Z'] = 12, ['['] = 6,  [']'] = 6,  ['^'] = 9,  ['_'] = 18, ['`'] = 8,  ['a'] = 11, ['b'] = 12, ['c'] = 11, ['d'] = 12, ['e'] = 12, ['f'] = 5,  ['g'] = 13, ['h'] = 11, ['i'] = 4,  ['j'] = 4,  ['k'] = 10, ['l'] = 4,  ['m'] = 18, ['n'] = 11, ['o'] = 12, ['p'] = 12, ['q'] = 12, ['r'] = 7,  ['s'] = 9,  ['t'] = 5,  ['u'] = 11, ['v'] = 10, ['w'] = 14, ['x'] = 9,  ['y'] = 10, ['z'] = 9,  ['{'] = 6,  ['|'] = 3,  ['}'] = 6 }

UI.BadgeStyle = { None = 0, BronzeMedal = 1, GoldMedal = 2, SilverMedal = 3, Alert = 4, Crown = 5, Ammo = 6, Armour = 7, Barber = 8, Clothes = 9, Franklin = 10, Bike = 11, Car = 12, Gun = 13, Heart = 14, Makeup = 15, Mask = 16, Michael = 17, Star = 18, Tattoo = 19, Trevor = 20, Lock = 21, Tick = 22 }

UI.BadgeTexture = {
	[0] = function() return "" end,
	[1] = function() return "mp_medal_bronze" end,
	[2] = function() return "mp_medal_gold" end,
	[3] = function() return "medal_silver" end,
	[4] = function() return "mp_alerttriangle" end,
	[5] = function() return "mp_hostcrown" end,
	[6] = function(Selected) if Selected then return "shop_ammo_icon_b" else return "shop_ammo_icon_a" end end,
	[7] = function(Selected) if Selected then return "shop_armour_icon_b" else return "shop_armour_icon_a" end end,
	[8] = function(Selected) if Selected then return "shop_barber_icon_b" else return "shop_barber_icon_a"  end end,
	[9] = function(Selected) if Selected then return "shop_clothing_icon_b" else return "shop_clothing_icon_a" end end,
	[10] = function(Selected) if Selected then return "shop_franklin_icon_b" else return "shop_franklin_icon_a" end end,
	[11] = function(Selected) if Selected then return "shop_garage_bike_icon_b" else return "shop_garage_bike_icon_a" end end,
	[12] = function(Selected) if Selected then return "shop_garage_icon_b" else return "shop_garage_icon_a" end end,
	[13] = function(Selected) if Selected then return "shop_gunclub_icon_b" else return "shop_gunclub_icon_a" end end,
	[14] = function(Selected) if Selected then return "shop_health_icon_b" else return "shop_health_icon_a" end end,
	[15] = function(Selected) if Selected then return "shop_makeup_icon_b" else return "shop_makeup_icon_a" end end,
	[16] = function(Selected) if Selected then return "shop_mask_icon_b" else return "shop_mask_icon_a" end end,
	[17] = function(Selected) if Selected then return "shop_michael_icon_b" else return "shop_michael_icon_a" end end,
	[18] = function() return "shop_new_star" end,
	[19] = function(Selected) if Selected then return "shop_tattoos_icon_b" else return "shop_tattoos_icon_" end end,
	[20] = function(Selected) if Selected then return "shop_trevor_icon_b" else return "shop_trevor_icon_a" end end,
	[21] = function() return "shop_lock" end,
	[22] = function() return "shop_tick_icon" end,
}

UI.BadgeDictionary = {
	[0] = function(Selected)
		if Selected then
			return "commonmenu"
		else
			return "commonmenu"
		end
	end,
}

UI.BadgeColour = {
	[5] = function(Selected) if Selected then return 0, 0, 0, 255 else return 255, 255, 255, 255 end end,
	[21] = function(Selected) if Selected then return 0, 0, 0, 255 else return 255, 255, 255, 255 end end,
	[22] = function(Selected) if Selected then return 0, 0, 0, 255 else return 255, 255, 255, 255   end end,
}

local function GetResolution()
	local W, H = GetActiveScreenResolution()
	if (W/H) > 3.5 then
		return GetScreenResolution()
	else
		return W, H
	end
end

local function FormatXWYH(Value, Value2)
	return Value/1920, Value2/1080
end

local function GetCharacterCount(str)
	local characters = 0
	for c in str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
		local a = c:byte(1, -1)
		if a ~= nil then
			characters = characters + 1
		end
	end
	return characters
end

local function GetByteCount(str)
	local bytes = 0

	for c in str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
		local a,b,c,d = c:byte(1, -1)
		if a ~= nil then
			bytes = bytes + 1
		end
		if b ~= nil then
			bytes = bytes + 1
		end
		if c ~= nil then
			bytes = bytes + 1
		end
		if d ~= nil then
			bytes = bytes + 1
		end
	end
	return bytes
end

local function AddLongStringForAscii(str)
	local maxbytelength = 99
	for i = 0, GetCharacterCount(str), 99 do
		AddTextComponentSubstringPlayerName(string.sub(str, i, math.min(maxbytelength, GetCharacterCount(str) - i))) --needs changed
	end
end

local function AddLongStringForUtf8(str)
	local maxbytelength = 99
	local bytecount = GetByteCount(str)

	if bytecount < maxbytelength then
		AddTextComponentSubstringPlayerName(str)
		return
	end

	local startIndex = 0

	for i = 0, GetCharacterCount(str), 1 do
		local length = i - startIndex
		if GetByteCount(string.sub(str, startIndex, length)) > maxbytelength then
			AddTextComponentSubstringPlayerName(string.sub(str, startIndex, length - 1))
			i = i - 1
			startIndex = startIndex + (length - 1)
		end
	end
	AddTextComponentSubstringPlayerName(string.sub(str, startIndex, GetCharacterCount(str) - startIndex))
end 

local function AddLongString(str)
	local bytecount = GetByteCount(str)
	if bytecount == GetCharacterCount(str) then
		AddLongStringForAscii(str)
	else
		AddLongStringForUtf8(str)
	end
end

local function MeasureStringWidthNoConvert(str, font, scale)
	BeginTextCommandWidth("STRING")
	AddLongString(str)
	return EndTextCommandGetWidth(font) * scale
end

function UI.GetBadgeTexture(Badge, Selected)
	if UI.BadgeTexture[Badge] then
		return UI.BadgeTexture[Badge](Selected)
	else
		return ""
	end
end

function UI.GetBadgeDictionary(Badge, Selected)
	if UI.BadgeDictionary[Badge] then
		return UI.BadgeDictionary[Badge](Selected)
	else
		return "commonmenu"
	end
end

function UI.GetBadgeColour(Badge, Selected)
	if UI.BadgeColour[Badge] then
		return UI.BadgeColour[Badge](Selected)
	else
		return 255, 255, 255, 255
	end
end

function UI.MeasureString(Str)
	local output = 0
	for i = 1, GetCharacterCount(Str), 1 do
		if UI.CharacterMap[string.sub(Str, i, i)] then
			output = output + UI.CharacterMap[string.sub(Str, i, i)] + 1
		end
	end
	return output
end

function UI.MeasureStringWidth(str, font, scale)
	return MeasureStringWidthNoConvert(str, font, scale) * 1920
end

function UI.GetLargestStringWidth(font, scale, ...)
	local Widths, Strings = {}, { ... }
	local Largest = 0

	for Index = 1, #Strings do
		table.insert(Widths, UI.MeasureStringWidth(Strings[Index], font, scale))
	end

	for Index = 1, #Widths do
		if Widths[Index] > Largest then
			Largest = Widths[Index]
		end
	end

	return Largest
end

function UI.IsMouseInBounds(X, Y, Width, Height)
	local MX, MY = math.round(GetControlNormal(0, 239) * 1920), math.round(GetControlNormal(0, 240) * 1080)
	MX, MY = FormatXWYH(MX, MY)
	X, Y = FormatXWYH(X, Y)
	Width, Height = FormatXWYH(Width, Height)
	return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function UI.GetSafeZoneBounds()
	local SafeSize = GetSafeZoneSize()
	SafeSize = math.round(SafeSize, 2)
	SafeSize = (SafeSize * 100) - 90
	SafeSize = 10 - SafeSize

	local W, H = 1920, 1080

	return {X = math.round(SafeSize * ((W/H) * 5.4)), Y = math.round(SafeSize * 5.4)}
end

function UI.Text.New(Text, X, Y, Scale, R, G, B, A, Font, Alignment, DropShadow, Outline, WordWrap)
	local _Text = {
		Data = {
			Text = tostring(Text) or "",
			X = tonumber(X) or 0,
			Y = tonumber(Y) or 0,
			Scale = tonumber(Scale) or 0,
			Colour = {R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255},
			Font = tonumber(Font) or 0,
			Alignment = Alignment or nil,
			DropShadow = Dropshadow or nil,
			Outline = Outline or nil,
			WordWrap = tonumber(WordWrap) or 0,
		},
	}
	return setmetatable(_Text, UI.Text)
end

function UI.Text:Position(X, Y)
	if tonumber(X) and tonumber(Y) then
		self.Data.X = tonumber(X)
		self.Data.Y = tonumber(Y)
	else
		return {X = self.Data.X, Y = self.Data.Y}
	end
end

function UI.Text:Colour(R, G, B, A)
	if tonumber(R) and tonumber(G) and tonumber(B) and tonumber(A) then
		self.Data.Colour.R = tonumber(R)
		self.Data.Colour.B = tonumber(B)
		self.Data.Colour.G = tonumber(G)
		self.Data.Colour.A = tonumber(A)
	else
		return self.Data.Colour
	end
end

function UI.Text:Label(Label)
	if tostring(Label) and Label ~= nil then
		self.Data.Text = tostring(Label)
	else
		return self.Data.Text
	end
end

function UI.Text:Draw()
	local Position = self:Position()
	Position.X, Position.Y = FormatXWYH(Position.X, Position.Y)

	SetTextFont(self.Data.Font)
	SetTextScale(1.0, self.Data.Scale)
	SetTextColour(self.Data.Colour.R, self.Data.Colour.G, self.Data.Colour.B, self.Data.Colour.A)

	if self.Data.DropShadow then
		SetTextDropShadow()
	end
	if self.Data.Outline then
		SetTextOutline()
	end

	if self.Data.Alignment ~= nil then
		if self.Data.Alignment == 1 or self.Data.Alignment == "Center" or self.Data.Alignment == "Centre" then
			SetTextCentre(true)
		elseif self.Data.Alignment == 2 or self.Data.Alignment == "Right" then
			SetTextRightJustify(true)
			SetTextWrap(0, Position.X)
		end
	end

	if tonumber(self.Data.WordWrap) then
		if tonumber(self.Data.WordWrap) ~= 0 then
			local WordWrap, _ = FormatXWYH(self.Data.WordWrap, 0)
			SetTextWrap(WordWrap, X - WordWrap)
		end
	end

	BeginTextCommandDisplayText("STRING")
	AddLongString(self.Data.Text)
	EndTextCommandDisplayText(Position.X, Position.Y)
end

function UI.Rectangle.New(X, Y, Width, Height, R, G, B, A)
	local _Rectangle = {
		Data = {
			X = tonumber(X) or 0,
			Y = tonumber(Y) or 0,
			Width = tonumber(Width) or 0,
			Height = tonumber(Height) or 0,
			Colour = {R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255},
		},
	}
	return setmetatable(_Rectangle, UI.Rectangle)
end

function UI.Rectangle:Position(X, Y)
	if tonumber(X) and tonumber(Y) then
		self.Data.X = tonumber(X)
		self.Data.Y = tonumber(Y)
	else
		return {X = self.Data.X, Y = self.Data.Y}
	end
end

function UI.Rectangle:Size(Width, Height)
	if tonumber(Width) and tonumber(Height) then
		self.Data.Width = tonumber(Width)
		self.Data.Height = tonumber(Height)
	else
		return {Width = self.Data.Width, Height = self.Data.Height}
	end
end

function UI.Rectangle:Colour(R, G, B, A)
	if tonumber(R) and tonumber(G) and tonumber(B) and tonumber(A) then
		self.Data.Colour.R = tonumber(R)
		self.Data.Colour.B = tonumber(B)
		self.Data.Colour.G = tonumber(G)
		self.Data.Colour.A = tonumber(A)
	else
		return self.Data.Colour
	end
end

function UI.Rectangle:Draw()
	local Position = self:Position()
	local Size = self:Size()
	Size.Width, Size.Height = FormatXWYH(Size.Width, Size.Height)
	Position.X, Position.Y = FormatXWYH(Position.X, Position.Y)
	DrawRect(Position.X + Size.Width * 0.5, Position.Y + Size.Height * 0.5, Size.Width, Size.Height, self.Data.Colour.R, self.Data.Colour.G, self.Data.Colour.B, self.Data.Colour.A)
end

function UI.Sprite.New(TxtDictionary, TxtName, X, Y, Width, Height, Heading, R, G, B, A)
	local _Sprite = {
		Data = {
			TxtDictionary = tostring(TxtDictionary),
			TxtName = tostring(TxtName),
			X = tonumber(X) or 0,
			Y = tonumber(Y) or 0,
			Width = tonumber(Width) or 0, 
			Height = tonumber(Height) or 0,
			Heading = tonumber(Heading) or 0,
			Colour = {R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255},
		},
	}
	return setmetatable(_Sprite, UI.Sprite)
end

function UI.Sprite:Position(X, Y)
	if tonumber(X) and tonumber(Y) then
		self.Data.X = tonumber(X)
		self.Data.Y = tonumber(Y)
	else
		return {X = self.Data.X, Y = self.Data.Y}
	end
end

function UI.Sprite:Size(Width, Height)
	if tonumber(Width) and tonumber(Width) then
		self.Data.Width = tonumber(Width)
		self.Data.Height = tonumber(Height)
	else
		return {Width = self.Data.Width, Height = self.Data.Height}
	end
end

function UI.Sprite:Colour(R, G, B, A)
	if tonumber(R) and tonumber(G) and tonumber(B) and tonumber(A) then
		self.Data.Colour.R = tonumber(R)
		self.Data.Colour.B = tonumber(B)
		self.Data.Colour.G = tonumber(G)
		self.Data.Colour.A = tonumber(A)
	else
		return self.Data.Colour
	end
end

function UI.Sprite:Draw()
	if not HasStreamedTextureDictLoaded(self.Data.TxtDictionary) then
		RequestStreamedTextureDict(self.Data.TxtDictionary, true)
	end
	local Position = self:Position()
	local Size = self:Size()
	Size.Width, Size.Height = FormatXWYH(Size.Width, Size.Height)
	Position.X, Position.Y = FormatXWYH(Position.X, Position.Y)
	DrawSprite(self.Data.TxtDictionary, self.Data.TxtName, Position.X + Size.Width * 0.5, Position.Y + Size.Height * 0.5, Size.Width, Size.Height, self.Data.Heading, self.Data.Colour.R, self.Data.Colour.G, self.Data.Colour.B, self.Data.Colour.A)
end

function UI.RenderRectangle(X, Y, Width, Height, R, G, B, A)
	local X, Y, Width, Height = X or 0, Y or 0, Width or 0, Height or 0
	local X, Y = FormatXWYH(X, Y)
	local Width, Height = FormatXWYH(Width, Height)
	DrawRect(X + Width * 0.5, Y + Height * 0.5, Width, Height, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

function UI.RenderText(Label, X, Y, Scale, R, G, B, A, Font, Alignment, DropShadow, Outline, WordWrap)
	local Label = tostring(Label)
	local X, Y = FormatXWYH(X, Y)
	SetTextFont(Font or 0)
	SetTextScale(1.0, Scale or 0)
	SetTextColour(R or 255, G or 255, B or 255, A or 255)

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
			SetTextWrap(0, X)
		end
	end

	if tonumber(WordWrap) then
		if tonumber(WordWrap) ~= 0 then
			WordWrap, _ = FormatXWYH(WordWrap, 0)
			SetTextWrap(WordWrap, X - WordWrap)
		end
	end

	BeginTextCommandDisplayText("STRING")
	AddLongString(Label)
	EndTextCommandDisplayText(X, Y)
end

function UI.RenderSprite(TxtDictionary, TxtName, X, Y, Width, Height, Heading, R, G, B, A)
	if not HasStreamedTextureDictLoaded(tostring(TxtDictionary) or "") then
		RequestStreamedTextureDict(tostring(TxtDictionary) or "", true)
	end
	local X, Y, Width, Height = X or 0, Y or 0, Width or 0, Height or 0
	local X, Y = FormatXWYH(X, Y)
	local Width, Height = FormatXWYH(Width, Height)
	DrawSprite(tostring(TxtDictionary) or "", tostring(TxtName) or "", X + Width * 0.5, Y + Height * 0.5, Width, Height, tonumber(Heading) or 0, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

--[=====[
function UI.Scaleform.New(Scaleform, X, Y, Width, Height, R, G, B, A)
	local _Scaleform = {
		Data = {
			Scaleform = {
				Handle = nil,
				String = Scaleform,
			},
			X = tonumber(X) or 0,
			Y = tonumber(Y) or 0,
			Width = tonumber(Width) or 0, 
			Height = tonumber(Height) or 0,
			Colour = {R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255},
		},
	}

	_Scaleform.Data.Scaleform.Handle = RequestScaleformMovie(tostring(_Scaleform.Data.Scaleform.String) or "")

	if not _Scaleform.Data.Scaleform.Handle or _Scaleform.Data.Scaleform.Handle == 0 then
		Log.Error("Failed to create scaleform \"".._Scaleform.Data.Scaleform.String.."\n as its not valid!")
		return nil
	end

	while not HasScaleformMovieLoaded(_Scaleform.Data.Scaleform.Handle) do
		Citizen.Wait(250)
	end

	--SetScaleformMovieAsNoLongerNeeded(_Scaleform.Data.Scaleform.Handle)

	return setmetatable(_Scaleform, UI.Scaleform)
end

function UI.Scaleform:Position(X, Y)
	if tonumber(X) and tonumber(Y) then
		self.Data.X = tonumber(X)
		self.Data.Y = tonumber(Y)
	else
		return {X = self.Data.X, Y = self.Data.Y}
	end
end

function UI.Scaleform:Size(Width, Height)
	if tonumber(Width) and tonumber(Width) then
		self.Data.Width = tonumber(Width)
		self.Data.Height = tonumber(Height)
	else
		return {Width = self.Data.Width, Height = self.Data.Height}
	end
end

function UI.Scaleform:Colour(R, G, B, A)
	if tonumber(R) and tonumber(G) and tonumber(B) and tonumber(A) then
		self.Data.Colour.R = tonumber(R)
		self.Data.Colour.B = tonumber(B)
		self.Data.Colour.G = tonumber(G)
		self.Data.Colour.A = tonumber(A)
	else
		return self.Data.Colour
	end
end

function UI.Scaleform:Valid()
	if not _Scaleform.Data.Scaleform.Handle or _Scaleform.Data.Scaleform.Handle == 0 then
		return false
	else
		return true
	end
end

function UI.Scaleform:Call(Function, ...)
	if not self:Valid() then
		Log.Error("Failed to call function as the scaleform \""..self.Data.Scaleform.String.."\n is not valid!")
		return
	end

	if type(Function) ~= "string" then
		Log.Error("Failed to call scaleform function \""..Function.."\n as its not a string!")
		return
	end

	PopScaleformMovieFunction(self.Data.Scaleform.Handle)

	local Parameters = { ... }

	for Index = 1, #Parameters do
		local Parameter = Parameters[Index]
		local ParameterType = type(Parameter)
		if ParameterType == "string" then
			PushScaleformMovieFunctionParameterString(Parameter)
		elseif ParameterType == "number" then
			if not string.find(Parameter, '%.') then
				PushScaleformMovieFunctionParameterInt(Parameter)
			else
				PushScaleformMovieFunctionParameterFloat(Parameter)
			end
		elseif ParameterType == "boolean" then
			PushScaleformMovieFunctionParameterBool(Parameter)
		else
			Log.Error("Unknown parameter type \""..tostring(Parameter).."\" for scaleform \""..self.Data.Scaleform.String.."\n")
			return
		end
	end

	PopScaleformMovieFunctionVoid()
end

function UI.Scaleform:Draw()
	local Position = self:Position()
	local Size = self:Size()
	Size.Width, Size.Height = FormatXWYH(Size.Width, Size.Height)
	Position.X, Position.Y = FormatXWYH(Position.X, Position.Y)
	DrawScaleformMovie(self.Data.Scaleform.Handle, Position.X + Size.Width * 0.5, Position.Y + Size.Height * 0.5, Size.Width, Size.Height, self.Data.Colour.R, self.Data.Colour.G, self.Data.Colour.B, self.Data.Colour.A)
	print("X: "..(Position.X + Size.Width * 0.5)..", Y: "..(Position.Y + Size.Height * 0.5)..", Width: "..Size.Width..", Height: "..Size.Height)
end

function UI.Scaleform:DrawFullscreen()
	DrawScaleformMovieFullscreen(self.Data.Scaleform.Handle, self.Data.Colour.R, self.Data.Colour.G, self.Data.Colour.B, self.Data.Colour.A)
end

--]=====]
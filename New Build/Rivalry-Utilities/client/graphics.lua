Utilities.Data.BadgeStyles = {
	None = 0,
	BronzeMedal = 1,
	GoldMedal = 2,
	SilverMedal = 3,
	Alert = 4,
	Crown = 5,
	Ammo = 6,
	Armour = 7,
	Barber = 8,
	Clothes = 9,
	Franklin = 10,
	Bike = 11,
	Car = 12,
	Gun = 13,
	Heart = 14,
	Makeup = 15,
	Mask = 16,
	Michael = 17,
	Star = 18,
	Tattoo = 19,
	Trevor = 20,
	Lock = 21,
	Tick = 22
}

Utilities.Data.BadgeTextures = {
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
    [19] = function(Selected) if Selected then return "shop_tattoos_icon_b" else return "shop_tattoos_icon_a" end end,
    [20] = function(Selected) if Selected then return "shop_trevor_icon_b" else return "shop_trevor_icon_a" end end,
    [21] = function() return "shop_lock" end,
    [22] = function() return "shop_tick_icon" end,
}

Utilities.Data.BadgeDictionaries = {
    [0] = function(Selected) if Selected then return "commonmenu" else return "commonmenu" end end,
}

Utilities.Data.BadgeColours = {
    [5] = function(Selected) if Selected then return {0, 0, 0, 255} else return {255, 255, 255, 255} end end,
    [21] = function(Selected) if Selected then return {0, 0, 0, 255} else return {255, 255, 255, 255} end end,
    [22] = function(Selected) if Selected then return {0, 0, 0, 255} else return {255, 255, 255, 255} end end,
}

Utilities.Data.Colours = {
    PureWhite = {255, 255, 255, 255},
    White = {240, 240, 240, 255},
    Black = {0, 0, 0, 255},
    Grey = {155, 155, 155, 255},
    GreyLight = {205, 205, 205, 255},
    GreyDark = {77, 77, 77, 255},
    Red = {224, 50, 50, 255},
    RedLight = {240, 153, 153, 255},
    RedDark = {112, 25, 25, 255},
    Blue = {93, 182, 229, 255},
    BlueLight = {174, 219, 242, 255},
    BlueDark = {47, 92, 115, 255},
    Yellow = {240, 200, 80, 255},
    YellowLight = {254, 235, 169, 255},
    YellowDark = {126, 107, 41, 255},
    Orange = {255, 133, 85, 255},
    OrangeLight = {255, 194, 170, 255},
    OrangeDark = {127, 66, 42, 255},
    Green = {114, 204, 114, 255},
    GreenLight = {185, 230, 185, 255},
    GreenDark = {57, 102, 57, 255},
    Purple = {132, 102, 226, 255},
    PurpleLight = {192, 179, 239, 255},
    PurpleDark = {67, 57, 111, 255},
    Pink = {203, 54, 148, 255},
    RadarHealth = {53, 154, 71, 255},
    RadarArmour = {93, 182, 229, 255},
    RadarDamage = {235, 36, 39, 255},
    NetPlayer1 = {194, 80, 80, 255},
    NetPlayer2 = {156, 110, 175, 255},
    NetPlayer3 = {255, 123, 196, 255},
    NetPlayer4 = {247, 159, 123, 255},
    NetPlayer5 = {178, 144, 132, 255},
    NetPlayer6 = {141, 206, 167, 255},
    NetPlayer7 = {113, 169, 175, 255},
    NetPlayer8 = {211, 209, 231, 255},
    NetPlayer9 = {144, 127, 153, 255},
    NetPlayer10 = {106, 196, 191, 255},
    NetPlayer11 = {214, 196, 153, 255},
    NetPlayer12 = {234, 142, 80, 255},
    NetPlayer13 = {152, 203, 234, 255},
    NetPlayer14 = {178, 98, 135, 255},
    NetPlayer15 = {144, 142, 122, 255},
    NetPlayer16 = {166, 117, 94, 255},
    NetPlayer17 = {175, 168, 168, 255},
    NetPlayer18 = {232, 142, 155, 255},
    NetPlayer19 = {187, 214, 91, 255},
    NetPlayer20 = {12, 123, 86, 255},
    NetPlayer21 = {123, 196, 255, 255},
    NetPlayer22 = {171, 60, 230, 255},
    NetPlayer23 = {206, 169, 13, 255},
    NetPlayer24 = {71, 99, 173, 255},
    NetPlayer25 = {42, 166, 185, 255},
    NetPlayer26 = {186, 157, 125, 255},
    NetPlayer27 = {201, 225, 255, 255},
    NetPlayer28 = {240, 240, 150, 255},
    NetPlayer29 = {237, 140, 161, 255},
    NetPlayer30 = {249, 138, 138, 255},
    NetPlayer31 = {252, 239, 166, 255},
    NetPlayer32 = {240, 240, 240, 255},
    SimpleBlipDefault = {159, 201, 166, 255},
    MenuBlue = {140, 140, 140, 255},
    MenuGreyLight = {140, 140, 140, 255},
    MenuBlueExtraDark = {40, 40, 40, 255},
    MenuYellow = {240, 160, 0, 255},
    MenuYellowDark = {240, 160, 0, 255},
    MenuGreen = {240, 160, 0, 255},
    MenuGrey = {140, 140, 140, 255},
    MenuGreyDark = {60, 60, 60, 255},
    MenuHighlight = {30, 30, 30, 255},
    MenuStandard = {140, 140, 140, 255},
    MenuDimmed = {75, 75, 75, 255},
    MenuExtraDimmed = {50, 50, 50, 255},
    BriefTitle = {95, 95, 95, 255},
    MidGreyMp = {100, 100, 100, 255},
    NetPlayer1Dark = {93, 39, 39, 255},
    NetPlayer2Dark = {77, 55, 89, 255},
    NetPlayer3Dark = {124, 62, 99, 255},
    NetPlayer4Dark = {120, 80, 80, 255},
    NetPlayer5Dark = {87, 72, 66, 255},
    NetPlayer6Dark = {74, 103, 83, 255},
    NetPlayer7Dark = {60, 85, 88, 255},
    NetPlayer8Dark = {105, 105, 64, 255},
    NetPlayer9Dark = {72, 63, 76, 255},
    NetPlayer10Dark = {53, 98, 95, 255},
    NetPlayer11Dark = {107, 98, 76, 255},
    NetPlayer12Dark = {117, 71, 40, 255},
    NetPlayer13Dark = {76, 101, 117, 255},
    NetPlayer14Dark = {65, 35, 47, 255},
    NetPlayer15Dark = {72, 71, 61, 255},
    NetPlayer16Dark = {85, 58, 47, 255},
    NetPlayer17Dark = {87, 84, 84, 255},
    NetPlayer18Dark = {116, 71, 77, 255},
    NetPlayer19Dark = {93, 107, 45, 255},
    NetPlayer20Dark = {6, 61, 43, 255},
    NetPlayer21Dark = {61, 98, 127, 255},
    NetPlayer22Dark = {85, 30, 115, 255},
    NetPlayer23Dark = {103, 84, 6, 255},
    NetPlayer24Dark = {35, 49, 86, 255},
    NetPlayer25Dark = {21, 83, 92, 255},
    NetPlayer26Dark = {93, 98, 62, 255},
    NetPlayer27Dark = {100, 112, 127, 255},
    NetPlayer28Dark = {120, 120, 75, 255},
    NetPlayer29Dark = {152, 76, 93, 255},
    NetPlayer30Dark = {124, 69, 69, 255},
    NetPlayer31Dark = {10, 43, 50, 255},
    NetPlayer32Dark = {95, 95, 10, 255},
    Bronze = {180, 130, 97, 255},
    Silver = {150, 153, 161, 255},
    Gold = {214, 181, 99, 255},
    Platinum = {166, 221, 190, 255},
    Gang1 = {29, 100, 153, 255},
    Gang2 = {214, 116, 15, 255},
    Gang3 = {135, 125, 142, 255},
    Gang4 = {229, 119, 185, 255},
    SameCrew = {252, 239, 166, 255},
    Freemode = {45, 110, 185, 255},
    PauseBg = {0, 0, 0, 255},
    Friendly = {93, 182, 229, 255},
    Enemy = {194, 80, 80, 255},
    Location = {240, 200, 80, 255},
    Pickup = {114, 204, 114, 255},
    PauseSingleplayer = {114, 204, 114, 255},
    FreemodeDark = {22, 55, 92, 255},
    InactiveMission = {154, 154, 154, 255},
    Damage = {194, 80, 80, 255},
    PinkLight = {252, 115, 201, 255},
    PmMitemHighlight = {252, 177, 49, 255},
    ScriptVariable = {0, 0, 0, 255},
    Yoga = {109, 247, 204, 255},
    Tennis = {241, 101, 34, 255},
    Golf = {214, 189, 97, 255},
    ShootingRange = {112, 25, 25, 255},
    FlightSchool = {47, 92, 115, 255},
    NorthBlue = {93, 182, 229, 255},
    SocialClub = {234, 153, 28, 255},
    PlatformBlue = {11, 55, 123, 255},
    PlatformGreen = {146, 200, 62, 255},
    PlatformGrey = {234, 153, 28, 255},
    FacebookBlue = {66, 89, 148, 255},
    IngameBg = {0, 0, 0, 255},
    Darts = {114, 204, 114, 255},
    Waypoint = {164, 76, 242, 255},
    Michael = {101, 180, 212, 255},
    Franklin = {171, 237, 171, 255},
    Trevor = {255, 163, 87, 255},
    GolfP1 = {240, 240, 240, 255},
    GolfP2 = {235, 239, 30, 255},
    GolfP3 = {255, 149, 14, 255},
    GolfP4 = {246, 60, 161, 255},
    WaypointLight = {210, 166, 249, 255},
    WaypointDark = {82, 38, 121, 255},
    PanelLight = {0, 0, 0, 255},
    MichaelDark = {72, 103, 116, 255},
    FranklinDark = {85, 118, 85, 255},
    TrevorDark = {127, 81, 43, 255},
    ObjectiveRoute = {240, 200, 80, 255},
    PausemapTint = {0, 0, 0, 255},
    PauseDeselect = {100, 100, 100, 255},
    PmWeaponsPurchasable = {45, 110, 185, 255},
    PmWeaponsLocked = {240, 240, 240, 255},
    ScreenBg = {0, 0, 0, 255},
    Chop = {224, 50, 50, 255},
    PausemapTintHalf = {0, 0, 0, 255},
    NorthBlueOfficial = {0, 71, 133, 255},
    ScriptVariable2 = {0, 0, 0, 255},
    H = {33, 118, 37, 255},
    HDark = {37, 102, 40, 255},
    T = {234, 153, 28, 255},
    TDark = {225, 140, 8, 255},
    HShard = {20, 40, 0, 255},
    ControllerMichael = {48, 255, 255, 255},
    ControllerFranklin = {48, 255, 0, 255},
    ControllerTrevor = {176, 80, 0, 255},
    ControllerChop = {127, 0, 0, 255},
    VideoEditorVideo = {53, 166, 224, 255},
    VideoEditorAudio = {162, 79, 157, 255},
    VideoEditorText = {104, 192, 141, 255},
    HbBlue = {29, 100, 153, 255},
    HbYellow = {234, 153, 28, 255},
    VideoEditorScore = {240, 160, 1, 255},
    VideoEditorAudioFadeout = {59, 34, 57, 255},
    VideoEditorTextFadeout = {41, 68, 53, 255},
    VideoEditorScoreFadeout = {82, 58, 10, 255},
    HeistBackground = {37, 102, 40, 255},
    VideoEditorAmbient = {240, 200, 80, 255},
    VideoEditorAmbientFadeout = {80, 70, 34, 255},
    Gb = {255, 133, 85, 255},
    G = {255, 194, 170, 255},
    B = {255, 133, 85, 255},
    LowFlow = {240, 200, 80, 255},
    LowFlowDark = {126, 107, 41, 255},
    G1 = {247, 159, 123, 255},
    G2 = {226, 134, 187, 255},
    G3 = {239, 238, 151, 255},
    G4 = {113, 169, 175, 255},
    G5 = {160, 140, 193, 255},
    G6 = {141, 206, 167, 255},
    G7 = {181, 214, 234, 255},
    G8 = {178, 144, 132, 255},
    G9 = {0, 132, 114, 255},
    G10 = {216, 85, 117, 255},
    G11 = {30, 100, 152, 255},
    G12 = {43, 181, 117, 255},
    G13 = {233, 141, 79, 255},
    G14 = {137, 210, 215, 255},
    G15 = {134, 125, 141, 255},
    Adversary = {109, 34, 33, 255},
    DegenRed = {255, 0, 0, 255},
    DegenYellow = {255, 255, 0, 255},
    DegenGreen = {0, 255, 0, 255},
    DegenCyan = {0, 255, 255, 255},
    DegenBlue = {0, 0, 255, 255},
    DegenMagenta = {255, 0, 255, 255},
    Stunt1 = {38, 136, 234, 255},
    Stunt2 = {224, 50, 50, 255},
}

Utilities.Data.values = function(xs)
	local i = 0
	return function()
		i = i + 1;
		return xs[i]
	end
end

Utilities.Data.map = function(xs, fn)
	local t = {}
	for i,v in ipairs(xs) do
		local r = fn(v, i, xs)
		table.insert(t, r)
	end
	return t
end

function Utilities:GetBadge(Badge, Selected)
	if self.Data.BadgeStyles[Badge] then
		return self.Data.BadgeDictionaries[Badge](Selected), self.Data.BadgeTextures[Badge](Selected), self.Data.BadgeColours[Badge](Selected)
	else
		return "commonmenu", "", {255, 255, 255, 255}
	end
end

function Utilities:GetColour(Colour)
	if self.Data.Colours[Colour] then
		return self.Data.Colours[Colour]
	else
		return {255, 255, 255, 255}
	end
end

function Utilities:GetBoundingBox(Min, Max, Pad)
	local Pad = Pad or 0.001

	return {
		-- Bottom
		vector3(Min.x - Pad, Min.y - Pad, Min.z - Pad), -- back right
		vector3(Max.x + Pad, Min.y - Pad, Min.z - Pad), -- back left
		vector3(Max.x + Pad, Max.y + Pad, Min.z - Pad), -- front left
		vector3(Min.x - Pad, Max.y + Pad, Min.z - Pad), -- front right

		-- Top
		vector3(Min.x - Pad, Min.y - Pad, Max.z + Pad), -- back right
		vector3(Max.x + Pad, Min.y - Pad, Max.z + Pad), -- back left
		vector3(Max.x + Pad, Max.y + Pad, Max.z + Pad), -- front left
		vector3(Min.x - Pad, Max.y + Pad, Max.z + Pad), -- front right
	}
end

function Utilities:GetBoundingBoxEdgeMatrix(Box)
	return {
		-- Bottom
		{ Box[1], Box[2] },
		{ Box[2], Box[3] },
		{ Box[3], Box[4] },
		{ Box[4], Box[1] },

		-- Top
		{ Box[5], Box[6] },
		{ Box[6], Box[7] },
		{ Box[7], Box[8] },
		{ Box[8], Box[5] },

		-- Sides
		{ Box[1], Box[5] },
		{ Box[2], Box[6] },
		{ Box[3], Box[7] },
		{ Box[4], Box[8] },
	}
end

function Utilities:GetBoundingBoxPolyMatrix(box)
	return {
		-- Bottom
		{ Box[3], Box[2], Box[1] },
		{ Box[4], Box[3], Box[1] },

		-- Top
		{ Box[5], Box[6], Box[7] },
		{ Box[5], Box[7], Box[8] },

		-- Front
		{ Box[3], Box[4], Box[7] },
		{ Box[8], Box[7], Box[4] },

		-- Back
		{ Box[1], Box[2], Box[5] },
		{ Box[6], Box[5], Box[2] },

		-- Left
		{ Box[2], Box[3], Box[6] },
		{ Box[3], Box[7], Box[6] },

		-- Right
		{ Box[5], Box[8], Box[4] },
		{ Box[5], Box[4], Box[1] },
	}
end

function Utilities:GetModelBoundingBox(Model)
	local Min, Max = GetModelDimensions(Model)
	return self:GetBoundingBox(Min, Max)
end

function Utilities:GetEntityBoundingBox(Entity)
	local Model = GetEntityModel(Entity)
	local Box = GetModelBoundingBox(Model)

	return Utilities.Data.map(Box, function (Corner)
		return GetOffsetFromEntityInWorldCoords(Entity, Corner)
	end)
end

function Utilities:IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = self:Round(GetControlNormal(0, 239) * 1920)/1920, self:Round(GetControlNormal(0, 240) * 1080)/1080

    X, Y = X/1920, Y/1080

    Width, Height = Width/1920, Height/1080

    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function Utilities:GetSafeZoneBounds()
    local SafeSize = GetSafeZoneSize()

    SafeSize = self:Round(SafeSize, 2)
    SafeSize = (SafeSize * 100) - 90
    SafeSize = 10 - SafeSize

    local W, H = 1920, 1080

    return {X = self:Round(SafeSize * ((W/H) * 5.4)), Y = self:Round(SafeSize * 5.4)}
end

function Utilities:GetCharacterCount(Str)
    local Chars = 0

    for Char in Str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        Chars = Chars + 1
    end

    return Chars
end

function Utilities:GetByteCount(Str)
    local Bytes = 0

    for Char in Str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        Bytes = Bytes + #table.pack(Char:byte(1, -1))
    end

    return Bytes
end

function Utilities:GetStringWidthNoConvert(Str, Font, Scale)
    BeginTextCommandWidth("STRING")

    AddTextComponentSubstringPlayerName(Str)

    SetTextFont(Font or 0)
    SetTextScale(1.0, Scale or 0)

    return EndTextCommandGetWidth(true)
end

function Utilities:GetStringWidth(Str, Font, Scale)
    return self:GetStringWidthNoConvert(Str, Font, Scale) * 1920
end

function Utilities:RenderSprite(TextureDictionary, TextureName, X, Y, Width, Height, Heading, R, G, B, A)
    local X, Y, Width, Height = (tonumber(X) or 0)/1920, (tonumber(Y) or 0)/1080, (tonumber(Width) or 0)/1920, (tonumber(Height) or 0)/1080

    if not HasStreamedTextureDictLoaded(TextureDictionary) then
        RequestStreamedTextureDict(TextureDictionary, true)
    end

    DrawSprite(TextureDictionary, TextureName, X + Width * 0.5, Y + Height * 0.5, Width, Height, Heading or 0, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

function Utilities:RenderRectangle(X, Y, Width, Height, R, G, B, A)
    local X, Y, Width, Height = (tonumber(X) or 0)/1920, (tonumber(Y) or 0)/1080, (tonumber(Width) or 0)/1920, (tonumber(Height) or 0)/1080

    DrawRect(X + Width * 0.5, Y + Height * 0.5, Width, Height, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

function Utilities:RenderText(Text, X, Y, Font, Scale, R, G, B, A, Alignment, DropShadow, Outline, WordWrap)
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

function Utilities:GetLineCount(Text, X, Y, Font, Scale, R, G, B, A, Alignment, DropShadow, Outline, WordWrap)
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

function Utilities:DrawEdgeMatrix(lines, r, g, b, a)
	for Line in self.Data.values(lines) do
		local x1, y1, z1 = table.unpack(Line[1])
		local x2, y2, z2 = table.unpack(Line[2])

		DrawLine(x1, y1, z1, x2, y2, z2, r, g, b, a)
	end
end

function Utilities:DrawPolyMatrix(Polies, r, g, b, a)
	for Poly in self.Data.values(Polies) do
		local x1, y1, z1 = table.unpack(Poly[1])
		local x2, y2, z2 = table.unpack(Poly[2])
		local x3, y3, z3 = table.unpack(Poly[3])

		DrawPoly(x1, y1, z1, x2, y2, z2, x3, y3, z3, r, g, b, a)
	end
end


function Utilities:DrawBoundingBox(Box, r1, g1, b1, a1, r2, g2, b2, a2)
	local polyMatrix = self:GetBoundingBoxPolyMatrix(Box)
	local edgeMatrix = self:GetBoundingBoxEdgeMatrix(Box)

	self:DrawEdgeMatrix(edgeMatrix, r1 or 255, g1 or 255, b1 or 255, a1 or 255)
	self:DrawPolyMatrix(polyMatrix, r2 or 255, g2 or 255, b2 or 255, a2 or 0)
end


function Utilities:DrawEntityBoundingBox(Entity, r1, g1, b1, a1, r2, g2, b2, a2)
	local Box = self:GetEntityBoundingBox(Entity)
	return self:DrawBoundingBox(Box, r1, g1, b1, a1, r2, g2, b2, a2)
end
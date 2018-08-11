UI = {
	Data = {},
	Metatables = {
		Rectangle = setmetatable({}, UI.Metatables.Rectangle),
		Text = setmetatable({}, UI.Metatables.Text),
		Sprite = setmetatable({}, UI.Metatables.Sprite),
	},
}

UI.Metatables.Rectangle.__index = UI.Metatables.Rectangle
UI.Metatables.Rectangle.__call = function() return "Rectangle" end

UI.Metatables.Text.__index = UI.Metatables.Text
UI.Metatables.Text.__call = function() return "Text" end

UI.Metatables.Sprite.__index = UI.Metatables.Sprite
UI.Metatables.Sprite.__call = function() return "Sprite" end

UI.Data.BadgeStyle = {
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

UI.Data.BadgeTexture = {
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

UI.Data.BadgeDictionary = {
    [0] = function(Selected)
        if Selected then
            return "commonmenu"
        else
            return "commonmenu"
        end
    end,
}

UI.Data.BadgeColour = {
    [5] = function(Selected) if Selected then return 0, 0, 0, 255 else return 255, 255, 255, 255 end end,
    [21] = function(Selected) if Selected then return 0, 0, 0, 255 else return 255, 255, 255, 255 end end,
    [22] = function(Selected) if Selected then return 0, 0, 0, 255 else return 255, 255, 255, 255   end end,
}

UI.Colours = {
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

function UI.FormatXWYH(Value, Value2)
    return Value/1920, Value2/1080
end

function UI.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = Utilities.RoundNumber(GetControlNormal(0, 239) * 1920), Utilities.RoundNumber(GetControlNormal(0, 240) * 1080)
    MX, MY = UI.FormatXWYH(MX, MY)
    X, Y = UI.FormatXWYH(X, Y)
    Width, Height = UI.FormatXWYH(Width, Height)
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function UI.GetSafeZoneBounds()
    local SafeSize = GetSafeZoneSize()
    SafeSize = Utilities.RoundNumber(SafeSize, 2)
    SafeSize = (SafeSize * 100) - 90
    SafeSize = 10 - SafeSize

    local W, H = 1920, 1080

    return {X = Utilities.RoundNumber(SafeSize * ((W/H) * 5.4)), Y = Utilities.RoundNumber(SafeSize * 5.4)}
end

function UI.GetCharacterCount(str)
    local characters = 0
    for c in str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        local a = c:byte(1, -1)
        if a ~= nil then
            characters = characters + 1
        end
    end
    return characters
end

function UI.GetByteCount(str)
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

function UI.AddLongStringForAscii(str)
    local maxbytelength = 99
    for i = 0, UI.GetCharacterCount(str), 99 do
        AddTextComponentSubstringPlayerName(string.sub(str, i, math.min(maxbytelength, GetCharacterCount(str) - i))) --needs changed
    end
end

function UI.AddLongStringForUtf8(str)
    local maxbytelength = 99
    local bytecount = GetByteCount(str)

    if bytecount < maxbytelength then
        AddTextComponentSubstringPlayerName(str)
        return
    end

    local startIndex = 0

    for i = 0, UI.GetCharacterCount(str), 1 do
        local length = i - startIndex
        if UI.GetByteCount(string.sub(str, startIndex, length)) > maxbytelength then
            AddTextComponentSubstringPlayerName(string.sub(str, startIndex, length - 1))
            i = i - 1
            startIndex = startIndex + (length - 1)
        end
    end
    AddTextComponentSubstringPlayerName(string.sub(str, startIndex, UI.GetCharacterCount(str) - startIndex))
end 

function UI.AddLongString(str)
    local bytecount = UI.GetByteCount(str)
    if bytecount == UI.GetCharacterCount(str) then
        UI.AddLongStringForAscii(str)
    else
        UI.AddLongStringForUtf8(str)
    end
end

function UI.MeasureStringWidthNoConvert(str, font, scale)
    BeginTextCommandWidth("STRING")
    UI.AddLongString(str)
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0)
    return EndTextCommandGetWidth(true)
end

function UI.MeasureStringWidth(str, font, scale)
    return UI.MeasureStringWidthNoConvert(str, font, scale) * 1920
end

function UI.GetBadgeTexture(Badge, Selected)
    if UI.Data.BadgeTexture[Badge] then
        return UI.Data.BadgeTexture[Badge](Selected)
    else
        return ""
    end
end

function UI.GetBadgeDictionary(Badge, Selected)
    if UI.Data.BadgeDictionary[Badge] then
        return UI.Data.BadgeDictionary[Badge](Selected)
    else
        return "commonmenu"
    end
end

function UI.GetBadgeColour(Badge, Selected)
    if UI.Data.BadgeColour[Badge] then
        return UI.Data.BadgeColour[Badge](Selected)
    else
        return 255, 255, 255, 255
    end
end

function UI.Rectangle(X, Y, Width, Height, R, G, B, A)
    local _Rectangle = {
        X = tonumber(X) or 0,
        Y = tonumber(Y) or 0,
        Width = tonumber(Width) or 0,
        Height = tonumber(Height) or 0,
        _Colour = {R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255},
    }
    return setmetatable(_Rectangle, UI.Metatables.Rectangle)
end

function UI.Text(Text, X, Y, Scale, R, G, B, A, Font, Alignment, DropShadow, Outline, WordWrap)
    local _Text = {
        _Text = tostring(Text) or "",
        X = tonumber(X) or 0,
        Y = tonumber(Y) or 0,
        Scale = tonumber(Scale) or 0,
        _Colour = {R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255},
        Font = tonumber(Font) or 0,
        Alignment = Alignment or nil,
        DropShadow = Dropshadow or nil,
        Outline = Outline or nil,
        WordWrap = tonumber(WordWrap) or 0,
    }
    return setmetatable(_Text, UI.Metatables.Text)
end

function UI.Sprite(TxtDictionary, TxtName, X, Y, Width, Height, Heading, R, G, B, A)
    local _Sprite = {
        TxtDictionary = tostring(TxtDictionary),
        TxtName = tostring(TxtName),
        X = tonumber(X) or 0,
        Y = tonumber(Y) or 0,
        Width = tonumber(Width) or 0, 
        Height = tonumber(Height) or 0,
        Heading = tonumber(Heading) or 0,
        _Colour = {R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255},
    }
    return setmetatable(_Sprite, UI.Metatables.Sprite)
end

function UI.RenderRectangle(X, Y, Width, Height, R, G, B, A)
    X, Y, Width, Height = X or 0, Y or 0, Width or 0, Height or 0

    X, Y = UI.FormatXWYH(X, Y)
    Width, Height = UI.FormatXWYH(Width, Height)

    DrawRect(X + Width * 0.5, Y + Height * 0.5, Width, Height, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

function UI.RenderText(Text, X, Y, Font, Scale, R, G, B, A, Alignment, DropShadow, Outline, WordWrap)
    Text = tostring(Text)
    X, Y = UI.FormatXWYH(X, Y)
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
            WordWrap, _ = UI.FormatXWYH(WordWrap, 0)
            SetTextWrap(WordWrap, X - WordWrap)
        end
    end

    BeginTextCommandDisplayText("STRING")
    UI.AddLongString(Text)
    EndTextCommandDisplayText(X, Y)
end

function UI.RenderSprite(TxtDictionary, TxtName, X, Y, Width, Height, Heading, R, G, B, A)
    if not HasStreamedTextureDictLoaded(tostring(TxtDictionary) or "") then
        RequestStreamedTextureDict(tostring(TxtDictionary) or "", true)
    end

    X, Y, Width, Height = X or 0, Y or 0, Width or 0, Height or 0

    X, Y = UI.FormatXWYH(X, Y)
    Width, Height = UI.FormatXWYH(Width, Height)

    DrawSprite(tostring(TxtDictionary) or "", tostring(TxtName) or "", X + Width * 0.5, Y + Height * 0.5, Width, Height, tonumber(Heading) or 0, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

--[[ 
	Metatable stuff
]]--

function UI.Metatables.Rectangle:Position(X, Y)
    if tonumber(X) and tonumber(Y) then
        self.X = tonumber(X)
        self.Y = tonumber(Y)
    else
        return {X = self.X, Y = self.Y}
    end
end

function UI.Metatables.Rectangle:Size(Width, Height)
    if tonumber(Width) and tonumber(Height) then
        self.Width = tonumber(Width)
        self.Height = tonumber(Height)
    else
        return {Width = self.Width, Height = self.Height}
    end
end

function UI.Metatables.Rectangle:Colour(R, G, B, A)
    if tonumber(R) or tonumber(G) or tonumber(B) or tonumber(A) then
        self._Colour.R = tonumber(R) or 255
        self._Colour.B = tonumber(B) or 255
        self._Colour.G = tonumber(G) or 255
        self._Colour.A = tonumber(A) or 255
    else
        return self._Colour
    end
end

function UI.Metatables.Rectangle:Draw()
    local Position = self:Position()
    local Size = self:Size()

    Size.Width, Size.Height = UI.FormatXWYH(Size.Width, Size.Height)
    Position.X, Position.Y = UI.FormatXWYH(Position.X, Position.Y)

    DrawRect(Position.X + Size.Width * 0.5, Position.Y + Size.Height * 0.5, Size.Width, Size.Height, self._Colour.R, self._Colour.G, self._Colour.B, self._Colour.A)
end

function UI.Metatables.Text:Position(X, Y)
    if tonumber(X) and tonumber(Y) then
        self.X = tonumber(X)
        self.Y = tonumber(Y)
    else
        return {X = self.X, Y = self.Y}
    end
end

function UI.Metatables.Text:Colour(R, G, B, A)
    if tonumber(R) and tonumber(G) and tonumber(B) and tonumber(A) then
        self._Colour.R = tonumber(R)
        self._Colour.B = tonumber(B)
        self._Colour.G = tonumber(G)
        self._Colour.A = tonumber(A)
    else
        return self._Colour
    end
end

function UI.Metatables.Text:Text(Text)
    if tostring(Text) and Text ~= nil then
        self._Text = tostring(Text)
    else
        return self._Text
    end
end

function UI.Metatables.Text:Draw()
    local Position = self:Position()

    Position.X, Position.Y = UI.FormatXWYH(Position.X, Position.Y)

    SetTextFont(self.Font)
    SetTextScale(1.0, self.Scale)
    SetTextColour(self._Colour.R, self._Colour.G, self._Colour.B, self._Colour.A)

    if self.DropShadow then
        SetTextDropShadow()
    end

    if self.Outline then
        SetTextOutline()
    end

    if self.Alignment ~= nil then
        if self.Alignment == 1 or self.Alignment == "Center" or self.Alignment == "Centre" then
            SetTextCentre(true)
        elseif self.Alignment == 2 or self.Alignment == "Right" then
            SetTextRightJustify(true)
            SetTextWrap(0, Position.X)
        end
    end

    if tonumber(self.WordWrap) then
        if tonumber(self.WordWrap) ~= 0 then
        	local WordWrap, _ = UI.FormatXWYH(self.WordWrap, 0)
        	SetTextWrap(WordWrap, Position.X - WordWrap)
        end
    end

    BeginTextCommandDisplayText("STRING")
    UI.AddLongString(self._Text)
    EndTextCommandDisplayText(Position.X, Position.Y)
end

function UI.Metatables.Sprite:Position(X, Y)
    if tonumber(X) and tonumber(Y) then
        self.X = tonumber(X)
        self.Y = tonumber(Y)
    else
        return {X = self.X, Y = self.Y}
    end
end

function UI.Metatables.Sprite:Size(Width, Height)
    if tonumber(Width) and tonumber(Width) then
        self.Width = tonumber(Width)
        self.Height = tonumber(Height)
    else
        return {Width = self.Width, Height = self.Height}
    end
end

function UI.Metatables.Sprite:Colour(R, G, B, A)
    if tonumber(R) or tonumber(G) or tonumber(B) or tonumber(A) then
        self._Colour.R = tonumber(R) or 255
        self._Colour.B = tonumber(B) or 255
        self._Colour.G = tonumber(G) or 255
        self._Colour.A = tonumber(A) or 255
    else
        return self._Colour
    end
end

function UI.Metatables.Sprite:Draw()
    if not HasStreamedTextureDictLoaded(self.TxtDictionary) then
        RequestStreamedTextureDict(self.TxtDictionary, true)
    end

    local Position = self:Position()
    local Size = self:Size()

    Size.Width, Size.Height = UI.FormatXWYH(Size.Width, Size.Height)
    Position.X, Position.Y = UI.FormatXWYH(Position.X, Position.Y)

    DrawSprite(self.TxtDictionary, self.TxtName, Position.X + Size.Width * 0.5, Position.Y + Size.Height * 0.5, Size.Width, Size.Height, self.Heading, self._Colour.R, self._Colour.G, self._Colour.B, self._Colour.A)
end
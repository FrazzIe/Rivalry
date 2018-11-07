--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                        Vehicle Rentals                                                       --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Variables                                                          --
--==============================================================================================================================--
isCarRentalOpen = false
isBoatRentalOpen = false                                                                                                       --
local vehbool = false                                                                                                           --
local currentShop = nil                                                                                                         --
local currentMarker = nil                                                                                                       --
local currentCategory = nil                                                                                                     --
local currentPreview = {model=0, entity=nil}                                                                                    --
local currentExit = nil                                                                                                         --  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Configuration                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
keys = {[0] = "ControlNextCamera", [1] = "ControlLookLeftRight", [2] = "ControlLookUpDown", [3] = "ControlLookUpOnly", [4] = "ControlLookDownOnly", [5] = "ControlLookLeftOnly", [6] = "ControlLookRightOnly", [7] = "ControlCinematicSlowMo", [8] = "ControlFlyUpDown", [9] = "ControlFlyLeftRight", [10] = "ControlScriptedFlyZUp", [11] = "ControlScriptedFlyZDown", [12] = "ControlWeaponWheelUpDown", [13] = "ControlWeaponWheelLeftRight", [14] = "ControlWeaponWheelNext", [15] = "ControlWeaponWheelPrev", [16] = "ControlSelectNextWeapon", [17] = "ControlSelectPrevWeapon", [18] = "ControlSkipCutscene", [19] = "ControlCharacterWheel", [20] = "ControlMultiplayerInfo", [21] = "ControlSprint", [22] = "ControlJump", [23] = "ControlEnter", [24] = "ControlAttack", [25] = "ControlAim", [26] = "ControlLookBehind", [27] = "ControlPhone", [28] = "ControlSpecialAbility", [29] = "ControlSpecialAbilitySecondary", [30] = "ControlMoveLeftRight", [31] = "ControlMoveUpDown", [32] = "ControlMoveUpOnly", [33] = "ControlMoveDownOnly", [34] = "ControlMoveLeftOnly", [35] = "ControlMoveRightOnly", [36] = "ControlDuck", [37] = "ControlSelectWeapon", [38] = "ControlPickup", [39] = "ControlSniperZoom", [40] = "ControlSniperZoomInOnly", [41] = "ControlSniperZoomOutOnly", [42] = "ControlSniperZoomInSecondary", [43] = "ControlSniperZoomOutSecondary", [44] = "ControlCover", [45] = "ControlReload", [46] = "ControlTalk", [47] = "ControlDetonate", [48] = "ControlHUDSpecial", [49] = "ControlArrest", [50] = "ControlAccurateAim", [51] = "ControlContext", [52] = "ControlContextSecondary", [53] = "ControlWeaponSpecial", [54] = "ControlWeaponSpecial2", [55] = "ControlDive", [56] = "ControlDropWeapon", [57] = "ControlDropAmmo", [58] = "ControlThrowGrenade", [59] = "ControlVehicleMoveLeftRight", [60] = "ControlVehicleMoveUpDown", [61] = "ControlVehicleMoveUpOnly", [62] = "ControlVehicleMoveDownOnly", [63] = "ControlVehicleMoveLeftOnly", [64] = "ControlVehicleMoveRightOnly", [65] = "ControlVehicleSpecial", [66] = "ControlVehicleGunLeftRight", [67] = "ControlVehicleGunUpDown", [68] = "ControlVehicleAim", [69] = "ControlVehicleAttack", [70] = "ControlVehicleAttack2", [71] = "ControlVehicleAccelerate", [72] = "ControlVehicleBrake", [73] = "ControlVehicleDuck", [74] = "ControlVehicleHeadlight", [75] = "ControlVehicleExit", [76] = "ControlVehicleHandbrake", [77] = "ControlVehicleHotwireLeft", [78] = "ControlVehicleHotwireRight", [79] = "ControlVehicleLookBehind", [80] = "ControlVehicleCinCam", [81] = "ControlVehicleNextRadio", [82] = "ControlVehiclePrevRadio", [83] = "ControlVehicleNextRadioTrack", [84] = "ControlVehiclePrevRadioTrack", [85] = "ControlVehicleRadioWheel", [86] = "ControlVehicleHorn", [87] = "ControlVehicleFlyThrottleUp", [88] = "ControlVehicleFlyThrottleDown", [89] = "ControlVehicleFlyYawLeft", [90] = "ControlVehicleFlyYawRight", [91] = "ControlVehiclePassengerAim", [92] = "ControlVehiclePassengerAttack", [93] = "ControlVehicleSpecialAbilityFranklin", [94] = "ControlVehicleStuntUpDown", [95] = "ControlVehicleCinematicUpDown", [96] = "ControlVehicleCinematicUpOnly", [97] = "ControlVehicleCinematicDownOnly", [98] = "ControlVehicleCinematicLeftRight", [99] = "ControlVehicleSelectNextWeapon", [100] = "ControlVehicleSelectPrevWeapon", [101] = "ControlVehicleRoof", [102] = "ControlVehicleJump", [103] = "ControlVehicleGrapplingHook", [104] = "ControlVehicleShuffle", [105] = "ControlVehicleDropProjectile", [106] = "ControlVehicleMouseControlOverride", [107] = "ControlVehicleFlyRollLeftRight", [108] = "ControlVehicleFlyRollLeftOnly", [109] = "ControlVehicleFlyRollRightOnly", [110] = "ControlVehicleFlyPitchUpDown", [111] = "ControlVehicleFlyPitchUpOnly", [112] = "ControlVehicleFlyPitchDownOnly", [113] = "ControlVehicleFlyUnderCarriage", [114] = "ControlVehicleFlyAttack", [115] = "ControlVehicleFlySelectNextWeapon", [116] = "ControlVehicleFlySelectPrevWeapon", [117] = "ControlVehicleFlySelectTargetLeft", [118] = "ControlVehicleFlySelectTargetRight", [119] = "ControlVehicleFlyVerticalFlightMode", [120] = "ControlVehicleFlyDuck", [121] = "ControlVehicleFlyAttackCamera", [122] = "ControlVehicleFlyMouseControlOverride", [123] = "ControlVehicleSubTurnLeftRight", [124] = "ControlVehicleSubTurnLeftOnly", [125] = "ControlVehicleSubTurnRightOnly", [126] = "ControlVehicleSubPitchUpDown", [127] = "ControlVehicleSubPitchUpOnly", [128] = "ControlVehicleSubPitchDownOnly", [129] = "ControlVehicleSubThrottleUp", [130] = "ControlVehicleSubThrottleDown", [131] = "ControlVehicleSubAscend", [132] = "ControlVehicleSubDescend", [133] = "ControlVehicleSubTurnHardLeft", [134] = "ControlVehicleSubTurnHardRight", [135] = "ControlVehicleSubMouseControlOverride", [136] = "ControlVehiclePushbikePedal", [137] = "ControlVehiclePushbikeSprint", [138] = "ControlVehiclePushbikeFrontBrake", [139] = "ControlVehiclePushbikeRearBrake", [140] = "ControlMeleeAttackLight", [141] = "ControlMeleeAttackHeavy", [142] = "ControlMeleeAttackAlternate", [143] = "ControlMeleeBlock", [144] = "ControlParachuteDeploy", [145] = "ControlParachuteDetach", [146] = "ControlParachuteTurnLeftRight", [147] = "ControlParachuteTurnLeftOnly", [148] = "ControlParachuteTurnRightOnly", [149] = "ControlParachutePitchUpDown", [150] = "ControlParachutePitchUpOnly", [151] = "ControlParachutePitchDownOnly", [152] = "ControlParachuteBrakeLeft", [153] = "ControlParachuteBrakeRight", [154] = "ControlParachuteSmoke", [155] = "ControlParachutePrecisionLanding", [156] = "ControlMap", [157] = "ControlSelectWeaponUnarmed", [158] = "ControlSelectWeaponMelee", [159] = "ControlSelectWeaponHandgun", [160] = "ControlSelectWeaponShotgun", [161] = "ControlSelectWeaponSmg", [162] = "ControlSelectWeaponAutoRifle", [163] = "ControlSelectWeaponSniper", [164] = "ControlSelectWeaponHeavy", [165] = "ControlSelectWeaponSpecial", [166] = "ControlSelectCharacterMichael", [167] = "ControlSelectCharacterFranklin", [168] = "ControlSelectCharacterTrevor", [169] = "ControlSelectCharacterMultiplayer", [170] = "ControlSaveReplayClip", [171] = "ControlSpecialAbilityPC", [172] = "ControlPhoneUp", [173] = "ControlPhoneDown", [174] = "ControlPhoneLeft", [175] = "ControlPhoneRight", [176] = "ControlPhoneSelect", [177] = "ControlPhoneCancel", [178] = "ControlPhoneOption", [179] = "ControlPhoneExtraOption", [180] = "ControlPhoneScrollForward", [181] = "ControlPhoneScrollBackward", [182] = "ControlPhoneCameraFocusLock", [183] = "ControlPhoneCameraGrid", [184] = "ControlPhoneCameraSelfie", [185] = "ControlPhoneCameraDOF", [186] = "ControlPhoneCameraExpression", [187] = "ControlFrontendDown", [188] = "ControlFrontendUp", [189] = "ControlFrontendLeft", [190] = "ControlFrontendRight", [191] = "ControlFrontendRdown", [192] = "ControlFrontendRup", [193] = "ControlFrontendRleft", [194] = "ControlFrontendRright", [195] = "ControlFrontendAxisX", [196] = "ControlFrontendAxisY", [197] = "ControlFrontendRightAxisX", [198] = "ControlFrontendRightAxisY", [199] = "ControlFrontendPause", [200] = "ControlFrontendPauseAlternate", [201] = "ControlFrontendAccept", [202] = "ControlFrontendCancel", [203] = "ControlFrontendX", [204] = "ControlFrontendY", [205] = "ControlFrontendLb", [206] = "ControlFrontendRb", [207] = "ControlFrontendLt", [208] = "ControlFrontendRt", [209] = "ControlFrontendLs", [210] = "ControlFrontendRs", [211] = "ControlFrontendLeaderboard", [212] = "ControlFrontendSocialClub", [213] = "ControlFrontendSocialClubSecondary", [214] = "ControlFrontendDelete", [215] = "ControlFrontendEndscreenAccept", [216] = "ControlFrontendEndscreenExpand", [217] = "ControlFrontendSelect", [218] = "ControlScriptLeftAxisX", [219] = "ControlScriptLeftAxisY", [220] = "ControlScriptRightAxisX", [221] = "ControlScriptRightAxisY", [222] = "ControlScriptRUp", [223] = "ControlScriptRDown", [224] = "ControlScriptRLeft", [225] = "ControlScriptRRight", [226] = "ControlScriptLB", [227] = "ControlScriptRB", [228] = "ControlScriptLT", [229] = "ControlScriptRT", [230] = "ControlScriptLS", [231] = "ControlScriptRS", [232] = "ControlScriptPadUp", [233] = "ControlScriptPadDown", [234] = "ControlScriptPadLeft", [235] = "ControlScriptPadRight", [236] = "ControlScriptSelect", [237] = "ControlCursorAccept", [238] = "ControlCursorCancel", [239] = "ControlCursorX", [240] = "ControlCursorY", [241] = "ControlCursorScrollUp", [242] = "ControlCursorScrollDown", [243] = "ControlEnterCheatCode", [244] = "ControlInteractionMenu", [245] = "ControlMpTextChatAll", [246] = "ControlMpTextChatTeam", [247] = "ControlMpTextChatFriends", [248] = "ControlMpTextChatCrew", [249] = "ControlPushToTalk", [250] = "ControlCreatorLS", [251] = "ControlCreatorRS", [252] = "ControlCreatorLT", [253] = "ControlCreatorRT", [254] = "ControlCreatorMenuToggle", [255] = "ControlCreatorAccept", [256] = "ControlCreatorDelete", [257] = "ControlAttack2", [258] = "ControlRappelJump", [259] = "ControlRappelLongJump", [260] = "ControlRappelSmashWindow", [261] = "ControlPrevWeapon", [262] = "ControlNextWeapon", [263] = "ControlMeleeAttack1", [264] = "ControlMeleeAttack2", [265] = "ControlWhistle", [266] = "ControlMoveLeft", [267] = "ControlMoveRight", [268] = "ControlMoveUp", [269] = "ControlMoveDown", [270] = "ControlLookLeft", [271] = "ControlLookRight", [272] = "ControlLookUp", [273] = "ControlLookDown", [274] = "ControlSniperZoomIn", [275] = "ControlSniperZoomOut", [276] = "ControlSniperZoomInAlternate", [277] = "ControlSniperZoomOutAlternate", [278] = "ControlVehicleMoveLeft", [279] = "ControlVehicleMoveRight", [280] = "ControlVehicleMoveUp", [281] = "ControlVehicleMoveDown", [282] = "ControlVehicleGunLeft", [283] = "ControlVehicleGunRight", [284] = "ControlVehicleGunUp", [285] = "ControlVehicleGunDown", [286] = "ControlVehicleLookLeft", [287] = "ControlVehicleLookRight", [288] = "ControlReplayStartStopRecording", [289] = "ControlReplayStartStopRecordingSecondary", [290] = "ControlScaledLookLeftRight", [291] = "ControlScaledLookUpDown", [292] = "ControlScaledLookUpOnly", [293] = "ControlScaledLookDownOnly", [294] = "ControlScaledLookLeftOnly", [295] = "ControlScaledLookRightOnly", [296] = "ControlReplayMarkerDelete", [297] = "ControlReplayClipDelete", [298] = "ControlReplayPause", [299] = "ControlReplayRewind", [300] = "ControlReplayFfwd", [301] = "ControlReplayNewmarker", [302] = "ControlReplayRecord", [303] = "ControlReplayScreenshot", [304] = "ControlReplayHidehud", [305] = "ControlReplayStartpoint", [306] = "ControlReplayEndpoint", [307] = "ControlReplayAdvance", [308] = "ControlReplayBack", [309] = "ControlReplayTools", [310] = "ControlReplayRestart", [311] = "ControlReplayShowhotkey", [312] = "ControlReplayCycleMarkerLeft", [313] = "ControlReplayCycleMarkerRight", [314] = "ControlReplayFOVIncrease", [315] = "ControlReplayFOVDecrease", [316] = "ControlReplayCameraUp", [317] = "ControlReplayCameraDown", [318] = "ControlReplaySave", [319] = "ControlReplayToggletime", [320] = "ControlReplayToggletips", [321] = "ControlReplayPreview", [322] = "ControlReplayToggleTimeline", [323] = "ControlReplayTimelinePickupClip", [324] = "ControlReplayTimelineDuplicateClip", [325] = "ControlReplayTimelinePlaceClip", [326] = "ControlReplayCtrl", [327] = "ControlReplayTimelineSave", [328] = "ControlReplayPreviewAudio", [329] = "ControlVehicleDriveLook", [330] = "ControlVehicleDriveLook2", [331] = "ControlVehicleFlyAttack2", [332] = "ControlRadioWheelUpDown", [333] = "ControlRadioWheelLeftRight", [334] = "ControlVehicleSlowMoUpDown", [335] = "ControlVehicleSlowMoUpOnly", [336] = "ControlVehicleSlowMoDownOnly", [337] = "ControlMapPointOfInterest"}

rental_cars = {
    {title = "Cars", vehicles = {
        {name = "Punto", price = 80, model = "panto"},
        {name = "Alpha", price = 900, model = "alpha"},
        {name = "Banshee", price = 2200, model = "banshee"},
        {name = "Buffalo", price = 200, model = "buffalo"},
        {name = "Buffalo S", price = 1000, model = "buffalo2"},
        {name = "Baller", price = 1200, model = "baller"},
        {name = "Cavalcade", price = 600, model = "cavalcade"},
        {name = "Grabger", price = 300, model = "granger"},
        {name = "Huntley S", price = 700, model = "huntley"},
        {name = "Landstalker", price = 1000, model = "landstalker"},
        {name = "Radius", price = 100, model = "radi"},
        {name = "Rocoto", price = 120, model = "rocoto"},
        {name = "Seminole", price = 150, model = "seminole"},
        {name = "XLS", price = 500, model = "xls"},
    }},
    {title = "Bicycles", vehicles = {
        {name = "BMX", price = 50, model = "bmx"},
        {name = "Scorcher", price = 65, model = "scorcher"},
        {name = "TriBike", price = 85, model = "tribike3"},
    }},
    {title = "Motorcycles", vehicles = {
        {name = "Faggio", price =50, model = "faggio2"},
        {name = "Enduro", price = 120, model = "enduro"},
        {name = "ATV", price = 200, model = "blazer"},
    }},
}

rental_boats = {
    {title = "Boats", vehicles = {
        {name = "Dinghy", price = 350, model = "dinghy"},
        {name = "Dinghy2", price = 200, model = "dinghy2"},
        {name = "Dinghy3", price = 425, model = "dinghy3"},
        {name = "Dinghy4", price = 300, model = "dinghy4"},
        {name = "Jetmax", price = 370, model = "jetmax"},
        {name = "Speeder", price = 520, model = "speeder"},
        {name = "Speeder2", price = 500, model = "speeder2"},
        {name = "Squalo", price = 300, model = "squalo"},
        {name = "Suntrap", price = 250, model = "suntrap"},
        {name = "Tropic", price = 320, model = "tropic"},
        {name = "Tropic2", price = 400, model = "tropic2"},
        {name = "Tug Boat", price = 100, model = "tug"},
        {name = "Toro", price = 1500, model = "toro"},
        {name = "Toro2", price = 1700, model = "toro2"},
        {name = "Marquis (Sailboat)", price = 2000, model = "marquis"},
        {name = "Submarine", price = 35000, model = "submersible"},
    }},
    {title = "Jetskis", vehicles = {
        {name = "Seashark", price = 550, model = "seashark"},
        {name = "Seashark2", price = 625, model = "seashark2"},
        {name = "Seashark3", price = 700, model = "seashark3"},
    }},
}
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                            Events                                                            --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local boughtvehicle = nil
RegisterNetEvent("carRental:bought")
AddEventHandler("carRental:bought", function(data)
    WarMenu.CloseMenu()
    isCarRentalOpen = false
    isBoatRentalOpen = false
    if DoesEntityExist(currentPreview.entity) then
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentPreview.entity))
    end
    currentPreview = {model=0, entity=nil}
    FreezeEntityPosition(GetPlayerPed(-1),false)
    SetEntityVisible(GetPlayerPed(-1),true)
    TriggerEvent("anticheat:set", "invisible", false, function(callback)
    end)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        local model = GetHashKey(data.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        local veh = CreateVehicle(model, currentExit[1], currentExit[2], currentExit[3], currentExit[4], true, false)
        boughtvehicle = veh
        while not DoesEntityExist(veh) do
            Citizen.Wait(0)
        end

        SetVehicleOnGroundProperly(veh)
        SetVehicleHasBeenOwnedByPlayer(veh,true)
        local id = NetworkGetNetworkIdFromEntity(veh)
        SetNetworkIdCanMigrate(id, true)

        SetVehicleColours(veh, data.primary_colour, data.secondary_colour)
        SetVehicleExtraColours(veh, tonumber(data.primary_colour), tonumber(data.wheel_colour))
        SetVehicleNumberPlateTextIndex(veh, data.plate_colour)
        SetVehicleNumberPlateText(veh, data.plate)
        SetVehicleNeonLightsColour(veh, tonumber(data.neon_colour[1]), tonumber(data.neon_colour[2]), tonumber(data.neon_colour[3]))
        SetVehicleTyreSmokeColor(veh, tonumber(data.smoke_colour[1]), tonumber(data.smoke_colour[2]), tonumber(data.smoke_colour[3]))
        SetVehicleModKit(veh, 0)

        for i = 0, 8 do
            SetVehicleMod(veh, i, tonumber(data["mod"..i]))
        end

        for i = 10, 16 do
            SetVehicleMod(veh, i, tonumber(data["mod"..i]))
        end

        for i = 23, 46 do
            SetVehicleMod(veh, i, tonumber(data["mod"..i]))
        end

        SetVehicleMod(veh, 48, tonumber(data.mod48))

        if data.turbo == "on" then
            ToggleVehicleMod(veh, 18, true)
        else
            ToggleVehicleMod(veh, 18, false)
        end

        if data.tyre_smoke == "on" then
            ToggleVehicleMod(veh, 20, true)
        else
            ToggleVehicleMod(veh, 20, false)
        end

        if data.xenon_lights == "on" then
            ToggleVehicleMod(veh, 22, true)
        else
            ToggleVehicleMod(veh, 22, false)
        end

        SetVehicleWheelType(veh, tonumber(data.wheeltype))
        SetVehicleMod(veh, 23, tonumber(data.mod23))
        SetVehicleMod(veh, 24, tonumber(data.mod24))

        if data.custom_wheels == "on" then
            SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), true)
        end

        if data.custom_wheels2 == "on" then
            SetVehicleMod(veh, 24, GetVehicleMod(veh, 24), true)
        end

        if data.neon0 == "on" then
            SetVehicleNeonLightEnabled(veh, 0, true)
        else
            SetVehicleNeonLightEnabled(veh, 0, false)
        end

        if data.neon1 == "on" then
            SetVehicleNeonLightEnabled(veh, 1, true)
        else
            SetVehicleNeonLightEnabled(veh, 1, false)
        end

        if data.neon2 == "on" then
            SetVehicleNeonLightEnabled(veh, 2, true)
        else
            SetVehicleNeonLightEnabled(veh, 2, false)
        end

        if data.neon3 == "on" then
            SetVehicleNeonLightEnabled(veh, 3, true)
        else
            SetVehicleNeonLightEnabled(veh, 3, false)
        end

        if data.bulletproof_wheels == "on" then
            SetVehicleTyresCanBurst(veh, false)
        else
            SetVehicleTyresCanBurst(veh, true)
        end

        SetVehicleWindowTint(veh, tonumber(data.tint_colour))

        --SetVehicleEngineHealth(veh, tonumber(data.engine_health))
        --SetVehiclePetrolTankHealth(veh, tonumber(data.petrol_health))
        --SetEntityHealth(veh, tonumber(data.vehicle_health))
        --SetVehicleBodyHealth(veh, tonumber(data.body_health))
        SetVehicleNumberPlateText(veh, "RR"..GetVehicleNumberPlateText(veh))
        TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
        SetModelAsNoLongerNeeded(model)
        DecorSetBool(veh, "hotwire", true)
        SetEntityInvincible(veh, false)
    end)
end)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Functions                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function openCarRental()
    TriggerEvent("anticheat:set", "invisible", true, function(callback)
        if callback then
            SetEntityVisible(GetPlayerPed(-1),false)
        else
            TriggerServerEvent("core:bug", "Line 192 in resource "..GetCurrentResourceName())
            SetEntityVisible(GetPlayerPed(-1),false)
        end
    end)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    local zcoord = Citizen.InvokeNative(0xC906A7DAB05C8D2B,currentShop[1],currentShop[2],currentShop[3],Citizen.PointerValueFloat(),0)
    SetEntityCoords(GetPlayerPed(-1),currentShop[1],currentShop[2],zcoord)
    SetEntityHeading(GetPlayerPed(-1),currentShop[4])
end

function closeCarRental()
    WarMenu.CloseMenu()
    if DoesEntityExist(currentPreview.entity) then
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentPreview.entity))
    end
    currentPreview = {model=0, entity=nil}
    SetEntityCoords(GetPlayerPed(-1),currentMarker[1],currentMarker[2],currentMarker[3])
    FreezeEntityPosition(GetPlayerPed(-1),false)
    SetEntityVisible(GetPlayerPed(-1),true)
    TriggerEvent("anticheat:set", "invisible", false, function(callback)
    end)
    isCarRentalOpen = false 
end

function openBoatRental()
    TriggerEvent("anticheat:set", "invisible", true, function(callback)
        if callback then
            SetEntityVisible(GetPlayerPed(-1),false)
        else
            TriggerServerEvent("core:bug", "Line 192 in resource "..GetCurrentResourceName())
            SetEntityVisible(GetPlayerPed(-1),false)
        end
    end)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    local zcoord = Citizen.InvokeNative(0xC906A7DAB05C8D2B,currentShop[1],currentShop[2],currentShop[3],Citizen.PointerValueFloat(),0)
    SetEntityCoords(GetPlayerPed(-1),currentShop[1],currentShop[2],zcoord)
    SetEntityHeading(GetPlayerPed(-1),currentShop[4])
end

function closeBoatRental()
    WarMenu.CloseMenu()
    if DoesEntityExist(currentPreview.entity) then
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentPreview.entity))
    end
    currentPreview = {model=0, entity=nil}
    SetEntityCoords(GetPlayerPed(-1),currentMarker[1],currentMarker[2],currentMarker[3])
    FreezeEntityPosition(GetPlayerPed(-1),false)
    SetEntityVisible(GetPlayerPed(-1),true)
    TriggerEvent("anticheat:set", "invisible", false, function(callback)
    end)
    isBoatRentalOpen = false 
end

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Car Preview                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isCarRentalOpen then
            for k,v in pairs(rental_cars) do
                if WarMenu.CurrentMenu() == v.title.."_RENTALS" then
                    for i = 1, #currentCategory do
                        if WarMenu.CurrentOption() == i then
                            if currentPreview.model ~= currentCategory[i].model then
                                if DoesEntityExist(currentPreview.entity) then
                                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentPreview.entity))
                                end
                                local hash = GetHashKey(currentCategory[i].model)
                                RequestModel(hash)
                                while not HasModelLoaded(hash) do
                                    Citizen.Wait(0)
                                    drawLoadingTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)
                                    for i = 0, #keys - 1 do
                                        DisableControlAction(1, i, true)
                                    end
                                end
                                local veh = CreateVehicle(hash,currentShop[1],currentShop[2],currentShop[3],currentShop[4],false,false)
                                while not DoesEntityExist(veh) do
                                    Citizen.Wait(0)
                                    drawLoadingTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)
                                    for i = 0, #keys - 1 do
                                        DisableControlAction(1, i, true)
                                    end
                                end
                                FreezeEntityPosition(veh,true)
                                SetEntityInvincible(veh,true)
                                SetVehicleDoorsLocked(veh,4)
                                TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
                                SetModelAsNoLongerNeeded(hash)
                                for i = 0,24 do
                                    SetVehicleModKit(veh,0)
                                    RemoveVehicleMod(veh,i)
                                end
                                currentPreview = {model=currentCategory[i].model,entity=veh}
                            end                 
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isBoatRentalOpen then
            for k,v in pairs(rental_boats) do
                if WarMenu.CurrentMenu() == v.title.."_RENTALS" then
                    for i = 1, #currentCategory do
                        if WarMenu.CurrentOption() == i then
                            if currentPreview.model ~= currentCategory[i].model then
                                if DoesEntityExist(currentPreview.entity) then
                                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentPreview.entity))
                                end
                                local hash = GetHashKey(currentCategory[i].model)
                                RequestModel(hash)
                                while not HasModelLoaded(hash) do
                                    Citizen.Wait(0)
                                    drawLoadingTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)
                                    for i = 0, #keys - 1 do
                                        DisableControlAction(1, i, true)
                                    end
                                end
                                local veh = CreateVehicle(hash,currentShop[1],currentShop[2],currentShop[3],currentShop[4],false,false)
                                while not DoesEntityExist(veh) do
                                    Citizen.Wait(0)
                                    drawLoadingTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)
                                    for i = 0, #keys - 1 do
                                        DisableControlAction(1, i, true)
                                    end
                                end
                                FreezeEntityPosition(veh,true)
                                SetEntityInvincible(veh,true)
                                SetVehicleDoorsLocked(veh,4)
                                TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
                                SetModelAsNoLongerNeeded(hash)
                                for i = 0,24 do
                                    SetVehicleModKit(veh,0)
                                    RemoveVehicleMod(veh,i)
                                end
                                currentPreview = {model=currentCategory[i].model,entity=veh}
                            end                 
                        end
                    end
                end
            end
        end
    end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Press E to open/close menu in the red marker
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
emplacement_vehiclerentals = {
    {name="Vehicle rentals", colour=69, sprite=225, x=-904.39,y=-2337.38,z=6.71,inside={-905.96,-2333.15,6.71,62.16},exit={-913.41979980469,-2318.0380859375,6.7090878486633}},
    {name="Vehicle rentals", colour=69, sprite=225, x = 1224.5212402344, y = 2727.7609863281, z = 38.004676818848,inside={1224.5212402344, 2727.7609863281, 38.004676818848},exit={1222.9229736328,2714.6872558594,38.005794525146,184.55676269531}},
    {name="Vehicle rentals", colour=69, sprite=225, x = -215.51065063477, y = 6218.5390625, z = 31.491468429565,inside={-205.63021850586, 6221.5771484375, 31.491050720215},exit={-214.88452148438, 6194.431640625, 31.488348007202, 129.13427734375}},
}

emplacement_boatrentals = {
    {name="Boat rentals", colour=69, sprite=266, x = -803.02807617188, y = -1415.1254882813, z = 0.81553113460541,inside={-821.85522460938,-1440.8056640625,0.0093457698822021,173.33671569824},exit={-821.85522460938,-1440.8056640625,0.0093457698822021,173.33671569824}},
    {name="Boat rentals", colour=69, sprite=266, x = 712.12225341797, y = 4101.3256835938, z = (35.785194396973) - 0.5,inside={698.50482177734,4099.6259765625,30.311496734619,43.885768890381},exit={698.50482177734,4099.6259765625,30.311496734619,43.885768890381}},
    {name="Boat rentals", colour=69, sprite=266, x = -287.29446411133, y = 6628.7670898438, z = (7.170877456665) - 0.5,inside={-309.6123046875,6652.4213867188,0.67072486877441,35.311882019043},exit={-309.6123046875,6652.4213867188,0.67072486877441,35.311882019043}},
}

Citizen.CreateThread(function()
    for _, item in pairs(emplacement_boatrentals) do
        addBlip(item)
    end
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(emplacement_boatrentals) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 40.0)then
                DrawMarker(25, v.x, v.y, v.z - 0.2, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a boat!\nPress ~INPUT_DETONATE~ to return your boat!")
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                        isBoatRentalOpen = true
                        currentMarker = {v.x,v.y,v.z}
                        currentShop = v.inside
                        currentExit = v.exit
                        player_menu = false
                        openBoatRental()
                        if not WarMenu.IsMenuOpened("Boatrentals") then
                            if not WarMenu.DoesMenuExist("Boatrentals") then
                                WarMenu.CreateMenu("Boatrentals", "Vehicle shop")
                                WarMenu.SetSpriteTitle("Boatrentals", "shopui_title_ie_modgarage")
                                WarMenu.SetSubTitle("Boatrentals", "CATEGORIES")
                                WarMenu.SetMenuX("Boatrentals", 0.6)
                                WarMenu.SetMenuY("Boatrentals", 0.15)
                                for k,v in pairs(rental_boats) do
                                    WarMenu.CreateSubMenu(v.title.."_RENTALS", "Boatrentals", v.title.." SECTION")
                                    for i,j in pairs(v.vehicles) do
                                        WarMenu.CreateSubMenu(j.name.."_RENTALS", v.title.."_RENTALS", j.name)
                                    end
                                end
                                WarMenu.OpenMenu("Boatrentals")
                            else
                                WarMenu.OpenMenu("Boatrentals")
                            end
                        else
                            WarMenu.CloseMenu()
                        end
                    end
                    if IsControlJustPressed(1, 47) then
                        DeleteVehicle(boughtvehicle)
                        if DoesEntityExist(boughtvehicle) then
                            DeleteVehicle(boughtvehicle)
                        else
                            boughtvehicle = nil
                        end
                    end
                end
                --if isCarRentalOpen then
                    if WarMenu.IsMenuOpened("Boatrentals") then
                        for k,v in pairs(rental_boats) do
                            if WarMenu.MenuButton(v.title, v.title.."_RENTALS") then
                                currentCategory = v.vehicles
                            end
                        end
                        if WarMenu.Button("Close") then
                            WarMenu.CloseMenu()
                        end
                        WarMenu.Display()
                    end
                    for k,v in pairs(rental_boats) do
                        if WarMenu.IsMenuOpened(v.title.."_RENTALS") then
                            for i,j in pairs(v.vehicles) do
                                if WarMenu.Button(j.name, "$"..j.price) then
                                    local veh = currentPreview.entity
                                    local turbo
                                    local tiresmoke
                                    local xenon
                                    local neon0
                                    local neon1
                                    local neon2
                                    local neon3
                                    local bulletproof
                                    local custom_wheels
                                    local custom_wheels2
                                    local plate = GetVehicleNumberPlateText(veh)
                                    local colors = table.pack(GetVehicleColours(veh))
                                    local extra_colors = table.pack(GetVehicleExtraColours(veh))
                                    local neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
                                    local smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))

                                    if IsToggleModOn(veh,18) then
                                        turbo = "on"
                                    else
                                        turbo = "off"
                                    end

                                    if IsToggleModOn(veh,20) then
                                        tiresmoke = "on"
                                    else
                                        tiresmoke = "off"
                                    end

                                    if IsToggleModOn(veh,22) then
                                        xenon = "on"
                                    else
                                        xenon = "off"
                                    end

                                    if IsVehicleNeonLightEnabled(veh,0) then
                                        neon0 = "on"
                                    else
                                        neon0 = "off"
                                    end

                                    if IsVehicleNeonLightEnabled(veh,1) then
                                        neon1 = "on"
                                    else
                                        neon1 = "off"
                                    end

                                    if IsVehicleNeonLightEnabled(veh,2) then
                                        neon2 = "on"
                                    else
                                        neon2 = "off"
                                    end

                                    if IsVehicleNeonLightEnabled(veh,3) then
                                        neon3 = "on"
                                    else
                                        neon3 = "off"
                                    end

                                    if GetVehicleTyresCanBurst(veh) then
                                        bulletproof = "off"
                                    else
                                        bulletproof = "on"
                                    end

                                    if GetVehicleModVariation(veh, 23) then
                                        custom_wheels = "on"
                                    else
                                        custom_wheels = "off"
                                    end

                                    if GetVehicleModVariation(veh, 24) then
                                        custom_wheels2 = "on"
                                    else
                                        custom_wheels2 = "off"
                                    end

                                    local data = {
                                        garage_id = 1,
                                        model = j.model,
                                        name = j.name,
                                        instance = veh,
                                        plate = GetVehicleNumberPlateText(veh),
                                        state = "~r~Missing",
                                        primary_colour = colors[1],
                                        secondary_colour = colors[2],
                                        pearlescent_colour = extra_colors[1],
                                        wheel_colour = extra_colors[2],
                                        smoke_colour = {smokecolor[1],smokecolor[2],smokecolor[3]},
                                        plate_colour = GetVehicleNumberPlateTextIndex(veh),
                                        neon_colour = {neoncolor[1],neoncolor[2],neoncolor[3]},
                                        tint_colour = GetVehicleWindowTint(veh),
                                        tyre_smoke = tiresmoke,
                                        xenon_lights = xenon,
                                        turbo = turbo,
                                        custom_wheels = custom_wheels,
                                        custom_wheels2 = custom_wheels2,
                                        bulletproof_wheels = bulletproof,
                                        wheeltype = GetVehicleWheelType(veh),
                                        neon0 = neon0,
                                        neon1 = neon1,
                                        neon2 = neon2,
                                        neon3 = neon3,
                                        engine_health = GetVehicleEngineHealth(veh),
                                        petrol_health = GetVehiclePetrolTankHealth(veh),
                                        body_health = GetVehicleBodyHealth(veh),
                                        vehicle_health = GetEntityHealth(veh),
                                        insurance = "false",
                                    }

                                    for i = 0, 8 do
                                        data["mod"..i] = GetVehicleMod(veh, i)
                                    end

                                    for i = 10, 16 do
                                        data["mod"..i] = GetVehicleMod(veh, i)
                                    end

                                    for i = 23, 46 do
                                        data["mod"..i] = GetVehicleMod(veh, i)
                                    end

                                    data["mod48"] = GetVehicleMod(veh, 48)

                                    TriggerServerEvent("carRental:buy", data)
                                end
                            end
                            WarMenu.Display()
                        end
                    end
                    if WarMenu.IsMenuAboutToBeClosed() then
                        closeBoatRental()
                    end
                --end
            end
        end
    end
end)

Citizen.CreateThread(function()
    for _, item in pairs(emplacement_vehiclerentals) do
        addBlip(item)
    end
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(emplacement_vehiclerentals) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a vehicle!")
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                        isCarRentalOpen = true
                        currentMarker = {v.x,v.y,v.z}
                        currentShop = v.inside
                        currentExit = v.exit
                        player_menu = false
                        openCarRental()
                        if not WarMenu.IsMenuOpened("Vehiclerentals") then
                            if not WarMenu.DoesMenuExist("Vehiclerentals") then
                                WarMenu.CreateMenu("Vehiclerentals", "Vehicle shop")
                                WarMenu.SetSpriteTitle("Vehiclerentals", "shopui_title_ie_modgarage")
                                WarMenu.SetSubTitle("Vehiclerentals", "CATEGORIES")
                                WarMenu.SetMenuX("Vehiclerentals", 0.6)
                                WarMenu.SetMenuY("Vehiclerentals", 0.15)
                                for k,v in pairs(rental_cars) do
                                    WarMenu.CreateSubMenu(v.title.."_RENTALS", "Vehiclerentals", v.title.." SECTION")
                                    for i,j in pairs(v.vehicles) do
                                        WarMenu.CreateSubMenu(j.name.."_RENTALS", v.title.."_RENTALS", j.name)
                                    end
                                end
                                WarMenu.OpenMenu("Vehiclerentals")
                            else
                                WarMenu.OpenMenu("Vehiclerentals")
                            end
                        else
                            WarMenu.CloseMenu()
                        end
                    end
                end
                --if isCarRentalOpen then
                    if WarMenu.IsMenuOpened("Vehiclerentals") then
                        for k,v in pairs(rental_cars) do
                            if WarMenu.MenuButton(v.title, v.title.."_RENTALS") then
                                currentCategory = v.vehicles
                            end
                        end
                        if WarMenu.Button("Close") then
                            WarMenu.CloseMenu()
                        end
                        WarMenu.Display()
                    end
                    for k,v in pairs(rental_cars) do
                        if WarMenu.IsMenuOpened(v.title.."_RENTALS") then
                            for i,j in pairs(v.vehicles) do
                                if WarMenu.Button(j.name, "$"..j.price) then
                                    local veh = currentPreview.entity
                                    local turbo
                                    local tiresmoke
                                    local xenon
                                    local neon0
                                    local neon1
                                    local neon2
                                    local neon3
                                    local bulletproof
                                    local custom_wheels
                                    local custom_wheels2
                                    local plate = GetVehicleNumberPlateText(veh)
                                    local colors = table.pack(GetVehicleColours(veh))
                                    local extra_colors = table.pack(GetVehicleExtraColours(veh))
                                    local neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
                                    local smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))

                                    if IsToggleModOn(veh,18) then
                                        turbo = "on"
                                    else
                                        turbo = "off"
                                    end

                                    if IsToggleModOn(veh,20) then
                                        tiresmoke = "on"
                                    else
                                        tiresmoke = "off"
                                    end

                                    if IsToggleModOn(veh,22) then
                                        xenon = "on"
                                    else
                                        xenon = "off"
                                    end

                                    if IsVehicleNeonLightEnabled(veh,0) then
                                        neon0 = "on"
                                    else
                                        neon0 = "off"
                                    end

                                    if IsVehicleNeonLightEnabled(veh,1) then
                                        neon1 = "on"
                                    else
                                        neon1 = "off"
                                    end

                                    if IsVehicleNeonLightEnabled(veh,2) then
                                        neon2 = "on"
                                    else
                                        neon2 = "off"
                                    end

                                    if IsVehicleNeonLightEnabled(veh,3) then
                                        neon3 = "on"
                                    else
                                        neon3 = "off"
                                    end

                                    if GetVehicleTyresCanBurst(veh) then
                                        bulletproof = "off"
                                    else
                                        bulletproof = "on"
                                    end

                                    if GetVehicleModVariation(veh, 23) then
                                        custom_wheels = "on"
                                    else
                                        custom_wheels = "off"
                                    end

                                    if GetVehicleModVariation(veh, 24) then
                                        custom_wheels2 = "on"
                                    else
                                        custom_wheels2 = "off"
                                    end

                                    local data = {
                                        garage_id = 1,
                                        model = j.model,
                                        name = j.name,
                                        instance = veh,
                                        plate = GetVehicleNumberPlateText(veh),
                                        state = "~r~Missing",
                                        primary_colour = colors[1],
                                        secondary_colour = colors[2],
                                        pearlescent_colour = extra_colors[1],
                                        wheel_colour = extra_colors[2],
                                        smoke_colour = {smokecolor[1],smokecolor[2],smokecolor[3]},
                                        plate_colour = GetVehicleNumberPlateTextIndex(veh),
                                        neon_colour = {neoncolor[1],neoncolor[2],neoncolor[3]},
                                        tint_colour = GetVehicleWindowTint(veh),
                                        tyre_smoke = tiresmoke,
                                        xenon_lights = xenon,
                                        turbo = turbo,
                                        custom_wheels = custom_wheels,
                                        custom_wheels2 = custom_wheels2,
                                        bulletproof_wheels = bulletproof,
                                        wheeltype = GetVehicleWheelType(veh),
                                        neon0 = neon0,
                                        neon1 = neon1,
                                        neon2 = neon2,
                                        neon3 = neon3,
                                        engine_health = GetVehicleEngineHealth(veh),
                                        petrol_health = GetVehiclePetrolTankHealth(veh),
                                        body_health = GetVehicleBodyHealth(veh),
                                        vehicle_health = GetEntityHealth(veh),
                                        insurance = "false",
                                    }

                                    for i = 0, 8 do
                                        data["mod"..i] = GetVehicleMod(veh, i)
                                    end

                                    for i = 10, 16 do
                                        data["mod"..i] = GetVehicleMod(veh, i)
                                    end

                                    for i = 23, 46 do
                                        data["mod"..i] = GetVehicleMod(veh, i)
                                    end

                                    data["mod48"] = GetVehicleMod(veh, 48)

                                    TriggerServerEvent("carRental:buy", data)
                                end
                            end
                            WarMenu.Display()
                        end
                    end
                    if WarMenu.IsMenuAboutToBeClosed() then
                        closeCarRental()
                    end
                --end
            end
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Useful functions
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

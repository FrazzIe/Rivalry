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
--                                                           Carshop                                                            --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Variables                                                          --
--==============================================================================================================================--
isCarshopOpen = false                                                                                                           --
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

cars = {
    {title = "Assault Vehicles", vehicles = {
        {name = "Cheburek", price = 0, model = "cheburek"},
        {name = "Dominator GTX", price = 0, model = "dominator3"},
        {name = "Ellie", price = 0, model = "ellie"},
        {name = "Entity XXR", price = 0, model = "entity2"},
        {name = "Fagaloa", price = 0, model = "fagaloa"},
        {name = "Flash GT", price = 0, model = "flashgt"},
        {name = "GB200", price = 0, model = "gb200"},
        {name = "Hotring Sabre", price = 0, model = "hotring"},
        {name = "Issi Classic", price = 0, model = "issi3"},
        {name = "Jester Classic", price = 0, model = "jester3"},
        {name = "Michelli GT", price = 0, model = "michelli"},
        {name = "Taipan", price = 0, model = "taipan"},
        {name = "Tezeract", price = 0, model = "tezeract"},
        {name = "Tyrant", price = 0, model = "tyrant"},
    }},
    {title = "Job Vehicles", vehicles = {
        {name = "Taxi", price = 25000, model = "taxi"},
        {name = "Tow Truck", price = 25000, model = "towtruck"},
        {name = "Tow Truck Mini", price = 25000, model = "towtruck2"},
        {name = "Taco Truck", price = 25000, model = "taco"},
        {name = "Tour Bus", price = 25000, model = "tourbus"},
    }},
    {title = "Compacts", vehicles = {
        {name = "Blista", price = 5500, model = "blista"},
        {name = "Brioso R/A", price = 6000, model = "brioso"},
        {name = "Dilettante", price = 8000, model = "dilettante"},
        {name = "Issi", price = 7500, model = "issi2"},
        {name = "Panto", price = 2500, model = "panto"},
        {name = "Prairie", price = 3500, model = "prairie"},
        {name = "Rhapsody", price = 6500, model = "rhapsody"},
    }},
    {title = "Coupes", vehicles = {
        {name = "Cognoscenti Cabrio", price = 14000, model = "cogcabrio"},
        {name = "Exemplar", price = 13000, model = "exemplar"},
        {name = "F620", price = 13000, model = "f620"},
        {name = "Felon", price = 23500, model = "felon"},
        {name = "Felon GT", price = 24500, model = "felon2"},
        {name = "Jackal", price = 21000, model = "jackal"},
        {name = "Oracle", price = 18500, model = "oracle"},
        {name = "Oracle XS", price = 19500, model = "oracle2"},
        {name = "Sentinel", price = 16500, model = "sentinel"},
        {name = "Sentinel XS", price = 17500, model = "sentinel2"},
        {name = "Windsor", price = 11000, model = "windsor"},
        {name = "Windsor Drop", price = 12000, model = "windsor2"},
        {name = "Zion", price = 11200, model = "zion"},
        {name = "Zion Cabrio", price = 12200, model = "zion2"},
    }},
    {title = "Sports", vehicles = {
        {name = "9F", price = 135500, model = "ninef"},
        {name = "9F Cabrio", price = 136500, model = "ninef2"},
        {name = "Alpha", price = 115500, model = "alpha"},
        {name = "Banshee", price = 143500, model = "banshee"},
        {name = "Banshee 900R", price = 253500, model = "banshee2"},
        {name = "Bestia GTS", price = 144500, model = "bestiagts"},
        {name = "Buffalo", price = 128000, model = "buffalo"},
        {name = "Buffalo S", price = 129850, model = "buffalo2"},
        {name = "Carbonizzare", price = 136800, model = "carbonizzare"},
        {name = "Coil Raiden", price = 121500, model = "raiden"}, --Sports
        {name = "Comet", price = 137000, model = "comet2"},
        {name = "Comet Retro Custom", price = 137500, model = "comet3"},
        {name = "Comet Safari", price = 138000, model = "comet4"}, --Sports
        {name = "Comet SR", price = 137500, model = "comet5"}, --Sports
        {name = "Coquette", price = 146500, model = "coquette"},
        {name = "Drift Tampa", price = 142500, model = "tampa2"},
        {name = "Elegy RH8", price = 124500, model = "elegy2"},
        {name = "Elegy Retro Custom", price = 125500, model = "elegy"},
        {name = "Feltzer", price = 136500, model = "feltzer2"},
        {name = "Furore GT", price = 126500, model = "furoregt"},
        {name = "Fusilade", price = 128500, model = "fusilade"},
        {name = "Futo", price = 133520, model = "futo"},
        {name = "Go Go Monkey Blista", price = 121000, model = "blista3"},
        {name = "Jester", price = 275000, model = "jester"},
        {name = "Jester Race", price = 285000, model = "jester2"},
        {name = "Khamelion", price = 123500, model = "khamelion"},
        {name = "Kuruma", price = 129000, model = "kuruma"},
        --{name = "Kuruma Armored", price = 33000, model = "kuruma2"}, --Armoured car
        {name = "Lynx", price = 126000, model = "lynx"},
        {name = "Massacro", price = 163000, model = "massacro"},
        {name = "Massacro Race", price = 165000, model = "massacro2"},
        {name = "Neon", price = 190000, model = "neon"}, --Sports
        {name = "Omnis", price = 129000, model = "omnis"},
        {name = "Pariah", price = 121000, model = "pariah"}, --Sports
        {name = "Penumbra", price = 118500, model = "penumbra"},
        {name = "Rapid GT", price = 128000, model = "rapidgt"},
        {name = "Rapid GT Convertible", price = 131000, model = "rapidgt2"},
        {name = "Raptor", price = 147500, model = "raptor"},
        {name = "Revolter", price = 115000, model = "revolter"}, --Sports
        {name = "Ruston", price = 146500, model = "ruston"},
        {name = "Schafter LWB", price = 119500, model = "schafter2"},
        {name = "Schafter V12", price = 122000, model = "schafter3"},
        {name = "Sentinel Classic", price = 111000, model = "sentinel3"}, --Sports
        {name = "Seven-70", price = 147000, model = "seven70"},
        {name = "Specter", price = 134500, model = "specter"},
        {name = "Specter Custom", price = 136500, model = "specter2"},
        {name = "Sprunk Buffalo", price = 129000, model = "buffalo3"},
        {name = "Streiter", price = 128000, model = "streiter"}, --Sports
        {name = "Sultan", price = 119500, model = "sultan"},
        {name = "Sultan RS", price = 250000, model = "sultanrs"},
        {name = "Surano", price = 123500, model = "surano"},
        {name = "Tropos Rallye", price = 143000, model = "tropos"},
        {name = "Verlierer", price = 139000, model = "verlierer2"},
    }},
    {title = "Sports Classics", vehicles = {
        --{name = "Ardent", price = 30000, model = "ardent"}, --Has guns, rip
        {name = "Casco", price = 24000, model = "casco"},
        {name = "Cheetah Classic", price = 26000, model = "cheetah2"},
        {name = "Coquette Classic", price = 32000, model = "coquette2"},
        {name = "Fränken Strange", price = 74000, model = "btype2"},
        {name = "GT 500", price = 32500, model = "gt500"}, --Sports Classic
        {name = "Infernus Classic", price = 102500, model = "infernus2"},
        {name = "JB 700", price = 33000, model = "jb700"},
        {name = "Karin 190z", price = 41000, model = "z190"}, --Sports Classic
        {name = "Mamba", price = 22000, model = "mamba"},
        {name = "Manana", price = 18000, model = "manana"},
        {name = "Monroe", price = 23500, model = "monroe"},
        {name = "Peyote", price = 17000, model = "peyote"},
        {name = "Pigalle", price = 15500, model = "pigalle"},
        {name = "Rapid GT Classic", price = 32000, model = "rapidgt3"}, --Sports Classic
        {name = "Retinue", price = 21000, model = "retinue"}, --Sports Classic
        {name = "Roosevelt", price = 22500, model = "btype"},
        {name = "Roosevelt Valor", price = 24500, model = "btype3"},
        {name = "Savestra", price = 18000, model = "savestra"}, --Sports Classic
        {name = "Stinger", price = 27000, model = "stinger"},
        {name = "Stinger GT", price = 48000, model = "stingergt"},
        {name = "Stirling GT", price = 48500, model = "feltzer3"},
        {name = "Torero", price = 17500, model = "torero"},
        {name = "Tornado", price = 15500, model = "tornado"},
        {name = "Tornado (Beater)", price = 9000, model = "tornado3"},
        {name = "Tornado (Mariachi)", price = 7500, model = "tornado4"},
        {name = "Tornado Custom", price = 17500, model = "tornado5"},
        {name = "Tornado Rat Rod", price = 11000, model = "tornado6"},
        {name = "Turismo Classic", price = 32500, model = "turismo2"},
        --{name = "Viseris", price = 45000, model = "viseris"}, --Sports Classic--Has guns
        {name = "Z-type", price = 14500, model = "ztype"},
    }},
    {title = "Super", vehicles = {
        --{name = "811", price = 1350000, model = "pfister811"},
        {name = "Adder", price = 5700000, model = "adder"},
        --{name = "Banshee 900R", price = 1166000, model = "banshee2"},
        --{name = "Bullet", price = 1120000, model = "bullet"},
        --{name = "Cheetah", price = 1180000, model = "cheetah"},
        {name = "Cyclone", price = 6000000, model = "cyclone"}, --Super
        --{name = "Entity XF", price = 1125000, model = "entityxf"},
        --{name = "ETR1", price = 1145000, model = "sheava"},
        --{name = "FMJ", price = 1115000, model = "fmj"},
        --{name = "GP1", price = 1150000, model = "gp1"},
        --{name = "Infernus", price = 1210000, model = "infernus"},
        --{name = "Itali GTB", price = 1500000, model = "italigtb"},
        --{name = "Itali GTB Custom", price = 1900000, model = "italigtb2"},
        --{name = "Nero", price = 1300000, model = "nero"},
        --{name = "Nero Custom", price = 1400000, model = "nero2"},
        --{name = "Osiris", price = 950000, model = "osiris"},
        --{name = "Overflod Autarch", price = 1300000, model = "autarch"}, --Super
        --{name = "Penetrator", price = 805000, model = "penetrator"},
        --{name = "RE-7B", price = 1475000, model = "le7b"},
        --{name = "Reaper", price = 725000, model = "reaper"},
        --{name = "SC1", price = 1150000, model = "sc1"}, --Super
        --{name = "Sultan RS", price = 250000, model = "sultanrs"},
        {name = "T20", price = 5600000, model = "t20"},
        --{name = "Tempesta", price = 945000, model = "tempesta"},
        --{name = "Turismo R", price = 1560000, model = "turismor"},
        --{name = "Tyrus", price = 1550000, model = "tyrus"},
        --{name = "Vacca", price = 1240000, model = "vacca"},
        --{name = "Vagner", price = 1005000, model = "vagner"},
        --{name = "Visione", price = 1500000, model = "visione"}, --Super
        --{name = "Voltic", price = 545000, model = "voltic"},
        {name = "XA-21", price = 5000000, model = "xa21"},
        --{name = "X80 Proto", price = 1700000, model = "prototipo"},
        {name = "Zentorno", price = 4900000, model = "zentorno"},
    }},
    {title = "Muscle", vehicles = {
        {name = "Blade", price = 15200, model = "blade"},
        {name = "Buccaneer", price = 22000, model = "buccaneer"},
        {name = "Buccaneer Custom", price = 23500, model = "buccaneer2"},
        --{name = "Burger Shot Stallion", price = 0, model = "stallion2"}, --Doesnt load in the shop?
        {name = "Chino", price = 37000, model = "chino"},
        {name = "Chino Custom", price = 38000, model = "chino2"},
        {name = "Coquette BlackFin", price = 123000, model = "coquette3"},
        {name = "Dominator", price = 35000, model = "dominator"},
        {name = "Dukes", price = 36000, model = "dukes"},
        --{name = "Duke O'Death", price = 0, model = "dukes2"}, --Armoured car
        {name = "Gauntlet", price = 22000, model = "gauntlet"},
        {name = "Hermes", price = 20000, model = "hermes"},  --Muscle
        {name = "Hotknife", price = 60000, model = "hotknife"},
        {name = "Hustler", price = 26000, model = "hustler"}, --Muscle
        {name = "Faction", price = 26000, model = "faction"},
        {name = "Faction Custom", price = 27000, model = "faction2"},
        {name = "Faction Custom Donk", price = 27500, model = "faction3"},
        {name = "Lost Slamvan", price = 13500, model = "slamvan2"},
        {name = "Lurcher", price = 17000, model = "lurcher"},
        {name = "Moonbeam", price = 11000, model = "moonbeam"},
        {name = "Moonbeam Custom", price = 12000, model = "moonbeam2"},
        {name = "Nightshade", price = 125000, model = "nightshade"},
        {name = "Phoenix", price = 54000, model = "phoenix"},
        {name = "Picador", price = 9000, model = "picador"},
        {name = "Pißwasser Dominator", price = 115000, model = "dominator2"},
        {name = "Rat-Loader", price = 3000, model = "ratloader"},
        {name = "Rat-Truck", price = 4000, model = "ratloader2"},
        {name = "Redwood Gauntlet", price = 90000, model = "gauntlet2"},
        {name = "Ruiner", price = 130000, model = "ruiner"},
        --{name = "Ruiner 2000", price = 0, model = "ruiner2"}, --This vehicle has guns, parachute, rockets etc
        {name = "Sabre Turbo", price = 8500, model = "sabregt"},
        {name = "Sabre Turbo Custom", price = 9500, model = "sabregt2"},
        {name = "Slamvan", price = 6500, model = "slamvan"},
        {name = "Slamvan Custom", price = 8000, model = "slamvan3"},
        --{name = "Stallion", price = 0, model = "stallion"}, --Doesnt load in the shop?
        {name = "Tampa", price = 175000, model = "tampa"},
        {name = "Virgo", price = 65000, model = "virgo"},
        {name = "Virgo Classic", price = 67500, model = "virgo2"},
        {name = "Virgo Classic Custom", price = 68000, model = "virgo3"},
        {name = "Vigero", price = 21000, model = "vigero"},
        {name = "Voodoo", price = 2500, model = "voodoo2"},
        {name = "Voodoo Custom", price = 3000, model = "voodoo"},
        {name = "Yosemite", price = 27000, model = "yosemite"}, --Muscle
    }},
    {title = "Offroad", vehicles = {
        {name = "Bifta", price = 35000, model = "bifta"},
        {name = "Bodhi", price = 13500, model = "bodhi2"},
        {name = "Brawler", price = 115000, model = "brawler"},
        {name = "Canis Kamacho", price = 26000, model = "kamacho"}, --Offroad
        {name = "Desert Raid", price = 395000, model = "trophytruck2"},
        {name = "Dubsta 6x6", price = 149000, model = "dubsta3"},
        {name = "Dune Buggy", price = 20000, model = "dune"},
        {name = "Duneloader", price = 7000, model = "dloader"},
        {name = "Injection", price = 4000, model = "bfinjection"},
        {name = "Kalahari", price = 21000, model = "kalahari"},
        {name = "Mesa (Caged)", price = 47000, model = "mesa3"},
        --{name = "Nightshark", price = 0, model = "nightshark"}, --Armoured car
        {name = "Rancher XL", price = 7000, model = "rancherxl"},
        {name = "Riata", price = 10000, model = "riata"}, --Offroad
        {name = "Rebel", price = 19000, model = "rebel2"},
        {name = "Rusty Rebel", price = 3000, model = "rebel"},
        {name = "Sandking SWB", price = 29000, model = "sandking2"},
        {name = "Sandking XL", price = 37000, model = "sandking"},
        {name = "Trophy Truck", price = 435000, model = "trophytruck"},
    }}, 
    {title = "SUV", vehicles = {
        {name = "Baller", price = 80000, model = "baller"},
        {name = "Baller 2nd Gen", price = 83000, model = "baller2"},
        {name = "Baller LE", price = 139000, model = "baller3"},
        {name = "Baller LE LWB", price = 141000, model = "baller4"},
        {name = "BeeJay XL", price = 49000, model = "bjxl"},
        {name = "Cavalcade", price = 45000, model = "cavalcade"},
        {name = "Cavalcade 2nd Gen", price = 80000, model = "cavalcade2"},
        {name = "Contender", price = 125000, model = "contender"},
        {name = "Dubsta", price = 120000, model = "dubsta2"},
        {name = "FQ 2", price = 27000, model = "fq2"},
        {name = "Granger", price = 35000, model = "granger"},
        {name = "Gresley", price = 29000, model = "gresley"},
        {name = "Habanero", price = 17500, model = "habanero"},
        {name = "Huntley S", price = 95000, model = "huntley"},
        {name = "Landstalker", price = 48000, model = "landstalker"},
        {name = "Mesa", price = 37000, model = "mesa"},
        {name = "Patriot", price = 42000, model = "patriot"},
        {name = "Radius", price = 22000, model = "radi"},
        {name = "Rocoto", price = 45000, model = "rocoto"},
        {name = "Seminole", price = 30000, model = "seminole"},
        {name = "Serrano", price = 30000, model = "serrano"},
        {name = "XLS", price = 820000, model = "xls"},
    }}, 
    {title = "Vans", vehicles = {
        {name = "Bison", price = 12000, model = "bison"},
        {name = "Bobcat XL", price = 11000, model = "bobcatxl"},
        {name = "Burrito", price = 11000, model = "burrito3"},
        {name = "Camper", price = 6000, model = "camper"},
        {name = "Gang Burrito", price = 8000, model = "gburrito2"},
        {name = "Journey", price = 7500, model = "journey"},
        {name = "Minivan", price = 8000, model = "minivan"},
        {name = "Minivan Custom", price = 9000, model = "minivan2"},
        {name = "Paradise", price = 11000, model = "paradise"},
        {name = "Rumpo", price = 15000, model = "rumpo"},
        {name = "Rumpo Custom", price = 19000, model = "rumpo3"},
        {name = "Surfer", price = 4000, model = "surfer"},
        {name = "Surfer (Beater)", price = 4500, model = "surfer2"},
        {name = "Youga", price = 5000, model = "youga"},
        {name = "Youga Classic", price = 6000, model = "youga2"},
    }},
    {title = "Sedans", vehicles = {
        {name = "Asea", price = 12000, model = "asea"},
        {name = "Asterope", price = 16000, model = "asterope"},
        {name = "Cognoscenti", price = 145000, model = "cognoscenti"},
        {name = "Cognoscenti 55", price = 150000, model = "cog55"},
        {name = "Emperor", price = 3000, model = "emperor"},
        {name = "Emperor (Beater)", price = 5000, model = "emperor2"},
        {name = "Fugitive", price = 24000, model = "fugitive"},
        {name = "Glendale", price = 27000, model = "glendale"},
        {name = "Ingot", price = 9000, model = "ingot"},
        {name = "Intruder", price = 15000, model = "intruder"},
        {name = "Premier", price = 10000, model = "premier"},
        {name = "Primo", price = 9000, model = "primo"},
        {name = "Primo Custom", price = 11000, model = "primo2"},
        {name = "Regina", price = 8000, model = "regina"},
        {name = "Romero Hearse", price = 9500, model = "romero"},
        {name = "Schafter", price = 45000, model = "schafter2"},
        {name = "Stanier", price = 10000, model = "stanier"},
        {name = "Stratum", price = 9000, model = "stratum"},
        {name = "Stretch Limo", price = 30000, model = "stretch"},
        {name = "Super Diamond", price = 175000, model = "superd"},
        {name = "Surge", price = 28000, model = "surge"},
        {name = "Tailgater", price = 15000, model = "tailgater"},
        {name = "Warrener", price = 27000, model = "warrener"},
        {name = "Washington", price = 11000, model = "washington"},
    }}, 
    {title = "Motorcycles", vehicles = {
        {name = "Akuma", price = 59000, model = "akuma"},
        {name = "Avarus", price = 46000, model = "avarus"},
        {name = "Bagger", price = 39000, model = "bagger"},
        {name = "Bati 801", price = 25000, model = "bati"},
        {name = "Bati 801RR", price = 37000, model = "bati2"},
        {name = "BF400", price = 55000, model = "bf400"},
        {name = "Carbon RS", price = 60000, model = "carbonrs"},
        {name = "Cliffhanger", price = 65000, model = "cliffhanger"},
        {name = "Daemon", price = 55000, model = "daemon2"},
        {name = "Daemon (Lost)", price = 67000, model = "daemon"},
        {name = "Defiler", price = 112000, model = "defiler"},
        {name = "Diablous", price = 149000, model = "diablous"},
        {name = "Diablous Custom", price = 151000, model = "diablous2"},
        {name = "Double T", price = 12000, model = "double"},
        {name = "Enduro", price = 28000, model = "enduro"},
        {name = "Esskey", price = 64000, model = "esskey"},
        {name = "Faggio", price = 2500, model = "faggio2"},
        {name = "Faggio Sport", price = 3500, model = "faggio"},
        {name = "Faggio Mod", price = 4000, model = "faggio3"},
        {name = "FCR 1000", price = 48000, model= "fcr"},
        {name = "FCR 1000 Custom", price = 51000, model = "fcr2"},
        {name = "Gargoyle", price = 17000, model = "gargoyle"},
        {name = "Hakuchou", price = 62000, model = "hakuchou"},
        {name = "Hakuchou Drag", price = 176000, model = "hakuchou2"},
        {name = "Hexer", price = 13000, model = "hexer"},
        {name = "Innovation", price = 19500, model = "innovation"},
        {name = "Lectro", price = 43000, model = "lectro"},
        {name = "Manchez", price = 46500, model = "manchez"},
        {name = "Nemesis", price = 12000, model = "nemesis"},
        {name = "Nightblade", price = 27000, model = "nightblade"},
        {name = "PCJ-600", price = 29000, model = "pcj"},
        {name = "Rat Bike", price = 25000, model = "ratbike"},
        {name = "Ruffian", price = 27000, model = "ruffian"},
        {name = "Sanchez", price = 40000, model = "sanchez"},
        {name = "Sanctus", price = 89000, model = "Sanctus"},
        {name = "Sovereign", price = 15000, model = "sovereign"},
        {name = "Thrust", price = 17000, model = "thrust"},
        {name = "Vader", price = 29000, model = "vader"},
        {name = "Vindicator", price = 110000, model = "vindicator"},
        {name = "Vortex", price = 72000, model = "vortex"},
        {name = "Wolfsbane", price = 15000, model = "wolfsbane"},
        {name = "Zombie Bobber", price = 23000, model = "zombiea"},
        {name = "Zombie Chopper", price = 12000, model = "zombieb"},
    }},
}

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                            Events                                                            --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterNetEvent("carshop:bought")
AddEventHandler("carshop:bought",function(data)
    WarMenu.CloseMenu()
    isCarshopOpen = false
    if DoesEntityExist(currentPreview.entity) then
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentPreview.entity))
    end
    currentPreview = {model=0, entity=nil}
    FreezeEntityPosition(GetPlayerPed(-1),false)
    SetEntityVisible(PlayerPedId() ,true)
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
        table.insert(out, veh); local count = #user_vehicles+1; user_vehicles[count] = data; user_vehicles[count].instance = veh; user_vehicles[count].state = "~r~Missing"
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
        TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
        SetModelAsNoLongerNeeded(model)
        SetEntityInvincible(veh, false)
    end)
end)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Functions                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function openCarshop()
    TriggerEvent("anticheat:set", "invisible", true, function(callback)
        if callback then
            SetEntityVisible(GetPlayerPed(-1),false)
        else
            TriggerServerEvent("core:bug", "Line 478 in resource "..GetCurrentResourceName())
            SetEntityVisible(GetPlayerPed(-1),false)
        end
    end)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    local zcoord = Citizen.InvokeNative(0xC906A7DAB05C8D2B,currentShop[1],currentShop[2],currentShop[3],Citizen.PointerValueFloat(),0)
    SetEntityCoords(GetPlayerPed(-1),currentShop[1],currentShop[2],zcoord)
    SetEntityHeading(GetPlayerPed(-1),currentShop[4])
    isCarshopOpen = true
end

function closeCarshop()
    isCarshopOpen = false
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
end

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Car Preview                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isCarshopOpen then
            for k,v in pairs(cars) do
                if WarMenu.CurrentMenu() == v.title then
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
emplacement_vehicleshop = {
    {name = "Vehicle shop", colour=69, sprite=225, x=-33.491161346436,y=-1102.2437744141,z=26.422353744507,inside={-46.56327,-1097.382,25.99875, 120.1953},exit={-55.709060668945,-1109.1584472656,26.435792922974,72.441734313965}},
}

Citizen.CreateThread(function()
    for _, item in pairs(emplacement_vehicleshop) do
        addBlip(item)
    end
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(emplacement_vehicleshop) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(25, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    DisplayHelpText("Press ~INPUT_CONTEXT~ to buy a vehicle!")
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                        if tobool(drivers_license) then
                            currentMarker = {v.x,v.y,v.z}
                            currentShop = v.inside
                            currentExit = v.exit
                            openCarshop()
                            if not WarMenu.IsMenuOpened("Vehicleshop") then
                                if not WarMenu.DoesMenuExist("Vehicleshop") then
                                    WarMenu.CreateMenu("Vehicleshop", "Vehicle shop")
                                    WarMenu.SetSpriteTitle("Vehicleshop", "shopui_title_ie_modgarage")
                                    WarMenu.SetSubTitle("Vehicleshop", "CATEGORIES")
                                    WarMenu.SetMenuX("Vehicleshop", 0.6)
                                    WarMenu.SetMenuY("Vehicleshop", 0.15)
                                    for k,v in pairs(cars) do
                                        WarMenu.CreateSubMenu(v.title, "Vehicleshop", v.title.." SECTION")
                                        for i,j in pairs(v.vehicles) do
                                            WarMenu.CreateSubMenu(j.name, v.title, j.name)
                                        end
                                    end
                                    WarMenu.OpenMenu("Vehicleshop")
                                else
                                    WarMenu.OpenMenu("Vehicleshop")
                                end
                            else
                                WarMenu.CloseMenu("Vehicleshop")
                            end
                        else
                            Notify("Get out of here! I'm not selling you a vehicle without a drivers license!")
                        end
                    end
                end
                --if isCarshopOpen then
                    if WarMenu.IsMenuOpened("Vehicleshop") then
                        for k,v in pairs(cars) do
                            if WarMenu.MenuButton(v.title, v.title) then
                                currentCategory = v.vehicles
                            end
                        end
                        WarMenu.Display()
                    end
                    for k,v in pairs(cars) do
                        if WarMenu.IsMenuOpened(v.title) then
                            for i,j in pairs(v.vehicles) do
                                if WarMenu.Button(j.name, "$"..j.price) then
                                    local available_garage = GetGarage()
                                    if available_garage then
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
                                            garage_id = available_garage,
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

                                        TriggerServerEvent("carshop:buy", data)
                                    else
                                        exports.pNotify:SendNotification({text = "Your garage is full!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                                    end
                                end
                            end
                            WarMenu.Display()
                        end
                    end
                    if WarMenu.IsMenuAboutToBeClosed() then
                        closeCarshop()
                    end
                --end
            end
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Useful functions
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function drawLoadingTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

function GetGarage()
    local garages_used, garages_slots, available_garages = {}, {}, {}
    for i = 1, tablelength(user_garages) do
        garages_slots[user_garages[i].garage_id] = user_garages[i].slots
        garages_used[user_garages[i].garage_id] = 0 
    end
    for i = 1, tablelength(user_vehicles) do
        if garages_used[user_vehicles[i].garage_id] then
            garages_used[user_vehicles[i].garage_id] = garages_used[user_vehicles[i].garage_id] + 1
        end
    end

    for k,v in pairs(garages_slots) do
        if v ~= nil then
            if garages_used[k] < v then
                table.insert(available_garages, k)
            end
        end
    end
    return available_garages[1]
end
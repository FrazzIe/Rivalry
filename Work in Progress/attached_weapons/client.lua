local weapons = {
    "WEAPON_PISTOL",
    "WEAPON_COMBATPISTOL",
    "WEAPON_STUNGUN",
    "WEAPON_FLAREGUN",
    "WEAPON_APPISTOL"
}

function CheckWeapon(ped)
    for i = 1, #weapons do
        if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
            return true
        end
    end
    return false
end

--[[ Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true)then
            RequestAnimDict( "rcmjosh4" )
            RequestAnimDict( "weapons@pistol@" )
            if CheckWeapon(ped) then
                if holstered then
                    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
                    TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                    SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
                    Citizen.Wait(1000)
                    ClearPedTasks(ped)
                    holstered = false
                end
            elseif not CheckWeapon(ped) then
                if not holstered then
                        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
                        TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                        Citizen.Wait(1200)
                        ClearPedTasks(ped)
                        holstered = true
                end
            end
        end
    end
end)--]]

 Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true)then
            RequestAnimDict( "reaction@intimidation@1h" )
            RequestAnimDict( "combat@reaction_aim@pistol" )
            if CheckWeapon(ped) then
                if holstered then
                    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
                    TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                    Citizen.Wait(1100)
                    SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
                    Citizen.Wait(1000)
                    ClearPedTasks(ped)
                    holstered = false
                end
            elseif not CheckWeapon(ped) then
                if not holstered then
                        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
                        TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                        Citizen.Wait(1200)
                        ClearPedTasks(ped)
                        holstered = true
                end
            end
        end
    end
end)

local rifles = {
    "WEAPON_BAT",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_CARBINERIFLE",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_DBSHOTGUN",
    "WEAPON_MICROSMG",
    "WEAPON_GOLFCLUB",
    "WEAPON_CROWBAR",
    "WEAPON_SNIPERRIFLE",
    "WEAPON_PETROLCAN",
    "WEAPON_POOLCUE",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_BULLPUPRIFLE",   
    "WEAPON_COMPACTRIFLE",
    "WEAPON_RPG",
    "WEAPON_WRENCH",
    "WEAPON_PUMPSHOTGUN"
}

function CheckHeavyWeapon(ped)
    for i = 1, #rifles do
        if GetHashKey(rifles[i]) == GetSelectedPedWeapon(ped) then
            return true
        end
    end
    return false
end

 Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true)then
            RequestAnimDict( "anim@heists@money_grab@duffel" )
            RequestAnimDict("anim@heists@money_grab@duffel")
            if CheckHeavyWeapon(ped) then
                if holstered2 then
                    TaskPlayAnim(ped, "anim@heists@money_grab@duffel", "enter", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                    Citizen.Wait(1100)
                    ClearPedTasks(ped)
                    holstered2 = false
                end
            elseif not CheckHeavyWeapon(ped) then
                if not holstered2 then
                        TaskPlayAnim(ped, "anim@heists@money_grab@duffel", "enter", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                        Citizen.Wait(1200)
                        ClearPedTasks(ped)
                        holstered2 = true
                end
            end
        end
    end
end)

bone_config = {

--[[	["WEAPON_KNIFE"] = {		
		bone = 24818,		
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0},
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		category = "melee", 
		model = "prop_w_me_knife_01"
	},--]]
	["WEAPON_NIGHTSTICK"] = {		
		bone = 24818,		
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_me_nightstick"
	},
	["WEAPON_HAMMER"] = {		
		bone = 24818,		
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "prop_tool_hammer"
	},

	["WEAPON_BAT"] = {
		bone = 24818,
		coordinates = {x = 0.0, y = 0.0, z = 0.0}, 
		rotation = {x = 320.0, y = 320.0, z = 320.0}, 
		model = "w_me_bat"
	},
	["WEAPON_GOLFCLUB"] = {		
		bone = 24818,		
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_me_gclub"
	},
	["WEAPON_CROWBAR"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_me_crowbar"
	},
--[[	["WEAPON_BOTTLE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "prop_w_me_bottle"
	},
	["WEAPON_KNUCKLE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "prop_w_me_dagger"
	},
	["WEAPON_HATCHET"] = {
		bone = 24818, 
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_me_hatchet"
	},
	["WEAPON_MACHETE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "prop_ld_w_me_machette"
	},
	["WEAPON_SWITCHBLADE"] = {
		bone = 24818, 

		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "prop_w_me_dagger"
	},
	["WEAPON_FLASHLIGHT"] = {
		bone = 24818,
		coordinates = {x = 0.0, y = 0.0, z = 0.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = "prop_w_me_dagger"
	},--]]
	["WEAPON_PISTOL"] = {
		bone = 51826,		
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0}, 
		model = "w_pi_pistol"
	},
--[[	["WEAPON_COMBATPISTOL"] = {
		bone = 51826, 
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0}, 
		model = "w_pi_combatpistol"
	},--]]
--[[	["WEAPON_APPISTOL"] = {
		bone = 51826, 
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0}, 
		model = "w_pi_appistol"
	},
	["WEAPON_PISTOL50"] = {
		bone = 51826, 
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0}, 
		model = "w_pi_pistol50"
	},
	["WEAPON_VINTAGEPISTOL"] = {
		bone = 51826, 
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0}, 
		model = "w_pi_vintage_pistol"
	},
	["WEAPON_HEAVYPISTOL"] = {
		bone = 51826, 
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0}, 
		model = "w_pi_heavypistol"
	},
	["WEAPON_SNSPISTOL"] = {
		bone = 58271, 
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0}, 
		model = "w_pi_sns_pistol"
	},
	["WEAPON_FLAREGUN"] = {
		bone = 58271, 
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0}, 
		model = "w_pi_flaregun"
	},
	["WEAPON_MARKSMANPISTOL"] = {
		bone = 58271, 
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0}, 
		model = ""
	},
	["WEAPON_REVOLVER"] = {
		bone = 58271, 
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0},
		model = ""},
	["WEAPON_STUNGUN"] = {
		bone = 58271, 
		coordinates = {x = -0.01, y = 0.10, z = 0.07}, 
		rotation = {x = -115.0, y = 0.0, z = 0.0}, 
		model = "w_pi_stungun"
	},--]]

	["WEAPON_MICROSMG"] = {
		bone = 24818, 

		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_sb_microsmg"},
	["WEAPON_SMG"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_sb_smg"
	},
	["WEAPON_MG"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_mg_mg"},
	["WEAPON_COMBATMG"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_mg_combatmg"
	},
	["WEAPON_GUSENBERG"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_sb_gusenberg"},
	["WEAPON_COMBATPDW"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_sb_combatpdw"
	},
	["WEAPON_MACHINEPISTOL"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = ""
	},
	["WEAPON_ASSAULTSMG"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_sb_assaultsmg"},
	["WEAPON_MINISMG"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = ""
	},
	["WEAPON_ASSAULTRIFLE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ar_assaultrifle"},
	["WEAPON_CARBINERIFLE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ar_carbinerifle"
	},
	["WEAPON_ADVANCEDRIFLE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ar_advancedrifle"},
	["WEAPON_SPECIALCARBINE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ar_specialcarbine"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ar_bullpuprifle"
	},
	["WEAPON_COMPACTRIFLE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ar_compactrifle"
	},

	["WEAPON_PUMPSHOTGUN"] = {
		bone = 24818,		
		coordinates = {x = 0.1, y = -0.15, z = 0.0},
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = "w_sg_pumpshotgun"
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		bone = 24818,		
		coordinates = {x = 0.1, y = -0.15, z = 0.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = ""
	},
	["WEAPON_BULLPUPSHOTGUN"] = {
		bone = 24818,		
		coordinates = {x = 0.1, y = -0.15, z = 0.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = "w_sg_bullpupshotgun"
	},
	["WEAPON_ASSAULTSHOTGUN"] = {
		bone = 24818,		
		coordinates = {x = 0.1, y = -0.15, z = 0.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = "w_sg_assaultshotgun"
	},
	["WEAPON_MUSKET"] = {
		bone = 24818,		
		coordinates = {x = 0.1, y = -0.15, z = 0.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = "w_ar_musket"
	},
	["WEAPON_HEAVYSHOTGUN"] = {
		bone = 24818,
		coordinates = {x = 0.1, y = -0.15, z = 0.0},
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = "w_sg_heavyshotgun"
	},
	["WEAPON_DBSHOTGUN"] = {
		bone = 24818,		
		coordinates = {x = 0.1, y = -0.15, z = 0.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = ""
	},
	["WEAPON_AUTOSHOTGUN"] = {
		bone = 24818,		
		coordinates = {x = 0.1, y = -0.15, z = 0.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = ""
	},

	["WEAPON_SNIPERRIFLE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_sr_sniperrifle"
	},
--[[	["WEAPON_HEAVYSNIPER"] = {
		bone = 24818,		
		coordinates = {x = 0.1, y = -0.15, z = 0.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = "w_sr_heavysniper"
	},
	["WEAPON_MARKSMANRIFLE"] = {
		bone = 24818,		
		coordinates = {x = 0.1, y = -0.15, z = 0.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0}, 
		model = "w_sr_marksmanrifle"
	},

	["WEAPON_REMOTESNIPER"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = ""
	},
	["WEAPON_STINGER"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = ""
	},--]]

--[[	["WEAPON_GRENADELAUNCHER"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_lr_grenadelauncher"},--]]
	["WEAPON_RPG"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_lr_rpg"},
	["WEAPON_MINIGUN"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_mg_minigun"},
--[[	["WEAPON_FIREWORK"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_lr_firework"},
	["WEAPON_RAILGUN"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ar_railgun"},
	["WEAPON_HOMINGLAUNCHER"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_lr_homing"},
	["WEAPON_COMPACTLAUNCHER"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = ""},
--]]
--[[	["WEAPON_STICKYBOMB"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "prop_bomb_01_s"},
	["WEAPON_MOLOTOV"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ex_molotov"},
	["WEAPON_FIREEXTINGUISHER"] = {
		bone = 24818, 
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_am_fire_exting"},--]]
	["WEAPON_PETROLCAN"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_am_jerrycan"},
--[[	["WEAPON_PROXMINE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = ""},
	["WEAPON_SNOWBALL"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ex_snowball"},
	["WEAPON_BALL"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_am_baseball"},
	["WEAPON_GRENADE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ex_grenadefrag"},
	["WEAPON_SMOKEGRENADE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ex_grenadesmoke"},
	["WEAPON_BZGAS"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_ex_grenadesmoke"
	},--]]

--[[	["WEAPON_DIGISCANNER"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_am_digiscanner"
	},
	["WEAPON_DAGGER"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "prop_w_me_dagger"
	},
	["WEAPON_GARBAGEBAG"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = ""
	},--]]
	["WEAPON_HANDCUFFS"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = ""
	},
	["WEAPON_BATTLEAXE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "prop_tool_fireaxe"
	},
--[[	["WEAPON_PIPEBOMB"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = ""
	},--]]
	["WEAPON_POOLCUE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "prop_pool_cue"
	},
	["WEAPON_WRENCH"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "w_me_hammer"
	},
	["GADGET_NIGHTVISION"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = ""
	},
	["GADGET_PARACHUTE"] = {
		bone = 24818,
		coordinates = {x = 65536.0, y = 65536.0, z = 65536.0}, 
		rotation = {x = 0.0, y = 0.0, z = 0.0},
		model = "p_parachute_s"
	},
}

local attached_weapons = {}
-----------------------------------------------------------
-----------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			local _ped = PlayerPedId()
			for _weapon, values in pairs(bone_config) do
				local _weapon_hash = GetHashKey(_weapon)
	    		if HasPedGotWeapon(_ped, _weapon_hash, false) then
	    			local onPlayer = false

					for _Weapon, entity in pairs(attached_weapons) do
	      				if entity ~= nil then
	      					if _Weapon == _weapon then
	      						onPlayer = true
	      						break
	      					end
	      				end
	      			end

	      			if not onPlayer and _weapon_hash ~= GetSelectedPedWeapon(_ped) then
		      			AddWeapon(_weapon)
	      			elseif onPlayer and _weapon_hash == GetSelectedPedWeapon(_ped) then
						RemoveWeapon(_weapon)
	      			end
	    		end
	    	end
	    	Wait(500)
	end
end)
-----------------------------------------------------------
-----------------------------------------------------------
AddEventHandler("aw:load", function()
	print("Loading _weapons")
	loaded = false
	RemoveAndAddWeapons()
end)

AddEventHandler("aw:remove", function()
	loaded = false
	RemoveWeapons()
end)

function RemoveWeapon(_weapon)
	RequestAndDelete(attached_weapons[_weapon], true)
	attached_weapons[_weapon] = nil
end

function RemoveWeapons()
	for _weapon, entity in pairs(attached_weapons) do
		if entity ~= nil then
			RequestAndDelete(entity, true)
		end
	end
	attached_weapons = {}
end

function AddWeapon(_weapon)
	Citizen.CreateThread(function()
		local weapon_hash = GetHashKey(bone_config[_weapon]["model"])
		RequestModel(weapon_hash)

		while not HasModelLoaded(weapon_hash) do
			Citizen.Wait(0)
		end

		attached_weapons[_weapon] = CreateObject(weapon_hash, x, y, z, true, true, true)
		while not DoesEntityExist(attached_weapons[_weapon]) do
			Citizen.Wait(0)
		end
		local _ped = PlayerPedId()
		local boneIndex = GetPedBoneIndex(_ped, bone_config[_weapon]["bone"])
		local bonePos = GetWorldPositionOfEntityBone(_ped, boneIndex)
		AttachEntityToEntity(attached_weapons[_weapon], _ped, boneIndex, bone_config[_weapon]["coordinates"]["x"], bone_config[_weapon]["coordinates"]["y"], bone_config[_weapon]["coordinates"]["z"], bone_config[_weapon]["rotation"]["x"], bone_config[_weapon]["rotation"]["y"], bone_config[_weapon]["rotation"]["z"], false, false, false, false, 2, true)
	end)
end

function AddWeapons()
	Citizen.CreateThread(function()
		for _weapon, values in pairs(user_weapons) do
			local weapon_hash = GetHashKey(bone_config[_weapon]["model"])
			RequestModel(weapon_hash)

			while not HasModelLoaded(weapon_hash) do
				Citizen.Wait(0)
			end
			attached_weapons[_weapon] = CreateObject(weapon_hash, x, y, z, true, true, true)
			while not DoesEntityExist(attached_weapons[_weapon]) do
				Citizen.Wait(0)
			end
			local _ped = PlayerPedId()
			local boneIndex = GetPedBoneIndex(_ped, bone_config[_weapon]["bone"])
			local bonePos = GetWorldPositionOfEntityBone(_ped, boneIndex)
			AttachEntityToEntity(attached_weapons[_weapon], _ped, boneIndex, bone_config[_weapon]["coordinates"]["x"], bone_config[_weapon]["coordinates"]["y"], bone_config[_weapon]["coordinates"]["z"], bone_config[_weapon]["rotation"]["x"], bone_config[_weapon]["rotation"]["y"], bone_config[_weapon]["rotation"]["z"], false, false, false, false, 2, true)
		end
	end)
end

function RemoveAndAddWeapons()
	Citizen.CreateThread(function()
		for _weapon, entity in pairs(attached_weapons) do
			if entity ~= nil then
				RequestAndDelete(entity, true)
			end
		end
		attached_weapons = {}
		for _weapon, values in pairs(user_weapons) do
			local weapon_hash = GetHashKey(bone_config[_weapon]["model"])
			RequestModel(weapon_hash)

			while not HasModelLoaded(weapon_hash) do
				Citizen.Wait(0)
			end
			attached_weapons[_weapon] = CreateObject(weapon_hash, x, y, z, true, true, true)
			while not DoesEntityExist(attached_weapons[_weapon]) do
				Citizen.Wait(0)
			end
			local _ped = PlayerPedId()
			local boneIndex = GetPedBoneIndex(_ped, bone_config[_weapon]["bone"])
			local bonePos = GetWorldPositionOfEntityBone(_ped, boneIndex)
			AttachEntityToEntity(attached_weapons[_weapon], _ped, boneIndex, bone_config[_weapon]["coordinates"]["x"], bone_config[_weapon]["coordinates"]["y"], bone_config[_weapon]["coordinates"]["z"], bone_config[_weapon]["rotation"]["x"], bone_config[_weapon]["rotation"]["y"], bone_config[_weapon]["rotation"]["z"], false, false, false, false, 2, true)
		end
		loaded = true
	end)
end
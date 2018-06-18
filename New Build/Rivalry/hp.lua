function Draw3DText(x,y,z, text, _size) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        local size = _size or 0.3
        SetTextScale(0.0*scale, size*scale)
        SetTextFont(6)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local Weapons = {"WEAPON_PISTOL","WEAPON_PISTOL_MK2","WEAPON_COMBATPISTOL","WEAPON_PISTOL50","WEAPON_SNSPISTOL","WEAPON_SNSPISTOL_MK2","WEAPON_HEAVYPISTOL","WEAPON_VINTAGEPISTOL","WEAPON_MARKSMANPISTOL","WEAPON_REVOLVER","WEAPON_REVOLVER_MK2","WEAPON_DOUBLEACTION","WEAPON_APPISTOL","WEAPON_FLAREGUN","WEAPON_STUNGUN","WEAPON_MICROSMG","WEAPON_MACHINEPISTOL","WEAPON_MINISMG","WEAPON_SMG","WEAPON_SMG_MK2","WEAPON_ASSAULTSMG","WEAPON_COMBATPDW","WEAPON_MG","WEAPON_COMBATMG","WEAPON_COMBATMG_MK2","WEAPON_GUSENBERG","WEAPON_ASSAULTRIFLE","WEAPON_ASSAULTRIFLE_MK2","WEAPON_CARBINERIFLE","WEAPON_CARBINERIFLE_MK2","WEAPON_ADVANCEDRIFLE","WEAPON_SPECIALCARBINE","WEAPON_SPECIALCARBINE_MK2","WEAPON_BULLPUPRIFLE","WEAPON_BULLPUPRIFLE_MK2","WEAPON_COMPACTRIFLE","WEAPON_SNIPERRIFLE","WEAPON_HEAVYSNIPER","WEAPON_HEAVYSNIPER_MK2","WEAPON_MARKSMANRIFLE","WEAPON_MARKSMANRIFLE_MK2","WEAPON_UNARMED","WEAPON_KNIFE","WEAPON_NIGHTSTICK","WEAPON_HAMMER","WEAPON_BAT","WEAPON_CROWBAR","WEAPON_GOLFCLUB","WEAPON_BOTTLE","WEAPON_DAGGER","WEAPON_HATCHET","WEAPON_KNUCKLE","WEAPON_MACHETE","WEAPON_FLASHLIGHT","WEAPON_SWITCHBLADE","WEAPON_BATTLEAXE","WEAPON_POOLCUE","WEAPON_WRENCH","WEAPON_PUMPSHOTGUN","WEAPON_PUMPSHOTGUN_MK2","WEAPON_SAWNOFFSHOTGUN","WEAPON_BULLPUPSHOTGUN","WEAPON_ASSAULTSHOTGUN","WEAPON_MUSKET","WEAPON_HEAVYSHOTGUN","WEAPON_DBSHOTGUN","WEAPON_AUTOSHOTGUN","WEAPON_GRENADELAUNCHER","WEAPON_RPG","WEAPON_MINIGUN","WEAPON_FIREWORK","WEAPON_RAILGUN","WEAPON_HOMINGLAUNCHER","WEAPON_COMPACTLAUNCHER","WEAPON_GRENADE","WEAPON_STICKYBOMB","WEAPON_PROXMINE","WEAPON_PIPEBOMB","WEAPON_SMOKEGRENADE","WEAPON_BZGAS","WEAPON_MOLOTOV","WEAPON_FIREEXTINGUISHER","WEAPON_PETROLCAN","WEAPON_BALL","WEAPON_SNOWBALL","WEAPON_FLARE","WEAPON_DIGISCANNER","WEAPON_REMOTESNIPER","WEAPON_ANIMAL","WEAPON_COUGAR","WEAPON_BARBED_WIRE","WEAPON_DROWNING","WEAPON_BLEEDING","WEAPON_ELECTRIC_FENCE","WEAPON_EXPLOSION","WEAPON_FALL","WEAPON_EXHAUSTION","WEAPON_HIT_BY_WATER_CANNON","WEAPON_RAMMED_BY_CAR", "WEAPON_RUN_OVER_BY_CAR","WEAPON_HELI_CRASH","WEAPON_FIRE"}
local InjuryStrings = {
	["WEAPON_PISTOL"] = "Pistol Bullets",
	["WEAPON_PISTOL_MK2"] = "Pistol Bullets",
	["WEAPON_COMBATPISTOL"] = "Combat Pistol Bullets",
	["WEAPON_PISTOL50"] = ".50 Pistol Bullets",
	["WEAPON_SNSPISTOL"] = "SNS Pistol Bullets",
	["WEAPON_SNSPISTOL_MK2"] = "SNS Pistol Bullets",
	["WEAPON_HEAVYPISTOL"] = "Heavy Pistol Bullets",
	["WEAPON_VINTAGEPISTOL"] = "Vintage Pistol Bullets",
	["WEAPON_MARKSMANPISTOL"] = "Marksman Pistol Bullets",
	["WEAPON_REVOLVER"] = "Revolver Bullets",
	["WEAPON_REVOLVER_MK2"] = "Revolver Bullets",
	["WEAPON_DOUBLEACTION"] = "Double Action Bullets",
	["WEAPON_APPISTOL"] = "AP Pistol Bullets",
	["WEAPON_FLAREGUN"] = "Flare Burns",
	["WEAPON_STUNGUN"] = "Electrical Burns",
	["WEAPON_MICROSMG"] = "Micro SMG Bullets",
	["WEAPON_MACHINEPISTOL"] = "Machine P Bullets",
	["WEAPON_MINISMG"] = "SMG Bullets",
	["WEAPON_SMG"] = "SMG Bullets",
	["WEAPON_SMG_MK2"] = "SMG Bullets",
	["WEAPON_ASSAULTSMG"] = "Assault SMG Bullets",
	["WEAPON_COMBATPDW"] = "PDW Bullets",
	["WEAPON_MG"] = "MG Bullets",
	["WEAPON_COMBATMG"] = "Combat MG Bullets",
	["WEAPON_COMBATMG_MK2"] = "Combat MG Bullets",
	["WEAPON_GUSENBERG"] = "Guesenberg Bullets",
	["WEAPON_ASSAULTRIFLE"] = "Assault Rifle Bullets",
	["WEAPON_ASSAULTRIFLE_MK2"] = "Assault Rifle Bullets",
	["WEAPON_CARBINERIFLE"] = "Carbine Rifle Bullets",
	["WEAPON_CARBINERIFLE_MK2"] = "Carbine Rifle Bullets",
	["WEAPON_ADVANCEDRIFLE"] = "Advanced Rifle Bullets",
	["WEAPON_SPECIALCARBINE"] = "Special Carbine Rifle Bullets",
	["WEAPON_SPECIALCARBINE_MK2"] = "Special Carbine Rifle Bullets",
	["WEAPON_BULLPUPRIFLE"] = "Bullpup Rifle Bullets",
	["WEAPON_BULLPUPRIFLE_MK2"] = "Bullpup Rifle Bullets",
	["WEAPON_COMPACTRIFLE"] = "Compact Rifle Bullets",
	["WEAPON_SNIPERRIFLE"] = "Sniper Wounds",
	["WEAPON_HEAVYSNIPER"] = "Heavy Sniper Wounds",
	["WEAPON_HEAVYSNIPER_MK2"] = "Heavy Sniper Wounds",
	["WEAPON_MARKSMANRIFLE"] = "Marksman Rifle Bullets",
	["WEAPON_MARKSMANRIFLE_MK2"] = "Marksman Rifle Bullets",
	["WEAPON_UNARMED"] = "Fist marks",
	["WEAPON_KNIFE"] = "Knife Wounds",
	["WEAPON_NIGHTSTICK"] = "Nightstick Indents",
	["WEAPON_HAMMER"] = "Hammer Indents",
	["WEAPON_BAT"] = "Bat Indents",
	["WEAPON_CROWBAR"] = "Crowbar Indents",
	["WEAPON_GOLFCLUB"] = "Golfclub Indents",
	["WEAPON_BOTTLE"] = "Glass Shards",
	["WEAPON_DAGGER"] = "Knife Wounds",
	["WEAPON_HATCHET"] = "Hatchet Wounds",
	["WEAPON_KNUCKLE"] = "Knuckle Indents",
	["WEAPON_MACHETE"] = "Machete Wounds",
	["WEAPON_FLASHLIGHT"] = "Blunt Object Marks",
	["WEAPON_SWITCHBLADE"] = "Blade Wounds",
	["WEAPON_BATTLEAXE"] = "Axe Wounds",
	["WEAPON_POOLCUE"] = "Poolcue Bruises",
	["WEAPON_WRENCH"] = "Wrench Indents",
	["WEAPON_PUMPSHOTGUN"] = "Pumpshotgun Bullets",
	["WEAPON_PUMPSHOTGUN_MK2"] = "Pumpshotgun Bullets",
	["WEAPON_SAWNOFFSHOTGUN"] = "Sawn-off Bullets",
	["WEAPON_BULLPUPSHOTGUN"] = "Bullpup Shotgun Bullets",
	["WEAPON_ASSAULTSHOTGUN"] = "Assault Shotgun Bullets",
	["WEAPON_MUSKET"] = "Musket Wounds",
	["WEAPON_HEAVYSHOTGUN"] = "Heavy Shotgun Bullets",
	["WEAPON_DBSHOTGUN"] = "Double Barrel Bullets",
	["WEAPON_AUTOSHOTGUN"] = "Auto Shotgun Bullets",
	["WEAPON_GRENADELAUNCHER"] = "Explosive Damage",
	["WEAPON_RPG"] = "Explosive Damage",
	["WEAPON_MINIGUN"] = "Minigun Wounds",
	["WEAPON_FIREWORK"] = "Firework Burns",
	["WEAPON_RAILGUN"] = "Explosive Damage",
	["WEAPON_HOMINGLAUNCHER"] = "Explosive Damage",
	["WEAPON_COMPACTLAUNCHER"] = "Explosive Damage",
	["WEAPON_GRENADE"] = "Explosive Damage",
	["WEAPON_STICKYBOMB"] = "Explosive Damage",
	["WEAPON_PROXMINE"] = "Explosive Damage",
	["WEAPON_PIPEBOMB"] = "Explosive Damage",
	["WEAPON_SMOKEGRENADE"] = "Gas Damage",
	["WEAPON_BZGAS"] = "Gas Damage",
	["WEAPON_MOLOTOV"] = "Accelerant Burns",
	["WEAPON_FIREEXTINGUISHER"] = "Extenguisher Damage",
	["WEAPON_PETROLCAN"] = "Petrol Damage",
	["WEAPON_BALL"] = "Blunt Force Wound",
	["WEAPON_SNOWBALL"] = "Blunt Force Wound",
	["WEAPON_FLARE"] = "Flare Burns",
	["WEAPON_DIGISCANNER"] = "Scanner Wounds",
	["WEAPON_REMOTESNIPER"] = "Sniper Wounds",
	["WEAPON_ANIMAL"] = "Animal Bites/Claw Marks",
	["WEAPON_COUGAR"] = "Animal Bites/Claw Marks",
	["WEAPON_BARBED_WIRE"] = "Barbed Wire Damage",
	["WEAPON_DROWNING"] = "Severe Lack Of Oxygen",
	["WEAPON_DROWNING_IN_VEHICLE"] = "Severe Lack Of Oxygen",
	["WEAPON_BLEEDING"] = "Loss Of Blood",
	["WEAPON_ELECTRIC_FENCE"] = "Electrical Burns",
	["WEAPON_EXPLOSION"] = "Explosive Damage",
	["WEAPON_FALL"] = "Fall Damage",
	["WEAPON_EXHAUSTION"] = "Exhaustion",
	["WEAPON_HIT_BY_WATER_CANNON"] = "Blunt Force Water Damage",
	["WEAPON_RAMMED_BY_CAR"] = "Blunt Force Vehicular Damage",
	["WEAPON_RUN_OVER_BY_CAR"] = "Crushing Vehicular Damage",
	["WEAPON_HELI_CRASH"] = "Extreme Burns",
	["WEAPON_FIRE"] = "Burns",
}
local DeathStrings = {
	["WEAPON_PISTOL"] = "Pistol",
	["WEAPON_PISTOL_MK2"] = "Pistol",
	["WEAPON_COMBATPISTOL"] = "Combat Pistol",
	["WEAPON_PISTOL50"] = ".50 Pistol",
	["WEAPON_SNSPISTOL"] = "SNS Pistol",
	["WEAPON_SNSPISTOL_MK2"] = "SNS Pistol",
	["WEAPON_HEAVYPISTOL"] = "Heavy Pistol",
	["WEAPON_VINTAGEPISTOL"] = "Vintage Pistol",
	["WEAPON_MARKSMANPISTOL"] = "Marksman Pistol",
	["WEAPON_REVOLVER"] = "Revolver",
	["WEAPON_REVOLVER_MK2"] = "Revolver",
	["WEAPON_DOUBLEACTION"] = "Double Action Revolver",
	["WEAPON_APPISTOL"] = "AP Pistol",
	["WEAPON_FLAREGUN"] = "Flaregun",
	["WEAPON_STUNGUN"] = "Stungun",
	["WEAPON_MICROSMG"] = "Micro SMG",
	["WEAPON_MACHINEPISTOL"] = "Machine Pistol",
	["WEAPON_MINISMG"] = "Mini SMG",
	["WEAPON_SMG"] = "SMG",
	["WEAPON_SMG_MK2"] = "SMG",
	["WEAPON_ASSAULTSMG"] = "Assault SMG",
	["WEAPON_COMBATPDW"] = "Combat PDW",
	["WEAPON_MG"] = "MG",
	["WEAPON_COMBATMG"] = "Combat MG",
	["WEAPON_COMBATMG_MK2"] = "Combat MG",
	["WEAPON_GUSENBERG"] = "Guesenberg",
	["WEAPON_ASSAULTRIFLE"] = "Assault Rifle",
	["WEAPON_ASSAULTRIFLE_MK2"] = "Assault Rifle",
	["WEAPON_CARBINERIFLE"] = "Carbine Rifle",
	["WEAPON_CARBINERIFLE_MK2"] = "Carbine Rifle",
	["WEAPON_ADVANCEDRIFLE"] = "Advanced Rifle",
	["WEAPON_SPECIALCARBINE"] = "Special Carbine Rifle",
	["WEAPON_SPECIALCARBINE_MK2"] = "Special Carbine Rifle",
	["WEAPON_BULLPUPRIFLE"] = "Bullpup Rifle",
	["WEAPON_BULLPUPRIFLE_MK2"] = "Bullpup Rifle",
	["WEAPON_COMPACTRIFLE"] = "Compact Rifle",
	["WEAPON_SNIPERRIFLE"] = "Sniper",
	["WEAPON_HEAVYSNIPER"] = "Heavy Sniper",
	["WEAPON_HEAVYSNIPER_MK2"] = "Heavy Sniper",
	["WEAPON_MARKSMANRIFLE"] = "Marksman Rifle",
	["WEAPON_MARKSMANRIFLE_MK2"] = "Marksman Rifle",
	["WEAPON_UNARMED"] = "Fists",
	["WEAPON_KNIFE"] = "Sharp Piercing Object",
	["WEAPON_NIGHTSTICK"] = "Blunt Object (Metal)",
	["WEAPON_HAMMER"] = "Blunt Object (Metal)",
	["WEAPON_BAT"] = "Large Blunt Object (Wooden)",
	["WEAPON_CROWBAR"] = "Medium Size Jagged Metal Object",
	["WEAPON_GOLFCLUB"] = "Long Thin Blunt Object",
	["WEAPON_BOTTLE"] = "Small Sharp Object (Glass)",
	["WEAPON_DAGGER"] = "Sharp Piercing Object",
	["WEAPON_HATCHET"] = "Large Thick Piercing Object",
	["WEAPON_KNUCKLE"] = "Knuckle Dusters",
	["WEAPON_MACHETE"] = "Long Sharp Blade",
	["WEAPON_FLASHLIGHT"] = "Flashlight",
	["WEAPON_SWITCHBLADE"] = "Switchblade",
	["WEAPON_BATTLEAXE"] = "Battleaxe",
	["WEAPON_POOLCUE"] = "Poolcue",
	["WEAPON_WRENCH"] = "Wrench",
	["WEAPON_PUMPSHOTGUN"] = "Pump Shotgun",
	["WEAPON_PUMPSHOTGUN_MK2"] = "Pump Shotgun",
	["WEAPON_SAWNOFFSHOTGUN"] = "Sawn-off Shotgun",
	["WEAPON_BULLPUPSHOTGUN"] = "Bullpup Shotgun",
	["WEAPON_ASSAULTSHOTGUN"] = "Assault Shotgun",
	["WEAPON_MUSKET"] = "Musket",
	["WEAPON_HEAVYSHOTGUN"] = "Heavy Shotgun",
	["WEAPON_DBSHOTGUN"] = "Double Barrel Shoutgun",
	["WEAPON_AUTOSHOTGUN"] = "Auto Shotgun",
	["WEAPON_GRENADELAUNCHER"] = "Explosive Damage",
	["WEAPON_RPG"] = "Explosive Damage",
	["WEAPON_MINIGUN"] = "Minigun",
	["WEAPON_FIREWORK"] = "Fireworks",
	["WEAPON_RAILGUN"] = "Explosive Damage",
	["WEAPON_HOMINGLAUNCHER"] = "Explosive Damage",
	["WEAPON_COMPACTLAUNCHER"] = "Explosive Damage",
	["WEAPON_GRENADE"] = "Explosive Damage",
	["WEAPON_STICKYBOMB"] = "Explosive Damage",
	["WEAPON_PROXMINE"] = "Explosive Damage",
	["WEAPON_PIPEBOMB"] = "Explosive Damage",
	["WEAPON_SMOKEGRENADE"] = "Gas Danage",
	["WEAPON_BZGAS"] = "Gas Damage",
	["WEAPON_MOLOTOV"] = "Fire Damage",
	["WEAPON_FIREEXTINGUISHER"] = "Extinguisher",
	["WEAPON_PETROLCAN"] = "Petrol Can",
	["WEAPON_BALL"] = "Small Blunt Object",
	["WEAPON_SNOWBALL"] = "Small Blunt Object",
	["WEAPON_FLARE"] = "Fire Damage",
	["WEAPON_DIGISCANNER"] = "Small Thin Object",
	["WEAPON_REMOTESNIPER"] = "Sniper",
	["WEAPON_ANIMAL"] = "Animal Bites and Claws",
	["WEAPON_COUGAR"] = "Animal Bites and Claws",
	["WEAPON_BARBED_WIRE"] = "Barbed Wire Damage",
	["WEAPON_DROWNING"] = "Severe Lack Of Oxygen",
	["WEAPON_DROWNING_IN_VEHICLE"] = "Severe Lack Of Oxygen",
	["WEAPON_BLEEDING"] = "Blood Loss",
	["WEAPON_ELECTRIC_FENCE"] = "Electical Burns",
	["WEAPON_EXPLOSION"] = "Explosion Damage",
	["WEAPON_FALL"] = "Fall Damage",
	["WEAPON_EXHAUSTION"] = "Exhasution",
	["WEAPON_HIT_BY_WATER_CANNON"] = "Blunt Force Water Damage",
	["WEAPON_RAMMED_BY_CAR"] = "Blunt Force Vehicular Damage",
	["WEAPON_RUN_OVER_BY_CAR"] = "Crushing Vehicular Damage",
	["WEAPON_HELI_CRASH"] = "Fire Damage",
	["WEAPON_FIRE"] = "Fire Damage",
}
local BodyParts = {
	Head = {
		["SKEL_Head"] = 31086,
		["IK_Head"] = 12844,
		["FACIAL_facialRoot"] = 65068,
		["FB_L_Brow_Out_000"] = 58331,
		["FB_L_Lid_Upper_000"] = 45750,
		["FB_L_Eye_000"] = 25260,
		["FB_L_CheekBone_000"] = 21550,
		["FB_L_Lip_Corner_000"] = 29868,
		["FB_R_Lid_Upper_000"] = 43536,
		["FB_R_Eye_000"] = 27474,
		["FB_R_CheekBone_000"] = 19336,
		["FB_R_Brow_Out_000"] = 1356,
		["FB_R_Lip_Corner_000"] = 11174,
		["FB_Brow_Centre_000"] = 37193,
		["FB_UpperLipRoot_000"] = 20178,
		["FB_UpperLip_000"] = 61839,
		["FB_L_Lip_Top_000"] = 20279,
		["FB_R_Lip_Top_000"] = 49979,
		["FB_Jaw_000"] = 46240,
		["FB_LowerLipRoot_000"] = 17188,
		["FB_LowerLip_000"] = 20623,
		["FB_L_Lip_Bot_000"] = 37319,
		["FB_R_Lip_Bot_000"] = 49979,
	},
	Neck = {
		["RB_Neck_1"] = 35731,
		["SKEL_Neck_1"] = 39317,
	},
	Upper = {
		["SKEL_Spine2"] = 24817,
		["SKEL_Spine3"] = 24818,	
	},
	Lower = {
		["SKEL_ROOT"] = 0,
		["SKEL_Pelvis"] = 11816,
		["SKEL_Spine_Root"] = 57597,
		["SKEL_Spine0"] = 23553,
		["SKEL_Spine1"] = 24816,
		["IK_Root"] = 56604,
		["FB_Tongue_000"] = 47495,
	},
	LeftArm = {
		["SKEL_L_UpperArm"] = 45509,
		["SKEL_L_Forearm"] = 61163,
		["SKEL_L_Clavicle"] = 64729,
		["RB_L_ForeArmRoll"] = 61007,
		["RB_L_ArmRoll"] = 5232,
		["MH_L_Elbow"] = 22711,
	},
	LeftHand = {
		["SKEL_L_Hand"] = 18905,
		["SKEL_L_Finger00"] = 26610,
		["SKEL_L_Finger01"] = 4089,
		["SKEL_L_Finger02"] = 4090,
		["SKEL_L_Finger10"] = 26611,
		["SKEL_L_Finger11"] = 4169,
		["SKEL_L_Finger12"] = 4170,
		["SKEL_L_Finger20"] = 26612,
		["SKEL_L_Finger21"] = 4185,
		["SKEL_L_Finger22"] = 4186,
		["SKEL_L_Finger30"] = 26613,
		["SKEL_L_Finger31"] = 4137,
		["SKEL_L_Finger32"] = 4138,
		["SKEL_L_Finger40"] = 26614,
		["SKEL_L_Finger41"] = 4153,
		["SKEL_L_Finger42"] = 4154,
		["PH_L_Hand"] = 60309,
		["IK_L_Hand"] = 36029,
	},
	RightArm = {
		["SKEL_R_Clavicle"] = 10706,
		["SKEL_R_UpperArm"] = 40269,
		["SKEL_R_Forearm"] = 28252,
		["RB_R_ForeArmRoll"] = 43810,
		["RB_R_ArmRoll"] = 37119,
		["MH_R_Elbow"] = 2992,
	},
	RightHand = {
		["SKEL_R_Hand"] = 57005,
		["SKEL_R_Finger00"] = 58866,
		["SKEL_R_Finger01"] = 64016,
		["SKEL_R_Finger02"] = 64017,
		["SKEL_R_Finger10"] = 58867,
		["SKEL_R_Finger11"] = 64096,
		["SKEL_R_Finger12"] = 64097,
		["SKEL_R_Finger20"] = 58868,
		["SKEL_R_Finger21"] = 64112,
		["SKEL_R_Finger22"] = 64113,
		["SKEL_R_Finger30"] = 58869,
		["SKEL_R_Finger31"] = 64064,
		["SKEL_R_Finger32"] = 64065,
		["SKEL_R_Finger40"] = 58870,
		["SKEL_R_Finger41"] = 64080,
		["SKEL_R_Finger42"] = 64081,
		["PH_R_Hand"] = 28422,
		["IK_R_Hand"] = 6286,
	},
	LeftLeg = {
		["SKEL_L_Thigh"] = 58271,
		["SKEL_L_Calf"] = 63931,
		["MH_L_Knee"] = 46078,
		["RB_L_ThighRoll"] = 23639,
	},
	LeftFoot = {
		["SKEL_L_Foot"] = 14201,
		["SKEL_L_Toe0"] = 2108,
		["IK_L_Foot"] = 65245,
		["PH_L_Foot"] = 57717,
	},
	RightLeg = {
		["SKEL_R_Thigh"] = 51826,
		["SKEL_R_Calf"] = 36864,
		["MH_R_Knee"] = 16335,
		["RB_R_ThighRoll"] = 6442,
	},
	RightFoot = {
		["SKEL_R_Foot"] = 52301,
		["SKEL_R_Toe0"] = 20781,
		["IK_R_Foot"] = 35502,
		["PH_R_Foot"] = 24806,
	},
}
local DamageIndictor = {
	Head = 50,
	Neck = 50,
	Upper = 50,
	Lower = 50,
	LeftArm = {Bone = 22711, Offset = {x = -0.75, y = 0.0, z = 0.25}},
	LeftHand = {Bone = 18905, Offset = {x = -0.75, y = 0.0, z = 0.0}},
	LeftLeg = 50,
	LeftFoot = 25,
	RightArm = {Bone = 2992, Offset = {x = 0.75, y = 0.0, z = 0.25}},
	RightHand = {Bone = 57005, Offset = {x = 0.75, y = 0.0, z = 0.0}},
	RightLeg = 50,
	RightFoot = 25,
}
local DefaultHealth = {Head = 50,Neck = 50,Upper = 50,Lower = 50,LeftArm = 50,LeftHand = 25,LeftLeg = 50,LeftFoot = 25,RightArm = 50,RightHand = 25,RightLeg = 50,RightFoot = 25}
local Health = {Head = 50,Neck = 50,Upper = 50,Lower = 50,LeftArm = 50,LeftHand = 25,LeftLeg = 50,LeftFoot = 25,RightArm = 50,RightHand = 25,RightLeg = 50,RightFoot = 25}
local Injuries = {Head = {},Neck = {},Upper = {},Lower = {},LeftArm = {},LeftHand = {},LeftLeg = {},LeftFoot = {},RightArm = {},RightHand = {},RightLeg = {},RightFoot = {}}
local CurrentPed = nil
local CurrentHealth = nil
local LastFall = nil

function FindBodyPart(id)
	for BodyPart, Bones in pairs(BodyParts) do
		for Bone, Value in pairs(Bones) do
			if id == Value then
				return BodyPart
			end
		end
	end
	return nil
end

function CompileInjuries(tbl)
	local Output = {}
	for BodyPart, Values in pairs(tbl) do
		local message = ""
		for Injury, Count in pairs(Values) do
			message = message.." ^3[" .. Count .. "x]^5 "..Injury
		end
		Output[BodyPart] = message
	end
	return Output
end

function DisplayInjuries(tbl)
	for BodyPart, Message in pairs(tbl) do
		if Message ~= "" then
			TriggerEvent("chatMessage", "^*"..BodyPart.."["..Health[BodyPart].."/"..DefaultHealth[BodyPart].."]", {255,255,255}, Message)
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 244) then
			DisplayInjuries(CompileInjuries(Injuries))
		end
		if CurrentPed ~= PlayerPedId() then
			CurrentPed = PlayerPedId()
			CurrentHealth = GetEntityHealth(CurrentPed)
			LastFall = GetEntityCoords(CurrentPed, false)
		end

		if not IsEntityDead(CurrentPed) then
			local offset = GetOffsetFromEntityInWorldCoords(CurrentPed, 0.75, 0.0, 0.0)
			local bone_coords = GetPedBoneCoords(CurrentPed, 57005, 0, 0, 0)
			DrawLine(bone_coords.x, bone_coords.y, bone_coords.z, offset.x, offset.y, offset.z, 255, 0, 0, 255)
			DrawMarker(28, bone_coords.x+0.25, bone_coords.y+0.25, bone_coords.z, 0, 0, 0, 0, 0, 0, 0.05, 0.05, 0.05, 255, 0, 0, 255, 0, 0, 2, 0, 0, 0, 0)
			local Position = GetEntityCoords(CurrentPed, false)
			if CurrentHealth ~= GetEntityHealth(CurrentPed) then
				local _, bone = GetPedLastDamageBone(CurrentPed)
				local BodyPart = FindBodyPart(bone)
				for Index = 1, #Weapons do
					if HasPedBeenDamagedByWeapon(CurrentPed, GetHashKey(Weapons[Index]), 0) then
						if Injuries[BodyPart] then
							if InjuryStrings[Weapons[Index]] then
								if Injuries[BodyPart][InjuryStrings[Weapons[Index]]] then
									Injuries[BodyPart][InjuryStrings[Weapons[Index]]] = Injuries[BodyPart][InjuryStrings[Weapons[Index]]] + 1
								else
									Injuries[BodyPart][InjuryStrings[Weapons[Index]]] = 1
								end
							end
						end
						ClearEntityLastDamageEntity(CurrentPed)
					end
				end
				local DamageTaken = CurrentHealth - GetEntityHealth(CurrentPed)
				if DamageTaken > 0 then
					if Health[BodyPart] then
						if Health[BodyPart] - DamageTaken >= 0 then
							Health[BodyPart] = Health[BodyPart] - DamageTaken
						else
							Health[BodyPart] = 0
						end
					end
				end
				CurrentHealth = GetEntityHealth(CurrentPed)		
			end

			if (Health["LeftLeg"] <= 0 or Health["RightLeg"] <= 0) and not GetPedConfigFlag(CurrentPed, 166) then --Set limp flag 1
				SetPedConfigFlag(CurrentPed, 166, true)
			elseif (Health["LeftLeg"] > 0 and Health["RightLeg"] > 0) and GetPedConfigFlag(CurrentPed, 166) then
				SetPedConfigFlag(CurrentPed, 166, false)
			end

			if (Health["LeftLeg"] <= 0 and Health["RightLeg"] <= 0) and not GetPedConfigFlag(CurrentPed, 170) then --Set limp flag 2
				SetPedConfigFlag(CurrentPed, 170, true)
			elseif (Health["LeftLeg"] > 0 and Health["RightLeg"] > 0) and GetPedConfigFlag(CurrentPed, 170) then
				SetPedConfigFlag(CurrentPed, 170, false)
			end

			if (Health["LeftLeg"] <= 0 and Health["RightLeg"] <= 0) and IsPedJumping(CurrentPed) then --Set ragdoll when jumping
				SetPedToRagdoll(CurrentPed, 750, 2000, 0, 0, 0, 0)
			end

			if (Health["Upper"] <= 0 or Health["Lower"] <= 0) and not GetPedConfigFlag(CurrentPed, 187) then --Set Injuried flag
				SetPedConfigFlag(CurrentPed, 187, true)
			elseif (Health["Upper"] > 0 and Health["Lower"] > 0) and not GetPedConfigFlag(CurrentPed, 187) then
				SetPedConfigFlag(CurrentPed, 187, false)
			end

			if (Health["LeftLeg"] <= 0 and Health["RightLeg"] <= 0) and (Health["Upper"] <= 0 or Health["Lower"] <= 0) then
				if GetDistanceBetweenCoords(LastFall.x, LastFall.y, LastFall.z, Position.x, Position.y, Position.z, false) > 5 then
					if GetRandomIntInRange(1, 4) == 2 then
						SetPedToRagdoll(CurrentPed, 750, 2000, 0, 0, 0, 0)
					end
					LastFall = Position
				end
			end

			if Health["RightHand"] <= 0 then --Disable firing
				DisablePlayerFiring(PlayerId(), false)
			end

			if Health["LeftArm"] <= 0 and Health["RightArm"] <= 0 then --Disable ladders, steering
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
				SetPedPathCanUseLadders(CurrentPed, false)
				if IsPedInAnyVehicle(CurrentPed, false) then
					DisableControlAction(0, 59, true)
				end
			end

			if Health["Head"] <= 20 then --Make screen blurry (Concussion effect)
				StartScreenEffect("SuccessNeutral", 5000, false)
			else
				StopScreenEffect("SuccessNeutral")
			end
		end
	end
end)
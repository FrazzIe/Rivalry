Weapons_names = {
    ["WEAPON_PISTOL"] = "Pistol",
    ["WEAPON_COMBATPISTOL"] = "Combat Pistol",
    ["WEAPON_PISTOL50"] = "Pistol .50",
    ["WEAPON_HEAVYPISTOL"] = "Heavy Pistol",
    ["WEAPON_SNSPISTOL"] = "SNS Pistol",
    ["WEAPON_APPISTOL"] = "AP Pistol",
    ["WEAPON_VINTAGEPISTOL"] = "Vintage Pistol",
    ["WEAPON_REVOLVER"] = "Revolver",
    ["WEAPON_MARKSMANPISTOL"] = "Marksman Pistol",
    ["WEAPON_FLAREGUN"] = "Flaregun",
    ["WEAPON_STUNGUN"] = "Stungun",
    ["WEAPON_MINISMG"] = "Mini SMG",
    ["WEAPON_MACHINEPISTOL"] = "Machine Pistol",
    ["WEAPON_COMBATPDW"] = "Combat PDW",
    ["WEAPON_MICROSMG"] = "Micro SMG",
    ["WEAPON_SMG"] = "MP5",
    ["WEAPON_ASSAULTSMG"] = "Assault SMG",
    ["WEAPON_GUSENBERG"] = "Gusenberg Sweeper",
    ["WEAPON_COMBATMG"] = "Combat MG",
    ["WEAPON_MG"] = "MG",
    ["WEAPON_COMPACTRIFLE"] = "Compact Rifle",
    ["WEAPON_ADVANCEDRIFLE"] = "Advanced Rifle",
    ["WEAPON_ASSAULTRIFLE"] = "Assault Rifle",
    ["WEAPON_BULLPUPRIFLE"] = "Bullpup Rifle",
    ["WEAPON_CARBINERIFLE"] = "Carbine Rifle",
    ["WEAPON_SPECIALCARBINE"] = "Special Carbine",
    ["WEAPON_SNIPERRIFLE"] = "Sniper Rifle",
    ["WEAPON_HEAVYSNIPER"] = "Heavy Sniper",
    ["WEAPON_MARKSMANRIFLE"] = "Marksman Rifle",
    ["WEAPON_KNIFE"] = "Knife",
    ["WEAPON_FLASHLIGHT"] = "Flashlight",
    ["WEAPON_NIGHTSTICK"] = "Nightstick",
    ["WEAPON_HAMMER"] = "Hammer",
    ["WEAPON_BAT"] = "Baseball Bat",
    ["WEAPON_GOLFCLUB"] = "Golfclub",
    ["WEAPON_CROWBAR"] = "Crowbar",
    ["WEAPON_BOTTLE"] = "Smashed Bottle",
    ["WEAPON_DAGGER"] = "Dagger",
    ["WEAPON_KNUCKLE"] = "Knuckle Dusters",
    ["WEAPON_HATCHET"] = "Hatchet",
    ["WEAPON_MACHETE"] = "Machete",
    ["WEAPON_SWITCHBLADE"] = "Switchblade",
    ["WEAPON_BATTLEAXE"] = "Battleaxe",
    ["WEAPON_POOLCUE"] = "Poolcue",
    ["WEAPON_WRENCH"] = "Wrench",
    ["WEAPON_SAWNOFFSHOTGUN"] = "Sawed-Off Shotgun",
    ["WEAPON_DBSHOTGUN"] = "Double Barrel Shotgun",
    ["WEAPON_AUTOSHOTGUN"] = "Sweeper Shotgun",
    ["WEAPON_PUMPSHOTGUN"] = "Pump Shotgun",
    ["WEAPON_ASSAULTSHOTGUN"] = "Assault Shotgun",
    ["WEAPON_BULLPUPSHOTGUN"] = "Bullpup Shotgun",
    ["WEAPON_HEAVYSHOTGUN"] = "Heavy Shotgun",
    ["WEAPON_MUSKET"] = "Musket",
    ["WEAPON_GRENADELAUNCHER"] = "Grenade Launcher",
    ["WEAPON_COMPACTLAUNCHER"] = "Compact Launcher",
    ["WEAPON_RAILGUN"] = "Railgun",
    ["WEAPON_HOMINGLAUNCHER"] = "Homing Launcher",
    ["WEAPON_MINIGUN"] = "Minigun",
    ["WEAPON_RPG"] = "RPG",
    ["WEAPON_FIREWORK"] = "Firework Launcher",
    ["WEAPON_BZGAS"] = "BZ Gas",
    ["WEAPON_MOLOTOV"] = "Molotov",
    ["WEAPON_SMOKEGRENADE"] = "Tear Gas",
    ["WEAPON_STICKYBOMB"] = "Sticky Bomb",
    ["WEAPON_GRENADE"] = "Grenade",
    ["WEAPON_BALL"] = "Ball",
    ["WEAPON_FLARE"] = "Flare",
    ["WEAPON_PROXMINE"] = "Proximity Mine",
    ["WEAPON_PIPEBOMB"] = "Pipe Bomb",
    ["WEAPON_PETROLCAN"] = "Petrol Can",
    ["WEAPON_SNOWBALL"] = "Snow Ball",
    ["WEAPON_DIGISCANNER"] = "Digi-Scanner",
    ["WEAPON_REMOTESNIPER"] = "Remote Sniper",
    ["GADGET_PARACHUTE"] = "Parachute",
}

function GetIdentity(id)
    local name = ""
    TriggerEvent("core:getname", id, function(_name) 
        if _name then
            name = _name
        end
    end)
    return name
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function Notify(_message, _time, _target)
    TriggerClientEvent("pNotify:SendNotification", _target, {text = _message, type = "error", queue = "left", timeout = _time, layout = "centerRight"})
end
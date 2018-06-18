function logCommand(_title, _fields)
    PerformHttpRequest(GetConvar("command_webhook", "https://discordapp.com/api/webhooks/393124622926741504/kjC2it8lmFuu2KjzJDPskTlRX3MSES64HSbs_ZEbKyf4Ujp0XZ0ggHi1jmP0-oyJ3GP5"), function(err, text, headers) end, 'POST', json.encode(
    {
        username = "Log Bot",
        embeds = {
            {
                title = "Command -> ".._title,
                description = "",
                fields = _fields,
                color = "8190976",
            }
        },

        content = ""

    }), { ['Content-Type'] = 'application/json' })
end

function logkill(attacker, victim)
    local compiled_table = {}
    for i = 1, #attacker do
        table.insert(compiled_table, attacker[i])
    end
    for i = 1, #victim do
        table.insert(compiled_table, victim[i])
    end
    PerformHttpRequest(GetConvar("death_webhook", "https://discordapp.com/api/webhooks/393124622926741504/kjC2it8lmFuu2KjzJDPskTlRX3MSES64HSbs_ZEbKyf4Ujp0XZ0ggHi1jmP0-oyJ3GP5"), function(err, text, headers) end, 'POST', json.encode(
    {
        username = "Log Bot",
        embeds = {
            {
                title = "Player Death",
                description = "",
                fields = compiled_table,
                color = "8190976",
            }
        },

        content = ""

    }), { ['Content-Type'] = 'application/json' })
end

function GetIdentity(id)
	local name = ""
	TriggerEvent("core:getname", id, function(_name) 
        if _name then
            name = _name
        end
	end)
	return name
end

function GetCharacter(id)
    local tbl = {}
    TriggerEvent("core:getuser", id, function(_Character, _User)
        if _Character then tbl.Character = _Character end
        if _User then tbl.User = _User end
    end)
    if not tbl.Character or not tbl.User then
        tbl = nil
    end
    return tbl 
end

function getID(type, source)
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" and (type == "steam" or type == 1) then
            return v
        elseif string.sub(tostring(v), 1, string.len("license:")) == "license:" and (type == "license" or type == 2) then
            return v
        elseif string.sub(tostring(v), 1, string.len("ip:")) == "ip:" and (type == "ip" or type == 3) then
            return v
        end
    end
    return nil
end

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
    ["WEAPON_MINISMG"] = "Micro SMG",
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
--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]

user_weapons = {}
server_weapons = {}
ammu_nation = {
	normal = {
	    {name="Ammunation", colour=1, sprite=110, x= -1117.81, y= 2698.16, z= 18.55},
	    {name="Ammunation", colour=1, sprite=110, x= 1693.93, y= 3759.73, z= 34.7},
	    {name="Ammunation", colour=1, sprite=110, x= 251.85, y= -49.87, z= 69.94},
	    {name="Ammunation", colour=1, sprite=110, x= -1306.17, y= -394.16, z= 36.69},
	    {name="Ammunation", colour=1, sprite=110, x= -662.22, y= -935.71, z= 21.82},
	    {name="Ammunation", colour=1, sprite=110, x= -330.00, y= 6083.41, z= 31.45},
	    {name="Ammunation", colour=1, sprite=110, x= 2567.91, y= 294.74, z= 108.73},
	    {name="Ammunation", colour=1, sprite=110, x= -3171.67, y= 1087.66, z= 20.83},
	    {name="Ammunation", colour=1, sprite=110, x= 842.40, y= -1033.12, z= 28.19},
	    {name="Ammunation", colour=1, sprite=110, x= 21.70, y= -1107.41, z= 29.79},
	    {name="Ammunation", colour=1, sprite=110, x= 810.15, y= -2156.88, z= 29.61},
	},
	blackmarket = {
		{name="Black Market", colour=4, id=110, x = 1009.8732299805, y = -2869.1584472656, z = 11.260106086731, Gang = "ballers"}, -- Ballers
		{name="Black Market", colour=4, id=110, x = 1248.4548339844, y = -3034.0766601563, z = 9.3649196624756, Gang = "italian"}, -- Italians
		{name="Black Market", colour=4, id=110, x = 470.47378540039, y = -2912.8369140625, z = 6.7312407493591, Gang = "russian"}, -- Russians
	},
	license = {
		{name="Gun License", colour=5, id=434, x=437.24404907227, y=-994.11242675781, z=30.68959236145},
	},
}
Weapons = {
	{Category = "Pistols", License = true, Items = {
		{Weapon = "WEAPON_PISTOL", Name = "Pistol", Cost = 550},
		{Weapon = "WEAPON_COMBATPISTOL", Name = "Combat Pistol", Cost = 625},
		--{Weapon = "WEAPON_PISTOL50", Name = "Pistol .50", Cost = 1},
		--{Weapon = "WEAPON_HEAVYPISTOL", Name = "Heavy Pistol", Cost = 1},
		--{Weapon = "WEAPON_SNSPISTOL", Name = "SNS Pistol", Cost = 1500},
		--{Weapon = "WEAPON_APPISTOL", Name = "AP Pistol", Cost = 1},
		{Weapon = "WEAPON_VINTAGEPISTOL", Name = "Vintage Pistol", Cost = 1050},
		--{Weapon = "WEAPON_REVOLVER", Name = "Revolver", Cost = 1},
		--{Weapon = "WEAPON_MARKSMANPISTOL", Name = "Marksman Pistol", Cost = 1},
		--{Weapon = "WEAPON_FLAREGUN", Name = "Flaregun", Cost = 1},
		{Weapon = "WEAPON_STUNGUN", Name = "Stungun", Cost =300},
	}},
	--[[
	{Category = "Submachine guns", Items = {
		--{Weapon = "WEAPON_MINISMG", Name = "Mini SMG", Cost = 1},
		--{Weapon = "WEAPON_MACHINEPISTOL", Name = "Machine Pistol", Cost = 1},
		--{Weapon = "WEAPON_COMBATPDW", Name = "Combat PDW", Cost = 1},
		--{Weapon = "WEAPON_MICROSMG", Name = "Micro SMG", Cost = 1},
		--{Weapon = "WEAPON_SMG", Name = "MP5", Cost = 1},
		--{Weapon = "WEAPON_ASSAULTSMG", Name = "Assault SMG", Cost = 1},
		--{Weapon = "WEAPON_GUSENBERG", Name = "Gusenberg Sweeper", Cost = 1},
		--{Weapon = "WEAPON_COMBATMG", Name = "Combat MG", Cost = 1},
		--{Weapon = "WEAPON_MG", Name = "MG", Cost = 1},
	}},
	{Category = "Assault Rifles", Items = {
		{Weapon = "WEAPON_COMPACTRIFLE", Name = "Compact Rifle", Cost = 1},
		{Weapon = "WEAPON_ADVANCEDRIFLE", Name = "Advanced Rifle", Cost = 1},
		{Weapon = "WEAPON_ASSAULTRIFLE", Name = "Assault Rifle", Cost = 1},
		{Weapon = "WEAPON_BULLPUPRIFLE", Name = "Bullpup Rifle", Cost = 1},
		{Weapon = "WEAPON_CARBINERIFLE", Name = "Carbine Rifle", Cost = 1},
		{Weapon = "WEAPON_SPECIALCARBINE", Name = "Special Carbine", Cost = 1},
	}},
	{Category = "Snipers", Items = {
		{Weapon = "WEAPON_SNIPERRIFLE", Name = "Sniper Rifle", Cost = 1},
		{Weapon = "WEAPON_HEAVYSNIPER", Name = "Heavy Sniper", Cost = 1},
		{Weapon = "WEAPON_MARKSMANRIFLE", Name = "Marksman Rifle", Cost = 1},
	}},
	--]]
	{Category = "Melee", License = false, Items = {
		{Weapon = "WEAPON_KNIFE", Name = "Knife", Cost = 65},
		{Weapon = "WEAPON_FLASHLIGHT", Name = "Flashlight", Cost = 20},
		--{Weapon = "WEAPON_NIGHTSTICK", Name = "Nightstick", Cost = 100},
		{Weapon = "WEAPON_HAMMER", Name = "Hammer", Cost = 50},
		{Weapon = "WEAPON_BAT", Name = "Baseball Bat", Cost = 100},
		{Weapon = "WEAPON_GOLFCLUB", Name = "Golfclub", Cost = 150},
		{Weapon = "WEAPON_CROWBAR", Name = "Crowbar", Cost = 100},
		{Weapon = "WEAPON_BOTTLE", Name = "Smashed Bottle", Cost = 50},
		{Weapon = "WEAPON_DAGGER", Name = "Dagger", Cost = 50},
		--{Weapon = "WEAPON_KNUCKLE", Name = "Knuckle Dusters", Cost = 500},
		{Weapon = "WEAPON_HATCHET", Name = "Hatchet", Cost = 70},
		{Weapon = "WEAPON_MACHETE", Name = "Machete", Cost = 140},
		{Weapon = "WEAPON_SWITCHBLADE", Name = "Switchblade", Cost = 150},
		{Weapon = "WEAPON_BATTLEAXE", Name = "Battleaxe", Cost = 300},
		{Weapon = "WEAPON_POOLCUE", Name = "Poolcue", Cost = 50},
		{Weapon = "WEAPON_WRENCH", Name = "Wrench", Cost = 30},
	}},
	{Category = "Shotguns", License = true, Items = {
		--{Weapon = "WEAPON_SAWNOFFSHOTGUN", Name = "Sawed-Off Shotgun", Cost = 1},
		{Weapon = "WEAPON_DBSHOTGUN", Name = "Double Barrel Shotgun", Cost = 1700},
		--{Weapon = "WEAPON_AUTOSHOTGUN", Name = "Sweeper Shotgun", Cost = 1},
		--{Weapon = "WEAPON_PUMPSHOTGUN", Name = "Pump Shotgun", Cost = 3250},
		--{Weapon = "WEAPON_ASSAULTSHOTGUN", Name = "Assault Shotgun", Cost = 1},
		--{Weapon = "WEAPON_BULLPUPSHOTGUN", Name = "Bullpup Shotgun", Cost = 1},
		--{Weapon = "WEAPON_HEAVYSHOTGUN", Name = "Heavy Shotgun", Cost = 1},
		--{Weapon = "WEAPON_MUSKET", Name = "Musket", Cost = 1},
	}},
	--[[
	{Category = "Launchers", Items = {
		{Weapon = "WEAPON_GRENADELAUNCHER", Name = "Grenade Launcher", Cost = 1},
		{Weapon = "WEAPON_COMPACTLAUNCHER", Name = "Compact Launcher", Cost = 1},
		{Weapon = "WEAPON_RAILGUN", Name = "Railgun", Cost = 1},
		{Weapon = "WEAPON_HOMINGLAUNCHER", Name = "Homing Launcher", Cost = 1},
		{Weapon = "WEAPON_MINIGUN", Name = "Minigun", Cost = 1},
		{Weapon = "WEAPON_RPG", Name = "RPG", Cost = 1},
		{Weapon = "WEAPON_FIREWORK", Name = "Firework Launcher", Cost = 1},
	}},
	--]]
	{Category = "Throwables", License = false, Items = {
		--{Weapon = "WEAPON_BZGAS", Name = "BZ Gas", Cost = 1},
		--{Weapon = "WEAPON_MOLOTOV", Name = "Molotov", Cost = 1},
		--{Weapon = "WEAPON_SMOKEGRENADE", Name = "Tear Gas", Cost = 1},
		--{Weapon = "WEAPON_STICKYBOMB", Name = "Sticky Bomb", Cost = 1},
		--{Weapon = "WEAPON_GRENADE", Name = "Grenade", Cost = 1},
		{Weapon = "WEAPON_BALL", Name = "Ball", Cost = 50},
		--{Weapon = "WEAPON_FLARE", Name = "Flare", Cost = 1},
		--{Weapon = "WEAPON_PROXMINE", Name = "Proximity Mine", Cost = 1},
		--{Weapon = "WEAPON_PIPEBOMB", Name = "Pipe Bomb", Cost = 1},
		{Weapon = "WEAPON_PETROLCAN", Name = "Petrol Can", Cost = 100},
		--{Weapon = "WEAPON_SNOWBALL", Name = "Snow Ball", Cost = 50},
	}},
	--[[
	{Category = "Specials", Items = {
		{Weapon = "WEAPON_DIGISCANNER", Name = "Digi-Scanner", Cost = 1},
		{Weapon = "WEAPON_REMOTESNIPER", Name = "Remote Sniper", Cost = 1},
	}},
	--]]
	{Category = "Gadgets", License = false, Items = {
		{Weapon = "GADGET_PARACHUTE", Name = "Parachute", Cost = 500},
	}},
}

Blackmarket_Weapons = {
	{Category = "Pistols", Items = {
		{Weapon = "WEAPON_PISTOL", Name = "Pistol", Cost = 550, AmmoType = "9mm", Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_COMBATPISTOL", Name = "Combat Pistol", Cost = 625, AmmoType = ".45mm", Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_PISTOL50", Name = "Pistol .50", Cost = 900, AmmoType = ".50mm", Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_HEAVYPISTOL", Name = "Heavy Pistol", Cost = 700, AmmoType = ".45mm", Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_SNSPISTOL", Name = "SNS Pistol", Cost = 700, AmmoType = ".45mm", Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_APPISTOL", Name = "AP Pistol", Cost = 1250, AmmoType = "9mm", Gang = "russian", SecondaryGang = "none"},
		{Weapon = "WEAPON_VINTAGEPISTOL", Name = "Vintage Pistol", Cost = 700, AmmoType = "9mm", Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_REVOLVER", Name = "Revolver", Cost = 800, AmmoType = ".44mm", Gang = "all", SecondaryGang = "none"},
	}},
	{Category = "Submachine guns", Items = {
		{Weapon = "WEAPON_MINISMG", Name = "Mini SMG", Cost = 1000, AmmoType = "9mm", Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_MACHINEPISTOL", Name = "Machine Pistol", Cost = 1050, AmmoType = "9mm", Gang = "ballers", SecondaryGang = "russian"},
		{Weapon = "WEAPON_COMBATPDW", Name = "Combat PDW", Cost = 2000, AmmoType = "5.56mm", Gang = "italian", SecondaryGang = "none"},
		{Weapon = "WEAPON_MICROSMG", Name = "Micro SMG", Cost = 1750, AmmoType = ".45mm", Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_SMG", Name = "MP5", Cost = 2150, AmmoType = "5.56mm", Gang = "italian", SecondaryGang = "none"},
		{Weapon = "WEAPON_ASSAULTSMG", Name = "Assault SMG", Cost = 2150, AmmoType = "5.56mm", Gang = "none", SecondaryGang = "none"},
		{Weapon = "WEAPON_GUSENBERG", Name = "Gusenberg Sweeper", Cost = 2500, AmmoType = ".45mm", Gang = "italian", SecondaryGang = "none"},
		{Weapon = "WEAPON_MG", Name = "MG", Cost = 5000, AmmoType = "7.62mm", Gang = "italian", SecondaryGang = "none"},
	}},
	{Category = "Assault Rifles", Items = {
		{Weapon = "WEAPON_COMPACTRIFLE", Name = "Compact Rifle", Cost = 2250, AmmoType = "7.62mm", Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_ADVANCEDRIFLE", Name = "Advanced Rifle", Cost = 2250, AmmoType = "5.56mm", Gang = "russian", SecondaryGang = "none"},
		{Weapon = "WEAPON_ASSAULTRIFLE", Name = "Assault Rifle", Cost = 3000, AmmoType = "7.62mm", Gang = "russian", SecondaryGang = "none"},
		{Weapon = "WEAPON_BULLPUPRIFLE", Name = "Bullpup Rifle", Cost = 4000, AmmoType = "5.56mm", Gang = "italian", SecondaryGang = "none"},
	}},
	{Category = "Snipers", Items = {
		{Weapon = "WEAPON_SNIPERRIFLE", Name = "Sniper Rifle", Cost = 50000, AmmoType = "7.62mm", Gang = "russian", SecondaryGang = "none"},
		{Weapon = "WEAPON_MARKSMANRIFLE", Name = "Marksman Rifle", Cost = 50000, AmmoType = "7.62mm", Gang = "italian", SecondaryGang = "russian"},
	}},
	{Category = "Melee", Items = {
		{Weapon = "WEAPON_KNIFE", Name = "Knife", Cost = 50, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_FLASHLIGHT", Name = "Flashlight", Cost = 10, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_NIGHTSTICK", Name = "Nightstick", Cost = 10, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_HAMMER", Name = "Hammer", Cost = 10, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_BAT", Name = "Baseball Bat", Cost = 10, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_GOLFCLUB", Name = "Golfclub", Cost = 10, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_CROWBAR", Name = "Crowbar", Cost = 10, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_BOTTLE", Name = "Smashed Bottle", Cost = 10, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_DAGGER", Name = "Dagger", Cost = 10, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_KNUCKLE", Name = "Knuckle Dusters", Cost = 150, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_HATCHET", Name = "Hatchet", Cost = 25, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_MACHETE", Name = "Machete", Cost = 25, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_SWITCHBLADE", Name = "Switchblade", Cost = 50, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_BATTLEAXE", Name = "Battleaxe", Cost = 150, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_POOLCUE", Name = "Poolcue", Cost = 10, Gang = "all", SecondaryGang = "none"},
		{Weapon = "WEAPON_WRENCH", Name = "Wrench", Cost = 10, Gang = "all", SecondaryGang = "none"},
	}},
	{Category = "Shotguns", Items = {
		{Weapon = "WEAPON_SAWNOFFSHOTGUN", Name = "Sawed-Off Shotgun", Cost = 1200, AmmoType = "12g", Gang = "ballers", SecondaryGang = "none"},
		{Weapon = "WEAPON_DBSHOTGUN", Name = "Double Barrel Shotgun", Cost = 1300, AmmoType = "12g", Gang = "ballers", SecondaryGang = "italian"},
		{Weapon = "WEAPON_PUMPSHOTGUN", Name = "Pump Shotgun", Cost = 1500, AmmoType = "12g", Gang = "italian", SecondaryGang = "russian"},
		{Weapon = "WEAPON_BULLPUPSHOTGUN", Name = "Bullpup Shotgun", Cost = 1750, AmmoType = "11g", Gang = "italian", SecondaryGang = "none"},
		{Weapon = "WEAPON_HEAVYSHOTGUN", Name = "Heavy Shotgun", Cost = 2250, AmmoType = "12g", Gang = "italian", SecondaryGang = "none"},
	}},
	{Category = "Illegal", Items = {
        {Name = "Lockpick", Id=36, Cost = 25, Max = 10, Gang = "all", SecondaryGang = "none"},
        {Name = "Hotwire kit", Id=46, Cost = 50, Max = 5, Gang = "all", SecondaryGang = "none"},
        {Name = "Body Armor", Id=39, Cost = 300, Max = 51, Gang = "all", SecondaryGang = "none"},
        {Name = "Ammo Box | 9mm", Id=83, Cost = 250, Max = 51, Gang = "all", SecondaryGang = "none"},
        {Name = "Ammo Box | .45mm", Id=84, Cost = 250, Max = 51, Gang = "all", SecondaryGang = "none"},
        {Name = "Ammo Box | .50mm", Id=85, Cost = 250, Max = 51, Gang = "all", SecondaryGang = "none"},
        {Name = "Ammo Box | 5.56mm", Id=86, Cost = 360, Max = 51, Gang = "all", SecondaryGang = "none"},
        {Name = "Ammo Box | 7.62mm", Id=87, Cost = 360, Max = 51, Gang = "all", SecondaryGang = "none"},
        {Name = "Ammo Box | .44mm", Id=88, Cost = 250, Max = 51, Gang = "all", SecondaryGang = "none"},
        {Name = "Ammo Box | 12g", Id=89, Cost = 360, Max = 51, Gang = "all", SecondaryGang = "none"},
        {Name = "Ammo Box | 11g", Id=90, Cost = 360, Max = 51, Gang = "all", SecondaryGang = "none"},

    }},
	{Category = "Throwables", Items = {
		{Weapon = "WEAPON_MOLOTOV", Name = "Molotov", Cost = 150, Gang = "all", SecondaryGang = "none"},
	}},
}

Public_Blackmarket_Weapons = {
	{Category = "Pistols", Items = {
		{Weapon = "WEAPON_PISTOL", Name = "Pistol", Cost = 550},
		{Weapon = "WEAPON_COMBATPISTOL", Name = "Combat Pistol", Cost = 625},
		{Weapon = "WEAPON_VINTAGEPISTOL", Name = "Vintage Pistol", Cost = 1050},
		{Weapon = "WEAPON_STUNGUN", Name = "Stungun", Cost =300},
	}},
	{Category = "Melee", Items = {
		{Weapon = "WEAPON_KNIFE", Name = "Knife", Cost = 65},
		{Weapon = "WEAPON_FLASHLIGHT", Name = "Flashlight", Cost = 20},
		{Weapon = "WEAPON_HAMMER", Name = "Hammer", Cost = 50},
		{Weapon = "WEAPON_BAT", Name = "Baseball Bat", Cost = 100},
		{Weapon = "WEAPON_GOLFCLUB", Name = "Golfclub", Cost = 150},
		{Weapon = "WEAPON_CROWBAR", Name = "Crowbar", Cost = 100},
		{Weapon = "WEAPON_BOTTLE", Name = "Smashed Bottle", Cost = 50},
		{Weapon = "WEAPON_DAGGER", Name = "Dagger", Cost = 50},
		{Weapon = "WEAPON_HATCHET", Name = "Hatchet", Cost = 70},
		{Weapon = "WEAPON_MACHETE", Name = "Machete", Cost = 140},
		{Weapon = "WEAPON_SWITCHBLADE", Name = "Switchblade", Cost = 150},
		{Weapon = "WEAPON_BATTLEAXE", Name = "Battleaxe", Cost = 300},
		{Weapon = "WEAPON_POOLCUE", Name = "Poolcue", Cost = 50},
		{Weapon = "WEAPON_WRENCH", Name = "Wrench", Cost = 30},
	}},
	{Category = "Shotguns", Items = {
		{Weapon = "WEAPON_DBSHOTGUN", Name = "Double Barrel Shotgun", Cost = 1700},
	}},
	{Category = "Gadgets", Items = {
		{Weapon = "GADGET_PARACHUTE", Name = "Parachute", Cost = 500},
	}},
}

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

Attachments = {
	["WEAPON_PISTOL"] = {},
	["WEAPON_COMBATPISTOL"] = {},
	["WEAPON_PISTOL50"] = {},
	["WEAPON_HEAVYPISTOL"] = {},
	["WEAPON_SNSPISTOL"] = {},
	["WEAPON_APPISTOL"] = {},
	["WEAPON_VINTAGEPISTOL"] = {},
	["WEAPON_REVOLVER"] = {},
	["WEAPON_MARKSMANPISTOL"] = {},
	["WEAPON_FLAREGUN"] = {},
	["WEAPON_STUNGUN"] = {},

	["WEAPON_MINISMG"] = {},
	["WEAPON_MACHINEPISTOL"] = {},
	["WEAPON_COMBATPDW"] = {},
	["WEAPON_MICROSMG"] = {},
	["WEAPON_SMG"] = {},
	["WEAPON_ASSAULTSMG"] = {},
	["WEAPON_GUSENBERG"] = {},
	["WEAPON_COMBATMG"] = {},
	["WEAPON_MG"] = {},

	["WEAPON_COMPACTRIFLE"] = {},
	["WEAPON_ADVANCEDRIFLE"] = {},
	["WEAPON_ASSAULTRIFLE"] = {},
	["WEAPON_BULLPUPRIFLE"] = {},
	["WEAPON_CARBINERIFLE"] = {},
	["WEAPON_SPECIALCARBINE"] = {},

	["WEAPON_SNIPERRIFLE"] = {},
	["WEAPON_HEAVYSNIPER"] = {},
	["WEAPON_MARKSMANRIFLE"] = {},

	["WEAPON_KNIFE"] = {},
	["WEAPON_FLASHLIGHT"] = {},
	["WEAPON_NIGHTSTICK"] = {},
	["WEAPON_HAMMER"] = {},
	["WEAPON_BAT"] = {},
	["WEAPON_GOLFCLUB"] = {},
	["WEAPON_CROWBAR"] = {},
	["WEAPON_BOTTLE"] = {},
	["WEAPON_DAGGER"] = {},
	["WEAPON_KNUCKLE"] = {},
	["WEAPON_HATCHET"] = {},
	["WEAPON_MACHETE"] = {},
	["WEAPON_SWITCHBLADE"] = {},
	["WEAPON_BATTLEAXE"] = {},
	["WEAPON_POOLCUE"] = {},
	["WEAPON_WRENCH"] = {},

	["WEAPON_SAWNOFFSHOTGUN"] = {},
	["WEAPON_DBSHOTGUN"] = {},
	["WEAPON_AUTOSHOTGUN"] = {},
	["WEAPON_PUMPSHOTGUN"] = {},
	["WEAPON_ASSAULTSHOTGUN"] = {},
	["WEAPON_BULLPUPSHOTGUN"] = {},
	["WEAPON_HEAVYSHOTGUN"] = {},
	["WEAPON_MUSKET"] = {},

	["WEAPON_GRENADELAUNCHER"] = {},
	["WEAPON_COMPACTLAUNCHER"] = {},
	["WEAPON_RAILGUN"] = {},
	["WEAPON_HOMINGLAUNCHER"] = {},
	["WEAPON_MINIGUN"] = {},
	["WEAPON_RPG"] = {},
	["WEAPON_FIREWORK"] = {},

	["WEAPON_BZGAS"] = {},
	["WEAPON_MOLOTOV"] = {},
	["WEAPON_SMOKEGRENADE"] = {},
	["WEAPON_STICKYBOMB"] = {},
	["WEAPON_GRENADE"] = {},
	["WEAPON_BALL"] = {},
	["WEAPON_FLARE"] = {},
	["WEAPON_PROXMINE"] = {},
	["WEAPON_PIPEBOMB"] = {},
	["WEAPON_PETROLCAN"] = {},
	["WEAPON_SNOWBALL"] = {},

	["WEAPON_DIGISCANNER"] = {},
	["WEAPON_REMOTESNIPER"] = {},

}
Attachments_Cost = {
    ["Suppressor"] = math.random(100, 200),
    ["Flashlight"] = math.random(300, 872),
    ["Extended clip"] = math.random(190, 217),
    ["Scope"] = math.random(100, 147),
    ["Grip"] = math.random(300, 864),
    ["Advanced Scope"] = math.random(250, 317),
    ["Yusuf Amir Luxury Finish"] = math.random(300, 400),
    ["Platinum Pearl Deluxe Finish"] = math.random(300, 400),
    ["Etched Wood Grip Finish"] = math.random(100, 200),
    ["Gilded Gun Metal Finish"] = math.random(200, 300),
    ["Eteched Gun Metal Finish"] = math.random(200, 300),
    ["Bodyguard Variant"] = math.random(100, 160),
    ["VIP Variant"] = math.random(300, 400),
    ["Black tint"] = math.random(100, 200),
    ["Army tint"] = math.random(100, 200),
    ["Green tint"] = math.random(100, 200),
    ["Orange tint"] = math.random(100, 200),
    ["LSPD tint"] = math.random(100, 200),
    ["Pink tint"] = math.random(100, 200),
    ["Gold tint"] = math.random(300, 400),
    ["Platinum tint"] = math.random(300, 400),
    ["Base Model"] = math.random(50, 100),
    ["The Pimp"] = math.random(500, 800),
    ["The Ballas"] = math.random(500, 800),
    ["The Hustler"] = math.random(500, 800),
    ["The Rock"] = math.random(500, 800),
    ["The Hater"] = math.random(500, 800),
    ["The Lover"] = math.random(500, 800),
    ["The Player"] = math.random(500, 800),
    ["The King"] = math.random(500, 800),
    ["The Vagos"] = math.random(500, 800),
    ["No tint"] = math.random(1000, 2000),
    ["Rainbow tint"] = math.random(1000, 2000),
    ["Red tint"] = math.random(1000, 2000),
    ["Seaside Stripes tint"] = math.random(1000, 2000),
    ["Widow Maker tint"] = math.random(1000, 2000),
    ["Patriot tint"] = math.random(1000, 2000),
    ["Blue tint"] = math.random(1000, 2000),
    ["Hornet tint"] = math.random(1000, 2000),
    ["Air force tint"] = math.random(1000, 2000),
    ["Desert tint"] = math.random(1000, 2000),
    ["Shadow tint"] = math.random(1000, 2000),
    ["High Altitude tint"] = math.random(1000, 2000),
    ["Airborne tint"] = math.random(1000, 2000),
    ["Sunrise tint"] = math.random(1000, 2000),
}
Tints = {
	{Name = "Black tint", Index = 0, Cost = Attachments_Cost["Black tint"]},
	{Name = "Army tint", Index = 4, Cost = Attachments_Cost["Army tint"]},
	{Name = "Green tint", Index = 1, Cost = Attachments_Cost["Green tint"]},
	{Name = "Orange tint", Index = 6, Cost = Attachments_Cost["Orange tint"]},
	{Name = "LSPD tint", Index = 5, Cost = Attachments_Cost["LSPD tint"]},
	{Name = "Pink tint", Index = 3, Cost = Attachments_Cost["Pink tint"]},
	{Name = "Gold tint", Index = 2, Cost = Attachments_Cost["Gold tint"]},
	{Name = "Platinum tint", Index = 7, Cost = Attachments_Cost["Platinum tint"]},
}
ParachuteTints = {
	{Name = "No tint", Index = -1, Cost = Attachments_Cost["No tint"]},
	{Name = "Rainbow tint", Index = 0, Cost = Attachments_Cost["Rainbow tint"]},
	{Name = "Red tint", Index = 1, Cost = Attachments_Cost["Red tint"]},
	{Name = "Seaside Stripes tint", Index = 2, Cost = Attachments_Cost["Seaside Stripes tint"]},
	{Name = "Widow Maker tint", Index = 3, Cost = Attachments_Cost["Widow Maker tint"]},
	{Name = "Patriot tint", Index = 4, Cost = Attachments_Cost["Patriot tint"]},
	{Name = "Blue tint", Index = 5, Cost = Attachments_Cost["Blue tint"]},
	{Name = "Black tint", Index = 6, Cost = Attachments_Cost["Black tint"]},
	{Name = "Hornet tint", Index = 7, Cost = Attachments_Cost["Hornet tint"]},
	{Name = "Air Force tint", Index = 8, Cost = Attachments_Cost["Air force tint"]},
	{Name = "Desert tint", Index = 9, Cost = Attachments_Cost["Desert tint"]},
	{Name = "Shadow tint", Index = 10, Cost = Attachments_Cost["Shadow tint"]},
	{Name = "High Altitude tint", Index = 11, Cost = Attachments_Cost["High Altitude tint"]},
	{Name = "Airborne tint", Index = 12, Cost = Attachments_Cost["Airborne tint"]},
	{Name = "Sunrise tint", Index = 13, Cost = Attachments_Cost["Sunrise tint"]},
}
Ammo = {
	["WEAPON_PISTOL"] = {Name = "Rounds x ", Amount = 24, Cost = 40, Max = 150},
	["WEAPON_COMBATPISTOL"] = {Name = "Rounds x ", Amount = 24, Cost = 40, Max = 150},
	["WEAPON_PISTOL50"] = {Name = "Rounds x ", Amount = 24, Cost = 40, Max = 150},
	["WEAPON_HEAVYPISTOL"] = {Name = "Rounds x ", Amount = 24, Cost = 40, Max = 150},
	["WEAPON_SNSPISTOL"] = {Name = "Rounds x ", Amount = 24, Cost = 40, Max = 150},
	["WEAPON_APPISTOL"] = {Name = "Rounds x ", Amount = 32, Cost = 45, Max = 150},
	["WEAPON_VINTAGEPISTOL"] = {Name = "Rounds x ", Amount = 24, Cost = 40, Max = 150},
	["WEAPON_REVOLVER"] = {Name = "Rounds x ", Amount = 24, Cost = 60, Max = 150},
	["WEAPON_MARKSMANPISTOL"] = {Name = "Rounds x ", Amount = 24, Cost = 100, Max = 150},
	["WEAPON_FLAREGUN"] = {Name = "Rounds x ", Amount = 20, Cost = 100, Max = 20},

	["WEAPON_MINISMG"] = {Name = "Rounds x ", Amount = 32, Cost = 60, Max = 150},
	["WEAPON_MACHINEPISTOL"] = {Name = "Rounds x ", Amount = 32, Cost = 60, Max = 150},
	["WEAPON_COMBATPDW"] = {Name = "Rounds x ", Amount = 60, Cost = 120, Max = 150},
	["WEAPON_MICROSMG"] = {Name = "Rounds x ", Amount = 32, Cost = 60, Max = 150},
	["WEAPON_SMG"] = {Name = "Rounds x ", Amount = 60, Cost = 120, Max = 150},
	["WEAPON_ASSAULTSMG"] = {Name = "Rounds x ", Amount = 60, Cost = 120, Max = 150},
	["WEAPON_GUSENBERG"] = {Name = "Rounds x ", Amount = 60, Cost = 120, Max = 150},
	["WEAPON_COMBATMG"] = {Name = "Rounds x ", Amount = 80, Cost = 180, Max = 150},
	["WEAPON_MG"] = {Name = "Rounds x ", Amount = 80, Cost = 180, Max = 150},

	["WEAPON_COMPACTRIFLE"] = {Name = "Rounds x ", Amount = 60, Cost = 140, Max = 250},
	["WEAPON_ADVANCEDRIFLE"] = {Name = "Rounds x ", Amount = 60, Cost = 140, Max = 250},
	["WEAPON_ASSAULTRIFLE"] = {Name = "Rounds x ", Amount = 60, Cost = 140, Max = 250},
	["WEAPON_BULLPUPRIFLE"] = {Name = "Rounds x ", Amount = 60, Cost = 140, Max = 250},
	["WEAPON_CARBINERIFLE"] = {Name = "Rounds x ", Amount = 60, Cost = 140, Max = 250},
	["WEAPON_SPECIALCARBINE"] = {Name = "Rounds x ", Amount = 60, Cost = 140, Max = 250},

	["WEAPON_SNIPERRIFLE"] = {Name = "Rounds x ", Amount = 12, Cost = 140, Max = 250},
	["WEAPON_HEAVYSNIPER"] = {Name = "Rounds x ", Amount = 12, Cost = 140, Max = 250},
	["WEAPON_MARKSMANRIFLE"] = {Name = "Rounds x ", Amount = 12, Cost = 140, Max = 250},

	["WEAPON_SAWNOFFSHOTGUN"] = {Name = "Cartridges x ", Amount = 16, Cost = 30, Max = 150},
	["WEAPON_DBSHOTGUN"] = {Name = "Cartridges x ", Amount = 16, Cost = 30, Max = 150},
	["WEAPON_AUTOSHOTGUN"] = {Name = "Cartridges x ", Amount = 16, Cost = 30, Max = 150},
	["WEAPON_PUMPSHOTGUN"] = {Name = "Cartridges x ", Amount = 16, Cost = 30, Max = 150},
	["WEAPON_ASSAULTSHOTGUN"] = {Name = "Cartridges x ", Amount = 16, Cost = 30, Max = 150},
	["WEAPON_BULLPUPSHOTGUN"] = {Name = "Cartridges x ", Amount = 16, Cost = 30, Max = 150},
	["WEAPON_HEAVYSHOTGUN"] = {Name = "Cartridges x ", Amount = 16, Cost = 30, Max = 150},
	["WEAPON_MUSKET"] = {Name = "Rounds x ", Amount = 10, Cost = 30, Max = 150},

	["WEAPON_GRENADELAUNCHER"] = {Name = "Grenades x ", Amount = 10, Cost = 300, Max = 20},
	["WEAPON_COMPACTLAUNCHER"] = {Name = "Grenades x ", Amount = 10, Cost = 300, Max = 20},
	["WEAPON_RAILGUN"] = {Name = "Rounds x ", Amount = 10, Cost = 900, Max = 20},
	["WEAPON_HOMINGLAUNCHER"] = {Name = "Rockets x ", Amount = 1, Cost = 300, Max = 10},
	["WEAPON_MINIGUN"] = {Name = "Rounds x ", Amount = 20, Cost = 50, Max = 200},
	["WEAPON_RPG"] = {Name = "Rockets x ", Amount = 1, Cost = 300, Max = 20},
	["WEAPON_FIREWORK"] = {Name = "Rockets x ", Amount = 1, Cost = 100, Max = 20},

	["WEAPON_BZGAS"] = {Name = "Gas x ", Amount = 1, Cost = 40, Max = 25},
	["WEAPON_MOLOTOV"] = {Name = "Molotov x ", Amount = 1, Cost = 40, Max = 25},
	["WEAPON_SMOKEGRENADE"] = {Name = "Gas x ", Amount = 1, Cost = 40, Max = 25},
	["WEAPON_STICKYBOMB"] = {Name = "Stickybomb x ", Amount = 1, Cost = 100, Max = 25},
	["WEAPON_GRENADE"] = {Name = "Grenade x ", Amount = 1, Cost = 30, Max = 25},
	["WEAPON_BALL"] = {Name = "Ball x ", Amount = 1, Cost = 10, Max = 1},
	["WEAPON_FLARE"] = {Name = "Flare x ", Amount = 1, Cost = 10, Max = 25},
	["WEAPON_PROXMINE"] = {Name = "Mine x ", Amount = 1, Cost = 75, Max = 5},
	["WEAPON_PIPEBOMB"] = {Name = "Bomb x ", Amount = 1, Cost = 50, Max = 10},
	["WEAPON_SNOWBALL"] = {Name = "Snowball x ", Amount = 1, Cost = 2, Max = 10},
	["WEAPON_PETROLCAN"] = {Name = "Gas x 1ml", Amount = 45, Cost = 2, Max = 4500},

}

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function AddAttachment(Weapon, Attachment, Hash)
	Attachments[Weapon][tablelength(Attachments[Weapon])+1] = {Name = Attachment, Hash = Hash, Cost = Attachments_Cost[Attachment]}
end

AddAttachment("WEAPON_PISTOL", "Extended clip", 3978713628)
AddAttachment("WEAPON_PISTOL", "Flashlight", 899381934)
AddAttachment("WEAPON_PISTOL", "Suppressor", 1709866683)
AddAttachment("WEAPON_PISTOL", "Yusuf Amir Luxury Finish", 3610841222)

AddAttachment("WEAPON_COMBATPISTOL", "Extended clip", 3598405421)
AddAttachment("WEAPON_COMBATPISTOL", "Flashlight", 899381934)
AddAttachment("WEAPON_COMBATPISTOL", "Suppressor", 3271853210)
AddAttachment("WEAPON_COMBATPISTOL", "Yusuf Amir Luxury Finish", 3328527730)

AddAttachment("WEAPON_PISTOL50", "Extended clip", 3654528146)
AddAttachment("WEAPON_PISTOL50", "Flashlight", 899381934)
AddAttachment("WEAPON_PISTOL50", "Suppressor", 2805810788)
AddAttachment("WEAPON_PISTOL50", "Platinum Pearl Deluxe Finish", 2008591151)

AddAttachment("WEAPON_HEAVYPISTOL", "Extended clip", 1694090795)
AddAttachment("WEAPON_HEAVYPISTOL", "Flashlight", 899381934)
AddAttachment("WEAPON_HEAVYPISTOL", "Suppressor", 3271853210)
AddAttachment("WEAPON_HEAVYPISTOL", "Etched Wood Grip Finish", 2053798779)

AddAttachment("WEAPON_SNSPISTOL", "Extended clip", 2063610803)
AddAttachment("WEAPON_SNSPISTOL", "Etched Wood Grip Finish", 2150886575)

AddAttachment("WEAPON_APPISTOL", "Extended clip", 614078421)
AddAttachment("WEAPON_APPISTOL", "Flashlight", 899381934)
AddAttachment("WEAPON_APPISTOL", "Suppressor", 3271853210)
AddAttachment("WEAPON_APPISTOL", "Gilded Gun Metal Finish", 2608252716)

AddAttachment("WEAPON_VINTAGEPISTOL", "Extended clip", 867832552)
AddAttachment("WEAPON_VINTAGEPISTOL", "Suppressor", 3271853210)

AddAttachment("WEAPON_REVOLVER", "Bodyguard Variant", 384708672)
AddAttachment("WEAPON_REVOLVER", "VIP Variant", 2492708877)

AddAttachment("WEAPON_MACHINEPISTOL", "Extended clip", 3106695545)
AddAttachment("WEAPON_MACHINEPISTOL", "Suppressor", 3271853210)

AddAttachment("WEAPON_MICROSMG", "Scope", 2637152041)
AddAttachment("WEAPON_MICROSMG", "Extended clip", 283556395)
AddAttachment("WEAPON_MICROSMG", "Flashlight", 899381934)
AddAttachment("WEAPON_MICROSMG", "Suppressor", 2805810788)
AddAttachment("WEAPON_MICROSMG", "Yusuf Amir Luxury Finish", 1215999497)

AddAttachment("WEAPON_SMG", "Scope", 1019656791)
AddAttachment("WEAPON_SMG", "Extended clip", 889808635)
AddAttachment("WEAPON_SMG", "Flashlight", 2076495324)
AddAttachment("WEAPON_SMG", "Suppressor", 3271853210)
AddAttachment("WEAPON_SMG", "Yusuf Amir Luxury Finish", 663170192)

AddAttachment("WEAPON_ASSAULTSMG", "Scope", 2637152041)
AddAttachment("WEAPON_ASSAULTSMG", "Extended clip", 3141985303)
AddAttachment("WEAPON_ASSAULTSMG", "Flashlight", 2076495324)
AddAttachment("WEAPON_ASSAULTSMG", "Suppressor", 2805810788)
AddAttachment("WEAPON_ASSAULTSMG", "Yusuf Amir Luxury Finish", 663517359)

AddAttachment("WEAPON_COMBATPDW", "Scope", 2855028148)
AddAttachment("WEAPON_COMBATPDW", "Extended clip", 860508675)
AddAttachment("WEAPON_COMBATPDW", "Flashlight", 2076495324)
AddAttachment("WEAPON_COMBATPDW", "Grip", 202788691)

AddAttachment("WEAPON_MG", "Scope", 1006677997)
AddAttachment("WEAPON_MG", "Extended clip", 2182449991)
AddAttachment("WEAPON_MG", "Yusuf Amir Luxury Finish", 3604658878)

AddAttachment("WEAPON_COMBATMG", "Scope", 2698550338)
AddAttachment("WEAPON_COMBATMG", "Extended clip", 3603274966)
AddAttachment("WEAPON_COMBATMG", "Grip", 202788691)
AddAttachment("WEAPON_COMBATMG", "Eteched Gun Metal Finish", 2466172125)

AddAttachment("WEAPON_GUSENBERG", "Extended clip", 3939025520)

AddAttachment("WEAPON_ASSAULTRIFLE", "Scope", 2637152041)
AddAttachment("WEAPON_ASSAULTRIFLE", "Extended clip", 2971750299)
AddAttachment("WEAPON_ASSAULTRIFLE", "Flashlight", 2076495324)
AddAttachment("WEAPON_ASSAULTRIFLE", "Suppressor", 2805810788)
AddAttachment("WEAPON_ASSAULTRIFLE", "Grip", 202788691)
AddAttachment("WEAPON_ASSAULTRIFLE", "Yusuf Amir Luxury Finish", 1319990579)

AddAttachment("WEAPON_CARBINERIFLE", "Scope", 2698550338)
AddAttachment("WEAPON_CARBINERIFLE", "Extended clip", 2433783441)
AddAttachment("WEAPON_CARBINERIFLE", "Flashlight", 2076495324)
AddAttachment("WEAPON_CARBINERIFLE", "Suppressor", 2205435306)
AddAttachment("WEAPON_CARBINERIFLE", "Grip", 202788691)
AddAttachment("WEAPON_CARBINERIFLE", "Yusuf Amir Luxury Finish", 3634075224)

AddAttachment("WEAPON_ADVANCEDRIFLE", "Scope", 2855028148)
AddAttachment("WEAPON_ADVANCEDRIFLE", "Extended clip", 2395064697)
AddAttachment("WEAPON_ADVANCEDRIFLE", "Flashlight", 2076495324)
AddAttachment("WEAPON_ADVANCEDRIFLE", "Suppressor", 2205435306)
AddAttachment("WEAPON_ADVANCEDRIFLE", "Eteched Gun Metal Finish", 930927479)

AddAttachment("WEAPON_SPECIALCARBINE", "Scope", 2698550338)
AddAttachment("WEAPON_SPECIALCARBINE", "Extended clip", 2089537806)
AddAttachment("WEAPON_SPECIALCARBINE", "Flashlight", 2076495324)
AddAttachment("WEAPON_SPECIALCARBINE", "Suppressor", 2805810788)
AddAttachment("WEAPON_SPECIALCARBINE", "Grip", 202788691)
AddAttachment("WEAPON_SPECIALCARBINE", "Eteched Gun Metal Finish", 1929467122)

AddAttachment("WEAPON_BULLPUPRIFLE", "Scope", 2855028148)
AddAttachment("WEAPON_BULLPUPRIFLE", "Extended clip", 3009973007)
AddAttachment("WEAPON_BULLPUPRIFLE", "Flashlight", 2076495324)
AddAttachment("WEAPON_BULLPUPRIFLE", "Suppressor", 2205435306)
AddAttachment("WEAPON_BULLPUPRIFLE", "Grip", 202788691)
AddAttachment("WEAPON_BULLPUPRIFLE", "Gilded Gun Metal Finish", 2824322168)

AddAttachment("WEAPON_COMPACTRIFLE", "Extended clip", 1509923832)

AddAttachment("WEAPON_SNIPERRIFLE", "Advanced Scope", 3159677559)
AddAttachment("WEAPON_SNIPERRIFLE", "Suppressor", 2805810788)
AddAttachment("WEAPON_SNIPERRIFLE", "Etched Wood Grip Finish", 1077065191)

AddAttachment("WEAPON_HEAVYSNIPER", "Advanced Scope", 3159677559)

AddAttachment("WEAPON_MARKSMANRIFLE", "Scope", 471997210)
AddAttachment("WEAPON_MARKSMANRIFLE", "Extended clip", 3439143621)
AddAttachment("WEAPON_MARKSMANRIFLE", "Flashlight", 2076495324)
AddAttachment("WEAPON_MARKSMANRIFLE", "Suppressor", 2205435306)
AddAttachment("WEAPON_MARKSMANRIFLE", "Grip", 202788691)

AddAttachment("WEAPON_KNUCKLE", "Base Model", 4081463091)
AddAttachment("WEAPON_KNUCKLE", "The Pimp", 3323197061)
AddAttachment("WEAPON_KNUCKLE", "The Ballas", 4007263587)
AddAttachment("WEAPON_KNUCKLE", "The Hustler", 1351683121)
AddAttachment("WEAPON_KNUCKLE", "The Rock", 2539772380)
AddAttachment("WEAPON_KNUCKLE", "The Hater", 2112683568)
AddAttachment("WEAPON_KNUCKLE", "The Lover", 1062111910)
AddAttachment("WEAPON_KNUCKLE", "The Player", 146278587)
AddAttachment("WEAPON_KNUCKLE", "The King", 3800804335)
AddAttachment("WEAPON_KNUCKLE", "The Vagos", 2062808965)

AddAttachment("WEAPON_PUMPSHOTGUN", "Flashlight", 2076495324)
AddAttachment("WEAPON_PUMPSHOTGUN", "Suppressor", 3859329886)
AddAttachment("WEAPON_PUMPSHOTGUN", "Yusuf Amir Luxury Finish", 2732039643)

AddAttachment("WEAPON_BULLPUPSHOTGUN", "Flashlight", 2076495324)
AddAttachment("WEAPON_BULLPUPSHOTGUN", "Suppressor", 2805810788)
AddAttachment("WEAPON_BULLPUPSHOTGUN", "Grip", 202788691)

AddAttachment("WEAPON_ASSAULTSHOTGUN", "Extended clip", 2260565874)
AddAttachment("WEAPON_ASSAULTSHOTGUN", "Flashlight", 2076495324)
AddAttachment("WEAPON_ASSAULTSHOTGUN", "Suppressor", 2205435306)
AddAttachment("WEAPON_ASSAULTSHOTGUN", "Grip", 202788691)

AddAttachment("WEAPON_HEAVYSHOTGUN", "Extended clip", 2535257853)
AddAttachment("WEAPON_HEAVYSHOTGUN", "Flashlight", 2076495324)
AddAttachment("WEAPON_HEAVYSHOTGUN", "Suppressor", 2805810788)
AddAttachment("WEAPON_HEAVYSHOTGUN", "Grip", 202788691)

AddAttachment("WEAPON_GRENADELAUNCHER", "Scope", 2855028148)
AddAttachment("WEAPON_GRENADELAUNCHER", "Flashlight", 2076495324)
AddAttachment("WEAPON_GRENADELAUNCHER", "Grip", 202788691)

Weaponhashes = {
	[`WEAPON_PISTOL`]  = "WEAPON_PISTOL",
	[`WEAPON_PISTOL_MK2`]  = "WEAPON_PISTOL_MK2",
	[`WEAPON_COMBATPISTOL`]  = "WEAPON_COMBATPISTOL",
	[`WEAPON_PISTOL50`]  = "WEAPON_PISTOL50",
	[`WEAPON_SNSPISTOL`]  = "WEAPON_SNSPISTOL",
	[`WEAPON_SNSPISTOL_MK2`]  = "WEAPON_SNSPISTOL_MK2",
	[`WEAPON_HEAVYPISTOL`]  = "WEAPON_HEAVYPISTOL",
	[`WEAPON_VINTAGEPISTOL`]  = "WEAPON_VINTAGEPISTOL",
	[`WEAPON_MARKSMANPISTOL`]  = "WEAPON_MARKSMANPISTOL",
	[`WEAPON_REVOLVER`]  = "WEAPON_REVOLVER",
	[`WEAPON_REVOLVER_MK2`]  = "WEAPON_REVOLVER_MK2",
	[`WEAPON_DOUBLEACTION`]  = "WEAPON_DOUBLEACTION",
	[`WEAPON_APPISTOL`]  = "WEAPON_APPISTOL",
	[`WEAPON_STUNGUN`]  = "WEAPON_STUNGUN",
	[`WEAPON_FLAREGUN`]  = "WEAPON_FLAREGUN",

	[`WEAPON_MICROSMG`]  = "WEAPON_MICROSMG",
	[`WEAPON_MACHINEPISTOL`]  = "WEAPON_MACHINEPISTOL",
	[`WEAPON_MINISMG`]  = "WEAPON_MINISMG",
	[`WEAPON_SMG`]  = "WEAPON_SMG",
	[`WEAPON_SMG_MK2`]  = "WEAPON_SMG_MK2",
	[`WEAPON_ASSAULTSMG`]  = "WEAPON_ASSAULTSMG",
	[`WEAPON_COMBATPDW`]  = "WEAPON_COMBATPDW",
	[`WEAPON_MG`]  = "WEAPON_MG",
	[`WEAPON_COMBATMG`]  = "WEAPON_COMBATMG",
	[`WEAPON_COMBATMG_MK2`]  = "WEAPON_COMBATMG_MK2",
	[`WEAPON_GUSENBERG`]  = "WEAPON_GUSENBERG",

	[`WEAPON_ASSAULTRIFLE`]  = "WEAPON_ASSAULTRIFLE",
	[`WEAPON_ASSAULTRIFLE_MK2`]  = "WEAPON_ASSAULTRIFLE_MK2",
	[`WEAPON_CARBINERIFLE`]  = "WEAPON_CARBINERIFLE",
	[`WEAPON_CARBINERIFLE_MK2`]  = "WEAPON_CARBINERIFLE_MK2",
	[`WEAPON_ADVANCEDRIFLE`]  = "WEAPON_ADVANCEDRIFLE",
	[`WEAPON_SPECIALCARBINE`]  = "WEAPON_SPECIALCARBINE",
	[`WEAPON_SPECIALCARBINE_MK2`]  = "WEAPON_SPECIALCARBINE_MK2",
	[`WEAPON_BULLPUPRIFLE`]  = "WEAPON_BULLPUPRIFLE",
	[`WEAPON_BULLPUPRIFLE_MK2`]  = "WEAPON_BULLPUPRIFLE_MK2",
	[`WEAPON_COMPACTRIFLE`]  = "WEAPON_COMPACTRIFLE",

	[`WEAPON_SNIPERRIFLE`]  = "WEAPON_SNIPERRIFLE",
	[`WEAPON_HEAVYSNIPER_MK2`]  = "WEAPON_HEAVYSNIPER_MK2",
	[`WEAPON_HEAVYSNIPER`]  = "WEAPON_HEAVYSNIPER",
	[`WEAPON_MARKSMANRIFLE`]  = "WEAPON_MARKSMANRIFLE",
	[`WEAPON_MARKSMANRIFLE_MK2`]  = "WEAPON_MARKSMANRIFLE_MK2",

	[`WEAPON_UNARMED`]  = "WEAPON_UNARMED",
	[`WEAPON_KNIFE`]  = "WEAPON_KNIFE",
	[`WEAPON_NIGHTSTICK`]  = "WEAPON_NIGHTSTICK",
	[`WEAPON_HAMMER`]  = "WEAPON_HAMMER",
	[`WEAPON_BAT`]  = "WEAPON_BAT",
	[`WEAPON_CROWBAR`]  = "WEAPON_CROWBAR",
	[`WEAPON_GOLFCLUB`]  = "WEAPON_GOLFCLUB",
	[`WEAPON_BOTTLE`]  = "WEAPON_BOTTLE",
	[`WEAPON_DAGGER`]  = "WEAPON_DAGGER",
	[`WEAPON_HATCHET`]  = "WEAPON_HATCHET",
	[`WEAPON_KNUCKLE`]  = "WEAPON_KNUCKLE",
	[`WEAPON_MACHETE`]  = "WEAPON_MACHETE",
	[`WEAPON_FLASHLIGHT`]  = "WEAPON_FLASHLIGHT",
	[`WEAPON_SWITCHBLADE`]  = "WEAPON_SWITCHBLADE",
	[`WEAPON_BATTLEAXE`]  = "WEAPON_BATTLEAXE",
	[`WEAPON_POOLCUE`]  = "WEAPON_POOLCUE",
	[`WEAPON_WRENCH`]  = "WEAPON_WRENCH",

	[`WEAPON_PUMPSHOTGUN`]  = "WEAPON_PUMPSHOTGUN",
	[`WEAPON_PUMPSHOTGUN_MK2`]  = "WEAPON_PUMPSHOTGUN_MK2",
	[`WEAPON_SAWNOFFSHOTGUN`]  = "WEAPON_SAWNOFFSHOTGUN",
	[`WEAPON_BULLPUPSHOTGUN`]  = "WEAPON_BULLPUPSHOTGUN",
	[`WEAPON_ASSAULTSHOTGUN`]  = "WEAPON_ASSAULTSHOTGUN",
	[`WEAPON_HEAVYSHOTGUN`]  = "WEAPON_HEAVYSHOTGUN",
	[`WEAPON_MUSKET`]  = "WEAPON_MUSKET",
	[`WEAPON_DBSHOTGUN`]  = "WEAPON_DBSHOTGUN",
	[`WEAPON_AUTOSHOTGUN`]  = "WEAPON_AUTOSHOTGUN",

	[`WEAPON_GRENADELAUNCHER`]  = "WEAPON_GRENADELAUNCHER",
	[`WEAPON_RPG`]  = "WEAPON_RPG",
	[`WEAPON_MINIGUN`]  = "WEAPON_MINIGUN",
	[`WEAPON_FIREWORK`]  = "WEAPON_FIREWORK",
	[`WEAPON_RAILGUN`]  = "WEAPON_RAILGUN",
	[`WEAPON_HOMINGLAUNCHER`]  = "WEAPON_HOMINGLAUNCHER",
	[`WEAPON_COMPACTLAUNCHER`]  = "WEAPON_COMPACTLAUNCHER",

	[`WEAPON_GRENADE`]  = "WEAPON_GRENADE",
	[`WEAPON_STICKYBOMB`]  = "WEAPON_STICKYBOMB",
	[`WEAPON_PROXMINE`]  = "WEAPON_PROXMINE",
	[`WEAPON_PIPEBOMB`]  = "WEAPON_PIPEBOMB",
	[`WEAPON_SMOKEGRENADE`]  = "WEAPON_SMOKEGRENADE",
	[`WEAPON_BZGAS`]  = "WEAPON_BZGAS",
	[`WEAPON_MOLOTOV`]  = "WEAPON_MOLOTOV",
	[`WEAPON_FIREEXTINGUISHER`]  = "WEAPON_FIREEXTINGUISHER",
	[`WEAPON_PETROLCAN`]  = "WEAPON_PETROLCAN",
	[`WEAPON_BALL`]  = "WEAPON_BALL",
	[`WEAPON_SNOWBALL`]  = "WEAPON_SNOWBALL",
	[`WEAPON_FLARE`]  = "WEAPON_FLARE",

	[`WEAPON_REMOTESNIPER`]  = "WEAPON_REMOTESNIPER",
	[`WEAPON_DIGISCANNER`]  = "WEAPON_DIGISCANNER",
	[`WEAPON_GRENADELAUNCHER_SMOKE`]  = "WEAPON_GRENADELAUNCHER_SMOKE",
	[`WEAPON_STINGER`]  = "WEAPON_STINGER",
	[`WEAPON_ELECTRIC_FENCE`]  = "WEAPON_ELECTRIC_FENCE",

	[`WEAPON_ANIMAL`]  = "WEAPON_ANIMAL",
	[`WEAPON_COUGAR`]  = "WEAPON_COUGAR",
	[`WEAPON_PASSENGER_ROCKET`]  = "WEAPON_PASSENGER_ROCKET",
	[`WEAPON_AIRSTRIKE_ROCKET`]  = "WEAPON_AIRSTRIKE_ROCKET",
	[`WEAPON_BRIEFCASE`]  = "WEAPON_BRIEFCASE",
	[`WEAPON_BRIEFCASE_02`]  = "WEAPON_BRIEFCASE_02",
	[`WEAPON_VEHICLE_ROCKET`]  = "WEAPON_VEHICLE_ROCKET",
	[`WEAPON_BARBED_WIRE`]  = "WEAPON_BARBED_WIRE",
	[`WEAPON_DROWNING`]  = "WEAPON_DROWNING",
	[`WEAPON_DROWNING_IN_VEHICLE`]  = "WEAPON_DROWNING_IN_VEHICLE",
	[`WEAPON_BLEEDING`]  = "WEAPON_BLEEDING",
	[`WEAPON_EXPLOSION`]  = "WEAPON_EXPLOSION",
	[`WEAPON_FALL`]  = "WEAPON_FALL",
	[`WEAPON_EXHAUSTION`]  = "WEAPON_EXHAUSTION",
	[`WEAPON_HIT_BY_WATER_CANNON`]  = "WEAPON_HIT_BY_WATER_CANNON",
	[`WEAPON_RAMMED_BY_CAR`]  = "WEAPON_RAMMED_BY_CAR",
	[`WEAPON_RUN_OVER_BY_CAR`]  = "WEAPON_RUN_OVER_BY_CAR",
	[`WEAPON_HELI_CRASH`]  = "WEAPON_HELI_CRASH",
	[`WEAPON_FIRE`]  = "WEAPON_FIRE",

	[`VEHICLE_WEAPON_TANK`]  = "VEHICLE_WEAPON_TANK",
	[`VEHICLE_WEAPON_SPACE_ROCKET`]  = "VEHICLE_WEAPON_SPACE_ROCKET",
	[`VEHICLE_WEAPON_PLANE_ROCKET`]  = "VEHICLE_WEAPON_PLANE_ROCKET",
	[`VEHICLE_WEAPON_PLAYER_LASER`]  = "VEHICLE_WEAPON_PLAYER_LASER",
	[`VEHICLE_WEAPON_PLAYER_BULLET`]  = "VEHICLE_WEAPON_PLAYER_BULLET",
	[`VEHICLE_WEAPON_PLAYER_BUZZARD`]  = "VEHICLE_WEAPON_PLAYER_BUZZARD",
	[`VEHICLE_WEAPON_PLAYER_HUNTER`]  = "VEHICLE_WEAPON_PLAYER_HUNTER",
	[`VEHICLE_WEAPON_PLAYER_LAZER`]  = "VEHICLE_WEAPON_PLAYER_LAZER",
	[`VEHICLE_WEAPON_ENEMY_LASER`]  = "VEHICLE_WEAPON_ENEMY_LASER",

	[`VEHICLE_WEAPON_SEARCHLIGHT`]  = "VEHICLE_WEAPON_SEARCHLIGHT",
	[`VEHICLE_WEAPON_RADAR`]  = "VEHICLE_WEAPON_RADAR",
	[`VEHICLE_WEAPON_ROTORS`]  = "VEHICLE_WEAPON_ROTORS",

	[`GADGET_NIGHTVISION`]  = "GADGET_NIGHTVISION",
	[`GADGET_PARACHUTE`]  = "GADGET_PARACHUTE",
}

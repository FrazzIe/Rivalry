local zones = { 
	['AIRP'] = {label = "Los Santos International Airport", gunshots = 100, vehicle = 100, drugs = 100, property_lock = 80}, -- 80% chance of being reported for firing a gun, lockpicking a vehicle, selling drugs
	['ALAMO'] = {label = "Alamo Sea", gunshots = 20, vehicle = 80, drugs = 20, property_lock = 80}, 
	['ALTA'] = {label = "Alta", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ARMYB'] = {label = "Fort Zancudo", gunshots = 100, vehicle = 100, drugs = 100, property_lock = 80}, 
	['BANHAMC'] = {label = "Banham Canyon Dr", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BANNING'] = {label = "Banning", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BEACH'] = {label = "Vespucci Beach", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BHAMCA'] = {label = "Banham Canyon", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BRADP'] = {label = "Braddock Pass", gunshots = 30, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BRADT'] = {label = "Braddock Tunnel", gunshots = 30, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BURTON'] = {label = "Burton", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['CALAFB'] = {label = "Calafia Bridge", gunshots = 80, vehicle = 80, drugs = 30, property_lock = 80}, 
	['CANNY'] = {label = "Raton Canyon", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['CCREAK'] = {label = "Cassidy Creek", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['CHAMH'] = {label = "Chamberlain Hills", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['CHIL'] = {label = "Vinewood Hills", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['CHU'] = {label = "Chumash", gunshots = 80, vehicle = 80, drugs = 20, property_lock = 80}, 
	['CMSW'] = {label = "Chiliad Mountain State Wilderness", gunshots = 15, vehicle = 75, drugs = 25, property_lock = 80}, 
	['CYPRE'] = {label = "Cypress Flats", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80},
	['DAVIS'] = {label = "Davis", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['DELBE'] = {label = "Del Perro Beach", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['DELPE'] = {label = "Del Perro", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['DELSOL'] = {label = "La Puerta", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['DESRT'] = {label = "Grand Senora Desert", gunshots = 50, vehicle = 60, drugs = 20, property_lock = 80}, 
	['DOWNT'] = {label = "Downtown", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['DTVINE'] = {label = "Downtown Vinewood", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['EAST_V'] = {label = "East Vinewood", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['EBURO'] = {label = "El Burro Heights", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ELGORL'] = {label = "El Gordo Lighthouse", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ELYSIAN'] = {label = "Elysian Island", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['GALFISH'] = {label = "Galilee", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['GOLF'] = {label = "GWC and Golfing Society", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['GRAPES'] = {label = "Grapeseed", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['GREATC'] = {label = "Great Chaparral", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['HARMO'] = {label = "Harmony", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['HAWICK'] = {label = "Hawick", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['HORS'] = {label = "Vinewood Racetrack", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['HUMLAB'] = {label = "Humane Labs and Research", gunshots = 100, vehicle = 100, drugs = 100, property_lock = 80}, 
	['JAIL'] = {label = "Bolingbroke Penitentiary", gunshots = 100, vehicle = 100, drugs = 100, property_lock = 80}, 
	['KOREAT'] = {label = "Little Seoul", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LACT'] = {label = "Land Act Reservoir", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LAGO'] = {label = "Lago Zancudo", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LDAM'] = {label = "Land Act Dam", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LEGSQU'] = {label = "Legion Square", gunshots = 90, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LMESA'] = {label = "La Mesa", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LOSPUER'] = {label = "La Puerta", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['MIRR'] = {label = "Mirror Park", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['MORN'] = {label = "Morningwood", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['MOVIE'] = {label = "Richards Majestic", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['MTCHIL'] = {label = "Mount Chiliad", gunshots = 40, vehicle = 60, drugs = 30, property_lock = 80}, 
	['MTGORDO'] = {label = "Mount Gordo", gunshots = 40, vehicle = 80, drugs = 30, property_lock = 80}, 
	['MTJOSE'] = {label = "Mount Josiah", gunshots = 40, vehicle = 80, drugs = 30, property_lock = 80}, 
	['MURRI'] = {label = "Murrieta Heights", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['NCHU'] = {label = "North Chumash", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['NOOSE'] = {label = "N.O.O.S.E", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['OCEANA'] = {label = "Pacific Ocean", gunshots = 10, vehicle = 80, drugs = 10, property_lock = 80}, 
	['PALCOV'] = {label = "Paleto Cove", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['PALETO'] = {label = "Paleto Bay", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['PALFOR'] = {label = "Paleto Forest", gunshots = 50, vehicle = 80, drugs = 30, property_lock = 80}, 
	['PALHIGH'] = {label = "Palomino Highlands", gunshots = 10, vehicle = 80, drugs = 50, property_lock = 80}, 
	['PALMPOW'] = {label = "Palmer-Taylor Power Station", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['PBLUFF'] = {label = "Pacific Bluffs", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['PBOX'] = {label = "Pillbox Hill", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['PROCOB'] = {label = "Procopio Beach", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['RANCHO'] = {label = "Rancho", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['RGLEN'] = {label = "Richman Glen", gunshots = 50, vehicle = 80, drugs = 60, property_lock = 80}, 
	['RICHM'] = {label = "Richman", gunshots = 50, vehicle = 80, drugs = 60, property_lock = 80}, 
	['ROCKF'] = {label = "Rockford Hills", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['RTRAK'] = {label = "Redwood Lights Track", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['SANAND'] = {label = "San Andreas", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['SANCHIA'] = {label = "San Chianski Mountain Range", gunshots = 20, vehicle = 80, drugs = 20, property_lock = 80}, 
	['SANDY'] = {label = "Sandy Shores", gunshots = 30, vehicle = 80, drugs = 50, property_lock = 80}, 
	['SKID'] = {label = "Mission Row", gunshots = 80, vehicle = 80, drugs = 90, property_lock = 80}, 
	['SLAB'] = {label = "Stab City", gunshots = 40, vehicle = 80, drugs = 30, property_lock = 80}, 
	['STAD'] = {label = "Maze Bank Arena", gunshots = 50, vehicle = 80, drugs = 80, property_lock = 80}, 
	['STRAW'] = {label = "Strawberry", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['TATAMO'] = {label = "Tataviam Mountains", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['TERMINA'] = {label = "Terminal", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['TEXTI'] = {label = "Textile City", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['TONGVAH'] = {label = "Tongva Hills", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['TONGVAV'] = {label = "Tongva Valley", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['VCANA'] = {label = "Vespucci Canals", gunshots = 30, vehicle = 80, drugs = 50, property_lock = 80}, 
	['VESP'] = {label = "Vespucci", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['VINE'] = {label = "Vinewood", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['WINDF'] = {label = "Ron Alternates Wind Farm", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['WVINE'] = {label = "West Vinewood", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ZANCUDO'] = {label = "Zancudo River", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ZP_ORT'] = {label = "Port of South Los Santos", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ZQ_UAR'] = {label = "Davis Quartz", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80},
}

local cars = {
        {name = "Taxi", model = "taxi"},
        {name = "Tow Truck", model = "towtruck"},
        {name = "Tow Truck Mini", model = "towtruck2"},
        {name = "Taco Truck", model = "taco"},
        {name = "Tour Bus", model = "tourbus"},
        {name = "Blista", model = "blista"},
        {name = "Brioso R/A", model = "brioso"},
        {name = "Dilettante", model = "dilettante"},
        {name = "Issi", model = "issi2"},
        {name = "Panto", model = "panto"},
        {name = "Prairie", model = "prairie"},
        {name = "Rhapsody", model = "rhapsody"},
        {name = "Cognoscenti Cabrio", model = "cogcabrio"},
        {name = "Exemplar", model = "exemplar"},
        {name = "F620", model = "f620"},
        {name = "Felon", model = "felon"},
        {name = "Felon GT", model = "felon2"},
        {name = "Jackal", model = "jackal"},
        {name = "Oracle", model = "oracle"},
        {name = "Oracle XS", model = "oracle2"},
        {name = "Sentinel", model = "sentinel"},
        {name = "Sentinel XS", model = "sentinel2"},
        {name = "Windsor", model = "windsor"},
        {name = "Windsor Drop", model = "windsor2"},
        {name = "Zion", model = "zion"},
        {name = "Zion Cabrio", model = "zion2"},
        {name = "9F", model = "ninef"},
        {name = "9F Cabrio", model = "ninef2"},
        {name = "Alpha", model = "alpha"},
        {name = "Banshee", model = "banshee"},
        {name = "Banshee 900R", model = "banshee2"},
        {name = "Bestia GTS", model = "bestiagts"},
        {name = "Buffalo", model = "buffalo"},
        {name = "Buffalo S", model = "buffalo2"},
        {name = "Carbonizzare", model = "carbonizzare"},
        {name = "Coil Raiden", model = "raiden"}, --Sports
        {name = "Comet", model = "comet2"},
        {name = "Comet Retro Custom", model = "comet3"},
        {name = "Comet Safari", model = "comet4"}, --Sports
        {name = "Comet SR", model = "comet5"}, --Sports
        {name = "Coquette", model = "coquette"},
        {name = "Drift Tampa", model = "tampa2"},
        {name = "Elegy RH8", model = "elegy2"},
        {name = "Elegy Retro Custom", model = "elegy"},
        {name = "Feltzer", model = "feltzer2"},
        {name = "Furore GT", model = "furoregt"},
        {name = "Fusilade", model = "fusilade"},
        {name = "Futo", model = "futo"},
        {name = "Go Go Monkey Blista", model = "blista3"},
        {name = "Jester", model = "jester"},
        {name = "Jester Race", model = "jester2"},
        {name = "Khamelion", model = "khamelion"},
        {name = "Kuruma", model = "kuruma"},
        {name = "Lynx", model = "lynx"},
        {name = "Massacro", model = "massacro"},
        {name = "Massacro Race", model = "massacro2"},
        {name = "Neon", model = "neon"}, --Sports
        {name = "Omnis", model = "omnis"},
        {name = "Pariah", model = "pariah"}, --Sports
        {name = "Penumbra", model = "penumbra"},
        {name = "Rapid GT", model = "rapidgt"},
        {name = "Rapid GT Convertible", model = "rapidgt2"},
        {name = "Raptor", model = "raptor"},
        {name = "Revolter", model = "revolter"}, --Sports
        {name = "Ruston", model = "ruston"},
        {name = "Schafter LWB", model = "schafter2"},
        {name = "Schafter V12", model = "schafter3"},
        {name = "Sentinel Classic", model = "sentinel3"}, --Sports
        {name = "Seven-70", model = "seven70"},
        {name = "Specter", model = "specter"},
        {name = "Specter Custom", model = "specter2"},
        {name = "Sprunk Buffalo", model = "buffalo3"},
        {name = "Streiter", model = "streiter"}, --Sports
        {name = "Sultan", model = "sultan"},
        {name = "Sultan RS", model = "sultanrs"},
        {name = "Surano", model = "surano"},
        {name = "Tropos Rallye", model = "tropos"},
        {name = "Verlierer", model = "verlierer2"},
        {name = "Casco", model = "casco"},
        {name = "Cheetah Classic", model = "cheetah2"},
        {name = "Coquette Classic", model = "coquette2"},
        {name = "Fränken Strange", model = "btype2"},
        {name = "GT 500", model = "gt500"}, --Sports Classic
        {name = "Infernus Classic", model = "infernus2"},
        {name = "JB 700", model = "jb700"},
        {name = "Karin 190z", model = "z190"}, --Sports Classic
        {name = "Mamba", model = "mamba"},
        {name = "Manana", model = "manana"},
        {name = "Monroe", model = "monroe"},
        {name = "Peyote", model = "peyote"},
        {name = "Pigalle", model = "pigalle"},
        {name = "Rapid GT Classic", model = "rapidgt3"}, --Sports Classic
        {name = "Retinue", model = "retinue"}, --Sports Classic
        {name = "Roosevelt", model = "btype"},
        {name = "Roosevelt Valor", model = "btype3"},
        {name = "Savestra", model = "savestra"}, --Sports Classic
        {name = "Stinger", model = "stinger"},
        {name = "Stinger GT", model = "stingergt"},
        {name = "Stirling GT", model = "feltzer3"},
        {name = "Torero", model = "torero"},
        {name = "Tornado", model = "tornado"},
        {name = "Tornado (Beater)", model = "tornado3"},
        {name = "Tornado (Mariachi)", model = "tornado4"},
        {name = "Tornado Custom", model = "tornado5"},
        {name = "Tornado Rat Rod", model = "tornado6"},
        {name = "Turismo Classic", model = "turismo2"},
        {name = "Z-type", model = "ztype"},
        --{name = "811", model = "pfister811"},
        {name = "Adder", model = "adder"},
        --{name = "Banshee 900R", model = "banshee2"},
        --{name = "Bullet", model = "bullet"},
        --{name = "Cheetah", model = "cheetah"},
        {name = "Cyclone", model = "cyclone"}, --Super
        --{name = "Entity XF", model = "entityxf"},
        --{name = "ETR1", model = "sheava"},
        --{name = "FMJ", model = "fmj"},
        --{name = "GP1", model = "gp1"},
        --{name = "Infernus", model = "infernus"},
        --{name = "Itali GTB", model = "italigtb"},
        --{name = "Itali GTB Custom", model = "italigtb2"},
        --{name = "Nero", model = "nero"},
        --{name = "Nero Custom", model = "nero2"},
        --{name = "Osiris, model = "osiris"},
        --{name = "Overflod Autarch", model = "autarch"}, --Super
        --{name = "Penetrator", model = "penetrator"},
        --{name = "RE-7B", model = "le7b"},
        --{name = "Reaper", model = "reaper"},
        --{name = "SC1", model = "sc1"}, --Super
        --{name = "Sultan RS", model = "sultanrs"},
        {name = "T20", model = "t20"},
        --{name = "Tempesta", model = "tempesta"},
        --{name = "Turismo R", model = "turismor"},
        --{name = "Tyrus", model = "tyrus"},
        --{name = "Vacca", model = "vacca"},
        --{name = "Vagner", model = "vagner"},
        --{name = "Visione", model = "visione"}, --Super
        --{name = "Voltic", model = "voltic"},
        {name = "XA-21", model = "xa21"},
        --{name = "X80 Proto", model = "prototipo"},
        {name = "Blade", model = "blade"},
        {name = "Buccaneer", model = "buccaneer"},
        {name = "Buccaneer Custom", model = "buccaneer2"},
        {name = "Chino", model = "chino"},
        {name = "Chino Custom", model = "chino2"},
        {name = "Coquette BlackFin", model = "coquette3"},
        {name = "Dominator", model = "dominator"},
        {name = "Dukes", model = "dukes"},
        {name = "Gauntlet", model = "gauntlet"},
        {name = "Hermes", model = "hermes"},  --Muscle
        {name = "Hotknife", model = "hotknife"},
        {name = "Hustler", model = "hustler"}, --Muscle
        {name = "Faction", model = "faction"},
        {name = "Faction Custom", model = "faction2"},
        {name = "Faction Custom Donk", model = "faction3"},
        {name = "Lost Slamvan", model = "slamvan2"},
        {name = "Lurcher", model = "lurcher"},
        {name = "Moonbeam", model = "moonbeam"},
        {name = "Moonbeam Custom", model = "moonbeam2"},
        {name = "Nightshade", model = "nightshade"},
        {name = "Phoenix", model = "phoenix"},
        {name = "Picador", model = "picador"},
        {name = "Pißwasser Dominator", model = "dominator2"},
        {name = "Rat-Loader", model = "ratloader"},
        {name = "Rat-Truck", model = "ratloader2"},
        {name = "Redwood Gauntlet", model = "gauntlet2"},
        {name = "Ruiner", model = "ruiner"},
        {name = "Sabre Turbo", model = "sabregt"},
        {name = "Sabre Turbo Custom", model = "sabregt2"},
        {name = "Slamvan", model = "slamvan"},
        {name = "Slamvan Custom", model = "slamvan3"},
        {name = "Tampa", model = "tampa"},
        {name = "Virgo", model = "virgo"},
        {name = "Virgo Classic", model = "virgo2"},
        {name = "Virgo Classic Custom", model = "virgo3"},
        {name = "Vigero", model = "vigero"},
        {name = "Voodoo", model = "voodoo2"},
        {name = "Voodoo Custom", model = "voodoo"},
        {name = "Yosemite", model = "yosemite"}, --Muscle
        {name = "Bifta", model = "bifta"},
        {name = "Bodhi", model = "bodhi2"},
        {name = "Brawler", model = "brawler"},
        {name = "Canis Kamacho", model = "kamacho"}, --Offroad
        {name = "Desert Raid", model = "trophytruck2"},
        {name = "Dubsta 6x6", model = "dubsta3"},
        {name = "Dune Buggy", model = "dune"},
        {name = "Duneloader", model = "dloader"},
        {name = "Injection", model = "bfinjection"},
        {name = "Kalahari", model = "kalahari"},
        {name = "Mesa (Caged)", model = "mesa3"},
        {name = "Rancher XL", model = "rancherxl"},
        {name = "Riata", model = "riata"}, --Offroad
        {name = "Rebel", model = "rebel2"},
        {name = "Rusty Rebel", model = "rebel"},
        {name = "Sandking SWB", model = "sandking2"},
        {name = "Sandking XL", model = "sandking"},
        {name = "Trophy Truck", model = "trophytruck"},
        {name = "Baller", model = "baller"},
        {name = "Baller 2nd Gen", model = "baller2"},
        {name = "Baller LE", model = "baller3"},
        {name = "Baller LE LWB", model = "baller4"},
        {name = "BeeJay XL", model = "bjxl"},
        {name = "Cavalcade", model = "cavalcade"},
        {name = "Cavalcade 2nd Gen", model = "cavalcade2"},
        {name = "Contender", model = "contender"},
        {name = "Dubsta", model = "dubsta2"},
        {name = "FQ 2", model = "fq2"},
        {name = "Granger", model = "granger"},
        {name = "Gresley", model = "gresley"},
        {name = "Habanero", model = "habanero"},
        {name = "Huntley S", model = "huntley"},
        {name = "Landstalker", model = "landstalker"},
        {name = "Mesa", model = "mesa"},
        {name = "Patriot", model = "patriot"},
        {name = "Radius", model = "radi"},
        {name = "Rocoto", model = "rocoto"},
        {name = "Seminole", model = "seminole"},
        {name = "Serrano", model = "serrano"},
        {name = "XLS", model = "xls"},
        {name = "Bison", model = "bison"},
        {name = "Bobcat XL", model = "bobcatxl"},
        {name = "Burrito", model = "burrito3"},
        {name = "Camper", model = "camper"},
        {name = "Gang Burrito", model = "gburrito2"},
        {name = "Journey", model = "journey"},
        {name = "Minivan", model = "minivan"},
        {name = "Minivan Custom", model = "minivan2"},
        {name = "Paradise", model = "paradise"},
        {name = "Rumpo", model = "rumpo"},
        {name = "Rumpo Custom", model = "rumpo3"},
        {name = "Surfer", model = "surfer"},
        {name = "Surfer (Beater)", model = "surfer2"},
        {name = "Youga", model = "youga"},
        {name = "Youga Classic", model = "youga2"},
        {name = "Asea", model = "asea"},
        {name = "Asterope", model = "asterope"},
        {name = "Cognoscenti", model = "cognoscenti"},
        {name = "Cognoscenti 55", model = "cog55"},
        {name = "Emperor", model = "emperor"},
        {name = "Emperor (Beater)", model = "emperor2"},
        {name = "Fugitive", model = "fugitive"},
        {name = "Glendale", model = "glendale"},
        {name = "Ingot", model = "ingot"},
        {name = "Intruder", model = "intruder"},
        {name = "Premier", model = "premier"},
        {name = "Primo", model = "primo"},
        {name = "Primo Custom", model = "primo2"},
        {name = "Regina", model = "regina"},
        {name = "Romero Hearse", model = "romero"},
        {name = "Schafter", model = "schafter2"},
        {name = "Stanier", model = "stanier"},
        {name = "Stratum", model = "stratum"},
        {name = "Stretch Limo", model = "stretch"},
        {name = "Super Diamond", model = "superd"},
        {name = "Surge", model = "surge"},
        {name = "Tailgater", model = "tailgater"},
        {name = "Warrener", model = "warrener"},
        {name = "Washington", model = "washington"},
        {name = "Akuma", model = "akuma"},
        {name = "Avarus", model = "avarus"},
        {name = "Bagger", model = "bagger"},
        {name = "Bati 801", model = "bati"},
        {name = "Bati 801RR", model = "bati2"},
        {name = "BF400", model = "bf400"},
        {name = "Carbon RS", model = "carbonrs"},
        {name = "Cliffhanger", model = "cliffhanger"},
        {name = "Daemon", model = "daemon2"},
        {name = "Daemon (Lost)", model = "daemon"},
        {name = "Defiler", model = "defiler"},
        {name = "Diablous", model = "diablous"},
        {name = "Diablous Custom", model = "diablous2"},
        {name = "Double T", model = "double"},
        {name = "Enduro", model = "enduro"},
        {name = "Esskey", model = "esskey"},
        {name = "Faggio", model = "faggio2"},
        {name = "Faggio Sport", model = "faggio"},
        {name = "Faggio Mod", model = "faggio3"},
        {name = "FCR 1000", model= "fcr"},
        {name = "FCR 1000 Custom", model = "fcr2"},
        {name = "Gargoyle", model = "gargoyle"},
        {name = "Hakuchou", model = "hakuchou"},
        {name = "Hakuchou Drag", model = "hakuchou2"},
        {name = "Hexer", model = "hexer"},
        {name = "Innovation", model = "innovation"},
        {name = "Lectro", model = "lectro"},
        {name = "Manchez", model = "manchez"},
        {name = "Nemesis", model = "nemesis"},
        {name = "Nightblade", model = "nightblade"},
        {name = "PCJ-600", model = "pcj"},
        {name = "Rat Bike", model = "ratbike"},
        {name = "Ruffian", model = "ruffian"},
        {name = "Sanchez", model = "sanchez"},
        {name = "Sanctus", model = "Sanctus"},
        {name = "Sovereign", model = "sovereign"},
        {name = "Thrust", model = "thrust"},
        {name = "Vader", model = "vader"},
        {name = "Vindicator", model = "vindicator"},
        {name = "Vortex", model = "vortex"},
        {name = "Wolfsbane", model = "wolfsbane"},
        {name = "Zombie Bobber", model = "zombiea"},
        {name = "Zombie Chopper", model = "zombieb"},
}

local colorNames = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steal",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "police car blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metaillic V Dark Blue",
    ['147'] = "MODSHOP BLACK1",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "DEFAULT ALLOY COLOR",
    ['157'] = "Epsilon Blue",
}

local weapons_whitelist = {
	["WEAPON_BALL"]	= 1,
	["WEAPON_PETROLCAN"] = 1,
	["WEAPON_SNOWBALL"] = 1,
}

local ten_fifthteen_timer = 10 --Minutes --Drugs
local ten_thirtyone_timer = 10 --Minutes --Gunshots
local ten_thirtytwo_timer = 10 --Minutes --Car Lockpicking
local ten_thirtytwo_2_timer = 10 --Minutes --Property lockpicking
local ten_ninety_timer = 10

local function willNPCreport(type)
	local pos = GetEntityCoords(PlayerPedId(), false)
	local zone = GetNameOfZone(pos.x, pos.y, pos.z)
	local percentage = GetRandomIntInRange(0, 101)
	if not zones[zone] then
		return false
	else
		if not zones[zone][type] then
			return false
		else
			return percentage > (100 - zones[zone][type])
		end
	end
end

RegisterNetEvent("trigger:animation")
AddEventHandler("trigger:animation", function()
	 TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 8.0, -1 , -1 , 0, false, true, true)
     Wait(7000)
     ClearPedTasks(PlayerPedId())
end)

ten_thirteen_pressed = false
AddEventHandler("dispatch:ten-thirteen", function(_source)
	ten_thirteen_pressed = true
	local pos = GetEntityCoords(PlayerPedId(), false)
	local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
	TriggerServerEvent("dispatch:ten-thirteen", GetStreetNameFromHashKey(street))
end)

RegisterNetEvent("dispatch:add_ten-thirteen")
AddEventHandler("dispatch:add_ten-thirteen", function(_source)
	if PlayerId ~= GetPlayerFromServerId(_source) then
		Citizen.CreateThread(function()
			local player_id = GetPlayerFromServerId(_source)
			local officer_down = true
			local player_blip = nil
			while officer_down do
				Citizen.Wait(0)
				if NetworkIsPlayerActive(player_id) then
					if DoesEntityExist(GetPlayerPed(player_id)) then
						if IsEntityDead(GetPlayerPed(player_id)) then
							if not DoesBlipExist(player_blip) then
								player_blip = AddBlipForEntity(GetPlayerPed(player_id))
								SetBlipSprite(player_blip, 1)
								SetBlipColour(player_blip, 1)
								SetBlipAsShortRange(player_blip, true)
								SetBlipScale(player_blip, 0.85)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("10-13")
								EndTextCommandSetBlipName(player_blip)
							end
						else
							officer_down = false
							RemoveBlip(player_blip)
						end
					else
						officer_down = false
						RemoveBlip(player_blip)
					end
				else
					officer_down = false
					RemoveBlip(player_blip)
				end
			end
		end)
	end
end)

Citizen.CreateThread(function()
	local lastpos = {x = 0.0, y = 0.0, z = 0.0}
	while true do
		Citizen.Wait(0)
		if not exports.policejob:getIsInService() then
			if IsPedShooting(PlayerPedId()) then
				local hasWeapon, currentWeapon = GetCurrentPedWeapon(PlayerPedId(), 1)
				if currentWeapon ~= nil then
					if GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(Weaponhashes[tostring(currentWeapon)])) > 0 then
						if not weapons_whitelist[Weaponhashes[tostring(currentWeapon)]] then
							local pos = GetEntityCoords(PlayerPedId(), false)
							if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, lastpos.x, lastpos.y, lastpos.z, true) > 50 then
								if willNPCreport("gunshots") then
									lastpos = pos
									local pos = GetEntityCoords(PlayerPedId(), false)
									local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
									TriggerServerEvent("dispatch:ten-thirtytwo", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street))
								end
							end
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("dispatch:ten-thirtytwo")
AddEventHandler("dispatch:ten-thirtytwo", function(coords)
	Citizen.CreateThread(function()
		local ten_thirtytwo_blip = nil
		local coords = coords
		local endTime = GetGameTimer() + ((ten_thirtytwo_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(ten_thirtytwo_blip) then
				ten_thirtytwo_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(ten_thirtytwo_blip, 458)
				SetBlipColour(ten_thirtytwo_blip, 28)
				SetBlipAsShortRange(ten_thirtytwo_blip, true)
				SetBlipScale(ten_thirtytwo_blip, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("10-32")
				EndTextCommandSetBlipName(ten_thirtytwo_blip)
			end
			if not arrived then
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-32")
				end
			end
		end
		RemoveBlip(ten_thirtytwo_blip)
	end)
end)

local lockpick_lastpos = {x = 0.0, y = 0.0, z = 0.0}
AddEventHandler("dispatch:lockpick", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, lockpick_lastpos.x, lockpick_lastpos.y, lockpick_lastpos.z, true) > 25 then
		if willNPCreport("vehicle") then
			lockpick_lastpos = pos
			local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
			local name = ""
			for k, v in pairs(cars) do
				if(v.model == string.lower(model)) then
					name = v.name
				end
			end
			local plate =  GetVehicleNumberPlateText(vehicle)
			local primary, secondary = GetVehicleColours(vehicle)
			primary = colorNames[tostring(primary)]
			TriggerServerEvent("dispatch:ten-thirtyone", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street), name, plate, primary)
		end
	end
end)

RegisterNetEvent("dispatch:ten-thirtyone")
AddEventHandler("dispatch:ten-thirtyone", function(coords)
	Citizen.CreateThread(function()
		local ten_thirtyone_blip = nil
		local coords = coords
		local endTime = GetGameTimer() + ((ten_thirtyone_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(ten_thirtyone_blip) then
				ten_thirtyone_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(ten_thirtyone_blip, 229)
				SetBlipColour(ten_thirtyone_blip, 28)
				SetBlipAsShortRange(ten_thirtyone_blip, true)
				SetBlipScale(ten_thirtyone_blip, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("10-31")
				EndTextCommandSetBlipName(ten_thirtyone_blip)
			end
			if not arrived then
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-31")
				end
			end
		end
		RemoveBlip(ten_thirtyone_blip)
	end)
end)

local drugs_lastpos = {x = 0.0, y = 0.0, z = 0.0}
AddEventHandler("dispatch:drug", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, drugs_lastpos.x, drugs_lastpos.y, drugs_lastpos.z, true) > 50 then
		if willNPCreport("drugs") then
			drugs_lastpos = pos
			local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
			local sex = IsPedMale(PlayerPedId())
			if sex then
				gender = "Male"
			elseif not sex then
				gender = "Female"
			end
			TriggerServerEvent("dispatch:ten-fifthteen", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street), gender)
		end
	end
end)

RegisterNetEvent("dispatch:ten-fifthteen")
AddEventHandler("dispatch:ten-fifthteen", function(coords)
	Citizen.CreateThread(function()
		local ten_fifthteen_blip = nil
		local coords = coords
		local endTime = GetGameTimer() + ((ten_fifthteen_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(ten_fifthteen_blip) then
				ten_fifthteen_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(ten_fifthteen_blip, 496)
				SetBlipColour(ten_fifthteen_blip, 28)
				SetBlipAsShortRange(ten_fifthteen_blip, true)
				SetBlipScale(ten_fifthteen_blip, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("10-15")
				EndTextCommandSetBlipName(ten_fifthteen_blip)
			end
			if not arrived then
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-15")
				end
			end
		end
		RemoveBlip(ten_fifthteen_blip)
	end)
end)

AddEventHandler("dispatch:lockpick_property", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	if willNPCreport("property_lock") then
		local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
		TriggerServerEvent("dispatch:ten-thirtyone_2", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street))
	end
end)

RegisterNetEvent("dispatch:ten-thirtyone_2")
AddEventHandler("dispatch:ten-thirtyone_2", function(coords)
	Citizen.CreateThread(function()
		local ten_thirtyone_2_blip = nil
		local coords = coords
		local endTime = GetGameTimer() + ((ten_thirtytwo_2_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(ten_thirtyone_2_blip) then
				ten_thirtyone_2_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(ten_thirtyone_2_blip, 459)
				SetBlipColour(ten_thirtyone_2_blip, 28)
				SetBlipAsShortRange(ten_thirtyone_2_blip, true)
				SetBlipScale(ten_thirtyone_2_blip, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("10-31")
				EndTextCommandSetBlipName(ten_thirtyone_2_blip)
			end
			if not arrived then
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-31")
				end
			end
		end
		RemoveBlip(ten_thirtyone_2_blip)
	end)
end)

RegisterNetEvent("dispatch:robbery")
AddEventHandler("dispatch:robbery", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
	TriggerServerEvent("dispatch:ten-ninety", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street))
end)

RegisterNetEvent("dispatch:ten-ninety")
AddEventHandler("dispatch:ten-ninety", function(coords)
	Citizen.CreateThread(function()
		local ten_ninety_blip = nil
		local coords = coords
		local endTime = GetGameTimer() + ((ten_ninety_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(ten_ninety_blip) then
				ten_ninety_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(ten_ninety_blip, 459)
				SetBlipColour(ten_ninety_blip, 28)
				SetBlipAsShortRange(ten_ninety_blip, true)
				SetBlipScale(ten_ninety_blip, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("10-90")
				EndTextCommandSetBlipName(ten_ninety_blip)
			end
			if not arrived then
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-90")
				end
			end
		end
		RemoveBlip(ten_ninety_blip)
	end)
end)

RegisterNetEvent("dispatch:notify-cops")
AddEventHandler("dispatch:notify-cops", function(message)
	local pos = GetEntityCoords(PlayerPedId(), false)
	local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
	message = string.gsub(message, "STREETNAME", GetStreetNameFromHashKey(street))
	TriggerServerEvent("dispatch:notify-cops", message)
end)

RegisterNetEvent("dispatch:notify-cops31")
AddEventHandler("dispatch:notify-cops31", function(message)
	local pos = GetEntityCoords(PlayerPedId(), false)
	local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
	message = string.gsub(message, "STREETNAME", GetStreetNameFromHashKey(street))
	vehicle = string.gsub(vehicle, "VEHICLE MODEL", GetVehiclePedIsUsing(PlayerPedId()))
	plate = string.gsub(plate, "VEHICLE PLATE", GetVehicleNumberPlateText(vehicle))
	color = string.gsub(color, "VEHICLE COLOR", GetVehicleColours(vehicle))
	TriggerServerEVent("dispatch:notify-cops31", message, vehicle, plate, color)
end)

local user_call_311_timer = 10
local user_call_911_timer = 10

RegisterNetEvent("dispatch:311")
AddEventHandler("dispatch:311", function(id, message)
	local user_call_311 = nil
	local id = GetPlayerPed(GetPlayerFromServerId(id))
	local coords = GetEntityCoords(id, false)
	local endTime = GetGameTimer() + ((user_call_311_timer * 60)/ 0.001)
	local arrived = false
	while endTime > GetGameTimer() and not arrived do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId(), false)
		if not DoesBlipExist(user_call_311) then
			user_call_311 = AddBlipForCoord(coords.x, coords.y, coords.z)
			SetBlipSprite(user_call_311, 459)
			SetBlipColour(user_call_311, 28)
			SetBlipAsShortRange(user_call_311, true)
			SetBlipScale(user_call_311, 0.85)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("311 Call")
			EndTextCommandSetBlipName(user_call_311)
		end
		if not arrived then
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
				arrived = true
				TriggerServerEvent("dispatch:pay", "311")
			end
		end
	end
	RemoveBlip(user_call_311)
end)

RegisterNetEvent("dispatch:911")
AddEventHandler("dispatch:911", function(id, message)
	local user_call_911 = nil
	local id = GetPlayerPed(GetPlayerFromServerId(id))
	local coords = GetEntityCoords(id, false)
	local endTime = GetGameTimer() + ((user_call_911_timer * 60)/ 0.001)
	local arrived = false
	while endTime > GetGameTimer() and not arrived do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId(), false)
		if not DoesBlipExist(user_call_911) then
			user_call_911 = AddBlipForCoord(coords.x, coords.y, coords.z)
			SetBlipSprite(user_call_911, 459)
			SetBlipColour(user_call_911, 28)
			SetBlipAsShortRange(user_call_911, true)
			SetBlipScale(user_call_911, 0.85)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("911 Call")
			EndTextCommandSetBlipName(user_call_911)
		end
		if not arrived then
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
				arrived = true
				TriggerServerEvent("dispatch:pay", "911")
			end
		end
	end
	RemoveBlip(user_call_911)
end)
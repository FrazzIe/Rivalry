resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Mythic Framework Hospital & Damage System'

version '1.0.0'

dependencies {
	"rivalry-utilities",
}

client_scripts {
	'@rivalry-utilities/client/weapons.lua',
	'@rivalry-utilities/client/distance.lua',
	'client/wound.lua',
	'client/main.lua',
	'client/items.lua',
}

server_scripts {
	'server/wound.lua',
	'server/main.lua',
}

dependencies {
	'mythic_progbar',
	'mythic_notify',
}

exports {
    'IsInjuredOrBleeding',
}

server_exports {
    'GetCharsInjuries',
}

shared_scripts {
	'@rivalry-utilities/shared.lua',
}
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'bunch of condensed shit'

ui_page 'banking/html/ui.html'

files {
	'banking/html/ui.html',
	'banking/html/pricedown.ttf',
	'banking/html/bank-icon.png',
	'banking/html/logo.png',
	'banking/html/cursor.png',
	'banking/html/styles.css',
	'banking/html/scripts.js',
	'banking/html/debounce.min.js',
	'sounds/chime.ogg',
	'banking/html/sounds/chime.ogg',
	"config.ini",
}

client_scripts {
	"laundering/client.lua",
	"paycheck/paycheck_cl.lua",
	"banking/client.lua",
	"helicam/heli_client.lua",
	--"luxart/client.lua",
	"informer/client.lua",
	"indicators/indicators_client.lua",
	"gui.lua",
	"extras.lua",
	"taxi/taxi_Menu.lua",
	"taxi/taxi_client.lua",
	"pointer/client.lua",
}

server_scripts {
	"laundering/server.lua",
	"paycheck/paycheck_sv.lua",
	"banking/server.lua",
	"helicam/heli_server.lua",
	--"luxart/server.lua",
	"informer/server.lua",
	"indicators/indicators_server.lua",
	'taxi/taxi_server.lua',
}

export 'getIsInService'

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'bunch of condensed shit'

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/bank-icon.png',
	'html/logo.png',
	'html/cursor.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js',
	'html/sounds/chime.ogg',
}

client_scripts {
	"client.lua",
}

server_scripts {
	"server.lua",
}
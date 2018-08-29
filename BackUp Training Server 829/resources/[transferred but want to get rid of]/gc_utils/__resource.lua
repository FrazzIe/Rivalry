-- resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/style.css',
	'html/script.js',
	'html/pricedown.ttf',
	'html/cursor.png'
}

client_script {
	"client.lua",
	"client_debug_test.lua"
}

export 'getGcUtils'
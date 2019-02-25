resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

dependencies {
	"rivalry-utilities",
}

shared_scripts {
	"@rivalry-utilities/shared.lua",
	"shared.lua",
}

client_scripts {
	"shared.lua",
	"@rivalry-utilities/shared.lua",
	"@rivalry-utilities/client/weapons.lua",
	"@rivalry-utilities/client/distance.lua",
	"@rivalry-utilities/client/enumeration.lua",
	"client.lua",
}

server_scripts {
	"shared.lua",
	"@rivalry-utilities/shared.lua",
	"server.lua",
}

ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/js/app.js",
	"ui/css/app.css",
	"ui/fonts/MaterialIcons-Regular.eot",
	"ui/fonts/MaterialIcons-Regular.ttf",
	"ui/fonts/MaterialIcons-Regular.woff",
	"ui/fonts/MaterialIcons-Regular.woff2",
	"ui/fonts/Roboto-Black.woff",
	"ui/fonts/Roboto-BlackItalic.woff",
	"ui/fonts/Roboto-Bold.woff",
	"ui/fonts/Roboto-BoldItalic.woff",
	"ui/fonts/Roboto-Light.woff",
	"ui/fonts/Roboto-LightItalic.woff",
	"ui/fonts/Roboto-Medium.woff",
	"ui/fonts/Roboto-MediumItalic.woff",
	"ui/fonts/Roboto-Regular.woff",
	"ui/fonts/Roboto-RegularItalic.woff",
	"ui/fonts/Roboto-Thin.woff",
	"ui/fonts/Roboto-ThinItalic.woff",
	"ui/fonts/Roboto-Black.woff2",
	"ui/fonts/Roboto-BlackItalic.woff2",
	"ui/fonts/Roboto-Bold.woff2",
	"ui/fonts/Roboto-BoldItalic.woff2",
	"ui/fonts/Roboto-Light.woff2",
	"ui/fonts/Roboto-LightItalic.woff2",
	"ui/fonts/Roboto-Medium.woff2",
	"ui/fonts/Roboto-MediumItalic.woff2",
	"ui/fonts/Roboto-Regular.woff2",
	"ui/fonts/Roboto-RegularItalic.woff2",
	"ui/fonts/Roboto-Thin.woff2",
	"ui/fonts/Roboto-ThinItalic.woff2",
}
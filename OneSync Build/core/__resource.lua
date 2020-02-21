resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
dependency 'GHMattiMySQL'

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/js/app.js',
	'ui/css/app.css',
	'ui/fonts/MaterialIcons-Regular.eot',
	'ui/fonts/MaterialIcons-Regular.ttf',
	'ui/fonts/MaterialIcons-Regular.woff',
	'ui/fonts/MaterialIcons-Regular.woff2',
	'ui/fonts/Roboto-Black.woff',
	'ui/fonts/Roboto-BlackItalic.woff',
	'ui/fonts/Roboto-Bold.woff',
	'ui/fonts/Roboto-BoldItalic.woff',
	'ui/fonts/Roboto-Light.woff',
	'ui/fonts/Roboto-LightItalic.woff',
	'ui/fonts/Roboto-Medium.woff',
	'ui/fonts/Roboto-MediumItalic.woff',
	'ui/fonts/Roboto-Regular.woff',
	'ui/fonts/Roboto-RegularItalic.woff',
	'ui/fonts/Roboto-Thin.woff',
	'ui/fonts/Roboto-ThinItalic.woff',
	'ui/fonts/Roboto-Black.woff2',
	'ui/fonts/Roboto-BlackItalic.woff2',
	'ui/fonts/Roboto-Bold.woff2',
	'ui/fonts/Roboto-BoldItalic.woff2',
	'ui/fonts/Roboto-Light.woff2',
	'ui/fonts/Roboto-LightItalic.woff2',
	'ui/fonts/Roboto-Medium.woff2',
	'ui/fonts/Roboto-MediumItalic.woff2',
	'ui/fonts/Roboto-Regular.woff2',
	'ui/fonts/Roboto-RegularItalic.woff2',
	'ui/fonts/Roboto-Thin.woff2',
	'ui/fonts/Roboto-ThinItalic.woff2',
}

client_scripts {
	'client/main.lua',
}
server_scripts {
	'server/main.lua',
	'server/user.lua',
	'server/character.lua',
	'server/callback.lua',
	'server/queue.lua',
	'server/bans.lua',
	'server/groups.lua',
	'server/misc.lua',
	'server/exports.lua',
}

export 'GetCharacterName'
export 'GetPower'
export 'GetGroup'
export 'GetMdtData'
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
dependency 'GHMattiMySQL'
ui_page 'html/index.html'

files {
	'html/index.html',
	'html/assets/bootstrap/css/bootstrap.min.css',
	'html/assets/bootstrap/js/bootstrap.min.js',
	'html/assets/js/jquery.min.js',
	'html/assets/js/moment.js',
	'html/assets/js/moment-duration-format.js',
	'html/assets/js/script.js',
	'html/assets/css/styles.css',
	'html/assets/img/servericon.png',
	'html/assets/fonts/FontAwesome.otf',
	'html/assets/fonts/fontawesome-webfont.eot',
	'html/assets/fonts/fontawesome-webfont.svg',
	'html/assets/fonts/fontawesome-webfont.ttf',
	'html/assets/fonts/fontawesome-webfont.woff',
	'html/assets/fonts/fontawesome-webfont.woff2',
	'html/assets/fonts/font-awesome.css',
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
}

export 'GetCharacterName'
export 'GetPower'
export 'GetGroup'
export 'GetMdtData'
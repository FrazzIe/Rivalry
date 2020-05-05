fx_version 'adamant'
game 'gta5'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/images/collar.png',
	'html/images/cylinder.png',
	'html/images/driver.png',
	'html/images/pinBott.png',
	'html/images/pinTop.png',
	'html/index.pug',
	'html/styles.css',
	'html/js/index.js',
	'html/js/lockpick.js',
	'html/js/vue.min.js',
	'html/js/script.js',
	'html/css/style.css',
	'html/scss/style.scss',
}

shared_scripts {
	'sh_config.lua',
}

client_scripts {
	'cl_robberies.lua',
	'cl_cams.lua',
	'cl_blackMarket.lua',
}

server_scripts {
	'sv_robberies.lua',
	'sv_blackMarket.lua',
}
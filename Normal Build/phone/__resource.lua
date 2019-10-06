resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
dependency 'GHMattiMySQL'
ui_page 'html/index.html'

files {
	'html/images/samsung-bg.jpg',
	'html/images/twitter-bird.png',
	'html/images/yellow-page.png',
	'html/snd/beepboop.ogg',
	'html/css/normalize.css',
	'html/css/simplebar.css',
	'html/css/style.css',
	'html/css/style.less',
	'html/js/jquery.js',
	'html/js/angular.js',
	'html/js/nicescroll.js',
	'html/js/simplebar.js',
	'html/js/moment.js',
	'html/js/app.js',
	'html/index.html',
}

client_script 'client.lua'
server_script 'server.lua'

exports {
	'PlayerHasPhone',
	'PlayerSetPhone',
}
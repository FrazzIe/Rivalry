resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
dependency 'GHMattiMySQL'
ui_page 'html/index.html'

files {
	'html/index.html',
	'html/assets/bootstrap/css/bootstrap.min.css',
	'html/assets/bootstrap/js/bootsrap.min.js',
	'html/assets/js/jquery.min.js',
	'html/assets/js/script.js',
	'html/assets/css/styles.css',
	'html/assets/img/ipad.png',
}
client_script 'client.lua'
server_script 'server.lua'

exports {
	'PlayerHasPhone',
	'PlayerSetPhone',
}
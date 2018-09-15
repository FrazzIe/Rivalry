resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
dependency 'GHMattiMySQL'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/assets/css/Footer-Basic.css',
	'html/assets/css/styles.css',
	'html/assets/bootstrap/css/bootstrap.min.css',
	'html/assets/bootstrap/js/bootstrap.min.js',
	'html/assets/js/bs-animation.js',
	'html/assets/js/jquery.min.js',
	'html/assets/js/table.js',
	'html/assets/img/logo.png',
	'html/assets/img/lspd.png',
	'html/assets/img/doj.png',
	'html/assets/img/lsfd.png',
	'html/assets/img/report.png',
	'html/assets/img/citation.png',
	'html/assets/img/arrestreport.png',
	'html/assets/img/warrant.png',
}

client_script 'client.lua'
server_script 'server.lua'
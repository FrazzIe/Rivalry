resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/assets/css/styles.css',
  'html/assets/js/combolock.js',
  'html/assets/js/jquery.min.js',
   'html/assets/js/debounce.min.js',
}

client_script 'client.lua'
client_script 'config.lua'
server_script 'server.lua'
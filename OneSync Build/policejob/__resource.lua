-- Manifest
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
dependency 'GHMattiMySQL'
dependency 'mdt'

client_script 'warmenu.lua'
client_script 'gui.lua'
client_script 'utils_c.lua'
server_script 'utils_s.lua'

client_script 'Blip.lua'
client_script 'Drawing.lua'

client_script 'main_client.lua'
client_script 'functions_client.lua'
client_script 'menu.lua'
client_script 'garage_menus.lua'
client_script 'armoury_menu.lua'
client_script 'mission_client.lua'
client_script 'police_doors.lua'
client_script 'commands.lua'
client_script 'barrier.lua'
--client_script 'new_forensics_client.lua'

server_script 'main_server.lua'
server_script 'functions_server.lua'
server_script 'mission_server.lua'
--server_script 'new_forensics_server.lua'

client_script "stash_client.lua"
server_script "stash_server.lua"

client_script "carshop_client.lua"
server_script "carshop_server.lua"

export 'getIsInService'
export 'getIsCuffed'
export 'getPoliceRank'
export 'getIsCop'
export 'IsVehicleExempt'
export 'DestroyVehicle'
export 'GetNearestVehicleAtCoords'

resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
dependency 'GHMattiMySQL'

client_script "utils_c.lua"
server_script "utils_s.lua"
client_script "gui.lua"
client_script "warmenu.lua"

client_script "main_client.lua"
client_script "functions_client.lua"
client_script "menu.lua"
client_script "garage_menus.lua"
client_script "mission_client.lua"
client_script "spawnstuff.lua"
client_script "teleporter_client.lua"
client_script "ems_doors.lua"

server_script "main_server.lua"
server_script "functions_server.lua"
server_script "mission_server.lua"
server_script "teleporter_server.lua"

export 'getIsInService'
export 'getParamedicRank'
export 'getIsParamedic'
export 'IsVehicleExempt'
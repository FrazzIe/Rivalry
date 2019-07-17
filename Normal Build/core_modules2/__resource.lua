resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

dependency "core_modules"

client_script '@core_modules/New/Utilities/Shared/Functions.lua'
server_script '@core_modules/New/Utilities/Shared/Functions.lua'

client_script '@core_modules/New/Utilities/Client/Functions.lua'

client_script '@core_modules/utilities/utils_c.lua'
server_script '@core_modules/utilities/utils_s.lua'

client_script 'animations/client.lua'
client_script 'fuel/client.lua'
server_script 'fuel/server.lua'

client_script 'chat_stuff/client.lua'
server_script 'chat_stuff/server.lua'

client_script 'carwash/client.lua'
server_script 'carwash/server.lua'

client_script 'seatbelt/client.lua'

client_script 'deer_riding/client.lua'

client_script 'rest_house/client.lua'
server_script 'rest_house/server.lua'

client_script 'attached_weapons/client.lua'

client_script 'teleports/client.lua'

client_script 'diving/client.lua'
server_script 'diving/server.lua'

client_script 'tackle/client.lua'
server_script 'tackle/server.lua'

client_script 'afk/client.lua'

client_script 'pdpeds/client.lua'

client_script 'recoil/client.lua'

client_script 'density.lua'

client_script 'stress/client.lua'
server_script 'stress/server.lua'

--client_script 'mouth_movement.lua'

export 'SeatbeltActive'
export 'ScubaHas'

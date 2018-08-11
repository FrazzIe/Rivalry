resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
dependency 'GHMattiMySQL'

--Utilities
client_script 'New/Wrappers/Shared/Log.lua'
server_script 'New/Wrappers/Shared/Log.lua'

client_script 'New/Utilities/Shared/Functions.lua'
server_script 'New/Utilities/Shared/Functions.lua'

client_script 'New/Wrappers/Shared/Chat.lua'
server_script 'New/Wrappers/Shared/Chat.lua'

client_script "New/Wrappers/Client/Decorator.lua"
client_script "New/Wrappers/Client/Animation.lua"
client_script "New/Wrappers/Client/Map.lua"
client_script "New/Wrappers/Client/Blip.lua"

client_script 'New/Utilities/Client/Functions.lua'
server_script 'New/Utilities/Server/Functions.lua'

client_script 'New/Utilities/Client/Drawing.lua'

client_script 'New/Wrappers/Client/NativeUI.lua'

client_script "New/Player/Client/Main.lua"
client_script "New/Player/Client/Emotes.lua"
client_script "New/Player/Client/Commands.lua"
client_script "New/Player/Client/Panic.lua"

server_script "New/Player/Client/Panic.lua"
server_script "New/Player/Server/Commands.lua"

client_script "New/Player/Shared/Gambling.lua"
server_script "New/Player/Shared/Gambling.lua"

client_script 'utilities/warmenu.lua'
client_script 'utilities/gui.lua'
client_script 'utilities/utils_c.lua'
server_script 'utilities/utils_s.lua'
--Admin
client_script 'admin/client.lua'
server_script 'admin/server.lua'
--Anticheat
client_script 'anticheat/client.lua'
server_script 'anticheat/server.lua'
--Garages
client_script 'garages/client.lua'
server_script 'garages/server.lua'
--Inventory
client_script 'inventory/client.lua'
server_script 'inventory/server.lua'
--Convience store
client_script 'stores/client.lua'
server_script 'stores/server.lua'
--Jail system
client_script 'jail/client.lua'
server_script 'jail/server.lua'

--Jobs

client_script 'jobs/trucking/client.lua'
server_script 'jobs/trucking/server.lua'

client_script 'jobs/doj/client.lua'
client_script 'jobs/doj/shared.lua'
server_script 'jobs/doj/server.lua'
server_script 'jobs/doj/shared.lua'

client_script 'jobs/mechanic/client.lua'
client_script 'jobs/mechanic/shared.lua'
server_script 'jobs/mechanic/server.lua'
server_script 'jobs/mechanic/shared.lua'
--[[
client_script 'jobs/towing/client.lua'
server_script 'jobs/towing/server.lua'
--Los Santos Customs
client_script 'lscustoms/client.lua'
server_script 'lscustoms/server.lua'
--]]
--Vehicle rentals
client_script 'vehicle_rentals/client.lua'
server_script 'vehicle_rentals/server.lua'
--Carshop
client_script 'carshop/client.lua'
server_script 'carshop/server.lua'
--Ammu-nation
client_script 'ammu-nation/config.lua'
client_script 'ammu-nation/client.lua'
server_script 'ammu-nation/server.lua'
--Properties
client_script 'properties/client.lua'
server_script 'properties/config.lua'
server_script 'properties/server.lua'
--Drugs
client_script 'drugs/weed.lua'
server_script 'drugs/weed_server.lua'

client_script 'drugs/cocaine.lua'
server_script 'drugs/cocaine_server.lua'

--Others

client_script 'others/fuel/client.lua'
server_script 'others/fuel/server.lua'

client_script "others/fuel/frfuel.net.dll"
file "config.ini"

client_script 'others/hunger/client.lua'

client_script 'animations/client.lua'

client_script 'others/alerts/client.lua'
server_script 'others/alerts/server.lua'

client_script 'others/chat_stuff/client.lua'
server_script 'others/chat_stuff/server.lua'

client_script 'others/scoreboard/client.lua'
server_script 'others/scoreboard/server.lua'

client_script 'others/speedometer/InteractSound.lua'
client_script 'others/speedometer/speedometer.lua'

client_script 'others/emergency_blips/client.lua'
server_script 'others/emergency_blips/server.lua'

client_script 'others/dispatch/client.lua'
server_script 'others/dispatch/server.lua'

client_script 'others/carwash/client.lua'
server_script 'others/carwash/server.lua'

client_script 'others/seatbelt/client.lua'

client_script 'others/deer_riding/client.lua'

--client_script 'others/chopshop/client.lua'
--server_script 'others/chopshop/server.lua'

client_script 'others/attached_weapons/client.lua'

client_script 'others/zones/client.lua'
server_script 'others/zones/server.lua'

client_script 'others/keys/client.lua'
server_script 'others/keys/server.lua'

client_script 'others/teleports/client.lua'

client_script 'others/diving/client.lua'
server_script 'others/diving/server.lua'

client_script 'others/tackle/client.lua'
server_script 'others/tackle/server.lua'

client_script 'others/afk/client.lua'

client_script 'others/environment/config.lua'
client_script 'others/environment/client.lua'
server_script 'others/environment/config.lua'
server_script 'others/environment/server.lua'

client_script 'others/pdpeds/client.lua'

--Interaction
client_script 'interaction/main.lua'
server_script 'interaction/server.lua'

client_script 'interaction/hud.lua'
client_script 'interaction/speedcontrol.lua'
client_script 'interaction/crouch_cuffs.lua'
client_script 'interaction/doors.lua'
client_script 'interaction/head_display_talking.lua'

client_script "PlayerCustomisation/Config.lua"
server_script "PlayerCustomisation/Config.lua"
client_script "PlayerCustomisation/Client/Utilities.lua"
client_script "PlayerCustomisation/Client/Camera.lua"
client_script "PlayerCustomisation/Client/Creator.lua"
client_script "PlayerCustomisation/Client/Barbers.lua"
client_script "PlayerCustomisation/Client/Clothing.lua"
client_script "PlayerCustomisation/Client/Masks.lua"
client_script "PlayerCustomisation/Client/Tattoos.lua"
client_script "PlayerCustomisation/Client/Outfits.lua"
client_script "PlayerCustomisation/Client/Main.lua"

server_script "PlayerCustomisation/Server/Outfits.lua"
server_script "PlayerCustomisation/Server/Main.lua"
--Exports

--Inventory
export 'GetItemQuantity'
export 'isFull'
--Hunger bars
export 'getBars'
--Jobs/Towing
export 'GetActiveTows'

export 'isCuffed'

export 'isCuffable'

export 'setAttribute'

export 'IsInJail'

export 'IsInZone'

export 'ApplyTattoos'

export 'SetParamedic'
export 'SetPolice'
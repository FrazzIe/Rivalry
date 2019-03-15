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

--client_script 'New/Utilities/Client/Drawing.lua'

--client_script 'New/Wrappers/Client/NativeUI.lua'

client_script "New/Player/Client/Main.lua"
client_script "New/Player/Client/Emotes.lua"
client_script "New/Player/Client/Commands.lua"

server_script "New/Player/Server/Commands.lua"
server_script "New/Player/Server/Main.lua"

client_script "New/Player/Shared/Panic.lua"
server_script "New/Player/Shared/Panic.lua"

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

--Chop Shop
client_script 'others/chopshop/client.lua'
server_script 'others/chopshop/server.lua'

--Jobs

client_script 'jobs/trucking/client.lua'
server_script 'jobs/trucking/server.lua'

client_script 'jobs/fisher/fisher_client.lua'
server_script 'jobs/fisher/fisher_server.lua'

client_script 'jobs/garbage/client.lua'
server_script 'jobs/garbage/server.lua'

client_script 'jobs/gopostal/client.lua'
server_script 'jobs/gopostal/server.lua'

client_script 'jobs/doj/client.lua'
client_script 'jobs/doj/shared.lua'
server_script 'jobs/doj/server.lua'
server_script 'jobs/doj/shared.lua'

client_script 'jobs/jouranlist/client.lua'
client_script 'jobs/jouranlist/shared.lua'
server_script 'jobs/jouranlist/server.lua'
server_script 'jobs/jouranlist/shared.lua'

client_script 'jobs/mechanic/client.lua'
client_script 'jobs/mechanic/shared.lua'
server_script 'jobs/mechanic/server.lua'
server_script 'jobs/mechanic/shared.lua'

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
client_script 'drugs/weed_shared.lua'
server_script 'drugs/weed_shared.lua'
client_script 'drugs/weed_client.lua'
server_script 'drugs/weed_server.lua'

client_script 'drugs/cocaine.lua'
server_script 'drugs/cocaine_server.lua'

--Others
client_script 'others/hunger/client.lua'

client_script 'others/scoreboard/client.lua'
server_script 'others/scoreboard/server.lua'

--client_script 'others/speedometer/speedometer.lua'

client_script 'others/emergency_blips/client.lua'
server_script 'others/emergency_blips/server.lua'

client_script 'others/dispatch/client.lua'
server_script 'others/dispatch/server.lua'

client_script 'others/zones/client.lua'
server_script 'others/zones/server.lua'

client_script 'others/keys/client.lua'
server_script 'others/keys/server.lua'

client_script 'others/environment/config.lua'
client_script 'others/environment/client.lua'
server_script 'others/environment/config.lua'
server_script 'others/environment/server.lua'

--Interaction --Big point of interest
client_script 'interaction/main.lua'
server_script 'interaction/server.lua'

client_script 'interaction/hud.lua'
client_script 'interaction/speedcontrol.lua'
client_script 'interaction/crouch_cuffs.lua'
client_script 'interaction/head_display_talking.lua'

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

export 'DOJgetrank'
export 'DOJonduty'
export 'DOJisdoj'

export 'NewsGetRank'
export 'NewsOnDuty'
export 'NewsIsNews'

export 'SetParamedic'
export 'SetPolice'

export 'StanceAllowed'

export 'TurnOffHudElements'
export 'HudElementsDisabled'
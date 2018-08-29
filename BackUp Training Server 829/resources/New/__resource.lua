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

server_script "New/Player/Server/Commands.lua"

client_script "New/Player/Shared/Panic.lua"
server_script "New/Player/Shared/Panic.lua"

client_script "New/Player/Shared/Gambling.lua"
server_script "New/Player/Shared/Gambling.lua"
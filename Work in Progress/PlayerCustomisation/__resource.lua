resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
dependency 'GHMattiMySQL'

client_scripts {
	"Client/NativeUI.lua",
    "Config.lua",
    "Client/Utilities.lua",
    "Client/Creator.lua",
    "Client/Barbers.lua",
    "Client/Clothing.lua",
    "Client/Masks.lua",
    "Client/Tattoos.lua",
    "Client/Outfits.lua",
    "Client/Main.lua",
}

server_scripts {
	"Config.lua",
	"Server/Outfits.lua",
}
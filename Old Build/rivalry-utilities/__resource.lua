resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

shared_scripts {
	"shared.lua",
}

client_scripts {
	"shared.lua",
	"client/enumeration.lua",
	"client/distance.lua",
	"client/destroy.lua",
	"client/graphics.lua",
	"client/weapons.lua",
	"client/decorator.lua",
	"client/animation.lua",
	"client/common.lua",
}

server_scripts {
	"shared.lua",
	"server/common.lua",
}
resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

dependencies {
	"rivalry-utilities",
}

shared_scripts {
	"@rivalry-utilities/shared.lua",
	"config.lua",
}

client_scripts {
	"@rivalry-utilities/client/enumeration.lua",
	"@rivalry-utilities/client/distance.lua",
	"@rivalry-utilities/client/graphics.lua",
	"@rivalry-utilities/client/common.lua",
	"@rivalry-utilities/client/destroy.lua",
	"client.lua",
	"bed.lua",
}
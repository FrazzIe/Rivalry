resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

dependencies {
	"Rivalry-Utilities",
}

shared_scripts {
	"@Rivalry-Utilities/shared.lua",
	"config.lua",
}

client_scripts {
	"@Rivalry-Utilities/client/enumeration.lua",
	"@Rivalry-Utilities/client/distance.lua",
	"@Rivalry-Utilities/client/graphics.lua",
	"@Rivalry-Utilities/client/common.lua",
	"client.lua",
}
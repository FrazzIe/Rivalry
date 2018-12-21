resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

dependencies {
	"rivalry-utilities",
	"jssql",
}

shared_scripts {
	"@rivalry-utilities/shared.lua",
}

client_scripts {
	"client/main.lua",
}

server_scripts {
	"@rivalry-utilities/server/common.lua",
	"server/queue.lua",
}
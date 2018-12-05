resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

dependency "Rivalry-Utilities"
dependency "jssql"

shared_scripts {
	"@Rivalry-Utilities/shared.lua",
}

client_scripts {
	"client/main.lua",
}

server_scripts {
	"@Rivalry-Utilities/server/common.lua",
	"server/queue.lua",
}
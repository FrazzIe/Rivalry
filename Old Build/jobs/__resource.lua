resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

--[[
ui_page 'gui/ui.html'

files {
	'gui/ui.html',
	'gui/job-icon.png',
	'gui/pricedown.ttf',
	"gui/unemployed.png",
	"gui/police.png",
	"gui/Miner.png",
	"gui/Lumberjack.png",
	"gui/Farmer.png",
	"gui/Fisher.png",
	"gui/Brewer.png",
	"gui/Vigneron.png",
	"gui/emergency.png",
	"gui/mechanic.png",
	"gui/Taxi.png",
	"gui/GoPostal.png",
	"gui/PoolCleaner.png",
	"gui/Garbage.png",
	"gui/Tow.png",
	"gui/Pharmacist.png",
}
--]]
client_script {
	'gui/gui.lua',
	'jobcenter/jobcenter_config.lua',
	'unemployed/unemployed_config.lua',
	--'farmer/farmer_config.lua',
	--'lumberjack/lumberjack_config.lua',
	--'miner/miner_config.lua',
	--'fisher/fisher_config.lua',
	--'winemaker/winemaker_config.lua',
	--'brewer/brewer_config.lua',
	'jobcenter/jobcenter_client.lua',
	'unemployed/unemployed_client.lua',
	--'farmer/farmer_client.lua',
	--'lumberjack/lumberjack_client.lua',
	--'miner/miner_client.lua',
	--'fisher/fisher_client.lua',
	--'winemaker/winemaker_client.lua',
	--'brewer/brewer_client.lua',
	'mechanic/mechanic_client.lua',
	'mechanic/mechanic_Menu.lua',
	'hunting/client.lua',
	'gopostal/cl_delivery.lua',
	'garbage/garbage-client.lua',
	'pool/pool-client.lua',
}

server_script {
	'jobcenter/jobcenter_server.lua',
	'unemployed/unemployed_server.lua',
	--'farmer/farmer_server.lua',
	--'lumberjack/lumberjack_server.lua',
	--'miner/miner_server.lua',
	--'fisher/fisher_server.lua',
	--'winemaker/winemaker_config.lua',
	--'winemaker/winemaker_server.lua',
	--'brewer/brewer_config.lua',
	--'brewer/brewer_server.lua',
	'mechanic/mechanic_server.lua',
	'hunting/server.lua',
	'gopostal/sv_delivery.lua',
	'garbage/garbage-server.lua',
	'pool/pool-server.lua',
}

export 'getMechanicIsInService'
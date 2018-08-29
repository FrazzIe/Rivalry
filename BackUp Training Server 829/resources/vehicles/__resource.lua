resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

files {
	"data/handling.meta",
	"data/vehicles.meta",
	"data/carcols.meta",
	"data/carvariations.meta",
	"data/popcycle.dat",
	"data/popgroups.ymt",
}

data_file "HANDLING_FILE" "data/handling.meta"
data_file "VEHICLE_METADATA_FILE" "data/vehicles.meta"
data_file "CARCOLS_FILE" "data/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/carvariations.meta"
--data_file "POPSCHED_FILE" "data/popcycle.dat"
--data_file "FIVEM_LOVES_YOU_341B23A2F0E0F131" "data/popgroups.ymt"

client_script "names.lua"
resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

files {
	'loadouts.meta',
	'weaponanimations.meta',
	'weaponarchetypes.meta',
	'weaponcomponents.meta',
	'weaponglock.meta',
	'pedpersonality.meta',
}

data_file 'LOADOUTS_FILE' 'loadouts.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weaponanimations.meta'
data_file 'WEAPONINFO_FILE' 'weaponglock.meta'
data_file 'WEAPONCOMPONENTSINFO_FILE' 'weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'weaponarchetypes.meta'
data_file 'PED_PERSONALITY_FILE'  'pedpersonality.meta'

client_script 'name.lua'
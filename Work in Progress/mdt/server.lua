local Colours = {
    "Metallic Black",
    "Metallic Graphite Black",
    "Metallic Black Steal",
    "Metallic Dark Silver",
    "Metallic Silver",
    "Metallic Blue Silver",
    "Metallic Steel Gray",
    "Metallic Shadow Silver",
    "Metallic Stone Silver",
    "Metallic Midnight Silver",
    "Metallic Gun Metal",
    "Metallic Anthracite Grey",
    "Matte Black",
    "Matte Gray",
    "Matte Light Grey",
    "Util Black",
    "Util Black Poly",
    "Util Dark silver",
    "Util Silver",
    "Util Gun Metal",
    "Util Shadow Silver",
    "Worn Black",
    "Worn Graphite",
    "Worn Silver Grey",
    "Worn Silver",
    "Worn Blue Silver",
    "Worn Shadow Silver",
    "Metallic Red",
    "Metallic Torino Red",
    "Metallic Formula Red",
    "Metallic Blaze Red",
    "Metallic Graceful Red",
    "Metallic Garnet Red",
    "Metallic Desert Red",
    "Metallic Cabernet Red",
    "Metallic Candy Red",
    "Metallic Sunrise Orange",
    "Metallic Classic Gold",
    "Metallic Orange",
    "Matte Red",
    "Matte Dark Red",
    "Matte Orange",
    "Matte Yellow",
    "Util Red",
    "Util Bright Red",
    "Util Garnet Red",
    "Worn Red",
    "Worn Golden Red",
    "Worn Dark Red",
    "Metallic Dark Green",
    "Metallic Racing Green",
    "Metallic Sea Green",
    "Metallic Olive Green",
    "Metallic Green",
    "Metallic Gasoline Blue Green",
    "Matte Lime Green",
    "Util Dark Green",
    "Util Green",
    "Worn Dark Green",
    "Worn Green",
    "Worn Sea Wash",
    "Metallic Midnight Blue",
    "Metallic Dark Blue",
    "Metallic Saxony Blue",
    "Metallic Blue",
    "Metallic Mariner Blue",
    "Metallic Harbor Blue",
    "Metallic Diamond Blue",
    "Metallic Surf Blue",
    "Metallic Nautical Blue",
    "Metallic Bright Blue",
    "Metallic Purple Blue",
    "Metallic Spinnaker Blue",
    "Metallic Ultra Blue",
    "Metallic Bright Blue",
    "Util Dark Blue",
    "Util Midnight Blue",
    "Util Blue",
    "Util Sea Foam Blue",
    "Uil Lightning blue",
    "Util Maui Blue Poly",
    "Util Bright Blue",
    "Matte Dark Blue",
    "Matte Blue",
    "Matte Midnight Blue",
    "Worn Dark blue",
    "Worn Blue",
    "Worn Light blue",
    "Metallic Taxi Yellow",
    "Metallic Race Yellow",
    "Metallic Bronze",
    "Metallic Yellow Bird",
    "Metallic Lime",
    "Metallic Champagne",
    "Metallic Pueblo Beige",
    "Metallic Dark Ivory",
    "Metallic Choco Brown",
    "Metallic Golden Brown",
    "Metallic Light Brown",
    "Metallic Straw Beige",
    "Metallic Moss Brown",
    "Metallic Biston Brown",
    "Metallic Beechwood",
    "Metallic Dark Beechwood",
    "Metallic Choco Orange",
    "Metallic Beach Sand",
    "Metallic Sun Bleeched Sand",
    "Metallic Cream",
    "Util Brown",
    "Util Medium Brown",
    "Util Light Brown",
    "Metallic White",
    "Metallic Frost White",
    "Worn Honey Beige",
    "Worn Brown",
    "Worn Dark Brown",
    "Worn straw beige",
    "Brushed Steel",
    "Brushed Black steel",
    "Brushed Aluminium",
    "Chrome",
    "Worn Off White",
    "Util Off White",
    "Worn Orange",
    "Worn Light Orange",
    "Metallic Securicor Green",
    "Worn Taxi Yellow",
    "police car blue",
    "Matte Green",
    "Matte Brown",
    "Worn Orange",
    "Matte White",
    "Worn White",
    "Worn Olive Army Green",
    "Pure White",
    "Hot Pink",
    "Salmon pink",
    "Metallic Vermillion Pink",
    "Orange",
    "Green",
    "Blue",
    "Mettalic Black Blue",
    "Metallic Black Purple",
    "Metallic Black Red",
    "hunter green",
    "Metallic Purple",
    "Metaillic V Dark Blue",
    "MODSHOP BLACK1",
    "Matte Purple",
    "Matte Dark Purple",
    "Metallic Lava Red",
    "Matte Forest Green",
    "Matte Olive Drab",
    "Matte Desert Brown",
    "Matte Desert Tan",
    "Matte Foilage Green",
    "Default Alloy Colour",
    "Epsilon Blue",
    "Pure Gold",
    "Brushed Gold",
    "Secret Gold",
}

local stat_query = "SELECT (SELECT COUNT(*) FROM mdt_arrest WHERE offender_character_id=@character_id) As 'arrest', (SELECT COUNT(*) FROM mdt_citation WHERE offender_character_id=@character_id) As 'citation', (SELECT COUNT(*) FROM mdt_warrant WHERE offender_character_id=@character_id) As 'warrant', (SELECT COUNT(*) FROM mdt_patient WHERE patient_character_id=@character_id) As 'treatment' FROM dual"
local arrest_query = "SELECT mdt_arrest.*, CONCAT(offender.first_name, ' ', offender.last_name) As 'offender_name', CONCAT(officer.first_name, ' ', officer.last_name) As 'officer_name' FROM mdt_arrest INNER JOIN characters offender ON mdt_arrest.offender_character_id = offender.character_id INNER JOIN characters officer ON mdt_arrest.officer_character_id = officer.character_id WHERE offender_character_id=@character_id"
local citation_query = "SELECT mdt_citation.*, CONCAT(offender.first_name, ' ', offender.last_name) As 'offender_name', CONCAT(officer.first_name, ' ', officer.last_name) As 'officer_name' FROM mdt_citation INNER JOIN characters offender ON mdt_citation.offender_character_id = offender.character_id INNER JOIN characters officer ON mdt_citation.officer_character_id = officer.character_id WHERE offender_character_id=@character_id"
local warrant_query = "SELECT mdt_warrant.*, CONCAT(offender.first_name, ' ', offender.last_name) As 'offender_name', CONCAT(officer.first_name, ' ', officer.last_name) As 'officer_name' FROM mdt_warrant INNER JOIN characters offender ON mdt_warrant.offender_character_id = offender.character_id INNER JOIN characters officer ON mdt_warrant.officer_character_id = officer.character_id WHERE offender_character_id=@character_id"
local vehicle_query = "SELECT plate, name, primary_colour, secondary_colour FROM vehicles WHERE offender_character_id=@character_id"
local patient_query = "SELECT mdt_patient.*, CONCAT(patient.first_name, ' ', patient.last_name) As 'patient_name', CONCAT(medic.first_name, ' ', medic.last_name) As 'medic_name' FROM mdt_patient INNER JOIN characters patient ON mdt_patient.patient_character_id = patient.character_id INNER JOIN characters medic ON mdt_patient.medic_character_id = medic.character_id WHERE patient_character_id=@character_id"
local death_query = "SELECT mdt_death.*, CONCAT(patient.first_name, ' ', patient.last_name) As 'patient_name', CONCAT(medic.first_name, ' ', medic.last_name) As 'medic_name' FROM mdt_death INNER JOIN characters patient ON mdt_death.patient_character_id = patient.character_id INNER JOIN characters medic ON mdt_death.medic_character_id = medic.character_id WHERE patient_character_id=@character_id"
local bolo_query = "SELECT mdt_bolo.*, CONCAT(officer.first_name, ' ', officer.last_name) As 'officer_name' FROM mdt_bolo INNER JOIN characters officer ON mdt_bolo.officer_character_id = officer.character_id"

RegisterServerEvent("mdt.loadplayer")
AddEventHandler("mdt.loadplayer", function(Data)
	local Source = source

	local query_params = {["@character_id"] = Data.character_id}
	exports['GHMattiMySQL']:QueryResultAsync(stat_query, query_params, function(Statistics)
		exports['GHMattiMySQL']:QueryResultAsync(arrest_query, query_params, function(Arrests)
			exports['GHMattiMySQL']:QueryResultAsync(citation_query, query_params, function(Citations)
				exports['GHMattiMySQL']:QueryResultAsync(warrant_query, query_params, function(Warrants)
					exports['GHMattiMySQL']:QueryResultAsync(vehicle_query, query_params, function(Vehicles)
						exports['GHMattiMySQL']:QueryResultAsync(patient_query, query_params, function(Treatments)
							exports['GHMattiMySQL']:QueryResultAsync(death_query, query_params, function(Deaths)
								TriggerClientEvent("mdt.loadplayer", Source, {Statistics = Statistics[1], Arrests = Arrests, Citations = Citations, Warrants = Warrants, Vehicles = Vehicles, Treatments = Treatments, Deaths = Deaths})
							end)
						end)
					end)
				end)
			end)
		end)
	end)
end)

RegisterNetEvent("mdt.loadplayer")
AddEventHandler("mdt.loadplayer", function(Data)
	for Index = 1, #Data.Vehicles do
		if Data.Vehicles[Index] then
			Data.Vehicles[Index].id = Data.Vehicles[Index].plate
			Data.Vehicles[Index].plate = strpad(string.format("%X", tostring(Data.Vehicles[Index].plate)), 8, "0", "STR_PAD_LEFT")
			Data.Vehicles[Index].primary_colour = Colours[Data.Vehicles[Index].primary_colour + 1]
			Data.Vehicles[Index].secondary_colour = Colours[Data.Vehicles[Index].secondary_colour + 1]
		end
	end
end)

sample_data = '[
"Statistics": ["arrest": 15, "citation": 15, "warrant": 2, "treatment": 50],
"Arrests": [
	["id": 1, "timestamp": 1537402737, "offender_name": "Eric Milton", "officer_name": "Ryleight Wolfhart", "sentence": 20, "fine": 20000, "charges": "* 5 x Attempted Murder of an LEO\n* 2 x Assault"],
	["id": 2, "timestamp": 1537402737, "offender_name": "Eric Milton", "officer_name": "Kelly Price", "sentence": 10, "fine": 10000, "charges": "* 5 x Battery\n* 2 x Assault"],
	["id": 3, "timestamp": 1537402737, "offender_name": "Mike Milton", "officer_name": "Klyde Campbell", "sentence": 5, "fine": 5000, "charges": "* 5 x Kidnapping\n* 2 x Assault"]
],
"Citations": [
	["id": 1, "timestamp": 1537402737, "offender_name": "Eric Milton", "officer_name": "Ryleight Wolfhart", "fine": 20000, "charges": "* 5 x Running a red light\n* 2 x Illegal U-turn", "plate": "00004AC1", "city": "Paleto Bay", "street", "Paleto road"],
	["id": 2, "timestamp": 1537402737, "offender_name": "Eric Milton", "officer_name": "Kelly Price", "fine": 10000, "charges": "* 5 x Careless driving\n* 2 x Running a red light", "plate": "00004000", "city": "Sandy Shores", "street", "Sandy Shores road"],
	["id": 3, "timestamp": 1537402737, "offender_name": "Mike Milton", "officer_name": "Klyde Campbell", "fine": 5000, "charges": "* 5 x Illegal Parking\n* 2 x Illegal U-turn", "plate": "00004B21", "city": "Paleto Bay", "street", "Paleto road"]
],
"Warrants": [
	["id": 1, "timestamp": 1537402737, "offender_name": "Eric Milton", "officer_name": "Ryleight Wolfhart", "description": "White male, red shorts, gray top", "charges": "* 5 x Attempted Murder of an LEO\n* 2 x Assault"],
	["id": 2, "timestamp": 1537402737, "offender_name": "Eric Milton", "officer_name": "Kelly Price", "description": "White male, red shorts, gray top", "charges": "* 5 x Battery\n* 2 x Assault"],
	["id": 3, "timestamp": 1537402737, "offender_name": "Mike Milton", "officer_name": "Klyde Campbell", "description": "White male, red shorts, gray top", "charges": "* 5 x Kidnapping\n* 2 x Assault"]
],
"Vehicles": [
	["id": 1, "plate": "00000001", "name": "Drift Tampa", "primary_colour": "Secret Gold", "secondary_colour": "Pure Gold"],
	["id": 2, "plate": "00000002", "name": "Tyrus", "primary_colour": "Epsilon Blue", "secondary_colour": "Matte Purple"],
	["id": 3, "plate": "00000003", "name": "Taipan", "primary_colour": "Metaillic V Dark Blue", "secondary_colour": "Green"]
],
"Treatments": [
	["id": 1, "timestamp": 1537402737, "patient_name": "Eric Milton", "medic_name": "Ryleight Wolfhart", "injuries": "Patient shot in the chest - Vest protected him. Bruising to ribs, otherwise fine.", "treatment": "Brought up in field and given advil for pain management", "hospitalised": 0, "life_support": 0, "sentence": 0],
	["id": 2, "timestamp": 1537402737, "patient_name": "Eric Milton", "medic_name": "Kelly Price", "injuries": "Bruising to right leg, Bruising to the head. ", "treatment": "Given a splint to immoblise his right leg as he was in a lot of pain. He was given an ice pack for his head for the bruising and advised to return to hospital immediately if the dizziness becomes more severe.", "hospitalised": 1, "life_support": 0, "sentence": 0],
	["id": 3, "timestamp": 1537402737, "patient_name": "Mike Milton", "medic_name": "Klyde Campbell", "injuries": "20x GSWs to chest", "treatment": "bandaged on scene before being taken to hospital for life saving Surgery", "hospitalised": 1, "life_support": 1, "sentence": 25]
],
"Deaths": [
	["id": 1, "timestamp": 1537402737, "patient_name": "Eric Milton", "medic_name": "Ryleight Wolfhart", "injuries": "Patient shot in the chest - Vest protected him. Bruising to ribs, otherwise fine.", "treatment": "Brought up in field and given advil for pain management", "death_cause": "Ran out of blood /shrug", "hospitalised": 0, "life_support": 0, "sentence": 0],
	["id": 2, "timestamp": 1537402737, "patient_name": "Eric Milton", "medic_name": "Kelly Price", "injuries": "Bruising to right leg, Bruising to the head. ", "treatment": "Given a splint to immoblise his right leg as he was in a lot of pain. He was given an ice pack for his head for the bruising and advised to return to hospital immediately if the dizziness becomes more severe.", "death_cause": "Ran out of something /shrug", "hospitalised": 1, "life_support": 0, "sentence": 0],
	["id": 3, "timestamp": 1537402737, "patient_name": "Mike Milton", "medic_name": "Klyde Campbell", "injuries": "20x GSWs to chest", "treatment": "bandaged on scene before being taken to hospital for life saving Surgery", "death_cause": "Ran out of blood /shrug", "hospitalised": 1, "life_support": 1, "sentence": 25]
],
]'
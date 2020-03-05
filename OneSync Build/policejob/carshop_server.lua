local policeVehicles = {
	{name = "Marked Transport", model = "policet", price = 0, rank = "cadet"},
	{name = "Prison Bus", model = "pbus", price = 0, rank = "cadet"},
	{name = "2011 Marked CVPI", model = "pd1", price = 0, rank = "recruit"},
	{name = "2010 Marked Charger", model = "pd9", price = 0, rank = "officer i"},
	{name = "2014 Marked Charger", model = "pd2", price = 0, rank = "officer i"},
	{name = "2014 Marked Charger EXL", model = "statep2", price = 0, rank = "officer ii"},
	{name = "Marked Motorcycle", model = "policebmw", price = 0, rank = "officer i"},
	{name = "2016 Marked Raptor", model = "fraptor", price = 0, rank = "officer i"},
	{name = "2014 Marked Tahoe", model = "pd8", price = 0, rank = "officer ii"},
	{name = "2016 Marked Taurus", model = "pd7", price = 0, rank = "officer ii"},
	{name = "2016 Marked Charger", model = "pd3", price = 0, rank = "officer ii"},
	{name = "2016 Marked Tahoe", model = "pd6", price = 0, rank = "officer ii"},
	{name = "2016 Marked Explorer", model = "pd5", price = 0, rank = "officer ii"},
	{name = "Interceptor Mustang", model = "2015polstang", price = 0, rank = "officer ii"},
	{name = "2011 Slicktop CVPI", model = "pd11", price = 0, rank = "detective"},
	{name = "2014 Slicktop Charger", model = "pd12", price = 0, rank = "detective"},
	{name = "2016 Slicktop Charger", model = "pd13", price = 0, rank = "detective"},
	{name = "2016 Slicktop Explorer", model = "pd15", price = 0, rank = "detective"},
	{name = "Unmarked CVPI", model = "police4", price = 0, rank = "detective"},
	{name = "Unmarked Panto", model = "upanto", price = 0, rank = "detective"},
	{name = "Unmarked Buffalo", model = "fbi", price = 0, rank = "detective"},
	{name = "Unmarked Taxi", model = "uc_taxi", price = 0, rank = "detective"},
	{name = "Unmarked Coquette", model = "uc_coquette", price = 0, rank = "detective"},
	{name = "Unmarked Sultan", model = "uc_sultan", price = 0, rank = "detective"},
	{name = "Unmarked Kuruma", model = "uc_kuruma", price = 0, rank = "detective"},
	{name = "Unmarked 2013 Impala", model = "um1", price = 0, rank = "detective"},
	{name = "Unmarked 2016 Raptor", model = "um6", price = 0, rank = "lieutenant"},
	{name = "Unmarked 2018 Charger", model = "18charger", price = 0, rank = "lieutenant"},
	{name = "Unmarked 2016 Tahoe", model = "um4", price = 0, rank = "captain"},
}

local function GetVehicleData()
	local data = {
		garage_id = -1,
		state = "~r~Missing",
		primary_colour = 1,
		secondary_colour = 0,
		pearlescent_colour = 0,
		wheel_colour = 0,
		smoke_colour = {255, 255, 255},
		plate_colour = 0,
		neon_colour = {255, 255, 255},
		tint_colour = -1,
		tyre_smoke = "off",
		xenon_lights = "off",
		turbo = "off",
		custom_wheels = "off",
		custom_wheels2 = "off",
		bulletproof_wheels = "off",
		wheeltype = 0,
		neon0 = "off",
		neon1 = "off",
		neon2 = "off",
		neon3 = "off",
		engine_health = 1000,
		petrol_health = 1000,
		body_health = 1000,
		vehicle_health = 1000,
		insurance = "true",
		claims = 1,
		livery = -1,
		headlight_colour = -1,
		dashboard_colour = -1,
		interior_colour = -1,
		instance = 0,
	}
	
	for i = 0, 8 do
		data["mod"..i] = -1
	end
	
	for i = 10, 16 do
		data["mod"..i] = -1
	end
	
	for i = 23, 46 do
		data["mod"..i] = -1
	end
	
	data["mod48"] = -1
	
	for i = 1, 15 do
		data["extra"..i] = false
	end

	return data
end

local function strpad(input, pad_length, pad_string, pad_type)
	local output = input

	if not pad_string then pad_string = ' ' end
	if not pad_type   then pad_type   = 'STR_PAD_RIGHT' end

	if pad_type == 'STR_PAD_BOTH' then
		local j = 0
		while string.len(output) < pad_length do
			output = j % 2 == 0 and output .. pad_string or pad_string .. output
			j = j + 1
		end
	else
		while string.len(output) < pad_length do
			output = pad_type == 'STR_PAD_LEFT' and pad_string .. output or output .. pad_string
		end
	end

	return output
end

RegisterNetEvent("policeVehicle:buy")
AddEventHandler("policeVehicle:buy", function(idx, spawn)
	local src = source

	if policeVehicles[idx] then
		local vehicle = policeVehicles[idx]

		local option = 0

		TriggerEvent("core:getuser", src, function(user)
			if user.get("wallet") >= vehicle.price then
				option = 1
			elseif user.get("bank") >= vehicle.price then
				option = 2
			end

			if option == 1 then
				user.removeWallet(vehicle.price)
			elseif option == 2 then
				user.removeBank(vehicle.price)
			end

			if option > 0 then
				local data = GetVehicleData()

				data.name = vehicle.name
				data.model = vehicle.model
				data.cost = vehicle.price / 2

				exports["GHMattiMySQL"]:Insert("vehicles", {
					{
						["character_id"] = user.get("characterID"),
						["garage_id"] = data.garage_id,
						["model"] = data.model,
						["name"] = data.name,
						["instance"] = data.instance,
						["state"] = data.state,
						["cost"] = data.cost,
						["primary_colour"] = data.primary_colour,
						["secondary_colour"] = data.secondary_colour,
						["pearlescent_colour"] = data.pearlescent_colour,
						["wheel_colour"] = data.wheel_colour,
						["smoke_colour"] = json.encode(data.smoke_colour),
						["plate_colour"] = data.plate_colour,
						["neon_colour"] = json.encode(data.neon_colour),
						["tint_colour"] = data.tint_colour,
						["mod0"] = data.mod0,
						["mod1"] = data.mod1,
						["mod2"] = data.mod2,
						["mod3"] = data.mod3,
						["mod4"] = data.mod4,
						["mod5"] = data.mod5,
						["mod6"] = data.mod6,
						["mod7"] = data.mod7,
						["mod8"] = data.mod8,
						["mod9"] = data.mod9,
						["mod10"] = data.mod1,
						["mod11"] = data.mod11,
						["mod12"] = data.mod12,
						["mod13"] = data.mod13,
						["mod14"] = data.mod14,
						["mod15"] = data.mod15,
						["mod16"] = data.mod16,
						["mod23"] = data.mod23,
						["mod24"] = data.mod24,
						["mod25"] = data.mod25,
						["mod26"] = data.mod26,
						["mod27"] = data.mod27,
						["mod28"] = data.mod28,
						["mod29"] = data.mod29,
						["mod30"] = data.mod30,
						["mod31"] = data.mod31,
						["mod32"] = data.mod32,
						["mod33"] = data.mod33,
						["mod34"] = data.mod34,
						["mod35"] = data.mod35,
						["mod36"] = data.mod36,
						["mod37"] = data.mod37,
						["mod38"] = data.mod38,
						["mod39"] = data.mod39,
						["mod40"] = data.mod40,
						["mod41"] = data.mod41,
						["mod42"] = data.mod42,
						["mod43"] = data.mod43,
						["mod44"] = data.mod44,
						["mod45"] = data.mod45,
						["mod46"] = data.mod46,
						["mod48"] = data.mod48,
						["tyre_smoke"] = data.tyre_smoke,
						["xenon_lights"] = data.xenon_lights,
						["turbo"] = data.turbo,
						["custom_wheels"] = data.custom_wheels,
						["custom_wheels2"] = data.custom_wheels2,
						["bulletproof_wheels"] = data.bulletproof_wheels,
						["wheeltype"] = data.wheeltype,
						["neon0"] = data.neon0,
						["neon1"] = data.neon1,
						["neon2"] = data.neon2,
						["neon3"] = data.neon3,
						["engine_health"] = data.engine_health,
						["petrol_health"] = data.petrol_health,
						["vehicle_health"] = data.vehicle_health,
						["body_health"] = data.body_health,
						["insurance"] = data.insurance,
						["claims"] = data.claims,
						["livery"] = data.livery,
						["headlight_colour"] = data.headlight_colour,
						["dashboard_colour"] = data.dashboard_colour,
						["interior_colour"] = data.interior_colour,
						["police"] = 1,
					}
				}, function(plate)
					data.plate = plate
					data.plate = string.format("%X", tostring(data.plate))
					data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")

					TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = "success", text = vehicle.name .. " purchased!" })
					TriggerClientEvent("policeVehicle:bought", src, data, spawn)
				end, true)
			else
				TriggerClientEvent("mythic_notify:client:SendAlert", src, { type = "error", text = "Insufficient funds!" })
			end
		end)
	end
end)
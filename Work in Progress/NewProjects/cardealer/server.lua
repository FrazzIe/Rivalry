local DisplayedVehicles = {}
local CarDealers = {}
AddEventHandler("CarDealer:Initialise", function(source, identifier, character_id)
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM cardealer WHERE character_id = @character_id", {["@character_id"] = character_id}, function(result)
		if result[1] == nil then
			TriggerClientEvent("CarDealer:Set", source, {}, false, true)
		else
			CarDealers[source] = result[1]
			TriggerClientEvent("CarDealer:Set", source, CarDealers[source], true, true)
		end
	end)
end)

RegisterServerEvent("Spawn.DisplayVehicle")
AddEventHandler("Spawn.DisplayVehicle", function(Vehicle)
	local Source = source
	DisplayedVehicles = table.insert(Vehicle, DisplayedVehicles)
	TriggerServerEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
end)

RegisterServerEvent("Retrieve.DisplayVehicles")
AddEventHandler("Retrieve.DisplayVehicles", function()
	local Source = source
	TriggerClientEvent("DisplayVehicles.Sync", Source, DisplayedVehicles)
end)

RegisterServerEvent("CarDealer.BuyCar")
AddEventHandler("CarDealer.BuyCar", function(Type, Index)
    local Source = source
    TriggerEvent("core:getuser", Source, function(User)
        local data = DisplayedVehicles[Index].Data
        if Type == 0 then
            if tonumber(user.get("wallet")) >= tonumber(DisplayedVehicles[Index].Price) then
                user.removeWallet(DisplayedVehicles[Index].Price)
                exports["GHMattiMySQL"]:Insert("vehicles", {
                    {
                        ["character_id"] = user.get("characterID"),
                        ["garage_id"] = data.garage_id,
                        ["model"] = data.model,
                        ["name"] = data.name,
                        ["instance"] = data.instance,
                        ["state"] = data.state,
                        ["cost"] = DisplayedVehicles[Index].Price,
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
                        ["fuel"] = data.fuel,
                        ["weeks"] = DisplayedVehicles[Index].Weeks,
                        ["intrest"] = DisplayedVehicles[Index].Intrest,
                        ["payedoff"] = 0
                    }
                }, function(plate)
                    data.cost = MonthlyPayment
                    data.plate = plate
                    data.plate = string.format("%X", tostring(data.plate))
                    data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    TriggerClientEvent("carshop:bought", Source, data)
                end, true)
            elseif tonumber(user.get("bank")) >= tonumber(DisplayedVehicles[Index].Price) then
                user.removeBank(DisplayedVehicles[Index].Price)
                exports["GHMattiMySQL"]:Insert("vehicles", {
                    {
                        ["character_id"] = user.get("characterID"),
                        ["garage_id"] = data.garage_id,
                        ["model"] = data.model,
                        ["name"] = data.name,
                        ["instance"] = data.instance,
                        ["state"] = data.state,
                        ["cost"] = DisplayedVehicles[Index].Price,
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
                        ["fuel"] = data.fuel,
                        ["weeks"] = DisplayedVehicles[Index].Weeks,
                        ["intrest"] = DisplayedVehicles[Index].Intrest,
                        ["payedoff"] = 0
                    }
                }, function(plate)
                    data.cost = MonthlyPayment
                    data.plate = plate
                    data.plate = string.format("%X", tostring(data.plate))
                    data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    TriggerClientEvent("carshop:bought", Source, data)
                end, true)
            else
                TriggerClientEvent("pNotify:SendNotification", Source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
            end
        elseif Type == 1 then
            local Intrest = ( ( DisplayedVehicles[Index].Price * ( DisplayedVehicles[Index].Intrest / 100) ) * ( ( DisplayedVehicles[Index].Weeks * 7 ) / 360 ) )
            local MonthlyPayment = ( ( DisplayedVehicles[Index].Price / DisplayedVehicles[Index].Weeks ) + Intrest )
            if tonumber(user.get("wallet")) >= tonumber(MonthlyPayment) then
                user.removeWallet(MonthlyPayment)
                exports["GHMattiMySQL"]:Insert("vehicles", {
                    {
                        ["character_id"] = user.get("characterID"),
                        ["garage_id"] = data.garage_id,
                        ["model"] = data.model,
                        ["name"] = data.name,
                        ["instance"] = data.instance,
                        ["state"] = data.state,
                        ["cost"] = DisplayedVehicles[Index].Price,
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
                        ["fuel"] = data.fuel,
                        ["weeks"] = DisplayedVehicles[Index].Weeks,
                        ["intrest"] = DisplayedVehicles[Index].Intrest,
                        ["payedoff"] = ( MonthlyPayment * DisplayedVehicles[Index].Weeks ) - MonthlyPayment
                    }
                }, function(plate)
                    data.cost = MonthlyPayment
                    data.plate = plate
                    data.plate = string.format("%X", tostring(data.plate))
                    data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    TriggerClientEvent("carshop:bought", Source, data)
                end, true)
            elseif tonumber(user.get("bank")) >= tonumber(MonthlyPayment) then
                user.removeBank(MonthlyPayment)
                exports["GHMattiMySQL"]:Insert("vehicles", {
                    {
                        ["character_id"] = user.get("characterID"),
                        ["garage_id"] = data.garage_id,
                        ["model"] = data.model,
                        ["name"] = data.name,
                        ["instance"] = data.instance,
                        ["state"] = data.state,
                        ["cost"] = DisplayedVehicles[Index].Price,
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
                        ["fuel"] = data.fuel,
                        ["weeks"] = DisplayedVehicles[Index].Weeks,
                        ["intrest"] = DisplayedVehicles[Index].Intrest,
                        ["payedoff"] = ( MonthlyPayment * DisplayedVehicles[Index].Weeks ) - MonthlyPayment
                    }
                }, function(plate)
                    data.cost = MonthlyPayment
                    data.plate = plate
                    data.plate = string.format("%X", tostring(data.plate))
                    data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    TriggerClientEvent("carshop:bought", Source, data)
                end, true)
            else
                TriggerClientEvent("pNotify:SendNotification", Source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
            end
        else
            TriggerEvent("core:anticheat-ban", Source)
        end
    end)
end)

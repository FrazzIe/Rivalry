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
	table.insert(DisplayedVehicles, Vehicle)
	TriggerClientEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
end)

RegisterServerEvent("Retrieve.DisplayVehicles")
AddEventHandler("Retrieve.DisplayVehicles", function(Source)
	TriggerClientEvent("DisplayVehicles.Sync", Source, DisplayedVehicles)
end)

RegisterServerEvent("Change.DisplayVehicle")
AddEventHandler("Change.DisplayVehicle", function(Vehicle, Index)
    DisplayedVehicles[Index] = Vehicle
    TriggerClientEvent("DisplayedVehicles.Sync", -1, DisplayedVehicles)
end)

RegisterServerEvent("CarDealer.BuyCar")
AddEventHandler("CarDealer.BuyCar", function(Type, Index, GarageID, Reduction)
    local Source = source
    TriggerEvent("core:getuser", Source, function(User)
        local data = DisplayedVehicles[Index].Data
        if Type == 0 then
            if tonumber(User.get("wallet")) >= tonumber(DisplayedVehicles[Index].Price) then
                User.removeWallet(DisplayedVehicles[Index].Price)
                exports["GHMattiMySQL"]:Insert("vehicles", {
                    {
                        ["character_id"] = User.get("characterID"),
                        ["garage_id"] = GarageID,
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
                    TriggerClientEvent("carshop:bought", Source, data, DisplayedVehicles[Index].Entity)
                    DealerSoldVehicle(DisplayedVehicles[Index].Seller)
                    table.remove(DisplayedVehicles, Index)
                    TriggerClientEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
                end, true)
            elseif tonumber(User.get("bank")) >= tonumber(DisplayedVehicles[Index].Price) then
                User.removeBank(DisplayedVehicles[Index].Price)
                exports["GHMattiMySQL"]:Insert("vehicles", {
                    {
                        ["character_id"] = User.get("characterID"),
                        ["garage_id"] = GarageID,
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
                    TriggerClientEvent("carshop:bought", Source, data, DisplayedVehicles[Index].Entity)
                    DealerSoldVehicle(DisplayedVehicles[Index].Seller)
                    table.remove(DisplayedVehicles, Index)
                    TriggerClientEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
                end, true)
            else
                TriggerClientEvent("pNotify:SendNotification", Source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
            end
        elseif Type == 1 then
            local didReduce = false
            if Reduction > 0 then
                if tonumber(User.get("wallet")) >= Reduction then
                    User.removeWallet(Reduction)
                    DisplayedVehicles[Index].Price = DisplayedVehicles[Index].Price - Reduction
                    didReduce = true
                    TriggerClientEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
                elseif tonumber(User.get("bank")) >= Reduction then
                    User.removeBank(Reduction)
                    DisplayedVehicles[Index].Price = DisplayedVehicles[Index].Price - Reduction
                    didReduce = true
                    TriggerClientEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
                else
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                end
            end
            local Intrest = ( ( DisplayedVehicles[Index].Price * ( DisplayedVehicles[Index].Intrest / 100) ) * ( ( DisplayedVehicles[Index].Weeks * 7 ) / 360 ) )
            local MonthlyPayment = ( ( DisplayedVehicles[Index].Price / DisplayedVehicles[Index].Weeks ) + Intrest )
            if tonumber(User.get("wallet")) >= tonumber(MonthlyPayment + DisplayedVehicles[Index].CashDown) then
                User.removeWallet(MonthlyPayment + DisplayedVehicles[Index].CashDown)
                exports["GHMattiMySQL"]:Insert("vehicles", {
                    {
                        ["character_id"] = User.get("characterID"),
                        ["garage_id"] = GarageID,
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
                        ["payedoff"] = ( MonthlyPayment * DisplayedVehicles[Index].Weeks ) - MonthlyPayment,
                        ["lastpayment"] = tostring(os.time()),
                        ["nextpayment"] = tostring(os.time() + 604800)
                    }
                }, function(plate)
                    data.cost = MonthlyPayment
                    data.plate = plate
                    data.plate = string.format("%X", tostring(data.plate))
                    data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    TriggerClientEvent("carshop:bought", Source, data, DisplayedVehicles[Index].Entity)
                    DealerSoldVehicle(DisplayedVehicles[Index].Seller)
                    table.remove(DisplayedVehicles, Index)
                    TriggerClientEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
                end, true)
            elseif tonumber(User.get("bank")) >= tonumber(MonthlyPayment + DisplayedVehicles[Index].CashDown) then
                User.removeBank(MonthlyPayment + DisplayedVehicles[Index].CashDown)
                exports["GHMattiMySQL"]:Insert("vehicles", {
                    {
                        ["character_id"] = User.get("characterID"),
                        ["garage_id"] = GarageID,
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
                        ["payedoff"] = ( MonthlyPayment * DisplayedVehicles[Index].Weeks ) - MonthlyPayment,
                        ["lastpayment"] = tostring(os.time()),
                        ["nextpayment"] = tostring(os.time() + 604800)
                    }
                }, function(plate)
                    data.cost = MonthlyPayment
                    data.plate = plate
                    data.plate = string.format("%X", tostring(data.plate))
                    data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    TriggerClientEvent("carshop:bought", Source, data, DisplayedVehicles[Index].Entity)
                    TriggerClientEvent("Dealer.SoldCar", DisplayedVehicles[Index].Seller)
                    DealerSoldVehicle(DisplayedVehicles[Index].Seller, Intrest, DisplayedVehicles[Index].Price)
                    table.remove(DisplayedVehicles, Index)
                    TriggerClientEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
                end, true)
            else
                TriggerClientEvent("pNotify:SendNotification", Source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                if didReduce == true then
                    User.addBank(Reduction)
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "You have been refunded the money to your bank that you placed down on the vehicle!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    DisplayedVehicles[Index].Price = DisplayedVehicles[Index].Price + Reduction
                    TriggerClientEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
                    didReduce = false
                end
            end
        else
            TriggerEvent("core:anticheat-ban", Source)
        end
    end)
end)

RegisterServerEvent("Dealer.GivePayment")
AddEventHandler("Dealer.GivePayment", function(Profit)
    local Source = source
    TriggerEvent("core:getuser", Source, function(User)
        if Profit ~= nil then
            if Profit > 0 then
                TriggerClientEvent("pNotify:SendNotification", Source, {text = "You've made $"..Profit.." of commissionn from that sale!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                User.addBank(Profit)
            end
        end
    end)
end)

function DealerSoldVehicle(Seller, Intrest, Price)
    TriggerEvent("core:getuser", Seller, function(Dealer)
        exports["GHMattiMySQL"]:QueryAsync("UPDATE cardealer SET sold = sold + 1 WHERE (character_id = @character_id)", {
            ["@character_id"] = Dealer.get("characterID"),
        })
        exports["GHMattiMySQL"]:QueryAsync("UPDATE carsales SET bank = bank + @intrest WHERE (id = @id)", {
            ["@intrest"] = Intrest,
            ["@id"] = 1
        })
        TriggerClientEvent("Dealer.SoldVehicle", Seller, Price)
    end)
end
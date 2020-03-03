local displayedVehicles = {
    ["normal"] = {},
    ["luxary"] = {},
    ["import"] = {},
}
local CarDealers = {}
local dealerTypes = {
    ["normal"] = true,
    ["luxary"] = true,
    ["import"] = true,
}
local dealerTypeNames = { -- Store name
    ["normal"] = "PDM",
    ["luxary"] = "Luxary Autos",
    ["import"] = "",   
}
local dealerBanks = {
    ["normal"] = 1,
    ["luxary"] = 2,
    ["import"] = 3,
}
local rankTypes = {
    ["associate"] = true,
    ["senior associate"] = true,
    ["supervisor"] = true,
    ["manager"] = true,
}

local function GenerateRankList()
    local list = ""
    local count = 1

    for k,v in pairs(rankTypes) do
        if count == 1 then
            list = list .. k
        else
            list = list .. ", " .. k
        end

        count = count + 1
    end

    return list
end

local function GenerateDealerTypeList()
    local list = ""
    local count = 1

    for k,v in pairs(dealerTypes) do
        if count == 1 then
            list = list .. k
        else
            list = list .. ", " .. k
        end

        count = count + 1
    end

    return list
end

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

TriggerEvent("core:addGroupCommand", "cardealeradd", "command", function(source, args, rawCommand, data, power, group)
    local source = source
    
	if #args < 1 then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /cardealeradd [id] [rank] [type]")	
    else
        local id = tonumber(args[1])
        local rank = "associate"
        local type = "normal"

        if args[2] then
            rank = args[2]:lower()
        end

        if args[3] then
            type = args[3]:lower()
        end

        if rankTypes[rank] then
            if dealerTypes[type] then
                if GetPlayerName(id) ~= nil then
                    TriggerEvent("core:getuser", id, function(target)
                        CarDealers[id] = nil

                        exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM cardealer WHERE character_id=@character_id", {
                            ["@character_id"] = target.get("characterID"),
                        }, function(result)
                            local query = ""
                            if #result > 0 then --update
                                query = "UPDATE cardealer SET rank=@rank, type=@type WHERE character_id=@character_id"
                            else
                                query = "INSERT cardealer (`character_id`, `rank`, `type`) VALUES (@character_id, @rank, @type)"
                            end

                            exports["GHMattiMySQL"]:QueryAsync(query, {
                                ["@character_id"] = target.get("characterID"),
                                ["@rank"] = rank,
                                ["@type"] = type,
                            })
                        end)

                        CarDealers[id] = { character_id = target.get("characterID"), rank = rank, sold = 0, type = type }

                        Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>You</span> have been hired! <br> Congratulations on joining the "..dealerTypeNames[type], 10000, id)

                        TriggerClientEvent("CarDealer:Set", id, CarDealers[source], true, true)
                    end)
                else
                    TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid player id!")
                end
            else
                TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid type: " .. GenerateDealerTypeList())
            end
        else
            TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid rank: " .. GenerateRankList())
        end
	end
end, { help = "Add a player to the whitelisted car dealer", params = { {name = "id", help = "The id of the player"}, {name = "type", help = "Ranks: ".. GenerateRankList() }, {name = "type", help = "Dealer type: ".. GenerateDealerTypeList() } } })

TriggerEvent("core:addGroupCommand", "cardealerrem", "command", function(source, args, rawCommand, data, power, group)
	local source = source
	if #args < 1 then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /cardealerrem [ID]")	
    else
        local id = tonumber(args[1])

		if GetPlayerName(id) then
			if CarDealers[id] ~= nil then
				TriggerEvent("core:getuser", id, function(target)
					CarDealers[id] = nil
					exports['GHMattiMySQL']:QueryAsync("DELETE FROM cardealer WHERE character_id=@character_id", {["@character_id"] = target.get("characterID")})
					TriggerClientEvent("CarDealer:Set", source, {}, false, true)
				end)
			else
				Notify("This user is not apart of any dealerships!", 3000, source)
			end
		else
			Notify("No player with this id!", 3000, source)
		end
	end
end, {help = "Remove a player from the Whitelisted Car Dealer", params = {{name = "id", help = "The id of the player"}}})

RegisterServerEvent("Spawn.DisplayVehicle")
AddEventHandler("Spawn.DisplayVehicle", function(Store, Vehicle)
	local Source = source
	table.insert(displayedVehicles[Store], Vehicle)
	TriggerClientEvent("DisplayVehicles.Sync", -1, displayedVehicles)
end)

RegisterServerEvent("Retrieve.DisplayVehicles")
AddEventHandler("Retrieve.DisplayVehicles", function(Source)
	TriggerClientEvent("DisplayVehicles.Sync", Source, displayedVehicles)
end)

RegisterServerEvent("Change.DisplayVehicle")
AddEventHandler("Change.DisplayVehicle", function(Vehicle, Store, Index)
    displayedVehicles[Store][Index] = Vehicle
    TriggerClientEvent("DisplayVehicles.Sync", -1, displayedVehicles)
end)

RegisterServerEvent("Spawn.PoliceCar")
AddEventHandler("Spawn.PoliceCar", function(DataTable, Vehicle)
    local Source = source
    local data = DataTable

    local _data = {}

    for i = 1, 15 do
        _data["extra"..i] = (data["extra"..i] == true) and 1 or 0
    end

    TriggerEvent("core:getuser", Source, function(User)
        exports["GHMattiMySQL"]:Insert("vehicles", {
            {
                ["character_id"] = User.get("characterID"),
                ["garage_id"] = 911,
                ["model"] = data.model,
                ["name"] = data.name,
                ["instance"] = data.instance,
                ["state"] = data.state,
                ["cost"] = 0,
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
                ["fuel"] = 100,
                ["weeks"] = 0,
                ["interest"] = 0,
                ["payedoff"] = 0,
                ["police"] = 1,
                ["livery"] = data.livery,
                ["extra1"] = _data.extra1,
                ["extra2"] = _data.extra2,
                ["extra3"] = _data.extra3,
                ["extra4"] = _data.extra4,
                ["extra5"] = _data.extra5,
                ["extra6"] = _data.extra6,
                ["extra7"] = _data.extra7,
                ["extra8"] = _data.extra8,
                ["extra9"] = _data.extra9,
                ["extra10"] = _data.extra10,
                ["extra11"] = _data.extra11,
                ["extra12"] = _data.extra12,
                ["extra13"] = _data.extra13,
                ["extra14"] = _data.extra14,
                ["extra15"] = _data.extra15,
                ["headlight_colour"] = data.headlight_colour,
                ["dashboard_colour"] = data.dashboard_colour,
                ["interior_colour"] = data.interior_colour,
            }
        }, function(plate)
            data.plate = plate
            data.plate = string.format("%X", tostring(data.plate))
            data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
            TriggerClientEvent("policecar:bought", Source, data, Vehicle)
            TriggerClientEvent("carshop:setplate", -1, data.plate, Vehicle)
            TriggerEvent("garage:initialise", Source, "", User.get("characterID"))
        end, true)
    end)
end)

RegisterServerEvent("CarDealer.BuyCar")
AddEventHandler("CarDealer.BuyCar", function(Type, Store, Index, GarageID, Reduction)
    local Source = source
    TriggerEvent("core:getuser", Source, function(User)
        TriggerEvent("core:getuser", displayedVehicles[Store][Index].Seller, function(Dealer)
            local data = displayedVehicles[Store][Index].Data

            local _data = {}

            for i = 1, 15 do
                _data["extra"..i] = (data["extra"..i] == true) and 1 or 0
            end
            
            if Type == 0 then
                if tonumber(User.get("wallet")) >= tonumber(displayedVehicles[Store][Index].Price) then
                    User.removeWallet(displayedVehicles[Store][Index].Price)
                    exports["GHMattiMySQL"]:Insert("vehicles", {
                        {
                            ["character_id"] = User.get("characterID"),
                            ["garage_id"] = GarageID,
                            ["model"] = data.model,
                            ["name"] = data.name,
                            ["instance"] = data.instance,
                            ["state"] = data.state,
                            ["cost"] = displayedVehicles[Store][Index].Price,
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
                            ["weeks"] = displayedVehicles[Store][Index].Weeks,
                            ["interest"] = displayedVehicles[Store][Index].Interest,
                            ["payedoff"] = 0,
                            ["livery"] = data.livery,
                            ["extra1"] = _data.extra1,
                            ["extra2"] = _data.extra2,
                            ["extra3"] = _data.extra3,
                            ["extra4"] = _data.extra4,
                            ["extra5"] = _data.extra5,
                            ["extra6"] = _data.extra6,
                            ["extra7"] = _data.extra7,
                            ["extra8"] = _data.extra8,
                            ["extra9"] = _data.extra9,
                            ["extra10"] = _data.extra10,
                            ["extra11"] = _data.extra11,
                            ["extra12"] = _data.extra12,
                            ["extra13"] = _data.extra13,
                            ["extra14"] = _data.extra14,
                            ["extra15"] = _data.extra15,
                            ["headlight_colour"] = data.headlight_colour,
                            ["dashboard_colour"] = data.dashboard_colour,
                            ["interior_colour"] = data.interior_colour,
                            ["seller"] = Dealer.get("characterID"),
                        }
                    }, function(plate)
                        data.plate = plate
                        data.plate = string.format("%X", tostring(data.plate))
                        data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                        TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                        TriggerClientEvent("carshop:bought", Source, data, displayedVehicles[Store][Index].Entity, Store)
                        TriggerClientEvent("carshop:setplate", -1, data.plate, displayedVehicles[Store][Index].Entity)
                        DealerSoldVehicle(displayedVehicles[Store][Index].Seller, 0, displayedVehicles[Store][Index].Price, Store)
                    end, true)
                elseif tonumber(User.get("bank")) >= tonumber(displayedVehicles[Store][Index].Price) then
                    User.removeBank(displayedVehicles[Store][Index].Price)
                    exports["GHMattiMySQL"]:Insert("vehicles", {
                        {
                            ["character_id"] = User.get("characterID"),
                            ["garage_id"] = GarageID,
                            ["model"] = data.model,
                            ["name"] = data.name,
                            ["instance"] = data.instance,
                            ["state"] = data.state,
                            ["cost"] = displayedVehicles[Store][Index].Price,
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
                            ["weeks"] = displayedVehicles[Store][Index].Weeks,
                            ["interest"] = displayedVehicles[Store][Index].Interest,
                            ["payedoff"] = 0,
                            ["livery"] = data.livery,
                            ["extra1"] = _data.extra1,
                            ["extra2"] = _data.extra2,
                            ["extra3"] = _data.extra3,
                            ["extra4"] = _data.extra4,
                            ["extra5"] = _data.extra5,
                            ["extra6"] = _data.extra6,
                            ["extra7"] = _data.extra7,
                            ["extra8"] = _data.extra8,
                            ["extra9"] = _data.extra9,
                            ["extra10"] = _data.extra10,
                            ["extra11"] = _data.extra11,
                            ["extra12"] = _data.extra12,
                            ["extra13"] = _data.extra13,
                            ["extra14"] = _data.extra14,
                            ["extra15"] = _data.extra15,
                            ["headlight_colour"] = data.headlight_colour,
                            ["dashboard_colour"] = data.dashboard_colour,
                            ["interior_colour"] = data.interior_colour,
                            ["seller"] = Dealer.get("characterID"),
                        }
                    }, function(plate)
                        data.plate = plate
                        data.plate = string.format("%X", tostring(data.plate))
                        data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                        TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                        TriggerClientEvent("carshop:bought", Source, data, displayedVehicles[Store][Index].Entity, Store)
                        TriggerClientEvent("carshop:setplate", -1, data.plate, displayedVehicles[Store][Index].Entity)
                        DealerSoldVehicle(displayedVehicles[Store][Index].Seller, 0, displayedVehicles[Store][Index].Price, Store)
                    end, true)
                else
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                end
            elseif Type == 1 then
                local didReduce = false
                if Reduction > 0 then
                    if tonumber(User.get("wallet")) >= Reduction then
                        User.removeWallet(Reduction)
                        displayedVehicles[Store][Index].Price = displayedVehicles[Store][Index].Price - Reduction
                        didReduce = true
                        TriggerClientEvent("DisplayVehicles.Sync", -1, displayedVehicles)
                    elseif tonumber(User.get("bank")) >= Reduction then
                        User.removeBank(Reduction)
                        displayedVehicles[Store][Index].Price = displayedVehicles[Store][Index].Price - Reduction
                        didReduce = true
                        TriggerClientEvent("DisplayVehicles.Sync", -1, displayedVehicles)
                    else
                        TriggerClientEvent("pNotify:SendNotification", Source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    end
                end
                local Interest = ( ( displayedVehicles[Store][Index].Price * ( displayedVehicles[Store][Index].Interest / 100) ) * ( ( displayedVehicles[Store][Index].Weeks * 7 ) / 360 ) )
                local MonthlyPayment = ( ( displayedVehicles[Store][Index].Price / displayedVehicles[Store][Index].Weeks ) + Interest )
                if tonumber(User.get("wallet")) >= tonumber(MonthlyPayment + displayedVehicles[Store][Index].CashDown) then
                    User.removeWallet(MonthlyPayment + displayedVehicles[Store][Index].CashDown)
                    exports["GHMattiMySQL"]:Insert("vehicles", {
                        {
                            ["character_id"] = User.get("characterID"),
                            ["garage_id"] = GarageID,
                            ["model"] = data.model,
                            ["name"] = data.name,
                            ["instance"] = data.instance,
                            ["state"] = data.state,
                            ["cost"] = displayedVehicles[Store][Index].Price,
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
                            ["weeks"] = displayedVehicles[Store][Index].Weeks,
                            ["interest"] = displayedVehicles[Store][Index].Interest,
                            ["payedoff"] = ( MonthlyPayment * displayedVehicles[Store][Index].Weeks ) - MonthlyPayment,
                            ["lastpayment"] = tostring(os.time()),
                            ["nextpayment"] = tostring(os.time() + 604800),
                            ["livery"] = data.livery,
                            ["extra1"] = _data.extra1,
                            ["extra2"] = _data.extra2,
                            ["extra3"] = _data.extra3,
                            ["extra4"] = _data.extra4,
                            ["extra5"] = _data.extra5,
                            ["extra6"] = _data.extra6,
                            ["extra7"] = _data.extra7,
                            ["extra8"] = _data.extra8,
                            ["extra9"] = _data.extra9,
                            ["extra10"] = _data.extra10,
                            ["extra11"] = _data.extra11,
                            ["extra12"] = _data.extra12,
                            ["extra13"] = _data.extra13,
                            ["extra14"] = _data.extra14,
                            ["extra15"] = _data.extra15,
                            ["headlight_colour"] = data.headlight_colour,
                            ["dashboard_colour"] = data.dashboard_colour,
                            ["interior_colour"] = data.interior_colour,
                            ["seller"] = Dealer.get("characterID"),
                        }
                    }, function(plate)
                        data.cost = MonthlyPayment
                        data.plate = plate
                        data.plate = string.format("%X", tostring(data.plate))
                        data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                        TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                        TriggerClientEvent("carshop:bought", Source, data, displayedVehicles[Store][Index].Entity, Store)
                        TriggerClientEvent("carshop:setplate", -1, data.plate, displayedVehicles[Store][Index].Entity)
                        DealerSoldVehicle(displayedVehicles[Store][Index].Seller, Interest, displayedVehicles[Store][Index].Price, Store)
                    end, true)
                elseif tonumber(User.get("bank")) >= tonumber(MonthlyPayment + displayedVehicles[Store][Index].CashDown) then
                    User.removeBank(MonthlyPayment + displayedVehicles[Store][Index].CashDown)
                    exports["GHMattiMySQL"]:Insert("vehicles", {
                        {
                            ["character_id"] = User.get("characterID"),
                            ["garage_id"] = GarageID,
                            ["model"] = data.model,
                            ["name"] = data.name,
                            ["instance"] = data.instance,
                            ["state"] = data.state,
                            ["cost"] = displayedVehicles[Store][Index].Price,
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
                            ["weeks"] = displayedVehicles[Store][Index].Weeks,
                            ["interest"] = displayedVehicles[Store][Index].Interest,
                            ["payedoff"] = ( MonthlyPayment * displayedVehicles[Store][Index].Weeks ) - MonthlyPayment,
                            ["lastpayment"] = tostring(os.time()),
                            ["nextpayment"] = tostring(os.time() + 604800),
                            ["livery"] = data.livery,
                            ["extra1"] = _data.extra1,
                            ["extra2"] = _data.extra2,
                            ["extra3"] = _data.extra3,
                            ["extra4"] = _data.extra4,
                            ["extra5"] = _data.extra5,
                            ["extra6"] = _data.extra6,
                            ["extra7"] = _data.extra7,
                            ["extra8"] = _data.extra8,
                            ["extra9"] = _data.extra9,
                            ["extra10"] = _data.extra10,
                            ["extra11"] = _data.extra11,
                            ["extra12"] = _data.extra12,
                            ["extra13"] = _data.extra13,
                            ["extra14"] = _data.extra14,
                            ["extra15"] = _data.extra15,
                            ["headlight_colour"] = data.headlight_colour,
                            ["dashboard_colour"] = data.dashboard_colour,
                            ["interior_colour"] = data.interior_colour,
                            ["seller"] = Dealer.get("characterID"),
                        }
                    }, function(plate)
                        data.cost = MonthlyPayment
                        data.plate = plate
                        data.plate = string.format("%X", tostring(data.plate))
                        data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                        TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                        TriggerClientEvent("carshop:bought", Source, data, displayedVehicles[Store][Index].Entity, Store)
                        TriggerClientEvent("carshop:setplate", -1, data.plate, displayedVehicles[Store][Index].Entity)
                        DealerSoldVehicle(displayedVehicles[Store][Index].Seller, Interest, displayedVehicles[Store][Index].Price, Store)
                    end, true)
                else
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    if didReduce == true then
                        User.addBank(Reduction)
                        TriggerClientEvent("pNotify:SendNotification", Source, {text = "You have been refunded the money to your bank that you placed down on the vehicle!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                        displayedVehicles[Store][Index].Price = displayedVehicles[Store][Index].Price + Reduction
                        TriggerClientEvent("DisplayVehicles.Sync", -1, displayedVehicles)
                        didReduce = false
                    end
                end
            else
                TriggerEvent("core:anticheat-ban", Source)
            end
        end)
    end)
end)

RegisterServerEvent("CarDealer.CheckHistory")
AddEventHandler("CarDealer.CheckHistory", function(PersonsID)
    local Source = source
    if CarDealers[Source] ~= nil then
        TriggerEvent("core:getuser", PersonsID, function(User)
            local character_id = User.get("characterID")
            exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM vehicles WHERE character_id = @character_id", {["@character_id"] = character_id}, function(result)
                if result[1] == nil then
                    TriggerClientEvent("chatMessage", Source, "Database", {16, 102, 158}, "No Information Found")
                else
                    TriggerClientEvent("chatMessage", Source, "Database", {16, 102, 158}, "Information Found")
                    for k, v in pairs(result) do
                        local financed = ""
                        local repoed = ""
                        if tonumber(v.lastpayment) <= 0 and tonumber(v.nextpayment) <= 0 then
                            financed = "False"
                        else
                            financed = "True"
                        end
                        if v.escrowed == 0 then
                            repoed = "False"
                        else
                            repoed = "True"
                        end
                        local lastpaymenttime = os.date("*t", v.lastpayment)
                        local nextpaymenttime = os.date("*t", v.nextpayment)
                        local LastTimePayed = "Unknown"
                        local NextTimePayed = "Unknown"
                        if v.lastpayment ~= "0" then
                            LastTimePayed = lastpaymenttime.month.."/"..lastpaymenttime.day
                        end
                        if v.nextpayment ~= "0" then
                            NextTimePayed = nextpaymenttime.month.."/"..nextpaymenttime.day
                        end
                        TriggerClientEvent("chatMessage", Source, "Result", {16, 102, 158}, "Model: "..v.model.." | Price: "..v.cost.." | Financed: "..financed.." | Repoed: "..repoed.." | Last Payment: "..LastTimePayed.." | Next Payment: "..NextTimePayed)
                    end
                end
            end)
        end)
    end
end)

RegisterServerEvent("Pay.CarPayment")
AddEventHandler("Pay.CarPayment", function(Plate)
    local Source = source
    TriggerEvent("core:getuser", Source, function(User)
        local character_id = User.get("characterID")
        exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM vehicles WHERE character_id = @character_id", {["@character_id"] = character_id}, function(result)
            if result[1] == nil then
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {16, 102, 158}, "Error!")
            else
                for k, v in pairs(result) do
                    if tonumber(Plate, 16) == v.plate then
                        local Interest = ( ( v.cost * ( v.interest / 100) ) * ( ( v.weeks * 7 ) / 360 ) )
                        local MonthlyPayment = math.floor( ( v.cost / v.weeks ) + Interest )
                        local WeeksMissed = math.floor( ( os.time() - v.lastpayment)  / 604800 )
                        if WeeksMissed >= 2 then
                            MonthlyPayment = MonthlyPayment * WeeksMissed
                        end
                        if User.get("wallet") > MonthlyPayment then
                            User.removeWallet(MonthlyPayment)
                            v.payedoff = v.payedoff - MonthlyPayment
                            v.lastpayment = os.time()
                            v.nextpayment = os.time() + 604800
                            time = os.date("*t", v.nextpayment)
                            exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicles SET payedoff = @payedoff, lastpayment = @lastpayment, nextpayment = @nextpayment WHERE (plate = @plate)", {
                                ["@payedoff"] = v.payedoff,
                                ["@lastpayment"] = v.lastpayment,
                                ["@nextpayment"] = v.nextpayment,
                                ["@plate"] = v.plate
                            })
                            TriggerClientEvent("pNotify:SendNotification", Source, {text = "Weekly Payment Successful! Next Payment is due on "..time.month.."/"..time.day,type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                        elseif User.get("bank") > MonthlyPayment then
                            User.removeBank(MonthlyPayment)
                            v.payedoff = v.payedoff - MonthlyPayment
                            v.lastpayment = os.time()
                            v.nextpayment = os.time() + 604800
                            time = os.date("*t", v.nextpayment)
                            exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicles SET payedoff = @payedoff, lastpayment = @lastpayment, nextpayment = @nextpayment WHERE (plate = @plate)", {
                                ["@payedoff"] = v.payedoff,
                                ["@lastpayment"] = v.lastpayment,
                                ["@nextpayment"] = v.nextpayment,
                                ["@plate"] = v.plate
                            })
                            TriggerClientEvent("pNotify:SendNotification", Source, {text = "Weekly Payment Successful! Next Payment is due on "..time.month.."/"..time.day,type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                        else
                            TriggerClientEvent("pNotify:SendNotification", Source, {text = "Insufficient Funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                        end
                    end
                end
            end
        end)
    end)
end)

RegisterServerEvent("CarDealer.RemoveVehicle")
AddEventHandler("CarDealer.RemoveVehicle", function(NetworkID, Store)
    local Source = source
    if displayedVehicles[Store] then
        for Index = 1, #displayedVehicles[Store] do
            if NetworkID == displayedVehicles[Store][Index].Entity then
                table.remove(displayedVehicles[Store], Index)
                TriggerClientEvent("DisplayVehicles.Sync", -1, displayedVehicles)
            end
        end
    end
end)

-- RegisterServerEvent("Sell.Car")
-- AddEventHandler("Sell.Car", function()
--     local Source = source
--     local Seller = nil
--     TriggerEvent("core:getuser", Source, function(User)
--         Seller = User.get(characterID)
--     end)
-- end)

function DealerSoldVehicle(Seller, Interest, Price, Store)
    local info = CarDealers[Seller]
    if info ~= nil then
        local Profit = nil

        info.sold = info.sold + 1

        if info.rank == "associate" then
            Profit = Price * 0.05
        elseif info.rank == "senior associate" then
            Profit = Price * 0.05
        elseif info.rank == "supervisor" then
            Profit = Price * 0.05
        elseif info.rank == "manager" then
            Profit = Price * 0.05
        end

        if Profit ~= nil then
            if Profit > 0 then
                Profit = math.tointeger(Profit)
                
                TriggerEvent("core:getuser", Seller, function(User)
                    TriggerClientEvent("pNotify:SendNotification", Seller, {text = "You've made $"..Profit.." of commission from that sale!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    User.addBank(Profit)
                    exports["GHMattiMySQL"]:QueryAsync("UPDATE cardealer SET sold = sold + 1 WHERE (character_id = @character_id)", {
                        ["@character_id"] = User.get("characterID"),
                    })
                    exports["GHMattiMySQL"]:QueryAsync("INSERT INTO carsales (`id`, `bank`) VALUES (@id, @interest) ON DUPLICATE KEY UPDATE bank = bank + @interest", {
                        ["@interest"] = Interest,
                        ["@id"] = dealerBanks[Store]
                    })
                    TriggerClientEvent("Dealer.SoldVehicle", Seller, info.Sold)
                end)
            end
        end
    end
end
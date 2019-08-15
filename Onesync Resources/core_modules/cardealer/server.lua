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

TriggerEvent("core:addGroupCommand", "cardealeradd", "command", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /cardealeradd [ID]")	
	else
		if GetPlayerName(tonumber(args[1])) ~= nil then
            TriggerEvent("core:getuser", tonumber(args[1]), function(target)
                CarDealers[tonumber(args[1])] = nil
                exports['GHMattiMySQL']:QueryAsync("INSERT INTO cardealer (`character_id`) VALUES (@character_id)", {
                    ["@character_id"] = target.get("characterID"),
                })
                CarDealers[tonumber(args[1])] = { IsDealer = true, OnDuty = false, character_id = target.get("characterID"), rank = "Associate", sold = 0 }
                Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>"..target.get("first_name").." "..target.get("last_name").."</span> has been accepted. <br> Congratulations on joining the Car Dealership!", 10000, tonumber(args[1]))
                TriggerClientEvent("CarDealer:Set", tonumber(args[1]), CarDealers[source], true, true)
            end)
		else
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /cardealer [ID]")
		end
	end
end, {help = "Add a player to the Whitelisted Car Dealer", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent("core:addGroupCommand", "cardealerrem", "command", function(source, args, rawCommand, data, power, group)
	local source = source
	if(not args[1]) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /cardealerrem [ID]")	
	else
		if GetPlayerName(tonumber(args[1])) then
			if CarDealers[tonumber(args[1])] ~= nil then
				TriggerEvent("core:getuser", tonumber(args[1]), function(target)
					CarDealers[tonumber(args[1])] = nil
					exports['GHMattiMySQL']:QueryAsync("DELETE FROM cardealer WHERE character_id=@character_id", {["@character_id"] = target.get("characterID")})
					TriggerClientEvent("CarDealer:Set", source, {}, false, true)
				end)
			else
				Notify("This user is not apart of the Car Dealership", 3000, source)
			end
		else
			Notify("No player with this ID !", 3000, source)
		end
	end
end, {help = "Remove a player from the Whitelisted Car Dealer", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent("core:addGroupCommand", "cardealerpromote", "command", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /cardealerpromote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if CarDealers[source] ~= nil then
				if CarDealers[tonumber(args[1])] ~= nil then
					if rank == "Associate" or rank == "Seniro Associate" or rank == "Supervisor" or rank == "Manager" then
                        if CarDealers[source].rank == "Manager" then
                            TriggerEvent("core:getuser", tonumber(args[1]), function(target)
                                exports['GHMattiMySQL']:QueryAsync("UPDATE cardealer SET rank=@rank WHERE character_id=@character_id", {["@character_id"] = target.get("characterID"), ["@rank"] = rank})
                                CarDealers[tonumber(args[1])].rank = rank
                                Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been promoted!</span><br> You are now a "..rank, 10000, tonumber(args[1]))
                                TriggerClientEvent("CarDealer:Set", tonumber(args[1]), CarDealers[tonumber(args[1])], true, true)
                            end)
                        else
                            Notify("You cannot target this player", 3000, source)
                        end
					else
						Notify("This rank does not exist", 3000, source)
					end
				else
					Notify("This user is not apart of the Car Dealership", 3000, source)
				end
			else
				Notify("You aren't apart of the Car Dealership", 3000, source)
			end
		else
			Notify("Player could not be found", 3000, source)
		end
	end
end, {help = "Promote to Whitelisted Car Dealership", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Associate | Senior Associate | Supervisor | Manager"}}})

TriggerEvent("core:addGroupCommand", "cardealerdemote", "command", function(source, args, rawCommand, data, power, group)
	local source = source
	if(#args < 2) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /cardealerdemote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[1])) ~= nil and tostring(args[2]) ~= nil)then
			local rank = table.concat(args, " ", 2)
			if CarDealers[source] ~= nil then
				if CarDealers[tonumber(args[1])] ~= nil then
					if rank == "Associate" or rank == "Seniro Associate" or rank == "Supervisor" or rank == "Manager" then
                        if CarDealers[source].rank == "Manager" then
                            TriggerEvent("core:getuser", tonumber(args[1]), function(target)
                                exports['GHMattiMySQL']:QueryAsync("UPDATE cardealer SET rank=@rank WHERE character_id=@character_id", {["@character_id"] = target.get("characterID"), ["@rank"] = rank:lower()})
                                CarDealers.Players[tonumber(args[1])].rank = rank:lower()
                                Notify("<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been demoted!</span><br> You are now a "..rank, 10000, tonumber(args[1]))
                                TriggerClientEvent("CarDealer:Set", tonumber(args[1]), CarDealers[tonumber(args[1])], false, true)
                            end)
                        else
                            Notify("You cannot demote anyone", 3000, source)
                        end
					else
						Notify("This rank does not exist", 3000, source)
					end
				else
					Notify("This user is not apart of the Car Dealership", 3000, source)
				end
			else
				Notify("You aren't apart of the Car Dealership", 3000, source)
			end
		else
			Notify("Player could not be found", 3000, source)
		end
	end
end, {help = "Demote from Whitelisted Car Dealership", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Associate | Senior Associate | Supervisor | Manager"}}})


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
    TriggerClientEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
end)

RegisterServerEvent("Spawn.PoliceCar")
AddEventHandler("Spawn.PoliceCar", function(DataTable, Vehicle)
    local Source = source
    local data = DataTable
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
                ["intrest"] = 0,
                ["payedoff"] = 0,
                ["police"] = 1
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
                    data.plate = plate
                    data.plate = string.format("%X", tostring(data.plate))
                    data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    TriggerClientEvent("carshop:bought", Source, data, DisplayedVehicles[Index].Entity)
                    TriggerClientEvent("carshop:setplate", -1, data.plate, DisplayedVehicles[Index].Entity)
                    DealerSoldVehicle(DisplayedVehicles[Index].Seller, 0, DisplayedVehicles[Index].Price)
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
                    data.plate = plate
                    data.plate = string.format("%X", tostring(data.plate))
                    data.plate = strpad(data.plate, 8, "0", "STR_PAD_LEFT")
                    TriggerClientEvent("pNotify:SendNotification", Source, {text = "Vehicle purchased!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    TriggerClientEvent("carshop:bought", Source, data, DisplayedVehicles[Index].Entity)
                    TriggerClientEvent("carshop:setplate", -1, data.plate, DisplayedVehicles[Index].Entity)
                    DealerSoldVehicle(DisplayedVehicles[Index].Seller, 0, DisplayedVehicles[Index].Price)
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
                    TriggerClientEvent("carshop:setplate", -1, data.plate, DisplayedVehicles[Index].Entity)
                    DealerSoldVehicle(DisplayedVehicles[Index].Seller, Intrest, DisplayedVehicles[Index].Price)
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
                    TriggerClientEvent("carshop:setplate", -1, data.plate, DisplayedVehicles[Index].Entity)
                    DealerSoldVehicle(DisplayedVehicles[Index].Seller, Intrest, DisplayedVehicles[Index].Price)
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
                TriggerClientEvent("pNotify:SendNotification", Source, {text = "You've made $"..Profit.." of commission from that sale!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                User.addBank(Profit)
            end
        end
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
                        if v.lastpayment == 0 and v.nextpayment == 0 then
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
                        local Intrest = ( ( v.cost * ( v.intrest / 100) ) * ( ( v.weeks * 7 ) / 360 ) )
                        local MonthlyPayment = math.floor( ( v.cost / v.weeks ) + Intrest )
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
AddEventHandler("CarDealer.RemoveVehicle", function(NetworkID)
    local Source = source
    for Index = 1, #DisplayedVehicles do
        if NetworkID == DisplayedVehicles[Index].Entity then
            table.remove(DisplayedVehicles, Index)
            TriggerClientEvent("DisplayVehicles.Sync", -1, DisplayedVehicles)
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
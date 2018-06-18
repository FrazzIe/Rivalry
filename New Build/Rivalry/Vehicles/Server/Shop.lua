function PurchaseVehicle(Source, Vehicle, Location)
	exports["GHMattiMySQL"]:Insert("vehicles", {
		{
			["character_id"] = Vehicle.CharacterId,
			["garage_id"] = Vehicle.GarageId,
			["model"] = Vehicle.Model,
			["name"] = Vehicle.Name,
			["cost"] = Vehicle.Cost,
			["type"] = Vehicle.Type,
			["insurance"] = Vehicle.Insurance,
			["primary_colour"] = Vehicle.Colour.Primary,
			["secondary_colour"] = Vehicle.Colour.Secondary,
			["pearlescent_colour"] = Vehicle.Colour.Pearlescent,
			["wheel_colour"] = Vehicle.Colour.Wheel,
			["smoke_colour"] = json.encode({Vehicle.Colour.Smoke.Red, Vehicle.Colour.Smoke.Green, Vehicle.Colour.Smoke.Blue}),
			["plate_colour"] = Vehicle.Colour.Plate,
			["neon_colour"] = json.encode({Vehicle.Colour.Neon.Red, Vehicle.Colour.Neon.Green, Vehicle.Colour.Neon.Blue}),
			["tint_colour"] = Vehicle.Colour.Tint,
			["mod0"] = Vehicle.Mods["0"],
			["mod1"] = Vehicle.Mods["1"],
			["mod2"] = Vehicle.Mods["2"],
			["mod3"] = Vehicle.Mods["3"],
			["mod4"] = Vehicle.Mods["4"],
			["mod5"] = Vehicle.Mods["5"],
			["mod6"] = Vehicle.Mods["6"],
			["mod7"] = Vehicle.Mods["7"],
			["mod8"] = Vehicle.Mods["8"],
			["mod10"] = Vehicle.Mods["10"],
			["mod11"] = Vehicle.Mods["11"],
			["mod12"] = Vehicle.Mods["12"],
			["mod13"] = Vehicle.Mods["13"],
			["mod14"] = Vehicle.Mods["14"],
			["mod15"] = Vehicle.Mods["15"],
			["mod16"] = Vehicle.Mods["16"],
			["mod23"] = Vehicle.Wheels.Front.Handle,
			["mod24"] = Vehicle.Wheels.Rear.Handle,
			["mod25"] = Vehicle.Mods["25"],
			["mod26"] = Vehicle.Mods["26"],
			["mod27"] = Vehicle.Mods["27"],
			["mod28"] = Vehicle.Mods["28"],
			["mod29"] = Vehicle.Mods["29"],
			["mod30"] = Vehicle.Mods["30"],
			["mod31"] = Vehicle.Mods["31"],
			["mod32"] = Vehicle.Mods["32"],
			["mod33"] = Vehicle.Mods["33"],
			["mod34"] = Vehicle.Mods["34"],
			["mod35"] = Vehicle.Mods["35"],
			["mod36"] = Vehicle.Mods["36"],
			["mod37"] = Vehicle.Mods["37"],
			["mod38"] = Vehicle.Mods["38"],
			["mod39"] = Vehicle.Mods["39"],
			["mod40"] = Vehicle.Mods["40"],
			["mod41"] = Vehicle.Mods["41"],
			["mod42"] = Vehicle.Mods["42"],
			["mod43"] = Vehicle.Mods["43"],
			["mod44"] = Vehicle.Mods["44"],
			["mod45"] = Vehicle.Mods["45"],
			["mod46"] = Vehicle.Mods["46"],
			["mod48"] = Vehicle.Mods["48"],
			["tyre_smoke"] = Vehicle.TyreSmoke,
			["xenon_lights"] = Vehicle.XenonLights,
			["turbo"] = Vehicle.Turbo,
			["custom_wheels"] = Vehicle.Wheels.Front.Custom,
			["custom_wheels2"] = Vehicle.Wheels.Rear.Custom,
			["bulletproof_wheels"] = Vehicle.Wheels.Bulletproof,
			["wheeltype"] = Vehicle.Wheels.Type,
			["neon0"] = Vehicle.Neon[1],
			["neon1"] = Vehicle.Neon[2],
			["neon2"] = Vehicle.Neon[3],
			["neon3"] = Vehicle.Neon[4],
			["engine_health"] = Vehicle.Health.Engine,
			["petrol_health"] = Vehicle.Health.Petrol,
			["vehicle_health"] = Vehicle.Health.Vehicle,
			["body_health"] = Vehicle.Health.Body,
		}
	}, function(Plate)
		Vehicle.Plate = strpad(string.format("%X", tostring(Plate)), 8, "0", "STR_PAD_LEFT"),
		AddVehicle(Source, Vehicle)
		TriggerClientEvent("Shop.Vehicle.Purchased", Source, Vehicle, Location)
		Notify(Vehicle.Name.." purchased!", 3000, Source)
	end, true)
end

RegisterServerEvent("Shop.Vehicle.Buy")
AddEventHandler("Shop.Vehicle.Buy", function(Type, Category, Index, GarageId, Vehicle, Location)
	local Source = source
	if Config.Dealership.Vehicles[Type][Category].Items[Index] then
		if GarageId then
			local Name, Price, Model = Config.Dealership.Vehicles[Type][Category].Items[Index].Name, Config.Dealership.Vehicles[Type][Category].Items[Index].Price, Config.Dealership.Vehicles[Type][Category].Items[Index].Model
			if Vehicle then
				TriggerEvent("core:getuser", Source, function(user)
					Vehicle.Type = Type
					Vehicle.Insurance = false
					Vehicle.State = "Available"
					Vehicle.CharacterId = user.get("characterID")
					Vehicle.Model = Model
					Vehicle.Cost = Price
					Vehicle.Name = Name
					Vehicle.GarageId = GarageId
					if user.get("wallet") >= Price then
						user.removeWallet(Price)
						PurchaseVehicle(Source, Vehicle, Location)
					elseif user.get("bank") >= Price then
						user.removeBank(Price)
						PurchaseVehicle(Source, Vehicle, Location)
					else
						Notify("Insufficient funds", 3000, Source)
						TriggerClientEvent("Shop.Vehicle.Reset", Source)
					end
				end)
			else
				TriggerClientEvent("Shop.Vehicle.Reset", Source)
			end
		else
			Notify("Unable to locate a garage that has room for this vehicle!", 3000, Source)
			TriggerClientEvent("Shop.Vehicle.Reset", Source)
		end
	else
		TriggerClientEvent("Shop.Vehicle.Reset", Source)
	end
end)
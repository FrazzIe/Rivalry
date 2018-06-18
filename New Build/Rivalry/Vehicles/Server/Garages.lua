local PlayerVehicles, PlayerGarages = {}, {}
local SlotPrice, ImpoundPrice = 5000, 5000

function tobool(input)
	if input == "true" or tonumber(input) == 1 or input == true or input == "on" then
		return true
	else
		return false
	end
end

function strpad(input, pad_length, pad_string, pad_type)
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

function Notify(_message, _time, _target)
    TriggerClientEvent("pNotify:SendNotification", _target, {text = _message, type = "error", queue = "left", timeout = _time, layout = "centerRight"})
end

function GetVehicleIndex(Source, Plate)
	for Index = 1, #PlayerVehicles[Source] do
		if Plate == PlayerVehicles[Source][Index].Plate then
			return Index
		end
	end
	return nil
end

function GetGarageIndex(Source, Type, GarageId)
	for Index = 1, #PlayerGarages[Source] do
		if GarageId == PlayerGarages[Source][Index].GarageId and Type == PlayerGarages[Source][Index].Type then
			return Index
		end
	end
	return nil
end

function SetupVehicle(data)
	local NeonColour, SmokeColour = json.decode(data.neon_colour), json.decode(data.smoke_colour)
	local Vehicle = {
		Plate = strpad(string.format("%X", tostring(data.plate)), 8, "0", "STR_PAD_LEFT"),
		CharacterId = data.character_id,
		Model = data.model,
		Name = data.name,
		Cost = data.cost,
		State = "Available",
		Type = data.type,
		GarageId = data.garage_id,
		Insurance = tobool(data.insurance),
		Mods = {},
		Wheels = {
			Type = data.wheeltype,
			Bulletproof = tobool(data.bulletproof_wheels),
			Front = {
				Handle = data.mod23,
				Custom = tobool(data.custom_wheels),
			},
			Rear = {
				Handle = data.mod24,
				Custom = tobool(data.custom_wheels2),
			},
		},
		Neon = {
			[1] = tobool(data.neon0),
			[2] = tobool(data.neon1),
			[3] = tobool(data.neon2),
			[4] = tobool(data.neon3),
		},
		Turbo = tobool(data.turbo),
		TyreSmoke = tobool(data.tyre_smoke),
		XenonLights = tobool(data.xenon_lights),
		Colour = {
			Primary = data.primary_colour,
			Secondary = data.secondary_colour,
			Pearlescent = data.pearlescent_colour,
			Wheel = data.wheel_colour,
			Neon = {Red = NeonColour[1], Green = NeonColour[2], Blue = NeonColour[3]},
			Smoke = {Red = SmokeColour[1], Green = SmokeColour[2], Blue = SmokeColour[3]},
			Tint = data.tint_colour,
			Plate = data.plate_colour,
		},
		Health = {
			Engine = data.engine_health,
			Petrol = data.petrol_health,
			Vehicle = data.vehicle_health,
			Body = data.body_health,
		},
	}
	for Index = 0, 48 do
		if data["mod"..Index] and Index ~= 23 and Index ~= 24 then
			Vehicle.Mods[tostring(Index)] = tonumber(data["mod"..Index])
		end
	end
	return Vehicle
end

function SetupGarage(data)
	local Garage = {
		Id = data.id,
		CharacterId = data.character_id,
		Type = data.type,
		Cost = data.cost,
		GarageId = data.garage_id,
		Slots = data.slots,
	}
	return Garage
end

function AddVehicle(Source, Vehicle)
	table.insert(PlayerVehicles[Source], Vehicle)
	TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
	TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source])
end

function PurchaseGarage(Source, Type, GarageId, Slots, Cost, CharacterId)
	exports["GHMattiMySQL"]:Insert("garages", {
		{
			["character_id"] = CharacterId,
			["garage_id"] = GarageId,
			["type"] = Type,
			["cost"] = Cost,
			["slots"] = Slots,
		}
	}, function(id)
		table.insert(PlayerGarages[Source], {Id = id, CharacterId = CharacterId, Type = Type, Cost = Cost, GarageId = GarageId, Slots = Slots})
		TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
		TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source])
		Notify("Garage purchased!", 3000, Source)
	end, true)
end

function RemoveImpound(Source, Plate, Index)
	PlayerVehicles[Source][Index].State = "Available"
	TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
	TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source])
end

function PurchaseInsurance(Source, Index, CharacterId)
	PlayerVehicles[Source][Index].Insurance = true
	exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicles SET insurance=@insurance WHERE (character_id=@character_id) AND (plate=@plate)", {["@character_id"] = CharacterId, ["@plate"] = tonumber(PlayerVehicles[Source][Index].Plate, 16), ["@insurance"] = PlayerVehicles[Source][Index].Insurance})
	TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
	TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source])
	Notify("Insurance purchased", 3000, Source)
end

function UpgradeGarage(Source, Type, GarageId, CharacterId, Index)
	PlayerGarages[Source][Index].Cost = PlayerGarages[Source][Index].Cost + SlotPrice
	PlayerGarages[Source][Index].Slots = PlayerGarages[Source][Index].Slots + 1
	exports["GHMattiMySQL"]:QueryAsync("UPDATE garages SET cost=@cost, slots=@slots WHERE (character_id=@character_id) AND (type=@type) AND (garage_id=@garage_id)", {["@character_id"] = CharacterId, ["@type"] = Type, ["@garage_id"] = GarageId, ["cost"] = PlayerGarages[Source][Index].Cost, ["slots"] = PlayerGarages[Source][Index].Slots})
	TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
	TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source])
	Notify("Garage upgraded!", 3000, Source)
end

RegisterServerEvent("Garages.Initialise")
AddEventHandler("Garages.Initialise", function(Source, Identifier, CharacterId)
	local Garages = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM garages WHERE character_id=@character_id", {["@character_id"] = CharacterId})
	local Vehicles = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM vehicles WHERE character_id=@character_id", {["@character_id"] = CharacterId})
	for i = 1, #Garages do Garages[i] = SetupGarage(Garages[i]) end
	for i = 1, #Vehicles do	Vehicles[i] = SetupVehicle(Vehicles[i])	end
	PlayerVehicles[Source] = Vehicles
	PlayerGarages[Source] = Garages
	TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
	TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source])
end)

RegisterServerEvent("Garages.Buy")
AddEventHandler("Garages.Buy", function(Type, GarageId, Slots)
	local Source = source
	local Cost = tonumber(Config.Garages[Type][GarageId].Cost + (SlotPrice * Slots))
	TriggerEvent("core:getuser", Source, function(user)
		if user.get("wallet") >= Cost then
			user.removeWallet(Cost)
			PurchaseGarage(Source, Type, GarageId, Slots, Cost, user.get("characterID"))
		elseif user.get("bank") >= Cost then
			user.removeBank(Cost)
			PurchaseGarage(Source, Type, GarageId, Slots, Cost, user.get("characterID"))
		else
			Notify("Insufficient funds", 3000, Source)
			TriggerClientEvent("Garages.Reset", Source)
		end
	end)
end)

RegisterServerEvent("Garages.Sell")
AddEventHandler("Garages.Sell", function(Type, GarageId)
	local Source = source
	local Index = GetGarageIndex(Source, Type, GarageId)
	if Index then
		TriggerEvent("core:getuser", Source, function(user)
			user.addBank(math.ceil(PlayerGarages[Source][Index].Cost/2))
			table.remove(PlayerGarages[Source], Index)
			exports["GHMattiMySQL"]:QueryAsync("DELETE FROM garages WHERE (character_id=@character_id) AND (type=@type) AND (garage_id=@garage_id)", {["@character_id"] = user.get("characterID"), ["@type"] = Type, ["@garage_id"] = GarageId})
			TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
			TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source])
			Notify("Garage sold!", 3000, Source)
		end)
	else
		TriggerClientEvent("Garages.Reset", Source)
	end
end)

RegisterServerEvent("Garages.Sell.Vehicle")
AddEventHandler("Garages.Sell.Vehicle", function(Handle, Plate)
	local Source = source
	local Index = GetVehicleIndex(Source, Plate)
	if Index then
		TriggerEvent("core:getuser", source, function(user)
			user.addBank(math.ceil(PlayerVehicles[Source][Index].Cost/2))
			exports["GHMattiMySQL"]:QueryAsync("DELETE FROM vehicles WHERE (character_id=@character_id) AND (plate=@plate)", {["@character_id"] = user.get("characterID"), ["@plate"] = tonumber(PlayerVehicles[Source][Index].Plate, 16)})
			table.remove(PlayerVehicles[Source], Index)
			TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
			TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source], Handle)
			Notify("Vehicle sold!", 3000, Source)
		end)
	else
		Notify("This vehicle does not belong to you!", 3000, Source)
	end
end)

RegisterServerEvent("Garages.Impound")
AddEventHandler("Garages.Impound", function(Plate)
	local Source = source
	local Index = GetVehicleIndex(Source, Plate)
	if Index then
		TriggerEvent("core:getuser", Source, function(user)
			if user.get("wallet") >= ImpoundPrice then
				user.removeWallet(ImpoundPrice)
				RemoveImpound(Source, Plate)
			elseif user.get("bank") >= ImpoundPrice then
				user.removeBank(ImpoundPrice)
				RemoveImpound(Source, Plate)
			else
				Notify("Insufficient funds", 3000, Source)
				TriggerClientEvent("Garages.Reset", Source)
			end
		end)
	else
		TriggerClientEvent("Garages.Reset", Source)
	end
end)

RegisterServerEvent("Garages.Store")
AddEventHandler("Garages.Store", function(Vehicle)
	local Source = source
	local Index = GetVehicleIndex(Source, Vehicle.Plate)
	if Index then
		PlayerVehicles[Source][Index].Mods = Vehicle.Mods
		PlayerVehicles[Source][Index].Colour = Vehicle.Colour
		PlayerVehicles[Source][Index].Wheels = Vehicle.Wheels
		PlayerVehicles[Source][Index].Neon = Vehicle.Neon
		PlayerVehicles[Source][Index].State = Vehicle.State
		PlayerVehicles[Source][Index].Turbo = Vehicle.Turbo
		PlayerVehicles[Source][Index].TyreSmoke = Vehicle.TyreSmoke
		PlayerVehicles[Source][Index].XenonLights = Vehicle.XenonLights
		PlayerVehicles[Source][Index].GarageId = Vehicle.GarageId
		exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicles SET garage_id=@garage_id, primary_colour=@primary_colour, secondary_colour=@secondary_colour, pearlescent_colour=@pearlescent_colour, wheel_colour=@wheel_colour, smoke_colour=@smoke_colour, plate_colour=@plate_colour, neon_colour=@neon_colour, tint_colour=@tint_colour, mod0=@mod0, mod1=@mod1, mod2=@mod2, mod3=@mod3, mod4=@mod4, mod5=@mod5, mod6=@mod6, mod7=@mod7, mod8=@mod8, mod10=@mod10, mod11=@mod11, mod12=@mod12, mod13=@mod13, mod14=@mod14, mod15=@mod15, mod16=@mod16, mod23=@mod23, mod24=@mod24, mod25=@mod25, mod26=@mod26, mod27=@mod27, mod28=@mod28, mod29=@mod29, mod30=@mod30, mod31=@mod31, mod32=@mod32, mod33=@mod33, mod34=@mod34, mod35=@mod35, mod36=@mod36, mod37=@mod37, mod38=@mod38, mod39=@mod39, mod40=@mod40, mod41=@mod41, mod42=@mod42, mod43=@mod43, mod44=@mod44, mod45=@mod45, mod46=@mod46, mod48=@mod48, tyre_smoke=@tyre_smoke, xenon_lights=@xenon_lights, turbo=@turbo, custom_wheels=@custom_wheels, custom_wheels2=@custom_wheels2, bulletproof_wheels=@bulletproof_wheels, wheeltype=@wheeltype, neon0=@neon0, neon1=@neon1, neon2=@neon2, neon3=@neon3, engine_health=@engine_health, petrol_health=@petrol_health, vehicle_health=@vehicle_health WHERE (character_id = @character_id) AND (plate = @plate)", { 
			["@plate"] = tonumber(PlayerVehicles[Source][Index].Plate, 16),
			["@character_id"] = PlayerVehicles[Source][Index].CharacterId,
			["@garage_id"] = PlayerVehicles[Source][Index].GarageId,
			["@primary_colour"] = PlayerVehicles[Source][Index].Colour.Primary,
			["@secondary_colour"] = PlayerVehicles[Source][Index].Colour.Secondary,
			["@pearlescent_colour"] = PlayerVehicles[Source][Index].Colour.Pearlescent,
			["@wheel_colour"] = PlayerVehicles[Source][Index].Colour.Wheel,
			["@smoke_colour"] = json.encode({PlayerVehicles[Source][Index].Colour.Smoke.Red, PlayerVehicles[Source][Index].Colour.Smoke.Green, PlayerVehicles[Source][Index].Colour.Smoke.Blue}),
			["@plate_colour"] = PlayerVehicles[Source][Index].Colour.Plate,
			["@neon_colour"] = json.encode({PlayerVehicles[Source][Index].Colour.Neon.Red, PlayerVehicles[Source][Index].Colour.Neon.Green, PlayerVehicles[Source][Index].Colour.Neon.Blue}),
			["@tint_colour"] = PlayerVehicles[Source][Index].Colour.Tint,
			["@mod0"] = PlayerVehicles[Source][Index].Mods["0"],
			["@mod1"] = PlayerVehicles[Source][Index].Mods["1"],
			["@mod2"] = PlayerVehicles[Source][Index].Mods["2"],
			["@mod3"] = PlayerVehicles[Source][Index].Mods["3"],
			["@mod4"] = PlayerVehicles[Source][Index].Mods["4"],
			["@mod5"] = PlayerVehicles[Source][Index].Mods["5"],
			["@mod6"] = PlayerVehicles[Source][Index].Mods["6"],
			["@mod7"] = PlayerVehicles[Source][Index].Mods["7"],
			["@mod8"] = PlayerVehicles[Source][Index].Mods["8"],
			["@mod10"] = PlayerVehicles[Source][Index].Mods["10"],
			["@mod11"] = PlayerVehicles[Source][Index].Mods["11"],
			["@mod12"] = PlayerVehicles[Source][Index].Mods["12"],
			["@mod13"] = PlayerVehicles[Source][Index].Mods["13"],
			["@mod14"] = PlayerVehicles[Source][Index].Mods["14"],
			["@mod15"] = PlayerVehicles[Source][Index].Mods["15"],
			["@mod16"] = PlayerVehicles[Source][Index].Mods["16"],
			["@mod23"] = PlayerVehicles[Source][Index].Wheels.Front.Handle,
			["@mod24"] = PlayerVehicles[Source][Index].Wheels.Rear.Handle,
			["@mod25"] = PlayerVehicles[Source][Index].Mods["25"],
			["@mod26"] = PlayerVehicles[Source][Index].Mods["26"],
			["@mod27"] = PlayerVehicles[Source][Index].Mods["27"],
			["@mod28"] = PlayerVehicles[Source][Index].Mods["28"],
			["@mod29"] = PlayerVehicles[Source][Index].Mods["29"],
			["@mod30"] = PlayerVehicles[Source][Index].Mods["30"],
			["@mod31"] = PlayerVehicles[Source][Index].Mods["31"],
			["@mod32"] = PlayerVehicles[Source][Index].Mods["32"],
			["@mod33"] = PlayerVehicles[Source][Index].Mods["33"],
			["@mod34"] = PlayerVehicles[Source][Index].Mods["34"],
			["@mod35"] = PlayerVehicles[Source][Index].Mods["35"],
			["@mod36"] = PlayerVehicles[Source][Index].Mods["36"],
			["@mod37"] = PlayerVehicles[Source][Index].Mods["37"],
			["@mod38"] = PlayerVehicles[Source][Index].Mods["38"],
			["@mod39"] = PlayerVehicles[Source][Index].Mods["39"],
			["@mod40"] = PlayerVehicles[Source][Index].Mods["40"],
			["@mod41"] = PlayerVehicles[Source][Index].Mods["41"],
			["@mod42"] = PlayerVehicles[Source][Index].Mods["42"],
			["@mod43"] = PlayerVehicles[Source][Index].Mods["43"],
			["@mod44"] = PlayerVehicles[Source][Index].Mods["44"],
			["@mod45"] = PlayerVehicles[Source][Index].Mods["45"],
			["@mod46"] = PlayerVehicles[Source][Index].Mods["46"],
			["@mod48"] = PlayerVehicles[Source][Index].Mods["48"],
			["@tyre_smoke"] = PlayerVehicles[Source][Index].TyreSmoke,
			["@xenon_lights"] = PlayerVehicles[Source][Index].XenonLights,
			["@turbo"] = PlayerVehicles[Source][Index].Turbo,
			["@custom_wheels"] = PlayerVehicles[Source][Index].Wheels.Front.Custom,
			["@custom_wheels2"] = PlayerVehicles[Source][Index].Wheels.Rear.Custom,
			["@bulletproof_wheels"] = PlayerVehicles[Source][Index].Wheels.Bulletproof,
			["@wheeltype"] = PlayerVehicles[Source][Index].Wheels.Type,
			["@neon0"] = PlayerVehicles[Source][Index].Neon[1],
			["@neon1"] = PlayerVehicles[Source][Index].Neon[2],
			["@neon2"] = PlayerVehicles[Source][Index].Neon[3],
			["@neon3"] = PlayerVehicles[Source][Index].Neon[4],
			["@engine_health"] = PlayerVehicles[Source][Index].Health.Engine,
			["@petrol_health"] = PlayerVehicles[Source][Index].Health.Petrol,
			["@vehicle_health"] = PlayerVehicles[Source][Index].Health.Vehicle,
			["@body_health"] = PlayerVehicles[Source][Index].Health.Body,
		})
		TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
		TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source])
	end
end)

RegisterServerEvent("Garages.Out")
AddEventHandler("Garages.Out", function(Vehicle)
	local Source = source
	local Index = GetVehicleIndex(Source, Vehicle.Plate)
	if Index then
		PlayerVehicles[Source][Index].State = Vehicle.State
		PlayerVehicles[Source][Index].Handle = Vehicle.Handle
		TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
		TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source])
	end
end)

RegisterServerEvent("Garages.Insurance")
AddEventHandler("Garages.Insurance", function(Plate)
	local Source = source
	local Index = GetVehicleIndex(Source, Plate)
	if Index then
		local InsurancePrice = math.floor(PlayerVehicles[Source][Index].Cost/10)
		TriggerEvent("core:getuser", Source, function(user)
			if user.get("wallet") >= InsurancePrice then
				user.removeWallet(InsurancePrice)
				PurchaseInsurance(Source, Index, user.get("characterID"))
			elseif user.get("bank") >= InsurancePrice then
				user.removeBank(InsurancePrice)
				PurchaseInsurance(Source, Index, user.get("characterID"))
			else
				Notify("Insufficient funds", 3000, Source)
				TriggerClientEvent("Garages.Reset", Source)
			end
		end)
	else
		TriggerClientEvent("Garages.Reset", Source)
	end
end)

RegisterServerEvent("Garages.Claim")
AddEventHandler("Garages.Claim", function(Plate)
	local Source = source
	local Index = GetVehicleIndex(Source, Plate)
	if Index then
		PlayerVehicles[Source][Index].State = "Available"
		TriggerClientEvent("Garages.Sync.All", -1, PlayerVehicles, PlayerGarages)
		TriggerClientEvent("Garages.Sync.Client", Source, PlayerVehicles[Source], PlayerGarages[Source])
	else
		TriggerClientEvent("Garages.Reset", Source)
	end
end)

RegisterServerEvent("Garages.Upgrade")
AddEventHandler("Garages.Upgrade", function(Type, GarageId)
	local Source = source
	local Cost = SlotPrice
	local Index = GetGarageIndex(Source, Type, GarageId)
	if Index then
		TriggerEvent("core:getuser", Source, function(user)
			if user.get("wallet") >= Cost then
				user.removeWallet(Cost)
				UpgradeGarage(Source, Type, GarageId, user.get("characterID"), Index)
			elseif user.get("bank") >= Cost then
				user.removeBank(Cost)
				UpgradeGarage(Source, Type, GarageId, user.get("characterID"), Index)
			else
				Notify("Insufficient funds", 3000, Source)
				TriggerClientEvent("Garages.Reset", Source)
			end
		end)
	else
		TriggerClientEvent("Garages.Reset", Source)
	end
end)
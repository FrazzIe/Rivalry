keys_vehicles = {}
keys_users = {}

local hotwire_rates = { -- % chance
    [0] = 70, -- Compacts
    [1] = 70, -- Sedans
    [2] = 70, -- SUV
    [3] = 70, -- Coupes
    [4] = 70, -- Muscle
    [5] = 70, -- Sports Classics
    [6] = 60, -- Sports
    [7] = 30, -- Super
    [8] = 40, -- Motorcycles
    [9] = 60, -- Off-road
    [10] = 50, -- Industrial
    [11] = 50, -- Utility
    [12] = 75, -- Vans
    [13] = 75, -- Cycles
    [14] = 60, -- Boats
    [15] = 0, -- Helicopters
    [16] = 0, -- Planes
    [17] = 60, -- Service
    [18] = 0, -- Emergency
    [19] = 0, -- Military
    [20] = 70, -- Commercial
    [21] = 0, -- Trains
}

DecorRegister("hotwire", 2)

AddEventHandler("keys:lock", function()
	local vehicle = GetNearestVehicle(PlayerPedId(), true)
	if vehicle ~= 0 and vehicle ~= nil then
		TriggerServerEvent("keys:lock", vehicle, GetVehicleNumberPlateText(vehicle))
	end
end)

AddEventHandler("keys:unlock", function()
	local vehicle = GetNearestVehicle(PlayerPedId(), true)
	if vehicle ~= 0 and vehicle ~= nil then
		TriggerServerEvent("keys:unlock", vehicle, GetVehicleNumberPlateText(vehicle))
	end
end)

AddEventHandler("keys:toggle", function()
	local vehicle = GetNearestVehicle(PlayerPedId(), true)
	if vehicle ~= 0 and vehicle ~= nil then
		local lockstatus = GetVehicleDoorLockStatus(vehicle)
		if lockstatus == 1 or lockstatus == 0 then
			TriggerServerEvent("keys:lock", vehicle, GetVehicleNumberPlateText(vehicle))
		else
			TriggerServerEvent("keys:unlock", vehicle, GetVehicleNumberPlateText(vehicle))
		end
	else
		Notify("You do not have the keys to this vehicle!")
	end
end)

AddEventHandler("keys:menu", function()
	exports.ui:reset()
	exports.ui:open("vehicle_keys")
	for plate, owner in pairs(keys_users[GetPlayerServerId(PlayerId())]) do
		if owner ~= nil then
			exports.ui:addOption(plate, "keys:sub_menu", plate)
		end
	end
	exports.ui:back([[TriggerEvent("interaction:keys")]])
end)

AddEventHandler("keys:sub_menu", function(plate)
	exports.ui:reset()
	exports.ui:open("vehicle_keys")
	exports.ui:addOption("Give", "keys:give", plate)
	exports.ui:addOption("Remove", "keys:remove", plate)
	exports.ui:back([[TriggerEvent("keys:menu")]])
end)

AddEventHandler("keys:give",function(plate)
	exports.ui:reset()
	exports.ui:open("vehicle_keys")
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("keys:give", plate, GetPlayerServerId(t))
    else
    	Notify("There is no player near you!")
    	TriggerEvent("keys:menu")
    end
end)

AddEventHandler("keys:remove", function(plate)
	exports.ui:reset()
	exports.ui:open("vehicle_keys")
	TriggerServerEvent("keys:remove", plate)
end)

AddEventHandler("keys:hotwire", function(ped, id)
	if IsPedSittingInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsIn(ped, false)
		local vehicle_class = GetVehicleClass(vehicle)
		if GetPedInVehicleSeat(vehicle, -1) == ped then
			TaskPlayAnim(ped,"mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
			TriggerEvent("dispatch:lockpick")
			Citizen.Wait(30000)
			ClearPedTasks(PlayerPedId())
			if GetRandomIntInRange(1, 101) >= 100 - ((hotwire_rates[vehicle_class] or 60)) then
				Notify("Successfully hotwired!")
				DecorSetBool(vehicle, "hotwire", true)
			else
				Notify("Hotwiring failed!")
			end
		else
			Notify("You must be in the drivers seat to hotwire!")
			addQty(tonumber(id), 1)
		end
	else
		Notify("You must be in a vehicle to hotwire!")
		addQty(tonumber(id), 1)
	end
end)

RegisterNetEvent("keys:sync")
AddEventHandler("keys:sync", function(_keys_vehicles, _keys_users)
	keys_vehicles, keys_users = _keys_vehicles, _keys_users
	if exports.ui:currentmenu() == "vehicle_keys" then
		TriggerEvent("keys:menu")
	end
end)

RegisterNetEvent("keys:trigger")
AddEventHandler("keys:trigger", function(vehicle, bool)
	if bool then
		SetVehicleDoorsLocked(vehicle, 2)
	else
		SetVehicleDoorsLocked(vehicle, 1)
	end
end)

Citizen.CreateThread(function()
	local lastvehicle = nil
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		if not isCarshopOpen and not isCarRentalOpen and not isBoatRentalOpen and not isBikeRentalOpen and IsPedSittingInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped, false)
			local plate = GetVehicleNumberPlateText(vehicle)
			local model = GetEntityModel(vehicle)
			if GetPedInVehicleSeat(vehicle, -1) == ped and not exports.policejob:IsVehicleExempt(model) and not exports.emsjob:IsVehicleExempt(model) then
				if keys_users[GetPlayerServerId(PlayerId())][plate] or DecorExistOn(vehicle, "hotwire") then
					if vehicle ~= lastvehicle then
						lastvehicle = vehicle
						SetVehicleEngineOn(vehicle, true, true, false)
						SetVehicleUndriveable(vehicle, true)
					end
				else
					SetVehicleEngineOn(vehicle, true, true, false)
					SetVehicleUndriveable(vehicle, true)
					if vehicle ~= lastvehicle then
						lastvehicle = vehicle
						if IsVehicleOwned(GetVehicleNumberPlateText(vehicle)) then
							TriggerServerEvent("keys:get", vehicle, plate)
						else
							Notify("You do not have the keys to this vehicle!")
						end
					end
				end
			end
		else
			lastvehicle = nil
		end

		if DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) then
			local vehicle = GetVehiclePedIsTryingToEnter(ped)
			local lockstatus = GetVehicleDoorLockStatus(veh)

			if lockstatus == 7 then
				SetVehicleDoorsLocked(vehicle, 2)
			end

			local ped_in_car = GetPedInVehicleSeat(vehicle, -1)

			if ped_in_car then
				SetPedCanBeDraggedOut(ped_in_car, false)
			end
		end
	end
end)

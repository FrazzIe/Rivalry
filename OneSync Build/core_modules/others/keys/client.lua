keys_vehicles = {}
keys_users = {}
local Animations = {Dictionary = "mp_common", Player = "givetake1_a"}
AddAnimDictionary(Animations.Dictionary)
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
			TriggerEvent('LIFE_CL:Sound:PlayOnOne', "locking", "0.3")
			TaskPlayAnim(PlayerPedId(), Animations.Dictionary, Animations.Player, 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)
			Wait(1000)
			ClearPedTasks(PlayerPedId())
		else
			TriggerServerEvent("keys:unlock", vehicle, GetVehicleNumberPlateText(vehicle))
			TriggerEvent('LIFE_CL:Sound:PlayOnOne', "locking", "0.3")
			TaskPlayAnim(PlayerPedId(), Animations.Dictionary, Animations.Player, 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)
			Wait(1000)
			ClearPedTasks(PlayerPedId())
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
			local report = math.random(1, 4)
			
			if report == 3 then
				TriggerEvent("dispatch:lockpick")
			end

			TaskPlayAnim(ped,"mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
			exports['mythic_progbar']:Progress({
                name = "hotwire_kit_action",
                duration = 30000,
                label = "Hotwiring Vehicle",
                useWhileDead = true,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }
            }, function(status)
                if not status then
					ClearPedTasks(PlayerPedId())
					Notify("Successfully hotwired!")
					DecorSetBool(vehicle, "hotwire", true)
                end
            end)
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

RegisterNetEvent("Hotwire.Car")
AddEventHandler("Hotwire.Car", function(Player)
	if IsPedSittingInAnyVehicle(Player) then
		local Vehicle = GetVehiclePedIsIn(Player, false)
		local VehicleClass = GetVehicleClass(Vehicle)
		if not DecorExistOn(vehicle, "hotwire") and GetPedInVehicleSeat(Vehicle, -1) == Player then
			TaskPlayAnim(Player,"mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
			exports['mythic_progbar']:Progress({
                name = "hotwire_action",
                duration = 60000,
                label = "Hotwiring Vehicle",
                useWhileDead = true,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }
            }, function(status)
                if not status then
					TriggerEvent("dispatch:lockpick")
					Citizen.Wait(60000)
					ClearPedTasks(PlayerPedId())
					if GetRandomIntInRange(1, 101) >= 100 - ((hotwire_rates[VehicleClass] or 60)) then
						Notify("Successfully hotwired!", 3100)
						DecorSetBool(Vehicle, "hotwire", true)
					else
						Notify("Hotwiring failed!", 3100)
					end
                end
            end)
		end
	end
end)

RegisterNetEvent("Robbing.Local.Keys")
AddEventHandler("Robbing.Local.Keys", function(Vehicle)
	DecorSetBool(Vehicle, "hotwire", true)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Player = PlayerPedId()
		if IsPedSittingInAnyVehicle(Player) then
			local Vehicle = GetVehiclePedIsIn(Player, false)
			local model = GetEntityModel(Vehicle)
			if not DecorGetBool(Vehicle, "hotwire") and GetPedInVehicleSeat(Vehicle, -1) == Player and not IsVehicleOwned(GetVehicleNumberPlateText(Vehicle)) and GetVehicleClass(Vehicle) ~= 13 and not keys_users[GetPlayerServerId(PlayerId())][GetVehicleNumberPlateText(Vehicle)] and string.sub(GetVehicleNumberPlateText(Vehicle), 1, 2) ~= "RR" and not exports.policejob:IsVehicleExempt(model) and not exports.emsjob:IsVehicleExempt(model) then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to try and hotwire this vehicle, or use a hotwire kit from your inventory!")
				if IsControlJustPressed(1, 51) then
					TriggerEvent("Hotwire.Car", Player)
					Citizen.Wait(60000)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	local lastvehicle = nil
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		if not isCarshopOpen and not isCarRentalOpen and not isBoatRentalOpen and not isBikeRentalOpen and IsPedSittingInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped, false)
			local vehClass = GetVehicleClass(vehicle)
			local plate = GetVehicleNumberPlateText(vehicle)
			local model = GetEntityModel(vehicle)
			local isOwned = IsVehicleOwned(GetVehicleNumberPlateText(vehicle))

			if GetPedInVehicleSeat(vehicle, -1) == ped and not exports.policejob:IsVehicleExempt(model) and not exports.emsjob:IsVehicleExempt(model) then
				local serverId = GetPlayerServerId(PlayerId())

				if keys_users[serverId][plate] or DecorExistOn(vehicle, "hotwire") then
					if vehicle ~= lastvehicle then
						lastvehicle = vehicle
						SetVehicleEngineOn(vehicle, true, true, false)
						SetVehicleUndriveable(vehicle, true)
					end
				elseif vehClass == 18 and IsOnDutyPolice then -- any cop can drive another cops car w/o keys?
					if vehicle ~= lastvehicle then
						lastvehicle = vehicle

						if not keys_vehicles[plate] and isOwned then
							TriggerServerEvent("keys:get", vehicle, plate) -- 
						end

						SetVehicleEngineOn(vehicle, true, true, false)
						SetVehicleUndriveable(vehicle, true)
					end
				else
					SetVehicleEngineOn(vehicle, true, true, false)
					SetVehicleUndriveable(vehicle, true)
					if vehicle ~= lastvehicle then
						lastvehicle = vehicle
						if isOwned then
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

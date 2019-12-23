function GetPlayerSeatIndex(Vehicle, Ped)
    for Index = -1, GetVehicleMaxNumberOfPassengers(Vehicle) do
        if GetPedInVehicleSeat(Vehicle, Index) == Ped then
            return Index
        end
    end

    return nil
end

function GetVehicleIndicatorState(Vehicle)
	local State = GetVehicleIndicatorLights(Vehicle)

	if State == 1 then
		return { false, true }
	elseif State == 2 then
		return { true, false }
	elseif State == 3 then
		return { false, false }
	else
		return { true, true }
	end
end

RegisterNetEvent("Window.Toggle")
AddEventHandler("Window.Toggle", function(Source, Up)
	local Player = GetPlayerFromServerId(Source)
	local Ped = GetPlayerPed(Player)
	local Vehicle = GetVehiclePedIsIn(Ped, false)

	if Vehicle then
		local Seat = GetPlayerSeatIndex(Vehicle, Ped)

		if Seat ~= nil then
			if Up then
				RollUpWindow(Vehicle, Seat + 1)
			else
				RollDownWindow(Vehicle, Seat + 1)
			end
		end
	end
end)

RegisterNetEvent("Indicator.Left")
AddEventHandler("Indicator.Left", function(Source, State)
	local Player = GetPlayerFromServerId(Source)
	local Ped = GetPlayerPed(Player)
	local Vehicle = GetVehiclePedIsIn(Ped, false)

	if Vehicle then
		SetVehicleIndicatorLights(Vehicle, 1, State)
	end
end)

RegisterNetEvent("Indicator.Right")
AddEventHandler("Indicator.Right", function(Source, State)
	local Player = GetPlayerFromServerId(Source)
	local Ped = GetPlayerPed(Player)
	local Vehicle = GetVehiclePedIsIn(Ped, false)

	if Vehicle then
		SetVehicleIndicatorLights(Vehicle, 0, State)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local PlayerPed = PlayerPedId()

		if IsPedSittingInAnyVehicle(PlayerPed) then
			local Vehicle = GetVehiclePedIsIn(PlayerPed, false)
			local EmergencyVehicle = GetVehicleClass(Vehicle) == 18
			local Seat = GetPlayerSeatIndex(Vehicle, PlayerPed)

			if Seat ~= nil then
				if Seat == -1 then
					if IsControlJustPressed(1, 174) or IsControlJustPressed(1, 175) then
						local State = GetVehicleIndicatorState(Vehicle)

						if IsControlJustPressed(1, 174) then
							TriggerServerEvent("Indicator.Left", State[1])
						end

						if IsControlJustPressed(1, 175) then
							TriggerServerEvent("Indicator.Right", State[2])
						end
					end
				end

				if not (Seat > 0 and EmergencyVehicle) then
					if IsControlJustPressed(1, 173) then
						TriggerServerEvent("Window.Toggle", false)
					end

					if IsControlJustPressed(1, 172) then
						TriggerServerEvent("Window.Toggle", true)
					end
				end
			end
		end
	end
end)
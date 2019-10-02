Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		if #(Data.MechanicLocation - PlayerPosition) <= 1.0 then
			DisplayHelpText("Press ~INPUT_CONTEXT~ to select vehicle!")
			if IsControlJustPressed(1, 51) then
				if IsPedInAnyVehicle(Player, true) then
					SelectedVehicle = GetVehiclePedIsIn(Player, false)
					TaskPedOutOfVehicle(Player)
				else
					Notify("You must enter a vehicle prior to starting repairs!")		
				end
			end
		end
		if SelectedVehicle ~= nil then
			local VehiclePosition = GetEntityCoords(SelectedVehicle, false)
			if #(PlayerPosition - VehiclePosition) <= 2.0 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open repair menu!")
				if IsControlJustPressed(1, 51) then
					SendNUIMessage("RepairMenu") 			
				end
			end
		end
		if #(Data.MechanicCustoms - PlayerPosition) <= 2.0 then
			DisplayHelpText("Press ~INPUT_CONTEXT~ to customize!")
			if IsControlJustPressed(1, 51) then
				TriggerEvent("Open.Mechanic.Customs")		
			end
		end
	end
end)

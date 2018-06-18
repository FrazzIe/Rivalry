local Seatbelt = {
	MinSpeed = 60.0,
	Difference = 0.255,
}

function Seatbelt.CalculateForwardPosition()
	Player.Heading = GetEntityHeading(Player.Ped)
	local Heading = (Player.Heading + 90.0) * 0.0174533
	return {x = math.cos(Heading) * 2.0, y = math.sin(Heading) * 2.0}
end

Citizen.CreateThread(function()
	local Buffer = {
		Speed = {},
		Velocity = {},
	}
	while true do
		Citizen.Wait(0)
		if Player.Ready then
			local Vehicle = Player.Vehicle.Current
			if DoesEntityExist(Vehicle) then
				local Model = GetEntityModel(Vehicle)
				if IsThisModelACar(Model) or IsThisModelAQuadbike(Model) or IsThisModelABike(Model) then

					Buffer.Speed[2] = Buffer.Speed[1] or 0.0
					Buffer.Speed[1] = GetEntitySpeed(Vehicle) * 2.23694

					if Player.Vehicle.Seatbelt then 
						DisableControlAction(0, 75, true)
						DisableControlAction(1, 75, true)
						DisableControlAction(2, 75, true)
					elseif GetEntitySpeedVector(Vehicle, true).y > 1.0 and Buffer.Speed[2] > Seatbelt.MinSpeed and (Buffer.Speed[2] - Buffer.Speed[1]) > (Buffer.Speed[2] * Seatbelt.Difference) then
						local ForwardPosition = Seatbelt.CalculateForwardPosition()
						Player.Coordinates = GetEntityCoords(Player.Ped, false)
						SetEntityCoords(Player.Ped, Player.Coordinates.x + ForwardPosition.x, Player.Coordinates.y + ForwardPosition.y, Player.Coordinates.z + 0.47, true, true, true)
						SetEntityVelocity(Player.Ped, Buffer.Velocity[2].x, Buffer.Velocity[2].y, Buffer.Velocity[2].z)
						Citizen.Wait(500)
						SetPedToRagdoll(Player.Ped, 1000, 1000, 0, 0, 0, 0)
					end

					Buffer.Velocity[2] = Buffer.Velocity[1]
					Buffer.Velocity[1] = GetEntityVelocity(Vehicle)

					if IsControlJustPressed(1, 29) then
						Player.Vehicle.Seatbelt = not Player.Vehicle.Seatbelt
						Notify(Player.Vehicle.Seatbelt and "Seatbelt: <span style='color:lime'>On</span>" or "Seatbelt: <span style='color:red'>Off</span>", 3000)
						SetDecorator(Player.Ped, "_Player_Seatbelt", Player.Vehicle.Seatbelt)
					end
				else
					Buffer.Speed[1], Buffer.Speed[2] = 0.0, 0.0
					Buffer.Velocity[1], Buffer.Velocity[2] = 0.0, 0.0
					if Player.Vehicle.Seatbelt then
						Player.Vehicle.Seatbelt = false
						SetDecorator(Player.Ped, "_Player_Seatbelt", Player.Vehicle.Seatbelt)
					end
				end
			end
		end
	end
end)
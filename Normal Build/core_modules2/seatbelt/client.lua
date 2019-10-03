local Seatbelt = {
	Active = false,
	MinSpeed = 60.0,
	Difference = 0.255,
}

function SeatbeltActive()
	return Seatbelt.Active
end

function Seatbelt.CalculateForwardPosition(PlayerPed)
	local Heading = (GetEntityHeading(PlayerPed) + 90.0) * 0.0174533
	return {x = math.cos(Heading) * 2.0, y = math.sin(Heading) * 2.0}
end

function drawHelpTxt(x,y ,width,height,scale, text, r,g,b,a,font)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local isHudOn = true

RegisterNetEvent('toggle:seatbelt')
AddEventHandler('toggle:seatbelt', function()
	isHudOn = not isHudOn
end)

Citizen.CreateThread(function()
	local Buffer = {
		Speed = {},
		Velocity = {},
	}
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()

		if IsPedSittingInAnyVehicle(PlayerPed) then
			local Vehicle = GetVehiclePedIsIn(PlayerPed, false)

			if DoesEntityExist(Vehicle) then
				local Model = GetEntityModel(Vehicle)
				if IsThisModelACar(Model) or IsThisModelAQuadbike(Model) or IsThisModelABike(Model) then
					Buffer.Speed[2] = Buffer.Speed[1] or 0.0
					Buffer.Speed[1] = GetEntitySpeed(Vehicle) * 2.23694

					if Seatbelt.Active then
						DisableControlAction(0, 75, true)
						DisableControlAction(1, 75, true)
						DisableControlAction(2, 75, true)
					elseif GetEntitySpeedVector(Vehicle, true).y > 1.0 and Buffer.Speed[2] > Seatbelt.MinSpeed and (Buffer.Speed[2] - Buffer.Speed[1]) > (Buffer.Speed[2] * Seatbelt.Difference) then
						local ForwardPosition = Seatbelt.CalculateForwardPosition(PlayerPed)
						local PlayerPosition = GetEntityCoords(PlayerPed, false)

						SetEntityCoords(PlayerPed, PlayerPosition.x + ForwardPosition.x, PlayerPosition.y + ForwardPosition.y, PlayerPosition.z + 0.47, true, true, true)
						SetEntityVelocity(PlayerPed, Buffer.Velocity[2].x, Buffer.Velocity[2].y, Buffer.Velocity[2].z)
						
						Citizen.Wait(500)
						
						SetPedToRagdoll(PlayerPed, 1000, 1000, 0, 0, 0, 0)
					end

					Buffer.Velocity[2] = Buffer.Velocity[1]
					Buffer.Velocity[1] = GetEntityVelocity(Vehicle)

					if IsControlJustPressed(1, 29) then
						Seatbelt.Active = not Seatbelt.Active
						Notify(Seatbelt.Active and "Seatbelt: <span style='color:lime'>On</span>" or "Seatbelt: <span style='color:red'>Off</span>", 3000)
						exports.core_modules:SetSeatbeltStatus()
					end
				else
					Buffer.Speed[1], Buffer.Speed[2] = 0.0, 0.0
					Buffer.Velocity[1], Buffer.Velocity[2] = 0.0, 0.0
					
					if Seatbelt.Active then
						Seatbelt.Active = false
					end
				end
			end
		end
	end
end)
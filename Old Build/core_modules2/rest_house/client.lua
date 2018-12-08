local RestHouseMarkers = {
	--[1] = {x = 1543.9691162109, y = 3591.2551269531, z = 35.452556610107, h = 302.49542236328},
	--[2] = {x = -1132.3039550781, y = 4952.8984375, z = 222.2686920166, h = 158.55874633789},
	--[3] = {x = 149.99578857422, y = -2203.3139648438, z = 4.6880264282227, h = 112.83338165283},
	vector3(2435.5532226563, 4960.0625, 46.812889099121),
}

RegisterNetEvent('resthouse:revive')
AddEventHandler('resthouse:revive', function()
	Citizen.CreateThread(function()
		Notify("You are currently being provided medical treatment", 30000)
		Citizen.Wait(30000)
		TriggerEvent("paramedic:heal")
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		for Index = 1, #RestHouseMarkers do
			local Distance = #(RestHouseMarkers[Index] - PlayerPosition)

			if Distance < 11.5 then
				DrawMarker(25, RestHouseMarkers[Index].x, RestHouseMarkers[Index].y, RestHouseMarkers[Index].z - 1, 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
				if Distance < 3.5 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to recieve medical treatment!($2500 Dirty)")
					if IsControlJustPressed(1, 51) then
						if IsEntityDead(PlayerPed) then
							TriggerServerEvent("resthouse:pay")
						else
							Notify("You look fine to me, go bother someone else!", 2500)
						end
					end
				end
			end
		end
	end
end)
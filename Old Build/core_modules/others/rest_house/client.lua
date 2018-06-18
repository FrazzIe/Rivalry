local rest_house_markers = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local pos = GetEntityCoords(PlayerPed, false)
		for k,v in pairs(rest_house_markers) do
			if Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 20 then
				RenderMarker(v.x, v.y, v.z)
				if Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2 then
					if IsControlJustPressed(1, 51) then
						if IsEntityDead(PlayerPed) then
							TriggerServerEvent("resthouse:pay")
						end
					end
				end
			end
		end
	end
end)
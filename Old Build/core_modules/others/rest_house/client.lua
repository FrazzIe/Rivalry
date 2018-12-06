local rest_house_markers = {
	[1] = {x = 1543.9691162109, y = 3591.2551269531, z = 35.452556610107, h = 302.49542236328},
	[2] = {x = -1132.3039550781, y = 4952.8984375, z = 222.2686920166, h = 158.55874633789},
	[3] = {x = 149.99578857422, y = -2203.3139648438, z = 4.6880264282227, h = 112.83338165283},
}
local allowed = false

RegisterNetEvent('resthouse:approve')
AddEventHandler('reshhouse:approve', function()
	allowed = not allowed
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local pos = GetEntityCoords(PlayerPed, false)
		for k,v in pairs(rest_house_markers) do
			if Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 20 then
				RenderMarker(v.x, v.y, v.z)
				if Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to recieve medical treatment!($3000)")
					if IsControlJustPressed(1, 51) then
						if IsEntityDead(PlayerPed) then
							TriggerServerEvent("resthouse:pay")
							if allowed then
								Notify("You are currently being provided medical treatment", 30000)
								Citizen.Wait(30000)
								TriggerServerEvent("paramedic:revive", GetPlayerServerId(PlayerId()))
								allowed = false
							end
						else
							Notify("You look fine to me, go bother someone else!", 2500)
							allowed = false
						end
					end
				end
			end
		end
	end
end)
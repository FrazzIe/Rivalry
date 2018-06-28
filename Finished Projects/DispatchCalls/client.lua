local user_call_311_timer = 10
local user_call_911_timer = 10

RegisterNetEvent("dispatch:311")
AddEventHandler("dispatch:311", function(id, message)
		local user_call_311 = nil
		local coords = GetEntityCoords(id, false)
		local endTime = GetGameTimer() + ((user_call_311_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(user_call_311) then
				user_call_311 = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(user_call_311, 459)
				SetBlipColour(user_call_311, 28)
				SetBlipAsShortRange(user_call_311, true)
				SetBlipScale(user_call_311, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("311")
				EndTextCommandSetBlipName(user_call_311)
			end
			if not arrived then
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "311")
				end
			end
		end
		RemoveBlip(user_call_311)
end)

RegisterNetEvent("dispatch:911")
AddEventHandler("dispatch:911", function(id, message)
		local user_call_911 = nil
		local coords = GetEntityCoords(id, false)
		local endTime = GetGameTimer() + ((user_call_911_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(user_call_911) then
				user_call_911 = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(user_call_911, 459)
				SetBlipColour(user_call_911, 28)
				SetBlipAsShortRange(user_call_911, true)
				SetBlipScale(user_call_911, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("911")
				EndTextCommandSetBlipName(user_call_911)
			end
			if not arrived then
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "911")
				end
			end
		end
		RemoveBlip(user_call_911)
end)
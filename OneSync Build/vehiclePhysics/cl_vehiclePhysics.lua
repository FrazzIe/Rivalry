WasOnVehicle = false
RagdollSpeed = 30.0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local isOnVehicle = IsPedOnVehicle(ped)

		if isOnVehicle then
			SetRagdollBlockingFlags(ped, 2)
		elseif WasOnVehicle and not isOnVehicle then
			ClearRagdollBlockingFlags(ped, 2)
			if GetEntitySpeed(ped) > RagdollSpeed then
				SetPedToRagdoll(ped)
			end
		end
		WasOnVehicle = isOnVehicle
	end
end)
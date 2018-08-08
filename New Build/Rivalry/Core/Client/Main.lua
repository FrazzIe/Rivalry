Citizen.CreateThread(function()
	for Index = 1, 15 do
		if Index ~= 11 and Index ~= 15 then
			EnableDispatchService(Index, false)
		end
	end

	local LastPosition, LastUpdate = nil, 0

	while true do
		Citizen.Wait(1000)
		
		Player.Playtime = Player.Playtime + 1

		if (LastUpdate + 60) == Player.Playtime then
			LastUpdate = Player.Playtime
			
			TriggerServerEvent("Core.Update", Player.Playtime, Player.Coordinates)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent("Core.Start")

			return
		end
	end
end)
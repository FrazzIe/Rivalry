Core = {}

Citizen.CreateThread(function()
	for Index = 1, 15 do
		if Index ~= 11 and Index ~= 15 then
			EnableDispatchService(Index, false)
		end
	end

	local LastPosition, LastUpdate = nil, 0

	while true do
		Citizen.Wait(60000)

		TriggerServerEvent("Core.Update", Player.Playtime, Player.Coordinates)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent("Core.Start")
			TriggerServerEvent("Queue:playerActivated")
			return
		end
	end
end)

RegisterNetEvent("Core.Sync")
AddEventHandler("Core.Sync", function(Data)
	Core.Groups = Data.Groups
	Core.Players = Data.Players
end)
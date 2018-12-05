Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent("Rivalry.Start")
			return
		end
	end
end)
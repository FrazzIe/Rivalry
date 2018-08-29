Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(1440000)
		TriggerServerEvent('paycheck:salary')
	end
end)

Farm = {
	Fields = {
		{
			Interval = 60,
			Time = 0,
			Raked = false,
		},
		{
			Interval = 60,
			Time = 0,
			Raked = false,
		},
		{
			Interval = 60,
			Time = 0,
			Raked = false,
		},
		{
			Interval = 60,
			Time = 0,
			Raked = false,
		},
	},
	Players = {},
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for Index = 1, #Farm.Fields do
			if Farm.Fields[Index].Raked then
				if os.time() > Farm.Fields[Index].Time then
					Farm.Fields[Index].Time = 0
					Farm.Fields[Index].Raked = false
				else
					Farm.Fields[Index].Raked = true
				end
			end
		end

		TriggerClientEvent("Farm.Sync", -1, Farm)
	end
end)

RegisterServerEvent("Farm.Raked")
AddEventHandler("Farm.Raked", function(Index)
	Farm.Fields[Index].Time = os.time() + (Farm.Fields[Index].Interval * 60000)
	Farm.Fields[Index].Raked = true

	TriggerClientEvent("Farm.Sync", -1, Farm)
end)
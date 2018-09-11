Farm = {
	Fields = {
		{
			Crop = {
				Minimum = 150,
				Maximum = 300,
			},
			Interval = 60,
			Time = 0,
			Raked = false,
		},
		{
			Crop = {
				Minimum = 150,
				Maximum = 300,
			},
			Interval = 60,
			Time = 0,
			Raked = false,
		},
		{
			Crop = {
				Minimum = 150,
				Maximum = 300,
			},
			Interval = 60,
			Time = 0,
			Raked = false,
		},
		{
			Crop = {
				Minimum = 150,
				Maximum = 300,
			},
			Interval = 60,
			Time = 0,
			Raked = false,
		},
	},
	Players = {},
	Planted = {},
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

		TriggerClientEvent("Farm.Sync", -1, Farm.Fields, Farm.Players, os.time())
	end
end)

RegisterServerEvent("Farm.Raked")
AddEventHandler("Farm.Raked", function(Index)
	Farm.Fields[Index].Time = os.time() + (Farm.Fields[Index].Interval * 60000)
	Farm.Fields[Index].Raked = true

	TriggerClientEvent("Farm.Sync", -1, Farm.Fields, Farm.Players, os.time())
end)

RegisterServerEvent("Farm.Plant")
AddEventHandler("Farm.Plant", function(Index, Crop)
	local Source = source
	local Time = os.time()

	if not Farm.Planted[Source] then Farm.Planted[Source] = {} end
	
	Crop.Time.Start = Time
	Crop.Time.End = Time + math.random(Farm.Fields[Index].Crop.Minimum, Farm.Fields[Index].Crop.Maximum)

	table.insert(Farm.Planted[Source], Crop)

	TriggerClientEvent("Farm.Sync", Source, Farm.Fields, Farm.Players, os.time(), Farm.Planted[Source])
end)
Farm = {
	Fields = {
		{
			Crop = {
				Minimum = 150,
				Maximum = 300,
				Item = 0,
			},
			Interval = 60,
			Time = 0,
			Raked = false,
		},
		{
			Crop = {
				Minimum = 150,
				Maximum = 300,
				Item = 0,
			},
			Interval = 60,
			Time = 0,
			Raked = false,
		},
		{
			Crop = {
				Minimum = 150,
				Maximum = 300,
				Item = 0,
			},
			Interval = 60,
			Time = 0,
			Raked = false,
		},
		{
			Crop = {
				Minimum = 150,
				Maximum = 300,
				Item = 0,
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

	if not Farm.Planted[Source] then Farm.Planted[Source] = {{},{},{},{}} end
	
	Crop.Time.Start = Time
	Crop.Time.End = Time + math.random(Farm.Fields[Index].Crop.Minimum, Farm.Fields[Index].Crop.Maximum)

	table.insert(Farm.Planted[Source][Index], Crop)

	TriggerClientEvent("Farm.Sync", Source, Farm.Fields, Farm.Players, os.time(), Farm.Planted[Source])
end)

RegisterServerEvent("Farm.Harvest")
AddEventHandler("Farm.Harvest", function(FieldIndex, CropIndex)
	local Source = source
	local Time = os.time()
	local Crop = Farm.Planted[Source][FieldIndex][CropIndex]

	if Crop then
		local Percentage = math.floor(((Time - Crop.Time.Start) / (Crop.Time.End - Crop.Time.Start)) * 100)
		local Stage = (Percentage >= 100) and 5 or ((Percentage >= 80) and 4 or ((Percentage >= 70) and 3 or ((Percentage >= 50) and 2 or 1)))
		local Item = Farm.Fields[Index].Crop.Item
		local Quantity = (Stage == 5) and 5 or (Stage - 1)

		if Stage >= 2 then
			table.remove(Farm.Planted[Source][FieldIndex], CropIndex)
			
			TriggerEvent("inventory:add_server", Source, Item, Quantity)
			TriggerClientEvent("Farm.Sync", Source, Farm.Fields, Farm.Players, os.time(), Farm.Planted[Source])
		end
	end
end)

RegisterServerEvent("Farm.Activity")
AddEventHandler("Farm.Activity", function(Status)
	local Source = source

	Farm.Planted[Source] = {}
	Farm.Players[Source] = Status

	TriggerClientEvent("Farm.Sync", Source, Farm.Fields, Farm.Players, os.time(), Farm.Planted[Source])
	TriggerClientEvent("Farm.Sync", -1, Farm.Fields, Farm.Players, os.time())
end)
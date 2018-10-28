Citizen.CreateThread(function()
	while true do
		Citizen.Wait(66.66)
		Time.Second = Time.Second + 1
		if Time.Second > 60 then
			Time.Second = 0
			Time.Minute = Time.Minute + 1
			if Time.Minute > 60 then
				Time.Minute = 0
				Time.Hour = Time.Hour + 1
				if Time.Hour % 4 == 0 then
					math.randomseed(os.time()); math.random(); math.random(); math.random();
					Weather.Current = Weather.Types[math.random(1, #Weather.Types)]
				end
				if Time.Hour > 23 then
					Time.Hour = 0
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		TriggerClientEvent("Environment:Sync", -1, Time.Hour, Time.Minute, Time.Second, Weather.Current)
	end
end)

TriggerEvent("core:addGroupCommand", "weather", "staff", function(source, args, rawCommand, data, power, group)
	local source = source
	if not args[1] then
		TriggerClientEvent('chatMessage', source, "^0[^1SYSTEM^0]", {255, 0, 0}, "^3/weather [type]")
	else
		for i = 1, #Weather.SetTypes do
			if Weather.SetTypes[i] == args[1] then
				Weather.Current = args[1]
				TriggerClientEvent('chatMessage', source, "^0[^1SYSTEM^0]", {255, 0, 0}, "^4Weather changed!")
				break
			end
		end
	end
end, {help = "Change the weather", params = {{name = "weather", help = table.concat(Weather.SetTypes, " | ")}}})

TriggerEvent("core:addGroupCommand", "time", "staff", function(source, args, rawCommand, data, power, group)
	local source = source
	if not #args == 3 then
		TriggerClientEvent('chatMessage', source, "^0[^1SYSTEM^0]", {255, 0, 0}, "^3/time [hour] [minute] [second]")
	else
		if tonumber(args[1]) and tonumber(args[2]) and tonumber(args[3]) then
			if tonumber(args[1]) >= 0 and tonumber(args[1]) <= 23 and tonumber(args[2]) >= 0 and tonumber(args[2]) <= 60 and tonumber(args[3]) >= 0 and tonumber(args[3]) <= 60 then
				Time.Hour, Time.Minute, Time.Second = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
				TriggerClientEvent('chatMessage', source, "^0[^1SYSTEM^0]", {255, 0, 0}, "^4Time set!")
			end
		end
	end
end, {help = "Change the time", params = {{name = "Hour", help = "0-23"}, {name = "Minute", help = "0-60"}, {name = "Second", help = "0-60"}}})
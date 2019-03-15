function CreateTimeString(Hour, Minute)
	if Minute < 10 then
		Minute = "0"..Minute
	end
	if Hour < 10 then
		Hour = "0"..Hour
	end
	return Hour..":"..Minute
end

local toggledhud = false

RegisterNetEvent('toggle:timeandweather')
AddEventHandler('toggle:timeandweather', function()
	toggledhud = not toggledhud
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not toggledhud then
			local anchor = GetMinimapAnchor()
			SetWeather(Weather.Current)
			NetworkOverrideClockTime(Time.Hour, Time.Minute, Time.Second)
		end
	end
end)

RegisterNetEvent("Environment:Sync")
AddEventHandler("Environment:Sync", function(H, M, S, W)
	Time.Hour, Time.Minute, Time.Second, Weather.Current = H, M, S, W
end)


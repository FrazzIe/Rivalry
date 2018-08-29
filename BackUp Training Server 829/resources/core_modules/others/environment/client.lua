local function CreateTimeString(Hour, Minute)
	if Minute < 10 then
		Minute = "0"..Minute
	end
	if Hour < 10 then
		Hour = "0"..Hour
	end
	return Hour..":"..Minute
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local anchor = GetMinimapAnchor()
		drawText(CreateTimeString(Time.Hour, Time.Minute).." - "..string.sub(Weather.Current, 1, 1)..string.lower(string.sub(Weather.Current, 2, string.len(Weather.Current))), 6, anchor.left_x, anchor.bottom_y - 0.005, 0.33, 255, 255, 255, 255, false, true)
		SetWeather(Weather.Current)
		NetworkOverrideClockTime(Time.Hour, Time.Minute, Time.Second)
	end
end)

RegisterNetEvent("Environment:Sync")
AddEventHandler("Environment:Sync", function(H, M, S, W)
	Time.Hour, Time.Minute, Time.Second, Weather.Current = H, M, S, W
end)
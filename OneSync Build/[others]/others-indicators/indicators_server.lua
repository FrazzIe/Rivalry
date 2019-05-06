RegisterServerEvent("Indicator.Left")
AddEventHandler("Indicator.Left", function(State)
	local Source = source

	TriggerClientEvent("Indicator.Left", -1, Source, State)
end)

RegisterServerEvent("Indicator.Right")
AddEventHandler("Indicator.Right", function(State)
	local Source = source

	TriggerClientEvent("Indicator.Right", -1, Source, State)
end)

RegisterServerEvent("Window.Toggle")
AddEventHandler("Window.Toggle", function(Up)
	local Source = source

	TriggerClientEvent("Window.Toggle", -1, Source, Up)
end)
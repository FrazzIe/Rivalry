RegisterServerEvent("Police.Cuff")
AddEventHandler("Police.Cuff", function(Target)
	local Source = source
	
	TriggerClientEvent("Police.Cuff", Target)
end)

RegisterServerEvent("Police.Uncuff")
AddEventHandler("Police.Uncuff", function(Target, Start)
	local Source = source

	TriggerClientEvent("Police.Uncuff", Target, Start)
end)
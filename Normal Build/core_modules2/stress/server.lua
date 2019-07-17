RegisterServerEvent("Use.Vicodin")
AddEventHandler("Use.Vicodin", function(Target)
	local Source = source
	TriggerClientEvent("Use.Vicodin", Target)
end)

RegisterServerEvent("Use.Hydrocodone")
AddEventHandler("Use.Hydrocodone", function(Target)
	local Source = source
	TriggerClientEvent("Use.Hydrocodone", Target)
end)

RegisterServerEvent("Use.Morphine")
AddEventHandler("Use.Morphine", function(Target)
	local Source = source
	TriggerClientEvent("Use.Morphine", Target)
end)

RegisterServerEvent("Use.Medkit")
AddEventHandler("Use.Medkit", function(Target)
	local Source = source
	TriggerClientEvent("Use.Medkit", Source, Target)
end)
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

RegisterServerEvent("Use.Gauze")
AddEventHandler("Use.Gauze", function(Target)
	local Source = source
	TriggerClientEvent("Use.Gauze", Source, Target)
end)

RegisterServerEvent("Use.Gauze.Effects")
AddEventHandler("Use.Gauze.Effects", function(Target)
	local Soruce = source
	TriggerClientEvent('mythic_hospital:client:FieldTreatBleed', Target)
end)

RegisterServerEvent("Use.Medkit")
AddEventHandler("Use.Medkit", function(Target)
	local Source = source
	TriggerClientEvent("Use.Medkit", Source, Target)
end)

RegisterServerEvent("Use.Medkit.Effects")
AddEventHandler("Use.Medkit.Effects", function(Target, Type)
	local Source = source
	TriggerClientEvent("Use.Medkit.Effects", Target, Type)
end)
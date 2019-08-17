RegisterServerEvent("Health.Injury.Add")
AddEventHandler("Health.Injury.Add", function(Bodypart, Weapon, Damage)
	local Source = source

	if not Health.Injuries[Source] then
		Health.Injuries[Source] = {}
	end

	if not Health.Injuries[Source][Bodypart] then
		Health.Injuries[Source][Bodypart] = {}
	end

	if not Health.Injuries[Source][Bodypart][Weapon] then
		if Bodypart == nil then
			"Head"
		end
		if Weapon == nil then
			"WT_UNARMED"
		end
		Health.Injuries[Source][Bodypart][Weapon] = Damage
	else
		Health.Injuries[Source][Bodypart][Weapon] = Health.Injuries[Source][Bodypart][Weapon] + Damage
	end

	TriggerClientEvent("Health.Sync", Source, Health.Injuries[Source])
end)

RegisterServerEvent("Health.Injury.Reset")
AddEventHandler("Health.Injury.Reset", function()
	local Source = source

	Health.Injuries[Source] = nil
	TriggerClientEvent("Health.Sync", Source, Health.Injuries[Source])
end)

RegisterServerEvent("Health.Injury.Get")
AddEventHandler("Health.Injury.Get", function(Name, Player)
	local Source = source

	TriggerClientEvent("Health.View", Source, Name, Health.Injuries[Player] or {})
end)

AddEventHandler("core:switch", function(source)
	local Source = source

	Health.Injuries[Source] = nil
	TriggerClientEvent("Health.Sync", Source, Health.Injuries[Source])	
end)

AddEventHandler("playerDropped", function()
	local Source = source

	Health.Injuries[Source] = nil
end)
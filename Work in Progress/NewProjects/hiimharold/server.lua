RegisterServerEvent("Open.Stash.Russian")
AddEventHandler("Open.Stash.Russian", function()
	local Source = source
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM gundealer WHERE ( character_id = @character_id ) and ( gang = @gang", {["@character_id"] = character_id, ["@gang"] = "russian"}, function(result)
		if result[1] ~= nil then
			TriggerEvent("Open.Stash", "Russian", Source)
		end
	end)
end)

RegisterServerEvent("Open.Stash")
AddEventHandler("Open.Stash", function(Gang, Source)
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM gunstash WHERE ( stash = @stash", {["@stash"] = Gang}, function(result)
		if result[1] ~= nil then
			TriggerClientEvent("Open.Stash", Source, results)
		end
	end)
end)
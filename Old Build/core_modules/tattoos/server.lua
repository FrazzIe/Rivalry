user_tattoos = {}

AddEventHandler("Tattoos.Initialise", function(source, identifier, character_id, model)
	exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM tattoos WHERE character_id=@character_id", {
		["@character_id"] = character_id,
	}, function(_tattoos)
		if _tattoos[1] == nil then
			exports["GHMattiMySQL"]:QueryAsync("INSERT INTO tattoos (`character_id`, `tattoos`) VALUES (@character_id,@tattoos)", {
				["@character_id"] = character_id,
				["@tattoos"] = json.encode({}),
			})
			user_tattoos[source] = {}
			TriggerClientEvent("Tattoos.Load", source, user_tattoos[source])
		else
			user_tattoos[source] = json.decode(_tattoos[1].tattoos)
			TriggerClientEvent("Tattoos.Load", source, user_tattoos[source])
		end
	end)
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    if user_tattoos[source] ~= nil then
        user_tattoos[source] = nil
    end
end)

AddEventHandler("core:switch", function(source)
    local source = source
    user_tattoos[source] = nil
end)
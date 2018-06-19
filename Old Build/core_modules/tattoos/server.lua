user_models = {}
RegisterServerEvent("tattoos:initialise")
AddEventHandler("tattoos:initialise",function(source, identifier, character_id, model)
	local source = source
    exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from models WHERE character_id=@character_id", {["@character_id"] = character_id}, function(result)
    	if result[1] == nil then
	        exports["GHMattiMySQL"]:QueryAsync("INSERT INTO models (`character_id`,`overlays_tattoos`,`overlays_tattootype`) VALUES (@character_id,@overlays_tattoos,@overlays_tattootype"), {
	            ["@character_id"] = character_id,
	            ["@overlays_tattoos"] = json.encode({nil})
	        	["@overlays_tattootype"] = json.encode({nil})
	        })
	    	local models = {}
	    	user_models[source] = models
			TriggerClientEvent("tattoos:spawn", source, models)
    	else
	    	local models = {}
	    	models.model = result[1].model
	    	models.tattoos = result[1].overlays_tattoos
	    	models.tattoosType = result[1].overlays_tattootype
	    	user_models[source] = models
			TriggerClientEvent("tattoos:spawn", source, models)
		end
    end)
end)

RegisterServerEvent("tattoos:spawn")
AddEventHandler("tattoos:spawn",function()
	local source = source
	TriggerClientEvent("tattoos:spawn", source, user_models[source])
end)

RegisterServerEvent("tattoos:save")
AddEventHandler("tattoos:save",function(player_data)
	local source = source
	user_models[source] = player_data
	TriggerEvent("core:getuser", source, function(user)
		exports["GHMattiMySQL"]:QueryAsync("UPDATE models SET overlays_tattoos=@overlays_tattoos, overlays_tattootype=@overlays_tattootype WHERE character_id=@character_id", {
			["@overlays_tattoos"] = json.encode(player_data.overlays.tattoos),
			["@overlays_tattootype"] = json.encode(player_data.overlays.tattootype)
		})
	end)
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    if user_models[source] ~= nil then
        user_models[source] = nil
    end
end)

AddEventHandler("core:switch", function(source)
    local source = source
    user_models[source] = nil
end)
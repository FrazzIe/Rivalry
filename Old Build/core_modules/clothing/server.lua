--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
user_models = {}
RegisterServerEvent("clothes:initialise")
AddEventHandler("clothes:initialise",function(source, identifier, character_id, model)
	local source = source
    exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from models WHERE character_id=@character_id", {["@character_id"] = character_id}, function(result)
    	if result[1] == nil then
	        exports["GHMattiMySQL"]:QueryAsync("INSERT INTO models (`character_id`,`model`,`new`,`clothing_drawables`,`clothing_textures`,`clothing_palette`,`props_drawables`,`props_textures`,`overlays_drawables`,`overlays_opacity`,`overlays_colours`) VALUES (@character_id,@model,@new,@clothing_drawables,@clothing_textures,@clothing_palette,@props_drawables,@props_textures,@overlays_drawables,@overlays_opacity,@overlays_colours)", {
	            ["@character_id"] = character_id,
	            ["@model"] = model or "a_m_m_afriamer_01",
	            ["@new"] = "true",
	            ["@clothing_drawables"] = json.encode({0,0,0,0,0,0,0,0,0,0,0,0}),
	            ["@clothing_textures"] = json.encode({2,0,1,1,0,0,0,0,0,0,0,0}),
	            ["@clothing_palette"] = json.encode({0,0,0,0,0,0,0,0,0,0,0,0}),
	            ["@props_drawables"] = json.encode({-1,-1,-1,-1,-1,-1,-1,-1}),
	            ["@props_textures"] = json.encode({-1,-1,-1,-1,-1,-1,-1,-1}),
	            ["@overlays_drawables"] = json.encode({-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}),
	            ["@overlays_opacity"] = json.encode({1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}),
	            ["@overlays_colours"] = json.encode({{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}}),
	        })
	    	local models = {}
	    	models.model = model or "a_m_m_afriamer_01"
	    	models.new = "true"
	    	models.clothing = { drawables = {0,0,0,0,0,0,0,0,0,0,0,0}, textures = {2,0,1,1,0,0,0,0,0,0,0,0}, palette = {0,0,0,0,0,0,0,0,0,0,0,0} }
	    	models.props = { drawables = {-1,-1,-1,-1,-1,-1,-1,-1}, textures = {-1,-1,-1,-1,-1,-1,-1,-1} }
	    	models.overlays = { drawables = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}, opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}, colours = {{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}} }
	    	user_models[source] = models
			TriggerClientEvent("clothes:spawn", source, models)
    	else
	    	local models = {}
	    	models.model = result[1].model
	    	models.new = result[1].new
	    	models.clothing = { drawables = json.decode(result[1].clothing_drawables), textures = json.decode(result[1].clothing_textures), palette = json.decode(result[1].clothing_palette) }
	    	models.props = { drawables = json.decode(result[1].props_drawables), textures = json.decode(result[1].props_textures) }
	    	models.overlays = { drawables = json.decode(result[1].overlays_drawables), opacity = json.decode(result[1].overlays_opacity), colours = json.decode(result[1].overlays_colours) }
	    	user_models[source] = models
			TriggerClientEvent("clothes:spawn", source, models)
		end
    end)
end)

RegisterServerEvent('clothes:payment')
AddEventHandler('clothes:payment', function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if(user.get("wallet") > 300) then
			user.removeWallet(300)
		else
			user.removeBank(300)
		end
	end)
end)

RegisterServerEvent("clothes:spawn")
AddEventHandler("clothes:spawn",function()
	local source = source
	TriggerClientEvent("clothes:spawn", source, user_models[source])
end)

RegisterServerEvent("clothes:save")
AddEventHandler("clothes:save",function(player_data)
	local source = source
	user_models[source] = player_data
	TriggerEvent("core:getuser", source, function(user)
		exports["GHMattiMySQL"]:QueryAsync("UPDATE models SET model=@model, new=@new, clothing_drawables=@clothing_drawables, clothing_textures=@clothing_textures, clothing_palette=@clothing_palette, props_drawables=@props_drawables, props_textures=@props_textures, overlays_drawables=@overlays_drawables, overlays_opacity=@overlays_opacity, overlays_colours=@overlays_colours WHERE character_id=@character_id", {
			["@character_id"] = user.get("characterID"),
			["@model"] = player_data.model,
			["@new"] = player_data.new,
			["@clothing_drawables"] = json.encode(player_data.clothing.drawables),
			["@clothing_textures"] = json.encode(player_data.clothing.textures),
			["@clothing_palette"] = json.encode(player_data.clothing.palette),
			["@props_drawables"] = json.encode(player_data.props.drawables),
			["@props_textures"] = json.encode(player_data.props.textures),
			["@overlays_drawables"] = json.encode(player_data.overlays.drawables),
			["@overlays_opacity"] = json.encode(player_data.overlays.opacity),
			["@overlays_colours"] = json.encode(player_data.overlays.colours),
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
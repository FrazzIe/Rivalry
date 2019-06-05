--[[
Los Santos Customs V1.1 
Credits - MythicalBro
/////License/////
Do not reupload/re release any part of this script without my permission
]]
local tbl = {
[1] = {locked = false, player = nil},
[2] = {locked = false, player = nil},
[3] = {locked = false, player = nil},
[4] = {locked = false, player = nil},
[5] = {locked = false, player = nil},
[6] = {locked = false, player = nil},
}
RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage', function(b,garage)
	tbl[tonumber(garage)].locked = b
	if not b then
		tbl[tonumber(garage)].player = nil
	else
		tbl[tonumber(garage)].player = source
	end
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)
RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo', function()
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)
AddEventHandler('playerDropped', function()
	for i,g in pairs(tbl) do
		if g.player then
			if source == g.player then
				g.locked = false
				g.player = nil
				TriggerClientEvent('lockGarage',-1,tbl)
			end
		end
	end
end)

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button)
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		if button.price then -- check if button have price
			if button.price < 0 then
				button.price = 196
			end
			if user.get("wallet") >= button.price then
				user.removeWallet(button.price)
				TriggerClientEvent("LSC:buttonSelected", source,name, button, true)
			elseif user.get("bank") >= button.price then
				user.removeBank(button.price)
				TriggerClientEvent("LSC:buttonSelected", source,name, button, true)
			else
				TriggerClientEvent("LSC:buttonSelected", source,name, button, false)
			end
		end
	end)
end)

RegisterServerEvent("LSC:finished")
AddEventHandler("LSC:finished", function(veh)
	local source = source
	local model = veh.model --Display name from vehicle model(comet2, entityxf)
	local mods = veh.mods
	local color = veh.color
	local extracolor = veh.extracolor
	local neoncolor = veh.neoncolor
	local smokecolor = veh.smokecolor
	local plateindex = veh.plateindex
	local windowtint = veh.windowtint
	local wheeltype = veh.wheeltype
	local bulletProofTyres = veh.bulletProofTyres
	local tyre_smoke = "off"
	local bulletproof_wheels = "off"
	local xenon_lights = "off"
	local custom_wheels = "off"
	local custom_wheels2 = "off"
	local turbo = "off"

	tyre_smoke = "on"

	if mods[18].mod == 1 then
		turbo = "on"
	else
		turbo = "off"
	end

	if bulletProofTyres == true then
		bulletproof_wheels = "on"
	else
		bulletproof_wheels = "off"
	end

	if mods[22].mod == 1 then
		xenon_lights = "on"
	else
		xenon_lights = "off"
	end

	if mods[23].variation then
		custom_wheels = "on"
	else
		custom_wheels = "off"
	end

	if mods[24].variation then
		custom_wheels2 = "on"
	else
		custom_wheels2 = "off"
	end

	if tonumber(veh.lplate, 16) ~= nil then
		--[[
		TriggerEvent("core:getuser", source, function(user)
			exports['GHMattiMySQL']:QueryAsync("UPDATE vehicles SET primary_colour=@primary_colour, secondary_colour=@secondary_colour, pearlescent_colour=@pearlescent_colour, wheel_colour=@wheel_colour, smoke_colour=@smoke_colour, plate_colour=@plate_colour, neon_colour=@neon_colour, tint_colour=@tint_colour, mod0=@mod0, mod1=@mod1, mod2=@mod2, mod3=@mod3, mod4=@mod4, mod5=@mod5, mod6=@mod6, mod7=@mod7, mod8=@mod8, mod10=@mod10, mod11=@mod11, mod12=@mod12, mod13=@mod13, mod14=@mod14, mod15=@mod15, mod16=@mod16, mod23=@mod23, mod24=@mod24, mod25=@mod25, mod26=@mod26, mod27=@mod27, mod28=@mod28, mod29=@mod29, mod30=@mod30, mod31=@mod31, mod32=@mod32, mod33=@mod33, mod34=@mod34, mod35=@mod35, mod36=@mod36, mod37=@mod37, mod38=@mod38, mod39=@mod39, mod40=@mod40, mod41=@mod41, mod42=@mod42, mod43=@mod43, mod44=@mod44, mod45=@mod45, mod46=@mod46, mod48=@mod48, tyre_smoke=@tyre_smoke, xenon_lights=@xenon_lights, turbo=@turbo, custom_wheels=@custom_wheels, custom_wheels2=@custom_wheels2, bulletproof_wheels=@bulletproof_wheels, wheeltype=@wheeltype, neon0=@neon0, neon1=@neon1, neon2=@neon2, neon3=@neon3, engine_health=@engine_health, petrol_health=@petrol_health, vehicle_health=@vehicle_health, body_health=@body_health WHERE (character_id = @character_id) AND (plate = @plate)", { 
				["@character_id"] = user.get("characterID"),
				["@plate"] = tonumber(veh.lplate, 16),
				["@primary_colour"] = color[1],
				["@secondary_colour"] = color[2],
				["@pearlescent_colour"] = extracolor[1],
				["@wheel_colour"] = extracolor[2],
				["@smoke_colour"] = json.encode({smokecolor[1],smokecolor[2],smokecolor[3]}),
				["@plate_colour"] = plateindex,
				["@neon_colour"] = json.encode({neoncolor[1],neoncolor[2],neoncolor[3]}),
				["@tint_colour"] = windowtint,
				["@mod0"] = mods[0].mod,
				["@mod1"] = mods[1].mod,
				["@mod2"] = mods[2].mod,
				["@mod3"] = mods[3].mod,
				["@mod4"] = mods[4].mod,
				["@mod5"] = mods[5].mod,
				["@mod6"] = mods[6].mod,
				["@mod7"] = mods[7].mod,
				["@mod8"] = mods[8].mod,
				["@mod9"] = mods[9].mod,
				["@mod10"] = mods[10].mod,
				["@mod11"] = mods[11].mod,
				["@mod12"] = mods[12].mod,
				["@mod13"] = mods[13].mod,
				["@mod14"] = mods[14].mod,
				["@mod15"] = mods[15].mod,
				["@mod16"] = mods[16].mod,
				["@mod23"] = mods[23].mod,
				["@mod24"] = mods[24].mod,
				["@mod25"] = mods[25].mod,
				["@mod26"] = mods[26].mod,
				["@mod27"] = mods[27].mod,
				["@mod28"] = mods[28].mod,
				["@mod29"] = mods[29].mod,
				["@mod30"] = mods[30].mod,
				["@mod31"] = mods[31].mod,
				["@mod32"] = mods[32].mod,
				["@mod33"] = mods[33].mod,
				["@mod34"] = mods[34].mod,
				["@mod35"] = mods[35].mod,
				["@mod36"] = mods[36].mod,
				["@mod37"] = mods[37].mod,
				["@mod38"] = mods[38].mod,
				["@mod39"] = mods[39].mod,
				["@mod40"] = mods[40].mod,
				["@mod41"] = mods[41].mod,
				["@mod42"] = mods[42].mod,
				["@mod43"] = mods[43].mod,
				["@mod44"] = mods[44].mod,
				["@mod45"] = mods[45].mod,
				["@mod46"] = mods[46].mod,
				["@mod48"] = mods[48].mod,
				["@tyre_smoke"] = tyre_smoke,
				["@xenon_lights"] = xenon_lights,
				["@turbo"] = turbo,
				["@custom_wheels"] = custom_wheels,
				["@custom_wheels2"] = custom_wheels2,
				["@bulletproof_wheels"] = bulletProofTyres,
				["@wheeltype"] = wheeltype,
				["@neon0"] = veh.neon0,
				["@neon1"] = veh.neon1,
				["@neon2"] = veh.neon2,
				["@neon3"] = veh.neon3,
	            ["@engine_health"] = veh.engine_health,
	            ["@petrol_health"] = veh.petrol_health,
	            ["@vehicle_health"] = veh.vehicle_health,
	            ["body_health"] = veh.body_health,
			})
		end)--]]
	end
end)

local inServiceCops = {}

function getpermissionlevel(identifier)
    return MySQL.Sync.fetchScalar("SELECT permission_level FROM users WHERE identifier = @name", {['@name'] = identifier})
end

function getjailtime(identifier)
    return MySQL.Sync.fetchScalar("SELECT jailtime FROM users WHERE identifier = @name", {['@name'] = identifier})
end

function getlicense(identifier)
    return MySQL.Sync.fetchScalar("SELECT gunlicense FROM users WHERE identifier=@name", {['@name'] = identifier})
end

function getowner(plate)
    return MySQL.Sync.fetchScalar("SELECT Nom FROM user_vehicle JOIN users ON user_vehicle.identifier = users.identifier WHERE vehicle_plate =@plate", {['@plate'] = plate})
end

function addCop(identifier)
	MySQL.Async.fetchAll("SELECT * FROM police WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier}, function (result)
		if(result[1] == nil) then
			MySQL.Async.execute("INSERT INTO police (`identifier`) VALUES ('"..identifier.."')", { ['@identifier'] = identifier})
		end
	end)
end

function remCop(identifier)
	MySQL.Async.execute("DELETE FROM police WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier})
end

RegisterServerEvent('police:removeCop')
AddEventHandler('police:removeCop', function()
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local identifier = user.getIdentifier()
		--print(identifier)
		remCop(identifier)
	end)
end)

function checkIsCop(identifier, source)
	MySQL.Async.fetchAll("SELECT * FROM police WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier}, function (result)
		if(result[1] == nil) then
			TriggerClientEvent('police:receiveIsCop', source, "inconnu")
		else
			TriggerClientEvent('police:receiveIsCop', source, result[1].rank)
		end
	end)
end

function s_checkIsCop(identifier)
	MySQL.Async.fetchAll("SELECT * FROM police WHERE identifier = @identifier", { ['@identifier'] = identifier}, function(getresult)
		local checkresult = getresult[1].rank
	
		if(not checkresult) then
			return "nil"
		else
			return checkresult
		end
	end)
end

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

function checkInventory(target)
	local identifier = getPlayerID(target)
	MySQL.Async.fetchAll("SELECT * FROM `user_inventory` JOIN items ON items.id = user_inventory.item_id WHERE user_id = '"..identifier.."'", { ['@username'] = identifier }, function (result)
		local strResult = "Items of " .. GetPlayerName(target) .. " : "
				
		for _, v in ipairs(result) do
			if(v.quantity ~= 0) then
				strResult = strResult .. v.quantity .. " - " .. v.libelle .. ", "
			end
					
			if(v.isIllegal == "1" or v.isIllegal == "True" or v.isIllegal == 1 or v.isIllegal == true) then
				TriggerClientEvent('police:dropIllegalItem', target, v.item_id)
			end
		end
		print(strResult)
		local probs = "Items of " .. GetPlayerName(target) .. " : "
		if strResult == probs then
			strResult = GetPlayerName(target).." has no items"
		end
		TriggerClientEvent("pNotify:SendNotification", source, {
            text = strResult,
            type = "error",
            queue = "left",
            timeout = 20000,
            layout = "centerRight"
        })
	end)

	MySQL.Async.fetchAll("SELECT * FROM gunshop WHERE identifier = '"..identifier.."'", { ['@username'] = identifier }, function (result)
		local strResult = "Weapons of " .. GetPlayerName(target) .. " : "
				
		for _, v in ipairs(result) do
			strResult = strResult .. v.weapon_name .. " - lvl "..v.licenselvl..", "
		end
		local probs = "Weapons of " .. GetPlayerName(target) .. " : "
		if strResult == probs then
			strResult = GetPlayerName(target).." has no weapons"
		end
		TriggerClientEvent("pNotify:SendNotification", source, {
            text = strResult,
            type = "error",
            queue = "left",
            timeout = 20000,
            layout = "centerRight"
        })
	end)
    TriggerEvent('es:getPlayerFromId', target, function(user)
    	TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text = GetPlayerName(target).." has <span style='color:lime'>$</span><span style='color:white'>"..user.dirty_money.."</span> in dirty money!",type = "error",queue = "left",timeout = 20000,layout = "centerRight"})
    	user:setDirty_Money(0)
    end)
	local license = getlicense(identifier)
	TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text = GetPlayerName(target).." has a level <span style='color:lime'>"..license.."</span> gun license",type = "error",queue = "left",timeout = 20000,layout = "centerRight"})
end

AddEventHandler('playerDropped', function()
	if(inServiceCops[source]) then
		inServiceCops[source] = nil
		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

AddEventHandler('es:playerDropped', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local isCop = s_checkIsCop(user.get('identifier'))
		if(isCop ~= "nil") then
			--TriggerEvent("jobssystem:disconnectReset", player, 7)
		end
	end)
end)

RegisterServerEvent('police:checkIsCop')
AddEventHandler('police:checkIsCop', function()
	local sourcePlayer = tonumber(source)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local identifier = user.get('identifier')
		--print(identifier)
		checkIsCop(identifier, sourcePlayer)
	end)
end)

RegisterServerEvent('police:takeService')
AddEventHandler('police:takeService', function()
	if(not inServiceCops[source]) then
		inServiceCops[source] = GetPlayerName(source)
		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

RegisterServerEvent('police:breakService')
AddEventHandler('police:breakService', function()
	if(inServiceCops[source]) then
		inServiceCops[source] = nil
		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

RegisterServerEvent('police:getAllCopsInService')
AddEventHandler('police:getAllCopsInService', function()
	TriggerClientEvent("police:resultAllCopsInService", source, inServiceCops)
end)

RegisterServerEvent('police:checkingPlate')
AddEventHandler('police:checkingPlate', function(plate)
    local result = getowner(plate)
    if (not result[1]) then
        TriggerClientEvent("pNotify:SendNotification", source, {
        	text = "The vehicle #"..plate.." is not registered!",
        	type = "error",
        	queue = "left",
        	timeout = 3000,
        	layout = "bottomCenter"
        })
    else
    	for _, v in ipairs(result) do
         	TriggerClientEvent("pNotify:SendNotification", source, {
            	text = "The vehicle <span style='color:lime'>"..plate.."</span> belongs to <span style='color:lime'>" ..v.Nom..".</span>",
            	type = "error",
            	queue = "left",
            	timeout = 6000,
            	layout = "bottomCenter"
			})
         end
    end
end)

RegisterServerEvent('police:confirmUnseat')
AddEventHandler('police:confirmUnseat', function(t)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, GetPlayerName(t).. " is out!")
	TriggerClientEvent('police:unseatme', t)
end)

RegisterServerEvent('police:targetCheckInventory')
AddEventHandler('police:targetCheckInventory', function(t)
	checkInventory(t)
end)

RegisterServerEvent('police:finesGranted')
AddEventHandler('police:finesGranted', function(t, amount, reason)
	TriggerClientEvent('chatMessage', t, 'GOVERNMENT', {255, 0, 0}, GetPlayerName(t).. " You paid $^2" .. amount .. "^7 fine for " .. reason)
	TriggerClientEvent('police:payFines', t, amount, reason)
end)
RegisterServerEvent('police:jailGranted')
AddEventHandler('police:jailGranted', function(t, amount, reason)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, GetPlayerName(t).. "You have been sentenced" .. amount .. "for" .. reason)
end)
RegisterServerEvent('police:cuffGranted')
AddEventHandler('police:cuffGranted', function(t)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, GetPlayerName(t).. " Handcuffs applied !")
	TriggerClientEvent('police:getArrested', t)
end)

RegisterServerEvent('police:forceEnterAsk')
AddEventHandler('police:forceEnterAsk', function(t, v)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, GetPlayerName(t).. " Enters the car)")
	TriggerClientEvent('police:forcedEnteringVeh', t, v)
end)

-- jail addon


-- jail addon end

RegisterServerEvent('police:dragRequest')
AddEventHandler('police:dragRequest', function(t)
	TriggerClientEvent('police:toggleDrag', t, source)
end)

RegisterServerEvent('police:spikes')
AddEventHandler('police:spikes', function(currentVeh, peeps)
    TriggerClientEvent("police:dietyres", peeps, currentVeh)
    TriggerClientEvent("police:dietyres2", peeps)
end)


-----------------------------------------------------------------------
----------------------EVENT SPAWN POLICE VEH---------------------------
-----------------------------------------------------------------------
RegisterServerEvent('CheckPoliceVeh')
AddEventHandler('CheckPoliceVeh', function(vehicle)
	local sourcePlayer = tonumber(source)
	TriggerEvent('es:getPlayerFromId', source, function(user)

			TriggerClientEvent('FinishPoliceCheckForVeh',sourcePlayer)
			-- Spawn police vehicle
			TriggerClientEvent('policeveh:spawnVehicle', sourcePlayer, vehicle)
	end)
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP COP-------------------
-----------------------------------------------------------------------
TriggerEvent('es:addGroupCommand', 'copadd', "admin", function(source, args, user)
	local sourcePlayer = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', sourcePlayer, 'GOVERNMENT', {255, 0, 0}, "Usage : /copadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				addCop(user.getIdentifier())
				TriggerClientEvent('chatMessage', sourcePlayer, 'GOVERNMENT', {255, 0, 0}, "Well understood !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "GOVERNMENT", false, "You are now a police man~w~.")
				TriggerClientEvent('police:nowCop', player)
			end)
		else
			TriggerClientEvent('chatMessage', sourcePlayer, 'GOVERNMENT', {255, 0, 0}, "No player with this ID")
		end
	end
end, function(source, args, user) 
	local sourcePlayer = tonumber(source)
	TriggerClientEvent('chatMessage', sourcePlayer, 'GOVERNMENT', {255, 0, 0}, "Permissions refused")
end)

TriggerEvent('es:addGroupCommand', 'coprem', "admin", function(source, args, user)
	local sourcePlayer = tonumber(source) 
     if(not args[2]) then
		TriggerClientEvent('chatMessage', sourcePlayer, 'GOVERNMENT', {255, 0, 0}, "Usage : /coprem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				remCop(user.getIdentifier())
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "GOVERNMENT", false, "You have been relieved of your dutys~w~.")
				TriggerClientEvent('chatMessage', sourcePlayer, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				--TriggerClientEvent('chatMessage', player, 'GOVERNMENT', {255, 0, 0}, "You're no longer a cop !")
				TriggerClientEvent('police:noLongerCop', player)
			end)
		else
			TriggerClientEvent('chatMessage', sourcePlayer, 'GOVERNMENT', {255, 0, 0}, "Pas de joueur avec cette ID")
		end
	end
end, function(source, args, user) 
	local sourcePlayer = tonumber(source)
	TriggerClientEvent('chatMessage', sourcePlayer, 'GOVERNMENT', {255, 0, 0}, "Permissions refused")
end)

	RegisterServerEvent('police:setService')
	AddEventHandler('police:setService', function (inService)
		TriggerEvent('es:getPlayerFromId', source , function (Player)
			Player.setSessionVar('policeInService', inService)
		end)
	end)

	RegisterServerEvent('police:showCharges')
	AddEventHandler('police:showCharges', function (t,charges)
        TriggerClientEvent('chatMessage', t, '[GOVERNMENT]', {255, 0, 0},"You have been charged with: "..table.concat(charges))
        TriggerClientEvent('chatMessage', source, '[GOVERNMENT]', {255, 0, 0}, "You have charged.."..GetPlayerName(t).." with: "..table.concat(charges))
	end)

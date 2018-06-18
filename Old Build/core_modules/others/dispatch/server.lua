local emergency_users = {}
local pay = {
	["10-15"] = 50,
	["10-31"] = 50,
	["10-32"] = 50,
	["10-90"] = 50,
}

RegisterServerEvent('paramedic:setService')
AddEventHandler('paramedic:setService', function (inService)
	local source = source
	if inService and not emergency_users[source] then
		emergency_users[source] = "paramedic"
	elseif not inService and emergency_users[source] then
		emergency_users[source] = nil
	end
end)

RegisterServerEvent('police:setService')
AddEventHandler('police:setService', function (inService)
	local source = source
	if inService and not emergency_users[source] then
		emergency_users[source] = "cop"
	elseif not inService and emergency_users[source] then
		emergency_users[source] = nil
	end
end)

AddEventHandler("playerDropped", function()
    local source = source
    if emergency_users[source] then
    	emergency_users[source] = nil
    end
end)

AddEventHandler("core:switch", function(source)
    local source = source
    if emergency_users[source] then
    	emergency_users[source] = nil
    end
end)

RegisterServerEvent("dispatch:ten-thirteen")
AddEventHandler("dispatch:ten-thirteen", function(street_name)
	local source = source
	for id, dept in pairs(emergency_users) do
		if dept ~= nil then
			TriggerClientEvent("chatMessage", id, "10-13", {255, 0, 0}, "^7Officer down at "..street_name)
			TriggerClientEvent("dispatch:add_ten-thirteen", id, source)
		end
	end
end)

RegisterServerEvent("dispatch:ten-thirtytwo")
AddEventHandler("dispatch:ten-thirtytwo", function(coords, street_name)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-32", {255, 0, 0}, "^7Shots fired at "..street_name)
			TriggerClientEvent("dispatch:ten-thirtytwo", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-thirtyone")
AddEventHandler("dispatch:ten-thirtyone", function(coords, street_name, model, plate)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-31", {255, 0, 0}, "^7Grand theft auto reported at "..street_name..". Car is a "..model.." with plate "..plate)
			TriggerClientEvent("dispatch:ten-thirtyone", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-thirtyone_2")
AddEventHandler("dispatch:ten-thirtyone_2", function(coords, street_name)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-31", {255, 0, 0}, "^7Possible break-in reported at "..street_name)
			TriggerClientEvent("dispatch:ten-thirtyone_2", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-fifthteen")
AddEventHandler("dispatch:ten-fifthteen", function(coords, street_name, gender)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-15", {255, 0, 0}, "^7Suspicious "..gender.." dealing drugs was reported at "..street_name)
			TriggerClientEvent("dispatch:ten-fifthteen", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-ninety")
AddEventHandler("dispatch:ten-ninety", function(coords, street_name)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-90", {255, 0, 0}, "^7A silent alarm has been triggered on "..street_name)
			TriggerClientEvent("dispatch:ten-ninety", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:pay")
AddEventHandler("dispatch:pay", function(type)
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "^4You have been paid $"..pay[type].." for responding to the "..type)
		user.addWallet(pay[type])
	end)
end)

RegisterServerEvent("dispatch:notify-cops")
AddEventHandler("dispatch:notify-cops", function(message)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "Dispatch", {0, 255, 0}, "^7"..message)
		end
	end
end)
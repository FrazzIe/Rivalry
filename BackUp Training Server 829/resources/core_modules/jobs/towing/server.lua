--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local activeTows = {}
local activeBlips = {}

RegisterServerEvent("tow:impound")
AddEventHandler("tow:impound", function(plate, instance)
	local plate = plate
	local source = source
	if plate ~= nil then
		impoundUserCar(plate)
		local pay = math.random(300,550)
		TriggerClientEvent("pNotify:SendNotification", source, {text = "Vehicle successfully impounded!, here's <span style='color:lime'>$</span><span style='color:white'>"..pay.."</span>",type = "error",queue = "left",timeout = 3000,layout = "bottomCenter"})
		TriggerEvent("f:getPlayer", source, function(user) user.addMoney(pay) end)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = "This vehicle doesn't even have a license plate?",type = "error",queue = "left",timeout = 3000,layout = "bottomCenter"})
	end
	activeBlips[plate] = nil
	TriggerClientEvent("tow:addBlip", -1, activeBlips)
end)

RegisterServerEvent("police:impound")
AddEventHandler("police:impound", function(plate, instance)
	local plate = plate
	local source = source
	if plate ~= nil then
		impoundUserCar(plate)
	end
	activeBlips[plate] = nil
	TriggerClientEvent("tow:addBlip", -1, activeBlips)
end)

function impoundUserCar(plate)
    TriggerEvent("f:getPlayers", function(users)
        for k , user in pairs(users) do
            if user.getCarOwner(plate) == true then
            	user.impoundCar(plate)
            end
        end
    end)
end

RegisterServerEvent('tow:setservice')
AddEventHandler('tow:setservice', function (inService)
	local source = source
	TriggerEvent('f:getPlayer',source,function(Player)
		Player.setSessionVar('towInService', inService)
	end)
	if inService then
		activeTows[source] = "true"
	else
		activeTows[source] = nil
	end
	TriggerClientEvent("tow:recieveTows", -1, activeTows)
	TriggerClientEvent("tow:addBlip", -1, activeBlips)
end)

AddEventHandler('playerDropped', function()
  if activeTows[source] then
  	activeTows[source] = nil
  	TriggerClientEvent("tow:recieveTows", -1, activeTows)
  end
end)

RegisterServerEvent("tow:addBlip")
AddEventHandler("tow:addBlip", function(vehicle_coords, plate, street)
	activeBlips[plate] = vehicle_coords
	for k,v in pairs(activeTows) do
		TriggerClientEvent("customNotification", k, "Impound requested for "..plate.." at "..street.."!")
		TriggerClientEvent("tow:addBlip", k, activeBlips)
	end
end)

RegisterServerEvent("tow:claim")
AddEventHandler("tow:claim", function(replacement)
	local source = source
	TriggerEvent("f:getPlayer", source, function(user) 
		if user.getMoney() >= 5000 then
			user.removeMoney(5000)
			local identity = user.getIdentity()
			local charName = identity.fname.." "..identity.sname
			local onlinetows = GetActiveTows()
			local towpay = 5000/tonumber(onlinetows)
			TriggerClientEvent("tow:claim", source, replacement)
		    TriggerEvent("f:getPlayers", function(users)
		        for k , user in pairs(users) do
		            if activeTows[k] then
		            	if charName then
		            		TriggerClientEvent("customNotification", k, "You have recieved <span style='color:lime'>$</span>"..math.floor(towpay).." as "..charName.." payed their impound fee!")
		            	else
		            		TriggerClientEvent("customNotification", k, "You have recieved <span style='color:lime'>$</span>"..math.floor(towpay).." as someone payed their impound fee!")
		            	end
		            	user.addMoney(tonumber(towpay))
		            end
		        end
		    end)
		else
			TriggerClientEvent("customNotification", source, "Insufficient funds")
		end
	end)
end)

function GetActiveTows()
	local count = 0
	for _, v in pairs(activeTows) do 
		if v == "true" then
			count = count + 1
		end
	end
	return count
end
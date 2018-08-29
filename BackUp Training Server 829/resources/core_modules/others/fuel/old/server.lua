--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(veh, pfuelcount, fuelcount)
	local source = tonumber(source)
	local addedFuel = (tonumber(fuelcount) - tonumber(pfuelcount))
	local cost = math.floor(tonumber(addedFuel)/1000)
	if cost < 5 then cost = 5 end
	TriggerEvent('core:getuser', source, function(user)
		if (tonumber(user.get("wallet")) >= tonumber(cost)) then
			user.removeWallet(tonumber(cost))
			TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text = "You have paid <span style='color:lime'>$</span><span style='color:white'>"..cost.."</span> for fuel!",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
		elseif (tonumber(user.get("bank")) >= tonumber(cost)) then
			user.removeBank(tonumber(cost))
			TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text = "You have paid <span style='color:lime'>$</span><span style='color:white'>"..cost.."</span> for fuel!",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})			
		else
			TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text = "Insufficient funds, fuel removed!",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
			TriggerClientEvent('fuel:removeFuel', source, veh, pfuelcount)
		end
	end)
end)
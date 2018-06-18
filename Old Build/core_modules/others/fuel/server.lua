--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(vehicle, max_fuel, previous_fuel, added_fuel)
	local cost = math.floor((added_fuel/max_fuel)*100)
	if cost < 5 then cost = 5 end
	TriggerEvent('core:getuser', source, function(user)
		if (tonumber(user.get("wallet")) >= tonumber(cost)) then
			user.removeWallet(tonumber(cost))
			Notify("You have paid <span style='color:lime'>$</span><span style='color:white'>"..cost.."</span> for fuel!", 3000, source)
		elseif (tonumber(user.get("bank")) >= tonumber(cost)) then
			user.removeBank(tonumber(cost))
			Notify("You have paid <span style='color:lime'>$</span><span style='color:white'>"..cost.."</span> for fuel!", 3000, source)
		else
			Notify("Insufficient funds, fuel removed!", 3000, source)
			TriggerClientEvent("fuel:remove", vehicle, previous_fuel)
		end
	end)
end)
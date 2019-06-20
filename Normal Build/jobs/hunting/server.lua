RegisterServerEvent('hunting:serverRequest')
AddEventHandler('hunting:serverRequest', function (typeRequest)
	local source = source

	if typeRequest == "SellViande" then
		TriggerEvent("inventory:getuser", source, function(inventory)
			local data = 0 
			if inventory[23] then
				if inventory[23].quantity ~= nil then
					if inventory[23].quantity > 0 then
						local sellprice = math.random(66, 99)
						TriggerEvent("inventory:remove_server", source, 23, 1)
						TriggerEvent('core:getuser', source, function(user)
							user.addWallet(sellprice)
						end)
						TriggerClientEvent("pNotify:SendNotification", source, {text = "Sold fresh meat for <span style='color:lime'>$</span><span style='color:white'>"..math.floor(sellprice).."</span>", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
					else
						TriggerClientEvent("pNotify:SendNotification", source, {text = "You don't have any meat to sell!", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
					end
				end
			end
		end)
	end
end)
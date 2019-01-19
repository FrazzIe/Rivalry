-- HELPER FUNCTIONS
function math.round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		if user ~= nil then
			if tonumber(amount) ~= nil then
				local amount_rounded = math.round(amount)
				if string.len(tostring(amount_rounded)) > 11 then
					TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Value too large^0")
				else
					if amount_rounded > 0 then
						if user.get("wallet") >= amount_rounded then
							user.addBank(amount_rounded)
							user.removeWallet(amount_rounded)
							TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "deposit: ~g~$".. amount_rounded .." ~n~~s~new Balance: ~g~$" .. user.get("bank"))
						else
							TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money^0")
						end
					end
				end
			end
	  	end
  	end)
end)

RegisterServerEvent('bank:withdrawAmende')
AddEventHandler('bank:withdrawAmende', function(amount)
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		if user ~= nil then
			local amount_rounded = math.round(amount)
			if string.len(tostring(amount_rounded)) <= 11 then
				if amount_rounded > 0 then
					user.removeBank(amount_rounded)
					TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "New Balance: ~g~$" .. user.get("bank"))
				end
			end
		end
	end)
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		if user ~= nil then
			if tonumber(amount) ~= nil then
				local amount_rounded = math.round(amount)
				if string.len(tostring(amount_rounded)) > 11 then
					TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Value too large^0")
				else
					if amount_rounded > 0 then
						if user.get("bank") >= amount_rounded then
							user.addWallet(amount_rounded)
							user.removeBank(amount_rounded)
							TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "withdrawal: ~g~$".. amount_rounded .." ~n~~s~New Balance: ~g~$" .. user.get("bank"))
						else
							TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money in account^0")
						end
					end
				end
			end
	  	end
  	end)
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(fromPlayer, toPlayer, amount)
	fromPlayer = tonumber(source)
	local source = tonumber(source)
  if tonumber(fromPlayer) == tonumber(toPlayer) then
	TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1You can not transfer to yourself^0")
	CancelEvent()
  else
	TriggerEvent('core:getuser', fromPlayer, function(user)
		local rounded = math.floor(tonumber(amount))
		if(string.len(tostring(rounded)) >= 9) then
		  TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Value to large^0")
		  CancelEvent()
		else
			if(tonumber(rounded) >= 0) then
			  if(tonumber(rounded) <= tonumber(user.get("bank"))) then
				user.removeBank(rounded)
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Transfered: ~r~-$".. rounded .." ~n~~s~New Balance: ~g~$" .. user.get("bank"))
				TriggerClientEvent("banking:updateBalance", source, user.get("bank"))
				TriggerEvent('core:getuser', toPlayer, function(user2)
					user2.addBank(rounded)
					TriggerClientEvent("es_freeroam:notify", tonumber(toPlayer), "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Recieved: ~g~$".. rounded .." ~n~~s~New Balance: ~g~$" .. user2.get("bank"))
					TriggerClientEvent("banking:updateBalance", tonumber(toPlayer), user2.get("bank"))
					CancelEvent()
				end)
				CancelEvent()
			  else
				TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money to complete^0")
				CancelEvent()
			  end
			else
			  TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Value too low^0")
			  CancelEvent()			
			end
		end
	end)
  end
end)
exports["kgv-blackjack"]:SetGetChipsCallback(function(source)
    return exports["core"]:GetPlayerChips(source)
end)

exports["kgv-blackjack"]:SetTakeChipsCallback(function(source, amount)
    exports["core"]:RemovePlayerChips(source, amount)
end)

exports["kgv-blackjack"]:SetGiveChipsCallback(function(source, amount)
    exports["core"]:AddPlayerChips(source, amount)
end)

AddEventHandler("onResourceStart", function(resourceName)
	if ("kgv-blackjack" == resourceName) then
        Citizen.Wait(2500)
        
		exports["kgv-blackjack"]:SetGetChipsCallback(function(source)
			return exports["core"]:GetPlayerChips(source)
		end)
		
		exports["kgv-blackjack"]:SetTakeChipsCallback(function(source, amount)
            exports["core"]:RemovePlayerChips(source, amount)
		end)
		
		exports["kgv-blackjack"]:SetGiveChipsCallback(function(source, amount)
            exports["core"]:AddPlayerChips(source, amount)
		end)
	end
end)

RegisterServerEvent("chipTrader:Aquire")
AddEventHandler("chipTrader:Aquire", function(amount)
	local cash = exports["core"]:GetPlayerCash(source)

	if cash >= amount then
		exports["core"]:RemovePlayerCash(source, amount)
		exports["core"]:AddPlayerChips(source, amount)

		TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "success", text = "Chips aquired!" })
	else
		TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "error", text = "You do not have enough cash!" })
	end
end)

RegisterServerEvent("chipTrader:Trade")
AddEventHandler("chipTrader:Trade", function(amount)
	local chips = exports["core"]:GetPlayerChips(source)

	if chips >= amount then
		exports["core"]:RemovePlayerChips(source, amount)
		exports["core"]:AddPlayerCash(source, amount)

		TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "success", text = "Chips traded!" })
	else
		TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "error", text = "You do not have enough chips!" })
	end
end)
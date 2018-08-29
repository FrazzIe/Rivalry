RegisterServerEvent('illegal:getDirtyMoney')
AddEventHandler('illegal:getDirtyMoney', function ()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
    print('montant : ' .. user.getDirtyMoney())
    TriggerClientEvent('illegal:getDirtyMoney',source, user.getDirtyMoney())
	end)
end)

RegisterServerEvent('illegal:transform')
AddEventHandler('illegal:transform', function (amount, ratio)
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
			local sale = user.getDirtyMoney()
			if sale > 0 then
        local realTransform = math.min(sale, amount)
				user.removeDirtyMoney(realTransform)
				user.addMoney(realTransform * math.min(1, ratio))
			end
	end)
end)
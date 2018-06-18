RegisterServerEvent('gopostal:checkjob')
AddEventHandler('gopostal:checkjob', function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local job = user.get("job")
		if job.id == 19 then --here you change the jobname (from your database)
			TriggerClientEvent('gopostal:deliverytrue', source)
		else
			TriggerClientEvent('gopostal:deliveryfalse', source)
		end
	end)
end)

RegisterServerEvent('gopostal:success')
AddEventHandler('gopostal:success', function(price)
	local source = source
	TriggerEvent('core:getuser', source, function(user)
		user.addWallet(tonumber(price))
	end)
end)

RegisterServerEvent('gopostal:fail')
AddEventHandler('gopostal:fail', function(price)
	local source = source
	TriggerEvent('core:getuser', source, function(user)
		user.removeWallet(tonumber(price))
	end)
end)
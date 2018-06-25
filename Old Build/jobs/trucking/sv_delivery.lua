RegisterServerEvent('trucking:checkjob')
AddEventHandler('trucking:checkjob', function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local job = user.get("job")
		if job.id == 24 then --here you change the jobname (from your database)
			TriggerClientEvent('trucking:deliverytrue', source)
		else
			TriggerClientEvent('trucking:deliveryfalse', source)
		end
	end)
end)

RegisterServerEvent('trucking:success')
AddEventHandler('trucking:success', function(price)
	local source = source
	TriggerEvent('core:getuser', source, function(user)
		user.addWallet(tonumber(price))
	end)
end)

RegisterServerEvent('trucking:fail')
AddEventHandler('trucking:fail', function(price)
	local source = source
	TriggerEvent('core:getuser', source, function(user)
		user.removeBank(tonumber(price))
	end)
end)
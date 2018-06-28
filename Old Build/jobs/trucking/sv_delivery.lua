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
AddEventHandler('trucking:success', function(amount)
    TriggerEvent('core:getuser', source, function(user)
        local jobtotal = amount
        if jobtotal > 4 then jobtotal = 150 end
        total = math.random(50,math.floor(jobtotal))
        user.addWallet(total*8)
    end)
end)

RegisterServerEvent('trucking:fail')
AddEventHandler('trucking:fail', function(price)
	local source = source
	TriggerEvent('core:getuser', source, function(user)
		user.removeBank(tonumber(price))
	end)
end)

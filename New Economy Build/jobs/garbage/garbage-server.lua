RegisterServerEvent('garbage:success')
AddEventHandler('garbage:success', function(amount)
	TriggerEvent("core:getuser", source, function(user)
		local garbagetotal = amount
		if garbagetotal > 150 then garbagetotal = 150 end
		total = math.random(50,math.floor(garbagetotal))
		user.addWallet(total)
	end)
end)

RegisterServerEvent('garbage:getplayerjob')
AddEventHandler('garbage:getplayerjob', function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)

		local job = user.get("job")
		TriggerClientEvent("garbage:result", source, job.id)
	end)
end)
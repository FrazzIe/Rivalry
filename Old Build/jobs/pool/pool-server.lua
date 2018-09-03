RegisterServerEvent('job:success')
AddEventHandler('job:success', function(amount)
    TriggerEvent('core:getuser', source, function(user)
        local pooltotal = amount
        if pooltotal > 150 then pooltotal = 150 end
        total = math.random(50,math.floor(pooltotal))
        user.addWallet(total)
    end)
end)

RegisterServerEvent('pool:getplayerjob')
AddEventHandler('pool:getplayerjob', function()
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        local job = user.get("job")
        user.removeWallet(250)
        TriggerClientEvent("pool:result", source, job.id)
    end)
end)
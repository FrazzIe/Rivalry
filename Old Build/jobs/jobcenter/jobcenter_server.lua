jobList = {
	{name="Unemployed", id=1},
	{name="police", id=2},
	{name="Miner", id=9},
	{name="bucheron", id=7},
	{name="Farmer", id=6},
	{name="Fisher", id=10},
	{name="Brewer", id=12},
	{name="vigneron", id=13},
	{name="emergency", id=15},
	{name="mechanic", id=16},
	{name="taxi", id=17},
	{name="Secret Service", id=18},
	{name="Trucker", id=24},
}

RegisterServerEvent('jobcenter:initialise')
AddEventHandler('jobcenter:initialise', function(source, currentJob)
	local source = tonumber(source)
	for _, item in pairs(jobList) do
		if currentJob.id == item.id then
			TriggerClientEvent(item.name..":drawBlips", source)
			TriggerClientEvent(item.name..":drawMarker", source, true)
			TriggerClientEvent(item.name..":marker", source)
		end
	end
    if currentJob.id == 22 then
        --TriggerClientEvent("tow:status", source, true)
    end
	TriggerClientEvent("jobcenter:updateJob", source, currentJob.name)
end)

RegisterServerEvent('jobcenter:isUnemployed')
AddEventHandler('jobcenter:isUnemployed', function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local currentJob = user.get("job")
		TriggerClientEvent('jobcenter:defineJobMenu', source, currentJob.id)
	end)
end)

RegisterServerEvent('jobcenter:jobs')
AddEventHandler('jobcenter:jobs', function(id)
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)

		local oldJob = user.get("job")

		for _, item in pairs(jobList) do
			if oldJob.id == item.id then
				TriggerClientEvent(item.name..":deleteBlips", source)
			end
		end

		user.job(id)

		local data = user.get("job")

        if id ~= 20 then
          TriggerClientEvent("pool:changedjob", source)
        elseif id ~= 21 then
          TriggerClientEvent("garbage:changedjob", source)
        end

		TriggerClientEvent("jobcenter:updateJob", source, data.name)

		for _, item in pairs(jobList) do
			if id == item.id then
				TriggerClientEvent(item.name..":drawBlips", source)
				TriggerClientEvent(item.name..":drawMarker", source, true)
				TriggerClientEvent(item.name..":marker", source)
			end
		end
	end)
end)

AddEventHandler("core:switch", function(source)
    local source = source
    TriggerEvent('core:getuser', source, function(user)
    	local job = user.get("job")
		for _, item in pairs(jobList) do
			if job.id == item.id then
				TriggerClientEvent(item.name..":deleteBlips", source)
			end
		end
    end)
end)

TriggerEvent('es:addGroupCommand', 'mecadd', "admin", function(source, args, user)
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /mecadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("core:getuser", player, function(target)
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Congrats, you're now a Mechanic !~w~.")
				TriggerClientEvent('jobcenter:getmyjob',player,16)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'mecrem', "admin", function(source, args, user) 
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /mecrem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("core:getuser", player, function(target)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "You're no longer a Mechanic !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent('jobcenter:getmyjob',player,1)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'taxadd', "admin", function(source, args, user)
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /taxadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("core:getuser", player, function(target)
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "Congrats, you're now a Taxi !~w~.")
				TriggerClientEvent('jobcenter:getmyjob',player,17)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'taxrem', "admin", function(source, args, user) 
	local source = tonumber(source)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Usage : /taxrem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("core:getuser", player, function(target)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "Government", false, "You're no longer a Taxi !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent('jobcenter:getmyjob',player,1)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	local source = tonumber(source)
	TriggerClientEvent('chatMessage', source, 'GOVERNMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

RegisterServerEvent('mission:completed')
AddEventHandler('mission:completed', function(total)
	local source = source
	TriggerEvent('core:getuser', source, function(user)
		user.addWallet(total)
		TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "You received ~g~$".. tonumber(total))
	end)
end)
	
	
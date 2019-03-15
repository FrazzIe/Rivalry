--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local lastrobbed = -9000000000
local eventfinished = false
local HeistActive = false
local robbers = {
    {ID=0, current_capacity=0, capacity=100,leader=false},
    {ID=0, current_capacity=0, capacity=100,leader=false},
    {ID=0, current_capacity=0, capacity=100,leader=false},
    {ID=0, current_capacity=0, capacity=100,leader=false},
}
local jewelryVehicles = {
    {ID=0, networkID=0, current_capacity=0, capacity=160},
    {ID=0, networkID=0, current_capacity=0, capacity=80},
    {ID=0, networkID=0, current_capacity=0, capacity=80},
    {ID=0, networkID=0, current_capacity=0, capacity=160},
}
local jewelryTrucks = {
	{ID=0, truck_networkID=0, trailer_networkID=0},
	{ID=0, truck_networkID=0, trailer_networkID=0},
	{ID=0, truck_networkID=0, trailer_networkID=0},
	{ID=0, truck_networkID=0, trailer_networkID=0},
}

RegisterServerEvent("jewel-heist:setCaseSmashed")
AddEventHandler("jewel-heist:setCaseSmashed", function(i)
    TriggerClientEvent("jewel-heist:setCaseSmashed", -1, i)
end)

RegisterServerEvent("jewel-heist:start")
AddEventHandler("jewel-heist:start", function(current_robbers)
	HeistActive = true
	local count = 0
    for k,v in pairs(robbers) do
    	if v.ID ~= 0 then
	    	count = count + 1
	    	TriggerClientEvent("jewel-heist:start", tonumber(v.ID), count, robbers)
	    end
    end
end)

RegisterServerEvent("jewel-heist:part-one")
AddEventHandler("jewel-heist:part-one", function()
    for k,v in pairs(robbers) do
    	if v.ID ~= 0 then
	    	TriggerClientEvent("jewel-heist:part-one", tonumber(v.ID))
	    end
    end
end)


RegisterServerEvent("jewel-heist:part-one-complete")
AddEventHandler("jewel-heist:part-one-complete", function()
	if not eventfinished then
		eventfinished = true
	    for k,v in pairs(robbers) do
	    	if v.ID ~= 0 then
		    	TriggerClientEvent("jewel-heist:part-one-complete", tonumber(v.ID))
		    end
	    end
	end
end)

RegisterServerEvent("jewel-heist:part-two")
AddEventHandler("jewel-heist:part-two", function()
    for k,v in pairs(robbers) do
    	if v.ID ~= 0 then
	    	TriggerClientEvent("jewel-heist:part-two", tonumber(v.ID))
	    end
    end
end)

RegisterServerEvent("jewel-heist:part-three")
AddEventHandler("jewel-heist:part-three", function()
    for k,v in pairs(robbers) do
    	if v.ID ~= 0 then
	    	TriggerClientEvent("jewel-heist:part-three", tonumber(v.ID))
	    end
    end
end)

RegisterServerEvent("jewel-heist:check")
AddEventHandler("jewel-heist:check",function(current_robbers)
	local source = source
	TriggerEvent("police:getCops", function(cops)
		if tonumber(cops) then
			if tonumber(cops) > 3 then
				if lastrobbed + 5400 < os.time() and activeRobbers() == 0 then
					lastrobbed = os.time()
					eventfinished = false
					robbers = current_robbers
					jewelryVehicles = {
					    {ID=0, networkID=0, current_capacity=0, capacity=160},
					    {ID=0, networkID=0, current_capacity=0, capacity=80},
					    {ID=0, networkID=0, current_capacity=0, capacity=80},
					    {ID=0, networkID=0, current_capacity=0, capacity=160},
					}
					jewelryTrucks = {
						{ID=0, truck_networkID=0, trailer_networkID=0},
						{ID=0, truck_networkID=0, trailer_networkID=0},
						{ID=0, truck_networkID=0, trailer_networkID=0},
						{ID=0, truck_networkID=0, trailer_networkID=0},
					}
					for k,v in pairs(robbers) do
						jewelryVehicles[k].ID = v.ID
						jewelryTrucks[k].ID = v.ID
					end
					TriggerClientEvent("jewel-heist:check", source)
			    elseif activeRobbers() > 0 then
			    	TriggerClientEvent("customNotification", source, "The jewelry store cannot be robbed at this time.")
			    elseif lastrobbed + 5400 > os.time() then

			        local remaining = (lastrobbed + 5400) - os.time()
			        local minutes = math.floor(remaining/60)
			        local seconds = math.floor(remaining - (minutes*60))

			        TriggerClientEvent("customNotification", source, "The jewelry store was robbed recently, please wait "..minutes.." minutes and "..seconds.." seconds")
			    end
			else
				TriggerClientEvent("customNotification", source, "The jewelry store cannot be robbed at this time")
			end
		else
			TriggerClientEvent("customNotification", source, "The jewelry store cannot be robbed at this time")
		end
	end)
end)

RegisterServerEvent("jewel-heist:notifycop")
AddEventHandler("jewel-heist:notifycop",function(message)
	TriggerClientEvent("jewel-heist:notifycop", -1, message)
end)

RegisterServerEvent("jewel-heist:notify")
AddEventHandler("jewel-heist:notify",function(message)
	local source = source
	for k,v in pairs(robbers) do
		if v.ID ~= 0 then
			TriggerClientEvent("customNotification", v.ID, message)
		end
	end
end)

RegisterServerEvent("jewel-heist:cancel")
AddEventHandler("jewel-heist:cancel",function(player, reason)
	local id = getYourId(player)
	local vid = getVehicleId(player)
	TriggerClientEvent("jewel-heist:cancel", player, reason)
	jewelryVehicles[vid] = {ID=0, networkID=0, current_capacity=0, capacity=160}
	robbers[id] = {ID=0, current_capacity=0, capacity=100,leader=false}
	for k,v in pairs(robbers) do
		if v.ID ~= 0 then
			TriggerClientEvent("jewel-heist:syncJewelry", v.ID, robbers, jewelryVehicles)
		end
	end
end)

RegisterServerEvent("jewel-heist:failed")
AddEventHandler("jewel-heist:failed",function(reason)
	for k,v in pairs(robbers) do
		if v.ID ~= 0 then
			TriggerClientEvent("jewel-heist:cancel", v.ID, reason)
			robbers[k] = {ID=0, current_capacity=0, capacity=100,leader=false}
		end
	end
	eventfinished = false
	HeistActive = false
	jewelryVehicles = {
		{ID=0, networkID=0, current_capacity=0, capacity=160},
		{ID=0, networkID=0, current_capacity=0, capacity=80},
		{ID=0, networkID=0, current_capacity=0, capacity=80},
		{ID=0, networkID=0, current_capacity=0, capacity=160},
	}
	jewelryTrucks = {
		{ID=0, truck_networkID=0, trailer_networkID=0},
		{ID=0, truck_networkID=0, trailer_networkID=0},
		{ID=0, truck_networkID=0, trailer_networkID=0},
		{ID=0, truck_networkID=0, trailer_networkID=0},
	}
	robbers = {
	    {ID=0, current_capacity=0, capacity=100,leader=false},
	    {ID=0, current_capacity=0, capacity=100,leader=false},
	    {ID=0, current_capacity=0, capacity=100,leader=false},
	    {ID=0, current_capacity=0, capacity=100,leader=false},
	}
end)

RegisterServerEvent("jewel-heist:storeHeistVeh")
AddEventHandler("jewel-heist:storeHeistVeh",function(vehicle)
	for k,v in pairs(jewelryVehicles) do
		if v.ID == source then
			v.networkID = vehicle
			break
		end
	end
	for k,v in pairs(robbers) do
		if v.ID ~= 0 then
			TriggerClientEvent("jewel-heist:storeHeistVeh", v.ID, jewelryVehicles)
		end
	end
end)

RegisterServerEvent("jewel-heist:storeHeistTruck")
AddEventHandler("jewel-heist:storeHeistTruck",function(truck, trailer)
	for k,v in pairs(jewelryTrucks) do
		if v.ID == source then
			v.truck_networkID = truck
			v.trailer_networkID = trailer
			break
		end
	end
	for k,v in pairs(robbers) do
		if v.ID ~= 0 then
			TriggerClientEvent("jewel-heist:storeHeistTruck", v.ID, jewelryTrucks)
		end
	end
end)

RegisterServerEvent("jewel-heist:receiveJewelry")
AddEventHandler("jewel-heist:receiveJewelry", function(amount)
	local source = source
	local id = getYourId(source)
	if robbers[id].current_capacity + amount > robbers[id].capacity then
		if robbers[id].current_capacity ~= robbers[id].capacity then
			robbers[id].current_capacity = robbers[id].capacity
		    for k,v in pairs(robbers) do
		    	if v.ID ~= 0 then
			    	TriggerClientEvent("jewel-heist:syncJewelry", v.ID, robbers, jewelryVehicles)
			    end
		    end			
		end
	else
		robbers[id].current_capacity = robbers[id].current_capacity + amount
		for k,v in pairs(robbers) do
		    if v.ID ~= 0 then
			    TriggerClientEvent("jewel-heist:syncJewelry", v.ID, robbers, jewelryVehicles)
			end
		end			
	end
end)

RegisterServerEvent("jewel-heist:storeJewelry")
AddEventHandler("jewel-heist:storeJewelry", function(vehicleID, amount)
	local source = source
	local id = getYourId(source)
	local vid = getVehicleId(vehicleID)
	if robbers[id].current_capacity >= amount then
		if jewelryVehicles[vid].current_capacity + amount >= jewelryVehicles[vid].capacity then
			if jewelryVehicles[vid].current_capacity ~= jewelryVehicles[vid].capacity then
				local available_space = jewelryVehicles[vid].capacity - jewelryVehicles[vid].current_capacity
				jewelryVehicles[vid].current_capacity = jewelryVehicles[vid].capacity
				local new_amount = amount - available_space
				robbers[id].current_capacity = new_amount
				for k,v in pairs(robbers) do
				    if v.ID ~= 0 then
					    TriggerClientEvent("jewel-heist:syncJewelry", v.ID, robbers, jewelryVehicles)
					end
				end
			end
		else
			jewelryVehicles[vid].current_capacity = jewelryVehicles[vid].current_capacity + amount
			robbers[id].current_capacity = robbers[id].current_capacity - amount
			for k,v in pairs(robbers) do
			    if v.ID ~= 0 then
				    TriggerClientEvent("jewel-heist:syncJewelry", v.ID, robbers, jewelryVehicles)
				end
			end
		end
	end
end)

RegisterServerEvent("jewel-heist:complete")
AddEventHandler("jewel-heist:complete", function(type)
	local source = source
	local id = getYourId(source)
	local vid = getVehicleId(source)
	local totalJewels = 0
	if type == 1 then
		totalJewels = robbers[id].current_capacity + jewelryVehicles[vid].current_capacity
	elseif type == 2 then
		totalJewels = robbers[id].current_capacity
	end
	local pay = totalJewels * 350
	TriggerEvent("core:getuser", source, function(user)
		if type == 1 then
			user.addBank(pay)
		elseif type == 2 then
			user.addDirty(pay)
		end
	end)
	jewelryVehicles[vid] = {ID=0, networkID=0, current_capacity=0, capacity=160}
	robbers[id] = {ID=0, current_capacity=0, capacity=100,leader=false}
	for k,v in pairs(robbers) do
		if v.ID ~= 0 then
			TriggerClientEvent("jewel-heist:syncJewelry", v.ID, robbers, jewelryVehicles)
		end
	end
end)

AddEventHandler("playerDropped",function()
	local id = getYourId(source)
	if id then
		local vid = getVehicleId(source)
		if robbers[id].leader == true then
			for k,v in pairs(robbers) do
				if v.ID ~= 0 then
					TriggerClientEvent("jewel-heist:cancel", v.ID, {heading="~r~Mission failed", desc="The leader disconnected and fucked you over"})
					v.ID = 0
				end
			end
			eventfinished = false
			HeistActive = false
			jewelryVehicles = {
				{ID=0, networkID=0, current_capacity=0, capacity=160},
				{ID=0, networkID=0, current_capacity=0, capacity=80},
				{ID=0, networkID=0, current_capacity=0, capacity=80},
				{ID=0, networkID=0, current_capacity=0, capacity=160},
			}
			jewelryTrucks = {
				{ID=0, truck_networkID=0, trailer_networkID=0},
				{ID=0, truck_networkID=0, trailer_networkID=0},
				{ID=0, truck_networkID=0, trailer_networkID=0},
				{ID=0, truck_networkID=0, trailer_networkID=0},
			}
			robbers = {
			    {ID=0, current_capacity=0, capacity=100,leader=false},
			    {ID=0, current_capacity=0, capacity=100,leader=false},
			    {ID=0, current_capacity=0, capacity=100,leader=false},
			    {ID=0, current_capacity=0, capacity=100,leader=false},
			}
		else
			jewelryVehicles[vid] = {ID=0, networkID=0, current_capacity=0, capacity=160}
			robbers[id] = {ID=0, current_capacity=0, capacity=100,leader=false}
			for k,v in pairs(robbers) do
				if v.ID ~= 0 then
					TriggerClientEvent("jewel-heist:syncJewelry", v.ID, robbers, jewelryVehicles)
				end
			end
		end
	end
end)

function activeRobbers()
	local count = 0
	for k,v in pairs(robbers) do
		if v.ID ~= 0 then
			count = count + 1
		end
	end
	return count
end

function getYourId(id)
    for k,v in pairs(robbers) do
        if v.ID == tonumber(id) then
            return k
        end
    end
    return nil
end

function getVehicleId(id)
    for k,v in pairs(robbers) do
        if v.ID == tonumber(id) then
            return k
        end
    end
    return nil
end
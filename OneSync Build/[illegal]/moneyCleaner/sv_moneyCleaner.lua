local machines = {}
local users = {}

local function SyncMachines(source)
	for k, v in pairs(machines) do
		v.timer = GetGameTimer() - v.startTime
	end

	if source == -1 then
		for user, _ in pairs(users) do
			TriggerClientEvent("moneyCleaner:sync", user, "machines", machines)
		end
	else
		TriggerClientEvent("moneyCleaner:sync", source, "machines", machines)
	end
end

RegisterNetEvent("moneyCleaner:requestMoney")
AddEventHandler("moneyCleaner:requestMoney", function()
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		TriggerClientEvent("moneyCleaner:sync", source, "dirty", user.get("dirty"))
	end)
end)

RegisterNetEvent("moneyCleaner:requestMachines")
AddEventHandler("moneyCleaner:requestMachines", function(toggle)
	if toggle then
		users[source] = true
		SyncMachines(source)
	else
		users[source] = nil
	end
end)

RegisterNetEvent("moneyCleaner:loadMachine")
AddEventHandler("moneyCleaner:loadMachine", function(index)
	local source = source

	TriggerEvent("core:getuser", source, function(user)
		local dirty = math.min(user.get("dirty"), Config.Cleaning.MaxDirty)
		user.removeDirty(dirty)

		if not machines[index] then
			machines[index] = { startTime = GetGameTimer(), dirty = 0 }
		end

		machines[index].dirty = machines[index].dirty + dirty
		SyncMachines(-1)
	end)
end)

RegisterNetEvent("moneyCleaner:unloadMachine")
AddEventHandler("moneyCleaner:unloadMachine", function(index)
	local source = source
	local machine = machines[index]

	if machine then
		TriggerEvent("core:getuser", source, function(user)
			user.addWallet(machines[index].dirty)
			machines[index] = nil
			SyncMachines(-1)
		end)
	end
end)
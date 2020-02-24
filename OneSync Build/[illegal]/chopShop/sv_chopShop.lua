LastListTime = 0
NextListTime = 0
Seed = 0
List = nil
Cooldowns = {}

--[[ Threads ]]--
Citizen.CreateThread(function()
	while true do
		Seed = os.time()
		math.randomseed(Seed)

		local delay = math.random(Config.ListDuration.Min, Config.ListDuration.Max)
		LastListTime = os.time()
		NextListTime = os.time() + delay * 60
		List = GetList(Seed)
		
		math.randomseed(GetGameTimer())

		TriggerClientEvent("chopShop:updateSeed", -1, Seed)

		Citizen.Wait(delay * 60000)
	end
end)

--[[ Functions ]]--
function FindCar(index, list)
	if not list then list = GetList(Seed) end

	for k, v in ipairs(list) do
		if index == v.index then
			return v.car
		end
	end
	return nil
end

--[[ Events ]]--
RegisterNetEvent("chopShop:requestSeed")
AddEventHandler("chopShop:requestSeed", function()
	TriggerClientEvent("chopShop:updateSeed", source, Seed)
end)

RegisterNetEvent("chopShop:requestTime")
AddEventHandler("chopShop:requestTime", function()
	TriggerClientEvent("chopShop:receiveTime", source, NextListTime - os.time())
end)

RegisterNetEvent("chopShop:chopVehicle")
AddEventHandler("chopShop:chopVehicle", function(index, modifier)
	local source = source

	-- Cooldown to prevent spam.
	if Cooldowns[source] then
		TriggerClientEvent("chopShop:chopResult", source, 2)
		return
	end

	Cooldowns[source] = true
	Citizen.CreateThread(function()
		Citizen.Wait(10000)
		Cooldowns[source] = nil
	end)

	-- Find car from index.
	local car = FindCar(index, List)
	if not car then
		TriggerClientEvent("chopShop:chopResult", source, 3)
		return
	end

	modifier = math.min(math.max(modifier, 0.0), 1.0)

	-- Chop the car.
	TriggerEvent("police:getCops", function(cops)
		-- cops = 2 -- DEBUG
		if tonumber(cops) >= Config.Cops.Min then
			local price = car.BasePrice * math.min(1.0 + (cops - Config.Cops.Min) / (Config.Cops.Max - Config.Cops.Min), Config.Cops.MaxRate) * modifier
			TriggerEvent("core:getuser", source, function(user)
				user.addWallet(price)
			end)
			TriggerClientEvent("chopShop:chopResult", source, 0)
		else
			TriggerClientEvent("chopShop:chopResult", source, 1)
		end
	end)
end)
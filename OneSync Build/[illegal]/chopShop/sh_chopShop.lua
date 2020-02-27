function GetList()
	math.randomseed(Seed)
	local count = math.random(Config.CarsPerList.Min, Config.CarsPerList.Max)
	local list = {}
	local pool = {}

	for k = 1, #Config.Cars do
		pool[#pool + 1] = k
	end
	
	for i = 1, count do
		local rand = math.random(1, #pool)
		local k = pool[rand]
		table.remove(pool, rand)
		list[i] = { index = k, car = Config.Cars[k] }
	end
	math.randomseed(GetGameTimer())

	-- list[1] = { index = 1, car = Config.Cars[1] } -- DEBUG
	-- list[2] = { index = 2, car = Config.Cars[2] } -- DEBUG
	-- list[3] = { index = 11, car = Config.Cars[11] } -- DEBUG

	return list
end
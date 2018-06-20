Mechanic.Ranks = {}

local function addRank(rank, inherit)
	if Mechanic.Ranks[inherit] then
		local table = {}
		for k,v in pairs(Mechanic.Ranks[inherit]) do
			table[k] = {}
		end
		table[inherit] = {}
		for k,v in pairs(Mechanic.Ranks) do
			if v[inherit] then
				v[rank] = {}
			end
		end
		Mechanic.Ranks[rank] = table
	else
		for k,v in pairs(Mechanic.Ranks) do
			v[rank] = {}
		end
		Mechanic.Ranks[rank] = {}	
	end
end

local function canTargetRank(user, target, callback)
	if Mechanic.Ranks[user] then
		if Mechanic.Ranks[target] then
			if Mechanic.Ranks[user][target] then
				callback(true)
			else
				callback(false)
			end
		else
			print("Error -> canTargetRank -> "..target.." rank doesn't exist.")
			callback(false)
		end
	else
		print("Error -> canTargetRank -> "..user.." rank doesn't exist.")
		callback(false)
	end
end

addRank("worker", "")
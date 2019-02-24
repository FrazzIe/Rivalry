DOJ.Ranks = {}

local function addRank(rank, inherit)
	if DOJ.Ranks[inherit] then
		local table = {}
		for k,v in pairs(DOJ.Ranks[inherit]) do
			table[k] = {}
		end
		table[inherit] = {}
		for k,v in pairs(DOJ.Ranks) do
			if v[inherit] then
				v[rank] = {}
			end
		end
		DOJ.Ranks[rank] = table
	else
		for k,v in pairs(DOJ.Ranks) do
			v[rank] = {}
		end
		DOJ.Ranks[rank] = {}	
	end
end

local function canTargetRank(user, target, callback)
	if DOJ.Ranks[user] then
		if DOJ.Ranks[target] then
			if DOJ.Ranks[user][target] then
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

addRank("chief justice", "")
addRank("justice", "")
addRank("judge", "")
addRank("district attorney", "")
addRank("assistant district attorney", "")
addRank("state attorney", "")
addRank("paralegal", "")
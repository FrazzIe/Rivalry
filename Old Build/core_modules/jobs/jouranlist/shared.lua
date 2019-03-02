News.Ranks = {}

local function addRank(rank, inherit)
	if News.Ranks[inherit] then
		local table = {}
		for k,v in pairs(News.Ranks[inherit]) do
			table[k] = {}
		end
		table[inherit] = {}
		for k,v in pairs(News.Ranks) do
			if v[inherit] then
				v[rank] = {}
			end
		end
		News.Ranks[rank] = table
	else
		for k,v in pairs(News.Ranks) do
			v[rank] = {}
		end
		News.Ranks[rank] = {}	
	end
end

local function canTargetRank(user, target, callback)
	if News.Ranks[user] then
		if News.Ranks[target] then
			if News.Ranks[user][target] then
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

addRank("intern", "")
addRank("cameraman i", "")
addRank("photographer i", "")
addRank("journalist i", "")
addRank("cameraman ii", "")
addRank("photographer ii", "")
addRank("journalist ii", "")
addRank("lead reporter", "")
addRank("chief executive", "")

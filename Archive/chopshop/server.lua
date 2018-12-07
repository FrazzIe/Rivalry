--[[ 
0: Compacts
1: Sedans
2: SUVs
3: Coupes
4: Muscle
5: Sports Classics
6: Sports
7: Super
8: Motorcycles
9: Off-road
10: Industrial
11: Utility
12: Vans
13: Cycles
14: Boats
15: Helicopters
16: Planes
17: Service
18: Emergency
19: Military
20: Commercial
21: Trains
]]--
local chopshop_pay = {
    [0] = 125,
    [1] = 150,
    [2] = 175,
    [3] = 150,
    [4] = 150,
    [5] = 200,
    [6] = 200,
    [7] = 300,
    [8] = 150,
    [9] = 150,
    [10] = 175,
    [11] = 175,
    [12] = 150,
    [13] = 75,
    [14] = 0,
    [15] = 0,
    [16] = 0,
    [17] = 175,
    [18] = 0,
    [19] = 0,
    [20] = 175,
    [21] = 0,
}

RegisterServerEvent("chopshop:pay")
AddEventHandler("chopshop:pay", function(class)
	local source = source
	if not chopshop_pay[class] then class = 2 end
	TriggerEvent("core:getuser", source, function(user)
		user.addDirty(chopshop_pay[class])
	end)
end)

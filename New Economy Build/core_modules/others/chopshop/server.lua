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
    [0] = 250,
    [1] = 250,
    [2] = 350,
    [3] = 250,
    [4] = 250,
    [5] = 250,
    [6] = 250,
    [7] = 400,
    [8] = 150,
    [9] = 250,
    [10] = 350,
    [11] = 250,
    [12] = 300,
    [13] = 50,
    [14] = 0,
    [15] = 0,
    [16] = 0,
    [17] = 250,
    [18] = 0,
    [19] = 0,
    [20] = 250,
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
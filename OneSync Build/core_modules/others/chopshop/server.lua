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
    [0] = 1250,
    [1] = 1500,
    [2] = 1750,
    [3] = 1500,
    [4] = 1500,
    [5] = 2000,
    [6] = 2000,
    [7] = 3000,
    [8] = 1500,
    [9] = 1500,
    [10] = 1750,
    [11] = 1750,
    [12] = 1500,
    [13] = 750,
    [14] = 0,
    [15] = 0,
    [16] = 0,
    [17] = 1750,
    [18] = 0,
    [19] = 0,
    [20] = 1750,
    [21] = 0,
}

RegisterServerEvent("ChopShop.Pay")
AddEventHandler("ChopShop.Pay", function(class)
	local Source = source
	if not chopshop_pay[class] then class = 2 end
	TriggerEvent("core:getuser", Source, function(user)
		user.addDirty(chopshop_pay[class])
	end)
end)

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
    [0] = 600,
    [1] = 600,
    [2] = 600,
    [3] = 600,
    [4] = 600,
    [5] = 750,
    [6] = 750,
    [7] = 1500,
    [8] = 300,
    [9] = 600,
    [10] = 500,
    [11] = 500,
    [12] = 500,
    [13] = 150,
    [14] = 0,
    [15] = 0,
    [16] = 0,
    [17] = 500,
    [18] = 0,
    [19] = 0,
    [20] = 500,
    [21] = 0,
}

RegisterServerEvent("ChopShop.Pay")
AddEventHandler("ChopShop.Pay", function(class)
	local Source = source
	if not chopshop_pay[class] then class = 2 end
    TriggerEvent("police:getCops", function(cops)
        if tonumber(cops) > 0 then
            TriggerEvent("core:getuser", Source, function(user)
                user.addDirty(chopshop_pay[class])
            end)
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = "Thanks for the free car bud, unfortunately I haven't heard anything on the police scanner. No risk no reward. ;)", type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
        end
    end)
end)

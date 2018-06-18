mission_list = {}

AddEventHandler("mechanic:menu_vehicle", function()
    exports.ui:reset()
    exports.ui:addOption("Towtruck", [[TriggerEvent("mechanic:spawnveh", 1)]])
    exports.ui:addOption("Flatbed", [[TriggerEvent("mechanic:spawnveh", 2)]])
    exports.ui:open()    
end)

AddEventHandler("mechanic:spawnveh", function(type)
    if type == 1 then
        spawnDepanneuse(spawnVehicleChoix, GetHashKey('towtruck'))
    elseif type == 2 then
        spawnDepanneuse(spawnVehicleChoix, GetHashKey('flatbed'))
    end
end)

AddEventHandler("mechanic:menu", function()
    TriggerServerEvent('mechanic:requestMission')
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Missions", [[TriggerEvent("mechanic:menu_missions")]])
    exports.ui:addOption("Vehicle analysis", [[TriggerEvent("mechanic:getStatusVehicle")]])
    exports.ui:addOption("Quick repair", [[TriggerEvent("mechanic:repairVehicle")]])
    exports.ui:addOption("Complete repair", [[TriggerEvent("mechanic:fullrepairVehicle")]])
    exports.ui:addOption("Open doors", [[TriggerEvent("mechanic:opendoors")]])
    exports.ui:addOption("Close doors", [[TriggerEvent("mechanic:closedoors")]])
    exports.ui:addOption("Clean vehicle", [[TriggerEvent("mechanic:clean")]])
    exports.ui:addOption("Show / hide help", [[TriggerEvent("mechanic:togglehelp")]])
    exports.ui:back([[TriggerEvent("interaction:main")]])
end)

AddEventHandler("mechanic:opendoors", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Drivers door", [[TriggerEvent("mechanic:menu_doors", "open", 0)]])
    exports.ui:addOption("Passenger door", [[TriggerEvent("mechanic:menu_doors", "open", 1)]])
    exports.ui:addOption("Rear drivers door", [[TriggerEvent("mechanic:menu_doors", "open", 2)]])
    exports.ui:addOption("Rear passenger door", [[TriggerEvent("mechanic:menu_doors", "open", 3)]])
    exports.ui:addOption("Hood", [[TriggerEvent("mechanic:menu_doors", "open", 4)]])
    exports.ui:addOption("Trunk", [[TriggerEvent("mechanic:menu_doors", "open", 5)]])
    exports.ui:addOption("Driver truck door", [[TriggerEvent("mechanic:menu_doors", "open", 6)]])
    exports.ui:addOption("Passenger truck door", [[TriggerEvent("mechanic:menu_doors", "open", 7)]])
    exports.ui:addOption("All the doors", [[TriggerEvent("mechanic:menu_doors", "open", -1)]])
    exports.ui:back([[TriggerEvent("mechanic:menu")]])
end)

AddEventHandler("mechanic:closedoors", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Drivers door", [[TriggerEvent("mechanic:menu_doors", "close", 0)]])
    exports.ui:addOption("Passenger door", [[TriggerEvent("mechanic:menu_doors", "close", 1)]])
    exports.ui:addOption("Rear drivers door", [[TriggerEvent("mechanic:menu_doors", "close", 2)]])
    exports.ui:addOption("Rear passenger door", [[TriggerEvent("mechanic:menu_doors", "close", 3)]])
    exports.ui:addOption("Hood", [[TriggerEvent("mechanic:menu_doors", "close", 4)]])
    exports.ui:addOption("Trunk", [[TriggerEvent("mechanic:menu_doors", "close", 5)]])
    exports.ui:addOption("Driver truck door", [[TriggerEvent("mechanic:menu_doors", "close", 6)]])
    exports.ui:addOption("Passenger truck door", [[TriggerEvent("mechanic:menu_doors", "close", 7)]])
    exports.ui:addOption("All the doors", [[TriggerEvent("mechanic:menu_doors", "close", -1)]])
    exports.ui:back([[TriggerEvent("mechanic:menu")]])
end)

AddEventHandler("mechanic:menu_doors", function(type, type2)
    print(type2)
    if type == "open" then
        openVehicleDoorData(tonumber(type2))
    elseif type == "close" then
        closeVehicleDoorData(tonumber(type2))
    end
end)

AddEventHandler("mechanic:menu_missions", function()
    exports.ui:reset()
    exports.ui:open("mechanic:missions")
    for k,v in pairs(mission_list) do
        exports.ui:addOption(v.name, v.event, v.mission)
    end
    exports.ui:back([[TriggerEvent("mechanic:menu")]])
end)
local grow_time = { -- Seconds
    min = 120,
    max = 300,
}
local weed_plants = {
    [1] = {start_time = 0.0, end_time = 0.0},
    [2] = {start_time = 0.0, end_time = 0.0},
    [3] = {start_time = 0.0, end_time = 0.0},
    [4] = {start_time = 0.0, end_time = 0.0},
    [5] = {start_time = 0.0, end_time = 0.0},
    [6] = {start_time = 0.0, end_time = 0.0},
    [7] = {start_time = 0.0, end_time = 0.0},
    [8] = {start_time = 0.0, end_time = 0.0},
    [9] = {start_time = 0.0, end_time = 0.0},
    [10] = {start_time = 0.0, end_time = 0.0},
    [11] = {start_time = 0.0, end_time = 0.0},
    [12] = {start_time = 0.0, end_time = 0.0},
    [13] = {start_time = 0.0, end_time = 0.0},
    [14] = {start_time = 0.0, end_time = 0.0},
    [15] = {start_time = 0.0, end_time = 0.0},
    [16] = {start_time = 0.0, end_time = 0.0},
    [17] = {start_time = 0.0, end_time = 0.0},
    [18] = {start_time = 0.0, end_time = 0.0},
    [19] = {start_time = 0.0, end_time = 0.0},
}
local traders = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0,
    [9] = 0,
    [10] = 0,
    [11] = 0,
    [12] = 0,
}
local joint_id, weed_id = 8, 4

local function ResetPlant(plant_id)
    math.randomseed(os.time())
    math.random(); math.random(); math.random();
    local start_time = os.time()
    weed_plants[plant_id].start_time = start_time
    weed_plants[plant_id].end_time = start_time + math.random(grow_time.min, grow_time.max)
    TriggerClientEvent("weed:sync", -1, weed_plants, traders)
end

local function CalculateGrowth(current_time, plant_start, plant_end)
    local total_seconds = plant_end - plant_start
    local elapsed_seconds = current_time - plant_start
    if math.floor((elapsed_seconds/total_seconds) * 100) > 100 then
        return 100
    else
        return math.floor((elapsed_seconds/total_seconds) * 100)
    end
end

local function GetGrowthInformation(current_growth)
    if current_growth >= 100 then
        return "Ready", 5
    elseif current_growth >= 80 then
        return "Flowering", 3
    elseif current_growth >= 70 then
        return "Vegetative", 2
    elseif current_growth >= 50 then
        return "Germination", 1
    end
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        math.randomseed(os.time())
        math.random(); math.random(); math.random();
        for i = 1, #weed_plants do
            local start_time = os.time()
            weed_plants[i].start_time = start_time
            weed_plants[i].end_time = start_time + math.random(grow_time.min, grow_time.max)
        end
    end
end)

AddEventHandler("weed:initialise", function(source)
    TriggerClientEvent("weed:sync", source, weed_plants, traders)
end)

RegisterServerEvent("weed:harvest")
AddEventHandler("weed:harvest", function(plant_id)
    local source = source
    local growth = CalculateGrowth(os.time(), weed_plants[plant_id].start_time, weed_plants[plant_id].end_time)
    local message, amount = GetGrowthInformation(growth)
    if growth >= 50 then
        if (getQuantity(source) + amount) <= user_max then
            TriggerClientEvent("weed:harvest", source)
            TriggerEvent("inventory:add_server", source, weed_id, amount)
            ResetPlant(plant_id)
        else
            TriggerClientEvent("inventory:messages", source, "~r~Your inventory is full")
        end
    end
end)

RegisterServerEvent("weed:trader")
AddEventHandler("weed:trader", function(id, _trader)
    local source = source
    traders[id] = _trader
    TriggerClientEvent("weed:sync", -1, weed_plants, traders)
end)

RegisterServerEvent("weed:trade")
AddEventHandler("weed:trade", function(trader, trader_ped)
    local source = source
    if user_inventory[source][weed_id] then
        local exchange = math.ceil(user_inventory[source][weed_id].quantity * (trader.rate / 100))
        TriggerEvent("inventory:remove_server", source, weed_id, user_inventory[source][weed_id].quantity)
        TriggerEvent("inventory:add_server", source, joint_id, exchange)
    end
end)

RegisterServerEvent("weed:sell")
AddEventHandler("weed:sell", function(pay, money_type)
    local source = source
    TriggerEvent("core:getuser", source, function(user)
        if money_type == 1 then
            user.addWallet(pay)
        else
            user.addDirty(pay)
        end
    end)
end)
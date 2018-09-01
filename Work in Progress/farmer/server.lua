local user_max = 100
local _plant_id = 50

RegisterServerEvent("weed:harvest")
AddEventHandler("weed:harvest", function(plant_id, growth, amount)
    TriggerEvent("core:getuser", source, function(user)
        if growth >= 100 then
            if (getQuantity(source) + amount) <= user_max then
                TriggerEvent("inventory:add_server", source, _plant_id, amount)
            else
                TriggerClientEvent("inventory:messages", source, "~r~Your inventory is full")
            end
        elseif growth >= 80 then
            if (getQuantity(source) + amount) <= user_max then
                TriggerEvent("inventory:add_server", source, _plant_id, amount)
            else
                TriggerClientEvent("inventory:messages", source, "~r~Your inventory is full")
            end
        elseif growth >= 70 then
            if (getQuantity(source) + amount) <= user_max then
                TriggerEvent("inventory:add_server", source, _plant_id, amount)
            else
                TriggerClientEvent("inventory:messages", source, "~r~Your inventory is full")
            end
        elseif growth >= 50 then
            if (getQuantity(source) + amount) <= user_max then
                TriggerEvent("inventory:add_server", source, _plant_id, amount)
            else
                TriggerClientEvent("inventory:messages", source, "~r~Your inventory is full")
            end
        end
    end)
end)
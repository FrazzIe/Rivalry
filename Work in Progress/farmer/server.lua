local user_max = 100
local _plant_id = 50
local tractor_rent = 50

RegisterServerEvent("farmer:rent")
AddEventHandler("farmer:rent", function()
    local source = source
    TriggerEvent("core:getuser", source, function(user)
        if user.get("wallet") >= tractor_rent then
            user.removeWallet(tractor_rent)
            TriggerClientEvent("farmer:rent", source)
        elseif user.get("bank") >= tractor_rent then
            user.removeBank(tractor_rent)
            TriggerClientEvent("farmer:rent", source)
        else
            Notify("Insufficient funds", 2500, source)
        end
    end)
end)

RegisterServerEvent("plant:harvest")
AddEventHandler("plant:harvest", function(plant_id, growth, amount)
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
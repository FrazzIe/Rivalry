local Cocaine = {
    Locations = {
        Pickup = vector3(-495.73739624023,-2911.3024902344,6.0003871917725),
        Van = vector3(-488.9792175293,-2909.376953125,6.000385761261),
    },
    Cost = {
        Dirty = 50,
        Van = 250,
    },
    Items = {
        Dirty = 47,
        Cocaine = 28,
    },
    Vehicle = {
        Model = "boxville4",
        Handle = nil,
    },
    Pay = {
        Min = 150,
        Max = 200,
    },
    Harvesting = false,
    Cooldown = 0,
}

RegisterServerEvent("cocaine:clean")
AddEventHandler("cocaine:clean", function()
    local source = source
    if user_inventory[source][Cocaine.Items.Dirty] then
        if user_inventory[source][Cocaine.Items.Dirty].quantity >= 1 then
            if user_inventory[source][Cocaine.Items.Dirty].quantity >= 5 then
                TriggerEvent("inventory:remove_server", source, Cocaine.Items.Dirty, 5)
                TriggerEvent("inventory:add_server", source, Cocaine.Items.Cocaine, 5)
                Notify("Cleaned 5 grams of cocaine", 3000, source)
            else
                Notify("Cleaned "..user_inventory[source][Cocaine.Items.Dirty].quantity.." grams of cocaine", 3000, source)
                TriggerEvent("inventory:add_server", source, Cocaine.Items.Cocaine, user_inventory[source][Cocaine.Items.Dirty].quantity)
                TriggerEvent("inventory:remove_server", source, Cocaine.Items.Dirty, user_inventory[source][Cocaine.Items.Dirty].quantity)
            end
        end
    end
end)

RegisterServerEvent("cocaine:purchase")
AddEventHandler("cocaine:purchase", function(Amount)
    local source = source
    TriggerEvent("core:getuser", source, function(user)
        if (getQuantity(source) + Amount) <= user_max then
            if user.get("wallet") >= (Cocaine.Cost.Dirty * Amount) then
                Notify("Dirty coke purchased!", 1500, source)
                user.removeWallet(Cocaine.Cost.Dirty * Amount)
                TriggerEvent("inventory:add_server", source, Cocaine.Items.Dirty, Amount)
            end
        else
            Notify("You do not have enough space!", 3000, source)
        end
    end)
end)

RegisterServerEvent("cocaine:vehicle")
AddEventHandler("cocaine:vehicle", function()
    local source = source
    TriggerEvent("core:getuser", source, function(user)
        if user.get("wallet") >= Cocaine.Cost.Van then
            user.removeWallet(Cocaine.Cost.Van)
            TriggerClientEvent("cocaine:vehicle", source)
        end
    end)
end)

RegisterServerEvent("cocaine:sell")
AddEventHandler("cocaine:sell", function(pay, money_type, amount)
    local source = source

    print(string.format("pay: %s, match: %s, max: %s, amount: %s", pay, Cocaine.Pay.Max * amount, Cocaine.Pay.Max, amount))
    if pay > (Cocaine.Pay.Max * amount) then
        TriggerEvent("core:anticheat-ban", source, string.format("Script Tampering (p: %s, m: %s, a: %s) (C) (1)", pay, Cocaine.Pay.Max * amount, amount))
    else
        if user_inventory[source][Cocaine.Items.Cocaine] then
            if user_inventory[source][Cocaine.Items.Cocaine].quantity >= amount then
                TriggerEvent("inventory:remove_server", source, Cocaine.Items.Cocaine, amount)
                TriggerEvent("core:getuser", source, function(user)
                    if money_type == 1 then
                        user.addWallet(pay)
                    else
                        user.addDirty(pay)
                    end
                end)
            else
                if amount > 1 then
                    TriggerEvent("core:anticheat-ban", source, string.format("Script Tampering (p: %s, m: %s, a: %s) (C) (2)", pay, Cocaine.Pay.Max * amount, amount))
                end
            end
        end
    end
end)

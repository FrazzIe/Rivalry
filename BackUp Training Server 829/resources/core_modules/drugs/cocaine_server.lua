local Cocaine = {
    Locations = {
        Pickup = {x = -495.73739624023, y = -2911.3024902344, z = 6.0003871917725, h = 42.021656036377},
        Van = {x = -488.9792175293, y = -2909.376953125, z = 6.000385761261, h = 316.95101928711},
    },
    Cost = {
        Dirty = 50,
        Van = 500,
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
        Min = 500,
        Max = 750,
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
AddEventHandler("cocaine:purchase", function()
    local source = source
    TriggerEvent("core:getuser", source, function(user)
        if user.get("wallet") >= Cocaine.Cost.Dirty then
            Notify("Dirty coke purchased!", 1500, source)
            user.removeWallet(Cocaine.Cost.Dirty)
            TriggerEvent("inventory:add_server", source, Cocaine.Items.Dirty, 1)
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
AddEventHandler("cocaine:sell", function(pay, money_type)
    local source = source
    TriggerEvent("core:getuser", source, function(user)
        if money_type == 1 then
            user.addWallet(pay)
        else
            user.addDirty(pay)
        end
    end)
end)
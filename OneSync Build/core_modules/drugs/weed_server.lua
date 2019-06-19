function Weed:ResetPlant(Plant)
    local Time = os.time()

    math.randomseed(Time)
    math.random(Weed.Growthtime.Minimum, Weed.Growthtime.Maximum)
    math.random(Weed.Growthtime.Minimum, Weed.Growthtime.Maximum)
    math.random(Weed.Growthtime.Minimum, Weed.Growthtime.Maximum)

    Weed.Plants[Plant].Start = Time
    Weed.Plants[Plant].End = Time + math.random(Weed.Growthtime.Minimum, Weed.Growthtime.Maximum)

   TriggerClientEvent("Weed.Sync", -1, Weed.Plants)
end

AddEventHandler('onResourceStart', function(Resource)
    if Resource == GetCurrentResourceName() then
        local Time = os.time()

        math.randomseed(Time)
        math.random(Weed.Growthtime.Minimum, Weed.Growthtime.Maximum)
        math.random(Weed.Growthtime.Minimum, Weed.Growthtime.Maximum)
        math.random(Weed.Growthtime.Minimum, Weed.Growthtime.Maximum)

        for Index = 1, #Weed.Plants do
            Weed.Plants[Index].Start = Time
            Weed.Plants[Index].End = Time + math.random(Weed.Growthtime.Minimum, Weed.Growthtime.Maximum)
        end
    end
end)

RegisterServerEvent("Weed.Initialise")
AddEventHandler("Weed.Initialise", function()
    local Source = source
    TriggerClientEvent("Weed.Sync", Source, Weed.Plants)
end)

RegisterServerEvent("Weed.Harvest")
AddEventHandler("Weed.Harvest", function(Plant)
    local Source = source
    local Growth = Weed:CalculateGrowth(os.time(), Weed.Plants[Plant].Start, Weed.Plants[Plant].End)
    local Message, Amount, Cost = Weed:GetGrowthInformation(Growth)

    TriggerEvent("core:getuser", Source, function(user)
        if user.get("wallet") >= Cost then            
            if (getQuantity(Source) + Amount) <= user_max then
                user.removeWallet(Cost)

                TriggerClientEvent("Weed.Harvest", Source)

                TriggerEvent("inventory:add_server", Source, Weed.Items.Weed, Amount)

                Weed:ResetPlant(Plant)
            else
                TriggerClientEvent("inventory:messages", Source, "~r~Your inventory is full")
            end
        else
            TriggerClientEvent("inventory:messages", Source, "~r~You don't have enough cash")
        end
    end)
end)

RegisterServerEvent("Weed.Trade")
AddEventHandler("Weed.Trade", function(Rate)
    local Source = source

    if user_inventory[Source][Weed.Items.Weed] then
        local Exchange = math.ceil(user_inventory[Source][Weed.Items.Weed].quantity * (Rate / 100))

        TriggerEvent("inventory:remove_server", Source, Weed.Items.Weed, user_inventory[Source][Weed.Items.Weed].quantity)
        TriggerEvent("inventory:add_server", Source, Weed.Items.Joint, Exchange)
    end
end)

RegisterServerEvent("Weed.Sell")
AddEventHandler("Weed.Sell", function(Pay, Clean, Amount)
    local Source = source

    if Pay > (Weed.Pay.Maximum * Amount) then

        TriggerEvent("core:anticheat-ban", Source, string.format("Script Tampering (p: %s, m: %s, a: %s) (W) (1)", Pay, Weed.Pay.Maximum * Amount, Amount))
    else
        if user_inventory[Source][Weed.Items.Joint] then
            if user_inventory[Source][Weed.Items.Joint].quantity >= Amount then
                TriggerEvent("inventory:remove_server", Source, Weed.Items.Joint, Amount)
                TriggerEvent("core:getuser", Source, function(user)
                    if Clean then
                        user.addWallet(Pay)
                    else
                        user.addDirty(Pay)
                    end
                end)
            else
                if Amount > 1 then
                    TriggerEvent("core:anticheat-ban", Source, string.format("Script Tampering (p: %s, m: %s, a: %s) (W) (2)", Pay, Weed.Pay.Maximum * Amount, Amount))
                end
            end
        end
    end
end)
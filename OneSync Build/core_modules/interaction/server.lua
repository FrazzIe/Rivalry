--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
vehicle_keys = {}
user_keys = {}

TriggerEvent("core:addCommand", "help", function(source, args, rawCommand, data, power, group)
    TriggerClientEvent("interaction:help", source)
end, {help = "Shows basic information"})

TriggerEvent("core:addCommand", "controller", function(source, args, rawCommand, data, power, group)
    TriggerClientEvent("interaction:controller", source)
end, {help = "Needed for plebs using a controller ^_^ cobra."})

AddEventHandler("playerDropped", function()
    local source = source
    handcuffs[source] = nil
    handcuff_keys[source] = nil
end)

AddEventHandler("core:switch", function(source)
    local source = source
    handcuffs[source] = nil
    handcuff_keys[source] = nil
end)

--[[ Money Transfer ]]--
RegisterServerEvent("interaction:givemoney")
AddEventHandler("interaction:givemoney", function(amount, target)
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        if user.get("wallet") >= tonumber(amount) then
            if user.get("timeplayed") > 7200 then
                user.removeWallet(math.floor(amount))
                TriggerEvent('core:getuser', tonumber(target), function(user2)
                    if amount >= 10000 then
                        logMoney({steam = getID("steam", target), name = GetIdentity(target)},{steam = getID("steam", source), name = GetIdentity(source)},"Transferred $" .. math.floor(amount) .. " clean cash")
                    end
                    user2.addWallet(math.floor(amount)) 
                    TriggerClientEvent("pNotify:SendNotification", source, {text = "You gave "..user2.get("first_name").." "..user2.get("last_name").." <span style='color:lime'>$</span>"..amount.."!",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})
                end)
                TriggerClientEvent("pNotify:SendNotification", tonumber(target), {text = user.get("first_name").." "..user.get("last_name").." has gave you <span style='color:lime'>$</span>"..amount.."!",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})   
            else
                TriggerClientEvent("pNotify:SendNotification", source, {text = "You must have at least 2 hours playtime to transfer money!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
            end
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You do not have enough money!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
        end
    end)
end)

RegisterServerEvent("interaction:givedmoney")
AddEventHandler("interaction:givedmoney", function(amount, target)
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        if user.get("dirty") >= tonumber(amount) then
            user.removeDirty(math.floor(amount))
            TriggerEvent('core:getuser', tonumber(target), function(user2)
                if amount >= 10000 then
                    logMoney({steam = getID("steam", target), name = GetIdentity(target)},{steam = getID("steam", source), name = GetIdentity(source)},"Transferred $" .. math.floor(amount) .. " dirty cash")
                end
                user2.addDirty(math.floor(amount)) 
                TriggerClientEvent("pNotify:SendNotification", source, {text = "You gave "..user2.get("first_name").." "..user2.get("last_name").." <span style='color:lime'>$</span>"..amount.." of dirty cash",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})  
            end)
            TriggerClientEvent("pNotify:SendNotification", tonumber(target), {text = user.get("first_name").." "..user.get("last_name").." has gave you <span style='color:lime'>$</span>"..amount.." of cash that appears to be dirty!",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You do not have enough money!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
        end
    end)
end)

RegisterNetEvent("interaction:take_money")
AddEventHandler("interaction:take_money", function(target)
    local source = source
    if handcuffs[target] then
        if handcuffs[target].cuffed and handcuffs[target].keyholder == source then
            TriggerEvent("core:getuser", target, function(user)
                local dirty_money = user.get("dirty")
                local wallet = user.get("wallet")
                user.dirty(0)
                user.wallet(0)
                Notify("You stole all of "..user.get("first_name").." "..user.get("last_name").."'s cash!", 3000, source)
                if dirty_money >= 10000 or wallet >= 10000 then
                    logMoney({steam = getID("steam", target), name = GetIdentity(target)},{steam = getID("steam", source), name = GetIdentity(source)},"Stole $" .. math.floor(wallet) .. " clean and $" .. math.floor(dirty_money) .. " dirty")
                end
                TriggerEvent("core:getuser", source, function(user2)
                    user2.addWallet(wallet)
                    user2.addDirty(dirty_money)
                    Notify(user2.get("first_name").." "..user2.get("last_name").." stole all of your cash!", 3000, target)
                end)            
            end)
        else
            Notify("The target is handcuffed, but you do not have the keys!", 3000, source)
        end
    else
        Notify("The target is not handcuffed!", 3000, source)
    end
end)

RegisterNetEvent("interaction:destroy_money")
AddEventHandler("interaction:destroy_money", function(target)
    local source = source
    if handcuffs[target] then
        if handcuffs[target].cuffed and handcuffs[target].keyholder == source then
            TriggerEvent("core:getuser", target, function(user)
                user.dirty(0)
                user.wallet(0)
                Notify("You destroyed all of "..user.get("first_name").." "..user.get("last_name").."'s cash!", 3000, source)        
            end)
            Notify(GetIdentity(source).." destroyed all of your cash!", 3000, target)
        else
            Notify("The target is handcuffed, but you do not have the keys!", 3000, source)
        end
    else
        Notify("The target is not handcuffed!", 3000, source)
    end
end)

--[[ Handcuffs ]]--
handcuffs = {}
handcuff_keys = {}

AddEventHandler("handcuffs:initialise", function(source)
    handcuffs[source] = {cuffed = false, keyholder = nil}
    handcuff_keys[source] = {}
    TriggerClientEvent("handcuffs:sync", -1, handcuffs)
end)

RegisterServerEvent("handcuffs:reload")
AddEventHandler("handcuffs:reload", function()
    local source = source
    handcuffs[source] = {cuffed = false, keyholder = nil}
    handcuff_keys[source] = {}
    TriggerClientEvent("handcuffs:sync", -1, handcuffs)
end)

RegisterServerEvent("handcuffs:cuff")
AddEventHandler("handcuffs:cuff", function(target)
    local source = source
    if not handcuffs[target].cuffed then
        handcuffs[target].cuffed = true
        handcuffs[target].keyholder = source
        handcuff_keys[source][target] = true
        TriggerClientEvent("handcuffs:sync", -1, handcuffs)
        TriggerClientEvent("handcuffs:sync_keys", source, handcuff_keys[source])
        TriggerClientEvent("handcuffs:check", target, source)
    else
        Notify("This user is already cuffed!", 2500, source)
        TriggerEvent("inventory:add_server", source, 44, 1)
    end
end)

RegisterServerEvent("handcuffs:uncuff")
AddEventHandler("handcuffs:uncuff", function(target)
    local source = source
    if handcuffs[target] then
        if handcuffs[target].keyholder then
            if handcuffs[target].keyholder == source then
                handcuffs[target].cuffed = false
                handcuffs[target].keyholder = nil
                TriggerClientEvent("handcuffs:sync", -1, handcuffs)
                TriggerClientEvent("handcuffs:sync_keys", source, handcuff_keys[source])
                TriggerClientEvent("handcuffs:uncuff", target)
                TriggerEvent("inventory:add_server", source, 44, 1)
            else
                handcuffs[target].cuffed = false
                handcuffs[target].keyholder = nil
                handcuff_keys[source][target] = nil
                TriggerClientEvent("handcuffs:sync", -1, handcuffs)
                TriggerClientEvent("handcuffs:sync_keys", source, handcuff_keys[source])
                TriggerClientEvent("handcuffs:uncuff", target)
            end
        end
    end
end)

RegisterServerEvent("handcuffs:success")
AddEventHandler("handcuffs:success", function(_source)
    local source = source
    Notify("You have been handcuffed!", 2500, source)
    Notify("Successfully handcuffed!", 2500, _source)
end)

RegisterServerEvent("handcuffs:fail")
AddEventHandler("handcuffs:fail", function(reason, _source)
    local source = source
    local _source = _source
    handcuffs[source].cuffed = false
    handcuffs[source].keyholder = nil
    handcuff_keys[_source][source] = nil
    Notify(reason, 2500, _source)
    TriggerEvent("inventory:add_server", _source, 44, 1)
    TriggerClientEvent("handcuffs:sync", -1, handcuffs)
    TriggerClientEvent("handcuffs:sync_keys", source, handcuff_keys[source])
end)

RegisterServerEvent("handcuffs:give_key")
AddEventHandler("handcuffs:give_key", function(target, keyid)
    local source = source
    if handcuff_keys[source][keyid] then
        handcuff_keys[source][keyid] = nil
        handcuff_keys[target][keyid] = true
        handcuffs[keyid].keyholder = target
        TriggerClientEvent("handcuffs:sync", -1, handcuffs)
        TriggerClientEvent("handcuffs:sync_keys", source, handcuff_keys[source])
        TriggerClientEvent("handcuffs:sync_keys", target, handcuff_keys[target])
    else
        Notify("Key not found?", 2500, source)
    end
end)

--[[ Doors ]]--
doors = {
    single = {
        [1] = {x = 0, y = 0, z = 0, model = 0, heading = 0.0, locked = false},
    },
    double = {
        [1] = {
            ["left"] = {x = 0, y = 0, z = 0, model = 0, heading = 0.0, locked = false},
            ["right"] = {x = 0, y = 0, z = 0, model = 0, heading = 0.0, locked = false},
        },
    }
}

AddEventHandler("doors:initialise", function(source)
    TriggerClientEvent("doors:sync", -1, doors)
end)

RegisterServerEvent("doors:lock")
AddEventHandler("doors:lock", function(doorid, type)
    local source = source
    if type == "single" then
        doors.single[doorid].locked = not doors.single[doorid].locked
        TriggerClientEvent("doors:sync", -1, doors)
    elseif type == "double" then
        doors.double[doorid]["left"].locked = not doors.double[doorid]["left"].locked
        doors.double[doorid]["right"].locked = doors.double[doorid]["left"].locked
        TriggerClientEvent("doors:sync", -1, doors)
    end
end)

--[[ Escort ]]--
RegisterServerEvent("interaction:drag")
AddEventHandler("interaction:drag", function(target)
    TriggerClientEvent("interaction:drag", target, source)
end)

--[[ Drivers license ]]--

AddEventHandler("core:loaded", function(source, user, power, group)
    TriggerClientEvent("interaction:set_drivers_license", source, user.get("drivers_license"))
end)

RegisterServerEvent("interaction:buy_drivers_license")
AddEventHandler("interaction:buy_drivers_license", function(target)
    local source = source
    TriggerEvent("core:getuser", target, function(user)
        user.set("drivers_license", "true")
        TriggerClientEvent("interaction:set_drivers_license", target, "true")
        Notify("Drivers license reinstated!", 3000, target)
        Notify("You reinstated "..GetIdentity(target).."'s drivers license!", 3000, source)
    end)
end)

--[[ Robbing - Phone removal ]]--
RegisterNetEvent("interaction:take_phone")
AddEventHandler("interaction:take_phone", function(target)
    local source = source
    if handcuffs[target] then
        if handcuffs[target].cuffed and handcuffs[target].keyholder == source then
            TriggerEvent("Phone.Set", target, false)
            Notify("You destroyed "..GetIdentity(target).."'s phone!", 3000, source)
            Notify(GetIdentity(source).." destroyed your phone!", 3000, target)
        else
            Notify("The target is handcuffed, but you do not have the keys!", 3000, source)
        end
    else
        Notify("The target is not handcuffed!", 3000, source)
    end
end)
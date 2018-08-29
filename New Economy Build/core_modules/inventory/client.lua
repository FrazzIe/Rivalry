--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                    Interactions/Inventory                                                    --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Variables                                                          --
--==============================================================================================================================--
user_inventory = {}  
vehicle_inventory = {}
vehicle_weapon_inventory = {}
inventories = {}
--=INVENTORY====================================================================================================================--
local drunk = false
local drugged = false                                                                                                             --
local armour_anim_dict = "switch@franklin@getting_ready"
local put_in_car_dict = "mp_common"

AddAnimDictionary(put_in_car_dict)
AddAnimDictionary(armour_anim_dict)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Inventory Events                                                       --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterNetEvent("inventory:updateitems")
AddEventHandler("inventory:updateitems", function(inv)
    user_inventory = inv
    if exports.ui:currentmenu() == "inventory" then
        TriggerEvent("inventory:open")
    end
end)

RegisterNetEvent("inventory:updateitems_vehicle")
AddEventHandler("inventory:updateitems_vehicle", function(veh_inv)
    vehicle_inventory = veh_inv
    if exports.ui:currentmenu() == "vehicle_inventory" then
        TriggerEvent("inventory:vehicle_open")
    end
end)

RegisterNetEvent("inventory:updateitems_vehicle_weapon")
AddEventHandler("inventory:updateitems_vehicle_weapon", function(veh_wep_inv)
    vehicle_weapon_inventory = veh_wep_inv
    if exports.ui:currentmenu() == "vehicle_weapon_inventory" then
        TriggerEvent("inventory:vehicle_weapon_open")
    end
end)

RegisterNetEvent("inventory:sync")
AddEventHandler("inventory:sync", function(_invs)
    inventories = _invs
    if exports.ui:currentmenu() == "rob_inventory" then
        TriggerEvent("interaction:rob")
    end
end)

RegisterNetEvent("inventory:addQty")
AddEventHandler("inventory:addQty",function(i,q)
    addQty(i,q)
end)

RegisterNetEvent("inventory:removeQty")
AddEventHandler("inventory:removeQty",function(i,q)
    removeQty(i,q)
end)

RegisterNetEvent("inventory:messages")
AddEventHandler("inventory:messages",function(message)
    DrawMissionText(message, 5000)
end)

AddEventHandler("inventory:give",function(data)
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        local amount = tonumber(KeyboardInput("Enter quantity:", 0, 10))
        if amount ~= nil then
            if math.floor(amount) > 0 then
                exports.ui:reset()
                exports.ui:open("inventory")
                TriggerServerEvent("inventory:give", tonumber(data.item_id), data.name, math.floor(amount), GetPlayerServerId(t))
            else
                TriggerEvent("inventory:open")
            end
        else
            TriggerEvent("inventory:open")
        end
    else
        Messages(5)
    end
end)

AddEventHandler("inventory:drop",function(data)
    local amount = tonumber(KeyboardInput("Enter quantity:", 0, 10))
    if amount ~= nil then
        if math.floor(amount) > 0 then
            exports.ui:reset()
            exports.ui:open("inventory")
            TriggerServerEvent("inventory:drop", tonumber(data.item_id), data.name, math.floor(amount), FindNearbyPlayers(8))
        else
            TriggerEvent("inventory:open")
        end
    else
        TriggerEvent("inventory:open")
    end
end)

AddEventHandler("inventory:vehicle_open", function()
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        local vehicleHandle = GetVehiclePedIsIn(PlayerPedId(), false)
        local plate = GetVehicleNumberPlateText(vehicleHandle)
        if vehicle_inventory[plate] then
            if keys_users[GetPlayerServerId(PlayerId())][plate] or vehicle_inventory[plate].locked == "false" then
                exports.ui:reset()
                exports.ui:open("vehicle_inventory")
                if keys_users[GetPlayerServerId(PlayerId())][plate] then
                    if vehicle_inventory[plate].locked == "true" then
                        exports.ui:addOption("Unlock trunk", "inventory:vehicle_lock", plate)
                    else
                        exports.ui:addOption("Lock trunk", "inventory:vehicle_lock", plate)
                    end
                end
                exports.ui:addOption("Deposit", "inventory:vehicle_deposit", plate)
                for k,v in pairs(vehicle_inventory[plate]) do
                    if k ~= "locked" then
                        exports.ui:addOption(v.quantity.." "..v.name, "inventory:vehicle_withdraw", v)
                    end
                end
                exports.ui:back([[TriggerEvent("interaction:vehicle")]])
            else
                TriggerEvent("interaction:vehicle")
                Notify("The trunk is locked!", 2500)
            end
        else
            if keys_users[GetPlayerServerId(PlayerId())][plate] then
                exports.ui:reset()
                exports.ui:open("vehicle_inventory")
                exports.ui:addOption("Deposit", "inventory:vehicle_deposit", plate)
                exports.ui:back([[TriggerEvent("interaction:vehicle")]])
            else
                TriggerEvent("interaction:vehicle")
                Notify("You don't have the keys to this vehicle!", 2500)
            end
        end
    else
        local pos = GetEntityCoords(PlayerPedId())
        local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)

        local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
        local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

        if vehicleHandle ~= nil then
            if DoesEntityExist(vehicleHandle) then
                local plate = GetVehicleNumberPlateText(vehicleHandle)
                if vehicle_inventory[plate] then
                    if keys_users[GetPlayerServerId(PlayerId())][plate] or vehicle_inventory[plate].locked == "false" then
                        exports.ui:reset()
                        exports.ui:open("vehicle_inventory")
                        if keys_users[GetPlayerServerId(PlayerId())][plate] then
                            if vehicle_inventory[plate].locked == "true" then
                                exports.ui:addOption("Unlock trunk", "inventory:vehicle_lock", plate)
                            else
                                exports.ui:addOption("Lock trunk", "inventory:vehicle_lock", plate)
                            end
                        end
                        exports.ui:addOption("Deposit", "inventory:vehicle_deposit", plate)
                        for k,v in pairs(vehicle_inventory[plate]) do
                            if k ~= "locked" then
                                exports.ui:addOption(v.quantity.." "..v.name, "inventory:vehicle_withdraw", v)
                            end
                        end
                        exports.ui:back([[TriggerEvent("interaction:vehicle")]])
                    else
                        TriggerEvent("interaction:vehicle")
                        Notify("The trunk is locked!", 2500)
                    end
                else
                    if keys_users[GetPlayerServerId(PlayerId())][plate] then
                        exports.ui:reset()
                        exports.ui:open("vehicle_inventory")
                        exports.ui:addOption("Deposit", "inventory:vehicle_deposit", plate)
                        exports.ui:back([[TriggerEvent("interaction:vehicle")]])
                    else
                        TriggerEvent("interaction:vehicle")
                        Notify("You don't have the keys to this vehicle!", 2500)
                    end
                end
            else
                TriggerEvent("interaction:vehicle")
            end
        else
            TriggerEvent("interaction:vehicle")
        end
    end
end)

AddEventHandler("inventory:vehicle_withdraw", function(data)
    local amount = tonumber(KeyboardInput("Enter quantity to remove:", 0, 10))
    if amount ~= nil then
        if math.floor(amount) > 0 then
            exports.ui:reset()
            exports.ui:open("vehicle_inventory")
            TriggerServerEvent("inventory:vehicle_withdraw", math.floor(amount), data)
            TaskPlayAnim(PlayerPedId(), put_in_car_dict, "givetake2_a", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)
        else
            TriggerEvent("inventory:vehicle_open")
        end
    else
        TriggerEvent("inventory:vehicle_open")
    end
end)

AddEventHandler("inventory:vehicle_deposit", function(plate)
    exports.ui:reset()
    exports.ui:open()
    for k,v in pairs(user_inventory) do
        exports.ui:addOption(v.quantity.." "..v.name, "inventory:vehicle_deposited", {plate = plate, item = v})
    end
    exports.ui:back([[TriggerEvent("inventory:vehicle_open")]])
end)

AddEventHandler("inventory:vehicle_lock", function(plate)
    exports.ui:reset()
    exports.ui:open("vehicle_inventory")
    TriggerServerEvent("inventory:vehicle_lock", plate)
end)

AddEventHandler("inventory:vehicle_deposited", function(data)
    local amount = tonumber(KeyboardInput("Enter quantity to transfer:", 0, 10))
    if amount ~= nil then
        if math.floor(amount) > 0 then
            exports.ui:reset()
            exports.ui:open("vehicle_inventory")
            TriggerServerEvent("inventory:vehicle_deposit", math.floor(amount), data.plate, data.item)
            TaskPlayAnim(PlayerPedId(), put_in_car_dict, "givetake1_a", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)
        else
            TriggerEvent("inventory:vehicle_open")
        end
    else
        TriggerEvent("inventory:vehicle_open")
    end
end)

AddEventHandler("inventory:vehicle_weapon_open", function()
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        local vehicleHandle = GetVehiclePedIsIn(PlayerPedId(), false)
        local plate = GetVehicleNumberPlateText(vehicleHandle)
        if vehicle_weapon_inventory[plate] then
            if keys_users[GetPlayerServerId(PlayerId())][plate] or vehicle_weapon_inventory[plate].locked == "false" then
                exports.ui:reset()
                exports.ui:open("vehicle_weapon_inventory")
                if keys_users[GetPlayerServerId(PlayerId())][plate] then
                    if vehicle_weapon_inventory[plate].locked == "true" then
                        exports.ui:addOption("Unlock weapon container", "inventory:vehicle_weapon_lock", plate)
                    else
                        exports.ui:addOption("Lock weapon container", "inventory:vehicle_weapon_lock", plate)
                    end
                end
                exports.ui:addOption("Deposit", "inventory:vehicle_weapon_deposit", plate)
                for k,v in pairs(vehicle_weapon_inventory[plate].weapons) do
                    if k ~= "locked" then
                        if v.ammo ~= 0 then
                            exports.ui:addOption(Weapons_names[v.model].." ["..v.ammo.."]", "inventory:vehicle_weapon_withdraw", {plate = plate, weapon = v, weapon_id = k})
                        else
                            exports.ui:addOption(Weapons_names[v.model], "inventory:vehicle_weapon_withdraw", {plate = plate, weapon = v, weapon_id = k})
                        end
                    end
                end
                exports.ui:back([[TriggerEvent("interaction:vehicle")]])
            else
                TriggerEvent("interaction:vehicle")
                Notify("The weapon container is locked!", 2500)
            end
        else
            if keys_users[GetPlayerServerId(PlayerId())][plate] then
                exports.ui:reset()
                exports.ui:open("vehicle_inventory")
                exports.ui:addOption("Deposit", "inventory:vehicle_weapon_deposit", plate)
                exports.ui:back([[TriggerEvent("interaction:vehicle")]])
            else
                TriggerEvent("interaction:vehicle")
                Notify("You don't have the keys to this vehicle!", 2500)
            end
        end
    else
        local pos = GetEntityCoords(PlayerPedId())
        local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)

        local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
        local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

        if vehicleHandle ~= nil then
            if DoesEntityExist(vehicleHandle) then
                local plate = GetVehicleNumberPlateText(vehicleHandle)
                if vehicle_weapon_inventory[plate] then
                    if keys_users[GetPlayerServerId(PlayerId())][plate] or vehicle_weapon_inventory[plate].locked == "false" then
                        exports.ui:reset()
                        exports.ui:open("vehicle_inventory")
                        if keys_users[GetPlayerServerId(PlayerId())][plate] then
                            if vehicle_weapon_inventory[plate].locked == "true" then
                                exports.ui:addOption("Unlock weapon container", "inventory:vehicle_weapon_lock", plate)
                            else
                                exports.ui:addOption("Lock weapon container", "inventory:vehicle_weapon_lock", plate)
                            end
                        end
                        exports.ui:addOption("Deposit", "inventory:vehicle_weapon_deposit", plate)
                        for k,v in pairs(vehicle_weapon_inventory[plate].weapons) do
                            if k ~= "locked" then
                                if v.ammo ~= 0 then
                                    exports.ui:addOption(Weapons_names[v.model].." ["..v.ammo.."]", "inventory:vehicle_weapon_withdraw", {plate = plate, weapon = v, weapon_id = k})
                                else
                                    exports.ui:addOption(Weapons_names[v.model], "inventory:vehicle_weapon_withdraw", {plate = plate, weapon = v, weapon_id = k})
                                end
                            end
                        end
                        exports.ui:back([[TriggerEvent("interaction:vehicle")]])
                    else
                        TriggerEvent("interaction:vehicle")
                        Notify("The weapon container is locked!", 2500)
                    end
                else
                    if keys_users[GetPlayerServerId(PlayerId())][plate] then
                        exports.ui:reset()
                        exports.ui:open("vehicle_inventory")
                        exports.ui:addOption("Deposit", "inventory:vehicle_weapon_deposit", plate)
                        exports.ui:back([[TriggerEvent("interaction:vehicle")]])
                    else
                        TriggerEvent("interaction:vehicle")
                        Notify("You don't have the keys to this vehicle!", 2500)
                    end
                end
            else
                TriggerEvent("interaction:vehicle")
            end
        else
            TriggerEvent("interaction:vehicle")
        end
    end
end)

AddEventHandler("inventory:vehicle_weapon_withdraw", function(data)
    exports.ui:reset()
    exports.ui:open("vehicle_weapon_inventory")
    TriggerServerEvent("inventory:vehicle_weapon_withdraw", data.plate, data.weapon, data.weapon_id)
end)

AddEventHandler("inventory:vehicle_weapon_deposit", function(plate)
    exports.ui:reset()
    exports.ui:open("deposit_weapons")
    for k,v in pairs(user_weapons) do
        if GetMaxAmmoInClip(PlayerPedId(), GetHashKey(k), 1) ~= 0 then
            exports.ui:addOption(Weapons_names[k].." ["..GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(k)).."]", "inventory:vehicle_weapon_deposited", {plate = plate, weapon = v})
        else
            exports.ui:addOption(Weapons_names[k], "inventory:vehicle_weapon_deposited", {plate = plate, weapon = v})
        end
    end
    exports.ui:back([[TriggerEvent("inventory:vehicle_weapon_open")]])
end)

AddEventHandler("inventory:vehicle_weapon_deposited", function(data)
    exports.ui:reset()
    exports.ui:open("vehicle_weapon_inventory")
    TriggerServerEvent("inventory:vehicle_weapon_deposit", data.plate, data.weapon)
end)

AddEventHandler("inventory:vehicle_weapon_lock", function(plate)
    exports.ui:open("vehicle_weapon_inventory")
    TriggerServerEvent("inventory:vehicle_weapon_lock", plate)
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                     Inventory Functions                                                      --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function removeQty(i,q)
    TriggerServerEvent("inventory:remove", tonumber(i),tonumber(q))
end

function addQty(i,q)
    TriggerServerEvent("inventory:add", tonumber(i),tonumber(q))
end

function getQuantity()
    local quantity = 0
    for k,v in pairs(user_inventory) do
        quantity = quantity + v.quantity
    end
    return quantity
end

function isFull()
    local quantity = 0
    for k,v in pairs(user_inventory) do
        quantity = quantity + v.quantity
    end
    if quantity >= 100 then
        return true
    else
        return false
    end
end

function GetItemQuantity(item)
    if user_inventory[item] then
        return user_inventory[item].quantity
    else
        return 0
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                     Inventory Use Functions                                                  --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local function addBAC(amount)
    local BAC_Driving_Limit = 0.08
    local currentBAC = DecorGetFloat(PlayerPedId(), "_BAC_Level")
    local newBAC = currentBAC + amount
    DecorSetFloat(PlayerPedId(), "_BAC_Level", newBAC)
    if newBAC >= BAC_Driving_Limit then
        local isBACactive = DecorGetBool(PlayerPedId(), "BAC_Active")
        if not isBACactive then
            DecorSetBool(PlayerPedId(), "BAC_Active", true)  
        end
    end
end

local function eat(item)
    local pid = PlayerPedId()
    RequestAnimDict("mp_player_inteat@burger")
    while (not HasAnimDictLoaded("mp_player_inteat@burger")) do Citizen.Wait(0) end
    TaskPlayAnim(pid, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 1.0, -1.0, 2000, 0, 1, true, true, true)
    TriggerEvent("fm:eat", 30)
    Citizen.Wait(1000)
    TriggerEvent("inventory:open")
end

local function drink(item)
    local pid = PlayerPedId()
    RequestAnimDict("amb@world_human_drinking@coffee@male@idle_a")
    while (not HasAnimDictLoaded("amb@world_human_drinking@coffee@male@idle_a")) do Citizen.Wait(0) end
    TaskPlayAnim(pid, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 1.0, -1.0, 2000, 0, 1, true, true, true)
    if item == 25 then
        TriggerEvent("fm:drink", -5)
        addBAC(0.4)
        drunk = true
    elseif item == 27 then
        TriggerEvent("fm:drink", -5)
        addBAC(0.4)
        drunk = true
    elseif item == 41 then
        TriggerEvent("fm:drink", -5)
        addBAC(0.4)
        drunk = true
    else
        TriggerEvent("fm:drink", 30)
    end
    Citizen.Wait(1000)
    TriggerEvent("inventory:open")
end

local function heal()
    Citizen.CreateThread(function()
        if not IsEntityDead(PlayerPedId()) then
            Citizen.Wait(200)
            SetEntityHealth(PlayerPedId(), 200)
            exports.pNotify:SendNotification({text = "Medkit used!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
            TriggerEvent("inventory:open")
        end
    end)
end

local function RepairVehicleCheck(id)
    TriggerServerEvent('repair:getMech',id)
end

local function RepairVehicle(id)
    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
        local pos = GetEntityCoords(PlayerPedId(), false)
        local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
        local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
        local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
        if DoesEntityExist(vehicleHandle) then
            if IsVehicleDoorFullyOpen(vehicleHandle, 4) then
                local ped = PlayerPedId()
                TaskPlayAnim(PlayerPedId(), "mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)  
                Citizen.Wait(20000)
                TriggerEvent('iens:repair', vehicleHandle)
                ClearPedTasks(ped)
                ClearPedTasksImmediately(ped)
                TriggerEvent("inventory:open")
            else
                Notify("You open up the hood!", 2500)
                addQty(tonumber(id),1)
            end
        else
            addQty(tonumber(id),1)
            Notify("Couldn't find a vehicle!", 2500)
            TriggerEvent("inventory:open")
        end
    else
        addQty(tonumber(id),1)
        Notify("You cannot repair while in the vehicle", 2500)
        TriggerEvent("inventory:open")
    end
end

RegisterNetEvent('repair:receiveMech')
AddEventHandler('repair:receiveMech',function(mechanic,id)
    local online = tonumber(mechanic)
    if online < 1 then
        RepairVehicle(id)
    else
        addQty(id,1)
        exports.pNotify:SendNotification({text = "These can only be used when there are no mechanics online! (Online: <span style='color:lime'>"..online.."</span>)",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
        TriggerEvent("inventory:open")
    end
end)

local function lockpick()
    Citizen.CreateThread(function()
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply, 0)
        local _veh = GetClosestVehicle(plyCoords["x"], plyCoords["y"], plyCoords["z"], 5.001, 0, 70)
        if _veh ~= nil and _veh ~= 0 then
            TaskPlayAnim(PlayerPedId(),"mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)  
            TriggerEvent("dispatch:lockpick")   
            Citizen.Wait(20000)
            local unlock = math.random(1,4)
            if unlock == 3 then
                SetVehicleDoorsLocked(_veh, 1)
                exports.pNotify:SendNotification({text = "Vehicle unlocked!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
                ClearPedTasks(PlayerPedId())
                TriggerEvent("inventory:open")
            else
                exports.pNotify:SendNotification({text = "Lockpick broke!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
                ClearPedTasks(PlayerPedId())
                StartVehicleAlarm(_veh)
                TriggerEvent("inventory:open")
            end
        else
            exports.pNotify:SendNotification({text = "No vehicle in range!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            addQty(36,1)
            TriggerEvent("inventory:open")
        end
    end)
end

local function hotwire(id)
    TriggerEvent("keys:hotwire", PlayerPedId(), id)
end

local function armour()
    Citizen.CreateThread(function()
        Citizen.Wait(200)
        if GetPedArmour(PlayerPedId()) < 50 then

            SetPedArmour(PlayerPedId(), 100)
            TaskPlayAnim(PlayerPedId(), armour_anim_dict, "002334_02_fras_v2_11_getting_dressed_exit", 4.0, -4, -1, 1, 0, false, false, false)
            Citizen.Wait(500)
            if GetPedDrawableVariation(PlayerPedId(), 9) == 0 then
                SetPedComponentVariation(PlayerPedId(), 9, 1, 1, 0)
            end
            Citizen.Wait(1700)
            ClearPedTasks(PlayerPedId())
            exports.pNotify:SendNotification({text = "Body armour equipped!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            TriggerEvent("inventory:open")
        else
            exports.pNotify:SendNotification({text = "You already have body armour equipped!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
            addQty(39,1)
            TriggerEvent("inventory:open")
        end
    end)
end

Citizen.CreateThread(function()
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if drunk then
            drunk = false
            Citizen.Wait(5000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            SetTimecycleModifier("spectator5")
            SetPedMotionBlur(PlayerPedId(), true)
            SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
            SetPedIsDrunk(PlayerPedId(), true)
            DoScreenFadeIn(1000)            
            Citizen.Wait(50000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ClearTimecycleModifier()
            ResetScenarioTypesEnabled()
            ResetPedMovementClipset(PlayerPedId(), 0)
            SetPedIsDrunk(PlayerPedId(), false)
            SetPedMotionBlur(PlayerPedId(), false)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if drugged then
            drugged = false
            Citizen.Wait(5000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            SetTimecycleModifier("spectator5")
            SetPedMotionBlur(PlayerPedId(), true)
            SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
            StartScreenEffect("DrugsDrivingIn", 0, true)
            DoScreenFadeIn(1000)            
            Citizen.Wait(50000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ClearTimecycleModifier()
            ResetScenarioTypesEnabled()
            ResetPedMovementClipset(PlayerPedId(), 0)
            StopScreenEffect("DrugsDrivingIn")
            
            SetPedMotionBlur(PlayerPedId(), false)
        end
    end
end)

AddEventHandler("inventory:use",function(data)
    if data.canuse ~= 0 then
        if data.canuse == 1 then
            drink(data.item_id)
        elseif data.canuse == 2 then
            eat(data.item_id)
        elseif data.canuse == 3 then --Medkit
            heal()
        elseif data.canuse == 4 then --Repair kit
            RepairVehicle(data.item_id)
        elseif data.canuse == 5 then --Lockpick
            lockpick()
        elseif data.canuse == 6 then --Body armour
            armour()
        elseif data.canuse == 7 then --Zipties
            local t, distance = GetClosestPlayer()
            if(distance ~= -1 and distance < 3) then
                TriggerServerEvent("handcuffs:cuff", GetPlayerServerId(t))
            else
                Messages(5)
            end
        elseif data.canuse == 8 then --Hotwire kit
            hotwire(data.item_id)
        elseif data.canuse == 10 then
            drugged = true
        end
        removeQty(data.item_id,1)
    else
        TriggerEvent("inventory:open")
        Messages(4)
    end
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Messages                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function Messages(value)
    if value == 1 then
        Notify("You must be driving to use this!")
    elseif value == 2 then
        Notify("You must be in a car to use this!")
    elseif value == 3 then
        Notify("You cannot use this in a police car!")
    elseif value == 4 then
        Notify("This item cannot be used!")
    elseif value == 5 then
        Notify("There is no player near you!")
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                             END                                                              --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
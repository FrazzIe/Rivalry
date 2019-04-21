--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
mission_list = {}

local activeMedics = 0
local AutoFill = {
    Sentence = 0,
    Fine = 0,
    Charges = {},
}
--[[ Main Menu ]]--
AddEventHandler("police:menu", function()
    TriggerServerEvent('police:requestMission')
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Citizen", [[TriggerEvent("police:menu_citizen")]])
    exports.ui:addOption("Vehicle", [[TriggerEvent("police:menu_vehicle")]])
    exports.ui:addOption("Placeables", [[TriggerEvent("police:menu_placeables")]])
    exports.ui:addOption("Missions", [[TriggerEvent("police:menu_missions")]])
    exports.ui:addOption("Processing", [[TriggerEvent("police:menu_processing")]])
    exports.ui:back([[TriggerEvent("interaction:main")]])
end)
--[[ Citizen ]]--
AddEventHandler("police:menu_citizen", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Freeze cuff", [[TriggerEvent("police:menu_citizen_cuffing", "freeze")]])
    exports.ui:addOption("Normal cuff", [[TriggerEvent("police:menu_citizen_cuffing", "normal")]])
    exports.ui:addOption("Drag", [[TriggerEvent("police:menu_citizen_drag")]])
    exports.ui:addOption("Put in vehicle", [[TriggerEvent("police:menu_citizen_force", "in")]])
    exports.ui:addOption("Take out of vehicle", [[TriggerEvent("police:menu_citizen_force", "out")]])
    exports.ui:addOption("Frisk", [[TriggerEvent("police:menu_citizen_frisk")]])
    exports.ui:addOption("Search", [[TriggerEvent("police:menu_citizen_search")]])
    exports.ui:addOption("Seize", [[TriggerEvent("police:menu_citizen_seize")]])
    exports.ui:addOption("Breathalyzer", [[TriggerEvent("police:menu_citizen_breathalyzer")]])
    exports.ui:addOption("Gun residue", [[TriggerEvent("police:menu_citizen_gun_residue")]])
    exports.ui:addOption("Supply user with a weapon license", [[TriggerEvent("police:menu_citizen_give_license")]])
    --exports.ui:addOption("Reinstate Drivers License", [[TriggerEvent("police:menu_citizen_give_drivers_license")]])
    if activeMedics == 0 then
        exports.ui:addOption("Revive", [[TriggerEvent("paramedic:menu_revive")]])
        exports.ui:addOption("Pronounce doa", [[TriggerEvent("paramedic:menu_doa")]])
    end
    exports.ui:back([[TriggerEvent("police:menu")]])
end)

AddEventHandler("police:menu_citizen_cuffing", function(type)
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:cuff", GetPlayerServerId(t), type)
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("police:menu_citizen_drag", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:drag", GetPlayerServerId(t))
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("police:menu_citizen_force", function(type)
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:force", GetPlayerServerId(t), type)
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("police:menu_citizen_frisk", function()
    exports.ui:open()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:frisk", GetPlayerServerId(t))
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

--[[ Search ]]--
AddEventHandler("police:menu_citizen_search", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Inventory", [[TriggerEvent("police:menu_citizen_search_execute", "inventory")]])
    exports.ui:addOption("Weapons", [[TriggerEvent("police:menu_citizen_search_execute", "weapons")]])
    exports.ui:addOption("Weapon License", [[TriggerEvent("police:menu_citizen_search_execute", "wl")]])
    exports.ui:addOption("Drivers License", [[TriggerEvent("police:menu_citizen_search_execute", "dl")]])
    exports.ui:addOption("Identification", [[TriggerEvent("police:menu_citizen_search_execute", "id")]])
    exports.ui:addOption("Wallet", [[TriggerEvent("police:menu_citizen_search_execute", "wallet")]])
    exports.ui:back([[TriggerEvent("police:menu_citizen")]])
end)

AddEventHandler("police:menu_citizen_search_execute", function(type)
    exports.ui:open()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:search", GetPlayerServerId(t), type)
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

--[[ Seize ]]--
AddEventHandler("police:menu_citizen_seize", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Inventory", [[TriggerEvent("police:menu_citizen_seize_execute", "inventory")]])
    exports.ui:addOption("Weapons", [[TriggerEvent("police:menu_citizen_seize_execute", "weapons")]])
    exports.ui:addOption("Weapon License", [[TriggerEvent("police:menu_citizen_seize_execute", "wl")]])
    exports.ui:addOption("Drivers License", [[TriggerEvent("police:menu_citizen_seize_execute", "dl")]])
    exports.ui:addOption("Wallet", [[TriggerEvent("police:menu_citizen_seize_execute", "wallet")]])
    exports.ui:addOption("Phone", [[TriggerEvent("police:menu_citizen_seize_execute", "phone")]])
    exports.ui:back([[TriggerEvent("police:menu_citizen")]])
end)

AddEventHandler("police:menu_citizen_seize_execute", function(type)
    exports.ui:open()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        if type == "weapons" then
            RemoveAllPedWeapons(GetPlayerPed(t), 0)
        end
        TriggerServerEvent("police:seize", GetPlayerServerId(t), type)
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("police:menu_citizen_breathalyzer", function()
    exports.ui:open()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        local isBACActive = DecorGetBool(GetPlayerPed(t), "BAC_Active")
        if isBACActive then
            Notify("Subject tested <b style='color:red'>Positive</b> <br>Their blood-alcohol concentration is outside the legal limits", 3000)
        else
            Notify("Subject tested <b style='color:lime'>Negative</b> <br>Their blood-alcohol concentration is inside the legal limits", 3000)
        end
    else
        Notify("Please get closer to the target!", 2500)
    end 
end)

AddEventHandler("police:menu_citizen_gun_residue", function()
    exports.ui:open()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        isGSRactive = DecorGetBool(GetPlayerPed(t), "GSR_Active")
        if isGSRactive then
            Notify("Subject tested <b style='color:red'>Positive</b><br>They have discharged a firearm recently!", 3000)
        else
            Notify("Subject tested <b style='color:lime'>Negative</b><br>They haven't discharged a firearm recently!", 3000)
        end
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("police:menu_citizen_give_license", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("weapon:givelicense", GetPlayerServerId(t))
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("police:menu_citizen_give_drivers_license", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("interaction:buy_drivers_license", GetPlayerServerId(t))
    else
        Notify("Please get closer to the target!", 2500)
    end
end)
--[[ Vehicle ]]--
AddEventHandler("police:menu_vehicle", function()
    exports.ui:reset()
    exports.ui:open()
    --exports.ui:addOption("Fix", [[TriggerEvent("police:fix_vehicle")]])
    --exports.ui:addOption("Clean", [[TriggerEvent("police:clean_vehicle")]])
    exports.ui:addOption("Check owner", [[TriggerEvent("police:check_plate")]])
    exports.ui:addOption("Search", [[TriggerEvent("police:menu_vehicle_search")]])
    exports.ui:addOption("Seize", [[TriggerEvent("police:menu_vehicle_seize")]])
    exports.ui:addOption("Impound", [[TriggerEvent("police:menu_vehicle_impound", 0)]])
    exports.ui:addOption("Impound ($3000)", [[TriggerEvent("police:menu_vehicle_impound", 3000)]])
    exports.ui:back([[TriggerEvent("police:menu")]])
end)

AddEventHandler("police:fix_vehicle", function()
    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
        local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
        local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)
        
        if DoesEntityExist(NearestVehicle.Handle) then
            TaskPlayAnim(PlayerPedId(), "mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)  
            Citizen.Wait(20000)
            ClearPedTasks(PlayerPedId())
            SetVehicleFixed(NearestVehicle.Handle)
        else
            Notify("Couldn't find a vehicle!", 2500)
        end
    else
        Notify("You cannot repair while in the vehicle", 2500)
    end
end)

AddEventHandler("police:clean_vehicle", function()
    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
        local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
        local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)
        
        if DoesEntityExist(NearestVehicle.Handle) then
            SetVehicleDirtLevel(NearestVehicle.Handle, 0)
            Notify("Vehicle cleaned!", 2500)
        else
            Notify("Couldn't find a vehicle!", 2500)
        end
    else
        local vehicleHandle = GetVehiclePedIsUsing(PlayerPedId())
        SetVehicleDirtLevel(vehicleHandle, 0)
        Notify("Vehicle cleaned!", 2500)
    end
end)

AddEventHandler("police:check_plate", function()
    local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
    local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)

    if DoesEntityExist(NearestVehicle.Handle) then
        TriggerServerEvent("police:check_plate", GetVehicleNumberPlateText(NearestVehicle.Handle))
    else
        Notify("Couldn't find a vehicle!", 2500)
    end
end)

AddEventHandler("police:menu_vehicle_search", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Inventory", [[TriggerEvent("police:menu_vehicle_search_execute", "inventory")]])
    exports.ui:addOption("Weapons", [[TriggerEvent("police:menu_vehicle_search_execute", "weapons")]])
    exports.ui:back([[TriggerEvent("police:menu_vehicle")]])
end)

AddEventHandler("police:menu_vehicle_search_execute", function(type)
    exports.ui:open()
    local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
    local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)

    if DoesEntityExist(NearestVehicle.Handle) then
        TriggerServerEvent("police:search_vehicle", GetVehicleNumberPlateText(NearestVehicle.Handle), type)
    else
        Notify("Couldn't find a vehicle!", 2500)
    end
end)

--[[ Seize ]]--
AddEventHandler("police:menu_vehicle_seize", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Inventory", [[TriggerEvent("police:menu_vehicle_seize_execute", "inventory")]])
    exports.ui:addOption("Weapons", [[TriggerEvent("police:menu_vehicle_seize_execute", "weapons")]])
    exports.ui:back([[TriggerEvent("police:menu_vehicle")]])
end)

AddEventHandler("police:menu_vehicle_seize_execute", function(type)
    exports.ui:open()
    local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
    local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)

    if DoesEntityExist(NearestVehicle.Handle) then
        TriggerServerEvent("police:seize_vehicle", GetVehicleNumberPlateText(NearestVehicle.Handle), type)
    else
        Notify("Couldn't find a vehicle!", 2500)
    end
end)

RegisterNetEvent("police:menu_vehicle_impound")
AddEventHandler("police:menu_vehicle_impound", function(_amount)
    if isInService then
        local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
        local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)

        if DoesEntityExist(NearestVehicle.Handle) then
            TriggerServerEvent("police:impound", GetVehicleNumberPlateText(NearestVehicle.Handle), _amount)
            DestroyVehicle(NearestVehicle.Handle)
        else
            Notify("Couldn't find a vehicle!", 2500)
        end
    end
end)
--[[ Placeables ]]--
AddEventHandler("police:menu_placeables", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Toggle spikes", [[TriggerEvent("Spikes.Create", 3)]])
    exports.ui:addOption("Toggle camera", [[TriggerEvent("PortableRadar.Create")]])
    exports.ui:back([[TriggerEvent("police:menu")]])
end)
--[[ Missions ]]--
AddEventHandler("police:menu_missions", function()
    exports.ui:reset()
    exports.ui:open("police:missions")
    for k,v in pairs(mission_list) do
        exports.ui:addOption(v.name, v.event, v.mission)
    end
    exports.ui:back([[TriggerEvent("police:menu")]])
end)
--[[ Processing ]]--
AddEventHandler("police:menu_processing", function()
    exports.ui:reset()
    exports.ui:open()
    exports.ui:addOption("Optional fine", [[TriggerEvent("police:fine_input", "optional")]])
    exports.ui:addOption("Non-optional fine", [[TriggerEvent("police:fine_input", "forced")]])
    exports.ui:addOption("Jail", [[TriggerEvent("police:jail_input")]])
    exports.ui:addOption("MDT", [[TriggerEvent("mdt.toggle")]])
    exports.ui:back([[TriggerEvent("police:menu")]])
end)

AddEventHandler("police:fine_input", function(_type)
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        local amount = tonumber(KeyboardInput("Enter amount:", AutoFill.Fine, 11))
        if amount ~= nil and amount >= 0 then
            if _type == "optional" then
                TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), amount)
            elseif _type == "forced" then
                TriggerServerEvent("police:finesForced", GetPlayerServerId(t), amount)
            end
        end
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("police:jail_input", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        local amount = tonumber(KeyboardInput("Enter time:", AutoFill.Sentence, 11))
        local reason = tostring(KeyboardInput("Enter reasons:", AutoFill.Charges, 1000))
        if amount ~= nil and amount >= 0 and reason ~= nil then
            TriggerServerEvent("jail:user", GetPlayerServerId(t), amount, reason)
        end
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("mdt.set.charges", function(Sentence, Fine, Charges)
    AutoFill = {
        Sentence = Sentence or 0,
        Fine = Fine or 0,
        Charges = Charges or {},
    }
end)
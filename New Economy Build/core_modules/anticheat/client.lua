--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local BannedVehicles = {
    "rhino",
    "apc",
    "oppressor",
    "tampa3",
    "insurgent3",
    "technical3",
    "halftrack",
    "nightshark",
    "blazer5",
    "boxville5",
    "dune4",
    "dune5",
    "phantom2",
    "ruiner2",
    "technical2",
    "voltic2",
    "hydra",
    "jet",
    "blimp",
    "cargoplane",
    "titan",
    "buzzard",
    "valkyrie",
    "savage",
    "dune3",
    "insurgent",
    "insurgent2"
}

local CageObjs = {
    "prop_gold_cont_01",
    "p_cablecar_s",
    "stt_prop_stunt_tube_l",
    "stt_prop_stunt_track_dwuturn",
}

local isInvisible, isInvincible, isNoclipping = false, false, false

setAttribute = function(_type, value)
    if _type:lower() ~= "invisible" and _type:lower() ~= "invincible" and _type:lower() ~= "noclip" then
        Notify("Invalid type specified - line 35, tell an admin (1)", 20000)
    elseif type(value) ~= "boolean" then
        Notify("Invalid type specified - line 35, tell an admin (2)", 20000)
    else
        if _type:lower() == "invisible" then
            isInvisible = value
        elseif _type:lower() == "invinclible" then
            isInvincible = value
        elseif _type:lower() == "noclip" then
            isNoclipping = value
        end
    end
end

AddEventHandler("anticheat:set", function(_type, value, callback)
    if _type:lower() ~= "invisible" and _type:lower() ~= "invincible" and _type:lower() ~= "noclip" then
        Notify("Invalid type specified - line 35, tell an admin (1)", 20000)
        callback(false)
    elseif type(value) ~= "boolean" then
        Notify("Invalid type specified - line 35, tell an admin (2)", 20000)
        callback(false)
    else
        if _type:lower() == "invisible" then
            isInvisible = value
            callback(true)
        elseif _type:lower() == "invincible" then
            isInvincible = value
            callback(true)
        elseif _type:lower() == "noclip" then
            isNoclipping = value
            callback(true)
        else
            callback(false)
        end
    end
end)

--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        TriggerServerEvent("anticheat:speedcheck")
    end
end)
--]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not isAdmin then
            local PlayerPed = PlayerPedId()
            
            SetPedInfiniteAmmoClip(PlayerPed, false)
            if not isInvisible then
                ResetEntityAlpha(PlayerPed)
                SetEntityVisible(PlayerPed, true)
            end
            local isFalling, isRagdoll, paraState = IsPedFalling(PlayerPed), IsPedRagdoll(PlayerPed), GetPedParachuteState(PlayerPed)
            if paraState >= 0 or isRagdoll or isFalling then
                SetEntityMaxSpeed(PlayerPed, 80.0)
            else
                SetEntityMaxSpeed(PlayerPed, 7.1)
            end
            if IsPedSittingInAnyVehicle(PlayerPed) then
                local currentVehicle = GetVehiclePedIsUsing(PlayerPed, false)
                for k,v in pairs(BannedVehicles) do
                    if GetEntityModel(currentVehicle) == GetHashKey(v) and GetPedInVehicleSeat(currentVehicle, -1) == PlayerPed then
                        SetEntityAsMissionEntity(currentVehicle, true, true)
                        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentVehicle))
                    end
                end
            end
        end
    end
end)
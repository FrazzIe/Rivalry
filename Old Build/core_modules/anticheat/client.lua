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
            SetPedInfiniteAmmoClip(PlayerPedId(), false)
            if not isInvisible then
                ResetEntityAlpha(PlayerPedId())
                SetEntityVisible(PlayerPedId(), true)
            end
            local isFalling, isRagdoll, paraState = IsPedFalling(PlayerPedId()), IsPedRagdoll(PlayerPedId()), GetPedParachuteState(PlayerPedId())
            if paraState >= 0 or isRagdoll or isFalling then
                SetEntityMaxSpeed(PlayerPedId(), 80.0)
            else
                SetEntityMaxSpeed(PlayerPedId(), 7.1)
            end
        end
    end
end)

--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        if not isAdmin then
            local currentPed, currentHealth = PlayerPedId(), GetEntityHealth(currentPed)
            SetEntityHealth(currentPed, currentHealth-2) -- this will substract 2hp from the current player, wait 50ms and then add it back, this is to check for hacks that force HP at 200
            Citizen.Wait(50)
            if PlayerPedId() == currentPed and GetEntityHealth(currentPed) == currentHealth and GetEntityHealth(currentPed) ~= 0 then
                TriggerServerEvent("anticheat:flag", "health", { invincible = false, health = { old = currentHealth-2, new = GetEntityHealth(currentPed) } })
            elseif GetEntityHealth(currentPed) == currentHealth-2 then
                SetEntityHealth(currentPed, GetEntityHealth(currentPed)+2)
            end

            if GetPlayerInvincible(PlayerId()) and not isInvincible then -- if the player is invincible, flag him as a cheater and then disable their invincibility
                --TriggerServerEvent("anticheat:flag", "health", { invincible = true, health = { old = currentHealth-2, new = GetEntityHealth(currentPed) } })
                SetPlayerInvincible( PlayerId(), false )
            end
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(60000)
    while true do
        Citizen.Wait(0)
        if not isAdmin then
            if not isNoclipping then
                local currentPed = PlayerPedId()
                local posx, posy, posz = table.unpack(GetEntityCoords(currentPed, true))
                local isStill, currentSpeed = IsPedStill(currentPed), GetEntitySpeed(currentPed)
                
                Citizen.Wait(3000) -- wait 3 seconds and check again

                local newx, newy, newz = table.unpack(GetEntityCoords(currentPed, true))
                local newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
                if GetDistanceBetweenCoords(posx, posy, posz, newx, newy, newz) > 200 and isStill == IsPedStill(currentPed) and currentSpeed == GetEntitySpeed(currentPed) and currentPed == newPed then
                    TriggerServerEvent("anticheat:flag", "noclip", {distance = GetDistanceBetweenCoords(posx, posy, posz, newx, newy, newz)})
                end
            end
        end
    end
end)
--]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not isAdmin then
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                local currentVehicle = GetVehiclePedIsUsing(PlayerPedId(), false)
                for k,v in pairs(BannedVehicles) do
                    if GetEntityModel(currentVehicle) == GetHashKey(v) and GetPedInVehicleSeat(currentVehicle, -1) == PlayerPedId() then
                        SetEntityAsMissionEntity(currentVehicle, true, true)
                        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentVehicle))
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local ped = PlayerPedId()
        for object in EnumerateObjects() do
            local ObjX,ObjY,ObjZ = table.unpack(GetEntityCoords(object, true))
            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
            if IsEntityAttached(object) and DoesEntityExist(object) then
                if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then
                    RequestAndDelete(object, true)
                end
            end
            for i = 1, #CageObjs do
                if GetEntityModel(object) == GetHashKey(CageObjs[i]) then
                    RequestAndDelete(object, false)
                end
            end
        end
    end
end)
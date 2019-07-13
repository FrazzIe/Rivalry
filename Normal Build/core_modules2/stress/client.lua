local StressLevel = 0
local HasToldAboutStress = false
local BleedingOut = false
local HasRecievedMedicalAttention = true
local YogaPlace = vector3(-1495.3853759766, 829.42315673828,181.62339782715)

RegisterNetEvent("Add.Stress")
AddEventHandler("Add.Stress", function(Stress)
    StressLevel = StressLevel + Stress
    if StressLevel == 25 or StressLevel == 50 or StressLevel == 75 or StressLevel == 100 then
        HasToldAboutStress = false
    end
    if StressLevel > 25 and StressLevel < 50 then
        if not HasToldAboutStress then
            Notify("You are becoming more stressed!", 3100)
            HasToldAboutStress = true
        end
    elseif StressLevel > 50 and StressLevel < 75 then
        if not HasToldAboutStress then
            Notify("You are mildly stressed!", 3100)
            HasToldAboutStress = true
        end
    elseif StressLevel > 75 and StressLevel < 100 then
        if not HasToldAboutStress then
            Notify("You are moderately stressed!", 3100)
            HasToldAboutStress = true
        end
    elseif StressLevel >= 100 then
        if not HasToldAboutStress then
            Notify("You are severly stressed!", 3100)
            HasToldAboutStress = true
        end
    end
end)

RegisterNetEvent("Check.Stress")
AddEventHandler("Check.Stress", function()
    if StressLevel > 25 and StressLevel < 50 then
        Notify("You are becoming more stressed!", 3100)
    elseif StressLevel > 50 and StressLevel < 75 then
        Notify("You are mildly stressed!", 3100)
    elseif StressLevel > 75 and StressLevel < 100 then
        Notify("You are moderately stressed!", 3100)
    elseif StressLevel >= 100 then
        Notify("You are severly stressed!", 3100)
    end
end)

RegisterNetEvent("Lower.Stress")
AddEventHandler("Lower.Stress", function(Value)
    StressLevel = StressLevel - Value
end)

RegisterNetEvent("Damage.StartBleeding")
AddEventHandler("Damage.StartBleeding", function(Bone, WeaponUsed, DamageTaken)
    Citizen.CreateThread(function()
        if DamageTaken > 11 then
            if WeaponUsed ~= "WEAPON_UNARMED" and WeaponUsed ~= "WEAPON_POOLCLUB" and WeaponUsed ~= "WEAPON_FLASHLIGHT" and WeaponUsed ~= "WEAPON_BATON" and WeaponUsed ~= "WEAPON_BAT" and WeaponUsed ~= "WEAPON_GOLFCLUB" and WeaponUsed ~= "WEAPON_CROWBAR" and WeaponUsed ~= "WEAPON_WRENCH" then
                BleedingOut = true
                HasRecievedMedicalAttention = false
            end
        end
    end)
end)

RegisterNetEvent("Stop.Bleeding")
AddEventHandler("Stop.Bleeding", function()
    if BleedingOut == true then
        BleedingOut = false
        HasRecievedMedicalAttention = false
    end
end)

RegisterNetEvent("Recieved.Medical.Attention")
AddEventHandler("Recieved.Medical.Attention", function()
    BleedingOut = false
    HasRecievedMedicalAttention = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local Player = PlayerPedId()      
        if StressLevel > 25 then
            if StressLevel > 50 and StressLevel < 75 then
                DoScreenFadeOut(4000)
                Citizen.Wait(1000)
                DoScreenFadeIn(4000)
                Citizen.Wait(180000)
            elseif StressLevel > 75 then
                DoScreenFadeOut(2000)
                Citizen.Wait(2000)
                DoScreenFadeIn(2000)
                Citizen.Wait(180000)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local Player = PlayerPedId()
        if StressLevel >= 25 then
            if StressLevel >= 25 and StressLevel < 50 then
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.02)
            elseif StressLevel >= 50 and StressLevel < 75 then
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.05)
            elseif StressLevel >= 75 and StressLevel < 100 then
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.07)
            elseif StressLevel >= 100 then
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.1)
            end
            Citizen.Wait(2000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local Player = PlayerPedId()
        local PlayerPosition = GetEntityCoords(Player, false)
        if #(PlayerPosition - YogaPlace) < 4 then
            DisplayHelpText("Press ~INPUT_CONTEXT~ to De-Stress and Unwind!")
            if IsControlJustPressed(1, 51) then
                TaskStartScenarioInPlace(Player, "WORLD_HUMAN_YOGA", 0, true)
            end
            if IsPedUsingScenario(Player, "WORLD_HUMAN_YOGA") then
                StressLevel = StressLevel - 0.5
                Citizen.Wait(1000)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if BleedingOut and not HasRecievedMedicalAttention then
            Citizen.Wait(120000)
            ApplyDamageToPed(PlayerPedId(), 5, true)
            Notify("You are bleeding out! You need medical attention!", 3100)
        end
    end
end)

Citizen.CreateThread(function()
    while HasRecievedMedicalAttention == false and not BleedingOut do
        StressLevel = 75
        Citizen.Wait(900000)
        Notify("Your wound has been infected! You need to go to a hospital!", 3100)
        Citizen.Wait(900000)
        Notify("You drop to the floor in shock due to infection!", 3100)
        SetEntityHealth(PlayerPedId(), 0)
    end
end)
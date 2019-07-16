local StressLevel = 0
local HasToldAboutStress = false
local BleedingOut = false
local HasRecievedMedicalAttention = true
local YogaPlace = vector3(-1495.3853759766, 829.42315673828,181.62339782715)
DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
local UsedCocaine =  false
local UsedCigarette = false
local UsedWeed = false
local CocaineTimer = nil
local BleedingOutStage = 0
local ToggleFlashes = false
local ToggleSpeed = false

RegisterNetEvent("Add.Stress")
AddEventHandler("Add.Stress", function(Stress)
    StressLevel = StressLevel + Stress
    DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
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
    DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
end)

RegisterNetEvent("Damage.StartBleeding")
AddEventHandler("Damage.StartBleeding", function(Bone, WeaponUsed, DamageTaken)
    Citizen.CreateThread(function()
        if Bone == "Neck" or Bone == "Stomach" or Bone == "Head" or Bone == "Upper chest" or Bone == "Right leg" or Bone == "Left leg" then
            if WeaponUsed ~= "WEAPON_UNARMED" and WeaponUsed ~= "WEAPON_POOLCLUB" and WeaponUsed ~= "WEAPON_FLASHLIGHT" and WeaponUsed ~= "WEAPON_BATON" and WeaponUsed ~= "WEAPON_BAT" and WeaponUsed ~= "WEAPON_GOLFCLUB" and WeaponUsed ~= "WEAPON_CROWBAR" and WeaponUsed ~= "WEAPON_WRENCH" then
                BleedingOut = true
                ToggleFlashes = false
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
    StressLevel = 0
    DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
end)

RegisterNetEvent("Cocaine.Speed")
AddEventHandler("Cocaine.Speed", function()
    CocaineTimer = 60
    UsedCocaine = true
end)

RegisterNetEvent("Use.Gauze")
AddEventHandler("Use.Gauze", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 1500,
        label = "Packing Wounds",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
            BleedingOut = false
        end
    end)
end)

RegisterNetEvent("Use.Bandage")
AddEventHandler("Use.Bandage", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 5000,
        label = "Using Bandage",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
			local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
            SetEntityHealth(PlayerPedId(), newHealth)
            BleedingOut = false
            HasRecievedMedicalAttention = false
        end
    end)
end)

RegisterNetEvent("Use.FirstAidKit")
AddEventHandler("Use.FirstAidKit", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 10000,
        label = "Using First Aid",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_stat_pack_01"
        },
    }, function(status)
        if not status then
			local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
            SetEntityHealth(PlayerPedId(), newHealth)
            BleedingOut = false
            HasRecievedMedicalAttention = false
        end
    end)
end)

RegisterNetEvent("Use.Medkit")
AddEventHandler("Use.Medkit", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 20000,
        label = "Using Medkit",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_ld_health_pack"
        },
    }, function(status)
        if not status then
            SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
            BleedingOut = false
            HasRecievedMedicalAttention = true
        end
    end)
end)

RegisterNetEvent("Use.Vicodin")
AddEventHandler("Use.Vicodin", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 3000,
        label = "Taking Vicodin",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            ToggleSpeed = false
            ToggleFlashes = true
        end
    end)
end)

RegisterNetEvent("Use.Hydrocodone")
AddEventHandler("Use.Hydrocodone", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 3000,
        label = "Taking Hydrocodone",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            ToggleSpeed = false
            ToggleFlashes = true
        end
    end)
end)

RegisterNetEvent("Use.Morphine")
AddEventHandler("Use.Morphine", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 3000,
        label = "Taking Morphine",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            ToggleSpeed = false
            ToggleFlashes = true
        end
    end)
end)

RegisterNetEvent("Use.Cigarette")
AddEventHandler("Use.Cigarette", function()
    UsedCigarette = true
end)

RegisterNetEvent("Use.Weed")
AddEventHandler("Use.Weed", function()
    UsedWeed = true
end)

-- Stress Thread
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

-- Condensed Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if BleedingOut and not HasRecievedMedicalAttention then
            Citizen.Wait(120000)
            ApplyDamageToPed(PlayerPedId(), 5, true)
            BleedingOutStage = 1
            Notify("You are bleeding out! You need medical attention!", 3100)
        end
        if not HasRecievedMedicalAttention and not BleedingOut then
            StressLevel = 75
            DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
            Citizen.Wait(900000)
            if HasRecievedMedicalAttention == false and not BleedingOut then
                Notify("Your wound has been infected! You need to go to a hospital!", 3100)
                BleedingOutStage = 2
            end
            Citizen.Wait(900000)
            if HasRecievedMedicalAttention == false and not BleedingOut then
                BleedingOutStage = 3
                Notify("Your infected has gotten much worse! You need to go to a hospital now!", 3100)
            end
            Citizen.Wait(300000)
            if HasRecievedMedicalAttention == false and not BleedingOut then
                Notify("You drop to the floor in shock due to infection!", 3100)
                SetEntityHealth(PlayerPedId(), 0)
            end
            if BleedingOut and not ToggleFlashes then
                if BleedingOutStage == 1 then
                    SetFlash(0, 0, 100, 100, 100)
                    Citizen.Wait(11000)
                elseif BleedingOutStage == 2 then
                    SetFlash(0, 0, 100, 250, 100)
                    Citizen.Wait(8000)
                elseif BleedingOutStage == 3 then
                    SetFlash(0, 0, 100, 500, 100)
                    Citizen.Wait(5000)
                end
            end
            local PlayerPosition = GetEntityCoords(Player, false)
            if #(PlayerPosition - YogaPlace) < 4 then
                DisplayHelpText("Press ~INPUT_CONTEXT~ to De-Stress and Unwind!")
                if IsControlJustPressed(1, 51) then
                    TaskStartScenarioInPlace(Player, "WORLD_HUMAN_YOGA", 0, true)
                end
                if IsPedUsingScenario(Player, "WORLD_HUMAN_YOGA") then
                    StressLevel = StressLevel - 0.5
                    DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
                    Citizen.Wait(1000)
                end
            end
        end
    end
end)

-- Movement Threads
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if UsedCocaine then
            SetPedMoveRateOverride(PlayerPedId(), 1.5)
        end
        if ToggleSpeed then
            SetPedMoveRateOverride(PlayerPedId(), 0.8)
        end
    end
end)

-- Weed \ Cigarette Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if UsedCigarette then
            Citizen.Wait(1000)
            if IsPedUsingScenario(PlayerPedId(), "WORLD_HUMAN_SMOKING") then
                StressLevel = StressLevel - 0.5
                DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
                if StressLevel == 0 then
                    Notify("You are not longer stressed!")
                    UsedCigarette = false
                end
            end
        elseif UsedWeed then
            Citizen.Wait(1000)
            if IsPedUsingScenario(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT") then
                StressLevel = StressLevel - 1.0
                DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
                if StressLevel == 0 then
                    Notify("You are not longer stressed!")
                    UsedWeed = false
                end
            end
        end
    end
end)

-- Timer Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if UsedCocaine then
            if CocaineTimer ~= nil then
                if CocaineTimer > 0 then
                    Citizen.Wait(1000)
                    CocaineTimer = CocaineTimer - 1
                else
                    UsedCocaine = false
                    CocaineTimer = nil
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if StressLevel > 0 then
            Citizen.Wait(10000)
            StressLevel = StressLevel - 0.5
            DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
        end
    end
end)
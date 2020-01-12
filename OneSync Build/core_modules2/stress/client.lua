local StressLevel = 0
local HasToldAboutStress = false
local YogaAreas = {
    vector3(-1495.3853759766, 829.42315673828,181.62339782715),
    vector3(-1224.2456054688, -1545.6127929688, 4.6459374427795), -- Vespucci Beach
    vector3(444.64099121094, -222.59527587891, 56.016399383545), -- Near Elgin Mechanic
}
DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
local UsedCocaine =  false
local UsedCigarette = false
local UsedWeed = false
local CocaineTimer = nil
local ToggleFlashes = false

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
	--ResetPedMovementClipset(PlayerPedId(), 1.0)
	TriggerEvent("ResetWalkStyle")
end)

RegisterNetEvent("Cocaine.Speed")
AddEventHandler("Cocaine.Speed", function()
    -- Change this value if needed
    CocaineTimer = 60 -- seconds
    UsedCocaine = true
end)

RegisterNetEvent("Use.Gauze")
AddEventHandler("Use.Gauze", function(Target)
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
            TriggerServerEvent("Use.Gauze.Effects", Target)
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
            SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
            TriggerEvent('mythic_hospital:client:RemoveBleed')
            TriggerEvent('mythic_hospital:client:ResetLimbs')
            StressLevel = 0
            DecorSetFloat(PlayerPedId(), "_Stress_Level", 0)
        end
    end)
end)

RegisterNetEvent("Use.Medkit")
AddEventHandler("Use.Medkit", function(Target)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 30000,
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
            -- animDict = "missheistdockssetup1clipboard@idle_a",
            animDict = "amb@medic@standing@kneel@idle_a",
            admin = "idle_a",
            -- anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_ld_health_pack"
        },
    }, function(status)
        if not status then
            if exports.emsjob:getIsInService() then
                TriggerServerEvent("Use.Medkit.Effects", Target, "Medic")
            else
                TriggerServerEvent("Use.Medkit.Effects", Target, "Civilian")
            end
        end
    end)
end)

RegisterNetEvent("Use.Vicodin")
AddEventHandler("Use.Vicodin", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 3000,
        label = "Taking Ibuprofen",
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
            TriggerEvent('mythic_hospital:client:UsePainKiller', 1)
            StressLevel = StressLevel - 25
            DecorSetFloat(PlayerPedId(), "_Stress_Level", StressLevel)
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
            TriggerEvent('mythic_hospital:client:UsePainKiller', 2)
            StressLevel = 0
            DecorSetFloat(PlayerPedId(), "_Stress_Level", 0)
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
            TriggerEvent('mythic_hospital:client:UsePainKiller', 4)
            StressLevel = 0
            DecorSetFloat(PlayerPedId(), "_Stress_Level", 0)
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

RegisterNetEvent("Use.Medkit.Effects")
AddEventHandler("Use.Medkit.Effects", function(Type)
    if Type == "Medic" then
        if IsEntityDead(PlayerPedId()) then
            TriggerServerEvent("medkit:revive", GetPlayerServerId(PlayerId()))
        else
            SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
            TriggerEvent('mythic_hospital:client:RemoveBleed')
            TriggerEvent('mythic_hospital:client:ResetLimbs')
            StressLevel = 0
            DecorSetFloat(PlayerPedId(), "_Stress_Level", 0)
        end
    else
        if IsEntityDead(PlayerPedId()) then
            TriggerServerEvent("medkit:revive", GetPlayerServerId(PlayerId()))
        else
            SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
            TriggerEvent('mythic_hospital:client:RemoveBleed')
            TriggerEvent('mythic_hospital:client:ResetLimbs')
            StressLevel = 0
            DecorSetFloat(PlayerPedId(), "_Stress_Level", 0)
        end
    end
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
    AddTextEntry("FRZL_BLIP_YOGA", "Yoga Park")

    for i = 1, #YogaAreas do
        local blip = AddBlipForCoord(YogaAreas[i].x, YogaAreas[i].y, YogaAreas[i].z)
        SetBlipSprite(blip, 480)
        SetBlipColour(blip, 8)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.6)
        BeginTextCommandSetBlipName("FRZL_BLIP_YOGA")
        EndTextCommandSetBlipName(blip)
    end
end)

-- Movement Threads
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if UsedCocaine then
            SetPedMoveRateOverride(PlayerPedId(), 1.5)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if StressLevel > 0 then
            local Player = PlayerPedId()
            local PlayerPosition = GetEntityCoords(Player, false)

            for i = 1, #YogaAreas do
                if #(PlayerPosition - YogaAreas[i]) < 4 then
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
            else
                UsedCigarette = false
                break
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
            else
                UsedWeed = false
                break 
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
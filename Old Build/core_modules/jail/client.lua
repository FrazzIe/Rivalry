--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local jobs = {
    [1] = {x = 1669.3770751953, y = 2671.7741699219, z = 45.564891815186, h = 9.0001344680786},
    [2] = {x = 1667.2628173828, y = 2671.7663574219, z = 45.564891815186, h = 6.1932606697083},
    [3] = {x = 1650.880859375, y = 2650.6540527344, z = 45.564891815186, h = 92.09351348877},
    [4] = {x = 1650.1315917969, y = 2652.2705078125, z = 45.564903259277, h = 94.331809997559},
    [5] = {x = 1649.455078125, y = 2586.4304199219, z = 45.564888000488, h = 179.61512756348},
    [6] = {x = 1675.7966308594, y = 2631.2055664063, z = 45.564880371094, h = 359.93759155273},
    [7] = {x = 1717.2008056641, y = 2631.2712402344, z = 45.564903259277, h = 268.37365722656},
    [8] = {x = 1758.4207763672, y = 2647.0783691406, z = 45.564903259277, h = 181.49214172363},
    [9] = {x = 1755.3251953125, y = 2675.5888671875, z = 45.564922332764, h = 9.2969970703125},
    [10] = {x = 1757.015625, y = 2676.6447753906, z = 45.564922332764, h = 11.364153862},
    [11] = {x = 1723.6801757813, y = 2685.2116699219, z = 45.564937591553, h = 310.82119750977},
    [12] = {x = 1725.4085693359, y = 2684.2580566406, z = 45.564937591553, h = 312.90051269531},
    [13] = {x = 1726.5012207031, y = 2664.3308105469, z = 45.564926147461, h = 1.168328166008},
}

local job_blip = nil
local finishedJob = false
local jailbreak = {x = 1720.6208496094, y = 2616.0678710938, z = 45.56485748291, h = 184.37046813965}

local randomizedJob = math.random(1,13)

IsJailed = false
local removeSentence = false
local isDoingJob = false
local whosJailed = {}
local isActive = false
 
RegisterNetEvent("jail:sync_players")
AddEventHandler("jail:sync_players", function(table)
    whosJailed = table
end)

RegisterNetEvent("jailbreak:toggle")
AddEventHandler("jailbreak:toggle", function()
    Citizen.CreateThread(function()
        while isActive do
            Citizen.Wait(0)
            Notify("You have just toggled the alarm! 10 minutes until completion!", 4000)
            Citizen.Wait(10000)
            TriggerServerEvent("jail:sync_players", jailedPlayers ,"removeall")
        end
    end)
end)

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped, false)
        if Vdist(coords.x, coords.y, coords.z, jailbreak.x, jailbreak.y, jailbreak.z) < 10 then
            drawMarker(25, jailbreak.x, jailbreak.y, jailbreak.z - 0.1, 1.0, 1.0, 1.5, 0, 255, 0, 255)
            if Vdist(coords.x, coords.y, coords.z, jailbreak.x, jailbreak.y, jailbreak.z) < 1 then
                DisplayHelpText("Press ~INPUT_CONTEXT~ to start a jailbreak!")
                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent('jailbreak:toggle')
                    if isActive == false then
                        isActive = true
                    else
                        Notify("Jailbreak has already been started!")
                    end
                end
            end
        else
            if isActive == true then
                isActive = false
                Notify("Jailbreak failed! You have left the required radius!")
            end
        end
    end
end)
--]]
local function drawJobBlips(randomizedJob)
    if not DoesBlipExist(job_blip) then
        job_blip = AddBlipForCoord(jobs[randomizedJob].x, jobs[randomizedJob].y, jobs[randomizedJob].z)
        SetBlipSprite(job_blip, 1)
        SetBlipColour(job_blip, 60)
        SetBlipAsShortRange(job_blip, true)
        SetBlipScale(job_blip, 0.85)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Jail Work")
        EndTextCommandSetBlipName(job_blip)
        SetBlipRoute(job_blip, true)
        Notify("You have been assigned a job!", 2500)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId(), false)
        if Vdist(coords.x, coords.y, coords.z, jobs[randomizedJob].x, jobs[randomizedJob].y, jobs[randomizedJob].z) < 10 then
            drawMarker(25, jobs[randomizedJob].x, jobs[randomizedJob].y, jobs[randomizedJob].z - 0.1, 1.0, 1.0, 1.5, 0, 255, 0, 255)
            if Vdist(coords.x, coords.y, coords.z, jobs[randomizedJob].x, jobs[randomizedJob].y, jobs[randomizedJob].z) < 1 then
                DisplayHelpText("Press ~INPUT_CONTEXT~ to work!")
                if IsControlJustPressed(1, 51) then
                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
                    Citizen.Wait(10000)
                    ClearPedTasks(PlayerPedId())
                    finishedJob = true
                    randomizedJob = math.random(1,13)
                    RemoveBlip(job_blip)
                    job_blip = nil
                    drawJobBlips(randomizedJob)
                    Notify("Your sentence has been reduced for your hard work!")
                end
            end
        end
    end
end)

RegisterNetEvent("jail:jail")
AddEventHandler("jail:jail", function(JailTime)
    if IsJailed == true then
        return
    end

    if exports.policejob:getIsCuffed() then
        TriggerEvent('police:uncuff')
    end
    if DoesEntityExist(PlayerPedId()) then
       
        Citizen.CreateThread(function()
            SetEntityCoords(PlayerPedId(), 1677.233, 2658.618, 45.216)
            IsJailed = true
            removeSentence = false
            randomizedJob = math.random(1,13)
            drawJobBlips(randomizedJob)
            --TriggerServerEvent("jail:jailedPlayers", GetPlayerServerId(PlayerId()), "add")
            local invisible = false
            TriggerEvent("anticheat:set", "invincible", true, function(callback)
                if callback then
                    invisible = true
                else
                    invisible = true
                    TriggerServerEvent("core:bug", "Line 33 in resource "..GetCurrentResourceName())
                end
            end)
            while invisible == false do Citizen.Wait(1) end
            while JailTime > 0 and not removeSentence do
                local coords = GetEntityCoords(PlayerPedId(), true)
                RemoveAllPedWeapons(PlayerPedId(), true)
                SetEntityInvincible(PlayerPedId(), true)
                TriggerEvent("fm:eat", 100)
                TriggerEvent("fm:drink", 100)
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    ClearPedTasksImmediately(PlayerPedId())
                end
                if JailTime % 30 == 0 then
                    exports.pNotify:SendNotification({text = JailTime/60 .." more months until release.",type = "error",timeout = 3000,layout = "centerRight",queue = "left"})
                    TriggerServerEvent("jail:update", JailTime/60)
                end
                Citizen.Wait(500)
                local Distance = Vdist(1677.233, 2658.618, 45.216, coords['x'], coords['y'], coords['z'])
                if Distance > 90 then
                    SetEntityCoords(PlayerPedId(), 1677.233, 2658.618, 45.216)
                    if Distance > 100 then
                        JailTime = JailTime + 60
                        exports.pNotify:SendNotification({text = "Your jail time was extended for an unlawful escape attempt.",type = "error",timeout = 5000,layout = "centerRight",queue = "left"})
                    end
                end
                if finishedJob == true then
                    JailTime = JailTime - 60.0
                    finishedJob = false
                else
                    JailTime = JailTime - 0.5
                end
            end
            SetEntityCoords(PlayerPedId(), 1839.099, 2608.195, 45.562)
            IsJailed = false
            RemoveBlip(job_blip)
            SetEntityInvincible(PlayerPedId(), false)
            TriggerEvent("anticheat:set", "invincible", false, function(callback)
            end)
            --TriggerServerEvent("jail:jailedPlayers", GetPlayerServerId(PlayerId()), "remove")
            if not removeSentence then
                TriggerServerEvent("jail:update", 0)
            end
        end)
    end
end)

RegisterNetEvent("jail:unjail")
AddEventHandler("jail:unjail", function()
    removeSentence = true
end)

function IsInJail()
    return IsJailed
end

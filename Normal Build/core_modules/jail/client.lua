--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local jobs = {
    vector3(1669.3770751953,2671.7741699219,45.564891815186),
    vector3(1667.2628173828,2671.7663574219,45.564891815186),
    vector3(1650.880859375,2650.6540527344,45.564891815186),
    vector3(1650.1315917969,2652.2705078125,45.564903259277),
    vector3(1649.455078125,2586.4304199219,45.564888000488),
    vector3(1675.7966308594,2631.2055664063,45.564880371094),
    vector3(1717.2008056641,2631.2712402344,45.564903259277),
    vector3(1758.4207763672,2647.0783691406,45.564903259277),
    vector3(1755.3251953125,2675.5888671875,45.564922332764),
    vector3(1757.015625,2676.6447753906,45.564922332764),
    vector3(1723.6801757813,2685.2116699219,45.564937591553),
    vector3(1725.4085693359,2684.2580566406,45.564937591553),
    vector3(1726.5012207031,2664.3308105469,45.564926147461),
    vector3(1670.4395751953,2696.798828125,45.564903259277),
    vector3(1679.5467529297,2699.3820800781,45.56587600708),
    vector3(1666.7370605469,2724.6909179688,45.564937591553),
    vector3(1605.7899169922,2642.2397460938,45.564853668213),
    vector3(1605.7042236328,2621.0129394531,45.564861297607),
    vector3(1586.3563232422,2513.5822753906,45.56485748291),
    vector3(1574.0158691406,2512.7614746094,45.564880371094),
    vector3(1586.302734375,2482.8239746094,45.564968109131),
    vector3(1645.3702392578,2457.4899902344,45.564926147461),
    vector3(1652.3911132813,2449.0991210938,45.564937591553),
    vector3(1719.185546875,2438.09375,45.564922332764),
    vector3(1729.7561035156,2457.4956054688,45.564922332764),
    vector3(1737.7976074219,2450.0727539063,45.565124511719),
    vector3(1763.4438476563,2467.296875,45.565113067627),
    vector3(1792.5939941406,2487.91015625,45.565113067627),
    vector3(1786.4692382813,2522.4604492188,45.565021514893),
    vector3(1792.0356445313,2540.2094726563,45.565021514893),
    vector3(1791.8231201172,2561.6052246094,45.565021514893),
    vector3(1791.1588134766,2568.6921386719,45.565021514893),
    vector3(1782.537109375,2632.2678222656,45.565021514893),
    vector3(1788.5661621094,2635.0715332031,45.565021514893),
    vector3(1629.5639648438,2564.1643066406,45.56485748291),
    vector3(1652.6964111328,2564.1635742188,45.56485748291),
    vector3(1735.7590332031,2504.7612304688,45.564979553223),
    vector3(1699.8347167969,2474.9255371094,45.564975738525),
    vector3(1678.21875,2481.0402832031,45.564922332764),
    vector3(1642.2850341797,2490.2690429688,45.564903259277),
    vector3(1621.8764648438,2509.28125,45.564903259277),
    vector3(1608.2794189453,2540.3198242188,45.564891815186),
    vector3(1609.8404541016,2568.4553222656,45.564891815186),
    vector3(1624.9686279297,2575.8442382813,45.564891815186),
}

local JailBreak = vector3(1722.8370361328,2615.0825195313,45.56485748291)

local job_blip = nil
local finishedJob = false

local randomizedJob = math.random(1,44)

IsJailed = false
local removeSentence = false
local isDoingJob = false
local whosJailed = {}
 
RegisterNetEvent("jail:sync_players")
AddEventHandler("jail:sync_players", function(table)
    whosJailed = table
end)

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
        if not removeSentence then
            local Ped = PlayerPedId()
            local PlayerPosition = GetEntityCoords(Ped, false)
            if #(PlayerPosition - jobs[randomizedJob]) < 10 then
                RenderMarker(25, jobs[randomizedJob].x, jobs[randomizedJob].y, jobs[randomizedJob].z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
                if #(PlayerPosition - jobs[randomizedJob]) < 1 then
                    DisplayHelpText("Press ~INPUT_CONTEXT~ to work!")
                    if IsControlJustPressed(1, 51) then
                        TaskStartScenarioInPlace(Ped, "WORLD_HUMAN_WELDING", 0, true)
                        Citizen.Wait(15000)
                        ClearPedTasks(Ped)
                        finishedJob = true
                        randomizedJob = math.random(1,13)
                        RemoveBlip(job_blip)
                        job_blip = nil
                        drawJobBlips(randomizedJob)
                        TriggerServerEvent('jail:payout', 10)
                        Notify("Your sentence has been reduced for your hard work!")
                    end
                end
            end
        else
            if DoesBlipExist(job_blip) then
                RemoveBlip(job_blip)
            end
        end
    end
end)

RegisterNetEvent("jail:notjailed")
AddEventHandler("jail:notjailed", function()
    IsJailed = false
    removeSentence = true
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
            SetEntityCoords(PlayerPedId(), 1689.7222900391, 2631.5864257813, 45.564895629883)
            IsJailed = true
            removeSentence = false
            randomizedJob = math.random(1,44)
            drawJobBlips(randomizedJob)
            TriggerServerEvent("Jail.AddJailedPlayer", GetPlayerServerId(PlayerId()))
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
                local Distance = Vdist(1693.1998291016,2583.5139160156,52.433990478516, coords['x'], coords['y'], coords['z'])
                if Distance > 160 then
                    SetEntityCoords(PlayerPedId(), 1689.7222900391, 2631.5864257813, 45.564895629883)
                    if Distance > 170 then
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
            SetEntityCoords(PlayerPedId(), 1678.5708007813, 2593.865234375, 45.564895629883)
            IsJailed = false
            RemoveBlip(job_blip)
            SetEntityInvincible(PlayerPedId(), false)
            TriggerEvent("anticheat:set", "invincible", false, function(callback)
            TriggerServerEvent('RemoveJailedPlayer', GetPlayerServerId(PlayerId()))
            end)
            if not removeSentence then
                TriggerServerEvent("jail:update", 0)
            end
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if removeSentence then
            local Player = PlayerPedId()
            local PlayerPosition = GetEntityCoords(Player, false)
            if #(PlayerPosition - JailBreak) < 10 then
                RenderMarker(25, JailBreak.x, JailBreak.y, JailBreak.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
                if #(PlayerPosition - JailBreak) < 1 then
                    DisplayHelpText("Press ~INPUT_CONTEXT~ to initiate a jailbreak!")
                    if IsControlJustPressed(1, 51) then
                        if not IsInJail() then
                            TriggerServerEvent("Jailbreak.Start")
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("Jailbreak.Start")
AddEventHandler("Jailbreak.Start", function()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        local Player = PlayerPedId()
        local PlayerPosition = GetEntityCoords(Player, false)
        while #(PlayerPosition - JailBreak) < 50 do
            Citizen.Wait(600000)
            TriggerServerEvent("Jailbreak.Complete")
            break
        end
        Notify("Jailbreak failed!", 2600)
    end)
end)

RegisterNetEvent("jail:unjail")
AddEventHandler("jail:unjail", function()
    removeSentence = true
    TriggerServerEvent('RemoveJailedPlayer', GetPlayerServerId(PlayerId()))
end)

function IsInJail()
    return IsJailed
end

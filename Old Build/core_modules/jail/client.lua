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
    [14] = {x = 1670.4395751953, y = 2696.798828125, z = 45.564903259277, h = 271.50485229492},
    [15] = {x = 1679.5467529297, y = 2699.3820800781, z = 45.56587600708, h = 87.567039489746},
    [16] = {x = 1666.7370605469, y = 2724.6909179688, z = 45.564937591553, h = 191.97801208496},
    [17] = {x = 1605.7899169922, y = 2642.2397460938, z = 45.564853668213, h = 269.22982788086},
    [18] = {x = 1605.7042236328, y = 2621.0129394531, z = 45.564861297607, h = 271.42584228516},
    [19] = {x = 1586.3563232422, y = 2513.5822753906, z = 45.56485748291, h = 94.014549255371},
    [20] = {x = 1574.0158691406, y = 2512.7614746094, z = 45.564880371094, h = 90.561859130859},
    [21] = {x = 1586.302734375, y = 2482.8239746094, z = 45.564968109131, h = 320.78604125977},
    [22] = {x = 1645.3702392578, y = 2457.4899902344, z = 45.564926147461, h = 178.7995300293},
    [23] = {x = 1652.3911132813, y = 2449.0991210938, z = 45.564937591553, h = 266.42047119141},
    [24] = {x = 1719.185546875, y = 2438.09375, z = 45.564922332764, h = 1.0305219888687},
    [25] = {x = 1729.7561035156, y = 2457.4956054688, z = 45.564922332764, h = 176.27433776855},
    [26] = {x = 1737.7976074219, y = 2450.0727539063, z = 45.565124511719, h = 267.70370483398},
    [27] = {x = 1763.4438476563, y = 2467.296875, z = 45.565113067627, h = 29.032508850098},
    [28] = {x = 1792.5939941406, y = 2487.91015625, z = 45.565113067627, h = 29.484596252441},
    [29] = {x = 1786.4692382813, y = 2522.4604492188, z = 45.565021514893, h = 91.146301269531},
    [30] = {x = 1792.0356445313, y = 2540.2094726563, z = 45.565021514893, h = 359.04632568359},
    [31] = {x = 1791.8231201172, y = 2561.6052246094, z = 45.565021514893, h = 88.750152587891},
    [32] = {x = 1791.1588134766, y = 2568.6921386719, z = 45.565021514893, h = 87.674461364746},
    [33] = {x = 1782.537109375, y = 2632.2678222656, z = 45.565021514893, h = 87.016998291016},
    [34] = {x = 1788.5661621094, y = 2635.0715332031, z = 45.565021514893, h = 91.105995178223},
    [35] = {x = 1629.5639648438, y = 2564.1643066406, z = 45.56485748291, h = 0.93585604429245},
    [36] = {x = 1652.6964111328, y = 2564.1635742188, z = 45.56485748291, h = 4.8337602615356},
    [37] = {x = 1735.7590332031, y = 2504.7612304688, z = 45.564979553223, h = 162.87686157227},
    [38] = {x = 1699.8347167969, y = 2474.9255371094, z = 45.564975738525, h = 225.43923950195},
    [39] = {x = 1678.21875, y = 2481.0402832031, z = 45.564922332764, h = 135.20106506348},
    [40] = {x = 1642.2850341797, y = 2490.2690429688, z = 45.564903259277, h = 185.9846496582},
    [41] = {x = 1621.8764648438, y = 2509.28125, z = 45.564903259277, h = 93.311950683594},
    [42] = {x = 1608.2794189453, y = 2540.3198242188, z = 45.564891815186, h = 135.70249938965},
    [43] = {x = 1609.8404541016, y = 2568.4553222656, z = 45.564891815186, h = 49.315849304199},
    [44] = {x = 1624.9686279297, y = 2575.8442382813, z = 45.564891815186, h = 266.890625},
}

local job_blip = nil
local finishedJob = false
local jailbreak = {x = 1720.6208496094, y = 2616.0678710938, z = 45.56485748291, h = 184.37046813965}

local randomizedJob = math.random(1,44)

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
end)--]]

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
        if not removeSentence then
            if Vdist(coords.x, coords.y, coords.z, jobs[randomizedJob].x, jobs[randomizedJob].y, jobs[randomizedJob].z) < 10 then
                drawMarker(25, jobs[randomizedJob].x, jobs[randomizedJob].y, jobs[randomizedJob].z - 0.1, 1.0, 1.0, 1.5, 0, 255, 0, 255)
                if Vdist(coords.x, coords.y, coords.z, jobs[randomizedJob].x, jobs[randomizedJob].y, jobs[randomizedJob].z) < 1 then
                    DisplayHelpText("Press ~INPUT_CONTEXT~ to work!")
                    if IsControlJustPressed(1, 51) then
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
                        Citizen.Wait(15000)
                        ClearPedTasks(PlayerPedId())
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
            SetEntityCoords(PlayerPedId(), 1848.1318359375, 2607.603515625, 45.582920074463)
            IsJailed = false
            RemoveBlip(job_blip)
            SetEntityInvincible(PlayerPedId(), false)
            TriggerEvent("anticheat:set", "invincible", false, function(callback)
            end)
            --TriggerServerEvent("jail:jailedPlayers", GetPlayerServerId(PlayerId()), "remove")
            if not removeSentence then
                TriggerServerEvent("jail:update", 0)
                --[[if DoesBlipExist(RemoveBlip) then
                    RemoveBlip(RemoveBlip)
                end--]]
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

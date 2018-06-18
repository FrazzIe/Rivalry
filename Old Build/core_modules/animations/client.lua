Citizen.CreateThread(function()
    local dict = "friends@frj@ig_1"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local handsup = false
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 57) then --Start holding X
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "wave_a", 8.0, 8.0, -1, 50, 0, false, false, false)
          	Citizen.Wait(5000)
          	ClearPedTasks(GetPlayerPed(-1))
                handsup = true
            else
                handsup = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    local dict = "anim@heists@prison_heiststation@cop_reactions"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local handsup = false
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 74) then
            if not handsup and not IsPedSittingInAnyVehicle(PlayerPedId()) then
                TaskPlayAnim(GetPlayerPed(-1), dict, "cop_a_idle", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)

Citizen.CreateThread(function()
    local dict = "amb@world_human_hang_out_street@female_arms_crossed@base"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local handsup = false
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 168) then --Start holding X
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)

Citizen.CreateThread(function()
    local dict = "mp_player_intfinger"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local handsup = false
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 167) then --Start holding X
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "mp_player_int_finger", 8.0, 8.0, -1, 50, 0, false, false, false)
          	Citizen.Wait(5000)
          	ClearPedTasks(GetPlayerPed(-1))
                handsup = true
            else
                handsup = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    local dict = "anim@mp_player_intcelebrationmale@face_palm"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local handsup = false
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 56) then --Start holding X
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "face_palm", 8.0, 8.0, -1, 50, 0, false, false, false)
          	Citizen.Wait(9000)
          	ClearPedTasks(GetPlayerPed(-1))
                handsup = true
            else
                handsup = false
            end
        end
    end
end)
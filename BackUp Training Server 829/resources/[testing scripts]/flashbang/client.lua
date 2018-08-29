local time = 0
local flashtime = 8
local sounds = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local weapon = GetSelectedPedWeapon(ped)
        if weapon == 126349499 then
            local x, y, z = table.unpack(BulletCoords())
            if x ~= 0.0 and y ~= 0.0 and z ~= 0.0 then
                TriggerServerEvent("flash:start", x, y, z, GetPlayersNearby(8))
            end
        end
    end
end)

RegisterNetEvent("flash:start")
AddEventHandler("flash:start",function(x, y, z)
    Citizen.CreateThread(function()
        time = flashtime
        while time > 0 do
            Citizen.Wait(0)
            RequestNamedPtfxAsset("core")
            SetPtfxAssetNextCall("core")
            effect = StartParticleFxLoopedAtCoord("ent_anim_paparazzi_flash", x, y, z, 0.0, 0.0, 0.0, 50.0, 0.0, 3.0, 1, 1)
            PlaySoundFromCoord(1, "Prison_Finale_Buzzard_Rocket", x, y, z, 0, 0, 15.0, 0)
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if time > 0 then
            time = time - 1
            Citizen.Wait(800)
        end
    end
end)

function BulletCoords()
    local result, coord = GetPedLastWeaponImpactCoord(GetPlayerPed(-1), Citizen.ReturnResultAnyway())
    return coord
end

function GetPlayersNearby(distance)
    local tbl = {}
    for i = -1, 32 do
        if NetworkIsPlayerConnected(i) and GetPlayerPed(i) ~= nil then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(i)),GetEntityCoords(GetPlayerPed(-1))) < distance then
                results[#results+1] = GetPlayerServerId(GetPlayerPed(i));
            end
        end
    end
    return tbl
end
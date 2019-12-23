local GSR = {
	Time = 15,
    Expire = 0,
    Whitelist = {
        [`WEAPON_BALL`]	= true,
        [`WEAPON_PETROLCAN`] = true,
        [`WEAPON_SNOWBALL`] = true,
        [`WEAPON_STUNGUN`] = true,
        [`WEAPON_FIREEXTINGUISHER`] = true,
        [`WEAPON_ANIMAL`] = true,
        [`WEAPON_COUGAR`] = true,
    },
    Players = {}
}

Citizen.CreateThread(function()
    local serverId = GetPlayerServerId(PlayerId())
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()

        if IsPedShooting(playerPed) then
            local hasWeapon, currentWeapon = GetCurrentPedWeapon(playerPed, 1)
            if currentWeapon ~= nil then
                if GetAmmoInPedWeapon(playerPed, currentWeapon) > 0 then
                    if not GSR.Whitelist[currentWeapon] then
                        GSR.Expire = GetGameTimer() + (GSR.Time * 1000 * 60)
                        TriggerServerEvent("GSR.Set", true)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    local serverId = GetPlayerServerId(PlayerId())
	while true do
		Citizen.Wait(5000)
		local playerPed = PlayerPedId()
        local currentTime = GetGameTimer()

        if currentTime > GSR.Expire and GSR.Players[serverId] then
            TriggerServerEvent("GSR.Set", false)
            GSR.Expire = 0
        end
	end
end)

AddEventHandler("GSR.Add", function()
    GSR.Expire = GetGameTimer() + (GSR.Time * 1000 * 60)
    TriggerServerEvent("GSR.Set", true)
end)

AddEventHandler("GSR.Get", function(cb)
    local player, distance = GetClosestPlayer()

    if distance ~= -1 and distance < 3 then
        local serverId = GetPlayerServerId(player)
        cb(GSR.Players[serverId])
    else
        cb(nil)
    end
end)

RegisterNetEvent("GSR.Sync")
AddEventHandler("GSR.Sync", function(src, value)
    GSR.Players[src] = value
end)
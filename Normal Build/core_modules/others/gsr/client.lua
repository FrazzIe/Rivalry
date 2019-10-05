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
}

AddEventHandler("GSR.Add", function()
    GSR.Expire = GetGameTimer() + (GSR.Time * 1000 * 60)
    DecorSetBool(PlayerPedId(), "_GSR", true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()

        if IsPedShooting(playerPed) then
            local hasWeapon, currentWeapon = GetCurrentPedWeapon(playerPed, 1)
            if currentWeapon ~= nil then
                if GetAmmoInPedWeapon(playerPed, currentWeapon) > 0 then
                    if not GSR.Whitelist[currentWeapon] then
                        GSR.Expire = GetGameTimer() + (GSR.Time * 1000 * 60)
                        DecorSetBool(playerPed, "_GSR", true)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    DecorRegister("_GSR", 2)
    
	while true do
		Citizen.Wait(5000)
		local playerPed = PlayerPedId()
        local currentTime = GetGameTimer()

        if currentTime > GSR.Expire then
            DecorSetBool(playerPed, "_GSR", false)
        else
            DecorSetBool(playerPed, "_GSR", true)
        end
	end
end)

AddEventHandler("GSR.Get", function(cb)
    local player, distance = GetClosestPlayer()
    
    if distance ~= -1 and distance < 3 then
        cb(DecorGetBool(player, "_GSR"))
    else
        cb(nil)
    end
end)
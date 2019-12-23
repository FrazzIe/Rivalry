Citizen.CreateThread(function()
    local Speaking = false

    while true do
        Citizen.Wait(0)
        local Player = PlayerId()
        local PlayerPed = PlayerPedId()

        if NetworkIsPlayerTalking(Player) then
            if not IsEntityPlayingAnim(PlayerPed, "mp_facial", "mic_chatter", 3) then
                TaskPlayAnim(PlayerPed, "mp_facial", "mic_chatter", 8.0, -4.0, -1, 33, 0.0, false, false, false)
                Speaking = true
            end
        else
            if Speaking then
                ClearPedSecondaryTask(PlayerPed)
                Speaking = false
            end
        end
    end
end)
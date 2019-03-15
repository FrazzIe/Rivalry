Citizen.CreateThread(function()
    local chop = GetHashKey("a_c_chop")
    local husky = GetHashKey("a_c_husky")

    for Index = 1, 15 do
        if Index ~= 11 and Index ~= 15 then
            EnableDispatchService(Index, false)
        else
            EnableDispatchService(Index, true)
        end
    end
    
    while true do
        Citizen.Wait(0)
        local PlayerPed = PlayerPedId()
        local PlayerPosition = GetEntityCoords(PlayerPed, false)
        local PlayerModel = GetEntityModel(PlayerPed)

        SetPedDensityMultiplierThisFrame(0.9999999)
        SetVehicleDensityMultiplierThisFrame(0.4)
        
        ClearAreaOfCops(PlayerPosition, 400.0)

        if PlayerModel == chop or PlayerModel == husky then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
    end
end)
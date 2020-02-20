local closestVehicle = nil
local closestVehiclePosition = nil
local closestVehicleDistance = nil
local currentVehicle = nil

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerVehicle = GetVehiclePedIsIn(playerPed, false)

        Citizen.Wait(0)

        -- Only run loop if play isn't in a vehicle
        if (playerVehicle == 0 or playerVehicle == nil) and (currentVehicle == 0 or currentVehicle == nil) then
            local playerPosition = GetEntityCoords(playerPed, false)

            local vehicles = {}

            for entity in EnumerateVehicles() do
                vehicles[#vehicles + 1] = entity
            end

            for i = 1, #vehicles do
                local entity = vehicles[i]
                local entityModel = GetEntityModel(entity)

                if IsThisModelACar(entityModel) then
                    local entityPosition = GetEntityCoords(entity, false)
                    local entityDistance = #(playerPosition - entityPosition)

                    if closestVehicle == nil then
                        closestVehicle = entity
                        closestVehiclePosition = entityPosition
                        closestVehicleDistance = entityDistance
                    else
                        if entityDistance < closestVehicleDistance then
                            closestVehicle = entity
                            closestVehiclePosition = entityPosition
                            closestVehicleDistance = entityDistance
                        end
                    end
                end       
            end

            Citizen.Wait(5000)
        else
            closestVehicle = nil
            closestVehiclePosition = nil
            closestVehicleDistance = nil
        end
    end
end)
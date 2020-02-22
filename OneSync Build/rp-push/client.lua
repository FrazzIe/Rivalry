local closestVehicle = nil
local closestVehiclePosition = nil
local closestVehicleDistance = nil
local currentVehicle = nil
local pushForward = false
local minDistance = 6
local pushDict = "missfinale_c2ig_11"
local pushAnim = "pushcar_offcliff_m"
local pushBone = 6286
local pushBoneIdx = GetPedBoneIndex(pushBone)
local messageDetach = "FRZL_PUSH_DETACH"
local blacklist = {
    [`dump`] = true,
    [`bus`] = true,
    [`airbus`] = true,
    [`coach`] = true,
    [`tourbus`] = true,
    [`taco`] = true,
    [`boxville`] = true,
    [`boxville2`] = true,
    [`boxville3`] = true,
    [`boxville4`] = true,
    [`burrito`] = true,
    [`burrito2`] = true,
    [`burrito3`] = true,
    [`burrito4`] = true,
    [`burrito5`] = true,
}
local isCuffed = false
local isInJail = false

function DisplayHelpText(label)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringTextLabel(label)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function IsAnyPlayerAttachedToEntity(entity)
    local players = GetActivePlayers()
    
	for i = 1, #players do
        local playerPed = GetPlayerPed(players[i])
        
		if DoesEntityExist(playerPed) then
			if GetEntityAttachedTo(playerPed) == entity then
				return true
			end
		end
    end
    
	return false
end

Citizen.CreateThread(function()
    AddTextEntry(messageDetach, "Press ~INPUT_CONTEXT~ to ~r~stop ~w~pushing.")

    while true do
        Citizen.Wait(0)
        
        local playerPed = PlayerPedId()
        local playerPosition = GetEntityCoords(playerPed, false)
        local isDead = IsEntityDead(playerPed)

        if not isDead and not isCuffed and not isInJail then
            if (closestVehicle ~= nil and closestVehicle ~= 0) and (currentVehicle == 0 or currentVehicle == nil) then
                if #(playerPosition - GetEntityCoords(closestVehicle, false)) < minDistance and not IsPedSittingInAnyVehicle(playerPed) then
                    if not GetIsVehicleEngineRunning(closestVehicle) and IsVehicleSeatFree(closestVehicle, -1) and not HasEntityCollidedWithAnything(closestVehicle) and GetVehicleEngineHealth(closestVehicle) > 0 and not IsAnyPlayerAttachedToEntity(closestVehicle) then
                        if IsControlPressed(0, 21) then
                            if IsControlJustPressed(1, 51) then
                                currentVehicle = closestVehicle
                                exports["core_modules"]:StanceAllowed(false)

                                local vehicleHeading = GetEntityHeading(currentVehicle)
                                local model = GetEntityModel(currentVehicle)
                                local minDim, maxDim = GetModelDimensions(model)
                                local size = (maxDim - minDim)

                                local backPos = GetOffsetFromEntityInWorldCoords(currentVehicle, 0, -(size.y / 2), 0)
                                local backDist = #(playerPosition - backPos)
                                local frontPos = GetOffsetFromEntityInWorldCoords(currentVehicle, 0, (size.y / 2), 0)
                                local frontDist = #(playerPosition - frontPos)
                                
                                local closestPos = nil
                                local closestDist = nil

                                if backDist < frontDist then
                                    pushForward = true
                                    closestPos = backPos
                                    closestDist = backDist
                                else
                                    pushForward = false
                                    closestPos = frontPos
                                    closestDist = frontDist
                                end

                                if closestDist > 1.0 then
                                    TaskGoStraightToCoord(playerPed, closestPos.x, closestPos.y, closestPos.z, 1.0, -1, vehicleHeading, 0.0)

                                    local time = GetGameTimer() + 5000

                                    while #(GetEntityCoords(playerPed, false) - closestPos) > 1.0 and GetGameTimer() < time do
                                        Citizen.Wait(100)
                                    end
                                end

                                local time = GetGameTimer() + 5000

                                NetworkRequestControlOfEntity(currentVehicle)
                                        
                                while not NetworkHasControlOfEntity(currentVehicle) and (time + 5000) > GetGameTimer() do
                                    Citizen.Wait(0)
                                end
                                
                                RequestAnimDict(pushDict)

                                while not HasAnimDictLoaded(pushDict) do
                                    Citizen.Wait(100)
                                end

                                if pushForward then
                                    AttachEntityToEntity(playerPed, currentVehicle, pushBoneIdx, 0.0, -(size.y / 2), minDim.z + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
                                else
                                    AttachEntityToEntity(playerPed, currentVehicle, pushBoneIdx, 0.0, (size.y / 2), minDim.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
                                end

                                TaskPlayAnim(playerPed, pushDict, pushAnim, 2.0, -8.0, -1, 35, 0, 0, 0, 0)

                                SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
                                SetEnableHandcuffs(playerPed, true)
                            end
                        end
                    end
                end
            elseif (currentVehicle ~= 0 and currentVehicle ~= nil) then
                if not GetIsVehicleEngineRunning(currentVehicle) and IsVehicleSeatFree(currentVehicle, -1) and not HasEntityCollidedWithAnything(currentVehicle) and GetVehicleEngineHealth(currentVehicle) > 0 then

                    SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)

                    if not IsEntityPlayingAnim(playerPed, pushDict, pushAnim, 3) then
                        TaskPlayAnim(playerPed, pushDict, pushAnim, 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                    end
                    
                    SetVehicleForwardSpeed(currentVehicle, pushForward and 1.0 or -1.0)

                    DisplayHelpText(messageDetach)

                    if IsControlPressed(0, 34) then
                        TaskVehicleTempAction(playerPed, currentVehicle, 11, 1000)
                    end

                    if IsControlPressed(0, 35) then
                        TaskVehicleTempAction(playerPed, currentVehicle, 10, 1000)
                    end

                    if IsControlJustPressed(1, 51) then
                        SetEnableHandcuffs(playerPed, false)
                        DetachEntity(playerPed, false, false)
                        StopAnimTask(playerPed, pushDict, pushAnim, 2.0)
                        exports["core_modules"]:StanceAllowed(true)
                        currentVehicle = nil
                    end
                else
                    SetEnableHandcuffs(playerPed, false)
                    DetachEntity(playerPed, false, false)
                    StopAnimTask(playerPed, pushDict, pushAnim, 2.0)
                    exports["core_modules"]:StanceAllowed(true)
                    currentVehicle = nil
                end
            end
        else
            if currentVehicle ~= 0 and currentVehicle ~= nil then
                if not isCuffed then
                    SetEnableHandcuffs(playerPed, false)
                end

                DetachEntity(playerPed, false, false)
                StopAnimTask(playerPed, pushDict, pushAnim, 2.0)
                exports["core_modules"]:StanceAllowed(true)
                currentVehicle = nil
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerVehicle = GetVehiclePedIsIn(playerPed, false)

        Citizen.Wait(0)

        -- Only run loop if play isn't in a vehicle
        if (playerVehicle == 0 or playerVehicle == nil) and (currentVehicle == 0 or currentVehicle == nil) then
            local playerPosition = GetEntityCoords(playerPed, false)

            closestVehicle = nil
            closestVehiclePosition = nil
            closestVehicleDistance = nil

            local vehicles = {}

            for entity in EnumerateVehicles() do
                vehicles[#vehicles + 1] = entity
            end

            for i = 1, #vehicles do
                local entity = vehicles[i]
                local entityModel = GetEntityModel(entity)

                if IsThisModelACar(entityModel) and not blacklist[entityModel] then
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

            Citizen.Wait(500)
        else
            closestVehicle = nil
            closestVehiclePosition = nil
            closestVehicleDistance = nil
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        isCuffed = exports.policejob:getIsCuffed() or exports["core_modules"]:isCuffed()
        isInJail = exports["core_modules"]:IsInJail()
    end
end)
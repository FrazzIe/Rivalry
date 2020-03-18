local barrierObjs = {}
local barrierProp = `prop_barrier_work05`
local barrierOffset = 4.0
local maxbarriers = 3
local barrierRadius = 10.0
local barrierSpeed = 0.0
local barrierBlip = nil
local barrierZone = nil

local barriersDeployed = false
local barriersDeleting = false
local barriersPlacing = false

function ToggleBarriers()
    if isInService then
        local playerPed = PlayerPedId()
        if not IsPedInAnyVehicle(playerPed) then
            if not barriersDeployed then
                if not barriersPlacing then
                    Notify("Placing road block")

                    barriersPlacing = true

                    local playerHeading = GetEntityHeading(playerPed)

                    RequestModel(barrierProp)

                    while not HasModelLoaded(barrierProp) do
                        Citizen.Wait(150)
                    end

                    for i = 1, maxbarriers do
                        local barrierIdx = #barrierObjs + 1
                        local coords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, barrierOffset * i + 0.5, 0.0)

                        barrierObjs[barrierIdx] = CreateObject(barrierProp, coords.x, coords.y, coords.z, true, false, false)

                        local barrierHeight = GetEntityHeightAboveGround(barrierObjs[barrierIdx])

                        SetEntityCoords(barrierObjs[barrierIdx], coords.x, coords.y, coords.z - barrierHeight + 0.05)

                        SetEntityHeading(barrierObjs[barrierIdx], playerHeading + 90.0)
                        SetEntityCollision(barrierObjs[barrierIdx], false, false)
                    end

                    local coords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, ((barrierOffset * maxbarriers)/2) + 0.5, 0.0)

                    barrierBlip = AddBlipForRadius(coords.x, coords.y, coords.z, barrierRadius)

                    SetBlipAlpha(barrierBlip, 80)
                    SetBlipColour(barrierBlip, 5)

                    barrierZone = AddSpeedZoneForCoord(coords.x, coords.y, coords.z, barrierRadius, barrierSpeed, false)

                    SetModelAsNoLongerNeeded(barrierProp)

                    barriersDeployed = true
                    barriersPlacing = false
                end
            else
                if not barriersDeleting then
                    Notify("Removing road block")

                    barriersDeleting = true

                    for i = 1, #barrierObjs do
                        if not NetworkHasControlOfEntity(barrierObjs[i]) then
                            local time = GetGameTimer() + 5000
                
                            while not NetworkHasControlOfEntity(barrierObjs[i]) and time > GetGameTimer() do
                                Citizen.Wait(250)
                            end
                        end
                
                        DeleteObject(barrierObjs[i])
                
                        if DoesEntityExist(barrierObjs[i]) then
                            SetEntityCoords(barrierObjs[i], 601.28948974609, -4396.9853515625, 384.98565673828)
                            SetEntityAsNoLongerNeeded(barrierObjs[i])
                        end
                    end
                
                    RemoveSpeedZone(barrierZone)
                    RemoveBlip(barrierBlip)
                
                    barrierZone = nil
                    barrierBlip = nil
                    barrierObjs = {}

                    barriersDeployed = false
                    barriersDeleting = false
                end
            end
        end
    end
end

RegisterCommand("+barriers", ToggleBarriers)
RegisterCommand("-barriers", function()

end)

RegisterCommand("rb", ToggleBarriers)

TriggerEvent("chat:addSuggestion", "rb", "Toggle road block", {})

RegisterKeyMapping("+barriers", "Toggle road block", "keyboard", "i")
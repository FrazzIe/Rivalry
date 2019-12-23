local uncuffLocations = {
    vector3(387.51870727539, 3585.2504882813, 33.292224884033)
}
local uncuffCost = 250

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()

        for i = 1, #uncuffLocations do
            local distance = #(GetEntityCoords(playerPed) - uncuffLocations[i])

            if distance < 20 then
                RenderMarker(25, uncuffLocations[i].x, uncuffLocations[i].y, uncuffLocations[i].z, 1.5, 1.5, 2.0, 255, 0, 0, 20)
                if distance < 2 then
                    DisplayHelpText("Press ~INPUT_CONTEXT~ to remove handcuffs for ~r~$~s~".. uncuffCost .. "/~g~$~s~".. (uncuffCost * 3) .. "!")
                    if IsControlJustPressed(0, 51) then
                        if exports.policejob:getIsCuffed() or exports.core_modules:isCuffed() then
                            TriggerServerEvent("uncuff:remove")
                        else
                            Notify("You aren't cuffed!", 2500)
                        end
                    end
                end
            end
        end
    end
end)
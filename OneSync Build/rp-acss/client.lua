RegisterNetEvent("ac.screenshot")
AddEventHandler("ac.screenshot", function(eventName)
    exports['screenshot-basic']:requestScreenshotUpload('https://wew.wtf/upload.php', 'files[]', function(data)
        local resp = json.decode(data)

        if resp then
            if resp.files then
                if resp.files[1] then
                    TriggerServerEvent(eventName, resp.files[1].url)
                end
            end
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if NetworkIsSessionStarted() then
            TriggerServerEvent("ac.activate")

            return
        end
    end
end)
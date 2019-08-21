RegisterNetEvent("ac.screenshot")
AddEventHandler("ac.screenshot", function()
    print("received")
    exports['screenshot-basic']:requestScreenshotUpload('https://wew.wtf/upload.php', 'files[]', function(data)
        local resp = json.decode(data)

        if resp then
            if resp.files then
                if resp.files[1] then
                    TriggerServerEvent("ac.screenshot", resp.files[1].url)
                end
            end
        end
    end)
end)
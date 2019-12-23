local players = {}
local playerCount = 0
local embedLimit = 10

function SendScreenshot(content, embeds)
    if embeds then
        if #embeds > 0 then
            local data = {
                username = "Screenshot Bot",
                content = content,
                embeds = embeds,      
            }

            PerformHttpRequest("https://discordapp.com/api/webhooks/613776913886085142/5y--jp-zEyDmMo-9V1CtFaGnyRy0W1mfrZ2bEZZo_55x40fgrBqeztyFYu1i5IC2okvb", function(err, text, headers) end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
        end
    end
end

RegisterServerEvent("ac.activate")
AddEventHandler("ac.activate", function()
    local src = source

    players[src] = true
    playerCount = playerCount + 1
end)

AddEventHandler("playerDropped", function(msg)
    local src = source

    players[src] = nil
    playerCount = playerCount - 1
end)

Citizen.CreateThread(function()
    local screenshots = {}

    RegisterServerEvent("ac.screenshot.all")
    AddEventHandler("ac.screenshot.all", function(img)
        local src = source
        if img ~= nil and type(img) == "string" then
            TriggerEvent("core:getuser", src, function(char, user)
                if char ~= nil and user ~= nil then
                    local first_name = char.get("first_name") or "NULL"
                    local last_name = char.get("last_name") or "NULL"
                    local steam = char.get("steam") or "NULL"
                    local license = user.get("license") or "NULL"
                    local char_id = char.get("characterID") or "NULL"
                    local steamHex = steam:sub(7)
                    local steamInt = tonumber(steamHex, 16) or "NULL"
                    local url = "https://steamcommunity.com/id/" .. steamInt

                    screenshots[#screenshots + 1] = {
                        id = src,
                        name = first_name .. " " .. last_name,
                        steam = steam,
                        license = license,
                        char_id = char_id,
                        url = url,
                        img = img,
                        timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
                    }

                end
            end)
        end
    end)

    while true do
        Citizen.Wait(5000)
        local currentPlayerCount = playerCount

        TriggerClientEvent("ac.screenshot", -1, "ac.screenshot.all")
        
        while #screenshots < currentPlayerCount do
            Citizen.Wait(0)
        end

        local screenshotCount = #screenshots

        if screenshotCount > embedLimit then
            local requestsNeeded = 1

            if screenshotCount % embedLimit == 0 then
                requestsNeeded = screenshotCount/10
            else
                requestsNeeded = (screenshotCount/10) + 1
            end

            for i = 1, requestsNeeded do
                local embeds = {}
                local content = "Screenshot " .. (((i - 1) * embedLimit) + 1) .. " to " .. (i * embedLimit) .. " out of " .. screenshotCount
                for j = ((i - 1) * embedLimit) + 1, (i * embedLimit) do
                    if screenshots[j] ~= nil then
                        embeds[#embeds + 1] = {
                            title = "ID: " .. screenshots[j].id,
                            description = "",
                            fields = {
                                {
                                    name = "Character Name",
                                    value = screenshots[j].name,
                                    inline = true,
                                },
                                {
                                    name = "Character ID",
                                    value = screenshots[j].char_id,
                                    inline = true,
                                },
                                {
                                    name = "License",
                                    value = screenshots[j].license,
                                    inline = true,
                                },
                                {
                                    name = "Steam",
                                    value =  screenshots[j].steam,
                                    inline = true,
                                },  
                                {
                                    name = "Steam Profile",
                                    value = screenshots[j].url,
                                }
                            },
                            color = "16239905",
                            timestamp = screenshots[j].timestamp,
                            image = {
                                url = screenshots[j].img,
                            },
                        } 
                    end
                end

                SendScreenshot(content, embeds)
            end

            screenshots = {}
        else
            local embeds = {}
            local content = "Screenshot 1 to " .. screenshotCount .. " out of " .. screenshotCount

            for i = 1, screenshotCount do
                if screenshots[i] ~= nil then
                    embeds[#embeds + 1] = {
                        title = "ID: " .. screenshots[i].id,
                        description = "",
                        fields = {
                            {
                                name = "Character Name",
                                value = screenshots[i].name,
                                inline = true,
                            },
                            {
                                name = "Character ID",
                                value = screenshots[i].char_id,
                                inline = true,
                            },
                            {
                                name = "License",
                                value = screenshots[i].license,
                                inline = true,
                            },
                            {
                                name = "Steam",
                                value =  screenshots[i].steam,
                                inline = true,
                            },  
                            {
                                name = "Steam Profile",
                                value = screenshots[i].url,
                            }
                        },
                        color = "16239905",
                        timestamp = screenshots[i].timestamp,
                        image = {
                            url = screenshots[i].img,
                        },
                    }
                end
            end

            SendScreenshot(content, embeds)
        end

        Citizen.Wait(1750000)
    end
end)

Citizen.CreateThread(function()
    local screenshots = {}

    RegisterServerEvent("ac.screenshot.target")
    AddEventHandler("ac.screenshot.target", function(img)
        local src = source
        if img ~= nil and type(img) == "string" then
            TriggerEvent("core:getuser", src, function(char, user)
                if char ~= nil and user ~= nil then
                    local first_name = char.get("first_name") or "NULL"
                    local last_name = char.get("last_name") or "NULL"
                    local steam = char.get("steam") or "NULL"
                    local license = user.get("license") or "NULL"
                    local char_id = char.get("characterID") or "NULL"
                    local steamHex = steam:sub(7)
                    local steamInt = tonumber(steamHex, 16) or "NULL"
                    local url = "https://steamcommunity.com/id/" .. steamInt

                    SendScreenshot("Targeted Screenshot From Icecon", {{
                        title = "ID: " .. src,
                        description = "",
                        fields = {
                            {
                                name = "Character Name",
                                value = first_name .. " " .. last_name,
                                inline = true,
                            },
                            {
                                name = "Character ID",
                                value = char_id,
                                inline = true,
                            },
                            {
                                name = "License",
                                value = license,
                                inline = true,
                            },
                            {
                                name = "Steam",
                                value =  steam,
                                inline = true,
                            },  
                            {
                                name = "Steam Profile",
                                value = url,
                            }
                        },
                        color = "16239905",
                        timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
                        image = {
                            url = img,
                        },
                    }})
                end
            end)
        end
    end)

    RegisterServerEvent("ac.screenshot.target.all")
    AddEventHandler("ac.screenshot.target.all", function(img)
        local src = source
        if img ~= nil and type(img) == "string" then
            TriggerEvent("core:getuser", src, function(char, user)
                if char ~= nil and user ~= nil then
                    local first_name = char.get("first_name") or "NULL"
                    local last_name = char.get("last_name") or "NULL"
                    local steam = char.get("steam") or "NULL"
                    local license = user.get("license") or "NULL"
                    local char_id = char.get("characterID") or "NULL"
                    local steamHex = steam:sub(7)
                    local steamInt = tonumber(steamHex, 16) or "NULL"
                    local url = "https://steamcommunity.com/id/" .. steamInt

                    screenshots[#screenshots + 1] = {
                        id = src,
                        name = first_name .. " " .. last_name,
                        steam = steam,
                        license = license,
                        char_id = char_id,
                        url = url,
                        img = img,
                        timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
                    }
                end
            end)
        end
    end)

    RegisterCommand("findcheater", function(src, args, raw)
        if args[1] then
            TriggerClientEvent("ac.screenshot", args[1], "ac.screenshot.target")
        else
            local currentPlayerCount = playerCount
    
            TriggerClientEvent("ac.screenshot", -1, "ac.screenshot.target.all")
            
            while #screenshots < currentPlayerCount do
                Citizen.Wait(0)
            end
    
            local screenshotCount = #screenshots
    
            if screenshotCount > embedLimit then
                local requestsNeeded = 1
    
                if screenshotCount % embedLimit == 0 then
                    requestsNeeded = screenshotCount/10
                else
                    requestsNeeded = (screenshotCount/10) + 1
                end
    
                for i = 1, requestsNeeded do
                    local embeds = {}
                    local content = "Screenshot " .. (((i - 1) * embedLimit) + 1) .. " to " .. (i * embedLimit) .. " out of " .. screenshotCount
                    for j = ((i - 1) * embedLimit) + 1, (i * embedLimit) do
                        if screenshots[j] ~= nil then
                            embeds[#embeds + 1] = {
                                title = "ID: " .. screenshots[j].id,
                                description = "",
                                fields = {
                                    {
                                        name = "Character Name",
                                        value = screenshots[j].name,
                                        inline = true,
                                    },
                                    {
                                        name = "Character ID",
                                        value = screenshots[j].char_id,
                                        inline = true,
                                    },
                                    {
                                        name = "License",
                                        value = screenshots[j].license,
                                        inline = true,
                                    },
                                    {
                                        name = "Steam",
                                        value =  screenshots[j].steam,
                                        inline = true,
                                    },  
                                    {
                                        name = "Steam Profile",
                                        value = screenshots[j].url,
                                    }
                                },
                                color = "16239905",
                                timestamp = screenshots[j].timestamp,
                                image = {
                                    url = screenshots[j].img,
                                },
                            } 
                        end
                    end
    
                    SendScreenshot(content, embeds)
                end
    
                screenshots = {}
            else
                local embeds = {}
                local content = "Screenshot 1 to " .. screenshotCount .. " out of " .. screenshotCount
    
                for i = 1, screenshotCount do
                    if screenshots[i] ~= nil then
                        embeds[#embeds + 1] = {
                            title = "ID: " .. screenshots[i].id,
                            description = "",
                            fields = {
                                {
                                    name = "Character Name",
                                    value = screenshots[i].name,
                                    inline = true,
                                },
                                {
                                    name = "Character ID",
                                    value = screenshots[i].char_id,
                                    inline = true,
                                },
                                {
                                    name = "License",
                                    value = screenshots[i].license,
                                    inline = true,
                                },
                                {
                                    name = "Steam",
                                    value =  screenshots[i].steam,
                                    inline = true,
                                },  
                                {
                                    name = "Steam Profile",
                                    value = screenshots[i].url,
                                }
                            },
                            color = "16239905",
                            timestamp = screenshots[i].timestamp,
                            image = {
                                url = screenshots[i].img,
                            },
                        }
                    end
                end
    
                SendScreenshot(content, embeds)
            end
        end
    end, true)
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerClientEvent("ac.screenshot", -1)
        Citizen.Wait(1750000)
    end
end)

RegisterServerEvent("ac.screenshot")
AddEventHandler("ac.screenshot", function(img)
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
                local jsonStr = json.encode({
                    username = "Screenshot Bot",
                    embeds = {
                        {
                            title = "Cheat Detector",
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
                        }
                    },
            
                    content = ""
                })
                PerformHttpRequest("https://discordapp.com/api/webhooks/613631136995999765/7ybrIp9EgseNld-kg5f1NddCOAg1TgNoPDleABChgc7v8JS0LPC8l1uBUZAtaovdqO_K", function(err, text, headers) end, 'POST', jsonStr, { ['Content-Type'] = 'application/json' })
            end
        end)
    end
end)

RegisterCommand("findcheater", function(src, args, raw)
    if args[1] then
        TriggerClientEvent("ac.screenshot", args[1])
    else
        TriggerClientEvent("ac.screenshot", -1)
    end
end, true)
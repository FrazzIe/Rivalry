local recentMessages = {}

TriggerEvent("core:addCommand", "me", function(source, args, rawCommand, data)
    local msg = table.concat(args, " ")
    local timer = GetGameTimer()
    local spam = false

    if recentMessages[source] then
        if msg == recentMessages[source][1] and timer - recentMessages[source][2] < 5000 then
            spam = true
        elseif msg ~= recentMessages[source][1] and timer - recentMessages[source][2] < 500 then
            spam = true
        end
    else
        recentMessages[source] = { msg, timer }
    end

    if not spam then
        local steam = data.get("steam")
        local name = data.get("first_name").." "..data.get("last_name")

        TriggerClientEvent("proximity:msg", -1, source, name, msg)

        PerformHttpRequest("https://discordapp.com/api/webhooks/673281686863347752/ZgiPizh03p1fuKHFbqsLTGIwc0G2M-Gg2ViihCIv2st8cP3ZXvj0MghZc6G29zDmNa2O", function(err, text, headers) end, 'POST', json.encode(
        {
            username = "Me",
            embeds = {
                {
                    title = name .. " (" .. steam .. ")",
                    description = msg,
                    fields = {},
                    color = "2132991",
                }
            },
    
            content = ""
    
        }), { ['Content-Type'] = 'application/json' })
    end
end, {help = "Roleplay with text by describing what you are doing."})

AddEventHandler("playerDropped", function()
    local src = source
    recentMessages[src] = nil
end)
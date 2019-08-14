TriggerEvent("core:addCommand", "me", function(source, args, rawCommand, data)
    local steam = data.get("steam")
    local name = data.get("first_name").." "..data.get("last_name")

    TriggerClientEvent("proximity:msg", -1, source, name, table.concat(args, " "))

    PerformHttpRequest("https://discordapp.com/api/webhooks/611315975052066836/5y7B37qMNxSFvXzabKjb9gqE7spujq1gW5En95JW8RnfLog2iInJYpKULpj_vItnu0VP", function(err, text, headers) end, 'POST', json.encode(
        {
            username = "ERP",
            embeds = {
                {
                    title = name .. " (" .. steam .. ")",
                    description = table.concat(args, " "),
                    fields = {},
                    color = "2132991",
                }
            },
    
            content = ""
    
        }), { ['Content-Type'] = 'application/json' })
end, {help = "Roleplay with text by describing what you are doing."})
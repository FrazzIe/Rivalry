RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

local filter = {
    "nigger",
    "faggot",
    "queer",
}

AddEventHandler('_chat:messageEntered', function(author, color, message)
	local source = tonumber(source)
    if not message or not author then
        return
    end

    local found = false
    for k,v in ipairs(filter) do
        if string.find(string.lower(message), v) then
            found = true
            break
        end
    end
    if found then
		TriggerEvent('FAC:Chatfilter', source, "2h" , "[CHAT-FILTER]::No Racist Slurs, enjoy your cooldown and read the rules", "CHAT FILTER")
    else

        TriggerEvent('chatMessage', source, author, message)

	    if not WasEventCanceled() then
	        TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
	    end
	    print('[CHAT]::'..author..': '..message)
	    TriggerEvent("f:log","chat","::"..author..": "..message)
	end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

AddEventHandler('rconCommand', function(commandName, args)
    if commandName == "say" then
        local msg = table.concat(args, ' ')

        TriggerClientEvent('chatMessage', -1, '^3Your friendly neighbourhood ^1Spooderman', { 0, 0x99, 255 }, msg)
        RconPrint('console: ' .. msg .. "\n")

        CancelEvent()
    end
end)

-- tell command handler
AddEventHandler('rconCommand', function(commandName, args)
    if commandName == "tell" then
        local target = table.remove(args, 1)
        local msg = table.concat(args, ' ')

        TriggerClientEvent('chatMessage', tonumber(target), '^3Your friendly neighbourhood ^1Spooderman', { 0, 0x99, 255 }, msg)
        RconPrint('console: ' .. msg .. "\n")

        CancelEvent()
    end
end)

--[[
Complete List of Options:
        type
        layout
        theme
        text
        timeout
        progressBar
        closeWith
        animation = {
            open
            close
        }
        sounds = {
            volume
            conditions
            sources
        }
        docTitle = {
            conditions
        }
        modal
        id
        force
        queue
        killer
        container
        buttons

More details below or visit the creators website http://ned.im/noty/options.html

Layouts:
    top
    topLeft
    topCenter
    topRight
    center
    centerLeft
    centerRight
    bottom
    bottomLeft
    bottomCenter
    bottomRight

Types:
    alert
    success
    error
    warning
    info

Themes: -- You can create more themes inside html/themes.css, use the gta theme as a template.
    gta
    mint
    relax
    metroui

Animations:
    open:
        noty_effects_open
        gta_effects_open
        gta_effects_open_left
        gta_effects_fade_in
    close:
        noty_effects_close
        gta_effects_close
        gta_effects_close_left
        gta_effects_fade_out

closeWith: -- array, You will probably never use this.
    click
    button

sounds:
    volume: 0.0 - 1.0
    conditions: -- array
        docVisible
        docHidden
    sources: -- array of sound files

modal:
    true
    false

force:
    true
    false

queue: -- default is global, you can make it what ever you want though.
    global

killer: -- will close all visible notifications and show only this one
    true
    false

visit the creators website http://ned.im/noty/options.html for more information
--]]

function SetQueueMax(queue, max)
    local tmp = {
        queue = tostring(queue),
        max = tonumber(max)
    }

    SendNUIMessage({maxNotifications = tmp})
end

function SendNotification(options)
    TriggerEvent("pNotify:SendNotification", options)
end

RegisterNetEvent("pNotify:SendNotification")
AddEventHandler("pNotify:SendNotification", function(options)
    exports.mythic_notify:DoCustomHudText('alert', options.text, 6000)
end)

RegisterNetEvent("pNotify:SetQueueMax")
AddEventHandler("pNotify:SetQueueMax", function(queue, max)
    SetQueueMax(queue, max)
end)

--[[RegisterNetEvent("chatMessage")
AddEventHandler("chatMessage", function(author, color, text)
    TriggerEvent("pNotify:SendNotification", {text = "<span style='font-weight: 900'>" .. text .. "</span>",
        layout = "centerLeft",
        timeout = 2000,
        progressBar = false,
        type = "error",
        animation = {
            open = "gta_effects_fade_in",
            close = "gta_effects_fade_out"
        }})
end)]]
--[[
local _3D = true
local safezone = true

function RenderRect(x, y, width, height, r, g, b, a)
    DrawRect(x + width * 0.5, y + height * 0.5, width, height, r, g, b, a)
end

function MeasureStringWidth(str, font, scale)
    BeginTextCommandWidth("CELL_EMAIL_BCON")
    AddTextComponentSubstringPlayerName(str)
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0)
    return EndTextCommandGetWidth(true)
end

function GetCharacterCount(str)
    local count = 0

    for char in str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        count = count + 1
    end

    return count
end

function AddText(text)
	local charCount = GetCharacterCount(text)

	if charCount < 100 then
		AddTextComponentSubstringPlayerName(text)
	else
        local strCount = (charCount % 99 == 0) and charCount / 99 or (charCount / 99) + 1
        
        if strCount > 3 then
            strCount = 3
        end
        
        for i = 0, math.floor(strCount) do
			AddTextComponentSubstringPlayerName(text:sub(i * 99, (i * 99) + 99))
		end
	end
end

function GetLineCount(msg, x, y, font, scale, wrap)
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0.35)
    SetTextWrap((x or 0) - ((wrap or 0)/2), (x or 0) + ((wrap or 0)/2))
    SetTextCentre(true)
    BeginTextCommandLineCount("CELL_EMAIL_BCON")
    AddText(msg or "")
    return GetTextScreenLineCount(x or 0, y or 0)
end

Citizen.CreateThread(function()
    local rect = {
        x = -0.04,
        y = 0,
        w = 0.11305357515812, -- 0.0012
        h = 0.01851851851,
        r = 255,
        g = 255,
        b = 255,
        a = 255,
    }
    local text = {
        x = -0.04,
        y = 0,
        font = 0,
        scale = 0.20,
        r = 0,
        g = 0,
        b = 0,
        a = 255,
    }

    local msg = "Pulls out his phone, and hands it over to the nearest person. Also grabs a pack of chips, and a water bottle. Then pulls out his wallet and pays for it."
    local lineCount = GetLineCount(msg, text.x, text.y, text.font, text.scale, rect.w)
    local rectWidthOffset = rect.w 
    local rectHeightOffset = rect.h

    if lineCount > 1 then
        rectHeightOffset = (rect.h * 0.75) * lineCount
    else
        rectWidthOffset = MeasureStringWidth(msg, text.font, text.scale)
    end

    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerPosition = GetEntityCoords(playerPed, false)

        if _3D then
            SetDrawOrigin(playerPosition.x, playerPosition.y, playerPosition.z, 0)
        end

        if safezone then
            SetScriptGfxAlign(76, 84)
            SetScriptGfxAlignParams(0, 0, 0, 0)
        end
        
        RenderRect(rect.x, rect.y, rectWidthOffset + 0.0012, rectHeightOffset, rect.r, rect.g, rect.b, rect.a)

        SetTextFont(text.font)
        SetTextScale(1.0, text.scale)
        SetTextColour(text.r, text.g, text.b, text.a)
        SetTextWrap(text.x - (rect.w/2), text.x + (rect.w/2)) -- centre
        SetTextCentre(true)
        BeginTextCommandDisplayText("CELL_EMAIL_BCON")
        AddText(msg)
        EndTextCommandDisplayText(text.x + ((rectWidthOffset + 0.0012)/2), text.y)

        if safezone then
            ResetScriptGfxAlign()
        end

        if _3D then
            ClearDrawOrigin()
        end
    end
end)

RegisterCommand("3d", function()
    _3D = not _3D;
end, false)

RegisterCommand("sf", function()
    safezone = not safezone;
end, false)
--]]

local messages = {}
local eventName = "proximity:msg"
local textCommandStr = "CELL_EMAIL_BCON"
local textCommandStrMaxLength = 297
local textCommandStrLength = 99
local messageExpire = 3500
local messageRadius = 12.5
local messageSeparator = 0.0012
local background = {
    x = -0.04,
    y = 0,
    w = 0.11425357515,
    h = 0.01851851851,
    r = 0,
    g = 0,
    b = 0,
    a = 110,
}
local message = {
    x = -0.04,
    y = 0,
    font = 0,
    scale = 0.20,
    r = 255,
    g = 255,
    b = 255,
    a = 170,
}
local debug = false

function RenderRect(x, y, width, height, r, g, b, a)
    DrawRect(x + width * 0.5, y + height * 0.5, width, height, r, g, b, a)
end

function GetCharacterCount(str)
    local count = 0

    for char in str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        count = count + 1
    end

    return count
end

function GetLineCount(msg, x, y, font, scale, wrap)
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0.35)
    SetTextWrap((x or 0) - ((wrap or 0)/2), (x or 0) + ((wrap or 0)/2))
    SetTextCentre(true)
    BeginTextCommandLineCount(textCommandStr)
    for i = 1, #msg do
        AddTextComponentSubstringPlayerName(msg[i])
    end
    return GetTextScreenLineCount(x or 0, y or 0)
end

function MeasureStringWidth(str, font, scale)
    BeginTextCommandWidth(textCommandStr)
    AddTextComponentSubstringPlayerName(str)
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0)
    return EndTextCommandGetWidth(true)
end

function AddMessage(src, msg)
    local msgs = {}
    local charCount = GetCharacterCount(msg)

    if charCount > 99 then
        local strCount = (charCount % textCommandStrLength == 0) and charCount / textCommandStrLength or (charCount / textCommandStrLength) + 1
    
        if strCount >= (textCommandStrMaxLength / textCommandStrLength) then
            strCount = (textCommandStrMaxLength / textCommandStrLength) - 1
        end

        for i = 0, math.floor(strCount) do
            local subStart = i * textCommandStrLength
            msgs[i + 1] = msg:sub(subStart, subStart + textCommandStrLength)
        end
    else
        msgs = {msg}        
    end

    local lineCount = GetLineCount(msgs, message.x, message.y, message.font, message.scale, background.w)
    local width = background.w
    local height = background.h

    if lineCount > 1 then
        height = (GetTextScaleHeight(message.scale, message.font) + 0.006) * lineCount
    else
        width = MeasureStringWidth(msg, message.font, message.scale)
    end

    if not messages[src] then
        messages[src] = {}
    end

    messages[src][#messages[src] + 1] = { w = width, h = height, msg = msgs, time = GetGameTimer() + (messageExpire * #msgs) }
end

RegisterNetEvent(eventName)
AddEventHandler(eventName, function(src, name, msg)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(src)))
    if #(GetEntityCoords(playerPed) - GetEntityCoords(targetPed) < messageRadius then
        if IsEntityDead(playerPed) then
            TriggerEvent('chatMessage', "^0-", {255, 0, 0}, "^5" .. name .."  ".."^3  " .. msg)
        elseif IsEntityDead(targetPed) then
            TriggerEvent('chatMessage', "^0-", {255, 0, 0}, "^5" .. name .."  ".."^3  " .. msg)
        else
            local charCount = GetCharacterCount(msg)

            if charCount > textCommandStrMaxLength then
                local strCount = (charCount % textCommandStrMaxLength == 0) and charCount / textCommandStrMaxLength or (charCount / textCommandStrMaxLength)
                
                for i = 0, math.floor(strCount) do
                    local subStart = i * textCommandStrMaxLength
                    AddMessage(src, msg:sub(subStart, subStart + textCommandStrMaxLength))
                end
            else
                AddMessage(src, msg)
            end
        end
    end
end)

Citizen.CreateThread(function()
    local removedKeys = {}
    local table_remove = table.remove

    while true do
        Citizen.Wait(0)
        local currentTime = GetGameTimer()

        local i = 1

        while i <= #removedKeys do
            if removedKeys[i] then
                if messages[removedKeys[i]] ~= nil then
                    if #messages[removedKeys[i]] <= 0 then
                        messages[removedKeys[i]] = nil
                    end
                end
            end

            table_remove(removedKeys, i)
        end

        for id, msgs in pairs(messages) do
            local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(id)))
            if #msgs > 0 then
                i = 1

                SetDrawOrigin(coords.x, coords.y, coords.z, 0)
                SetScriptGfxAlign(76, 84)
                SetScriptGfxAlignParams(0, 0, 0, 0)

                local yOffset = 0

                while i <= #msgs do
                    if currentTime >= msgs[i].time then
                        table_remove(msgs, i)
                    else
                        RenderRect(background.x, background.y + yOffset, msgs[i].w, msgs[i].h, background.r, background.g, background.b, background.a)

                        SetTextFont(message.font)
                        SetTextScale(1.0, message.scale)
                        SetTextColour(message.r, message.g, message.b, message.a)
                        SetTextCentre(true)
                        SetTextWrap(message.x - (msgs[i].w/2), message.x + (msgs[i].w/2))

                        BeginTextCommandDisplayText(textCommandStr)

                        for j = 1, #msgs[i].msg do
                            AddTextComponentSubstringPlayerName(msgs[i].msg[j])
                        end

                        if debug then
                            AddTextComponentSubstringPlayerName(" " .. (msgs[i].time - currentTime) * 0.001 .. "s")
                        end

                        EndTextCommandDisplayText(message.x + (msgs[i].w/2), message.y + yOffset)
                        
                        yOffset = yOffset + msgs[i].h + messageSeparator
                        i = i + 1
                    end
                end

                ResetScriptGfxAlign()                
                ClearDrawOrigin()
            else
                removedKeys[#removedKeys + 1] = id
            end
        end
    end
end)
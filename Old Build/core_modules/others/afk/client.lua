AFK = {}

AFK.Movement = GetGameTimer()
AFK.KeyPressed = GetGameTimer()
AFK.Time = 10
AFK.Warning = 5
AFK.Position = GetEntityCoords(PlayerPedId(), false)

local function GetRemainingString(timeleft)
    if timeleft > 1 then
        return math.floor(timeleft).." minutes"
    else
        return "less than 1 minute"
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local Position = GetEntityCoords(PlayerPedId(), false)

        if IsControlJustPressed(1, 245) or IsControlJustPressed(1, 249) then
            AFK.KeyPressed = GetGameTimer()
            AFK.Movement = GetGameTimer()
        end

        if AFK.Position ~= Position then
            AFK.Position = Position
            AFK.Movement = GetGameTimer()
            AFK.KeyPressed = GetGameTimer()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        local Time = GetGameTimer()

        if (Time - AFK.Movement) > (60000 * AFK.Time) or (Time - AFK.KeyPressed) > (60000 * AFK.Time) then
            TriggerServerEvent("core:kickall", "AFK")
        elseif (Time - AFK.Movement) > (60000 * (AFK.Time - AFK.Warning)) or (Time - AFK.KeyPressed) > (60000 * (AFK.Time - AFK.Warning)) then
            AFK.Remaining = math.max((Time - AFK.Movement), (Time - AFK.KeyPressed)) / 60000
            TriggerEvent("chatMessage", "AFK", {255,255,255}, "^1You will be kicked for being AFK in "..GetRemainingString(AFK.Time - AFK.Remaining))
        end
    end
end)
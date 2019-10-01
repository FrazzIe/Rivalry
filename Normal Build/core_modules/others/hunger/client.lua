--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local water = 100
local food = 100
local falpha = 200
local walpha = 200
local fualpha = 200
local Oxygen = 100

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local PlayerPed = PlayerPedId()
        if GetEntityMaxHealth(PlayerPed) ~= 200 then
            SetEntityMaxHealth(PlayerPed, 200)
            SetEntityHealth(PlayerPed, 200)
        end
        
        if IsPedSwimmingUnderWater(PlayerPedId()) then
            if Oxygen > 0 and not exports.core_modules2:ScubaHas() then
                Oxygen = Oxygen - 0.1
            elseif Oxygen > 0 and exports.core_modules2:ScubaHas() then
                Oxygen = Oxygen - 0.00325
            end
        elseif Oxygen ~= 100 then
            Oxygen = 100
        end

        if not hud_off then
            local Air = 0.070 * (Oxygen / 100)
            local Hunger = 0.070 * (food / 100)
            local Thirst = 0.070 * (water / 100)
            local parmor = GetPedArmour(PlayerPed)
            local Armor = 0.070 * (parmor / 100)
            local phealth = GetEntityHealth(PlayerPed) - 100
            local Health = 0.070 * (phealth / 100)
            if exports.core_modules2:SeatbeltActive() then
                Seat = "~g~ BELT"
            else
                Seat = "~r~ BELT"
            end
            if(IsPedInAnyVehicle(PlayerPed, false))then
                local cVeh = GetVehiclePedIsIn(PlayerPed, false)
                local Mph = GetEntitySpeed(GetVehiclePedIsIn(PlayerPed, false)) * 2.236936
                local Height = GetEntityHeightAboveGround(PlayerPedId())
                local currentfuel = (DecorGetFloat(cVeh, "_Fuel_Level")*1.53846153846)
                local VehicleClass = GetVehicleClass(cVeh)
                if VehicleClass == 15 or VehicleClass == 16 then
                    drawHelpTxt(.66, 1.418, 1.0,1.0,0.55 , "~w~" .. math.ceil(Mph), 255, 255, 255, 250, 6)  -- Speed
                    drawHelpTxt(0.676, 1.428, 1.0,1.0,0.3, "~w~ MPH", 255, 255, 255, 250, 6)  -- MPH
                    drawHelpTxt(0.696, 1.418, 1.0,1.0,0.55 , "~w~" .. math.ceil(Height), 255, 255, 255, 250, 6)  -- Height
                    drawHelpTxt(0.717, 1.428, 1.0,1.0,0.3, "~w~ FT", 255, 255, 255, 250, 6) -- FT
                    drawRct(0.015, 0.967, 0.1405,0.03,0,0,0,150) -- main
                    drawRct(0.015, 0.97, 0.070,0.01,68,102,68,200) -- Health Background
                    drawRct(0.015, 0.97, Health,0.01,55,185,55,200) -- Health Main
                    drawRct(0.0855, 0.97, 0.070,0.01,65,87,97,200) -- Armor Background
                    drawRct(0.0855, 0.97, Armor,0.01,54,119,159,200) -- Armor Main
                    drawRct(0.015, 0.983, 0.070,0.01,100,95,70,200) -- Hunger Background
                    drawRct(0.015, 0.983, Hunger,0.01,180,162,53,200) -- Hunger Main
                    drawRct(0.0855, 0.983, 0.070,0.01,83,115,124,200) -- Thirst Background
                    drawRct(0.0855, 0.983, Thirst,0.01,95,156,178,200) -- Thirst Main
                elseif VehicleClass == 14 then
                    drawHelpTxt(.66, 1.418, 1.0,1.0,0.55 , "~w~" .. math.ceil(Mph), 255, 255, 255, 250, 6)  -- Speed
                    drawHelpTxt(0.676, 1.428, 1.0,1.0,0.3, "~w~ MPH", 255, 255, 255, 250, 6)  -- MPH
                    drawRct(0.015, 0.967, 0.1405,0.03,0,0,0,150) -- main
                    drawRct(0.015, 0.97, 0.070,0.01,68,102,68,200) -- Health Background
                    drawRct(0.015, 0.97, Health,0.01,55,185,55,200) -- Health Main
                    drawRct(0.0855, 0.97, 0.070,0.01,65,87,97,200) -- Armor Background
                    drawRct(0.0855, 0.97, Armor,0.01,54,119,159,200) -- Armor Main
                    drawRct(0.015, 0.983, 0.070,0.01,100,95,70,200) -- Hunger Background
                    drawRct(0.015, 0.983, Hunger,0.01,180,162,53,200) -- Hunger Main
                    drawRct(0.0855, 0.983, 0.070,0.01,83,115,124,200) -- Thirst Background
                    drawRct(0.0855, 0.983, Thirst,0.01,95,156,178,200) -- Thirst Main
                elseif VehicleClass == 13 then
                    drawRct(0.015, 0.967, 0.1405,0.03,0,0,0,150) -- main
                    drawRct(0.015, 0.97, 0.070,0.01,68,102,68,200) -- Health Background
                    drawRct(0.015, 0.97, Health,0.01,55,185,55,200) -- Health Main
                    drawRct(0.0855, 0.97, 0.070,0.01,65,87,97,200) -- Armor Background
                    drawRct(0.0855, 0.97, Armor,0.01,54,119,159,200) -- Armor Main
                    drawRct(0.015, 0.983, 0.070,0.01,100,95,70,200) -- Hunger Background
                    drawRct(0.015, 0.983, Hunger,0.01,180,162,53,200) -- Hunger Main
                    drawRct(0.0855, 0.983, 0.070,0.01,83,115,124,200) -- Thirst Background
                    drawRct(0.0855, 0.983, Thirst,0.01,95,156,178,200) -- Thirst Main
                else
                    if GetPedInVehicleSeat(cVeh, -1) == PlayerPed or GetPedInVehicleSeat(cVeh, 0) == PlayerPed then
                        drawHelpTxt(.66, 1.418, 1.0,1.0,0.55 , "~w~" .. math.ceil(Mph), 255, 255, 255, 250, 6)  -- Speed
                        drawHelpTxt(0.676, 1.428, 1.0,1.0,0.3, "~w~ MPH", 255, 255, 255, 250, 6)  -- MPH
                        drawHelpTxt(0.696, 1.418, 1.0,1.0,0.55 , "~w~" .. math.ceil(currentfuel), 255, 255, 255, 250, 6)  -- Fuel Remaining
                        drawHelpTxt(0.712, 1.428, 1.0,1.0,0.3, "~w~ FUEL", 255, 255, 255, 250, 6) -- Fuel
                        drawHelpTxt(0.732, 1.422, 1.0,1.0,0.45, Seat, 255, 255, 255, 250, 6) -- Seatbelt
                        drawRct(0.015, 0.967, 0.1405,0.03,0,0,0,150) -- main
                        drawRct(0.015, 0.97, 0.070,0.01,68,102,68,200) -- Health Background
                        drawRct(0.015, 0.97, Health,0.01,55,185,55,200) -- Health Main
                        drawRct(0.0855, 0.97, 0.070,0.01,65,87,97,200) -- Armor Background
                        drawRct(0.0855, 0.97, Armor,0.01,54,119,159,200) -- Armor Main
                        drawRct(0.015, 0.983, 0.070,0.01,100,95,70,200) -- Hunger Background
                        drawRct(0.015, 0.983, Hunger,0.01,180,162,53,200) -- Hunger Main
                        drawRct(0.0855, 0.983, 0.070,0.01,83,115,124,200) -- Thirst Background
                        drawRct(0.0855, 0.983, Thirst,0.01,95,156,178,200) -- Thirst Main
                    else
                        drawHelpTxt(0.66, 1.422, 1.0,1.0,0.45, Seat, 255, 255, 255, 250, 6) -- Seatbelt
                        drawRct(0.015, 0.967, 0.1405,0.03,0,0,0,150) -- main
                        drawRct(0.015, 0.97, 0.070,0.01,68,102,68,200) -- Health Background
                        drawRct(0.015, 0.97, Health,0.01,55,185,55,200) -- Health Main
                        drawRct(0.0855, 0.97, 0.070,0.01,65,87,97,200) -- Armor Background
                        drawRct(0.0855, 0.97, Armor,0.01,54,119,159,200) -- Armor Main
                        drawRct(0.015, 0.983, 0.070,0.01,100,95,70,200) -- Hunger Background
                        drawRct(0.015, 0.983, Hunger,0.01,180,162,53,200) -- Hunger Main
                        drawRct(0.0855, 0.983, 0.070,0.01,83,115,124,200) -- Thirst Background
                        drawRct(0.0855, 0.983, Thirst,0.01,95,156,178,200) -- Thirst Main
                    end
                end
            elseif IsPedSwimmingUnderWater(PlayerPedId()) then
                drawRct(0.015, 0.967, 0.1405,0.03,0,0,0,150) -- main
                drawRct(0.015, 0.97, ((0.070*.66666)-.0001),0.01,68,102,68,200) -- Health Background
                drawRct(0.015, 0.97, ((Health*.66666)-.0001),0.01,55,185,55,200) -- Health Main
                drawRct(0.062, 0.97, ((0.070*.66666)-.0001),0.01,65,87,97,200) -- Armor Background
                drawRct(0.062, 0.97, ((Armor*.66666)-.0001),0.01,54,119,159,200) -- Armor Main
                drawRct(0.109, 0.97, ((0.070*.66666)-.0001),0.01,105,105,105,200) -- Oxygen Background
                drawRct(0.109, 0.97, ((Air*.66666)-.0001),0.01,128,128,128,200) -- Oxygen Main
                drawRct(0.015, 0.983, 0.070,0.01,100,95,70,200) -- Hunger Background
                drawRct(0.015, 0.983, Hunger,0.01,180,162,53,200) -- Hunger Main
                drawRct(0.0855, 0.983, 0.070,0.01,83,115,124,200) -- Thirst Background
                drawRct(0.0855, 0.983, Thirst,0.01,95,156,178,200) -- Thirst Main
            else
                drawRct(0.015, 0.967, 0.1405,0.03,0,0,0,150) -- main
                drawRct(0.015, 0.97, 0.070,0.01,68,102,68,200) -- Health Background
                drawRct(0.015, 0.97, Health,0.01,55,185,55,200) -- Health Main
                drawRct(0.0855, 0.97, 0.070,0.01,65,87,97,200) -- Armor Background
                drawRct(0.0855, 0.97, Armor,0.01,54,119,159,200) -- Armor Main
                drawRct(0.015, 0.983, 0.070,0.01,100,95,70,200) -- Hunger Background
                drawRct(0.015, 0.983, Hunger,0.01,180,162,53,200) -- Hunger Main
                drawRct(0.0855, 0.983, 0.070,0.01,83,115,124,200) -- Thirst Background
                drawRct(0.0855, 0.983, Thirst,0.01,95,156,178,200) -- Thirst Main

            end
        end
    end
end)

function drawRct(x,y,width,height,r,g,b,a)

    DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function drawHelpTxt(x,y ,width,height,scale, text, r,g,b,a,font)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

AddEventHandler('playerSpawned', function(spawn)
    food = 100
    water = 100
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if water < 20 then
            wateralpha = not wateralpha
            Wait(500)
            if wateralpha then
                walpha = 100
            else
                walpha = 200
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if food < 20 then
            foodalpha = not foodalpha
            Wait(500)
            if foodalpha then
                falpha = 100
            else
                falpha = 200
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not isAdmin then
            local PlayerPed = PlayerPedId()
            if IsPedRunning(PlayerPed) then
                food = food - 1
                water = water - 0.8
            elseif IsPedWalking(PlayerPed) then
                food = food - 0.2
                water = water - 0.1
            else
                food = food - 0.2
                water = water - 0.1
            end
            Citizen.Wait(40000)
            if food < 20 or water < 20 then
                local newhealth = GetEntityHealth(PlayerPed) - 15
                SetEntityHealth(PlayerPed, newhealth)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if food <= 1 or water <= 1 then
            food = 0
            water = 0
            SetEntityHealth(PlayerPed, 0)
            food = 40
            water = 40
        end
    end
end)

RegisterNetEvent('fm:drink')
AddEventHandler('fm:drink', function(v)
    water = water + tonumber(v)
    if water < 0 then
        water = 0
    end
    if water > 100 then
        water = 100
    end
end)

RegisterNetEvent('fm:eat')
AddEventHandler('fm:eat', function(v)
    food = food + tonumber(v)
    if food < 0 then
        food = 0
    end
    if food > 100 then
        food = 100
    end
end)

function getBars()
    return {food,water}
end


--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        value = value - 1
    end
end)

value = 300
maxvalue = 300
width = 0.069
xvalue = 0.5
yvalue = 0.8
            DrawRect(xvalue + (width/2),yvalue,width + 0.004,0.015,0,0,0,150)
            drawHelpTxt(xvalue + (((maxvalue/2)/((maxvalue/2)/width))/2) + width/1.5,yvalue + 0.037,0.1,0.1,0.2, value, 255,255,255,255,6)
            DrawRect(xvalue + (width/2),yvalue,width,0.008295,10,100,255,75)
            DrawRect(xvalue + ((value/(maxvalue/width))/2),yvalue,value/(maxvalue/width),0.008295,10,100,255,255)
--]]
--[[
currentPosition = 0 -- Scroller Position
maxPosition = GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 0)
local olink = 0.138/(GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 0)-1)
link = 0
bar = {
    x = 0.628, -- X Coordinate of both boxes
    y = 0.436, -- Y Coordinate of both boxes
    height = 0.014, -- Width of both boxes
    width = {background_box = 0.175, scroller = 0.037},
}
new_x = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        drawHelpTxt(0.3,0.837 ,0.1,0.1,0.5, currentPosition.."/"..maxPosition-1 , 255,255,255,255,6)
        DrawRect(bar.x, bar.y, bar.width.background_box, bar.height, 23, 108, 183, 190) -- Background
        new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) + (((bar.width.background_box - bar.width.scroller) / (maxPosition-1)) * currentPosition)
        if new_x < (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MIN
        if new_x > (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MAX
        DrawRect(new_x,bar.y,bar.width.scroller,bar.height,0, 126, 255,255)    -- Scroller

        if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
            PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            if currentPosition > 0 then
                currentPosition = currentPosition-1 
            else 
                currentPosition = 0 
            end
            SetPedComponentVariation(GetPlayerPed(-1), 0, currentPosition, 0, 0)
        end
        if IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
            PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            if currentPosition < maxPosition-1 then 
                currentPosition = currentPosition+1 
            else 
                currentPosition = maxPosition-1 
            end
            SetPedComponentVariation(GetPlayerPed(-1), 0, currentPosition, 0, 0)
        end
    end
end)
--]]
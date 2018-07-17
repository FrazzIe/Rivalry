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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not hud_off then
            DrawRect(0.0855,0.8,0.142,0.015,0,0,0,150)
            if(IsPedInAnyVehicle(GetPlayerPed(-1), false))then
    	        local cVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    	        local currentfuel = DecorGetFloat(cVeh, "_Fuel_Level")
            	DrawRect(0.068 + (0.05175)/2,0.8,0.05175,0.008295,10,100,255,75)
            	DrawRect(0.068 + (water/1932.3671497)/2,0.8,water/1932.3671497,0.008295,10,100,255,walpha)
            	drawHelpTxt(0.138,0.837 ,0.1,0.1,0.2, "THIRST", 255,255,255,255,6)
    	        DrawRect(0.0148 + (0.0525)/2,0.8,0.0525,0.008295,255,165,0,75)
    	        DrawRect(0.0148 + (food/1904.76190476)/2,0.8,food/1904.76190476,0.008295,255,165,0,falpha)
    	        drawHelpTxt(0.084,0.837 ,0.1,0.1,0.2, "HUNGER", 255,255,255,255,6)
    	        DrawRect(0.1215 + (0.0345)/2,0.8,0.0345,0.008295,255, 206, 30,75)
    	        DrawRect(0.1215 + ((currentfuel/(GetVehicleHandlingFloat(cVeh, "CHandlingData", "fPetrolTankVolume")/0.0345))/2),0.8,currentfuel/(GetVehicleHandlingFloat(cVeh, "CHandlingData", "fPetrolTankVolume")/0.0345),0.008295,255, 206, 30,fualpha)
    	        drawHelpTxt(0.183,0.837 ,0.1,0.1,0.2, "FUEL", 255,255,255,255,6)
            else
            	DrawRect(0.087 + (0.069)/2,0.8,0.069,0.008295,10,100,255,75)
            	DrawRect(0.087 + (water/1449.27536232)/2,0.8,water/1449.27536232,0.008295,10,100,255,walpha)
            	drawHelpTxt(0.165,0.837 ,0.1,0.1,0.2, "THIRST", 255,255,255,255,6)
            	DrawRect(0.0148 + (0.07)/2,0.8,0.07,0.008295,255,165,0,75)
            	DrawRect(0.0148 + (food/1428.57142857)/2,0.8,food/1428.57142857,0.008295,255,165,0,falpha)
            	drawHelpTxt(0.094,0.837 ,0.1,0.1,0.2, "HUNGER", 255,255,255,255,6)
            end
        end
    end
end)

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
            if IsPedRunning(GetPlayerPed(-1)) then
                food = food - 1
                water = water - 0.8
            elseif IsPedWalking(GetPlayerPed(-1)) then
                food = food - 0.2
                water = water - 0.1
            else
                food = food - 0.2
                water = water - 0.1
            end
    		Citizen.Wait(40000)
    		if food < 20 or water < 20 then
    			local newhealth = GetEntityHealth(GetPlayerPed(-1)) - 15
    			SetEntityHealth(GetPlayerPed(-1), newhealth)
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
            SetEntityHealth(GetPlayerPed(-1), 0)
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
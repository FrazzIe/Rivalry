--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local showPlayerBlips = false
local ignorePlayerNameDistance = false
local disPlayerNames = 30
local playerSource = 0
local function DrawText3D(x, y, z, text, r, g, b, a) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.8*scale)
        SetTextFont(6)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(r, g, b, a)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local invehicle = IsPedInAnyVehicle(ped, false)
    if invehicle then 
        for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
            if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
        end
    end
    return -2
end

-- IsPedInMeleeCombat

-- IsPedShooting

-- IsPedDucking(GetPlayerPed( id ))

-- IsPedWeaponReadyToShoot(GetPlayerPed( id ))
--

Citizen.CreateThread(function()
    while true do
        if not hud_off then
            if WarMenu.IsMenuOpened("Scoreboard") or WarMenu.IsMenuOpened("player_info") or WarMenu.IsMenuOpened("player_info_disconnected") or WarMenu.IsMenuOpened("disconnected") then
                for i=0,99 do
                	N_0x31698aa80e0223f8(i)
                end
                for id = 0, 31 do
                	if  ((NetworkIsPlayerActive( id )) and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) then
                		ped = GetPlayerPed( id )
                		x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                		x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                		distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
                		local isDucking = IsPedDucking(GetPlayerPed( id ))
                		local cansee = HasEntityClearLosToEntity( GetPlayerPed( -1 ), GetPlayerPed( id ), 17 )
                		local seatnumber = GetPedVehicleSeat( GetPlayerPed( id ) )
                	    local isReadyToShoot = IsPedWeaponReadyToShoot(GetPlayerPed( id ))
                	    local isStealth = GetPedStealthMovement(GetPlayerPed( id ))
                	    local isDriveBy = IsPedDoingDriveby(GetPlayerPed( id ))
                	    local isInCover = IsPedInCover(GetPlayerPed( id ),true)
                	    if isStealth == nil then
                	        isStealth = 0
                	    end

                	    if isDucking or isStealth == 1 or isDriveBy or isInCover then
                	        cansee = false
                	    end

                	    if seatnumber ~= -2 then
                	        seatnumber = seatnumber + 0.25
                	    end
                	    seatnumber = tonumber(seatnumber)
                	    if (distance < disPlayerNames) then
                	        if( NetworkIsPlayerTalking(id) ) then

                	            if cansee then
                	                 if seatnumber == -2 then
                	                    DrawText3D(x2, y2, z2+1.2, GetPlayerServerId(id), 255, 0, 0, 255)
                	                else
                	                    DrawText3D(x2, (y2+seatnumber), z2+1.2, GetPlayerServerId(id), 255, 0, 0, 255)
                	                end
                	            end
                	            else
                	            if cansee then
                	                if seatnumber == -2 then
                	                    DrawText3D(x2, y2, z2+1.2, GetPlayerServerId(id), 255, 255, 255, 255)
                	                else
                	                    DrawText3D(x2, (y2+seatnumber), z2+1.2, GetPlayerServerId(id), 255, 255, 255, 255)
                	                end
                	            end
                	        end
                	    end

                	end
                end
            end
        end
        Citizen.Wait(0)

        if not IsAimCamActive() or not IsFirstPersonAimCamActive() then
        	HideHudComponentThisFrame(14)
        end


        if IsHudComponentActive(1) then 
        	HideHudComponentThisFrame(1)
        end

        if IsHudComponentActive(6) then 
        	HideHudComponentThisFrame(6)
        end

        if IsHudComponentActive(7) then 
        	HideHudComponentThisFrame(7)
        end

        if IsHudComponentActive(9) then 
        	HideHudComponentThisFrame(9)
        end
        if IsHudComponentActive(0) and not IsPedInAnyVehicle(GetPlayerPed( -1 ), true) then 
        	HideHudComponentThisFrame(0)
        end
	end
end)


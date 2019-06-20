IsPolice = false
IsParamedic = false
IsOnDutyPolice = false
IsOnDutyParamedic = false

function SetPolice(_IsPolice, _IsOnDuty)
    IsPolice = _IsPolice
    IsOnDutyPolice = _IsOnDuty
end

function SetParamedic(_IsParamedic, _IsOnDuty)
    IsParamedic = _IsParamedic
    IsOnDutyParamedic = _IsOnDuty
end

local animals = {
    "a_c_boar",
    "a_c_cat_01",
    "a_c_chickenhawk",
    "a_c_chimp",
    "a_c_chop",
    "a_c_cormorant",
    "a_c_cow",
    "a_c_coyote",
    "a_c_crow",
    "a_c_deer",
    "a_c_dolphin",
    "a_c_fish",
    "a_c_hen",
    "a_c_humpback",
    "a_c_husky",
    "a_c_killerwhale",
    "a_c_mtlion",
    "a_c_pig",
    "a_c_pigeon",
    "a_c_poodle",
    "a_c_rabbit_01",
    "a_c_rat",
    "a_c_retriever",
    "a_c_rhesus",
    "a_c_rottweiler",
    "a_c_seagull",
    "a_c_sharkhammer",
    "a_c_sharktiger",
    "a_c_shepherd",
    "a_c_westy",
}

for i = 1, #animals do
    animals[i] = GetHashKey(animals[i])
end

local extrablips = {
    {name="Prison", sprite=285, x=1679.049, y=2513.711, z=45.565},
    {name="Impound Lot", sprite=68, x=401.05154418945, y=-1631.6422119141, z=29.291933059692},
    {name="Impound Lot", sprite=68, x=1727.1442871094, y=3710.8161621094, z=34.258625030518},
    {name="LS Courthouse", sprite=419, x=235.60780334473, y=-411.32336425781, z=48.111949920654},
}

local InstructionalButtons = nil
local unixtime = 0
local activeCops = 0
local activeMedics = 0

function GetMinimapAnchor()
    -- Safezone goes from 1.0 (no gap) to 0.9 (5% gap (1/20))
    -- 0.05 * ((safezone - 0.9) * 10)
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

function DrawHUDBar(max, value, x, y, width, height, primary_colour, secondary_colour, background, background_colour, type)
    if background then
        if type == 1 then
            DrawRect(x + (width/2), y + 0.000025, width, height + 0.007705, background_colour.r or 15, background_colour.g or 26, background_colour.b or 32, background_colour.a or 200)
        elseif type == 2 then
            DrawRect(x + (width/2) + 0.00075, y + 0.000025, width + 0.0015, height + 0.007705, background_colour.r or 15, background_colour.g or 26, background_colour.b or 32, background_colour.a or 200)
        elseif type == 3 then
            DrawRect(x + (width/2) - 0.00075, y + 0.000025, width + 0.0015, height + 0.007705, background_colour.r or 15, background_colour.g or 26, background_colour.b or 32, background_colour.a or 200)
        else
            DrawRect(x + (width/2), y - 0.00005, width + 0.002, height + 0.007705, background_colour.r or 15, background_colour.g or 26, background_colour.b or 32, background_colour.a or 150)
        end
    end
    DrawRect(x + (width/2), y, width, height, primary_colour.r or 42, secondary_colour.g or 85, secondary_colour.b or 50, secondary_colour.a or 75)
    DrawRect(x + ((value/(max/width))/2), y, value/(max/width), height, primary_colour.r or 74, primary_colour.g or 147, primary_colour.b or 78, primary_colour.a or 255)
end

function drawMarker(_type, _x, _y, _z, _scale_x, _scale_y, _scale_z, _r, _g, _b, _a)
    DrawMarker(_type, _x, _y, _z-0.9, 0, 0, 0, 0, 0, 0, _scale_x, _scale_y, _scale_z, _r, _g, _b, _a, 0, 0, 2, 0, 0, 0, 0)
end

function addBlip(item)
    item.blip = AddBlipForCoord(item.x, item.y, item.z)
    SetBlipSprite(item.blip, item.sprite)
    SetBlipColour(item.blip, item.colour)
    SetBlipAsShortRange(item.blip, true)
    SetBlipScale(item.blip, 0.6)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(item.name)
    EndTextCommandSetBlipName(item.blip)
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function showLoadingPrompt(showText, showType)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0xaba17d7ce615adbf("STRING") -- set type
        AddTextComponentString(showText) -- sets the text
        N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
    end)
end

function stopLoadingPrompt()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0x10d373323e5b9c0d()
    end)
end

function DrawMissionText(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
end

function drawText(text, font, x , y, scale, r, g, b, a, shadow, outline)
    SetTextColour(r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    if shadow then
        SetTextDropShadow(2, 2, 0, 0, 0)
    end    
    if outline then
        SetTextOutline()
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x,y)
end

function Draw3DText(x,y,z, text, _size) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        local size = _size or 0.3
        SetTextScale(0.0*scale, size*scale)
        SetTextFont(6)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
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

Citizen.CreateThread(function()
    for _, item in pairs(extrablips) do
        addBlip(item)
    end
    while true do
        Citizen.Wait(0)
        if not IsEntityDead(GetPlayerPed(-1)) then
            if garage_menu then
                trucking_menu = false
                Menu.DisplayCurMenu()
            elseif trucking_menu then
                garage_menu = false
                Menu.DisplayCurMenu()
            end
        else
            garage_menu = false
            trucking_menu = false
        end
    end
end)

function SetInstructionalButtons(buttons, layout) --Layout: 0 - Horizontal, 1 - vertical
    Citizen.CreateThread(function()
        if not HasScaleformMovieLoaded(InstructionalButtons) then
            InstructionalButtons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
            while not HasScaleformMovieLoaded(InstructionalButtons) do
                Citizen.Wait(0)
            end
        end
        local sf = InstructionalButtons
        local w,h = GetScreenResolution()
        PushScaleformMovieFunction(sf,"INSTRUCTIONAL_BUTTONS")
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
        PushScaleformMovieFunctionParameterInt(w)
        PushScaleformMovieFunctionParameterInt(h)
        PushScaleformMovieFunctionParameterFloat(0.02)
        PushScaleformMovieFunctionParameterFloat(0.98)
        PushScaleformMovieFunctionParameterFloat(0.02)
        PushScaleformMovieFunctionParameterFloat(0.98)
        PushScaleformMovieFunctionParameterBool(true)
        PushScaleformMovieFunctionParameterBool(false)
        PushScaleformMovieFunctionParameterBool(false)
        PushScaleformMovieFunctionParameterInt(w)
        PushScaleformMovieFunctionParameterInt(h)
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
        PushScaleformMovieFunctionParameterInt(1)
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"CLEAR_ALL")
        PopScaleformMovieFunction()
        for i,btn in pairs(buttons) do
            PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
            PushScaleformMovieFunctionParameterInt(i-1)
            PushScaleformMovieFunctionParameterString(btn[1])
            PushScaleformMovieFunctionParameterString(btn[2])
            PopScaleformMovieFunction()
            
        end
        if layout ~= 1 then
            PushScaleformMovieFunction(sf,"SET_PADDING")
            PushScaleformMovieFunctionParameterInt(10)
            PopScaleformMovieFunction()
        end
        PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
        PushScaleformMovieFunctionParameterInt(layout)
        PopScaleformMovieFunction()
    end)
end

function DrawInstructionalButtons()
    if HasScaleformMovieLoaded(InstructionalButtons) then
        DrawScaleformMovie(InstructionalButtons, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
    end
end

function GetCurrentServerTime()
    return unixtime
end

function GetCurrentClientTime()
    local function YearInSec(y)
      -- returns seconds of a year
      if ((y % 400) == 0) or (((y % 4) == 0) and ((y % 100) ~= 0)) then
        return 31622400 -- 366 * 24 * 60 * 60
      else
        return 31536000 -- 365 * 24 * 60 * 60
      end
    end

    local function IsLeapYear(y)
      -- returns true of false
      return ((y % 400) == 0) or (((y % 4) == 0) and ((y % 100) ~= 0))
    end

    local function unixtime(date)
      -- date = "2013-01-13 15:45:13"
      local days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
      local daysec = 86400
      local y,m,d,h,mi,s = date:match("(%d+)-(%d+)-(%d+)%s+(%d+):(%d+):(%d+)") 
      local time = 0
      
      -- sum years
      for n = 1970,(y - 1) do 
        time = time + YearInSec(n)
      end
      
      -- sum month
      for n = 1,(m - 1) do
        time = time + (days[n] * daysec)
      end
      
      -- add days
      time = time + (d - 1) * daysec
      
      -- if current year is leap year and february is in the past  
      -- it seems that m + 0 is much faster than tonumber(m) 
      -- this currently works with 5.1, 5.2 and 5.3 but in future lua versions this can be removed
      if IsLeapYear(y) and (m + 0 > 2) then
        time = time + daysec
      end
      
      -- add hour, minute and seconds
      return time + (h * 3600) + (mi * 60) + s 
        
    end
    local years, months, days, hours, minutes, seconds = Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
    return unixtime(years.."-"..months.."-"..days.." "..hours..":"..minutes..":"..seconds)--]]
end

function GetTimeRemaining(time1, time2, _type)
    if _type ~= "long" and _type ~= "short" then return "invalid type" end
    local difference = time2 - time1
    if difference < 0 then return "Now!" end
    local years, months, weeks, days, hours, minutes, seconds = 0, 0, 0, 0, 0, 0, 0

    seconds = math.floor(difference % 60)
    difference = difference / 60
    minutes = math.floor(difference % 60)
    difference = difference / 60
    hours = math.floor(difference % 24)
    difference = difference / 24
    days = math.floor(difference % 365)
    difference = difference / 7
    --[[weeks = math.floor(difference)
    difference = difference / 4.28
    months = math.floor(difference)
    difference = difference / 12
    years = math.floor(difference)]]

    local result = ""

    if years > 1 then
        if _type == "long" then
            result = result .. years .. "years, "
        elseif _type == "short" then
            result = result .. years .. "yrs, "
        end
    elseif years == 1 then
        if _type == "long" then
            result = result .. years .. "year, "
        elseif _type == "short" then
            result = result .. years .. "yr, "
        end
    end

    if months > 1 then
        if _type == "long" then
            result = result .. months .. "months, "
        elseif _type == "short" then
            result = result .. months .. "mo, "
        end
    elseif months == 1 then
        if _type == "long" then
            result = result .. months .. "month, "
        elseif _type == "short" then
            result = result .. months .. "mo, "
        end
    end

    if weeks > 1 then
        if _type == "long" then
            result = result .. weeks .. "weeks, "
        elseif _type == "short" then
            result = result .. weeks .. "wks, "
        end
    elseif weeks == 1 then
        if _type == "long" then
            result = result .. weeks .. "week, "
        elseif _type == "short" then
            result = result .. weeks .. "wk, "
        end
    end

    if days > 1 then
        if _type == "long" then
            result = result .. days .. "days, "
        elseif _type == "short" then
            result = result .. days .. "d, "
        end
    elseif days == 1 then
        if _type == "long" then
            result = result .. days .. "day, "
        elseif _type == "short" then
            result = result .. days .. "d, "
        end
    end

    if hours > 1 then
        if _type == "long" then
            result = result .. hours .. "hours, "
        elseif _type == "short" then
            result = result .. hours .. "hrs, "
        end
    elseif hours == 1 then
        if _type == "long" then
            result = result .. hours .. "hour, "
        elseif _type == "short" then
            result = result .. hours .. "hr, "
        end
    end

    if minutes > 1 then
        if _type == "long" then
            result = result .. minutes .. "minutes "
        elseif _type == "short" then
            result = result .. minutes .. "mins "
        end
    elseif minutes == 1 then
        if _type == "long" then
            result = result .. minutes .. "minute "
        elseif _type == "short" then
            result = result .. minutes .. "min "
        end
    end

    if seconds >= 0 then
        if _type == "long" then
            result = result .. "& " .. seconds .. "and seconds"
        elseif _type == "short" then
            result = result .. "& " .. seconds .. "secs"
        end
    end

    return result
end

function teleportPlayer(coords)
    WarMenu.CloseMenu()
    Citizen.CreateThread(function()
        DoScreenFadeOut(1000)
        while IsScreenFadingOut() do Citizen.Wait(0) end
        NetworkFadeOutEntity(PlayerPedId(), true, false)
        Citizen.Wait(1000)
        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
        SetEntityHeading(PlayerPedId(), coords.h or 90.0)
        NetworkFadeInEntity(PlayerPedId(), 0)
        Citizen.Wait(1000)
        SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
        DoScreenFadeIn(1000)
        while IsScreenFadingIn() do Citizen.Wait(0) end
    end)
end

function getPercentage()
    return GetRandomIntInRange(1, 101)
end

function getCops()
    return activeCops
end

function getParamedics()
    return activeMedics
end

function IsPedAnAnimal(_model)
    local found = false

    for i = 1, #animals do
        if animals[i] == _model then
            found = true
            break
        end
    end

    return found
end

function FindNearbyPlayers(distance)
    local results = {}
    for i = -1, 255 do
        if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= nil then
            local targetPed = GetPlayerPed(i)
            if GetDistanceBetweenCoords(GetEntityCoords(targetPed),GetEntityCoords(PlayerPedId())) < distance then
                if PlayerPedId() ~= GetPlayerPed(i) then
                    table.insert(results, {ped_id = targetPed, player_id = i, server_id = GetPlayerServerId(i)})
                end
            end
        end
    end
    return results
end

function RequestAndDelete(entity, detach)
    if DoesEntityExist(entity) then
        NetworkRequestControlOfEntity(entity)
        while not NetworkHasControlOfEntity(entity) do
            Citizen.Wait(1)
        end
        if detach then
            DetachEntity(entity, 0, false)
        end
        SetEntityCollision(entity, false, false)
        SetEntityAlpha(entity, 0.0, true)
        SetEntityAsMissionEntity(entity, false, true)
        SetEntityAsNoLongerNeeded(entity)
        if IsEntityAVehicle(entity) then
            DeleteVehicle(entity)
        elseif IsEntityAPed(entity) then
            DeletePed(entity)
        elseif IsEntityAnObject(entity) then
            DeleteEntity(entity)
        else
            DeleteEntity(entity)
        end
        print("Entity Deleted!")
    end
end

function DestroyCar(_vehicle)
    if DoesEntityExist(_vehicle) then
        for seat = -1, GetVehicleMaxNumberOfPassengers(_vehicle) do
            if not IsVehicleSeatFree(_vehicle, seat) then
                TaskLeaveVehicle(GetPedInVehicleSeat(_vehicle, seat), _vehicle, 0)
            end
        end

        Citizen.Wait(5000)
        NetworkRequestControlOfEntity(_vehicle)
        while not NetworkHasControlOfEntity(_vehicle) do
            Citizen.Wait(0)
        end
        SetEntityAsMissionEntity(_vehicle, false, true)
        DeleteVehicle(_vehicle)
        SetEntityAsNoLongerNeeded(_vehicle)
        if DoesEntityExist(_vehicle) then
            local _vehiclepos = GetEntityCoords(_vehicle, false)
            SetEntityCoords(_vehicle, _vehiclepos.x, _vehiclepos.y, _vehicle.z-20.0)
        end
    end
end

function GetSeat(_vehicle, _ped)
    for i = -1, GetVehicleMaxNumberOfPassengers(_vehicle) do
        if GetPedInVehicleSeat(_vehicle, i) == _ped then
            return i
        end
    end
    return nil
end

function GetNearestVehicle(ped, currentvehicle, distance)
    local distance = distance or 2.5
    local nearest_vehicle = {["vehicle"] =nil, ["position"] = nil}
    local nearest_vehicles = {}
    local player_position = GetEntityCoords(ped, false)
    if currentvehicle then
        if IsPedSittingInAnyVehicle(ped) then
            return GetVehiclePedIsIn(ped, false)
        else
            for vehicle in EnumerateVehicles() do
                local vehicle_position = GetEntityCoords(vehicle, false)
                if GetDistanceBetweenCoords(player_position.x, player_position.y, player_position.z, vehicle_position.x, vehicle_position.y, vehicle_position.z, true) < distance then
                    table.insert(nearest_vehicles, {["vehicle"] = vehicle, ["position"] = vehicle_position})
                end
            end

            for i = 1, #nearest_vehicles do
                if nearest_vehicles[i] then
                    if i == 1 then
                        nearest_vehicle = nearest_vehicles[i]
                    else
                        if GetDistanceBetweenCoords(player_position.x, player_position.y, player_position.z, nearest_vehicle.position.x, nearest_vehicle.position.y, nearest_vehicle.position.z, true) > GetDistanceBetweenCoords(player_position.x, player_position.y, player_position.z, nearest_vehicles[i].position.x, nearest_vehicles[i].position.y, nearest_vehicles[i].position.z, true) then
                            nearest_vehicle = nearest_vehicles[i]
                        end
                    end
                end
            end

            return nearest_vehicle.vehicle
        end
    else
        for vehicle in EnumerateVehicles() do
            local vehicle_position = GetEntityCoords(vehicle, false)
            if GetDistanceBetweenCoords(player_position.x, player_position.y, player_position.z, vehicle_position.x, vehicle_position.y, vehicle_position.z, true) < distance then
                table.insert(nearest_vehicles, {["vehicle"] = vehicle, ["position"] = vehicle_position})
            end
        end

        for i = 1, #nearest_vehicles do
            if nearest_vehicles[i] then
                if i == 1 then
                    nearest_vehicle = nearest_vehicles[i]
                else
                    if GetDistanceBetweenCoords(player_position.x, player_position.y, player_position.z, nearest_vehicle.position.x, nearest_vehicle.position.y, nearest_vehicle.position.z, true) > GetDistanceBetweenCoords(player_position.x, player_position.y, player_position.z, nearest_vehicles[i].position.x, nearest_vehicles[i].position.y, nearest_vehicles[i].position.z, true) then
                        nearest_vehicle = nearest_vehicles[i]
                    end
                end
            end
        end

        return nearest_vehicle.vehicle
    end
end

function IsVehicleOwned(_plate)
    local owned = false
    for k,v in pairs(user_vehicles) do
        if v.plate == _plate then
            owned = true
            break
        end
    end
    return owned
end

function CreateUniquePlate(vehicle)
    local vehicle_name = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    local vehicle_plate = string.gsub(GetVehicleNumberPlateText(vehicle), "%s*", "")
    local vehicle_class = GetLabelText("VEH_CLASS_" .. GetVehicleClassFromName(vehicle_name))
    return string.upper(vehicle_name.."_"..vehicle_plate.."_"..vehicle_class)
end

function SetWeather(WeatherType)
    ClearWeatherTypePersist()
    SetWeatherTypeNowPersist(WeatherType)
    SetWeatherTypeNow(WeatherType)
    SetWeatherTypePersist(WeatherType)
    if WeatherType == "XMAS" then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
    else
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
    end
end

function DestroyPed(Handle)
    Citizen.CreateThread(function()
        local Handle = Handle
        local Start = GetGameTimer()

        NetworkRequestControlOfEntity(Handle)

        while not NetworkHasControlOfEntity(Handle) and Start + 5000 > GetGameTimer() do
            Citizen.Wait(0)
        end

        DeletePed(Handle)
        SetEntityAsNoLongerNeeded(Handle)

        if DoesEntityExist(Handle) then
            SetEntityCoords(Handle, 601.28948974609, -4396.9853515625, 384.98565673828)
        end
    end)
end

RegisterNetEvent("core:synctime")
AddEventHandler("core:synctime", function(_time)
    unixtime = _time
end)

RegisterNetEvent('police:updateactiveCops')
AddEventHandler('police:updateactiveCops',function(activeCount)
    activeCops = activeCount
end)

RegisterNetEvent('paramedic:updateactiveMedics')
AddEventHandler('paramedic:updateactiveMedics',function(activeCount)
    activeMedics = activeCount
end)

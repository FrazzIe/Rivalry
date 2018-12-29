--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
hud_off = false
local wallet, dirty, bank = 0, 0, 0
local job = "Unemployed"
local voice = "~b~Normal"
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
local directions = { [0] = 'N', [45] = 'NE', [90] = 'E', [135] = 'SE', [180] = 'S', [225] = 'SW', [270] = 'W', [315] = 'NW', [360] = 'N'} 
local police_information, paramedic_information, taxi_information, mechanic_information = "~b~Police~w~: Open menu to update call information", "~r~Paramedic~w~: Open menu to update call information", "~y~Taxi~w~: Open menu to update call information", "~c~Mechanic~w~: Open menu to update call information"
local cops_callstatus, cops_active, cops_available = 0, 0, 0
local paramedics_callstatus, paramedics_active, paramedics_available = 0, 0, 0
local taxi_callstatus, taxi_active, taxi_available = 0, 0, 0
local mechanic_callstatus, mechanic_active, mechanic_available = 0, 0, 0
local ServiceTracker = {false, false, false, false}
local Location = {Area = "", Street = "", Crossing = "", Direction = ""}

function TurnOffHudElements(value)
    if value then
        hud_off = true
    else
        hud_off = false
    end
end

function HudElementsDisabled()
    return hud_off
end

function degreesToIntercardinalDirection(dgr)
    dgr = dgr % 360.0
    
    if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
        return "N"
    elseif dgr >= 22.5 and dgr < 67.5 then
        return "NW"
    elseif dgr >= 67.5 and dgr < 112.5 then
        return "W"
    elseif dgr >= 112.5 and dgr < 157.5 then
        return "SW"
    elseif dgr >= 157.5 and dgr < 202.5 then
        return "S"
    elseif dgr >= 202.5 and dgr < 247.5 then
        return "SE"
    elseif dgr >= 247.5 and dgr < 292.5 then
        return "E"
    elseif dgr >= 292.5 and dgr < 337.5 then
        return "NE"
    end
end

function GetLocation(PlayerPosition)
    local Street, Crossing = GetStreetNameAtCoord(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
    local Area = GetNameOfZone(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
    
    return GetLabelText(Area), GetStreetNameFromHashKey(Street), GetStreetNameFromHashKey(Crossing)
end

AddEventHandler('onClientMapStart', function()
    NetworkSetTalkerProximity(15.0)
end)

AddEventHandler("interaction:voice_change",function(_type)
    if _type == 1 then
        NetworkSetTalkerProximity(2.0)
        voice = "~y~Whisper"
    elseif _type == 2 then
        NetworkSetTalkerProximity(15.0)
        voice = "~b~Normal"
    elseif _type == 3 then
        NetworkSetTalkerProximity(35.0)
        voice = "~r~Shout"
    end
end)

AddEventHandler("interaction:hud", function()
    exports.ui:open()
    Citizen.CreateThread(function()
        hud_off = not hud_off
        TriggerEvent("chat:disable", hud_off)
        TriggerEvent("toggle:watermark")
        TriggerEvent("toggle:timeandweather")
        TriggerEvent("toggle:seatbelt")
        while hud_off do
            Citizen.Wait(0)
            HideHudAndRadarThisFrame()
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        local PlayerPed = PlayerPedId()
        local PlayerPosition = GetEntityCoords(PlayerPed, false)
        local PlayerHeading = GetEntityHeading(PlayerPed)

        Location.Area, Location.Street, Location.Crossing = GetLocation(PlayerPosition)
        Location.Direction = degreesToIntercardinalDirection(PlayerHeading - 360)

        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if WarMenu.IsMenuOpened("Scoreboard") or WarMenu.IsMenuOpened("player_info") or WarMenu.IsMenuOpened("player_info_disconnected") or WarMenu.IsMenuOpened("disconnected") then
            if exports.policejob and exports.emsjob and exports.others and exports.jobs then
                if exports.policejob.getIsInService and exports.emsjob.getIsInService and exports.others.getIsInService and exports.jobs.getMechanicIsInService then
                    ServiceTracker = {
                        exports.policejob:getIsInService(),
                        exports.emsjob:getIsInService(),
                        exports.others:getIsInService(),
                        exports.jobs:getMechanicIsInService(),
                    }
                end
            end
            
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    local minimap = GetMinimapAnchor()
    while true do
        Citizen.Wait(0)
        if WarMenu.IsMenuOpened("Scoreboard") or WarMenu.IsMenuOpened("player_info") or WarMenu.IsMenuOpened("player_info_disconnected") or WarMenu.IsMenuOpened("disconnected") then
            drawText(job, 6, 0.16, 0.895, 0.50, 255, 255, 255, 255, false, true)

            drawText("~g~Status of calls", 6, 0.3, 0.795, 0.50, 255, 255, 255, 255, false, true)

            if cops_callstatus == 0 then
                drawText("~b~LSPD~w~: You currently don't have a call", 6, 0.3, 0.82, 0.50, 255, 255, 255, 255, false, true)
            elseif cops_callstatus == 1 then
                drawText("~b~LSPD~w~: ~g~A unit will arrive at the location of the call", 6, 0.3, 0.82, 0.50, 255, 255, 255, 255, false, true)
            else
                if cops_active == 0 then
                    drawText("~b~LSPD~w~: ~r~No officers are active", 6, 0.3, 0.82, 0.50, 255, 255, 255, 255, false, true)
                elseif cops_available == 0 then
                    drawText("~b~LSPD~w~: ~o~All our units are occupied", 6, 0.3, 0.82, 0.50, 255, 255, 255, 255, false, true)
                else
                    drawText("~b~LSPD~w~: Your call is on hold", 6, 0.3, 0.82, 0.50, 255, 255, 255, 255, false, true)
                end
            end

            if paramedics_callstatus == 0 then
                drawText("~r~LSFD~w~: You currently don't have a call", 6, 0.3, 0.845, 0.50, 255, 255, 255, 255, false, true)
            elseif paramedics_callstatus == 1 then
                drawText("~r~LSFD~w~: ~g~A unit will arrive at the location of the call", 6, 0.3, 0.845, 0.50, 255, 255, 255, 255, false, true)
            else
                if paramedics_active == 0 then
                    drawText("~r~LSFD~w~: ~r~No paramedics are active", 6, 0.3, 0.845, 0.50, 255, 255, 255, 255, false, true)
                elseif paramedics_available == 0 then
                    drawText("~r~LSFD~w~: ~o~All our ambulances are occupied", 6, 0.3, 0.845, 0.50, 255, 255, 255, 255, false, true)
                else
                    drawText("~r~LSFD~w~: Your call is on hold", 6, 0.3, 0.845, 0.50, 255, 255, 255, 255, false, true)
                end
            end

            if taxi_callstatus == 0 then
                drawText("~y~TAXI~w~: You currently don't have a call", 6, 0.3, 0.87, 0.50, 255, 255, 255, 255, false, true)
            elseif taxi_callstatus == 1 then
                drawText("~y~TAXI~w~: ~g~A taxi will arrive at the location of the call", 6, 0.3, 0.87, 0.50, 255, 255, 255, 255, false, true)
            else
                if taxi_active == 0 then
                    drawText("~y~TAXI~w~: ~r~No taxis are active", 6, 0.3, 0.87, 0.50, 255, 255, 255, 255, false, true)
                elseif taxi_available == 0 then
                    drawText("~y~TAXI~w~: ~o~All our taxis are occupied", 6, 0.3, 0.87, 0.50, 255, 255, 255, 255, false, true)
                else
                    drawText("~y~TAXI~w~: Your call is on hold", 6, 0.3, 0.87, 0.50, 255, 255, 255, 255, false, true)
                end
            end

            if mechanic_callstatus == 0 then
                drawText("~c~MECHANIC~w~: You currently don't have a call", 6, 0.3, 0.895, 0.50, 255, 255, 255, 255, false, true)
            elseif mechanic_callstatus == 1 then
                drawText("~c~MECHANIC~w~: ~g~A mechanic will arrive at the location of the call", 6, 0.3, 0.895, 0.50, 255, 255, 255, 255, false, true)
            else
                if mechanic_active == 0 then
                    drawText("~c~MECHANIC~w~: ~r~No mechanics are active", 6, 0.3, 0.895, 0.50, 255, 255, 255, 255, false, true)
                elseif mechanic_available == 0 then
                    drawText("~c~MECHANIC~w~: ~o~All our mechanics are occupied", 6, 0.3, 0.895, 0.50, 255, 255, 255, 255, false, true)
                else
                    drawText("~c~MECHANIC~w~: Your call is on hold", 6, 0.3, 0.895, 0.50, 255, 255, 255, 255, false, true)
                end
            end

            if ServiceTracker[1] then
                drawText(police_information, 6, 0.6, 0.82, 0.50, 255, 255, 255, 255, false, true)
            end
            if ServiceTracker[2] then
                drawText(paramedic_information, 6, 0.6, 0.845, 0.50, 255, 255, 255, 255, false, true)
            end
            if ServiceTracker[3] then
                drawText(taxi_information, 6, 0.6, 0.87, 0.50, 255, 255, 255, 255, false, true)
            end
            if ServiceTracker[4] then
                drawText(mechanic_information, 6, 0.6, 0.895, 0.50, 255, 255, 255, 255, false, true)
            end
        end

        if not hud_off then
            local PlayerPed = PlayerPedId()

            if NetworkIsPlayerTalking(PlayerId()) then
                drawText("~o~>>"..voice, 6, 0.16, 0.92, 0.50, 255, 255, 255, 255, false, true)
            else
                drawText(voice, 6, 0.16, 0.92, 0.50, 255, 255, 255, 255, false, true)
            end

            if IsPedSittingInAnyVehicle(PlayerPed) then
                local vehicle = GetVehiclePedIsIn(PlayerPed, false)
                if GetPedInVehicleSeat(vehicle, -1) == PlayerPed or GetPedInVehicleSeat(vehicle, 0) == PlayerPed then
                    drawText("~y~"..GetVehicleNumberPlateText(vehicle), 6, 0.889, 0.85, 0.5, 255, 255, 255, 255, false, true)
                    DisplayRadar(true)
                end
            else
                DisplayRadar(false)
            end


            if Location.Crossing ~= "" and Location.Crossing ~= nil then
                drawText("Crossing ~y~" .. Location.Crossing .. "~w~", 6, 0.18, 0.965, 0.4, 255, 255, 255, 255, false, true)
            end

            if Location.Street ~= "" and Location.Area ~= "" then
                drawText("~b~" .. Location.Street .. " ~w~in ~y~" .. Location.Area, 6, 0.18, 0.945, 0.4, 255, 255, 255, 255, false, true)
            end

            if #Location.Direction == 1 then
                drawText(Location.Direction, 6, 0.16, 0.94, 0.9, 255, 255, 255, 255, false, true)
            elseif #Location.Direction == 2 then
                drawText(string.sub(Location.Direction, 1, 1), 6, 0.16, 0.94, 0.9, 255, 255, 255, 255, false, true)
                drawText(string.sub(Location.Direction, 2), 6, 0.17, 0.95, 0.5, 255, 255, 255, 255, false, true)
            end
           
        end
    end
end)

--[[ Call HUDs - Police ]]--
AddEventHandler("police:updateInformation", function(_info)
    police_information = _info
end)

RegisterNetEvent('police:callStatus')
AddEventHandler('police:callStatus',function(status)
    cops_callstatus = status
end)

RegisterNetEvent('police:updateactiveCops')
AddEventHandler('police:updateactiveCops',function(activeCount, availableCount)
    cops_active = activeCount
    cops_available = availableCount
end)
--[[ Call HUDs - Paramedic ]]--
AddEventHandler("paramedic:updateInformation", function(_info)
    paramedic_information = _info
end)

RegisterNetEvent('paramedic:callStatus')
AddEventHandler('paramedic:callStatus',function(status)
    paramedics_callstatus = status
end)

RegisterNetEvent('paramedic:updateactiveMedics')
AddEventHandler('paramedic:updateactiveMedics',function(activeCount, availableCount)
    paramedics_active = activeCount
    paramedics_available = availableCount
end)
--[[ Call HUDs - Taxi ]]--
AddEventHandler("taxi:updateInformation", function(_info)
    taxi_information = _info
end)

RegisterNetEvent('taxi:callStatus')
AddEventHandler('taxi:callStatus',function(status)
    taxi_callstatus = status
end)

RegisterNetEvent('taxi:personnelChange')
AddEventHandler('taxi:personnelChange',function(activeCount, availableCount)
    taxi_active = activeCount
    taxi_available = availableCount
end)
--[[ Call HUDs - Mechanic ]]--
AddEventHandler("mechanic:updateInformation", function(_info)
    mechanic_information = _info
end)

RegisterNetEvent('mechanic:callStatus')
AddEventHandler('mechanic:callStatus',function(status)
    mechanic_callstatus = status
end)

RegisterNetEvent('mechanic:personnelChange')
AddEventHandler('mechanic:personnelChange',function(activeCount, availableCount)
    mechanic_active = activeCount
    mechanic_available = availableCount
end)
--[[ Job HUD ]]--
RegisterNetEvent('jobcenter:updateJob')
AddEventHandler('jobcenter:updateJob', function(job_name)
    if job_name == "Police" then
        job = "~b~Police ~w~[ ~y~"..string.gsub(exports.policejob:getPoliceRank() or "", "%f[%a].", string.upper).." ~w~]"
    elseif job_name == "Emergency" then
        job = "~g~Paramedic ~w~[ ~y~"..string.gsub(exports.emsjob:getParamedicRank() or "", "%f[%a].", string.upper).." ~w~]"
    elseif job_name == "DOJ" then
        job = "~c~DOJ ~w~[ ~y~"..string.gsub(DOJ.Rank or "", "%f[%a].", string.upper).." ~w~]"
    else
        job = "~w~"..job_name
    end
end)

--[[ Money HUD ]]--
RegisterNetEvent("core:updateMoney")
AddEventHandler("core:updateMoney", function(value, _moneytype, _type, _change)
    local message = ""
    local ypos = 0.16
    if _moneytype == "wallet" then
        wallet = value
        if _type == "add" then
            message = message .. "~g~+"
        elseif _type == "remove" then
            message = message .. "~r~-"
        elseif _type == "set" then
            message = message .. "~y~set to "
        end
        message = message .. "~g~$~w~" .. _change
        ypos = 0.82
    elseif _moneytype == "dirty" then
        dirty = value
        if _type == "add" then
            message = message .. "~g~+"
        elseif _type == "remove" then
            message = message .. "~r~-"
        elseif _type == "set" then
            message = message .. "~y~set to "
        end
        message = message .. "~r~$~w~" .. _change
        ypos = 0.845
    elseif _moneytype == "bank" then
        bank = value
        if _type == "add" then
            message = message .. "~g~+"
        elseif _type == "remove" then
            message = message .. "~r~-"
        elseif _type == "set" then
            message = message .. "~y~set to "
        end
        message = message .. "~b~$~w~" .. _change
        ypos = 0.87
    end
    Citizen.CreateThread(function()
        local endtime = GetGameTimer()+5000
        while GetGameTimer() < endtime do
            Citizen.Wait(0)
            drawText(message, 6, 0.23, ypos, 0.50, 255, 255, 255, 255, false, true)
        end
    end)
end)

--[[ Help ]]--
RegisterNetEvent("interaction:help")
AddEventHandler("interaction:help", function()
    Citizen.CreateThread(function()
        local help = true
        SetInstructionalButtons({{GetControlInstructionalButton(1, 51, 0), "Close"}}, 1)
        while help do
            Citizen.Wait(0)
            DrawInstructionalButtons()
            if IsControlJustPressed(1, 51) then
                help = false
            end
            local controls = {
                "~b~Basic Controls",
                "~w~Toggle lock: ~y~L",
                "~w~Toggle seatbelt: ~y~B",
                "~w~Set cruise control: ~y~M",
                "~w~Toggle engine: ~y~Scroll up",
                "~w~Indicators: ~y~left/right arrow", 
                "~w~Windows: ~y~up/down arrow",
                "~w~Change stance: ~y~L-Ctrl",
                "~w~Switch character: ~y~F5",
                "~w~Open Phone: ~y~F2",
                "~w~Toggle VOIP: ~y~F3",
                "~w~Hands Up: ~y~X",
                "~b~Interaction menu controls",
                "~w~Open: ~y~K or LALT",
                "~w~Close: ~y~Esc", 
                "~w~Back: ~y~Backspace / Right click",
                "~w~Select: ~y~Enter / Left click",
                "~w~Navigate: ~y~Arrow keys / Mouse",
                "~w~Toggle mouse: ~y~Mouse 3",
            }
            local info = {
                "~b~Basic Information",
                "~w~You cannot drive a car without its key",
                "~w~Ammo is tracked, once you shoot a bullet it is gone",
                "~w~Maximum of 3 weapons on your person at all times",
                "~w~Low hunger/thirst will kill you",
                "~w~100 slots is the inventory limit per person and per vehicle",
                "~w~The switch character range is 75 meters, if someone comes close it will cancel",
                "~w~Models are saved automatically",
                "~w~Progress saves every 15 minutes and when you leave",
                "~w~You must purchase a weapons license from an LSPD Officer",
                "~w~Your phone can be stolen/destroyed and you will have to buy a new one from the store",
                "~w~Phone stuck on screen? Press F8 and type frozen and re-open the phone",
                "~w~/e will bring up a menu where you can do an emote or change your walk style",
                "~w~You can do /roll to roll a die, or /draw to draw a random playing card",
            }

            local add_y_c = 0.0
            for k,v in pairs(controls) do
                drawText(controls[k], 6, 0.25, 0.25 + add_y_c, 0.50, 255, 255, 255, 255, false, true)
                add_y_c = add_y_c + 0.03
            end

            local add_y_i = 0.0
            for k,v in pairs(info) do
                drawText(info[k], 6, 0.45, 0.25 + add_y_i, 0.50, 255, 255, 255, 255, false, true)
                add_y_i = add_y_i + 0.03
            end
        end
    end)
end)
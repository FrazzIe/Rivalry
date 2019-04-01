local myVehiculeEntity = nil
local inService = false
local spawnVehicleChoix = {}
local VehicleModelKeyTaxi = GetHashKey('taxi')
local KEY_E = 38
local KEY_UP = 96 -- N+
local KEY_DOWN = 97 -- N-
local KEY_CLOSE = 177
local currentBlip = nil 
local listMissions = {}
local currentMissions = nil
local myCallMission = nil 
local taxi_nbMissionEnAttenteText = '-- Aucune Info --'
local taxi_Bliptaxi = {}
local taxi_call_accept = 0
local taxi_nbtaxiInService = 0
local taxi_nbtaxiDispo = 0
local missionXCoord = 0
local missionYCoord = 0
local missionZCoord = 0
local previousMissionX = 0
local previousMissionY = 0
local previousMissionZ = 0
local drivers_license = false
local MissionCaller = nil

isTaxi = false

local TEXT = {
    PrendreService = '~INPUT_PICKUP~ Start taxi service',
    QuitterService = '~INPUT_PICKUP~  Stop taxi service',
    SpawnVehicle = '~INPUT_PICKUP~ Recover your ~b~ service vehicle(~b~$500)',
    SpawnVehicleImpossible = '~R~  Cannot spawn service vehicle',
   
    Blip = 'Course in progress',
    BlipGarage = "Taxi",
    MissionCancel = 'Your client canceled the call',
    MissionClientAccept = 'A taxi took your call',
    MissionClientCancel = 'Your taxi dropped you',
    InfotaxiNoAppel = '~g~No calls waiting',
    InfotaxiNbAppel = '~w~ Call(s) waiting',
    BliptaxiService = 'Taking service',
    BliptaxiVehicle = 'Taking service vehicle',

    CALL_INFO_NO_PERSONNEL = '~r~No taxi drivers on duty',
    CALL_INFO_ALL_BUSY = '~o~All taxi drivers are busy',
    CALL_INFO_WAIT = '~b~Your call is on hold',
    CALL_INFO_OK = '~g~A taxi will arrive soon. Stay where you are.',

    CALL_RECU = 'Confirmation \nYour call has been registered',
    CALL_ACCEPT = 'Your call has been accepted, a taxi is on the way',
    CALL_CANCEL = 'The taxi driver just dropped your call',
    CALL_FINI = 'Your call has been resolved',
    CALL_EN_COURS = 'You already have a request ...',

    MISSION_NEW = 'A new customer needs a ride!',
    MISSION_ACCEPT = 'Call accepted',
    MISSION_ANNULE = 'Your customer has canceled',
    MISSION_CONCURENCE = 'Multiple cabs have taken the call',
    MISSION_INCONNU = 'This call is no longer active',
    MISSION_EN_COURS = 'There is already another taxi on the way'
    
}
-- restart depanneur
local coords = {
    {
        ['PriseDeService'] = {x = 895.18, y = -179.19, z = 74.70},
        ['SpawnVehicleAction'] = { x = 900.08, y = -171.57, z = 74.07},
        ['SpawnVehicle'] = {
            {x = 920.15, y = -163.88, z = 74.40, h = 281.23, type = VehicleModelKeyTaxi},
            {x = 913.68, y = -159.34, z = 74.42, h = 13.135, type = VehicleModelKeyTaxi},
            {x = 911.46, y = -163.10, z = 73.99, h = 14.988, type = VehicleModelKeyTaxi},
            {x = 918.00, y = -167.15, z = 74.19, h = 280.71, type = VehicleModelKeyTaxi},
            {x = 916.37, y = -170.75, z = 74.04, h = 281.02, type = VehicleModelKeyTaxi},
        },
    }
}
--====================================================================================
--  Utils function
--====================================================================================

RegisterNetEvent('taxi:updateLicense')
AddEventHandler('taxi:updateLicense', function(license)
    drivers_license = license
end)

function getIsInService()
    return inService
end

local function showMessageInformation(message, duree)
    duree = duree or 2000
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end


--====================================================================================
--  Gestion de prise et d'abandon de service
--====================================================================================
local function showBliptaxi()
    for _ , c in pairs(coords) do
        local currentBlip = AddBlipForCoord(c.PriseDeService.x, c.PriseDeService.y, c.PriseDeService.z)
        SetBlipSprite(currentBlip, 17)
        SetBlipColour(currentBlip, 25)
        SetBlipAsShortRange(currentBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(TEXT.BliptaxiService)
        EndTextCommandSetBlipName(currentBlip)
        SetBlipAsMissionCreatorBlip(currentBlip, true)
        table.insert(taxi_Bliptaxi, currentBlip)

        local currentBlip2 = AddBlipForCoord(c.SpawnVehicleAction.x, c.SpawnVehicleAction.y, c.SpawnVehicleAction.z)
        SetBlipSprite(currentBlip2, 18)
        SetBlipColour(currentBlip2, 64)
        SetBlipAsShortRange(currentBlip2, true)
        --SetBlipFlashes(currentBlip,1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(TEXT.BliptaxiVehicle)
        EndTextCommandSetBlipName(currentBlip2)
        SetBlipAsMissionCreatorBlip(currentBlip2, true)
        table.insert(taxi_Bliptaxi, currentBlip2)
    end
end

local function removeBliptaxi()
    for _ , c in pairs(taxi_Bliptaxi) do
        RemoveBlip(c)
    end
    taxi_Bliptaxi = {}
end

function spawnVehicle(coords, type)
    deleteVehicle()
    for _, pos in pairs(coords) do 
        if pos.type == type then
            local vehi = GetClosestVehicle(pos.x, pos.y, pos.z, 2.0, 0, 70)
            -- Citizen.Trace('vehi : ' .. vehi)
            if vehi == 0 then
                RequestModel(type)
                while not HasModelLoaded(type) do
                    Wait(1)
                end
                myVehiculeEntity = CreateVehicle(type, pos.x, pos.y, pos.z, pos.h , true, false)
                SetVehicleNumberPlateText(myVehiculeEntity, "Taxi-" .. math.random(100,999))
                local ObjectId = NetworkGetNetworkIdFromEntity(myVehiculeEntity)
                SetNetworkIdExistsOnAllMachines(ObjectId, true)
                DecorSetBool(myVehiculeEntity, "hotwire", true)
                local p = GetEntityCoords(myVehiculeEntity, 0)
                local h = GetEntityHeading(myVehiculeEntity)
                return
            end
        end
    end
    -- Citizen.Trace('impossible')
    notifIcon("CHAR_BLANK_ENTRY", 1, "taxi", false, TEXT.SpawnVehicleImpossible)
    -- local myPed = GetPlayerPed(-1)
    -- local player = PlayerId()
    -- RequestModel(VehicleModelKeyTowTruck)
    -- while not HasModelLoaded(VehicleModelKeyTowTruck) do
    --     Wait(1)
    -- end
    
    -- local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
    -- myVehiculeEntity = CreateVehicle(VehicleModelKeyTowTruck, coords.x, coords.y, coords.z, 0 , true, false)
    -- DecorSetInt(myVehiculeEntity, 'VehicleDepa', 1)
    -- SetVehicleNumberPlateText(myVehiculeEntity, "Depa001")
    -- local ObjectId = NetworkGetNetworkIdFromEntity(myVehiculeEntity)
    -- SetNetworkIdExistsOnAllMachines(ObjectId, true)
end


local function toogleService()
    inService = not inService
    if inService then
        local myPed = GetPlayerPed(-1)
        TriggerServerEvent('taxi:takeService')
        TriggerServerEvent('taxi:requestMission')
    else
        -- Restaure Ped
        TriggerServerEvent('taxi:endService')
        TriggerServerEvent("skin_customization:SpawnPlayer")
    end 
end

local function gestionService()
    local myPed = GetPlayerPed(-1)
    local myPos = GetEntityCoords(myPed)
    for _, coordData in pairs(coords) do 
        local pos = coordData.PriseDeService
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, myPos.x, myPos.y, myPos.z, false)
        if dist <= 20 then
            DrawMarker(1, pos.x, pos.y, pos.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 0, 255, 200, 0, 0, 0, 0)
        end
        if dist <= 1 then 
            if inService then
                --showMessageInformation(TEXT.QuitterService, 60)
                SetTextComponentFormat("STRING")
                AddTextComponentString(TEXT.QuitterService)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            else
                SetTextComponentFormat("STRING")
                AddTextComponentString(TEXT.PrendreService)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                --showMessageInformation(TEXT.PrendreService, 60)
            end
            if IsControlJustPressed(0, 51) then
                toogleService()
                TriggerServerEvent('taxi:checkLicense')
            end
        end

        if inService then 
            local pos = coordData.SpawnVehicleAction
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, myPos.x, myPos.y, myPos.z, false)
            if dist <= 20 then
                DrawMarker(1, pos.x, pos.y, pos.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 128, 0, 200, 0, 0, 0, 0)
            end
            if dist <= 1 then 
                -- showMessageInformation(TEXT.SpawnVehicle, 60)
                SetTextComponentFormat("STRING")
                AddTextComponentString(TEXT.SpawnVehicle)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                if IsControlJustPressed(0, 51) then
                    if drivers_license == true then
                        TriggerServerEvent("taxi:rent", coordData.SpawnVehicle, VehicleModelKeyTaxi)
                    else
                        TriggerEvent("pNotify:SendNotification", {text = "You dont have a valid drivers license!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    end
                end
            end
        end
    end
end

RegisterNetEvent('taxi:rent')
AddEventHandler('taxi:rent', function(CoordData, Model)
    spawnVehicle(CoordData, Model)
end)
--====================================================================================
-- 
--====================================================================================


function deleteVehicle()
    if myVehiculeEntity ~= nil then
        DeleteVehicle(myVehiculeEntity)
        myVehiculeEntity = nil
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isTaxi then
            gestionService()
        end
    end
end)

--
--
RegisterNetEvent('taxi:drawMarker') 
AddEventHandler('taxi:drawMarker', function (boolean)
    isTaxi = boolean
    if isTaxi then
        showBliptaxi()
    else
        removeBliptaxi()
    end
end)
RegisterNetEvent('taxi:drawBlips')  
AddEventHandler('taxi:drawBlips', function ()
end)
RegisterNetEvent('taxi:marker') 
AddEventHandler('taxi:marker', function ()
end)

RegisterNetEvent('taxi:deleteBlips')
AddEventHandler('taxi:deleteBlips', function ()
    isTaxi = false
    inService = false
    removeBliptaxi()
end)

--====================================================================================
-- Serveur - Client Trigger
-- restart depanneur
--====================================================================================

function notifIcon(icon, type, sender, title, text)
    Citizen.CreateThread(function()
        Wait(1)
        SetNotificationTextEntry("STRING");
        if TEXT[text] ~= nil then
            text = TEXT[text]
        end
        AddTextComponentString(text);
        SetNotificationMessage(icon, icon, true, type, sender, title, text);
        DrawNotification(false, true);
    end)
end

RegisterNetEvent("taxi:PersonnelMessage")
AddEventHandler("taxi:PersonnelMessage",function(message)
    if inService then
        notifIcon("CHAR_BLANK_ENTRY", 1, "Taxi Info", false, message)
    end
end)

RegisterNetEvent("taxi:ClientMessage")
AddEventHandler("taxi:ClientMessage",function(message)
    notifIcon("CHAR_BLANK_ENTRY", 1, "Taxi", false, message)
end)

AddEventHandler("taxi:accept_mission", function(data)
    TriggerServerEvent('taxi:AcceptMission', data.id)
end)

function updateMenuMission()
    local items = {}
    for _,m in pairs(listMissions) do 
        -- Citizen.Trace('item mission')
        local item = {
            name = 'Mission ' .. m.id .. ' [' .. m.type .. ']',
            mission = m,
            event = "taxi:accept_mission"
        }
        if #m.acceptBy ~= 0 then
            item.name = item.name .. ' (In progress)'
            item.TextColor = {39, 174, 96, 255}
        end
        table.insert(items, item)
    end
    if currentMissions ~= nil then
        table.insert(items, {name = 'Finish the mission', event = "taxi:finish_mission", mission = ""})
    end

    mission_list = items
    if exports.ui:currentmenu() == "taxi:missions" then
        TriggerEvent("taxi:missions")
    end
end

RegisterNetEvent('taxi:MissionAccept')
AddEventHandler('taxi:MissionAccept', function (mission)
    currentMissions = mission
    missionXCoord = mission.pos[1]
    missionYCoord = mission.pos[2]
    missionZCoord = mission.pos[3]
    MissionCaller = mission.caller
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    currentBlip= AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(currentBlip, 309)
    SetBlipColour(currentBlip, 5)
    SetBlipAsShortRange(currentBlip, true)
    --SetBlipFlashes(currentBlip,1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(TEXT.Blip)
      EndTextCommandSetBlipName(currentBlip)
    SetBlipAsMissionCreatorBlip(currentBlip, true)
  end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
        if inService then
            local coords = GetEntityCoords(PlayerPedId(), false)
            local distance = Vdist(coords.x, coords.y, coords.z, missionXCoord, missionYCoord, missionZCoord)
            local lastmission = Vdist(missionXCoord, missionYCoord, missionZCoord, previousMissionX, previousMissionY, previousMissionZ)
            if GetPlayerServerId(PlayerPedId()) ~= MissionCaller then
                if( distance < 10 and lastmission > 50 ) then
                    TriggerServerEvent('taxi:FinishMission', currentMissions.id)
                    currentMissions = nil
                    RemoveBlip(currentBlip)
                    TriggerServerEvent('taxi:PayPlayer')
                    previousMissionX = missionXCoord
                    previousMissionY = missionYCoord
                    previousMissionZ = missionZCoord
                end
            end
        end
    end
end)

AddEventHandler("taxi:finish_mission", function()
    TriggerServerEvent('taxi:FinishMission', currentMissions.id)
    local coords = GetEntityCoords(PlayerPedId(), false)
    local distance = Vdist(coords.x, coords.y, coords.z, missionXCoord, missionYCoord, missionZCoord)
    local lastmission = Vdist(missionXCoord, missionYCoord, missionZCoord, previousMissionX, previousMissionY, previousMissionZ)
    currentMissions = nil
    if GetPlayerServerId(PlayerPedId()) ~= MissionCaller then
        if(distance < 10 and lastmission > 50 )then
            TriggerServerEvent('taxi:PayPlayer')
            RemoveBlip(currentBlip)
        end
        if currentBlip ~= nil then
            RemoveBlip(currentBlip)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if inService then
            Citizen.Wait(180000)
            previousMissionX = 0
            previousMissionY = 0
            previousMissionZ = 0
        end
    end
end)

RegisterNetEvent('taxi:MissionCancel')
AddEventHandler('taxi:MissionCancel', function ()
    currentMissions = nil
    if currentBlip ~= nil then
        RemoveBlip(currentBlip)
    end
end)

RegisterNetEvent('taxi:MissionChange')
AddEventHandler('taxi:MissionChange', function (missions)
    if not inService then
        return
    end
    listMissions = missions

    local nbMissionEnAttente = 0

    for _,m in pairs(listMissions) do

        if #m.acceptBy == 0 then
        nbMissionEnAttente = nbMissionEnAttente + 1
        end
    end
    if nbMissionEnAttente == 0 then 
        TriggerEvent("taxi:updateMission", TEXT.InfotaxiNoAppel)
    else
        TriggerEvent("taxi:updateMission", '~g~ ' .. nbMissionEnAttente .. ' ' .. TEXT.InfotaxiNbAppel)
    end
    updateMenuMission()
end)


function callService(type)
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    TriggerServerEvent('taxi:Call', myCoord.x, myCoord.y, myCoord.z, type, GetPlayerServerId(PlayerPedId()))
end

function toogleHelperLine()
    ShowLineGrueHelp = not ShowLineGrueHelp
end

RegisterNetEvent('taxi:callService')
AddEventHandler('taxi:callService',function(type)
    print(type)
    callService(type)
end)

RegisterNetEvent('taxi:callServiceCustom')
AddEventHandler('taxi:callServiceCustom',function(data)
    local info = openTextInput('', '', 128)
    if info ~= nil and info ~= '' then
         callService(info)
    end
end)

RegisterNetEvent('taxi:callStatus')
AddEventHandler('taxi:callStatus',function(status)
    taxi_call_accept = status
end)

RegisterNetEvent('taxi:personnelChange')
AddEventHandler('taxi:personnelChange',function(nbPersonnel, nbDispo)
    taxi_nbtaxiInService = nbPersonnel
    taxi_nbtaxiDispo = nbDispo
end)

RegisterNetEvent('taxi:cancelCall')
AddEventHandler('taxi:cancelCall',function(data)
    TriggerServerEvent('taxi:cancelCall')
end)



function openTextInput(title, defaultText, maxlength)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", defaultText or "", "", "", "", maxlength or 180)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end
    return nil
end


--Citizen.Trace("taxi load")
TriggerServerEvent('taxi:requestPersonnel')



-- isTaxi = true
-- toogleService()


-- ----[[ DEBUG
-- local myPed = GetPlayerPed(-1)
-- local myCoord = GetEntityCoords(myPed)
-- -- toogleService()
-- Citizen.Trace('Pos init: ' .. myCoord.x .. ', ' .. myCoord.y .. ', ' .. myCoord.z)

-- -- local l = math.floor(math.random() * #coords) + 1 
-- -- -- Citizen.Trace('Tp at ' .. l )
-- -- local pos = coords[l].SpawnVehicleAction
-- -- --SetEntityCoords(myPed, pos.x, pos.y, pos.z)

-- -- --]]
-- toogleService()
-- isTaxi = true
-- -- local myPed = GetPlayerPed(-1)
-- -- local myCoord = GetEntityCoords(myPed)
-- -- local any = nil
-- -- AddRope(
-- -- myCoord.x, myCoord.y, myCoord.z, 
-- -- 0.0, 0.0, 0.0,
-- -- 5.0, 1, 4.5, 5.5, 
-- -- 0,0,0,
-- -- 0,0,0,Citizen.ReturnResultAnyway())
-- local function GetVehicleInDirection( coordFrom, coordTo )
--     local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
--     local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
--     return vehicle
-- end

-- local function GetVehicleLookByPlayer(ped, dist)
--     local playerPos =GetOffsetFromEntityInWorldCoords( ped, 0.0, 0.0, 0.0 )
--     local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, dist, -0.8 )
--     return GetVehicleInDirection( playerPos, inFrontOfPlayer )
-- end
-- local my= GetPlayerPed(-1)
-- local vi = GetVehicleLookByPlayer(my, 3.0)
-- if vi ~= nil then
--     local myCoord = GetEntityCoords(vi)
--     local h = GetEntityHeading(vi)
--     Citizen.Trace('Car init: ' .. myCoord.x .. ', ' .. myCoord.y .. ', ' .. myCoord.z ..  ', h :  ' .. h)
-- end

-- Citizen.CreateThread(function()
--     while true do 
--     Citizen.Wait(1)
--     local ped = GetPlayerPed(-1)
--            local playerPos = GetEntityCoords( ped, 1 )
--            local p = GetOffsetFromEntityInWorldCoords( ped, 0.0, 0.0, 0.0 )
--         local p1 = GetOffsetFromEntityInWorldCoords( ped, 0.0, 3.0, -0.8)
--         DrawLine(p.x, p.y, p.z, p1.x, p1.y, p1.z, 255,0,0,255)
--     end
-- end)

Citizen.CreateThread(function()
	local payphones = vector3(1841.0107421875, 2614.990234375, 45.630123138428)
    while true do
    Citizen.Wait(0)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped, false)
        local dist = #(coords - payphones)
        if dist < 1 then
            if IsControlJustPressed(1, 51) then
                TriggerServerEvent('taxi:payPhone')
            end
        end
    end
end)
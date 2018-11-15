local myVehiculeEntity = nil
local otherVehicle = nil
local inService = false
local alarmValue = 0
local alarmVehicle = 0
local alarmDelay = 500
local ShowLineGrueHelp = true
local VehicleModelKeyTowTruck = GetHashKey('towtruck')
local VehicleModelKeyFlatBed = GetHashKey('flatbed')
spawnVehicleChoix = {}
local KEY_E = 38
local KEY_UP = 96 -- N+
local KEY_DOWN = 97 -- N-
local KEY_CLOSE = 177
local currentBlip = nil 
local listMissions = {}
local currentMissions = nil
local myCallMission = nil 
local mechanic_nbMissionEnAttenteText = 'Loading information'
local mechanic_BlipMechanic = {}
local mechanic_showHelp = false
local mechanic_call_accept = 0
local mechanic_nbMechanicInService = 0
local mechanic_nbMechanicDispo = 0
local missionXCoord = 0
local missionYCoord = 0
local missionZCoord = 0
local previousMissionX = 0
local previousMissionY = 0
local previousMissionZ = 0
local whoCalledX = 0
local whoCalledY = 0
local whoCalledZ = 0
local previous_mission_coords = nil

function getMechanicIsInService()
    return inService
end

isMechanic = false

RegisterNetEvent("Mechanic:Set")
AddEventHandler("Mechanic:Set", function(_Data, _Mechanic, first)
    isMechanic = _Mechanic
    if not isMechanic then
        inService = false
    end
end)

local TEXT = {
    PrendreService = '~INPUT_PICKUP~ Take your Mechanics service',
    QuitterService = '~INPUT_PICKUP~ Leaving Mechanics service',
    SpawnVehicle = '~INPUT_PICKUP~ Recover your ~b~service vehicle',
    SpawnVehicleImpossible = '~R~ Impossible, no place available',
    PasVehicule = "~r~Place yourself in front of a vehicle",
    CapotFerme = '~o~Open the hood of the vehicle to avoid passing for a horn...',
    VehiculeOK = '~g~No problem',
    VehiculeReparable = '~o~Vehicle is damaged but can be repaired on site',
    VehiculeKO = "~r~Vehicle must be transported to a garage for repair",
    VehiculeReparationRapideOk = "~g~Vehicle has been repaired",
    VehiculeReparationRapideKo = "~r~Vehicle can not be repaired on site",
    VehiculeReparationGarage = "~r~This type of repair can only be done here",
    VehiculeReparationOk = '~g~The vehicle is like new',
    VehiculeDeverrouilleOk = '~g~The vehicle is open for all',
    VehiculeDeverrouilleKo = '~o~Something is not going as planned...',
    InfoGrue = '~g~E~s~ Attach/Detatch the vehicle\n~g~N+~s~ Mount the crane\n~g~N-~s~ To lower the crane',
    InfoRemoqueAttach = '~g~E~s~ Attach the vehicle',
    InfoRemoqueDettach = '~g~E~s~ Detatch the vehicle',
    InfoRemoqueNo = 'No vehicles at all',
    Blip = 'Mission in progress',
    BlipGarage = "Mechanic",
    MissionCancel = 'Your current mission n\'is no longer d\'current',
    MissionClientAccept = 'A Mechanic took your call',
    MissionClientCancel = 'Your Mechanic has abandoned you',
    InfoMechanicNoAppel = '~g~No Calls waiting',
    InfoMechanicNbAppel = '~w~ Call(s) waiting',
    BlipMechanicService = 'Mechanic Service',
    BlipMechanicVehicle = 'Taking the service vehicle',

    CALL_INFO_NO_PERSONNEL = '~r~No Mechanics in service',
    CALL_INFO_ALL_BUSY = '~o~All our Mechanics are busy',
    CALL_INFO_WAIT = '~b~Your call is on hold',
    CALL_INFO_OK = '~g~A Mechanic will arrive at the l\'call location',

    CALL_RECU = 'Confirmation\nYour call has been saved',
    CALL_ACCEPT = 'Your call has been accepted, a Mechanic is on the way',
    CALL_CANCEL = 'The Mechanic comes to abandon your call',
    CALL_FINI = 'Your call has been resolved',
    CALL_EN_COURS = 'You already have a request in progress ...',

    MISSION_NEW = 'A new accident has been reported, it has been added to your mission list',
    MISSION_ACCEPT = 'Mission accepted, get started',
    MISSION_ANNULE = 'Your customer has canceled',
    MISSION_CONCURENCE = 'You are several on the spot',
    MISSION_INCONNU = 'This mission n\'is no longer d\'current',
    MISSION_EN_COURS = 'This mission is already under way'
    
}
-- restart depanneur
local coords = {
    {
        ['Repair'] = {x = -1148.4748, y = -2000.0338, z = 13.1803},
        ['ArenaRepair'] = {x = -1144.57,  y = -2005.16,  z = 13.18, r = 50.0},
        ['SpawnVehicleAction'] = { x = -1122.80, y = -2012.5684, z = 13.1887},
        ['SpawnVehicle'] = {
            {x = -1159.3833, y = -1991.1313, z = 13.1363, h = 311.7820, type = VehicleModelKeyTowTruck},
            {x = -1119.97, y = -2022.58, z = 13.1807, h = 314.9234, type = VehicleModelKeyTowTruck},
            {x = -1143.5556, y = -1967.2910, z = 13.2475, h = 179.9410, type = VehicleModelKeyFlatBed},
        },
    },
    {
        ['Repair'] = {x = 548.6361, y = -172.5256, z = 54.4813},
        ['ArenaRepair'] = {x = 542.55,  y = -180.42,  z = 54.08846, r = 28.0},
        ['SpawnVehicleAction'] = { x = 540.0619, y = -196.7581, z = 54.4898},
        ['SpawnVehicle'] = {
            {x = 534.4255, y = -169.6911, z = 54.6268, h = 0.0179, type = VehicleModelKeyTowTruck},
            {x = 530.7656, y = -169.5748, z = 54.8785, h = 0.3389, type = VehicleModelKeyTowTruck},
            {x = 545.5554, y = -210.4010, z = 53.47, h = 147.20, type = VehicleModelKeyFlatBed},
        },
    },
    {
        ['Repair'] = {x = 2004.3656, y = 3790.5842, z = 32.1809},
        ['ArenaRepair'] = {x = 2006.354,  y = 3798.739,  z = 32.1808, r = 15.0},
        ['SpawnVehicleAction'] = { x = 1997.1357, y = 3779.9375, z = 32.1809},
        ['SpawnVehicle'] = {
            {x = 1983.1662, y = 3784.6511, z = 32.1463, h = 29.7412, type = VehicleModelKeyTowTruck},
            {x = 1979.5776, y = 3782.8300, z = 32.1465, h = 29.2248, type = VehicleModelKeyTowTruck},
            {x = 1977.0086, y = 3780.3515, z = 32.2697, h = 29.2043, type = VehicleModelKeyFlatBed},
        },
    },
    {
        ['Repair'] = {x = 99.1272, y = 6620.6496, z = 32.4359},
        ['ArenaRepair'] = {x = 130.16,  y = 6609.85,  z = 31.84, r = 25.0},
        ['SpawnVehicleAction'] = { x = 108.0850, y = 6614.4726, z = 31.9555},
        ['SpawnVehicle'] = {
            {x = 109.5908, y = 6607.0776, z = 31.8156, h = 316.8023, type = VehicleModelKeyTowTruck},
            {x = 112.7592, y = 6603.8974, z = 31.8990, h = 314.7157, type = VehicleModelKeyTowTruck},
            {x = 119.9472, y = 6599.2880, z = 32.06, h = 270.60, type = VehicleModelKeyFlatBed},
        },
    },
    {
        ['Repair'] = {x = 1130.3, y = -776.80, z = 57.6105},
        ['ArenaRepair'] = {x = 1145.31,  y = -777.64,  z = 57.60, r = 20.0},
        ['SpawnVehicleAction'] = { x = 1123.9494, y = -784.7940, z = 57.6278},
        ['SpawnVehicle'] = {
            {x = 1136.1314, y = -793.9711, z = 57.5579, h = 87.9044, type = VehicleModelKeyTowTruck},
            {x = 1121.5769, y = -791.0843, z = 57.6906, h = 359.1412, type = VehicleModelKeyTowTruck},
            {x = 1111.0352, y = -785.2324, z = 58.3496, h = 359.7257, type = VehicleModelKeyFlatBed},
        },
    },
}

local impoundlot = {
    [1] = {x=401.05154418945, y=-1631.6422119141, z=29.291933059692},
    [2] = {x=1727.1442871094, y=3710.8161621094, z=34.258625030518},
}
--====================================================================================
--  Utils function
--====================================================================================
local function showMessageInformation(message, duree)
    duree = duree or 2000
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

local function SetTimeout(delay, func)
    Citizen.CreateThread(function()
        Citizen.Wait(delay)
        func()
    end)
end

local function setVehicleDoor(vehicle, open)
    open = open or 1
    if open == 1 then 
        SetVehicleDoorOpen(vehicle, 4, 0, 0)
        SetVehicleDoorOpen(vehicle, 0, 0, 0)
        SetVehicleDoorOpen(vehicle, 1, 0, 0)
        SetVehicleDoorOpen(vehicle, 2, 0, 0)
        SetVehicleDoorOpen(vehicle, 3, 0, 0)
        SetVehicleDoorOpen(vehicle, 5, 0, 0)
        SetVehicleDoorOpen(vehicle, 6, 0, 0)
        SetVehicleDoorOpen(vehicle, 7, 0, 0)
    else
        SetVehicleDoorShut(vehicle, 0, 0)
        SetVehicleDoorShut(vehicle, 1, 0)
        SetVehicleDoorShut(vehicle, 2, 0)
        SetVehicleDoorShut(vehicle, 3, 0)
        SetVehicleDoorShut(vehicle, 4, 0)
        SetVehicleDoorShut(vehicle, 5, 0)
        SetVehicleDoorShut(vehicle, 6, 0)
        SetVehicleDoorShut(vehicle, 7, 0)
    end
end

local function alarmState()
    if alarmVehicle ~= 0 and alarmValue ~= 0 then
        alarmValue = alarmValue - 1
        local state = alarmValue % 2
        setVehicleDoor(alarmVehicle, state)
        SetVehicleLights(vehicle, 1 + state)
        -- Citizen.Trace('... ' .. state)
        if alarmValue == 0 then 
            alarmVehicle = 0
            StartVehicleAlarm(alarmVehicle)
            SetVehicleSiren(vehicle, 0)
        else
            SetTimeout(alarmDelay, alarmState)
        end
    end
end

local function startAlarm(vehicle)
    if alarmVehicle == 0 then
        alarmVehicle = vehicle
        alarmValue = 20
        SetVehicleAlarm(alarmVehicle, 1)
        StartVehicleAlarm(alarmVehicle)
        StartVehicleHorn(alarmVehicle, 5000, 0 , 0)
        SetVehicleSiren(vehicle, 1)
        SetTimeout(alarmDelay, function()
            alarmState()
        end)
    end
end

local function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

local function GetVehicleLookByPlayer(ped, dist)
    local playerPos =GetOffsetFromEntityInWorldCoords( ped, 0.0, 0.0, 0.0 )
    local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, dist, -0.8 )
    return GetVehicleInDirection( playerPos, inFrontOfPlayer )
end

--====================================================================================
--  Gestion de prise et d'abandon de service
--====================================================================================
local function showBlipMechanic()
    for _ , c in pairs(coords) do
        local currentBlip = AddBlipForCoord(c.Repair.x, c.Repair.y, c.Repair.z)
        SetBlipSprite(currentBlip, 17)
        SetBlipColour(currentBlip, 25)
        SetBlipScale(currentBlip, 0.6)
        SetBlipAsShortRange(currentBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(TEXT.BlipMechanicService)
        EndTextCommandSetBlipName(currentBlip)
        SetBlipAsMissionCreatorBlip(currentBlip, true)
        table.insert(mechanic_BlipMechanic, currentBlip)

        local currentBlip2 = AddBlipForCoord(c.SpawnVehicleAction.x, c.SpawnVehicleAction.y, c.SpawnVehicleAction.z)
        SetBlipSprite(currentBlip2, 18)
        SetBlipColour(currentBlip2, 64)
        SetBlipScale(currentBlip2, 0.6)
        SetBlipAsShortRange(currentBlip2, true)
        --SetBlipFlashes(currentBlip,1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(TEXT.BlipMechanicVehicle)
        EndTextCommandSetBlipName(currentBlip2)
        SetBlipAsMissionCreatorBlip(currentBlip2, true)
        table.insert(mechanic_BlipMechanic, currentBlip2)
    end
end

local function removeBlipMechanic()
    for _ , c in pairs(mechanic_BlipMechanic) do
        RemoveBlip(c)
    end
    mechanic_BlipMechanic = {}
end

local function drawHelpJobM()
    local lines = {
        { text = '~o~Mechanical Information', isTitle = true, isCenter = true},
        { text = '~g~You need to help citizens solve their vehicle problems', isCenter = true, addY = 0.04},
        { text = ' - Take your car and get the vehicle in a garage'},
        { text = ' - When a call is initiated, pick up the call and dial to the client'},
        { text = ' - Once there, analyze the situation and make an on-site repair if possible'},
        { text = ' - If this is not possible, transport the vehicle to the nearest garage for repair'},
        { text = ' - Bill the customer and return his keys'},
        { text = ' - Advise the call center that the mission is complete'},
        { text = ' - Take or wait for the next call', addY = 0.04},
        { text = '~b~ Your skills :', size = 0.4, addY = 0.04 },
        { text = '~g~Quick Repair: ~w~Returns engine running, but body damage is'},
        { text = '    Always present'},
        
        { text = '~g~Complete Repair: ~w~Can only be worked on in garage, Repairs the whole vehicle'},
        { text = '~g~Unlock the vehicle: ~w~Unlocks vehicle doors'},
        { text = '~b~ The Vehicles :', size = 0.4, addY = 0.04 },
        { text = '~g~Towtruck ~w~Fast and handy, allows to transport the cars through a crane'},
        { text = '~g~Flatbed ~w~More imposing, it allows to transport all types of vehicles', addY = 0.04},
        { text = '~b~ Tips :', size = 0.4, addY = 0.04 },
        { text = '~g~Show / hide help : ~w~Displays or hides the help line behind your vehicle that signals'},
        { text = '   The correct placement of the vehicle to be loaded', addY = 0.04},
        { text = '~c~If you can not load the vehicle on the flatbed or the cable jumps for the'},
        { text = '~c~towtruck, unlock the vehicle'},
        { text = '~c~If the cable s\'is attached l\'to the other side of the vehicle, detach and reattach', addY = 0.06},
        { text = '~d~If you find problems, use the forum to let us know', isCenter = true, addY = 0.06},
        { text = '~b~Thank You & Good Road', isCenter = true},
    }
    DrawRect(0.5, 0.5, 0.48, 0.9, 0,0,0, 225)
    local y = 0.06 - 0.025
    local defaultAddY = 0.025
    local addY = 0.025
    for _, line in pairs(lines) do 
        y = y + addY
        local caddY = defaultAddY
        local x = 0.275
        local defaultSize = 0.32
        local defaultFont = 8
        if line.isTitle == true then
            defaultFont = 1
            defaultSize = 0.8
            caddY = 0.06
        end
        SetTextFont(line.font or defaultFont)
        SetTextScale(0.0,line.size or defaultSize)
        SetTextCentre(line.isCenter == true)
        if line.isCenter == true then
            x = 0.5
        end
        SetTextDropShadow(0, 0, 0, 0, 0)
        SetTextEdge(0, 0, 0, 0, 0)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        AddTextComponentString(line.text)
        DrawText(x, y)
        addY = line.addY or caddY
    end
    --SetTextComponentFormat("STRING")
    --AddTextComponentString('~INPUT_CELLPHONE_CANCEL~ ~g~Ferme l\'aide')
    --DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

function spawnDepanneuse(coords, type)
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
                local ObjectId = NetworkGetNetworkIdFromEntity(myVehiculeEntity)
                SetNetworkIdExistsOnAllMachines(ObjectId, true)
                DecorSetBool(myVehiculeEntity, "hotwire", true)
                local p = GetEntityCoords(myVehiculeEntity, 0)
                local h = GetEntityHeading(myVehiculeEntity)
                --showMessageInformation('Pos: ' .. p.x .. ' ' .. p.y .. ' ' .. p.z .. ' ' .. h)
                return
            end
        end
    end
    -- Citizen.Trace('impossible')
    notifIcon("CHAR_BLANK_ENTRY", 1, "Mechanic", false, TEXT.SpawnVehicleImpossible)
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
    TriggerServerEvent('Mechanic:setService', inService)
    if inService then
        local myPed = GetPlayerPed(-1)
        GiveWeaponToPed(myPed, 'WEAPON_HAMMER', 0, 0, 0)
        GiveWeaponToPed(myPed, 'WEAPON_CROWBAR', 0, 0, 0)
        GiveWeaponToPed(myPed, 'WEAPON_FLASHLIGHT', 0, 0, 0)
        GiveWeaponToPed(myPed, 'WEAPON_PETROLCAN', 1000, 0, 0)
        GiveWeaponToPed(myPed, 'WEAPON_FIREEXTINGUISHER', 1000, 0, 0)
        -- A Configurer
        local hashSkin = GetHashKey("mp_m_freemode_01")
        Citizen.CreateThread(function()
        if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
            SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2) -- TORSO
            SetPedComponentVariation(GetPlayerPed(-1), 11, 43, 0, 2) -- TORSO2
            SetPedComponentVariation(GetPlayerPed(-1), 4, 41, 0, 2) -- LEGS
            SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2) -- FEET
            SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) -- ACCESSORIE
        else
            SetPedComponentVariation(GetPlayerPed(-1), 3, 25, 0, 2) -- TORSO
            SetPedComponentVariation(GetPlayerPed(-1), 11, 1, 0, 2) -- TORSO2
            SetPedComponentVariation(GetPlayerPed(-1), 4, 4, 8, 2) -- LEGS
            SetPedComponentVariation(GetPlayerPed(-1), 6, 4, 0, 2) -- FEET
            SetPedComponentVariation(GetPlayerPed(-1), 8, 20, 1, 2) -- ACCESSORIE
        end
        end)
        TriggerServerEvent('mechanic:takeService')
        TriggerServerEvent('mechanic:requestMission')
        mechanic_showHelp = true
    else
        -- Restaure Ped
        TriggerServerEvent('mechanic:endService')
        TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
    end 
end

local function gestionService()
    local myPed = GetPlayerPed(-1)
    local myPos = GetEntityCoords(myPed)
    for _, coordData in pairs(coords) do 
        local pos = coordData.Repair
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
            if IsControlJustPressed(0, KEY_E) then
                toogleService()
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
                if IsControlJustPressed(0, KEY_E) then
                    spawnVehicleChoix = coordData.SpawnVehicle
                    TriggerEvent("mechanic:menu_vehicle")
                end

            end

            local posArenaRepair = coordData.ArenaRepair
            local dist2 = GetDistanceBetweenCoords(posArenaRepair.x, posArenaRepair.y, posArenaRepair.z, myPos.x, myPos.y, myPos.z, false)
            if dist2 <= 60 then
                DrawMarker(1, posArenaRepair.x, posArenaRepair.y, posArenaRepair.z - 1.0, 0, 0, 0, 0, 0, 0, posArenaRepair.r, posArenaRepair.r, 1.0, 128, 0, 255, 128, 0, 0, 0, 0)
            end
        end
    end
end

--====================================================================================
-- UserAction restart depanneur
--====================================================================================

AddEventHandler("mechanic:getStatusVehicle", function()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    local p = GetEntityCoords(vehicle, 0)
    local h = GetEntityHeading(vehicle)
    -- Citizen.Trace('Pos: ' .. p.x .. ' ' .. p.y .. ' ' .. p.z .. ' ' .. h)
    if vehicle ~= 0 then 
        -- local capotOpen = GetVehicleDoorAngleRatio(vehicle, 4) > 0.5
        -- if not capotOpen then 
        --     showMessageInformation(TEXT.CapotFerme)
        -- else
            local dict = 'amb@prop_human_bum_shopping_cart@male@base'
            local anim = 'base'
            local pos = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 0.2, 0.0)
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            --TaskStartScenarioAtPosition(myPed, scenario, pos.x, pos.y, pos.z, 0.0, 8000, 1, 0)
            TaskPlayAnim(PlayerPedId(), dict, anim, 4.0, -4, -1, 1, 0, false, false, false)
            Citizen.Wait(8000)
            ClearPedTasks(myPed)
            local vehicleHealth = GetVehicleEngineHealth(vehicle)
            if vehicleHealth > 900 then
                showMessageInformation(TEXT.VehiculeOK,8000)
            elseif vehicleHealth >= 150 then
                showMessageInformation(TEXT.VehiculeReparable,8000)
            else
                showMessageInformation(TEXT.VehiculeKO,8000)
            end
        -- end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end)

AddEventHandler("mechanic:repairVehicle", function()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then 
        -- local capotOpen = GetVehicleDoorAngleRatio(vehicle, 4) > 0.5
        -- if not capotOpen then 
        --     showMessageInformation(TEXT.CapotFerme)
        -- else
            local dict = 'amb@world_human_vehicle_mechanic@male@base'
            local anim = 'base'

            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            local pos = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 0.02, 0.0)
            local h = GetEntityHeading(myPed)
            SetEntityHeading(myPed, GetEntityHeading(myPed) - 180)
            TaskPlayAnim(PlayerPedId(), dict, anim, 4.0, -4, -1, 1, 0, false, false, false)
            --TaskStartScenarioAtPosition(myPed, scenario,8000,1)
            Citizen.Wait(8000)
            ClearPedTasks(myPed)
            local vehicleHealth = GetEntityHealth(vehicle)
            if vehicleHealth >= 0 then
                TriggerServerEvent("mechanic:quickRepair", vehicle)
                SetVehicleEngineHealth(vehicle, 1000.0)
                SetVehicleEngineOn(vehicle, 0, 0, 0)
                SetVehicleUndriveable(vehicle, false)
                SetVehicleEngineTorqueMultiplier(vehicle, 1.0)
                showMessageInformation(TEXT.VehiculeReparationRapideOk)
            else
                showMessageInformation(TEXT.VehiculeReparationRapideKo)
            end
        -- end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end)

RegisterNetEvent('mechanic:qrepair')
AddEventHandler('mechanic:qrepair', function (vehicle)
    SetVehicleEngineHealth(vehicle, 960.0)
    SetVehicleEngineOn(vehicle, 0, 0, 0)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineTorqueMultiplier(vehicle, 1.0)
end)

AddEventHandler("mechanic:fullrepairVehicle", function()
    local myPed = GetPlayerPed(-1)
    local myPos = GetEntityCoords(myPed)
    local inArena = false
    for _, coordData in pairs(coords) do
        local pos = coordData.ArenaRepair
        -- Citizen.Trace('pos ' .. pos.x .. ' ' .. pos.y .. ' ' .. pos.z .. '    ' .. GetDistanceBetweenCoords(pos.x, pos.y, pos.y, myPos.x, myPos.y, myPos.z, false))
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.y, myPos.x, myPos.y, myPos.z, false) <= coordData.ArenaRepair.r then
            inArena = true
            break
        end
    end
    if not inArena then
         showMessageInformation(TEXT.VehiculeReparationGarage)
        return
    end
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then 
        local dict = 'amb@world_human_vehicle_mechanic@male@base'
        local anim = 'base'

        RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end
        local pos = GetOffsetFromEntityInWorldCoords(myPed, 0.0, 0.02, 0.0)
        local h = GetEntityHeading(myPed)
        SetEntityHeading(myPed, GetEntityHeading(myPed) - 180)
        TaskPlayAnim(PlayerPedId(), dict, anim, 4.0, -4, -1, 1, 0, false, false, false)        local value = GetVehicleBodyHealth(vehicle)
        
        while( value < 999.9 ) do
            value = GetVehicleBodyHealth(vehicle)
            SetVehicleBodyHealth(vehicle, value + 1.0)
            showMessageInformation('Repair in progress ~b~' .. math.floor(value) .. '/1000')
            Citizen.Wait(125)     
        end
        Citizen.Wait(250)
        ClearPedTasks(myPed)
        TriggerServerEvent("mechanic:completeRepair", vehicle)
        SetVehicleBodyHealth(vehicle, 1000.0)
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetEntityHealth(vehicle,1000)
        SetVehiclePetrolTankHealth(vehicle,1000.0)
        SetVehicleEngineOn(vehicle, 0, 0, 0)
        SetVehicleBodyHealth(vehicle, 1000.0)
        SetVehicleFixed(vehicle)
        SetVehicleEngineTorqueMultiplier(vehicle,1.0)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        showMessageInformation(TEXT.VehiculeReparationOk)
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end)

RegisterNetEvent('mechanic:cRepair')
AddEventHandler('mechanic:cRepair', function(vehicle)
    SetVehicleBodyHealth(vehicle, 1000.0)
    SetVehicleEngineHealth(vehicle, 1000.0)
    SetEntityHealth(vehicle,1000)
    SetVehiclePetrolTankHealth(vehicle,1000.0)
    SetVehicleEngineOn(vehicle, true, true, 0)
    SetVehicleBodyHealth(vehicle, 1000.0)
    SetVehicleFixed(vehicle)
    SetVehicleEngineTorqueMultiplier(vehicle,1.0)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)

end)

-- restart depanneur
function openVehicleDoorData(door_id)
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then
        if door_id == -1 then 
            SetVehicleDoorOpen(vehicle, 0, 0, 0)
            SetVehicleDoorOpen(vehicle, 1, 0, 0)
            SetVehicleDoorOpen(vehicle, 2, 0, 0)
            SetVehicleDoorOpen(vehicle, 3, 0, 0)
            SetVehicleDoorOpen(vehicle, 4, 0, 0)
            SetVehicleDoorOpen(vehicle, 5, 0, 0)
            SetVehicleDoorOpen(vehicle, 6, 0, 0)
            SetVehicleDoorOpen(vehicle, 7, 0, 0)
        else
            SetVehicleDoorOpen(vehicle, door_id, 0, 0)
        end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end

function closeVehicleDoorData(door_id)
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then
        if door_id == -1 then 
            SetVehicleDoorShut(vehicle, 0, 0)
            SetVehicleDoorShut(vehicle, 1, 0)
            SetVehicleDoorShut(vehicle, 2, 0)
            SetVehicleDoorShut(vehicle, 3, 0)
            SetVehicleDoorShut(vehicle, 4, 0)
            SetVehicleDoorShut(vehicle, 5, 0)
            SetVehicleDoorShut(vehicle, 6, 0)
            SetVehicleDoorShut(vehicle, 7, 0)
        else
            SetVehicleDoorShut(vehicle, door_id, 0, 0)
        end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end

function unlockVehiculeForAll()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehicleLookByPlayer(myPed, 3.0)
    if vehicle ~= 0 then 
        if math.random() > -0.25 then
            TaskWarpPedIntoVehicle(myPed, vehicle, -1)
            SetVehicleDoorsLocked(vehicle, 1)
            showMessageInformation(TEXT.VehiculeDeverrouilleOk)
        else   
            startAlarm(vehicle)
            showMessageInformation(TEXT.VehiculeDeverrouilleKo) 
        end
    else
        showMessageInformation(TEXT.PasVehicule)
    end
end

--====================================================================================
-- Vehicule gestion
--====================================================================================

--restart metiers
function jobsSystem()
    if inService == false then
        return
    end
    
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    local currentVehicle = GetVehiclePedIsIn(myPed, 0)

    if currentVehicle == 0 then -- a pied
        local towtruck = GetClosestVehicle(myCoord.x, myCoord.y, myCoord.z, 10.0, VehicleModelKeyTowTruck, 70)
        if towtruck ~= 0 then
            local coords = GetOffsetFromEntityInWorldCoords(towtruck, -1.5, -3.2, 0)
            local dist = GetDistanceBetweenCoords(myCoord.x, myCoord.y, myCoord.z, coords.x, coords.y, coords.z, true)
            if dist < 10 then
                DrawMarker(1, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)
            end
            if dist < 1.5 then 
                -- showMessageInformation(TEXT.InfoGrue)
                SetTextComponentFormat("STRING")
                AddTextComponentString(TEXT.InfoGrue)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                local c1 = GetOffsetFromEntityInWorldCoords(towtruck, 0.0, -4.3, 1.8)
                local c2 = GetOffsetFromEntityInWorldCoords(towtruck, 0.0, -4.3, -1.2)
                local vehicleAttach = GetEntityAttachedToTowTruck(towtruck)
                local vehicleGrap = GetVehicleInDirection(c1,c2)
                if ShowLineGrueHelp == true then 
                    if vehicleAttach ~= 0 then 
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 255, 0, 255)
                    elseif vehicleGrap ~= 0 then
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 0, 255, 255)
                    else
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
                    end
                end
                if IsControlJustPressed(1, KEY_UP) then
                    -- Citizen.Trace('up')
                    Citizen.InvokeNative(0xFE54B92A344583CA, towtruck, 1.0)
                elseif IsControlJustPressed(1, KEY_DOWN) then
                    -- Citizen.Trace('down')
                    Citizen.InvokeNative(0xFE54B92A344583CA, towtruck, 0.0)
                elseif IsControlJustPressed(1, KEY_E) then
                    -- Citizen.Trace('attack')
                    if vehicleAttach ~= 0 then
                        DetachVehicleFromTowTruck(towtruck, vehicleAttach)
                    elseif vehicleGrap ~= 0 then
                        AttachVehicleToTowTruck(towtruck, vehicleGrap, true, 0.0,0.0,0.0)
                    end
                end
            end
 
        else
            local flatbed= GetClosestVehicle(myCoord.x, myCoord.y, myCoord.z, 10.0, VehicleModelKeyFlatBed, 70)
            if flatbed ~= 0 then
                local coords = GetOffsetFromEntityInWorldCoords(flatbed, -1.5, -5.2, 0)
                local dist = GetDistanceBetweenCoords(myCoord.x, myCoord.y, myCoord.z, coords.x, coords.y, coords.z, true)
                if dist < 10 then
                    DrawMarker(1, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, 0, 0, 0, 0)
                end
                if dist < 1.5 then 

                    -- local c1 = GetOffsetFromEntityInWorldCoords(flatbed, -1.0, -1.4, 1.2)
                    -- local c2 = GetOffsetFromEntityInWorldCoords(flatbed, 1.0, -1.4, 1.2)

                    local c1 = GetOffsetFromEntityInWorldCoords(flatbed, -2.0, -1.2, 1.2)
                    local c2 = GetOffsetFromEntityInWorldCoords(flatbed, 2.0, -1.2, 1.2)
                    -- DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 255, 0, 255)
                    local cvg = GetVehicleInDirection(c1,c2)
                    --local cvg = GetEntityAttachedTo(flatbed)
                    -- restart depanneur
                    if cvg ~= 0 and GetEntityAttachedTo(cvg) == flatbed then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString(TEXT.InfoRemoqueDettach)
                        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                        if IsControlJustPressed(1, KEY_E) then
                            DetachEntity(cvg, true,true)
                            local c = GetOffsetFromEntityInWorldCoords(flatbed, 0.0, -10.0, 0)
                            SetEntityCoords(cvg,c.x, c.y, c.z)
                            SetVehicleOnGroundProperly(cvg)
                        end
                    else
                        local c1 = GetOffsetFromEntityInWorldCoords(flatbed, 0.0, -7.3, 1.8)
                        local c2 = GetOffsetFromEntityInWorldCoords(flatbed, 0.0, -7.3, -1.2)
                        local vehicleGrap = GetVehicleInDirection(c1,c2)
                        if ShowLineGrueHelp == true then 
                            if vehicleGrap ~= 0 then 
                                DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 255, 0, 255)
                            else
                                DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
                            end
                        end
                        
                        if vehicleGrap ~= 0 then 
                            SetTextComponentFormat("STRING")
                            AddTextComponentString(TEXT.InfoRemoqueAttach)
                            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                            if IsControlJustPressed(1, KEY_E) then
                                Citizen.InvokeNative(0x870DDFD5A4A796E4,vehicleGrap)
                                AttachEntityToEntity(vehicleGrap, flatbed, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, true, false, 20, true)
                            end
                        else 
                            SetTextComponentFormat("STRING")
                            AddTextComponentString(TEXT.InfoRemoqueNo)
                            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                            if IsControlJustPressed(1, KEY_E) then
                                DetachEntity(flatbed, true,true)
                            end
                        end
                    end
                end
            end
        end
    else
        if ShowLineGrueHelp == true then 
            local inTowtruck = IsVehicleModel(currentVehicle, VehicleModelKeyTowTruck)
            if inTowtruck then
                local c1 = GetOffsetFromEntityInWorldCoords(currentVehicle, 0.0, -4.3, 1.8)
                local c2 = GetOffsetFromEntityInWorldCoords(currentVehicle, 0.0, -4.3, -0.8)
                local vehicle = GetVehicleInDirection(c1,c2)
                if vehicle ~= 0 then
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 0, 255, 255)
                else
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
                end
            else 
                local inFlatBed = IsVehicleModel(currentVehicle, VehicleModelKeyFlatBed)
                if inFlatBed then
                    local c1 = GetOffsetFromEntityInWorldCoords(currentVehicle, 0.0, -7.3, 1.8)
                    local c2 = GetOffsetFromEntityInWorldCoords(currentVehicle, 0.0, -7.3, -1.2)
                    local vehicleGrap = GetVehicleInDirection(c1,c2)
                    if vehicleGrap ~= 0 then 
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 0, 255, 0, 255)
                    else
                        DrawLine(c1.x, c1.y, c1.z, c2.x, c2.y, c2.z, 255, 0, 0, 255)
                    end
                end
            end
        end
    end
end

function deleteVehicle()
    if myVehiculeEntity ~= nil then
        DeleteVehicle(myVehiculeEntity)
        myVehiculeEntity = nil
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if inService then
            local coords = GetEntityCoords(PlayerPedId(), false)
            for k, v in ipairs(impoundlot) do
                if Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 20 then
                    DrawMarker(25, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 10, 10, 1.0, 128, 0, 255, 128, 0, 0, 0, 0)
                    if Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 10 then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to impound the vehicle!")
                        if IsControlJustPressed(1, 51) then
                            local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
                            local NearestVehicle = exports.policejob:GetNearestVehicleAtCoords(v.x, v.y, v.z, 10.0)

                            if DoesEntityExist(NearestVehicle.Handle) then
                                TriggerServerEvent("police:impound", GetVehicleNumberPlateText(NearestVehicle.Handle), 500)
                                exports.policejob:DestroyVehicle(NearestVehicle.Handle)
                            else
                                exports.pNotify:SendNotification({text = "Unable to find a vehicle! Make sure its nearby!",type = "error",timeout = 5000,layout = "centerRight",queue = "left"})
                            end
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isMechanic then
            gestionService()
            jobsSystem()
        end
        if mechanic_showHelp == true then
            drawHelpJobM()
            if IsControlJustPressed(0, KEY_CLOSE) then
                mechanic_showHelp = false
            end
        end
    end
end)

RegisterNetEvent('mechanic:drawMarker')   
AddEventHandler('mechanic:drawMarker', function (boolean)
    isMechanic = boolean
    if isMechanic then
        showBlipMechanic()
    else
        removeBlipMechanic()
    end
end)

RegisterNetEvent('mechanic:drawBlips')    
AddEventHandler('mechanic:drawBlips', function ()
end)

RegisterNetEvent('mechanic:marker')   
AddEventHandler('mechanic:marker', function ()
end)

RegisterNetEvent('mechanic:deleteBlips')
AddEventHandler('mechanic:deleteBlips', function ()
    isMechanic = false
    removeBlipMechanic()
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

RegisterNetEvent("mechanic:PersonnelMessage")
AddEventHandler("mechanic:PersonnelMessage",function(message)
    if inService then
        notifIcon("CHAR_BLANK_ENTRY", 1, "Mechanic Info", false, message)
    end
end)

RegisterNetEvent("mechanic:ClientMessage")
AddEventHandler("mechanic:ClientMessage",function(message)
    notifIcon("CHAR_BLANK_ENTRY", 1, "Mechanic", false, message)
end)


--=== restart depanneur
AddEventHandler("mechanic:accept_mission", function(data)
    TriggerServerEvent('mechanic:AcceptMission', data.id)
end)

function updateMenuMission() 
    local items = {}
    for _,m in pairs(listMissions) do 
        local item = {
            name = 'Mission ' .. m.id .. ' [' .. m.type .. ']',
            mission = m,
            event = "mechanic:accept_mission"
        }
        if #m.acceptBy ~= 0 then
            item.name = item.name .. ' (current mission)'
            item.TextColor = {39, 174, 96, 255}
        end
        if m.id ~= GetPlayerServerId(PlayerId()) then
            table.insert(items, item)
        end
    end
    if currentMissions ~= nil then
        table.insert(items, {name = 'Finish Mission', event = "mechanic:finish_mission", mission = ""})
    end
    mission_list = items
end

RegisterNetEvent('mechanic:MissionAccept')
AddEventHandler('mechanic:MissionAccept', function (mission)
    currentMissions = mission
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    currentBlip = AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(currentBlip, 446)
    SetBlipColour(currentBlip, 5)
    SetBlipAsShortRange(currentBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(TEXT.Blip)
    EndTextCommandSetBlipName(currentBlip)
    SetBlipAsMissionCreatorBlip(currentBlip, true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if currentMissions ~= nil then
            local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
            if GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, currentMissions.pos[1], currentMissions.pos[2], currentMissions.pos[3], true) < 10 then
                TriggerEvent("mechanic:finish_mission")
            end
        end
    end
end)

AddEventHandler("mechanic:finish_mission", function()
    if currentMissions ~= nil then
        if previous_mission_coords ~= nil then
            if GetDistanceBetweenCoords(currentMissions.pos[1], currentMissions.pos[2], currentMissions.pos[3], previous_mission_coords[1], previous_mission_coords[2], previous_mission_coords[3], true) > 30 then
                TriggerServerEvent("mechanic:PayPlayer")
            end
            
            previous_mission_coords = currentMissions.pos
        else
            previous_mission_coords = currentMissions.pos
            TriggerServerEvent("mechanic:PayPlayer")
        end

        TriggerServerEvent('mechanic:FinishMission', currentMissions.id)
        currentMissions = nil
    end
    
    if currentBlip ~= nil then
        RemoveBlip(currentBlip)
    end
end)

RegisterNetEvent('mechanic:MissionCancel')
AddEventHandler('mechanic:MissionCancel', function ()
    currentMissions = nil
    if currentBlip ~= nil then
        RemoveBlip(currentBlip)
    end
end)

RegisterNetEvent('mechanic:MissionChange')
AddEventHandler('mechanic:MissionChange', function (missions)
    if not inService then
        return
    end
    listMissions = missions
    -- if currentMissions ~= nil then
         local nbMissionEnAttente = 0
    --     local find = false 
         for _,m in pairs(listMissions) do
      --       if m.id == currentMissions.id then
      --           find = true
       --      end
             if #m.acceptBy == 0 then
               nbMissionEnAttente = nbMissionEnAttente + 1
             end
        end
        if nbMissionEnAttente == 0 then 
            TriggerEvent("mechanic:updateInformation", TEXT.InfoMechanicNoAppel)
         else
            TriggerEvent("mechanic:updateInformation", '~g~ ' .. nbMissionEnAttente .. ' ' .. TEXT.InfoMechanicNbAppel)
         end
    --     Citizen.Trace('ok')
    --     if not find then
    --         currentMissions = nil
    --         notifIcon("CHAR_BLANK_ENTRY", 1, "Mechanic", false, TEXT.MissionCancel)
    --         if currentBlip ~= nil then
    --             RemoveBlip(currentBlip)
    --         end
    --     end
    -- end
    updateMenuMission()
end)


function needMechanic(type)
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    TriggerServerEvent('mechanic:Call', myCoord.x, myCoord.y, myCoord.z, type)
end

AddEventHandler('mechanic:togglehelp', function()
    ShowLineGrueHelp = not ShowLineGrueHelp
end)

AddEventHandler('mechanic:clean', function ()
    SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
    SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
end)

RegisterNetEvent('mechanic:openMenu')
AddEventHandler('mechanic:openMenu', function()
    -- Citizen.Trace('open menu mechanic')
    if inService then
        TriggerServerEvent('mechanic:requestMission')
        openMenuGeneral()
    else
        showMessageInformation("~r~You must be in service to use the menu")
    end
end)

RegisterNetEvent('mechanic:callMechanic')
AddEventHandler('mechanic:callMechanic',function(type)
    needMechanic(type)
end)

RegisterNetEvent('mechanic:callStatus')
AddEventHandler('mechanic:callStatus',function(status)
    mechanic_call_accept = status
end)

RegisterNetEvent('mechanic:personnelChange')
AddEventHandler('mechanic:personnelChange',function(nbPersonnel, nbDispo)
    mechanic_nbMechanicInService = nbPersonnel
    mechanic_nbMechanicDispo = nbDispo
end)

RegisterNetEvent('mechanic:cancelCall')
AddEventHandler('mechanic:cancelCall',function(data)
    TriggerServerEvent('mechanic:cancelCall')
end)

--====================================================================================
-- ADD Blip for All Player
--====================================================================================
-- Delay sinon sa ne s'affiche pas
SetTimeout(2500, function() 
    for _, c in pairs(coords) do 
        local currentBlip = AddBlipForCoord(c.ArenaRepair.x, c.ArenaRepair.y, c.ArenaRepair.z)
        SetBlipSprite(currentBlip, 446)
        SetBlipScale(currentBlip, 0.7)
        SetBlipAsShortRange(currentBlip, true)
        SetBlipColour(currentBlip, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(TEXT.BlipGarage)
        EndTextCommandSetBlipName(currentBlip)
        SetBlipAsMissionCreatorBlip(currentBlip, true)
    end
    
end)
--Citizen.Trace("Mechanic load")
TriggerServerEvent('mechanic:requestPersonnel')

-- Register a network event 
RegisterNetEvent( 'deleteVehicle' )

-- The distance to check in front of the player for a vehicle
-- Distance is in GTA units, which are quite big  
local distanceToCheck = 5.0

-- Add an event handler for the deleteVehicle event. 
-- Gets called when a user types in /dv in chat (see server.lua)
function MECANO_deleteVehicle()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )
        -- log( "Player is at:\nX: " .. pos.x .. " Y: " .. pos.y .. " Z: " .. pos.z )
        -- log( "Found vehicle?: " .. tostring( DoesEntityExist( vehicle ) ) )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                ShowNotification( "No vehicle Near." )
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )
            else 
                ShowNotification( "test" )
            end 
        else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                -- log( "Distance between ped and vehicle: " .. tostring( GetDistanceBetween( ped, vehicle ) ) )
                ShowNotification( "test" )
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )
            else 
                ShowNotification( "test" )
            end 
        end 
    end 
end

-- Delete car function borrowed frtom Mr.Scammer's model blacklist, thanks to him!
function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

-- Shows a notification on the player's screen 
function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end
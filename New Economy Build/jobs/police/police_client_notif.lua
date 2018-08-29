local KEY_E = 38
local KEY_CLOSE = 177
local POLICE_currentBlip = nil 
local POLICE_listMissions = {}
local POLICE_currentMissions = nil
local POLICE_nbMissionEnAttenteText = '-- No Information --'
local POLICE_BlipMechanic = {}
local POLICE_showHelp = false
local POLICE_CALL_ACCEPT_P = 0
local POLICE_nbMechanicisInService = 0
local POLICE_nbMechanicDispo = 0
local currentSuspectCharges = {}

-- local isCop = false
-- local isCopInService = false
-- local rank = "inconnu"
-- local checkpoints = {}
-- local existingVeh = nil
-- local handCuffed = false

-- isCop = true -- famse
-- isisInService = false
-- blipsCops = {}


local POLICE_TEXT = {
    PrendreService = '~INPUT_PICKUP~ Go on duty',
    QuitterService = '~INPUT_PICKUP~ Go off duty',
    SpawnVehicle = '~INPUT_PICKUP~ Recovering his vehicle from ~b~service',
    SpawnVehicleImpossible = '~R~ Impossible, no place available',

    Blip = 'Mission in progress',


    MissionCancel = 'Your current mission is no longer current',
    MissionClientAccept = 'A policeman took your call',
    MissionClientCancel = 'Your policeman has abandoned you',
    InfoPoliceNoAppel = '~g~No Call Waiting',
    InfoPoliceNbAppel = '~w~ Call waiting',
    BlipMechanicService = 'Service plug',
    BlipMechanicVehicle = 'Service Vehicle',

    CALL_INFO_NO_PERSONNEL = '~r~No police officers in service',
    CALL_INFO_ALL_BUSY = '~o~All our units are occupied',
    CALL_INFO_WAIT = '~b~Your call is on hold',
    CALL_INFO_OK = '~g~A unit will arrive at the location of the call',

    CALL_RECU = 'Confirmation\nYour call has been registered',
    CALL_ACCEPT_P_P = 'Your call has been accepted, a Policeman is on the way',
    CALL_CANCEL = 'The policeman has just d\'abandoned your call',
    CALL_FINI = 'Your call has been resolved',
    CALL_EN_COURS = 'You already have a request ...',

    MISSION_NEW = 'A new alert has been posted, it has been added to your list of missions',
    MISSION_ACCEPT = 'Mission accepted, get started',
    MISSION_ANNULE = 'Your customer s\'has canceled',
    MISSION_CONCURENCE = 'You are several on the go',
    MISSION_INCONNU = 'The mission n\'is no longer d\'current',
    MISSION_EN_COURS = 'This mission is already under way'
    
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
--====================================================================================
--  Gestion de prise et d'abandon de service
--====================================================================================


-- local function --onServiceChangePolice()
--     if isCopInService then
--         TriggerServerEvent('police:takeService')
--         TriggerServerEvent('police:requestMission')
--     else
--         -- Restaure Ped
--         TriggerServerEvent('police:endService')
--         TriggerServerEvent("skin_customization:SpawnPlayer")
--     end 
-- end


--====================================================================================
-- UserAction restart police
--====================================================================================

    RegisterNetEvent('police:fouille')
    AddEventHandler('police:fouille', function()
        if(isCopInService) then
            t, distance = GetClosestPlayer()
            if(distance ~= -1 and distance < 1) then
                TriggerServerEvent("police:targetFouille", GetPlayerServerId(t))
            else
                TriggerServerEvent("police:targetFouilleEmpty")
            end
        else
            TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "You are not in service!")
        end
    end)

    RegisterNetEvent('police:amende')
    AddEventHandler('police:amende', function(t, amount)
        if(isCopInService) then
            TriggerServerEvent("police:amendeGranted", t, amount)
        else
            TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "You are not in service!")
        end
    end)

    RegisterNetEvent('police:cuff')
    AddEventHandler('police:cuff', function(t)
        if(isCopInService) then
            t, distance = GetClosestPlayer()
            if(distance ~= -1 and distance < 1) then
                TriggerServerEvent("police:cuffGranted", GetPlayerServerId(t))
            else
                TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "No player within range! !")
            end
        else
            TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "You are not in service!")
        end
    end)


    RegisterNetEvent('police:payAmende')
    AddEventHandler('police:payAmende', function(amount)
        TriggerServerEvent('bank:withdrawAmende', amount)
        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "You paid a fine of $"..amount..".")
    end)



    RegisterNetEvent('police:forceEnter')
    AddEventHandler('police:forceEnter', function(id)
        if(isCopInService) then
            t, distance = GetClosestPlayer()
            if(distance ~= -1 and distance < 1) then
                TriggerServerEvent("police:forceEnterAsk", GetPlayerServerId(t))
            else
                TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "No player handcuffed in range !")
            end
        else
            TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "You are not in service!")
        end
    end)





--====================================================================================
-- Vehicule gestion
--====================================================================================

function POLICE_showInfoClient() 
    if POLICE_CALL_ACCEPT_P ~= 0 then

        local offsetX = 0.87
        local offsetY = 0.785
        DrawRect(offsetX, offsetY, 0.23, 0.035, 0, 0, 0, 215)

        SetTextFont(1)
        SetTextScale(0.0,0.5)
        SetTextCentre(true)
        SetTextDropShadow(0, 0, 0, 0, 0)
        SetTextEdge(0, 0, 0, 0, 0)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        if POLICE_CALL_ACCEPT_P == 1 then
            AddTextComponentString(POLICE_TEXT.CALL_INFO_OK)
        else 
            if POLICE_nbMechanicisInService == 0 then
                AddTextComponentString(POLICE_TEXT.CALL_INFO_NO_PERSONNEL)
            elseif POLICE_nbMechanicDispo == 0 then
                AddTextComponentString(POLICE_TEXT.CALL_INFO_ALL_BUSY)
            else
                AddTextComponentString(POLICE_TEXT.CALL_INFO_WAIT)
            end
        end  
        DrawText(offsetX, offsetY - 0.015 )
    end
end

function POLICE_showInfoJobs()
    local offsetX = 0.9
    local offsetY = 0.845
    DrawRect(offsetX, offsetY, 0.15, 0.07, 0, 0, 0, 215)

    SetTextFont(1)
    SetTextScale(0.0,0.5)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString('~o~Police Info')
    DrawText(offsetX, offsetY - 0.03)

    SetTextFont(1)
    SetTextScale(0.0,0.5)
    SetTextCentre(false)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")

    AddTextComponentString(POLICE_nbMissionEnAttenteText)
    DrawText(offsetX - 0.065, offsetY -0.002)
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isCop then
            --gestionService()
            
            if isCopInService then
                --TriggerServerEvent('police:setService', true)
                POLICE_showInfoJobs()   
            else
                --TriggerServerEvent('police:setService', false)
            end
        end

        if POLICE_CALL_ACCEPT_P ~= 0 then
            POLICE_showInfoClient()
        end
        -- Citizen.Trace('isCop: ' .. (isCop and 'True' or 'False'))
        -- POLICE_showInfoJobs()
    end
end)

--
RegisterNetEvent('police:drawMarker')   
AddEventHandler('police:drawMarker', function (boolean)
    isCop = true
    Citizen.Trace('NOW COP')
    Citizen.Trace('NOW COP')
    Citizen.Trace('NOW COP')
end)
RegisterNetEvent('police:drawBlips')    
AddEventHandler('police:drawBlips', function ()

end)
RegisterNetEvent('police:marker')   
AddEventHandler('police:marker', function ()
end)

RegisterNetEvent('police:deleteBlips')
AddEventHandler('police:deleteBlips', function ()
    isCop = false
    Citizen.Trace("NOMORECOP")
    TriggerServerEvent("police:removeCop")
    TriggerEvent("police:finishService")
    
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
end)

--====================================================================================
-- Call System
--====================================================================================

-- Notification
function notifIcon(icon, type, sender, title, text)
    Citizen.CreateThread(function()
        Wait(1)
        SetNotificationTextEntry("STRING");
        if POLICE_TEXT[text] ~= nil then
            text = POLICE_TEXT[text]
        end
        AddTextComponentString(text);
        SetNotificationMessage(icon, icon, true, type, sender, title, text);
        DrawNotification(false, true);
    end)
end

RegisterNetEvent("police:PersonnelMessage")
AddEventHandler("police:PersonnelMessage",function(message)
    if isCopInService then
        notifIcon("CHAR_BLANK_ENTRY", 1, "Police Info", false, message)
    end
end)

RegisterNetEvent("police:ClientMessage")
AddEventHandler("police:ClientMessage",function(message)
    notifIcon("CHAR_BLANK_ENTRY", 1, "Police", false, message)
end)

-- 
function acceptMissionPolice(data) 
    local mission = data.mission 
    TriggerServerEvent('police:AcceptMission', mission.id)
end

function finishCurrentMissionPolice()
    TriggerServerEvent('police:FinishMission', POLICE_currentMissions.id)
    POLICE_currentMissions = nil
    if POLICE_currentBlip ~= nil then
        RemoveBlip(POLICE_currentBlip)
    end
end

function updateMenuMissionPolice() 
    local items = {{['Title'] = 'Return', ['ReturnBtn'] = true }}
      for k,v in pairs(POLICE_listMissions) do
        Citizen.Trace('==>' .. k )
    end
    for _,m in pairs(POLICE_listMissions) do 
        local item = {
            Title = '' .. m.id .. ' - ' .. m.type,
            mission = m,
            Function = acceptMissionPolice
        }
        if #m.acceptBy ~= 0 then
            item.Title = item.Title .. ' (' .. #m.acceptBy ..' Unit)'
            item.TextColor = {39, 174, 96, 255}
        end
        table.insert(items, item)
        Citizen.Trace('add')
    end

    if POLICE_currentMissions ~= nil then
        table.insert(items, {['Title'] = 'Finish the mission', ['Function'] = finishCurrentMissionPolice})
    end
    table.insert(items, {['Title'] = 'Fermer'})

    menu = {['Title'] = 'Current missions',  ['SubMenu'] = {
        ['Title'] = 'Current mssions', ['Items'] = items
    }}
    updateMenuPolice(menu)
end

function callPolice(type)
    local myPed = GetPlayerPed(-1)
    local myCoord = GetEntityCoords(myPed)
    TriggerServerEvent('police:Call', myCoord.x, myCoord.y, myCoord.z, type)
end

RegisterNetEvent('police:MissionAccept')
AddEventHandler('police:MissionAccept', function (mission)
    POLICE_currentMissions = mission
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    POLICE_currentBlip = AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(POLICE_currentBlip, 58)
    SetBlipColour(POLICE_currentBlip, 5)
    SetBlipAsShortRange(POLICE_currentBlip, true)
    --SetBlipFlashes(POLICE_currentBlip,1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(POLICE_TEXT.Blip)
    EndTextCommandSetBlipName(POLICE_currentBlip)
    SetBlipAsMissionCreatorBlip(POLICE_currentBlip, true)

end)

RegisterNetEvent('police:MissionCancel')
AddEventHandler('police:MissionCancel', function ()
    POLICE_currentMissions = nil
    if POLICE_currentBlip ~= nil then
        RemoveBlip(POLICE_currentBlip)
    end
end)

RegisterNetEvent('police:MissionChange')
AddEventHandler('police:MissionChange', function (missions)
    if not isCopInService then
        return
    end 
    
    POLICE_listMissions = missions
    local nbMissionEnAttente = 0
    for _,m in pairs(POLICE_listMissions) do
        if #m.acceptBy == 0 then
            nbMissionEnAttente = nbMissionEnAttente + 1
        end
    end
    if nbMissionEnAttente == 0 then 
        POLICE_nbMissionEnAttenteText = POLICE_TEXT.InfoPoliceNoAppel
    else
        POLICE_nbMissionEnAttenteText = '~g~ ' .. nbMissionEnAttente .. ' ' .. POLICE_TEXT.InfoPoliceNbAppel
    end
  
    updateMenuMissionPolice()
end)

RegisterNetEvent('police:openMenu')
AddEventHandler('police:openMenu', function()
    if isCopInService then
        TriggerServerEvent('police:requestMission')
        openMenuPoliceGeneral()
    else
        showMessageInformation("~r~You must be in service to access the menu")
    end
end)

RegisterNetEvent('police:callPolice')
AddEventHandler('police:callPolice',function(data)
    callPolice(data.type)
end)

RegisterNetEvent('police:callPoliceCustom')
AddEventHandler('police:callPoliceCustom',function()
    local raison = openTextInput('','', 32)
    if raison ~= nil and raison ~= '' then 
        callPolice(raison)
    end
end)

RegisterNetEvent('police:callStatus')
AddEventHandler('police:callStatus',function(status)
    POLICE_CALL_ACCEPT_P = status
end)

RegisterNetEvent('police:personnelChange')
AddEventHandler('police:personnelChange',function(nbPersonnel, nbDispo)
    --Citizen.Trace('nbPersonnel : ' .. nbPersonnel .. ' dispo' .. nbDispo)
    POLICE_nbMechanicisInService = nbPersonnel
    POLICE_nbMechanicDispo = nbDispo
end)

RegisterNetEvent('police:cancelCall')
AddEventHandler('police:cancelCall',function(data)
    TriggerServerEvent('police:cancelCall')
end)

--====================================================================================
-- Initialisation
--====================================================================================


RegisterNetEvent('police:drawGetService')
AddEventHandler('police:drawGetService', function (source)
    isCopInService = not isCopInService
    --onServiceChangePolice()
    Citizen.Trace("DRAWDRAW")
    TriggerServerEvent('police:setService', isCopInService)
    if(existingVeh ~= nil) then
        SetEntityAsMissionEntity(existingVeh, true, true)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
        existingVeh = nil
    end
end)

RegisterNetEvent('police:getSkin')
AddEventHandler('police:getSkin', function (source)
    local playerPed = GetPlayerPed(-1)
    if (isCop and isCopInService) then
        SetPedComponentVariation(playerPed, 11, 55, 0, 2)  --Chemise Police
        SetPedComponentVariation(playerPed, 8, 58, 0, 2)   --Ceinture + matraque Police 
        SetPedComponentVariation(playerPed, 4, 35, 0, 2)   --Pantalon Police
        SetPedComponentVariation(playerPed, 6, 24, 0, 2)   -- Chaussure Police
        SetPedComponentVariation(playerPed, 10, 8, 0, 2)   --grade 0
        SetPedComponentVariation(playerPed, 3, 0, 0, 2)   -- under skin
        GiveWeaponToPed(playerPed, GetHashKey("WEAPON_NIGHTSTICK"), true, true)
        GiveWeaponToPed(playerPed, GetHashKey("WEAPON_PISTOL50"), 100, true, true)
        GiveWeaponToPed(playerPed, GetHashKey("WEAPON_STUNGUN"), true, true)
        GiveWeaponToPed(playerPed, GetHashKey("WEAPON_PUMPSHOTGUN"), 100, true, true)
    else
        TriggerServerEvent("mm:otherspawn")
        RemoveAllPedWeapons(GetPlayerPed(-1), true)
    end
end)

RegisterNetEvent('police:receiveIsCop')
AddEventHandler('police:receiveIsCop', function(result)
    if (result == "inconnu") then
        isCop = false
        isCopInService = false
        --onServiceChangePolice()
    else
        isCop = true
    end
end)

RegisterNetEvent('police:nowCop')
AddEventHandler('police:nowCop', function()
    isCop = true
    isCopInService = false
    --onServiceChangePolice()
    TriggerServerEvent("js:jobs", 2)
end)

RegisterNetEvent('police:noLongerCop')
AddEventHandler('police:noLongerCop', function()
    isCop = false
    isCopInService = false
    --onServiceChangePolice()
    TriggerServerEvent("mm:otherspawn")
    TriggerServerEvent("js:jobs", 1)
    if(existingVeh ~= nil) then
        SetEntityAsMissionEntity(existingVeh, true, true)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
        existingVeh = nil
    end
end)

RegisterNetEvent('police:postAmendes')
RegisterNetEvent('police:postAmendes', function(data)
    
end)

RegisterNetEvent('police:postAmendesCustom')
RegisterNetEvent('police:postAmendesCustom', function(data)
    
end)

AddEventHandler("playerSpawned", function(source)
    TriggerServerEvent("police:checkIsCop")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if (handCuffed == true) then
            RequestAnimDict('mp_arresting')
            SetPedComponentVariation(GetPlayerPed(-1), 7, 41, 0 ,0)

            while not HasAnimDictLoaded('mp_arresting') do
            Citizen.Wait(0)
            end
            
            local myPed = PlayerPedId()
            local animation = 'idle'
            local flags = 16

            TaskPlayAnim(myPed, 'mp_arresting', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
        end
    end
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

--====================================================================================
-- Action
--====================================================================================
function POLICE_Check()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:targetCheckInventory", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "No close player!")
    end
end

function POLICE_Cuffed()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:cuffGranted", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'GOVERNMENT', {255, 0, 0}, "No close player!")
    end
end
-- jail addon

function Arrest(amount)
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent('SentMeToJail', GetPlayerServerId(t), amount)
    else
        TriggerEvent('chatMessage', "^0[^1JAIL^0]", {0,0,0}, "No player near!")
    end
end

-- jail addon end

function DragPlayer()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:dragRequest", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', "GOVERNMENT", {255, 0, 0}, "No player near")
    end
end

function DMVcheck()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("dmv:policedmv", GetPlayerServerId(t))
    else
        exports.pNotify:SendNotification({text = "No player near",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
    end
end



function POLICE_Crocheter()
    Citizen.CreateThread(function()
        Citizen.Trace('POLICE_Crocheter')
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        --GetClosestVehicle(x,y,z,distance dectection, 0 = tous les vehicules, Flag 70 = tous les veicules sauf police a tester https://pastebin.com/kghNFkRi)
        veh = GetClosestVehicle(plyCoords["x"], plyCoords["y"], plyCoords["z"], 5.001, 0, 70)
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
        Citizen.Wait(20000)
        SetVehicleDoorsLocked(veh, 1)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        drawNotification("Doors have been unlocked.")
    end)
end

function POLICE_PutInVehicle()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        local v = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        TriggerServerEvent("police:forceEnterAsk", GetPlayerServerId(t), v)
    else
        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "No close player!")
    end
end

function POLICE_UnseatVehicle()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:confirmUnseat", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "No close player")
    end
end

function POLICE_CheckPlate()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
    if(DoesEntityExist(vehicleHandle)) then
        TriggerServerEvent("police:checkingPlate", GetVehicleNumberPlateText(vehicleHandle))
    else
        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "No vehicle nearby!")
    end
end

function Arrest_DATA(data)
    Arrest(data.amount)
end

function POLICE_FINE_DATA(data)
    POLICE_Fines(data.tarif, data.Title)
end

function customJailTime()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        local time = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
        if(time == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
            showLoadingPrompt("Enter a jail time..", 3)
            DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
            while (UpdateOnscreenKeyboard() == 0) do
                  DisableAllControlActions(0);
                Wait(0);
            end
            if (GetOnscreenKeyboardResult()) then
                local option = tonumber(GetOnscreenKeyboardResult())
                if(option ~= nil and option ~= 0) then
                    N_0x10d373323e5b9c0d() -- remove promt
                    time = ""..option
                    customtime = true         
                end
            end
        end
        stopLoadingPrompt()
        if time ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and customtime == true then
            JailReason(t,time)
        end
    else
        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "No player nearby!")
    end
end

function JailReason(target,jailtime)
    local reason = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
    local id = tonumber(target)
    local time = tonumber(jailtime)
    if(reason == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
        showLoadingPrompt("Enter a reason..", 3)
        DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 200)
        while (UpdateOnscreenKeyboard() == 0) do
              DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local res = tostring(GetOnscreenKeyboardResult())
            if(res ~= nil and res ~= 0 and res ~= "") then
                N_0x10d373323e5b9c0d() -- remove promt
                reason = res             
            end
        end
    end
    stopLoadingPrompt()        
    if(reason ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
        TriggerServerEvent("js:jailuser", GetPlayerServerId(id), time, reason)
    end
end

function add_Charge(data)
    if currentSuspectCharges[data.Title] == nil then
        currentSuspectCharges[data.Title] = {}
        currentSuspectCharges[data.Title].cost = data.cost
        currentSuspectCharges[data.Title].time = data.time
        currentSuspectCharges[data.Title].count = 1
    else
        currentSuspectCharges[data.Title].cost = currentSuspectCharges[data.Title].cost + data.cost
        currentSuspectCharges[data.Title].time = currentSuspectCharges[data.Title].time + data.time
        currentSuspectCharges[data.Title].count = currentSuspectCharges[data.Title].count + 1
    end

    ShowNotification("Added Charge: ~b~" .. data.Title)
end

function police_Review_Charges()

      local charges = {}
      local time = 0
      local cost = 0

      for key, val in pairs(currentSuspectCharges) do
            
            charges[#charges+1] = (" ^3[" .. currentSuspectCharges[key].count .. "x]^5 " .. key .. "")
            time = time + currentSuspectCharges[key].time
            cost = cost + currentSuspectCharges[key].cost
      end

      charges[#charges+1] = (" ^1||^0 Suggested Jailtime: ^3" .. time .. "^0 minutes ^1" .. "||^0 Suggested Cost: $^3" .. cost .. "")

      --TriggerEvent('chatMessage', "propertyCharges", { 255, 255, 0 }, table.concat(charges))

      --outputChatBox("[Charges]", table.concat(charges), { 255, 0 , 0}, { 255, 0 , 0});
      TriggerEvent('chatMessage', '[Charges]', {255, 0, 0}, table.concat(charges))
      return cost
end

function police_Apply_Charges()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then

        local charges = {}
        local time = 0
        local cost = 0

        for key, val in pairs(currentSuspectCharges) do
            
            charges[#charges+1] = (" ^3[" .. currentSuspectCharges[key].count .. "x]^5 " .. key .. "")
            time = time + currentSuspectCharges[key].time
            cost = cost + currentSuspectCharges[key].cost
        end

        charges[#charges+1] = (" ^1|| ^0 Cost: $^3" .. cost .. "")

        TriggerServerEvent("police:showCharges", GetPlayerServerId(t), charges)
        TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), amount, reason)
    else
        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "No close player!")
    end
end

function police_Clear_Charges()
    currentSuspectCharges = {}
    ShowNotification("~g~Charges Cleared")
end

function POLICE_FINE_CUSTOM()
    local r = openTextInput('','', 128)
    if r ~= nil and r ~= '' then
        local t = tonumber(openTextInput('','', 12))
        if t ~= nil and t > 0 then
            POLICE_Fines(t,r)
        end
    end
end

function POLICE_Fines(amount, reason)
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), amount, reason)
    else
        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "No close player!")
    end
end
--====================================================================================
-- Event 
--====================================================================================

RegisterNetEvent('police:payFines')
AddEventHandler('police:payFines', function(amount)
    TriggerServerEvent('bank:withdrawAmende', amount)
    TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "You paid $"..amount.." in fines")
end)

RegisterNetEvent('police:dropIllegalItem')
AddEventHandler('police:dropIllegalItem', function(id)
    TriggerEvent("player:looseItem", tonumber(id), exports.vdk_inventory:getQuantity(id))
end)

RegisterNetEvent('police:unseatme')
AddEventHandler('police:unseatme', function(t)
    local ped = GetPlayerPed(t)         
    ClearPedTasksImmediately(ped)
    plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
    local xnew = plyPos.x + 2
    local ynew = plyPos.y + 2
    
    SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

RegisterNetEvent('police:forcedEnteringVeh')
AddEventHandler('police:forcedEnteringVeh', function()
    if(handCuffed) then
        -- local pos = GetEntityCoords(GetPlayerPed(-1), 0)
        -- local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0, 3.0, 0.0)
        -- local rayHandle = Cast_3dRayPointToPoint(pos.x, pos.y, pos.z-1, entityWorld.x, entityWorld.y, entityWorld.z,5, 10, player, 0)
        -- local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
        local ped = GetPlayerPed(-1)
        local coordFrom =GetOffsetFromEntityInWorldCoords( ped, 0.0, 0.0, 0.0 )
        local coordTo = GetOffsetFromEntityInWorldCoords( ped, 0.0, 3.0, -0.8 )
        local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
        local _, _, _, _, vehicleHandle = GetRaycastResult( rayHandle )
        if vehicleHandle ~= nil then
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 2)
            TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "In the car")
        end
    end
end)

RegisterNetEvent('police:resultAllCopsInService')
AddEventHandler('police:resultAllCopsInService', function(array)
    allServiceCops = array
    enableCopBlips()
end)

function enableCopBlips()

    -- for k, existingBlip in pairs(blipsCops) do
        -- RemoveBlip(existingBlip)
    -- end
    -- blipsCops = {}
    
    -- local localIdCops = {}
    -- for id = 0, 64 do
        -- if(NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
            -- for i,c in pairs(allServiceCops) do
                -- if(i == GetPlayerServerId(id)) then
                    -- localIdCops[id] = c
                    -- break
                -- end
            -- end
        -- end
    -- end
    
    -- for id, c in pairs(localIdCops) do
        -- local ped = GetPlayerPed(id)
        -- local blip = GetBlipFromEntity(ped)
        
        -- if not DoesBlipExist( blip ) then

            -- blip = AddBlipForEntity( ped )
            -- SetBlipSprite( blip, 1 )
            -- Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
            -- HideNumberOnBlip( blip )
            -- SetBlipNameToPlayerName( blip, id )
            
            -- SetBlipScale( blip,  0.85 )
            -- SetBlipAlpha( blip, 255 )
            
            -- table.insert(blipsCops, blip)
        -- else
            
            -- blipSprite = GetBlipSprite( blip )
            
            -- HideNumberOnBlip( blip )
            -- if blipSprite ~= 1 then
                -- SetBlipSprite( blip, 1 )
                -- Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
            -- end
            
            -- Citizen.Trace("Name : "..GetPlayerName(id))
            -- SetBlipNameToPlayerName( blip, id )
            -- SetBlipScale( blip,  0.85 )
            -- SetBlipAlpha( blip, 255 )
            
            -- table.insert(blipsCops, blip)
        -- end
    -- end
end

--====================================================================================
-- Initialisation
--====================================================================================


TriggerServerEvent('police:requestPersonnel')
--TriggerServerEvent("police:checkIsCop")

-- Register a network event 
RegisterNetEvent( 'deleteVehicle' )

-- The distance to check in front of the player for a vehicle
-- Distance is in GTA units, which are quite big  
local distanceToCheck = 5.0

-- Add an event handler for the deleteVehicle event. 
-- Gets called when a user types in /dv in chat (see server.lua)
function POLICE_deleteVehicle()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )
        -- log( "Player is at:\nX: " .. pos.x .. " Y: " .. pos.y .. " Z: " .. pos.z )
        -- log( "Found vehicle?: " .. tostring( DoesEntityExist( vehicle ) ) )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                ShowNotification( "Delete vehicle." )
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )
            else 
                ShowNotification( "Put yourself in the driver's seat" )
            end 
        else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                -- log( "Distance between ped and vehicle: " .. tostring( GetDistanceBetween( ped, vehicle ) ) )
                ShowNotification( "Vehicle deleted." )
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )
            else 
                ShowNotification( "Get closer to a vehicle" )
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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(1, 323) then --Start holding X
            if IsPedInAnyVehicle(LocalPed(), true) == false then
                Citizen.Wait(0200)
                RequestAnimDict( 'random@arrests@busted' )
                while not HasAnimDictLoaded('random@arrests@busted') do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded('random@arrests@busted') then
                    local wep = GetSelectedPedWeapon(GetPlayerPed(-1))
                    TaskHandsUp(GetPlayerPed(-1), 10000, -1, -1, true)
                    Citizen.Wait(2000)
                    SetPedDropsInventoryWeapon(GetPlayerPed(-1), wep, 0, 2.0, 0, -1) --drop weapon on the ground
                    GiveWeaponToPed(GetPlayerPed(-1), 0xA2719263, 0, 0, 1) --set unarmed
                    ShowNotification("~w~You dropped your ~r~weapon ~w~on the ground")
                    Citizen.Wait(2000)
                    TaskPlayAnim( GetPlayerPed(-1), 'random@arrests@busted', 'enter' ,8.0, -8.0, -1, 0, 0, false, false, false )
                    Citizen.Wait(1000)
                    TaskPlayAnim( GetPlayerPed(-1), 'random@arrests@busted', 'idle_a' ,8.0, -8.0, -1, 0, 0, false, false, false )
                    Citizen.Wait(1000)
                    TaskPlayAnim( GetPlayerPed(-1), 'random@arrests@busted', 'idle_b' ,8.0, -8.0, -1, 0, 0, false, false, false )
                    Citizen.Wait(5000)
                    TaskPlayAnim( GetPlayerPed(-1), 'random@arrests@busted', 'idle_c' ,8.0, -8.0, -1, 0, 0, false, false, false )
                    Citizen.Wait(3000)
                    TaskPlayAnim( GetPlayerPed(-1), 'random@arrests@busted', 'exit' ,8.0, -8.0, -1, 0, 0, false, false, false )
                    Citizen.Wait(8000)
                end -- Perform animation.
            end
        end
        if IsControlPressed(1, 29) then --Start holding B
            if IsPedInAnyVehicle(LocalPed(), true) == false then
                TaskToggleDuck(GetPlayerPed(-1), 1000, -1, -1, true) -- Perform animation.
                RequestAnimDict( 'gestures@f@standing@casual' )
                while not HasAnimDictLoaded('gestures@f@standing@casual') do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded('gestures@f@standing@casual') then
                    TaskPlayAnim( GetPlayerPed(-1), 'gestures@f@standing@casual', 'gesture_point' ,8.0, -8.0, -1, 0, 0, false, false, false )
                end
            end
        end
        
    end
end)


--[[---------------------------------------------------------------------------------
||                                                                                  ||
||                          SPEEDCAMERA SCRIPT - GTA5 - FiveM                       ||
||                                   Author = Shedow                                ||
||                            Created for N3MTV community                           ||
||                                                                                  ||
----------------------------------------------------------------------------------]]--
 
local maxSpeed = 0
-- local minSpeed = 0
local info = ""
local isRadarPlaced = false -- bolean to get radar status
local Radar -- entity object
local RadarBlip -- blip
local RadarPos = {} -- pos
local RadarAng = 0 -- angle
local LastPlate = ""
local LastVehDesc = ""
local LastSpeed = 0
local LastInfo = ""
 
local function GetPlayers2()
    local players = {}
    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end
 
local function GetClosestDrivingPlayerFromPos(radius, pos)
    local players = GetPlayers2()
    local closestDistance = radius or -1
    local closestPlayer = -1
    local closestVeh = -1
    for _ ,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local ped = GetPlayerPed(value)
            if GetVehiclePedIsUsing(ped) ~= 0 then
                local targetCoords = GetEntityCoords(ped, 0)
                local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], pos["x"], pos["y"], pos["z"], true)
                if(closestDistance == -1 or closestDistance > distance) then
                    closestVeh = GetVehiclePedIsUsing(ped)
                    closestPlayer = value
                    closestDistance = distance
                end
            end
        end
    end
    return closestPlayer, closestVeh, closestDistance
end
 
 
function radarSetSpeed(defaultText)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", defaultText or "", "", "", "", 5)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local gettxt = tonumber(GetOnscreenKeyboardResult())
        if gettxt ~= nil then
            return gettxt
        else
            ClearPrints()
            SetTextEntry_2("STRING")
            AddTextComponentString("~r~Please enter a correct number !")
            DrawSubtitleTimed(3000, 1)
            return
        end
    end
    return
end
 
 
local function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
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
 
function POLICE_radar()
    if isRadarPlaced then -- remove the previous radar if it exists, only one radar per cop
       
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), RadarPos.x, RadarPos.y, RadarPos.z, true) < 0.9 then -- if the player is close to his radar
       
            RequestAnimDict("anim@apt_trans@garage")
            while not HasAnimDictLoaded("anim@apt_trans@garage") do
               Wait(1)
            end
            TaskPlayAnim(GetPlayerPed(-1), "anim@apt_trans@garage", "gar_open_1_left", 1.0, -1.0, 5000, 0, 1, true, true, true) -- animation
       
            Citizen.Wait(2000) -- prevent spam radar + synchro spawn with animation time
       
            SetEntityAsMissionEntity(Radar, false, false)
           
            DeleteObject(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
            DeleteEntity(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
            Radar = nil
            RadarPos = {}
            RadarAng = 0
            isRadarPlaced = false
           
            RemoveBlip(RadarBlip)
            RadarBlip = nil
            LastPlate = ""
            LastVehDesc = ""
            LastSpeed = 0
            LastInfo = ""
           
        else
           
            ClearPrints()
            SetTextEntry_2("STRING")
            AddTextComponentString("~r~You are not next to your Radar !")
            DrawSubtitleTimed(3000, 1)
           
            Citizen.Wait(1500) -- prevent spam radar
       
        end
   
    else -- or place a new one
        maxSpeed = radarSetSpeed("50")
       
        Citizen.Wait(200) -- wait if the player was in moving
        RadarPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.5, 0)
        RadarAng = GetEntityRotation(GetPlayerPed(-1))
       
        if maxSpeed ~= nil then -- maxSpeed = nil only if the player hasn't entered a valid number
       
            RequestAnimDict("anim@apt_trans@garage")
            while not HasAnimDictLoaded("anim@apt_trans@garage") do
               Wait(1)
            end
            TaskPlayAnim(GetPlayerPed(-1), "anim@apt_trans@garage", "gar_open_1_left", 1.0, -1.0, 5000, 0, 1, true, true, true) -- animation
           
            Citizen.Wait(1500) -- prevent spam radar placement + synchro spawn with animation time
           
            RequestModel("prop_cctv_pole_01a")
            while not HasModelLoaded("prop_cctv_pole_01a") do
               Wait(1)
            end
           
            Radar = CreateObject(1927491455, RadarPos.x, RadarPos.y, RadarPos.z - 7, true, true, true) -- http://gtan.codeshock.hu/objects/index.php?page=1&search=prop_cctv_pole_01a
            SetEntityRotation(Radar, RadarAng.x, RadarAng.y, RadarAng.z - 115)
            -- SetEntityInvincible(Radar, true) -- doesn't work, radar still destroyable
            -- PlaceObjectOnGroundProperly(Radar) -- useless
            SetEntityAsMissionEntity(Radar, true, true)
           
            FreezeEntityPosition(Radar, true) -- set the radar invincible (yeah, SetEntityInvincible just not works, okay FiveM.)
 
            isRadarPlaced = true
           
            RadarBlip = AddBlipForCoord(RadarPos.x, RadarPos.y, RadarPos.z)
            SetBlipSprite(RadarBlip, 380) -- 184 = cam
            SetBlipColour(RadarBlip, 1) -- https://github.com/Konijima/WikiFive/wiki/Blip-Colors
            SetBlipAsShortRange(RadarBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Radar")
            EndTextCommandSetBlipName(RadarBlip)
       
        end
       
    end
end
 
Citizen.CreateThread(function()
    while true do
        Wait(0)
 
        if isRadarPlaced then
       
            if HasObjectBeenBroken(Radar) then -- check is the radar is still there
               
                SetEntityAsMissionEntity(Radar, false, false)
                SetEntityVisible(Radar, false)
                DeleteObject(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
                DeleteEntity(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
               
                Radar = nil
                RadarPos = {}
                RadarAng = 0
                isRadarPlaced = false
               
                RemoveBlip(RadarBlip)
                RadarBlip = nil
               
                LastPlate = ""
                LastVehDesc = ""
                LastSpeed = 0
                LastInfo = ""
               
            end
           
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), RadarPos.x, RadarPos.y, RadarPos.z, true) > 100 then -- if the player is too far from his radar
           
                SetEntityAsMissionEntity(Radar, false, false)
                SetEntityVisible(Radar, false)
                DeleteObject(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
                DeleteEntity(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
               
                Radar = nil
                RadarPos = {}
                RadarAng = 0
                isRadarPlaced = false
               
                RemoveBlip(RadarBlip)
                RadarBlip = nil
               
                LastPlate = ""
                LastVehDesc = ""
                LastSpeed = 0
                LastInfo = ""
               
                ClearPrints()
                SetTextEntry_2("STRING")
                AddTextComponentString("~r~Too far from your radar !")
                DrawSubtitleTimed(3000, 1)
               
            end
           
        end
       
        if isRadarPlaced then
 
            local viewAngle = GetOffsetFromEntityInWorldCoords(Radar, -8.0, -4.4, 0.0) -- forwarding the camera angle, to increase or reduce the distance, just make a cross product like this one :  ( X * 11.0 ) / 20.0 = Y   gives  (Radar, X, Y, 0.0)
            local ply, veh, dist = GetClosestDrivingPlayerFromPos(20, viewAngle) -- viewAngle
 
            -- local debuginfo = string.format("%s ~n~%s ~n~%s ~n~", ply, veh, dist)
            -- drawTxt(0.27, 0.1, 0.185, 0.206, 0.40, debuginfo, 255, 255, 255, 255)
 
            if veh ~= nil then
           
                local vehPlate = GetVehicleNumberPlateText(veh) or ""
                local vehSpeedMph= GetEntitySpeed(veh)*2.236936
                local vehDesc = GetDisplayNameFromVehicleModel(GetEntityModel(veh)).." "..GetVehicleColor(veh)
                if vehDesc == "CARNOTFOUND" then vehDesc = "" end
               
                -- local vehSpeedMph= GetEntitySpeed(veh)*2.236936
                -- if vehSpeedMph > minSpeed then            
                     
                if vehSpeedMph < maxSpeed then
                    info = string.format("~b~Vehicle  ~w~ %s ~n~~b~Plate    ~w~ %s ~n~~y~Mp/h        ~g~%s", vehDesc, vehPlate, math.ceil(vehSpeedMph))
                else
                    info = string.format("~b~Vehicle  ~w~ %s ~n~~b~Plate    ~w~ %s ~n~~y~Mp/h        ~r~%s", vehDesc, vehPlate, math.ceil(vehSpeedMph))
                    if LastPlate ~= vehPlate then
                        LastSpeed = vehSpeedMph
                        LastVehDesc = vehDesc
                        LastPlate = vehPlate
                    elseif LastSpeed < vehSpeedMph and LastPlate == vehPlate then
                            LastSpeed = vehSpeedMph
                    end
                    LastInfo = string.format("~b~Vehicle  ~w~ %s ~n~~b~Plate    ~w~ %s ~n~~y~Mp/h        ~r~%s", LastVehDesc, LastPlate, math.ceil(LastSpeed))
                end
                   
                DrawRect(0.76, 0.0455, 0.18, 0.09, 0,10, 28, 210)
                drawTxt(0.77, 0.1, 0.185, 0.206, 0.40, info, 255, 255, 255, 255)
               
                DrawRect(0.76, 0.145, 0.18, 0.09, 0,10, 28, 210)
                drawTxt(0.77, 0.20, 0.185, 0.206, 0.40, LastInfo, 255, 255, 255, 255)
                 
                -- end
               
            end
           
        end
           
    end  
end)

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
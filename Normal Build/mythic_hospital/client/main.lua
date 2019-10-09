local HospitalCheckin = vector3(347.46362304688, -1413.2648925781, 32.429145812988),
local BedOccupying = nil
local BedOccupyingData = nil
local Cam = nil
local InBedDict = "anim@gangops@morgue@table@"
local InBedAnim = "ko_front"
local GetOutDict = 'switch@franklin@bed'
local GetOutAnim = 'sleep_getup_rubeyes'

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LeaveBed()
    RequestAnimDict(GetOutDict)
    while not HasAnimDictLoaded(GetOutDict) do
        Citizen.Wait(0)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityHeading(PlayerPedId(), BedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), GetOutDict , GetOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('mythic_hospital:server:LeaveBed', BedOccupying)

    BedOccupying = nil
    BedOccupyingData = nil
end

RegisterNetEvent('mythic_hospital:client:RPCheckPos')
AddEventHandler('mythic_hospital:client:RPCheckPos', function()
    TriggerServerEvent('mythic_hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('mythic_hospital:client:RPSendToBed')
AddEventHandler('mythic_hospital:client:RPSendToBed', function(id, data)
    BedOccupying = id
    BedOccupyingData = data

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z - 0.5)
    
    RequestAnimDict(InBedDict)
    while not HasAnimDictLoaded(InBedDict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), InBedDict , InBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(Cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(Cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(Cam, 90.0)
    SetCamRot(Cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)
            

    Citizen.CreateThread(function()
        while BedOccupyingData ~= nil do
            Citizen.Wait(1)
            DisplayHelpText('Press ~INPUT_CONTEXT~ to get up')
            if IsControlJustReleased(0, 54) then
                LeaveBed()
            end
        end
    end)
end)

RegisterNetEvent('mythic_hospital:client:SendToBed')
AddEventHandler('mythic_hospital:client:SendToBed', function(id, data)
    BedOccupying = id
    BedOccupyingData = data

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z - 0.3)
    RequestAnimDict(InBedDict)
    while not HasAnimDictLoaded(InBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), InBedDict , InBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(Cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(Cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(Cam, 90.0)
    SetCamRot(Cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        exports['mythic_notify']:DoHudText('inform', 'Doctors Are Treating You')
        Citizen.Wait(30000)
        TriggerServerEvent('mythic_hospital:server:EnteredBed')
    end)
end)

RegisterNetEvent('mythic_hospital:client:FinishServices')
AddEventHandler('mythic_hospital:client:FinishServices', function()
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
    TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    exports['mythic_notify']:DoHudText('inform', 'You\'ve Been Treated & Billed')
    LeaveBed()
end)

RegisterNetEvent('mythic_hospital:client:ForceLeaveBed')
AddEventHandler('mythic_hospital:client:ForceLeaveBed', function()
    LeaveBed()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
			local PlayerPosition = GetEntityCoords(PlayerPedId(), 0)
            if #(HospitalCheckin - PlayerPosition) < 10 then
                exports.core_modules:RenderMarker(25, HospitalCheckin.x, HospitalCheckin.y, HospitalCheckin.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
                if not IsPedInAnyVehicle(PlayerPedId(), true) then
                    if #(HospitalCheckin - PlayerPosition) < 1 then
                        DisplayHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
                        if IsControlJustReleased(0, 54) then
                            if (GetEntityHealth(PlayerPedId()) < 200) or (IsInjuredOrBleeding()) then
                                exports['mythic_progbar']:Progress({
                                    name = "hospital_action",
                                    duration = 10500,
                                    label = "Checking In",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "p_amb_clipboard_01",
                                        bone = 18905,
										coords = { x = 0.10, y = 0.02, z = 0.08 },
										rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                    propTwo = {
                                        model = "prop_pencil_01",
                                        bone = 58866,
										coords = { x = 0.12, y = 0.0, z = 0.001 },
										rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                    },
                                }, function(status)
                                    if not status then
                                        TriggerServerEvent('mythic_hospital:server:RequestBed')
                                    end
                                end)
                            else
                                exports['mythic_notify']:DoHudText('error', 'You do not need medical attention')
                            end
                        end
                    end
                end
            else
                Citizen.Wait(1000)
            end
    end
end)
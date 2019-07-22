--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--Make ems cars undrivable for civs
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not isParamedic then
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                local vehicle = GetVehiclePedIsUsing(PlayerPedId(), false)
                if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                    for k,v in pairs(cars) do
                        if GetHashKey(v.model) == GetEntityModel(vehicle) then
                            drawText("~r~It's against the rules for civilians to drive these vehicles!", 6, 0.45 , 0.5, 0.5, 255, 255, 255, 255, false, true)
                            SetVehicleUndriveable(vehicle, true)
                        end
                    end
                end
            end
        end
    end
end)
--==============================================================================================================================--
--Dragging
drag = false
draggedBy = -1
wasDragged = false

RegisterNetEvent('paramedic:drag')
AddEventHandler('paramedic:drag', function(_source)
    drag = not drag
    draggedBy = _source
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if drag then
            wasDragged = true
			AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(draggedBy)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
            if not IsPedInParachuteFreeFall(PlayerPedId()) and wasDragged then
                wasDragged = false
                DetachEntity(PlayerPedId(), true, false)    
            end
		end
	end
end)
--==============================================================================================================================--
--Forced entry of a vehicle
RegisterNetEvent('paramedic:force')
AddEventHandler('paramedic:force', function(_type)
    local pos = GetEntityCoords(PlayerPedId(), false)
    if _type == "in" then
    	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

    	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

    	if vehicleHandle ~= nil then
            local total_seats, used_seats = GetVehicleMaxNumberOfPassengers(vehicleHandle), GetVehicleNumberOfPassengers(vehicleHandle)
            if total_seats ~= used_seats then
                for i = -1, total_seats do
                    if IsVehicleSeatFree(vehicleHandle, i) and i ~= -1 then
                        SetPedIntoVehicle(PlayerPedId(), vehicleHandle, i)
                        break
                    end
                end
            end
    	end
    elseif _type == "out" then
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            SetEntityCoords(PlayerPedId(), pos.x + 2.0, pos.y + 2.0, pos.z)
        end
    end
end)
--==============================================================================================================================--
--Heal
RegisterNetEvent("paramedic:heal")
AddEventHandler("paramedic:heal", function()
    SetEntityHealth(PlayerPedId(), GetPedMaxHealth(PlayerPedId()))
    SetEntityInvincible(PlayerPedId(), false)
    DisablePlayerFiring(PlayerId(), false)
    ClearPedBloodDamage(PlayerPedId())
    TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    local coord = GetEntityCoords(PlayerPedId(), false)
    local head = GetEntityHeading(PlayerPedId())
    NetworkResurrectLocalPlayer(coord.x, coord.y, coord.z, head, true, false)
    local bars = exports.core_modules:getBars()
    if bars[1] < 21 or bars[2] < 21 then
    	TriggerEvent('fm:drink', 21)
    	TriggerEvent('fm:eat', 21)
    end
    secondsRemaining = -1
end)
--==============================================================================================================================--
--Weapons
RegisterNetEvent("paramedic:weapons")
AddEventHandler("paramedic:weapons", function()
    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_FLASHLIGHT"), 250, 0, false)
    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_STUNGUN"), 250, 0, false)
    SetPedArmour(PlayerPedId(), 100)
end)
--==============================================================================================================================--
--DOA
RegisterNetEvent("paramedic:requestdoa")
AddEventHandler("paramedic:requestdoa", function(sender)
    Citizen.CreateThread(function()
        local start, answered = GetGameTimer(), false
        SetInstructionalButtons({
            {GetControlInstructionalButton(1, 7, 0), "No"},
            {GetControlInstructionalButton(1, 246, 0), "Do you accept being pronounced dead? | Yes"},
        }, 0)
        while GetTimeDifference(GetGameTimer(), start) < 30000 and not answered do
            Citizen.Wait(0)
            DrawInstructionalButtons()

            if IsControlJustPressed(1, 246) then
                answered = true
                TriggerServerEvent("paramedic:acceptdoa", sender, true)
            elseif IsControlJustPressed(1, 7) then
                answered = true
                TriggerServerEvent("paramedic:acceptdoa", sender, false)
            end
        end
        if not answered then
            TriggerServerEvent("paramedic:acceptdoa", sender, false)
        end
    end)
end)
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterNetEvent("paramedic:lifesupport")
AddEventHandler("paramedic:lifesupport", function(time)
    SetEntityHealth(PlayerPedId(), GetPedMaxHealth(PlayerPedId()))
    SetEntityInvincible(PlayerPedId(), false)
    DisablePlayerFiring(PlayerId(), false)
    ClearPedBloodDamage(PlayerPedId())
    NetworkResurrectLocalPlayer(253.01351928711, -1364.8498535156, 39.534378051758, 138.13046264648, true, false)
    local bars = exports.core_modules:getBars()
    if bars[1] < 21 or bars[2] < 21 then
        TriggerEvent('fm:drink', 21)
        TriggerEvent('fm:eat', 21)
    end
    secondsRemaining = -1
    Notify("You have been put on life support!", 3000)
    Citizen.CreateThread(function()
        local start = GetGameTimer()
        while math.floor(GetTimeDifference(GetGameTimer(), start)*0.001) < time do
            Citizen.Wait(0)
            local position = GetEntityCoords(PlayerPedId(), false)
            Draw3DText(position.x, position.y, position.z + 1.1, "~b~"..time - math.floor(GetTimeDifference(GetGameTimer(), start)*0.001), 0.5)
            if not exports.core_modules:IsInZone("hospital") then
                SetEntityCoords(PlayerPedId(), 253.01351928711, -1364.8498535156, 39.534378051758)
                SetEntityHeading(PlayerPedId(), 138.13046264648)
            end
        end
    end)
end)
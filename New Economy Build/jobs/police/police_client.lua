isCop = false
isCopInService = false
local rank = "inconnu"
local checkpoints = {}
local existingVeh = nil
local handCuffed = false
local isHandCuffed = false
local isAlreadyDead = false
local allServiceCops = {}
local blipsCops = {}
local drag = false
local officerDrag = -1

local takingService = {
  {x=850.156677246094, y=-1283.92004394531, z=28.0047378540039},
  {x=457.956909179688, y=-992.72314453125, z=30.6895866394043},
  {x=1856.91320800781, y=3689.50073242188, z=34.2670783996582},
  {x=-450.063201904297, y=6016.5751953125, z=31.7163734436035}
}

local stationGarage = {
	{x=452.115966796875, y=-1018.10681152344, z=28.4786586761475},
	{x=1868.16, y=3683.34, z=33.6837}
}

AddEventHandler("playerSpawned", function()
	TriggerServerEvent("police:checkIsCop")
end)

RegisterNetEvent('police:toggleDrag')
AddEventHandler('police:toggleDrag', function(t)
	if(handCuffed) then
		drag = not drag
		officerDrag = t
	end
end)

RegisterNetEvent('police:receiveIsCop')
AddEventHandler('police:receiveIsCop', function(result)
	Citizen.Trace('isCopisCopisCopisCopisCopisCopisCop')
	if(result == "inconnu") then
		isCop = false
	else
		isCop = true
		rank = result
	end
end)

RegisterNetEvent('police:nowCop')
AddEventHandler('police:nowCop', function()
	isCop = true
end)

RegisterNetEvent('police:noLongerCop')
AddEventHandler('police:noLongerCop', function()
	isCop = false
	isCopInService = false
	
	local playerPed = GetPlayerPed(-1)
						
	TriggerServerEvent("mm:otherspawn")
	SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)
	RemoveAllPedWeapons(playerPed)
	
	if(existingVeh ~= nil) then
		SetEntityAsMissionEntity(existingVeh, true, true)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end
	
	ServiceOff()
end)

---cones

local spikes_deployed = false
local obj1 = nil
local obj2 = nil
local obj3 = nil

function cones()
    TriggerEvent("police:DeployC")
end
RegisterNetEvent("police:DeployC")
AddEventHandler("police:DeployC", function()
    Citizen.CreateThread(function()
        if not spikes_deployed then
            local spikes = GetHashKey("prop_mp_cone_02")
            RequestModel(spikes)
            while not HasModelLoaded(spikes) do
                Citizen.Wait(0)
            end
            exports.pNotify:SendNotification({text = "Deploying cones!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            local playerheading = GetEntityHeading(GetPlayerPed(-1))
            coords1 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 3, 10, -0.7)
            coords2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -5, -0.5)
            obj1 = CreateObject(spikes, coords1['x'], coords1['y'], coords1['z'], true, true, true)
            obj2 = CreateObject(spikes, coords2['x'], coords2['y'], coords2['z'], true, true, true)
            obj3 = CreateObject(spikes, coords2['x'], coords2['y'], coords2['z'], true, true, true)
            SetEntityHeading(obj1, playerheading)
            SetEntityHeading(obj2, playerheading)
            SetEntityHeading(obj3, playerheading)
            AttachEntityToEntity(obj1, GetPlayerPed(-1), 1, 0.0, 4.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(obj2, GetPlayerPed(-1), 1, 0.0, 8.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(obj3, GetPlayerPed(-1), 1, 0.0, 12.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            Citizen.Wait(10)
            DetachEntity(obj1, true, true)
            DetachEntity(obj2, true, true)
            DetachEntity(obj3, true, true)
            spikes_deployed = true
        else
            spikes_deployed = false
            exports.pNotify:SendNotification({text = "Removing cones!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            SetEntityCoords(obj1, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(obj2, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(obj3, -5000.0, -5000.0, 20.0, true, false, false, true)
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj1))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj2))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj3))
            FIX_DeleteObject(obj1)
            FIX_DeleteObject(obj2)
            FIX_DeleteObject(obj3)
            obj1 = nil
            obj2 = nil
            obj3 = nil
        end
    end)
end)

---Make all peds fuck off at the sight of cones
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local o1x, o1y, o1z = table.unpack(GetEntityCoords(obj1, true))
        local cVeh = GetClosestVehicle(o1x, o1y, o1z, 50.1, 0, 70)
        if(IsEntityAVehicle(cVeh)) then
            if IsEntityAtEntity(cVeh, obj1, 20.0, 6.0, 2.0, 0, 1, 0) then
                local cDriver = GetPedInVehicleSeat(cVeh, -1)
                TaskVehicleTempAction(cDriver, cVeh, 6, 1000)
                SetVehicleHandbrake(cVeh, true)
            end
        end
        local o2x, o2y, o2z = table.unpack(GetEntityCoords(obj2, true))
        local cVeh2 = GetClosestVehicle(o2x, o2y, o2z, 50.1, 0, 70)
        if(IsEntityAVehicle(cVeh2)) then
            if IsEntityAtEntity(cVeh2, obj2, 20.0, 6.0, 2.0, 0, 1, 0) then
                local cDriver = GetPedInVehicleSeat(cVeh2, -1)
                TaskVehicleTempAction(cDriver, cVeh2, 6, 1000)
                SetVehicleHandbrake(cVeh2, true)
            end
        end
        local o3x, o3y, o3z = table.unpack(GetEntityCoords(obj3, true))
        local cVeh3 = GetClosestVehicle(o3x, o3y, o3z, 50.1, 0, 70)
        if(IsEntityAVehicle(cVeh3)) then
            if IsEntityAtEntity(cVeh3, obj3, 20.0, 6.0, 2.0, 0, 1, 0) then
                local cDriver = GetPedInVehicleSeat(cVeh3, -1)
                TaskVehicleTempAction(cDriver, cVeh3, 6, 1000)
                SetVehicleHandbrake(cVeh3, true)
            end
        end
    end
end)

--cones

local spikes_deployed = false
local obj1 = nil
local obj2 = nil
local obj3 = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if spikes_deployed then
            for peeps = 0, 64 do
                if NetworkIsPlayerActive(GetPlayerFromServerId(peeps)) then
                    
                    local currentVeh = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false)
                    if currentVeh ~= nil and currentVeh ~= false then
                        local currentVehcoords = GetEntityCoords(currentVeh, true)
                        local obj1coords = GetEntityCoords(obj1, true)
                        local obj2coords = GetEntityCoords(obj2, true)
                        local obj3coords = GetEntityCoords(obj3, true)
                        local DistanceBetweenObj1 = Vdist(obj1coords['x'], obj1coords['y'], obj1coords['z'], currentVehcoords['x'], currentVehcoords['y'], currentVehcoords['z'])
                        local DistanceBetweenObj2 = Vdist(obj2coords['x'], obj2coords['y'], obj2coords['z'], currentVehcoords['x'], currentVehcoords['y'], currentVehcoords['z'])
                        local DistanceBetweenObj3 = Vdist(obj3coords['x'], obj3coords['y'], obj3coords['z'], currentVehcoords['x'], currentVehcoords['y'], currentVehcoords['z'])
                        if DistanceBetweenObj1 < 2.2 or DistanceBetweenObj2 < 2.2 or DistanceBetweenObj3 < 2.2 then
                            
							TriggerServerEvent("police:spikes", currentVeh, peeps)
                            --TriggerEvent("police:Deploy")
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("police:dietyres")
AddEventHandler("police:dietyres", function(currentVeh)
    SetVehicleTyreBurst(currentVeh, 0, true, 0)
    SetVehicleTyreBurst(currentVeh, 1, true, 1)
    SetVehicleTyreBurst(currentVeh, 2, true, 1)
    SetVehicleTyreBurst(currentVeh, 3, true, 1)
    SetVehicleTyreBurst(currentVeh, 4, true, 3)
    SetVehicleTyreBurst(currentVeh, 5, true, 4)
end)

RegisterNetEvent("police:dietyres2")
AddEventHandler("police:dietyres2", function(peeps)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 0, true, 0)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 1, true, 1)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 2, true, 1)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 3, true, 1)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 4, true, 3)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 5, true, 4)
end)

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        if IsPedInAnyPoliceVehicle(GetPlayerPed(PlayerId())) then
            local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
            if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
                if isCopInService == false and exports.emergency:getIsInService() == true then
                elseif isCopInService == true and exports.emergency:getIsInService() == false then
                elseif isCopInService == true and exports.emergency:getIsInService() == true then
                elseif isCopInService == false and exports.emergency:getIsInService() == false then
                    drawTxt("~r~It's against the rules for civilians to drive these vehicles!",0,1,0.5,0.8,0.6,255,255,255,255)           
                    SetVehicleUndriveable(veh, true)
                end
            end
        end
    end
end)


function spikes()
	TriggerEvent("police:Deploy")
end
RegisterNetEvent("police:Deploy")
AddEventHandler("police:Deploy", function()
    Citizen.CreateThread(function()
        if not spikes_deployed then
            local spikes = GetHashKey("p_stinger_04")
            RequestModel(spikes)
            while not HasModelLoaded(spikes) do
                Citizen.Wait(0)
            end
            local playerheading = GetEntityHeading(GetPlayerPed(-1))
            coords1 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 3, 10, -0.7)
            coords2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -5, -0.5)
            obj1 = CreateObject(spikes, coords1['x'], coords1['y'], coords1['z'], true, true, true)
            obj2 = CreateObject(spikes, coords2['x'], coords2['y'], coords2['z'], true, true, true)
            obj3 = CreateObject(spikes, coords2['x'], coords2['y'], coords2['z'], true, true, true)
			SetEntityHeading(obj1, playerheading)
            SetEntityHeading(obj2, playerheading)
            SetEntityHeading(obj3, playerheading)
            AttachEntityToEntity(obj1, GetPlayerPed(-1), 1, 0.0, 4.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(obj2, GetPlayerPed(-1), 1, 0.0, 8.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(obj3, GetPlayerPed(-1), 1, 0.0, 12.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            Citizen.Wait(10)
            DetachEntity(obj1, true, true)
            DetachEntity(obj2, true, true)
            DetachEntity(obj3, true, true)
            spikes_deployed = true
        else
        	spikes_deployed = false
            SetEntityCoords(obj1, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(obj2, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(obj3, -5000.0, -5000.0, 20.0, true, false, false, true)
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj1))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj2))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj3))
            DeleteObject(obj1)
            DeleteObject(obj2)
            DeleteObject(obj3)
            obj1 = nil
            obj2 = nil
            obj3 = nil
        end
	end)
end)



RegisterNetEvent('police:getArrested')
AddEventHandler('police:getArrested', function()
	if(isCop == false) then
		handCuffed = not handCuffed
		if(handCuffed) then
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "You are handcuffed")
			SetPedComponentVariation(GetPlayerPed(-1), 7, 41, 0 ,0)
			isHandCuffed = true
		else
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Freedom")
			SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0 ,0)
			drag = false
			isHandCuffed = false
		end
	end
end)

-- RegisterNetEvent('police:payFines')
-- AddEventHandler('police:payFines', function(amount, reason)
	-- --TriggerServerEvent('bank:withdrawAmende', amount)
	-- TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "You paid a $"..amount.." fine for" .. reason )
-- end)

RegisterNetEvent('police:dropIllegalItem')
AddEventHandler('police:dropIllegalItem', function(id)
	TriggerEvent("player:looseItem", tonumber(id), exports.vdk_inventory:getQuantity(id))
end)


RegisterNetEvent('police:unseatme')
AddEventHandler('police:unseatme', function(t)
    local ped = GetPlayerPed(t)        
    ClearPedTasksImmediately(ped)
    plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
    local xnew = plyPos.x+1
    local ynew = plyPos.y+1
   
    SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

RegisterNetEvent('police:forcedEnteringVeh')
AddEventHandler('police:forcedEnteringVeh', function(veh)
	if(handCuffed) then
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
		end
	end
end)

RegisterNetEvent('police:resultAllCopsInService')
AddEventHandler('police:resultAllCopsInService', function(array)
	allServiceCops = array
	enableCopBlips()
end)

function enableCopBlips()

	for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
	blipsCops = {}
	
	local localIdCops = {}
	for id = 0, 64 do
		if(NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
			for i,c in pairs(allServiceCops) do
				if(i == GetPlayerServerId(id)) then
					localIdCops[id] = c
					break
				end
			end
		end
	end
	
	for id, c in pairs(localIdCops) do
		local ped = GetPlayerPed(id)
		local blip = GetBlipFromEntity(ped)
		
		if not DoesBlipExist( blip ) then

			blip = AddBlipForEntity( ped )
			SetBlipSprite( blip, 1 )
			Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			HideNumberOnBlip( blip )
			SetBlipNameToPlayerName( blip, id )
			
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			
			table.insert(blipsCops, blip)
		else
			
			blipSprite = GetBlipSprite( blip )
			
			HideNumberOnBlip( blip )
			if blipSprite ~= 1 then
				SetBlipSprite( blip, 1 )
				Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			end
			
			Citizen.Trace("Name : "..GetPlayerName(id))
			SetBlipNameToPlayerName( blip, id )
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			
			table.insert(blipsCops, blip)
		end
	end
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
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

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function getIsInService()
	return isCopInService
end

function isNearTakeService()
	for i = 1, #takingService do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(takingService[i].x, takingService[i].y, takingService[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, takingService[i].x, takingService[i].y, takingService[i].z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

function isNearStationGarage()
	for i = 1, #stationGarage do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, stationGarage[i].x, stationGarage[i].y, stationGarage[i].z-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

function ServiceOn()
	isCopInService = true
	--TriggerServerEvent("jobssystem:jobs", 2)
	TriggerServerEvent("police:takeService")
end

function ServiceOff()
	isCopInService = false
	--TriggerServerEvent("jobssystem:jobs", 7)
	TriggerServerEvent("police:breakService")
	allServiceCops = {}
	
	for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
	blipsCops = {}
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isCop) then
			if(isNearTakeService()) then
			
				DisplayHelpText('Press ~INPUT_CONTEXT~ to go on service',0,1,0.5,0.8,0.6,255,255,255,255) -- ~g~E~s~
				if IsControlJustPressed(1,51) then
					--OpenMenuVest()
					MenuChoixPoliceService()
				end
			end
			-- if(isCopInService) then
				-- if IsControlJustPressed(1,166) then 
					-- OpenPoliceMenu()
				-- end
			-- end
			
			if(isCopInService) then
				if(isNearStationGarage()) then
					if(policevehicle ~= nil) then --existingVeh
						DisplayHelpText('Press ~INPUT_CONTEXT~ to get your vehicle',0,1,0.5,0.8,0.6,255,255,255,255)
					else
						DisplayHelpText('Press ~INPUT_CONTEXT~ to store your vehicle',0,1,0.5,0.8,0.6,255,255,255,255)
					end
					
					if IsControlJustPressed(1,51) then
						if(policevehicle ~= nil) then
							SetEntityAsMissionEntity(policevehicle, true, true)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(policevehicle))
							policevehicle = nil
						else
							--OpenVeh()
							MenuChoixPoliceVehicleCar()
						end
					end
				end
				
				
			end
		else
			if (handCuffed == true) then
			  RequestAnimDict('mp_arresting')

			  while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(0)
			  end

			  local myPed = PlayerPedId()
			  local animation = 'idle'
			  local flags = 16

			  TaskPlayAnim(myPed, 'mp_arresting', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
			end
			if drag then
				local ped = GetPlayerPed(GetPlayerFromServerId(officerDrag))
				local myped = GetPlayerPed(-1)
				AttachEntityToEntity(myped, ped, 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			else
				DetachEntity(GetPlayerPed(-1), true, false)		
			end
		end
    end
end)
--------------------------------------------------------------------------------
-------------------------------SPAWN HELI AND CHECK DEATH------------------------------
---------------------------------------------------------------------------------------
local alreadyDead = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isCop) then
			if(isCopInService) then
			
				-- if(IsPlayerDead(PlayerId())) then
					-- if(alreadyDead == false) then
						-- ServiceOff()
						-- alreadyDead = true
					-- end
				-- else
					-- alreadyDead = false
				-- end
			
				DrawMarker(1,449.113,-981.084,42.691,0,0,0,0,0,0,2.0,2.0,2.0,0,155,255,200,0,0,0,0)
			
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 449.113,-981.084,43.691, true ) < 5 then
					if(existingVeh ~= nil) then
						DisplayHelpText('Use ~INPUT_CONTEXT~ to store your helicopter',0,1,0.5,0.8,0.6,255,255,255,255)
					else
						DisplayHelpText('Use ~INPUT_CONTEXT~ to open helicopter garage',0,1,0.5,0.8,0.6,255,255,255,255)
					end
					
					if IsControlJustPressed(1,51)  then
						if(existingVeh ~= nil) then
							SetEntityAsMissionEntity(existingVeh, true, true)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
							existingVeh = nil
						else
							local car = GetHashKey("polmav")
							local ply = GetPlayerPed(-1)
							local plyCoords = GetEntityCoords(ply, 0)
							
							RequestModel(car)
							while not HasModelLoaded(car) do
									Citizen.Wait(0)
							end
							
							existingVeh = CreateVehicle(car, plyCoords["x"], plyCoords["y"], plyCoords["z"], 90.0, true, false)
							SetVehicleLivery(existingVeh, 0)
							local id = NetworkGetNetworkIdFromEntity(existingVeh)
							SetNetworkIdCanMigrate(id, true)
							TaskWarpPedIntoVehicle(ply, existingVeh, -1)
						end
					end
				end
			end
		end
    end
end)


--[Citizen.CreateThread(function()
    --while true do
        --Citizen.Wait(3000)
			--if not(isCopInService) then
				--local ply = GetPlayerPed(-1)
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PUMPSHOTGUN"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_ASSAULTRIFLE"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SNIPERRIFLE"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PISTOL50"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_PISTOL"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SMG"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_MICROSMG"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_CARBINERIFLE"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_SPECIALCARBINE"))
				--RemoveWeaponFromPed(ply, GetHashKey("WEAPON_COMBATPISTOL"))
			--end
	--end
--end)




Citizen.CreateThread(function()
	for i = 1, 12 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
end)

player_GSR_Active = false
player_GSR_LastShot = 0
player_GSR_ExpireTime = 15 -- Minutes
DecorRegister("GSR_Active", 2)
DecorSetBool(GetPlayerPed(-1), "GSR_Active", false)	
Citizen.CreateThread(function()

	local allowedWeapons = {"WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50", "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_ASSAULTRIFLE", "WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_PUMPSHOTGUN", "WEAPON_SAWNOFFSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_BULLPUPSHOTGUN","WEAPON_STUNGUN", "WEAPON_SNIPERRIFLE", "WEAPON_SMOKEGRENADE", "WEAPON_BZGAS", "WEAPON_MOLOTOV", "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_SNSPISTOL", "WEAPON_SPECIALCARBINE", "WEAPON_HEAVYPISTOL", "WEAPON_BULLPUPRIFLE", "WEAPON_HOMINGLAUNCHER", "WEAPON_PROXMINE", "WEAPON_SNOWBALL", "WEAPON_VINTAGEPISTOL", "WEAPON_DAGGER", "WEAPON_FIREWORK", "WEAPON_MUSKET", "WEAPON_MARKSMANRIFLE", "WEAPON_HEAVYSHOTGUN", "WEAPON_GUSENBERG", "WEAPON_HATCHET", "WEAPON_COMBATPDW", "WEAPON_KNUCKLE", "WEAPON_MARKSMANPISTOL", "WEAPON_BOTTLE", "WEAPON_FLAREGUN", "WEAPON_FLARE", "WEAPON_REVOLVER", "WEAPON_SWITCHBLADE", "WEAPON_MACHETE", "WEAPON_FLASHLIGHT", "WEAPON_MACHINEPISTOL", "WEAPON_DBSHOTGUN", "WEAPON_COMPACTRIFLE"}
	local previousAmmoCount = -1
	local previousWeapon = ""
	local lastEvidenceIndex = -1

	while true do
		Citizen.Wait(1)
		if IsControlPressed(0, 24) or IsControlPressed(0, 142) then
			local hasWeapon, currentWeapon = GetCurrentPedWeapon(GetPlayerPed(-1), 1)
			for i=1,#allowedWeapons do
                if currentWeapon == GetHashKey(allowedWeapons[i]) then
                	local ammoCount = GetAmmoInPedWeapon(GetPlayerPed(-1), GetHashKey(allowedWeapons[i]))
                	if ammoCount ~= previousAmmoCount then
                		previousAmmoCount = ammoCount	                    
	                    TriggerEvent("WeaponFired")
		            end
                end
            end
		end

		if player_GSR_Active then
			if player_GSR_LastShot + (player_GSR_ExpireTime * 1000 * 60) > GetGameTimer() then
				player_GSR_Active = false
				DecorSetBool(GetPlayerPed(-1), "GSR_Active", false)		
			end
		end
	end
end)

AddEventHandler("WeaponFired", function()

	ShowNotification("Weapon Fired")
	player_GSR_LastShot = GetGameTimer()

	if not player_GSR_Active then
		DecorSetBool(GetPlayerPed(-1), "GSR_Active", true)
	end

end)

function police_GSR_Test()
    pedIndex, distance = GetClosestPlayer()

    if(distance ~= -1 and distance < 3) then
    	local subject = GetPlayerPed(pedIndex)
    	local result = DecorGetBool(subject, "GSR_Active")
        
        if result then
        	exports.pNotify:SendNotification({text = "Subject tested positive for GSR",type = "info",queue = "error",timeout = 3000,layout = "centerRight"}) 
        else
        	exports.pNotify:SendNotification({text = "Subject tested NEGATIVE for GSR",type = "info",queue = "left",timeout = 3000,layout = "centerRight"}) 
        end

    else
        exports.pNotify:SendNotification({text = "No player near",type = "info",queue = "left",timeout = 3000,layout = "centerRight"}) 
    end
end

--Breathalyzer
DecorRegister("BAC_Active", 2)
DecorSetBool(GetPlayerPed(-1), "BAC_Active", false)	
BAC_level = 0
BAC_Active = false
BAC_Driving_Limit = 0.08
BAC_Removal_Rate = 0.0005

function police_Breathalyzer_Test()
    pedIndex, distance = GetClosestPlayer()

    if(distance ~= -1 and distance < 3) then
    	local subject = GetPlayerPed(pedIndex)
    	local result = DecorGetBool(subject, "BAC_Active")
        
        if result then
        	exports.pNotify:SendNotification({text = "Subject Tested POSITIVE for a BAC outside the legal limits",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
        else
        	exports.pNotify:SendNotification({text = "Subject Tested NEGATIVE for a BAC outside the legal limits",type = "info",queue = "left",timeout = 3000,layout = "centerRight"})
        end

    else
        exports.pNotify:SendNotification({text = "No player near",type = "info",queue = "left",timeout = 3000,layout = "centerRight"})
    end
end

function addBAC(amt)

	BAC_level = BAC_level + amt

	if BAC_level >= BAC_Driving_Limit then
		if not BAC_Active then
			BAC_Active = true
			DecorSetBool(GetPlayerPed(-1), "BAC_Active", true)	
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) -- Every Minute remove some BAC

		if BAC_level > 0 then
			BAC_level = BAC_level - BAC_Removal_Rate

			if BAC_level < 0 then
				BAC_level = 0
			end

			if BAC_level == 0 then
				BAC_Active = false
				DecorSetBool(GetPlayerPed(-1), "BAC_Active", false)	
			end
		end

	end
end)

--Jail
JailCoords = {1694.8, 2563.99, 45.57}
JailExit = {162.3504, -715.025, 42.02894}
JailTimeRemaining = 0

Citizen.CreateThread(function()	

	while true do
		Wait(5000)
		if JailTimeRemaining > 0 then

			JailTimeRemaining = JailTimeRemaining - 5

			if (GetDistanceBetweenCoords(JailCoords[1],JailCoords[2],JailCoords[3],GetEntityCoords(GetPlayerPed(-1))) > 75) then -- Move back to jail
					SetEntityCoords(GetPlayerPed(-1), JailCoords[1],JailCoords[2],JailCoords[3])
			end

			if JailTimeRemaining <= 0 then
				JailTimeRemaining = 0
				SetEntityCoords(GetPlayerPed(-1), JailExit[1],JailExit[2],JailExit[3])
			end
			RemoveAllPedWeapons(GetPlayerPed(-1),  true)
		end
	end
end)

RegisterNetEvent("SentMeToJail")
  AddEventHandler("SentMeToJail", function(timeInMinutes)
    Citizen.CreateThread(function()
        ShowNotification("You have been Jailed for ~b~" .. timeInMinutes .. "~s~ minutes.")
        JailTimeRemaining = timeInMinutes * 60
    end)
  end)


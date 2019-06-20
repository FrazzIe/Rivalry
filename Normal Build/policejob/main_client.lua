--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
isCop = false
isInService = false
existingVeh = nil
blipsCops = {}
allServiceCops = {}
ranks = {}
user_cop = {}

local takingService = {
	{name="Police Station", sprite = 60, colour = 28, x=457.956909179688, y=-992.72314453125, z=30.6895866394043},  -- Mission Row
	{name="Police Station", sprite = 60, colour = 28, x=-449.90, y=6016.22, z= 31.72}, -- Paleto Bay
	{name="Police Station", sprite = 60, colour = 28, x=1849.4110107422, y=3690.2810058594, z=34.267074584961}, -- Sandy Shores
	{name="Police Station", sprite = 60, colour = 28, x=-1113.65, y=-849.21, z=13.45}, -- San Andreas Ave
	{name="Police Station", sprite = 60, colour = 28, x=-561.28, y=-132.60, z=38.04}, -- Rockford Hills
	{name="Park Ranger Station", sprite = 175, colour = 39, x = 387.07974243164, y = 792.12249755859, z = 187.69355773926}, -- Park Ranger Station
}

RegisterNetEvent("police:setranks")
AddEventHandler("police:setranks", function(_ranks)
	ranks = _ranks
end)

RegisterNetEvent("police:set")
AddEventHandler("police:set", function(_data, _iscop, first)
	user_cop = _data
	isCop = _iscop
	if not isCop and isInService then
		isInService = false
		exports["core_modules"]:SetPolice(isCop, isInService)
		TriggerServerEvent("jobcenter:jobs", 1)
		TriggerServerEvent("police:setService", isInService)
		BlipRemoval()
		RemovePoliceBlips()
		TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
		if(existingVeh ~= nil) then
			SetEntityAsMissionEntity(existingVeh, true, true)
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
			existingVeh = nil
		end
	elseif not isCop and not isInService then
		if not first then
			TriggerServerEvent("jobcenter:jobs", 1)
			exports["core_modules"]:SetPolice(isCop, isInService)
		end
	elseif isCop then
		TriggerServerEvent("jobcenter:jobs", 2)
		exports["core_modules"]:SetPolice(isCop, isInService)
	end
end)

AddEventHandler("paramedic:dead", function()
	if isCop and isInService then
		isInService = false
		exports["core_modules"]:SetPolice(isCop, isInService)
		TriggerServerEvent("jobcenter:jobs", 1)
		TriggerServerEvent("police:setService", isInService)
		TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
		RemovePoliceBlips()
		BlipRemoval()
	end
end)

function isNearTakeService()
	for i = 1, #takingService do
		local pos = GetEntityCoords(GetPlayerPed(-1), 0)
		local distance = GetDistanceBetweenCoords(takingService[i].x, takingService[i].y, takingService[i].z, pos.x, pos.y, pos.z, true)
		if(distance < 30) then
			DrawMarker(25, takingService[i].x, takingService[i].y, takingService[i].z-0.9, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

Citizen.CreateThread(function()
    for _, item in pairs(takingService) do
    	addBlip(item)
    end
    while true do
        Citizen.Wait(0)
        if isCop then
			if isNearTakeService() then
				if isInService then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~r~off duty~w~.")
				else
					DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~g~on duty~w~.")
				end
				if IsControlJustReleased(1, 38)  then
					isInService = not isInService
					exports["core_modules"]:SetPolice(isCop, isInService)
					TriggerServerEvent("police:setService", isInService)
					
					if(isInService) then
						TriggerServerEvent("jobcenter:jobs", 2)
						TriggerServerEvent("PlayerCustomisation.ModelType", "Police")
						AddPoliceBlips()
					else
						TriggerServerEvent("jobcenter:jobs", 2)
						TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
						RemovePoliceBlips()
						BlipRemoval()
					end
				end
			end
		end
    end
end)

function enableCopBlips() --Needs worked on

	for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
	blipsCops = {}
	
	local localIdCops = {}
	for id = 0, 255 do
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

function BlipRemoval()
	allServiceCops = {}
	
	for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
	blipsCops = {}
end

RegisterNetEvent('police:resultAllCopsInService')
AddEventHandler('police:resultAllCopsInService', function(array)
	allServiceCops = array
	enableCopBlips()
end)

function AddPoliceBlips()
	ArmouryBlips()
	GarageBlips()
end

function RemovePoliceBlips()
	RemoveArmouryBlips()
	RemoveGarageBlips()
end

--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
isParamedic = false
isInService = false
existingVeh = nil
ranks = {}
user_paramedic = {}
-- Location to enable an officer service
local takingService = {
	{name = "Hospital", sprite = 61, colour = 2, x = 1155.26, y = -1520.82, z = 34.84},
	{name = "Hospital", sprite = 61, colour = 2, x = 365.32025146484, y = -1404.8325195313, z = 32.936241149902},
	{name = "Hospital", sprite = 61, colour = 2, x = -449.639, y = -340.586, z = 34.5018},
	{name = "Hospital", sprite = 61, colour = 2, x = -874.467, y = -307.896, z = 39.5699},
	{name = "Hospital", sprite = 61, colour = 2, x = -677.135, y = 310.275, z = 83.0842},
	{name = "Hospital", sprite = 61, colour = 2, x = 1839.5745849609, y = 3688.7849121094, z = 34.270038604736},
	{name = "Hospital", sprite = 61, colour = 2, x = -242.968, y = 6326.29, z = 32.4262},
	{name = "Hospital", sprite = 61, colour = 2, x = 337.56130981445, y = -576.15032958984, z = 43.328758239746},
}

RegisterNetEvent("paramedic:setranks")
AddEventHandler("paramedic:setranks", function(_ranks)
	ranks = _ranks
end)

RegisterNetEvent('paramedic:set')
AddEventHandler('paramedic:set', function(_data, _isparamedic, first)
	user_paramedic = _data
	isParamedic = _isparamedic
	if not isParamedic and isInService then
		isInService = false
		exports["core_modules"]:SetParamedic(isParamedic, isInService)
		TriggerServerEvent("jobcenter:jobs", 1)
		TriggerServerEvent("paramedic:setService", isInService)
		RemoveParamedicBlips()
		TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
		if(existingVeh ~= nil) then
			SetEntityAsMissionEntity(existingVeh, true, true)
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
			existingVeh = nil
		end
	elseif not isParamedic and not isInService then
		if not first then
			exports["core_modules"]:SetParamedic(isParamedic, isInService)
			TriggerServerEvent("jobcenter:jobs", 1)
		end
	elseif isParamedic then
		exports["core_modules"]:SetParamedic(isParamedic, isInService)
		TriggerServerEvent("jobcenter:jobs", 15)
	end
end)

function isNearTakeService()
	for i = 1, #takingService do
		local pos = GetEntityCoords(PlayerPedId(), 0)
		local distance = GetDistanceBetweenCoords(takingService[i].x, takingService[i].y, takingService[i].z, pos.x, pos.y, pos.z, true)
		if(distance < 30) then
			DrawMarker(25, takingService[i].x, takingService[i].y, takingService[i].z-0.9, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 243, 44, 82, 20, 0, 0, 2, 0, 0, 0, 0)
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
        if isParamedic then
			if isNearTakeService() then
				if isInService then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~r~off duty~w~.")
				else
					DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~g~on duty~w~.")
				end
				if IsControlJustReleased(1, 38)  then
					isInService = not isInService
					exports["core_modules"]:SetParamedic(isParamedic, isInService)
					TriggerServerEvent("paramedic:setService", isInService)
					
					if isInService then
						TriggerServerEvent("jobcenter:jobs", 15)
						TriggerServerEvent("PlayerCustomisation.ModelType", "Paramedic")
						TriggerServerEvent("paramedic:getinteriors")
						AddParamedicBlips()
					else
						TriggerServerEvent("jobcenter:jobs", 1)
						TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
						RemoveParamedicBlips()
					end
				end
			end
		end
    end
end)

AddEventHandler("paramedic:dead", function()
	if isParamedic and isInService then
		exports["core_modules"]:SetParamedic(isParamedic, isInService)
		isInService = false
		TriggerServerEvent("jobcenter:jobs", 1)
		TriggerServerEvent("paramedic:setService", isInService)
		RemoveParamedicBlips()
		TriggerServerEvent("PlayerCustomisation.ModelType", "Default")
	end
end)
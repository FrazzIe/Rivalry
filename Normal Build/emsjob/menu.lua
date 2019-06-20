--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
mission_list = {}

AddEventHandler("paramedic:menu", function()
	TriggerServerEvent('paramedic:requestMission')
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("MDT", [[TriggerEvent("mdt.toggle")]])
	exports.ui:addOption("Missions", [[TriggerEvent("paramedic:menu_missions")]])
	exports.ui:addOption("Revive", [[TriggerEvent("paramedic:menu_revive")]])
	exports.ui:addOption("Pronounce DOA", [[TriggerEvent("paramedic:menu_doa")]])
	--exports.ui:addOption("Put on life support", [[TriggerEvent("paramedic:menu_lifesupport")]])
	exports.ui:addOption("Drag", [[TriggerEvent("paramedic:menu_drag")]])
	exports.ui:addOption("Put in vehicle", [[TriggerEvent("paramedic:menu_force", "in")]])
	exports.ui:addOption("Take out of vehicle", [[TriggerEvent("paramedic:menu_force", "out")]])
	exports.ui:addOption("Fix vehicle", [[TriggerEvent("paramedic:fix_vehicle")]])
	exports.ui:addOption("Clean vehicle", [[TriggerEvent("paramedic:clean_vehicle")]])
	exports.ui:back([[TriggerEvent("interaction:main")]])
end)

AddEventHandler("paramedic:menu_missions", function()
	exports.ui:reset()
	exports.ui:open("paramedic:missions")
	for k,v in pairs(mission_list) do
		exports.ui:addOption(v.name, v.event, v.mission)
	end
	exports.ui:back([[TriggerEvent("paramedic:menu")]])
end)

AddEventHandler("paramedic:menu_revive", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
		if GetEntityHealth(GetPlayerPed(t)) < 10 then
			TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
			Citizen.Wait(8000)
			ClearPedTasks(PlayerPedId());
			TriggerServerEvent("paramedic:revive", GetPlayerServerId(t))
		end
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("paramedic:menu_doa", function()
	if GetEntityHealth(PlayerPedId()) == 0 then
		TriggerEvent("paramedic:heal", PlayerId())
	else
		local t, distance = GetClosestPlayer()
		if(distance ~= -1 and distance < 3) then
			if GetEntityHealth(GetPlayerPed(t)) < 10 then
				TriggerServerEvent("paramedic:requestdoa", GetPlayerServerId(t))
			end
		else
			Notify("Please get closer to the target!", 2500)
		end
	end
end)

AddEventHandler("paramedic:menu_lifesupport", function()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		if GetEntityHealth(GetPlayerPed(t)) < 10 then
			local time = tonumber(KeyboardInput("How many seconds will this person be on life support for?", "", 11))
			if time ~= nil and time > 0 then
				TriggerServerEvent("paramedic:lifesupport", GetPlayerServerId(t), time)
			end
		end
	else
		Notify("Please get closer to the target!", 2500)
	end
end)

AddEventHandler("paramedic:menu_drag", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	TriggerServerEvent("paramedic:drag", GetPlayerServerId(t))
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("paramedic:menu_force", function(type)
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	TriggerServerEvent("paramedic:force", GetPlayerServerId(t), type)
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("paramedic:fix_vehicle", function()
	if not IsPedSittingInAnyVehicle(PlayerPedId()) then
		local pos = GetEntityCoords(PlayerPedId(), false)
		local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			TaskStartScenarioInPlace(PlayerPedId(), "world_human_vehicle_mechanic", 0, false)
			Citizen.Wait(20000)
			ClearPedTasks(PlayerPedId())
			SetVehicleFixed(vehicleHandle, true)
			SetVehicleUndriveable(vehicleHandle, true)
			Notify("Vehicle repaired!", 2500)
		else
			Notify("Couldn't find a vehicle!", 2500)
		end
	else
		Notify("You cannot repair while in the vehicle", 2500)
	end
end)

AddEventHandler("paramedic:clean_vehicle", function()
	if not IsPedSittingInAnyVehicle(PlayerPedId()) then
		local pos = GetEntityCoords(PlayerPedId(), false)
		local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			SetVehicleDirtLevel(vehicleHandle, 0)
			Notify("Vehicle cleaned!", 2500)
		else
			Notify("Couldn't find a vehicle!", 2500)
		end
	else
		local vehicleHandle = GetVehiclePedIsUsing(PlayerPedId())
		SetVehicleDirtLevel(vehicleHandle, 0)
		Notify("Vehicle cleaned!", 2500)
	end
end)
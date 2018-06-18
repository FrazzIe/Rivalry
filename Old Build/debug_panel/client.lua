local isDebugPanelOpen = false
local isCursorActive = false
local isDeleteActive = false
local isNetworkingActive = false
local isRotationActive = false
local isAllowedToOpen = false
local function ShowCursor()
	isCursorActive = not isCursorActive	
	SetNuiFocus(isCursorActive, isCursorActive)
	SetPlayerControl(PlayerId(), (not isCursorActive), 0)
end

local function boolToStr(bool)
	if bool == 1 or bool == true then
		return "True"
	elseif bool == 2 or bool == false then
		return "False"
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if exports.core:GetGroup(GetPlayerServerId(PlayerId())) == "admin" or exports.core:GetGroup(GetPlayerServerId(PlayerId())) == "owner" or exports.core:GetGroup(GetPlayerServerId(PlayerId())) == "staff" then
			isAllowedToOpen = true
		else
			isAllowedToOpen = false
		end
	end
end)

Citizen.CreateThread(function()
	local previous_entity = nil
	while true do
		Citizen.Wait(0)
		if isAllowedToOpen then
			if IsControlJustPressed(1, 10) and IsInputDisabled(2) then
				isDebugPanelOpen = not isDebugPanelOpen
				SendNUIMessage({display = isDebugPanelOpen})
			end
			if IsControlJustPressed(1, 11) and IsInputDisabled(2) and isDebugPanelOpen then
				ShowCursor()
			end
		end
		if isDebugPanelOpen then
			local player_pos = GetEntityCoords(PlayerPedId(), false)
			local player_heading = GetEntityHeading(PlayerPedId())
			local player_rotation = GetEntityRotation(PlayerPedId())
			SendNUIMessage({
				setPlayer = true,
				position = "{x = "..player_pos.x..", y = "..player_pos.y..", z = "..player_pos.z..", h = "..player_heading.."},",
				rotations = "{x = "..player_rotation.x..", y = "..player_rotation.y..", z = "..player_rotation.z.."},"
			})
			if IsPlayerFreeAiming(PlayerId()) then
				local result, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
				if DoesEntityExist(entity) then
					if isNetworkingActive then
						if not IsEntityAMissionEntity(entity) then
							if DoesEntityExist(previous_entity) then
								SetEntityAsMissionEntity(entity, false, false)
								SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(entity), true)
								SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(entity), true)
							end
							SetEntityAsMissionEntity(entity, true, true)
							previous_entity = entity
						end
					end
					local entity_pos = GetEntityCoords(entity, false)
					local entity_heading = GetEntityHeading(entity)
					local entity_rotation = GetEntityRotation(entity)
					local entity_model = GetEntityModel(entity)
					local entity_networked = boolToStr(NetworkHasControlOfEntity(entity))
					local entity_controlled = boolToStr(NetworkRequestControlOfNetworkId(NetworkGetNetworkIdFromEntity(entity)))
					local entity_network_id_exists = boolToStr(NetworkDoesNetworkIdExist(NetworkGetNetworkIdFromEntity(entity)))
					local entity_mission = boolToStr(IsEntityAMissionEntity(entity))
					SendNUIMessage({
						setTarget = true,
						position = "{x = "..entity_pos.x..", y = "..entity_pos.y..", z = "..entity_pos.z..", h = "..entity_heading.."},",
						rotations = "{x = "..entity_rotation.x..", y = "..entity_rotation.y..", z = "..entity_rotation.z.."},",
						id = entity,
						model = entity_model,
						network_id = NetworkGetNetworkIdFromEntity(entity),
						networked = entity_networked,
						controlled = entity_controlled,
						exists = entity_network_id_exists,
						mission = entity_mission,
					})
					if isDeleteActive and IsPedShooting(PlayerPedId()) then
						if not IsEntityAMissionEntity(entity) then
							SetEntityAsMissionEntity(entity, true, true)
						end
						if IsEntityAPed(entity) then
							DeletePed(entity)
							DeleteEntity(entity)
							SetModelAsNoLongerNeeded(entity_model)
						elseif IsEntityAVehicle(entity) then
							DeleteVehicle(entity)
							DeleteEntity(entity)
							SetModelAsNoLongerNeeded(entity_model)
						elseif IsEntityAnObject(entity) then
							DeleteEntity(entity)
							DeleteObject(entity)
						end
					end

					if isRotationActive then
						if IsControlPressed(0, 52) then
							SetEntityHeading(entity, GetEntityHeading(entity) + 1.5)
						elseif IsControlPressed(0, 51) then
							SetEntityHeading(entity, GetEntityHeading(entity) - 1.5)
						end

						if IsControlPressed(0, 174) then
							SetEntityCoordsNoOffset(entity, GetOffsetFromEntityInWorldCoords(entity, 0.0, 0.25, 0.0))
						elseif IsControlPressed(0, 175) then
							SetEntityCoordsNoOffset(entity, GetOffsetFromEntityInWorldCoords(entity, 0.0, -0.25, 0.0))
						end

						if IsControlPressed(0, 172) then
							SetEntityCoordsNoOffset(entity, GetOffsetFromEntityInWorldCoords(entity, 0.0, 0.0, 0.25))
						elseif IsDisabledControlPressed(0, 173) then
							SetEntityCoordsNoOffset(entity, GetOffsetFromEntityInWorldCoords(entity, 0.0, 0.0, -0.25))
						end
					end
				end
			end
		end
	end
end)

RegisterNUICallback("close", function(data)
	isDebugPanelOpen = not isDebugPanelOpen
	SendNUIMessage({display = isDebugPanelOpen})
	if data.display == "flex" then
		isCursorActive = true
		ShowCursor()
	end
end)

RegisterNUICallback("cursor", function(data)
	ShowCursor()
end)


RegisterNUICallback("checkbox", function(data)
	if data.type == "deletegun" then
		isDeleteActive = not isDeleteActive
	elseif data.type == "network" then
		isNetworkingActive = not isNetworkingActive
	elseif data.type == "rotate" then
		isRotationActive = not isRotationActive
	end
end)

local ragdoll_time_source = 1500
local ragdoll_time_target = 3000
local ragdoll_time_target_ai = 4000
local area_of_effect_radius = 2.125

function math.pow(x, y)
	for i = 1, y-1 do
		x = x * x
	end
	return x
end

function GetPlayerTargets(ped, ped_coords)
	local playerList = GetPlayers()
	local targets = {}
	for i = 1, #playerList do
		if DoesEntityExist(GetPlayerPed(playerList[i])) and GetPlayerPed(playerList[i]) ~= ped and not IsEntityDead(GetPlayerPed(playerList[i])) then
			local target_coords = GetEntityCoords(GetPlayerPed(playerList[i]), true)
			if target_coords ~= nil then
				if GetDistanceBetweenCoords(ped_coords.x, ped_coords.y, ped_coords.z, target_coords.x, target_coords.y, target_coords.z, true) < math.pow(area_of_effect_radius, 2) then
					if GetPlayerServerId(playerList[i]) then
						table.insert(targets, GetPlayerServerId(playerList[i]))
					end
				end
			end
		end
	end
	return targets
end

function GetPedTargets(ped, ped_coords)
	local targets = {}
	for target in EnumeratePeds() do
		if DoesEntityExist(target) and not IsPedAPlayer(target) and not IsEntityDead(target) and target ~= ped and not IsPedSwimming(target) and not IsPedProne(target) and not IsPedSittingInAnyVehicle(target) and not IsPedRagdoll(target) and IsPedOnFoot(target) then
			local target_coords = GetEntityCoords(target, true)
			if target_coords ~= nil then
				if GetDistanceBetweenCoords(ped_coords.x, ped_coords.y, ped_coords.z, target_coords.x, target_coords.y, target_coords.z, true) < math.pow(area_of_effect_radius, 2) then
					table.insert(targets, target)
				end
			end
		end
	end
	return targets
end

RegisterNetEvent("police:tackle")
AddEventHandler("police:tackle", function(source)
	local net_id = GetPlayerFromServerId(source)
	if net_id then
		if NetworkIsPlayerActive(net_id) then
			local source_ped = GetPlayerPed(net_id)
			if DoesEntityExist(source_ped) then
				local source_coords = GetEntityCoords(source_ped, true)
				if source_coords ~= nil then
					local ped = PlayerPedId()
					local position = GetEntityCoords(ped, false)
					if GetDistanceBetweenCoords(position.x, position.y, position.z, source_coords.x, source_coords.y, source_coords.z, true) < math.pow(area_of_effect_radius, 2) then
						SetPedToRagdoll(ped, ragdoll_time_target, 2 * ragdoll_time_target, 0, true, true, true)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped, position = PlayerPedId(), GetEntityCoords(PlayerPedId(), false)
		if IsControlJustPressed(1, 51) and not IsPedSittingInAnyVehicle(ped) and GetEntitySpeed(ped) > 4.7 then
			if exports.policejob:getIsInService() then
				local players, peds = GetPlayerTargets(ped, position), GetPedTargets(ped, position)
				if #players > 0 or #peds > 0 then
					TaskPlayAnim(ped, "move_jump", "dive_start_run", 8.0, -8.0, -1, 0, 0, false, false, false)
					Citizen.Wait(500)
					SetPedToRagdoll(ped, ragdoll_time_source, 2 * ragdoll_time_source, 0, true, true, true)
					if #players > 0 then
						TriggerServerEvent("police:tackle", players)
					else
						for i = 1, #peds do
							SetPedToRagdoll(peds[i], ragdoll_time_target_ai, 2 * ragdoll_time_target_ai, 0, true, true, true)
							Citizen.Wait(2 * ragdoll_time_target_ai)
							ClearPedTasksImmediately(peds[i])
							TaskReactAndFleePed(peds[i], ped)
						end
					end
				end
			end
		end
	end
end)
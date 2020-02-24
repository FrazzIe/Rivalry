Seed = 0
Peds = {}
Chopping = nil

--[[ Threads ]]--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)

		-- Update zones.
		for k, zone in ipairs(Config.Zones) do
			if zone.Chance ~= 100 then
				math.randomseed(Seed + k)
				if math.random() * 100.0 > zone.Chance then
					if Peds[k] then
						ClearPed(Peds[k])
						Peds[k] = nil
					end
					goto continue
				end
				math.randomseed(GetGameTimer())
			end

			local dist = #(zone.Coords - pos)
			if dist < zone.Visibility then
				local hasGround, groundZ = GetGroundZFor_3dCoord(zone.Coords.x, zone.Coords.y, zone.Coords.z)

				if zone.Type == 0 then
					-- TODO: New Framework - use Markers export.
					local size = 2.0
					DrawMarker(25, zone.Coords.x, zone.Coords.y, groundZ + 0.01, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, size, size, size, 60, 60, 250, 64, false, false)
					
					if dist < zone.Radius then
						local handle, vehicle = FindFirstVehicle()
						local success = false

						while true do
							success, vehicle = FindNextVehicle(handle)
							if not success then
								vehicle = nil
								break
							end
							if #(GetEntityCoords(vehicle) - zone.Coords) < zone.Radius then
								break
							end
						end

						EndFindVehicle(handle)

						if vehicle then
							-- TODO: New Framework - use Markers export.
							SetTextComponentFormat("STRING")
							AddTextComponentString("Press ~INPUT_CONTEXT~ to scrap vehicle!")
							DisplayHelpTextFromStringLabel(0, 0, 1, -1)
							if IsControlJustPressed(1, 51) then
								BeginScrapping(vehicle, zone)
							end
						end
					end
				elseif zone.Type == 1 then
					-- Create the ped.
					if not Peds[k] and zone.Peds and hasGround then
						Peds[k] = {}
						Citizen.CreateThread(function()
							math.randomseed(Seed + k)
							local zonePed = zone.Peds[math.random(1, #zone.Peds)]
							local model = GetHashKey(zonePed.Model)
							math.randomseed(GetGameTimer())
	
							while not HasModelLoaded(model) do RequestModel(model) Citizen.Wait(1) end
							while not HasAnimDictLoaded(Config.Anim.Dict) do RequestAnimDict(Config.Anim.Dict) Citizen.Wait(1) end
	
							local prop = nil
							local ped = CreatePed(4, model, zone.Coords.x, zone.Coords.y, groundZ, zone.Heading, false, true)
	
							FreezeEntityPosition(ped, true)
							SetEntityInvincible(ped, false)
							SetPedCanRagdollFromPlayerImpact(ped, false)
							SetBlockingOfNonTemporaryEvents(ped, true)
							SetPedFleeAttributes(ped, 0, 0)
							SetPedCombatAttributes(ped, 17, 1)
							SetEntityInvincible(ped, true)
							DecorSetBool(ped, "isTrader", true)
							TaskPlayAnim(ped, Config.Anim.Dict, Config.Anim.Name, -1, -1, -1, 1, 0.0, false, false, false)
	
							if Config.HeldObject then
								local heldModel = GetHashKey(Config.HeldObject.Model)
								local pos = Config.HeldObject.Pos
								local rot = Config.HeldObject.Rot
	
								while not HasModelLoaded(heldModel) do RequestModel(heldModel) Citizen.Wait(1) end
	
								prop = CreateObject(heldModel, 0, 0, 0, false, true, false)
								AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 60309), pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, true, true, false, true, 1, true)
							end
	
							Peds[k] = { ped = ped, prop = prop }
						end)
					end

					-- Update the ped.
					if Peds[k] then
						local pedPos = GetEntityCoords(Peds[k].ped)

						if #(pedPos - pos) < zone.Radius then
							-- TODO: New Framework - use Markers export.
							SetTextComponentFormat("STRING")
							AddTextComponentString("Press ~INPUT_CONTEXT~ to recieve vehicle list!")
							DisplayHelpTextFromStringLabel(0, 0, 1, -1)
							if IsControlJustPressed(1, 51) then
								RequestList()
							end
						end
					end
				end
			elseif Peds[k] then
				ClearPed(Peds[k])
				Peds[k] = nil
			end

			::continue::
		end
	end
end)

--[[ Functions ]]--
function ClearPed(ped)
	if ped.ped then
		DeletePed(ped.ped)
	end

	if ped.prop then
		DeleteEntity(ped.prop)
	end
end

function RequestList()
	local cars = GetList(Seed)
	local output = ""

	for k, v in ipairs(cars) do
		if k ~= 1 then
			output = output.." - "
		end
		output = output..v.car.Model.." ($"..v.car.BasePrice..")"
	end

	TriggerEvent("chatMessage", "", {220, 220, 220}, output)
	TriggerServerEvent("chopShop:requestTime")
end

function BeginScrapping(vehicle, zone)
	if Chopping then return end
	local ped = PlayerPedId()
	local plate = GetVehicleNumberPlateText(vehicle)
	local error = nil
	
	-- Checks for player owned vehicles.
	for k,v in pairs(exports.core_modules:GetVehiclesTable()) do
		if v.plate == plate then
			error = "I'm affraid I cannot chop this person's vehicle..."
			break
		end
	end

	-- Check for rentals.
	if string.sub(plate, 1, 2) == "RR" then
		error = "We don't chop rentals..."
	end
	
	-- Check the list.
	local listedVehicle = FindIndex(vehicle)
	if not listedVehicle then
		error = "That's not on the list!"
	end
	
	-- Finish checks.
	if error then
		TriggerEvent("pNotify:SendNotification", { text = error, type = "error", queue = "left", timeout = 6000, layout = "centerRight" })
		return
	end

	Chopping = vehicle
	TriggerEvent("pNotify:SendNotification", { text = "Begin scrapping the vehicle...", type = "error", queue = "left", timeout = 6000, layout = "centerRight" })

	-- Eject people from seats.
	for seat = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
		if not IsVehicleSeatFree(vehicle, seat) then
			TaskLeaveVehicle(GetPedInVehicleSeat(vehicle, seat), vehicle, 0)
		end
	end

	while IsPedInVehicle(ped, vehicle, true) do
		Citizen.Wait(0)
	end

	Citizen.CreateThread(function()
		local status = false
		
		while not status do
			Citizen.Wait(0)
			ped = PlayerPedId()
			local pedPos = GetEntityCoords(ped)

			if not DoesEntityExist(vehicle) or #(GetEntityCoords(vehicle) - zone.Coords) > zone.Radius or #(pedPos - zone.Coords) > zone.Radius then
				break
			end

			local components = {}
			
			-- Components.
			for _, component in ipairs(Config.Components) do
				local index = GetEntityBoneIndexByName(vehicle, component.Name)
				if index ~= -1 then
					local text = nil

					if component.Type == 0 then
						text = "Removing door"
					elseif component.Type == 1 then
						text = "Removing wheel"
					end

					local pos = GetWorldPositionOfEntityBone(vehicle, index)
					local rot = GetWorldRotationOfEntityBone(vehicle, index)

					pos = GetEntityCoords(vehicle) - GetOffsetFromEntityInWorldCoords(vehicle, component.Offset) + pos

					components[#components + 1] = {
						pos = pos,
						text = text,
						type = component.Type,
						condition = function()
							if component.Type == -1 then
								return true
							elseif component.Type == 0 then
								return not IsVehicleDoorDamaged(vehicle, component.Index)
							elseif component.Type == 1 then
								return not IsVehicleTyreBurst(vehicle, component.Index, false)
							end
						end,
						callback = function()
							if component.Type == -1 then
								status = true
								local ratio = 0.0
								for _, component in ipairs(components) do
									if not component.condition() then
										ratio = ratio + 1.0 / (#components - 1)
									end
								end
								TriggerServerEvent("chopShop:chopVehicle", listedVehicle, ratio)
							elseif component.Type == 0 then
								SetVehicleDoorBroken(vehicle, component.Index, true)
								-- TODO: request to be given scrap metal
							elseif component.Type == 1 then
								SetVehicleTyreBurst(vehicle, component.Index, true, 1000)
								-- TODO: request to be given rubber
							end
							-- TODO: add windows
						end,
					}
				end
			end

			-- Register components.
			local nearestComponent = nil
			local nearestDist = 0.0
			for _, component in ipairs(components) do
				if not component.condition or component.condition() then
					local pos = component.pos
					local dist = #(pos - pedPos)

					-- TODO: Use new framework draw floating text util
					local r, g, b = 60, 60, 250

					if component.type == -1 then
						r, g, b = 250, 60, 60
					end

					DrawMarker(28, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, r, g, b, 128, false, true, 2, false, nil, nil, false)
					-- DrawLine(pos.x, pos.y, pos.z, pedPos.x, pedPos.y, pedPos.z, r, g, b, 220)

					if (not nearestComponent or dist < nearestDist) and dist < Config.ComponentRange then
						nearestComponent = component
						nearestDist = dist
					end
				end
			end

			-- Remove nearest component.
			local shouldRemove = IsControlJustPressed(1, 51)
			if shouldRemove and nearestComponent then
				exports['mythic_progbar']:Progress({
					name = "chopping",
					duration = 2500,
					label = nearestComponent.text or "Chopping",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "mp_intro_seq@",
						anim = "mp_mech_fix",
						flags = 2,
					}
				}, function(status)
					if not status then
						if not nearestComponent.condition or nearestComponent.condition() then
							nearestComponent.callback()
						end
					end
				end)
			end
		end

		if not status then
			Chopping = nil
		end
	end)
	-- SetVehicleDoorBroken

	-- Chop the vehicle.
	-- TriggerServerEvent("chopShop:chopVehicle", listedVehicle)
end

-- exports['mythic_progbar']:Progress({
-- 	name = "chopping",
-- 	duration = 5000,
-- 	label = "Chopping",
-- 	useWhileDead = false,
-- 	canCancel = true,
-- 	controlDisables = {
-- 		disableMovement = true,
-- 		disableCarMovement = true,
-- 		disableMouse = false,
-- 		disableCombat = true,
-- 	},
-- 	animation = {
-- 		animDict = "amb@world_human_vehicle_mechanic@male@idle_a",
-- 		anim = "idle_a",
-- 		flags = 49,
-- 	},
-- 	prop = {
-- 		model = "prop_tool_hammer",
-- 		bone = 28422,
-- 	}
-- }, function(status)
	
-- end)

-- local ped = PlayerPedId()
-- local veh = GetVehiclePedIsIn(ped)
-- GetVehicleHandlingFloat(veh, "CVehicleCoverBoundOffsetInfo", "Front")
-- SetVehicleDoorBroken(veh, 4, true)

function FindIndex(vehicle, list)
	if not list then list = GetList(Seed) end

	local model = GetEntityModel(vehicle)
	for k, v in ipairs(list) do
		if model == GetHashKey(v.car.Model:lower()) then
			return v.index
		end
	end
	return nil
end

--[[ Events ]]--
RegisterNetEvent("chopShop:updateSeed")
AddEventHandler("chopShop:updateSeed", function(seed)
	Seed = seed
end)

RegisterNetEvent("chopShop:chopResult")
AddEventHandler("chopShop:chopResult", function(response)
	-- local listedVehicle = FindIndex(vehicle)
	if response == 0 then
		if Chopping then
			DeleteEntity(Chopping)
		end
	elseif response == 1 then
		TriggerEvent("pNotify:SendNotification", {
			text = "Sorry, nobody works hard enough around here. I can't have your vehicle chopped.",
			type = "error",
			queue = "left",
			timeout = 7000,
			layout = "centerRight"
		})
	elseif response == 2 then
		TriggerEvent("pNotify:SendNotification", {
			text = "Slow your roll there, buddy!",
			type = "error",
			queue = "left",
			timeout = 7000,
			layout = "centerRight"
		})
	end
	Chopping = false
end)

RegisterNetEvent("chopShop:receiveTime")
AddEventHandler("chopShop:receiveTime", function(time)
	TriggerEvent("pNotify:SendNotification", {
		text = "I wrote the list down for you. You have "..math.ceil(time / 60).." minutes before the list changes.",
		type = "success",
		queue = "left",
		timeout = 7000,
		layout = "centerRight"
	})
end)

--[[ Resource Events ]]--
AddEventHandler("onClientResourceStart", function()
	TriggerServerEvent("chopShop:requestSeed")
end)
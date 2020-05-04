CurrentRobbable = nil
NearestRobbery = nil
NearestObjects = {}
NearestRobbables = {}
Doors = {}
-- States = {
-- 	["Blaine County Savings"] = { {coords=vector3(-104.60489654541, 6473.4438476563, 31.795324325562),unlocked=false,opened=false} }
-- }

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		local ped = PlayerPedId()
		local pedPos = GetEntityCoords(ped)

		NearestRobbery = nil

		for k, robbery in pairs(Config.Robberies) do
			local robberyPos = robbery.Coords
			local dist = #(robberyPos - pedPos)

			if dist < (robbery.Dist or 20.0) then
				NearestRobbery = k
				NearestObjects = exports.utils:GetObjects()
				NearestRobbables = {}
				
				for _k, v in pairs(robbery.Robbables) do
					local robbable = GetRobbable(v)

					if robbable.ModelCache ~= nil then
						for _, object in ipairs(NearestObjects) do
							local objectModel = GetEntityModel(object)
							local modelCache = robbable.ModelCache[objectModel]
	
							if modelCache ~= nil then
								NearestRobbables[object] = { key = _k, id = v }
							end
						end
					else
						NearestRobbables[robbable.Id] = { key = _k, coords = v.Coords}
					end
				end

				break
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		while NearestRobbery == nil do
			Citizen.Wait(0)
		end

		local ped = PlayerPedId()
		local pedPos = GetEntityCoords(ped)

		local robbery = Config.Robberies[NearestRobbery]

		-- ProcessDoors(robbery)
		
		local nearestIndex = nil
		local nearestRobbableIndex = nil
		local nearestRobbable, nearestDist = GetNearest(NearestRobbables, function(key, value)
			if value.coords ~= nil then
				local index, dist = GetNearest(value.coords, function(_key, _value)
					return _value
				end)

				if index ~= nil then
					nearestRobbableIndex = index
				end

				return value.coords[index]
			end

			local offset = Config.Robbables[value.id].Offset

			if offset == nil then
				return GetEntityCoords(key)
			else
				return GetOffsetFromEntityInWorldCoords(key, offset.x, offset.y, offset.z)
			end
		end)

		if nearestRobbable ~= nil then
			local pos = nil
			local offset = vector3(0.0, 0.0, 0.0)
			local isProp = type(nearestRobbable) ~= "string"

			local robbable = nil
			local robbableConfig = nil
			
			if not isProp then
				robbable = nearestRobbable
				robbableConfig = Config.Robbables[robbable]
				pos = robbery.Robbables[NearestRobbables[robbable].key].Coords[nearestRobbableIndex]

				if type(pos) == "vector4" then
					pos = vector3(pos.x, pos.y, pos.z)
				end
			else
				
				robbable = NearestRobbables[nearestRobbable].id
				robbableConfig = Config.Robbables[robbable]
				local offset = robbableConfig.Offset

				if robbableConfig.Models then
					local model = GetEntityModel(nearestRobbable)
					local modelCache = robbableConfig.Models[robbableConfig.ModelCache[model]]

					if modelCache.Hide then
						goto hide
					end
				end
				
				if offset == nil then
					pos = GetEntityCoords(nearestRobbable)
				else
					pos = GetOffsetFromEntityInWorldCoords(nearestRobbable, offset.x, offset.y, offset.z)
				end
			end

			local canRob = 1

			if robbableConfig.Items ~= nil then
				for _, item in ipairs(robbableConfig.Items) do
					if exports.core_modules:GetItemQuantity(item) <= 0 then
						canRob = 2
						break
					end
				end
			end

			if robbableConfig.Armed and not IsPedArmed(ped, 5) then
				canRob = 2
			end

			-- local model = robbableConfig.Models[]

			if exports.utils:DrawContext(robbableConfig.Text or "Rob", pos + offset, canRob) and canRob == 1 then
				if not isProp then
					pos = nearestRobbableIndex
				end

				CurrentRobbable = robbable
				
				TriggerServerEvent("robberies:attempt", NearestRobbery, NearestRobbables[nearestRobbable].key, pos)
			end

			::hide::
		end
	end
end)

function BeginHacking(robbable, stage, phase, phases, length, duration)
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start", length, duration, ("Hacking (Phase %s / %s)"):format(phase, phases), function(success)
		if success and phase < phases then
			BeginHacking(robbable, stage, phase + 1, phases, length, duration)

			return
		end

		TriggerEvent("mhacking:hide")
		FinishRobbing(robbable, not success)
	end)
end

function BeginRobbing(robbable, stage)
	if not robbable then return end

	local config = Config.Robbables[robbable]

	if config.Stages ~= nil then
		config = config.Stages[stage]
	end

	local minigame = config.Minigame
	
	if minigame ~= nil then
		if minigame.Type == "Hacking" then
			BeginHacking(robbable, stage, 1, minigame.Phases or 4, minigame.Length or 2, minigame.Duration or 30)

			return
		end
	end

	exports.mythic_progbar:Progress({
		name = "robbing",
		duration = (config.Duration or 1) * 1000,
		label = config.Text or "Robbing",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = config.Anim.Dict,
			anim = config.Anim.Name,
			flags = config.Anim.Flag or 1,
		},
	}, function(status)
		FinishRobbing(robbable, status)
	end)
end

function FinishRobbing(robbable, status)
	TriggerServerEvent("robberies:finish", status)
end

function GetRobbable(robbable)
	if type(robbable) == "string" then
		return Config.Robbables[robbable]
	end

	return robbable
end

function GetNearest(data, posFunc)
	local pedPos = GetEntityCoords(PlayerPedId())
	local nearestKey = nil
	local nearestDist = 0

	for k, v in pairs(data) do
		local pos = posFunc(k, v)
		
		if pos ~= nil then
			-- DrawLine(pos.x, pos.y, pos.z, pedPos.x, pedPos.y, pedPos.z, 255, 255, 255, 255)

			if type(pos) == "vector4" then
				pos = vector3(pos.x, pos.y, pos.z)
			end

			local dist = #(pos - pedPos)
		
			if dist < 1.2 and (nearestKey == nil or dist < nearestDist) then
				nearestKey = k
				nearestDist = dist
			end
		end
	end

	return nearestKey, nearestDist
end

function ProcessDoors(robbery)
	local states = States[robbery.Name] or {}
	for _, object in ipairs(NearestObjects) do
		local config = Config.Robbables.Doors.ModelCache[GetEntityModel(object)]
		if config ~= nil then
			config = Config.Robbables.Doors.Models[config]
			if config ~= nil and config.Banks ~= nil then
				config = config.Banks[robbery.Name] or {}
			end

			local door = Doors[object]
			local pos = GetEntityCoords(object)
			local heading = GetEntityHeading(object)
			if door == nil then
				door = { heading = config.closed or heading }
				Doors[object] = door
			end
			
			local locked = true
			local opened = false
			for __, doorState in ipairs(states) do
				if #(doorState.coords - pos) < 0.01 then
					locked = doorState.unlocked ~= true
					opened = doorState.opened
					break
				end
			end

			if opened then
				local targetHeading = config.opened or (config.closed + 90)

				if targetHeading > heading then
					heading = math.min(heading + 1, targetHeading)
				else
					heading = math.max(heading - 1, targetHeading)
				end

				SetEntityHeading(object, heading)
			elseif locked then
				SetEntityHeading(object, door.heading)
			end
		end
	end
end

RegisterNetEvent("robberies:response")
AddEventHandler("robberies:response", function(status)
	if status > 0 then
		BeginRobbing(CurrentRobbable, status)
		
		return
	end

	local message = Config.StatusErrors[status] or "Hmm..."
	TriggerEvent("pNotify:SendNotification", { text = message, type = "error", queue = "left", timeout = 10000, layout = "centerRight" })
end)
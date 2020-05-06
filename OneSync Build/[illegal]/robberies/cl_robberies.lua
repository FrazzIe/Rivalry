LastRobbery = nil
CurrentRobbable = nil
CurrentRobbableInfo = {}
NearestRobbery = nil
NearestObjects = {}
NearestRobbables = {}
LockPosition = nil
Doors = {}
States = { doors = {} }
-- States = {
-- 	{coords=vector3(-104.60489654541, 6473.4438476563, 31.795324325562),unlocked=true,opened=true},
-- 	{coords=vector3(255.22825622559, 223.97601318359, 102.39321899414),unlocked=true,opened=true},
-- }

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		local ped = PlayerPedId()
		local pedPos = GetEntityCoords(ped)
		local nearestDist = 0

		NearestRobbery = nil

		if ViewingCams ~= nil then
			NearestRobbery = ViewingCams
		else
			for k, robbery in pairs(Config.Robberies) do
				local robberyPos = robbery.Coords
				local dist = #(robberyPos - pedPos)
	
				if dist < (robbery.Dist or 20.0) and (NearestRobbery == nil or dist < nearestDist) then
					nearestDist = dist
					NearestRobbery = k
				end
			end
		end

		if NearestRobbery ~= nil then
			local robbery = Config.Robberies[NearestRobbery]
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
					local nearestRobbable = { key = _k, coords = v.Coords}

					if NearestRobbables[robbable.Id] == nil then
						NearestRobbables[robbable.Id] = { nearestRobbable }
					else
						table.insert(NearestRobbables[robbable.Id], nearestRobbable)
					end
				end
			end
		end

		if LastRobbery ~= NearestRobbery then
			if LastRobbery ~= nil then
				TriggerServerEvent("robberies:subscribe", LastRobbery, false)
			end
			if NearestRobbery ~= nil then
				TriggerServerEvent("robberies:subscribe", NearestRobbery, true)
			end
		end

		LastRobbery = NearestRobbery
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

		ProcessDoors(robbery)
		
		local nearestRobbable = nil
		local nearestDist = 0
		for k, v in pairs(NearestRobbables) do
			if type(k) == "string" then
				for _k, _v in pairs(v) do
					for __k, __v in pairs(_v.coords) do
						if type(__v) == "vector4" then
							__v = vector3(__v.x, __v.y, __v.z)
						end

						local dist = #(__v - pedPos)

						if nearestRobbable == nil or dist < nearestDist then
							nearestRobbable = {k, _k, __k}
							nearestDist = dist
						end
					end
				end
			else
				local pos = nil
				-- local offset = Config.Robbables[v.id].Offset

				-- local model = GetEntityModel(nearestRobbable)
				-- local modelCache = robbableConfig.Models[robbableConfig.ModelCache[model]]

				-- if modelCache then
				-- 	if modelCache.Flipped then
				-- 		offset = offset * -1
				-- 	end
				-- 	-- TODO?
				-- end
				
				-- if offset == nil then
				-- else
				-- 	pos = GetOffsetFromEntityInWorldCoords(k, offset.x, offset.y, offset.z)
				-- end
				pos = GetEntityCoords(k)

				local dist = #(pos - pedPos)
				
				if nearestRobbable == nil or dist < nearestDist then
					nearestRobbable = k
					nearestDist = dist
				end
			end
		end

		if nearestRobbable ~= nil and nearestDist < 1.5 then
			local pos = nil
			local robbableKey = 0
			local offset = vector3(0.0, 0.0, 0.0)
			local isProp = type(nearestRobbable) ~= "table"

			local robbable = nil
			local robbableConfig = nil

			local canRob = 1
			local itemId = nil
			local items = nil
			
			if not isProp then
				robbable = nearestRobbable[1]
				local nearestRobbableInfo = NearestRobbables[robbable][nearestRobbable[2]]

				robbableKey = nearestRobbableInfo.key
				robbableConfig = Config.Robbables[robbable]
				pos = nearestRobbableInfo.coords[nearestRobbable[3]]

				LockPosition = pos

				local _robbableConfig = robbery.Robbables[nearestRobbableInfo.key]

				if _robbableConfig ~= nil then
					items = _robbableConfig.Items
				end

				if type(pos) == "vector4" then
					pos = vector3(pos.x, pos.y, pos.z)
				end
			else
				robbableKey = NearestRobbables[nearestRobbable].key
				robbable = NearestRobbables[nearestRobbable].id
				robbableConfig = Config.Robbables[robbable]
				local _offset = robbableConfig.Offset

				if robbableConfig.Models then
					local model = GetEntityModel(nearestRobbable)
					local modelCache = robbableConfig.Models[robbableConfig.ModelCache[model]]

					if modelCache.Hide then
						goto hide
					end

					if modelCache.Flipped then
						_offset = _offset * -1
					end
				end
				
				pos = GetEntityCoords(nearestRobbable)

				if _offset ~= nil then
					offset = pos - GetOffsetFromEntityInWorldCoords(nearestRobbable, _offset.x, _offset.y, _offset.z)
				end

				LockPosition = vector4(pos.x - offset.x, pos.y - offset.y, pos.z - offset.x, GetEntityHeading(nearestRobbable))
			end

			if robbableConfig.LockTo == false then
				LockPosition = nil
			end

			items = items or robbableConfig.Items

			if items ~= nil then
				for _, item in ipairs(items) do
					if exports.core_modules:GetItemQuantity(item) > 0 then
						itemId = item
						break
					end
				end
				if itemId == nil then
					canRob = 2
				end
			end

			CurrentRobbableInfo.itemId = itemId
			
			if robbableConfig.Armed and not IsPedArmed(ped, 5) then
				canRob = 2
			end

			-- local model = robbableConfig.Models[]
			
			if exports.utils:DrawContext(robbableConfig.Text or "Rob", pos - offset, canRob) and canRob == 1 then
				if not isProp then
					pos = nearestRobbable[3]
				end
				
				CurrentRobbable = robbable
				
				TriggerServerEvent("robberies:attempt", NearestRobbery, robbableKey, pos)
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

	-- Take item.
	if CurrentRobbableInfo.itemId ~= nil then
		exports.core_modules:removeQty(CurrentRobbableInfo.itemId, 1)
	end

	-- Positioning.
	if LockPosition ~= nil then
		local ped = PlayerPedId()
		local hasGround, groundZ = GetGroundZFor_3dCoord(LockPosition.x, LockPosition.y, LockPosition.z)
		if hasGround then
			SetEntityCoords(ped, LockPosition.x, LockPosition.y, groundZ, true, true, true, false)
			SetEntityHeading(ped, LockPosition.w)
		end
	end

	-- Safes.
	if stage == 2 and robbable == "Safe" then
		Citizen.CreateThread(function()
			local pedPos = GetEntityCoords(PlayerPedId())
			local door = nil
			for _, object in ipairs(NearestObjects) do
				if GetEntityModel(object) == -1375589668 and #(GetEntityCoords(object) - pedPos) < 2.0 then
					door = object
					break
				end
			end

			if door == nil then return end
			SetEntityHeading(door, GetEntityHeading(door) + 90)
		end)
	end

	-- Minigames.
	local minigame = config.Minigame
	
	if minigame ~= nil then
		if minigame.Type == "Hacking" then
			BeginHacking(robbable, stage, 1, minigame.Phases or 4, minigame.Length or 2, minigame.Duration or 30)

			return
		end
	end

	-- Progress bars.
	if config.Anim ~= nil and config.Anim.flag == nil then
		config.Anim.flag = 1
	end

	exports.mythic_progbar:Progress({
		name = "robbing",
		duration = (config.Duration or 1) * 1000,
		label = config.Label or "Robbing",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = config.Anim or {},
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

function ProcessDoors(robbery)
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

			-- Delete door lol
			local model = GetEntityModel(object)
			if #(pos - vector3(-104.60489654541, 6473.4438476563, 31.795324325562)) < 0.5 and model == 1622278560 then
				NearestObjects[object] = nil
				SetEntityAsMissionEntity(object, true)
				DeleteEntity(object)
				goto continue
			end
			
			local locked = true
			local opened = nil
			for __, doorState in ipairs(States.doors) do
				if #(doorState.coords - pos) < (config.Size or 0.1) then
					locked = doorState.unlocked ~= true
					opened = doorState.opened
					break
				end
			end

			if opened ~= nil then
				local targetHeading = heading

				if opened then
					targetHeading = config.opened or ((config.closed or door.heading) + 90)
				else
					targetHeading = config.closed or door.heading
				end

				if targetHeading > heading then
					heading = math.min(heading + 0.4, targetHeading)
				else
					heading = math.max(heading - 0.4, targetHeading)
				end

				SetEntityHeading(object, heading)
				FreezeEntityPosition(object, false)
			elseif locked then
				SetEntityHeading(object, door.heading)
				FreezeEntityPosition(object, true)
			else
				FreezeEntityPosition(object, false)
			end
		end
		::continue::
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

RegisterNetEvent("robberies:sync")
AddEventHandler("robberies:sync", function(states)
	States = states
end)

RegisterNetEvent("robberies:unlock")
AddEventHandler("robberies:unlock", function(coords, unlocked, opened)
	for __, doorState in ipairs(States.doors) do
		if #(doorState.coords - coords) < 0.1 then
			doorState.unlocked = unlocked
			doorState.opened = opened
		end
	end

	table.insert(States.doors, { coords = coords, unlocked = unlocked, opened = opened })
end)
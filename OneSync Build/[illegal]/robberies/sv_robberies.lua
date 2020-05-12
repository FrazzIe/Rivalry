Robberies = {}
Players = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)

		for k, v in pairs(Robberies) do
			for _k, robbable in pairs(v.robbables) do
				if robbable.robbing then
					goto continue
				end
			end

			local robberyConfig = Config.Robberies[k]
			if os.time() - (v.time or 0.0) > (robberyConfig.Cooldown or 10) * 60 then
				local robbery = Robberies[k]
				robbery.robbables = {}
				robbery.doors = {}
				robbery.cams = {}
			end
			::continue::
		end
	end
end)

RegisterNetEvent("robberies:attempt")
AddEventHandler("robberies:attempt", function(robbery, robbable, coords)
	local source = source

	local robberyConfig = Config.Robberies[robbery]
	if not robberyConfig then print("Robberies -> No robbery") return end

	local robbableInfo = robberyConfig.Robbables[robbable]
	if not robbableInfo then print("Robberies -> No robbable") return end

	if type(coords) == "number" then
		coords = robbableInfo.Coords[coords]
		robbableInfo = robbableInfo.Id
	end

	local robbableConfig = Config.Robbables[robbableInfo]

	if type(coords) == "vector4" then
		coords = vector3(coords.x, coords.y, coords.z)
	end

	if not coords or type(coords) ~= "vector3" then print("Robberies -> No coords") return end
	local status, timeLeft = CheckRobbery(robbery, robbable, coords)
	
	if status > 0 then
		local robberyCache = Robberies[robbery]
		
		-- Cache the robbery.
		if robberyCache == nil then
			robberyCache = { robbables = {}, time = os.time() }
			Robberies[robbery] = robberyCache
		end

		local robbableCache = GetRobbable(robbery, coords)

		if robbableCache == nil then
			robbableCache = { coords = coords, time = os.time(), stage = 1, robbing = true, key = robbable }
			table.insert(robberyCache.robbables, robbableCache)
		else
			robbableCache.robbing = true
			robbableCache.time = os.time()
		end

		-- Cache the player.
		Players[source] = { robbery = robbery, robbable = robbableInfo, robbableIndex = robbable, coords = coords }

		-- Dispatch police.
		if not robberyCache.dispatched or os.time() - robberyCache.dispatched > Config.DispatchCooldown then
			robberyCache.dispatched = os.time()
			local suffix = ""
			suffix = robberyConfig.Type

			TriggerEvent("dispatch:ten-ninety", robberyConfig.Coords, ("%s %s (%s)"):format(robberyConfig.Name, suffix, robbery))
		end

		-- Interval based payouts.
		local robbableStage = GetStage(robbableInfo, robbableCache.stage or 1) or {}
		
		if robbableStage.PayoutInterval ~= nil then
			Citizen.CreateThread(function()
				for i = 1, robbableStage.Duration / (robbableStage.PayoutInterval or 1.0) do
					if Players[source] == nil or not robbableCache.robbing then
						return
					end

					GivePayout(source, robbableInfo, robbableCache.stage or 1)
					
					Citizen.Wait(1000 * robbableStage.PayoutInterval)
				end
			end)
		end
	end

	TriggerClientEvent("robberies:response", source, status, timeLeft)
end)

RegisterNetEvent("robberies:finish")
AddEventHandler("robberies:finish", function(status)
	local source = source
	local cache = Players[source]

	if not cache then
		print(("[%s] tried finishing a robbery without starting one (?)"):format(source))
		return
	end

	-- Cache the robbery.
	local robberyCache = Robberies[cache.robbery]
	if robberyCache == nil then
		Robberies[cache.robbery] = { robbables = {}, doors = {}, cams = {}, players = { [source] = true } }
		robberyCache = Robberies[cache.robbery]
	end

	local robbableCache = GetRobbable(cache.robbery, cache.coords)

	if robbableCache ~= nil then
		robbableCache.robbing = false
	end

	-- Get the robbable stage.
	local robbableConfig = Config.Robbables[cache.robbable]
	local robbableStage = robbableConfig

	if robbableConfig.Stages ~= nil then
		robbableStage = robbableConfig.Stages[robbableCache.stage]
	end

	-- Canceling.
	if status and not robbableStage.CooldownOnCancel then
		Players[source] = nil
		return
	end

	-- Config.
	local robberyConfig = Config.Robberies[cache.robbery]
	local robbableInfo = robberyConfig.Robbables[cache.robbableIndex]
	
	-- Doors.
	if robbableConfig.IsDoor then
		SetDoorUnlocked(cache.robbery, cache.coords, true)
	end

	if robbableInfo.Unlocks ~= nil then
		for k, v in ipairs(robbableInfo.Unlocks) do
			SetDoorUnlocked(cache.robbery, v, true, robbableInfo.Opens)
		end
	end

	-- Payouts.
	GivePayout(source, cache.robbable, robbableCache.stage)

	-- Item payouts.
	if robbableStage.PayoutItems ~= nil then
		local foundSomething = false
		for k, v in ipairs(robbableStage.PayoutItems) do
			local item = v[1]
			local amount = v[2]
			local chance = v[3]
			local random = math.random()

			if type(amount) == "table" then
				amount = math.random(amount[1], amount[2] + 1)
			end

			if chance > random then
				foundSomething = true
				TriggerClientEvent("inventory:addQty", source, item, amount)
			end
		end
		if foundSomething then
			TriggerClientEvent("pNotify:SendNotification", source, { text = "You found something!", type = "error", queue = "left", timeout = 10000, layout = "centerRight" })
		end
	end

	-- Update the time.
	robberyCache.time = os.time()

	-- Increment the stage.
	if robbableConfig.Stages == nil or robbableCache.stage >= #robbableConfig.Stages then
		robbableCache.stage = -2
	else
		robbableCache.stage = robbableCache.stage + 1
	end

	-- Clear the player cache.
	Players[source] = nil
end)

RegisterNetEvent("robberies:subscribe")
AddEventHandler("robberies:subscribe", function(robbery, subscribe)
	if not robbery then return end
	
	local source = source
	local robberyCache = Robberies[robbery]

	if not subscribe then
		subscribe = nil
	end

	if robberyCache == nil then
		if Config.Robberies[robbery] == nil then return end

		robberyCache = { robbables = {}, doors = {}, cams = {}, players = { [source] = true } }
		Robberies[robbery] = robberyCache
	else
		robberyCache.players[source] = subscribe
	end

	if subscribe then
		TriggerClientEvent("robberies:sync", source, { doors = robberyCache.doors, cams = robberyCache.cams })
	end
end)

RegisterNetEvent("robberies:destroyCam")
AddEventHandler("robberies:destroyCam", function(robbery, coords)
	local robberyCache = Robberies[robbery]
	if robberyCache == nil then return end

	for k, v in ipairs(robberyCache.cams) do
		if #(v - coords) < 1.0 then return end
	end

	table.insert(robberyCache.cams, coords)
	
	for player, _ in pairs(robberyCache.players) do
		TriggerClientEvent("robberies:destroyCam", player, coords)
	end
end)

function SetDoorUnlocked(robbery, coords, unlocked, opened)
	local robberyCache = Robberies[robbery]
	local exists = false
	for k, v in ipairs(robberyCache.doors) do
		if #(v.coords - coords) < 0.1 then
			v.unlocked = unlocked
			v.opened = opened
			exists = true
			break
		end
	end
	if not exists then
		table.insert(robberyCache.doors, { coords = coords, unlocked = unlocked, opened = opened })
	end

	for player, _ in pairs(robberyCache.players) do
		TriggerClientEvent("robberies:unlock", player, coords, unlocked, opened)
	end
end

function CheckRobbery(robbery, robbable, coords)
	local status = 1
	local robberyCache = Robberies[robbery]
	local robberyConfig = Config.Robberies[robbery]
	-- local robbableConfig = robberyConfig.robbables[robbable]
	
	-- Cop check.
	if not Config.Debug then
		TriggerEvent("police:getCops", function(cops)
			if (robberyConfig.Cops or Config.DefaultCops) > cops then
				status = -1
			end
		end)
	end

	-- Global cooldown.
	for k, v in pairs(Robberies) do
		if k ~= robbery then
			local _robberyConfig = Config.Robberies[k]
			if _robberyConfig.Size == robberyConfig.Size then
				if os.time() - (v.time or 0) < Config.GlobalCooldowns[robberyConfig.Size] * 60 or v.robbing then
					return -5
				end
			end
		end
	end

	-- Check previous to avoid exploiting.
	if robberyConfig.EssentialOrder then
		for k, v in ipairs(robberyConfig.Robbables) do
			if type(v) == "table" and k < robbable then
				local hasRobbable = false
				for _k, _v in ipairs(robberyCache.robbables) do
					if _v.key == k and _v.stage < 0 then
						hasRobbable = true
						break
					end
				end
				if not hasRobbable then
					return -4
				end
			end
		end
	end

	local robbable = GetRobbable(robbery, coords)
	
	if robbable ~= nil then
		-- It's being robbed.
		if robbable.robbing then
			return -3
		end

		return robbable.stage or -2
	else
		return status
	end
end

function GetRobbable(robbery, coords)
	if Robberies[robbery] == nil then
		return nil
	end
	for k, v in ipairs(Robberies[robbery].robbables) do
		if #(v.coords - coords) < 0.1 then
			return v
		end
	end
end

function GetStage(robbable, stage)
	robbable = Config.Robbables[robbable]

	if robbable.Stages == nil then
		return robbable
	else
		return robbable.Stages[stage]
	end
end

function GivePayout(source, robbable, stage)
	stage = GetStage(robbable, stage)
	math.randomseed(os.time())

	local payout = stage.Payouts or 0
	local dirty = stage.Dirty or 0.0

	if type(dirty) == "table" then
		dirty = math.random(math.floor(dirty[1] * 100), math.floor(dirty[2] * 100)) / 100.0
	end
	
	if type(payout) == "table" then
		payout = math.random(math.floor(payout[1]), math.floor(payout[2]) + 1)
	end
	
	if payout ~= 0 then
		dirty = payout * dirty
		payout = payout - dirty

		TriggerEvent("core:getuser", source, function(user)
			user.addWallet(payout)

			if dirty ~= 0 then
				user.addDirty(dirty)
			end
		end)
	end
end
Robberies = {}
Players = {}
Subscribers = {}

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
				Robberies[k].robbables = {}
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
	local status = CheckRobbery(robbery, coords)
	
	if status > 0 then
		local robberyCache = Robberies[robbery]
		
		-- Cache the robbery.
		if robberyCache == nil then
			robberyCache = { robbables = {}, time = os.time() }
			Robberies[robbery] = robberyCache
		end

		local robbableCache = GetRobbable(robbery, coords)

		if robbableCache == nil then
			robbableCache = { coords = coords, time = os.time(), stage = 1, robbing = true }
			table.insert(robberyCache.robbables, robbableCache)
		else
			robbableCache.robbing = true
			robbableCache.time = os.time()
		end

		-- Cache the player.
		Players[source] = { robbery = robbery, robbable = robbableInfo, coords = coords }

		-- Dispatch police.
		if not robberyCache.dispatched or os.time() - robberyCache.dispatched > Config.DispatchCooldown then
			robberyCache.dispatched = os.time()
			local suffix = ""
			if robberyConfig.Type == "Bank" then
				suffix = "Bank"
			else
				suffix = robberyConfig.Type.." Store"
			end

			TriggerEvent("dispatch:ten-ninety", robberyConfig.Coords, ("%s %s"):format(robberyConfig.Name, suffix))
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

	TriggerClientEvent("robberies:response", source, status)
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
		Robberies[cache.robbery] = { robbables = {}, players = { [source] = true } }
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

	-- Payouts.
	GivePayout(source, cache.robbable, robbableCache.stage)

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
	local source = source
	local subscribedTo = Subscribers[source]
	if subscribedTo == nil then
		Subscribers[source] = robbery
	elseif Robberies[subscribedTo] ~= nil then
		Robberies[subscribedTo].players[source] = nil
	end

	--TODO
end)

function CheckRobbery(robbery, coords)
	local status = 1
	local robberyConfig = Config.Robberies[robbery]
	
	if not Config.Debug then
		TriggerEvent("police:getCops", function(cops)
			if (robberyConfig.Cops or Config.DefaultCops) > cops then
				status = -1
			end
		end)
	end
		end
	end)

	local robbable = GetRobbable(robbery, coords)
	
	if robbable ~= nil then
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

	if type(payout) == "table" then
		payout = math.random(math.floor(payout[1]), math.floor(payout[2]) + 1)
	end

	if payout ~= 0 then
		TriggerEvent("core:getuser", source, function(user)
			user.addWallet(payout)
		end)
	end
end

function SyncDoors(robbery)

end
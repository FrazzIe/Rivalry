local data = { machines = {}, dirty = 0 }
local wasInside = false
local isStarting = false

local function IsInside(coords)
	return #(coords - Config.Interior.Coords) < Config.Interior.Radius
end

local function DisplayText(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(text)
	EndTextCommandDisplayHelp(0, 0, 0, -1)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		-- Wait until the player is inside the interior.
		while not IsInside(GetEntityCoords(PlayerPedId())) do
			if wasInside then
				TriggerServerEvent("moneyCleaner:requestMachines", false)
			end

			wasInside = false
			Citizen.Wait(1000)
		end

		-- Loop through each machine.
		for k, v in ipairs(Config.Machines) do
			local machine = data.machines[k]
			local hasGround, groundZ = GetGroundZFor_3dCoord(v.x, v.y, v.z)
			local maxSize = Config.Marker.Size
			local col = Config.Marker.DefaultColor
			local progress = 0
			local dir = 1.0
			local isDone = false
			local isCleaning = machine ~= nil
			local dirtyRatio = 1.0
			
			-- When the machine is on...
			if machine and machine.dirty > 0 then
				dirtyRatio = machine.dirty / Config.Cleaning.MaxDirty
				progress = (GetGameTimer() - data.machines[k].startTime) / (math.max(Config.Cleaning.Duration * 60 * dirtyRatio, Config.Cleaning.MinDuration) * 1000)

				-- Determine if the machine is done cleaning.
				if progress >= 1.0 then
					isDone = true
					col = Config.Marker.FinishedColor
					dir = 0.0
				end

				progress = math.min(progress, 1.0)
			end

			-- When the machine isn't on...
			if ((not isCleaning and data.dirty > 0) or isDone) and #(v - GetEntityCoords(PlayerPedId())) < maxSize then
				local maxDirty = math.min(Config.Cleaning.MaxDirty, data.dirty)
				-- Display the help text.
				if isDone then
					DisplayText(("Press ~INPUT_CONTEXT~ to remove $%s clean!"):format(machine.dirty))
				else
					DisplayText(("Press ~INPUT_CONTEXT~ to begin cleaning $%s dirty!"):format(maxDirty))
				end

				-- When `INPUT_CONTEXT` is pressed...
				if IsControlJustReleased(1, 51) then
					isStarting = true

					local duration
					local label

					if isDone then
						duration = math.max(Config.Cleaning.EndDuration * dirtyRatio, Config.Cleaning.MinDuration) * 1000
						label = "Taking Clean Money"
					else
						duration = math.max(Config.Cleaning.StartDuration * (maxDirty / Config.Cleaning.MaxDirty), Config.Cleaning.MinDuration) * 1000
						label = "Loading Dirty Money"
					end

					exports.mythic_progbar:Progress({
						name = "moneyCleaner",
						duration = duration,
						label = label,
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = false,
							disableMouse = false,
							disableCombat = true,
						},
						animation = {
							animDict = "mp_safehousevagos@",
							anim = "package_dropoff",
							flags = 49,
						},
					}, function(status)
						if not status then
							if isDone then
								TriggerServerEvent("moneyCleaner:unloadMachine", k)
							else
								TriggerServerEvent("moneyCleaner:loadMachine", k)
							end
						end
					end)
				end
			end

			DrawMarker(27, v.x, v.y, groundZ + 0.02, 0, 0, 0, 0, 0, 0, maxSize, maxSize, 1, col.r, col.g, col.b, 255, 0, 0, 0, isCleaning and not isDone)
			if isCleaning then
				maxSize = maxSize - Config.Marker.Thickness
				if not isDone then
					DrawMarker(25, v.x, v.y, groundZ + 0.02, 0, 0, 0, 0, 0, 0, maxSize, maxSize, maxSize, col.r, col.g, col.b, 128, 0, 0, 0, 0)
				end
				maxSize = maxSize * progress
				DrawMarker(25, v.x, v.y, groundZ + 0.02, 0, 0, 0, 0, 0, 0, maxSize, maxSize, maxSize, col.r, col.g, col.b, 255, 0, 0, 0, 0)
			end
		end

		if not wasInside then
			TriggerServerEvent("moneyCleaner:requestMoney")
			TriggerServerEvent("moneyCleaner:requestMachines", true)
		end

		wasInside = true
	end
end)

RegisterNetEvent("moneyCleaner:sync")
AddEventHandler("moneyCleaner:sync", function(key, _data)
	if key == "machines" then
		for k, v in pairs(_data) do
			v.startTime = GetGameTimer() - v.timer
		end
	end

	data[key] = _data
end)

RegisterNetEvent("core:updateMoney")
AddEventHandler("core:updateMoney", function(value, moneyType)
	if moneyType == "dirty" then
		data["dirty"] = value
	end
end)
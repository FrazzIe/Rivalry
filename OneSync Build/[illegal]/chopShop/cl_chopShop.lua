Seed = 0
Peds = {}
Chopping = nil

--[[ Threads ]]--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)

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

						if vehicle and not IsPedInVehicle(ped, vehicle, false) then
							-- TODO: New Framework - use Markers export.
							SetTextComponentFormat("STRING")
							AddTextComponentString("Press ~INPUT_CONTEXT~ to scrap vehicle!")
							DisplayHelpTextFromStringLabel(0, 0, 1, -1)
							if IsControlJustPressed(1, 51) then
								ScrapVehicle(vehicle)
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

function ScrapVehicle(vehicle)
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

	-- Chop the vehicle.
	Chopping = vehicle
	TriggerServerEvent("chopShop:chopVehicle", listedVehicle)
end

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
		DeleteEntity(Chopping)
	elseif response == 1 then
		TriggerEvent("pNotify:SendNotification", { text = "Sorry, nobody works hard enough around here. I can't have your vehicle chopped.", type = "error", queue = "left", timeout = 6000, layout = "centerRight" })
	end
	Chopping = false
end)

--[[ Resource Events ]]--
AddEventHandler("onClientResourceStart", function()
	TriggerServerEvent("chopShop:requestSeed")
end)
local isFarmer = true
local isFarmerInService = false
local tractor_rent = 50
local tractor = nil
local tractor_rake = nil
local farmer_job = nil
local tractor_rake_blip, farmer_blip = nil, nil
local isLandRaked = false
local currentPathIndex = 1
local isAllRaked = 0
local plot = {x = 2186.8093261719, y = 5188.0375976563, z = 58.89741897583, h = 309.36944580078}

local locations = {
	mower = {x = 2234.9660644531, y = 5163.5834960938, z = 58.425266265869, h = 137.29484558105},
	rake = {
		marker = {x = 2201.5202636719, y = 5194.150390625, z = 60.830341339111, h = 155.92613220215},
		spawn = {x = 2191.7397460938, y = 5201.9365234375, z = 61.073333740234, h = 137.29484558105},
	},
	service = {x = 2243.3278808594, y = 5154.0966796875, z = 57.887161254883, h = 144.05862426758},
}

local scenario = "WORLD_HUMAN_GARDENER_PLANT"
local planted_seed = {}

local path = {
	[1] = {x = 2193.9150390625, y = 5188.1459960938, z = 59.059753417969, h = 39.391429901123, completed = 0},
	[2] = {x = 2187.0158691406, y = 5195.6010742188, z = 59.594276428223, h = 41.488956451416, completed = 0},
	[3] = {x = 2175.7575683594, y = 5204.5400390625, z = 60.051952362061, h = 40.563274383545, completed = 0},
	[4] = {x = 2182.5380859375, y = 5194.7612304688, z = 59.353458404541, h = 218.07431030273, completed = 0},
	[5] = {x = 2191.4995117188, y = 5184.6977539063, z = 58.670963287354, h = 221.44151306152, completed = 0},
	[6] = {x = 2198.1149902344, y = 5177.5249023438, z = 58.113025665283, h = 218.45552062988, completed = 0},
	[7] = {x = 2204.8364257813, y = 5169.9501953125, z = 57.650497436523, h = 219.80587768555, completed = 0},
	[8] = {x = 2201.2028808594, y = 5166.6201171875, z = 57.14693069458, h = 39.857002258301, completed = 0},
	[9] = {x = 2192.0178222656, y = 5176.4321289063, z = 57.919853210449, h = 39.497161865234, completed = 0},
	[10] = {x = 2184.6027832031, y = 5185.1821289063, z = 58.574562072754, h = 40.442863464355, completed = 0},
	[11] = {x = 2177.7548828125, y = 5192.9487304688, z = 59.124225616455, h = 41.262138366699, completed = 0},
	[12] = {x = 2167.4794921875, y = 5204.412109375, z = 59.627094268799, h = 42.048748016357, completed = 0},
	[13] = {x = 2157.7414550781, y = 5204.6264648438, z = 59.178524017334, h = 217.78340148926, completed = 0},
	[14] = {x = 2163.482421875, y = 5197.826171875, z = 58.948963165283, h = 220.49252319336, completed = 0},
	[15] = {x = 2170.3811035156, y = 5190.2524414063, z = 58.579944610596, h = 222.57078552246, completed = 0},
	[16] = {x = 2178.7124023438, y = 5181.2836914063, z = 57.806262969971, h = 222.77090454102, completed = 0},
	[17] = {x = 2186.6396484375, y = 5172.7026367188, z = 57.044944763184, h = 222.71524047852, completed = 0},
	[18] = {x = 2194.9296875, y = 5163.736328125, z = 56.340160369873, h = 222.73774719238, completed = 0},
}

RegisterNetEvent("farmer:set")
AddEventHandler("farmer:set", function(_isFarmer)
	isFarmerInService = false
	isFarmer = _isFarmer
end)

RegisterNetEvent("farmer:rent")
AddEventHandler("farmer:rent", function()
	Citizen.CreateThread(function()
		local model = "tractor2"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		tractor = CreateVehicle(model, locations.mower.x, locations.mower.y, locations.mower.z, locations.mower.h, true, false)
		local plate = "KKONA"..GetVehicleNumberPlateText(tractor)
		SetVehicleNumberPlateText(tractor, plate)
		SetEntityInvincible(tractor, false)
		SetPedIntoVehicle(PlayerPedId(), tractor, -1)
		SetModelAsNoLongerNeeded(model)
		DecorSetBool(tractor, "hotwire", true)
	end)
end)

local function CalculateGrowth(current_time, plant_start, plant_end)
	local total_seconds = plant_end - plant_start
	local elapsed_seconds = current_time - plant_start
	if math.floor((elapsed_seconds/total_seconds) * 100) > 100 then
		return 100
	else
		return math.floor((elapsed_seconds/total_seconds) * 100)
	end
end

local function GetGrowthInformation(current_growth)
	if current_growth >= 100 then
		return "Ready", 5
	elseif current_growth >= 80 then
		return "Flowering", 3
	elseif current_growth >= 70 then
		return "Vegetative", 2
	elseif current_growth >= 50 then
		return "Germination", 1
	elseif current_growth >= 30 then
		return "Seedling", 0
	else
		return "Seed", 0
	end
end

function spawnPlant(_x,_y,_z)
	local _plant = CreateObject(GetHashKey("prop_veg_corn_01"), _x, _y - 1, _z, true, false, false)
	plant = {
		x = _x,
		y = _y,
		z =_z,
		start_time = 0,
		end_time = 180000,
		object = _plant,
	}
	table.insert(planted_seed, plant)
end

function rakeSync()
	path[currentPathIndex].completed = 1
	currentPathIndex = currentPathIndex + 1
	for k, v in ipairs(path) do
		if(v.completed == 1) then
			isAllRaked = isAllRaked + 1
		end
	end
	print(isAllRaked)
	if (isAllRaked == 171) then
		isLandRaked = true
		currentPathIndex = 0
	end
end

function isNearAnotherPlant()
	local pos = GetEntityCoords(PlayerPedId(), false)
	if #planted_seed > 0 then
		for k, v in ipairs(planted_seed) do
			if Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 5 then
				Notify("Try planting a little further from your other crop.", 3000)
				return true
			else
				return false
			end
		end
	else
		return false
	end
end

RegisterNetEvent("plant:sync")
AddEventHandler("plant:sync", function(_plants)
	for i = 1, #_plants do
		planted_seed[i].start_time = _plants[i].start_time
		planted_seed[i].end_time = _plants[i].end_time
	end
end)

Citizen.CreateThread(function()
	CreateBlip("Crop Farms", 469, 24, locations.service.x, locations.service.y, locations.service.z)
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped, false)
		if isFarmer then
			if Vdist(pos.x, pos.y, pos.z, locations.service.x, locations.service.y, locations.service.z) < 20 then
				drawMarker(25, locations.service.x, locations.service.y, locations.service.z, 1.0, 1.0, 1.5, 0, 255, 0, 255)
				if Vdist(pos.x, pos.y, pos.z, locations.service.x, locations.service.y, locations.service.z) < 1 then
					if isFarmerInService then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~r~off duty")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to go ~g~on duty")
					end
					if IsControlJustPressed(1, 51) then
						isFarmerInService = not isFarmerInService
					end
				end
			end
			if isFarmerInService then
				if Vdist(pos.x, pos.y, pos.z, locations.mower.x, locations.mower.y, locations.mower.z) < 20 then
					drawMarker(25, locations.mower.x, locations.mower.y, locations.mower.z, 3.0, 3.0, 3.5, 0, 255, 0, 255)
					if Vdist(pos.x, pos.y, pos.z, locations.mower.x, locations.mower.y, locations.mower.z) < 3 then
						if tractor then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to return a tractor")
						elseif not tractor then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a tractor [$"..tractor_rent.."]")
						end
						if IsControlJustPressed(1, 51) then
							if tractor then
								SetEntityAsMissionEntity(tractor, true, true)
								DeleteVehicle(tractor)
								tractor = nil
							else
								TriggerServerEvent("farmer:rent")
							end
						end
					end
				end
				if tractor then
					if not tractor_rake then
						if not DoesBlipExist(tractor_rake_blip) then
							tractor_rake_blip = AddBlipForCoord(locations.rake.marker.x, locations.rake.marker.y, locations.rake.marker.z)
							SetBlipSprite(tractor_rake_blip, 1)
							SetBlipColour(tractor_rake_blip, 60)
							SetBlipAsShortRange(tractor_rake_blip, true)
							SetBlipScale(tractor_rake_blip, 0.85)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString("Trailer Collection")
							EndTextCommandSetBlipName(tractor_rake_blip)
							SetBlipRoute(tractor_rake_blip, true)
						end
						if Vdist(pos.x, pos.y, pos.z, locations.rake.marker.x, locations.rake.marker.y, locations.rake.marker.z) < 20 then
							drawMarker(25, locations.rake.marker.x, locations.rake.marker.y, locations.rake.marker.z, 1.0, 1.0, 1.5, 0, 255, 0, 255)
							if Vdist(pos.x, pos.y, pos.z, locations.rake.marker.x, locations.rake.marker.y, locations.rake.marker.z) < 1 then
								if not IsPedSittingInAnyVehicle(ped) then
									DisplayHelpText("Press ~INPUT_CONTEXT~ for a tractor rake")
									if IsControlJustPressed(1, 51) then
										Citizen.CreateThread(function()
											local model = "RakeTrailer"
											RequestModel(model)
											while not HasModelLoaded(model) do
												Citizen.Wait(0)
											end
											tractor_rake = CreateVehicle(model, locations.rake.spawn.x, locations.rake.spawn.y, locations.rake.spawn.z, locations.rake.spawn.h, true, false)
											local plate = "TR"..GetVehicleNumberPlateText(tractor_rake)
											SetVehicleNumberPlateText(tractor_rake, plate)
											SetEntityInvincible(tractor_rake, false)
											SetModelAsNoLongerNeeded(model)
										end)		
									end
								end
							end
						end
					else
						local isAttached, rake = GetVehicleTrailerVehicle(tractor, tractor_rake)
						if isAttached and rake == tractor_rake then
							if IsEntityDead(tractor_rake) and tractor_rake ~= nil then
								tractor_rake = nil
								Notify("The trailer was destroyed, go get a new one!", 3000)
							end
							if IsEntityDead(tractor) and tractor ~= nil then
								tractor = nil
								Notify("The tractor was destroyed, go get a new one!", 3000)
							end
							if DoesBlipExist(tractor_rake_blip) then
								RemoveBlip(tractor_rake_blip)
								SetBlipRoute(tractor_rake_blip, false)
								tractor_rake_blip = nil
							end
							if isAllRaked ~= 171 then
								if Vdist(pos.x, pos.y, pos.z, locations.rake.marker.x, locations.rake.marker.y, locations.rake.marker.z) < 60 and currentPathIndex ~= 19 and path[currentPathIndex].completed == 0 then
									drawMarker(25, path[currentPathIndex].x, path[currentPathIndex].y, path[currentPathIndex].z, 1.0, 1.0, 1.5, 0, 255, 0, 255)
									if Vdist(pos.x, pos.y, pos.z, path[currentPathIndex].x, path[currentPathIndex].y, path[currentPathIndex].z) < 1 then
										rakeSync(currentPathIndex)
									end
								end
							end
						else
							if IsEntityDead(tractor_rake) then
								tractor_rake = nil
								Notify("The trailer was destroyed, go get a new one!", 3000)
							end
							if IsEntityDead(tractor) then
								tractor = nil
								Notify("The tractor was destroyed, go get a new one!", 3000)
							end
						end
					end
				else
					if tractor_rake_blip then
						RemoveBlip(tractor_rake_blip)
						SetBlipRoute(tractor_rake_blip, false)
						tractor_rake_blip = nil
					end
				end
				if isLandRaked then
					if Vdist(pos.x, pos.y, pos.z, plot.x, plot.y, plot.z) < 40 and isNearAnotherPlant() == false then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to plant a seed")
						if IsControlJustPressed(1, 51) then
							TaskStartScenarioInPlace(PlayerPedId(), scenario, 0, false)
							Citizen.Wait(4000)
							ClearPedTasks(ped)
							spawnPlant(pos.x, pos.y, pos.z)
						end
					end
					for k, v in pairs(planted_seed) do
						if Vdist2(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to harvest the crop")
							local growth = CalculateGrowth(GetCurrentServerTime(), v.start_time, v.end_time)
							local message, amount = GetGrowthInformation(growth)
							Draw3DText(v.x, v.y, v.z, growth.."%")
							Draw3DText(v.x, v.y, v.z-0.1, message.." ["..amount.."]")
							if IsControlJustPressed(1, 51) then
								if growth >= 50 then
									TriggerServerEvent("plant:harvest", k, growth, amount)
									TaskStartScenarioInPlace(PlayerPedId(), scenario, 0, false);
									Citizen.Wait(4000)
									ClearPedTasks(ped)
									DestoryObject(v.object)
									table.remove(v)
								end
							end
						end
					end
				end
			end
		end
	end
end)
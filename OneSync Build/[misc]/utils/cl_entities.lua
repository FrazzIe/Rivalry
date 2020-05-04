--[[ Enumeration ]]--
-- https://gist.github.com/IllidanS4/9865ed17f60576425369fc1da70259b2
local EntityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
		enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
		
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, EntityEnumerator)
		
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
		
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

local function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

local function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

local function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

local Objects = {}
local Peds = {}
local Vehicles = {}
local NearestVehicle = 0
local NearestPed = 0

--[[ Threads ]]--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local playerPed = PlayerPedId()
		local playerPos = GetEntityCoords(playerPed)
		
		-- Objects.
		Objects = {}
		
		for object, _ in EnumerateObjects() do
			Objects[#Objects + 1] = object
		end
		
		-- Peds.
		Peds = {}
		NearestPed = 0
		NearestPedDistance = 0.0

		for ped, _ in EnumeratePeds() do
			if ped ~= playerPed then
				Peds[#Peds + 1] = ped

				local dist = #(playerPos - GetEntityCoords(ped))
				if NearestPed == 0 or dist < NearestPedDistance then
					NearestPedDistance = dist
					NearestPed = ped
				end
			end
		end
		
		-- Vehicles.
		Vehicles = {}
		NearestVehicle = 0
		NearestVehicleDistance = 0.0

		for vehicle, _ in EnumerateVehicles() do
			Vehicles[#Vehicles + 1] = vehicle
			
			local dist = #(playerPos - GetEntityCoords(vehicle))
			if NearestVehicle == 0 or dist < NearestVehicleDistance then
				NearestVehicleDistance = dist
				NearestVehicle = vehicle
			end
		end

		-- Pickups.
		for pickup, _ in EnumeratePickups() do
			RemovePickup(pickup)
		end
	end
end)

--[[ Exports ]]--
exports("FindObject", function(findFunc, comparer)
	
end)

exports("GetObjects", function()
	return Objects
end)

exports("GetPeds", function()
	return Peds
end)

exports("GetVehicles", function()
	return Vehicles
end)

exports("GetNearestVehicle", function()
	return NearestVehicle
end)

exports("GetNearestPed", function()
	return NearestPed
end)
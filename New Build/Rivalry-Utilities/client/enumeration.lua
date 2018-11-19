Utilities.Data.Enumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

function Utilities:EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
	
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, self.Data.Enumerator)
	
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
	
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function Utilities:EnumerateObjects()
    return self:EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function Utilities:EnumeratePeds()
    return self:EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function Utilities:EnumerateVehicles()
    return self:EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function Utilities:EnumeratePickups()
    return self:EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end
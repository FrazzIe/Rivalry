interiorID = GetInteriorAtCoords(442.78, -984.02, 30.68) --placeholder x: 442.78, y: -984.022, z: 30,6896

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsValidInterior(interiorID) then
			LoadInterior(interiorID)
		end
	end
end)
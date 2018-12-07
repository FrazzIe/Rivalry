local doors_locked = {
	single = {
		[1] = {x = -1002.4011230469, y = -477.61575317383, z = 50.027568817139, model = -2030220382, heading = 299.10842895508}, -- Property door (Movie studio)
	},
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		for k,v in pairs(doors_locked.single) do
			if not DoesEntityExist(v.handle) then
				v.handle =  GetClosestObjectOfType(v.x, v.y, v.z, 0.5, v.model, false, false, false)
			end

			if v.handle ~= nil and v.handle ~= 0 then
				SetEntityHeading(v.handle, v.heading)
			end
		end
	end
end)
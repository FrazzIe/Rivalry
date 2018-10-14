local Scrap = {
	Data = {
		Doors = {
			{x = -589.53009033203, y = -1621.603515625, z = 33.161777496338, h = 174.73043823242, model = 812467272},
			{x = -590.82397460938, y = -1621.5015869141, z = 33.162761688232, h = 354.52551269531, model = 812467272},
		},
	},
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for k, v in ipairs(Scrap.Data.Doors) do
			local entity = GetClosestObjectOfType(v.x, v.y, v.z, 5.0, v.model, 0, 1, 1)
			SetEntityAsMissionEntity(entity, true, true)
			DeleteEntity(entity)
		end
	end
end)
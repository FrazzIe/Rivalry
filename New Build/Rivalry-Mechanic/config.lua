Mechanic = {
	Data = {
		IsMechanic = false,
		OnDuty = false,
	},
}

if not IsDuplicityVersion() then
	Mechanic.Vehicles = {
		["flatbed"] = {
			Control = {
				Offset = vector3(-1.4982982969284, -5.1126073908806, 0.0),
				Position = nil,
				Direction = vector3(0.5, 0.5, 1.0),
				Colour = {255, 0, 0, 100},
			},
			Target = {
				Offset = {0.0, -8.1126073908806, 0.0},
				Position = nil,
			},
			Vehicle = nil,
			Help = true,
			Dimensions = nil,
			AttachedVehicle = 0,
		},
		["towtruck"] = {
			Control = {
				Offset = vector3(-1.4882982969284, -3.1126073908806, 0.0),
				Position = nil,
				Direction = vector3(0.5, 0.5, 1.0),
				Colour = {255, 0, 0, 100},
			},
			Target = {
				Offset = {0.0, -6.1126073908806, 0.0},
				Position = nil,
			},
			Vehicle = nil,
			LastVehicle = nil,
			Height = 0.5,
			Help = true,
			Dimensions = nil,
		},
		["towtruck2"] = {
			Control = {
				Offset = vector3(-1.1469407081604, -0.40072667598724, 0.0),
				Position = nil,
				Direction = vector3(0.5, 0.5, 1.0),
				Colour = {255, 0, 0, 100},
			},
			Target = {
				Offset = {0.0, -6.1126073908806, 0.0},
				Position = nil,
			},
			Vehicle = nil,
			LastVehicle = nil,
			Height = 0.5,
			Help = true,
			Dimensions = nil,
		},
	}

	function Mechanic:AddControls(Key, Func)
		if self.Vehicles[Key] then
			self.Vehicles[Key].Controls = Func
		end
	end
end
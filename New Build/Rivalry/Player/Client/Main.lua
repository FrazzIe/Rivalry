Player = {
	Ready = false,
	Id = nil,
	Ped = nil,
	Coordinates = nil,
	Heading = nil,
	Dead = false,
	Cuffs = {
		Active = false,
		Type = false,
		Component = {Drawable = nil, Texture = nil, Palette = nil},
	},
	Stance = {
		Enabled = false,
		Standing = true,
		Crouched = false,
		Proned = false,
		GoingUp = false,
		OnBack = false,
	},
	HandsUp = false,
	OnKnees = false,
	Dragged = {
		Being = false,
		Was = false,
		By = false,
	},
	BAC = 0.00,
	DrunkState = 0,
	Residue = {
		Active = false,
		Timer = 0,
	},
	Playtime = 0,
	Vehicle = {
		Current = nil,
		Last = nil,
		Using = nil,
		Seatbelt = false,
	},
	Walkstyle = "",
}

CreateDecorator("_Player_Down", 2)
CreateDecorator("_Player_Cuffed", 2)
CreateDecorator("_Player_Cuffed_Type", 2)
CreateDecorator("_Player_Stance", 3)
CreateDecorator("_Player_BAC", 1)
CreateDecorator("_Player_Drunk_State", 3)
CreateDecorator("_Player_Residue", 2)
CreateDecorator("_Player_Seatbelt", 2)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		Player.Id = PlayerId()
		if Player.Ped ~= PlayerPedId() then
			Player.Ped = PlayerPedId()
			SetDecorator(Player.Ped, "_Player_Down", Player.Dead)
			SetDecorator(Player.Ped, "_Player_Cuffed", Player.Cuffs.Active)
			SetDecorator(Player.Ped, "_Player_Cuffed_Type", Player.Cuffs.Type)
			SetDecorator(Player.Ped, "_Player_Stance", (Player.Stance.Standing and 1 or (Player.Stance.Crouched and 2 or (Player.Stance.Proned and 3 or 1))))
			SetDecorator(Player.Ped, "_Player_BAC", Player.BAC)
			SetDecorator(Player.Ped, "_Player_Drunk_State", Player.DrunkState)
			SetDecorator(Player.Ped, "_Player_Residue", Player.Residue.Active)
			SetDecorator(Player.Ped, "_Player_Seatbelt", Player.Vehicle.Seatbelt)

			if not Player.Stance.Crouched then
				if Player.Walkstyle ~= "" then
					SetPedMovementClipset(PlayerPedId(), Player.Walkstyle, 1.0)
				end
			end
		end
		Player.Coordinates = GetEntityCoords(Player.Ped, false)
		Player.Heading = GetEntityHeading(Player.Ped)
		Player.Vehicle.Current = GetVehiclePedIsIn(Player.Ped, false)
		Player.Vehicle.Last = GetVehiclePedIsIn(Player.Ped, true)
		Player.Vehicle.Using = GetVehiclePedIsUsing(Player.Ped)
		if not Player.Ready then Player.Ready = true end
	end
end)
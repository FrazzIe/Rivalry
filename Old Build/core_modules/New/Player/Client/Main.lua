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
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		Player.Id = PlayerId()
		if Player.Ped ~= PlayerPedId() then
			Player.Ped = PlayerPedId()
		end
		Player.Coordinates = GetEntityCoords(Player.Ped, false)
		Player.Heading = GetEntityHeading(Player.Ped)
		Player.Vehicle.Current = GetVehiclePedIsIn(Player.Ped, false)
		Player.Vehicle.Last = GetVehiclePedIsIn(Player.Ped, true)
		Player.Vehicle.Using = GetVehiclePedIsUsing(Player.Ped)
		if not Player.Ready then Player.Ready = true end
	end
end)

local count = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(IsPedJumping(PlayerPedId()))then
			count = count + 0.03
		end
		if(math.floor(count) == 4)then
			SetPedToRagdoll(PlayerPedId(), 2000, 2000, 0, 0, 0, 0)
			count = 0
		end
	end
end)

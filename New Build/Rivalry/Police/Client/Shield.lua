Shield = {
	Active = false,
	Handle = nil,
	Models = {
		Ballistic = "prop_ballistic_shield",
		Riot = "prop_riot_shield",
	},
	State = {
		Current = nil,
		Previous = nil,
	},
	Position = {
		Inactive = {
			{x = 0.0899995, y = -0.255, z = 0.260001},
			{x = 5.44001, y = 1.08002, z = -363.882},
		},
		Melee = {
			{x = 0.0, y = -0.0700002, z = 0.0},
			{x = 39.0, y = 188.5, z = 4.0},
		},
		Armed = {
			{x = -0.255001, y = 0.11, z = -0.18},
			{x = 57.4701, y = 198.83, z = 25.4501},
		},
		Reloading = {
			{x = 0.500001, y = 0.045, z = -0.04},
			{x = -248.81, y = 8.92, z = -126.71},
		},
	},
	Bone = {
		Inactive = 0,
		Melee = 36029,
		Armed = 36029,
		Reloading = 5232,
	},
	Animation = {
		Dictionary = "weapons@pistol_1h@gang",
		Aim = "aim_med_loop",
	},
}

AddAnimDictionary(Shield.Animation.Dictionary)

function Shield.Create()
	local Model = GetHashKey(Shield.Models.Riot)
	RequestModel(Model)
	
	while not HasModelLoaded(Model) do
		Citizen.Wait(250)
	end

	Shield.Handle = CreateObject(Model, Player.Coordinates.x, Player.Coordinates.x, Player.Coordinates.z, true, false, false)
	SetModelAsNoLongerNeeded(Model)
	SetEntityAlpha(Shield.Handle, 0)
	SetEntityInvincible(Shield.Handle, true)
	Shield.State.Current = ""
	Shield.Active = true
end

function Shield.Destroy()
	Shield.Active = false
	if IsEntityPlayingAnim(Player.Ped, Shield.Animation.Dictionary, Shield.Animation.Aim, 3) and (Shield.State.Current == "Inactive" or Shield.State.Current == "Reloading" or Shield.State.Current == "Melee") then
		StopAnimTask(Player.Ped, Shield.Animation.Dictionary, Shield.Animation.Aim, 1.0)
	end
	
	DetachEntity(Shield.Handle, true, false)
	DestroyObject(Shield.Handle)
	
	Shield.Handle = nil
	Shield.State.Current = ""

	StopAnimTask(Player.Ped, Shield.Animation.Dictionary, Shield.Animation.Aim, 1.0)
	SetPedCanArmIk(Player.Ped, true)
end

function Shield.Detach()
	SetEntityAlpha(Shield.Handle, 0)
	DetachEntity(Shield.Handle, true, false)
end

function Shield.Attach()
	local Position, Bone = Shield.Position[Shield.State.Current], GetPedBoneIndex(Player.Ped, Shield.Bone[Shield.State.Current])
	
	AttachEntityToEntity(Shield.Handle, Player.Ped, Bone, Position[1].x, Position[1].y, Position[1].z, Position[2].x, Position[2].y, Position[2].z, false, false, false, false, 2, true)
	SetEntityAlpha(Shield.Handle, 255)
end

function Shield.Update()
	if Shield.State.Current ~= Shield.State.Previous then
		Shield.State.Previous = Shield.State.Current
		Shield.Detach()
		Shield.Attach()
		
		if IsEntityPlayingAnim(Player.Ped, Shield.Animation.Dictionary, Shield.Animation.Aim, 3) and (Shield.State.Current == "Inactive" or Shield.State.Current == "Reloading" or Shield.State.Current == "Melee") then
			StopAnimTask(Player.Ped, Shield.Animation.Dictionary, Shield.Animation.Aim, 1.0)
		end
	end
end

function Shield.Animations()
	if Shield.State.Current ~= "Armed" or (IsPedReloading(Player.Ped) or IsPedJumping(Player.Ped) or IsPedFalling(Player.Ped) or IsPedRagdoll(Player.Ped)) then
		return
	end

	SetPedCanArmIk(Player.Ped, true)

	if not IsEntityPlayingAnim(Player.Ped, Shield.Animation.Dictionary, Shield.Animation.Aim, 3) then
		TaskPlayAnim(Player.Ped, Shield.Animation.Dictionary, Shield.Animation.Aim, 8.0, 4.0, -1, 49, 0, false, false, false)
	else
		if IsPedReloading(Player.Ped) or IsPedJumping(Player.Ped) or IsPedFalling(Player.Ped) or IsPedRagdoll(Player.Ped) then
			StopAnimTask(Player.Ped, Shield.Animation.Dictionary, Shield.Animation.Aim, 1.0)
		end
	end
	SetPedCanArmIk(Player.Ped, false)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Player.Ready then
			if Shield.Active then
				local _, Weapon = GetCurrentPedWeapon(Player.Ped, 1)
				local WeaponGroupType = GetWeapontypeGroup(Weapon)
				if WeaponGroupType == 416676503 or Weapon == 911657153 then
					DisableControlAction(0, 25, true)
					DisableControlAction(1, 25, true)
					DisableControlAction(2, 25, true)
					
					if not IsPedReloading(Player.Ped) then
						if Shield.State.Current ~= "Armed" then
							Shield.State.Current = "Armed"
						end
					else
						if Shield.State.Current ~= "Reloading" then
							Shield.State.Current = "Reloading"
						end
					end
				elseif WeaponGroupType == -728555052 then
					if Shield.State.Current ~= "Melee" then
						Shield.State.Current = "Melee"
					end
				else
					if Shield.State.Current ~= "Inactive" then
						Shield.State.Current = "Inactive"
					end		
				end
				
				Shield.Update()
				Shield.Animations()
			end
		end
	end
end)
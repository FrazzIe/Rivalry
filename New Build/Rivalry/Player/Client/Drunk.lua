local Drunk = {
	Slightly = "MOVE_M@DRUNK@SLIGHTLYDRUNK",
	Moderate = "MOVE_M@DRUNK@MODERATEDRUNK",
	Very = "MOVE_M@DRUNK@VERYDRUNK",
	Shake = "DRUNK_SHAKE",
	Walkstyle = "",
}

local SetDrunkState = {
	[1] = function()
		Player.Walkstyle = Drunk.Walkstyle

		if not Player.Stance.Crouched then
			if Player.Walkstyle ~= "" then
				SetPedMovementClipset(Player.Ped, Player.Walkstyle, 1.0)
			else
				ResetPedMovementClipset(Player.Ped, 1.0)
			end
		end

		SetPedIsDrunk(Player.Ped, false)
		SetPedMotionBlur(Player.Ped, false)
		ShakeGameplayCam(Drunk.Shake, 0.0)
	end,
	[2] = function()
		if Player.Walkstyle ~= Drunk.Slightly and Player.Walkstyle ~= Drunk.Moderate and Player.Walkstyle ~= Drunk.Very then
			Drunk.Walkstyle = Player.Walkstyle
		end

		Player.Walkstyle = Drunk.Slightly

		if not Player.Stance.Crouched then
			SetPedMovementClipset(Player.Ped, Player.Walkstyle, 1.0)
		end

		SetPedIsDrunk(Player.Ped, true)
		SetPedMotionBlur(Player.Ped, true)
		ShakeGameplayCam(Drunk.Shake, 0.25)
	end,
	[3] = function()
		if Player.Walkstyle ~= Drunk.Slightly and Player.Walkstyle ~= Drunk.Moderate and Player.Walkstyle ~= Drunk.Very then
			Drunk.Walkstyle = Player.Walkstyle
		end

		Player.Walkstyle = Drunk.Moderate

		if not Player.Stance.Crouched then
			SetPedMovementClipset(Player.Ped, Player.Walkstyle, 1.0)
		end

		SetPedIsDrunk(Player.Ped, true)
		SetPedMotionBlur(Player.Ped, true) 
		ShakeGameplayCam(Drunk.Shake, 1.0)
	end,
	[4] = function()
		if Player.Walkstyle ~= Drunk.Slightly and Player.Walkstyle ~= Drunk.Moderate and Player.Walkstyle ~= Drunk.Very then
			Drunk.Walkstyle = Player.Walkstyle
		end

		Player.Walkstyle = Drunk.Very

		if not Player.Stance.Crouched then
			SetPedMovementClipset(Player.Ped, Player.Walkstyle, 1.0)
		end

		SetPedIsDrunk(Player.Ped, true)
		SetPedMotionBlur(Player.Ped, true) 
		ShakeGameplayCam(Drunk.Shake, 2.0)
	end,
	[5] = function()
		Player.Walkstyle = Drunk.Walkstyle

		if not Player.Stance.Crouched then
			if Player.Walkstyle ~= "" then
				SetPedMovementClipset(Player.Ped, Player.Walkstyle, 1.0)
			else
				ResetPedMovementClipset(Player.Ped, 1.0)
			end
		end

		SetEntityHealth(Player.Ped, 0.0)
		Player.BAC = 0
		SetDecorator(Player.Ped, "_Player_BAC", Player.BAC)
	end,
}

AddAnimSet(Drunk.Very)
AddAnimSet(Drunk.Moderate)
AddAnimSet(Drunk.Slightly)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Player.Ready then
			local DrunkState = CaluclateDrunkState()
			if DrunkState ~= Player.DrunkState then
				Player.DrunkState = DrunkState
				SetDecorator(Player.Ped, "_Player_Drunk_State", Player.DrunkState)
				SetDrunkState[DrunkState]()
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Player.BAC > 0 then
			Citizen.Wait(60000)
			ReduceBloodAlcoholContent(GetRandomFloatInRange(0.01, 0.025))
		end
	end
end)

function IncreaseBloodAlcoholContent(Amount)
	if IsPedMale(Player.Ped) then
		Player.BAC = Player.BAC + Amount
	else
		Player.BAC = Player.BAC + Amount + GetRandomFloatInRange(0.03, 0.045)
	end

	SetDecorator(Player.Ped, "_Player_BAC", Player.BAC)
end

function ReduceBloodAlcoholContent(Amount)
	if Amount then
		Player.BAC = Player.BAC - Amount
	end
	
	if Player.BAC < 0 then Player.BAC = 0 end

	SetDecorator(Player.Ped, "_Player_BAC", Player.BAC)
end

function CaluclateDrunkState()
	return ((Player.BAC >= 0.07 and Player.BAC < 0.16) and 2 or ((Player.BAC >= 0.16 and Player.BAC < 0.22) and 3 or ((Player.BAC >= 0.22 and Player.BAC < 0.27) and 4 or ((Player.BAC >= 0.27) and 5 or 1))))
end
local Stance = {
	Timer = 0,
	Prone = {
		Dictionary = "move_crawl",
		Front = {
			Forward = "onfront_fwd",
			Backward = "onfront_bwd",
		},
		Back = {
			Forward = "onback_fwd",
			Backward = "onback_bwd",
		},
	},
	Stand = {
		Dictionary = "get_up@directional@movement@from_knees@standard",
		Animation = "getup_l_0"
	},
	Dive = {
		Dictionary = "move_jump",
		Animation = "dive_start_run",
	},
	Crouch = "move_ped_crouched",
	Surrender = {
		Dictionary = "missminuteman_1ig_2",
		Animation = "handsup_enter",
	},
	Kneeling = {
		Start = {
			Dictionary = "random@arrests@busted",
			Enter = "enter",
			Exit = "exit",
			Idle = "idle_a",
		},
		End = {
			Dictionary = "random@arrests",
			Animation = "kneeling_arrest_get_up",
		},
	}
}

AddAnimDictionary(Stance.Prone.Dictionary)
AddAnimDictionary(Stance.Stand.Dictionary)
AddAnimDictionary(Stance.Dive.Dictionary)
AddAnimSet(Stance.Crouch)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DisableControlAction(0, 36, true) 
		if (Player.Stance.Proned or Player.Stance.Crouched) and Player.Dead then
			Player.Stance.Standing = true
			Player.Stance.Crouched = false
			Player.Stance.Proned = false
		end
		if Player.Stance.Proned and Player.Cuffs.Active then
			Player.Stance.Standing = false
			Player.Stance.Crouched = true
			Player.Stance.Proned = false
			SetPedMovementClipset(Player.Ped, Stance.Crouch, 0.45)
		end
		if (Player.Stance.Proned or Player.Stance.Crouched) and Player.OnKnees then
			Player.Stance.Standing = true
			Player.Stance.Crouched = false
			Player.Stance.Proned = false
			Player.Stance.GoingUp = false
			ResetPedMovementClipset(Player.Ped, 0.45)
		end
		if Player.Stance.Proned and Player.HandsUp then
			Player.Stance.Standing = true
			Player.Stance.Crouched = false
			Player.Stance.Proned = false
			Player.Stance.GoingUp = false
			ResetPedMovementClipset(Player.Ped, 0.45)
		end
		if IsDisabledControlJustPressed(0, 36) and not Player.Dead and not IsPedSittingInAnyVehicle(Player.Ped) then
			Stance.Timer = 0
			while IsDisabledControlPressed(0, 36) and Stance.Timer ~= 30 do
				Citizen.Wait(1)
				Stance.Timer = Stance.Timer + 1
			end
			if Stance.Timer >= 30 then
				if Player.Stance.Standing then
					if not Player.Cuffs.Active and not Player.HandsUp and not Player.OnKnees then
						Player.Stance.Standing = false
						Player.Stance.Crouched = false
						Player.Stance.Proned = true
						Player.Stance.GoingUp = true
						if IsPedRunning(Player.Ped) or IsPedSprinting(Player.Ped) or GetEntitySpeed(Player.Ped) > 4.7 then
							TaskPlayAnim(Player.Ped, Stance.Dive.Dictionary, Stance.Dive.Animation, 4.0, 0, -1, 15, 1.0, 0, 1, 0)
							Citizen.Wait(1250)
						end
						ClearPedTasks(Player.Ped)
						TaskPlayAnim(Player.Ped, Stance.Prone.Dictionary, Stance.Prone.Front.Forward, 8.0, 0, -1, 0, 1.0, 0, 1, 0)
					else
						Player.Stance.Standing = false
						Player.Stance.Crouched = true
						Player.Stance.Proned = false
						Player.Stance.GoingUp = false
						SetPedMovementClipset(Player.Ped, Stance.Crouch, 0.45)						
					end
				elseif Player.Stance.Crouched then
					if Player.Stance.GoingUp then
						if not Player.Cuffs.Active and not Player.HandsUp and not Player.OnKnees then
							Player.Stance.Standing = false
							Player.Stance.Crouched = false
							Player.Stance.Proned = true
							Player.Stance.GoingUp = true
							ResetPedMovementClipset(Player.Ped, 0.45)
							TaskPlayAnim(Player.Ped, Stance.Prone.Dictionary, Stance.Prone.Front.Forward, 8.0, 0, -1, 0, 1.0, 0, 1, 0)
						else
							Player.Stance.Standing = false
							Player.Stance.Crouched = true
							Player.Stance.Proned = false
							Player.Stance.GoingUp = false
							SetPedMovementClipset(Player.Ped, Stance.Crouch, 0.45)
						end
					else
						Player.Stance.Standing = true
						Player.Stance.Crouched = false
						Player.Stance.Proned = false
						Player.Stance.GoingUp = false
						ResetPedMovementClipset(Player.Ped, 0.45)
					end
				elseif Player.Stance.Proned then
					Player.Stance.Standing = true
					Player.Stance.Crouched = false
					Player.Stance.Proned  = false
					Player.Stance.GoingUp = false
					TaskPlayAnim(Player.Ped, Stance.Stand.Dictionary, Stance.Stand.Animation, 8.0, 0, -1, 2, 0.0, 0, 0, 0)
					Citizen.Wait(1875)
					ClearPedTasksImmediately(Player.Ped)
				end
			else
				if Player.Stance.Standing then
					Player.Stance.Standing = false
					Player.Stance.Crouched = true
					Player.Stance.Proned = false
					Player.Stance.GoingUp = false
					SetPedMovementClipset(Player.Ped, Stance.Crouch, 0.45)
				elseif Player.Stance.Crouched then
					if not Player.Cuffs.Active and not Player.HandsUp and not Player.OnKnees then
						if not Player.Stance.GoingUp then
							Player.Stance.Standing = false
							Player.Stance.Crouched = false
							Player.Stance.Proned = true
							Player.Stance.GoingUp = true
							ResetPedMovementClipset(Player.Ped, 0.45)
							TaskPlayAnim(Player.Ped, Stance.Prone.Dictionary, Stance.Prone.Front.Forward, 8.0, 0, -1, 0, 1.0, 0, 1, 0)
						else
							Player.Stance.Standing = true
							Player.Stance.Crouched = false
							Player.Stance.Proned = false
							Player.Stance.GoingUp = false
							ResetPedMovementClipset(Player.Ped, 0.45)
						end
					else
						Player.Stance.Standing = true
						Player.Stance.Crouched = false
						Player.Stance.Proned = false
						Player.Stance.GoingUp = false
						ResetPedMovementClipset(Player.Ped, 0.45)
					end
				elseif Player.Stance.Proned then
					Player.Stance.Standing = false
					Player.Stance.Crouched = true
					Player.Stance.Proned = false
					Player.Stance.GoingUp = true
					ClearPedTasksImmediately(Player.Ped)
					SetPedMovementClipset(Player.Ped, Stance.Crouch, 0.45)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Player.Stance.Proned then
			local Heading = GetEntityHeading(Player.Ped)
			if IsControlPressed(0, 34) and Player.Stance.Proned then
				SetEntityHeading(Player.Ped, Heading + 1.5)
			elseif IsControlPressed(0, 35) and Player.Stance.Proned then
				SetEntityHeading(Player.Ped, Heading - 1.5)
			end
            if IsControlJustPressed(0, 21) and Player.Stance.Proned then
                if Player.Stance.OnBack then
                    Player.Stance.OnBack = false
                	TaskPlayAnim(Player.Ped, Stance.Prone.Dictionary, Stance.Prone.Front.Forward, 8.0, 1, -1, 2, 1.0, 0, 1, 0)
                else
                    Player.Stance.OnBack = true
                	TaskPlayAnim(Player.Ped, Stance.Prone.Dictionary, Stance.Prone.Back.Backward, 8.0, 1, -1, 2, 1.0, 0, 1, 0)
                end
            end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Player.Stance.Proned then
			if Player.Stance.OnBack then
                if IsControlPressed(0, 32) then
                    TaskPlayAnim(Player.Ped, Stance.Prone.Dictionary, Stance.Prone.Back.Forward, 8.0, 1, -1, 2, 0.0, 0, 0, 0)
                    Citizen.Wait(1100)
                end
                if IsControlPressed(0, 8) then
                    TaskPlayAnim(Player.Ped, Stance.Prone.Dictionary, Stance.Prone.Back.Backward, 8.0, 1, -1, 2, 0.0, 0, 0, 0)
                    Citizen.Wait(1100)
                end
			else
                if IsControlPressed(0, 32) then
                    TaskPlayAnim(Player.Ped, Stance.Prone.Dictionary, Stance.Prone.Front.Forward, 8.0, 1, -1, 2, 0.0, 0, 0, 0)
                    Citizen.Wait(750)
                end
                if IsControlPressed(0, 8) then
                    TaskPlayAnim(Player.Ped, Stance.Prone.Dictionary, Stance.Prone.Front.Backward, 8.0, 1, -1, 2, 0.0, 0, 0, 0)
                    Citizen.Wait(950)
                end
			end
		end
	end
end)
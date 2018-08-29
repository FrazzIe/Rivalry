local Animations = {
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

AddAnimDictionary(Animations.Surrender.Dictionary)
AddAnimDictionary(Animations.Kneeling.Start.Dictionary)
AddAnimDictionary(Animations.Kneeling.End.Dictionary)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if IsControlJustPressed(1, 323) and not Player.Cuffs.Active then
            if not IsPedSittingInAnyVehicle(Player.Ped) and not Player.Stance.Proned and not Player.HandsUp and not Player.OnKnees and not Player.Dead then
            	Player.HandsUp = true
            	TaskPlayAnim(Player.Ped, Animations.Surrender.Dictionary, Animations.Surrender.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
            elseif Player.HandsUp then
            	Player.HandsUp = false
            	ClearPedSecondaryTask(Player.Ped)
            end
        end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, 289) and not Player.Cuffs.Active then
			if not IsPedSittingInAnyVehicle(Player.Ped) and not Player.Stance.Proned and not Player.Stance.HandsUp and not Player.OnKnees and not Player.Dead then
				Player.OnKnees = true
				ClearPedTasks(Player.Ped)
				TaskPlayAnim(Player.Ped, Animations.Kneeling.Start.Dictionary, Animations.Kneeling.Start.Enter, 4.0, -4, -1, 21, 0, 0, 0, 0)
				Citizen.Wait(1650)
				TaskPlayAnim(Player.Ped, Animations.Kneeling.Start.Dictionary, Animations.Kneeling.Start.Idle, 4.0, -4, -1, 15, 0, 0, 0, 0)
			elseif Player.OnKnees then
				Player.OnKnees = false
				TaskPlayAnim(Player.Ped, Animations.Kneeling.Start.Dictionary, Animations.Kneeling.Start.Exit, 4.0, -4, -1, 15, 0, 0, 0, 0)
				Citizen.Wait(1950)
				TaskPlayAnim(Player.Ped, Animations.Kneeling.End.Dictionary, Animations.Kneeling.End.Animation, 4.0, -4, -1, 15, 0, 0, 0, 0)
				Citizen.Wait(2250)
				ClearPedTasksImmediately(Player.Ped)
			end
		end
	end
end)
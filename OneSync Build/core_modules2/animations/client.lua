Citizen.CreateThread(function()
	local dict = "friends@frj@ig_1"

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 57) then --Start holding X
			if not handsup then
				local PlayerPed = PlayerPedId()
				TaskPlayAnim(PlayerPed, dict, "wave_a", 8.0, 8.0, -1, 50, 0, false, false, false)
				Citizen.Wait(5000)
				ClearPedTasks(PlayerPed)
				handsup = true
			else
				handsup = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	local dict = "amb@code_human_police_investigate@base"

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 74) then
			local PlayerPed = PlayerPedId()
			if not handsup and not IsPedSittingInAnyVehicle(PlayerPed) then
				TaskPlayAnim(PlayerPed, dict, "base", -4.0, 4.0, -1, 49, 0, false, false, false)
				handsup = true
			else
				handsup = false
				ClearPedTasks(PlayerPed)
			end
		end
	end
end)

Citizen.CreateThread(function()
	local dict = "amb@world_human_hang_out_street@female_arms_crossed@base"
	
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 168) then --Start holding X
			local PlayerPed = PlayerPedId()
			if not handsup then
				TaskPlayAnim(PlayerPed, dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
				handsup = true
			else
				handsup = false
				ClearPedTasks(PlayerPed)
			end
		end
	end
end)

--[[Citizen.CreateThread(function()
	local dict = "mp_player_intfinger"

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 167) then --Start holding X
			if not handsup then
				local PlayerPed = PlayerPedId()
				TaskPlayAnim(PlayerPed, dict, "mp_player_int_finger", 8.0, 8.0, -1, 50, 0, false, false, false)
				Citizen.Wait(5000)
				ClearPedTasks(PlayerPed)
				handsup = true
			else
				handsup = false
			end
		end
	end
end)--]]

Citizen.CreateThread(function()
	local dict = "anim@mp_player_intcelebrationmale@face_palm"

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 56) then --Start holding X
			if not handsup then
				local PlayerPed = PlayerPedId()
				TaskPlayAnim(PlayerPed, dict, "face_palm", 8.0, 8.0, -1, 50, 0, false, false, false)
				Citizen.Wait(9000)
				ClearPedTasks(PlayerPed)
				handsup = true
			else
				handsup = false
			end
		end
	end
end)
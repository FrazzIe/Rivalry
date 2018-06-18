local Animations = {
	Handcuffs = {
		Dictionary = "mp_arresting",
		Uncuff = "a_uncuff",
		Cuffed = "idle",
	},
	Arresting = {
		Dictionary = "mp_arrest_paired",
		Cop = "cop_p3_fwd",
		Criminal = "crook_p3",
	},
}


AddAnimDictionary(Animations.Handcuffs.Dictionary)
AddAnimDictionary(Animations.Arresting.Dictionary)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Player.Cuffs.Active then
			if IsPedRunningRagdollTask(Player.Ped) then
				while IsPedRunningRagdollTask(Player.Ped) do
					Citizen.Wait(0)
				end
				ClearPedTasksImmediately(Player.Ped)
			end
			if Player.Cuffs.Type then
				TaskPlayAnim(Player.Ped, Animations.Handcuffs.Dictionary, Animations.Handcuffs.Cuffed, 8.0, -8, -1, 16, 0, 0, 0, 0)
			else
				if not IsEntityPlayingAnim(Player.Ped, Animations.Handcuffs.Dictionary, Animations.Handcuffs.Cuffed, 3) then
					Citizen.Wait(100)
					TaskPlayAnim(Player.Ped, Animations.Handcuffs.Dictionary, Animations.Handcuffs.Cuffed, 8.0, -8, -1, 49, 0, 0, 0, 0)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Player.Cuffs.Active then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 25, true)
			SetPedPathCanUseLadders(Player.Ped, false)
			if IsPedInAnyVehicle(Player.Ped, false) then
				DisableControlAction(0, 59, true)
			end
		end
		if Player.Ready then
			for Index = 0, 32 do
				if NetworkIsPlayerActive(Index) then
					local TargetPed = GetPlayerPed(Index)
					if DoesEntityExist(TargetPed) and TargetPed ~= Player.Ped then
						local TargetServerId = GetPlayerServerId(Index)
						local TargetPosition = GetEntityCoords(TargetPed, false)
						local Distance = GetDistanceBetweenCoords(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, TargetPosition.x, TargetPosition.y, TargetPosition.z, true)
						if Distance < 1.1 then
							local TargetCuffed, TargetCuffType, TargetDead = GetDecorator(TargetPed, "_Player_Cuffed"), GetDecorator(TargetPed, "_Player_Cuffed_Type"), GetDecorator(TargetPed, "_Player_Down")
							if IsPolice and IsOnDuty then
								if IsPlayerFreeAiming(Player.Id) then
									if not TargetCuffed then
										DisplayHelpText("Press ~INPUT_CONTEXT~ to cuff "..exports.core:GetCharacterName(TargetServerId)) --GetCharacterName might change
										if IsControlJustPressed(1, 51) then
											TriggerServerEvent("Police.Cuff", TargetServerId)
											Citizen.Wait(200)
											TaskPlayAnim(Player.Ped, Animations.Arresting.Dictionary, Animations.Arresting.Cop, 8.0, -8.0, -1, 16, 0, 0, 0, 0)
										end
									else
										DisplayHelpText(TargetCuffType and "Press ~INPUT_CONTEXT~ to uncuff "..exports.core:GetCharacterName(TargetServerId).."\nPress ~INPUT_INTERACTION_MENU~ to loosen" or "Press ~INPUT_CONTEXT~ to uncuff "..exports.core:GetCharacterName(TargetServerId).."\nPress ~INPUT_INTERACTION_MENU~ to tighten")
										if IsControlJustPressed(1, 51) then
											TaskPlayAnim(Player.Ped, Animations.Handcuffs.Dictionary, Animations.Handcuffs.Uncuff, 8.0, -8.0, -1, 16, 0, 0, 0, 0)
											TriggerServerEvent("Police.Uncuff", TargetServerId, true)
											Citizen.Wait(5000)
											TriggerServerEvent("Police.Uncuff", TargetServerId)
										end
										if IsControlJustPressed(1, 244) then 
											TriggerServerEvent("Police.Cuff", TargetServerId)
										end
									end
								end
							else
								if GetSelectedPedWeapon(Player.Ped) == GetHashKey("WEAPON_KNIFE") and TargetCuffed and not TargetCuffType and not TargetDead then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to uncuff "..exports.core:GetCharacterName(TargetServerId))
									if IsControlJustPressed(1, 51) then
										TaskPlayAnim(Player.Ped, Animations.Handcuffs.Dictionary, Animations.Handcuffs.Uncuff, 8.0, -8.0, -1, 16, 0, 0, 0, 0)
										TriggerServerEvent("Police.Uncuff", TargetServerId, true)
										Citizen.Wait(5000)
										if not Player.Cuffs.Active and not Player.Dead then
											TriggerServerEvent("Police.Uncuff", TargetServerId)
										else
											TriggerServerEvent("Police.Uncuff", TargetServerId, false)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("Police.Cuff")
AddEventHandler("Police.Cuff", function()
	if Player.Cuffs.Active then
		Player.Cuffs.Type = not Player.Cuffs.Type
		SetDecorator(Player.Ped, "_Player_Cuffed_Type", Player.Cuffs.Type)
		Notify(CuffType and "Your restraints have been tightened to the point where you are unable to move!" or "Your restraints have been loosened!", 2500)
	else
		if not Player.Dead then 
			TaskPlayAnim(Player.Ped, Animations.Arresting.Dictionary, Animations.Arresting.Criminal, 8.0, -8.0, -1, 16, 0, 0, 0, 0)
			Citizen.Wait(850)
		end
		Player.Cuffs.Active, Player.Cuffs.Type = true, false
		Player.Cuffs.Component = {Drawable = GetPedDrawableVariation(Player.Ped, 7), Texture = GetPedTextureVariation(Player.Ped, 7), Palette = GetPedPaletteVariation(Player.Ped, 7)}
		SetDecorator(Player.Ped, "_Player_Cuffed", Player.Cuffs.Active)
		SetDecorator(Player.Ped, "_Player_Cuffed_Type", Player.Cuffs.Type)
		SetEnableHandcuffs(Player.Ped, Player.Cuffs.Active)
		SetCurrentPedWeapon(Player.Ped, GetHashKey("WEAPON_UNARMED"), true)
		SetPedComponentVariation(Player.Ped, 7, 41, 0, 0)
		Notify("You have been restrained!", 2500)
	end
end)

RegisterNetEvent("Police.Uncuff")
AddEventHandler("Police.Uncuff", function(Start)
	if Start then
		FreezeEntityPosition(Player.Ped, true)
	elseif Start == false then
		FreezeEntityPosition(Player.Ped, false)
	else
		FreezeEntityPosition(Player.Ped, false)
		if Player.Cuffs.Active then Notify("Your restraints have been removed!", 2500) end
		Player.Cuffs.Active, Player.Cuffs.Type = false, false
		SetEnableHandcuffs(Player.Ped, Player.Cuffs.Active)
		SetPedComponentVariation(Player.Ped, 7, Player.Cuffs.Component.Drawable, Player.Cuffs.Component.Texture, Player.Cuffs.Component.Palette)
		SetDecorator(Player.Ped, "_Player_Cuffed", Player.Cuffs.Active)
		SetDecorator(Player.Ped, "_Player_Cuffed_Type", Player.Cuffs.Type)
		ClearPedTasks(Player.Ped)
	end
end)
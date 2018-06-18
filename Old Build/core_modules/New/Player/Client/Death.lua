local Death = {
	Timer = 0,
	UI = {
		Rectangle = {
			Border = {
				Top = UI.Rectangle.New(810, 995, 288, 5, 93, 182, 229, 255),
				Bottom = UI.Rectangle.New(810, 1064, 288, 5, 93, 182, 229, 255),
			},
			Divider = UI.Rectangle.New(863, 1004, 1, 56, 93, 182, 229, 255),
			Main = UI.Rectangle.New(810, 1000, 288, 64, 0, 0, 0, 255),
		},
		Text = {
			Timer = UI.Text.New("", 815, 1015.5, 0.35, 114, 204, 114, 255, 0, nil, false, false, nil),
			Warning = UI.Text.New("Heavly Wounded!", 980, 1015.5, 0.35, 224, 50, 50, 255, 0, "Centre", false, false, nil),
			Respawn = UI.Text.New("Use phone to respawn!", 980, 1032, 0.35,  240, 200, 80, 255, 0, "Centre", false, false, nil),
		},
	},
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if Death.Timer > 0 then
			Death.Timer = Death.Timer - 1
			Death.UI.Text.Timer:Label(((string.len(tostring(Death.Timer)) == 1) and "  " or ((string.len(tostring(Death.Timer)) == 2) and " " or ""))..Death.Timer)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Player.Ready then
			if DoesEntityExist(Player.Ped) and IsEntityDead(Player.Ped) then
				Player.Dead = true
				SetPlayerInvincible(Player.Id, true)
				SetDecorator(Player.Ped, "_Player_Down", Player.Dead)
				SetEntityHealth(Player.Ped, GetPedMaxHealth(Player.Ped))
				NetworkResurrectLocalPlayer(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, true, true, false)
				Death.Timer = 300
				while Player.Dead do
					SetPedToRagdoll(Player.Ped, 3000, 3000, 0, 0, 0, 0)
					Citizen.Wait(0)
					ScreenDrawPositionBegin(76, 84)
					ScreenDrawPositionRatio(0, 0, 0, 0)
					Death.UI.Rectangle.Border.Top:Draw()
					Death.UI.Rectangle.Main:Draw()
					Death.UI.Rectangle.Border.Bottom:Draw()
					Death.UI.Rectangle.Divider:Draw()
					Death.UI.Text.Timer:Draw()
					if (CopsOnDuty == 0 and ParamedicsOnDuty == 0) or Death.Timer == 0 then
						Death.UI.Text.Warning:Position(980, 1003)
						Death.UI.Text.Warning:Draw()
						Death.UI.Text.Respawn:Draw()
					else
						Death.UI.Text.Warning:Position(980, 1015.5)
						Death.UI.Text.Warning:Draw()
					end
					ScreenDrawPositionEnd()
				end
			end
		end
	end
end)

AddEventHandler("playerSpawned", function()
	exports.spawnmanager:setAutoSpawn(false)
end)

AddEventHandler("Player.Respawn.Check", function()
	if (CopsOnDuty == 0 and ParamedicsOnDuty == 0) or Death.Timer == 0 then
		if ParamedicsOnDuty == 0 then
			TriggerServerEvent("Death.Respawn.Normal")
		else
			TriggerServerEvent("Death.Respawn.Remove")
		end
	end
end)

RegisterNetEvent("Player.Respawn")
AddEventHandler("Player.Respawn", function()
	Death.Timer = 0
	Player.Dead = false
	SetEntityInvincible(Player.Ped, false)
	ClearPedBloodDamage(Player.Ped)
	SetDecorator(Player.Ped, "_Player_Down", Player.Dead)

	--Restore hunger	
	--Uncuff people
end)
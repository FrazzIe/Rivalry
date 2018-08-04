local Residue = {
	Time = 15,
	Fragments = {},
}

Citizen.CreateThread(function()
	while true do
		if Player.Ready then
			local _, SelectedWeapon = GetCurrentPedWeapon(Player.Ped, 1)
			local WeaponString = Config.Weapons.ToString[SelectedWeapon]
			
			if Config.Weapons.ToString[SelectedWeapon] then
				if IsPedShooting(Player.Ped) then
					if GetAmmoInPedWeapon(Player.Ped, SelectedWeapon) > 0 then
						Player.Residue.Active = true
						Player.Residue.Timer = GetGameTimer()
						Residue.Fragments[Config.Weapons.ToAmmo[WeaponString]] = (Residue.Fragments[Config.Weapons.ToAmmo[WeaponString]] or 0) + 1
						SetDecorator(Player.Ped, "_Player_Residue", Player.Residue.Active)
					end
				end
			end
			if Player.Residue.Active and (Player.Residue.Timer + (Residue.Time * 1000 * 60)) > GetGameTimer() then
				Player.Residue.Active = false
				Residue.Fragments = {}
				SetDecorator(Player.Ped, "_Player_Residue", Player.Residue.Active)
			end
		end
	end
end)

AddEventHandler("Residue.Check", function()
	local NearestPlayer, NearestPed, NearestPosition = Utilities.GetNearestPlayerAtCoords(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, 3, false, true)
	
	if DoesEntityExist(NearestPed) then
		Notify(GetDecorator(NearestPed, "_Player_Residue") and "Subject tested <b style='color:red'>Positive</b><br>You found residue on the individual!" or "Subject tested <b style='color:lime'>Negative</b><br>There wasn't any residue on the individual!", 3000)
	else
		Notify("Please get closer to the target!", 3000)
	end
end)
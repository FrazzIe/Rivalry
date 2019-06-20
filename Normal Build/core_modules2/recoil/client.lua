local Recoil = {

	-- PISTOLS 
	
	[453432689] = 0.5, -- PISTOL
	[3219281620] = 0.4, -- PISTOL MK2
	[1593441988] = 0.4, -- COMBAT PISTOL
	[2578377531] = 0.7, -- PISTOL .50
	[3218215474] = 0.2, -- SNS PISTOL
	[137902532] = 0.5, -- VINTAGE PISTOL
	[911657153] = 0.01, -- STUN GUN		
	[584646201] = 5.7, -- AP PISTOL

	
	-- SMGS
	
	[324215364] = 0.5, -- MICRO SMG
	[3173288789] = 0.3, -- MINI SMG		
	[736523883] = 0.1, -- SMG
	[2024373456] = 0.1, -- SMG MK2
	[2634544996] = 0.1, -- MG
	[2144741730] = 0.1, -- COMBAT MG
	[3686625920] = 0.1, -- COMBAT MG MK2
	[171789620] = 0.2, -- COMBAT PDW
	[4024951519] = 0.1, -- ASSAULT SMG
	[1627465347] = 0.5, -- GUSENBERG
	[3675956304] = 0.3, -- MACHINE PISTOL
	
	-- RIFLES

	
	[3220176749] = 0.2, -- ASSAULT RIFLE
	[961495388] = 0.2, -- ASSAULT RIFLE MK2
	[1649403952] = 0.3, -- COMPACT RIFLE
	[2210333304] = 0.2, -- CARBINE RIFLE
	[4208062921] = 0.1, -- CARBINE RIFLE MK2
	[2937143193] = 0.1, -- ADVANCED RIFLE
	[2132975508] = 0.2, -- BULLPUP RIFLE
	[-2066285827] = 0.15, -- BULLPUP RIFLE MK2

	[3231910285] = 0.2, -- SPECIAL CARBINE
	[-1768145561] = 0.15, -- SPECIAL CARBINE MK2
	
	-- SHOTGUNS
	
	[487013001] = 0.4, -- PUMP SHOTGUN
	[1432025498] = 0.35, -- PUMP SHOTGUN MK2
	[2017895192] = 0.7, -- SAWNOFF SHOTGUN
	[3800352039] = 0.4, -- ASSAULT SHOTGUN
	[2640438543] = 0.2, -- BULLPUP SHOTGUN
	[2828843422] = 0.7, -- MUSKET
	[984333226] = 0.2, -- HEAVY SHOTGUN
	[4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
	[317205821] = 0.2, -- AUTO SHOTGUN
	
	-- THROWABLES
	
	[1198879012] = 0.9, -- FLARE GUN
	
	-- MELEE
	
	-- MISC/UNUSED

	[3523564046] = 0.5, -- HEAVY PISTOL
	[3249783761] = 0.6, -- REVOLVER
	[-879347409] = 0.6, -- REVOLVER MK2
	[3696079510] = 0.9, -- MARKSMAN PISTOL
	[3342088282] = 0.3, -- MARKSMAN RIFLE
	[1785463520] = 0.25, -- MARKSMAN RIFLE MK2
	[100416529] = 0.5, -- SNIPER RIFLE
	[205991906] = 0.7, -- HEAVY SNIPER
	[177293209] = 0.6, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.01, -- MINIGUN
	[1672152130] = 0, -- HOMING LAUNCHER
	[1834241177] = 2.4, -- RAILGUN
	[125959754] = 0.5, -- COMPACT LAUNCHER

}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local PlayerPed = PlayerPedId()

		if IsPedShooting(PlayerPed) and not IsPedDoingDriveby(PlayerPed) then
			local HasWeapon, CurrentWeapon = GetCurrentPedWeapon(PlayerPed, 1)
			if HasWeapon then
				if GetAmmoInPedWeapon(PlayerPed, CurrentWeapon) > 0 then
					local HasAmmo, CurrentAmmo = GetAmmoInClip(PlayerPed, CurrentWeapon)
					if CurrentAmmo > 0 then
						if Recoil[CurrentWeapon] then
							if Recoil[CurrentWeapon] ~= 0 then
								local CurrentAngle = 0
								if GetFollowPedCamViewMode() ~= 4 then
									repeat
										Citizen.Wait(0)

										SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + 0.1, 0.2)
										CurrentAngle = CurrentAngle + 0.1

									until CurrentAngle >= Recoil[CurrentWeapon]
								else
									repeat
										Citizen.Wait(0)

										if Recoil[CurrentWeapon] > 0.25 then
											SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + 0.25, 0.5)
											CurrentAngle = CurrentAngle + 0.6
										else
											SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + 0.016, 0.18)
											CurrentAngle = CurrentAngle + 0.1
										end

									until CurrentAngle >= Recoil[CurrentWeapon]
								end
							end
						end
					end
				end
			end
		end
	end
end)
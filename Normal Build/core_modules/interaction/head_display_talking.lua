--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
local showPlayerBlips = false
local ignorePlayerNameDistance = false
local PlayerNameDistance = 30
local playerSource = 0
local function DrawText3D(x, y, z, text, r, g, b, a) -- some useful function, use it if you want!
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

	local scale = (1/dist)*2
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov

	if onScreen then
		SetTextScale(0.0*scale, 0.8*scale)
		SetTextFont(6)
		SetTextProportional(1)
		-- SetTextScale(0.0, 0.55)
		SetTextColour(r, g, b, a)
		SetTextDropshadow(0, 0, 0, 0, 55)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

function GetPedVehicleSeat(ped)
	local vehicle = GetVehiclePedIsIn(ped, false)
	local invehicle = IsPedInAnyVehicle(ped, false)
	if invehicle then 
		for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
			if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
		end
	end
	return -2
end

-- IsPedInMeleeCombat

-- IsPedShooting

-- IsPedDucking(GetPlayerPed( id ))

-- IsPedWeaponReadyToShoot(GetPlayerPed( id ))
--

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local PlayerPed = PlayerPedId()

		if not hud_off then
			if WarMenu.IsMenuOpened("Scoreboard") or WarMenu.IsMenuOpened("player_info") or WarMenu.IsMenuOpened("player_info_disconnected") or WarMenu.IsMenuOpened("disconnected") then
				for PlayerIndex = 0, 255 do
					RemoveMpGamerTag(PlayerIndex)
				end

				local PlayerPosition = GetEntityCoords(PlayerPed, false)

				for PlayerIndex = 0, 255 do
					if NetworkIsPlayerActive(PlayerIndex) and GetPlayerPed(PlayerIndex) ~= PlayerPed then
						local OtherPed = GetPlayerPed(PlayerIndex)
						local OtherPlayerPosition = GetEntityCoords(OtherPed, false)
						local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, OtherPlayerPosition.x, OtherPlayerPosition.y, OtherPlayerPosition.z, true)

						local isDucking = IsPedDucking(OtherPed)
						local cansee = HasEntityClearLosToEntity(PlayerPed, OtherPed, 17)
						local seatnumber = GetPedVehicleSeat(OtherPed)
						local isReadyToShoot = IsPedWeaponReadyToShoot(OtherPed)
						local isStealth = GetPedStealthMovement(OtherPed)
						local isDriveBy = IsPedDoingDriveby(OtherPed)
						local isInCover = IsPedInCover(OtherPed, true)

						if isStealth == nil then
							isStealth = 0
						end

						if isDucking or isStealth == 1 or isDriveBy or isInCover then
							cansee = false
						end

						if seatnumber ~= -2 then
							seatnumber = seatnumber + 0.25
						end

						seatnumber = tonumber(seatnumber)

						if Distance < PlayerNameDistance then
							local ServerId = GetPlayerServerId(PlayerIndex)
							if NetworkIsPlayerTalking(PlayerIndex) then
								if cansee then
									 if seatnumber == -2 then
										DrawText3D(OtherPlayerPosition.x, OtherPlayerPosition.y, OtherPlayerPosition.z+1.2, ServerId, 255, 0, 0, 255)
									else
										DrawText3D(OtherPlayerPosition.x, (OtherPlayerPosition.y+seatnumber), OtherPlayerPosition.z+1.2, ServerId, 255, 0, 0, 255)
									end
								end
							else
								if cansee then
									if seatnumber == -2 then
										DrawText3D(OtherPlayerPosition.x, OtherPlayerPosition.y, OtherPlayerPosition.z+1.2, ServerId, 255, 255, 255, 255)
									else
										DrawText3D(OtherPlayerPosition.x, (OtherPlayerPosition.y+seatnumber), OtherPlayerPosition.z+1.2, ServerId, 255, 255, 255, 255)
									end
								end
							end
						end

					end
				end
			end
		end

		if not IsAimCamActive() or not IsFirstPersonAimCamActive() then
			HideHudComponentThisFrame(14)
		end

		if IsHudComponentActive(1) then 
			HideHudComponentThisFrame(1)
		end

		if IsHudComponentActive(6) then 
			HideHudComponentThisFrame(6)
		end

		if IsHudComponentActive(7) then 
			HideHudComponentThisFrame(7)
		end

		if IsHudComponentActive(9) then 
			HideHudComponentThisFrame(9)
		end

		if IsHudComponentActive(0) and not IsPedInAnyVehicle(PlayerPed, true) then 
			HideHudComponentThisFrame(0)
		end
	end
end)


--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--Make police cars undrivable for civs
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not isCop then
			if IsPedSittingInAnyVehicle(PlayerPedId()) then
				local vehicle = GetVehiclePedIsUsing(PlayerPedId(), false)
				if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
					for k,v in pairs(cars) do
						if GetHashKey(v.model) == GetEntityModel(vehicle) then
							drawText("~r~It's against the rules for civilians to drive these vehicles!", 6, 0.45 , 0.5, 0.5, 255, 255, 255, 255, false, true)
							SetVehicleUndriveable(vehicle, true)
						end
					end
				end
			end
		end
	end
end)
--==============================================================================================================================--
--Forensics System
local tFingerprints = {}
local eLocations = {}
local count = 0 

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
        if(IsPedInAnyVehicle(PlayerPedId()))then
            local vehicle = GetVehiclePedIsUsing(PlayerPedId(), false)
            tFingerprint = {
                veh = GetVehicleNumberPlateText(vehicle),
                player = exports.core:GetCharacterName(GetPlayerServerId(PlayerId())),
            }
            if (GetPedDrawableVariation(PlayerPedId(), 3) < 16) then
              	table.insert(tFingerprints, tFingerprint)
            end

            for k, v in ipairs(tFingerprints) do
                for a, b in ipairs(tFingerprint) do
                    if(v.veh == b.veh and v.player == b.player) then
                        count = 1
                    end
                    if(count > 1)then 
                        table.remove(tFingerprints, tFingerprint)
                    end
                end
            end
            TriggerServerEvent("police:saveprint", tFingerprints)
        end
    end
end)


--[[RegisterNetEvent('markerForCops')
AddEventHandler('markerForCops', function()
	if isCop then
	    for k, v in ipairs(eLocations) do
	       DrawMarker( 1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 0.5001, 1555, 0, 0, 165, 0, 0, 0, 0 )
	    end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
                local evidencePos = {0,0,0}
                local ped = GetPlayerPed(-1) 
                local pedShooting = IsPedShooting(ped) 
                local evidence = nil
                if pedShooting and not isCop then
              		TriggerServerEvent('playerShot', ped)
                    maxdistance = 50
                    needDistance = nil
                    evidence = GetEntityCoords(ped, true)
                    if(#eLocations == 0 )then
                        needDistance =  51
                    else
                        needDistance = Vdist(evidence.x, evidence.y, evidence.z, px, py, pz)
                    end
                    if needDistance > maxdistance then
                      typeGun = GetSelectedPedWeapon(ped)
                      local t = {
                       x = evidence.x,
                       y = evidence.y,
                       z = evidence.z,
                       gunused = typeGun
                      }
                      table.insert(eLocations, t)
                    end
                    px = evidence.x
                    py = evidence.y
                    pz = evidence.z
                end

        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k, v in pairs(eLocations) do
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x , v.y , v.z)
           if dist <= 1.2 then
              DrawNotification("Press E to investigate")
                if IsControlJustPressed(1,51) and isPlayerCop() == true then
                    fireArm = typeGunUsed(v.gunused)
                	TriggerServerEvent('removeMarker', GetPlayerPed(-1))
                    table.remove(eLocations, k)
                    local roll = math.random(100)
                    if roll <= 50 then
                    	exports.pNotify:SendNotification({text = "^2FORENSICS: ^7The bullet seems to have noticeable markings. Seems the bullet came from a "..fireArm,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
                    else
                    	exports.pNotify:SendNotification({text = "^2FORENSICS: ^7The bullet doesn't have any clues.",type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
                    end
                end
            end
        end
      end
end)--]]

--==============================================================================================================================--
--Cuffing
cuff_type = nil
cuffed = false
DecorRegister("policeCuffed", 2)
DecorSetBool(PlayerPedId(), "policeCuffed", false) 
DecorRegister("Cuffedtype", 2)
DecorSetBool(PlayerPedId(), "Cuffedtype", false) 

RegisterNetEvent("police:cuff")
AddEventHandler("police:cuff", function(_type)
	if cuffed and _type == cuff_type then
		cuffed = not cuffed
		cuff_type = nil
		Notify("Your restraints have been removed!", 2500)
		SetPedCanRagdoll(PlayerPedId(), true)
		ClearPedSecondaryTask(PlayerPedId())
		SetEnableHandcuffs(PlayerPedId(), false)
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
		SetPedComponentVariation(PlayerPedId(), 7, 0, 0 ,0)
		DecorSetBool(PlayerPedId(), "policeCuffed", false) 
		DecorSetBool(PlayerPedId(), "Cuffedtype", false)
	elseif cuffed and _type ~= cuff_type then
		cuff_type = _type
		if _type == "freeze" then
			DecorSetBool(PlayerPedId(), "Cuffedtype", true) 
			Notify("Your restraints have been tightened to the point where you are unable to move!", 2500)
		else
			Notify("Your restraints have been loosened!", 2500)
			DecorSetBool(PlayerPedId(), "Cuffedtype", false)
		end
	elseif not cuffed then
		SetPedCanRagdoll(PlayerPedId(), false)
		if exports.core_modules:isCuffed() then
			TriggerServerEvent("handcuffs:uncuff", GetPlayerServerId(PlayerId()))
		end
		cuff_type = _type
		Notify("You have been restrained!", 2500)
		ClearPedTasks(PlayerPedId())
		RequestAnimDict("mp_arresting")
		while not HasAnimDictLoaded("mp_arresting") do
			Citizen.Wait(100)
		end

		TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
		SetPedCanRagdoll(PlayerPedId(), true)
		SetEnableHandcuffs(PlayerPedId(), true)
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
		SetPedComponentVariation(PlayerPedId(), 7, 41, 0 ,0)
		DecorSetBool(PlayerPedId(), "policeCuffed", true)
		if _type == "freeze" then
			DecorSetBool(PlayerPedId(), "Cuffedtype", true) 
		else
			DecorSetBool(PlayerPedId(), "Cuffedtype", false)
		end
		cuffed = not cuffed
	end
end)

RegisterNetEvent("police:uncuff")
AddEventHandler("police:uncuff", function()
	cuffed = false
	cuff_type = nil
	ClearPedSecondaryTask(PlayerPedId())
	SetEnableHandcuffs(PlayerPedId(), false)
	SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
	SetPedComponentVariation(PlayerPedId(), 7, 0, 0 ,0)
	DecorSetBool(PlayerPedId(), "policeCuffed", false)
	DecorSetBool(PlayerPedId(), "Cuffedtype", false)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if cuffed then
			if IsPedRunningRagdollTask(PlayerPedId()) then
				while IsPedRunningRagdollTask(PlayerPedId()) do
					Citizen.Wait(0)
				end
				ClearPedTasksImmediately(PlayerPedId())
			end
			if cuff_type == "freeze" then
				TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 16, 0, 0, 0, 0)
			end

			if not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) and cuff_type == "normal" then
				Citizen.Wait(100)
				TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if cuffed then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 25, true)
			SetPedPathCanUseLadders(PlayerPedId(), false)
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				DisableControlAction(0, 59, true)
			end
		end
	end
end)


Citizen.CreateThread(function()
	RequestAnimDict("weapons@first_person@aim_idle@p_m_zero@melee@knife@fidgets@b")
	while not HasAnimDictLoaded("weapons@first_person@aim_idle@p_m_zero@melee@knife@fidgets@b") do
		Citizen.Wait(0)
	end
	while true do
		Citizen.Wait(0)
		if not isInService then
			local pos = GetEntityCoords(PlayerPedId(), false)
			for i = 0, 32 do
				if NetworkIsPlayerActive(i) then
					if PlayerId() ~= i then
						local pos2 = GetEntityCoords(GetPlayerPed(i), false)
						if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z, true) < 1.0 then
							local isUserCuffed = DecorGetBool(GetPlayerPed(i), "policeCuffed")
							if isUserCuffed then
								if GetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_KNIFE"), true) then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to uncuff "..exports.core:GetCharacterName(GetPlayerServerId(i)))
									if IsControlJustPressed(1, 51) then
										local uncuffing = GetGameTimer() + 7500
										while uncuffing > GetGameTimer() do
											Citizen.Wait(0)
											if not IsEntityPlayingAnim(PlayerPedId(), "weapons@first_person@aim_idle@p_m_zero@melee@knife@fidgets@b", "fidget_low_loop", 3) then
												TaskPlayAnim(PlayerPedId(), "weapons@first_person@aim_idle@p_m_zero@melee@knife@fidgets@b", "fidget_low_loop", 8.0, -4.0, -1, 9, 0, false, false, false)
											end
										end
										ClearPedTasks(PlayerPedId())
										if not IsEntityDead(PlayerPedId()) and not cuffed then 
											TriggerServerEvent("police:uncuff", GetPlayerServerId(i))
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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isCop then
			if isInService then
				local pos = GetEntityCoords(PlayerPedId(), false)
				for i = 0, 32 do
					if NetworkIsPlayerActive(i) then
						if PlayerId() ~= i then
							local pos2 = GetEntityCoords(GetPlayerPed(i), false)
							if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z, true) < 1.0 then
								if IsPlayerFreeAiming(PlayerId()) then
									local ped = GetPlayerPed(i)
									local isUserCuffed, cuffType = DecorGetBool(ped, "policeCuffed"), DecorGetBool(GetPlayerPed(i), "Cuffedtype")
									if not isUserCuffed then
										DisplayHelpText("Press ~INPUT_CONTEXT~ to cuff "..exports.core:GetCharacterName(GetPlayerServerId(i)))
										if IsControlJustPressed(1, 51) then
											TriggerServerEvent("police:cuff", GetPlayerServerId(i), "normal")
										end
									else
										if cuffType then
											DisplayHelpText("Press ~INPUT_CONTEXT~ to uncuff "..exports.core:GetCharacterName(GetPlayerServerId(i)).."\nPress ~INPUT_INTERACTION_MENU~ to loosen")
										else
											DisplayHelpText("Press ~INPUT_CONTEXT~ to uncuff "..exports.core:GetCharacterName(GetPlayerServerId(i)).."\nPress ~INPUT_INTERACTION_MENU~ to tighten")
										end
										if IsControlJustPressed(1, 51) then
											TriggerServerEvent("police:uncuff", GetPlayerServerId(i))
										end
										if IsControlJustPressed(1, 244) then
											if cuffType then
												TriggerServerEvent("police:cuff", GetPlayerServerId(i), "normal")
											else
												TriggerServerEvent("police:cuff", GetPlayerServerId(i), "freeze")
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
	end
end)

--==============================================================================================================================--
--Dragging
drag = false
draggedBy = -1
wasDragged = false

RegisterNetEvent('police:drag')
AddEventHandler('police:drag', function(_source)
	if cuffed then
		drag = not drag
		draggedBy = _source
	end
end)

AddEventHandler('police:undrag', function()
	drag = false
	draggedBy = -1
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if drag then
			wasDragged = true
			AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(draggedBy)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
			if not IsPedInParachuteFreeFall(PlayerPedId()) and wasDragged then
				wasDragged = false
				DetachEntity(PlayerPedId(), true, false)    
			end
		end
	end
end)
--==============================================================================================================================--
--Forced entry of a vehicle
RegisterNetEvent('police:force')
AddEventHandler('police:force', function(_type)
	local pos = GetEntityCoords(PlayerPedId(), false)
	if cuffed then
		if _type == "in" then
			local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

			local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
			local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

			if vehicleHandle ~= nil then
				local total_seats, used_seats = GetVehicleMaxNumberOfPassengers(vehicleHandle), GetVehicleNumberOfPassengers(vehicleHandle)
				if total_seats ~= used_seats then
					for i = -1, total_seats do
						if IsVehicleSeatFree(vehicleHandle, i) and i ~= -1 and i ~= 0 then
							SetPedIntoVehicle(PlayerPedId(), vehicleHandle, i)
							break
						end
					end
				end
			end
		elseif _type == "out" then
			if IsPedSittingInAnyVehicle(PlayerPedId()) then
				SetEntityCoords(PlayerPedId(), pos.x + 2.0, pos.y + 2.0, pos.z)
			end
		end
	end
end)
--==============================================================================================================================--
--Fines
local lockAskingFine = false
RegisterNetEvent('police:payFines')
AddEventHandler('police:payFines', function(amount, sender)
	Citizen.CreateThread(function()
		
		if(lockAskingFine ~= true) then
			lockAskingFine = true
			local notifReceivedAt = GetGameTimer()
			local msg = "Press <span style='color:lime'>Y</span> to accept the fine of <span style='color:lime'>$</span>".. amount ..", press <span style='color:red'>L</span>  to reject it!"
			exports.pNotify:SendNotification({text = msg,type = "error",timeout = 30000,layout = "centerRight",queue = "left"})
			while(true) do
				Wait(0)
				
				if (GetTimeDifference(GetGameTimer(), notifReceivedAt) > 30000) then
					TriggerServerEvent('police:finesETA', sender, 2)
					exports.pNotify:SendNotification({text = "The application for the fine has expired.",type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
					lockAskingFine = false
					break
				end
				
				if IsControlPressed(1, 246) then
					TriggerServerEvent('bank:withdrawAmende', amount)

					local msg = "You paid the fine of $ ".. amount .."."
					exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
					TriggerServerEvent('police:finesETA', sender, 0)
					lockAskingFine = false
					break
				end
				
				if IsControlPressed(1, 7) then
					local msg = "You refused to pay the fine."
					exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
					TriggerServerEvent('police:finesETA', sender, 3)
					lockAskingFine = false
					break
				end
			end
		else
			TriggerServerEvent('police:finesETA', sender, 1)
		end
	end)
end)

--==============================================================================================================================--
--Radar
Citizen.CreateThread(function()
	local radar_locked = false
	local front_info, rear_info, left_info, right_info = {name = "None", plate = "None", speed = 0}, {name = "None", plate = "None", speed = 0}, {name = "None", plate = "None", speed = 0}, {name = "None", plate = "None", speed = 0}
	while true do
		Citizen.Wait(0)
		if isInService then
			if IsControlJustPressed(1, 243) then
				radar_locked = not radar_locked
			end
			local front = getVehicleInDirection(GetEntityCoords(PlayerPedId(), false), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 15.0, 1.0))
			local rear = getVehicleInDirection(GetEntityCoords(PlayerPedId(), false), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -15.0, 1.0))
			local left = getVehicleInDirection(GetEntityCoords(PlayerPedId(), false), GetOffsetFromEntityInWorldCoords(PlayerPedId(), -15.0, 0.0, 1.0))
			local right = getVehicleInDirection(GetEntityCoords(PlayerPedId(), false), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 15.0, 0.0, 1.0))
			if not radar_locked then
				if front ~= nil then
					front_info.name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(front)))
					front_info.plate = GetVehicleNumberPlateText(front)
					front_info.speed = GetEntitySpeed(front)*2.236936
				end
				if rear ~= nil then
					rear_info.name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(rear)))
					rear_info.plate = GetVehicleNumberPlateText(rear)
					rear_info.speed = GetEntitySpeed(rear)*2.236936
				end
				if left ~= nil then
					left_info.name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(left)))
					left_info.plate = GetVehicleNumberPlateText(left)
					left_info.speed = GetEntitySpeed(left)*2.236936
				end
				if right ~= nil then
					right_info.name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(right)))
					right_info.plate = GetVehicleNumberPlateText(right)
					right_info.speed = GetEntitySpeed(right)*2.236936
				end
			end
			drawText("~o~Front ~w~| ~b~"..front_info.name.." ~w~| ~y~"..front_info.plate.." ~w~| ~g~"..math.floor(front_info.speed).."~c~mph", 6, 0.805, 0.895, 0.45, 255, 255, 255, 255, false, true)
			drawText("~o~Left ~w~| ~b~"..left_info.name.." ~w~| ~y~"..left_info.plate.." ~w~| ~g~"..math.floor(left_info.speed).."~c~mph", 6, 0.805, 0.92, 0.45, 255, 255, 255, 255, false, true)
			drawText("~o~Right ~w~| ~b~"..right_info.name.." ~w~| ~y~"..right_info.plate.." ~w~| ~g~"..math.floor(right_info.speed).."~c~mph", 6, 0.805, 0.945, 0.45, 255, 255, 255, 255, false, true)
			drawText("~o~Rear ~w~| ~b~"..rear_info.name.." ~w~| ~y~"..rear_info.plate.." ~w~| ~g~"..math.floor(rear_info.speed).."~c~mph", 6, 0.805, 0.97, 0.45, 255, 255, 255, 255, false, true)
		end
	end
end)
--==============================================================================================================================--
--Spike strips
local Spikes = {
	Model = "p_stinger_04",
	Spawned = false,
	Tyres = {
		[1] = {Bone = "wheel_lf", Index = 0},
		[2] = {Bone = "wheel_rf", Index = 1},
		[3] = {Bone = "wheel_lm", Index = 2},
		[4] = {Bone = "wheel_rm", Index = 3},
		[5] = {Bone = "wheel_lr", Index = 4},
		[6] = {Bone = "wheel_rr", Index = 5},
	},
	Handles = {},
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Spikes.Spawned then
			for Index = 0, 32 do
				if NetworkIsPlayerActive(Index) then
					local TargetPed = GetPlayerPed(Index)
					if DoesEntityExist(TargetPed) then
						local Vehicle = GetVehiclePedIsUsing(TargetPed)
						if DoesEntityExist(Vehicle) then
							local VehiclePosition = GetEntityCoords(Vehicle, false)
							local Spikestrip = GetClosestObjectOfType(VehiclePosition.x, VehiclePosition.y, VehiclePosition.z, 30.0, GetHashKey(Spikes.Model), false, 1, 1)
							if DoesEntityExist(Spikestrip) then
								local SpikestripPosition = GetEntityCoords(Spikestrip, false)
								local Distance = Vdist(VehiclePosition.x, VehiclePosition.y, VehiclePosition.z, SpikestripPosition.x, SpikestripPosition.y, SpikestripPosition.z)
								if Distance < 15 then
									for Wheel = 1, #Spikes.Tyres do
										local TyrePosition = GetWorldPositionOfEntityBone(Vehicle, GetEntityBoneIndexByName(Vehicle, Spikes.Tyres[Wheel].Bone))
										Distance = Vdist(TyrePosition.x, TyrePosition.y, TyrePosition.z, SpikestripPosition.x, SpikestripPosition.y, SpikestripPosition.z)
										if Distance < 1.8 then
											if not IsVehicleTyreBurst(Vehicle, Spikes.Tyres[Wheel].Index, true) or IsVehicleTyreBurst(Vehicle, Spikes.Tyres[Wheel].Index, false) then
												SetVehicleTyreBurst(Vehicle, Spikes.Tyres[Wheel].Index, false, 1000.0)
												TriggerServerEvent("Spikes.Burst", GetPlayerServerId(Index), Spikes.Tyres[Wheel].Index)
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
	end
end)

RegisterNetEvent("Spikes.Burst")
AddEventHandler("Spikes.Burst", function(Tyre)
	SetVehicleTyreBurst(GetVehiclePedIsUsing(PlayerPedId()), Tyre, false, 1000.0)
end)

RegisterNetEvent("Spikes.Create")
AddEventHandler("Spikes.Create", function(Amount)
	if not Spikes.Spawned then
		if isInService then
			if not Spikes.Spawning then
				Spikes.Spawning = true
				local Model = GetHashKey(Spikes.Model)

				RequestModel(Model)
				while not HasModelLoaded(Model) do
					Citizen.Wait(250)
				end

				for Index = 1, 3 do
					local SpikePlacement = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0 * Index + 0.5, 0.0)
					local Spike = CreateObject(Model, SpikePlacement.x, SpikePlacement.y, SpikePlacement.z, true, false, false)
					local SpikeHeight = GetEntityHeightAboveGround(Spike)
					SetEntityCoords(Spike, SpikePlacement.x, SpikePlacement.y, SpikePlacement.z - SpikeHeight + 0.05, 0.0, 0.0, 0.0, 0.0)
					SetEntityHeading(Spike, GetEntityHeading(PlayerPedId()))
					SetEntityCollision(Spike, false, false)
					table.insert(Spikes.Handles, Spike)
				end

				SetModelAsNoLongerNeeded(Model)
				
				Spikes.Spawned = true
				Spikes.Spawning = false
			end
		end
	else
		if not Spikes.Deleting then
			Spikes.Deleting = true
			for Index = 1, #Spikes.Handles do
				DestroyObject(Spikes.Handles[Index])
			end
			Spikes.Handles = {}
			Spikes.Spawned = false
			Spikes.Deleting = false
		end
	end
end)
--==============================================================================================================================--
--Portable speed camera
local PortableRadar = {
	Model = "prop_cctv_pole_01a",
	Spawned = false,
	Blip = nil,
	Handle = nil,
	Position = {},
	Animation = {
		Dictionary = "anim@apt_trans@garage", 
		Place = "gar_open_1_left",
	},
	Limit = nil,
}

Citizen.CreateThread(function()
	RequestAnimDict(PortableRadar.Animation.Dictionary)
	while not HasAnimDictLoaded(PortableRadar.Animation.Dictionary) do
		Citizen.Wait(250)
	end
	local CurrentInfo, LastInfo = "", ""
	local CurrentWidth, LastWidth = 0, 0
	local CurrentVehicle, LastVehicle = nil, nil
	while true do
		Citizen.Wait(0)
		if PortableRadar.Spawned then
			if DoesEntityExist(PortableRadar.Handle) then
				local RadarViewAngle = GetOffsetFromEntityInWorldCoords(PortableRadar.Handle, -8.0, -4.4, 0.0)
				local NearestPlayer, NearestPed, NearestVehicle, VehiclePosition = GetNearestPlayerVehicleAtCoords(RadarViewAngle.x, RadarViewAngle.y, RadarViewAngle.z, 20)
				if DoesEntityExist(NearestVehicle) then
					local Plate, Speed, Name = GetVehicleNumberPlateText(NearestVehicle), math.ceil(GetEntitySpeed(NearestVehicle) * 2.236936), GetVehicleName(GetEntityModel(NearestVehicle))
					if Speed > PortableRadar.Limit then
						if LastVehicle ~= NearestVehicle then
							LastInfo = string.format("Plate: ~y~%s\n~w~Model: %s\nSpeed: ~r~%s", Plate, Name, Speed)
							LastWidth = UI.GetLargestStringWidth(0, 0.35, "Plate: "..Plate, "Model: "..Name, "Speed: "..Speed)
							if not DoesBlipExist(GetBlipFromEntity(NearestVehicle)) then
								Citizen.CreateThread(function()
									local Tracker = CreateEntityBlip("Speeder", 225, 1, NearestVehicle, 0.6, false)
									local StartTime = GetGameTimer()
									while StartTime + 120000 > GetGameTimer() do
										Citizen.Wait(1000)
									end
									DeleteEntityBlip(Tracker)
								end)
							end
						end
					else
						if NearestVehicle ~= CurrentVehicle then
							CurrentInfo = string.format("Plate: ~y~%s\n~w~Model: %s\nSpeed: %s", Plate, Name, Speed)
							CurrentWidth = UI.GetLargestStringWidth(0, 0.35, "Plate: "..Plate, "Model: "..Name, "Speed: "..Speed)
						end
					end
				end
				
				UI.RenderRectangle(1600, 100, CurrentWidth, 84, 0, 0, 0, 255)
				UI.RenderText(CurrentInfo, 1600, 100, 0.35, 255, 255, 255, 255, 0, nil, false, false, nil)

				if LastInfo ~= "" then
					UI.RenderRectangle(1600, 200, LastWidth, 84, 0, 0, 0, 255)
					UI.RenderText(LastInfo, 1600, 200, 0.35, 255, 255, 255, 255, 0, nil, false, false, nil)
				end
			else
				TriggerEvent("PortableRadar.Delete")
			end
		end
	end
end)

RegisterNetEvent("PortableRadar.Create")
AddEventHandler("PortableRadar.Create", function()
	if not PortableRadar.Spawned then
		if not PortableRadar.Spawning then
			PortableRadar.Spawning = true
			local RadarPlacement = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 1.5, 0)
			local RadarRotation = GetEntityRotation(PlayerPedId())
			local Model = GetHashKey(PortableRadar.Model)

			local Speed = tonumber(KeyboardInput("Enter speed limit:", "50", 4))
			if Speed ~= nil then
				if math.ceil(Speed) > 0 then
					TaskPlayAnim(PlayerPedId(), PortableRadar.Animation.Dictionary, PortableRadar.Animation.Place, 1.0, -1.0, 5000, 0, 1, true, true, true)

					Citizen.Wait(1500)

					RequestModel(Model)
					while not HasModelLoaded(Model) do
						Citizen.Wait(250)
					end

					PortableRadar.Handle = CreateObject(Model, RadarPlacement.x, RadarPlacement.y, RadarPlacement.z - 7.0, true, false, false)

					SetEntityRotation(PortableRadar.Handle, RadarRotation.x, RadarRotation.y, RadarRotation.z - 115.0)

					FreezeEntityPosition(PortableRadar.Handle, true)

					PortableRadar.Blip = CreateEntityBlip("Portable Radar", 380, 1, PortableRadar.Handle, 0.6, true)

					PortableRadar.Position = RadarPlacement
					PortableRadar.Limit = Speed
					PortableRadar.Spawned = true

					Notify("Radar placed!", 3000)
					PortableRadar.Spawning = false
				else
					PortableRadar.Spawning = false
					Notify("Please enter a valid speed limit")
				end
			else
				PortableRadar.Spawning = false
				Notify("Please enter a valid speed limit")
			end
		end
	else
		local pos = GetEntityCoords(PlayerPedId(), false)
		if Vdist(pos.x, pos.y, pos.z, PortableRadar.Position.x, PortableRadar.Position.y, PortableRadar.Position.z) < 0.9 then
			if not PortableRadar.Deleting then
				PortableRadar.Deleting = true
				TaskPlayAnim(PlayerPedId(), PortableRadar.Animation.Dictionary, PortableRadar.Animation.Place, 1.0, -1.0, 5000, 0, 1, true, true, true)

				Citizen.Wait(2000)

				DeleteEntityBlip(PortableRadar.Blip)
				DestroyObject(PortableRadar.Handle)

				PortableRadar.Spawned = false

				Notify("Radar removed!", 3000)
				PortableRadar.Deleting = false
			end
		else
			Notify("You must be close to the radar to remove it!", 3000)
		end
	end
end)

AddEventHandler("PortableRadar.Delete", function()
	PortableRadar.Deleting = true
	DeleteEntityBlip(PortableRadar.Blip)
	DestroyObject(PortableRadar.Handle)

	PortableRadar.Spawned = false

	Notify("Radar removed!", 3000)
	PortableRadar.Deleting = false	
end)
--==============================================================================================================================--
--Cones
local cones_deployed = false
local cobj1 = nil
local cobj2 = nil
local cobj3 = nil
local cobj4 = nil
local cobj5 = nil

RegisterNetEvent("police:DeployC")
AddEventHandler("police:DeployC", function()
	Citizen.CreateThread(function()
		if not cones_deployed then
			local cones = GetHashKey("prop_mp_cone_02")
			RequestModel(cones)
			while not HasModelLoaded(cones) do
				Citizen.Wait(0)
			end
			exports.pNotify:SendNotification({text = "Deploying cones!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
			local playerheading = GetEntityHeading(GetPlayerPed(-1))
			coords1 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 3, 10, -0.7)
			coords2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -5, -0.5)
			cobj1 = CreateObject(cones, coords1['x'], coords1['y'], coords1['z'], true, true, true)
			cobj2 = CreateObject(cones, coords2['x'], coords2['y'], coords2['z'], true, true, true)
			cobj3 = CreateObject(cones, coords2['x'], coords2['y'], coords2['z'], true, true, true)
			cobj4 = CreateObject(cones, coords2['x'], coords2['y'], coords2['z'], true, true, true)
			cobj5 = CreateObject(cones, coords2['x'], coords2['y'], coords2['z'], true, true, true)
			SetEntityHeading(cobj1, playerheading)
			SetEntityHeading(cobj2, playerheading)
			SetEntityHeading(cobj3, playerheading)
			SetEntityHeading(cobj4, playerheading)
			SetEntityHeading(cobj5, playerheading)
			AttachEntityToEntity(cobj1, GetPlayerPed(-1), 1, 0.0, 4.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
			AttachEntityToEntity(cobj2, GetPlayerPed(-1), 1, 0.0, 8.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
			AttachEntityToEntity(cobj3, GetPlayerPed(-1), 1, 0.0, 12.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
			AttachEntityToEntity(cobj4, GetPlayerPed(-1), 1, 0.0, 16.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
			AttachEntityToEntity(cobj5, GetPlayerPed(-1), 1, 0.0, 20.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
			Citizen.Wait(10)
			DetachEntity(cobj1, true, true)
			DetachEntity(cobj2, true, true)
			DetachEntity(cobj3, true, true)
			DetachEntity(cobj4, true, true)
			DetachEntity(cobj5, true, true)
			cones_deployed = true
		else
			cones_deployed = false
			exports.pNotify:SendNotification({text = "Removing cones!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
			SetEntityCoords(cobj1, -5000.0, -5000.0, 20.0, true, false, false, true)
			SetEntityCoords(cobj2, -5000.0, -5000.0, 20.0, true, false, false, true)
			SetEntityCoords(cobj3, -5000.0, -5000.0, 20.0, true, false, false, true)
			SetEntityCoords(cobj4, -5000.0, -5000.0, 20.0, true, false, false, true)
			SetEntityCoords(cobj5, -5000.0, -5000.0, 20.0, true, false, false, true)
			Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(cobj1))
			Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(cobj2))
			Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(cobj3))
			Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(cobj4))
			Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(cobj5))
			cobj1 = nil
			cobj2 = nil
			cobj3 = nil
			cobj4 = nil
			cobj5 = nil
		end
	end)
end)

---Make all peds fuck off at the sight of cones
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local o1x, o1y, o1z = table.unpack(GetEntityCoords(cobj1, true))
		local cVeh = GetClosestVehicle(o1x, o1y, o1z, 50.1, 0, 70)
		if(IsEntityAVehicle(cVeh)) then
			if IsEntityAtEntity(cVeh, cobj1, 20.0, 6.0, 2.0, 0, 1, 0) then
				local cDriver = GetPedInVehicleSeat(cVeh, -1)
				TaskVehicleTempAction(cDriver, cVeh, 6, 1000)
				SetVehicleHandbrake(cVeh, true)
			end
		end
		local o2x, o2y, o2z = table.unpack(GetEntityCoords(cobj2, true))
		local cVeh2 = GetClosestVehicle(o2x, o2y, o2z, 50.1, 0, 70)
		if(IsEntityAVehicle(cVeh2)) then
			if IsEntityAtEntity(cVeh2, cobj2, 20.0, 6.0, 2.0, 0, 1, 0) then
				local cDriver = GetPedInVehicleSeat(cVeh2, -1)
				TaskVehicleTempAction(cDriver, cVeh2, 6, 1000)
				SetVehicleHandbrake(cVeh2, true)
			end
		end
		local o3x, o3y, o3z = table.unpack(GetEntityCoords(cobj3, true))
		local cVeh3 = GetClosestVehicle(o3x, o3y, o3z, 50.1, 0, 70)
		if(IsEntityAVehicle(cVeh3)) then
			if IsEntityAtEntity(cVeh3, cobj3, 20.0, 6.0, 2.0, 0, 1, 0) then
				local cDriver = GetPedInVehicleSeat(cVeh3, -1)
				TaskVehicleTempAction(cDriver, cVeh3, 6, 1000)
				SetVehicleHandbrake(cVeh3, true)
			end
		end
		local o4x, o4y, o4z = table.unpack(GetEntityCoords(cobj3, true))
		local cVeh4 = GetClosestVehicle(o4x, o4y, o4z, 50.1, 0, 70)
		if(IsEntityAVehicle(cVeh4)) then
			if IsEntityAtEntity(cVeh3, cobj3, 20.0, 6.0, 2.0, 0, 1, 0) then
				local cDriver = GetPedInVehicleSeat(cVeh4, -1)
				TaskVehicleTempAction(cDriver, cVeh4, 6, 1000)
				SetVehicleHandbrake(cVeh4, true)
			end
		end
		local o5x, o5y, o5z = table.unpack(GetEntityCoords(cobj3, true))
		local cVeh5 = GetClosestVehicle(o5x, o5y, o5z, 50.1, 0, 70)
		if(IsEntityAVehicle(cVeh5)) then
			if IsEntityAtEntity(cVeh3, cobj3, 20.0, 6.0, 2.0, 0, 1, 0) then
				local cDriver = GetPedInVehicleSeat(cVeh5, -1)
				TaskVehicleTempAction(cDriver, cVeh5, 6, 1000)
				SetVehicleHandbrake(cVeh5, true)
			end
		end
	end
end)
--==============================================================================================================================--

--Breathalyzer

DecorRegister("BAC_Active", 2)
DecorSetBool(GetPlayerPed(-1), "BAC_Active", false)
DecorRegister("_BAC_Level", 1)
DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", 0.0)

function addBAC(amount)
	local BAC_Driving_Limit = 0.08
	local currentBAC = DecorGetFloat(GetPlayerPed(-1), "_BAC_Level")
	local newBAC = currentBAC + amount
	DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", newBAC)
	if newBAC >= BAC_Driving_Limit then
		local isBACactive = DecorGetBool(GetPlayerPed(-1), "BAC_Active")
		if not isBACactive then
			DecorSetBool(GetPlayerPed(-1), "BAC_Active", true)  
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) -- Every Minute remove some BAC
		local currentBAC = DecorGetFloat(GetPlayerPed(-1), "_BAC_Level")
		if currentBAC > 0 then
			local newBAC = currentBAC - 0.0005 --BAC to remove

			if newBAC < 0 then
				newBAC = 0
			end
			DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", newBAC) 
			if newBAC == 0 then
				DecorSetBool(GetPlayerPed(-1), "BAC_Active", false) 
			end
		end

	end
end)
--==============================================================================================================================--
--Gunshot residue test 

local GSR_LastShot = 0
local GSR_ExpireTime = 15 -- Minutes
DecorRegister("GSR_Active", 2)
DecorSetBool(GetPlayerPed(-1), "GSR_Active", false) 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsPedShooting(GetPlayerPed(-1)) then
			TriggerEvent("police:wfired")
		end
		local isGSRactive = DecorGetBool(GetPlayerPed(-1), "GSR_Active")
		if isGSRactive then
			if GSR_LastShot + (GSR_ExpireTime * 1000 * 60) <= GetGameTimer() then
				DecorSetBool(GetPlayerPed(-1), "GSR_Active", false)     
			end
		end
	end
end)

AddEventHandler("police:wfired", function()
	GSR_LastShot = GetGameTimer()
	local isGSRactive = DecorGetBool(GetPlayerPed(-1), "GSR_Active")
	if not isGSRactive then
		DecorSetBool(GetPlayerPed(-1), "GSR_Active", true)
	end
end)
--==============================================================================================================================--
--Charges
currentSuspectCharges = {}
currentSuspect = {name="", identifier=""}
currentOfficer = ""

RegisterNetEvent("police:receiveSuspectInfo")
AddEventHandler("police:receiveSuspectInfo", function(officer, name, identifier)
	currentOfficer = officer or ""
	currentSuspect.name = name or ""
	currentSuspect.identifier = identifier or ""
end)

AddEventHandler("police:add_charge", function(data)
	exports.ui:open()
	if currentSuspectCharges[data.charge] == nil then
		currentSuspectCharges[data.charge] = {}
		currentSuspectCharges[data.charge].cost = data.cost
		currentSuspectCharges[data.charge].time = data.time
		currentSuspectCharges[data.charge].count = 1
	else
		currentSuspectCharges[data.charge].cost = currentSuspectCharges[data.charge].cost + data.cost
		currentSuspectCharges[data.charge].time = currentSuspectCharges[data.charge].time + data.time
		currentSuspectCharges[data.charge].count = currentSuspectCharges[data.charge].count + 1
	end
	TriggerEvent("customNotification","Added Charge: " .. data.charge)
end)

AddEventHandler("police:review_charge", function(_ignore)
	if not _ignore then exports.ui:open() end
	local charges = {}
	local time = 0
	local cost = 0
	for key, val in pairs(currentSuspectCharges) do            
		charges[#charges+1] = (" ^3[" .. currentSuspectCharges[key].count .. "x]^5 " .. key .. "")
		time = time + currentSuspectCharges[key].time
		cost = cost + currentSuspectCharges[key].cost
	end
	charges[#charges+1] = (" ^1||^0 Suggested Jailtime: ^3" .. time .. "^0 seconds ^1" .. "||^0 Suggested Cost: ^2$^3" .. cost .. "")
	TriggerEvent('chatMessage', '[Charges]', {255, 0, 0}, table.concat(charges))
end)

AddEventHandler("police:apply_charge", function(_ignore)
	if not _ignore then exports.ui:open() end
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		local charges = {}
		local time = 0
		local cost = 0
		for key, val in pairs(currentSuspectCharges) do
			charges[#charges+1] = (" ^3[" .. currentSuspectCharges[key].count .. "x]^5 " .. key .. "")
			time = time + currentSuspectCharges[key].time
			cost = cost + currentSuspectCharges[key].cost
		end
		charges[#charges+1] = (" ^1|| ^0 Cost: $^3" .. cost .. "")
		TriggerServerEvent("police:showCharges", GetPlayerServerId(t), charges)
	else
		Notify("Please get closer to the target!", 2500)
	end
end)

AddEventHandler("police:clear_charge", function(_ignore)
	if not _ignore then exports.ui:open() end
	currentSuspectCharges = {}
	currentSuspect = {}
	TriggerEvent("customNotification","Charges Cleared")
end)

--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
Citizen.CreateThread(function()
	RequestAnimDict("random@arrests")
	while not HasAnimDictLoaded("random@arrests") do
		Citizen.Wait(0)
	end
	local radio = false
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		if DoesEntityExist(ped) and not IsEntityDead(ped) then
			if not IsPauseMenuActive() then 
				if isInService or exports.emsjob:getIsInService() then
					if IsControlJustReleased(1, 249) then -- INPUT_PUSH_TO_TALK
						if radio then
							radio = false
							ClearPedTasks(ped)
							SetEnableHandcuffs(ped, false)
						end
					else
						if IsControlPressed(1, 249) and IsControlJustPressed(1, 217) and not IsPlayerFreeAiming(PlayerId()) then -- INPUT_PUSH_TO_TALK
							radio = true
							TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
							SetEnableHandcuffs(ped, true)
						elseif IsControlPressed(1, 249) and IsControlJustPressed(1, 217) and IsPlayerFreeAiming(PlayerId()) then -- INPUT_PUSH_TO_TALK
							radio = true
							TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
							SetEnableHandcuffs(ped, true)
						end 
						if IsEntityPlayingAnim(PlayerPedId(), "random@arrests", "generic_radio_enter", 3) then
							DisableControlAction(1, 140, true)
							DisableControlAction(1, 141, true)
							DisableControlAction(1, 142, true)
							DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
							DisablePlayerFiring(ped, false) -- Disable weapon firing
						elseif IsEntityPlayingAnim(PlayerPedId(), "random@arrests", "radio_chatter", 3) then
							DisableControlAction(1, 140, true)
							DisableControlAction(1, 141, true)
							DisableControlAction(1, 142, true)
							DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
							DisablePlayerFiring(ped, false) -- Disable weapon firing
						end
					end
				end
			end 
		end 
	end
end)
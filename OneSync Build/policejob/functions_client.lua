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

--==============================================================================================================================--
--Cuffing
cuff_type = nil
cuffed = false
DecorRegister("policeCuffed", 2)
DecorSetBool(PlayerPedId(), "policeCuffed", false) 
DecorRegister("Cuffedtype", 2)
DecorSetBool(PlayerPedId(), "Cuffedtype", false)

local Animations = {
	Handcuffs = {
		Dictionary = "mp_arresting",
		Uncuff = "a_uncuff",
		Cuffed = "idle",
	},
	Arresting = {
		Dictionary = "mp_arrest_paired",
		Cop = "cop_p2_back_right",
		Criminal = "crook_p2_back_right",
	},
} 

function CuffAnimation(cuffer)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
	SetPedCanRagdoll(PlayerPed, true)
	SetEnableHandcuffs(PlayerPed, true)
	SetCurrentPedWeapon(PlayerPed, GetHashKey("WEAPON_UNARMED"), true)
	SetPedComponentVariation(PlayerPed, 7, 41, 0 ,0)
	DecorSetBool(PlayerPed, "policeCuffed", true)
	RequestAnimDict(Animations.Arresting.Dictionary)
	while not HasAnimDictLoaded(Animations.Arresting.Dictionary) do
		Citizen.Wait(0)
	end
	local cuffer = GetPlayerPed(GetPlayerFromServerId(cuffer))
	local dir = GetEntityHeading(cuffer)
	SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))
	Citizen.Wait(100)
	SetEntityHeading(PlayerPedId(),dir)
	TaskPlayAnim(PlayerPedId(), Animations.Arresting.Dictionary, Animations.Arresting.Criminal, 8.0, -8, -1, 32, 0, 0, 0, 0)
	Citizen.Wait(2500)
end

RegisterNetEvent("police:cuff")
AddEventHandler("police:cuff", function(_type, cuffer)
	local PlayerPed = PlayerPedId()
	if cuffed and _type == cuff_type then
		cuffed = not cuffed
		cuff_type = nil
		Notify("Your restraints have been removed!", 2500)
		SetPedCanRagdoll(PlayerPed, true)
		ClearPedSecondaryTask(PlayerPed)
		SetEnableHandcuffs(PlayerPed, false)
		SetCurrentPedWeapon(PlayerPed, GetHashKey("WEAPON_UNARMED"), true)
		SetPedComponentVariation(PlayerPed, 7, 0, 0 ,0)
		DecorSetBool(PlayerPed, "policeCuffed", false) 
		DecorSetBool(PlayerPed, "Cuffedtype", false)
	elseif cuffed and _type ~= cuff_type then
		cuff_type = _type
		if _type == "freeze" then
			DecorSetBool(PlayerPed, "Cuffedtype", true) 
			Notify("Your restraints have been tightened to the point where you are unable to move!", 2500)
		else
			Notify("Your restraints have been loosened!", 2500)
			DecorSetBool(PlayerPed, "Cuffedtype", false)
		end
	elseif not cuffed then
		SetPedCanRagdoll(PlayerPed, false)
		if exports.core_modules:isCuffed() then
			TriggerServerEvent("handcuffs:uncuff", GetPlayerServerId(PlayerId()))
		end
		cuff_type = _type
		Notify("You have been restrained!", 2500)
		ClearPedTasks(PlayerPed)
		CuffAnimation(cuffer)
		Citizen.Wait(3500)
		RequestAnimDict("mp_arresting")
		while not HasAnimDictLoaded("mp_arresting") do
			Citizen.Wait(0)
			PlayerPed = PlayerPedId()
		end
		TaskPlayAnim(PlayerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
		SetPedCanRagdoll(PlayerPed, true)
		SetEnableHandcuffs(PlayerPed, true)
		SetCurrentPedWeapon(PlayerPed, GetHashKey("WEAPON_UNARMED"), true)
		SetPedComponentVariation(PlayerPed, 7, 41, 0 ,0)
		DecorSetBool(PlayerPed, "policeCuffed", true)
		if _type == "freeze" then
			DecorSetBool(PlayerPed, "Cuffedtype", true) 
		else
			DecorSetBool(PlayerPed, "Cuffedtype", false)
		end
		cuffed = not cuffed
	end
end)

RegisterNetEvent("police:uncuff")
AddEventHandler("police:uncuff", function()
	local PlayerPed = PlayerPedId()

	cuffed = false
	cuff_type = nil
	ClearPedSecondaryTask(PlayerPed)
	SetEnableHandcuffs(PlayerPed, false)
	SetCurrentPedWeapon(PlayerPed, GetHashKey("WEAPON_UNARMED"), true)
	SetPedComponentVariation(PlayerPed, 7, 0, 0 ,0)
	DecorSetBool(PlayerPed, "policeCuffed", false)
	DecorSetBool(PlayerPed, "Cuffedtype", false)
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
							if IsPlayerDead(PlayerPedId()) then
								SetEntityHealth(PlayerPedId(), 100)
								SetPedIntoVehicle(PlayerPedId(), vehicleHandle, i)
								break
							else
								SetPedIntoVehicle(PlayerPedId(), vehicleHandle, i)
								break
							end
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
			for Index = 0, 255 do
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
		if isInService and IsPedInAnyVehicle(PlayerPedId()) == false then
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
									while StartTime + 10000 > GetGameTimer() do
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

--Breathalyzer

DecorRegister("BAC_Active", 2)
DecorSetBool(PlayerPedId(), "BAC_Active", false)
DecorRegister("_BAC_Level", 1)
DecorSetFloat(PlayerPedId(), "_BAC_Level", 0.0)

local BAC_Driving_Limit = 0.08

function addBAC(amount)
	local PlayerPed = PlayerPedId()
	local currentBAC = DecorGetFloat(PlayerPed, "_BAC_Level")
	local newBAC = currentBAC + amount

	DecorSetFloat(PlayerPed, "_BAC_Level", newBAC)
	if newBAC >= BAC_Driving_Limit then
		DecorSetBool(PlayerPed, "BAC_Active", true)  
	else
		DecorSetBool(PlayerPed, "BAC_Active", false) 
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) -- Every Minute remove some BAC
		local PlayerPed = PlayerPedId()
		local currentBAC = DecorGetFloat(PlayerPed, "_BAC_Level")
		if currentBAC > 0 then
			local newBAC = currentBAC - 0.0005 --BAC to remove

			if newBAC < 0 then
				newBAC = 0
			end

			DecorSetFloat(PlayerPed, "_BAC_Level", newBAC) 

			if newBAC == 0 then
				DecorSetBool(PlayerPed, "BAC_Active", false) 
			end
		end

	end
end)
--==============================================================================================================================--
--Gunshot residue test 

DecorRegister("GSR_Active", 2)
DecorSetBool(PlayerPedId(), "GSR_Active", false)

--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

Citizen.CreateThread(function()
	local AnimDict = "random@arrests"
	local Anim1, Anim2 = "generic_radio_enter", "radio_chatter"
	local GSR_LastShot = 0
	local GSR_ExpireTime = 15 -- Minutes
	local GSR_Whitelist = {
		["WEAPON_BALL"]	= 1,
		["WEAPON_PETROLCAN"] = 1,
		["WEAPON_SNOWBALL"] = 1,
		["WEAPON_STUNGUN"] = 1,
		["WEAPON_FIREEXTINGUISHER"] = 1,
	}

	RequestAnimDict(AnimDict)

	while not HasAnimDictLoaded(AnimDict) do
		Citizen.Wait(0)
	end

	local radio = false

	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()

		if not isCop then
			if IsPedSittingInAnyVehicle(PlayerPed) then
				local PlayerVehicle = GetVehiclePedIsUsing(PlayerPed, false)
				if GetPedInVehicleSeat(PlayerVehicle, -1) == PlayerPed then
					local PlayerVehicleModel = GetEntityModel(PlayerVehicle)
					for k,v in pairs(cars) do
						if GetHashKey(v.model) == PlayerVehicleModel then
							SetVehicleUndriveable(PlayerVehicle, true)
						end
					end
				end
			end
		else
			if not IsEntityDead(PlayerPed) and not IsPauseMenuActive() then
				if isInService then
					local PlayerId = PlayerId()

					if IsPlayerFreeAiming(PlayerId) then
						local PlayerPosition = GetEntityCoords(PlayerPed, false)

						for PlayerIndex = 0, 255 do
							if NetworkIsPlayerActive(PlayerIndex) then
								if PlayerId ~= PlayerIndex then
									local OtherPed = GetPlayerPed(PlayerIndex)

									if DoesEntityExist(OtherPed) then
										local OtherPosition = GetEntityCoords(OtherPed, false)
										local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, OtherPosition.x, OtherPosition.y, OtherPosition.z, true)

										if Distance < 1.0 then
											local isUserCuffed, cuffType = DecorGetBool(OtherPed, "policeCuffed"), DecorGetBool(OtherPed, "Cuffedtype")
											local OtherServerId = GetPlayerServerId(PlayerIndex)
											local OtherCharacterName = exports.core:GetCharacterName(OtherServerId)
											if not isUserCuffed then
												DisplayHelpText("Press ~INPUT_CONTEXT~ to cuff "..OtherCharacterName)

												if IsControlJustPressed(1, 51) then
													RequestAnimDict(Animations.Arresting.Dictionary)
													while not HasAnimDictLoaded(Animations.Arresting.Dictionary) do
														Citizen.Wait(0)
													end
													TaskPlayAnim(PlayerPed, Animations.Arresting.Dictionary, Animations.Arresting.Cop, 8.0, -8, -1, 48, 0, 0, 0, 0)
													TriggerServerEvent("police:cuff", OtherServerId, "normal", GetPlayerServerId(PlayerPed))
													Citizen.Wait(3500)
													ClearPedTasksImmediately(PlayerPed)
												end
											else
												if cuffType then
													DisplayHelpText("Press ~INPUT_CONTEXT~ to uncuff "..OtherCharacterName.."\nPress ~INPUT_INTERACTION_MENU~ to loosen")
												else
													DisplayHelpText("Press ~INPUT_CONTEXT~ to uncuff "..OtherCharacterName.."\nPress ~INPUT_INTERACTION_MENU~ to tighten")
												end

												if IsControlJustPressed(1, 51) then
													TriggerServerEvent("police:uncuff", OtherServerId)
												end
												
												if IsControlJustPressed(1, 244) then
													if cuffType then
														TriggerServerEvent("police:cuff", OtherServerId, "normal")
													else
														TriggerServerEvent("police:cuff", OtherServerId, "freeze")
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


				if isInService or exports.emsjob:getIsInService() then
					local PlayerId = PlayerId()

					if IsControlJustReleased(1, 249) then -- INPUT_PUSH_TO_TALK
						if radio then
							radio = false
							ClearPedTasks(PlayerPed)
							SetEnableHandcuffs(PlayerPed, false)
						end
					else
						local IsFreeAiming = IsPlayerFreeAiming(PlayerId)

						if IsControlPressed(1, 249) and IsControlJustPressed(1, 217) and not IsFreeAiming then -- INPUT_PUSH_TO_TALK
							radio = true

							TaskPlayAnim(PlayerPed, AnimDict, Anim1, 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
							SetEnableHandcuffs(PlayerPed, true)
						elseif IsControlPressed(1, 249) and IsControlJustPressed(1, 217) and IsFreeAiming then -- INPUT_PUSH_TO_TALK
							radio = true

							TaskPlayAnim(PlayerPed, AnimDict, Anim2, 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
							SetEnableHandcuffs(PlayerPed, true)
						end 

						if IsEntityPlayingAnim(PlayerPed, AnimDict, Anim1, 3) then
							DisableControlAction(1, 140, true)
							DisableControlAction(1, 141, true)
							DisableControlAction(1, 142, true)
							DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
							DisablePlayerFiring(PlayerPed, true) -- Disable weapon firing
						elseif IsEntityPlayingAnim(PlayerPed, AnimDict, Anim2, 3) then
							DisableControlAction(1, 140, true)
							DisableControlAction(1, 141, true)
							DisableControlAction(1, 142, true)
							DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
							DisablePlayerFiring(PlayerPed, true) -- Disable weapon firing
						end
					end
				end
			end 
		end

		if cuffed then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 25, true)
			SetPedPathCanUseLadders(PlayerPed, false)
			if IsPedInAnyVehicle(PlayerPed, false) then
				DisableControlAction(0, 59, true)
			end
		end

		if IsPedShooting(PlayerPed) then
			local hasWeapon, currentWeapon = GetCurrentPedWeapon(PlayerPed, 1)
			if currentWeapon ~= nil then
				local WeaponStr = Weaponhashes[tostring(currentWeapon)]
				if WeaponStr then
					if GetAmmoInPedWeapon(PlayerPed, currentWeapon) > 0 then
						if not GSR_Whitelist[WeaponStr] then
							GSR_LastShot = GetGameTimer()
							DecorSetBool(PlayerPed, "GSR_Active", true)
						end
					end
				end
			end
		end

		local isGSRactive = DecorGetBool(PlayerPed, "GSR_Active")

		if isGSRactive then
			if GSR_LastShot + (GSR_ExpireTime * 1000 * 60) <= GetGameTimer() then
				DecorSetBool(PlayerPed, "GSR_Active", false)   
			end
		end

		if drag then
			wasDragged = true
			AttachEntityToEntity(PlayerPed, GetPlayerPed(GetPlayerFromServerId(draggedBy)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
			if not IsPedInParachuteFreeFall(PlayerPed) and wasDragged then
				wasDragged = false
				DetachEntity(PlayerPed, true, false)    
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if cuffed then
			local PlayerPed = PlayerPedId()

			if not IsEntityDead(PlayerPed) then
				if IsPedRunningRagdollTask(PlayerPed) then
					while IsPedRunningRagdollTask(PlayerPed) do
						Citizen.Wait(0)
					end
					ClearPedTasksImmediately(PlayerPed)
				end
			end

			if cuff_type == "freeze" then
				TaskPlayAnim(PlayerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 16, 0, 0, 0, 0)
			end

			if not IsEntityPlayingAnim(PlayerPed, "mp_arresting", "idle", 3) and cuff_type == "normal" then
				Citizen.Wait(100)
				TaskPlayAnim(PlayerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
			end
		end
	end
end)

Citizen.CreateThread(function()
	local AnimDict = "weapons@first_person@aim_idle@p_m_zero@melee@knife@fidgets@b"
	local Anim = "fidget_low_loop"
	local Knifehash = GetHashKey("WEAPON_KNIFE")

	RequestAnimDict(AnimDict)

	while not HasAnimDictLoaded(AnimDict) do
		Citizen.Wait(0)
	end

	while true do
		Citizen.Wait(0)
		if not isInService then
			local PlayerPed = PlayerPedId()

			if GetCurrentPedWeapon(PlayerPed, Knifehash, true) then
				local PlayerId = PlayerId()
				local PlayerPosition = GetEntityCoords(PlayerPed, false)


				for PlayerIndex = 0, 255 do
					if NetworkIsPlayerActive(PlayerIndex) then
						if PlayerId ~= PlayerIndex then
							local OtherPed = GetPlayerPed(PlayerIndex)
							if DoesEntityExist(OtherPed) then
								local OtherPosition = GetEntityCoords(OtherPed, false)
								local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, OtherPosition.x, OtherPosition.y, OtherPosition.z, true)

								if Distance < 1.0 then
									local isUserCuffed = DecorGetBool(OtherPed, "policeCuffed")
									if isUserCuffed then
										local OtherServerId = GetPlayerServerId(PlayerIndex)

										DisplayHelpText("Press ~INPUT_CONTEXT~ to uncuff "..exports.core:GetCharacterName(OtherServerId))

										if IsControlJustPressed(1, 51) then
											local uncuffing = GetGameTimer() + 7500
											
											while uncuffing > GetGameTimer() do
												Citizen.Wait(0)

												if not IsEntityPlayingAnim(PlayerPed, AnimDict, Anim, 3) then
													TaskPlayAnim(PlayerPed, AnimDict, Anim, 8.0, -4.0, -1, 9, 0, false, false, false)
												end
											end
												
											ClearPedTasks(PlayerPed)
												
											if not IsEntityDead(PlayerPed) and not cuffed then 
												TriggerServerEvent("police:uncuff", OtherServerId)
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

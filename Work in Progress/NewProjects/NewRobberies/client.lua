local IsRobbingStoreVault = false
local TotalLocks = 0
local TotalComboLocks = 0
local NumberOfPins = 0
local isRobbing = false
local isStillRobbingBlaine = false
local isStillRobbingPacific = false
local isStillRobbingFleeca = false
local isStillRobbingStore = false
local whichFleeca = nil
local whichStore = nil
local VehicleHandle = nil
local HasBlaineBeenReset = false
local HasPacificBeenReset = false
local HasFleecaBeenReset = false
local CurrentLockpicked = 0

function DisplayHelpText(Str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(Str or "")
	EndTextCommandDisplayHelp(0, 0, 0, -1)
end

function Notify(Message, Time)
	exports.pNotify:SendNotification({text = Message or "", type = "error", timeout = Time or 3000, layout = "centerRight", queue = "left"})
end

function RenderMarker(Type, X, Y, Z, SX, SY, SZ, R, G, B, A, BobUpAndDown)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		DrawMarker(Type, X, Y, Z - 0.9, 0, 0, 0, 0, 0, 0, SX or 0, SY or 0, SZ or 0, R or 255, G or 255, B or 255, A or 255, BobUpAndDown or false, 0, 2, 0, 0, 0, 0)
	end
end

RegisterNetEvent('customNotification')
AddEventHandler('customNotification', function(msg)
   TriggerEvent("pNotify:SendNotification", { theme = "gta2", text = "".. msg .. "", layout = "centerRight", type = "info", timeout = 6000, animation = {open = "gta_effects_open", close = "gta_effects_close"} } )
end)

--[[ Store Robberies ]]--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		if not exports.policejob:getIsInService() then
			for StoreNumber = 1, #Rivalry.Robberies.Stores do
				if #(PlayerPosition - Rivalry.Robberies.Stores[StoreNumber].Vault) < 15.0 then
					for RegisterNumber = 1, #Rivalry.Robberies.Stores[StoreNumber].CashRegisters do
						if #(PlayerPosition - Rivalry.Robberies.Stores[StoreNumber].CashRegisters[RegisterNumber].Coords) < 1 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to break open the cash register!")
							if IsControlJustPressed(1, 51) then
								TriggerServerEvent("Rivalry.Rob.CashRegister", StoreNumber, RegisterNumber, GetPlayerServerId(PlayerId()))
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
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		if not exports.policejob:getIsInService() then
			for StoreNumber = 1, #Rivalry.Robberies.Stores do
				if #(PlayerPosition - Rivalry.Robberies.Stores[StoreNumber].Vault) < 1 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to start cracking the safe!")
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("Rivalry.Rob.StoreVault", StoreNumber, GetPlayerServerId(PlayerId()))
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		if #(PlayerPosition - Rivalry.Robberies.Banks.Blaine.Vault) < 20 then
			if not HasBlaineBeenReset then
				TriggerServerEvent("Rivalry.CheckBankStatus", "Blaine", 0)
			end
			if not exports.policejob:getIsInService() then
				if not Rivalry.Robberies.Banks.Blaine.Locked then
					for Index = 1, #Rivalry.Robberies.Banks.Blaine.LockedBoxes do
						if #(PlayerPosition - Rivalry.Robberies.Banks.Blaine.LockedBoxes[Index]) < 1 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to lockpick safe box!")
							if IsControlJustPressed(1, 51) then
								if exports.core_modules:GetItemQuantity(36) > 0 then
									TriggerServerEvent("Rivalry.Rob.Blaine.Safebox", Index, GetPlayerServerId(PlayerId()))
								else
									Notify("You do not have any lockpicks!", 2500)
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
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		for Index = 1, #Rivalry.Robberies.Banks.Fleeca do
			if #(PlayerPosition - Rivalry.Robberies.Banks.Fleeca[Index].Vault) < 10.0 then
				if not HasFleecaBeenReset then
					TriggerServerEvent("Rivalry.CheckBankStatus", "Fleeca", Index)
				end
				if not exports.policejob:getIsInService() then
					if not Rivalry.Robberies.Banks.Fleeca[Index].Locked then
						for BoxNumber = 1, #Rivalry.Robberies.Banks.Fleeca[Index].LockedBoxes do
							if #(PlayerPosition - Rivalry.Robberies.Banks.Fleeca[Index].LockedBoxes[BoxNumber]) < 1 then
								DisplayHelpText("Press ~INPUT_CONTEXT~ to lockpick safe box!")
								if IsControlJustPressed(1, 51) then
									if exports.core_modules:GetItemQuantity(36) > 0 then
										TriggerServerEvent("Rivalry.Rob.Fleeca.Safebox", Index, BoxNumber, GetPlayerServerId(PlayerId()))
									else
										Notify("You do not have any lockpicks!", 2500)
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
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		if #(PlayerPosition - Rivalry.Robberies.Banks.Pacific.Vault) < 20 then
			if not HasPacificBeenReset then
				TriggerServerEvent("Rivalry.CheckBankStatus", "Pacific", 0)
			end
			if not exports.policejob:getIsInService() then
				if not Rivalry.Robberies.Banks.Pacific.Locked then
					for Index = 1, #Rivalry.Robberies.Banks.Pacific.LockedBoxes do
						if not Rivalry.Robberies.Banks.Pacific.Locked4 then
							if #(PlayerPosition - Rivalry.Robberies.Banks.Pacific.LockedBoxes[Index]) < 1 then
								DisplayHelpText("Press ~INPUT_CONTEXT~ to lockpick safe box!")
								if IsControlJustPressed(1, 51) then
									if exports.core_modules:GetItemQuantity(36) > 0 and not Rivalry.Robberies.Banks.Pacific.Locked then
										TriggerServerEvent("Rivalry.Rob.Pacific.Safebox", Index, GetPlayerServerId(PlayerId()))
									else
										Notify("You do not have any lockpicks!", 2500)
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
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		if not exports.policejob:getIsInService() then
			if #(PlayerPosition - Rivalry.Robberies.Banks.Pacific.CameraDisable) < 11.0 then
				if #(PlayerPosition - Rivalry.Robberies.Banks.Pacific.CameraDisable) <= 1.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to disable cameras!")
					if IsControlJustPressed(1, 51) then
						TriggerEvent("Rivalry.HackCameras", 1, 6)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("Rivalry.Rob.CashRegister")
AddEventHandler("Rivalry.Rob.CashRegister", function(StoreNumber, RegisterNumber)
	Citizen.CreateThread(function()
		if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			local PlayerPed = PlayerPedId()
			local Dictionary = "missheist_jewel"
			local Animation = "smash_case"
			RequestAnimDict(Dictionary)
			while not HasAnimDictLoaded(Dictionary) do
				Citizen.Wait(0)
			end
			TaskPlayAnim(PlayerPed, Dictionary, Animation, 4.0, -4, -1, 0, 0, 0, 0, 0)
			TriggerServerEvent("dispatch:ten-ninety-store-cashregisters", Rivalry.Robberies.Stores[StoreNumber].Name)
			PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1);
			--TriggerEvent('LIFE_CL:Sound:PlayOnOne', "locking", "0.3")
			Citizen.Wait(2000)
			Rivalry.Robberies.Stores[StoreNumber].CashRegisters[RegisterNumber].Robbed = true
			PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			TriggerServerEvent("Rivalry.CashRegister.Payout")
		end
	end)
end)

RegisterNetEvent("Rivalry.Rob.StoreVault")
AddEventHandler("Rivalry.Rob.StoreVault", function(StoreNumber)
	Citizen.CreateThread(function()
		if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			OpenComboLockGui()
			SendNUIMessage({combolock = true, newnumber = true, numberone = math.random(1, 40), numbertwo = math.random(1, 40), numberthree = math.random(1, 40)})
			IsRobbingStoreVault = true
			TotalLocks = 0
			NumberOfPins = 0
			TriggerServerEvent("dispatch:ten-ninety-store-vault", Rivalry.Robberies.Stores[StoreNumber].Name)
		end
	end)
end)

RegisterNetEvent("Rivalry.Rob.Blaine.Safebox")
AddEventHandler("Rivalry.Rob.Blaine.Safebox", function()
	Citizen.CreateThread(function()
		if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			OpenLockPickGui()
			isStillRobbingBlaine = true
		end
	end)
end)

RegisterNetEvent("Rivalry.Rob.Pacific.Safebox")
AddEventHandler("Rivalry.Rob.Pacific.Safebox", function()
	Citizen.CreateThread(function()
		if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			OpenLockPickGui()
			isStillRobbingPacific = true
		end
	end)
end)

RegisterNetEvent("Rivalry.Rob.Fleeca.Safebox")
AddEventHandler("Rivalry.Rob.Fleeca.Safebox", function(BankNumber)
	Citizen.CreateThread(function()
		if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			OpenLockPickGui()
			isStillRobbingFleeca = true
			whichFleeca = BankNumber
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isStillRobbingPacific == true then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(PlayerPosition - Rivalry.Robberies.Banks.Pacific.Vault) > 20 then
				TriggerServerEvent("Rivalry.Robberies.Stopped.Robbing", "Pacific", 0)
				isStillRobbingPacific = false
			end
		elseif isStillRobbingBlaine == true then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(PlayerPosition - Rivalry.Robberies.Banks.Blaine.Vault) > 20 then
				TriggerServerEvent("Rivalry.Robberies.Stopped.Robbing", "Blaine", 0)
				isStillRobbingPacific = false
			end
		elseif isStillRobbingPacific == true then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(PlayerPosition - Rivalry.Robberies.Banks.Fleeca[whichFleeca].Vault) > 20 then
				TriggerServerEvent("Rivalry.Robberies.Stopped.Robbing", "Fleeca", whichFleeca)
				isStillRobbingFleeca = false
			end
		end
	end
end)

function OpenLockPickGui()
	if exports.core_modules:GetItemQuantity(36) > 0 then
		SetPlayerControl(PlayerId(), 0, 0)
		SetNuiFocus(true, true)
		SendNUIMessage({lockpick = true, pins = exports.core_modules:GetItemQuantity(36), doorlock = false})
		RequestAnimDict("mini@safe_cracking")
		while not HasAnimDictLoaded("mini@safe_cracking") do
			Wait(0)
		end
		TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_clock_fast", 4.0, -4, -1, 1, 0, false, false, false)
	else
		Notify("You do not have any lockpicks!", 2500)
	end
end

function CloseLockPickGui()
	SetNuiFocus(false, false)
	SendNUIMessage({lockpick = false})
	SetPlayerControl(PlayerId(), 1, 0)
end

-- Open Gui and Focus NUI
function OpenComboLockGui()
	SetPlayerControl(PlayerId(), 0, 0)
	SetNuiFocus(true, true)
	RequestAnimDict("mini@safe_cracking")
	while not HasAnimDictLoaded("mini@safe_cracking") do
		Wait(0)
	end
	TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_clock_fast", 4.0, -4, -1, 1, 0, false, false, false)
end

-- Close Gui and disable NUI
function CloseComboLockGui()
	ClearPedTasks(PlayerPedId())
	SetNuiFocus(false, false)
	SendNUIMessage({combolock = false})
	SetPlayerControl(PlayerId(), 1, 0)
end

RegisterNetEvent("Rivalry.HackVault")
AddEventHandler("Rivalry.HackVault", function(phase, phase_max, bank, banknumber)
	isRobbing = true
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start", 5, 31, "Starting Hack.. Phase "..phase.." of "..phase_max,function(success)
		if success then
			if phase == phase_max then
				isRobbing = false
				TriggerEvent("mhacking:hide")
				TriggerServerEvent("Rivalry.Robberies.Sync.Vault", bank, banknumber, false)
			else
				TriggerEvent("Rivalry.HackVault", phase+1, 20, bank, banknumber)
			end
		else
			isRobbing = false
			TriggerEvent("mhacking:hide")
			TriggerServerEvent("Rivalry.Robberies.Sync.Vault", bank, banknumber, true)
		end
	end)
end)

RegisterNetEvent("Rivalry.HackCameras")
AddEventHandler("Rivalry.HackCameras", function(phase, phase_max)
	isRobbing = true
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start", 5, 31, "Starting Hack.. Phase"..phase.." of "..phase_max,function(success)
		if success then
			if phase == phase_max then
				isRobbing = false
				TriggerEvent("mhacking:hide")
				TriggerServerEvent("Rivalry.Disable.Pacific.Cameras")
			else
				TriggerEvent("Rivalry.HackCameras", phase+1, 6)
			end
		else
			isRobbing = false
			TriggerEvent("mhacking:hide")
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isRobbing then
			if IsEntityDead(PlayerPedId()) then
				TriggerEvent("mhacking:fail")
				isRobbing = false
			end
			if exports.policejob:getIsCuffed() then
				TriggerEvent("mhacking:fail")
				isRobbing = false
			end
			if IsPedSittingInAnyVehicle(PlayerPedId()) then
				TriggerEvent("mhacking:fail")
				isRobbing = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2500)
		for Index = 1, #Rivalry.Robberies.Banks.Fleeca do
			if not DoesEntityExist(Rivalry.Robberies.Banks.Fleeca[Index].Handle) then
				Rivalry.Robberies.Banks.Fleeca[Index].Handle = GetClosestObjectOfType(Rivalry.Robberies.Banks.Fleeca[Index].Vault.x, Rivalry.Robberies.Banks.Fleeca[Index].Vault.y, Rivalry.Robberies.Banks.Fleeca[Index].Vault.z, 1.0, Rivalry.Robberies.Banks.Fleeca[Index].Model, false, false, false)
			end
			if not DoesEntityExist(Rivalry.Robberies.Banks.Fleeca[Index].Handle2) then
				Rivalry.Robberies.Banks.Fleeca[Index].Handle2 = GetClosestObjectOfType(Rivalry.Robberies.Banks.Fleeca[Index].Vault2.x, Rivalry.Robberies.Banks.Fleeca[Index].Vault2.y, Rivalry.Robberies.Banks.Fleeca[Index].Vault2.z, 1.0, Rivalry.Robberies.Banks.Fleeca[Index].Vault2Model, false, false, false)
			end
		end

		if not DoesEntityExist(Rivalry.Robberies.Banks.Blaine.Handle) then
			Rivalry.Robberies.Banks.Blaine.Handle = GetClosestObjectOfType(Rivalry.Robberies.Banks.Blaine.Vault.x, Rivalry.Robberies.Banks.Blaine.Vault.y, Rivalry.Robberies.Banks.Blaine.Vault.z, 1.0, Rivalry.Robberies.Banks.Blaine.Model, false, false, false)
		end

		if not DoesEntityExist(Rivalry.Robberies.Banks.Pacific.Handle) then
			Rivalry.Robberies.Banks.Pacific.Handle = GetClosestObjectOfType(Rivalry.Robberies.Banks.Pacific.Vault.x, Rivalry.Robberies.Banks.Pacific.Vault.y, Rivalry.Robberies.Banks.Pacific.Vault.z, 1.0, Rivalry.Robberies.Banks.Pacific.Model, false, false, false)
		end

		if not DoesEntityExist(Rivalry.Robberies.Banks.Pacific.Handle2) then
			Rivalry.Robberies.Banks.Pacific.Handle2 = GetClosestObjectOfType(Rivalry.Robberies.Banks.Pacific.Door.x, Rivalry.Robberies.Banks.Pacific.Door.y, Rivalry.Robberies.Banks.Pacific.Door.z, 1.0, Rivalry.Robberies.Banks.Pacific.DoorModel, false, false, false)
		end

		if not DoesEntityExist(Rivalry.Robberies.Banks.Pacific.Handle3) then
			Rivalry.Robberies.Banks.Pacific.Handle3 = GetClosestObjectOfType(Rivalry.Robberies.Banks.Pacific.Door2.x, Rivalry.Robberies.Banks.Pacific.Door2.y, Rivalry.Robberies.Banks.Pacific.Door2.z, 1.0, Rivalry.Robberies.Banks.Pacific.Door2Model, false, false, false)
		end

		if not DoesEntityExist(Rivalry.Robberies.Banks.Pacific.Handle4) then
			Rivalry.Robberies.Banks.Pacific.Handle4 = GetClosestObjectOfType(Rivalry.Robberies.Banks.Pacific.Door3.x, Rivalry.Robberies.Banks.Pacific.Door3.y, Rivalry.Robberies.Banks.Pacific.Door3.z, 1.0, Rivalry.Robberies.Banks.Pacific.Door3Model, false, false, false)
		end

		for Index = 1, #Rivalry.Robberies.Banks.Pacific.Doors do
			if not DoesEntityExist(Rivalry.Robberies.Banks.Pacific.Doors[Index].Handle) then
				Rivalry.Robberies.Banks.Pacific.Doors[Index].Handle = GetClosestObjectOfType(Rivalry.Robberies.Banks.Pacific.Doors[Index].Position.x, Rivalry.Robberies.Banks.Pacific.Doors[Index].Position.y, Rivalry.Robberies.Banks.Pacific.Doors[Index].Position.z, 1.0, Rivalry.Robberies.Banks.Pacific.Doors[Index].Model, false, false, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		if #(Rivalry.Robberies.Banks.Blaine.Vault - PlayerPosition) <= 10.0 then
			if Rivalry.Robberies.Banks.Blaine.Locked == true then
				if Rivalry.Robberies.Banks.Blaine.Handle ~= nil and Rivalry.Robberies.Banks.Blaine.Handle ~= 0 then
					SetEntityHeading(Rivalry.Robberies.Banks.Blaine.Handle, Rivalry.Robberies.Banks.Blaine.Heading)
				end
			else
				if Rivalry.Robberies.Banks.Blaine.Handle ~= nil and Rivalry.Robberies.Banks.Blaine.Handle ~= 0 then
					SetEntityHeading(Rivalry.Robberies.Banks.Blaine.Handle, Rivalry.Robberies.Banks.Blaine.OpenHeading)
				end
			end
		end
		if #(Rivalry.Robberies.Banks.Pacific.Vault - PlayerPosition) <= 25.0 then
			if Rivalry.Robberies.Banks.Pacific.Locked == true then
				if Rivalry.Robberies.Banks.Pacific.Handle ~= nil and Rivalry.Robberies.Banks.Pacific.Handle ~= 0 then
					SetEntityHeading(Rivalry.Robberies.Banks.Pacific.Handle, Rivalry.Robberies.Banks.Pacific.Heading)
				end
			else
				if Rivalry.Robberies.Banks.Pacific.Handle ~= nil and Rivalry.Robberies.Banks.Pacific.Handle ~= 0 then
					SetEntityHeading(Rivalry.Robberies.Banks.Pacific.Handle, Rivalry.Robberies.Banks.Pacific.OpenHeading)
				end
			end
			if Rivalry.Robberies.Banks.Pacific.Locked2 == true then
				if Rivalry.Robberies.Banks.Pacific.Handle2 ~= nil and Rivalry.Robberies.Banks.Pacific.Handle2 ~= 0 then
					SetEntityHeading(Rivalry.Robberies.Banks.Pacific.Handle2, Rivalry.Robberies.Banks.Pacific.DoorHeading)
				end
			end
			if Rivalry.Robberies.Banks.Pacific.Locked3 == true then
				if Rivalry.Robberies.Banks.Pacific.Handle3 ~= nil and Rivalry.Robberies.Banks.Pacific.Handle3 ~= 0 then
					SetEntityHeading(Rivalry.Robberies.Banks.Pacific.Handle3, Rivalry.Robberies.Banks.Pacific.Door2Heading)
				end
			end
			if Rivalry.Robberies.Banks.Pacific.Locked4 == true then
				if Rivalry.Robberies.Banks.Pacific.Handle4 ~= nil and Rivalry.Robberies.Banks.Pacific.Handle4 ~= 0 then
					SetEntityHeading(Rivalry.Robberies.Banks.Pacific.Handle4, Rivalry.Robberies.Banks.Pacific.Door3Heading)
				end
			end
			for Index = 1, #Rivalry.Robberies.Banks.Pacific.Doors do
				if Rivalry.Robberies.Banks.Pacific.Doors[Index].Locked == true then
					if Rivalry.Robberies.Banks.Pacific.Doors[Index].Handle ~= nil and Rivalry.Robberies.Banks.Pacific.Doors[Index].Handle ~= 0 then
						SetEntityHeading(Rivalry.Robberies.Banks.Pacific.Doors[Index].Handle, Rivalry.Robberies.Banks.Pacific.Doors[Index].Heading)
					end
				end
			end
		end
		for Index = 1, #Rivalry.Robberies.Banks.Fleeca do
			if #(Rivalry.Robberies.Banks.Fleeca[Index].Vault - PlayerPosition) <= 10.0 then
				if Rivalry.Robberies.Banks.Fleeca[Index].Locked == true then
					if Rivalry.Robberies.Banks.Fleeca[Index].Handle ~= nil and Rivalry.Robberies.Banks.Fleeca[Index].Handle ~= 0 then
						SetEntityHeading(Rivalry.Robberies.Banks.Fleeca[Index].Handle, Rivalry.Robberies.Banks.Fleeca[Index].Heading)
					end
				else
					if Rivalry.Robberies.Banks.Fleeca[Index].Handle ~= nil and Rivalry.Robberies.Banks.Fleeca[Index].Handle ~= 0 then
						SetEntityHeading(Rivalry.Robberies.Banks.Fleeca[Index].Handle, Rivalry.Robberies.Banks.Fleeca[Index].OpenHeading)
					end
				end
				if Rivalry.Robberies.Banks.Fleeca[Index].Locked2 == true then
					if Rivalry.Robberies.Banks.Fleeca[Index].Handle2 ~= nil and Rivalry.Robberies.Banks.Fleeca[Index].Handle2 ~= 0 then
						SetEntityHeading(Rivalry.Robberies.Banks.Fleeca[Index].Handle2, Rivalry.Robberies.Banks.Fleeca[Index].Vault2Heading)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		if #(Rivalry.Robberies.Banks.Blaine.Keypad - PlayerPosition) <= 20.0 then
			RenderMarker(25, Rivalry.Robberies.Banks.Blaine.Keypad.x, Rivalry.Robberies.Banks.Blaine.Keypad.y, Rivalry.Robberies.Banks.Blaine.Keypad.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
			if #(Rivalry.Robberies.Banks.Blaine.Keypad - PlayerPosition) <= 1.0 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to hack vault security lock!")
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("Rivalry.HackVault", 1, 20, "Blaine", 0)
				end
			end
			if #(Rivalry.Robberies.Banks.Blaine.TorchPosition - PlayerPosition) <= 1.0 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to blow torch door lock!")
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("Rivalry.BlowTorch", "Blaine", 0)
				end
			end
		end 
		if #(Rivalry.Robberies.Banks.Pacific.Keypad - PlayerPosition) <= 30.0 then
			RenderMarker(25, Rivalry.Robberies.Banks.Pacific.Keypad.x, Rivalry.Robberies.Banks.Pacific.Keypad.y, Rivalry.Robberies.Banks.Pacific.Keypad.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
			if #(Rivalry.Robberies.Banks.Pacific.Keypad - PlayerPosition) <= 1.0 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to hack vault security lock!")
				if IsControlJustPressed(1, 51) then
					if not Rivalry.Robberies.Banks.Pacific.Locked3 then
						TriggerServerEvent("Rivalry.HackVault", 1, 20, "Pacific", 0)
					else
						Notify("Go back and unlock those first two doors! You will need them open so you can escape right?", 3100)
					end
				end
			end
			if #(Rivalry.Robberies.Banks.Pacific.TorchPosition - PlayerPosition) <= 1.0 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to blow torch door lock!")
				if IsControlJustPressed(1, 51) then
					if exports.core_modules:GetItemQuantity(82) > 0 then
						TriggerServerEvent("Rivalry.BlowTorch", "Pacific", 1, 0)
					else
						Notify("You need a blow torch to break this doors lock open!", 3100)
					end
				end
			end
			if #(Rivalry.Robberies.Banks.Pacific.TorchPosition2 - PlayerPosition) <= 1.0 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to blow torch door lock!")
				if IsControlJustPressed(1, 51) then
					if exports.core_modules:GetItemQuantity(82) > 0 then
						TriggerServerEvent("Rivalry.BlowTorch", "Pacific", 2, 0)
					else
						Notify("You need a blow torch to break this doors lock open!", 3100)
					end
				end
			end
			if #(Rivalry.Robberies.Banks.Pacific.TorchPosition3 - PlayerPosition) <= 1.0 then
				if not Rivalry.Robberies.Banks.Pacific.Locked and not Rivalry.Robberies.Banks.Pacific.Locked3 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to blow torch door lock!")
					if IsControlJustPressed(1, 51) then
						if exports.core_modules:GetItemQuantity(82) > 0 then
							TriggerServerEvent("Rivalry.BlowTorch", "Pacific", 3, 0)
						else
							Notify("You need a blow torch to break this doors lock open!", 3100)
						end
					end
				end
			end
			for Index = 1, #Rivalry.Robberies.Banks.Pacific.Doors do
				if #(Rivalry.Robberies.Banks.Pacific.Doors[Index].Position - PlayerPosition) <= 1.0 then
					if Rivalry.Robberies.Banks.Pacific.Doors[Index].Locked then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to lockpick the door!")
						if IsControlJustPressed(1, 51) then
							if exports.core_modules:GetItemQuantity(36) > 0 then
								OpenLockPickGui2(Index)
							else
								Notify("You need a lockpick to do this!", 3100)
							end
						end
					end
				end
			end
		end
		for Index = 1, #Rivalry.Robberies.Banks.Fleeca do
			if #(Rivalry.Robberies.Banks.Fleeca[Index].Keypad - PlayerPosition) <= 20.0 then
				RenderMarker(25, Rivalry.Robberies.Banks.Fleeca[Index].Keypad.x, Rivalry.Robberies.Banks.Fleeca[Index].Keypad.y, Rivalry.Robberies.Banks.Fleeca[Index].Keypad.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if #(Rivalry.Robberies.Banks.Fleeca[Index].Keypad - PlayerPosition) <= 1.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to hack vault security lock!")
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("Rivalry.HackVault", 1, 20, "Fleeca", Index)
					end
				end
				if #(Rivalry.Robberies.Banks.Pacific.TorchPosition - PlayerPosition) <= 1.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to blow torch door lock!")
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("Rivalry.BlowTorch", "Fleeca", 0, Index)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("Rivalry.Robberies.Sync.Vault")
AddEventHandler("Rivalry.Robberies.Sync.Vault", function(Bank, Index, Status)
	if Bank == "Blaine" then
		Rivalry.Robberies.Banks.Blaine.Locked = Status
	elseif Bank == "Pacific" then
		Rivalry.Robberies.Banks.Pacific.Locked = Status
	elseif Bank == "Fleeca" then
		Rivalry.Robberies.Banks.Fleeca[Index].Locked = Status
	end
end)

RegisterNetEvent("Rivalry.BlowTorch")
AddEventHandler("Rivalry.BlowTorch", function(Bank, Door, BankNumber)
	if Bank == "Blaine" then
		Wait(10000)
		Rivalry.Robberies.Banks.Blaine.Locked2 = false
	elseif Bank == "Pacific" then
		Wait(10000)
		if Door == 1 then
			Rivalry.Robberies.Banks.Pacific.Locked2 = false
		elseif Door == 2 then
			Rivalry.Robberies.Banks.Pacific.Locked3 = false
		else
			Rivalry.Robberies.Banks.Pacific.Locked4 = false
		end
	elseif Bank == "Fleeca" then
		Wait(10000)
		Rivalry.Robberies.Banks.Fleeca[BankNumber].Locked2 = false
	end
end)

RegisterNetEvent("Rivalry.Lockpick")
AddEventHandler("Rivalry.Lockpick", function(Door)
	Rivalry.Robberies.Banks.Pacific.Doors[Door].Locked = false
end)

function OpenLockPickGui2(Door)
	if exports.core_modules:GetItemQuantity(36) > 0 then
		SetPlayerControl(PlayerId(), 0, 0)
		SetNuiFocus(true, true)
		CurrentLockpicked = Door
		SendNUIMessage({pins = exports.core_modules:GetItemQuantity(36), doorlock = true})
		RequestAnimDict("mini@safe_cracking")
		while not HasAnimDictLoaded("mini@safe_cracking") do
			Wait(0)
		end
		TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_clock_fast", 4.0, -4, -1, 1, 0, false, false, false)
	else
		Notify("You do not have any lockpicks!", 2500)
	end
end

RegisterNetEvent("Rivalry.BlowTorch.Animation")
AddEventHandler("Rivalry.BlowTorch.Animation", function()
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
	Wait(10000)
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("Rivalry.CheckBankStatus")
AddEventHandler("Rivalry.CheckBankStatus", function(Bank, BankNumber)
	if Bank == "Blaine" then
		HasBlaineBeenReset = true
		Rivalry.Robberies.Banks.Blaine.Locked = true
		Rivalry.Robberies.Banks.Blaine.Locked2 = true
	elseif Bank == "Fleeca" then
		HasFleecaBeenReset = true
		Rivalry.Robberies.Banks.Fleeca[BankNumber].Locked = true
		Rivalry.Robberies.Banks.Fleeca[BankNumber].Locked2 = true
	elseif Bank == "Pacific" then
		HasPacificBeenReset = true
		Rivalry.Robberies.Banks.Pacific.Locked = true
		Rivalry.Robberies.Banks.Pacific.Locked2 = true
		Rivalry.Robberies.Banks.Pacific.Locked3 = true
		Rivalry.Robberies.Banks.Pacific.Locked4 = true
		for Index = 1, #Rivalry.Robberies.Banks.Pacific.Doors do
			Rivalry.Robberies.Banks.Pacific.Doors[Index].Locked = true
		end
		for Index = 1, #Rivalry.Cameras do
			Rivalry.Cameras[Index].Online = true
		end
	end
end)

RegisterNetEvent("Rivalry.Disable.Pacific.Cameras")
AddEventHandler("Rivalry.Disable.Pacific.Cameras", function()
	Rivalry.Cameras[19].Online = false
	CurrentCamera = 1
end)

RegisterNUICallback('dialsound', function(data, cb)
	TriggerEvent('LIFE_CL:Sound:PlayOnOne', "dial", "1.0")
	cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
	CloseComboLockGui()
	TotalComboLocks = 0
	NumberOfPins = 0
	cb('ok')
end)

RegisterNUICallback('lockpickclose', function(data, cb)
	TotalLocks = exports.core_modules:GetItemQuantity(36)
	TotalLocksAfter = data.lockpicks
	Difference = TotalLocks - TotalLocksAfter
	if Difference > 0 then
		Notify("You don't have any more lockpicks!")
		exports.core_modules:removeQty(36, Difference)
	end
	CloseLockPickGui()
	ClearPedTasks(PlayerPedId())
end)

RegisterNUICallback('lockpickwin', function(data, cb)
	TotalLocks = exports.core_modules:GetItemQuantity(36)
	TotalLocksAfter = data.lockpicks
	Difference = TotalLocks - TotalLocksAfter
	if Difference > 0 then
		exports.core_modules:removeQty(36, Difference)
	end
	CloseLockPickGui()
	ClearPedTasks(PlayerPedId())
	Bank = data.currentbank
	if not IsEntityDead(PlayerPedId()) then
		TriggerServerEvent("Rivalry.Lockbox.Payout", Bank)
		PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	end
end)

RegisterNUICallback('lockpickwin2', function(data, cb)
	TotalLocks = exports.core_modules:GetItemQuantity(36)
	TotalLocksAfter = data.lockpicks
	Difference = TotalLocks - TotalLocksAfter
	if Difference > 0 then
		exports.core_modules:removeQty(36, Difference)
	end
	CloseLockPickGui()
	ClearPedTasks(PlayerPedId())
	if not IsEntitydead(PlayerPedId()) then
		TriggerServerEvent("Rivalry.Lockpick", CurrentLockpicked)
	end
	CurrentLockpicked = 0
end)

RegisterNUICallback('lockclick', function(data, cb)
	if NumberOfPins < 3 then
		NumberOfPins = NumberOfPins + 1
	end
	if NumberOfPins == 3 then
		TriggerEvent('LIFE_CL:Sound:PlayOnOne', "unlock", "1.0")
		SendNUIMessage({newnumber = true, numberone = math.random(1, 40), numbertwo = math.random(1, 40), numberthree = math.random(1, 40)})
		TotalComboLocks = TotalComboLocks + 1
		if TotalComboLocks < 6 then
			TriggerServerEvent('Rivalry.Vault.Payout')
			PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		else
			SendNUIMessage({combolock = false, newnumber = true, numberone = math.random(1, 40), numbertwo = math.random(1, 40), numberthree = math.random(1, 40)})
		end
	end
end)

-- Cameras Script

RegisterNetEvent("Set.Current.Camera")
AddEventHandler("Set.Current.Camera", function(CurrentCam)
	if Rivalry.Cameras[19].Online then
		CurrentCamera = CurrentCam
	else
		if CurrentCam >= 19 then
			Notify("Pacific Standard Camera's are Offline!")
		else
			CurrentCamera = CurrentCam
		end
	end
end)

local CameraActive = false
local CurrentCamera = 1
local CreatedCamera = 0

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
        local Player = PlayerPedId()
        local PlayerPosition = GetEntityCoords(Player, false)
        local PlayerHeading = GetEntityRotation(Player, 2)
        if exports.policejob:getIsInService() then
        	if IsPedOnFoot(Player) then
        		for Computer = 1, #Rivalry.Computers do
        			if #(PlayerPosition - Rivalry.Computers[Computer]) <= 1.0 then
		                if IsControlJustPressed(1, 51) and CreatedCamera == 0 and not IsEntityDead(PlayerPedId()) then
		                    SetFocusArea(Rivalry.Cameras[CurrentCamera].Coords.x, Rivalry.Cameras[CurrentCamera].Coords.y, Rivalry.Cameras[CurrentCamera].Coords.z, Rivalry.Cameras[CurrentCamera].Coords.x, Rivalry.Cameras[CurrentCamera].Coords.y, Rivalry.Cameras[CurrentCamera].Coords.z)
		                    ChangeSecurityCamera(Rivalry.Cameras[CurrentCamera].Coords.x, Rivalry.Cameras[CurrentCamera].Coords.y, Rivalry.Cameras[CurrentCamera].Coords.z, Rivalry.Cameras[CurrentCamera].Heading)
		                    SendNUIMessage({
		                        type = "enablecam",
		                        label = Rivalry.Cameras[CurrentCamera].Label,
		                        box = Rivalry.Cameras[CurrentCamera].Title,
		                    })
		                    FreezeEntityPosition(Player, true)
		                    TriggerEvent('interaction:hud:cameras')
		                end
		            end
	            end
            else
            	VehicleHandle = GetVehiclePedIsIn(Player, false)
            	if GetVehicleClass(VehicleHandle) == 18 then
            		if IsControlJustPressed(1, 217) and CreatedCamera == 0 and not IsEntityDead(PlayerPedId()) then
        				if IsVehicleStopped(VehicleHandle) then
	            			SetFocusArea(Rivalry.Cameras[CurrentCamera].Coords.x, Rivalry.Cameras[CurrentCamera].Coords.y, Rivalry.Cameras[CurrentCamera].Coords.z, Rivalry.Cameras[CurrentCamera].Coords.x, Rivalry.Cameras[CurrentCamera].Coords.y, Rivalry.Cameras[CurrentCamera].Coords.z)
		                    ChangeSecurityCamera(Rivalry.Cameras[CurrentCamera].Coords.x, Rivalry.Cameras[CurrentCamera].Coords.y, Rivalry.Cameras[CurrentCamera].Coords.z, Rivalry.Cameras[CurrentCamera].Heading)
		                    SendNUIMessage({
		                        type = "enablecam",
		                        label = Rivalry.Cameras[CurrentCamera].Label,
		                        box = Rivalry.Cameras[CurrentCamera].Title,
		                    })
		                    FreezeEntityPosition(VehicleHandle, true)
		                    FreezeEntityPosition(Player, true)
		                    DisplayRadar(false)
		                    TriggerEvent('interaction:hud:cameras')
		                else
		                	Notify("You cannot use the cameras while the vehicle is moving!", 3300)
		                end
            		end
            	end
            end
        end

        if CreatedCamera ~= 0 then
            local Instructions = CreateInstuctionScaleform("instructional_buttons")
            DrawScaleformMovieFullscreen(Instructions, 255, 255, 255, 255, 0)
            if CurrentCamera > 18 then
	            if Rivalry.Cameras[19].Online then
	            	SetTimecycleModifier("scanline_cam_cheap")
	            	SetTimecycleModifierStrength(2.0)
	            else
	            	SetTimecycleModifier("CAMERA_secuirity_FUZZ")
	            	SetTimecycleModifierStrength(11.0)
	            end
	        else
	            SetTimecycleModifier("scanline_cam_cheap")
	            SetTimecycleModifierStrength(2.0)
	        end

            -- CLOSE CAMERAS
            if IsControlJustPressed(1, 194) then
                CloseSecurityCamera()
                SendNUIMessage({
                    type = "disablecam",
                })
                TriggerEvent('interaction:hud:cameras')
            end

            -- GO BACK CAMERA
            if IsControlJustPressed(1, 174) and not IsEntityDead(PlayerPedId()) then
                local NewCamIndex

                if CurrentCamera == 1 then
                    NewCamIndex = #Rivalry.Cameras
                else
                    NewCamIndex = CurrentCamera - 1
                end

                SetFocusArea(Rivalry.Cameras[NewCamIndex].Coords.x, Rivalry.Cameras[NewCamIndex].Coords.y, Rivalry.Cameras[NewCamIndex].Coords.z, Rivalry.Cameras[NewCamIndex].Coords.x, Rivalry.Cameras[NewCamIndex].Coords.y, Rivalry.Cameras[NewCamIndex].Coords.z)
                SendNUIMessage({
                    type = "updatecam",
                    label = Rivalry.Cameras[NewCamIndex].Label,
                    box = Rivalry.Cameras[NewCamIndex].Title
                })
                ChangeSecurityCamera(Rivalry.Cameras[NewCamIndex].Coords.x, Rivalry.Cameras[NewCamIndex].Coords.y, Rivalry.Cameras[NewCamIndex].Coords.z, Rivalry.Cameras[NewCamIndex].Heading)
                CurrentCamera = NewCamIndex
            end

            -- GO FORWARD CAMERA
            if IsControlJustPressed(1, 175) and not IsEntityDead(PlayerPedId()) then
                local NewCamIndex
                if CurrentCamera == #Rivalry.Cameras then
                    NewCamIndex = 1
                else
                    NewCamIndex = CurrentCamera + 1
                end

                SetFocusArea(Rivalry.Cameras[NewCamIndex].Coords.x, Rivalry.Cameras[NewCamIndex].Coords.y, Rivalry.Cameras[NewCamIndex].Coords.z, Rivalry.Cameras[NewCamIndex].Coords.x, Rivalry.Cameras[NewCamIndex].Coords.y, Rivalry.Cameras[NewCamIndex].Coords.z)
                SendNUIMessage({
                    type = "updatecam",
                    label = Rivalry.Cameras[NewCamIndex].Label,
                    box = Rivalry.Cameras[NewCamIndex].Title
                })
                ChangeSecurityCamera(Rivalry.Cameras[NewCamIndex].Coords.x, Rivalry.Cameras[NewCamIndex].Coords.y, Rivalry.Cameras[NewCamIndex].Coords.z, Rivalry.Cameras[NewCamIndex].Heading)
                CurrentCamera = NewCamIndex
            end

        ---------------------------------------------------------------------------
        -- CAMERA ROTATION CONTROLS
        ---------------------------------------------------------------------------
            local GetCameraRotation = GetCamRot(CreatedCamera, 2)

            -- ROTATE UP
            if IsControlPressed(1, 32) and not IsEntityDead(PlayerPedId()) then
                if GetCameraRotation.x <= 0.0 then
                    SetCamRot(CreatedCamera, GetCameraRotation.x + 0.7, 0.0, GetCameraRotation.z, 2)
                end
            end

            -- ROTATE DOWN
            if IsControlPressed(1, 33) and not IsEntityDead(PlayerPedId()) then
                if GetCameraRotation.x >= -50.0 then
                    SetCamRot(CreatedCamera, GetCameraRotation.x - 0.7, 0.0, GetCameraRotation.z, 2)
                end
            end

            -- ROTATE LEFT
            if IsControlPressed(1, 34) and not IsEntityDead(PlayerPedId()) then
                SetCamRot(CreatedCamera, GetCameraRotation.x, 0.0, GetCameraRotation.z + 0.7, 2)
            end

            -- ROTATE RIGHT
            if IsControlPressed(1, 35) and not IsEntityDead(PlayerPedId()) then
                SetCamRot(CreatedCamera, GetCameraRotation.x, 0.0, GetCameraRotation.z - 0.7, 2)
            end
        end
    end
end)

---------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------
function ChangeSecurityCamera(x, y, z, r)
    if CreatedCamera ~= 0 then
        DestroyCam(CreatedCamera, 0)
        CreatedCamera = 0
    end

    local Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(Cam, x, y, z)
    SetCamRot(Cam, 0.0, 0.0, r, 2)
    RenderScriptCams(1, 0, 0, 1, 1)
    Citizen.Wait(250)
    CreatedCamera = Cam
end

function CloseSecurityCamera()
    DestroyCam(CreatedCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    CreatedCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    if VehicleHandle ~= nil then
    	FreezeEntityPosition(VehicleHandle, false)
    	DisplayRadar(true)
    	SetVehicleDoorsLocked(VehicleHandle, false)
    end
end

function CreateInstuctionScaleform(Scaleform)
    local Scaleform = RequestScaleformMovie(Scaleform)
    while not HasScaleformMovieLoaded(Scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(Scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(Scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    InstructionButton(GetControlInstructionalButton(1, 175, true))
    InstructionButtonMessage("Go Forward")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage("Close Camera")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    InstructionButton(GetControlInstructionalButton(1, 174, true))
    InstructionButtonMessage("Go Back")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return Scaleform
end

function InstructionButton(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end


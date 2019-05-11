local IsRobbingStoreVault = false
local TotalLocks = 0
local NumberOfPins = 0
local isRobbing = false
local isStillRobbingBlaine = false
local isStillRobbingPacific = false
local isStillRobbingFleeca = false
local isStillRobbingStore = false
local whichFleeca = nil
local whichStore = nil

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

--[[ Store Robberies ]]--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		for StoreNumber = 1, #Rivalry.Robberies.Stores do
			if #(PlayerPosition - Rivalry.Robberies.Stores[StoreNumber].Vault) < 40 then
				for RegisterNumber = 1, #Rivalry.Robberies.Stores[StoreNumber].CashRegisters do
					if #(PlayerPosition - Rivalry.Robberies.Stores[StoreNumber].CashRegisters[RegisterNumber]) < 1 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to break open the cash register!")
						if IsControlJustPressed(1, 51) then
							TriggerServerEvent("Rivalry.Rob.CashRegister", StoreNumber, RegisterNumber, GetPlayerServerId(PlayerId()))
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
		for StoreNumber = 1, #Rivalry.Robberies.Stores do
			if #(PlayerPosition - Rivalry.Robberies.Stores[StoreNumber].Vault) < 1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to start cracking the safe!")
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("Rivalry.Rob.StoreVault", StoreNumber, GetPlayerServerId(PlayerId()))
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
		if #(PlayerPosition - Rivalry.Robberies.Banks.Blaine.LockedBoxes[1]) < 20 then
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
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		for Index = 1, #Rivalry.Robberies.Banks.Pacific.SafeBoxes do
			if #(PlayerPosition - Rivalry.Robberies.Banks.Pacific.SafeBoxes[Index]) < 1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to break open locked box!")
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("Rivalry.Rob.Pacific.SafeBox", Index, GetPlayerServerId(PlayerId()))
				end
			end
		end
	end
end)

RegisterNetEvent("Rivalry.Rob.CashRegister")
AddEventHandler("Rivalry.Rob.CashRegister", function(StoreNumber)
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
			Citizen.Wait(2500)
			TriggerServerEvent("Rivalry.CashRegister.Payout")
			isStillRobbingStore = true
			whichStore = StoreNumber
		end
	end)
end)

RegisterNetEvent("Rivalry.Rob.StoreVault")
AddEventHandler("Rivalry.Rob.StoreVault", function(StoreNumber)
	Citizen.CreateThread(function()
		if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			OpenComboLockGui()
			SendNUIMessage({active = true, newnumber = true, numberone = math.random(1, 40), numbertwo = math.random(1, 40), numberthree = math.random(1, 40)})
			IsRobbingStoreVault = true
			TotalLocks = 0
			NumberOfPins = 0
			isStillRobbingStore = true
			whichStore = StoreNumber
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

RegisterNetEvent("Rivalry.Rob.Pacific.Safebox")
AddEventHandler("Rivalry.Rob.Pacific.Safebox", function(BankNumber)
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
		elseif isStillRobbingStore == true then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(PlayerPosition - Rivalry.Robberies.Stores[whichStore].Vault) > 20 then
				TriggerServerEvent("Rivalry.Robberies.Stopped.Robbing", "Store", whichStore)
				isStillRobbingPacific = false
			end
		end
	end
end)
function OpenLockPickGui()
	if exports.core_modules:GetItemQuantity(36) > 0 then
		SetPlayerControl(PlayerId(), 0, 0)
		SetNuiFocus(true, true)
		SendNUIMessage({lockpick = true, pins = exports.core_modules:GetItemQuantity(36)})
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
	SendNUIMessage({active = true})
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
	SendNUIMessage({active = false})
	SetPlayerControl(PlayerId(), 1, 0)
end

RegisterNetEvent("Rivalry.HackVault")
AddEventHandler("Rivalry.HackVault", function(phase, phase_max, bank, banknumber)
	isRobbing = true
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start", 5, 31, "Starting Hack.. Phase "..phase.." of "..phase_max,function(success)
		if success then
			if phase == phase_max then
				isRobbing = false;
				TriggerEvent("mhacking:hide")
				TriggerServerEvent("Rivalry.Robberies.Sync.Vault", bank, banknumber, false)
			else
				TriggerEvent("Rivalry.HackVault", phase+1, 2, bank, banknumber)
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
		end

		if not DoesEntityExist(Rivalry.Robberies.Banks.Blaine.Handle) then
			Rivalry.Robberies.Banks.Blaine.Handle = GetClosestObjectOfType(Rivalry.Robberies.Banks.Blaine.Vault.x, Rivalry.Robberies.Banks.Blaine.Vault.y, Rivalry.Robberies.Banks.Blaine.Vault.z, 1.0, Rivalry.Robberies.Banks.Blaine.Model, false, false, false)
		end

		if not DoesEntityExist(Rivalry.Robberies.Banks.Pacific.Handle) then
			Rivalry.Robberies.Banks.Pacific.Handle = GetClosestObjectOfType(Rivalry.Robberies.Banks.Pacific.Vault.x, Rivalry.Robberies.Banks.Pacific.Vault.y, Rivalry.Robberies.Banks.Pacific.Vault.z, 1.0, Rivalry.Robberies.Banks.Pacific.Model, false, false, false)
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
		if #(Rivalry.Robberies.Banks.Pacific.Vault - PlayerPosition) <= 10.0 then
			if Rivalry.Robberies.Banks.Pacific.Locked == true then
				if Rivalry.Robberies.Banks.Pacific.Handle ~= nil and Rivalry.Robberies.Banks.Pacific.Handle ~= 0 then
					SetEntityHeading(Rivalry.Robberies.Banks.Pacific.Handle, Rivalry.Robberies.Banks.Pacific.Heading)
				end
			else
				if Rivalry.Robberies.Banks.Pacific.Handle ~= nil and Rivalry.Robberies.Banks.Pacific.Handle ~= 0 then
					SetEntityHeading(Rivalry.Robberies.Banks.Pacific.Handle, Rivalry.Robberies.Banks.Pacific.OpenHeading)
				end
			end
		end
		for Index = 1, #Rivalry.Robberies.Banks.Fleeca do
			if #(Rivalry.Robberies.Banks.Fleeca[Index].Vault - PlayerPosition) <= 10.0 then
				if Rivalry.Robberies.Banks.Fleeca[Index].Locked == true then
					if Rivalry.Robberies.Banks.Fleeca[Index].Handle ~= nil and Rivalry.Robberies.Banks.Fleeca[Index].Handle ~= 0 then
						SetEntityHeading(Rivalry.Robberies.Banks.Fleeca[Index].Handle, Rivalry.Robberies.Banks.Fleeca[Index].Heading)
					end
				end
			else
				if Rivalry.Robberies.Banks.Fleeca[Index].Handle ~= nil and Rivalry.Robberies.Banks.Fleeca[Index].Handle ~= 0 then
					SetEntityHeading(Rivalry.Robberies.Banks.Fleeca[Index].Handle, Rivalry.Robberies.Banks.Fleeca[Index].OpenHeading)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if exports.policejob:getIsInService() then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(Rivalry.Robberies.Banks.Blaine.Keypad - PlayerPosition) <= 10.0 then
					RenderMarker(25, Rivalry.Robberies.Banks.Blaine.Keypad.x, Rivalry.Robberies.Banks.Blaine.Keypad.y, Rivalry.Robberies.Banks.Blaine.Keypad.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if #(Rivalry.Robberies.Banks.Blaine.Keypad - PlayerPosition) <= 1.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to reset vault security lock!")
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("Rivalry.Robberies.Sync.Vault", "Blaine", 0, true)
					end
				end
			end 
			if #(Rivalry.Robberies.Banks.Pacific.Keypad - PlayerPosition) <= 10.0 then
				RenderMarker(25, Rivalry.Robberies.Banks.Pacific.Keypad.x, Rivalry.Robberies.Banks.Pacific.Keypad.y, Rivalry.Robberies.Banks.Pacific.Keypad.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if #(Rivalry.Robberies.Banks.Pacific.Keypad - PlayerPosition) <= 1.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to reset vault security lock!")
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("Rivalry.Robberies.Sync.Vault", "Pacific", 0, true)
					end
				end
			end
			for Index = 1, #Rivalry.Robberies.Banks.Fleeca do
				if #(Rivalry.Robberies.Banks.Fleeca[Index].Keypad - PlayerPosition) <10.0 then
					RenderMarker(25, Rivalry.Robberies.Banks.Fleeca[Index].Keypad.x, Rivalry.Robberies.Banks.Fleeca[Index].Keypad.y, Rivalry.Robberies.Banks.Fleeca[Index].Keypad.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(Rivalry.Robberies.Banks.Fleeca[Index].Keypad - PlayerPosition) <= 1.0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to reset vault security lock!")
						if IsControlJustPressed(1, 51) then
							TriggerServerEvent("Rivalry.Robberies.Sync.Vault", "Fleeca", Index, true)
						end
					end
				end
			end
		else
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(Rivalry.Robberies.Banks.Blaine.Keypad - PlayerPosition) <= 10.0 then
				RenderMarker(25, Rivalry.Robberies.Banks.Blaine.Keypad.x, Rivalry.Robberies.Banks.Blaine.Keypad.y, Rivalry.Robberies.Banks.Blaine.Keypad.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if #(Rivalry.Robberies.Banks.Blaine.Keypad - PlayerPosition) <= 1.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to hack vault security lock!")
					if IsControlJustPressed(1, 51) then
						TriggerEvent("Rivalry.HackVault", 1, 2, "Blaine", 0)
					end
				end
			end 
			if #(Rivalry.Robberies.Banks.Pacific.Keypad - PlayerPosition) <= 10.0 then
				RenderMarker(25, Rivalry.Robberies.Banks.Pacific.Keypad.x, Rivalry.Robberies.Banks.Pacific.Keypad.y, Rivalry.Robberies.Banks.Pacific.Keypad.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if #(Rivalry.Robberies.Banks.Pacific.Keypad - PlayerPosition) <= 1.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to hack vault security lock!")
					if IsControlJustPressed(1, 51) then
						TriggerEvent("Rivalry.HackVault", 1, 2, "Pacific", 0)
					end
				end
			end
			for Index = 1, #Rivalry.Robberies.Banks.Fleeca do
				if #(Rivalry.Robberies.Banks.Fleeca[Index].Keypad - PlayerPosition) <10.0 then
					RenderMarker(25, Rivalry.Robberies.Banks.Fleeca[Index].Keypad.x, Rivalry.Robberies.Banks.Fleeca[Index].Keypad.y, Rivalry.Robberies.Banks.Fleeca[Index].Keypad.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(Rivalry.Robberies.Banks.Fleeca[Index].Keypad - PlayerPosition) <= 1.0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to hack vault security lock!")
						if IsControlJustPressed(1, 51) then
							TriggerEvent("Rivalry.HackVault", 1, 2, "Fleeca", 0)
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("Rivalry.Robberies.Sync.Vault")
AddEventHandler("Rivalry.Robberies.Sync.Vault", function(Bank, Index, Status)
	if Bank == "Blaine" then
		print("Unlocked Blaine")
		Rivalry.Robberies.Banks.Blaine.Locked = Status
	elseif Bank == "Pacific" then
		print("Unlocked Pacific")
		Rivalry.Robberies.Banks.Pacific.Locked = Status
	elseif Bank == "Fleeca" then
		print("Unlocked Fleeca # "..Index)
		Rivalry.Robberies.Banks.Fleeca[Index].Locked = Status
	end
end)

RegisterNUICallback('dialsound', function(data, cb)
	TriggerEvent('LIFE_CL:Sound:PlayOnOne', "dial", "1.0")
	cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
	CloseComboLockGui()
	TriggerServerEvent('Rivalry.Vault.Payout', TotalLocks)
	TotalLocks = 0
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
	TriggerServerEvent('Rivalry.Blaine.Payout')
end)

RegisterNUICallback('lockclick', function(data, cb)
	if NumberOfPins < 3 then
		NumberOfPins = NumberOfPins + 1
		TriggerEvent('LIFE_CL:Sound:PlayOnOne', "unlock", "1.0")
		cb('ok')
	end
	if NumberOfPins == 3 then
		SendNUIMessage({newnumber = true, numberone = math.random(1, 40), numbertwo = math.random(1, 40), numberthree = math.random(1, 40)})
		NumberOfPins = 0
		if TotalLocks < 6 then
			TotalLocks = TotalLocks + 1
		else
			CloseComboLockGui()
			TriggerServerEvent('Rivalry.Vault.Payout', TotalLocks)
			TotalLocks = 0
			NumberOfPins = 0
		end
	end
end)
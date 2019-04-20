local IsRobbingStoreVault = false
local TotalLocks = 0
local NumberOfPins = 0

function DisplayHelpText(Str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(Str or "")
	EndTextCommandDisplayHelp(0, 0, 0, -1)
end

function Notify(Message, Time)
	exports.pNotify:SendNotification({text = Message or "", type = "error", timeout = Time or 3000, layout = "centerRight", queue = "left"})
end

function IsVaultDoorOpened()
	local Object = GetClosestObjectOfType()
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
							TriggerServerEvent("Rivalry.Rob.CashRegister", StoreNumber, RegisterNumber)
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
					TriggerServerEvent("Rivalry.Rob.StoreVault", StoreNumber)
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
							TriggerServerEvent("Rivalry.Rob.Blaine.Safebox", Index)
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
		if not IsVaultDoorOpened() then
			if #(PlayerPosition - Rivalry.Robberies.Banks.Pacific.VaultDoor.Coords) < 2 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to start drilling into the vault!")
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("Rivalry.Rob.Pacific.Vault")
				end
			end
		end
		else
			for Index = 1, #Rivalry.Robberies.BanksPacific.SafeBoxes do
				if #(PlayerPosition - Rivalry.Robberies.Banks.Pacific.SafeBoxes) < 1 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to break open locked box!")
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("Rivalry.Rob.Pacific.SafeBox", Index)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("Rivalry.Rob.CashRegister")
AddEventHandler("Rivalry.Rob.CashRegister", function()
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
		end
	end)
end)

RegisterNetEvent("Rivalry.Rob.StoreVault")
AddEventHandler("Rivalry.Rob.StoreVault", function()
	Citizen.CreateThread(function()
		if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			OpenComboLockGui()
			SendNUIMessage({newnumber = true, numberone = math.random(1, 40), numbertwo = math.random(1, 40), numberthree = math.random(1, 40)})
			IsRobbingStoreVault = true
			TotalLocks = 0
			NumberOfPins = 0
		end
	end)
end)

RegisterNetEvent("Rivalry.Rob.Blaine.Safebox")
AddEventHandler("Rivalry.Rob.Blaine.Safebox", function()
	Citizen.CreateThread(function()
		if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			OpenLockPickGui()
		end
	end)
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
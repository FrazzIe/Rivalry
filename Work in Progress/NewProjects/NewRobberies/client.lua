local IsRobbingStoreVault = false
local TotalLocks = 0
local NumberOfPins = 0

function DisplayHelpText(Str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(Str or "")
	EndTextCommandDisplayHelp(0, 0, 0, -1)
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

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		if #(PlayerPosition - Rivalry.Robberies.Banks.Blaine.LockedBoxes[1]) < 20 then
			for Index = 1, #Rivalry.Robberires.Banks.Blaine.LockedBoxes do
				if #(PlayerPosition - Rivalry.Robberies.Banks.Blaine.LockedBoxes[Index]) < 1 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to lockpick safe box!")
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("Rivalry.Rob.Blaine.Safebox", Index)
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
		if #(PlayerPosition - Rivalry.Robberies.Banks.Pacific.VaultDoor.Coords) < 2 then
			DisplayHelpText("Press ~INPUT_CONTEXT~ to start drilling into the vault!")
			if IsControlJustPressed(1, 51) then
				TriggerServerEvent("Rivalry.Rob.Pacific.Vault")
			end
		end
		if IsVaultDoorOpened() then
			for Index = 1, #Rivalry.Robberies.BanksPacific.SafeBoxes do
				if #(PlayerPosition - Rivalry.Robberies.Banks.Pacific.SafeBoxes) then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to break open locked box!")
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("Rivalry.Rob.Pacific.SafeBox", Index)
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
	end
end)--]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsRobbingStoreVault then
			DisplayHelpText("Press ~INPUT_CONTEXT~ to leave the vault!")
			if IsControlJustPressed(1, 51) then
				CloseComboLockGui()
				TriggerServerEvent("Rivalry.Vault.Payout", TotalLocks)
				IsRobbingStoreVault = false
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
			SendNUIMessage({NewNumber = true, NumberOne = math.random(1, 40), NumberTwo = math.random(1, 40), NumberThree = math.random(1, 40)})
			IsRobbingStoreVault = true
		end
	end)
end)

-- Open Gui and Focus NUI
function OpenComboLockGui()
	SetPlayerControl(PlayerId(), 0, 0)
	SetNuiFocus(true, true)
	SendNUIMessage({active = true})
end

-- Close Gui and disable NUI
function CloseComboLockGui()
	SetNuiFocus(false, false)
	SendNUIMessage({active = false})
	SetPlayerControl(PlayerId(), 1, 0)
end

RegisterNUICallback('DialSoundStart', function(data, cb)
	TriggerEvent('LIFE_CL:Sound:PlayOnOne', "dial", "0.4")
end)

RegisterNUICallback('close', function(data, cb)
	CloseComboLockGui()
end)

RegisterNUICallback('LockClick', function(data, cb)
	if NumberOfPins < 3 then
		NumberOfPins = NumberOfPins + 1
		TriggerEvent('LIFE_CL:Sound:PlayOnOne', "unlock", "0.2")
	end
	if NumberOfPins == 3 then
		SendNUIMessage({NewNumber = true, NumberOne = math.random(1, 40), NumberTwo = math.random(1, 40), NumberThree = math.random(1, 40)})
		NumberOfPins = 0
		if TotalLocks < 6 then
			TotalLocks = TotalLocks + 1
		end
	end
end)
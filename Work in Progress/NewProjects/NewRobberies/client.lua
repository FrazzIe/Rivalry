--[[ Store Robberies ]]--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		for Index = 1, #Rivalry.Robberies.Stores do
			if #(PlayerPosition - Rivalry.Robberies.Stores[Index].Vault) < 40 then
				for Index2 = 1, #Rivalry.Robberies.Stores.CashRegisters do
					if #(PlayerPosition - Rivalry.Robberies.Stores.CashRegisters[Index2]) then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to break open the cash register!")
						if IsControlJustPressed(1, 51) then
							TriggerServerEvent("Rivalry.Rob.CashRegister", Index)
						end
					end
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
		for Index = 1, #Rivalry.Robberies.Stores do
			if #(PlayerPosition - Rivalry.Robberies.Stores[Index].Vault) < 1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to start cracking the safe!")
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("Rivalry.Rob.StoreVault", Index)
				end
			end
		end
	end
end)

--[[ Bank Robberies ]]--

--[[ Blaine County Savings Bank ]]--
Citizen.CreateThread(function()
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

--[[ Fleeca Bank Robberies ]]--
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

--[[ Pacific Standard Bank Robbery ]]--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
	end
end)--]]

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
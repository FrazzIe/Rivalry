Rivalry = {
	Robberies = {
		Stores = {
			[1] = {
				Name = "Little Seoul Convinence Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				},
				LastRobbed = 0
			},
			[2] = {
				Name = "Palomino Freeway Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				},
				LastRobbed = 0
			},
			[3] = {
				Name = "Sandy Shores Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				},
				LastRobbed = 0
			},
			[4] = {
				Name = "Sandy Shores Yellowjack",
				Vault = false,
				CashRegisters = {},
				LastRobbed = 0
			},
			[5] = {
				Name = "Richman Glen Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				},
				LastRobbed = 0
			},
			[6] = {
				Name = "Mount Chiliad Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				},
				LastRobbed = 0
			},
		},
		Banks = {
			Blaine = {
				[1] = {
					Name = "Blaine County Savings",
					LockedBoxes = {
						[1] = false,
						[2] = false,
						[3] = false,
						[4] = false,
						[5] = false,
					},
					LastRobbed = 0
				}
			},
			Fleeca = {
				[1] = {
					Name = "Fleeca Bank | Great Ocean Highway",
					Vault = false,
					LastRobbed = 0
				},
				[2] = {
					Name = "Fleeca Bank | Hawick Avenue",
					Vault = false,
					LastRobbed = 0
				},
				[3] = {
					Name = "Fleeca Bank | Route 68",
					Vault = false,
					LastRobbed = 0
				}
			},
			Pacific = {
				[1] = {
					Name = "Pacific Standard Bank",
					SafeBoxes = {
						[1] = false,
						[2] = false,
						[3] = false,
						[4] = false,
						[5] = false,
						[6] = false,
						[7] = false,
						[8] = false,
						[9] = false,
						[10] = false,
						[11] = false,
						[12] = false,
						[13] = false,
						[14] = false,
						[15] = false,
						[16] = false,
						[17] = false,
						[18] = false,
					},
					LastRobbed = 0
				}
			},
			BeingRobbed = false
		},
		Heists = {
			[1] = {
				Name = "Union Depository",
				Crates = {
					[1] = false,
					[2] = false,
					[3] = false,
					[4] = false,
					[5] = false,
					[6] = false,
					[7] = false,
					[8] = false,
					[9] = false,
					[10] = false,
					[11] = false,
					[12] = false,
					[13] = false,
					[14] = false,
				},
				Money = {
					[1] = false,
					[2] = false,
					[3] = false,
					[4] = false,
					[5] = false,
					[6] = false,
					[7] = false,
				},
				LastRobbed = 0
			}
		}
	}
}

Cooldown = 30

function HasBeenRobbed(TypeOfRobbery, Index)
	if TypeOfRobbery == "Store"
		if (os.time() - Rivalry.Robberies.Stores[Index].LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Stores[Index].LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Stores[Index].LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	elseif TypeOfRobbery == "Blaine"
		if (os.time() - Rivalry.Robberies.Banks.Blaine[Index].LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Blaine[Index].LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Banks.Blaine[Index].LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	elseif TypeOfRobbery == "Fleeca"
		if (os.time() - Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	elseif TypeOfRobbery == "Pacific"
		if (os.time() - Rivalry.Robberies.Banks.Pacific[Index].LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Pacific[Index].LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Banks.Pacific[Index].LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	end
end

RegisterServerEvent("Rivalry.Rob.CashRegister")
AddEventHandler("Rivalry.Rob.CashRegister", function(StoreNumber, RegisterNumber)
	local Source = source
	if Rivalry.Robberies.Stores[StoreNumber].CashRegisters[RegisterNumber] == false and Rivalry.Robberies.Stores[StoreNumber].Vault == false then
		TriggerClientEvent("Rivalry.Rob.CashRegister", Source)
		Rivalry.Robberies.Stores[StoreNumber].CashRegisters[RegisterNumber] = true
	end
end)

RegisterServerEvent("Rivalry.Rob.StoreVault")
AddEventHandler("Rivalry.Rob.StoreVault", function(StoreNumber)
	local Source = source
	if Rivalry.Robberies.Stores[StoreNumber].Vault == false then
		TriggerClientEvent("Rivalry.Rob.StoreVault", Source)
		Rivalry.Robberies.Stores[StoreNumber].Vault = true
	end
end)

RegisterServerEvent("Rivalry.CashRegister.Payout")
AddEventHandler("Rivalry.CashRegister.Payout", function()
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		local RegisterPayOut = math.random(250,500)
		User.addDirty(RegisterPayOut)
	end)
end)

RegisterServerEvent("Rivalry.Vault.Payout")
AddEventHandler("Rivalry.Vault.Payout", function(TotalLocks)
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		local Payout = 0
		if TotalLocks > 0 then
			for Total = 0, TotalLocks do
				Payout = Payout + math.random(350, 500)
			end
		else
		end
		if Payout > 0 then
			User.addDirty(Payout)
		end
	end)
end)
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
				LastRobbed = 0,
				Robber = nil
			},
			[2] = {
				Name = "Palomino Freeway Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				},
				LastRobbed = 0,
				Robber = nil
			},
			[3] = {
				Name = "Sandy Shores Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				},
				LastRobbed = 0,
				Robber = nil
			},
			[4] = {
				Name = "Sandy Shores Yellowjack",
				Vault = false,
				CashRegisters = {},
				LastRobbed = 0,
				Robber = nil
			},
			[5] = {
				Name = "Richman Glen Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				},
				LastRobbed = 0,
				Robber = nil
			},
			[6] = {
				Name = "Mount Chiliad Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				},
				LastRobbed = 0,
				Robber = nil
			},
		},
		Banks = {
			Blaine = {
				Name = "Blaine County Savings",
				LockedBoxes = {
					[1] = false,
					[2] = false,
					[3] = false,
					[4] = false,
					[5] = false,
				},
				LastRobbed = 0,
				Robber = nil
			},
			Fleeca = {
				[1] = {
					Name = "Fleeca Bank | Great Ocean Highway",
					Vault = false,
					LastRobbed = 0,
					Robber = nil
				},
				[2] = {
					Name = "Fleeca Bank | Hawick Avenue",
					Vault = false,
					LastRobbed = 0,
					Robber = nil
				},
				[3] = {
					Name = "Fleeca Bank | Route 68",
					Vault = false,
					LastRobbed = 0,
					Robber = nil
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
					LastRobbed = 0,
					Robber = nil
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
				LastRobbed = 0,
				Robber = nil
			}
		}
	}
}

Cooldown = 30

function HasBeenRobbed(TypeOfRobbery, Index, PlayerID)
	if TypeOfRobbery == "Store" then
		if ( os.time() - Rivalry.Robberies.Stores[Index].LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Stores[Index].LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Stores[Index].LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	elseif TypeOfRobbery == "Blaine" then
		if ( os.time() - Rivalry.Robberies.Banks.Blaine.LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Blaine.LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Banks.Blaine.LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	elseif TypeOfRobbery == "Fleeca" then
		if ( os.time() - Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	elseif TypeOfRobbery == "Pacific" then
		if ( os.time() - Rivalry.Robberies.Banks.Pacific[Index].LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Pacific[Index].LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Banks.Pacific.LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	end
end

RegisterServerEvent("Rivalry.Rob.CashRegister")
AddEventHandler("Rivalry.Rob.CashRegister", function(StoreNumber, RegisterNumber, PlayerID)
	local Source = source
	if not HasBeenRobbed("Store", StoreNumber, PlayerID) or Rivalry.Robberies.Stores[StoreNumber].Robber == PlayerID then
		if Rivalry.Robberies.Stores[StoreNumber].CashRegisters[RegisterNumber] == false then
			TriggerClientEvent("Rivalry.Rob.CashRegister", Source, StoreNumber)
			Rivalry.Robberies.Stores[StoreNumber].CashRegisters[RegisterNumber] = true
			Rivalry.Robberies.Stores[StoreNumber].LastRobbed = os.time()
			Rivalry.Robberies.Stores[StoreNumber].Robber = PlayerID
		end
	end
end)

RegisterServerEvent("Rivalry.Rob.StoreVault")
AddEventHandler("Rivalry.Rob.StoreVault", function(StoreNumber, PlayerID)
	local Source = source
	if not HasBeenRobbed("Store", StoreNumber, PlayerID) or Rivalry.Robberies.Stores[StoreNumber].Robber == PlayerID then
		if Rivalry.Robberies.Stores[StoreNumber].Vault == false then
			TriggerClientEvent("Rivalry.Rob.StoreVault", Source, StoreNumber)
			Rivalry.Robberies.Stores[StoreNumber].Vault = true
			Rivalry.Robberies.Stores[StoreNumber].LastRobbed = os.time()
			Rivalry.Robberies.Stores[StoreNumber].Robber = PlayerID
		end
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

RegisterServerEvent("Rivalry.Blaine.Payout")
AddEventHandler("Rivalry.Blaine.Payout", function()
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		User.addDirty(11)
	end)
end)

RegisterServerEvent("Rivalry.Rob.Blaine.Safebox")
AddEventHandler("Rivalry.Rob.Blaine.Safebox", function(LockBoxNumber, PlayerID)
	local Source = source
	if not HasBeenRobbed("Blaine", 0, PlayerID) or Rivalry.Robberies.Banks.Blaine.Robber == PlayerID then
		if Rivalry.Robberies.Banks.Blaine.LockedBoxes[LockBoxNumber] == false then
			TriggerClientEvent("Rivalry.Rob.Blaine.Safebox", Source)
			Rivalry.Robberies.Banks.Blaine.LockedBoxes[LockBoxNumber] = true
			Rivalry.Robberies.Banks.Blaine.LastRobbed = os.time()
			Rivalry.Robberies.Banks.Blaine.Robber = PlayerID
		end
	end
end)

RegisterServerEvent("Rivalry.Rob.Pacific.SafeBox")
AddEventHandler("Rivalry.Rob.Pacific.SafeBox", function(LockBoxNumber, PlayerID)
	local Source = source
	if not HasBeenRobbed("Pacific", 0, PlayerID) or Rivalry.Robberies.Banks.Pacific.Robber == PlayerID then
		if Rivalry.Robberies.Banks.Pacific.LockedBoxes[LockBoxNumber] == false then
			TriggerClientEvent("Rivalry.Rob.Pacific.Safebox", Source)
			Rivalry.Robberies.Banks.Pacific.LockedBoxes[LockBoxNumber] = true
			Rivalry.Robberies.Banks.Pacific.LastRobbed = os.time()
			Rivalry.Robberies.Banks.Pacific.Robber = PlayerID
		end
	end
end)

RegisterServerEvent("Rivalry.Robberies.Stopped.Robbing")
AddEventHandler("Rivalry.Robberies.Stopped.Robbing", function(Type, Number)
	if Type == "Blaine" then
		Rivalry.Robberies.Banks.Blaine.Robber = nil
	elseif Type == "Pacific" then
		Rivalry.Robberies.Banks.Pacific.Robber = nil
	elseif Type == "Fleeca" then
		Rivalry.Robberies.Banks.Fleeca[Number].Robber = nil
	elseif Type == "Store" then
		Rivalry.Robberies.Stores[Number].Robber = nil
	end
end)

RegisterServerEvent("Rivalry.Robberies.Sync.Vault")
AddEventHandler("Rivalry.Robberies.Sync.Vault", function(Bank, BankNumber, Status)
	TriggerClientEvent("Rivalry.Robberies.Sync.Vault", -1, Bank, BankNumber, Status)
end)
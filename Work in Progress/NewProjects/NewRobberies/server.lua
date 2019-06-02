Rivalry = {
	Robberies = {
		Stores = {
			[1] = {
				Name = "Little Seoul Convinence Store",
				Vault = 0,
				CashRegisters = {
					[1] = 0,
					[2] = 0,
				},
				LastRobbed = 0,
				Robber = nil
			},
			[2] = {
				Name = "Palomino Freeway Convience Store",
				Vault = 0,
				CashRegisters = {
					[1] = 0,
					[2] = 0,
				},
				LastRobbed = 0,
				Robber = nil
			},
			[3] = {
				Name = "Sandy Shores Convience Store",
				Vault = 0,
				CashRegisters = {
					[1] = 0,
					[2] = 0,
				},
				LastRobbed = 0,
				Robber = nil
			},
			[4] = {
				Name = "Sandy Shores Yellowjack",
				Vault = 0,
				CashRegisters = {},
				LastRobbed = 0,
				Robber = nil
			},
			[5] = {
				Name = "Richman Glen Convience Store",
				Vault = 0,
				CashRegisters = {
					[1] = 0,
					[2] = 0,
				},
				LastRobbed = 0,
				Robber = nil
			},
			[6] = {
				Name = "Mount Chiliad Convience Store",
				Vault = 0,
				CashRegisters = {
					[1] = 0,
					[2] = 0,
				},
				LastRobbed = 0,
				Robber = nil
			},
		},
		Banks = {
			SoftCooldown = 0,
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
				Robber = nil,
				VaultOpened = false,
				DoorOpened = false
			},
			Fleeca = {
				[1] = {
					Name = "Fleeca Bank | Great Ocean Highway",
					LockedBoxes = {
						
					},
					Vault = false,
					LastRobbed = 0,
					Robber = nil,
					VaultOpened = false,
					DoorOpened = false
				},
				[2] = {
					Name = "Fleeca Bank | Hawick Avenue",
					LockedBoxes = {
						
					},
					Vault = false,
					LastRobbed = 0,
					Robber = nil,
					VaultOpened = false,
					DoorOpened = false
				},
				[3] = {
					Name = "Fleeca Bank | Route 68",
					LockedBoxes = {
						
					},
					Vault = false,
					LastRobbed = 0,
					Robber = nil,
					VaultOpened = false,
					DoorOpened = false
				}
			},
			Pacific = {
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
				Robber = nil,
				VaultOpened = false,
				DoorOpened = false,
				DoorOpened2 = false
			},
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

function HasSoftCooldownEnded(Source)
	if ( os.time() - Rivalry.Robberies.Banks.SoftCooldown) < (Cooldown * 60) and Rivalry.Robberies.Banks.SoftCooldown ~= 0 then
		TriggerClientEvent('customNotification', Source, "All the banks are on lockdown for " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Banks.SoftCooldown))/60)) .. " minutes.")
		return false
	else
		return true
	end
end

function HasBeenRobbed(TypeOfRobbery, Index, Source)
	if TypeOfRobbery == "Blaine" then
		if ( os.time() - Rivalry.Robberies.Banks.Blaine.LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Blaine.LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', Source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Banks.Blaine.LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	elseif TypeOfRobbery == "Fleeca" then
		if ( os.time() - Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', Source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	elseif TypeOfRobbery == "Pacific" then
		if ( os.time() - Rivalry.Robberies.Banks.Pacific.LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Pacific.LastRobbed ~= 0 then
			TriggerClientEvent('customNotification', Source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Banks.Pacific.LastRobbed))/60)) .. " minutes.")
			return true
		else
			return false
		end
	end
end

RegisterServerEvent("Rivalry.Rob.CashRegister")
AddEventHandler("Rivalry.Rob.CashRegister", function(StoreNumber, RegisterNumber, PlayerID)
	local Source = source
	if ( os.time() - Rivalry.Robberies.Stores[StoreNumber].CashRegisters[RegisterNumber] ) > (Cooldown*60) then
		TriggerClientEvent("Rivalry.Rob.CashRegister", Source, StoreNumber, RegisterNumber)
		Rivalry.Robberies.Stores[StoreNumber].CashRegisters[RegisterNumber] = os.time()
	else
		TriggerClientEvent('customNotification', Source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Stores[StoreNumber].CashRegisters[RegisterNumber]))/60)) .. " minutes.")
	end
end)

RegisterServerEvent("Rivalry.Rob.StoreVault")
AddEventHandler("Rivalry.Rob.StoreVault", function(StoreNumber, PlayerID)
	local Source = source
	if ( os.time() - Rivalry.Robberies.Stores[StoreNumber].Vault ) > (Cooldown*60) then
		TriggerClientEvent("Rivalry.Rob.StoreVault", Source, StoreNumber)
		Rivalry.Robberies.Stores[StoreNumber].Vault = os.time()
	else
		TriggerClientEvent('customNotification', Source, "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Rivalry.Robberies.Stores[StoreNumber].Vault))/60)) .. " minutes.")
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

RegisterServerEvent("Rivalry.Lockbox.Payout")
AddEventHandler("Rivalry.Lockbox.Payout", function(Bank)
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		User.addDirty(Bank.Payout)
	end)
end)

RegisterServerEvent("Rivalry.Rob.Blaine.Safebox")
AddEventHandler("Rivalry.Rob.Blaine.Safebox", function(LockBoxNumber, PlayerID)
	local Source = source
	if not ( HasBeenRobbed("Blaine", 0, PlayerID) or Rivalry.Robberies.Banks.Blaine.Robber == PlayerID ) and Rivalry.Robberies.Banks.Blaine.VaultOpened and Rivalry.Robberies.Banks.Blaine.DoorOpened then
		if Rivalry.Robberies.Banks.Blaine.LockedBoxes[LockBoxNumber] == false then
			TriggerClientEvent("Rivalry.Rob.Blaine.Safebox", Source)
			Rivalry.Robberies.Banks.Blaine.LockedBoxes[LockBoxNumber] = true
		end
	end
end)

RegisterServerEvent("Rivalry.Rob.Pacific.SafeBox")
AddEventHandler("Rivalry.Rob.Pacific.SafeBox", function(LockBoxNumber, PlayerID)
	local Source = source
	if not ( HasBeenRobbed("Pacific", 0, PlayerID) or Rivalry.Robberies.Banks.Pacific.Robber == PlayerID ) and Rivalry.Robberies.Banks.Pacific.VaultOpened and Rivalry.Robberies.Banks.Pacific.DoorOpened and Rivalry.Robberies.Banks.Pacific.DoorOpened2 then
		if Rivalry.Robberies.Banks.Pacific.LockedBoxes[LockBoxNumber] == false then
			TriggerClientEvent("Rivalry.Rob.Pacific.Safebox", Source)
			Rivalry.Robberies.Banks.Pacific.LockedBoxes[LockBoxNumber] = true
		end
	end
end)

RegisterServerEvent("Rivalry.Rob.Fleeca.Safebox")
AddEventHandler("Rivalry.Rob.Fleeca.Safebox", function(BankNumber, LockBoxNumber, PlayerID)
	local Source = source
	if not ( HasBeenRobbed("Fleeca", BankNumber, PlayerID) or Rivalry.Robberies.Banks.Fleeca[BankNumber].Robber == PlayerID ) and Rivalry.Robberies.Banks.Fleeca[BankNumber].VaultOpened and Rivalry.Robberies.Banks.Fleeca[BankNumber].DoorOpened then
		if Rivalry.Robberies.Banks.Fleeca[BankNumber].LockedBoxes[LockBoxNumber] == false then
			TriggerClientEvent("Rivalry.Rob.Fleeca.Safebox", Source, BankNumber)
			Rivalry.Robberies.Banks.Fleeca[BankNumber].LockedBoxes[LockBoxNumber] = true
		end
	end
end)

RegisterServerEvent("Rivalry.Robberies.Stopped.Robbing")
AddEventHandler("Rivalry.Robberies.Stopped.Robbing", function(Type, BankNumber)
	if Type == "Blaine" then
		Rivalry.Robberies.Banks.Blaine.Robber = nil
	elseif Type == "Pacific" then
		Rivalry.Robberies.Banks.Pacific.Robber = nil
	elseif Type == "Fleeca" then
		Rivalry.Robberies.Banks.Fleeca[BankNumber].Robber = nil
	end
end)

RegisterServerEvent("Rivalry.Robberies.Sync.Vault")
AddEventHandler("Rivalry.Robberies.Sync.Vault", function(Bank, BankNumber, Status)
	TriggerClientEvent("Rivalry.Robberies.Sync.Vault", -1, Bank, BankNumber, Status)
end)

RegisterServerEvent("Rivalry.HackVault")
AddEventHandler("Rivalry.HackVault", function(Level, MaxLevel, Bank, BankNumber)
	local Source = source
	if not HasBeenRobbed(Bank, BankNumber) and HasSoftCooldownEnded(Source) then
		if Bank == "Fleeca" then
			Rivalry.Robberies.Banks.Fleeca[BankNumber].LastRobbed = os.time()
			Rivalry.Robberies.Banks.Fleeca[BankNumber].Robber = Source
			TriggerClientEvent("Rivalry.HackVault", Source, Level, MaxLevel, Bank, BankNumber)
			TriggerEvent("dispatch:ten-ninety-bank", Rivalry.Robberies.Banks.Fleeca[BankNumber].Name)
			TriggerClientEvent('customNotification', Source, "You have just tripped an antitampering system! Better be quick!")
		elseif Bank == "Blaine" then
			Rivalry.Robberies.Banks.Blaine.LastRobbed = os.time()
			Rivalry.Robberies.Banks.Blaine.Robber = Source
			TriggerClientEvent("Rivalry.HackVault", Source, Level, MaxLevel, Bank, BankNumber)
			TriggerEvent("dispatch:ten-ninety-bank", Rivalry.Robberies.Banks.Blaine.Name)
			TriggerClientEvent('customNotification', Source, "You have just tripped an antitampering system! Better be quick!")
		elseif Bank == "Pacific" then
			Rivalry.Robberies.Banks.Pacific.LastRobbed = os.time()
			Rivalry.Robberies.Banks.Pacific.Robber = Source
			TriggerClientEvent("Rivalry.HackVault", Source, Level, MaxLevel, Bank, BankNumber)
			TriggerEvent("dispatch:ten-ninety-bank", Rivalry.Robberies.Banks.Pacific.Name)
			TriggerClientEvent('customNotification', Source, "You have just tripped an antitampering system! Better be quick!")
		end
	end
end)

RegisterServerEvent("Rivalry.BlowTorch")
AddEventHandler("Rivalry.BlowTorch", function(Bank, Door, BankNumber)
	local Source = source
	if Bank == "Blaine" then
		if not HasBeenRobbed(Bank, BankNumber) and HasSoftCooldownEnded(Source) then
			TriggerClientEvent("Rivalry.BlowTorch", -1, Bank, Door, BankNumber)
			TriggerClientEvent("Rivalry.BlowTorch.Animation", Source)
		end
	elseif Bank == "Pacific" then
		if not HasBeenRobbed(Bank, BankNumber) and HasSoftCooldownEnded(Source) then
			TriggerClientEvent("Rivalry.BlowTorch", -1, Bank, Door, BankNumber)
			TriggerClientEvent("Rivalry.BlowTorch.Animation", Source)
		end
	elseif Bank == "Fleeca" then
		if not HasBeenRobbed(Bank, BankNumber) and HasSoftCooldownEnded(Source) then
			TriggerClientEvent("Rivalry.BlowTorch", -1, Bank, Door, BankNumber)
			TriggerClientEvent("Rivalry.BlowTorch.Animation", Source)
		end
	end
end)
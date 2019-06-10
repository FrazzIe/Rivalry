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
			BlainePayout = {min = 9800, max = 10200},
			PacificPayout = {min = 12800, max = 13200},
			FleecaPayout = {min = 9800, max = 10200},
			Blaine = {
				Name = "Blaine County Savings",
				LockedBoxes = {
					[1] = false,
					[2] = false,
					[3] = false,
					[4] = false,
					[5] = false,
					[6] = false,
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
						[1] = false,
						[2] = false,
						[3] = false,
						[4] = false,
						[5] = false,
						[6] = false,
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
						[1] = false,
						[2] = false,
						[3] = false,
						[4] = false,
						[5] = false,
						[6] = false,
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
						[1] = false,
						[2] = false,
						[3] = false,
						[4] = false,
						[5] = false,
						[6] = false,
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
				LockedBoxes = {
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

function HasBeenRobbed2(TypeOfRobbery, Index)
	if TypeOfRobbery == "Blaine" then
		if ( os.time() - Rivalry.Robberies.Banks.Blaine.LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Blaine.LastRobbed ~= 0 then
			return true
		else
			return false
		end
	elseif TypeOfRobbery == "Fleeca" then
		if ( os.time() - Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Fleeca[Index].LastRobbed ~= 0 then
			return true
		else
			return false
		end
	elseif TypeOfRobbery == "Pacific" then
		if ( os.time() - Rivalry.Robberies.Banks.Pacific.LastRobbed) < (Cooldown*60) and Rivalry.Robberies.Banks.Pacific.LastRobbed ~= 0 then
			return true
		else
			return false
		end
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

function CheckCops()
	TriggerEvent("police:getCops", function(cops)
		if tonumber(cops) then
			if cops > 4 then
				return true
			else
				return false
			end
		end
	end)
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
		local RegisterPayOut = math.random(150,250)
		User.addDirty(RegisterPayOut)
	end)
end)

RegisterServerEvent("Rivalry.Vault.Payout")
AddEventHandler("Rivalry.Vault.Payout", function()
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		Payout = math.random(400, 500)
		User.addDirty(Payout)
	end)
end)

RegisterServerEvent("Rivalry.Lockbox.Payout")
AddEventHandler("Rivalry.Lockbox.Payout", function(Bank)
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		if Bank == "Blaine" then
			local Pay = math.random(Rivalry.Robberies.Banks.BlainePayout.min, Rivalry.Robberies.Banks.BlainePayout.max)
			User.addDirty(Pay)
		elseif Bank == "Pacific" then
			local Pay = math.random(Rivalry.Robberies.Banks.PacificPayout.min, Rivalry.Robberies.Banks.PacificPayout.max)
			User.addDirty(Pay)
		elseif Bank == "Fleeca" then
			local Pay = math.random(Rivalry.Robberies.Banks.FleecaPayout.min, Rivalry.Robberies.Banks.FleecaPayout.max)
			User.addDirty(Pay)
		end
	end)
end)

RegisterServerEvent("Rivalry.Rob.Blaine.Safebox")
AddEventHandler("Rivalry.Rob.Blaine.Safebox", function(LockBoxNumber, PlayerID)
	local Source = source
	if ( Rivalry.Robberies.Banks.Blaine.Robber == PlayerID ) then
		if Rivalry.Robberies.Banks.Blaine.LockedBoxes[LockBoxNumber] == false then
			TriggerClientEvent("Rivalry.Rob.Blaine.Safebox", Source)
			Rivalry.Robberies.Banks.Blaine.LockedBoxes[LockBoxNumber] = true
		end
	end
end)

RegisterServerEvent("Rivalry.Rob.Pacific.Safebox")
AddEventHandler("Rivalry.Rob.Pacific.Safebox", function(LockBoxNumber, PlayerID)
	local Source = source
	if ( Rivalry.Robberies.Banks.Pacific.Robber == PlayerID ) then
		if Rivalry.Robberies.Banks.Pacific.LockedBoxes[LockBoxNumber] == false then
			TriggerClientEvent("Rivalry.Rob.Pacific.Safebox", Source)
			Rivalry.Robberies.Banks.Pacific.LockedBoxes[LockBoxNumber] = true
		end
	end
end)

RegisterServerEvent("Rivalry.Rob.Fleeca.Safebox")
AddEventHandler("Rivalry.Rob.Fleeca.Safebox", function(BankNumber, LockBoxNumber, PlayerID)
	local Source = source
	if ( Rivalry.Robberies.Banks.Fleeca[BankNumber].Robber == PlayerID ) then
		if Rivalry.Robberies.Banks.Fleeca[BankNumber].LockedBoxes[LockBoxNumber] == false then
			TriggerClientEvent("Rivalry.Rob.Fleeca.Safebox", Source, BankNumber)
			Rivalry.Robberies.Banks.Fleeca[BankNumber].LockedBoxes[LockBoxNumber] = true
		end
	end
end)

RegisterServerEvent("Rivalry.Robberies.Stopped.Robbing")
AddEventHandler("Rivalry.Robberies.Stopped.Robbing", function(Bank, BankNumber)
	if Bank == "Blaine" then
		Rivalry.Robberies.Banks.Blaine.Robber = nil
	elseif Bank == "Pacific" then
		Rivalry.Robberies.Banks.Pacific.Robber = nil
	elseif Bank == "Fleeca" then
		Rivalry.Robberies.Banks.Fleeca[BankNumber].Robber = nil
	end
end)

RegisterServerEvent("Rivalry.Robberies.Sync.Vault")
AddEventHandler("Rivalry.Robberies.Sync.Vault", function(Bank, BankNumber, Status)
	TriggerClientEvent("Rivalry.Robberies.Sync.Vault", -1, Bank, BankNumber, Status)
end)

RegisterServerEvent("Rivalry.HackVault")
AddEventHandler("Rivalry.HackVault", function(Level, MaxLevel, Bank, BankNumber, PlayerID)
	local Source = source
	if not HasBeenRobbed(Bank, BankNumber, Source) and HasSoftCooldownEnded(Source) and CheckCops() then
		if Bank == "Fleeca" then
			TriggerClientEvent("Rivalry.SetRobbing", Source, "Fleeca", BankNumber)
			TriggerClientEvent("Rivalry.HackVault", Source, Level, MaxLevel, Bank, BankNumber)
			TriggerEvent("dispatch:ten-ninety-bank", Rivalry.Robberies.Banks.Fleeca[BankNumber].Name)
			Rivalry.Robberies.Banks.SoftCooldown = os.time()
			TriggerClientEvent('customNotification', Source, "You have just tripped an antitampering system! Better be quick!")
			Rivalry.Robberies.Banks.Fleeca[BankNumber].LastRobbed = os.time()
			Rivalry.Robberies.Banks.Fleeca[BankNumber].Robber = PlayerID
		elseif Bank == "Blaine" then
			TriggerClientEvent("Rivalry.SetRobbing", Source, "Blaine", 0)
			Rivalry.Robberies.Banks.Blaine.LastRobbed = os.time()
			Rivalry.Robberies.Banks.Blaine.Robber = PlayerID
			TriggerClientEvent("Rivalry.HackVault", Source, Level, MaxLevel, Bank, BankNumber)
			TriggerEvent("dispatch:ten-ninety-bank", Rivalry.Robberies.Banks.Blaine.Name)
			Rivalry.Robberies.Banks.SoftCooldown = os.time()
			TriggerClientEvent('customNotification', Source, "You have just tripped an antitampering system! Better be quick!")
		elseif Bank == "Pacific" then
			TriggerClientEvent("Rivalry.SetRobbing", Source, "Pacific", 0)
			Rivalry.Robberies.Banks.Pacific.LastRobbed = os.time()
			Rivalry.Robberies.Banks.Pacific.Robber = PlayerID
			TriggerClientEvent("Rivalry.HackVault", Source, Level, MaxLevel, Bank, BankNumber)
			TriggerEvent("dispatch:ten-ninety-bank", Rivalry.Robberies.Banks.Pacific.Name)
			Rivalry.Robberies.Banks.SoftCooldown = os.time()
			TriggerClientEvent('customNotification', Source, "You have just tripped an antitampering system! Better be quick!")
		end
	end
end)

RegisterServerEvent("Rivalry.BlowTorch")
AddEventHandler("Rivalry.BlowTorch", function(Bank, Door, BankNumber, PlayerID)
	local Source = source
	if Bank == "Blaine" then
		if ( Rivalry.Robberies.Banks.Blaine.Robber == PlayerID or not HasBeenRobbed(Bank, BankNumber, PlayerID) ) then
			if Rivalry.Robberies.Banks.Blaine.Robber == PlayerID then
				TriggerClientEvent("Rivalry.BlowTorch", -1, Bank, Door, BankNumber)
				TriggerClientEvent("Rivalry.BlowTorch.Animation", Source)
			elseif HasSoftCooldownEnded(Source) then
				TriggerClientEvent("Rivalry.BlowTorch", -1, Bank, Door, BankNumber)
				TriggerClientEvent("Rivalry.BlowTorch.Animation", Source)
			end
		end
	elseif Bank == "Pacific" then
		if ( Rivalry.Robberies.Banks.Pacific.Robber == PlayerID or not HasBeenRobbed(Bank, BankNumber, PlayerID) ) then
			if Rivalry.Robberies.Banks.Pacific.Robber == PlayerID then
				TriggerClientEvent("Rivalry.BlowTorch", -1, Bank, Door, BankNumber)
				TriggerClientEvent("Rivalry.BlowTorch.Animation", Source)
			elseif HasSoftCooldownEnded(Source) then
				TriggerClientEvent("Rivalry.BlowTorch", -1, Bank, Door, BankNumber)
				TriggerClientEvent("Rivalry.BlowTorch.Animation", Source)
			end
		end
	elseif Bank == "Fleeca" then
		if ( Rivalry.Robberies.Banks.Fleeca[BankNumber].Robber == PlayerID or not HasBeenRobbed(Bank, BankNumber, PlayerID) ) then
			if Rivalry.Robberies.Banks.Fleeca[BankNumber].Robber == PlayerID then
				TriggerClientEvent("Rivalry.BlowTorch", -1, Bank, Door, BankNumber)
				TriggerClientEvent("Rivalry.BlowTorch.Animation", Source)
			elseif HasSoftCooldownEnded(Source) then
				TriggerClientEvent("Rivalry.BlowTorch", -1, Bank, Door, BankNumber)
				TriggerClientEvent("Rivalry.BlowTorch.Animation", Source)
			end
		end
	end
end)

RegisterServerEvent("Rivalry.Lockpick")
AddEventHandler("Rivalry.Lockpick", function(Door)
	local Source = source
	TriggerClientEvent("Rivalry.Lockpick", -1, Door)
end)

RegisterServerEvent("Rivalry.CheckBankStatus")
AddEventHandler("Rivalry.CheckBankStatus", function(Bank, BankNumber)
	local Source = source
	if not Bank == "Blaine" then
		if not HasBeenRobbed2(Bank, BankNumber) then
			TriggerClientEvent("Rivalry.CheckBankStatus", -1, Bank, BankNumber)
			Rivalry.Robberies.Banks.Blaine.Robber = nil
			Rivalry.Robberies.Banks.Blaine.VaultOpened = false
			Rivalry.Robberies.Banks.Blaine.DoorOpened = false
			for Index = 1, #Rivalry.Robberies.Banks.Blaine.LockedBoxes do
				Rivalry.Robberies.Banks.Blaine.LockedBoxes[Index] = false
			end
		end
	elseif not Bank == "Fleeca" then
		if not HasBeenRobbed2(Bank, BankNumber) then
			TriggerClientEvent("Rivalry.CheckBankStatus", -1, Bank, BankNumber)
			Rivalry.Robberies.Banks.Fleeca[BankNumber].Robber = nil
			Rivalry.Robberies.Banks.Fleeca[BankNumber] = false
			Rivalry.Robberies.Banks.Fleeca[BankNumber] = false
			for Index = 1, #Rivalry.Robberies.Banks.Fleeca[BankNumber].LockedBoxes do
				Rivalry.Robberies.Banks.Fleeca[BankNumber].LockedBoxes[Index] = false
			end
		end
	elseif Bank == "Pacific" then
		if not HasBeenRobbed2(Bank, BankNumber) then
			TriggerClientEvent("Rivalry.CheckBankStatus", -1, Bank, BankNumber)
			Rivalry.Robberies.Banks.Pacific.Robber = nil
			Rivalry.Robberies.Banks.Pacific.VaultOpened = false
			Rivalry.Robberies.Banks.Pacific.DoorOpened = false
			Rivalry.Robberies.Banks.Pacific.DoorOpened2 = false
			for Index = 1, #Rivalry.Robberies.Banks.Pacific.LockedBoxes do
				Rivalry.Robberies.Banks.Pacific.LockedBoxes[Index] = false
			end
		end
	end
end)

RegisterServerEvent("Rivalry.Disable.Pacific.Cameras")
AddEventHandler("Rivalry.Disable.Pacific.Cameras", function()
	local Source = source
	TriggerClientEvent('customNotification', Source, "You have just tripped an antitampering system! Better be quick!")
	TriggerClientEvent("Rivalry.Disable.Pacific.Cameras", -1)
end)

RegisterServerEvent("Rivalry.EnableCameras")
AddEventHandler("Rivalry.EnableCameras", function()
	local Source = source
	if Rivalry.Robberies.Banks.Pacific.Robber == nil then
		TriggerClientEvent('customNotification', Source, "You have successfully reset the camera system for Pacific Standard Bank.")
		TriggerClientEvent("Rivalry.EnableCameras", -1)
	else
		TriggerClientEvent('customNotification', Source, "You cannot reset the camera system yet as there is an active robbery in progress!")
	end
end)

Rivalry = {
	Robberies = {
		Stores = {
			[1] = {
				Name = "Little Seoul Convinence Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				}
			},
			[2] = {
				Name = "Palomino Freeway Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				}
			},
			[3] = {
				Name = "Sandy Shores Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				}
			},
			[4] = {
				Name = "Sandy Shores Yellowjack",
				Vault = false,
				CashRegisters = {}
			},
			[5] = {
				Name = "Richman Glen Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				}
			},
			[6] = {
				Name = "Mount Chiliad Convience Store",
				Vault = false,
				CashRegisters = {
					[1] = false,
					[2] = false,
				}
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
					}
				}
			},
			Fleeca = {
				[1] = {
					Name = "Fleeca Bank | Great Ocean Highway",
					Vault = false,
				},
				[2] = {
					Name = "Fleeca Bank | Hawick Avenue",
					Vault = false,
				},
				[3] = {
					Name = "Fleeca Bank | Route 68",
					Vault = false,
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
					}
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
				}
			}
		}
	}
}

local SafePayOut = math.random(2000,3000)

RegisterServerEvent("Rivalry.Rob.CashRegister")
AddEventHandler("Rivalry.Rob.CashRegister", function(Index)
	local Source = source
	for Index2 = 1, #Rivalry.Robberies.Stores[Index].CashRegisters do
		if Rivalry.Robberies.Stores[Index].CashRegisters[Index2] == false then
			TriggerClientEvent("Rivalry.Rob.CashRegister", Source)
			Rivalry.Robberies.Stores[Index].CashRegisters[Index2] = true
		end
	end
end

RegisterServerEvent("Rivalry.Rob.StoreVault")
AddEventHandler("Rivalry.Rob.StoreVault", function(Index)
	local Source = source
	if Rivalry.Robberies.Stores[Index].Vault == false then
		TriggerClientEvent("Rivalry.Rob.StoreVault", Source)
		Rivalry.Robberies.Stores[Index].Vault = true
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
local isBusy = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        isBusy = exports.policejob:getIsCuffed() or exports["core_modules"]:isCuffed() or exports["core_modules"]:IsInJail() or exports["core_modules"]:GetIsCarriedOrInTrunk()
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if ("kgv-blackjack" == resourceName) then
		Citizen.Wait(1000)
		exports["kgv-blackjack"]:SetSatDownCallback(function()
			exports["core_modules"]:StanceAllowed(false)
			exports["core_modules"]:TurnOffHudElements(true)
			exports["core_modules"]:DisableInteractionMenu(true)
		end)
		
		exports["kgv-blackjack"]:SetStandUpCallback(function()
			exports["core_modules"]:StanceAllowed(true)
			exports["core_modules"]:TurnOffHudElements(false)
			exports["core_modules"]:DisableInteractionMenu(false)
		end)
		
		exports["kgv-blackjack"]:SetLeaveCheckCallback(function()
			if isBusy then
				return true
			else
				return false
			end
		end)
		
		exports["kgv-blackjack"]:SetCanSitDownCallback(function()
			if isBusy then
				return false
			else
				return true
			end
		end)
	end
end)

local traderCoords = {
	--{ vector3(1406.3347167969, 1158.9976806641, 114.33351898193), 3.2992217540741 }, -- Ranch
	{ vector3(-2091.2634277344, -1016.3739624023, 8.9711818695068), 249.34878540039 }, -- Yacht
	{ vector3(-773.58599853516, 322.48684692383, 211.99694824219), 351.65280151367}, -- My House
}

local traderLabel = { "CHIPS_MENU_P", "Press ~INPUT_CONTEXT~ to speak to the Cashier." }

Citizen.CreateThread(function()
	AddTextEntry(traderLabel[1], traderLabel[2])
	
	local traderModel = `u_f_m_casinocash_01`

	RequestModel(traderModel)

	while not HasModelLoaded(traderModel) do
		Citizen.Wait(150)
	end

	for i = 1, #traderCoords do
		local trader = CreatePed(4, traderModel, traderCoords[i][1].x, traderCoords[i][1].y, traderCoords[i][1].z, traderCoords[i][2], false, true)

		SetEntityCanBeDamaged(trader, false)
		SetBlockingOfNonTemporaryEvents(trader, true)
		SetPedCanRagdollFromPlayerImpact(trader, false)
		
		SetPedResetFlag(trader, 249, true)
		SetPedConfigFlag(trader, 185, true)
		SetPedConfigFlag(trader, 108, true)
		SetPedConfigFlag(trader, 208, true)		
	end

	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local playerPosition = GetEntityCoords(playerPed, false)

		for i = 1, #traderCoords do
			local dist = #(playerPosition - traderCoords[i][1])
			
			if dist < 5 then
				if dist < 1.5 then
					BeginTextCommandDisplayHelp("STRING")
					AddTextComponentSubstringTextLabel(traderLabel[1])
					EndTextCommandDisplayHelp(0, 0, 1, -1)

					if IsControlJustPressed(1, 51) then
						JayMenu.OpenMenu("blackjack_trader")
					end
				elseif dist > 3.0 then
					if JayMenu.IsMenuOpened("blackjack_trader") then
						JayMenu.CloseMenu()
					end
				end
			end
		end
	end

end)

Citizen.CreateThread(function()
	JayMenu.CreateMenu("blackjack_trader", "")
	JayMenu.SetSubTitle("blackjack_trader", "CASHIER SERVICES")
	JayMenu.UseSpriteAsBackground("blackjack_trader", "shopui_title_casino", "shopui_title_casino", 255, 255, 255, 255, false)

	local chips = { 50, 100, 500, 1000, 1500, 2000, 5000, 10000, 20000, 50000, 100000 }
	local chipIdx = 1
	local chipIdx2 = 1
	local chipIdx3 = 1
	local chipIdx4 = 1
	while true do
		Citizen.Wait(0)

		if JayMenu.IsMenuOpened("blackjack_trader") then
			if JayMenu.ComboBox("Aquire Chips", chips, chipIdx, chipIdx2, function(currentIndex, selectedIndex)
				chipIdx, chipIdx2 = currentIndex, selectedIndex
			end) then
				TriggerServerEvent("chipTrader:Aquire", chips[chipIdx2])
			end
			if JayMenu.ComboBox("Trade In Chips", chips, chipIdx3, chipIdx4, function(currentIndex, selectedIndex)
				chipIdx3, chipIdx4 = currentIndex, selectedIndex
			end) then
				TriggerServerEvent("chipTrader:Trade", chips[chipIdx4])
			end
			JayMenu.Display()
		end
	end
end)
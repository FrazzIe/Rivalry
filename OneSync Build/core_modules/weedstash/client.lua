local OpenMenu = false
local IsOpened = false
local Inventory = {}
local StashID = nil
DrugWhitelist = {}
DrugWhitelist.IsDealer = false
Teleporters = {
    Inside = vector4(1066.3852539063,-3183.421875,-39.163722991943,90.758277893066),
    Outside = vector4(184.54653930664,-1513.7951660156,29.141626358032,43.084125518799),
}
PackingStation = vector4(1032.9704589844,-3205.4916992188,-38.180351257324,270.69873046875)
Stashes = {
	[1] = vector3(1041.3369140625,-3194.1374511719,-38.165397644043),
}

function DisplayHelpText(Str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(Str or "")
	EndTextCommandDisplayHelp(0, 0, 0, -1)
end

function Notify(Message, Time)
	exports.pNotify:SendNotification({text = Message or "", type = "error", timeout = Time or 3000, layout = "centerRight", queue = "left"})
end

RegisterNetEvent("DrugStash.Sync")
AddEventHandler("DrugStash.Sync", function()
	IsOpened = true
end)

RegisterNetEvent("Open.DrugStash")
AddEventHandler("Open.DrugStash", function(Inv)
	Inventory = Inv
	OpenMenu = true
end)

RegisterNetEvent("Close.DrugStash")
AddEventHandler("Close.DrugStash", function()
	IsOpened = false
end)

RegisterNetEvent("DrugDealer:Set")
AddEventHandler("DrugDealer:Set", function(_Data, _DrugWhitelist, first)
	DrugWhitelist.IsDealer = _DrugWhitelist

	if not DrugWhitelist.IsDealer then
		DrugWhitelist.Gang = nil
	else
		if _Data ~= nil then
			if _Data.gang ~= nil then
				DrugWhitelist.Gang = _Data.gang
			end
		end
	end
end)

RegisterNetEvent("Police.Search.DrugStash")
AddEventHandler("Police.Search.DrugStash", function(DrugStash)
	TriggerEvent('chatMessage', "Drug DrugStash:", {255, 0, 0}, DrugStash.quantity.." Weed Bricks!")
end)

-- Open DrugStash Thread
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if DrugWhitelist.IsDealer or exports.policejob:getIsInService() then
            local Player = PlayerPedId()
            local PlayerPosition = GetEntityCoords(Player, false)
			for Index = 1, #Stashes do
				if #(PlayerPosition - Stashes[Index]) <= 1.1 then
					if exports.policejob:getIsInService() then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to search the DrugStash!")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to open DrugStash!")
					end
					if IsControlJustPressed(1, 51) then
						if exports.policejob:getIsInService() then
							TriggerServerEvent("Police.Search.DrugStash", Index)
						else
							if not IsOpened then
								TriggerServerEvent("Open.DrugStash", Index)
								StashID = Index
							else
								Notify("One person at a time please! For now...", 3100)
							end
						end
					end
				end
            end
        end
    end
end)

-- Teleporter Thread
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if DrugWhitelist.IsDealer or exports.policejob:getIsInService() then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(PlayerPosition - vector3(Teleporters.Outside.x, Teleporters.Outside.y, Teleporters.Outside.z)) <= 1.1 then
				if IsControlJustPressed(1, 51) then
					TeleportPlayer(Teleporters.Inside.x, Teleporters.Inside.y, Teleporters.Inside.z, Teleporters.Inside.w)
				end
			end
			if #(PlayerPosition - vector3(Teleporters.Inside.x, Teleporters.Inside.y, Teleporters.Inside.z)) <= 1.1 then
				if IsControlJustPressed(1, 51) then
					TeleportPlayer(Teleporters.Outside.x, Teleporters.Outside.y, Teleporters.Outside.z, Teleporters.Outside.w)
				end
			end
		end
	end
end)

-- DrugStash Thread
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		RequestAnimDict("anim@amb@business@coc@coc_unpack_cut@")
		while not HasAnimDictLoaded("anim@amb@business@coc@coc_unpack_cut@") do
			Citizen.Wait(0)
		end
		if DrugWhitelist.IsDealer then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(PlayerPosition - vector3(PackingStation.x, PackingStation.y, PackingStation.z)) <= 1.1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to pack weed!")
				if IsControlJustPressed(1, 51) then
					if GetItemQuantity(4) == 100 then
						SetEntityCoords(Player, PackingStation.x, PackingStation.y, PackingStation.z - 1.0)
						SetEntityHeading(Player, PackingStation.w)
						TaskPlayAnim(Player, "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_cokepacker", 5.0, -1, -1, 10, 0, false, false, false)
						exports['mythic_progbar']:Progress({
							name = "weed_action",
							duration = 43000,
							label = "Packing Weed",
							useWhileDead = true,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							}
						}, function(status)
							if not status then
								if GetItemQuantity(4) >= 100 then
									removeQty(4, 100)
									addQty(140, 1)
									Notify("You packed 1 weed brick!")
								else
									Notify("You are missing "..100-GetItemQuantity(4).." Cannabis! Packing requires 100!")
								end
							end
						end)
					else
						Notify("You are missing "..100-GetItemQuantity(4).." Cannabis! Packing requires 100!")
					end
				end
			end
			if OpenMenu then
				if not WarMenu.IsMenuOpened("DrugStash") then
					if not WarMenu.DoesMenuExist("DrugStash") then
						WarMenu.CreateMenu("DrugStash", "DrugStash")
						WarMenu.SetSpriteTitle("DrugStash", "shopui_title_gr_gunmod")
						WarMenu.SetSubTitle("DrugStash", "CATEGORIES")
						WarMenu.SetMenuX("DrugStash", 0.6)
						WarMenu.SetMenuY("DrugStash", 0.15)
						WarMenu.SetTitleBackgroundColor("DrugStash", 0, 107, 87)
						WarMenu.CreateSubMenu("DrugStash_Deposit", "DrugStash", "DEPOSIT SECTION")
						WarMenu.CreateSubMenu("DrugStash_Withdraw", "DrugStash", "WITHDRAW SECTION")
						WarMenu.OpenMenu("DrugStash")
					else
						currentItemIndex = 1
						WarMenu.OpenMenu("DrugStash")
					end
				else
					WarMenu.CloseMenu()
				end
				OpenMenu = false
			end
			if WarMenu.IsMenuOpened("DrugStash") then
				if WarMenu.Button("Deposit") then
					WarMenu.OpenMenu("DrugStash_Deposit")
				end
				if WarMenu.Button("Withdraw") then
					WarMenu.OpenMenu("DrugStash_Withdraw")
				end
				if WarMenu.Button("Close") then
					WarMenu.CloseMenu()
					StashID = nil
					TriggerServerEvent("Close.DrugStash")
				end
				if IsControlJustPressed(1, 177) then
					WarMenu.CloseMenu()
					StashID = nil
					TriggerServerEvent("Close.DrugStash")
				end
				WarMenu.Display()
			end
			if WarMenu.IsMenuOpened("DrugStash_Deposit") then
				for k, v in pairs(user_inventory) do
					if WarMenu.Button("["..v.quantity.."x] "..v.name, "Deposit") then
						if v.item_id == 140 then
							if v.quantity <= 1 then	
								TriggerServerEvent("DrugStash.Deposit", 1, 1)
							else
								local PromptedQuantity = tonumber(KeyboardInput("How much:", "1", 4))
								if PromptedQuantity > 0 and PromptedQuantity ~= nil and v.quantity >= PromptedQuantity then
									TriggerServerEvent("DrugStash.Deposit", PromptedQuantity, 1)
								end
							end
							WarMenu.CloseMenu()
							TriggerServerEvent("Close.DrugStash")
						else
							Notify("This storage only can hold weed bricks!")
						end
					end
				end
				WarMenu.Display()
			end
			if WarMenu.IsMenuOpened("DrugStash_Withdraw") then
				for k, v in pairs(Inventory) do
					if WarMenu.Button("["..v.quantity.."] ".." Weed Bricks") then
						if v.quantity > 0 then
							local WithdrawlAmount = tonumber(KeyboardInput("How much:", "1", 4))
							if WithdrawlAmount > 0 and WithdrawlAmount <= v.quantity then
								TriggerServerEvent("DrugStash.Withdraw", WithdrawlAmount, 1)
								WarMenu.CloseMenu()
								TriggerServerEvent("Close.DrugStash")
							end
						else
							Notify("There is no weed bricks stored right now!")
						end
					end
				end
				WarMenu.Display()
			end
		end
	end
end)

RegisterNetEvent("DrugStash.Withdraw")
AddEventHandler("DrugStash.Withdraw", function(Quantity)
	if DrugWhitelist.IsDealer then
		addQty(140, Quantity)
		Notify("You recieved "..Quantity.."weed brick(s)")
	end
end)
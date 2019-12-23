--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local onlinePlayers, disconnectedPlayers = {}, {}


local leaderboard_selected = {}

RegisterNetEvent("scoreboard:recieveUserInformation")
AddEventHandler("scoreboard:recieveUserInformation", function(_p, _dp)
	onlinePlayers = _p
	disconnectedPlayers = _dp
end)

local pressedz = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if pressedz == true then
			TriggerServerEvent('scoreboard:notify', pressedz)
			Citizen.Wait(10000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 20) then
			if not isCarshopOpen and not isCarRentalOpen and not isBoatRentalOpen and not isBikeRentalOpen then
				if not WarMenu.IsMenuOpened("Scoreboard") then
					local players = {}
					for _, player in ipairs(GetActivePlayers()) do
						table.insert(players, {id = GetPlayerServerId(player), name = GetPlayerName(player), steam = "Not found", license = "Not found", ip = "Not found"})
					end
					TriggerServerEvent("scoreboard:getUserInformation", players)

					if not WarMenu.DoesMenuExist("Scoreboard") then
						WarMenu.CreateMenu("Scoreboard", "Player list")
						WarMenu.SetTitleBackgroundColor("Scoreboard", 0, 128, 255, 255)
						--WarMenu.SetScaleformTitle("Scoreboard", "mp_menu_glare")
						WarMenu.SetScaleformTitleColour("Scoreboard", 0, 128, 255, 255)
						WarMenu.SetSubTitle("Scoreboard", "PLAYERS")
						WarMenu.SetMenuMaxOptionCountOnScreen("Scoreboard", 16)
						WarMenu.CreateSubMenu("player_info", "Scoreboard", "Player Info")
						WarMenu.CreateSubMenu("disconnected", "Scoreboard", "Disconnected Players")
						WarMenu.CreateSubMenu("player_info_disconnected", "disconnected", "Player Info")
						WarMenu.OpenMenu("Scoreboard")
					else
						WarMenu.OpenMenu("Scoreboard")
					end
				else
					WarMenu.CloseMenu("Scoreboard")
				end
			end
		end
		if WarMenu.IsMenuOpened("Scoreboard") then
			pressedz = true
			for k,v in pairs(onlinePlayers) do
				if WarMenu.MenuButton("["..v.id.."] "..v.steam, "player_info") then
					leaderboard_selected = v
				end
			end
			WarMenu.MenuButton("Recently Disconnected","disconnected")
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened("player_info") then
			pressedz = true
			WarMenu.Button(leaderboard_selected.name, leaderboard_selected.id)
			WarMenu.Button(leaderboard_selected.steam)
			if isAdmin then
				WarMenu.Button(leaderboard_selected.license)
				WarMenu.Button(leaderboard_selected.ip)
			end
			if WarMenu.Button("Report") then
				local report = tostring(KeyboardInput("What did "..leaderboard_selected.name.." do?", "I am reporting "..leaderboard_selected.name.." for", 1000))
				if report ~= nil and report ~= "nil" and report ~= "" then
					Notify("Report submitted!", 3000)
					TriggerServerEvent("scoreboard:report", report, leaderboard_selected)
				end
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened("disconnected") then
			pressedz = true
			for k,v in pairs(disconnectedPlayers) do
				if WarMenu.MenuButton("["..v.id.."] "..v.steam, "player_info_disconnected") then
					leaderboard_selected = v
				end
			end
			WarMenu.Display()			
		elseif WarMenu.IsMenuOpened("player_info_disconnected") then
			pressedz = true
			WarMenu.Button(leaderboard_selected.name, leaderboard_selected.id)
			WarMenu.Button(leaderboard_selected.steam)
			if isAdmin then
				WarMenu.Button(leaderboard_selected.license)
				WarMenu.Button(leaderboard_selected.ip)
			end
			if WarMenu.Button("Report") then
				local report = tostring(KeyboardInput("What did "..leaderboard_selected.name.." do?", "I am reporting "..leaderboard_selected.name.." for", 1000))
				if report ~= nil and report ~= "nil" and report ~= "" then
					Notify("Report submitted!", 3000)
					TriggerServerEvent("scoreboard:report", report, leaderboard_selected)
				end
			end
			WarMenu.Display()
		else
			pressedz = false
		end
	end
end)

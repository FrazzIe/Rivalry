--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
-- Settings
local guiEnabled = false
local hasOpened = false
local warrants = {}
local arrests = {}
local violations = {}

-- Open Gui and Focus NUI
function openGui()
	SetPlayerControl(PlayerId(), 0, 0)
	guiEnabled = true
	SetNuiFocus(true, true)
	SendNUIMessage({active = true})
	if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
		TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, false);
	end

	-- If this is the first time we've opened the phone, load all warrants
	if hasOpened == false then
		TriggerServerEvent('police:load-warrants', false)
		TriggerServerEvent('police:load-arrests', false)
		hasOpened = true
	end
end

-- Close Gui and disable NUI
function closeGui()
	SetNuiFocus(false, false)
	SendNUIMessage({active = false})
	guiEnabled = false
	ClearPedTasks(GetPlayerPed(-1))
	Wait(250)
	SetPlayerControl(PlayerId(), 1, 0)
end

local function canDelete(rank)
	if rank == "chief of police" or rank == "colonel" or rank == "deputy chief of police" or rank == "lieutenant colonel" or rank == "captain" or rank == "director" or rank == "lieutenant" or rank == "trooper sergeant" or rank == "sergeant" or rank == "trooper" or rank == "detective" or rank == "officer ii" then
		return true
	else
		return false
	end
end

-- Disable controls while GUI open
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if guiEnabled then
			if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
				SendNUIMessage({type = "click"})
			end
		end
	end
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
	closeGui()
end)

RegisterNetEvent('customNotification')
AddEventHandler('customNotification', function(msg)
	TriggerEvent("pNotify:SendNotification", { theme = "gta2", text = "".. msg .. "", layout = "centerRight", type = "info", timeout = 6000, animation = {open = "gta_effects_open", close = "gta_effects_close"} } )
end)
--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
 __          __     _____  _____            _   _ _______ _____    _____ ______ _____ _______ _____ ____  _   _ 
 \ \        / /\   |  __ \|  __ \     /\   | \ | |__   __/ ____|  / ____|  ____/ ____|__   __|_   _/ __ \| \ | | --Callbacks
  \ \  /\  / /  \  | |__) | |__) |   /  \  |  \| |  | | | (___   | (___ | |__ | |       | |    | || |  | |  \| |
   \ \/  \/ / /\ \ |  _  /|  _  /   / /\ \ | . ` |  | |  \___ \   \___ \|  __|| |       | |    | || |  | | . ` | --Events
	\  /\  / ____ \| | \ \| | \ \  / ____ \| |\  |  | |  ____) |  ____) | |___| |____   | |   _| || |__| | |\  |
	 \/  \/_/    \_\_|  \_\_|  \_\/_/    \_\_| \_|  |_| |_____/  |_____/|______\_____|  |_|  |_____\____/|_| \_| --Functions
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]
-- Warrants Callbacks
RegisterNUICallback('loadWarrants', function(data, cb)
  if (#warrants == 0) then
	TriggerServerEvent('police:load-warrants', true)
  else
	SendNUIMessage({openSection = "warrants", list = warrants})
  end
  cb('ok')
end)

RegisterNUICallback('warrantRead', function(data, cb)
	SendNUIMessage({openSection = "warrantRead", id = data.id, officer_name = data.officer_name, offender_name = data.offender_name, location = data.location, notes = data.notes})
end)

RegisterNUICallback('warrantDelete', function(data, cb)
	if canDelete(user_cop.rank) then
		TriggerServerEvent('police:remove-warrant', data.id)
	else
		TriggerEvent("customNotification", "You do not have permission to do this!")
	end
end)

RegisterNUICallback('newWarrant', function(data, cb)
  SendNUIMessage({openSection = "newWarrant", location = getLocation()})
end)

RegisterNUICallback('newWarrantSubmit', function(data, cb)
	data.notes = data.notes or ''
	if(data.offender_name ~= nil and data.location ~= nil) then
		TriggerServerEvent('police:new-warrant', data.offender_name, data.location, data.notes)
	else
		TriggerEvent("customNotification", "You must fill in a name and last known location!")
	end	
end)

--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]

RegisterNetEvent('police:load-warrants')
AddEventHandler('police:load-warrants', function(data, openUI)
  openUI = openUI or false
  warrants = data
  if openUI then
	SendNUIMessage({openSection = "warrants", list = warrants})
  end
end)

RegisterNetEvent('police:new-warrant')
AddEventHandler('police:new-warrant', function(entry)
	table.insert(warrants, entry[1])
	SendNUIMessage({newWarrant = true, warrant = entry[1]})
	if isInService then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "New warrant has been posted")
	end
end)

RegisterNetEvent('police:remove-warrant')
AddEventHandler('police:remove-warrant', function(id)
	for k,v in pairs(warrants) do
		if v.id == tonumber(id) then
			table.remove(warrants, k)
		end
	end
end)
--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]

function getLocation()
  local pos = GetEntityCoords(GetPlayerPed(-1),  true)
  local street = table.pack(GetStreetNameAtCoord(pos.x, pos.y, pos.z))
  local loc = string.format("%s", GetStreetNameFromHashKey(street[1]))

  if street[2] ~= 0 and street[2] ~= nil then
	loc = string.format("%s, nearby %s", GetStreetNameFromHashKey(street[1]), GetStreetNameFromHashKey(street[2]))
  end

  return loc
end
--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
		   _____  _____  ______  _____ _______    _____ ______ _____ _______ _____ ____  _   _ 
	 /\   |  __ \|  __ \|  ____|/ ____|__   __|  / ____|  ____/ ____|__   __|_   _/ __ \| \ | | --Callbacks
	/  \  | |__) | |__) | |__  | (___    | |    | (___ | |__ | |       | |    | || |  | |  \| |
   / /\ \ |  _  /|  _  /|  __|  \___ \   | |     \___ \|  __|| |       | |    | || |  | | . ` | --Events
  / ____ \| | \ \| | \ \| |____ ____) |  | |     ____) | |___| |____   | |   _| || |__| | |\  |
 /_/    \_\_|  \_\_|  \_\______|_____/   |_|    |_____/|______\_____|  |_|  |_____\____/|_| \_| --Functions
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]

RegisterNUICallback('loadArrests', function(data, cb)
	if (#arrests == 0) then
		TriggerServerEvent('police:load-arrests', true)
	else
		SendNUIMessage({openSection = "arrests", list = arrests})
	end
end)

RegisterNUICallback('viewArrest', function(data, cb)
	SendNUIMessage({openSection = "viewArrest", id = data.id, timestamp = data.timestamp, officer_name = data.officer_name, offender_name = data.offender_name, sentenceORfine = data.sentenceORfine, sentence = data.sentence, charges = data.charges, fine = data.fine})
end)

RegisterNUICallback('removeArrest', function(data, cb)
	if canDelete(user_cop.rank) then
		TriggerServerEvent('police:remove-arrest', data.id)
	else
		TriggerEvent("customNotification", "You do not have permission to do this!")
	end
end)

RegisterNUICallback('newArrest', function(data, cb)
	SendNUIMessage({openSection = "newArrest"})
end)

RegisterNUICallback('newArrestSubmit', function(data, cb)
	data.sentence = data.sentence or 0
	data.fine = data.fine or 0
	if(data.officer_name ~= nil and data.offender_name ~= nil and data.sentenceORfine ~= nil and data.charges ~= nil and data.sentence ~= nil and data.fine ~= nil)then
		TriggerServerEvent('police:new-arrest', data.officer_name, data.offender_name, data.sentenceORfine, data.sentence, data.fine, data.charges, currentSuspect.identifier)
	else
		TriggerEvent("customNotification", "You must fill everything in!")
	end
end)

RegisterNUICallback('autofillArrest', function(data, cb)
	local autofill = AutoFill()
	SendNUIMessage({openSection = "autofill_arrests", charges = autofill.charges, fine = autofill.cost, officer_name = currentOfficer, offender_name = currentSuspect.name, jail = autofill.time})
end)
--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]

RegisterNetEvent('police:load-arrests')
AddEventHandler('police:load-arrests', function(data, openUI)
  openUI = openUI or false
  arrests = data
  if openUI then
	SendNUIMessage({openSection = "arrests", list = arrests})
  end
end)

RegisterNetEvent('police:new-arrest')
AddEventHandler('police:new-arrest', function(entry)
	table.insert(arrests, entry[1])
	SendNUIMessage({openSection = "addNewArrest", new_arrest = entry[1]})
	if isInService then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "New Arrest Entry")
	end
end)

RegisterNetEvent('police:remove-arrest')
AddEventHandler('police:remove-arrest', function(id)
	for k,v in pairs(arrests) do
		if v.id == tonumber(id) then
			table.remove(arrests, k)
		end
	end
end)

--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]

function AutoFill()
  local charges = {}
  local time = 0
  local cost = 0
  for key, val in pairs(currentSuspectCharges) do            
	  charges[#charges+1] = (" [" .. currentSuspectCharges[key].count .. "x] " .. key .. "")
	  time = time + currentSuspectCharges[key].time
	  cost = cost + currentSuspectCharges[key].cost
  end
  return {charges = table.concat(charges), time = time, cost = cost}
end
--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
 __      _______ ____  _            _______ _____ ____  _   _  _____    _____ ______ _____ _______ _____ ____  _   _ 
 \ \    / /_   _/ __ \| |        /\|__   __|_   _/ __ \| \ | |/ ____|  / ____|  ____/ ____|__   __|_   _/ __ \| \ | | --Callbacks
  \ \  / /  | || |  | | |       /  \  | |    | || |  | |  \| | (___   | (___ | |__ | |       | |    | || |  | |  \| |
   \ \/ /   | || |  | | |      / /\ \ | |    | || |  | | . ` |\___ \   \___ \|  __|| |       | |    | || |  | | . ` | --Events
    \  /   _| || |__| | |____ / ____ \| |   _| || |__| | |\  |____) |  ____) | |___| |____   | |   _| || |__| | |\  |
     \/   |_____\____/|______/_/    \_\_|  |_____\____/|_| \_|_____/  |_____/|______\_____|  |_|  |_____\____/|_| \_| --Functions
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]
RegisterNUICallback('loadViolations', function(data, cb)
	if (#violations == 0) then
		TriggerServerEvent('police:load-violations', true)
	else
		SendNUIMessage({openSection = "violations", list = violations})
	end
end)

RegisterNUICallback('viewViolation', function(data, cb)
	SendNUIMessage({openSection = "viewViolation", id = data.id, timestamp = data.timestamp, officer_name = data.officer_name, offender_name = data.offender_name, violations = data.violations, fine = data.fine})
end)

RegisterNUICallback('removeViolation', function(data, cb)
	if canDelete(user_cop.rank) then
		TriggerServerEvent('police:remove-violation', data.id)
	else
		TriggerEvent("customNotification", "You do not have permission to do this!")
	end
end)

RegisterNUICallback('newViolation', function(data, cb)
	SendNUIMessage({openSection = "newViolation"})
end)

RegisterNUICallback('newViolationSubmit', function(data, cb)
	data.fine = data.fine or 0
	if(data.officer_name ~= nil and data.offender_name ~= nil and data.violations ~= nil and data.fine ~= nil)then
		TriggerServerEvent('police:new-violation', data.officer_name, data.offender_name, data.violations, data.fine, currentSuspect.identifier)
	else
		TriggerEvent("customNotification", "You must fill everything in!")
	end
end)

RegisterNUICallback('autofillViolation', function(data, cb)
	local autofill = AutoFill()
	SendNUIMessage({openSection = "autofill_violations", violations = autofill.charges, fine = autofill.cost, officer_name = currentOfficer, offender_name = currentSuspect.name})
end)

--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]
RegisterNetEvent('police:load-violations')
AddEventHandler('police:load-violations', function(data, openUI)
  openUI = openUI or false
  violations = data
  if openUI then
	SendNUIMessage({openSection = "violations", list = violations})
  end
end)

RegisterNetEvent('police:new-violation')
AddEventHandler('police:new-violation', function(entry)
	table.insert(violations, entry[1])
	SendNUIMessage({openSection = "addNewViolation", new_violation = entry[1]})
	if isInService then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "New traffic violation")
	end
end)

RegisterNetEvent('police:remove-violation')
AddEventHandler('police:remove-violation', function(id)
	for k,v in pairs(violations) do
		if v.id == tonumber(id) then
			table.remove(violations, k)
		end
	end
end)
--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]
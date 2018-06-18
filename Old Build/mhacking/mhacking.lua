mhackingCallback = {};
showHelp = false
helpTimer = 0

helpCycle = 4000

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if showHelp then
			if helpTimer > GetGameTimer() then
				showHelpText("Navigate with ~y~W,A,S,D~s~ and confirm with ~y~SPACE~s~ for the left code block.")
			elseif helpTimer > GetGameTimer()-helpCycle then
				showHelpText("Use the ~y~Arrow Keys~s~ and ~y~ENTER~s~ for the right code block")
			else
				helpTimer = GetGameTimer()+helpCycle
			end
		end
	end
end)

local function openPhone()
  if IsPlayerDead(PlayerId()) then
    return
  end
  local dict = "cellphone@"
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    dict = dict .. "in_car@ds"
  end

  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Citizen.Wait(100)
  end

  SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
  TaskPlayAnim(GetPlayerPed(-1), dict, "cellphone_text_in", 4.0, -1, -1, 50, 0, false, false, false)
end

local function closePhone()
  if IsPlayerDead(PlayerId()) then
    return
  end

  local dict = "cellphone@"
  if IsPedInAnyVehicle(PlayerPedId(), false) then
    dict = dict .. "in_car@ds"
  end

  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Citizen.Wait(100)
  end

  SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
  TaskPlayAnim(PlayerPedId(), dict, "cellphone_text_out", 4.0, -1, -1, 50, 0, false, false, false)
  Citizen.Wait(700)
  StopAnimTask(PlayerPedId(), dict, "cellphone_text_out", 1.0)
end

function showHelpText(s)
	SetTextComponentFormat("STRING")
	AddTextComponentString(s)
	EndTextCommandDisplayHelp(0,0,0,-1)
end

AddEventHandler('mhacking:show', function()
  nuiMsg = {}
	nuiMsg.show = true
	SendNUIMessage(nuiMsg)
	SetNuiFocus(true, false)
end)

AddEventHandler('mhacking:hide', function()
  nuiMsg = {}
	nuiMsg.show = false
	SendNUIMessage(nuiMsg)
	SetNuiFocus(false, false)
	showHelp = false
end)

AddEventHandler('mhacking:start', function(solutionlength, duration, message, callback)
  mhackingCallback = callback
	nuiMsg = {}
	nuiMsg.s = solutionlength
	nuiMsg.d = duration
  if message then
    nuiMsg.m = message
  end
	nuiMsg.start = true
	SendNUIMessage(nuiMsg)
	showHelp = true
	openPhone()
end)

AddEventHandler('mhacking:fail', function()
  nuiMsg = {}
  nuiMsg.fail = true
  SendNUIMessage(nuiMsg)
  SetNuiFocus(false, false)
  showHelp = false
end)

RegisterNUICallback('callback', function(data, cb)
	closePhone()
	mhackingCallback(data.success)
  cb('ok')
end)

RegisterNUICallback("cancel", function(data, cb)
  TriggerEvent("mhacking:fail")
  cb('ok')
end)
--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local isDead = false
local isKO = false
local spawnlocation = {x = 352.54373168945, y = -599.32861328125, z = 43.284065246582, h = 69.074485778809}
DecorRegister("isDead", 2)
DecorSetBool(GetPlayerPed(-1), "isDead", false) 

secondsRemaining = -1

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local cpos = GetEntityCoords(PlayerPedId(), true)
		local ppos

		isDead = IsEntityDead(playerPed)
	
		if isKO and ppos ~= cpos then
			isKO = false
		end

		if (GetEntityHealth(PlayerPedId()) < 120 and not isDead and not isKO) then
			if IsPedInMeleeCombat(PlayerPedId()) then
				SetPlayerKO(PlayerPedId())
			end
		end

		ppos = cpos
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsEntityDead(PlayerPedId())then
			timer = true
			DecorSetBool(PlayerPedId(), "isDead", true) 
			while IsEntityDead(PlayerPedId()) do
				if timer then
					timer = false
					secondsRemaining = 300
				end
				Citizen.Wait(0)
			end
			DecorSetBool(PlayerPedId(), "isDead", false)
			secondsRemaining = -1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if(secondsRemaining > 0)then
			secondsRemaining = secondsRemaining - 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if secondsRemaining > 0 then
			drawRespawnTxt("~g~"..secondsRemaining.."~w~ seconds until you can respawn!",6,1.0,0.5,0.75,0.6,255,255,255,255)
			drawRespawnTxt("~w~ Use your phone (F2) for Life Alert or /911 to call for help!",6,1.0,0.5,0.78,0.6,255,255,255,255)
		elseif secondsRemaining == 0 then
			drawRespawnTxt("You can respawn using your phone",6,1.0,0.5,0.75,0.6,255,255,255,255)
		end
	end
end)

AddEventHandler('baseevents:onPlayerDied', function(playerId, reasonID)
	TriggerEvent("paramedic:coma")
	SendNotification("You've been severely injured and need medical assistance")
end)

AddEventHandler('baseevents:onPlayerKilled', function(playerId, playerKill, reasonID)
	TriggerEvent("paramedic:coma")
	
	SendNotification("You've been severely injured and need medical assistance")
end)

RegisterNetEvent('paramedic:respawnCheck')
AddEventHandler('paramedic:respawnCheck', function()
	TriggerServerEvent('paramedic:respawn_rip', secondsRemaining)
end)

RegisterNetEvent('paramedic:respawn')
AddEventHandler('paramedic:respawn', function()
	TriggerEvent("paramedic:dead")
	TriggerEvent("police:undrag")
	TriggerEvent("interaction:undrag")
	TriggerEvent("Reset.Carry.And.Kidnap")
	DetachEntity(PlayerPedId(), true, false)
	secondsRemaining = -1
	SetEntityHealth(GetPlayerPed(-1), GetPedMaxHealth(GetPlayerPed(-1)))
	SetEntityInvincible(GetPlayerPed(-1), false)
	DisablePlayerFiring(PlayerId(), false)
	ClearPedBloodDamage(GetPlayerPed(-1))
	NetworkResurrectLocalPlayer(spawnlocation.x, spawnlocation.y, spawnlocation.z, true, true, false)
	local bars = exports.core_modules:getBars()
	if bars[1] < 21 or bars[2] < 40 then
		TriggerEvent('fm:drink', 40)
		TriggerEvent('fm:eat', 40)
	end
	if exports.policejob:getIsCuffed() then
		TriggerEvent('police:uncuff')
	elseif exports.core_modules:isCuffed() then
		TriggerServerEvent("handcuffs:uncuff", GetPlayerServerId(PlayerId()))
	end
end)

function SetPlayerKO(playerPed)
	isKO = true
	SendNotification('You got knocked out!')
	SetPedToRagdoll(playerPed, 6000, 6000, 0, 0, 0, 0)
end

function SendNotification(message)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(message)
	DrawNotification(false, false)
end

function drawRespawnTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end
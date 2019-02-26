local JumpTimer = -1

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if JumpTimer > 0 then
			JumpTimer = JumpTimer - 1
		end
	end
end)

local count = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(IsPedJumping(PlayerPedId()))then
			count = count + 0.03
		end
		if(math.floor(count) > 0.00)then
			JumpTimer = 10
		end
		if(math.floor(count) == 4)then
			SetPedToRagdoll(PlayerPedId(), 2000, 2000, 0, 0, 0, 0)
			count = 0
		end
		if JumpTimer == 0 then
			count = 0
			JumpTimer = -1
		end
	end
end)

--[[local pressed = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local timer = 0
        while IsControlPressed(1, 75) do
            Citizen.Wait(0)
            timer = timer + 1
            if timer > 120 then
                pressed = true
                break
            end
        end
        while not IsControlJustReleased(1, 75) do
            Citizen.Wait(0)
        end
        pressed = false
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			if not pressed then
				if IsControlJustPressed(1, 75) then
					SetVehicleEngineOn(vehicle, true, true, false)
				end
			else
				SetVehicleEngineOn(vehicle, false, false, false)
			end
		end
	end
end)--]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if GetItemQuantity(8) > 20 then
			local chance = math.random(1,100)
			if chance > 50 then
				TriggerServerEvent('drugs:sendMessage', "weed")
				Citizen.Wait(60000)
			else
				Citizen.Wait(60000)
			end
		end
	end
end)
--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isInJail() then
			TriggerServerEvent('sync:jailedPlayers', GetPlayerServerId(PlayerId()))
			Citizen.Wait(60000)
			TriggerServerEvent('sync:jailedPlayersClearTable')
		end
	end
end)--]]

local binoculars = false
local fov_max = 70.0
local fov_min = 5.0
local fov = (fov_max+fov_min)*0.5
local zoomspeed = 10.0
local speed_lr = 8.0
local speed_ud = 8.0

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local lPed = GetPlayerPed(-1)
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then

		if IsControlJustPressed(0,241) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	end
end

function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end
	return handle
end

--[[Citizen.CreateThread(function ()
	local model = GetHashKey("ba_prop_club_screens_01")
	local pos = { x = -1604.664, y = -3012.583, z = 80.00 }
	local entity = GetClosestObjectOfType(pos.x, pos.y, pos.z, 0.05, model, 0, 0, 0)
	local handle = CreateNamedRenderTargetForModel("club_projector", model)
	RegisterScriptWithAudio(0)
	SetTvChannel(-1)
	Citizen.InvokeNative(0x9DD5A62390C3B735, 2, "PL_TOU_LSER_GALAXY", 0)
	SetTvChannel(2)
	EnableMovieSubtitles(1)
	while true do
	    SetTvAudioFrontend(0)
	    AttachTvAudioToEntity(entity)
	    SetTextRenderId(handle)
	    Set_2dLayer(4)
	    Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
	    DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
	    SetTextRenderId(GetDefaultScriptRendertargetRenderId())
	    Citizen.Wait(0)
	end
end)--]]

RegisterNetEvent('toggle:binoculars')
AddEventHandler('toggle:binoculars', function()
	binoculars = not binoculars
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(ped, false)
			if GetItemQuantity(78) > 0 and binoculars then
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_BINOCULARS", 0, 1)
				PlayAmbientSpeech1(ped, "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")

				Wait(2000)

				local scaleform = RequestScaleformMovie("BINOCULARS")

				while not HasScaleformMovieLoaded(scaleform) do
					Citizen.Wait(0)
				end

				local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

				AttachCamToEntity(cam, ped, 0.0,0.0,1.0, true)
				SetCamRot(cam, 0.0,0.0,GetEntityHeading(ped))
				SetCamFov(cam, fov)
				RenderScriptCams(true, false, 0, 1, 0)
				PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
				PushScaleformMovieFunctionParameterInt(0)
				PopScaleformMovieFunctionVoid()

				while binoculars and not IsEntityDead(ped) and GetVehiclePedIsIn(ped, false) == vehicle and true do
					if IsControlJustPressed(1, 177) then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						ClearPedTasks(ped)
						binoculars = false
					end

					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam, zoomvalue)

					HandleZoom(cam)
					HideHUDThisFrame()

					DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					Citizen.Wait(10)
				end
				binoculars = false
				fov = (fov_max+fov_min)*0.5
				RenderScriptCams(false, false, 0, 1, 0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam, false)
				SetNightvision(false)
				SetSeethrough(false)
				break
			else
				Notify("You do not own any binoculars!", 2500)
				break
			end
		end
	end)
end)

local WeaponsList = {
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_REVOLVER",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_APPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_GUSENBERG",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_DBSHOTGUN",
	"WEAPON_AUTOSHOTGUN",
}

function HasPlayerRecentlyRobbed(TargetPed, Table)
	for i = 1, #Table do
		if Table[i] == TargetPed then
			return false
		end
	end
	return true
end

function TypeOfWeapon(Weapon)
	for i = 1, #WeaponsList do
		if Weapon == GetHashKey(WeaponsList[i]) then
			return true
		end
	end
	return false
end

local HasTriggered = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local Aiming, TargetPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
		local PlayerPosition, TargetPedPosition = GetEntityCoords(PlayerPed, 0), GetEntityCoords(TargetPed, 0)
		local PreviouslyRobbed = {}
		local Dictionary, AnimationName, AnimationName2 = "random@arrests@busted", "enter", "idle_a"
		RequestAnimDict(Dictionary)
		while not HasAnimDictLoaded(Dictionary) do
			Citizen.Wait(0)
		end
	 	if Aiming and TypeOfWeapon(GetSelectedPedWeapon(PlayerPed)) and not exports.policejob:getIsInService() and not IsPedShooting(PlayerPed) then
	  		if DoesEntityExist(TargetPed) and IsEntityAPed(TargetPed) and HasPlayerRecentlyRobbed(TargetPed, PreviouslyRobbed) and not IsPedAPlayer(TargetPed) then
		  		if #(PlayerPosition - TargetPedPosition) < 5 then
			  		TaskSetBlockingOfNonTemporaryEvents(TargetPed, true)
			  		SetPedFleeAttributes(TargetPed, 0, 0)
			  		SetPedCombatAttributes(TargetPed, 46, 1)
			  		SetPedSeeingRange(TargetPed, 0.0)
			  		SetPedHearingRange(TargetPed, 0.0)
			  		SetPedAlertness(TargetPed, 0)
			  		SetEntityAsMissionEntity(TargetPed, true, true)
			  		if IsPedInAnyVehicle(TargetPed, 0) then
			  			local Vehicle = GetVehiclePedIsIn(TargetPed)
			  			TaskLeaveVehicle(TargetPed, Vehicle)
			  			Citizen.Wait(3000)
			  			if HasTriggered == false then
			  				FreezeEntityPosition(TargetPed, true)
			  				TaskPlayAnim(TargetPed, Dictionary, AnimationName2, 4.0, -4, -1, 1, 0, false, false, false)
			  				HasTriggered = true
			  			end
			  			if #(PlayerPosition - TargetPedPosition) < 3 then
				  			DisplayHelpText("Press ~INPUT_CONTEXT~ to rob!")
				  			if IsControlJustPressed(1,51) then
				  				TaskPlayAnim(TargetPed, Dictionary, AnimationName2, 4.0, -4, -1, 1, 0, false, false, false)
				  				street, crossing = GetStreetNameAtCoord(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
				  				TriggerServerEvent("dispatch:ten-thirtytwo-r", {PlayerPosition.x, PlayerPosition.y, PlayerPosition.z}, GetStreetNameFromHashKey(street))
				  				Notify("You're robbing a mothafucka. Dont move and keep them at gunpoint until you get that lettuce!", 30000)
				  				Citizen.Wait(30000)
				  				PlayerPosition, TargetPedPosition = GetEntityCoords(PlayerPed, 0), GetEntityCoords(TargetPed, 0)
				  				if #(PlayerPosition - TargetPedPosition) < 3 then
					  				if getCops() <= 0 then 
										TriggerServerEvent("Rob:Sucessful", false)
									else
										TriggerServerEvent("Rob:Sucessful", true)
									end
								end
				  				table.insert(PreviouslyRobbed, TargetPed)
				  				TaskSetBlockingOfNonTemporaryEvents(TargetPed, false)
				  				FreezeEntityPosition(TargetPed, false)
				  				TaskReactAndFleePed(TargetPed, PlayerPed)
				  				Citizen.Wait(30000)
				  				HasTriggered = false
				  			end
				  		end
			  		else
			  			if HasTriggered == false then
			  				FreezeEntityPosition(TargetPed, true)
		  					TaskPlayAnim(TargetPed, Dictionary, AnimationName2, 4.0, -4, -1, 1, 0, false, false, false)
		  					HasTriggered = true
		  				end
			  			if #(PlayerPosition - TargetPedPosition) < 3 then
				  			DisplayHelpText("Press ~INPUT_CONTEXT~ to rob!")
				  			if IsControlJustPressed(1,51) then
				  				TaskPlayAnim(TargetPed, Dictionary, AnimationName2, 4.0, -4, -1, 1, 0, false, false, false)
				  				street, crossing = GetStreetNameAtCoord(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
				  				TriggerServerEvent("dispatch:ten-thirtytwo-r", {PlayerPosition.x, PlayerPosition.y, PlayerPosition.z}, GetStreetNameFromHashKey(street))
				  				Notify("You're robbing a mothafucka. Dont move and keep them at gunpoint until you get that lettuce!", 30000)
				  				Citizen.Wait(30000)
				  				PlayerPosition, TargetPedPosition = GetEntityCoords(PlayerPed, 0), GetEntityCoords(TargetPed, 0)
				  				if #(PlayerPosition - TargetPedPosition) < 3 then
					  				if getCops() <= 0 then 
										TriggerServerEvent("Rob:Sucessful", false)
									else
										TriggerServerEvent("Rob:Sucessful", true)
									end
								end
				  				table.insert(PreviouslyRobbed, TargetPed)
				  				TaskSetBlockingOfNonTemporaryEvents(TargetPed, false)
				  				FreezeEntityPosition(TargetPed, false)
				  				TaskReactAndFleePed(TargetPed, PlayerPed)
				  				Citizen.Wait(30000)
				  				HasTriggered = false
				  			end
				  		end
			  		end
			  	end
		  	end
		end
	end
end)

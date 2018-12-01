Player = {
	Ready = false,
	Id = nil,
	Ped = nil,
	Coordinates = nil,
	Heading = nil,
	Dead = false,
	Cuffs = {
		Active = false,
		Type = false,
		Component = {Drawable = nil, Texture = nil, Palette = nil},
	},
	Stance = {
		Standing = true,
		Crouched = false,
		Proned = false,
		GoingUp = false,
		OnBack = false,
	},
	HandsUp = false,
	OnKnees = false,
	Dragged = {
		Being = false,
		Was = false,
		By = false,
	},
	BAC = 0.00,
	DrunkState = 0,
	Residue = {
		Active = false,
		Timer = 0,
	},
	Playtime = 0,
	Vehicle = {
		Current = nil,
		Last = nil,
		Using = nil,
		Seatbelt = false,
	},
}

local JumpTimer = -1

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		Player.Id = PlayerId()
		if Player.Ped ~= PlayerPedId() then
			Player.Ped = PlayerPedId()
		end
		
		Player.Coordinates = GetEntityCoords(Player.Ped, false)
		Player.Heading = GetEntityHeading(Player.Ped)
		Player.Vehicle.Current = GetVehiclePedIsIn(Player.Ped, false)
		Player.Vehicle.Last = GetVehiclePedIsIn(Player.Ped, true)
		Player.Vehicle.Using = GetVehiclePedIsUsing(Player.Ped)

		ClearAreaOfCops(Player.Coordinates, 400.0)

		if not Player.Ready then Player.Ready = true end
	end
end)

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
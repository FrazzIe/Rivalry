ViewingCams = nil
CurrentCamera = 1
Camera = nil
CameraCache = {}
CameraObjects = {}
CameraInstructions = nil
Transitioning = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		while not ViewingCams or Transitioning do
			Citizen.Wait(0)
		end

		local robberyConfig = Config.Robberies[ViewingCams]
		local camera = CameraCache[CurrentCamera]

		-- Check state.
		local isDestroyed = false
		
		for k, v in ipairs(States.cams) do
			if #(v - GetEntityCoords(camera)) < 0.1 then
				isDestroyed = true
				break
			end
		end

		-- Vehicle.
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, false)
	
		if GetPedInVehicleSeat(vehicle, -1) == ped then
			SetVehicleEngineOn(vehicle, false, false, true)
		end

		-- Effects.
		if isDestroyed or not DoesEntityExist(camera) or GetEntityHealth(camera) < 1000 then
			SetTimecycleModifier("CAMERA_secuirity_FUZZ")
			SetTimecycleModifierStrength(11.0)
		else
			SetTimecycleModifier("scanline_cam_cheap")
			SetTimecycleModifierStrength(2.0)
		end

		-- Keybinds.
		if IsControlJustPressed(1, 174) then
			SwitchCamera(CurrentCamera - 1)
			LoadCams()
		elseif IsControlJustPressed(1, 175) then
			SwitchCamera(CurrentCamera + 1)
			LoadCams()
		elseif IsControlJustPressed(1, 194) then
			CloseCams()
		end

		-- Rotation (up/down/left/right)
		local rotation = GetCamRot(Camera)
		local speed = 0.6

		if IsControlPressed(1, 32) then
			if rotation.x <= 0.0 then
				SetCamRot(Camera, rotation.x + speed, 0.0, rotation.z, 2)
			end
		end

		if IsControlPressed(1, 33) then
			if rotation.x >= -50.0 then
				SetCamRot(Camera, rotation.x - speed, 0.0, rotation.z, 2)
			end
		end

		if IsControlPressed(1, 34) then
			SetCamRot(Camera, rotation.x, 0.0, rotation.z + speed, 2)
		end

		if IsControlPressed(1, 35) then
			SetCamRot(Camera, rotation.x, 0.0, rotation.z - speed, 2)
		end

		-- Instructions.
		if CameraInstructions ~= nil then
			DrawScaleformMovieFullscreen(CameraInstructions, 255, 255, 255, 255, 0)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		while NearestRobbery == nil or not IsPedShooting(PlayerPedId()) do
			Citizen.Wait(0)
		end
		
		local retval, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
		
		if Config.CameraCache[GetEntityModel(entity)] ~= nil then
			TriggerServerEvent("robberies:destroyCam", NearestRobbery, GetEntityCoords(entity))
		end
	end
end)

RegisterNetEvent("robberies:destroyCam")
AddEventHandler("robberies:destroyCam", function(coords)
	table.insert(States.cams, coords)
end)

function SwitchCamera(index)
	DoScreenFadeOut(100)
	local robberyConfig = Config.Robberies[ViewingCams]

	if index > #CameraCache then
		index = 1
	elseif index <= 0 then
		index = #CameraCache
	end

	local object = CameraCache[index]
	if not DoesEntityExist(object) then return end

	CurrentCamera = index

	local camera = CameraObjects[object]
	local cameraConfig = Config.Cameras[camera]
	local offset = cameraConfig.Offset or vector3(0.0, 0.0, -0.8)
	local coords = GetOffsetFromEntityInWorldCoords(object, offset.x, offset.y, offset.z)
	local rot = GetEntityRotation(object)

	SetCamCoord(Camera, coords.x, coords.y, coords.z)
	SetCamRot(Camera, rot.x, rot.y, rot.z + (cameraConfig.Heading or 0.0), 2)
	RenderScriptCams(1, 0, 0, 1, 1)

	SendNUIMessage({
		type = "enablecam",
		label = robberyConfig.Name,
		box = "Camera "..tostring(index),
	})

	Citizen.Wait(100)
	DoScreenFadeIn(100)
end

function LoadCams()
	local robberyConfig = Config.Robberies[ViewingCams]
	local objects = exports.utils:GetObjects()
	local hasCameras = false
	local oldCamera = CameraCache[CurrentCamera]

	CameraCache = {}
	CameraObjects = {}

	ClearTimecycleModifier("scanline_cam_cheap")

	for _, object in ipairs(objects) do
		if DoesEntityExist(object) then
			local cameraCache = Config.CameraCache[GetEntityModel(object)]
			if cameraCache ~= nil and #(GetEntityCoords(object) - robberyConfig.Coords) < (robberyConfig.Dist or 20.0) and IsEntityUpright(object) then
				CameraObjects[object] = cameraCache
				table.insert(CameraCache, object)
				hasCameras = true
			end
			if oldCamera == object then
				CurrentCamera = #CameraCache
			end
		end
	end
	
	return hasCameras
end

function CloseCams()
	if ViewingCams == nil then return end
	
	local ped = PlayerPedId()

	if Camera ~= nil then
		DestroyCam(Camera, 0)
		RenderScriptCams(0, 0, 1, 1, 1)
		ClearTimecycleModifier("scanline_cam_cheap")
		SetFocusEntity(ped)
		Camera = nil
	end

	DoScreenFadeIn(1000)
	SendNUIMessage({type = "disablecam"})
	TriggerEvent("interaction:hud:cameras")

	FreezeEntityPosition(ped, false)
	ClearFocus()

	ViewingCams = nil
	Transitioning = false
end

function ViewCams(robbery)
	if Transitioning then return end

	robbery = tonumber(robbery)
	local robberyConfig = Config.Robberies[robbery]
	
	if robbery == nil or robberyConfig == nil then
		CloseCams()
		return
	end
	
	local ped = PlayerPedId()
	local pedPos = GetEntityCoords(ped)
	local coords = robberyConfig.Coords
	local vehicle = GetVehiclePedIsIn(ped, false)
	
	if not DoesEntityExist(vehicle) or GetVehicleClass(vehicle) ~= 18 then
		return
	end

	ViewingCams = robbery

	Transitioning = true
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)

	-- Set focus.
	SetFocusPosAndVel(coords.x, coords.y, coords.z, 0.0, 0.0, 0.0)

	-- Freeze.
	FreezeEntityPosition(ped, true)

	-- Create the camera.
	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(Camera, coords.x, coords.y, coords.z)
	SetCamRot(Camera, 0.0, 0.0, 0.0, 2)
	RenderScriptCams(1, 0, 0, 1, 1)

	Citizen.Wait(1000)

	-- Load the cameras.
	local tries = 20
	for i = 1, tries do
		local hasCameras = LoadCams()

		if hasCameras then
			SwitchCamera(1)
			break
		else
			if i >= tries then
				print("No cams loaded after "..tries.." tries")
				CloseCams()

				return
			end
			Citizen.Wait(500)
		end
	end

	DoScreenFadeIn(1000)
	Transitioning = false

	-- Enable effects.
	CameraInstructions = CreateInstuctionScaleform("instructional_buttons")
	TriggerEvent("interaction:hud:cameras")
end
exports("ViewCams", ViewCams)

function CreateInstuctionScaleform(scaleform)
	scaleform = RequestScaleformMovie(scaleform)
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(0)
	InstructionButton(GetControlInstructionalButton(1, 175, true))
	InstructionButtonMessage("Next")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(1)
	InstructionButton(GetControlInstructionalButton(1, 194, true))
	InstructionButtonMessage("Close")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(2)
	InstructionButton(GetControlInstructionalButton(1, 174, true))
	InstructionButtonMessage("Previous")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(80)
	PopScaleformMovieFunctionVoid()

	return scaleform
end

function InstructionButton(controlButton)
	N_0xe83a3e3557a56640(controlButton)
end

function InstructionButtonMessage(text)
	BeginTextCommandScaleformString("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandScaleformString()
end

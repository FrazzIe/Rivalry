Camera = {}

Camera = setmetatable({}, Camera)
Camera.__index = Camera

function Camera.New(X, Y, Z, Roll, Pitch, Yaw)
	return setmetatable(
		{
			Handle = nil,
			Coordinates = {X = tonumber(X) or 0, Y = tonumber(Y) or 0, Z = tonumber(Z) or 0},
			Rotation = {X = tonumber(Roll) or 0, Y = tonumber(Pitch) or 0, Z = tonumber(Yaw) or 0},
		},
	Camera)
end

function Camera:Destroy()
	DestroyCam(self.Handle, false)
end

function Camera:Create()
	self:Destroy()
	self.Handle = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	self:Position(self.Coordinates.X, self.Coordinates.Y, self.Coordinates.Z)
	self:Rotate(self.Rotation.X, self.Rotation.Y, self.Rotation.Z)
end

function Camera:Rotate(Roll, Pitch, Yaw)
	SetCamRot(self.Handle, tonumber(Roll) or 0, tonumber(Pitch) or 0, tonumber(Yaw) or 0, 2)
	self.Rotation = {X = tonumber(Roll) or 0, Y = tonumber(Pitch) or 0, Z = tonumber(Yaw) or 0}
end

function Camera:Position(X, Y, Z)
	SetCamCoord(self.Handle, tonumber(X) or 0, tonumber(Y) or 0, tonumber(Z) or 0)
	self.Coordinates = {X = tonumber(X) or 0, Y = tonumber(Y) or 0, Z = tonumber(Z) or 0}
end

function Camera:AttachToEntity(Entity, X, Y, Z, Relative)
	if DoesEntityExist(Entity) then
		AttachCamToEntity(self.Handle, Entity, tonumber(X) or 0, tonumber(Y) or 0, tonumber(Z) or 0, Relative)
	end
end

function Camera:AttachToBone(Ped, Bone, X, Y, Z, H)
	if DoesEntityExist(Ped) then
		AttachCamToPedBone(self.Handle, Ped, tonumber(Bone) or 0, tonumber(X) or 0, tonumber(Y) or 0, tonumber(Z) or 0, tonumber(H) or 0)
	end
end

function Camera:Exists()
	return DoesCamExist(self.Handle)
end

function Camera:Active()
	return IsCamActive(self.Handle)
end

function Camera:Rendering()
	return IsCamRendering(self.Handle)
end

function Camera:Detach()
	DetachCam(self.Handle)
end

function Camera:Switch(From, Duration, EaseLocation, EaseRotation)
	SetCamActiveWithInterp(self.Handle, From, Duration, EaseLocation, EaseRotation)
end

function Camera:Activate(EaseTransition, EaseTime)
	SetCamActive(self.Handle, true)
	RenderScriptCams(true, EaseTransition, tonumber(EaseTime) or 0, 1, 0)
end

function Camera:Deactivate(EaseTransition, EaseTime)
	SetCamActive(self.Handle, false)
	RenderScriptCams(false, EaseTransition, tonumber(EaseTime) or 0, 1, 0)
end
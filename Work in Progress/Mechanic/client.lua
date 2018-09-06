local function PatchTheStupidLeakyLeak() collectgarbage() Citizen.SetTimeout(2000, PatchTheStupidLeakyLeak) end Citizen.SetTimeout(2000, PatchTheStupidLeakyLeak)

function RenderMarker(Type, X, Y, Z, SX, SY, SZ, R, G, B, A, BobUpAndDown)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		DrawMarker(Type, X, Y, Z - 0.9, 0, 0, 0, 0, 0, 0, SX or 0, SY or 0, SZ or 0, R or 255, G or 255, B or 255, A or 255, BobUpAndDown or false, 0, 2, 0, 0, 0, 0)
	end
end

function GetVehicleInDirectionSphere(Entity, EntityCoords, Offset)
	local rayHandle = StartShapeTestCapsule(EntityCoords.x, EntityCoords.y, EntityCoords.z, Offset.x, Offset.y, Offset.z, 2.0, 2, Entity, 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end

Mechanic = {
	Data = {
		IsMechanic = false,
		OnDuty = false,
		Vehicles = {
			{
				Model = "flatbed",
				Control = {
					Offset = {-1.4982982969284, -5.1126073908806, 0.0},
					Position = nil,
				},
				Target = {
					Offset = {0.0, -8.1126073908806, 0.0},
					Position = nil,
				},
				Closest = nil,
				Help = true,
				Dimensions = nil,
				AttachedVehicle = 0,
				Controls = function(self, Ped, Coordinates)
					local TargetVehicle = nil

					if self.AttachedVehicle == 0 then
						TargetVehicle = GetVehicleInDirectionSphere(self.Closest.Handle, self.Closest.Position, self.Target.Position)
					end

					RenderMarker(25, self.Control.Position.x, self.Control.Position.y, self.Control.Position.z, 0.5, 0.5, 1.0, 255, 0, 0, 100)

					if self.Help and TargetVehicle ~= 0 then
						DrawEntityBoundingBox(TargetVehicle, 0, 255, 0, 255)
					end

					if Vdist(Coordinates.x, Coordinates.y, Coordinates.z, self.Control.Position.x, self.Control.Position.y, self.Control.Position.z) < 1 then
						Utilities.DisplayHelpText("Press ~INPUT_CONTEXT~ to tow\nPress ~INPUT_INTERACTION_MENU~ for help")

						if IsControlJustPressed(0, 51) then
							if self.AttachedVehicle ~= 0 then
								local DropPointOffset = GetOffsetFromEntityInWorldCoords(self.Closest.Handle, 0.0, -10.0, 0.0)

								DetachEntity(self.AttachedVehicle, false, false)
								SetEntityCoords(self.AttachedVehicle, DropPointOffset.x, DropPointOffset.y, DropPointOffset.z, 1, 0, 0, 1)
								PlaceObjectOnGroundProperly(self.AttachedVehicle)

								self.AttachedVehicle = 0
							elseif TargetVehicle ~= 0 then
								AttachEntityToEntity(TargetVehicle, self.Closest.Handle, GetEntityBoneIndexByName(self.Closest.Handle, "bodyshell"), 0, -2.2, 0.4 - table.pack(GetModelDimensions(GetEntityModel(TargetVehicle)))[1].z, 0, 0, 0, 1, 1, 0, 1, 0, 1)
							end
						end

						if IsControlJustPressed(0, 244) then
							self.Help = not self.Help
						end
					end
				end,
			},
			{
				Model = "towtruck",
				Control = {
					Offset = {-1.4882982969284, -3.1126073908806, 0.0},
					Position = nil,
				},
				Target = {
					Offset = {0.0, -6.1126073908806, 0.0},
					Position = nil,
				},
				Closest = nil,
				LastHandle = nil,
				Height = 0.5,
				Help = true,
				Dimensions = nil,
				Controls = function(self, Ped, Coordinates)
					if self.LastHandle ~= self.Closest.Handle then
						SetTowTruckCraneHeight(self.Closest.Handle, self.Height)
					end

					local AttachedVehicle = GetEntityAttachedToTowTruck(self.Closest.Handle)
					local TargetVehicle = nil
					
					if AttachedVehicle == 0 then
						TargetVehicle = GetVehicleInDirectionSphere(self.Closest.Handle, self.Closest.Position, self.Target.Position)
					end

					RenderMarker(25, self.Control.Position.x, self.Control.Position.y, self.Control.Position.z, 0.5, 0.5, 1.0, 255, 0, 0, 100)

					if self.Help and TargetVehicle ~= 0 then
						DrawEntityBoundingBox(TargetVehicle, 0, 255, 0, 255)
					end

					if Vdist(Coordinates.x, Coordinates.y, Coordinates.z, self.Control.Position.x, self.Control.Position.y, self.Control.Position.z) < 1 then
						Utilities.DisplayHelpText("Press ~INPUT_CONTEXT~ to tow\nPress ~INPUT_INTERACTION_MENU~ for help\n~g~+~w~/~r~-~w~ to adjust hook")

						if IsControlPressed(0, 96) then
							if self.Height < 1.0 then
								self.Height = self.Height + 0.1								
								SetTowTruckCraneHeight(self.Closest.Handle, self.Height)
							end
						end

						if IsControlPressed(0, 97) then
							if self.Height > 0.0 then
								self.Height = self.Height - 0.1								
								SetTowTruckCraneHeight(self.Closest.Handle, self.Height)
							end
						end
						
						if IsControlJustPressed(0, 51) then
							if AttachedVehicle ~= 0 then
								DetachVehicleFromTowTruck(self.Closest.Handle, AttachedVehicle)
							elseif TargetVehicle ~= 0 then
								AttachVehicleToTowTruck(self.Closest.Handle, TargetVehicle, true, 0.0, 0.0, 0.0)
							end
						end

						if IsControlJustPressed(0, 244) then
							self.Help = not self.Help
						end
					end
				end,
			},
			{
				Model = "towtruck2",
				Control = {
					Offset = {-1.1469407081604, -0.40072667598724, 0.0},
					Position = nil,
				},
				Target = {
					Offset = {0.0, -6.1126073908806, 0.0},
					Position = nil,
				},
				Closest = nil,
				LastHandle = nil,
				Height = 0.5,
				Help = true,
				Dimensions = nil,
				Controls = function(self, Ped, Coordinates)
					if self.LastHandle ~= self.Closest.Handle then
						SetTowTruckCraneHeight(self.Closest.Handle, self.Height)
					end

					local AttachedVehicle = GetEntityAttachedToTowTruck(self.Closest.Handle)
					local TargetVehicle = nil
					
					if AttachedVehicle == 0 then
						TargetVehicle = GetVehicleInDirectionSphere(self.Closest.Handle, self.Closest.Position, self.Target.Position)
					end

					RenderMarker(25, self.Control.Position.x, self.Control.Position.y, self.Control.Position.z + 0.4, 0.5, 0.5, 1.0, 255, 0, 0, 100)

					if self.Help and TargetVehicle ~= 0 then
						DrawEntityBoundingBox(TargetVehicle, 0, 255, 0, 255)
					end

					if Vdist(Coordinates.x, Coordinates.y, Coordinates.z, self.Control.Position.x, self.Control.Position.y, self.Control.Position.z) < 1 then
						Utilities.DisplayHelpText("Press ~INPUT_CONTEXT~ to tow\nPress ~INPUT_INTERACTION_MENU~ for help\n~g~+~w~/~r~-~w~ to adjust hook")

						if IsControlPressed(0, 96) then
							if self.Height < 1.0 then
								self.Height = self.Height + 0.1								
								SetTowTruckCraneHeight(self.Closest.Handle, self.Height)
							end
						end

						if IsControlPressed(0, 97) then
							if self.Height > 0.0 then
								self.Height = self.Height - 0.1								
								SetTowTruckCraneHeight(self.Closest.Handle, self.Height)
							end
						end
						
						if IsControlJustPressed(0, 51) then
							if AttachedVehicle ~= 0 then
								DetachVehicleFromTowTruck(self.Closest.Handle, AttachedVehicle)
							elseif TargetVehicle ~= 0 then
								AttachVehicleToTowTruck(self.Closest.Handle, TargetVehicle, true, 0.0, 0.0, 0.0)
							end
						end

						if IsControlJustPressed(0, 244) then
							self.Help = not self.Help
						end
					end
				end,
			},
		},
	},
}

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

Utilities = {}

function Utilities.EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
	
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
	
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
	
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function Utilities.EnumerateObjects()
	return Utilities.EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function Utilities.EnumeratePeds()
	return Utilities.EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function Utilities.EnumerateVehicles()
	return Utilities.EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function Utilities.EnumeratePickups()
	return Utilities.EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function Utilities.GetNearestVehicleAtCoords(X, Y, Z, Radius, Alive, ExcludePlayer, Model)
	local NearestVehicles = {}
	local NearestVehicle = {Handle = nil, Position = nil, Distance = nil}
	local PlayerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		if tonumber(Radius) then
			for Vehicle in Utilities.EnumerateVehicles() do
				if DoesEntityExist(Vehicle) and not (Alive and false or IsEntityDead(Vehicle)) and not (ExcludePlayer and false or (Vehicle == PlayerVehicle)) and (Model and false or IsVehicleModel(Vehicle, Model)) then
					local VehiclePosition = GetEntityCoords(Vehicle, false)
					local Distance = Vdist(X, Y, Z, VehiclePosition.x, VehiclePosition.y, VehiclePosition.z)
					if Distance <= Radius then
						table.insert(NearestVehicles, {Handle = Vehicle, Position = VehiclePosition, Distance = Distance})
					end
				end
			end

			for Index = 1, #NearestVehicles, 1 do
				if NearestVehicles[Index] then
					if Index == 1 then NearestVehicle = NearestVehicles[Index] end
					if Vdist(X, Y, Z, NearestVehicle.Position.x, NearestVehicle.Position.y, NearestVehicle.Position.z) > Vdist(X, Y, Z, NearestVehicles[Index].Position.x, NearestVehicles[Index].Position.y, NearestVehicles[Index].Position.z) then
						NearestVehicle = NearestVehicles[Index]
					end
				end
			end
		end
	end
	return NearestVehicle
end

function Utilities.GetVehicleAttachedToVehicle(AttachedVehicle)
	for Vehicle in Utilities.EnumerateVehicles() do
		if DoesEntityExist(Vehicle) then
			if GetEntityAttachedTo(Vehicle) == AttachedVehicle then
				return Vehicle
			end
		end
	end

	return 0
end

function Utilities.DisplayHelpText(Str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(Str or "")
	EndTextCommandDisplayHelp(0, 0, 0, -1)
end

function Utilities.GetGroundZ(X, Y, Z)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		local _, GroundZ = GetGroundZFor_3dCoord(X + 0.0, Y + 0.0, Z + 0.0, Citizen.ReturnResultAnyway())
		return GroundZ
	else
		return Z
	end
end

function values(xs)
	local i = 0
	return function()
		i = i + 1;
		return xs[i]
	end
end

function map(xs, fn)
	local t = {}
	for i,v in ipairs(xs) do
		local r = fn(v, i, xs)
		table.insert(t, r)
	end
	return t
end

function GetBoundingBox(min, max, pad)
	local pad = pad or 0.001

	return {
		-- Bottom
		vector3(min.x - pad, min.y - pad, min.z - pad), -- back right
		vector3(max.x + pad, min.y - pad, min.z - pad), -- back left
		vector3(max.x + pad, max.y + pad, min.z - pad), -- front left
		vector3(min.x - pad, max.y + pad, min.z - pad), -- front right

		-- Top
		vector3(min.x - pad, min.y - pad, max.z + pad), -- back right
		vector3(max.x + pad, min.y - pad, max.z + pad), -- back left
		vector3(max.x + pad, max.y + pad, max.z + pad), -- front left
		vector3(min.x - pad, max.y + pad, max.z + pad), -- front right
	}
end

function GetBoundingBoxEdgeMatrix(box)
	return {
		-- Bottom
		{ box[1], box[2] },
		{ box[2], box[3] },
		{ box[3], box[4] },
		{ box[4], box[1] },

		-- Top
		{ box[5], box[6] },
		{ box[6], box[7] },
		{ box[7], box[8] },
		{ box[8], box[5] },

		-- Sides
		{ box[1], box[5] },
		{ box[2], box[6] },
		{ box[3], box[7] },
		{ box[4], box[8] },
	}
end

function GetBoundingBoxPolyMatrix(box)
	return {
		-- Bottom
		{ box[3], box[2], box[1] },
		{ box[4], box[3], box[1] },

		-- Top
		{ box[5], box[6], box[7] },
		{ box[5], box[7], box[8] },

		-- Front
		{ box[3], box[4], box[7] },
		{ box[8], box[7], box[4] },

		-- Back
		{ box[1], box[2], box[5] },
		{ box[6], box[5], box[2] },

		-- Left
		{ box[2], box[3], box[6] },
		{ box[3], box[7], box[6] },

		-- Right
		{ box[5], box[8], box[4] },
		{ box[5], box[4], box[1] },
	}
end

function GetModelBoundingBox(model)
	local min, max = GetModelDimensions(model)
	return GetBoundingBox(min, max)
end

function GetEntityBoundingBox(entity)
	local model = GetEntityModel(entity)
	local box = GetModelBoundingBox(model)

	return map(box, function (corner)
		return GetOffsetFromEntityInWorldCoords(entity, corner)
	end)
end


function DrawEdgeMatrix(lines, r, g, b, a)
	for line in values(lines) do
		local x1, y1, z1 = table.unpack(line[1])
		local x2, y2, z2 = table.unpack(line[2])

		DrawLine(x1, y1, z1, x2, y2, z2, r, g, b, a)
	end
end

function DrawPolyMatrix(polies, r, g, b, a)
	for poly in values(polies) do
		local x1, y1, z1 = table.unpack(poly[1])
		local x2, y2, z2 = table.unpack(poly[2])
		local x3, y3, z3 = table.unpack(poly[3])

		DrawPoly(x1, y1, z1, x2, y2, z2, x3, y3, z3, r, g, b, a)
	end
end


function DrawBoundingBox(box, r1, g1, b1, a1, r2, g2, b2, a2)
	local polyMatrix = GetBoundingBoxPolyMatrix(box)
	local edgeMatrix = GetBoundingBoxEdgeMatrix(box)

	DrawEdgeMatrix(edgeMatrix, r1 or 255, g1 or 255, b1 or 255, a1 or 255)
	DrawPolyMatrix(polyMatrix,   r2 or 255, g2 or 255, b2 or 255, a2 or 0)
end


function DrawEntityBoundingBox(entity, r1, g1, b1, a1, r2, g2, b2, a2)
	local box = GetEntityBoundingBox(entity)
	return DrawBoundingBox(box, r1, g1, b1, a1, r2, g2, b2, a2)
end

Citizen.CreateThread(function()
	for Index = 1, #Mechanic.Data.Vehicles do
		Mechanic.Data.Vehicles[Index].ModelHash = GetHashKey(Mechanic.Data.Vehicles[Index].Model)
	end

	while true do
		local PlayerPed = PlayerPedId()
		local PlayerCoordinates = GetEntityCoords(PlayerPed, false)

		for Index = 1, #Mechanic.Data.Vehicles do
			Mechanic.Data.Vehicles[Index].Closest = Utilities.GetNearestVehicleAtCoords(PlayerCoordinates.x, PlayerCoordinates.y, PlayerCoordinates.z, 10, true, true, Mechanic.Data.Vehicles[Index].ModelHash)

			if Mechanic.Data.Vehicles[Index].Closest then
				if DoesEntityExist(Mechanic.Data.Vehicles[Index].Closest.Handle) then
					Mechanic.Data.Vehicles[Index].Target.Position = GetOffsetFromEntityInWorldCoords(Mechanic.Data.Vehicles[Index].Closest.Handle, table.unpack(Mechanic.Data.Vehicles[Index].Target.Offset))
					Mechanic.Data.Vehicles[Index].Control.Position = GetOffsetFromEntityInWorldCoords(Mechanic.Data.Vehicles[Index].Closest.Handle, table.unpack(Mechanic.Data.Vehicles[Index].Control.Offset))

					if Mechanic.Data.Vehicles[Index].AttachedVehicle ~= nil then
						Mechanic.Data.Vehicles[Index].AttachedVehicle = Utilities.GetVehicleAttachedToVehicle(Mechanic.Data.Vehicles[Index].Closest.Handle)
					end
				end
			end
		end

		Citizen.Wait(750)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerCoordinates = GetEntityCoords(PlayerPed, false)

		for Index = 1, #Mechanic.Data.Vehicles do
			if Mechanic.Data.Vehicles[Index].Closest then
				if DoesEntityExist(Mechanic.Data.Vehicles[Index].Closest.Handle) then
					Mechanic.Data.Vehicles[Index].Controls(Mechanic.Data.Vehicles[Index], PlayerPed, PlayerCoordinates)
				end
			end
		end
	end
end)
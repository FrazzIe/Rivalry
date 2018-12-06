Mechanic:AddControls("flatbed", function(self, PlayerPosition)
	local TargetVehicle = nil

	if self.AttachedVehicle == 0 then
		TargetVehicle = Utilities:GetVehicleInDirectionSphere(self.Vehicle.Handle, self.Vehicle.Position, self.Target.Position)
	end

	Utilities:RenderMarker(25, self.Control.Position.x, self.Control.Position.y, self.Control.Position.z, 0.5, 0.5, 1.0, 255, 0, 0, 100)

	if self.Help and TargetVehicle ~= 0 then
		Utilities:DrawEntityBoundingBox(TargetVehicle, 0, 255, 0, 255)
	end

	if #(Coordinates - self.Control.Position) < 1 then
		Utilities:DisplayHelpText("Press ~INPUT_CONTEXT~ to tow\nPress ~INPUT_INTERACTION_MENU~ for help")

		if IsControlJustPressed(0, 51) then
			if self.AttachedVehicle ~= 0 then
				local DropPointOffset = GetOffsetFromEntityInWorldCoords(self.Vehicle.Handle, 0.0, -10.0, 0.0)

				DetachEntity(self.AttachedVehicle, false, false)
				SetEntityCoords(self.AttachedVehicle, DropPointOffset.x, DropPointOffset.y, DropPointOffset.z, 1, 0, 0, 1)
				PlaceObjectOnGroundProperly(self.AttachedVehicle)

				self.AttachedVehicle = 0
			elseif TargetVehicle ~= 0 then
				AttachEntityToEntity(TargetVehicle, self.Vehicle.Handle, GetEntityBoneIndexByName(self.Vehicle.Handle, "bodyshell"), 0, -2.2, 0.4 - table.pack(GetModelDimensions(GetEntityModel(TargetVehicle)))[1].z, 0, 0, 0, 1, 1, 0, 1, 0, 1)
			end
		end

		if IsControlJustPressed(0, 244) then
			self.Help = not self.Help
		end
	end
end)

Mechanic:AddControls("towtruck", function(self, PlayerPosition)
	if self.LastVehicle ~= self.Vehicle.Handle then
		SetTowTruckCraneHeight(self.Vehicle.Handle, self.Height)
	end

	local AttachedVehicle = GetEntityAttachedToTowTruck(self.Vehicle.Handle)
	local TargetVehicle = nil
					
	if AttachedVehicle == 0 then
		TargetVehicle = Utilities:GetVehicleInDirectionSphere(self.Vehicle.Handle, self.Vehicle.Position, self.Target.Position)
	end

	Utilities:RenderMarker(25, self.Control.Position.x, self.Control.Position.y, self.Control.Position.z, 0.5, 0.5, 1.0, 255, 0, 0, 100)

	if self.Help and TargetVehicle ~= 0 then
		Utilities:DrawEntityBoundingBox(TargetVehicle, 0, 255, 0, 255)
	end

	if #(Coordinates - self.Control.Position) < 1 then
		Utilities:DisplayHelpText("Press ~INPUT_CONTEXT~ to tow\nPress ~INPUT_INTERACTION_MENU~ for help\n~g~+~w~/~r~-~w~ to adjust hook")

		if IsControlPressed(0, 96) then
			if self.Height < 1.0 then
				self.Height = self.Height + 0.1								
				SetTowTruckCraneHeight(self.Vehicle.Handle, self.Height)
			end
		end

		if IsControlPressed(0, 97) then
			if self.Height > 0.0 then
				self.Height = self.Height - 0.1								
				SetTowTruckCraneHeight(self.Vehicle.Handle, self.Height)
			end
		end
						
		if IsControlJustPressed(0, 51) then
			if AttachedVehicle ~= 0 then
				DetachVehicleFromTowTruck(self.Vehicle.Handle, AttachedVehicle)
			elseif TargetVehicle ~= 0 then
				AttachVehicleToTowTruck(self.Vehicle.Handle, TargetVehicle, true, 0.0, 0.0, 0.0)
			end
		end

		if IsControlJustPressed(0, 244) then
			self.Help = not self.Help
		end
	end
end)

Mechanic:AddControls("towtruck2", function(self, PlayerPosition)
	if self.LastVehicle ~= self.Vehicle.Handle then
		SetTowTruckCraneHeight(self.Vehicle.Handle, self.Height)
	end

	local AttachedVehicle = GetEntityAttachedToTowTruck(self.Vehicle.Handle)
	local TargetVehicle = nil
					
	if AttachedVehicle == 0 then
		TargetVehicle = Utilities:GetVehicleInDirectionSphere(self.Vehicle.Handle, self.Vehicle.Position, self.Target.Position)
	end

	Utilities:RenderMarker(25, self.Control.Position.x, self.Control.Position.y, self.Control.Position.z + 0.4, 0.5, 0.5, 1.0, 255, 0, 0, 100)

	if self.Help and TargetVehicle ~= 0 then
		Utilities:DrawEntityBoundingBox(TargetVehicle, 0, 255, 0, 255)
	end

	if #(Coordinates - self.Control.Position) < 1 then
		Utilities:DisplayHelpText("Press ~INPUT_CONTEXT~ to tow\nPress ~INPUT_INTERACTION_MENU~ for help\n~g~+~w~/~r~-~w~ to adjust hook")

		if IsControlPressed(0, 96) then
			if self.Height < 1.0 then
				self.Height = self.Height + 0.1								
				SetTowTruckCraneHeight(self.Vehicle.Handle, self.Height)
			end
		end

		if IsControlPressed(0, 97) then
			if self.Height > 0.0 then
				self.Height = self.Height - 0.1								
				SetTowTruckCraneHeight(self.Vehicle.Handle, self.Height)
			end
		end
						
		if IsControlJustPressed(0, 51) then
			if AttachedVehicle ~= 0 then
				DetachVehicleFromTowTruck(self.Vehicle.Handle, AttachedVehicle)
			elseif TargetVehicle ~= 0 then
				AttachVehicleToTowTruck(self.Vehicle.Handle, TargetVehicle, true, 0.0, 0.0, 0.0)
			end
		end

		if IsControlJustPressed(0, 244) then
			self.Help = not self.Help
		end
	end
end)

Citizen.CreateThread(function()
	for Model, Data in pairs(Mechanic.Vehicles) do
		Data.Hash = GetHashKey(Model)
	end

	while true do
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		for Model, Data in pairs(Mechanic.Vehicles) do
			Data.Vehicle = Utilities:GetClosestVehicle(PlayerPosition, 10, true, Data.Hash, true)

			if Data.Vehicle then
				if DoesEntityExist(Data.Vehicle.Handle) then
					Data.Target.Position = GetOffsetFromEntityInWorldCoords(Data.Vehicle.Handle, Data.Target.Offset.x, Data.Target.Offset.y, Data.Target.Offset.z)
					Data.Control.Position = GetOffsetFromEntityInWorldCoords(Data.Vehicle.Handle, Data.Control.Offset.x, Data.Control.Offset.y, Data.Control.Offset.z)

					if Data.AttachedVehicle ~= nil then
						Data.AttachedVehicle = Utilities:GetVehicleAttachedToVehicle(Data.Vehicle.Handle)
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
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		for Model, Data in pairs(Mechanic.Vehicles) do
			if Data.Vehicle then
				if DoesEntityExist(Data.Vehicle.Handle) then
					Data.Controls(Data, PlayerPosition)
				end
			end
		end
	end
end)
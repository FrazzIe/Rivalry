local Spikes = {
	Model = "p_stinger_04",
	Spawned = false,
	Tyres = {
		[1] = {Bone = "wheel_lf", Index = 0},
		[2] = {Bone = "wheel_rf", Index = 1},
		[3] = {Bone = "wheel_lm", Index = 2},
		[4] = {Bone = "wheel_rm", Index = 3},
		[5] = {Bone = "wheel_lr", Index = 4},
		[6] = {Bone = "wheel_rr", Index = 5},
	},
	Handles = {},
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Spikes.Spawned then
			for Index = 0, 32 do
				if NetworkIsPlayerActive(Index) then
					local TargetPed = GetPlayerPed(Index)
					
					if DoesEntityExist(TargetPed) then
						local Vehicle = GetVehiclePedIsUsing(TargetPed)
						
						if DoesEntityExist(Vehicle) then
							local VehiclePosition = GetEntityCoords(Vehicle, false)
							local Spikestrip = GetClosestObjectOfType(VehiclePosition.x, VehiclePosition.y, VehiclePosition.z, 30.0, GetHashKey(Spikes.Model), false, 1, 1)
							
							if DoesEntityExist(Spikestrip) then
								local SpikestripPosition = GetEntityCoords(Spikestrip, false)
								local Distance = Vdist(VehiclePosition.x, VehiclePosition.y, VehiclePosition.z, SpikestripPosition.x, SpikestripPosition.y, SpikestripPosition.z)
								
								if Distance < 15 then
									for Wheel = 1, #Spikes.Tyres do
										local TyrePosition = GetWorldPositionOfEntityBone(Vehicle, GetEntityBoneIndexByName(Vehicle, Spikes.Tyres[Wheel].Bone))
										
										Distance = Vdist(TyrePosition.x, TyrePosition.y, TyrePosition.z, SpikestripPosition.x, SpikestripPosition.y, SpikestripPosition.z)
										
										if Distance < 1.8 then
											if not IsVehicleTyreBurst(Vehicle, Spikes.Tyres[Wheel].Index, true) or IsVehicleTyreBurst(Vehicle, Spikes.Tyres[Wheel].Index, false) then
												SetVehicleTyreBurst(Vehicle, Spikes.Tyres[Wheel].Index, false, 1000.0)
												TriggerServerEvent("Spikes.Burst", GetPlayerServerId(Index), Spikes.Tyres[Wheel].Index)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("Spikes.Burst")
AddEventHandler("Spikes.Burst", function(Tyre)
	SetVehicleTyreBurst(GetVehiclePedIsUsing(Player.Ped), Tyre, false, 1000.0)
end)

RegisterNetEvent("Spikes.Create")
AddEventHandler("Spikes.Create", function(Amount)
	if not Spikes.Spawned then
		local Model = GetHashKey(Spikes.Model)

		RequestModel(Model)
		
		while not HasModelLoaded(Model) do
			Citizen.Wait(250)
		end

		for Index = 1, 3 do
			local SpikePlacement = GetOffsetFromEntityInWorldCoords(Player.Ped, 0.0, 4.0 * Index + 0.5, 0.0)
			local Spike = CreateObject(Model, SpikePlacement.x, SpikePlacement.y, SpikePlacement.z, true, false, false)
			local SpikeHeight = GetEntityHeightAboveGround(Spike)
			
			SetEntityCoords(Spike, SpikePlacement.x, SpikePlacement.y, SpikePlacement.z - SpikeHeight + 0.05, 0.0, 0.0, 0.0, 0.0)
			SetEntityHeading(Spike, Player.Heading)
			SetEntityCollision(Spike, false, false)
			
			table.insert(Spikes.Handles, Spike)
		end

		SetModelAsNoLongerNeeded(Model)
		
		Spikes.Spawned = true
	else
		for Index = 1, #Spikes.Handles do
			DestroyObject(Spikes.Handles[Index])
		end
		
		Spikes.Handles = {}
		Spikes.Spawned = false
	end
end)
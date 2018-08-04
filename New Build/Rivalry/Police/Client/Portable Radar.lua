local PortableRadar = {
	Model = "prop_cctv_pole_01a",
	Spawned = false,
	Blip = nil,
	Handle = nil,
	Position = {},
	Animation = {
		Dictionary = "anim@apt_trans@garage", 
		Place = "gar_open_1_left",
	},
	Limit = nil,
}

AddAnimDictionary(PortableRadar.Animation.Dictionary)

Citizen.CreateThread(function()
	local CurrentInfo, LastInfo = "", ""
	local CurrentWidth, LastWidth = 0, 0
	local CurrentVehicle, LastVehicle = nil, nil

	while true do
		Citizen.Wait(0)
		if PortableRadar.Spawned then
			if DoesEntityExist(PortableRadar.Handle) then
				local RadarViewAngle = GetOffsetFromEntityInWorldCoords(PortableRadar.Handle, -8.0, -4.4, 0.0)
				local NearestPlayer, NearestPed, NearestVehicle, VehiclePosition = GetNearestPlayerVehicleAtCoords(RadarViewAngle.x, RadarViewAngle.y, RadarViewAngle.z, 20)
				
				if DoesEntityExist(NearestVehicle) then
					local Plate, Speed, Name = GetVehicleNumberPlateText(NearestVehicle), math.ceil(GetEntitySpeed(NearestVehicle) * 2.236936), GetVehicleName(GetEntityModel(NearestVehicle))
					
					if Speed > PortableRadar.Limit then
						if LastVehicle ~= NearestVehicle then
							LastInfo = string.format("Plate: ~y~%s\n~w~Model: %s\nSpeed: ~r~%s", Plate, Name, Speed)
							LastWidth = UI.GetLargestStringWidth(0, 0.35, "Plate: "..Plate, "Model: "..Name, "Speed: "..Speed)
							
							if not DoesBlipExist(GetBlipFromEntity(NearestVehicle)) then
								Citizen.CreateThread(function()
									local Tracker = CreateEntityBlip("Speeder", 225, 1, NearestVehicle, 0.6, false)
									local StartTime = GetGameTimer()
									
									while StartTime + 120000 > GetGameTimer() do
										Citizen.Wait(1000)
									end
									
									DeleteEntityBlip(Tracker)
								end)
							end
						end
					else
						if NearestVehicle ~= CurrentVehicle then
							CurrentInfo = string.format("Plate: ~y~%s\n~w~Model: %s\nSpeed: %s", Plate, Name, Speed)
							CurrentWidth = UI.GetLargestStringWidth(0, 0.35, "Plate: "..Plate, "Model: "..Name, "Speed: "..Speed)
						end
					end
				end
				
				UI.RenderRectangle(1600, 100, CurrentWidth, 84, 0, 0, 0, 255)
				UI.RenderText(CurrentInfo, 1600, 100, 0.35, 255, 255, 255, 255, 0, nil, false, false, nil)

				if LastInfo ~= "" then
					UI.RenderRectangle(1600, 200, LastWidth, 84, 0, 0, 0, 255)
					UI.RenderText(LastInfo, 1600, 200, 0.35, 255, 255, 255, 255, 0, nil, false, false, nil)
				end
			else
				TriggerEvent("PortableRadar.Delete")
			end
		end
	end
end)

RegisterNetEvent("PortableRadar.Create")
AddEventHandler("PortableRadar.Create", function(Speed)
	if not PortableRadar.Spawned then
		if not PortableRadar.Spawning then
			PortableRadar.Spawning = true
			
			local RadarPlacement = GetOffsetFromEntityInWorldCoords(Player.Ped, 0, 1.5, 0)
			local RadarRotation = GetEntityRotation(Player.Ped)
			local Model = GetHashKey(PortableRadar.Model)

			TaskPlayAnim(Player.Ped, PortableRadar.Animation.Dictionary, PortableRadar.Animation.Place, 1.0, -1.0, 5000, 0, 1, true, true, true)

			Citizen.Wait(1500)

			RequestModel(Model)
			
			while not HasModelLoaded(Model) do
				Citizen.Wait(250)
			end

			PortableRadar.Handle = CreateObject(Model, RadarPlacement.x, RadarPlacement.y, RadarPlacement.z - 7.0, true, false, false)

			SetEntityRotation(PortableRadar.Handle, RadarRotation.x, RadarRotation.y, RadarRotation.z - 115.0)

			FreezeEntityPosition(PortableRadar.Handle, true)

			PortableRadar.Blip = CreateEntityBlip("Portable Radar", 380, 1, PortableRadar.Handle, 0.6, true)

			PortableRadar.Position = RadarPlacement
			PortableRadar.Limit = Speed
			PortableRadar.Spawned = true

			Notify("Radar placed!", 3000)
			
			PortableRadar.Spawning = false
		end
	else
		if Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, PortableRadar.Position.x, PortableRadar.Position.y, PortableRadar.Position.z) < 0.9 then
			if not PortableRadar.Deleting then
				PortableRadar.Deleting = true
				
				TaskPlayAnim(Player.Ped, PortableRadar.Animation.Dictionary, PortableRadar.Animation.Place, 1.0, -1.0, 5000, 0, 1, true, true, true)

				Citizen.Wait(2000)

				DeleteEntityBlip(PortableRadar.Blip)
				DestroyObject(PortableRadar.Handle)

				PortableRadar.Spawned = false

				Notify("Radar removed!", 3000)
				
				PortableRadar.Deleting = false
			end
		else
			Notify("You must be close to the radar to remove it!", 3000)
		end
	end
end)

AddEventHandler("PortableRadar.Delete", function()
	PortableRadar.Deleting = true
	
	DeleteEntityBlip(PortableRadar.Blip)
	DestroyObject(PortableRadar.Handle)

	PortableRadar.Spawned = false

	Notify("Radar removed!", 3000)
	
	PortableRadar.Deleting = false	
end)
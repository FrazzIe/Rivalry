DensityMultiplier = 1.15
Citizen.CreateThread(function()
    while true 
    	do
    		-- These natives has to be called every frame.
              SetVehicleDensityMultiplierThisFrame(0.5)
              SetPedDensityMultiplierThisFrame(0.3)
              SetRandomVehicleDensityMultiplierThisFrame(0.3)
              SetParkedVehicleDensityMultiplierThisFrame(0.3)
              SetScenarioPedDensityMultiplierThisFrame(0.03, 0.3)
              for i = 1, 32 do
                Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
              end
		
		-- These natives do not have to be called everyframe.
		SetGarbageTrucks(1)
		SetRandomBoats(1)
    	
		Citizen.Wait(1)
	end

end)
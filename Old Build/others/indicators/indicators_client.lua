RegisterNetEvent( "MSQVehicleIndicator" )
RegisterNetEvent( "MSQVehicleWindow" )
-- MSQ event. Called when any player switches the turn indicator on or off
-- @param1	integer		PlayerID
-- @param2	integer		1 for left, 0 for right
-- @param3	boolean		whether turn indicator is on
-- @return
AddEventHandler( "MSQVehicleIndicator", function( playerID, dir, state )
	SetVehicleIndicatorLights( GetVehiclePedIsIn( GetPlayerPed( GetPlayerFromServerId( playerID ) ), false ), dir, state )
end)

-- MSQ event. Called when any player rolls down the vehicle windows
-- @param1	integer		PlayerID
-- @param2	boolean		true for windows down, false for windows up
-- @return
AddEventHandler( "MSQVehicleWindow", function( playerID, windowsDown )
	local vehicle = GetVehiclePedIsIn( GetPlayerPed( GetPlayerFromServerId( playerID ) ), false )
	
	if windowsDown then
		RollDownWindow( vehicle, 0 )
		RollDownWindow( vehicle, 1 )
	else
		RollUpWindow( vehicle, 0 )
		RollUpWindow( vehicle, 1 )
	end
end)

-- Reborn event. Called when the client spawns into the map
-- @param1
-- @return
AddEventHandler( "onClientMapStart", function()
	TriggerServerEvent( "MSQonClientMapStart" )
end)

local phone = false
-- Additional Sync High Priority Loop
Citizen.CreateThread( function()
	while true do
		Wait( 0 )
		
		local pressedUp = config.vehicleWindowSync and IsControlJustPressed( keybinds.windows.inputGroup, keybinds.windows.up ) or false
		local pressedDown = config.vehicleWindowSync and IsControlJustPressed( keybinds.windows.inputGroup, keybinds.windows.down ) or false
		local pressedLeft = config.vehicleIndicatorSync and IsControlJustPressed( keybinds.indicators.inputGroup, keybinds.indicators.left ) or false
		local pressedRight = config.vehicleIndicatorSync and IsControlJustPressed( keybinds.indicators.inputGroup, keybinds.indicators.right ) or false
		
		if pressedLeft or pressedRight or pressedUp or pressedDown then
			local ped = GetPlayerPed( -1 )
			
			if IsPedInAnyVehicle( ped, true ) then
				local vehicle = GetVehiclePedIsIn( ped, false )
				
				if GetPedInVehicleSeat( vehicle, -1 ) == ped then

						if pressedLeft then
							vehicleState.indicator.left = not vehicleState.indicator.left
							TriggerServerEvent( "MSQSetVehicleIndicator", 1, vehicleState.indicator.left )
						end
						
						if pressedRight then
							vehicleState.indicator.right = not vehicleState.indicator.right
							TriggerServerEvent( "MSQSetVehicleIndicator", 0, vehicleState.indicator.right )
						end
						
						if pressedUp then
							vehicleState.windowsDown = false
							TriggerServerEvent( "MSQSetVehicleWindow", vehicleState.windowsDown )
						end
						
						if pressedDown then
							vehicleState.windowsDown = true
							TriggerServerEvent( "MSQSetVehicleWindow", vehicleState.windowsDown )
						end

				end
			end
		end
		
	end
end)

config={}
keybinds={indicators={},windows={}}

config.vehicleIndicatorSync = true
config.vehicleWindowSync = true

keybinds.indicators.inputGroup = 1	-- Default: "Look" mode (1)
keybinds.indicators.left = 174		-- Default: Left arrow key (174)
keybinds.indicators.right = 175		-- Default: Right arrow key (175)

keybinds.windows.inputGroup = 1		-- Default: "Look" mode (1)
keybinds.windows.up = 27			-- Default: Up arrow key (27)
keybinds.windows.down = 173			-- Default: Down arrow key (173)

vehicleState = {
	windowsDown = false,
	indicator = {
		left = false,
		right = false
	}
}
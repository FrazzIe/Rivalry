RegisterServerEvent( "MSQSetVehicleIndicator" )
RegisterServerEvent( "MSQSetVehicleWindow" )

AddEventHandler( "MSQSetVehicleIndicator", function( dir, state )
	TriggerClientEvent( "MSQVehicleIndicator", -1, source, dir, state )
end)

-- MSQ event. Called when a client rolls down the vehicle's windows
-- @param1	boolean		Whether the windows are down (down = true)
-- @return
AddEventHandler( "MSQSetVehicleWindow", function( windowsDown )
	TriggerClientEvent( "MSQVehicleWindow", -1, source, windowsDown )
end)
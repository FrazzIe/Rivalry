--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
AddEventHandler("frfuel:fuelAdded", function(added_fuel)
	local ped = PlayerPedId()
	local vehicle = nil
	if IsPedSittingInAnyVehicle() then
		vehicle = GetVehiclePedIsIn(ped, false)
	else
		vehicle = GetVehiclePedIsIn(ped, true)
	end
	if vehicle ~= nil and vehicle ~= 0 then
		local max_fuel = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fPetrolTankVolume")
		local current_fuel = DecorGetFloat(vehicle, "_Fuel_Level")
		local previous_fuel = current_fuel - added_fuel

		TriggerServerEvent("fuel:pay", vehicle, max_fuel, previous_fuel, added_fuel)
	end
end)

RegisterNetEvent("fuel:remove")
AddEventHandler("fuel:remove", function(vehicle, previous_fuel)
	DecorSetFloat(vehicle, "_Fuel_Level", previous_fuel)
end)
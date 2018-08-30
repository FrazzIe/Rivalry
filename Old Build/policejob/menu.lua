--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
mission_list = {}
local charges = {
    {title="1st Degree Felonies", items = {
        {charge="Aggravated Murder of LEO", time=15, cost=9000},
        {charge="Attempted Murder of LEO", time=14, cost=8400},
        {charge="Felony Murder", time=12, cost=7200},
        {charge="Attempted Murder", time=10, cost=6000},
        {charge="Kidnapping", time=10, cost=6000},
        {charge="Aggravated Armed Robbery", time=10, cost=6000},
        {charge="Armed Bank Robbery", time=10, cost=6000},
        {charge="Grand Theft Auto", time=8, cost=5000},
        {charge="Racketeering", time=10, cost=6000},
    }},
    {title="2nd Degree Felonies", items = {
        {charge="Possession of CDS w/ Intent to Distribute (Cannabis 11+)", time=10, cost=10000},
        {charge="Possession of CDS w/ Intent to Distribute (Cannabis 30+)", time=10, cost=15000},
        {charge="Possession of CDS w/ Intent to Distribute (Cannabis 60+)", time=10, cost=20000},
        {charge="Possession of CDS w/ Intent to Distribute (Cannabis 120+)", time=10, cost=25000},
        {charge="Possession of CDS w/ Intent to Distribute (Cocaine 0-30)", time=10, cost=15000},
        {charge="Possession of CDS w/ Intent to Distribute (Cocaine 30+)", time=10, cost=20000},
        {charge="Possession of CDS w/ Intent to Distribute (Cocaine 60+)", time=10, cost=25000},
        {charge="Possession of CDS w/ Intent to Distribute (Cocaine 120+)", time=10, cost=30000},
        {charge="Drug Trafficking (CDS in vehicle)", time=5, cost=5000},
        {charge="Sale of CDS", time=4, cost=3000},
        {charge="Manslaughter", time=10, cost=6000},
        {charge="Negligent Homicide", time=7, cost=4200},
        {charge="Vehicular Manslaughter", time=7, cost=4200},
        {charge="Attempted Kidnapping", time=8, cost=4800},
        {charge="Felonious Restraint", time=6.66, cost=4000},
        {charge="Grand Theft", time=7, cost=4200},
        {charge="Robbery", time=7, cost=4200},
        {charge="Petty Theft with Prior", time=8.33, cost=5000},
        {charge="Petty Theft", time=6.5, cost=3900},
        {charge="Escape While Armed", time=7, cost=4200},
    }},
    {title="3rd Degree Felonies", items = {
        {charge="Aggravated Assault", time=7, cost=4200},
        {charge="Hit and Run With Injuries", time=10, cost=6000},
        {charge="Poss. of Class 2 Illegal Firearm/Weapon", time=10, cost=6000},
        {charge="Poss. of Firearm by Convicted Violent Felon", time=8.33, cost=5000},
        {charge="Identity Theft by a Convicted Felon", time=7, cost=4200},
        {charge="Attempted or Unarmed Robbery", time=7, cost=4200},
        {charge="Perjury", time=6.5, cost=3900},
        {charge="Attempted Bribery", time=7, cost=4200},
        {charge="Fleeing/Eluding Law Enforcement (Death/Injury)", time=7, cost=4200},
        {charge="Escape", time=6.5, cost=3900},
        {charge="Rioting", time=8, cost=4800},
        {charge="Cultivation of CDS (0-30)", time=3.33, cost=5000},
        {charge="Cultivation of CDS (30-60)", time=3.33, cost=10000},
        {charge="Cultivation of CDS (60+)", time=3.33, cost=15000},
    }},
    {title="1st Degree Misdemeanors", items = {
        {charge="Aiding and Abetting", time=5, cost=3000},
        {charge="Assault", time=5, cost=3000},
        {charge="Attempted Grand Theft Auto", time=5, cost=3000},
        {charge="Contempt of Court", time=20, cost=25000},
        {charge="Obstruction of Justice", time=6.5, cost=3900},
        {charge="Damage to State Property", time=6.5, cost=3900},
        {charge="Fleeing/Eluding Law Enforcement", time=5, cost=3000},
        {charge="Money Laundering", time=5, cost=3000},
        {charge="Negligent Discharge of Firearm in Public", time=5, cost=3000},
        {charge="False Imprisonment", time=6.66, cost=4000},
        {charge="Domestic Violence", time=5, cost=3000},
        {charge="Threat of Bodily Harm", time=5, cost=3000},
        {charge="Reckless Endangerment", time=8, cost=4800},
        {charge="Hit and Run No Injuries", time=5, cost=3000},
        {charge="Criminal Trespass", time=5, cost=3000},
        {charge="Identity Theft", time=5, cost=3000},
        {charge="Tampering With Evidence", time=6.5, cost=3900},
        {charge="False Identification", time=5, cost=3000},
        {charge="Misuse of 911", time=5, cost=3000},
        {charge="Misuse of Taser/Wasting Police Resources", time=5, cost=3000},
        {charge="Indecent Exposure", time=5, cost=3000},
        {charge="Extortion/Blackmail", time=5, cost=3000},
        {charge="Prostitution", time=5, cost=3000},
        {charge="Gambling", time=5, cost=3000},
        {charge="Social Media Hate Crime", time=10, cost=6000},
        {charge="Conspiracy", time=10, cost=6000},
        {charge="False Personation", time=6.66, cost=4000},

    }},
    {title="2nd Degree Misdemeanors", items = {
        {charge="Reckless Driving", time=5, cost=3000},
        {charge="Poss. of Stolen Vehicle", time=5, cost=3000},
        {charge="Damage to Public Property", time=5, cost=3000},
        {charge="Damage to Private Property", time=2, cost=2500},
        {charge="Poss. of Burglary Tools", time=5, cost=3000},
        {charge="Poss. of Weapon w/ Criminal Intent", time=5, cost=3000},
        {charge="Poss. of Illegal Contraband", time=5, cost=3000},
        {charge="Failure to Obey a Lawful Order", time=5, cost=3000},
        {charge="Illegal Brandishing of Firearm", time=5, cost=3000},
        {charge="Defamation", time=5, cost=3000},
    }},
    {title="3rd Degree Misdemeanors", items = {
        {charge="Resisting Arrest", time=5, cost=3000},
        {charge="Loitering (Non-optional Fine)", time=0, cost=1500},
        {charge="Failure to Inform of Concealed Weapon (Non-optional Fine)", time=0, cost=3000},
        {charge="Disorderly Conduct", time=2, cost=1500},
        {charge="Poss. of Firearm w/o a Weapons License", time=5, cost=3000},
        {charge="Disturbing the Peace (Non-optional Fine)", time=0, cost=3000},
        {charge="Harassment (Non-optional Fine)", time=0, cost=3000},
        {charge="Domestic Disturbence (Non-optional Fine)", time=0, cost=3000},
        {charge="Jay Walking (Non-optional Fine)", time=0, cost=1500},
    }},
    {title="DOJ/License", items = {
        {charge="Weapons License", time=0, cost=10000},
        {charge="Drivers License", time=0, cost=2500},
        {charge="Release of Information", time=0, cost=7500},
    }},
    {title="Traffic Violations", items = {
        {charge="Failure to Stop - Red Light", time=0, cost=750},
        {charge="Failure to Stop - Stop Sign", time=0, cost=500},
        {charge="No insurance/Expired Registration", time=0, cost=500},
        {charge="Speeding 10-29mph Over", time=0, cost=1500},
        {charge="Speeding 30mph+ Over", time=0, cost=2500},
        {charge="Careless Driving", time=0, cost=500},
        {charge="Illegal U-turn", time=0, cost=500},
        {charge="Illegal Window Tint", time=0, cost=500},
        {charge="Fail to Yield to Emergency Services", time=0, cost=500},
        {charge="Fail to Give Right of Way", time=0, cost=500},
        {charge="Failure to Signal", time=0, cost=500},
        {charge="Broken Tail Light", time=0, cost=500},
        {charge="Broken Head Light", time=0, cost=500},
        {charge="Illegal Parking", time=0, cost=500},
        {charge="Parked Near Fire Hydrant", time=0, cost=500},
        {charge="Fail to Yield to Pedestrian", time=0, cost=500},
        {charge="Failure to Obey LEO Signals", time=0, cost=500},
        {charge="Improper/Unsafe Turn", time=0, cost=500},
        {charge="Improper/Missing Plate", time=0, cost=500},
        {charge="Wrong Way", time=0, cost=500},
        {charge="Improper/Illegal Pass", time=0, cost=500},
    }},
}

local activeMedics = 0
--[[ Main Menu ]]--
AddEventHandler("police:menu", function()
	TriggerServerEvent('police:requestMission')
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Citizen", [[TriggerEvent("police:menu_citizen")]])
	exports.ui:addOption("Vehicle", [[TriggerEvent("police:menu_vehicle")]])
	exports.ui:addOption("Placeables", [[TriggerEvent("police:menu_placeables")]])
	exports.ui:addOption("Missions", [[TriggerEvent("police:menu_missions")]])
	exports.ui:addOption("Processing", [[TriggerEvent("police:menu_processing")]])
	exports.ui:back([[TriggerEvent("interaction:main")]])
end)
--[[ Citizen ]]--
AddEventHandler("police:menu_citizen", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Freeze cuff", [[TriggerEvent("police:menu_citizen_cuffing", "freeze")]])
	exports.ui:addOption("Normal cuff", [[TriggerEvent("police:menu_citizen_cuffing", "normal")]])
	exports.ui:addOption("Drag", [[TriggerEvent("police:menu_citizen_drag")]])
	exports.ui:addOption("Put in vehicle", [[TriggerEvent("police:menu_citizen_force", "in")]])
	exports.ui:addOption("Take out of vehicle", [[TriggerEvent("police:menu_citizen_force", "out")]])
	exports.ui:addOption("Search", [[TriggerEvent("police:menu_citizen_search")]])
	exports.ui:addOption("Seize", [[TriggerEvent("police:menu_citizen_seize")]])
	exports.ui:addOption("Breathalyzer", [[TriggerEvent("police:menu_citizen_breathalyzer")]])
	exports.ui:addOption("Gun residue", [[TriggerEvent("police:menu_citizen_gun_residue")]])
	exports.ui:addOption("Supply user with a weapon license", [[TriggerEvent("police:menu_citizen_give_license")]])
	if activeMedics == 0 then
		exports.ui:addOption("Revive", [[TriggerEvent("paramedic:menu_revive")]])
	end
	exports.ui:back([[TriggerEvent("police:menu")]])
end)

AddEventHandler("police:menu_citizen_cuffing", function(type)
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	TriggerServerEvent("police:cuff", GetPlayerServerId(t), type)
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("police:menu_citizen_drag", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	TriggerServerEvent("police:drag", GetPlayerServerId(t))
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

AddEventHandler("police:menu_citizen_force", function(type)
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	TriggerServerEvent("police:force", GetPlayerServerId(t), type)
    else
        Notify("Please get closer to the target!", 2500)
    end
end)

--[[ Search ]]--
AddEventHandler("police:menu_citizen_search", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Inventory", [[TriggerEvent("police:menu_citizen_search_execute", "inventory")]])
	exports.ui:addOption("Weapons", [[TriggerEvent("police:menu_citizen_search_execute", "weapons")]])
	exports.ui:addOption("Weapon License", [[TriggerEvent("police:menu_citizen_search_execute", "wl")]])
	exports.ui:addOption("Drivers License", [[TriggerEvent("police:menu_citizen_search_execute", "dl")]])
	exports.ui:addOption("Identification", [[TriggerEvent("police:menu_citizen_search_execute", "id")]])
	exports.ui:addOption("Wallet", [[TriggerEvent("police:menu_citizen_search_execute", "wallet")]])
	exports.ui:back([[TriggerEvent("police:menu_citizen")]])
end)

AddEventHandler("police:menu_citizen_search_execute", function(type)
	exports.ui:open()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:search", GetPlayerServerId(t), type)
	else
		Notify("Please get closer to the target!", 2500)
	end
end)

--[[ Seize ]]--
AddEventHandler("police:menu_citizen_seize", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Inventory", [[TriggerEvent("police:menu_citizen_seize_execute", "inventory")]])
	exports.ui:addOption("Weapons", [[TriggerEvent("police:menu_citizen_seize_execute", "weapons")]])
	exports.ui:addOption("Weapon License", [[TriggerEvent("police:menu_citizen_seize_execute", "wl")]])
	exports.ui:addOption("Drivers License", [[TriggerEvent("police:menu_citizen_seize_execute", "dl")]])
	exports.ui:addOption("Wallet", [[TriggerEvent("police:menu_citizen_seize_execute", "wallet")]])
    exports.ui:addOption("Phone", [[TriggerEvent("police:menu_citizen_seize_execute", "phone")]])
	exports.ui:back([[TriggerEvent("police:menu_citizen")]])
end)

AddEventHandler("police:menu_citizen_seize_execute", function(type)
	exports.ui:open()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		if type == "weapons" then
			RemoveAllPedWeapons(GetPlayerPed(t), 0)
		end
		TriggerServerEvent("police:seize", GetPlayerServerId(t), type)
	else
		Notify("Please get closer to the target!", 2500)
	end
end)

AddEventHandler("police:menu_citizen_breathalyzer", function()
	exports.ui:open()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		local isBACActive = DecorGetBool(GetPlayerPed(t), "BAC_Active")
		if isBACActive then
			Notify("Subject tested <b style='color:red'>Positive</b> <br>Their blood-alcohol concentration is outside the legal limits", 3000)
		else
			Notify("Subject tested <b style='color:lime'>Negative</b> <br>Their blood-alcohol concentration is inside the legal limits", 3000)
		end
	else
		Notify("Please get closer to the target!", 2500)
	end 
end)

AddEventHandler("police:menu_citizen_gun_residue", function()
	exports.ui:open()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		isGSRactive = DecorGetBool(GetPlayerPed(t), "GSR_Active")
		if isGSRactive then
			Notify("Subject tested <b style='color:red'>Positive</b><br>They have discharged a firearm recently!", 3000)
		else
			Notify("Subject tested <b style='color:lime'>Negative</b><br>They haven't discharged a firearm recently!", 3000)
		end
	else
		Notify("Please get closer to the target!", 2500)
	end
end)

AddEventHandler("police:menu_citizen_give_license", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	TriggerServerEvent("weapon:givelicense", GetPlayerServerId(t))
    else
        Notify("Please get closer to the target!", 2500)
    end
end)
--[[ Vehicle ]]--
AddEventHandler("police:menu_vehicle", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Fix", [[TriggerEvent("police:fix_vehicle")]])
	exports.ui:addOption("Clean", [[TriggerEvent("police:clean_vehicle")]])
	exports.ui:addOption("Check owner", [[TriggerEvent("police:check_plate")]])
	exports.ui:addOption("Search", [[TriggerEvent("police:menu_vehicle_search")]])
	exports.ui:addOption("Seize", [[TriggerEvent("police:menu_vehicle_seize")]])
	exports.ui:addOption("Impound", [[TriggerEvent("police:menu_vehicle_impound", 0)]])
	exports.ui:addOption("Impound ($5000)", [[TriggerEvent("police:menu_vehicle_impound", 5000)]])
	exports.ui:back([[TriggerEvent("police:menu")]])
end)

AddEventHandler("police:fix_vehicle", function()
	if not IsPedSittingInAnyVehicle(PlayerPedId()) then
		local pos = GetEntityCoords(PlayerPedId(), false)
		local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			TaskPlayAnim(PlayerPedId(), "mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)  
			Citizen.Wait(20000)
			ClearPedTasks(PlayerPedId())
			SetVehicleFixed(vehicleHandle)
		else
			Notify("Couldn't find a vehicle!", 2500)
		end
	else
		Notify("You cannot repair while in the vehicle", 2500)
	end
end)

AddEventHandler("police:clean_vehicle", function()
	if not IsPedSittingInAnyVehicle(PlayerPedId()) then
		local pos = GetEntityCoords(PlayerPedId(), false)
		local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			SetVehicleDirtLevel(vehicleHandle, 0)
			Notify("Vehicle cleaned!", 2500)
		else
			Notify("Couldn't find a vehicle!", 2500)
		end
	else
		local vehicleHandle = GetVehiclePedIsUsing(PlayerPedId())
		SetVehicleDirtLevel(vehicleHandle, 0)
		Notify("Vehicle cleaned!", 2500)
	end
end)

AddEventHandler("police:check_plate", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

	if vehicleHandle ~= nil then
		TriggerServerEvent("police:check_plate", GetVehicleNumberPlateText(vehicleHandle))
	else
		Notify("Couldn't find a vehicle!", 2500)
	end
end)

AddEventHandler("police:menu_vehicle_search", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Inventory", [[TriggerEvent("police:menu_vehicle_search_execute", "inventory")]])
	exports.ui:addOption("Weapons", [[TriggerEvent("police:menu_vehicle_search_execute", "weapons")]])
	exports.ui:back([[TriggerEvent("police:menu_vehicle")]])
end)

AddEventHandler("police:menu_vehicle_search_execute", function(type)
	exports.ui:open()
	local pos = GetEntityCoords(PlayerPedId(), false)
	local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
	if vehicleHandle ~= nil then
		TriggerServerEvent("police:search_vehicle", GetVehicleNumberPlateText(vehicleHandle), type)
	else
		Notify("Couldn't find a vehicle!", 2500)
	end
end)

--[[ Seize ]]--
AddEventHandler("police:menu_vehicle_seize", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Inventory", [[TriggerEvent("police:menu_vehicle_seize_execute", "inventory")]])
	exports.ui:addOption("Weapons", [[TriggerEvent("police:menu_vehicle_seize_execute", "weapons")]])
	exports.ui:back([[TriggerEvent("police:menu_vehicle")]])
end)

AddEventHandler("police:menu_vehicle_seize_execute", function(type)
	exports.ui:open()
	local pos = GetEntityCoords(PlayerPedId(), false)
	local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
	if vehicleHandle ~= nil then
		TriggerServerEvent("police:seize_vehicle", GetVehicleNumberPlateText(vehicleHandle), type)
	else
		Notify("Couldn't find a vehicle!", 2500)
	end
end)

RegisterNetEvent("police:menu_vehicle_impound")
AddEventHandler("police:menu_vehicle_impound", function(_amount)
    if isInService then
    	local pos = GetEntityCoords(PlayerPedId(), false)
    	local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
    	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

    	if vehicleHandle ~= nil then
    		TriggerServerEvent("police:impound", GetVehicleNumberPlateText(vehicleHandle), _amount)
            DestroyVehicle(vehicleHandle)
    	else
    		Notify("Couldn't find a vehicle!", 2500)
    	end
    end
end)
--[[ Placeables ]]--
AddEventHandler("police:menu_placeables", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Toggle spikes", [[TriggerEvent("Spikes.Create", 3)]])
	exports.ui:addOption("Toggle camera", [[TriggerEvent("PortableRadar.Create")]])
	exports.ui:addOption("Toggle cones", [[TriggerEvent("police:DeployC")]])
	exports.ui:back([[TriggerEvent("police:menu")]])
end)
--[[ Missions ]]--
AddEventHandler("police:menu_missions", function()
	exports.ui:reset()
	exports.ui:open("police:missions")
    for k,v in pairs(mission_list) do
   		exports.ui:addOption(v.name, v.event, v.mission)
    end
    exports.ui:back([[TriggerEvent("police:menu")]])
end)
--[[ Processing ]]--
AddEventHandler("police:menu_processing", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Optional fine", [[TriggerEvent("police:fine_input", "optional")]])
	exports.ui:addOption("Non-optional fine", [[TriggerEvent("police:fine_input", "forced")]])
	exports.ui:addOption("Jail", [[TriggerEvent("police:jail_input")]])
	exports.ui:addOption("Charges", [[TriggerEvent("police:menu_charges")]])
	exports.ui:addOption("MDT", [[TriggerEvent("mdt:open")]])
	exports.ui:back([[TriggerEvent("police:menu")]])
end)

AddEventHandler("police:fine_input", function(_type)
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		local amount = tonumber(KeyboardInput("Enter amount:", AutoFill().cost, 11))
		if amount ~= nil and amount >= 0 then
			if _type == "optional" then
				TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), amount)
			elseif _type == "forced" then
				TriggerServerEvent("police:finesForced", GetPlayerServerId(t), amount)
			end
		end
	else
		Notify("Please get closer to the target!", 2500)
	end
end)

AddEventHandler("police:jail_input", function()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		local amount = tonumber(KeyboardInput("Enter time:", AutoFill().time, 11))
		local reason = tostring(KeyboardInput("Enter reasons:", AutoFill().charges, 1000))
		if amount ~= nil and amount >= 0 and reason ~= nil then
			TriggerServerEvent("jail:user", GetPlayerServerId(t), amount, reason)
		end
	else
		Notify("Please get closer to the target!", 2500)
	end
end)

AddEventHandler("mdt:open", function()
	openGui()
end)

--[[ Charges ]]--
AddEventHandler("police:menu_charges", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Add Charges", [[TriggerEvent("police:menu_subcharges")]])
	exports.ui:addOption("Review Charges", [[TriggerEvent("police:review_charge")]])
	exports.ui:addOption("Apply Charges", [[TriggerEvent("police:apply_charge")]])
	exports.ui:addOption("Clear Charges", [[TriggerEvent("police:clear_charge")]])
	exports.ui:back([[TriggerEvent("police:menu_processing")]])
end)

AddEventHandler("police:menu_subcharges", function()
	exports.ui:reset()
	exports.ui:open()
	for k,v in pairs(charges) do
		exports.ui:addOption(v.title, "police:menu_addcharges", v.items)
	end
	exports.ui:back([[TriggerEvent("police:menu_charges")]])
end)

AddEventHandler("police:menu_addcharges", function(items)
	exports.ui:reset()
	exports.ui:open()
	for k,v in pairs(items) do
		exports.ui:addOption(v.charge, "police:menu_addcharge", v)
	end
	exports.ui:back([[TriggerEvent("police:menu_subcharges")]])
end)

AddEventHandler("police:menu_addcharge", function(data)
	local current_charge = {charge = data.charge, time = data.time, cost = data.cost}
	local time = tonumber(KeyboardInput("Enter time (Months/Minutes):", tostring(data.time), 11))
	local cost = tonumber(KeyboardInput("Enter cost:", tostring(data.cost), 11))
	if time ~= nil and time >= 0 and cost ~= nil and cost >= 0 then
		current_charge.time = time
		current_charge.cost = cost
		TriggerEvent("police:add_charge", current_charge)
	end
	exports.ui:open()
end)
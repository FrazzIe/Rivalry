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
    {title="Federal Felonies", items = {
        {charge="Assassination", time=999999, cost=0},
        {charge="Murder of a Federal Employee", time=999999, cost=0},
        {charge="Attempted Murder of a Federal Employee", time=50, cost=40000},
        {charge="Assault on a Federal Employee", time=30, cost=20000},
        {charge="Manslaughter", time=20, cost=10000},
        {charge="Torture", time=80, cost=50000},
        {charge="Treason", time=999999, cost=0},
        {charge="Racketeering / RICO", time=999999, cost=0},
        {charge="Airplane/Helicopter Hijacking", time=40, cost=20000},
        {charge="Possession of Explosives", time=999999, cost=100000},
        {charge="Drive-by Shooting", time=15, cost=10000},
        {charge="Armed Federal Bank Robbery", time=25, cost=10000},
        {charge="Unarmed Federal Bank Robbery", time=15, cost=5000},
        {charge="Hostage Taking (Federal)", time=20, cost=10000},
        {charge="Declaration of Ransom", time=10, cost=10000},
        {charge="Human Trafficking", time=40, cost=20000},
        {charge="Forced Labor", time=30, cost=15000},
        {charge="Concealing Escaped Prisoner", time=15, cost=7500},
        {charge="Concealing Person From Arrest", time=15, cost=7500},
        {charge="Stalking (In violation of restraining order)", time=15, cost=7500},
        {charge="Contempt of Court", time=10, cost=5000},
        {charge="Perjury", time=100, cost=30000},
        {charge="Witness Tampering", time=100, cost=30000},
        {charge="Failure to Appear On Felony Offense", time=15, cost=15000},
        {charge="Failure to Follow Court Orders", time=15, cost=15000},
        {charge="Failure to Comply with Subpoena", time=15, cost=15000},
        {charge="Retaliating Against a Witness, Victim, or Informant", time=10, cost=10000},
        {charge="Retaliating Against a Justice/Judge by False Claim or Slander", time=10, cost=10000},
        {charge="False Declarations before Grand Jury or Court", time=10, cost=10000},
        {charge="Flight to Avoid Prosecution or Giving Testimony", time=10, cost=10000},
        {charge="Probation Violation", time=10, cost=10000},
        {charge="Bankruptcy Fraud", time=30, cost=0},
        {charge="Business Espionage", time=40, cost=50000},
        {charge="Blackmail", time=20, cost=10000},
        {charge="Extortion", time=20, cost=10000},
        {charge="Bribery", time=20, cost=10000},
        {charge="Possession of Counterfeit Currency ($75,000+)", time=20, cost=10000},
        {charge="Money Laundering", time=15, cost=10000},
        {charge="Fraud Against the Government", time=40, cost=50000},
        {charge="Identity Theft", time=60, cost=30000},
        {charge="False Personation of a Federal Employee", time=20, cost=10000},
        {charge="Disclosure of Confidential Information/Documents", time=60, cost=30000},
        {charge="Damage to Religious Property", time=20, cost=10000},
        {charge="Obstruction of Justice", time=10, cost=10000},
        {charge="Drug Smuggling", time=40, cost=40000},
        {charge="Child Abuse", time=25, cost=20000},
        {charge="Arson", time=20, cost=20000},
        {charge="Conspiracy to Commit Federal Felony", time=0, cost=0},
        {charge="Organ Harvesting", time=35, cost=20000},
        {charge="Organ Trafficking", time=35, cost=20000},
        {charge="Weapons Stockpiling", time=60, cost=35000},
        {charge="Poaching", time=20, cost=10000},
        {charge="Jailbreak", time=35, cost=30000},
        {charge="Terroristic Threat", time=30, cost=15000},
    }},
    {title="1st Degree Felonies", items = {
        {charge="Aggravated Murder of LEO", time=999999, cost=80000},
        {charge="Attempted Murder of LEO", time=30, cost=10000},
        {charge="Felony Murder", time=999999, cost=40000},
        {charge="Attempted Murder", time=25, cost=10000},
        {charge="Kidnapping", time=15, cost=5000},
        {charge="Hostage Taking (State)", time=15, cost=5000},
        {charge="Aggravated Armed Robbery", time=15, cost=5000},
        {charge="Armed Bank Robbery", time=15, cost=5000},
        {charge="Grand Theft Auto", time=15, cost=5000},
    }},
    {title="2nd Degree Felonies", items = {
        {charge="Possession of CDS (Cannabis/Weed 11-19)", time=4, cost=4000},
        {charge="Possession of CDS (Cannabis/Weed 20-59)", time=8, cost=4000},
        {charge="Possession of CDS w/ Intent to Traffic (Cannabis/Weed 60-119)", time=12, cost=4000},
        {charge="Possession of CDS w/ Intent to Traffic (Cannabis/Weed 120-199)", time=16, cost=4000},
        {charge="Possession of CDS (Cocaine 1-29)", time=5, cost=4000},
        {charge="Possession of CDS (Cocaine 30-59)", time=10, cost=4000},
        {charge="Possession of CDS (Cocaine 60-119)", time=15, cost=4000},
        {charge="Possession of CDS (Cocaine 120-199)", time=20, cost=4000},
        {charge="Drug Trafficking", time=5, cost=4000},
        {charge="Sale of CDS", time=5, cost=4000},
        {charge="Manslaughter", time=12, cost=4000},
        {charge="Negligent Homicide", time=12, cost=4000},
        {charge="Vehicular Manslaughter", time=12, cost=4000},
        {charge="Attempted Kidnapping", time=12, cost=4000},
        {charge="Felonious Restraint", time=12, cost=4000},
        {charge="Grand Theft", time=12, cost=4000},
        {charge="Robbery", time=12, cost=4000},
        {charge="Petty Theft with Prior", time=12, cost=4000},
        {charge="Petty Theft", time=12, cost=4000},
        {charge="Escape While Armed", time=12, cost=4000},
        {charge="Animal Cruelty", time=12, cost=4000},
        {charge="Assault On LEO/EMS", time=12, cost=4000},
        {charge="Assault w/ Deadly", time=12, cost=4000},
    }},
    {title="3rd Degree Felonies", items = {
        {charge="Poss. of a Class 2 Illegal Firearm/Weapon", time=10, cost=3000},
        {charge="Illegal Sale/Transfer of Class 2 Firearm(s)", time=10, cost=3000},
        {charge="Poss. of Firearm by a Convicted Violent Felon", time=10, cost=3000},
        {charge="Driving Under The Influence", time=10, cost=3000},
        {charge="Hit and Run with Injuries", time=10, cost=3000},
        {charge="Felony Evading Law Enforcement (Vehicle)", time=10, cost=3000},
        {charge="Fleeing/Eluding (Death/Injury) (Vehicle)", time=10, cost=3000},
        {charge="Attempted or Unarmed Robbery", time=10, cost=3000},
        {charge="Attempted Bribery", time=10, cost=3000},
        {charge="Escape", time=10, cost=3000},
        {charge="Rioting", time=10, cost=3000},
        {charge="Aiding and Abetting In The Commission of a Felony", time=10, cost=3000},
        {charge="Felony Attempted Commission of an Offence/Crime", time=10, cost=3000},
        {charge="Possession or Distribution of Confidential Documents/Information", time=10, cost=3000},
        {charge="Felonious Trespassing", time=10, cost=3000},
        {charge="Smuggling ", time=10, cost=3000},
        {charge="Conspiracy to Commit State Felony", time=10, cost=3000},
    }},
    {title="1st Degree Misdemeanors", items = {
        {charge="Negligent Discharge of a Firearm/Weapon in Public", time=8, cost=2000},
        {charge="Reckless Endangerment", time=8, cost=2000},
        {charge="Assault", time=8, cost=2000},
        {charge="Threat of Bodily Harm", time=8, cost=2000},
        {charge="Domestic Violence", time=8, cost=2000},
        {charge="Contempt of Court", time=8, cost=2000},
        {charge="Obstruction of Justice", time=8, cost=2000},
        {charge="Damage to State Property", time=8, cost=2000},
        {charge="Poss. Of Stolen Property", time=8, cost=2000},
        {charge="Aiding and Abetting In The Commission of a Misdemeanor", time=8, cost=2000},
        {charge="Attempted Grand Theft Auto", time=8, cost=2000},
        {charge="Hit and Run No Injuries", time=8, cost=2000},
        {charge="Fleeing/Eluding Law Enforcement (On Foot)", time=8, cost=2000},
        {charge="Money Laundering", time=8, cost=2000},
        {charge="Gambling", time=8, cost=2000},
        {charge="Prostitution", time=8, cost=2000},
        {charge="False Identification", time=8, cost=2000},
        {charge="False Imprisonment", time=8, cost=2000},
        {charge="False Personation", time=8, cost=2000},
        {charge="Criminal Trespass", time=8, cost=2000},
        {charge="Breaking And Entering", time=8, cost=2000},
        {charge="Misuse of 911", time=8, cost=2000},
        {charge="Indecent Exposure", time=8, cost=2000},
        {charge="Social Media Hate Crime", time=8, cost=2000},
        {charge="Adultery", time=8, cost=2000},
    }},
    {title="2nd Degree Misdemeanors", items = {
        {charge="Reckless Driving", time=6, cost=1500},
        {charge="Poss. of Stolen Vehicle", time=6, cost=1500},
        {charge="Poss. of Counterfeit Currency", time=6, cost=1500},
        {charge="Damage to Public Property", time=6, cost=1500},
        {charge="Damage to Private Property", time=6, cost=1500},
        {charge="Poss. of Weapon w/ Criminal Intent", time=6, cost=1500},
        {charge="Poss. of Illegal Contraband", time=6, cost=1500},
        {charge="Failure to Obey a Lawful Order", time=6, cost=1500},
        {charge="Illegal Brandishing of Firearm", time=6, cost=1500},
        {charge="Defamation", time=6, cost=1500},
    }},
    {title="3rd Degree Misdemeanors", items = {
        {charge="Poss. of Firearm w/o a Weapon License", time=4, cost=1000},
        {charge="Poss. Of An Unregistered Firearm", time=4, cost=1500},
        {charge="Illegal Sale/Transfer of Non Class 2 Firearm(s)/Weapon(s)", time=4, cost=2000},
        {charge="Failure to Inform of Concealed Weapon", time=4, cost=500},
        {charge="Operating Motor Vehicle w/o Valid DL", time=4, cost=1000},
        {charge="Resisting Arrest", time=4, cost=1000},
        {charge="Disorderly Conduct", time=4, cost=700},
        {charge="Disturbing the Peace", time=4, cost=500},
        {charge="Domestic Disturbance", time=0, cost=300},
        {charge="Harassment", time=4, cost=400},
        {charge="Loitering", time=0, cost=300},
        {charge="Jay Walking", time=0, cost=100},
        {charge="Conspiracy To Commit State Misdemeanor", time=0, cost=0},
        {charge="Public Intoxication", time=4, cost=400},
        {charge="Failure to Identify", time=4, cost=400},
    }},
    {title="DOJ/License", items = {
        {charge="Weapons License", time=0, cost=1000},
        {charge="Drivers License", time=0, cost=150},
        {charge="Release of Information", time=0, cost=100},
    }},
    {title="Traffic Violations", items = {
        {charge="Failure to Stop - Red Light", time=0, cost=250},
        {charge="Failure to Stop - Stop Sign", time=0, cost=250},
        {charge="Speeding 5mph Over", time=0, cost=500},
        {charge="Speeding 10mph Over", time=0, cost=750},
        {charge="Speeding 20mph Over", time=0, cost=1000},
        {charge="Speeding 30+mph Over", time=0, cost=1500},
        {charge="Unroadworthy Vehicle", time=0, cost=500},
        {charge="Careless Driving", time=0, cost=1000},
        {charge="Illegal U-Turn", time=0, cost=250},
        {charge="Illegal Window Tint", time=0, cost=250},
        {charge="Failure to Yield to Emergency Services", time=0, cost=1000},
        {charge="No Insurance/Expired Registration", time=0, cost=250},
        {charge="Failure to Give Right of Way", time=0, cost=250},
        {charge="Failure to Signal", time=0, cost=250},
        {charge="Broken Tail Light", time=0, cost=250},
        {charge="Broken Head Light", time=0, cost=250},
        {charge="Illegal Parking", time=0, cost=250},
        {charge="Improper/Unsafe Turn", time=0, cost=250},
        {charge="Improper/Missing Plate", time=0, cost=250},
        {charge="Wrong Way of Travel", time=0, cost=250},
        {charge="Improper/Illegal Pass", time=0, cost=250},
        {charge="Use of Police/EMS Sirens", time=0, cost=250},
        {charge="Driving Without Headlights", time=0, cost=250},
        {charge="Obstructing Traffic", time=0, cost=250},
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
    exports.ui:addOption("Frisk", [[TriggerEvent("police:menu_citizen_frisk")]])
    exports.ui:addOption("Search", [[TriggerEvent("police:menu_citizen_search")]])
    exports.ui:addOption("Seize", [[TriggerEvent("police:menu_citizen_seize")]])
    exports.ui:addOption("Breathalyzer", [[TriggerEvent("police:menu_citizen_breathalyzer")]])
    exports.ui:addOption("Gun residue", [[TriggerEvent("police:menu_citizen_gun_residue")]])
    exports.ui:addOption("Supply user with a weapon license", [[TriggerEvent("police:menu_citizen_give_license")]])
    --exports.ui:addOption("Reinstate Drivers License", [[TriggerEvent("police:menu_citizen_give_drivers_license")]])
    if activeMedics == 0 then
        exports.ui:addOption("Revive", [[TriggerEvent("paramedic:menu_revive")]])
        exports.ui:addOption("Pronounce doa", [[TriggerEvent("paramedic:menu_doa")]])
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

AddEventHandler("police:menu_citizen_frisk", function()
    exports.ui:open()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:frisk", GetPlayerServerId(t))
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

AddEventHandler("police:menu_citizen_give_drivers_license", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("interaction:buy_drivers_license", GetPlayerServerId(t))
    else
        Notify("Please get closer to the target!", 2500)
    end
end)
--[[ Vehicle ]]--
AddEventHandler("police:menu_vehicle", function()
    exports.ui:reset()
    exports.ui:open()
    --exports.ui:addOption("Fix", [[TriggerEvent("police:fix_vehicle")]])
    --exports.ui:addOption("Clean", [[TriggerEvent("police:clean_vehicle")]])
    exports.ui:addOption("Check owner", [[TriggerEvent("police:check_plate")]])
    exports.ui:addOption("Search", [[TriggerEvent("police:menu_vehicle_search")]])
    exports.ui:addOption("Seize", [[TriggerEvent("police:menu_vehicle_seize")]])
    exports.ui:addOption("Impound", [[TriggerEvent("police:menu_vehicle_impound", 0)]])
    exports.ui:addOption("Impound ($3000)", [[TriggerEvent("police:menu_vehicle_impound", 3000)]])
    exports.ui:back([[TriggerEvent("police:menu")]])
end)

AddEventHandler("police:fix_vehicle", function()
    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
        local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
        local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)
        
        if DoesEntityExist(NearestVehicle.Handle) then
            TaskPlayAnim(PlayerPedId(), "mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)  
            Citizen.Wait(20000)
            ClearPedTasks(PlayerPedId())
            SetVehicleFixed(NearestVehicle.Handle)
        else
            Notify("Couldn't find a vehicle!", 2500)
        end
    else
        Notify("You cannot repair while in the vehicle", 2500)
    end
end)

AddEventHandler("police:clean_vehicle", function()
    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
        local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
        local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)
        
        if DoesEntityExist(NearestVehicle.Handle) then
            SetVehicleDirtLevel(NearestVehicle.Handle, 0)
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
    local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
    local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)

    if DoesEntityExist(NearestVehicle.Handle) then
        TriggerServerEvent("police:check_plate", GetVehicleNumberPlateText(NearestVehicle.Handle))
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
    local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
    local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)

    if DoesEntityExist(NearestVehicle.Handle) then
        TriggerServerEvent("police:search_vehicle", GetVehicleNumberPlateText(NearestVehicle.Handle), type)
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
    local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
    local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)

    if DoesEntityExist(NearestVehicle.Handle) then
        TriggerServerEvent("police:seize_vehicle", GetVehicleNumberPlateText(NearestVehicle.Handle), type)
    else
        Notify("Couldn't find a vehicle!", 2500)
    end
end)

RegisterNetEvent("police:menu_vehicle_impound")
AddEventHandler("police:menu_vehicle_impound", function(_amount)
    if isInService then
        local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
        local NearestVehicle = GetNearestVehicleAtCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 2.0)

        if DoesEntityExist(NearestVehicle.Handle) then
            TriggerServerEvent("police:impound", GetVehicleNumberPlateText(NearestVehicle.Handle), _amount)
            DestroyVehicle(NearestVehicle.Handle)
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

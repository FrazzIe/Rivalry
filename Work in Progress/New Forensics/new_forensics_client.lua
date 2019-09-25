-- Client Side

local Evidence = {
    ["Fingerprints"] = {},
    ["Ballistics"] = {],
    ["Inventory"] = {},
    ["Firearms"] = {},
}

local ClientEvidence = {
    ["Fingerprints"] = {},
    ["Ballistics"] = {},
    ["Inventory"] = {},
    ["Firearms"] = {},
}

local CollectedEvidence = {
    ["Fingerprints"] = {},
    ["Ballistics"] = {},
    ["Inventory"] = {},
    ["Firearms"] = {},
}

local Data = {
    Locker = vector3(0.0,0.0,0.0),
}
local CurrentItemIndex = 1
local CurrentSelection = nil
    
Citizen.CreateThread(funciton()
    while true do
        Citizen.Wait(0)
        if exports.policejob:getIsInService() then
            local Player = PlayerPedId()
            local PlayerPosition = GetEntityCoords(Player, false)
            if GetSelectedPedWeapon(Player) == GetHashKey("weapon_flashlight") and IsPedFreeAiming(Player, true) then
                for Index = 1, #Evidence["Ballistics"] do
                    if #(PlayerPosition - Evidence["Ballistics"][Index].Position) <= 1.1 then
                        Draw3DText(Evidence["Ballistics"][Index].Position.x, Evidence["Ballistics"][Index].Position.y, Evidence["Ballistics"][Index].Position.z, "Press E to pick up!")
                        if IsControlJustPressed(1, 51) then
                            TriggerServerEvent("Pickup.Evidence", k, Evidence["Ballistics"][Index])
                            Notify("Evidence Collected", 3100)
                        end
                    end
                end
            end
        end
        if IsPedGettingIntoVehicle(Player, false) then
            if GetPedDrawableVariation(Player, 3) >= 16 then
                local Vehicle = GetVehiclePedIsGettingInto(Player, false)
                local VehicleSeat = GetSeatPedIsUsing(Player)
                local Plate = GetVehicleNumberPlateText(vehicleHandle)
                local StreetName, CrossingnName = GetStreetNameAtCoord(StreetName)
                local Table = {
                    VehiclePlate = Plate,
                    Street = StreetName,
                }
                TriggerServerEvent("Add.Fingerprint", Table)
            end
        end
       if [[ --Insert Code Here-- ]]then
           [[ --Shots Fired Code-- ]]        
       end
    end
end)
    
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if exports.policejob:getIsInService() then
            local Player = PlayerPedId()
            local PlayerPosition = GetEntityCoords(Player, false)
            if #(PlayerPosition - Data.Locker) <= 11.0 then
                RenderMarker()
                if #(PlayerPosition - Data.Locker) <= 1.1 then
                   Draw3DText(Data.Locker.x, Data.Locker.y, Data.Locker.z, "Press [E] to open evidence locker")
                   if IsControlJustPressed(1, 51) then
                       if not WarMenu.IsMenuOpened("Evidence") then
                           if not WarMenu.DoesMenuExist("Evidence") then
                               WarMenu.CreateMenu("Evidence", "Evidence Locker")
                               WarMenu.SetSpriteTitle("Evidence", "shopui_title_gr_gunmod")
                               WarMenu.SetSubTitle("Evidence", "CATEGORIES")
                               WarMenu.SetMenuX("Evidence", 0.6)
                               WarMenu.SetMenuY("Evidence", 0.15)
                               WarMenu.SetTitleBackgroundColor("Evidence", 0, 107, 87)
                               WarMenu.CreateSubMenu("Evidence_Ballistics", "Evidence", "BALLISTICS SECTION")
                               WarMenu.CreateSubMenu("Evidence_Fingerprints", "Evidence", "FINGERPRINTS SECTION")
                               WarMenu.CreateSubMenu("Evidence_Firearms", "Evidence", "FIREARMS SECTION")
                               WarMenu.CreateSubMenu("Evidence_Items", "Evidence", "ITEMS SECTION")
                               WarMenu.OpenMenu("Evidence")
                           else
                               currentItemIndex = 1
                               WarMenu.OpenMenu("Evidence")
                           end
                       else
                           WarMenu.CloseMenu()
                           CurrentSelection = nil
                       end
                       if WarMenu.IsMenuOpened("Evidence_Ballistics") then
                          if WarMenu.Button("Insert") then
                             WarMenu.OpenMenu("Evidence_Insert")
                             SelectedEvidence = "Ballistics"
                          end
                          if WarMenu.Button("Withdraw") then
                             WarMenu.OpenMenu("Evidence_Withdraw")           
                             SelectedEvidence = "Ballistics" 
                          end
                       end
                       if WarMenu.IsMenuOpened("Evidence_Fingerprints") then
                          if WarMenu.Button("Insert") then
                             WarMenu.OpenMenu("Evidence_Insert")
                             SelectedEvidence = "Fingerprints"
                          end
                          if WarMenu.Button("Withdraw") then
                             WarMenu.OpenMenu("Evidence_Withdraw") 
                             TriggerServerEvent("Get.Evidence.Locker")
                             SelectedEvidence = "Fingerprints"
                          end
                       end
                       if WarMenu.IsMenuOpened("Evidence_Firearms") then
                          if WarMenu.Button("Insert") then
                             WarMenu.OpenMenu("Evidence_Insert")
                             SelectedEvidence = "Firearms"
                          end
                          if WarMenu.Button("Withdraw") then
                             WarMenu.OpenMenu("Evidence_Withdraw")  
                             TriggerServerEvent("Get.Evidence.Locker")
                             SelectedEvidence = "Firearms"
                          end
                       end
                       if WarMenu.IsMenuOpened("Evidence_Items") then
                          if WarMenu.Button("Insert") then
                             WarMenu.OpenMenu("Evidence_Insert")
                             SelectedEvidence = "Items"
                          end
                          if WarMenu.Button("Withdraw") then
                             WarMenu.OpenMenu("Evidence_Withdraw")
                             TriggerServerEvent("Fetch.Evidence.Locker")
                             SelectedEvidence = "Items"
                          end
                       end
                       if WarMenu.IsMenuOpened("Evidence_Insert") then
                           if SelectedEvidence ~= nil then
                               for Index = 1, #Collected_Evidence[SelectedEvidence] do
                                   if WarMenu.Button(Collected_Evidence[SelectedEvidence][Index]) then
                                        TriggerServerEvent("Insert.Evidence", Collected_Evidence[SelectedEvidence][Index], SelectedEvidence)
                                   end
                               end
                           end
                       end
                       if WarMenu.IsMenuOpened("Evidence_Withdraw") then
                          if Locker ~= nil then
                              for Index = 1, #Locker[SelectedEvidence] do
                                 if WarMenu.Button(Locker[SelectedEvidence][Index]) then
                                     TriggerServerEvent("Withdraw.Evidence", Index, SelectedEvidence)
                                 end
                          else
                               TriggerEvent("chat:Message", "ERROR", {255,255,255}, "Failed to fetch evidence locker. Please wait! If this continues please exit and contact Kole!")
                          end
                       end
                   end
                end
            end
        end
    end
end)

RegisterNetEvent("Sync.Evidence")
AddEventHandler("Sync.Evidence", function(Data)
   Evidence = Data             
end
        
RegisterNetEvent("Pickup.Evidence")
AddEventHandler("Pickup.Evidence", function(Type, Evidence)
    if Type == "Fingerprints" or Type == "Ballistics" or Type == "Inventory" or Type == "Firearms" then
        table.insert(CollectedEvidence[Type], Evidence)            
    end
end)
    
RegisterNetEvent("Swab.Vehicle")
AddEventHandler("Swab.Vehicle", function()
    local pos = GetEntityCoords(PlayerPedId(), false)
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    local Results = {}
    if vehicleHandle ~= nil then
        RequestAnimDict("timetable@floyd@clean_kitchen@idle_a")
        while not HasAnimDictLoaded("timetable@floyd@clean_kitchen@idle_a") do
            Wait(0)
        end
        TaskPlayAnim(PlayerPedId(), "timetable@floyd@clean_kitchen@idle_a", "idle_a", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)
        Notify("You are currently swabbing the vehicle!", 10000)
        Citizen.Wait(10000)
        for Index = 1, #Evidence["Fingerprints"] do
            local Plate = GetVehicleNumberPlateText(vehicleHandle)
            if Evidence["Fingerprints"][Index].VehiclePlate == Plate then
                table.insert(Results, Evidence["Fingerprints"][Index])
            end
        end
        TriggerServerEvent("Swab.Vehicle.Results", Results)
    end
end)

AddEventHandler("Police.OpenEvidenceBag", function()
    exports.ui:addOption("Fingerprints", [[TriggerEvent("Open.Fingerprints")]])
    exports.ui:addOption("Ballistics", [[TriggerEvent("Open.Ballistics")]])
    exports.ui:addOption("Inventory", [[TriggerEvent("Open.Inventory")]])
    exports.ui:addOption("Firearms", [[TriggerEvent("Open.Firearms")]])
end)
    
AddEventHandler("Open.Fingerprints", function()
    for Index = 1, #CollectedEvidence["Fingerprints"] do
       exports.ui:addOption(CollectedEvidence["Fingerprints"][Index].Time.." - "..CollectedEvidence["Fingerprints"][Index].Seat.." | "..CollectedEvidence["Fingerprints"][Index].VehiclePlate, [[TriggerEvent("Evidence.Options"]],{Evidence = CollectedEvidence["Fingerprints"][Index], Type = "Fingerprints"})
    end
end)
    
AddEventHandler("Open.Ballistics", function()
    for Index = 1, #CollectedEvidence["Ballistics"] do
       exports.ui:addOption(CollectedEvidence["Ballistics"][Index].Time.." - "..CollectedEvidence["Ballistics"][Index].AmmoType.." | "..CollectedEvidence["Ballistics"][Index].StreetName, [[TriggerEvent("Evidence.Options"]],{Evidence =  CollectedEvidence["Ballistics"][Index], Type = "Ballistics"})        
    end
end)
    
AddEventHandler("Open.Inventory", function()
    for Index = 1, #CollectedEvidence["Inventory"] do
       exports.ui:addOption(CollectedEvidence["Inventory"][Index].Time.." - "..CollectedEvidence["Inventory"][Index].CharacterName.." | "..CollectedEvidence["Inventory"][Index].Quantity.."x "..CollectedEvidence["Inventory"][Index].ItemName, [[TriggerEvent("Evidence.Options")]], {Evidence = CollectedEvidence["Inventory"][Index], Type = "Inventory"})        
    end
end)
    
AddEventHandler("Open.Firearms", function()
    for Index = 1, #CollectedEvidence["Firearms"] do
       exports.ui:addOption(CollectedEvidence["Firearms"][Index].Time.." - "..CollectedEvidence["Firearms"][Index].WeaponUsed.." | Serial: "..CollectedEvidence["Firearms"][Index].SerialNumber, CollectedEvidence["Firearms"][Index], [[TriggerEvent("Evidence.Options"]], {Evidence = CollectedEvidence["Firearms"][Index], Type = "Firearms"})        
    end
end)
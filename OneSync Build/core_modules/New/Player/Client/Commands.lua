local Hat, Glasses, Mask, MPhone = false, false, false, false
local HatDrawable, HatTexture = nil, nil
local GlassesDrawable, GlassesTexture = nil, nil
local MaskDrawable, MaskTexture, MaskPalette = nil, nil, nil
local GlovesDrawable, GlovesTexture, GlovesPalette = nil, nil, nil
local DisplayTenCodes = false
local DisplayImmersionBars = false
local BedLocations = {
    vector3(349.42709350586,-583.51416015625,42.871894836426),
    vector3(353.52642822266,-584.78887939453,42.871894836426),
    vector3(356.7373046875,-585.93511962891,42.871894836426),
    vector3(360.41680908203,-587.03009033203,42.871894836426),
    vector3(357.39080810547,-594.36395263672,42.871894836426),
    vector3(354.23416137695,-592.67858886719,42.871894836426),
    vector3(350.72268676758,-591.75512695313,42.871894836426),
    vector3(346.90606689453,-590.63903808594,42.871894836426),
}
local InBed = false
local CurrentBed = nil

recycleAmount = 0
local Animations = {
    Hat = {
        On = {
            Dictionary = "missheistdockssetup1hardhat@",
            Animation = "put_on_hat",
        },
        Off = {
            Dictionary = "veh@common@fp_helmet@",
            Animation = "take_off_helmet_stand",
        },
    },
    Glasses = {
        Dictionary = "clothingspecs",
        On = "put_on",
        Off = "take_off",
    },
    Mask = {
        On = {
            Dictionary = "mp_masks@on_foot",
            Animation = "put_on_mask",
        },
        Off = {
            Dictionary = "misscommon@std_take_off_masks",
            Animation = "take_off_mask_rps",
        },
    },
    Gloves = {
        Dictionary = "switch@michael@closet",
        On = "closet_c",
        Off = "closet_b",
    }
}

AddAnimDictionary(Animations.Hat.On.Dictionary)
AddAnimDictionary(Animations.Hat.Off.Dictionary)
AddAnimDictionary(Animations.Glasses.Dictionary)
AddAnimDictionary(Animations.Mask.On.Dictionary)
AddAnimDictionary(Animations.Mask.Off.Dictionary)
AddAnimDictionary(Animations.Gloves.Dictionary)

RegisterNetEvent("core:ready")
AddEventHandler("core:ready", function()
    Chat.Command({"e", "emote"}, function(source, args, fullCommand)
        if args[1] then
            if args[1] == "stop" then 
                Emotes.Stop() 
            else
                local Emote = Emotes.Find(args[1]:lower())
                if Emote then
                    if args[1]:lower() ~= "cigar" then
                        Emotes.Stop()
                        Emote.Playing = true
                        Emote:Play(Emote)
                        table.insert(Emotes.Active, Emote)
                    end
                end
            end
        end
    end, false, {Help = "Play an emote", Params = {{name = "emote", help = Emotes.GenerateDescription()}}})

    Chat.Command({"wash"}, function(source, args, fullCommand)
        local Dictionary = "switch@franklin@cleaning_car"
        local Animation = "001946_01_gc_fras_v2_ig_5_base"
        if Mechanic.Active then
            RequestAnimDict(Dictionary)
            while not HasAnimDictLoaded(Dictionary) do
                Wait(0)
            end
            local pos = GetEntityCoords(PlayerPedId(), false)
            local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
            local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
            local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
            if vehicleHandle ~= nil then
                local CurrentDirt = GetVehicleDirtLevel(vehicleHandle)
                StartCleaningVehicle(vehicleHandle, CurrentDirt)
                Notify("You are currently cleaning a vehicle!", (10000 * math.floor(CurrentDirt)))
                Wait(10000 * math.floor(CurrentDirt))
                Notify("Vehicle cleaned!")
                ClearPedTasks(PlayerPedId())
            end
        else
            if GetItemQuantity(80) > 0 then
                if GetItemQuantity(81) > 0 then
                    local pos = GetEntityCoords(PlayerPedId(), false)
                    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
                    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
                    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
                    if vehicleHandle ~= nil then
                        local CurrentDirt = GetVehicleDirtLevel(vehicleHandle)
                        StartCleaningVehicle(vehicleHandle, CurrentDirt)
                        Notify("You are currently cleaning a vehicle!", (10000 * math.floor(CurrentDirt)))
                        Wait(10000 * math.floor(CurrentDirt))
                        Notify("Vehicle cleaned!")
                        ClearPedTasks(PlayerPedId())
                        removeQty(81, 1)
                    end
                else
                    Notify("You do not have any solution to clean the car with!", 2500)
                end
            else
                Notify("You do not have a cloth to wash the car with!", 2500)
            end
        end
    end, false, {Help = "Wash a car", Params = {{}}})

    Chat.Command({"ws", "walkstyle"}, function(source, args, fullCommand)
        if args[1] then
            if args[1] == "reset" then 
                ResetPedMovementClipset(PlayerPedId(), 1.0)
            else
                local WalkStyle = WalkStyles.Find(args[1]:lower())
                if WalkStyle then
                    SetPedMovementClipset(PlayerPedId(), WalkStyle.Clipset, 1.0)
                end
            end
        end
    end, false, {Help = "Change the way you walk!", Params = {{name = "walk style", help = WalkStyles.GenerateDescription()}}})

    Chat.Command({"v", "vest"}, function(source, args, fullCommand)
        if args[1] and exports.policejob:getIsInService() then
            RequestAnimDict("switch@franklin@getting_ready")
            while not HasAnimDictLoaded("switch@franklin@getting_ready") do
                Wait(0)
            end
            TaskPlayAnim(PlayerPedId(), "switch@franklin@getting_ready", "002334_02_fras_v2_11_getting_dressed_exit", 4.0, -4, -1, 1, 0, false, false, false)
            Wait(500)
            if IsPedMale(PlayerPedId()) then
                if tonumber(args[1]) < 36 then
                    SetPedComponentVariation(PlayerPedId(), 9, tonumber(args[1]), tonumber(args[2]), 0)
                    Wait(1700)
                    ClearPedTasks(PlayerPedId())
                end
            else
                if tonumber(args[1]) < 36 then
                    SetPedComponentVariation(PlayerPedId(), 9, tonumber(args[1]), tonumber(args[2]), 0)
                    Wait(1700)
                    ClearPedTasks(PlayerPedId())
                end
            end
        end
    end, false, {Help = "Change your vest!", Params = {{name = "drawableid", help = "number"}, {name = "textureid", help = "number"}}})

    Chat.Command("hat", function(source, args, fullCommand)
        if not Hat then
            Hat = true
            HatDrawable, HatTexture = GetPedPropIndex(PlayerPedId(), 0), GetPedPropTextureIndex(PlayerPedId(), 0)
            TaskPlayAnim(PlayerPedId(), Animations.Hat.Off.Dictionary, Animations.Hat.Off.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(800)
            ClearPedProp(PlayerPedId(), 0)
            Citizen.Wait(400)
            ClearPedTasks(PlayerPedId())
        else
            Hat = false
            TaskPlayAnim(PlayerPedId(), Animations.Hat.On.Dictionary, Animations.Hat.On.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1300)
            SetPedPropIndex(PlayerPedId(), 0, HatDrawable, HatTexture, true)
            ClearPedTasks(PlayerPedId())
        end
    end, false, {Help = "Put on/Take off your hat!", Params = {}})

    Chat.Command("glasses", function(source, args, fullCommand)
        if not Glasses then
            Glasses = true
            GlassesDrawable, GlassesTexture = GetPedPropIndex(PlayerPedId(), 1), GetPedPropTextureIndex(PlayerPedId(), 1)
            TaskPlayAnim(PlayerPedId(), Animations.Glasses.Dictionary, Animations.Glasses.Off, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1200)
            ClearPedProp(PlayerPedId(), 1)
            ClearPedTasks(PlayerPedId())
        else
            Glasses = false
            TaskPlayAnim(PlayerPedId(), Animations.Glasses.Dictionary, Animations.Glasses.On, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(4000)
            SetPedPropIndex(PlayerPedId(), 1, GlassesDrawable, GlassesTexture, true)
            ClearPedTasks(PlayerPedId())
        end
    end, false, {Help = "Put on/Take off your glasses!", Params = {}})

    Chat.Command("mask", function(source, args, fullCommand)
        if not Mask then
            Mask = true
            MaskDrawable, MaskTexture, MaskPalette = GetPedDrawableVariation(PlayerPedId(), 1), GetPedTextureVariation(PlayerPedId(), 1), GetPedPaletteVariation(PlayerPedId(), 1)
            TaskPlayAnim(PlayerPedId(), Animations.Mask.Off.Dictionary, Animations.Mask.Off.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1000)
            SetPedComponentVariation(PlayerPedId(), 1, 0, 0, MaskPalette)
            ClearPedTasks(PlayerPedId())
        else
            Mask = false
            TaskPlayAnim(PlayerPedId(), Animations.Mask.On.Dictionary, Animations.Mask.On.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(500)
            SetPedComponentVariation(PlayerPedId(), 1, MaskDrawable, MaskTexture, MaskPalette)
            ClearPedTasks(PlayerPedId())
        end
    end, false, {Help = "Put on/Take off your mask!", Params = {}})

    Chat.Command("gloves", function(source, args, fullCommand)
        if not Gloves then
            Gloves = true
            GlovesDrawable, GlovesTexture, GlovesPalette = GetPedDrawableVariation(PlayerPedId(), 3), GetPedTextureVariation(PlayerPedId(), 3), GetPedPaletteVariation(PlayerPedId(), 3)
            TaskPlayAnim(GetPlayerPed(-1), Animations.Gloves.Dictionary, Animations.Gloves.Off, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1300)
            SetPedComponentVariation(PlayerPedId(), 3, 0, 0, GlovesPalette)
            ClearPedTasks(PlayerPedId())
        else
            Gloves = false
            TaskPlayAnim(GetPlayerPed(-1), Animations.Gloves.Dictionary, Animations.Gloves.On, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1300)
            SetPedComponentVariation(PlayerPedId(), 3, GlovesDrawable, GlovesTexture, GlovesPalette)
            ClearPedTasks(PlayerPedId())
        end
    end, false, {Help = "Put on/Take off your gloves!", Params = {}})

    Chat.Command("codes", function(source, args, rawCommand)
        if exports.policejob:getIsInService() then
            DisplayTenCodes = not DisplayTenCodes
        else
            DisplayTenCodes = false
            Chat.Message("INFO", "You must be on duty use this command!", 255, 0, 0, true)
        end
    end, false, {Help = "Toggle ten codes",  Params = {}})

    Chat.Command("hood", function(source, args, fullCommand)
        local pos = GetEntityCoords(PlayerPedId(), false)
        local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
        local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
        local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
            
        if vehicleHandle ~= nil and vehicleHandle ~= 0 then
            local isopen = GetVehicleDoorAngleRatio(vehicleHandle, 4)
            local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(vehicleHandle), 1)

            if distanceToVeh <= 3.5 and DoesEntityExist(vehicleHandle) then
                if isopen == 0 then
                    SetVehicleDoorOpen(vehicleHandle, 4, 0, 0)
                else
                    SetVehicleDoorShut(vehicleHandle, 4, 0)
                end
            else
                Notify("You must be near your vehicle to do that!")
            end
        else
            Notify("No vehicle in range!")
        end
    end, false, {Help = "Open/Close your hood!", Params = {}})

    Chat.Command("door", function(source, args, fullCommand)
        local pos = GetEntityCoords(PlayerPedId(), false)
        local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
        local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
        local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
        local door = nil
        if args[1] == "fl" or args[1] == "fr" or args[1] == "bl" or args[1] == "br" then
            if args[1] == "fl" then door = 0 end
            if args[1] == "fr" then door = 1 end
            if args[1] == "bl" then door = 2 end
            if args[1] == "br" then door = 3 end
            if vehicleHandle ~= nil and vehicleHandle ~= 0 then
                local isopen = GetVehicleDoorAngleRatio(vehicleHandle, door)
                local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(vehicleHandle), 1)

                if distanceToVeh <= 3.5 and DoesEntityExist(vehicleHandle) then
                    if isopen == 0 then
                        SetVehicleDoorOpen(vehicleHandle, door, 0, 0)
                    else
                        SetVehicleDoorShut(vehicleHandle, door, 0)
                    end
                else
                    Notify("You must be near your vehicle to do that!")
                end
            else
                Notify("No vehicle in range!")
            end
        else
            Notify("Invalid Input!")
        end
    end, false, {Help = "Open/Close doors!", Params = {{name = "fl | fr | bl | br", help = "number"}}})

    Chat.Command("trunk", function(source, args, fullCommand)
        local pos = GetEntityCoords(PlayerPedId(), false)
        local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
        local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
        local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
            
        if vehicleHandle ~= nil and vehicleHandle ~= 0 then
            local isopen = GetVehicleDoorAngleRatio(vehicleHandle,5)
            local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(vehicleHandle), 1)
                    
            if distanceToVeh <= 3.5 and DoesEntityExist(vehicleHandle) then
                if isopen == 0 then
                    SetVehicleDoorOpen(vehicleHandle, 5, 0, 0)
                else
                    SetVehicleDoorShut(vehicleHandle, 5, 0)
                end
            else
                Notify("You must be near your vehicle to do that!")
            end
        else
            Notify("No vehicle in range!")
        end
    end, false, {Help = "Open/Close your trunk!", Params = {}})

    Chat.Command({"ar", "rifle"}, function(source, args, rawCommand)
        if exports.policejob:getIsInService() then
            local pos = GetEntityCoords(PlayerPedId(), false)
            local NearestVehicle, NearestVehiclePosition = GetNearestVehicleAtCoords(pos.x, pos.y, pos.z, 2.0, false, false)
            if GetVehicleClass(NearestVehicle) == 18 then
                local weaponhash = GetHashKey("WEAPON_CARBINERIFLE")
                if not HasPedGotWeapon(PlayerPedId(), weaponhash, false) and weaponhash ~= GetSelectedPedWeapon(PlayerPedId()) then
                    GiveWeaponToPed(PlayerPedId(), weaponhash, 250, false, true)
                    GiveWeaponComponentToPed(PlayerPedId(), weaponhash, 2076495324)
                    GiveWeaponComponentToPed(PlayerPedId(), weaponhash, 202788691)
                    SetPedWeaponTintIndex(PlayerPedId(), weaponhash, 7)
                else
                    RemoveWeaponFromPed(PlayerPedId(), weaponhash)
                end
            else
                Chat.Message("INFO", "You must be near a police vehicle!", 255, 0, 0, true)
            end 
        else
            Chat.Message("INFO", "You must be on duty use this command!", 255, 0, 0, true)
        end
    end, false, {Help = "Toggle assault rifle",  Params = {}})

    Chat.Command({"sg", "shotgun"}, function(source, args, rawCommand)
        if exports.policejob:getIsInService() then
            local pos = GetEntityCoords(PlayerPedId(), false)
            local NearestVehicle, NearestVehiclePosition = GetNearestVehicleAtCoords(pos.x, pos.y, pos.z, 2.0, false, false)
            if GetVehicleClass(NearestVehicle) == 18 then
                local weaponhash = GetHashKey("WEAPON_PUMPSHOTGUN")
                if not HasPedGotWeapon(PlayerPedId(), weaponhash, false) and weaponhash ~= GetSelectedPedWeapon(PlayerPedId()) then
                    GiveWeaponToPed(PlayerPedId(), weaponhash, 250, false, true)
                    GiveWeaponComponentToPed(PlayerPedId(), weaponhash, 2076495324)
                    SetPedWeaponTintIndex(PlayerPedId(), weaponhash, 7)
                else
                    RemoveWeaponFromPed(PlayerPedId(), weaponhash)
                end
            else
                Chat.Message("INFO", "You must be near a police vehicle!", 255, 0, 0, true)
            end 
        else
            Chat.Message("INFO", "You must be on duty use this command!", 255, 0, 0, true)
        end
    end, false, {Help = "Toggle shotgun",  Params = {}})

    Chat.Command({"bars", "immersion"}, function(source, args, rawCommand)
        DisplayImmersionBars = not DisplayImmersionBars
        TriggerEvent('interaction:hud')
    end, false, {Help = "Toggle immersion bars",  Params = {}})

    Chat.Command({"gm", "givemoney"}, function(source, args, rawCommand)
        local Amount = tonumber(args[1])
        local Target = tonumber(args[2])
        TriggerEvent('interaction:give_money_ID', Amount, Target)
    end, false, {Help = "Give Money",  Params = {{name = "amount", help = "number"},{name = "id", help = "id"}}})

    Chat.Command({"gdm", "givedirtymoney"}, function(source, args, rawCommand)
        local Amount = tonumber(args[1])
        local Target = tonumber(args[2])
        TriggerEvent('interaction:give_dirtymoney_ID', Amount, Target)
    end, false, {Help = "Give Dirty Money",  Params = {{name = "amount", help = "number"},{name = "id", help = "id"}}})

    Chat.Command("bed", function(source, args, rawCommand)
        local Ped = PlayerPedId()
        local PlayerPosition = GetEntityCoords(Ped, false)
        local Dictionary = "missfinale_c1@"
        local Animation = "lying_dead_player0"
        if not IsEntityDead(Ped) then
            RequestAnimDict(Dictionary)
            while not HasAnimDictLoaded(Dictionary) do
                Wait(0)
            end
            for Index = 1, #BedLocations do
                if #(PlayerPosition - BedLocations[Index]) < 2.0 then
                    NearestBed = GetClosestObjectOfType(BedLocations[Index].x, BedLocations[Index].y, BedLocations[Index].z, 2.0, -1091386327, 0, 0, 0)
                    AttachEntityToEntity(Ped, NearestBed, 1, -0.2, -0.2, 1.4, 0.0, 0.0, 180.0, true, true, true, true, 1, true)
                    TaskPlayAnim(Ped, Dictionary, Animation, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
                    InBed = true
                    CurrentBed = NearestBed
                end
            end
        end
    end, false, {Help = "Lye down on the nearest hospital bed", Params = {}})
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if InBed then
            local Dictionary = "switch@franklin@bed"
            local Animation = "sleep_getup_rubeyes"
            local Ped = PlayerPedId()
            DisplayHelpText("Press ~INPUT_CONTEXT~ to get up!")
            if IsControlJustPressed(1, 51) then
                RequestAnimDict(Dictionary)
                while not HasAnimDictLoaded(Dictionary) do
                    Citizen.Wait(0)
                end
                DetachEntity(Ped, true, true)
                SetEntityHeading(Ped, GetEntityHeading(CurrentBed) - 90)
                TaskPlayAnim(Ped, Dictionary, Animation, 100.0, 1.0, -1, 8, -1, 0, 0, 0)
                InBed = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    local PoliceTenCodes = {
        {Text = " - 10-2 | Signal Good", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-4 | Acknowledge", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-6 | Busy", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-7 | Out of Service", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-8 | In Service", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-9 | Repeat", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-13 | Officer Down", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-15 | Drug Call", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-19 | Returning to", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-20 | Location", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-23 | Arrived at scene", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-28 | Registration Check", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-29 | Background Check", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-30 | Misuse of radio", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-31 | Crime in progress", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-32 | Shots fired", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-33 | Emergency", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-38 | Stopping Vehicle", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-41 | Starting tour of duty", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-42 | Ending tour of duty", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-52 | Ambulance needed", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-76 | En route", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-78 | Need Assistance", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-80 | Chase in progress", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-90 | Robbery", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-95 | Suspect in custody", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
    }
    local X, Y = 0, 0.25
    while true do
        Citizen.Wait(0)
        if DisplayTenCodes then
            ScreenDrawPositionBegin(76, 84)
            ScreenDrawPositionRatio(0, 0, 0, 0)
            for Index = 1, #PoliceTenCodes do
                SetTextFont(PoliceTenCodes[Index].Font or 6)
                SetTextScale(0.0, PoliceTenCodes[Index].Scale or 0.3)
                SetTextDropShadow(0, 0, 0, 0, 0)
                SetTextEdge(0, 0, 0, 0, 0)
                SetTextColour(PoliceTenCodes[Index].R or 255, PoliceTenCodes[Index].G or 255, PoliceTenCodes[Index].B or 255, PoliceTenCodes[Index].A or 255)
                BeginTextCommandDisplayText("STRING")
                AddTextComponentSubstringPlayerName(PoliceTenCodes[Index].Text or "")
                EndTextCommandDisplayText(X, Y + (0.015 * (Index - 1)))
            end
            ScreenDrawPositionEnd()
        end
    end
end)

function StartCleaningVehicle(Vehicle, CurrentDirt)
    Citizen.CreateThread(function()
        while true do
            if CurrentDirt > 0 then
                Citizen.Wait(10000)
                SetVehicleDirtLevel(Vehicle, CurrentDirt - 1)
            else
                break 
            end
        end
    end)
end

function drawRct(x,y,width,height,r,g,b,a)
    DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

local UI = { 
    x =  0.000 ,
    y = -0.001 ,
}

Citizen.CreateThread(function()
    local X, Y, WIDTH, HEIGHT, HEIGHT2 = 0.000, -0.001, 1.0, 0.15, 0.151
    while true do
        Citizen.Wait(0)
        if DisplayImmersionBars then
            DrawRect(0.5,0.0755,1.0,0.17,0,0,0,255) -- top
            DrawRect(0.5,0.9245,1.0,0.17,0,0,0,255) -- bottom
        end
        if IsControlJustPressed(1, 194) and DisplayImmersionBars then
            DisplayImmersionBars = not DisplayImmersionBars
            TriggerEvent('interaction:hud')
        end
        if IsControlJustPressed(1, 167) then
            TriggerEvent('interaction:hud')
        end
    end
end)
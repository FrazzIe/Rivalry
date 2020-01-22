local Hat, Glasses, Mask, MPhone = false, false, false, false
local HatDrawable, HatTexture = nil, nil
local GlassesDrawable, GlassesTexture = nil, nil
local MaskDrawable, MaskTexture, MaskPalette = nil, nil, nil
local GlovesDrawable, GlovesTexture, GlovesPalette = nil, nil, nil
local DisplayTenCodes = false
local DisplayCameras = false
local DisplayImmersionBars = false
local BedLocations = {
    [1] = vector3(349.42709350586,-583.51416015625,42.871894836426),
    [2] = vector3(353.52642822266,-584.78887939453,42.871894836426),
    [3] = vector3(356.7373046875,-585.93511962891,42.871894836426),
    [4] = vector3(360.41680908203,-587.03009033203,42.871894836426),
    [5] = vector3(357.39080810547,-594.36395263672,42.871894836426),
    [6] = vector3(354.23416137695,-592.67858886719,42.871894836426),
    [7] = vector3(350.72268676758,-591.75512695313,42.871894836426),
    [8] = vector3(346.90606689453,-590.63903808594,42.871894836426),
}
local InBed = false
local CurrentBed = nil
local IsInTrunk = false
local ForcedIntoTrunk = false
local IsBeingCarried = false
local CarryingTarget = nil
local MaskOn = false
local CurrentWalkStyle = nil

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
    end, false, {Help = "Play an emote", Params = {{name = "emote", help = "Find a list of emotes on the rivalryrp forums"}}})

    Chat.Command({"wash"}, function(source, args, fullCommand)
        if Mechanic.Active then
            local pos = GetEntityCoords(PlayerPedId(), false)
            local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
            local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
            local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
            if vehicleHandle ~= nil then
                local CurrentDirt = GetVehicleDirtLevel(vehicleHandle)
                StartCleaningVehicle(vehicleHandle, CurrentDirt)
                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MAID_CLEAN", 0, true)
                Notify("You are currently cleaning a vehicle!", (5000 * math.floor(CurrentDirt)))
                Wait(5000 * math.floor(CurrentDirt))
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
                        TaskPlayAnim(PlayerPedId(), Dictionary, Animation, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_MAID_CLEAN", 0, true)
                        Notify("You are currently cleaning a vehicle!", (5000 * math.floor(CurrentDirt)))
                        Wait(5000 * math.floor(CurrentDirt))
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
				CurrentWalkStyle = nil
				ResetPedMovementClipset(PlayerPedId(), 1.0)
            else
                local WalkStyle = WalkStyles.Find(args[1]:lower())
				if WalkStyle then
					CurrentWalkStyle = WalkStyle
					ResetPedMovementClipset(PlayerPedId(), 1.0)
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

    Chat.Command("fmask", function(source, args, fullCommand)
        if GetEntityModel(PlayerPedId()) == GetHashKey("player_one") then
            if MaskOn then
                MaskOn = false
                TaskPlayAnim(PlayerPedId(), Animations.Mask.Off.Dictionary, Animations.Mask.Off.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
                Citizen.Wait(500)
                SetPedComponentVariation(PlayerPedId(), 8, 0, 1, 0)
                ClearPedTasks(PlayerPedId())
            else
                MaskOn = true
                TaskPlayAnim(PlayerPedId(), Animations.Mask.On.Dictionary, Animations.Mask.On.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
                Citizen.Wait(1000)
                SetPedComponentVariation(PlayerPedId(), 8, 9, 0, 0)
                ClearPedTasks(PlayerPedId())
            end
        end
    end, false, {Help = "Put franklin's green mask on and off!", Params = {}})

    Chat.Command("codes", function(source, args, rawCommand)
        if exports.policejob:getIsInService() then
            DisplayTenCodes = not DisplayTenCodes
        else
            DisplayTenCodes = false
            Chat.Message("INFO", "You must be on duty use this command!", 255, 0, 0, true)
        end
    end, false, {Help = "Toggle ten codes",  Params = {}})

    Chat.Command("cams", function(source, args, rawCommand)
        if exports.policejob:getIsInService() then
            DisplayCameras = not DisplayCameras
        else
            DisplayCameras = false
            Chat.Message("INFO", "You must be on duty use this command!", 255, 0, 0, true)
        end
    end, false, {Help = "Toggle camera list",  Params = {}})

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

    -- Chat.Command("extras", function(source, args, fullCommand)
    --     local PossibleTypes = {"lighting", "panel", "ladder"}
    --     if exports.emsjob:getIsInService() then
    --         if args[1] == PossibleTypes[1] or args[1] == PossibleTypes[2] or args[1] == PossibleTypes[3] then
    --             local pos = GetEntityCoords(PlayerPedId(), false)
    --             local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
    --             local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    --             local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
                    
    --             if vehicleHandle ~= nil and vehicleHandle ~= 0 then
    --                 local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(vehicleHandle), 1)    
    --                 if distanceToVeh <= 3.5 and DoesEntityExist(vehicleHandle) then
    --                     TriggerEvent("EMS.VehicleExtras", GetEntityModel(vehicleHandle), args[1], args[2])
    --                 else
    --                     Notify("You must be near your vehicle to do that!")
    --                 end
    --             else
    --                 Notify("No vehicle in range!")
    --             end
    --         else
    --             Notify("Invalid Type!")
    --         end
    --     else
    --         ChatMessage("INFO", "You must be on duty to use this command!", 255, 0, 0, true)
    --     end
    -- end, false, {Help = "EMSONLY: Toggle Components on vehicle!", Params = {}})

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
                    GiveWeaponComponentToPed(PlayerPedId(), weaponhash, 2698550338)
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

    Chat.Command("cctv", function(source, args, rawCommand)
        local Camera = tonumber(args[1])
        TriggerEvent('Set.Current.Camera', Camera)
    end, false, {Help = "Select CCTV Camera",  Params = {{name = "Cameras", help = "id"}}})

    Chat.Command("bed", function(source, args, rawCommand)
        local Ped = PlayerPedId()
        local PlayerPosition = GetEntityCoords(Ped, false)
        TriggerServerEvent("mythic_hospital:server:RPRequestBed", PlayerPosition)
    end, false, {Help = "Lye down on the nearest hospital bed", Params = {}})

    Chat.Command("carpayment", function(source, args, rawCommand)
        local Plate = args[1]
        TriggerServerEvent("Pay.CarPayment", Plate)
    end, false, {Help = "Repay a car payment", Params = {{name = "plate", help = "string"}}})

    Chat.Command("checkhistory", function(source, args, rawCommand)
        local Target = tonumber(args[1])
        if GetPlayerFromServerId(Target) ~= nil and Target ~= nil then
            TriggerServerEvent("CarDealer.CheckHistory", Target)
        end
    end, false, {Help = "Car Dealers: Check Client History", Params = {{name = "id", help = "number"}}})

    Chat.Command("carry", function(source, args, rawCommand)
		local Player = PlayerPedId()
		if not IsBeingCarried and not ForcedIntoTrunk and not IsInTrunk and not IsPedSittingInAnyVehicle(Player) then
			if CarryingTarget ~= nil then
				ClearPedTasks(Player)
			else
				local t, distance = GetClosestPlayer()
				if(distance ~= -1 and distance < 3) then
					CarryingTarget = GetPlayerServerId(t)
					RequestAnimDict('missfinale_c2mcs_1')
					while not RequestAnimDict('missfinale_c2mcs_1') do
						Wait(0)
					end
					TaskPlayAnim(Player, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0, -1, -1, 50, 0, 0, 0, 0)
				else
					Notify("No player is nearby!", 3100)
				end
			end
			
			if CarryingTarget ~= nil then
				TriggerServerEvent("Carry.Player", CarryingTarget)
				CarryingTarget = nil
			end
        else
            Notify("You can't carry someone while being carried!", 3100)
        end
    end, false, {Help = "Carry a player", Params = {}})

    Chat.Command("kidnap", function(source, args, rawCommand)
        if not ForcedIntoTrunk and not IsInTrunk and not IsPedSittingInAnyVehicle(PlayerPedId()) then
            local t, distance = GetClosestPlayer()
            if(distance ~= -1 and distance < 3) then
                local TargetPlayer = GetPlayerServerId(t)
                local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
                local Vehicle = GetClosestVehicle(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 5.001, 0, 70)
                if Vehicle ~= nil then
                    TriggerServerEvent("Kidnap.Player", TargetPlayer)
                end
            else
                Notify("No player is nearby!", 3100)
            end
        else
            Notify("You can not kidnap someone if you are already kidnapped!", 3100)
        end
    end, false, {Help = "Kidnap a player", Params = {}})

    Chat.Command("hideintrunk", function(source, args, rawCommand)
        if not IsInTrunk and not ForcedIntoTrunk then
            local player = PlayerPedId()
            local pos = GetEntityCoords(player, false)
            local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 20.0, 0.0)
            local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, player, 0)
            local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
            if vehicle then
                RequestAnimDict("timetable@floyd@cryingonbed@base")
                while not HasAnimDictLoaded("timetable@floyd@cryingonbed@base") do
                    Wait(0)
                end
                AttachEntityToEntity(player, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	       		
                RaiseConvertibleRoof(vehicle, false)
                if IsEntityAttached(player) and HasAnimDictLoaded("timetable@floyd@cryingonbed@base") then
                    TaskPlayAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)	
                    SetEntityHeading(player, GetEntityHeading(180)) -- My attempt at fixing setting player back to the trunk
                end
                IsInTrunk = true
            else
                Notify("No vehicle is nearby!", 3100)
            end
        else
            Notify("You are already in the trunk! Or you are kidnapped!", 3100)
        end
    end, false, {Help = "Hide yourself in trunk | Look at Vehicle", Params = {}})

    Chat.Command("helpouttrunk", function(source, args, rawCommand)
        if not IsInTrunk and not ForcedIntoTrunk then
            local t, distance = GetClosestPlayer()
            if(distance ~= -1 and distance < 3) then
                local TargetPlayer = GetPlayerServerId(t)
                local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
                local Vehicle = GetClosestVehicle(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 5.001, 0, 70)
                if Vehicle ~= nil then
                    TriggerServerEvent("Remove.Player.From.Trunk", TargetPlayer)
                end
            else
                Notify("No player is nearby!", 3100)
            end
        else
            Notify("You are inside of a trunk right now or been kidnapped! You can't do that!", 3100)
        end
    end, false, {Help = "Hide yourself in trunk | Look at Vehicle", Params = {}})

    -- Chat.Command("sellcar", function(source, args, rawCommand)
    --     local Plate = tonumber(args[1])
    --     local Price = tonumber(args[2])
    --     local Buyer = tonumber(args[3])
    --     local Target = GetPlayerPed(GetPlayerFromServerId(Buyer))
    --     local Ped = PlayerPedId()
    --     local TargetPosition = GetEntityCoords(Target, 0)
    --     local PlayerPosition = GetEntityCoords(Ped, 0)
    --     local Distance = #(PlayerPosition - TargetPosition)
    --     if not exports.policejob:getIsCuffed() and not isCuffed() then
    --         if not IsPlayerDead(Ped) and not IsEntityDead(Ped) then
    --             if Target ~= Ped and GetPlayerFromServerId(Buyer) ~= nil and Target ~= nil then
    --                 if(Distance ~= -1 and Distance < 3) then
    --                     if Price ~= nil then
    --                         if math.floor(Price) >= 0 then
    --                             TriggerServerEvent("Sell.Car", Plate, math.floor(Price), Buyer)
    --                         end
    --                     end
    --                 end
    --             else
    --                 Notify("This player doesn't exist, and also can't be yourself!", 2500)
    --             end
    --         else
    --             Notify("You can't sell a vehicle while dead!", 2500)
    --         end
    --     else
    --         Notify("You can't sell cars while restrained!", 2500)
    --     end
    -- end, false, {Help = "Car Dealers: Check Client History", Params = {{name = "id", help = "number"}}})
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
                SetEntityHeading(Ped, GetEntityHeading(CurrentBed) + 90)
                TaskPlayAnim(Ped, Dictionary, Animation, 100.0, 1.0, -1, 8, -1, 0, 0, 0)
                InBed = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsInTrunk and not ForcedIntoTrunk then
            local Ped = PlayerPedId()
            DisplayHelpText("Press ~INPUT_CONTEXT~ to get out of trunk!")
            if IsControlJustPressed(1, 51) then
                DetachEntity(Ped, true, true)
                ClearPedTasksImmediately(Ped)
                IsInTrunk = false
                ForcedIntoTrunk = false
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
        {Text = " - 10-9 | Repeat Last", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-10 | Fight in progress", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-13 | Panic / Officer Down", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-14 | Suspicious Person", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-19 | Returning to", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-20 | Location", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-22 | Disregard", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-23 | Arrived at scene", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-24 | Assignment complete", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-25 | Report in person (meet)", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-28 | Plate/Registration Check", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-29 | Background Check", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-30 | Misuse of radio", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-31 | Crime in progress", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-32 | Individual with firearm", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-33 | Emergency", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-38 | Stopping Vehicle", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-41 | Starting tour of duty", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-42 | Ending tour of duty", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-52 | Ambulance needed", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-59 | Escort needed", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-76 | En route", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-78 | Need Assistance", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-80 | Pursuit in progress", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-90 | Robbery in progress", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-91 | Pick up / Transport Suspect", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-95 | Suspect in custody", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-96 | Mental subject", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-98 | Prison / Jail Break", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10-99 | Wanted / Stolen", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
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

Citizen.CreateThread(function()
    local CameraList = {
        {Text = " - 1 | Little Seoul | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 2 | Little Seoul | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 3 | Palomino Hwy | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 4 | Palomino Hwy | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 5 | Sandy Shores | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 6 | Sandy Shores | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 7 | Richman Glen | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 8 | Richman Glen | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 9 | Paleto Bay | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 10 | Paleto Bay | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 11 | Grove Street | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 12 | Grove Street | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 13 | Mirror Park | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 14 | Mirror Park | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 15 | Grapeseed | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 16 | Grapeseed | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 17 | Fleeca Bank | Hawick Ave | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 18 | Fleeca Bank | Hawick Ave | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 19 | Fleeca Bank | Great Ocean Hwy | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 20 | Fleeca Bank | Great Ocean Hwy | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 21 | Fleeca Bank | Route 68 | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 22 | Fleeca Bank | Route 68 | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 23 | Blaine County Savings | Interior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 24 | Blaine County Savings | Exterior Camera", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 25 | Pacific Standard | Flr 2 Stairwell", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 26 | Pacific Standard | Flr 2 Balcony", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 27 | Pacific Standard | Flr 2 Stairs", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 28 | Pacific Standard | Flr 1 Lobby", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 29 | Pacific Standard | Vault Door", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 30 | Pacific Standard | Flr 2 Offices", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 31 | Pacific Standard | Back Alley", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
        {Text = " - 32 | Pacific Standard | Front Door", Scale = 0.3, Font = 6, R = 255, G = 255, B = 255, A = 255},
    }
    local X, Y = 0, 0.25
    while true do
        Citizen.Wait(0)
        if DisplayCameras then
            ScreenDrawPositionBegin(76, 84)
            ScreenDrawPositionRatio(0, 0, 0, 0)
            for Index = 1, #CameraList do
                SetTextFont(CameraList[Index].Font or 6)
                SetTextScale(0.0, CameraList[Index].Scale or 0.3)
                SetTextDropShadow(0, 0, 0, 0, 0)
                SetTextEdge(0, 0, 0, 0, 0)
                SetTextColour(CameraList[Index].R or 255, CameraList[Index].G or 255, CameraList[Index].B or 255, CameraList[Index].A or 255)
                BeginTextCommandDisplayText("STRING")
                AddTextComponentSubstringPlayerName(CameraList[Index].Text or "")
                EndTextCommandDisplayText(X, Y + (0.015 * (Index - 1)))
            end
            ScreenDrawPositionEnd()
        end
    end
end)

function StartCleaningVehicle(Vehicle, CurrentDirt)
    Citizen.CreateThread(function()
        local DirtLevel = CurrentDirt
        while true do
            if CurrentDirt > 0 then
                Citizen.Wait(5000)
                DirtLevel = DirtLevel - 1
                SetVehicleDirtLevel(Vehicle, DirtLevel)
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
            TriggerEvent('interaction:hud:cameras')
        end
        if IsControlJustPressed(1, 167) then
            TriggerEvent('interaction:hud:cameras')
        end
    end
end)

RegisterNetEvent("Force.Into.Trunk")
AddEventHandler("Force.Into.Trunk", function(Vehicle)
    local Player = PlayerPedId()
    local PlayerPosition = GetEntityCoords(Player, false)
    local Vehicle = GetClosestVehicle(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 5.001, 0, 70)
    RequestAnimDict("timetable@floyd@cryingonbed@base")
    while not HasAnimDictLoaded("timetable@floyd@cryingonbed@base") do
        Wait(0)
    end
    if Vehicle ~= nil then
        AttachEntityToEntity(Player, Vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	       		
        RaiseConvertibleRoof(Vehicle, false)
        if IsEntityAttached(Player) and HasAnimDictLoaded("timetable@floyd@cryingonbed@base") then
            TaskPlayAnim(Player, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)	
            SetEntityHeading(Player, GetEntityHeading(180))
        end
        IsInTrunk = true
        ForcedIntoTrunk = true
    end
end)

RegisterNetEvent("Carry.Player")
AddEventHandler("Carry.Player", function(OtherPlayer)
	local Player = PlayerPedId()
    local OtherPlayerId = GetPlayerFromServerId(OtherPlayer)
    if not IsBeingCarried then
        if OtherPlayerId ~= nil then
            local OtherPlayerPed = GetPlayerPed(OtherPlayerId)
            if OtherPlayerPed ~= nil then
                RequestAnimDict('nm')
                while not HasAnimDictLoaded('nm') do
                    Wait(0)
                end
                AttachEntityToEntity(Player, OtherPlayerPed, GetPedBoneIndex(OtherPlayerPed, 40269), -0.1, 0.0, 0.1, 25.0, -290.0, -150.0, 1, 1, 0, 1, 0, 1)
                TaskPlayAnim(Player, 'nm', 'firemans_carry', 8.0, -1, -1, 1, 1, 0, 0, 0)
            end
            IsBeingCarried = true
        end
    else
        DetachEntity(Player, true, true)
        ClearPedTasksImmediately(Player)
        IsBeingCarried = false
    end
end)

RegisterNetEvent("Remove.Player.From.Trunk")
AddEventHandler("Remove.Player.From.Trunk", function()
    if IsInTrunk or ForcedIntoTrunk then
        local Player = PlayerPedId()
        DetachEntity(Player, true, true)
        ClearPedTasksImmediately(Player)
        IsInTrunk = false
        ForcedIntoTrunk = false
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local Player = PlayerPedId()
        if IsInTrunk or ForcedIntoTrunk then
            if not IsEntityPlayingAnim(Player, 'timetable@floyd@cryingonbed@base', 'base', 1) then
                TaskPlayAnim(Player, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)	
            end
        end
        if IsBeingCarried then
            if not IsEntityPlayingAnim(Player, 'nm', 'firemans_carry', 1) then
                TaskPlayAnim(Player, 'nm', 'firemans_carry', 8.0, -1, -1, 1, 1, 0, 0, 0)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsInTrunk or ForcedIntoTrunk then
            local Player = PlayerPedId()
            local PlayerPosition = GetEntityCoords(Player, false)
            local Vehicle = GetClosestVehicle(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, 5.001, 0, 70)
            if IsEntityInWater(Player) or IsEntityInWater(Vehicle) then
                SetEntityHealth(Player, 0)
            end
            Citizen.Wait(11000)
        end
    end
end)

RegisterNetEvent("Reset.Carry.And.Kidnap")
AddEventHandler("Reset.Carry.And.Kidnap", function()
    IsBeingCarried = false
    ForcedIntoTrunk = false
    IsInTrunk = false
end)

AddEventHandler("ResetWalkStyle", function()
	ResetPedMovementClipset(PlayerPedId(), 1.0)

	if CurrentWalkStyle then 
		SetPedMovementClipset(PlayerPedId(), CurrentWalkStyle.Clipset, 1.0)
	end
end)
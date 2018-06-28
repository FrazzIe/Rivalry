local Hat, Glasses, Mask = false, false, false
local HatDrawable, HatTexture = nil, nil
local GlassesDrawable, GlassesTexture = nil, nil
local MaskDrawable, MaskTexture, MaskPalette = nil, nil, nil
local GlovesDrawable, GlovesTexture, GlovesPalette = nil, nil, nil
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

AddEventHandler("playerSpawned", function()
    Chat.Command({"e", "emote"}, function(source, args, fullCommand)
        if args[1] then
            if args[1] == "stop" then 
                Emotes.Stop() 
            else
                local Emote = Emotes.Find(args[1]:lower())
                if Emote then
                    Emote:Play(Emote)
                    table.insert(Emotes.Active, Emote)
                end
            end
        else
            EmoteMenu:Visible(not EmoteMenu:Visible())
        end
    end, false, {Help = "Play an emote", Params = {{name = "emote", help = Emotes.GenerateDescription()}}})

    Chat.Command({"ws", "walkstyle"}, function(source, args, fullCommand)
        if args[1] then
            if args[1] == "reset" then 
                ResetPedMovementClipset(Player.Ped, 1.0)
            else
                local WalkStyle = WalkStyles.Find(args[1]:lower())
                if WalkStyle then
                    SetPedMovementClipset(PlayerPedId(), WalkStyle.Clipset, 1.0)
                end
            end
        else
            EmoteMenu:Visible(not EmoteMenu:Visible())
        end
    end, false, {Help = "Change the way you walk!", Params = {{name = "walk style", help = WalkStyles.GenerateDescription()}}})

    Chat.Command("hat", function(source, args, fullCommand)
        if not Hat then
            Hat = true
            HatDrawable, HatTexture = GetPedPropIndex(Player.Ped, 0), GetPedPropTextureIndex(Player.Ped, 0)
            TaskPlayAnim(Player.Ped, Animations.Hat.Off.Dictionary, Animations.Hat.Off.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(800)
            ClearPedProp(Player.Ped, 0)
            Citizen.Wait(400)
            ClearPedTasks(Player.Ped)
        else
            Hat = false
            TaskPlayAnim(Player.Ped, Animations.Hat.On.Dictionary, Animations.Hat.On.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1300)
            SetPedPropIndex(Player.Ped, 0, HatDrawable, HatTexture, true)
            ClearPedTasks(Player.Ped)
        end
    end, false, {Help = "Put on/Take off your hat!", Params = {}})

    Chat.Command("glasses", function(source, args, fullCommand)
        if not Glasses then
            Glasses = true
            GlassesDrawable, GlassesTexture = GetPedPropIndex(Player.Ped, 1), GetPedPropTextureIndex(Player.Ped, 1)
            TaskPlayAnim(Player.Ped, Animations.Glasses.Dictionary, Animations.Glasses.Off, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1200)
            ClearPedProp(Player.Ped, 1)
            ClearPedTasks(Player.Ped)
        else
            Glasses = false
            TaskPlayAnim(Player.Ped, Animations.Glasses.Dictionary, Animations.Glasses.On, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(4000)
            SetPedPropIndex(Player.Ped, 1, GlassesDrawable, GlassesTexture, true)
            ClearPedTasks(Player.Ped)
        end
    end, false, {Help = "Put on/Take off your glasses!", Params = {}})

    Chat.Command("mask", function(source, args, fullCommand)
        if not Mask then
            Mask = true
            MaskDrawable, MaskTexture, MaskPalette = GetPedDrawableVariation(Player.Ped, 1), GetPedTextureVariation(Player.Ped, 1), GetPedPaletteVariation(Player.Ped, 1)
            TaskPlayAnim(Player.Ped, Animations.Mask.Off.Dictionary, Animations.Mask.Off.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1000)
            SetPedComponentVariation(Player.Ped, 1, 0, 0, MaskPalette)
            ClearPedTasks(Player.Ped)
        else
            Mask = false
            TaskPlayAnim(Player.Ped, Animations.Mask.On.Dictionary, Animations.Mask.On.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(500)
            SetPedComponentVariation(Player.Ped, 1, MaskDrawable, MaskTexture, MaskPalette)
            ClearPedTasks(Player.Ped)
        end
    end, false, {Help = "Put on/Take off your mask!", Params = {}})

    Chat.Command("gloves", function(source, args, fullCommand)
        if not Gloves then
            Gloves = true
            GlovesDrawable, GlovesTexture, GlovesPalette = GetPedPropIndex(Player.Ped, 3), GetPedPropTextureIndex(Player.Ped, 3), GetPedPaletteVariation(Player.Ped, 3)
            TaskPlayAnim(GetPlayerPed(-1), Animations.Gloves.Dictionary, Animations.Gloves.Off, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1300)
            SetPedComponentVariation(Player.Ped, 3, 17, 0, GlovesPalette)
            ClearPedTasks(Player.Ped)
        else
            Gloves = false
            TaskPlayAnim(GetPlayerPed(-1), Animations.Gloves.Dictionary, Animations.Gloves.On, 8.0, 8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1300)
            SetPedComponentVariation(Player.Ped, 3, GlovesDrawable, GlovesTexture, GlovesPalette)
                ClearPedTasks(Player.Ped)
        end
    end, false, {Help = "Put on/Take off your gloves!", Params = {}})

Chat.Command("hood", function(source, args, fullCommand)
        local pos = GetEntityCoords(PlayerPedId(), false)
        local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
        local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
        local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
            
        local isopen = GetVehicleDoorAngleRatio(vehicleHandle,4)
        local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(vehicleHandle), 1)
            
        if distanceToVeh <= 3.5 and DoesEntityExist(vehicleHandle) then
            if (isopen == 0) then
                SetVehicleDoorOpen(vehicleHandle,4,0,0)
            else
                SetVehicleDoorShut(vehicleHandle,4,0)
            end
        else
            Notify("~r~You must be near your vehicle to do that.", 2500)
        end
    end, false, {Help = "Open/Close your hood!", Params = {}})

Chat.Command("trunk", function(source, args, fullCommand)
        local pos = GetEntityCoords(PlayerPedId(), false)
        local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
        local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
        local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
            
        local isopen = GetVehicleDoorAngleRatio(vehicleHandle,5)
        local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(vehicleHandle), 1)
            
        if distanceToVeh <= 3.5 and DoesEntityExist(vehicleHandle) then
            if (isopen == 0) then
                SetVehicleDoorOpen(vehicleHandle,5,0,0)
            else
                SetVehicleDoorShut(vehicleHandle,5,0)
            end
        else
            Notify("~r~You must be near your vehicle to do that.", 2500)
        end
    end, false, {Help = "Open/Close your trunk!", Params = {}})

end)

local Animations = {
    Surrender = {
        Dictionary = "missminuteman_1ig_2",
        Animation = "handsup_enter",
    },
    Kneeling = {
        Start = {
            Dictionary = "random@arrests@busted",
            Enter = "enter",
            Exit = "exit",
            Idle = "idle_a",
        },
        End = {
            Dictionary = "random@arrests",
            Animation = "kneeling_arrest_get_up",
        },
    }
}

RequestAnimDict(Animations.Surrender.Dictionary)
RequestAnimDict(Animations.Kneeling.Start.Dictionary)
RequestAnimDict(Animations.Kneeling.End.Dictionary)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 323) and not Player.Cuffs.Active then
            if not IsPedSittingInAnyVehicle(Player.Ped) and not Player.Stance.Proned and not Player.HandsUp and not Player.OnKnees and not Player.Dead then
                Player.HandsUp = true
                TaskPlayAnim(Player.Ped, Animations.Surrender.Dictionary, Animations.Surrender.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
            elseif Player.HandsUp then
                Player.HandsUp = false
                ClearPedSecondaryTask(Player.Ped)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 289) and not Player.Cuffs.Active then
            if not IsPedSittingInAnyVehicle(Player.Ped) and not Player.Stance.Proned and not Player.Stance.HandsUp and not Player.OnKnees and not Player.Dead then
                Player.OnKnees = true
                ClearPedTasks(Player.Ped)
                TaskPlayAnim(Player.Ped, Animations.Kneeling.Start.Dictionary, Animations.Kneeling.Start.Enter, 4.0, -4, -1, 21, 0, 0, 0, 0)
                Citizen.Wait(1650)
                TaskPlayAnim(Player.Ped, Animations.Kneeling.Start.Dictionary, Animations.Kneeling.Start.Idle, 4.0, -4, -1, 15, 0, 0, 0, 0)
            elseif Player.OnKnees then
                Player.OnKnees = false
                TaskPlayAnim(Player.Ped, Animations.Kneeling.Start.Dictionary, Animations.Kneeling.Start.Exit, 4.0, -4, -1, 15, 0, 0, 0, 0)
                Citizen.Wait(1950)
                TaskPlayAnim(Player.Ped, Animations.Kneeling.End.Dictionary, Animations.Kneeling.End.Animation, 4.0, -4, -1, 15, 0, 0, 0, 0)
                Citizen.Wait(2250)
                ClearPedTasksImmediately(Player.Ped)
            end
        end
    end
end)
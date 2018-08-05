local Hat, Glasses, Mask = false, false, false
local HatDrawable, HatTexture = nil, nil
local GlassesDrawable, GlassesTexture = nil, nil
local MaskDrawable, MaskTexture, MaskPalette = nil, nil, nil
local GlovesDrawable, GlovesTexture, GlovesPalette = nil, nil, nil
local DisplayTenCodes = false
local DisplayImmersionBars = false
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

    Chat.Command("newmdt", function(source, args, fullCommand)
            TriggerEvent('open:newmdt')
    end, false, {Help = "Open/Close the MDT!", Params = {}})
end)

    Chat.Command("showid", function(source, args, rawCommand)
        TriggerServerEvent("server:showid")
        print("Showing ID from Clientside.")
    end, false, {Help = "Show an ID.", Params = {}})

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

function drawRct(x,y,width,height,r,g,b,a)
    DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

local UI = { 
    x =  0.000 ,
    y = -0.001 ,
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(1, 109)then
            DisplayImmersionBars = not DisplayImmersionBars
            TriggerEvent('interaction:hud')
        end
    end
end)

Citizen.CreateThread(function()
    local X, Y, WIDTH, HEIGHT, HEIGHT2 = 0.000, -0.001, 1.0, 0.15, 0.151
    while true do
        Citizen.Wait(0)
        if DisplayImmersionBars then
            drawRct(UI.x + 0.0,     UI.y + 0.0, 1.0,0.15,0,0,0,255) -- Top Bar
            drawRct(UI.x + 0.0,     UI.y + 0.85, 1.0,0.151,0,0,0,255) -- Bottom Bar
        end
    end
end)

RegisterNetEvent("showid-player")
AddEventHandler("showid-player", function(currentjob, lastname, firstname, phonenumber)
    local source = source
    if(currentjob == "Police")then
        currentjob = "Police "..string.gsub(exports.policejob:getPoliceRank() or "", "%f[%a].", string.upper)
    end
    if(currentjob == "Emergency")then
        currentjob = "EMS "..string.gsub(exports.emsjob:getParamedicRank() or "", "%f[%a].", string.upper)
    end
    if(currentjob == "DOJ")then
        currentjob = string.gsub(DOJ.rank or "", "%f[%a].", string.upper)
    end
    Chat.Message(-1, "^3 "..firstname.." "..lastname.." | "..currentjob.." | "..phonenumber.."^0", true, "showid", 5, source)
end)

Citizen.CreateThread(function()
    Chat.Template("showid", "<img src=\"data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTYuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjE2cHgiIGhlaWdodD0iMTZweCIgdmlld0JveD0iMCAwIDMxLjkzOSAzMS45MzkiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDMxLjkzOSAzMS45Mzk7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4KPGc+Cgk8Zz4KCQk8cGF0aCBkPSJNMTUuNTgsMTguMzMyaC0wLjc3N2MtMC40MDMsMC0wLjczLTAuMzI2LTAuNzMtMC43MjljMC0wLjE0OSwwLjA2LTAuMjkzLDAuMTY3LTAuMzk3YzAuNDUyLTAuNDM5LDAuODMyLTEuMDMsMS4xMDctMS42NjcgICAgYzAuMDU2LDAuMDQxLDAuMTE2LDAuMDcxLDAuMTg0LDAuMDcxYzAuNDM2LDAsMC45NS0wLjk2NCwwLjk1LTEuNjIxYzAtMC42NTctMC4wNjEtMS4xOS0wLjQ5OC0xLjE5ICAgIGMtMC4wNTIsMC0wLjEwNiwwLjAwOS0wLjE2MiwwLjAyM2MtMC4wMzEtMS43ODItMC40ODEtNC4wMDUtMy4yMDItNC4wMDVjLTIuODM5LDAtMy4xNywyLjIxOS0zLjIwMiwzLjk5OSAgICBjLTAuMDQtMC4wMDgtMC4wOC0wLjAxNy0wLjExNy0wLjAxN2MtMC40MzcsMC0wLjQ5NywwLjUzMy0wLjQ5NywxLjE5YzAsMC42NTcsMC41MTIsMS42MjEsMC45NDksMS42MjEgICAgYzAuMDU0LDAsMC4xMDQtMC4wMTUsMC4xNTEtMC4wNDJjMC4yNzQsMC42MjcsMC42NDksMS4yMDYsMS4wOTQsMS42NDFjMC4xMDcsMC4xMDQsMC4xNjcsMC4yNDYsMC4xNjcsMC4zOTYgICAgYzAsMC40MDMtMC4zMjcsMC43My0wLjczLDAuNzNIOS42NTZjLTEuNjYyLDAtMy4wMDksMS4zNDctMy4wMDksMy4wMDl2MC44MzRjMCwwLjUyNCwwLjQyNSwwLjk1LDAuOTUsMC45NWgxMC4wNDIgICAgYzAuNTI0LDAsMC45NDktMC40MjYsMC45NDktMC45NXYtMC44MzRDMTguNTg5LDE5LjY4LDE3LjI0MiwxOC4zMzIsMTUuNTgsMTguMzMyeiIgZmlsbD0iIzAwMDAwMCIvPgoJCTxwYXRoIGQ9Ik0yNC41ODksMTAuMDc3aC04LjQyMWMwLjI0MywwLjUzOCwwLjQxNywxLjIsMC40ODksMi4wMTljMC4xOCwwLjExMSwwLjMxNSwwLjI5LDAuNDI1LDAuNTA2aDcuNTA3ICAgIGMwLjM5LDAsMC43MDQtMC4zMTUsMC43MDQtMC43MDR2LTEuMTE3QzI1LjI5MywxMC4zOTMsMjQuOTc5LDEwLjA3NywyNC41ODksMTAuMDc3eiIgZmlsbD0iIzAwMDAwMCIvPgoJCTxwYXRoIGQ9Ik0yNC41ODksMTQuNjc4aC03LjMzNWMtMC4xOTksMC43NTItMC42ODksMS41MzktMS4zNjgsMS43NDljLTAuMDIsMC4wMzctMC4wNDMsMC4wNjktMC4wNjQsMC4xMDZ2MC42N2g4Ljc2NiAgICBjMC4zODksMCwwLjcwNC0wLjMxNSwwLjcwNC0wLjcwNXYtMS4xMTZDMjUuMjkzLDE0Ljk5MywyNC45NzksMTQuNjc4LDI0LjU4OSwxNC42Nzh6IiBmaWxsPSIjMDAwMDAwIi8+CgkJPHBhdGggZD0iTTI0LjU4OSwxOS4yNzloLTUuNzI2YzAuMzc4LDAuNTk4LDAuNiwxLjMwMywwLjYsMi4wNjJ2MC40NjNoNS4xMjZjMC4zOSwwLDAuNzA0LTAuMzE1LDAuNzA0LTAuNzA0di0xLjExNyAgICBDMjUuMjkzLDE5LjU5NCwyNC45NzksMTkuMjc5LDI0LjU4OSwxOS4yNzl6IiBmaWxsPSIjMDAwMDAwIi8+CgkJPHBhdGggZD0iTTI3LjYxNSwzLjA1N0g0LjMyNUMxLjkzNiwzLjA1NywwLDQuOTkzLDAsNy4zODJ2MTcuMTc2YzAsMi4zOSwxLjkzNiw0LjMyNSw0LjMyNSw0LjMyNWgyMy4yOSAgICBjMi4zODksMCw0LjMyNC0xLjkzNiw0LjMyNC00LjMyNVY3LjM4MkMzMS45MzksNC45OTMsMzAuMDA0LDMuMDU3LDI3LjYxNSwzLjA1N3ogTTI5Ljg5OCwyNC41NThjMCwxLjI1OS0xLjAyNCwyLjI4My0yLjI4MywyLjI4MyAgICBINC4zMjVjLTEuMjU5LDAtMi4yODMtMS4wMjQtMi4yODMtMi4yODNWNy4zODJjMC0xLjI1OSwxLjAyNC0yLjI4MywyLjI4My0yLjI4M2gyMy4yOWMxLjI1OSwwLDIuMjgzLDEuMDI0LDIuMjgzLDIuMjgzVjI0LjU1OHoiIGZpbGw9IiMwMDAwMDAiLz4KCTwvZz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8Zz4KPC9nPgo8L3N2Zz4K=\" height=\"16\" />  <b>{0}</b>: {1}")
end)
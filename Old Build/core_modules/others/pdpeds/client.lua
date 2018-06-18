local Grace = {
    Handle = nil,
    Model = "mp_f_freemode_01",
    Animations = {
        Dictionary = "amb@world_human_hang_out_street@female_arms_crossed@base",
        Animation = "base",
    },
    Coordinates = {x = 454.053, y = -979.939, z = 29.689, h = 86.588},
    Clothing = {
        Drawables = {40,121,42,31,37,0,29,0,35,0,7,48},
        Textures = {0,0,5,0,0,0,0,0,0,0,1,0},
        Palettes = {0,0,1,0,0,0,0,0,0,0,0,0},
    },
    Props = {
        Drawables = {-1,20,-1,-1,-1,-1,-1,-1},
        Textures = {-1,0,-1,-1,-1,-1,-1,-1},
    },
    Overlays = {
        Drawables = {255,255,0,255,0,0,255,255,0,255,255,255,255},
        Opacity = {1.0,1.0,0.9,1.0,0.9,0.9,1.0,1.0,0.9,1.0,1.0,1.0,1.0},
        Colours = {
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 1, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 2, Colour = 61},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 2, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
        },
    }
}

local Kole = {
    Handle = nil,
    Model = "mp_m_freemode_01",
    Animations = {
        Dictionary = "amb@world_human_hang_out_street@female_arms_crossed@base",
        Animation = "base",
    },
    Coordinates = {x = 454.04647827148, y = -980.49584960938, z = 30.689605712891, h = 88.353057861328},
    Clothing = {
        Drawables = {0,0,19,0,24,0,25,0,58,0,0,55},
        Textures = {0,0,38,0,2,0,0,0,0,0,0,0},
        Palettes = {0,0,1,0,0,0,0,0,0,0,0,0},
    },
    Props = {
        Drawables = {-1,9,-1,-1,-1,-1,3,-1},
        Textures = {-1,0,-1,-1,-1,-1,0,-1},
    },
    Overlays = {
        Drawables = {255,0,0,0,255,255,255,255,255,255,255,255,255},
        Opacity = {1.0,0.9,0.9,0.9,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0},
        Colours = {
            {ColourType = 0, Colour = 0},
            {ColourType = 1, Colour = 1},
            {ColourType = 1, Colour = 27},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
            {ColourType = 0, Colour = 0},
        },
    }
}

function CreateGrace()
    local Model = GetHashKey(Grace.Model)

    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(250)
    end

    Grace.Handle = CreatePed(4, Model, Grace.Coordinates.x, Grace.Coordinates.y, Grace.Coordinates.z, Grace.Coordinates.h, false, false)

    while not DoesEntityExist(Grace.Handle) do
        Citizen.Wait(250)
    end

    for i = 0, 11 do
        if i == 0 then
            SetPedHeadBlendData(Grace.Handle, Grace.Clothing.Drawables[i+1], Grace.Clothing.Drawables[i+1], 0, Grace.Clothing.Drawables[i+1], Grace.Clothing.Drawables[i+1], 0, 0.5, 0.5, 0.0, false)
        elseif i == 2 then
            SetPedComponentVariation(Grace.Handle, i, Grace.Clothing.Drawables[i+1], 0, 1)
            SetPedHairColor(Grace.Handle, Grace.Clothing.Textures[i+1], Grace.Clothing.Textures[i+1])
        else
            SetPedComponentVariation(Grace.Handle, i, Grace.Clothing.Drawables[i+1], Grace.Clothing.Textures[i+1], Grace.Clothing.Palettes[i+1])
        end
    end

    for i = 0, 7 do
        SetPedPropIndex(Grace.Handle, i, Grace.Props.Drawables[i+1], Grace.Props.Textures[i+1], false)
    end
            
    for i = 0, 12 do
        SetPedHeadOverlay(Grace.Handle, i, Grace.Overlays.Drawables[i+1], Grace.Overlays.Opacity[i+1])
        SetPedHeadOverlayColor(Grace.Handle, i, Grace.Overlays.Colours[i+1].ColourType, Grace.Overlays.Colours[i+1].Colour, Grace.Overlays.Colours[i+1].Colour)
    end

    SetEntityCanBeDamaged(Grace.Handle, false)
    SetPedCanRagdollFromPlayerImpact(Grace.Handle, false)
    TaskSetBlockingOfNonTemporaryEvents(Grace.Handle, true)
    SetPedFleeAttributes(Grace.Handle, 0, 0)
    SetPedCombatAttributes(Grace.Handle, 17, 1)
    SetEntityInvincible(Grace.Handle, true)
    --TaskStartScenarioInPlace(Grace.Handle, "WORLD_HUMAN_COP_IDLES", 0, true)

    RequestAnimDict(Grace.Animations.Dictionary)
    while not HasAnimDictLoaded(Grace.Animations.Dictionary) do
        Citizen.Wait(250)
    end

    TaskPlayAnim(Grace.Handle, Grace.Animations.Dictionary, Grace.Animations.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
end

function CreateKole()
    local Model = GetHashKey(Kole.Model)

    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(250)
    end

    Kole.Handle = CreatePed(4, Model, Kole.Coordinates.x, Kole.Coordinates.y, Kole.Coordinates.z, Kole.Coordinates.h, false, false)

    while not DoesEntityExist(Kole.Handle) do
        Citizen.Wait(250)
    end

    for i = 0, 11 do
        if i == 0 then
            SetPedHeadBlendData(Kole.Handle, Kole.Clothing.Drawables[i+1], Kole.Clothing.Drawables[i+1], 0, Kole.Clothing.Drawables[i+1], Kole.Clothing.Drawables[i+1], 0, 0.5, 0.5, 0.0, false)
        elseif i == 2 then
            SetPedComponentVariation(Kole.Handle, i, Kole.Clothing.Drawables[i+1], 0, 1)
            SetPedHairColor(Kole.Handle, Kole.Clothing.Textures[i+1], Kole.Clothing.Textures[i+1])
        else
            SetPedComponentVariation(Kole.Handle, i, Kole.Clothing.Drawables[i+1], Kole.Clothing.Textures[i+1], Kole.Clothing.Palettes[i+1])
        end
    end

    for i = 0, 7 do
        SetPedPropIndex(Kole.Handle, i, Kole.Props.Drawables[i+1], Kole.Props.Textures[i+1], false)
    end
            
    for i = 0, 12 do
        SetPedHeadOverlay(Kole.Handle, i, Kole.Overlays.Drawables[i+1], Kole.Overlays.Opacity[i+1])
        SetPedHeadOverlayColor(Kole.Handle, i, Kole.Overlays.Colours[i+1].ColourType, Kole.Overlays.Colours[i+1].Colour, Kole.Overlays.Colours[i+1].Colour)
    end

    SetEntityCanBeDamaged(Kole.Handle, false)
    SetPedCanRagdollFromPlayerImpact(Kole.Handle, false)
    TaskSetBlockingOfNonTemporaryEvents(Kole.Handle, true)
    SetPedFleeAttributes(Kole.Handle, 0, 0)
    SetPedCombatAttributes(Kole.Handle, 17, 1)
    SetEntityInvincible(Kole.Handle, true)
    --TaskStartScenarioInPlace(Kole.Handle, "WORLD_HUMAN_COP_IDLES", 0, true)

    RequestAnimDict(Kole.Animations.Dictionary)
    while not HasAnimDictLoaded(Kole.Animations.Dictionary) do
        Citizen.Wait(250)
    end

    TaskPlayAnim(Kole.Handle, Kole.Animations.Dictionary, Kole.Animations.Animation, 8.0, 8.0, -1, 50, 0, false, false, false)
end
Citizen.CreateThread(function()
    CreateGrace()
    CreateKole()
end)
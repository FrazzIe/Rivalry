--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Paramedic Clothing                                                     --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local componentScroller = 0
local subComponentScroller = 0
local textureScroller = 0
local paletteScroller = 0
local removeScroller = 0
local opacityScroller = 0
local colourScroller = 0

function GetOverlayColourType(Overlay)
    if Overlay == 1 or Overlay == 2 or Overlay == 10 then
        return 1
    elseif Overlay == 5 or Overlay == 8 then
        return 2
    else
        return 0
    end
end

function OpenClothes()
    Menu.SetupMenu("clothing_main","Clothing")
    Menu.Switch(nil, "clothing_main")
    for k,v in pairs(menu_options) do
        Menu.addOption("clothing_main", function()
            if(Menu.Option(v.name))then
                v.f(v.name,v.param)
            end
        end)
    end
end

function listModels(title, table)
    Menu.SetupMenu("clothing_models", title)
    Menu.Switch("clothing_main", "clothing_models")
    for k,v in pairs(table) do
        Menu.addOption("clothing_models", function()
            if(Menu.Option(v))then
                TriggerEvent("paramedic:changemodel", v)
            end
        end)
    end
end

function customise(title)
    Menu.SetupMenu("clothing_customise", title)
    Menu.Switch("clothing_main", "clothing_customise")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        componentScroller = 0
        subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
        textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
        paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarString({"Head","Mask","Hair","Arms","Pants","Parachutes","Shoes","Necklace & Ties","Undershirt","Body Armour","Decals","Shirts"}, componentScroller, function(cb) componentScroller = cb end)) then
                subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
                textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
                paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedDrawableVariations(PlayerPedId(), componentScroller), function(cb) subComponentScroller = cb end)) then
                if componentScroller == 0 then
                    SetPedHeadBlendData(PlayerPedId(), subComponentScroller, subComponentScroller, 0, subComponentScroller, subComponentScroller, 0, 0.5, 0.5, 0.0, false)
                end
                SetPedComponentVariation(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                textureScroller = 0
                paletteScroller = 0
            end
        end)
        Menu.addOption("clothing_customise", function()
            local textureMax = 0
            if componentScroller == 2 then textureMax = GetNumHairColors() else textureMax = GetNumberOfPedTextureVariations(PlayerPedId(), componentScroller, subComponentScroller) end
            if(Menu.ScrollBarInt("Textures", textureScroller, textureMax, function(cb) textureScroller = cb end)) then
                if componentScroller == 2 then
                    SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, 0, 1)
                    SetPedHairColor(PlayerPedId(), textureScroller, textureScroller)
                    player_data.clothing.textures[3] = textureScroller
                else
                    SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                end
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Colour Palette", paletteScroller, 2, function(cb) paletteScroller = cb end)) then
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.Option("Remove Undershirt"))then
                SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.Option("Randomize"))then
                SetPedRandomComponentVariation(PlayerPedId(), true)
            end
        end)
    else
        componentScroller = 0
        subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
        textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
        paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_customise", function()
            local precomponentTable = {"Head","No idea","Hair","Shirts","Pants","No idea","No idea","No idea","Necklace & Ties","No idea","No idea","No idea"}
            local componentTable = {}
            for i = 0, 11 do
                if GetNumberOfPedDrawableVariations(PlayerPedId(), i) ~= 0 and GetNumberOfPedDrawableVariations(PlayerPedId(), i) ~= false then
                    componentTable[i+1] = precomponentTable[i+1]
                else
                    componentTable[i+1] = "Empty slot"
                end
            end
            if(Menu.ScrollBarString(componentTable, componentScroller, function(cb) componentScroller = cb end)) then
                subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
                textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
                paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedDrawableVariations(PlayerPedId(), componentScroller), function(cb) subComponentScroller = cb end)) then
                SetPedComponentVariation(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                textureScroller = 0
                paletteScroller = 0
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Textures", textureScroller, GetNumberOfPedTextureVariations(PlayerPedId(), componentScroller, subComponentScroller), function(cb) textureScroller = cb end)) then
                if componentScroller == 2 then player_data.clothing.textures[3] = textureScroller end
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Colour Palette", paletteScroller, 2, function(cb) paletteScroller = cb end)) then
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.Option("Randomize"))then
                SetPedRandomComponentVariation(PlayerPedId(), true)
            end
        end)
    end
end

function accessories(title)
    Menu.SetupMenu("clothing_accessories", title)
    Menu.Switch("clothing_main", "clothing_accessories")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        componentScroller = 0
        subComponentScroller = GetPedPropIndex(PlayerPedId(), componentScroller)
        textureScroller = GetPedPropTextureIndex(PlayerPedId(), componentScroller)
        removeScroller = 0
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarString({"Hats/Helmets","Glasses","Earrings","Empty slot","Empty slot","Empty slot","Left Wrist","Right Wrist"}, componentScroller, function(cb) componentScroller = cb end)) then
                subComponentScroller = GetPedPropIndex(PlayerPedId(), componentScroller)
                textureScroller = GetPedPropTextureIndex(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedPropDrawableVariations(PlayerPedId(), componentScroller), function(cb) subComponentScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
                textureScroller = 0
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Textures", textureScroller, GetNumberOfPedPropTextureVariations(PlayerPedId(), componentScroller, subComponentScroller), function(cb) textureScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarStringSelect({"Remove helmets","Remove glasses","Remove earrings","Remove left wrist","Remove right wrist"}, removeScroller, function(cb) removeScroller = cb end)) then
                if removeScroller ~= 3 and removeScroller ~= 4 then
                    ClearPedProp(PlayerPedId(), tonumber(removeScroller))
                elseif removeScroller == 3 then
                    ClearPedProp(PlayerPedId(), 6)
                else
                    ClearPedProp(PlayerPedId(), 7)
                end
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.Option("Randomize"))then
                SetPedRandomProps(PlayerPedId())
            end
        end)
    else
        local precomponentTable = {"Hats/Helmets","Glasses","Earrings","Empty slot","Empty slot","Empty slot","Left Wrist","Right Wrist"}
        local componentTable = {}
        for i = 0, 7 do
            if GetNumberOfPedPropDrawableVariations(PlayerPedId(), i) ~= 0 and GetNumberOfPedPropDrawableVariations(PlayerPedId(), i) ~= false then
                componentTable[i+1] = precomponentTable[i+1]
            else
                componentTable[i+1] = "Empty slot"
            end
        end
        componentScroller = 0
        subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
        textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
        removeScroller = 0
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarString(componentTable, componentScroller, function(cb) componentScroller = cb end)) then
                subComponentScroller = GetPedPropIndex(PlayerPedId(), componentScroller)
                textureScroller = GetPedPropTextureIndex(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedPropDrawableVariations(PlayerPedId(), componentScroller), function(cb) subComponentScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
                textureScroller = 0
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Textures", textureScroller, GetNumberOfPedPropTextureVariations(PlayerPedId(), componentScroller, subComponentScroller) or 0, function(cb) textureScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarStringSelect({"Remove helmets","Remove glasses","Remove earrings","Remove left wrist","Remove right wrist"}, removeScroller, function(cb) removeScroller = cb end)) then
                if removeScroller ~= 3 and removeScroller ~= 4 then
                    ClearPedProp(PlayerPedId(), tonumber(removeScroller))
                elseif removeScroller == 3 then
                    ClearPedProp(PlayerPedId(), 6)
                else
                    ClearPedProp(PlayerPedId(), 7)
                end
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.Option("Randomize"))then
                SetPedRandomProps(PlayerPedId())
            end
        end)
    end
end

function overlays(title)
    Menu.SetupMenu("clothing_overlays", title)
    Menu.Switch("clothing_main", "clothing_overlays")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        componentScroller = 0
        removeScroller = 0
        subComponentScroller = GetPedHeadOverlayValue(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarString({"Blemishes","Facial Hair","Eyebrows","Ageing","Makeup","Blush","Complexion","Sun Damage","Lipstick","Moles/Freckles","Chest hair","Body blemishes","Add Body blemishes"}, componentScroller, function(cb) componentScroller = cb end)) then
                subComponentScroller = GetPedHeadOverlayValue(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumHeadOverlayValues(componentScroller)-1, function(cb) subComponentScroller = cb end)) then
                SetPedHeadOverlay(PlayerPedId(), componentScroller, subComponentScroller, player_data.overlays.opacity[componentScroller+1] or 1.0)
                player_data.overlays.drawables[componentScroller+1] = subComponentScroller
                opacityScroller = player_data.overlays.opacity[componentScroller+1] or 1.0
            end
        end)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarInt("Opacity", opacityScroller, 10, function(cb) opacityScroller = cb end)) then
                SetPedHeadOverlay(PlayerPedId(), componentScroller, subComponentScroller, tonumber(opacityScroller/10))
                player_data.overlays.opacity[componentScroller+1] = tonumber(opacityScroller/10)
            end
        end)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarInt("Colours", colourScroller, 63, function(cb) colourScroller = cb end)) then
                local colourType = GetOverlayColourType(componentScroller)
                SetPedHeadOverlayColor(PlayerPedId(), componentScroller, colourType, colourScroller, colourScroller)
                player_data.overlays.colours[componentScroller+1] = {colourType = colourType, colour = colourScroller}
            end
        end)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarStringSelect({"Reset Blemishes","Reset Facial Hair","Reset Eyebrows","Reset Ageing","Reset Makeup","Reset Blush","Reset Complexion","Reset Sun Damage","Reset Lipstick","Reset Moles/Freckles","Reset Chest hair","Reset Body blemishes","Reset Body blemishes 2"}, removeScroller, function(cb) removeScroller = cb end)) then
                SetPedHeadOverlay(PlayerPedId(), removeScroller, 255, player_data.overlays.opacity[componentScroller+1] or 1.0)
                player_data.overlays.drawables[removeScroller+1] = 255
            end
        end)
    else
    end
end

function save()
    player_data.new = "false"
    for i = 0, 11 do
        player_data.clothing.drawables[i+1] = GetPedDrawableVariation(PlayerPedId(), i)
        if i ~= 2 then
            player_data.clothing.textures[i+1] = GetPedTextureVariation(PlayerPedId(), i)
        end
        player_data.clothing.palette[i+1] = GetPedPaletteVariation(PlayerPedId(), i)
    end
    for i = 0, 7 do
        player_data.props.drawables[i+1] = GetPedPropIndex(PlayerPedId(), i)
        player_data.props.textures[i+1] = GetPedPropTextureIndex(PlayerPedId(), i)
    end
    for i = 0, 12 do
        player_data.overlays.drawables[i+1] = GetPedHeadOverlayValue(PlayerPedId(), i)
    end

    if player_data.clothing.drawables[12] == 55 and GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then player_data.clothing.drawables[12] = 56 SetPedComponentVariation(PlayerPedId(), 11, 56, 0, 2) end
    if player_data.clothing.drawables[12] == 48 and GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then player_data.clothing.drawables[12] = 49 SetPedComponentVariation(PlayerPedId(), 11, 49, 0, 2) end

    TriggerServerEvent("paramedic:save_clothing", player_data)
end

AddEventHandler("paramedic:changemodel", function(skin)
    local model = GetHashKey(skin)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        player_data.model = skin
        if skin ~= "mp_f_freemode_01" and skin ~= "mp_m_freemode_01" then 
            SetPedRandomComponentVariation(PlayerPedId(), true)
        else
            SetPedComponentVariation(PlayerPedId(), 11, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 11, 6, 1, 0)
            SetPedHeadBlendData(PlayerPedId(), player_data.clothing.drawables[1] or 0, player_data.clothing.drawables[1] or 0, 0, player_data.clothing.drawables[1] or 0, player_data.clothing.drawables[1] or 0, 0, 0.5, 0.5, 0.0, false)
        end
        SetModelAsNoLongerNeeded(model)
    else
    end
end)

RegisterNetEvent("paramedic:load_clothing")
AddEventHandler("paramedic:load_clothing", function(data)
    player_data = data
    local model = player_data.model
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        if model ~= "mp_f_freemode_01" and model ~= "mp_m_freemode_01" then 
            SetPedRandomComponentVariation(PlayerPedId(), true)
        else
            SetPedComponentVariation(PlayerPedId(), 11, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 11, 6, 1, 0)
            SetPedHeadBlendData(PlayerPedId(), player_data.clothing.drawables[1] or 0, player_data.clothing.drawables[1] or 0, 0, player_data.clothing.drawables[1] or 0, player_data.clothing.drawables[1] or 0, 0, 0.5, 0.5, 0.0, false)
        end
        SetModelAsNoLongerNeeded(model)
        if player_data.new == "false" then
            TriggerEvent("paramedic:setComponents")
        else
            TriggerServerEvent("paramedic:model_loaded", isInService)
        end
    end
end)

AddEventHandler("paramedic:setComponents", function()
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        SetPedHeadBlendData(PlayerPedId(), player_data.clothing.drawables[1], player_data.clothing.drawables[1], 0, player_data.clothing.drawables[1], player_data.clothing.drawables[1], 0, 0.5, 0.5, 0.0, false)

        for i = 0, 12 do
            SetPedHeadOverlay(PlayerPedId(), i, player_data.overlays.drawables[i+1], player_data.overlays.opacity[i+1])
            SetPedHeadOverlayColor(PlayerPedId(), i, GetOverlayColourType(i), player_data.overlays.colours[i+1].colour, player_data.overlays.colours[i+1].colour)
        end

        SetPedComponentVariation(PlayerPedId(), 2, player_data.clothing.drawables[3], 0, 1)
        SetPedHairColor(PlayerPedId(), player_data.clothing.textures[3], player_data.clothing.textures[3])
        
        for i = 3, 11 do
            SetPedComponentVariation(PlayerPedId(), i, player_data.clothing.drawables[i+1], player_data.clothing.textures[i+1], player_data.clothing.palette[i+1])
        end

        for i = 0, 7 do
            SetPedPropIndex(PlayerPedId(), i, player_data.props.drawables[i+1], player_data.props.textures[i+1], true)
        end

        exports["core_modules"]:ApplyTattoos(PlayerPedId())
        
        TriggerServerEvent("paramedic:model_loaded", isInService)
    else
        for i = 0, 11 do
            SetPedComponentVariation(PlayerPedId(), i, player_data.clothing.drawables[i+1], player_data.clothing.textures[i+1], player_data.clothing.palette[i+1])
        end
        for i = 0, 7 do
            SetPedPropIndex(PlayerPedId(), i, player_data.props.drawables[i+1], player_data.props.textures[i+1], false)
        end
        TriggerServerEvent("paramedic:model_loaded", isInService)
    end
end)
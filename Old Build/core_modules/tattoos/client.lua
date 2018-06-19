local componentScroller = 0
local subComponentScroller = 0
local subComponentScrollerMax = 0

function OpenTattoos()
    Menu.SetupMenu("tattoos_main","Tattoos")
    Menu.Switch(nil, "tattoos_main")
    for k,v in pairs(menu_options) do
        Menu.addOption("tattoos_main", function()
            if(Menu.Option(v.name))then
                 v.f(v.name,v.param)
            end
        end)
    end
end

function customise(title)
    Menu.SetupMenu("tattoo_customise", title)
    Menu.Switch("tattoo_main", "tattoo_customise")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        if(GetEntityModel(PlayerPedId())== GetHashKey("mp_m_freemode_01"))then
        SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 4, 14,0, 2)
    else
        SetPedComponentVariation(GetPlayerPed(-1), 8, 34,0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 11, 101,1, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 4, 16,0, 2)
    end
        componentScroller = 1
        Menu.addOption("tattoo_customise", function()
            if(Menu.ScrollBarString({"Buisness", "Hipster", "Biker", "Air Races", "Beach", "Christmas", "Gun Running", "Imports", "Low Rider2", "Low Rider"}, componentScroller, function(cb) Citizen.Trace(cb) componentScroller = cb end)) then
                if(componentScroller == 1) then
                    subComponentScrollerMax = 15
                elseif(componentScroller == 1) then
                    subComponentScrollerMax =  49                           
                elseif(componentScroller == 2) then
                    subComponentScrollerMax = 61
                elseif(componentScroller == 3) then
                    subComponentScrollerMax = 8
                elseif(componentScroller == 4) then
                    subComponentScrollerMax = 17
                elseif(componentScroller == 5) then
                    subComponentScrollerMax = 27
                elseif(componentScroller == 6) then
                    subComponentScrollerMax = 30
                elseif(componentScroller == 7) then
                    subComponentScrollerMax = 12
                elseif(componentScroller == 8) then
                    subComponentScrollerMax = 16
                elseif (componentScroller == 9) then
                    subComponentScrollerMax = 17
                end
                subComponentScroller = 0
            end
        end)
        Menu.addOption("tattoo_customise", function()
            if(Menu.ScrollBarInt("Tattoo", componentScroller, subComponentScrollerMax, function(cb) Citizen.Trace(cb) subComponentScroller = cb end)) then
                ApplyPedOverlay(PlayerPedId(), GetHashKey(tattoosCategories[componentScroller].value), GetHashKey(tattoosList[tattoosCategories[componentScroller].value][subComponentScroller].nameHash) )
                    if(IsControlJustPressed(1, 11))then
                        ClearPedDecorations(PlayerPedId())
                    end
            end
        end)
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

    TriggerServerEvent("clothes:save", player_data)
    TriggerServerEvent("core:model_loaded")
end

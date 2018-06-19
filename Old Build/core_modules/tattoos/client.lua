local componentScroller = 0
local subComponentScroller = 0
local subComponentScrollerMax = 0
local tattootable = {}

function reapplyTattoos(ped)
    local ped = ped
    for k, v in pairs(tattootable) do
        ApplyPedOverlay(ped, v.typet, v.drawt)
    end
end


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
    Menu.SetupMenu("tattoo_customise", "title")
    Menu.Switch("tattoos_main", "tattoo_customise")
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
        componentScroller = 0
        Menu.addOption("tattoo_customise", function()
            if(Menu.ScrollBarString({"TattooSelection","Buisness", "Hipster", "Biker", "Air Races", "Beach", "Christmas", "Gun Running", "Imports", "Low Rider2", "Low Rider"}, componentScroller, function(cb) Citizen.Trace(cb) componentScroller = cb end)) then
                if(componentScroller == 1) then
                    subComponentScrollerMax = 26
                elseif(componentScroller == 2) then
                    subComponentScrollerMax =  50                           
                elseif(componentScroller == 3) then
                    subComponentScrollerMax = 61
                elseif(componentScroller == 4) then
                    subComponentScrollerMax = 9
                elseif(componentScroller == 5) then
                    subComponentScrollerMax = 17
                elseif(componentScroller == 6) then
                    subComponentScrollerMax = 27
                elseif(componentScroller == 7) then
                    subComponentScrollerMax = 30
                elseif(componentScroller == 8) then
                    subComponentScrollerMax = 12
                elseif(componentScroller == 9) then
                    subComponentScrollerMax = 16
                elseif (componentScroller == 10) then
                    subComponentScrollerMax = 17
                end
                subComponentScroller = 0
            end
        end)
        Menu.addOption("tattoo_customise", function()
            if(Menu.ScrollBarInt("Tattoo", subComponentScroller, subComponentScrollerMax, function(cb) Citizen.Trace(cb) subComponentScroller = cb end)) then
            ClearPedDecorations(PlayerPedId())
            reapplyTattoos(PlayerPedId())
                if(subComponentScroller <= subComponentScrollerMax and subComponentScroller >= 1 and componentScroller ~= 0) then
                    ApplyPedOverlay(PlayerPedId(), GetHashKey(tattoosCategories[componentScroller].value), GetHashKey(tattoosList[tattoosCategories[componentScroller].value][subComponentScroller].nameHash) )
                    Citizen.CreateThread(function()
                        while true do
                        Citizen.Wait(0)
                            if IsControlJustReleased(1, 55) then -- INPUT_CELLPHONE_DOWN
                                local tattoostables = {
                                typet = GetHashKey(tattoosCategories[componentScroller].value),
                                drawt = GetHashKey(tattoosList[tattoosCategories[componentScroller].value][subComponentScroller].nameHash)
                                }
                                table.insert(tattootable, tattoostables)
                            end
                        end
                    end)
                end
            end
        end)
    end
end

function save()
    player_data.new = "false"
    for i = 0, 10 do
        player_data.tattoostype[i] = componentScroller
    end
    for i = 0, subComponentScrollerMax do
        player_data.tattoos[i] = subComponentScoller
    end

    TriggerServerEvent("tattoos:save", player_data)
    TriggerServerEvent("core:model_loaded")
end

AddEventHandler("tattoos:setComponents", function()
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        for i = 0, 9 do
            for k = 0, subComponentScrollerMax do
                ApplyPedOverlay(PlayerPedId(), GetHashKey(player_data.tattoostype[i+1]), GetHashKey(player_data_tattoos[k+1]))
            end
        end
        TriggerServerEvent("core:model_loaded")
    else
        TriggerServerEvent("core:model_loaded")
    end
end)

RegisterNetEvent("tattoos:spawn")
AddEventHandler("tattoos:spawn", function(data)
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
        end
        SetModelAsNoLongerNeeded(model)
        if player_data.new == "false" then
            TriggerEvent("tattoos:setComponents")
        else
            TriggerServerEvent("core:model_loaded")
        end
    end
end)

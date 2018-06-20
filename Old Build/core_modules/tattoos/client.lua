local Pool = NativeUI.CreatePool()
local TattooMenu = NativeUI.CreateMenu("Tattoo Parlour", "", 1300, 300)
local Tattoos = {
    Active = {},
    Locations = {
        [1] = {
            Blip = {
                Name = "Tattoo Store", 
                Sprite = 75, 
                Colour = 0,
            },
            Marker = {
                x = 1322.645,
                y = -1651.976,
                z = 52.275,
            },
        },
        [2] = {
            Blip = {
                Name = "Tattoo Store", 
                Sprite = 75, 
                Colour = 0,
            },
            Marker = {
                x = -1153.676, 
                y = -1425.68, 
                z = 4.954
            },
        },
        [3] = {
            Blip = {
                Name = "Tattoo Store", 
                Sprite = 75, 
                Colour = 0,
            },
            Marker = {
                x = 322.139,
                y = 180.467, 
                z = 103.587
            },
        },
        [4] = {
            Blip = {
                Name = "Tattoo Store", 
                Sprite = 75, 
                Colour = 0,
            },
            Marker = {
                x = -3170.071, 
                y = 1075.059, 
                z = 20.829
            },
        },
        [5] = {
            Blip = {
                Name = "Tattoo Store", 
                Sprite = 75, 
                Colour = 0,
            },
            Marker = {
                x = 1864.633, 
                y = 3747.738, 
                z = 33.032
            },
        },
        [6] = {
            Blip = {
                Name = "Tattoo Store", 
                Sprite = 75, 
                Colour = 0,
            },
            Marker = {
                x = -293.713, 
                y = 6200.04, 
                z = 31.487
            },
        },
    },
    Collections = {
        [1] = {Name = "Business", Value = "mpbusiness_overlays"},
        [2] = {Name = "Hipster", Value = "mphipster_overlays"},
        [3] = {Name = "Biker", Value = "mpbiker_overlays"},
        [4] = {Name = "Air", Value = "mpairraces_overlays"},
        [5] = {Name = "Beach", Value = "mpbeach_overlays"},
        [6] = {Name = "Christmas", Value = "mpchristmas2_overlays"},
        [7] = {Name = "Gunrunning", Value = "mpgunrunning_overlays"},
        [8] = {Name = "Import", Value = "mpimportexport_overlays"},
        [9] = {Name = "Lowrider", Value = "mplowrider_overlays"},
        [10] = {Name = "Lowrider 2", Value = "mplowrider2_overlays"},
    },
    List = {
        [1] = {
            "MP_Buis_M_Neck_000",
            "MP_Buis_M_Neck_001",
            "MP_Buis_M_Neck_002",
            "MP_Buis_M_Neck_003",
            "MP_Buis_M_LeftArm_000",
            "MP_Buis_M_LeftArm_001",
            "MP_Buis_M_RightArm_000",
            "MP_Buis_M_RightArm_001",
            "MP_Buis_M_Stomach_000",
            "MP_Buis_M_Chest_000",
            "MP_Buis_M_Chest_001",
            "MP_Buis_M_Back_000",
            "MP_Buis_F_Chest_000",
            "MP_Buis_F_Chest_001",
            "MP_Buis_F_Chest_002",
            "MP_Buis_F_Stom_000",
            "MP_Buis_F_Stom_001",
            "MP_Buis_F_Stom_002",
            "MP_Buis_F_Back_000",
            "MP_Buis_F_Back_001",
            "MP_Buis_F_Neck_000",
            "MP_Buis_F_Neck_001",
            "MP_Buis_F_RArm_000",
            "MP_Buis_F_LArm_000",
            "MP_Buis_F_LLeg_000",
            "MP_Buis_F_RLeg_000",
        },
        [2] = {
            "FM_Hip_M_Tat_000",
            "FM_Hip_M_Tat_001",
            "FM_Hip_M_Tat_002",
            "FM_Hip_M_Tat_003",
            "FM_Hip_M_Tat_004",
            "FM_Hip_M_Tat_005",
            "FM_Hip_M_Tat_006",
            "FM_Hip_M_Tat_007",
            "FM_Hip_M_Tat_008",
            "FM_Hip_M_Tat_009",
            "FM_Hip_M_Tat_010",
            "FM_Hip_M_Tat_011",
            "FM_Hip_M_Tat_012",
            "FM_Hip_M_Tat_013",
            "FM_Hip_M_Tat_014",
            "FM_Hip_M_Tat_015",
            "FM_Hip_M_Tat_016",
            "FM_Hip_M_Tat_017",
            "FM_Hip_M_Tat_018",
            "FM_Hip_M_Tat_019",
            "FM_Hip_M_Tat_020",
            "FM_Hip_M_Tat_021",
            "FM_Hip_M_Tat_022",
            "FM_Hip_M_Tat_023",
            "FM_Hip_M_Tat_024",
            "FM_Hip_M_Tat_025",
            "FM_Hip_M_Tat_026",
            "FM_Hip_M_Tat_027",
            "FM_Hip_M_Tat_028",
            "FM_Hip_M_Tat_029",
            "FM_Hip_M_Tat_030",
            "FM_Hip_M_Tat_031",
            "FM_Hip_M_Tat_032",
            "FM_Hip_M_Tat_033",
            "FM_Hip_M_Tat_034",
            "FM_Hip_M_Tat_035",
            "FM_Hip_M_Tat_036",
            "FM_Hip_M_Tat_037",
            "FM_Hip_M_Tat_038",
            "FM_Hip_M_Tat_039",
            "FM_Hip_M_Tat_040",
            "FM_Hip_M_Tat_041",
            "FM_Hip_M_Tat_042",
            "FM_Hip_M_Tat_043",
            "FM_Hip_M_Tat_044",
            "FM_Hip_M_Tat_045",
            "FM_Hip_M_Tat_046",
            "FM_Hip_M_Tat_047",
            "FM_Hip_M_Tat_048",
        },
        [3] = {
            "MP_MP_Biker_Tat_000_M",
            "MP_MP_Biker_Tat_001_M",
            "MP_MP_Biker_Tat_002_M",
            "MP_MP_Biker_Tat_003_M",
            "MP_MP_Biker_Tat_004_M",
            "MP_MP_Biker_Tat_005_M",
            "MP_MP_Biker_Tat_006_M",
            "MP_MP_Biker_Tat_007_M",
            "MP_MP_Biker_Tat_008_M",
            "MP_MP_Biker_Tat_009_M",
            "MP_MP_Biker_Tat_010_M",
            "MP_MP_Biker_Tat_011_M",
            "MP_MP_Biker_Tat_012_M",
            "MP_MP_Biker_Tat_013_M",
            "MP_MP_Biker_Tat_014_M",
            "MP_MP_Biker_Tat_015_M",
            "MP_MP_Biker_Tat_016_M",
            "MP_MP_Biker_Tat_017_M",
            "MP_MP_Biker_Tat_018_M",
            "MP_MP_Biker_Tat_019_M",
            "MP_MP_Biker_Tat_020_M",
            "MP_MP_Biker_Tat_021_M",
            "MP_MP_Biker_Tat_022_M",
            "MP_MP_Biker_Tat_023_M",
            "MP_MP_Biker_Tat_024_M",
            "MP_MP_Biker_Tat_025_M",
            "MP_MP_Biker_Tat_026_M",
            "MP_MP_Biker_Tat_027_M",
            "MP_MP_Biker_Tat_028_M",
            "MP_MP_Biker_Tat_029_M",
            "MP_MP_Biker_Tat_030_M",
            "MP_MP_Biker_Tat_031_M",
            "MP_MP_Biker_Tat_032_M",
            "MP_MP_Biker_Tat_033_M",
            "MP_MP_Biker_Tat_034_M",
            "MP_MP_Biker_Tat_035_M",
            "MP_MP_Biker_Tat_036_M",
            "MP_MP_Biker_Tat_037_M",
            "MP_MP_Biker_Tat_038_M",
            "MP_MP_Biker_Tat_039_M",
            "MP_MP_Biker_Tat_040_M",
            "MP_MP_Biker_Tat_041_M",
            "MP_MP_Biker_Tat_042_M",
            "MP_MP_Biker_Tat_043_M",
            "MP_MP_Biker_Tat_044_M",
            "MP_MP_Biker_Tat_045_M",
            "MP_MP_Biker_Tat_046_M",
            "MP_MP_Biker_Tat_047_M",
            "MP_MP_Biker_Tat_048_M",
            "MP_MP_Biker_Tat_049_M",
            "MP_MP_Biker_Tat_050_M",
            "MP_MP_Biker_Tat_051_M",
            "MP_MP_Biker_Tat_052_M",
            "MP_MP_Biker_Tat_053_M",
            "MP_MP_Biker_Tat_054_M",
            "MP_MP_Biker_Tat_055_M",
            "MP_MP_Biker_Tat_056_M",
            "MP_MP_Biker_Tat_057_M",
            "MP_MP_Biker_Tat_058_M",
            "MP_MP_Biker_Tat_059_M",
            "MP_MP_Biker_Tat_060_M",
        },
        [4] = {
            "MP_Airraces_Tattoo_000_M",
            "MP_Airraces_Tattoo_001_M",
            "MP_Airraces_Tattoo_002_M",
            "MP_Airraces_Tattoo_003_M",
            "MP_Airraces_Tattoo_004_M",
            "MP_Airraces_Tattoo_005_M",
            "MP_Airraces_Tattoo_006_M",
            "MP_Airraces_Tattoo_007_M",
        },
        [5] = {
            "MP_Bea_M_Back_000",
            "MP_Bea_M_Chest_000",
            "MP_Bea_M_Chest_001",
            "MP_Bea_M_Head_000",
            "MP_Bea_M_Head_001",
            "MP_Bea_M_Head_002",
            "MP_Bea_M_Lleg_000",
            "MP_Bea_M_Rleg_000",
            "MP_Bea_M_RArm_000",
            "MP_Bea_M_Head_000",
            "MP_Bea_M_LArm_000",
            "MP_Bea_M_LArm_001",
            "MP_Bea_M_Neck_000",
            "MP_Bea_M_Neck_001",
            "MP_Bea_M_RArm_001",
            "MP_Bea_M_Stom_000",
            "MP_Bea_M_Stom_001",
        },
        [6] = {
            "MP_Xmas2_M_Tat_000",
            "MP_Xmas2_M_Tat_001",
            "MP_Xmas2_M_Tat_003",
            "MP_Xmas2_M_Tat_004",
            "MP_Xmas2_M_Tat_005",
            "MP_Xmas2_M_Tat_006",
            "MP_Xmas2_M_Tat_007",
            "MP_Xmas2_M_Tat_008",
            "MP_Xmas2_M_Tat_009",
            "MP_Xmas2_M_Tat_010",
            "MP_Xmas2_M_Tat_011",
            "MP_Xmas2_M_Tat_012",
            "MP_Xmas2_M_Tat_013",
            "MP_Xmas2_M_Tat_014",
            "MP_Xmas2_M_Tat_015",
            "MP_Xmas2_M_Tat_016",
            "MP_Xmas2_M_Tat_017",
            "MP_Xmas2_M_Tat_018",
            "MP_Xmas2_M_Tat_019",
            "MP_Xmas2_M_Tat_022",
            "MP_Xmas2_M_Tat_023",
            "MP_Xmas2_M_Tat_024",
            "MP_Xmas2_M_Tat_025",
            "MP_Xmas2_M_Tat_026",
            "MP_Xmas2_M_Tat_027",
            "MP_Xmas2_M_Tat_028",
            "MP_Xmas2_M_Tat_029",
        },
        [7] = {
            "MP_Gunrunning_Tattoo_000_M",
            "MP_Gunrunning_Tattoo_001_M",
            "MP_Gunrunning_Tattoo_002_M",
            "MP_Gunrunning_Tattoo_003_M",
            "MP_Gunrunning_Tattoo_004_M",
            "MP_Gunrunning_Tattoo_005_M",
            "MP_Gunrunning_Tattoo_006_M",
            "MP_Gunrunning_Tattoo_007_M",
            "MP_Gunrunning_Tattoo_008_M",
            "MP_Gunrunning_Tattoo_009_M",
            "MP_Gunrunning_Tattoo_010_M",
            "MP_Gunrunning_Tattoo_011_M",
            "MP_Gunrunning_Tattoo_012_M",
            "MP_Gunrunning_Tattoo_013_M",
            "MP_Gunrunning_Tattoo_014_M",
            "MP_Gunrunning_Tattoo_015_M",
            "MP_Gunrunning_Tattoo_016_M",
            "MP_Gunrunning_Tattoo_017_M",
            "MP_Gunrunning_Tattoo_018_M",
            "MP_Gunrunning_Tattoo_019_M",
            "MP_Gunrunning_Tattoo_020_M",
            "MP_Gunrunning_Tattoo_021_M",
            "MP_Gunrunning_Tattoo_022_M",
            "MP_Gunrunning_Tattoo_023_M",
            "MP_Gunrunning_Tattoo_024_M",
            "MP_Gunrunning_Tattoo_025_M",
            "MP_Gunrunning_Tattoo_026_M",
            "MP_Gunrunning_Tattoo_027_M",
            "MP_Gunrunning_Tattoo_028_M",
            "MP_Gunrunning_Tattoo_029_M",
            "MP_Gunrunning_Tattoo_030_M",
        },
        [8] = {
            "MP_MP_ImportExport_Tat_000_M",
            "MP_MP_ImportExport_Tat_001_M",
            "MP_MP_ImportExport_Tat_002_M",
            "MP_MP_ImportExport_Tat_003_M",
            "MP_MP_ImportExport_Tat_004_M",
            "MP_MP_ImportExport_Tat_005_M",
            "MP_MP_ImportExport_Tat_006_M",
            "MP_MP_ImportExport_Tat_007_M",
            "MP_MP_ImportExport_Tat_008_M",
            "MP_MP_ImportExport_Tat_009_M",
            "MP_MP_ImportExport_Tat_010_M",
            "MP_MP_ImportExport_Tat_011_M",
        },
        [9] = {
            "MP_LR_Tat_001_M",
            "MP_LR_Tat_002_M",
            "MP_LR_Tat_004_M",
            "MP_LR_Tat_005_M",
            "MP_LR_Tat_007_M",
            "MP_LR_Tat_009_M",
            "MP_LR_Tat_010_M",
            "MP_LR_Tat_013_M",
            "MP_LR_Tat_014_M",
            "MP_LR_Tat_015_M",
            "MP_LR_Tat_017_M",
            "MP_LR_Tat_020_M",
            "MP_LR_Tat_021_M",
            "MP_LR_Tat_023_M",
            "MP_LR_Tat_026_M",
            "MP_LR_Tat_027_M",
            "MP_LR_Tat_033_M",
        },
        [10] = {
            "MP_LR_Tat_000_M",
            "MP_LR_Tat_003_M",
            "MP_LR_Tat_006_M",
            "MP_LR_Tat_008_M",
            "MP_LR_Tat_011_M",
            "MP_LR_Tat_012_M",
            "MP_LR_Tat_016_M",
            "MP_LR_Tat_018_M",
            "MP_LR_Tat_019_M",
            "MP_LR_Tat_022_M",
            "MP_LR_Tat_028_M",
            "MP_LR_Tat_029_M",
            "MP_LR_Tat_030_M",
            "MP_LR_Tat_031_M",
            "MP_LR_Tat_032_M",
            "MP_LR_Tat_035_M",
        },
    },
}

Pool:Add(TattooMenu)
Pool:ControlDisablingEnabled(false)
Pool:MouseControlsEnabled(false)

function GetModelType()
    if IsOnDutyPolice then
        return "police"
    elseif IsOnDutyParamedic then
        return "paramedic"
    else
        return "default"
    end
end

function ApplyTattoos(Ped)
    local ModelType = GetModelType()

    ClearPedDecorations(Ped)
    for Tattoo, Collection in pairs(Tattoos.Active[ModelType]) do
        SetPedDecoration(Ped, GetHashKey(Collection), GetHashKey(Tattoo))
    end
end

function SwitchClothes(Model)
    ClearAllPedProps(Player.Ped)
    if Model == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(Player.Ped, 1, 0, 0, 2)
        SetPedComponentVariation(Player.Ped, 8, 15, 0, 2)
        SetPedComponentVariation(Player.Ped, 3, 15, 0, 2)
        SetPedComponentVariation(Player.Ped, 11, 91, 0, 2)
        SetPedComponentVariation(Player.Ped, 4, 14, 0, 2)
    else
        SetPedComponentVariation(Player.Ped, 1, 0, 0, 2)
        SetPedComponentVariation(Player.Ped, 8, 34, 0, 2)
        SetPedComponentVariation(Player.Ped, 3, 15, 0, 2)
        SetPedComponentVariation(Player.Ped, 11, 101, 1, 2)
        SetPedComponentVariation(Player.Ped, 4, 16, 0, 2)
    end
end

function SetupTattooMenuItems(Model)
    TattooMenu:Clear()
    if Model == GetHashKey("mp_m_freemode_01") or Model == GetHashKey("mp_f_freemode_01") then
        SwitchClothes(Model)

        local ItemCategoryList = NativeUI.CreateListItem("Collection", Tattoos.Collections, 1, "")
        local ItemTattooSlider = NativeUI.CreateSliderItem("Tattoos", Tattoos.List[1], 1, "Press enter to add/remove tattoos")
        local ItemRemoveTattoos = NativeUI.CreateItem("Remove All", "Remove every single tattoo.")
        ItemCategoryList.OnListChanged = function(ParentMenu, ListItem, Index)
            ItemTattooSlider.Items = Tattoos.List[Index]
            ItemTattooSlider:Index(1)
        end

        ItemTattooSlider.OnSliderSelected = function(ParentMenu, SliderItem, Index)
            local ActiveItem = SliderItem:IndexToItem(Index)
            local ModelType = GetModelType()

            if Tattoos.Active[ModelType][ActiveItem] then
                Tattoos.Active[ModelType][ActiveItem] = nil
                exports.pNotify:SendNotification({text = "Tattoo removed!", type = "error", timeout = 3000, layout = "bottomRight", queue = "left"})
            else
                Tattoos.Active[ModelType][ActiveItem] = ItemCategoryList:IndexToItem(ItemCategoryList:Index()).Value
                exports.pNotify:SendNotification({text = "Tattoo applied!", type = "error", timeout = 3000, layout = "bottomRight", queue = "left"})
            end

            ApplyTattoos(Player.Ped)
        end

        ItemTattooSlider.OnSliderChanged = function(ParentMenu, SliderItem, Index)
            local ActiveItem = SliderItem:IndexToItem(Index)
            local ModelType = GetModelType()

            ApplyTattoos(Player.Ped)

            if not Tattoos.Active[ModelType][ActiveItem] then
                SetPedDecoration(Player.Ped, GetHashKey(ItemCategoryList:IndexToItem(ItemCategoryList:Index()).Value), GetHashKey(ActiveItem))
            end
        end

        ItemRemoveTattoos.Activated = function(ParentMenu, SelectedItem)
            Tattoos.Active[GetModelType()] = {}
            
            ApplyTattoos(Player.Ped)
        end

        TattooMenu:AddItem(ItemCategoryList)
        TattooMenu:AddItem(ItemTattooSlider)
        TattooMenu:AddItem(ItemRemoveTattoos)
    else
        TattooMenu:AddItem(NativeUI.CreateItem("Your model doesn't support Tattoos", "Your model doesn't support Tattoos"))
    end
    Pool:RefreshIndex()
    TattooMenu:Visible(true)
end

TattooMenu.OnMenuClosed = function(Menu)
    local Model = GetEntityModel(Player.Ped)
    if Model == GetHashKey("mp_m_freemode_01") or Model == GetHashKey("mp_f_freemode_01") then
        local ModelType = GetModelType()
        TriggerServerEvent((IsOnDutyPolice and "police:load_clothing" or (IsOnDutyParamedic and "paramedic:load_clothing" or "clothes:spawn")))
        TriggerServerEvent("Tattoos.Save", Tattoos.Active[ModelType], ModelType)
    end
end

Citizen.CreateThread(function()
    for Index = 1, #Tattoos.Locations do
        CreateBlip(Tattoos.Locations[Index].Blip.Name, Tattoos.Locations[Index].Blip.Sprite, Tattoos.Locations[Index].Blip.Colour, Tattoos.Locations[Index].Marker.x, Tattoos.Locations[Index].Marker.y, Tattoos.Locations[Index].Marker.z)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        Pool:ProcessMenus()
        if Player.Ready then
            for Index = 1, #Tattoos.Locations do
                if Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, Tattoos.Locations[Index].Marker.x, Tattoos.Locations[Index].Marker.y, Tattoos.Locations[Index].Marker.z) < 20 then
                    RenderMarker(25, Tattoos.Locations[Index].Marker.x, Tattoos.Locations[Index].Marker.y, Tattoos.Locations[Index].Marker.z, 3.0, 3.0, 3.5, 255, 255, 0, 255)
                    if Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, Tattoos.Locations[Index].Marker.x, Tattoos.Locations[Index].Marker.y, Tattoos.Locations[Index].Marker.z) < 3 then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to open the tattoo parlour!")
                        if IsControlJustPressed(1, 51) then
                            if TattooMenu:Visible() then
                                TattooMenu:Visible(false)
                            else
                                SetupTattooMenuItems(GetEntityModel(Player.Ped))
                            end
                        end
                    elseif Vdist(Player.Coordinates.x, Player.Coordinates.y, Player.Coordinates.z, Tattoos.Locations[Index].Marker.x, Tattoos.Locations[Index].Marker.y, Tattoos.Locations[Index].Marker.z) > 3 then
                        if TattooMenu:Visible() then
                            TattooMenu:Visible(false)
                        end                   
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("Tattoos.Load")
AddEventHandler("Tattoos.Load", function(Tats)
    Tattoos.Active = Tats
end)
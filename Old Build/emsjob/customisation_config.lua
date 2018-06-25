--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
clothing_menu = false

emsskins = {
    's_m_m_paramedic_01',
    's_f_y_scrubs_01',
	's_m_m_doctor_01',
	's_m_y_autopsy_01',
    "mp_m_freemode_01",
    "mp_f_freemode_01",
}

local paramedic_clothing_emplacement = {
    {name="Paramedic Clothing", sprite = 73, colour = 39, x = 269.6764831543, y = -1362.9470214844, z = 24.537792205811},
}

menu_options = {
    {name = "Clothing", f = customise, param = nil},
    {name = "Accessories", f = accessories, param = nil},
    {name = "Face", f = overlays, param = nil},
    {name = "Models", f = listModels, param = emsskins},
}
player_data  = {
    model = "s_m_m_paramedic_01",
    new = "true",
    clothing = {
        drawables = {},
        textures = {
            1,1,1
        },
        palette = {},
    },
    props = {
        drawables = {},
        textures = {},
    },
    overlays = {
        drawables = {255,255,255,255,255,255,255,255,255,255,255,255,255},
        opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0},
        colours = {
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
            {colourType = 0, colour = 0},
        },
    },
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isParamedic then
        	if isInService then
		        local pos = GetEntityCoords(GetPlayerPed(-1), true)
		        for k,v in ipairs(paramedic_clothing_emplacement) do
		            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
		                DrawMarker(25, v.x, v.y, v.z -0.9, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
		                    DisplayHelpText("Press ~INPUT_CONTEXT~ to customise your paramedic.")
		                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
		                        GUI.maxVisOptions = 20; titleTextSize = {0.85, 0.80}; titleRectSize = {0.23, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.23, 0.035}; menuX = 0.745; menuXOption = 0.11; menuXOtherOption = 0.06; menuYModify = 0.1500; menuYOptionDiv = 4.285; menuYOptionAdd = 0.21
		                        clothing_menu = not clothing_menu
		                        OpenClothes()
		                    end
		                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
		                    incircle = false
		                    if clothing_menu then
		                        save()
		                    end
		                    clothing_menu = false
		                end
		            end
		        end
		        if clothing_menu then
		        	menuX = 0.745
		            Menu.DisplayCurMenu()
		        end
		    end
		end
    end
end)

function ClothingBlips()
    for _, item in pairs(paramedic_clothing_emplacement) do
        addBlip(item)
    end
end

function RemoveClothingBlips()
    for _, item in pairs(paramedic_clothing_emplacement) do
        RemoveBlip(item.blip)
    end
end
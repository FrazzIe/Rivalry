--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local armoury = {
    {name = "Armoury", sprite = 175, colour = 39, x=452.28164672852, y=-980.19580078125, z=30.689605712891}, -- Mission row
    {name = "Armoury", sprite = 175, colour = 39, x=-450.52, y=6011.33, z=31.72}, -- Paleto Bay
    {name = "Armoury", sprite = 175, colour = 39, x=1852.49, y=3691.61, z=34.27}, -- Sandy Shores
    {name = "Armoury", sprite = 175, colour = 39, x=-1078.54, y=-857.00, z=5.04}, -- San Andreas Ave
    {name = "Armoury", sprite = 175, colour = 39, x=-566.57, y=-132.83, z=37.96}, -- Rockford Hills
}

guns = {
    {name = "Pistol", model = "WEAPON_PISTOL"},
    {name = "Pistol Mark 2", model = "WEAPON_PISTOL_MK2"},
    {name = "Knife", model = "WEAPON_KNIFE"},
    {name = "Flare", model = "WEAPON_FLARE"},
    {name = "Stun Gun", model = "WEAPON_STUNGUN"},
    {name = "Flashlight", model = "WEAPON_FLASHLIGHT"},
    {name = "Nightstick", model = "WEAPON_NIGHTSTICK"},
    {name = "Pump Shotgun", model = "WEAPON_PUMPSHOTGUN"},
    {name = "Combat Pistol", model = "WEAPON_COMBATPISTOL"},
	{name = "Combat PDW", model = "WEAPON_COMBATPDW"},
    {name = "Fire Extinguisher", model = "WEAPON_FIREEXTINGUISHER"},
    {name = "Trooper Only Revolver", model = "WEAPON_REVOLVER_MK2"},
}

local options = {"Equip", "Remove"}
local currentItemIndex, selectedItemIndex = {}, {}
for i = 1, (#guns+1) do
    currentItemIndex[i] = 1
    selectedItemIndex[i] = 1
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if isInService then
        	local pos = GetEntityCoords(GetPlayerPed(-1), true)
        	for k,v in ipairs(armoury) do
            	if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                	DrawMarker(25, v.x, v.y, v.z-0.9, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
                	if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    	if not armoury_menu then
                        	DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~open the armoury~w~!")
                        else
                        	DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~close the armoury~w~!")
                        end
                    	if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                            if not WarMenu.IsMenuOpened("armoury_menu") then
                                if not WarMenu.DoesMenuExist("armoury_menu") then
                                    WarMenu.CreateMenu("armoury_menu", "Armoury")
                                    WarMenu.SetSpriteTitle("armoury_menu", "shopui_title_gr_gunmod")
                                    WarMenu.SetSubTitle("armoury_menu", "Armoury")
                                    WarMenu.SetMenuX("armoury_menu", 0.6)
                                    WarMenu.SetMenuY("armoury_menu", 0.15)
                                    WarMenu.SetTitleBackgroundColor("armoury_menu", 0, 128, 255, 255)
                                else
                                    WarMenu.OpenMenu("armoury_menu")
                                end
                            else
                                WarMenu.CloseMenu("armoury_menu")
                            end
                    	end
                        if WarMenu.IsMenuOpened("armoury_menu") then
                            if WarMenu.Button("Add Attachments to current weapon") then
                                local hasWeapon, currentWeapon = GetCurrentPedWeapon(PlayerPedId(), 1)
                                if currentWeapon ~= nil then
                                    if IsPedArmed(PlayerPedId(), 7) then
                                        local HashWeapon = Weaponhashes[tostring(currentWeapon)]
                                        if HashWeapon then
                                            if Attachments[HashWeapon] then
                                                for k,v in pairs(Attachments[HashWeapon]) do
                                                    if not tonumber(v.Hash) then
                                                        GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(HashWeapon), GetHashKey(v.Hash))
                                                    else
                                                        GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(HashWeapon), tonumber(v.Hash))
                                                    end
                                                end
                                            end
                                            if string.sub(HashWeapon, string.len(HashWeapon)-2, string.len(HashWeapon)) == "MK2" then
                                                SetPedWeaponTintIndex(PlayerPedId(), GetHashKey(HashWeapon), 10)
                                            else
                                                SetPedWeaponTintIndex(PlayerPedId(), GetHashKey(HashWeapon), 5)
                                            end
                                            local ammotype = GetPedAmmoTypeFromWeapon(PlayerPedId(), GetHashKey(HashWeapon))
                                            SetPedAmmoByType(PlayerPedId(), ammotype, 250)
                                        end
                                    end
                                end
                            end
                            for k,v in pairs(guns) do
                                if WarMenu.ComboBox(v.name, options , currentItemIndex[k], selectedItemIndex[k], function(currentIndex, selectedIndex)
                                    currentItemIndex[k] = currentIndex
                                    selectedItemIndex[k] = selectedIndex
                                end) then
                                    if selectedItemIndex[k] == 1 then
                                        GiveWeaponToPed(PlayerPedId(), GetHashKey(v.model), 250, 0, false)
                                    elseif selectedItemIndex[k] == 2 then
                                        RemoveWeaponFromPed(PlayerPedId(), GetHashKey(v.model))
                                    end
                                end
                            end
                            if WarMenu.ComboBox("Armour", options , currentItemIndex[#currentItemIndex], selectedItemIndex[#selectedItemIndex], function(currentIndex, selectedIndex)
                                currentItemIndex[#currentItemIndex] = currentIndex
                                selectedItemIndex[#selectedItemIndex] = selectedIndex
                            end) then
                                if selectedItemIndex[#selectedItemIndex] == 1 then
                                    SetPedArmour(PlayerPedId(), 100)
                                elseif selectedItemIndex[#selectedItemIndex] == 2 then
                                    SetPedArmour(PlayerPedId(), 0)
                                end
                            end
                            WarMenu.Display()
                        end
                    elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                        if WarMenu.IsMenuOpened("armoury_menu") then
                            WarMenu.CloseMenu("armoury_menu")
                        end
                    end
            	end
        	end
    	end
    end
end)

function ArmouryBlips()
    for _, item in pairs(armoury) do
        addBlip(item)
    end
end

function RemoveArmouryBlips()
    for _, item in pairs(armoury) do
        RemoveBlip(item.blip)
    end
end
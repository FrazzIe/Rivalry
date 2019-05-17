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
    {name = "Armoury", sprite = 175, colour = 39, x=389.47625732422, y=798.86975097656, z=187.67149353027}, -- Park Ranger Station
}

guns = {
    {name = "Pistol", model = "WEAPON_PISTOL"},
    {name = "Knife", model = "WEAPON_KNIFE"},
    {name = "Stun Gun", model = "WEAPON_STUNGUN"},
    {name = "Flashlight", model = "WEAPON_FLASHLIGHT"},
    {name = "Nightstick", model = "WEAPON_NIGHTSTICK"},
    {name = "Combat Pistol", model = "WEAPON_COMBATPISTOL"},
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
            local PlayerPed = PlayerPedId()
        	local PlayerPosition = GetEntityCoords(PlayerPed, false)


        	for k,v in ipairs(armoury) do
                local Distance = GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, v.x, v.y, v.z, true)
            	if Distance < 15.0 then
                	DrawMarker(25, v.x, v.y, v.z-0.9, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
                	if Distance < 1.0 then
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
                                local hasWeapon, currentWeapon = GetCurrentPedWeapon(PlayerPed, 1)
                                if currentWeapon ~= nil then
                                    if IsPedArmed(PlayerPed, 7) then
                                        local WeaponStr = Weaponhashes[tostring(currentWeapon)]
                                        if WeaponStr then
                                            if Attachments[WeaponStr] then
                                                for k,v in pairs(Attachments[WeaponStr]) do
                                                    if not tonumber(v.Hash) then
                                                        GiveWeaponComponentToPed(PlayerPed, currentWeapon, GetHashKey(v.Hash))
                                                    else
                                                        GiveWeaponComponentToPed(PlayerPed, currentWeapon, tonumber(v.Hash))
                                                    end
                                                end
                                            end
                                            if string.sub(WeaponStr, string.len(WeaponStr)-2, string.len(WeaponStr)) == "MK2" then
                                                SetPedWeaponTintIndex(PlayerPed, currentWeapon, 24)
                                            else
                                                SetPedWeaponTintIndex(PlayerPed, currentWeapon, 7)
                                            end
                                            local ammotype = GetPedAmmoTypeFromWeapon(PlayerPed, currentWeapon)
                                            SetPedAmmoByType(PlayerPed, ammotype, 250)
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
                                        GiveWeaponToPed(PlayerPed, GetHashKey(v.model), 250, 0, false)
                                    elseif selectedItemIndex[k] == 2 then
                                        RemoveWeaponFromPed(PlayerPed, GetHashKey(v.model))
                                    end
                                end
                            end
                            if WarMenu.ComboBox("Armour", options , currentItemIndex[#currentItemIndex], selectedItemIndex[#selectedItemIndex], function(currentIndex, selectedIndex)
                                currentItemIndex[#currentItemIndex] = currentIndex
                                selectedItemIndex[#selectedItemIndex] = selectedIndex
                            end) then
                                if selectedItemIndex[#selectedItemIndex] == 1 then
                                    SetPedArmour(PlayerPed, 100)
                                elseif selectedItemIndex[#selectedItemIndex] == 2 then
                                    SetPedArmour(PlayerPed, 0)
                                end
                            end
                            WarMenu.Display()
                        end
                    elseif Distance > 1.0 then
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

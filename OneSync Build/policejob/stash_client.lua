local stashes = {
    vector3(457.73382568359, -988.47528076172, 30.689607620239), -- MRPD
    vector3(1856.810546875, 3694.0515136719, 34.225002288818), -- SS
    vector3(-439.88165283203, 5991.8466796875, 31.716167449951), -- PB
}
local stashMenu = "pd_stash_"
local stashItems = {}
local stashLimit = 18
local spinnerLabel = { "FRZL_LOAD_STASH", "Fetching stash contents..." }
local playerWeapons = {}

RegisterNetEvent("policeStash:received")

Citizen.CreateThread(function()
    AddTextEntry(spinnerLabel[1], spinnerLabel[2])

    local recievedItems = false

    WarMenu.CreateMenu(stashMenu, "Weapon Locker")
    WarMenu.SetSubTitle(stashMenu, "OPTIONS")
    WarMenu.CreateSubMenu(stashMenu .. "deposit", stashMenu, "WEAPONS")

    while true do
        Citizen.Wait(0)

        if isInService then
            local playerPed = PlayerPedId()
            local playerPos = GetEntityCoords(playerPed)

            for i = 1, #stashes do
                local stash = stashes[i]
                local stashDist = #(playerPos - stash)

                if stashDist < 5 then
                    DrawMarker(25, stash.x, stash.y, stash.z - 0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 255, 255, 0, 50, 0, 0, 2, 0, 0, 0, 0) -- Draw a marker

                    if stashDist < 1.5 then
                        if IsControlJustPressed(1, 51) then
                            if WarMenu.IsMenuOpened(stashMenu) then
                                WarMenu.CloseMenu()
                            else
                                recievedItems = false

                                local eventHandler = AddEventHandler("policeStash:received", function(items) -- Add temporary handler
                                    stashItems = items
                                    recievedItems = true
                                end)

                                TriggerServerEvent("policeStash:fetch") -- Fetch stash items from db
                                
                                BeginTextCommandBusyspinnerOn(spinnerLabel[1]) -- Show loading prompt
                                EndTextCommandBusyspinnerOn(4)

                                repeat -- Wait for items
                                    Citizen.Wait(0)
                                until recievedItems

                                BusyspinnerOff() -- Remove loading prompt

                                RemoveEventHandler(eventHandler) -- Remove temporary handler

                                WarMenu.OpenMenu(stashMenu) -- Open stash
                            end
                        end
                    else -- If not close enough, close menu
                        if WarMenu.IsMenuOpened(stashMenu) then
                            WarMenu.CloseMenu()
                        end
                    end
                end
            end

            if WarMenu.IsMenuOpened(stashMenu) then -- Display main menu
                if #stashItems < stashLimit then -- If stash isn't full then
                    WarMenu.MenuButton("Store a weapon", stashMenu .. "deposit")
                end

                for i = 1, #stashItems do
                    local weapon = stashItems[i]

                    if not weapon.locked then
                        if WarMenu.Button(Weapons_names[weapon.model] .. " [" .. weapon.ammo .. "]", "Take") then
                            TriggerServerEvent("policeStash:remove", weapon, i)
                            weapon.locked = true
                            local newIdx = WarMenu.GetMenuProperty(stashMenu, "currentOption") - 1
                            WarMenu.SetMenuCurrentOption(stashMenu, (newIdx > 0) and newIdx or 1)
                        end
                    end
                end

                WarMenu.Display()
            end

            if WarMenu.IsMenuOpened(stashMenu .. "deposit") then -- Display deposit menu
                if #stashItems < stashLimit then
                    for k,v in pairs(playerWeapons) do
                        local weapon = v

                        if not weapon.locked then
                            if WarMenu.Button(Weapons_names[weapon.model] .. " [" .. weapon.ammo .. "]", "Store") then
                                TriggerServerEvent("policeStash:add", weapon)
                                weapon.locked = true
                                local newIdx = WarMenu.GetMenuProperty(stashMenu .. "deposit", "currentOption") - 1
                                WarMenu.SetMenuCurrentOption(stashMenu .. "deposit", (newIdx > 0) and newIdx or 1)
                            end
                        end
                    end
                else
                    WarMenu.Button("Stash is full!")
                end

                WarMenu.Display()
            end
        end
    end
end)

RegisterNetEvent("weapon:set")
AddEventHandler("weapon:set", function(weapons)
    playerWeapons = weapons
end)

RegisterNetEvent("policeStash:remove")
AddEventHandler("policeStash:remove", function(idx)
    if stashItems[idx] then
        if stashItems[idx].locked then
            stashItems[idx].locked = false
        end
    end
end)

RegisterNetEvent("policeStash:update")
AddEventHandler("policeStash:update", function(stash)
    stashItems = stash
end)
---====================================================================================
-- #Author: Jonathan D @ Gannon
-- 
-- Développée pour la communauté n3mtv
--      https://www.twitch.tv/n3mtv
--      https://twitter.com/n3m_tv
--      https://www.facebook.com/lan3mtv
--====================================================================================

local Menu = {}
local itemMenuGeneralPolice = {}
local itemMenuChoixPoliceService = {}
local itemMenuChoixPoliceVehicle = {}

local UrgencePoliceMenu = {['Title'] = 'Current missions',  ['SubMenu'] = {
    ['Title'] = 'Current missions', ['Items'] = {
        {['Title'] = 'Return', ['ReturnBtn'] = true },
        {['Title'] = 'To close'},
}}}

function updateMenuPolice(newUrgenceMenu)
    itemMenuGeneralPolice.Items[1] = newUrgenceMenu
end

function openMenuPoliceGeneral() 
    Menu.item = itemMenuGeneralPolice
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixPoliceVehicleCar()
    Menu.item = itemMenuChoixPoliceVehicleCar
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixPoliceVehicleHeli()
    Menu.item = itemMenuChoixPoliceVehicleHeli
    Menu.isOpen = true
    Menu.initMenu()
end

function MenuChoixPoliceService()
    Menu.item = itemMenuChoixPoliceService
    Menu.isOpen = true
    Menu.initMenu()
end


itemMenuGeneralPolice = {
    ['Title'] = 'Police',
    ['Items'] = {
        UrgencePoliceMenu,
        {['Title'] = 'Citizens',  ['SubMenu'] = {
            ['Title'] = "Citizen Actions",
            ['Items'] = {
                {['Title'] = 'Search', ['Function'] = POLICE_Check},
                {['Title'] = 'Handcuff', ['Function'] = POLICE_Cuffed},
                {['Title'] = 'GSR Test', ['Function'] = police_GSR_Test},
                {['Title'] = 'Breathalyze', ['Function'] = police_Breathalyzer_Test},
                {['Title'] = 'Weapon License Check', ['Function'] = getlicense},    
                {['Title'] = 'Escort', ['Function'] = DragPlayer},
                {['Title'] = 'Jail', ['Function'] = customJailTime},
                {['Title'] = 'Place in Vehicle', ['Function'] = POLICE_PutInVehicle},
                {['Title'] = 'Exit the vehicle', ['Function'] = POLICE_UnseatVehicle},
            }
        }},
        {['Title'] = 'Vehicles',  ['SubMenu'] = {
            ['Title'] = "Vehicle Actions",
            ['Items'] = {
                {['Title'] = 'Check DMV', ['Function'] = DMVcheck},
                {['Title'] = 'Check the plate', ['Function'] = POLICE_CheckPlate},
                {['Title'] = 'Place a Radar', ['Function'] = POLICE_radar},
                {['Title'] = 'Lockpick', ['Function'] = POLICE_Crocheter},
                {['Title'] = 'Spike Strip', ['Function'] = spikes},
                {['Title'] = 'Deploy Cones', ['Function'] = cones},
                {['Title'] = 'Delete Vehicle', ['Function'] = POLICE_deleteVehicle},
            }
        }},
        {['Title'] = 'Fines',  ['SubMenu'] = {
            ['Title'] = 'fines', 
            ['Items'] = {
                {['Title'] = 'Traffic Laws',  ['SubMenu'] = { 
                    ['Title'] = 'Fines - Highway Traffic Act', 
                    ['Items'] = {
                        {['Title'] = 'Failure to comply with the highway code', ['Function'] = POLICE_FINE_DATA, tarif = 100},
                        {['Title'] = 'Small Speeding'   , ['Function'] = POLICE_FINE_DATA, tarif = 100},
                        {['Title'] = 'Great Speeding'   , ['Function'] = POLICE_FINE_DATA, tarif = 400},
                        {['Title'] = 'Hazardous Conduct', ['Function'] = POLICE_FINE_DATA, tarif = 150},
                        {['Title'] = 'Vehicle too damaged', ['Function'] = POLICE_FINE_DATA, tarif = 250},
                        {['Title'] = 'Drug / Drug Conduct', ['Function'] = POLICE_FINE_DATA, tarif = 1500},
                        {['Title'] = 'Hit and run', ['Function'] = POLICE_FINE_DATA, tarif = 5000},
                    }
                }},
                {['Title'] = 'Criminal and Penal Offenses',  ['SubMenu'] = { 
                    ['Title'] = 'Fines - Highway Traffic Act', 
                    ['Items'] = {
                        {['Title'] = 'Unlawful activities', ['Function'] = POLICE_FINE_DATA, tarif = 5000},
                        {['Title'] = 'Violence', ['Function'] = POLICE_FINE_DATA, tarif = 5000},
                        {['Title'] = 'Vehicle theft', ['Function'] = POLICE_FINE_DATA, tarif = 10000},
                        {['Title'] = 'Robbery', ['Function'] = POLICE_FINE_DATA, tarif = 15000},
                        {['Title'] = 'Damage', ['Function'] = POLICE_FINE_DATA, tarif = 5000},
                        {['Title'] = 'Outrage Against LSPD', ['Function'] = POLICE_FINE_DATA, tarif = 5000},
                        {['Title'] = 'Violence against LSPD', ['Function'] = POLICE_FINE_DATA, tarif = 15000},
                        {['Title'] = 'Crimes', ['Function'] = POLICE_FINE_DATA, tarif = 70000},
                    }
                }},
                {['Title'] = 'Charges',  ['SubMenu'] = {
                    ['Title'] = 'Charges', 
                    ['Items'] = {
                        {['Title'] = 'Apply Charges', ['Function'] = police_Apply_Charges},
                        {['Title'] = 'Review Charges', ['Function'] = police_Review_Charges},
                        {['Title'] = 'Clear Charges', ['Function'] = police_Clear_Charges},
                        {['Title'] = 'Traffic Laws',  ['SubMenu'] = { 
                            ['Title'] = 'Fines - Highway Traffic Act', 
                            ['Items'] = {
                                {['Title'] = 'Failure to comply with the highway code', ['Function'] = add_Charge, cost = 100, time = 1},
                                {['Title'] = 'Small Speeding'   , ['Function'] = add_Charge, cost = 100, time = 7},
                                {['Title'] = 'Great Speeding'   , ['Function'] = add_Charge, cost = 400, time = 4},
                                {['Title'] = 'Hazardous Conduct', ['Function'] = add_Charge, cost = 150, time = 6},
                                {['Title'] = 'Vehicle too damaged', ['Function'] = add_Charge, cost = 250, time = 5},
                                {['Title'] = 'Drug / Drug Conduct', ['Function'] = add_Charge, cost = 1500, time = 12},
                                {['Title'] = 'Hit and run', ['Function'] = add_Charge, cost = 5000, time = 15},
                            }
                        }}
                    }
                }},
                {['Title'] = 'Other', ['Function'] = POLICE_FINE_CUSTOM }, -- policier/chasseur
                }
        
            }
        }   
    }
}

itemMenuChoixPoliceVehicleCar = {
    ['Title'] = 'Police - Choice of vehicle',
    ['Items'] = {
        {['Title'] = 'Recruit',  ['SubMenu'] = { 
            ['Title'] = 'Jurisdiction', 
                    ['Items'] = {
                        {['Title'] = 'LAPD', ['SubMenu'] = {
                            ['Items'] = {
                                {['Title'] = 'Police Transport', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'policet'},
                                {['Title'] = 'CVPI', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'cop1'},
                            }
                        }
                    }                       
                }
        }},
        {['Title'] = 'Police/Sheriff',  ['SubMenu'] = { 
            ['Title'] = 'Jurisdiction', 
                    ['Items'] = {
                        {['Title'] = 'LAPD', ['SubMenu'] = {
                            ['Items'] = {
                                {['Title'] = 'Police Transport', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'policet'},
                                {['Title'] = 'CVPI', ['Function'] = POLICE_pushBar2,  type = 'Car', model = 'cop1'},
                                {['Title'] = 'Taurus', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'cop2'},
                            }
                        }},
                        {['Title'] = 'BCSO', ['SubMenu'] = {
                            ['Items'] = {
                                {['Title'] = 'Sheriff Charger', ['Function'] = POLICE_BCSO,  type = 'Car', model = 'sheriff2'},
                                {['Title'] = 'Sheriff Tahoe', ['Function'] = POLICE_BCSO,  type = 'Car', model = 'sheriff'},
                                {['Title'] = 'Sheriff CVPI', ['Function'] = POLICE_BCSO,  type = 'Car', model = 'sheriff3'},
                            }
                        }
                    }                       
                }
        }},
        {['Title'] = 'CHP',  ['SubMenu'] = { 
            ['Title'] = 'Jurisdiction', 
                    ['Items'] = {
                        {['Title'] = 'LAPD', ['SubMenu'] = {
                            ['Items'] = {
                                {['Title'] = 'Police Transport', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'policet'},
                                {['Title'] = 'CVPI', ['Function'] = POLICE_pushBar,  type = 'Car', model = 'cop1'},
                                {['Title'] = 'Taurus', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'cop2'},
                                {['Title'] = 'Charger', ['Function'] = POLICE_pushBar3,  type = 'Car', model = 'cop4'},
                            }
                        }},
                        {['Title'] = 'BCSO', ['SubMenu'] = {
                            ['Items'] = {
                                {['Title'] = 'Sheriff Charger', ['Function'] = POLICE_BCSO,  type = 'Car', model = 'sheriff'},
                                {['Title'] = 'Sheriff Tahoe', ['Function'] = POLICE_BCSO,  type = 'Car', model = 'sheriff2'},
                                {['Title'] = 'Sheriff CVPI', ['Function'] = POLICE_BCSO,  type = 'Car', model = 'sheriff3'},
                            }
                        }},
                        {['Title'] = 'CHP', ['SubMenu'] = {
                            ['Items'] = {
                                {['Title'] = 'CVPI', ['Function'] = POLICE_pushBar3,  type = 'Car', model = 'cop1'},
                                {['Title'] = 'Taurus', ['Function'] = POLICE_pushBar3,  type = 'Car', model = 'cop2'},
                                {['Title'] = 'Impala', ['Function'] = POLICE_pushBar3,  type = 'Car', model = 'cop3'},
                                {['Title'] = '16 Charger', ['Function'] = POLICE_pushBar3,  type = 'Car', model = 'cop4'},
                                {['Title'] = '13 FPIU', ['Function'] = POLICE_pushBar3,  type = 'Car', model = 'cop5'},
                                {['Title'] = '16 FPIU', ['Function'] = POLICE_pushBar3,  type = 'Car', model = 'cop6'},
                                {['Title'] = 'K9 Unit', ['Function'] = POLICE_pushBar3,  type = 'Car', model = 'cop7'},
                            }
                        }},
                        {['Title'] = 'UnderCover', ['SubMenu'] = {
                            ['Items'] = {
                                {['Title'] = 'Charger', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'fbi3'},
                                {['Title'] = 'Tahoe', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'fbi4'},
                            }
                        }
                    }                       
                }
        }},
        {['Title'] = 'Filature', ['Function'] = POLICE_SpanwVehicleCar,  type = 'Car', model = 'police4'},
    }
}

itemMenuChoixPoliceVehicleHeli = {
    ['Title'] = 'Police - Choice of vehicle',
    ['Items'] = {
        {['Title'] = 'Helicopter', ['Function'] = POLICE_invokeVehicle, type = 'Chopper', model = 'polmav'},
    }
}

itemMenuChoixPoliceService = {
    ['Title'] = 'Police - cloakroom',
    ['Items'] = {
        {['Title'] = 'LAPD', ['Function'] = takeService},
        {['Title'] = 'Sheriff Loadout', ['Function'] = takeServiceInvestigation},
        {['Title'] = 'Highway Patrol', ['Function'] = takeServiceHighway},
        {['Title'] = 'Put on Bulletproof vest', ['Function'] = equipeVest, type = 'Bulletproof jacket'},
        {['Title'] = 'Take off Bulletproof vest', ['Function'] = equipeVest, type = 'Take offbulletproof jacket'},
        {['Title'] = "Put on high Visibly vest", ['Function'] = equipeVest, type = 'High-visibility clothing'},
        {['Title'] = "Take off high Visibitly vest", ['Function'] = equipeVest, type = 'Take off High-visibility clothing'},
        {['Title'] = 'Leave the service', ['Function'] = finishService},
    }
}

--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 52, 73, 94, 196 }
Menu.backgroundColorActive = {243, 156, 18, 255}
Menu.tileTextColor = {243, 156, 18, 255}
Menu.tileBackgroundColor = { 255,255,255, 255 }
Menu.textColor = { 255,255,255,255 }
Menu.textColorActive = { 255,255,255, 255 }

Menu.keyOpenMenu = 170 -- N+
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe 
Menu.keyRight =	175 -- PhoneRigth || Not use next release Maybe 
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel
Menu.IgnoreNextKey = false
Menu.posX = 0.05
Menu.posY = 0.05

Menu.ItemWidth = 0.20
Menu.ItemHeight = 0.03

Menu.isOpen = false   -- /!\ Ne pas toucher
Menu.currentPos = {1} -- /!\ Ne pas toucher

--===============================================================
-- Function
--======================================




--====================================================================================
--  Menu System
--====================================================================================

function Menu.drawRect(posX, posY, width, heigh, color)
    DrawRect(posX + width / 2, posY + heigh / 2, width, heigh, color[1], color[2], color[3], color[4])
end

function Menu.initText(textColor, font, scale)
    font = font or 0
    scale = scale or 0.35
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextEntry("STRING")
end

function Menu.draw() 
    -- Draw Rect
    local pos = 0
    local menu = Menu.getCurrentMenu()
    local selectValue = Menu.currentPos[#Menu.currentPos]
    local nbItem = #menu.Items
    -- draw background title & title
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.tileBackgroundColor)    
    Menu.initText(Menu.tileTextColor, 4, 0.7)
    AddTextComponentString(menu.Title)
    DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY)

    -- draw bakcground items
    Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * 2, Menu.ItemWidth, Menu.ItemHeight + (nbItem-1)*Menu.ItemHeight, Menu.backgroundColor)
    -- draw all items
    for pos, value in pairs(menu.Items) do
        if pos == selectValue then
            Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * (1+pos), Menu.ItemWidth, Menu.ItemHeight, Menu.backgroundColorActive)
            Menu.initText(Menu.textColorActive)
        else
            Menu.initText(value.TextColor or Menu.textColor)
        end
        AddTextComponentString(value.Title)
        DrawText(Menu.posX + Menu.ItemWidth/2, Menu.posY + Menu.ItemHeight * (pos+1))
    end
    
end

function Menu.getCurrentMenu()
    local currentMenu = Menu.item
    for i=1, #Menu.currentPos - 1 do
        local val = Menu.currentPos[i]
        currentMenu = currentMenu.Items[val].SubMenu
    end
    return currentMenu
end

function Menu.initMenu()
    Menu.currentPos = {1}
    Menu.IgnoreNextKey = true 
end

function Menu.keyControl()
    if Menu.IgnoreNextKey == true then
        Menu.IgnoreNextKey = false 
        return
    end
    if IsControlJustPressed(1, Menu.keyDown) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = (Menu.currentPos[slcp] % size) + 1

    elseif IsControlJustPressed(1, Menu.keyUp) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = ((Menu.currentPos[slcp] - 2 + size) % size) + 1

    elseif IsControlJustPressed(1, Menu.KeyCancel) then 
        table.remove(Menu.currentPos)
        if #Menu.currentPos == 0 then
            Menu.isOpen = false 
        end

    elseif IsControlJustPressed(1, Menu.keySelect)  then
        local cSelect = Menu.currentPos[#Menu.currentPos]
        local cMenu = Menu.getCurrentMenu()
        if cMenu.Items[cSelect].SubMenu ~= nil then
            Menu.currentPos[#Menu.currentPos + 1] = 1
        else
            if cMenu.Items[cSelect].ReturnBtn == true then
                table.remove(Menu.currentPos)
                if #Menu.currentPos == 0 then
                    Menu.isOpen = false 
                end
            else
                if cMenu.Items[cSelect].Function ~= nil then
                    cMenu.Items[cSelect].Function(cMenu.Items[cSelect])
                end
                if cMenu.Items[cSelect].Event ~= nil then
                    TriggerEvent(cMenu.Items[cSelect].Event, cMenu.Items[cSelect])
                end
                if cMenu.Items[cSelect].Close == nil or cMenu.Items[cSelect].Close == true then
                    Menu.isOpen = false
                end
            end
        end
    end

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        if IsControlJustPressed(1, Menu.keyOpenMenu) then
            Menu.isOpen = false
        end
        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
        end
	end
end)


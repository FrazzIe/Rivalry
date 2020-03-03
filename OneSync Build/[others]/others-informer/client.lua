local informer_menu = false
local informerbool = false

local options = {
	-- {text="Blackmarket Weapons",price=10000},
	{text="Harvest Cannabis",price=3000},
	{text="Buy Dirty Cocaine",price=5000},
	{text="Clean Dirty Cocaine",price=5000},
	{text="Rest House",price=3000},
	{text="Chop Shops",price=2000},
	{text="Restraints Remover", price=1000},
}

function InformerMenu()
    Menu.SetupMenu("main_menu","Drug Informer")
    Menu.Switch(nil,"main_menu")
    for i,v in pairs(options) do
	    Menu.addOption("main_menu", function()
			if(Menu.CarBool(tostring(v.text), informerbool,"~g~$~w~"..v.price,"~g~$~w~"..v.price,function(cb)   informerbool = cb end))then
				GetInformation(i)
			end
		end)
	end
end

function GetInformation(id)
	if id == 1 then
		TriggerServerEvent("informer:getguns")
	elseif id == 2 then
		TriggerServerEvent("informer:getweed")
	elseif id == 3 then
		TriggerServerEvent("informer:dirtycoke")
	elseif id == 4 then
		TriggerServerEvent("informer:cleancoke")
	elseif id == 5 then
		TriggerServerEvent("informer:resthouse")
	elseif id == 6 then
		TriggerServerEvent("informer:chopshop")
	elseif id == 7 then
		TriggerServerEvent("informer:uncuff")
	end
end

local informer = {
	{ ['x'] = 57.083034515381, ['y'] = 3691.4270019531, ['z'] = 39.921283721924 },
}

Citizen.CreateThread(function()
	for k,v in ipairs(informer)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 304)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Informer")
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(informer) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 86, 115, 154, 165, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
					DisplayHelpText("Press ~INPUT_VEH_EXIT~ to ~g~Talk to the informer.")
					if IsControlJustPressed(1, 23) then
                        GUI.maxVisOptions = 20
                        titleTextSize = {0.85, 0.65} ------------ {p1, Size}                                      --
                        titleRectSize = {0.16, 0.085} ----------- {Width, Height}                                 --
                        optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      --
                        optionRectSize = {0.16, 0.035} ---------- {Width, Height}    
                        menuX = 0.75 ----------------------------- X position of the menu                          --
                        menuXOption = 0.075 --------------------- X postiion of Menu.Option text                  --
                        menuXOtherOption = 0.027 ---------------- X position of Bools, Arrays etc text            --
                        menuYModify = 0.3000 -------------------- Default: 0.1174   ------ Top bar                --
                        menuYOptionDiv = 8.56 ------------------ Default: 3.56   ------ Distance between buttons --
                        menuYOptionAdd = 0.36 ------------------ Default: 0.142  ------ Move buttons up and down --
						informer_menu = true
						InformerMenu()
				    end
				elseif(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) > 1.0)then
					informer_menu = false
                end
            end
	        if informer_menu then
	            Menu.DisplayCurMenu()
	        end
		end
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
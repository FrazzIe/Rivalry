--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local default_speed = 115
local default_speed_emergency = 180
local speedlocked = false
local vehicle_speeds = {}
local speed_config = {
    ["c7r"] = 250,
    ["rmodbmwi8"] = 250,
    ["rmodmustang"] = 250,
    ["blista"] = 105,
    ["brioso"] = 105,
    ["dilettante"] = 105,
    ["issi2"] = 105,
    ["panto"] = 105,
    ["prairie"] = 105,
    ["rhapsody"] = 110,
    ["cogcabrio"] = 120,
    ["exemplar"] = 120,
    ["f620"] = 120,
    ["felon"] = 120,
    ["felon2"] = 120,
    ["jackal"] = 120,
    ["oracle"] = 125,
    ["oracle2"] = 125,
    ["sentinel"] = 125,
    ["sentinel2"] = 125,
    ["windsor"] = 110,
    ["windsor2"] = 110,
    ["zion"] = 115,
    ["zion2"] = 115,
    ["ninef"] = 160,
    ["ninef2"] = 165,
    ["alpha"] = 125,
    ["banshee"] = 155,
    ["bestiagts"] = 145,
    ["buffalo"] = 130,
    ["buffalo2"] = 135,
    ["carbonizzare"] = 125,
    ["comet2"] = 135,
    ["comet3"] = 135,
    ["coquette"] = 145,
    ["tampa2"] = 140,
    ["elegy2"] = 120,
    ["elegy"] = 120,
    ["feltzer2"] = 130,
    ["furoregt"] = 135,
    ["fusilade"] = 125,
    ["futo"] = 105,
    ["blista3"] = 105,
    ["jester"] = 150,
    ["jester2"] = 155,
    ["khamelion"] = 120,
    ["kuruma"] = 135,
    ["kuruma2"] = 135,
    ["lynx"] = 130,
    ["massacro"] = 145,
    ["massacro2"] = 155,
    ["omnis"] = 125,
    ["penumbra"] = 120,
    ["rapidgt"] = 135,
    ["rapidgt2"] = 150,
    ["raptor"] = 145,
    ["ruston"] = 160,
    ["schafter2"] = 120,
    ["schafter3"] = 135,
    ["seven70"] = 145,
    ["specter"] = 150,
    ["specter2"] = 150,
    ["buffalo3"] = 135,
    ["sultan"] = 120,
    ["surano"] = 120,
    ["tropos"] = 134,
    ["verlierer2"] = 145,
    ["ardent"] = 150,
    ["casco"] = 135,
    ["cheetah2"] = 130,
    ["coquette2"] = 140,
    ["btype2"] = 130,
    ["infernus2"] = 185,
    ["jb700"] = 140,
    ["mamba"] = 130,
    ["manana"] = 130,
    ["monroe"] = 130,
    ["peyote"] = 130,
    ["pigalle"] = 130,
    ["btype"] = 130,
    ["btype3"] = 130,
    ["stinger"] = 140,
    ["stingergt"] = 140,
    ["feltzer3"] = 130,
    ["torero"] = 140,
    ["tornado"] = 100,
    ["tornado3"] = 100,
    ["tornado4"] = 120,
    ["tornado5"] = 120,
    ["tornado6"] = 120,
    ["turismo2"] = 160,
    ["ztype"] = 130,
    ["pfister811"] = 190,
    ["adder"] = 190,
    ["banshee2"] = 160,
    ["bullet"] = 160,
    ["cheetah"] = 160,
    ["entityxf"] = 160,
    ["sheava"] = 160,
    ["fmj"] = 160,
    ["gp1"] = 160,
    ["infernus"] = 170,
    ["italigtb"] = 190,
    ["italigtb2"] = 190,
    ["nero"] = 160,
    ["nero2"] = 160,
    ["osiris"] = 150,
    ["penetrator"] = 150,
    ["le7b"] = 160,
    ["reaper"] = 160,
    ["sultanrs"] = 160,
    ["t20"] = 180,
    ["tempesta"] = 160,
    ["turismor"] = 190,
    ["tyrus"] = 190,
    ["vacca"] = 160,
    ["vagner"] = 160,
    ["Voltic"] = 160,
    ["xa21"] = 190,
    ["prototipo"] = 180,
    ["zentorno"] = 190,
    ["blade"] = 130,
    ["buccaneer"] = 130,
    ["buccaneer2"] = 130,
    ["stallion2"] = 120,
    ["chino"] = 130,
    ["chino2"] = 130,
    ["coquette3"] = 130,
    ["dominator"] = 130,
    ["dukes"] = 130,
    ["dukes2"] = 130,
    ["gauntlet"] = 130,
    ["hotknife"] = 120,
    ["faction"] = 110,
    ["faction2"] = 110,
    ["faction3"] = 110,
    ["slamvan2"] = 110,
    ["lurcher"] = 120,
    ["moonbeam"] = 120,
    ["moonbeam2"] = 120,
    ["nightshade"] = 120,
    ["phoenix"] = 130,
    ["picador"] = 120,
    ["dominator2"] = 120,
    ["ratloader"] = 120,
    ["ratloader2"] = 110,
    ["gauntlet2"] = 110,
    ["ruiner"] = 140,
    ["ruiner2"] = 140,
    ["sabregt"] = 110,
    ["sabregt2"] = 110,
    ["slamvan"] = 110,
    ["slamvan3"] = 110,
    ["stallion"] = 110,
    ["tampa"] = 120,
    ["virgo"] = 140,
    ["virgo2"] = 140,
    ["virgo3"] = 130,
    ["vigero"] = 140,
    ["voodoo2"] = 140,
    ["voodoo"] = 130,
    ["bifta"] = 130,
    ["blazer"] = 130,
    ["blazer2"] = 130,
    ["blazer3"] = 130,
    ["bodhi2"] = 110,
    ["brawler"] = 110,
    ["trophytruck2"] = 120,
    ["dubsta3"] = 120,
    ["dune"] = 60,
    ["dloader"] = 120,
    ["bfinjection"] = 110,
    ["kalahari"] = 110,
    ["monster"] = 120,
    ["marshall"] = 110,
    ["mesa3"] = 110,
    ["nightshark"] = 110,
    ["rancherxl"] = 110,
    ["rebel2"] = 80,
    ["rebel"] = 80,
    ["sandking2"] = 110,
    ["sandking"] = 110,
    ["blazer4"] = 60,
    ["trophytruck"] = 110,
    ["baller"] = 140,
    ["baller2"] = 140,
    ["baller3"] = 140,
    ["baller4"] = 140,
    ["bjxl"] = 130,
    ["cavalcade"] = 130,
    ["cavalcade2"] = 130,
    ["contender"] = 130,
    ["dubsta2"] = 130,
    ["fq2"] = 120,
    ["granger"] = 120,
    ["gresley"] = 130,
    ["habanero"] = 130,
    ["huntley"] = 120,
    ["landstalker"] = 120,
    ["mesa"] = 110,
    ["patriot"] = 110,
    ["radi"] = 110,
    ["rocoto"] = 110,
    ["seminole"] = 120,
    ["serrano"] = 120,
    ["xls"] = 140,
    ["bison"] = 110,
    ["bobcatxl"] = 110,
    ["burrito3"] = 110,
    ["camper"] = 110,
    ["gburrito2"] = 110,
    ["journey"] = 110,
    ["minivan"] = 110,
    ["minivan2"] = 110,
    ["paradise"] = 110,
    ["rumpo"] = 130,
    ["rumpo3"] = 130,
    ["surfer"] = 130,
    ["surfer2"] = 120,
    ["youga"] = 110,
    ["youga2"] = 110,
    ["asea"] = 120,
    ["asterope"] = 135,
    ["cognoscenti"] = 130,
    ["cog55"] = 130,
    ["emperor"] = 130,
    ["emperor2"] = 130,
    ["fugitive"] = 130,
    ["glendale"] = 130,
    ["ingot"] = 130,
    ["intruder"] = 120,
    ["premier"] = 125,
    ["primo"] = 120,
    ["primo2"] = 120,
    ["regina"] = 120,
    ["romero"] = 120,
    ["schafter2"] = 110,
    ["stanier"] = 120,
    ["stratum"] = 120,
    ["stretch"] = 120,
    ["superd"] = 130,
    ["surge"] = 120,
    ["tailgater"] = 110,
    ["warrener"] = 120,
    ["washington"] = 120,
    ["akuma"] = 130,
    ["avarus"] = 130,
    ["bagger"] = 80,
    ["bati"] = 130,
    ["bati2"] = 130,
    ["bf400"] = 130,
    ["carbonrs"] = 130,
    ["chimera"] = 160,
    ["cliffhanger"] = 130,
    ["daemon"] = 130,
    ["daemon2"] = 130,
    ["defiler"] = 160,
    ["diablous"] = 160,
    ["diablous2"] = 160,
    ["double"] = 120,
    ["enduro"] = 120,
    ["esskey"] = 120,
    ["faggio2"] = 35,
    ["faggio"] = 45,
    ["faggio3"] = 35,
    ["fcr"] = 120,
    ["fcr2"] = 120,
    ["gargoyle"] = 120,
    ["hakuchou"] = 150,
    ["hakuchou2"] = 150,
    ["hexer"] = 140,
    ["innovation"] = 130,
    ["lectro"] = 140,
    ["manchez"] = 110,
    ["nemesis"] = 150,
    ["nightblade"] = 110,
    ["pcj"] = 110,
    ["ratbike"] = 80,
    ["ruffian"] = 80,
    ["sanchez"] = 60,
    ["Sanctus"] = 120,
    ["shotaro"] = 140,
    ["sovereign"] = 120,
    ["thrust"] = 120,
    ["vader"] = 90,
    ["vindicator"] = 160,
    ["vortex"] = 150,
    ["wolfsbane"] = 110,
    ["zombiea"] = 110,
    ["zombieb"] = 110,
    ["sheriff3"] = 130,
    ["sheriff"] = 140,
    ["policeb"] = 130,
}

--[[
RegisterNetEvent("core:loaded")
AddEventHandler("core:loaded", function(user, power, group)
    for k,v in pairs(speed_config) do
        vehicle_speeds[tostring(GetHashKey(k))] = tonumber(v)
    end
end)

AddEventHandler("interaction:vehicle_speedlock", function()
	speedlocked = not speedlocked
	if speedlocked then
		local speed = tonumber(KeyboardInput("Enter speed:", 45, 3))
		if speed then
			Citizen.CreateThread(function()
				while speedlocked do
					Citizen.Wait(0)
					if IsPedSittingInAnyVehicle(PlayerPedId()) then
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
						if (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
							if vehicle_speeds[GetEntityModel(vehicle)] then
								if speed <= vehicle_speeds[GetEntityModel(vehicle)] then
									SetEntityMaxSpeed(vehicle, speed/2.236936)
                                    if not hud_off then
                                        local x = 0.77
                                        if speed >= 100 then x = 0.768 else x = 0.77 end
                                        drawText("~y~SPEED LOCKED TO "..speed, 6, x, 0.789, 0.4, 255, 255, 255, 255, false, true)
                                    end
								else
									speedlocked = false
								end
							else
								if speed <= default_speed then
									SetEntityMaxSpeed(vehicle, speed/2.236936)
                                    if not hud_off then
                                        local x = 0.77
                                        if speed >= 100 then x = 0.768 else x = 0.77 end
                                        drawText("~y~SPEED LOCKED TO "..speed, 6, x, 0.789, 0.4, 255, 255, 255, 255, false, true)
                                    end
								else
									speedlocked = false
								end
							end
						else
							speedlocked = false
						end
					else
						speedlocked = false
					end
				end
			end)
		end
	end
end)

--]]
AddEventHandler("interaction:vehicle_speedlock", function()
    speedlocked = not speedlocked
    if speedlocked then
        local speed = tonumber(KeyboardInput("Enter speed:", 45, 3))
        if speed then
            Citizen.CreateThread(function()
                while speedlocked do
                    Citizen.Wait(0)
                    local PlayerPed = PlayerPedId()
                    local LastVehicle = GetVehiclePedIsIn(PlayerPed, true)

                    if IsPedSittingInAnyVehicle(PlayerPed) then
                        local vehicle = GetVehiclePedIsIn(PlayerPed, false)
                        if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
                            if (math.abs(speed)/2.23693629) <= GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel") then
                                SetEntityMaxSpeed(vehicle, math.abs(speed)/2.23693629)
                                if not hud_off then
                                    local x = 0.77
                                    if math.abs(speed) >= 100 then x = 0.768 else x = 0.77 end
                                    drawHelpTxt(.66, 1.395, 1.0,1.0,0.45, "Speed locked at "..math.abs(speed), 255, 255, 255, 250, 6)
                                end
                            else
                                SetEntityMaxSpeed(LastVehicle, GetVehicleHandlingFloat(LastVehicle, "CHandlingData", "fInitialDriveMaxFlatVel"))
                                speedlocked = false
                            end
                        else
                            SetEntityMaxSpeed(LastVehicle, GetVehicleHandlingFloat(LastVehicle, "CHandlingData", "fInitialDriveMaxFlatVel"))
                            speedlocked = false
                        end
                    else
                        SetEntityMaxSpeed(LastVehicle, GetVehicleHandlingFloat(LastVehicle, "CHandlingData", "fInitialDriveMaxFlatVel"))
                        speedlocked = false
                    end
                end
            end)
        end
    else
        SetEntityMaxSpeed(LastVehicle, GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), true), "CHandlingData", "fInitialDriveMaxFlatVel"))
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local PlayerPed = PlayerPedId()

        if not IsPedInAnyVehicle(PlayerPed, false) and speedlocked then
            speedlocked = false
        end

        if IsPedSittingInAnyVehicle(PlayerPed) then 
            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPed, false), -1) == PlayerPed then
                if IsControlJustPressed(1, 244) and IsInputDisabled(2) and not controller then
                    TriggerEvent("interaction:vehicle_speedlock")
                end
            end
        end
    end
end)
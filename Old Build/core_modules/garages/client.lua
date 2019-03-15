--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Garages                                                            --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Variables                                                          --
--==============================================================================================================================--
user_vehicles = {}                                                                                                             --
user_garages = {}                                                                                                              --
out = {}                                                                                                                        --
local replacementgarage = {x=0.0,y=0.0,z=0.0,heading=0.0}
local currentgaragecost = nil                                                                                                   --
local slotprice = 500                                                                                                        --
local garageposition = 1                                                                                                        --                                                                                               
local vehiclebool = false                                                                                                       --
--local insurancebool = false                                                                                                     --
garage_menu = false                                                                                                             --
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Configuration                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--[[insurance = {
    ["cheburek"] = 0,
    ["ellie"] = 0,
    ["entity2"] = 0,
    ["fagaloa"] = 0,
    ["flashgt"] = 0,
    ["gb200"] = 0,
    ["issi3"] = 0,
    ["michelli"] = 0,
    ["tezeract"] = 0,
    ["tyrant"] = 0,

    ["taxi"] = 9500,
    ["towtruck"] = 15000,
    ["towtruck2"] = 7000,
    ["taco"] = 11000,
    ["tourbus"] = 13000,

    ["blista"] = 7500,
    ["brioso"] = 9000,
    ["dilettante"] = 6000,
    ["issi2"] = 7500,
    ["panto"] = 2500,
    ["prairie"] = 6000,
    ["rhapsody"] = 2500,
    ["issi3"] = 15000,

    ["cogcabrio"] = 218400,
    ["exemplar"] = 173000,
    ["f620"] = 85400,
    ["felon"] = 47000,
    ["felon2"] = 49000,
    ["jackal"] = 70000,
    ["oracle"] = 90000,
    ["oracle2"] = 95000,
    ["sentinel"] = 125000,
    ["sentinel2"] = 132000,
    ["windsor"] = 120000,
    ["windsor2"] = 122500,
    ["zion"] = 60000,
    ["zion2"] = 63000,

    ["ninef"] = 140000,
    ["ninef2"] = 145000,
    ["alpha"] = 45000,
    ["banshee"] = 75000,
    ["banshee2"] = 965000,
    ["bestiagts"] = 185000,
    ["buffalo"] = 29500,
    ["buffalo2"] = 39500,
    ["carbonizzare"] = 250000,
    ["raiden"] = 70000,
    ["comet2"] = 125000,
    ["comet3"] = 80000,
    ["comet4"] = 70000,
    ["comet5"] = 165000,
    ["coquette"] = 125000,
    ["tampa2"] = 95000,
    ["hotring"] = 42500,
    ["elegy2"] = 82000,
    ["elegy"] = 99000,
    ["feltzer2"] = 164000,
    ["furoregt"] = 81750,
    ["fusilade"] = 31500,
    ["futo"] = 17000,
    ["blista3"] = 40000,
    ["jester"] = 210000,
    ["jester2"] = 274000,
    ["khamelion"] = 69000,
    ["kuruma"] = 37500,
    ["kuruma2"] = 52500,
    ["lynx"] = 61750,
    ["massacro"] = 142500,
    ["massacro2"] = 143500,
    ["neon"] = 135000,
    ["omnis"] = 51750,
    ["pariah"] = 35750,
    ["penumbra"] = 43900,
    ["rapidgt"] = 115000,
    ["rapidgt2"] = 130000,
    ["raptor"] = 51000,
    ["revolter"] = 43000,
    ["ruston"] = 103500,
    ["schafter2"] = 48000,
    ["schafter3"] = 152000,
    ["sentinel3"] = 21000,
    ["seven70"] = 225000,
    ["specter"] = 175000,
    ["specter2"] = 210000,
    ["buffalo3"] = 49000,
    ["streiter"] = 42000,
    ["sultan"] = 28210,
    ["sultanrs"] = 78210,
    ["surano"] = 60750,
    ["tropos"] = 120000,
    ["verlierer2"] = 95150,

    ["ardent"] = 30000,
    ["casco"] = 75000,
    ["cheetah2"] = 170000,
    ["coquette2"] = 230000,
    ["btype2"] = 150000,
    ["gt500"] = 127500,
    ["infernus2"] = 220000,
    ["jester3"] = 105000,
    ["jb700"] = 175000,
    ["z190"] = 20000,
    ["mamba"] = 350000,
    ["manana"] = 18000,
    ["monroe"] = 45500,
    ["peyote"] = 17000,
    ["pigalle"] = 15500,
    ["rapidgt3"] = 232000,
    ["retinue"] = 21000,
    ["btype"] = 122500,
    ["btype3"] = 24500,
    ["savestra"] = 58000,
    ["stinger"] = 327000,
    ["stingergt"] = 318000,
    ["feltzer3"] = 328500,
    ["torero"] = 17500,
    ["tornado"] = 15500,
    ["tornado3"] = 9000,
    ["tornado4"] = 7500,
    ["tornado5"] = 17500,
    ["tornado6"] = 11000,
    ["turismo2"] = 292500,
    ["viseris"] = 45000,
    ["ztype"] = 44500,

    --["pfister811"] = 1350000,
    ["adder"] = 1700000,
    --["banshee2"] = 1166000,
    --["bullet"] = 1120000,
    --["cheetah"] = 1180000,
    ["cyclone"] = 2100000,
    --["entityxf"] = 1125000,
    --["sheava"] = 1145000,
    --["fmj"] = 1115000,
    --["gp1"] = 1150000,
    ["infernus"] = 1210000,
    --["italigtb"] = 1500000,
    --["italigtb2"] = 1900000,
    --["nero"] = 1300000,
    --["nero2"] = 1400000,
    --["osiris"] = 950000,
    --["autarch"] = 1300000,
    --["penetrator"] = 805000,
    --["le7b"] = 1475000,
    --["reaper"] = 725000,
    --["sc1"] = 1150000,
    --["sultanrs"] = 250000,
    ["t20"] = 1650000,
    --["tempesta"] = 945000,
    --["turismor"] = 1560000,
    --["tyrus"] = 1550000,
    ["vacca"] = 240000,
    --["vagner"] = 1005000,
    --["visione"] = 1500000,
    --["voltic"] = 545000,
    ["xa21"] = 1500000,
    --["prototipo"] = 1700000,
    ["zentorno"] = 1100000,
    ["taipan"] = 2175000,
    ["entity2"] = 975000,

    ["blade"] = 12500,
    ["buccaneer"] = 11000,
    ["buccaneer2"] = 14000,
    ["stallion2"] = 0,
    ["chino"] = 10200,
    ["chino2"] = 12200,
    ["coquette3"] = 67900,
    ["dominator"] = 25680,
    ["dominator3"] = 125680,
    ["dukes"] = 22500,
    ["dukes2"] = 0,
    ["gauntlet"] = 27290,
    ["hermes"] = 19995,
    ["hotknife"] = 60000,
    ["hustler"] = 32500,
    ["faction"] = 14995,
    ["faction2"] = 16995,
    ["faction3"] = 18995,
    ["slamvan2"] = 28500,
    ["lurcher"] = 45950,
    ["moonbeam"] = 4995,
    ["moonbeam2"] = 6995,
    ["nightshade"] = 19900,
    ["phoenix"] = 21050,
    ["picador"] = 6300,
    ["dominator2"] = 35680,
    ["ratloader"] = 5500,
    ["ratloader2"] = 5250,
    ["gauntlet2"] = 29290,
    ["ruiner"] = 14500,
    ["ruiner2"] = 0,
    ["sabregt"] = 8500,
    ["sabregt2"] = 9500,
    ["slamvan"] = 6500,
    ["slamvan3"] = 8000,
    ["stallion"] = 0,
    ["tampa"] = 21000,
    ["virgo"] = 22000,
    ["virgo2"] = 29000,
    ["virgo3"] = 31000,
    ["vigero"] = 16000,
    ["voodoo2"] = 2500,
    ["voodoo"] = 3000,
    ["yosemite"] = 12900,

    ["bifta"] = 7795,
    ["bodhi2"] = 8495,
    ["brawler"] = 100000,
    ["kamacho"] = 27945,
    ["trophytruck2"] = 187212,
    ["dubsta3"] = 450000,
    ["dune"] = 9000,
    ["dloader"] = 7000,
    ["bfinjection"] = 4000,
    ["kalahari"] = 16000,
    ["mesa3"] = 47000,
    ["nightshark"] = 0,
    ["rancherxl"] = 7000,
    ["riata"] = 10000,
    ["rebel2"] = 19000,
    ["rebel"] = 3000,
    ["sandking2"] = 21000,
    ["sandking"] = 24000,
    ["trophytruck"] = 435000,

    ["baller"] = 80000,
    ["baller2"] = 83000,
    ["baller3"] = 139000,
    ["baller4"] = 141000,
    ["bjxl"] = 26000,
    ["cavalcade"] = 18000,
    ["cavalcade2"] = 21000,
    ["contender"] = 27750,
    ["dubsta2"] = 123600,
    ["fq2"] = 17400,
    ["granger"] = 13000,
    ["gresley"] = 18000,
    ["habanero"] = 13000,
    ["huntley"] = 75000,
    ["landstalker"] = 22000,
    ["mesa"] = 24000,
    ["patriot"] = 15000,
    ["radi"] = 16570,
    ["rocoto"] = 32000,
    ["seminole"] = 24000,
    ["serrano"] = 27000,
    ["xls"] = 70150,

    ["bison"] = 32000,
    ["bobcatxl"] = 21000,
    ["burrito3"] = 14000,
    ["camper"] = 17000,
    ["gburrito2"] = 18000,
    ["journey"] = 17500,
    ["minivan"] = 28000,
    ["minivan2"] = 39000,
    ["paradise"] = 21000,
    ["rumpo"] = 15000,
    ["rumpo3"] = 19000,
    ["surfer"] = 14000,
    ["surfer2"] = 14500,
    ["youga"] = 12000,
    ["youga2"] = 14000,

    ["asea"] = 10000,
    ["asterope"] = 14000,
    ["cognoscenti"] = 120000,
    ["cog55"] = 160000,
    ["emperor"] = 6000,
    ["emperor2"] = 4000,
    ["fugitive"] = 24000,
    ["glendale"] = 21000,
    ["ingot"] = 9000,
    ["intruder"] = 15000,
    ["premier"] = 10000,
    ["primo"] = 6080,
    ["primo2"] = 10000,
    ["regina"] = 8000,
    ["romero"] = 9500,
    ["schafter2"] = 35000,
    ["stanier"] = 10000,
    ["stratum"] = 8000,
    ["stretch"] = 25000,
    ["superd"] = 155000,
    ["surge"] = 24000,
    ["tailgater"] = 18000,
    ["warrener"] = 13000,
    ["washington"] = 15000,
    
    ["akuma"] = 4500,
    ["avarus"] = 38900,
    ["bagger"] = 14500,
    ["bati"] = 25000,
    ["bati2"] = 37000,
    ["bf400"] = 6300,
    ["carbonrs"] = 11500,
    ["cliffhanger"] = 29000,
    ["daemon"] = 9500,
    ["daemon2"] = 10000,
    ["defiler"] = 11200,
    ["diablous"] = 12700,
    ["diablous2"] = 14200,
    ["double"] = 9000,
    ["enduro"] = 6500,
    ["esskey"] = 7950,
    ["faggio2"] = 2500,
    ["faggio"] = 3500,
    ["faggio3"] = 4000,
    ["fcr"] = 12500,
    ["fcr2"] = 14500,
    ["gargoyle"] = 11400,
    ["hakuchou"] = 62000,
    ["hakuchou2"] = 176000,
    ["hexer"] = 11500,
    ["innovation"] = 12000,
    ["lectro"] = 7550,
    ["manchez"] = 7000,
    ["nemesis"] = 11000,
    ["nightblade"] = 13500,
    ["pcj"] = 12000,
    ["ratbike"] = 10800,
    ["ruffian"] = 9500,
    ["sanchez"] = 7500,
    ["Sanctus"] = 55000,
    ["sovereign"] = 9500,
    ["thrust"] = 7600,
    ["vader"] = 6500,
    ["vindicator"] = 11000,
    ["vortex"] = 9250,
    ["wolfsbane"] = 4500,
    ["zombiea"] = 6500,
    ["zombieb"] = 7500,

}--]]


claimspots = {
    {x=-237.37387084961,y=-1183.5006103516,z=22.483282089233},
    {x=-242.02268981934,y=-1183.203125,z=22.483671188354},
    {x=-222.5458984375,y=-1183.1156005859,z=22.48335647583},
    {x=-229.61878967285,y=-1183.6950683594,z=22.22283744812},
    {x=-235.49664306641,y=-1183.2746582031,z=22.223714828491},
}

emplacement_garage = {
    [1] = {name="Public Garage", colour=1, sprite=357, x=-332.88320922852,y=-779.23046875,z=33.964912414551,id=1,gname="Peaceful St [1]",cost=3000,heading=0.0,maxslots=3}, -- Peaceful St
    [2] = {name="Public Garage", colour=1, sprite=357, x=-443.00497436523,y=185.29835510254,z=75.203712463379,id=2,gname="North LS [2]",cost=2000,heading=0.0,maxslots=2}, -- Public Upper City
    [3] = {name="Public Garage", colour=1, sprite=357, x=1232.4792480469,y=2708.3212890625,z=38.005790710449,id=3,gname="Sandy [3]",cost=1000,heading=0.0,maxslots=1}, -- Public Sandy
    [4] = {name="Public Garage", colour=1, sprite=357, x=117.96788024902,y=6599.45703125,z=32.013603210449,id=4,gname="Paleto [4]",cost=1000,heading=-90.0,maxslots=1}, -- Public Paleto
    [5] = {name="Personal Garage", colour=3, sprite=357, x=947.13641357422,y=-1697.9788818359,z=30.085023880005,id=5,gname="Industrial [5]",cost=2000,heading=-95.0,maxslots=2}, -- Personal
    [6] = {name="Personal Garage", colour=3, sprite=357, x=520.40753173828,y=168.9965057373,z=99.372108459473,id=6,gname="Apartment Complex [6]",cost=2000,heading=-110.0,maxslots=2}, -- Personal
    [7] = {name="Personal Garage", colour=3, sprite=357, x=-667.74456787109,y=-2378.0485839844,z=13.8580493927,id=7,gname="Exceptionalists Way [7]",cost=4000,heading=-45.0,maxslots=4}, -- Personal
    [8] = {name="Personal Garage", colour=3, sprite=357, x=258.68347167969,y=2589.7287597656,z=44.954097747803,id=8,gname="Autoshop Garage [8]",cost=2000,heading=10.0,maxslots=2}, -- Personal
    [9] = {name="Personal Garage", colour=3, sprite=357, x=-34.561923980713,y=6418.0092773438,z=31.442190170288,id=9,gname="Paleto Blvd [9]",cost=2000,heading=225.0,maxslots=2}, -- Personal
    [10] = {name="Personal Garage", colour=3, sprite=357, x=-833.24926757813,y=-392.95385742188,z=31.325246810913,id=10,gname="Weazel [10]",cost=4000,heading=225.0,maxslots=4}, -- Personal
    [11] = {name="Personal Garage", colour=3, sprite=357, x=-30.303638458252,y=2.1268248558044,z=71.200004577637,id=11,gname="Small Garage [11]",cost=2000,heading=150.0,maxslots=2}, -- Personal
    [12] = {name="Personal Garage", colour=3, sprite=357, x=-84.019691467285,y=-820.99694824219,z=36.028030395508,id=12,gname="Maze Tower [12]",cost=5000,heading=-365.0,maxslots=5}, -- Personal
    [13] = {name="Personal Garage", colour=3, sprite=357, x=1958.3830566406,y=3767.013671875,z=32.208053619385,id=13,gname="Sandy Shores [13]",cost=3000,heading=29.273107528687,maxslots=3},
}

--[[emplacement_insurance = {
    {name="Buy Insurance", colour=69, sprite=498, x=-32.958335876465,y=-1111.619140625,z=26.422338485718},
}--]]

emplacement_selling = {
    {name="Sell vehicles", colour=1, sprite=225, x=-44.919033050537,y=-1082.6441650391,z=26.685247421265},
}

--[[emplacement_claim = {    
    {name="Claim Insurance", colour=3, sprite=467, x=-218.64384460449,y=-1162.3128662109,z=23.022277832031},
}--]]

emplacement_garage_options = {    
    {name="Modify garages", colour=3, sprite=78, x=-55.156490325928,y=-1089.9210205078,z=26.322859191895},
}
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                            Events                                                            --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterNetEvent("garage:setvehicles")
AddEventHandler("garage:setvehicles", function(data)
    user_vehicles = data
end)

RegisterNetEvent("garage:setvehicle")
AddEventHandler("garage:setvehicle", function(data)
    for i = 1, #user_vehicles do
        if data.plate == user_vehicles[i].plate then
            user_vehicles[i] = data
        end
    end
end)

RegisterNetEvent("garage:setgarages")
AddEventHandler("garage:setgarages", function(data)
    user_garages = data
end)

--[[RegisterNetEvent("garage:insurance")
AddEventHandler("garage:insurance",function(index)
    user_vehicles[index].insurance = "true"
    garage_menu = false
end)--]]

RegisterNetEvent("garage:pay_impound")
AddEventHandler("garage:pay_impound",function(index)
    user_vehicles[index].state = "~g~Stored"
    garage_menu = false
end)

RegisterNetEvent("garage:buy")
AddEventHandler("garage:buy",function(new_garage)
    table.insert(user_garages, new_garage)
    garage_menu = false
end)

RegisterNetEvent("garage:transfer")
AddEventHandler("garage:transfer",function(_plate, _gid)
    for k,v in pairs(user_vehicles) do
        if v.plate == _plate then
            v.garage_id = _gid
            break
        end
    end
    garage_menu = false
end)

RegisterNetEvent("garage:sold")
AddEventHandler("garage:sold",function(index)
    table.remove(user_vehicles, index)
end)

RegisterNetEvent("garage:buyslots")
AddEventHandler("garage:buyslots",function(_slots, gid)
    for k,v in pairs(user_garages) do
        if v.garage_id == gid then
            v.slots = _slots
            subGarageOptions(v)
            break
        end
    end
end)

RegisterNetEvent("garage:impound")
AddEventHandler("garage:impound", function(plate, amount)
    for k,v in pairs(user_vehicles) do
        if plate == v.plate then
            if amount > 0 then
                v.state = "~b~Impounded"
            else
                v.state = "~g~Stored"
            end
            break
        end
    end
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Open Menus                                                          --
--                                                          Draw Blips                                                          --
--                                                         Draw Markers                                                         --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local incircle = false
Citizen.CreateThread(function()
    for _, item in pairs(emplacement_garage) do
        addBlip(item)
    end
--[[    for _, item in pairs(emplacement_insurance) do
        addBlip(item)
    end--]]
    for _, item in pairs(emplacement_selling) do
        addBlip(item)
    end
--[[    for _, item in pairs(emplacement_claim) do
        addBlip(item)
    end--]]
    for _, item in pairs(emplacement_garage_options) do
        addBlip(item)
    end
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(emplacement_garage) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(25, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 3.5)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to open the garage!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
                        GUI.maxVisOptions = 10; titleTextSize = {0.85, 0.65}; titleRectSize = {0.16, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.16, 0.035}; menuX = 0.75; menuXOption = 0.075; menuXOtherOption = 0.055; menuYModify = 0.3000; menuYOptionDiv = 8.56; menuYOptionAdd = 0.36
                        currentgarage = emplacement_garage[k]
                        garageposition = 1
                        garage_menu = not garage_menu
                        garage() -- Menu to draw
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 3.5)then
                    incircle = false
                    garage_menu = false
                end
            end
        end
        --[[for k,v in ipairs(emplacement_insurance) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(25, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to buy insurance!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
                        GUI.maxVisOptions = 20; titleTextSize = {0.85, 0.80}; titleRectSize = {0.23, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.23, 0.035}; menuX = 0.745; menuXOption = 0.11; menuXOtherOption = 0.06; menuYModify = 0.1500; menuYOptionDiv = 4.285; menuYOptionAdd = 0.21;
                        garage_menu = not garage_menu
                        insuranceMenu() -- Menu to draw
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    garage_menu = false
                end
            end
        end--]]
        --[[for k,v in ipairs(emplacement_claim) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(25, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to claim insurance!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then -- INPUT_CELLPHONE_DOWN
                        GUI.maxVisOptions = 10; titleTextSize = {0.85, 0.65}; titleRectSize = {0.16, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.16, 0.035}; menuX = 0.75; menuXOption = 0.075; menuXOtherOption = 0.055; menuYModify = 0.3000; menuYOptionDiv = 8.56; menuYOptionAdd = 0.36
                        garage_menu = not garage_menu
                        claimMenu()
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    garage_menu = false
                end
            end
        end--]]
        for k,v in ipairs(emplacement_garage_options) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(25, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 3.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to modify your garages!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then -- INPUT_CELLPHONE_DOWN
                        GUI.maxVisOptions = 20; titleTextSize = {0.85, 0.80}; titleRectSize = {0.23, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.23, 0.035}; menuX = 0.745; menuXOption = 0.11; menuXOtherOption = 0.06; menuYModify = 0.1500; menuYOptionDiv = 4.285; menuYOptionAdd = 0.21;
                        garage_menu = not garage_menu
                        GarageOptions()
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 3.0)then
                    incircle = false
                    garage_menu = false
                end
            end
        end
        for k,v in ipairs(emplacement_selling) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(25, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 3.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to sell your car for half the purchase price!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then -- INPUT_CELLPHONE_DOWN
                        currentgarage = emplacement_selling[k]
                        local veh = GetClosestVehicle(currentgarage.x, currentgarage.y, currentgarage.z, 3.000, 0, 70)
                        if DoesEntityExist(veh) then
                            local stored = false
                            local plate = GetVehicleNumberPlateText(veh)
                            for i = 1, #user_vehicles do
                                if tostring(plate) == tostring(user_vehicles[i].plate) or veh == tonumber(user_vehicles[i].instance) then
                                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                                    stored = true
                                    TriggerServerEvent("garage:sell", user_vehicles[i].plate, user_vehicles[i].model, i)
                                end
                            end
                            if not stored then
                                exports.pNotify:SendNotification({text = "This is not your vehicle!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                            end
                        else
                            exports.pNotify:SendNotification({text = "You aren't a vehicle, idiot!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                        end
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 3.0)then
                    incircle = false
                end
            end
        end
    end
end)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Garage Menu                                                         --
--                                                      Buy/Store/Retrieve                                                      --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function garage()
    local t = true
    for i = 1, #user_garages do
        if user_garages[i].garage_id == currentgarage.id then
            t = false
        end
    end
    if t then
        currentgaragecost = currentgarage.cost
        menuXOtherOption = 0.027
        Menu.SetupMenu("buy_menu","Buy Garage")
        Menu.Switch(nil,"buy_menu")
        Menu.addOption("buy_menu", function()
            if(Menu.GarageBool(currentgarage.gname, vehiclebool, "~g~$~w~"..currentgaragecost,"~g~$~w~"..currentgaragecost,function(cb)   vehiclebool = cb end))then
                TriggerServerEvent("garage:buy", currentgarage.id, garageposition)
            end
        end)
        Menu.addOption("buy_menu", function()
            local slots = {}
            for i = 1, currentgarage.maxslots do
                table.insert(slots, ""..i)
            end
            if(Menu.GarageArray("Slots:", slots, garageposition,function(cb) garageposition = cb end)) then
                currentgaragecost = tostring(tonumber(currentgarage.cost) + (slotprice * (garageposition - 1)))
            end         
        end)
    else
        menuXOtherOption = 0.055
        Menu.SetupMenu("garage_menu","Garage")
        Menu.Switch(nil,"garage_menu")
        Menu.addOption("garage_menu", function()
            if(Menu.Option("Retrieve a vehicle"))then
                GetVehicles()
            end
        end)
        Menu.addOption("garage_menu", function()
            if(Menu.Option("Store a vehicle"))then
                StoreVehicle()
            end
        end)
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Garage Menu                                                         --
--                                                           Retrieve                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function getCarQ()
    local count = 0
    for i=1,#user_vehicles do
        if user_vehicles[i].garage_id == currentgarage.id then
            count = count + 1
        end
    end
    return count
end

function getGarageQ()

    for i=1,#user_garages do
        if user_garages[i].garage_id == currentgarage.id then
            return user_garages[i].slots
        end
    end
    return "Error"
end

function GetVehicles()
    Menu.SetupMenu("vehicle_list","Cars: " .. getCarQ() .. "/" .. getGarageQ())
    Menu.Switch("garage_menu","vehicle_list")
    for i = 1,#user_vehicles do
        if (user_vehicles[i] ~= nil) then
            if user_vehicles[i].garage_id == currentgarage.id then
                Menu.addOption("vehicle_list", function()
                    if(Menu.Bool(tostring(user_vehicles[i].name), vehiclebool, tostring(user_vehicles[i].state),tostring(user_vehicles[i].state),function(cb)   vehiclebool = cb end))then
                        if user_vehicles[i].state ~= "~r~Missing" and not string.starts(user_vehicles[i].state, "~b~Impounded") then
                            garage_menu = false
                            SpawnVehicle(user_vehicles[i], i)
                        elseif string.starts(user_vehicles[i].state, "~b~Impounded") then
                            TriggerServerEvent("garage:pay_impound", i)
                            garage_menu = false
                        else
                            exports.pNotify:SendNotification({text = "This vehicle is not in the garage", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                        end
                    end
                end)
            end
        end
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                        Insurance Menu                                                        --
--                                                        Buy Insurance                                                         --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--[[function insuranceMenu()
    Menu.SetupMenu("insurance_menu","Insurance")
    Menu.Switch(nil,"insurance_menu")
    for i = 1,#user_vehicles do
        if (user_vehicles[i] ~= nil) then
            local cost = (insurance[user_vehicles[i].model] or 125000)/10
            if user_vehicles[i].insurance == "false" or tonumber(user_vehicles[i].insurance) == 0 then
                Menu.addOption("insurance_menu", function()
                    if(Menu.CarBool(tostring(user_vehicles[i].name), insurancebool, "~g~$~w~"..math.floor(cost),"~g~$~w~"..math.floor(cost),function(cb)   insurancebool = cb end))then
                        TriggerServerEvent("garage:insurance", user_vehicles[i].plate, user_vehicles[i].model, i)
                    end
                end)
            elseif user_vehicles[i].insurance == "true" then
                Menu.addOption("insurance_menu", function()
                    if(Menu.CarBool(tostring(user_vehicles[i].name), insurancebool, "~g~Insured","~g~Insured",function(cb)   insurancebool = cb end))then
                    end
                end)
            else
                Citizen.Trace("This is an error: "..user_vehicles[i].insurance.." report it to an admin!")
            end
        end
    end
end--]]

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Claim Menu                                                          --
--                                               Get your car back if its insured                                               --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--[[function claimMenu()
    Menu.SetupMenu("claim_menu","Insurance Claims")
    Menu.Switch(nil,"claim_menu")
    for i = 1,#user_vehicles do
        if (user_vehicles[i] ~= nil) then
            if user_vehicles[i].insurance == "true" and user_vehicles[i].state == "~r~Missing" then
                Menu.addOption("claim_menu", function()
                    if(Menu.Bool(tostring(user_vehicles[i].name), vehiclebool, "~g~Claim", "~g~Claim",function(cb)   vehiclebool = cb end))then
                        Citizen.CreateThread(function()
                            local instance = user_vehicles[i].instance
                            Citizen.Trace("CURRENT instance == "..instance)
                            local count = math.random(1,5)
                            for b = 1, #claimspots do
                                if b == count then
                                    replacementgarage.x = claimspots[count].x
                                    replacementgarage.y = claimspots[count].y
                                    replacementgarage.z = claimspots[count].z
                                    replacementgarage.heading = 0.0
                                end
                            end
                            local isAreaCrowded = GetClosestVehicle(replacementgarage.x, replacementgarage.y, replacementgarage.z, 3.000, 0, 70)
                            if DoesEntityExist(isAreaCrowded) then
                                exports.pNotify:SendNotification({text = "Try again, the spawn location is occupied!", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                            else
                                local found_instance = false
                                for a = 1, #out do
                                    if out[a] == instance then
                                        found_instance = true
                                        table.remove(out, a)
                                        SpawnReplacement(user_vehicles[i], i)                                
                                        if DoesEntityExist(instance) then
                                            DestroyCar(instance)
                                        end
                                        break
                                    end
                                end
                                if not found_instance then
                                    SpawnReplacement(user_vehicles[i], i)
	   		                          TriggerServerEvent("garage:pay_impound") 
                                    if DoesEntityExist(instance) then
                                        DestroyCar(instance)
                                    end
                                end
                            end
                        end)
                    end
                end)
            end
        end
    end
end--]]
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Modify Menu                                                         --
--                                                       Buy more storage                                                       --
--                                                        Transfer Cars                                                         --
--                                                         Sell garages                                                         --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function GarageOptions()
    Menu.SetupMenu("garage_options_menu","Modify Garages")
    Menu.Switch(nil,"garage_options_menu")
    for i = 1, #user_garages do
        if (user_garages[i] ~= nil) then
            Menu.addOption("garage_options_menu", function()
                local a = user_garages[i].garage_id
                if(Menu.Option(emplacement_garage[a].gname))then
                    subGarageOptions(user_garages[i])
                end
            end)
        end
    end
end

function subGarageOptions(garage)
    local currentgaragecost = 500
    Menu.SetupMenu("subgarage_options_menu",emplacement_garage[garage.garage_id].gname)
    Menu.Switch("garage_options_menu","subgarage_options_menu")
    currentOption = 0
    Menu.addOption("subgarage_options_menu", function()
        if(Menu.Option("Transfer a car to this garage"))then
            transferVehicle(garage)
        end
    end)
    if garage.garage_id > 4 then
        Menu.addOption("subgarage_options_menu", function()
            if(Menu.Option("Sell garage"))then
                TriggerServerEvent("garage:sellg", garage.garage_id)
            end
        end)
    end
    if garage.slots ~= emplacement_garage[garage.garage_id].maxslots then
        Menu.addOption("subgarage_options_menu", function()
            if(Menu.GarageBool("Upgrade storage", vehiclebool, "~g~$~w~"..currentgaragecost,"~g~$~w~"..currentgaragecost,function(cb)   vehiclebool = cb end))then
                TriggerServerEvent("garage:buyslots", garage.garage_id, (garageposition + garage.slots), garageposition)
            end
        end)
        Menu.addOption("subgarage_options_menu", function()
            local slots = {}
            for a = (garage.slots + 1), emplacement_garage[garage.garage_id].maxslots do
                table.insert(slots, ""..a)
            end
            if(Menu.GarageArray("Increase slots from "..garage.slots.." to:", slots, garageposition, function(cb) garageposition = cb end)) then
                currentgaragecost = tostring(slotprice * garageposition)
            end         
        end)
    end
end

function transferVehicle(garage)
    Menu.SetupMenu("vehicletransfer_menu",emplacement_garage[garage.garage_id].gname)
    Menu.Switch("subgarage_options_menu","vehicletransfer_menu")
    for i = 1, #user_vehicles do
        Menu.addOption("vehicletransfer_menu", function()
            if(Menu.TransferBool(user_vehicles[i].name, vehiclebool, emplacement_garage[user_vehicles[i].garage_id].gname, emplacement_garage[user_vehicles[i].garage_id].gname, function(cb)   vehiclebool = cb end))then
                local count = 0
                for a = 1, #user_vehicles do
                    if user_vehicles[a].garage_id == garage.garage_id then
                        count = count + 1
                    end
                end
                local actualslots = garage.slots
                if count <= actualslots and user_vehicles[i].garage_id == garage.garage_id then
                    exports.pNotify:SendNotification({text = "You cannot transfer a vehicle to the same garage", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                elseif count < actualslots and user_vehicles[i].garage_id ~= garage.garage_id then
                    if user_vehicles[i].state == "~g~Stored" then
                        TriggerServerEvent("garage:transfer", user_vehicles[i].plate, garage.garage_id)
                    else
                        exports.pNotify:SendNotification({text = "Your car must be stored to transfer it!", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                    end
                else
                    exports.pNotify:SendNotification({text = "This garage is full!", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                end
            end
        end)      
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Garage Functions                                                       --
--                                                        Store/Retrieve                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function StoreVehicle()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        local veh = GetClosestVehicle(currentgarage.x, currentgarage.y, currentgarage.z, 3.000, 0, 70)
        if GetVehicleEngineHealth(veh) >= 900 then
            if DoesEntityExist(veh) then
                for i = 1, #out do
                    if out[i] == veh then
                        table.remove(out, i)
                    end
                end
                SetEntityAsMissionEntity(veh, true, true)
                local turbo
                local tiresmoke
                local xenon
                local neon0
                local neon1
                local neon2
                local neon3
                local bulletproof
                local custom_wheels
                local custom_wheels2
                local plate = GetVehicleNumberPlateText(veh)
                local colors = table.pack(GetVehicleColours(veh))
                local extra_colors = table.pack(GetVehicleExtraColours(veh))
                local neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
                local smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))

                if IsToggleModOn(veh,18) then
                    turbo = "on"
                else
                    turbo = "off"
                end

                if IsToggleModOn(veh,20) then
                    tiresmoke = "on"
                else
                    tiresmoke = "off"
                end

                if IsToggleModOn(veh,22) then
                    xenon = "on"
                else
                    xenon = "off"
                end

                if IsVehicleNeonLightEnabled(veh,0) then
                    neon0 = "on"
                else
                    neon0 = "off"
                end

                if IsVehicleNeonLightEnabled(veh,1) then
                    neon1 = "on"
                else
                    neon1 = "off"
                end

                if IsVehicleNeonLightEnabled(veh,2) then
                    neon2 = "on"
                else
                    neon2 = "off"
                end

                if IsVehicleNeonLightEnabled(veh,3) then
                    neon3 = "on"
                else
                    neon3 = "off"
                end

                if GetVehicleTyresCanBurst(veh) then
                    bulletproof = "off"
                else
                    bulletproof = "on"
                end

                if GetVehicleModVariation(veh, 23) then
                    custom_wheels = "on"
                else
                    custom_wheels = "off"
                end

                if GetVehicleModVariation(veh, 24) then
                    custom_wheels2 = "on"
                else
                    custom_wheels2 = "off"
                end

                local stored = false
                for i = 1, #user_vehicles do
                    if tostring(plate) == tostring(user_vehicles[i].plate) then
                        local count = 0
                        for a = 1,#user_vehicles do
                            if user_vehicles[a].garage_id == currentgarage.id then
                                count = count + 1
                            end
                        end
                        local actualslots
                        for b = 1, #user_garages do
                            if user_garages[b].garage_id == currentgarage.id then
                                actualslots = user_garages[b].slots
                            end
                        end
                        if count <= actualslots and user_vehicles[i].garage_id == currentgarage.id then
                            local data = {
                                garage_id = currentgarage.id,
                                model = user_vehicles[i].model,
                                name = user_vehicles[i].name,
                                instance = veh,
                                plate = GetVehicleNumberPlateText(veh),
                                state = "~g~Stored",
                                primary_colour = colors[1],
                                secondary_colour = colors[2],
                                pearlescent_colour = extra_colors[1],
                                wheel_colour = extra_colors[2],
                                smoke_colour = {smokecolor[1],smokecolor[2],smokecolor[3]},
                                plate_colour = GetVehicleNumberPlateTextIndex(veh),
                                neon_colour = {neoncolor[1],neoncolor[2],neoncolor[3]},
                                tint_colour = GetVehicleWindowTint(veh),
                                tyre_smoke = tiresmoke,
                                xenon_lights = xenon,
                                turbo = turbo,
                                custom_wheels = custom_wheels,
                                custom_wheels2 = custom_wheels2,
                                bulletproof_wheels = bulletproof,
                                wheeltype = GetVehicleWheelType(veh),
                                neon0 = neon0,
                                neon1 = neon1,
                                neon2 = neon2,
                                neon3 = neon3,
                                engine_health = GetVehicleEngineHealth(veh),
                                petrol_health = GetVehiclePetrolTankHealth(veh),
                                vehicle_health = GetEntityHealth(veh),
                                insurance = user_vehicles[i].insurance,
                            }

                            for i = 0, 8 do
                            	data["mod"..i] = GetVehicleMod(veh, i)
                            end

                            for i = 10, 16 do
                            	data["mod"..i] = GetVehicleMod(veh, i)
                            end

                            for i = 23, 46 do
                            	data["mod"..i] = GetVehicleMod(veh, i)
                            end

                            data["mod48"] = GetVehicleMod(veh, 48)

                            TriggerServerEvent("garage:stored", data)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                            exports.pNotify:SendNotification({text = "Vehicle stored", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                            garage_menu = false
                            stored = true
                        elseif count < actualslots and user_vehicles[i].garage_id ~= currentgarage.id then
                            local data = {
                                garage_id = currentgarage.id,
                                model = user_vehicles[i].model,
                                name = user_vehicles[i].name,
                                instance = veh,
                                plate = GetVehicleNumberPlateText(veh),
                                state = "~g~Stored",
                                primary_colour = colors[1],
                                secondary_colour = colors[2],
                                pearlescent_colour = extra_colors[1],
                                wheel_colour = extra_colors[2],
                                smoke_colour = {smokecolor[1],smokecolor[2],smokecolor[3]},
                                plate_colour = GetVehicleNumberPlateTextIndex(veh),
                                neon_colour = {neoncolor[1],neoncolor[2],neoncolor[3]},
                                tint_colour = GetVehicleWindowTint(veh),
                                tyre_smoke = tiresmoke,
                                xenon_lights = xenon,
                                turbo = turbo,
                                custom_wheels = custom_wheels,
                                custom_wheels2 = custom_wheels2,
                                bulletproof_wheels = bulletproof,
                                wheeltype = GetVehicleWheelType(veh),
                                neon0 = neon0,
                                neon1 = neon1,
                                neon2 = neon2,
                                neon3 = neon3,
                                engine_health = GetVehicleEngineHealth(veh),
                                petrol_health = GetVehiclePetrolTankHealth(veh),
                                vehicle_health = GetEntityHealth(veh),
                                body_health = GetVehicleBodyHealth(veh),
                                insurance = user_vehicles[i].insurance,
                            }

                            for i = 0, 8 do
                                data["mod"..i] = GetVehicleMod(veh, i)
                            end

                            for i = 10, 16 do
                                data["mod"..i] = GetVehicleMod(veh, i)
                            end

                            for i = 23, 46 do
                                data["mod"..i] = GetVehicleMod(veh, i)
                            end

                            data["mod48"] = GetVehicleMod(veh, 48)

                            TriggerServerEvent("garage:stored", data)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                            exports.pNotify:SendNotification({text = "Vehicle stored", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                            garage_menu = false
                            stored = true
                        else
                            garage_menu = false
                            stored = true
                            exports.pNotify:SendNotification({text = "This garage is full!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                        end
                    end
                end
                if not stored then
                    exports.pNotify:SendNotification({text = "This is not your vehicle!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                    garage_menu = false
                end
            else
                exports.pNotify:SendNotification({text = "No veh!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                garage_menu = false
            end
        else
            Notify("Vehicle is too damaged, we won't store a car looking like that!", 3000)
        end
    end)
end

function SpawnVehicle(data, index)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        local isAreaCrowded = GetClosestVehicle(currentgarage.x, currentgarage.y, currentgarage.z, 3.000, 0, 70)
        if DoesEntityExist(isAreaCrowded) then
            exports.pNotify:SendNotification({text = "The area is crowded", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
        else
            local model = GetHashKey(data.model)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end
            local veh = CreateVehicle(model, currentgarage.x, currentgarage.y, currentgarage.z, currentgarage.heading, true, false)
            while not DoesEntityExist(veh) do
                Citizen.Wait(0)
            end
            table.insert(out, veh)
            SetVehicleOnGroundProperly(veh)
            SetVehicleHasBeenOwnedByPlayer(veh,true)
            local id = NetworkGetNetworkIdFromEntity(veh)
            NetworkRegisterEntityAsNetworked(veh)
            SetNetworkIdCanMigrate(id, true)
            SetNetworkIdExistsOnAllMachines(id, true)

            SetVehicleColours(veh, data.primary_colour, data.secondary_colour)
            SetVehicleExtraColours(veh, tonumber(data.pearlescent_colour), tonumber(data.wheel_colour))
            SetVehicleNumberPlateTextIndex(veh, data.plate_colour)
            SetVehicleNumberPlateText(veh, data.plate)
            SetVehicleNeonLightsColour(veh, tonumber(data.neon_colour[1]), tonumber(data.neon_colour[2]), tonumber(data.neon_colour[3]))
            SetVehicleTyreSmokeColor(veh, tonumber(data.smoke_colour[1]), tonumber(data.smoke_colour[2]), tonumber(data.smoke_colour[3]))
            SetVehicleModKit(veh, 0)

            for i = 0, 8 do
                SetVehicleMod(veh, i, tonumber(data["mod"..i]))
            end

            for i = 10, 16 do
                SetVehicleMod(veh, i, tonumber(data["mod"..i]))
            end

            for i = 23, 46 do
                SetVehicleMod(veh, i, tonumber(data["mod"..i]))
            end

            SetVehicleMod(veh, 48, tonumber(data.mod48))

            if data.turbo == "on" then
                ToggleVehicleMod(veh, 18, true)
            else
                ToggleVehicleMod(veh, 18, false)
            end

            if data.tyre_smoke == "on" then
                ToggleVehicleMod(veh, 20, true)
            else
                ToggleVehicleMod(veh, 20, false)
            end

            if data.xenon_lights == "on" then
                ToggleVehicleMod(veh, 22, true)
            else
                ToggleVehicleMod(veh, 22, false)
            end

            SetVehicleWheelType(veh, tonumber(data.wheeltype))
            SetVehicleMod(veh, 23, tonumber(data.mod23))
            SetVehicleMod(veh, 24, tonumber(data.mod24))

            if data.custom_wheels == "on" then
                SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), true)
            end

            if data.custom_wheels2 == "on" then
                SetVehicleMod(veh, 24, GetVehicleMod(veh, 24), true)
            end

            if data.neon0 == "on" then
                SetVehicleNeonLightEnabled(veh, 0, true)
            else
                SetVehicleNeonLightEnabled(veh, 0, false)
            end

            if data.neon1 == "on" then
                SetVehicleNeonLightEnabled(veh, 1, true)
            else
                SetVehicleNeonLightEnabled(veh, 1, false)
            end

            if data.neon2 == "on" then
                SetVehicleNeonLightEnabled(veh, 2, true)
            else
                SetVehicleNeonLightEnabled(veh, 2, false)
            end

            if data.neon3 == "on" then
                SetVehicleNeonLightEnabled(veh, 3, true)
            else
                SetVehicleNeonLightEnabled(veh, 3, false)
            end

            if data.bulletproof_wheels == "on" then
                SetVehicleTyresCanBurst(veh, false)
            else
                SetVehicleTyresCanBurst(veh, true)
            end

            SetVehicleWindowTint(veh, tonumber(data.tint_colour))

            --SetVehicleEngineHealth(veh, tonumber(data.engine_health))
            --SetVehiclePetrolTankHealth(veh, tonumber(data.petrol_health))
            --SetEntityHealth(veh, tonumber(data.vehicle_health))
            --SetVehicleBodyHealth(veh, tonumber(data.body_health))

            TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)

            SetModelAsNoLongerNeeded(model)
            
            SetEntityInvincible(veh, false)

            user_vehicles[index].state = "~r~Missing"
            user_vehicles[index].instance = veh

            data.state = "~r~Missing"
            data.instance = veh
            TriggerServerEvent("garage:out", data)
        end
    end)
end

function SpawnReplacement(data, index)
    garage_menu = false
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        local model = GetHashKey(data.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        local veh = CreateVehicle(model, replacementgarage.x, replacementgarage.y, replacementgarage.z, replacementgarage.heading, true, false)
        while not DoesEntityExist(veh) do
            Citizen.Wait(0)
        end
        table.insert(out, veh)
        SetVehicleOnGroundProperly(veh)
        SetVehicleHasBeenOwnedByPlayer(veh,true)
        local id = NetworkGetNetworkIdFromEntity(veh)
        NetworkRegisterEntityAsNetworked(veh)
        SetNetworkIdCanMigrate(id, true)
        SetNetworkIdExistsOnAllMachines(id, true)

        SetVehicleColours(veh, data.primary_colour, data.secondary_colour)
        SetVehicleExtraColours(veh, tonumber(data.pearlescent_colour), tonumber(data.wheel_colour))
        SetVehicleNumberPlateTextIndex(veh, data.plate_colour)
        SetVehicleNumberPlateText(veh, data.plate)
        SetVehicleNeonLightsColour(veh, tonumber(data.neon_colour[1]), tonumber(data.neon_colour[2]), tonumber(data.neon_colour[3]))
        SetVehicleTyreSmokeColor(veh, tonumber(data.smoke_colour[1]), tonumber(data.smoke_colour[2]), tonumber(data.smoke_colour[3]))
        SetVehicleModKit(veh, 0)

        for i = 0, 8 do
            SetVehicleMod(veh, i, tonumber(data["mod"..i]))
        end

        for i = 10, 16 do
            SetVehicleMod(veh, i, tonumber(data["mod"..i]))
        end

        for i = 23, 46 do
            SetVehicleMod(veh, i, tonumber(data["mod"..i]))
        end

        SetVehicleMod(veh, 48, tonumber(data.mod48))

        if data.turbo == "on" then
            ToggleVehicleMod(veh, 18, true)
        else
            ToggleVehicleMod(veh, 18, false)
        end

        if data.tyre_smoke == "on" then
            ToggleVehicleMod(veh, 20, true)
        else
            ToggleVehicleMod(veh, 20, false)
        end

        if data.xenon_lights == "on" then
            ToggleVehicleMod(veh, 22, true)
        else
            ToggleVehicleMod(veh, 22, false)
        end

        SetVehicleWheelType(veh, tonumber(data.wheeltype))
        SetVehicleMod(veh, 23, tonumber(data.mod23))
        SetVehicleMod(veh, 24, tonumber(data.mod24))

        if data.custom_wheels == "on" then
            SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), true)
        end

        if data.custom_wheels2 == "on" then
            SetVehicleMod(veh, 24, GetVehicleMod(veh, 24), true)
        end

        if data.neon0 == "on" then
            SetVehicleNeonLightEnabled(veh, 0, true)
        else
            SetVehicleNeonLightEnabled(veh, 0, false)
        end

        if data.neon1 == "on" then
            SetVehicleNeonLightEnabled(veh, 1, true)
        else
            SetVehicleNeonLightEnabled(veh, 1, false)
        end

        if data.neon2 == "on" then
            SetVehicleNeonLightEnabled(veh, 2, true)
        else
            SetVehicleNeonLightEnabled(veh, 2, false)
        end

        if data.neon3 == "on" then
            SetVehicleNeonLightEnabled(veh, 3, true)
        else
            SetVehicleNeonLightEnabled(veh, 3, false)
        end

        if data.bulletproof_wheels == "on" then
            SetVehicleTyresCanBurst(veh, false)
        else
            SetVehicleTyresCanBurst(veh, true)
        end

        SetVehicleWindowTint(veh, tonumber(data.tint_colour))

        --SetVehicleEngineHealth(veh, tonumber(data.engine_health))
        --SetVehiclePetrolTankHealth(veh, tonumber(data.petrol_health))
        --SetEntityHealth(veh, tonumber(data.vehicle_health))
        --SetVehicleBodyHealth(veh, tonumber(data.body_health))

        TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)

        SetModelAsNoLongerNeeded(model)

        SetEntityInvincible(veh, false)

        user_vehicles[index].state = "~r~Missing"
        user_vehicles[index].instance = veh

        data.state = "~r~Missing"
        data.instance = veh
        TriggerServerEvent("garage:out", data)
    end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Basic Functions                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--


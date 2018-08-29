--=============================================================================
--  Teste & Debug
--=============================================================================
-- GaUi.config = {
--     ProgressBar = {
--         borderColor = {0, 0, 0, 255},
--         backgroundColor = {255, 255, 255, 100},
--         barColor = {0, 0xAE, 0xFF, 0xFF},
--         textColor = {255, 255, 255, 255},
--     }
-- }
-- GaUi.showNativeProgressBar = function (percent, texte) 
--     DrawRect(0.5, 0.95 - 0.032 / 2, 0.6 + 0.001, 0.003, GaUi.config.ProgressBar.borderColor[1], GaUi.config.ProgressBar.borderColor[2],GaUi.config.ProgressBar.borderColor[3],GaUi.config.ProgressBar.borderColor[4])
--     DrawRect(0.5, 0.95 + 0.032 / 2, 0.6 + 0.001, 0.003, GaUi.config.ProgressBar.borderColor[1], GaUi.config.ProgressBar.borderColor[2],GaUi.config.ProgressBar.borderColor[3],GaUi.config.ProgressBar.borderColor[4])
    
--     DrawRect(0.5, 0.95, 0.6, 0.032, GaUi.config.ProgressBar.backgroundColor[1], GaUi.config.ProgressBar.backgroundColor[2],GaUi.config.ProgressBar.backgroundColor[3],GaUi.config.ProgressBar.backgroundColor[4])
--     DrawRect(percent * 0.3 + 0.2, 0.95, percent * 0.6, 0.032, GaUi.config.ProgressBar.barColor[1], GaUi.config.ProgressBar.barColor[2], GaUi.config.ProgressBar.barColor[3], GaUi.config.ProgressBar.barColor[4])
    
--     DrawRect(0.5 - 0.6 /2, 0.95, 0.001, 0.032, GaUi.config.ProgressBar.borderColor[1], GaUi.config.ProgressBar.borderColor[2],GaUi.config.ProgressBar.borderColor[3],GaUi.config.ProgressBar.borderColor[4])
--     DrawRect(0.5 + 0.6 /2, 0.95, 0.001, 0.032, GaUi.config.ProgressBar.borderColor[1], GaUi.config.ProgressBar.borderColor[2],GaUi.config.ProgressBar.borderColor[3],GaUi.config.ProgressBar.borderColor[4])
    
--     GaUi.DrawText(texte, 0.5, 0.95 - 0.015, GaUi.config.ProgressBar.textColor, 1, 0, 0.36, 1)
-- end

-- GaUi.showProgressBar = function (percent, texte, time) 
--     -- ...
-- end
--local pos = {x = 453.0, y = -980.0, z= 30.73}

-- local weapon_pickup = {
--     ['Pistolet'] =              { model = GetHashKey("PICKUP_WEAPON_PISTOL50"), quanity = 1 },
--     ['Munition pistolet'] =     { model = GetHashKey('PICKUP_AMMO_PISTOL'), quanity = 9 },
--     ['Fusil a pompe'] =         { model = GetHashKey('PICKUP_WEAPON_PUMPSHOTGUN'), quanity = 1 },
--     ['Munition pompe'] =        { model = GetHashKey('PICKUP_AMMO_SHOTGUN'), quanity = 8 },
--     ['Pistolet de détresse'] =  { model = GetHashKey("PICKUP_WEAPON_FLAREGUN"), quanity = 1 },
--     ['Fusée de détresse'] =     { model = GetHashKey('PICKUP_AMMO_FLAREGUN'), quanity = 1 },
--     ['Lacrymogène'] =           { model = GetHashKey('PICKUP_WEAPON_SMOKEGRENADE'), quanity = 1 },
--     ['Torche'] =                { model = GetHashKey('PICKUP_WEAPON_FLASHLIGHT'), quanity = 1 },
--     ['Théo'] =                  { model = GetHashKey('PICKUP_WEAPON_NIGHTSTICK'), quanity = 1 },
--     ['Taser'] =                 { model = GetHashKey('PICKUP_WEAPON_STUNGUN'), quanity = 1 },
-- }

-- function CreatePickUpWeaponPolice(name)
--     local pos = {x = 452.91, y = -980.0, z= 30.71}
--     local h = weapon_pickup[name]
--     CreatePickupRotate(h.model, pos.x, pos.y, pos.z, 90.0, 0.0, 90.0, 1<<3, h.quanity, 0,0,h.hash)
-- end

-- local pickup = GetHashKey("PICKUP_WEAPON_PISTOL")
-- local hash = GetHashKey("prop_pistol_holster")
-- Citizen.CreateThread(function()
--     local i = 0.000
--     -- RequestModel(hash)
--     -- while not HasModelLoaded(hash) do
--     --     Wait(1)
--     -- end
--     CreatePickUpWeaponPolice('Fusil a pompe')
--     --CreatePickup(pickup, pos.x, pos.y, pos.z, 0, 200, 0, hash)
--     while true do
--         Citizen.Wait(0)
--         DrawLine(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z + 0.2, 255,0,0,255 )

        

--     end
    
-- end)
-- function dump(o)
--    if type(o) == 'table' then
--       local s = '{ '
--       for k,v in pairs(o) do
--          if type(k) ~= 'number' then k = '"'..k..'"' end
--          s = s .. '['..k..'] = ' .. dump(v) .. ','
--       end
--       return s .. '} '
--    else
--       return tostring(o)
--    end
-- end
-- RegisterNetEvent("gcUtils:teste001")
-- AddEventHandler("gcUtils:teste001", function(data)
    
--     Citizen.Trace('data => ' .. dump(data))
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         TriggerServerEvent("gcUtils:teste001")
--         Citizen.Wait(8000)
--     end
-- end)
--  GcUtils.showDialog("Plop", {
--                 "Oui et toi ?",
--                 "Boff",
--                 "...",
--                 'Aurte',
--                 'encore',
--                 'sa depace ?'
--             }, function(reponse)
--                Citizen.Trace(reponse)
--             end)
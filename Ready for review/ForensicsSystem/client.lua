local charactername = nil
local isCop = false
local tFingerprints = {}
  
RegisterNetEvent('isACop')
AddEventHandler('isACop', function(police)
    if(police == true)then
       isCop = police   
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      local ped = PlayerPedId()
      pVehicle = GetPlayersLastVehicle()
      if(IsPedInAnyVehicle(ped) and GetPedDrawableVariation(ped, 3) < 16 ) then
            local vehicle = GetPlayersLastVehicle()
            tFingerprint = {
                veh = GetVehicleNumberPlateText(vehicle),
                player = exports.core:GetCharacterName(GetPlayerServerId(ped)),
              }
              table.insert(tFingerprints, tFingerprint)

            for k, v in ipairs(tFingerprints) do
                for a, b in ipairs(tFingerprint) do
                    if(v.veh == b.veh and v.player == b.player) then
                        count = 1
                    end
                    if(count > 1)then
                        table.remove(tFingerprints, tFingerprint)
                    end
                end
            end
      end
    end
end)

RegisterNetEvent('liftPrint')
AddEventHandler('liftPrint', function(source)
   for k, v in ipairs(tFingerprints) do
    coords = GetEntityCoords(GetPlayerPed(-1), true)
    closestVehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()),100.00,0)
    coordsVehicle = GetEntityCoords(closestVehicle, false)
    dist = Vdist(coordsVehicle.x, coordsVehicle.y, coordsVehicle.z, coords.x, coords.y, coords.z)
        if(dist <= 2) then
            if(v.veh == GetVehicleNumberPlateText(closestVehicle))then
                TriggerEvent('chatMessage', "^2[FORENSICS]: Fingerprint was lifted, and it appears to come back to a "..v.player, {0,0,0})
                return
            else
                TriggerEvent('chatMessage', "^2[FORENSICS]: No prints were found. Suspect was either wearing gloves, or its been too long.", {0,0,0})
                return
            end
        end
    end
end)

RegisterNetEvent('isACop')
RegisterNetEvent('markerForCops')

AddEventHandler('copOnDuty', function(cop)
    for k, v in ipairs(eLocations) do
      if(cop == true)
       DrawMarker( 1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 0.5001, 1555, 0, 0, 165, 0, 0, 0, 0 )
      end
    end
end)

AddEventHandler('isACop', function isPlayerCop(cop)
    if(cop == true)then
      return true
    else
      return false
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
                local evidencePos = {0,0,0}
                local ped = GetPlayerPed(-1) 
                local pedShooting = IsPedShooting(ped) 
                local evidence = nil
                if pedShooting then
              TriggerServerEvent('playerShot', ped)
                    maxdistance = 50
                    needDistance = nil
                    evidence = GetEntityCoords(ped, true)
                    if(#eLocations == 0 )then
                        needDistance =  51
                    else
                        needDistance = Vdist(evidence.x, evidence.y, evidence.z, px, py, pz)
                    end
                    if needDistance > maxdistance then
                      typeGun = GetSelectedPedWeapon(ped)
                      local t = {
                       x = evidence.x,
                       y = evidence.y,
                       z = evidence.z,
                       gunused = typeGun
                      }
                      table.insert(eLocations, t)
                    end
                    px = evidence.x
                    py = evidence.y
                    pz = evidence.z
                end

        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k, v in pairs(eLocations) do
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x , v.y , v.z)
           if dist <= 1.2 then
              DrawNotification("Press E to investigate")
                if IsControlJustPressed(1,51) and isPlayerCop() == true then
                    fireArm = typeGunUsed(v.gunused)
                TriggerServerEvent('removeMarker', GetPlayerPed(-1))
                    table.remove(eLocations, k)
                    local roll = math.random(100)
                    if roll <= 50 then
                  Chat.Message(-1, GetIdentity(GetPlayerPed(-1)), "^2FORENSICS: ^7The bullet seems to have noticeable markings. Seems the bullet came from a "..fireArm , 48, 177, 232, true, 5, GetPlayerPed(-1))
                    else
                  Chat.Message(-1, GetIdentity(GetPlayerPed(-1)), "^2FORENSICS: ^7The bullet doesn't have any clues.", 48, 177, 232, true, 5, GetPlayerPed(-1))
                    end
                end
            end
        end
      end
end)
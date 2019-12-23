local beds = {
    { -- Lower Pillbox
        { coords = vector3(351.83090209961, -568.70837402344, 28.355701446533), h = 160.0, taken = false },
        { coords = vector3(355.248046875, -569.95239257813, 28.355701446533), h = 160.0, taken = false },
        { coords = vector3(358.57180786133, -571.16241455078, 28.355701446533), h = 160.0, taken = false },
        { coords = vector3(354.33316040039, -562.06158447266, 28.355701446533), h = -20.0, taken = false },
        { coords = vector3(357.73266601563, -563.30017089844, 28.355701446533), h = -20.0, taken = false },
        { coords = vector3(361.12408447266, -564.53582763672, 28.355701446533), h = -20.0, taken = false },
    },
    { -- Sandy Medical
        { coords = vector3(1825.7750244141,3678.5363769531,33.822647094727), h = 120.61444091797, taken = false },
        { coords = vector3(1829.6729736328,3676.1083984375,33.822647094727), h = 210.4328918457, taken = false },
        { coords = vector3(1820.3516845703,3671.4311523438,33.82999420166), h = 121.3650894165, taken = false },
    },
    { -- Paleto Medical
        { coords = vector3(-260.17749023438,6320.3125,31.996198654175), h = 314.46951293945, taken = false },
        { coords = vector3(-257.83325195313,6317.9829101563,31.996198654175), h = 315.89712524414, taken = false },
        { coords = vector3(-255.45822143555,6325.1264648438,31.996198654175), h = 45.455837249756, taken = false },
    },
}

local bedsTaken = {}
local injuryBasePrice = 100

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        local hospital = bedsTaken[source][1]
        local bed = bedsTaken[source][2]
        if beds[hospital] ~= nil then
            if beds[hospital][bed] ~= nil then
                beds[hospital][bed].taken = false
            end
        end
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function(hospital)
    if beds[hospital] ~= nil then
        for i = 1, #beds[hospital] do
            if not beds[hospital][i].taken then
                beds[hospital][i].taken = true
                bedsTaken[source] = { hospital, i }
                TriggerClientEvent('mythic_hospital:client:SendToBed', source, hospital, i, beds[hospital][i])
                break
            end
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No Beds Available' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundBed = false
    
    for i = 1, #beds do
        for j = 1, #beds[i] do
            local distance = #(beds[i][j].coords - plyCoords)

            if distance < 3.0 then
                if not beds[i][j].taken then
                    beds[i][j].taken = true
                    bedsTaken[source] = { i, j }
                    TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, i, j,  beds[i][j])
                else
                    TriggerEvent('mythic_chat:server:System', source, 'That Bed Is Taken')
                end

                foundBed = true
                break
            end
        end
    end

    if not foundBed then
        TriggerEvent('mythic_chat:server:System', source, 'Not Near A Hospital Bed')
    end
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end

    TriggerEvent("core:getuser", src, function(user)
        user.removeBank(totalBill)
    end)
	TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(hospital, bed)
    if beds[hospital] ~= nil then
        if beds[hospital][bed] ~= nil then
            beds[hospital][bed].taken = false
            bedsTaken[source] = nil
        end
    end
end)
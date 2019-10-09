local beds = {
    { x = 351.83090209961, y = -568.70837402344, z = 28.355701446533, h = 160.0, taken = false },
    { x = 355.248046875, y = -569.95239257813, z = 28.355701446533, h = 160.0, taken = false },
    { x = 358.57180786133, y = -571.16241455078, z = 28.355701446533, h = 160.0, taken = false },
    { x = 354.33316040039, y = -562.06158447266, z = 28.355701446533, h = -20.0, taken = false },
    { x = 357.73266601563, y = -563.30017089844, z = 28.355701446533, h = -20.0, taken = false },
    { x = 361.12408447266, y = -564.53582763672, z = 28.355701446533, h = -20.0, taken = false },
}

local bedsTaken = {}
local injuryBasePrice = 100

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No Beds Available' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerEvent('mythic_chat:server:System', source, 'That Bed Is Taken')
            end
        end
    end

    if not foundbed then
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
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)
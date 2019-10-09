local beds = {
    { x = 331.36474609375, y = -1424.7255859375, z = 37.473350524902, h = 140.80712890625, taken = false },
    { x = 333.30783081055, y = -1426.3583984375, z = 37.473350524902, h = 140.02899169922, taken = false },
    { x = 333.82510375977, y = -1421.3458251953, z = 37.495662689209, h = 49.889408111572, taken = false },
    { x = 336.46697998047, y = -1423.595703125, z = 37.473350524902, h = 230.10862731934, taken = false },
    { x = 335.89321899414, y = -1418.8764648438, z = 37.473350524902, h = 49.832653045654, taken = false },
    { x = 338.20336914063, y = -1421.5404052734, z = 37.473350524902, h = 229.84906005859, taken = false },
    { x = 337.93078613281, y = -1416.4410400391, z = 37.473350524902, h = 49.399826049805, taken = false },
    { x = 339.90237426758, y = -1419.3892822266, z = 37.473350524902, h = 229.50271606445, taken = false },
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
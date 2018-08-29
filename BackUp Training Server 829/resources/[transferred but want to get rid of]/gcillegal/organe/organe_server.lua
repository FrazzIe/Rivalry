--=============================================================================
-- #Author: Jonathan D @ Gannon
--=============================================================================

local ORGANE_EVENT_PREFIX = 'illegal:organe:'

local Organe = {}

Organe.itemDocumentId = 34
Organe.itemOldDocumentId = 35

Organe.nbPointHopital = 5
Organe.timeBetweenMission = {7*60*60 , 9*60*60} -- 7 à 9 heures
Organe.timeNextMission = getTime()
Organe.documentVole = false

Organe.reset = function () 
    Organe.timeNextMission = getTime() + math.random(Organe.timeBetweenMission[1], Organe.timeBetweenMission[2])
    Organe.documentVole = false
    MySQL:executeQuery('INSERT INTO user_inventory (user_inventory.user_id, user_inventory.item_id, user_inventory.quantity) (SELECT ui.user_id, @OldDocumentId, ui.quantity FROM user_inventory as ui WHERE ui.item_id = @itemDocumentId) ON DUPLICATE KEY UPDATE user_inventory.quantity = user_inventory.quantity + ui.quantity', {
        ['@OldDocumentId'] = Organe.itemOldDocumentId,
        ['@itemDocumentId'] = Organe.itemDocumentId
    })
    MySQL:executeQuery('UPDATE user_inventory SET user_inventory.quantity = 0 WHERE user_inventory.item_id = @itemDocumentId', {
        ['@itemDocumentId'] = Organe.itemDocumentId
    })
end

RegisterServerEvent(ORGANE_EVENT_PREFIX .. 'checkMission')
AddEventHandler(ORGANE_EVENT_PREFIX .. 'checkMission', function ()
    TriggerClientEvent(ORGANE_EVENT_PREFIX .. 'checkMission', source, timeNextMission)
end)

RegisterServerEvent(ORGANE_EVENT_PREFIX .. 'tryVente')
AddEventHandler(ORGANE_EVENT_PREFIX .. 'tryVente', function ()
    if getTime() > Organe.timeNextMission then
        TriggerClientEvent(ORGANE_EVENT_PREFIX .. 'tryVente', source, 1)
        Organe.reset()
    else
        TriggerClientEvent(ORGANE_EVENT_PREFIX .. 'tryVente', source, 0)
    end
end)






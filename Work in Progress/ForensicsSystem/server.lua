RegisterServerEvent('playerShot')
AddEventHandler('playerShot', function(source)
    if(exports.policejob:getIsInServer(source) == true)then
    	TriggerClientEvent('markerForCops', true)
    end
end)

RegisterServerEvent('removeMarker')
AddEventHandler('removeMarker', function(source)
    if(exports.policejob:getIsInServer(source) == true)then
      TriggerClientEvent('isACop', true)
    end
end)

RegisterServerEvent('policeChecker')
AddEventHandler('policeChecker', function(source)
    if(exports.policejob:getIsInServer(source) == true)then
      TriggerClientEvent('isACop', true)
    end 
end)

Chat.Command("liftprint", function(source, args, rawCommand)
    TriggerClientEvent('liftPrint', source)
end, false, {Help = "Lift a print from a vehicle", Params = {}})
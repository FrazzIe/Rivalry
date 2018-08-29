--=============================================================================
--  Jonathan D @ Gannon
--=============================================================================

RegisterServerEvent('illegal:requestNbCop')
AddEventHandler('illegal:requestNbCop', function()
	getPoliceInService( function(nbPolicier) 
        local nbPolice = nbPolicier
	    TriggerClientEvent('illegal:setcop',source,nbPolice)
	end)
end)

function getPoliceInService(cb)
	TriggerEvent("police:getCops", function(cops)
		cb(cops or 0)
	end)
end


function getTime()
    return os.time()
end

RegisterServerEvent('illegal:showSmoke')
AddEventHandler('illegal:showSmoke', function (posX, posY, posZ)
	TriggerClientEvent('illegal:showSmoke', -1, posX, posY, posZ)
end)
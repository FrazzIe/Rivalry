	RegisterServerEvent('Fisher:Car')
	AddEventHandler('Fisher:Car', function()
		TriggerClientEvent('Fisher:getCar',source)
	end)
	
	RegisterServerEvent('Fisher:Car2')
	AddEventHandler('Fisher:Car2', function()
		TriggerClientEvent('Fisher:getCar2', source)
	end)

	RegisterServerEvent('Fisher:serverRequest')
	AddEventHandler('Fisher:serverRequest', function (typeRequest)
		local source = tonumber(source)
		TriggerEvent("inventory:getuser", source, function(inventory)
			if typeRequest == "GetPoisson" then
				local data = 0
				local data2 = 0
				local data3 = 0
				local data4 = 0
				local data5 = 0
				if inventory[21] then data = inventory[21].quantity end
				if inventory[50] then data2 = inventory[50].quantity end
				if inventory[52] then data3 = inventory[52].quantity end
				if inventory[54] then data4 = inventory[54].quantity end
				if inventory[56] then data5 = inventory[56].quantity end
				TriggerClientEvent('Fisher:drawGetPoisson', source, data, data2, data3, data4, data5)
			elseif typeRequest == "GetPoissonDeep" then
				local data = 0
				local data2 = 0
				local data3 = 0
				local data4 = 0
				local data5 = 0
				local data6 = 0
				if inventory[58] then data = inventory[58].quantity end
				if inventory[60] then data2 = inventory[60].quantity end
				if inventory[62] then data3 = inventory[62].quantity end
				if inventory[64] then data4 = inventory[64].quantity end
				if inventory[66] then data5= inventory[66].quantity end
				if inventory[68] then data6 = inventory[68].quantity end
				TriggerClientEvent('Fisher:drawGetPoissonDeep',source, data, data2, data3, data4, data5, data6)
			elseif typeRequest == "SellFilet" then
				local data = 0
				local data2 = 0
				local data3 = 0
				local data4 = 0
				local data5 = 0
				local data6 = 0
				local data7 = 0
				local data8 = 0
				local data9 = 0
				local data10 = 0
				local data11 = 0
				if inventory[21] then data = inventory[21].quantity end
				if inventory[50] then data2 = inventory[50].quantity end
				if inventory[52] then data3 = inventory[52].quantity end
				if inventory[54] then data4 = inventory[54].quantity end
				if inventory[56] then data5 = inventory[56].quantity end
				if inventory[58] then data6 = inventory[58].quantity end
				if inventory[60] then data7 = inventory[60].quantity end
				if inventory[62] then data8 = inventory[62].quantity end
				if inventory[64] then data9 = inventory[64].quantity end
				if inventory[66] then data10 = inventory[66].quantity end
				if inventory[68] then data11 = inventory[68].quantity end
				TriggerClientEvent('Fisher:drawSellFilet', source, data, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11)
			end
		end)
	end)
		
RegisterServerEvent('Fisher:setService')
AddEventHandler('Fisher:setService', function (inService)
	TriggerEvent('core:getuser', source , function (Player)
		Player.setSessionVar('FisherInService', inService)
	end)
	TriggerEvent('fish:initialise')
end)

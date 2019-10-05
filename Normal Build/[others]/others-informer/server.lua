RegisterServerEvent("informer:getweed")
AddEventHandler("informer:getweed", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 3000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
		user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "I heard it's hidden in the mountains near a freeway protected by a herd of cows." )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:dirtycoke")
AddEventHandler("informer:dirtycoke", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 5000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
			user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "I heard some shipment company is fronting the illegal cocaine trade from somewhere in the Elysian Islands. That's all I know." )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:cleancoke")
AddEventHandler("informer:cleancoke", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 5000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
			user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "I like to plant seeds in Grapeseed." )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:convertweed")
AddEventHandler("informer:convertweed", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 5000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
			user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Make a phone call." )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:sellweed")
AddEventHandler("informer:sellweed", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 5000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
			user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Umm.. try talking to other human beings you basement dweller." )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:sellweedbulk")
AddEventHandler("informer:sellweedbulk", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 10000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
			user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Near the Smoke in the Water, there's an all green building, the buyer lives in one of the apartments" )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:getmeth")
AddEventHandler("informer:getmeth", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 15000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
			user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Vehicle: Jesse and Heisenberg use one of these, you may need one and get to Grapeseed!." )
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "A Meth lab would probably be a great place to start looking for chemicals to produce Meth")
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:producemeth")
AddEventHandler("informer:producemeth", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 15000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
		user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Erm..Meth heads cook at a dock, off the Great Ocean Highway." )
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "When looking at the map, just North, west of the Chiliad Mountains")
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:sellmeth")
AddEventHandler("informer:sellmeth", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 15000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
		user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Pretty sure a good place is El Burro Heights? there is a abandon warehouse, you can't miss it!" )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:getguns")
AddEventHandler("informer:getguns", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 10000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
		user.removeWallet(price)
		TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "This might be a painful find, but somewhere in the southern part of Los Santos." )
		else
		TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
RegisterServerEvent("informer:getlaunder")
AddEventHandler("informer:getlaunder", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 4000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
		user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Try your luck at the Casino." )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)

RegisterServerEvent("informer:resthouse")
AddEventHandler("informer:resthouse", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 3000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
			user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "I heard that a house once owned by Walter White has people providing medical attention to the injured." )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)

RegisterServerEvent("informer:chopshop")
AddEventHandler("informer:chopshop", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 2000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
			user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "I heard there is a old recycling place out on Route 68! As well there is a old garage in Downtown Los Santos. Both places have been scraping cars illegaly!" )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)

RegisterServerEvent("informer:uncuff")
AddEventHandler("informer:uncuff", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 1000
		if (tonumber(user.get("wallet")) >= tonumber(price)) then
			user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "I heard there is some guy that operates at some tractor part place in sandy" )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)
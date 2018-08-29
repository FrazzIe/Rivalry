--=============================================================================
-- #Author: Jonathan D @ Gannon
--=============================================================================

--=============================================================================
--  Config
--=============================================================================
local WeedPlant = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
local passwordPreFix = {'Crunch', 'Frazzle', 'Anita', 'James', 'Johny'}
local passwords = {current="",old="",time_generated=0}
local timeGeneratePassword = 0
local timePasswordValid =  60 * 60-- 1hours
local fileName = 'illegalDataWeed.txt'

--=============================================================================
--  
--=============================================================================

function getPlayerID(source)
	return getIdentifiant(GetPlayerIdentifiers(source))
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end

function loadPassword()
    passwords = LoadResourceFile(GetCurrentResourceName(), "weeds/password.txt") or json.encode({current="Frazzle",old="Meep",time_generated=getTime()})
    passwords = json.decode(passwords)
end

function savePassword()
    SaveResourceFile(GetCurrentResourceName(), "weeds/password.txt", json.encode(passwords), -1)
end

function initWeed() 
    for i = 1, 19 do 
        WeedPlant[i] =  getTime() - math.floor(math.random(8*60))
    end
    loadPassword()
end

function generatePassword()
    local p = passwordPreFix[math.random(1,#passwordPreFix)] 
    p = p .. string.sub('00' .. math.random(10,9999), -4)
    passwords.time_generated = getTime()
    passwords.old = passwords.current
    passwords.current = p
    savePassword()
    return passwords.current
end

function getCurrentPassword()
    local t = getTime()
    if passwords.time_generated + timePasswordValid >= t then
		print("PW: " .. tostring(timeGeneratePassword) ..  " + " .. tostring(timePasswordValid) .. " time : " .. tostring(t) .. " / " .. tostring(timeGeneratePassword + timePasswordValid))
        return passwords.current
    else
        return generatePassword()
    end
	
end

initWeed()

RegisterServerEvent("informer:getpassword")
AddEventHandler("informer:getpassword", function()
	local source = tonumber(source)
	TriggerEvent('core:getuser', source, function(user)
		local price = 10000
		if (tonumber(user.getMoney()) >= tonumber(price)) then
			user.removeWallet(price)
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "I hear that the current password for the premium weed dood is "..getCurrentPassword().."" )
			local valid = (passwords.time_generated + timePasswordValid) - getTime()
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "This password will only be vaild for another "..(math.floor(valid/60)).." minutes" )
		else
			TriggerClientEvent('chatMessage', source, 'Informer ', {0, 255, 100}, "Information isn't free, get your bread up!")
		end
	end)
end)

RegisterServerEvent('illegal:requestFullPlantData')
AddEventHandler('illegal:requestFullPlantData', function ()
    TriggerClientEvent('illegal:setFullPlantData', source, WeedPlant)
end)


RegisterServerEvent('illegal:PlanteSeed')
AddEventHandler('illegal:PlanteSeed', function (id)
    if WeedPlant[id] == 0 then
        local t = getTime()
        WeedPlant[id] = t
        TriggerClientEvent('illegal:seedChange', -1 , id,t)
    end
end)


RegisterServerEvent('illegal:weedTryPassowrd')
AddEventHandler('illegal:weedTryPassowrd', function (password, qte)
	local source = source
    local pw = getCurrentPassword()
    if tostring(password) == tostring(pw) then
        TriggerEvent('core:getuser', source, function(Player)
            Player.addDirty(qte * JoinVenteFull)
            TriggerClientEvent('illegal:fullVente', source, 1 , qte) 
        end)
    elseif password == oldPassword then
        TriggerClientEvent('illegal:fullVente', source, 0 , 0)
    else
        TriggerClientEvent('illegal:fullVente', source, -1 , 0)
    end
end)

RegisterServerEvent('illegal:needPassword')
AddEventHandler('illegal:needPassword', function ()
	local t = getTime()
	local resultattime = tonumber(timeGeneratePassword + timePasswordValid - t)

    TriggerClientEvent('illegal:password', source, getCurrentPassword(), resultattime)
end)

RegisterServerEvent('illegal:recoltWeed')
AddEventHandler('illegal:recoltWeed', function (id)
    local t = WeedPlant[id]
    local d = math.floor(getTime()-t) / WeedGrowthTime
    if t ~= 0 and d >= 0.5 then
        local qte = 0 
        if d >= 1 then
            qte = 7
        elseif d >= 0.90 then
            qte = math.random(4,5)
        elseif d >= 0.80 then
            qte = math.random(3,4)
        elseif d >= 0.70 then
            qte = math.random(2,3)
        elseif d >= 0.60 then
            qte = math.random(1,3) 
        elseif d >= 0.50 then
            qte = math.random(1,2) 
        end    

        TriggerClientEvent('illegal:recoltWeed', source, qte)
        WeedPlant[id] = 0
        TriggerClientEvent('illegal:seedChange', -1 , id, 0)
    end
end)

RegisterServerEvent('illegal:completed')
AddEventHandler('illegal:completed', function(total)
    -- Get the players money amount
    local source = source
TriggerEvent('core:getuser', source, function(user)
  -- update player money amount
  user.addDirty((total))
 end)
end)

--=============================================================================
-- #Author: Jonathan D @ Gannon
--=============================================================================

--=============================================================================
--  Config
--=============================================================================

Weeds = {}

DecorRegister('illegal_lastBuyWeed', 3)

Weeds.recoltes = {
    { pos = {x = 2215.85, y = 5575.36, z = 53.69}, time = 0},
    { pos = {x = 2216.24, y = 5577.55, z = 53.78}, time = 0},
    { pos = {x = 2218.19, y = 5575.20, z = 53.70}, time = 0},
    { pos = {x = 2221.00, y = 5575.00, z = 53.71}, time = 0},
    { pos = {x = 2222.70, y = 5574.80, z = 53.73}, time = 0},
    { pos = {x = 2227.30, y = 5574.60, z = 53.79}, time = 0},
    { pos = {x = 2230.70, y = 5574.40, z = 53.90}, time = 0},
    { pos = {x = 2232.43, y = 5576.30, z = 53.97}, time = 0},
    { pos = {x = 2230.22, y = 5576.55, z = 53.93}, time = 0},
    { pos = {x = 2227.74, y = 5576.66, z = 53.86}, time = 0},
    { pos = {x = 2225.44, y = 5576.90, z = 53.85}, time = 0},
    { pos = {x = 2223.05, y = 5577.12, z = 53.83}, time = 0},
    { pos = {x = 2220.60, y = 5577.06, z = 53.83}, time = 0},
    { pos = {x = 2218.60, y = 5577.26, z = 53.85}, time = 0},
    { pos = {x = 2219.00, y = 5579.42, z = 53.89}, time = 0},
    { pos = {x = 2223.80, y = 5579.30, z = 53.91}, time = 0},
    { pos = {x = 2225.40, y = 5578.94, z = 53.88}, time = 0},
    { pos = {x = 2230.15, y = 5579.00, z = 53.97}, time = 0},
    { pos = {x = 2233.90, y = 5578.70, z = 54.11}, time = 0}

}
Weeds.tranformCoord = {x = 707.019, y =  4183.08, z = 40.7092}
Weeds.tranformRayon = 10.0
Weeds.tranformTime = 4000
Weeds.FullVenteCoord = { x = -1136.65, y = -1466.16, z = 7.69071} --{ x = -1175.94, y = -1547.63, z = 17.33}
Weeds.VenteUnityCenter = {x = -2200.0, y= -1700.0, z = 0.0}
Weeds.VenteUnityRayon = 1070.0
Weeds.passNbTry = 0
Weeds.inRayon = false

Weeds.Text = {
    NoPlant = 'No weed is planted here',
    RecolteKo = 'The weed is not ready',
    RecoltePremature = 'Premature harvest possible',
    RecolteOk = 'Ready to be harvested',
    ActionRecolte = 'Press ~INPUT_PICKUP~ to harvest ~o~~g~Cannabis',
    ActionPanter = 'Press ~INPUT_PICKUP~ to plant seeds',
    ActionInteraction = '~INPUT_PICKUP~ Interact',
    TransformEncours = 'Cannabis transformation in progress',
    TransformOk = '+1 ~o~Joints',
    NoPassword = '...',
    PasswordKo = '~r~The password was not right!',
    PasswordOld  = '~b~This password is old...',
    PasswordCorrect = "~g~I bought everything for ~g~$~w~" .. JoinVenteFull .. " ~g~a unit for a total of ",
    GoodPlaceToSell = '~o~It seems like a good location to sell joints, find clients!',
    PasswordSend = "Near ~b~the shop~w~, Somebody buys in bulk.\n~o~Password: ~r~",
    Buy2 = "~g~I'll take ~b~two ~w~ from you here's ~o~",
    Buy1 = "~b~I'll take ~b~one~w~ from you here's ~o~",
    Buy0 = "~o~Keep your shit, i don't want it",
    DejaPropo = '~dHello? Go somewhere else, i have what i need.',
    RecolteEncours = 'Harvesting in progress',
    PlantationEncours = 'Planting in progress',
}


local myPed
local myPos

Weeds.recolte = function(id)
    TriggerServerEvent('illegal:recoltWeed', id)
end


Weeds.planteSeed = function(id)
    TriggerServerEvent('illegal:PlanteSeed', id)
    --showMessageInformation(Weeds.Text.PlantationEncours, 10000)
    GcUtils.showProgressBarTimer(10000, Weeds.Text.PlantationEncours)
    PlayEmote('WORLD_HUMAN_GARDENER_PLANT', 4000)
    Citizen.Wait(10000)
end

Weeds.systemGrowth = function (id, seed, pos)
    if seed.time == 0 then
        --showMessageInformation(Weeds.Text.NoPlant)
        --GcUtils.showProgressBar(0, '~o~' .. Weeds.Text.NoPlant, 100)
        GcUtils.DrawTextIn3DWorld(pos.x, pos.y, pos.z, '~o~' .. Weeds.Text.NoPlant)
        showActionInfo(Weeds.Text.ActionPanter)
        if IsControlJustPressed(1, 38) then
            Weeds.planteSeed(id)
        end
    else
        local d = math.floor((getTime()-seed.time) / WeedGrowthTime * 10000) / 100
        if d < 50 then
            --GcUtils.showProgressBar(d/100, Weeds.Text.RecolteKo .. ' ~o~ (' .. d .. '%)', 100)
            GcUtils.DrawTextIn3DWorld(pos.x, pos.y, pos.z, Weeds.Text.RecolteKo .. ' ~o~ (' .. d .. '%)')
        else
            if d >= 100 then
                --GcUtils.showProgressBar(1, Weeds.Text.RecolteOk .. '~o~ (7)', 100)
                GcUtils.DrawTextIn3DWorld(pos.x, pos.y, pos.z,  Weeds.Text.RecolteOk .. '~o~ (7)')
            elseif d >= 90 then
                --GcUtils.showProgressBar(d/100, Weeds.Text.RecoltePremature .. '~o~ (4-5) ~w~ [' .. d .. '%]', 100)
                GcUtils.DrawTextIn3DWorld(pos.x, pos.y, pos.z, Weeds.Text.RecoltePremature .. '~o~ (4-5) ~b~ [' .. d .. '%]')
            elseif d >= 80 then
                --GcUtils.showProgressBar(d/100, Weeds.Text.RecoltePremature .. '~o~ (3-4) ~w~ [' .. d .. '%]', 100)
                GcUtils.DrawTextIn3DWorld(pos.x, pos.y, pos.z, Weeds.Text.RecoltePremature .. '~o~ (3-4) ~b~ [' .. d .. '%]')
            elseif d >= 70 then
                --GcUtils.showProgressBar(d/100, Weeds.Text.RecoltePremature .. '~o~ (2-3) ~w~ [' .. d .. '%]', 100)
                GcUtils.DrawTextIn3DWorld(pos.x, pos.y, pos.z, Weeds.Text.RecoltePremature .. '~o~ (2-3) ~b~ [' .. d .. '%]')
            elseif d >= 60 then
                --GcUtils.showProgressBar(d/100, Weeds.Text.RecoltePremature .. '~o~ (1-3) ~w~ [' .. d .. '%]', 100)
                GcUtils.DrawTextIn3DWorld(pos.x, pos.y, pos.z, Weeds.Text.RecoltePremature .. '~o~ (1-3) ~b~ [' .. d .. '%]')
            elseif d >= 50 then
                --GcUtils.showProgressBar(d/100, Weeds.Text.RecoltePremature .. '~o~ (1-2) ~w~ [' .. d .. '%]', 100)
                GcUtils.DrawTextIn3DWorld(pos.x, pos.y, pos.z, Weeds.Text.RecoltePremature .. '~o~ (1-2) ~b~ [' .. d .. '%]')
            end
            local full = exports.core_modules:isFull()
            if full then
                showMessageInformation('Inventory is full')
            else
                showActionInfo(Weeds.Text.ActionRecolte)
                if IsControlJustPressed(1, 38) then
                    Weeds.recolte(id)
                end
            end
        end
    end
end

Weeds.checkRecoltes = function ()
    local myPed = GetPlayerPed(-1)
    local myPos = GetEntityCoords(myPed)
    for id, seed in pairs(Weeds.recoltes) do 
        local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, seed.pos.x, seed.pos.y, seed.pos.z, false)
        if dist < 0.7 then
            Weeds.systemGrowth(id,seed, seed.pos)
            break
        end
    end

end

Weeds.checkTranform = function ()
    local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, Weeds.tranformCoord.x, Weeds.tranformCoord.y, Weeds.tranformCoord.z, false)
        
    if dist <= Weeds.tranformRayon then
        --Citizen.Trace('tranform' .. dist)
        if exports.core_modules:GetItemQuantity(WeedItemId) > 0 then
            GcUtils.showProgressBarTimer(Weeds.tranformTime, Weeds.Text.TransformEncours, Weeds.Text.TransformOk)
            Citizen.Wait(Weeds.tranformTime + 2000)
            TriggerEvent("inventory:removeQty", WeedItemId, 1)
            TriggerEvent("inventory:addQty", JoinItemId, 1)
        end
    end
end

Weeds.tryFullVente = function ()
    local pw = openTextInput('', 'Password', 22)
    --Citizen.Trace('pw ' .. pw )
    if pw == nil or pw == '' or pw == 'Password' then
        showActionInfo(Weeds.Text.NoPassword)
    else
        local qte = exports.core_modules:GetItemQuantity(JoinItemId)
        TriggerServerEvent('illegal:weedTryPassowrd', tostring(pw), qte)
    end
end

Weeds.checkVente = function()
    local totalItem = exports.core_modules:GetItemQuantity(JoinItemId)
    if totalItem == 0 then
        return
    end
    local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z,Weeds.FullVenteCoord.x, Weeds.FullVenteCoord.y, Weeds.FullVenteCoord.z, true)
    local dist2 = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z,Weeds.VenteUnityCenter.x, Weeds.VenteUnityCenter.y, Weeds.VenteUnityCenter.z, false)
    if dist <= 2.0 then
        showActionInfo(Weeds.Text.ActionInteraction)
        if IsControlJustPressed(1, 38) then
            Weeds.tryFullVente()
        end
    elseif dist2 <= Weeds.VenteUnityRayon then
        if Weeds.inRayon == false then
            showMessageInformation(Weeds.Text.GoodPlaceToSell, 8000)
            Weeds.inRayon = true 
        end
        if IsControlJustPressed(1, 38) then 
            --local ped = 0
            --Citizen.InvokeNative(0xC33AB876A77F8164, myPos.x, myPos.y, myPos.z, 5.0, 1,0, Citizen.PointerValueInt(ped),1,0, -1)
            --local ped = GetRandomPedAtCoord(myPos.x, myPos.y, myPos.z, 1.0, 1.0, 1.0, 26, _r)
            local ped = GetRandomPedAtCoord(myPos.x, myPos.y, myPos.z, 3.0, 3.0, 3.0, 26)
           -- local ped = GetRandomPedAtCoord(myPos.x, myPos.y, myPos.z, 3.0, 3.0, 3.0, -1)
            if ped ~= 0 then
                local lastBuy = DecorGetInt(ped, 'illegal_lastBuyWeed')
                if lastBuy == 0 or lastBuy + PNJ_TIME_SELL < getTime() then
                    local r = math.random() 
                    if r > 0.995 then -- 0.995
                       TriggerServerEvent('illegal:needPassword')
                    elseif r > 0.85 and totalItem > 2 then
                        local total = math.random(JoinVenteUnite[1], JoinVenteUnite[2])
                        TriggerEvent('inventory:removeQty',JoinItemId, 2)
                        total = total * 2
                        TriggerServerEvent('illegal:completed', total)
                        showMessageInformation(Weeds.Text.Buy2..'$'.. total*2,3000)
                    elseif r > 0.55 then
                        local total = math.random(JoinVenteUnite[1], JoinVenteUnite[2])
                        showMessageInformation(Weeds.Text.Buy1 ..'$'.. total, 3000)
                        TriggerEvent('inventory:removeQty',JoinItemId, 1)
                        TriggerServerEvent('illegal:completed', total)
                    else
                        showMessageInformation(Weeds.Text.Buy0,3000)
                    end
                    DecorSetInt(ped, 'illegal_lastBuyWeed', getTime())
                    SetPedIsDrunk(ped,true)
                else
                    showMessageInformation(Weeds.Text.DejaPropo,3000)
                end
            -- else
            --     showMessageInformation("DEBUG notfound")
            end
        end
    else
        Weeds.inRayon = false
    end
end



Weeds.drawDebug = function ()
    for _, k in pairs(Weeds.recoltes) do 
        ShowVerticalLineAtPos(k.pos) 
    end
end

Weeds.start = function ()
    TriggerServerEvent('illegal:requestFullPlantData')
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            myPed = GetPlayerPed(-1)
            myPos = GetEntityCoords(myPed)
            Weeds.checkRecoltes()
            Weeds.checkTranform()
            Weeds.checkVente()
        end
    end)
end




--=============================================================================
--  Event
--=============================================================================
RegisterNetEvent('illegal:setFullPlantData')
AddEventHandler('illegal:setFullPlantData',function(data)
    for i, t in pairs(data) do
        Weeds.recoltes[i].time = t
    end
end)

RegisterNetEvent('illegal:seedChange')
AddEventHandler('illegal:seedChange',function(id, time)
    Weeds.recoltes[id].time = time
end)

RegisterNetEvent('illegal:recoltWeed')
AddEventHandler('illegal:recoltWeed',function(qte)
    TriggerEvent('inventory:addQty',WeedItemId, qte)
   
    GcUtils.showProgressBarTimer(24000, Weeds.Text.RecolteEncours, '+ ' .. qte .. ' ~o~Cannabis')
    --showMessageInformation(Weeds.Text.RecolteEncours, 20000)
    PlayEmote('WORLD_HUMAN_GARDENER_PLANT', 20000)
    Citizen.Wait(20000 + 6000)

end)

RegisterNetEvent('illegal:fullVente')
AddEventHandler('illegal:fullVente', function( sta, qte)
    if sta == 0 then
        showMessageInformation(Weeds.Text.PasswordOld,8000)
    elseif sta == 1 then
        local total = qte * JoinVenteFull
        showMessageInformation(Weeds.Text.PasswordCorrect ..'~g~$~r~'.. total, 8000)
        TriggerEvent('inventory:removeQty',JoinItemId, qte)
    else
        showMessageInformation(Weeds.Text.PasswordKo, 8000)
        Weeds.passNbTry = Weeds.passNbTry + 1 
    end
end)


RegisterNetEvent('illegal:password')
AddEventHandler('illegal:password', function(password, exptime)
	if tonumber(exptime) < 60 then
		timeresult = tostring(exptime) 
		unite = " sec"
	elseif exptime < 120 then
		timeresult = exptime / 60
		unite = " minute"
	else
		timeresult = exptime / 60
		unite = " minutes"
	end
    showMessageInformation(Weeds.Text.PasswordSend .. password .. "~w~ Expires in ~r~" .. math.floor(timeresult) .. unite, 30000)
    Citizen.Wait(15000)
end)


--=============================================================================
--  Initialisation
--=============================================================================



--=============================================================================
--  DEBUG
--=============================================================================
-- TriggerEvent("player:receiveItem", JoinItemId, 9)
-- TriggerEvent("player:receiveItem", WeedItemId, 2)
-- -- Citizen.Trace('Time: ' .. GcUtils.getTime())
-- SetEntityCoords(GetPlayerPed(-1),-1136.65,  -1466.16, 7.69071)


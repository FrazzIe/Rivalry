--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
RegisterServerEvent("carRental:buy")
AddEventHandler("carRental:buy",function(data)
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        if (tonumber(user.get("wallet")) >= tonumber(rental_cars[data.model])) then
            user.removeWallet(tonumber(rental_cars[data.model]))
            TriggerClientEvent("carRental:bought", source, data)
        elseif (tonumber(user.get("bank")) >= tonumber(rental_cars[data.model])) then
            user.removeBank(tonumber(rental_cars[data.model]))
            TriggerClientEvent("carRental:bought", source, data)
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
        end
    end)
end)

rental_cars = {
    ["panto"] = 400,
    ["alpha"] = 500,
    ["banshee"] = 650,
    ["buffalo"] = 400,
    ["buffalo2"] = 400,
    ["baller"] = 400,
    ["cavalcade"] = 600,
    ["granger"] = 300,
    ["huntley"] = 400,
    ["landstalker"] = 1000,
    ["radi"] = 300,
    ["rocoto"] = 400,
    ["seminole"] = 300,
    ["xls"] = 500,
    --Bicycles
    ["bmx"] = 350,
    ["scorcher"] = 400,
    ["tribike3"] = 400,
    --Motocycles
    ["faggio2"] = 250,
    ["enduro"] = 700,
    ["blazer"] = 200,
}
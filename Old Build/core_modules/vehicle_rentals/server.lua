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
    --Boats
    ["dinghy"] = 5000,
    ["dinghy2"] = 5000,
    ["dinghy3"] = 5000,
    ["jetmax"] = 5000,
    ["speeder"] = 5000,
    ["speeder2"] = 5000,
    ["squalo"] = 5000,
    ["suntrap"] = 5000,
    ["tropic"] = 5000,
    ["tropic2"] = 5000,
    ["tug"] = 10000,
    ["toro"] = 15000,
    ["toro2"] = 15000,
    ["marquis"] = 20000,
    ["submersible"] = 150000,
    ["seashark"] = 2500,
    ["seashark2"] = 2500,
    ["seashark3"] = 2500,
}
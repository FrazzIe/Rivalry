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
    ["panto"] = 80,
    ["alpha"] = 900,
    ["banshee"] = 2200,
    ["buffalo"] = 200,
    ["buffalo2"] = 1000,
    ["baller"] = 1200,
    ["cavalcade"] = 600,
    ["granger"] = 300,
    ["huntley"] = 700,
    ["landstalker"] = 1000,
    ["radi"] = 100,
    ["rocoto"] = 120,
    ["seminole"] = 150,
    ["xls"] = 500,
    --Bicycles
    ["bmx"] = 50,
    ["scorcher"] = 65,
    ["tribike3"] = 85,
    --Motocycles
    ["faggio2"] = 50,
    ["enduro"] = 120,
    ["blazer"] = 200,
    --Boats
    ["dinghy"] = 350,
    ["dinghy2"] = 200,
    ["dinghy3"] = 425,
    ["dinghy4"] = 300,
    ["jetmax"] = 300,
    ["speeder"] = 370,
    ["speeder2"] = 520,
    ["squalo"] = 500,
    ["suntrap"] = 250,
    ["tropic"] = 320,
    ["tropic2"] = 400,
    ["tug"] = 100,
    ["toro"] = 1500,
    ["toro2"] = 1700,
    ["marquis"] = 2000,
    ["submersible"] = 35000,
    ["seashark"] = 550,
    ["seashark2"] = 625,
    ["seashark3"] = 700,
}

local interiors = {
  [1] = { 
    ["xo"] = 307.5690612793,
    ["yo"] = -1433.5883789063, 
    ["zo"] = 29.944669723511, 
    ["ho"] = 150.10, 
    ["xe"] = 334.98007202148, 
    ["ye"] = -1432.265625, 
    ["ze"] = 46.511947631836,
    ["he"] = 234.62, 
    ["name"] = 'Hospital Helipad'
  },
  [2] = { 
    ["xo"] = 325.26516723633, --
    ["yo"] = -598.69635009766, 
    ["zo"] = 43.291839599609, 
    ["ho"] = 150.10, 
    ["xe"] = 338.76507568359, 
    ["ye"] = -583.93139648438, 
    ["ze"] = 74.165626525879,
    ["he"] = 234.62, 
    ["name"] = 'Hospital Helipad'
  },
  [3] = { 
    ["xo"] = 1835.8286132813,
    ["yo"] = 3670.5595703125,
    ["zo"] = 34.276756286621, 
    ["ho"] = 150.10, 
    ["xe"] = 1785.2305908203, 
    ["ye"] = 3233.646484375, 
    ["ze"] = 42.517009735107,
    ["he"] = 234.62, 
    ["name"] = 'Hospital Helipad'
  },
  [4] = { 
    ["xo"] = -248.58085632324, 
    ["yo"] = 6331.0200195313, 
    ["zo"] = 32.42618560791, 
    ["ho"] = 150.10, 
    ["xe"] = -479.25231933594, 
    ["ye"] = 6010.533203125, 
    ["ze"] = 31.296033859253,
    ["he"] = 234.62, 
    ["name"] = 'Hospital Helipad'
  },
}

RegisterServerEvent("paramedic:getinteriors")
AddEventHandler("paramedic:getinteriors", function()
    TriggerClientEvent("paramedic:receivinginteriors", source, interiors)
end)
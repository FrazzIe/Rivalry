local bike_stands = {
    {name="Bike Rental", id=376, x=103.675, y=-1074.48, z=29.192},
    {name="Bike Rental", id=376, x=-899.22, y=-153.433, z=41.884},
    {name="Bike Rental", id=376, x=1034.23, y=-767.52, z=58.00},
    {name="Bike Rental", id=376, x=120.412, y=6625.959, z=31.953}
}

local bikes = {
    {name="Bmx Bike", desc="Rent a Bmx Bike.", h="bmx", price=75},
    {name="Cruiser", desc="Rent a Cruiser.", h="cruiser", price=90},
    {name="Scorcher", desc="Rent a Scorcher.", h="scorcher", price=125}
}



menuOpen = false
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Bike Stand", "~b~Bike Rentals")

function spawnBike(bike)
    local px,py,pz = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    local tbike = GetHashKey(bike)
    RequestModel(tbike)
    Citizen.Wait(100)
    nbike = CreateVehicle(tbike, px, py, pz, GetEntityHeading(PlayerPedId())+90, 1, 0)
    SetPedIntoVehicle(GetPlayerPed(-1), nbike, -1)
end

for n,i in pairs(bikes) do
    local bike = NativeUI.CreateItem(i.name,i.desc)
    mainMenu:AddItem(bike)
    bike.Activated = function(ParentMenu,SelectedItem)
        -- Add money IF statement to test if they have enough
        spawnBike(i.h)
        _menuPool:CloseAllMenus()
        --TriggerServerEvent("pay", i.price)
    end
end

_menuPool:Add(mainMenu)
_menuPool:RefreshIndex()
Citizen.CreateThread(function()
    for _, item in pairs(bike_stands) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipScale(item.blip, 0.5)
      SetBlipColour(item.blip, 24)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:ControlDisablingEnabled(false)
        _menuPool:MouseControlsEnabled(false)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(bike_stands) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 2.0001, 2.0001, 0.5001, 1555, 0, 0,165, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
                    if (menuOpen == false) then
                        showHelpText("Press ~INPUT_CONTEXT~ to rent a bicycle")
                    end
                    if IsControlJustPressed(1, 51) then
                        mainMenu:Visible(not mainMenu:Visible())
                        TriggerServerEvent("checkCash")
                    end
                else
                    _menuPool:CloseAllMenus()
                end
            end
        end
    end
end)



function showHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
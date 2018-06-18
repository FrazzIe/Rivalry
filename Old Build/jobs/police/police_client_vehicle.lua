local policeveh = {
	opened = false,
	title = "Cop Garage",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }, -- ???
	menu = {
		x = 0.11,
		y = 0.25,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "CVPI", costs = 0, description = {}, model = "cop1"},
				{name = "taures", costs = 0, description = {}, model = "cop2"},
				{name = "impala", costs = 0, description = {}, model = "cop3"},
				{name = "charger", costs = 0, description = {}, model = "cop4"},
				{name = "fpiu13", costs = 0, description = {}, model = "cop5"},
				{name = "fpiu16", costs = 0, description = {}, model = "cop6"},
				{name = "k9", costs = 0, description = {}, model = "cop7"},
				{name = "Police Transport", costs = 0, description = {}, model = "policet"},
				{name = "Police Interceptor", costs = 0, description = {}, model = "police2"},
				{name = "Cop Car", costs = 0, description = {}, model = "police4"},
				{name = "charger sheriff", costs = 0, description = {}, model = "sheriff"},
				{name = "cvpi sheriff", costs = 0, description = {}, model = "sheriff3"},
				{name = "tahoe sheriff", costs = 0, description = {}, model = "sheriff2"},
				{name = "FBI", costs = 0, description = {}, model = "fbi"},
				{name = "FBI2", costs = 0, description = {}, model = "fbi2"},
				{name = "Cop Motorcycle", costs = 0, description = {}, model = "policeb"},
				{name = "CVPI", costs = 0, description = {}, model = "pvic"},
				{name = "taures", costs = 0, description = {}, model = "ptaurus"},
				{name = "impala", costs = 0, description = {}, model = "pimpala"},
				{name = "charger", costs = 0, description = {}, model = "pcharger"},
				{name = "fpiu13", costs = 0, description = {}, model = "fpiu13"},
				{name = "fpiu16", costs = 0, description = {}, model = "fpiu16"},
				{name = "k9", costs = 0, description = {}, model = "ptahoe"},
			
			}
		},
	},
	cop1 = { x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
	cop2 = { x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
	cop3 = { x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
	cop4 = { x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
	cop5 = { x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
	cop6 = { x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
	cop7 = { x = 463.3115, y = -1019.43, z = 27.84 , h = 90.02},
	policet = { x = 436.1801, y = -996.90, z = 25.74, h = 182,05},

	pvic = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	ptaurus = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	pimpala = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	pcharger = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	pcharger = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	fpiu13 = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	fpiu16 = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	ptahoe = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	sheriff = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	sheriff2 = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	sheriff3 = { x = 1868.44, y = 3695.37, z = 33.5902 , h = 180.00},
	fbi3 = { x = 1868.44, y = 3695.37, z = 33.5902, h = 180.00},
	fbi4 = { x = 1868.44, y = 3695.37, z = 33.5902, h = 180.00},
}




local fakecar = {model = '', car = nil}
local boughtcar = false
local vehicle_price = 0

function LocalPed()
    return GetPlayerPed(-1)
end



function POLICE_SpanwVehicleCar(data)
    Citizen.Trace('POLICE_SpanwVehicleCar' .. data.model)
    --if fakecar.model ~= data.model then
        if DoesEntityExist(fakecar.car) then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
        end
        local ped = LocalPed()
        local plyCoords = GetEntityCoords(ped, 0)
        local hash = GetHashKey(data.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end
		local pos = policeveh[data.model]
		Citizen.Trace('P' .. pos.x .. '  '.. pos.y .. '  '.. pos.z .. '  '.. pos.h)
        local veh = CreateVehicle(hash,pos.x,pos.y,pos.z,pos.h,true,false)
		local plate = math.random(100, 900)
		SetVehicleNumberPlateText(veh, "LAPD"..plate.." ")
		SetVehicleMod(veh, 11, 2)
		SetVehicleMod(veh, 12, 2)
		SetVehicleMod(veh, 13, 2)
		SetVehicleEnginePowerMultiplier(veh, 20.0)
		SetVehicleExtra(veh, 1, true)
		SetVehicleExtra(veh, 2, true)
		SetVehicleExtra(veh, 3, true)
		SetVehicleExtra(veh, 4, true)
		SetVehicleExtra(veh, 5, true)
		SetVehicleExtra(veh, 6, true)
		SetVehicleExtra(veh, 7, true)
		SetVehicleExtra(veh, 8, true)
		SetVehicleExtra(veh, 9, true)
		SetVehicleExtra(veh, 10, true)
		SetVehicleExtra(veh, 11, true)
		SetVehicleExtra(veh, 12, true)
		SetVehicleLivery(veh, 3)

        --FreezeEntityPosition(veh,true)
        --SetEntityInvincible(veh,true)
        --SetVehicleDoorsLocked(veh,4)
        --SetEntityCollision(veh,false,false)
        --TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
        -- for i = 0,24 do
        --     SetVehicleModKit(veh,0)
        --     RemoveVehicleMod(veh,i)
        -- end
        fakecar = { model = data.model, car = veh}
--    -- end

end

function POLICE_BCSO(data)
    Citizen.Trace('POLICE_SpanwVehicleCar' .. data.model)
    --if fakecar.model ~= data.model then
        if DoesEntityExist(fakecar.car) then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
        end
        local ped = LocalPed()
        local plyCoords = GetEntityCoords(ped, 0)
        local hash = GetHashKey(data.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end
		local pos = policeveh[data.model]
		Citizen.Trace('P' .. pos.x .. '  '.. pos.y .. '  '.. pos.z .. '  '.. pos.h)
        local veh = CreateVehicle(hash,pos.x,pos.y,pos.z,pos.h,true,false)
		local plate = math.random(100, 900)
		SetVehicleNumberPlateText(veh, "BCSO"..plate.." ")
		SetVehicleMod(veh, 11, 2)
		SetVehicleMod(veh, 12, 2)
		SetVehicleMod(veh, 13, 2)
		SetVehicleEnginePowerMultiplier(veh, 20.0)
		SetVehicleExtra(veh, 1, false)
		SetVehicleExtra(veh, 2, false)
		SetVehicleExtra(veh, 3, false)
		SetVehicleExtra(veh, 4, false)
		SetVehicleExtra(veh, 5, false)
		SetVehicleExtra(veh, 6, false)
		SetVehicleExtra(veh, 7, false)
		SetVehicleExtra(veh, 8, false)
		SetVehicleExtra(veh, 9, false)
		SetVehicleExtra(veh, 10, false)
		SetVehicleExtra(veh, 11, false)
		SetVehicleExtra(veh, 12, false)
		SetVehicleLivery(veh, 1)

        --FreezeEntityPosition(veh,false)
        --SetEntityInvincible(veh,true)
        --SetVehicleDoorsLocked(veh,4)
        --SetEntityCollision(veh,false,false)
        --TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
        -- for i = 0,24 do
        --     SetVehicleModKit(veh,0)
        --     RemoveVehicleMod(veh,i)
        -- end
        fakecar = { model = data.model, car = veh}
--    -- end

end

function POLICE_pushBar(data)
    Citizen.Trace('POLICE_SpanwVehicleCar' .. data.model)
    --if fakecar.model ~= data.model then
        if DoesEntityExist(fakecar.car) then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
        end
        local ped = LocalPed()
        local plyCoords = GetEntityCoords(ped, 0)
        local hash = GetHashKey(data.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end
		local pos = policeveh[data.model]
		Citizen.Trace('P' .. pos.x .. '  '.. pos.y .. '  '.. pos.z .. '  '.. pos.h)
        local veh = CreateVehicle(hash,pos.x,pos.y,pos.z,pos.h,true,false)
		local plate = math.random(100, 900)
		SetVehicleNumberPlateText(veh, "LAPD"..plate.." ")
		SetVehicleMod(veh, 11, 2)
		SetVehicleMod(veh, 12, 2)
		SetVehicleMod(veh, 13, 2)
		SetVehicleEnginePowerMultiplier(veh, 20.0)
		SetVehicleExtra(veh, 1, false)
		SetVehicleExtra(veh, 2, false)
		SetVehicleExtra(veh, 3, false)
		SetVehicleExtra(veh, 4, false)
		SetVehicleExtra(veh, 5, false)
		SetVehicleExtra(veh, 6, false)
		SetVehicleExtra(veh, 7, false)
		SetVehicleExtra(veh, 8, false)
		SetVehicleExtra(veh, 9, false)
		SetVehicleExtra(veh, 10, false)
		SetVehicleExtra(veh, 11, false)
		SetVehicleExtra(veh, 12, false)
		SetVehicleLivery(veh, 3)

        --FreezeEntityPosition(veh,true)
        --SetEntityInvincible(veh,true)
        --SetVehicleDoorsLocked(veh,4)
        --SetEntityCollision(veh,false,false)
        --TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
        -- for i = 0,24 do
        --     SetVehicleModKit(veh,0)
        --     RemoveVehicleMod(veh,i)
        -- end
        fakecar = { model = data.model, car = veh}
--    -- end

end

function POLICE_pushBar2(data)
    Citizen.Trace('POLICE_SpanwVehicleCar' .. data.model)
    --if fakecar.model ~= data.model then
        if DoesEntityExist(fakecar.car) then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
        end
        local ped = LocalPed()
        local plyCoords = GetEntityCoords(ped, 0)
        local hash = GetHashKey(data.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end
		local pos = policeveh[data.model]
		Citizen.Trace('P' .. pos.x .. '  '.. pos.y .. '  '.. pos.z .. '  '.. pos.h)
        local veh = CreateVehicle(hash,pos.x,pos.y,pos.z,pos.h,true,false)
		local plate = math.random(100, 900)
		SetVehicleNumberPlateText(veh, "LAPD"..plate.." ")
		SetVehicleMod(veh, 11, 2)
		SetVehicleMod(veh, 12, 2)
		SetVehicleMod(veh, 13, 2)
		SetVehicleEnginePowerMultiplier(veh, 20.0)
		SetVehicleExtra(veh, 1, false)
		SetVehicleExtra(veh, 2, false)
		SetVehicleExtra(veh, 3, false)
		SetVehicleExtra(veh, 4, false)
		SetVehicleExtra(veh, 5, false)
		SetVehicleExtra(veh, 6, false)
		SetVehicleExtra(veh, 7, false)
		SetVehicleExtra(veh, 8, false)
		SetVehicleExtra(veh, 9, false)
		SetVehicleExtra(veh, 10, false)
		SetVehicleExtra(veh, 11, false)
		SetVehicleExtra(veh, 12, false)
		SetVehicleLivery(veh, 1)

        --FreezeEntityPosition(veh,true)
        --SetEntityInvincible(veh,true)
        --SetVehicleDoorsLocked(veh,4)
        --SetEntityCollision(veh,false,false)
        --TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
        -- for i = 0,24 do
        --     SetVehicleModKit(veh,0)
        --     RemoveVehicleMod(veh,i)
        -- end
        fakecar = { model = data.model, car = veh}
--    -- end

end

function POLICE_pushBar3(data)
    Citizen.Trace('POLICE_SpanwVehicleCar' .. data.model)
    --if fakecar.model ~= data.model then
        if DoesEntityExist(fakecar.car) then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
        end
        local ped = LocalPed()
        local plyCoords = GetEntityCoords(ped, 0)
        local hash = GetHashKey(data.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end
		local pos = policeveh[data.model]
		Citizen.Trace('P' .. pos.x .. '  '.. pos.y .. '  '.. pos.z .. '  '.. pos.h)
        local veh = CreateVehicle(hash,pos.x,pos.y,pos.z,pos.h,true,false)
		local plate = math.random(100, 900)
		SetVehicleNumberPlateText(veh, "LAPD"..plate.." ")
		SetVehicleMod(veh, 11, 2)
		SetVehicleMod(veh, 12, 2)
		SetVehicleMod(veh, 13, 2)
		SetVehicleEnginePowerMultiplier(veh, 20.0)
		SetVehicleExtra(veh, 1, false)
		SetVehicleExtra(veh, 2, false)
		SetVehicleExtra(veh, 3, false)
		SetVehicleExtra(veh, 4, false)
		SetVehicleExtra(veh, 5, false)
		SetVehicleExtra(veh, 6, false)
		SetVehicleExtra(veh, 7, false)
		SetVehicleExtra(veh, 8, false)
		SetVehicleExtra(veh, 9, false)
		SetVehicleExtra(veh, 10, false)
		SetVehicleExtra(veh, 11, false)
		SetVehicleExtra(veh, 12, false)
		SetVehicleLivery(veh, 3)

        --FreezeEntityPosition(veh,true)
        --SetEntityInvincible(veh,true)
        --SetVehicleDoorsLocked(veh,4)
        --SetEntityCollision(veh,false,false)
        --TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
        -- for i = 0,24 do
        --     SetVehicleModKit(veh,0)
        --     RemoveVehicleMod(veh,i)
        -- end
        fakecar = { model = data.model, car = veh}
--    -- end

end




RegisterNetEvent('policeveh:spawnVehicle')
AddEventHandler('policeveh:spawnVehicle', function(v)
	-- local car = GetHashKey(v)
	-- local playerPed = GetPlayerPed(-1)
	-- if playerPed and playerPed ~= -1 then
	-- 	RequestModel(car)
	-- 	while not HasModelLoaded(car) do
	-- 			Citizen.Wait(0)
	-- 	end
	-- 	local playerCoords = GetEntityCoords(playerPed)

	-- 	veh = CreateVehicle(car, playerCoords, 0.0, true, false)
	-- 	TaskWarpPedIntoVehicle(playerPed, veh, -1)
	-- 	SetEntityInvincible(veh, false)
	-- end
end)
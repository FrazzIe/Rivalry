local zones = { 
	['AIRP'] = {label = "Los Santos International Airport", gunshots = 100, vehicle = 100, drugs = 100, property_lock = 80}, -- 80% chance of being reported for firing a gun, lockpicking a vehicle, selling drugs
	['ALAMO'] = {label = "Alamo Sea", gunshots = 20, vehicle = 80, drugs = 20, property_lock = 80}, 
	['ALTA'] = {label = "Alta", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ARMYB'] = {label = "Fort Zancudo", gunshots = 100, vehicle = 100, drugs = 100, property_lock = 80}, 
	['BANHAMC'] = {label = "Banham Canyon Dr", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BANNING'] = {label = "Banning", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BEACH'] = {label = "Vespucci Beach", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BHAMCA'] = {label = "Banham Canyon", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BRADP'] = {label = "Braddock Pass", gunshots = 30, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BRADT'] = {label = "Braddock Tunnel", gunshots = 30, vehicle = 80, drugs = 50, property_lock = 80}, 
	['BURTON'] = {label = "Burton", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['CALAFB'] = {label = "Calafia Bridge", gunshots = 80, vehicle = 80, drugs = 30, property_lock = 80}, 
	['CANNY'] = {label = "Raton Canyon", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['CCREAK'] = {label = "Cassidy Creek", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['CHAMH'] = {label = "Chamberlain Hills", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['CHIL'] = {label = "Vinewood Hills", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['CHU'] = {label = "Chumash", gunshots = 80, vehicle = 80, drugs = 20, property_lock = 80}, 
	['CMSW'] = {label = "Chiliad Mountain State Wilderness", gunshots = 15, vehicle = 75, drugs = 25, property_lock = 80}, 
	['CYPRE'] = {label = "Cypress Flats", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80},
	['DAVIS'] = {label = "Davis", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['DELBE'] = {label = "Del Perro Beach", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['DELPE'] = {label = "Del Perro", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['DELSOL'] = {label = "La Puerta", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['DESRT'] = {label = "Grand Senora Desert", gunshots = 50, vehicle = 60, drugs = 20, property_lock = 80}, 
	['DOWNT'] = {label = "Downtown", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['DTVINE'] = {label = "Downtown Vinewood", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['EAST_V'] = {label = "East Vinewood", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['EBURO'] = {label = "El Burro Heights", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ELGORL'] = {label = "El Gordo Lighthouse", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ELYSIAN'] = {label = "Elysian Island", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['GALFISH'] = {label = "Galilee", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['GOLF'] = {label = "GWC and Golfing Society", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['GRAPES'] = {label = "Grapeseed", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['GREATC'] = {label = "Great Chaparral", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['HARMO'] = {label = "Harmony", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['HAWICK'] = {label = "Hawick", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['HORS'] = {label = "Vinewood Racetrack", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['HUMLAB'] = {label = "Humane Labs and Research", gunshots = 100, vehicle = 100, drugs = 100, property_lock = 80}, 
	['JAIL'] = {label = "Bolingbroke Penitentiary", gunshots = 100, vehicle = 100, drugs = 100, property_lock = 80}, 
	['KOREAT'] = {label = "Little Seoul", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LACT'] = {label = "Land Act Reservoir", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LAGO'] = {label = "Lago Zancudo", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LDAM'] = {label = "Land Act Dam", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LEGSQU'] = {label = "Legion Square", gunshots = 90, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LMESA'] = {label = "La Mesa", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['LOSPUER'] = {label = "La Puerta", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['MIRR'] = {label = "Mirror Park", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['MORN'] = {label = "Morningwood", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['MOVIE'] = {label = "Richards Majestic", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['MTCHIL'] = {label = "Mount Chiliad", gunshots = 40, vehicle = 60, drugs = 30, property_lock = 80}, 
	['MTGORDO'] = {label = "Mount Gordo", gunshots = 40, vehicle = 80, drugs = 30, property_lock = 80}, 
	['MTJOSE'] = {label = "Mount Josiah", gunshots = 40, vehicle = 80, drugs = 30, property_lock = 80}, 
	['MURRI'] = {label = "Murrieta Heights", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['NCHU'] = {label = "North Chumash", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['NOOSE'] = {label = "N.O.O.S.E", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['OCEANA'] = {label = "Pacific Ocean", gunshots = 10, vehicle = 80, drugs = 10, property_lock = 80}, 
	['PALCOV'] = {label = "Paleto Cove", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['PALETO'] = {label = "Paleto Bay", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['PALFOR'] = {label = "Paleto Forest", gunshots = 50, vehicle = 80, drugs = 30, property_lock = 80}, 
	['PALHIGH'] = {label = "Palomino Highlands", gunshots = 10, vehicle = 80, drugs = 50, property_lock = 80}, 
	['PALMPOW'] = {label = "Palmer-Taylor Power Station", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['PBLUFF'] = {label = "Pacific Bluffs", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['PBOX'] = {label = "Pillbox Hill", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['PROCOB'] = {label = "Procopio Beach", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['RANCHO'] = {label = "Rancho", gunshots = 50, vehicle = 80, drugs = 50, property_lock = 80}, 
	['RGLEN'] = {label = "Richman Glen", gunshots = 50, vehicle = 80, drugs = 60, property_lock = 80}, 
	['RICHM'] = {label = "Richman", gunshots = 50, vehicle = 80, drugs = 60, property_lock = 80}, 
	['ROCKF'] = {label = "Rockford Hills", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['RTRAK'] = {label = "Redwood Lights Track", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['SANAND'] = {label = "San Andreas", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['SANCHIA'] = {label = "San Chianski Mountain Range", gunshots = 20, vehicle = 80, drugs = 20, property_lock = 80}, 
	['SANDY'] = {label = "Sandy Shores", gunshots = 30, vehicle = 80, drugs = 50, property_lock = 80}, 
	['SKID'] = {label = "Mission Row", gunshots = 80, vehicle = 80, drugs = 90, property_lock = 80}, 
	['SLAB'] = {label = "Stab City", gunshots = 40, vehicle = 80, drugs = 30, property_lock = 80}, 
	['STAD'] = {label = "Maze Bank Arena", gunshots = 50, vehicle = 80, drugs = 80, property_lock = 80}, 
	['STRAW'] = {label = "Strawberry", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['TATAMO'] = {label = "Tataviam Mountains", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['TERMINA'] = {label = "Terminal", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['TEXTI'] = {label = "Textile City", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['TONGVAH'] = {label = "Tongva Hills", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['TONGVAV'] = {label = "Tongva Valley", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['VCANA'] = {label = "Vespucci Canals", gunshots = 30, vehicle = 80, drugs = 50, property_lock = 80}, 
	['VESP'] = {label = "Vespucci", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['VINE'] = {label = "Vinewood", gunshots = 80, vehicle = 80, drugs = 70, property_lock = 80}, 
	['WINDF'] = {label = "Ron Alternates Wind Farm", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['WVINE'] = {label = "West Vinewood", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ZANCUDO'] = {label = "Zancudo River", gunshots = 20, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ZP_ORT'] = {label = "Port of South Los Santos", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80}, 
	['ZQ_UAR'] = {label = "Davis Quartz", gunshots = 80, vehicle = 80, drugs = 50, property_lock = 80},
}

local colorNames = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steal",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "police car blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metaillic V Dark Blue",
    ['147'] = "MODSHOP BLACK1",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "DEFAULT ALLOY COLOR",
    ['157'] = "Epsilon Blue",
}

local weapons_whitelist = {
	["WEAPON_BALL"]	= 1,
	["WEAPON_PETROLCAN"] = 1,
	["WEAPON_SNOWBALL"] = 1,
	["WEAPON_STUNGUN"] = 1,
	["WEAPON_FIREEXTINGUISHER"] = 1,
}

local knifes = {
    ["WEAPON_KNIFE"] = 1,
    ["WEAPON_MACHETE"] = 1,
    ["WEAPON_DAGGER"] = 1,
    ["WEAPON_SWITCHBLADE"] = 1,
}

local ten_fifthteen_timer = 10 --Minutes --Drugs
local ten_thirtyone_timer = 10 --Minutes --Gunshots
local ten_thirtytwo_timer = 10 --Minutes --Car Lockpicking
local ten_thirtytwo_2_timer = 10 --Minutes --Property lockpicking
local ten_ninety_timer = 10

local function GetClosestPed()
    local closestPed = 0
  
    for ped in EnumeratePeds() do
        local distanceCheck = #(GetEntityCoords(PlayerPedId(), false) - GetEntityCoords(ped, false))
        if distanceCheck <= 15.0 then
            closestPed = ped
            break
        end
    end

    return closestPed
end

local function willNPCreport(type)
	local pos = GetEntityCoords(PlayerPedId(), false)
	local zone = GetNameOfZone(pos.x, pos.y, pos.z)
	local percentage = GetRandomIntInRange(0, 101)
	if not zones[zone] then
		return false
	else
		if not zones[zone][type] then
			return false
		else
			return percentage > (100 - zones[zone][type])
		end
	end
end

Citizen.CreateThread(function()
	local lastpos = vector3(0,0,0)
	while true do
		Citizen.Wait(0)
		if not exports.policejob:getIsInService() then
            local PlayerPed = PlayerPedId()
			if IsPedShooting(PlayerPed) then
				local hasWeapon, currentWeapon = GetCurrentPedWeapon(PlayerPed, 1)
				if currentWeapon ~= nil then
					local WeaponStr = Weaponhashes[tostring(currentWeapon)]
					if WeaponStr then
                        local Weaponhash = GetHashKey(WeaponStr)
						if GetAmmoInPedWeapon(PlayerPed, Weaponhash) > 0 then
							if not weapons_whitelist[WeaponStr] then
								local pos = GetEntityCoords(PlayerPed, false)
								if #(pos - lastpos) > 50 then
									if willNPCreport("gunshots") then
										lastpos = pos
										local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
										TriggerServerEvent("dispatch:ten-thirtytwo", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street))
                                        TriggerServerEvent("News:Dispatch", GetStreetNameFromHashKey(street))
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    local lastpos = vector3(0,0,0)
    while true do
        Citizen.Wait(0)
        if not exports.policejob:getIsInService() then
            local PlayerPed = PlayerPedId()
            local hasWeapon, currentWeapon = GetCurrentPedWeapon(PlayerPed, 1)
            if IsPedArmed(PlayerPed, 4) then
                if IsPedInAnyVehicle(PlayerPed, false) == false then
                    if currentWeapon ~= nil and not IsPedShooting(PlayerPed) then
                        local WeaponStr = Weaponhashes[tostring(currentWeapon)]
                        if WeaponStr then
                            local Weaponhash = GetHashKey(WeaponStr)
                            if not weapons_whitelist[WeaponStr] then
                                local pos = GetEntityCoords(PlayerPed, false)
                                if #(pos - lastpos) > 75 then
                                    local ped = GetClosestPed()
                                    local distance = #(GetEntityCoords(PlayerPed, false) - GetEntityCoords(ped, false))
                                    if distance <= 45.0 then
                                        if HasEntityClearLosToEntity(ped, PlayerPed, 17) then
                                            if GetPedType(ped) == 26 or GetPedType(ped) == 4 or GetPedType(ped) == 5 then
                                                lastpos = pos
                                                local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
                                                if IsPedMale(PlayerPed) then
                                                    local random = math.random(1,100)
                                                    if random >= 50 then
                                                        TriggerServerEvent("dispatch:ten-thirtytwo:2", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street), "Male")
                                                        TriggerServerEvent("News:Dispatch", GetStreetNameFromHashKey(street))
                                                    end
                                                else
                                                    local random = math.random(1,100)
                                                    if random >= 50 then
                                                        TriggerServerEvent("dispatch:ten-thirtytwo:2", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street), "Female")
                                                        TriggerServerEvent("News:Dispatch", GetStreetNameFromHashKey(street))
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end 
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("dispatch:ten-thirtytwo")
AddEventHandler("dispatch:ten-thirtytwo", function(coords)
	Citizen.CreateThread(function()
		local ten_thirtytwo_blip = nil
		local coords = coords
		local endTime = GetGameTimer() + ((ten_thirtytwo_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(ten_thirtytwo_blip) then
				ten_thirtytwo_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(ten_thirtytwo_blip, 458)
				SetBlipColour(ten_thirtytwo_blip, 28)
				SetBlipAsShortRange(ten_thirtytwo_blip, true)
				SetBlipScale(ten_thirtytwo_blip, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("10-31")
				EndTextCommandSetBlipName(ten_thirtytwo_blip)
			end
			if not arrived then
                coords = vector3(coords.x, coords.y, coords.z)
				if #(pos - coords) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-31")
				end
			end
		end
		RemoveBlip(ten_thirtytwo_blip)
	end)
end)

RegisterNetEvent("dispatch:ten-thirtytwo-r")
AddEventHandler("dispatch:ten-thirtytwo-r", function(coords)
    Citizen.CreateThread(function()
        local ten_thirtytwo_blip = nil
        local coords = coords
        local endTime = GetGameTimer() + ((ten_thirtytwo_timer * 60)/ 0.001)
        local arrived = false
        while endTime > GetGameTimer() and not arrived do
            Citizen.Wait(0)
            local pos = GetEntityCoords(PlayerPedId(), false)
            if not DoesBlipExist(ten_thirtytwo_blip) then
                ten_thirtytwo_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                SetBlipSprite(ten_thirtytwo_blip, 480)
                SetBlipColour(ten_thirtytwo_blip, 28)
                SetBlipAsShortRange(ten_thirtytwo_blip, true)
                SetBlipScale(ten_thirtytwo_blip, 0.85)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("10-31")
                EndTextCommandSetBlipName(ten_thirtytwo_blip)
            end
            if not arrived then
                coords = vector3(coords.x, coords.y, coords.z)
                if #(pos - coords) < 20 then
                    arrived = true
                    TriggerServerEvent("dispatch:pay", "10-31")
                end
            end
        end
        RemoveBlip(ten_thirtytwo_blip)
    end)
end)

RegisterNetEvent("dispatch:ten-thirtytwo:2")
AddEventHandler("dispatch:ten-thirtytwo:2", function(coords)
    Citizen.CreateThread(function()
        local ten_thirtytwo_blip = nil
        local coords = coords
        local endTime = GetGameTimer() + ((ten_thirtytwo_timer * 60)/ 0.001)
        local arrived = false
        while endTime > GetGameTimer() and not arrived do
            Citizen.Wait(0)
            local pos = GetEntityCoords(PlayerPedId(), false)
            if not DoesBlipExist(ten_thirtytwo_blip) then
                ten_thirtytwo_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                SetBlipSprite(ten_thirtytwo_blip, 110)
                SetBlipColour(ten_thirtytwo_blip, 28)
                SetBlipAsShortRange(ten_thirtytwo_blip, true)
                SetBlipScale(ten_thirtytwo_blip, 0.85)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("10-32")
                EndTextCommandSetBlipName(ten_thirtytwo_blip)
            end
            if not arrived then
                coords = vector3(coords.x, coords.y, coords.z)
                if #(pos - coords) < 20 then
                    arrived = true
                    TriggerServerEvent("dispatch:pay", "10-32")
                end
            end
        end
        RemoveBlip(ten_thirtytwo_blip)
    end)
end)

RegisterNetEvent("dispatch:ten-thirtytwo:3")
AddEventHandler("dispatch:ten-thirtytwo:3", function(coords)
    Citizen.CreateThread(function()
        local ten_thirtytwo_blip = nil
        local coords = coords
        local endTime = GetGameTimer() + ((ten_thirtytwo_timer * 60)/ 0.001)
        local arrived = false
        while endTime > GetGameTimer() and not arrived do
            Citizen.Wait(0)
            local pos = GetEntityCoords(PlayerPedId(), false)
            if not DoesBlipExist(ten_thirtytwo_blip) then
                ten_thirtytwo_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                SetBlipSprite(ten_thirtytwo_blip, 491)
                SetBlipColour(ten_thirtytwo_blip, 28)
                SetBlipAsShortRange(ten_thirtytwo_blip, true)
                SetBlipScale(ten_thirtytwo_blip, 0.85)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("10-31")
                EndTextCommandSetBlipName(ten_thirtytwo_blip)
            end
            if not arrived then
                coords = vector3(coords.x, coords.y, coords.z)
                if #(pos - coords) < 20 then
                    arrived = true
                    TriggerServerEvent("dispatch:pay", "10-31")
                end
            end
        end
        RemoveBlip(ten_thirtytwo_blip)
    end)
end)

PossibleVehicles = {
	""
}

local lockpick_lastpos = vector3(0,0,0)
AddEventHandler("dispatch:lockpick", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	if #(pos - lockpick_lastpos) > 25 then
		if willNPCreport("vehicle") then
			lockpick_lastpos = pos
			local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
            if DoesEntityExist(vehicle) then
    			local model = string.gsub(GetVehicleName(GetEntityModel(vehicle)), "%f[%a].", string.upper)

    			local plate =  GetVehicleNumberPlateText(vehicle)
    			local primary, secondary = GetVehicleColours(vehicle)
    			primary = colorNames[tostring(primary)] or ""
    			TriggerServerEvent("dispatch:ten-thirtyone", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street), model, plate, primary)
            end
		end
	end
end)

RegisterNetEvent("dispatch:ten-thirtyone")
AddEventHandler("dispatch:ten-thirtyone", function(coords)
	Citizen.CreateThread(function()
		local ten_thirtyone_blip = nil
		local coords = coords
		local endTime = GetGameTimer() + ((ten_thirtyone_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(ten_thirtyone_blip) then
				ten_thirtyone_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(ten_thirtyone_blip, 229)
				SetBlipColour(ten_thirtyone_blip, 28)
				SetBlipAsShortRange(ten_thirtyone_blip, true)
				SetBlipScale(ten_thirtyone_blip, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("10-31")
				EndTextCommandSetBlipName(ten_thirtyone_blip)
			end
			if not arrived then
                coords = vector3(coords.x, coords.y, coords.z)
				if #(pos - coords) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-31")
				end
			end
		end
		RemoveBlip(ten_thirtyone_blip)
	end)
end)

local drugs_lastpos = vector3(0,0,0)
AddEventHandler("dispatch:drug", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	if #(pos - drugs_lastpos) > 50 then
		if willNPCreport("drugs") then
			drugs_lastpos = pos
			local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
			local sex = IsPedMale(PlayerPedId())
			if sex then
				gender = "Male"
			else
				gender = "Female"
			end
			TriggerServerEvent("dispatch:ten-fifthteen", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street), gender)
		end
	end
end)

RegisterNetEvent("dispatch:ten-fifthteen")
AddEventHandler("dispatch:ten-fifthteen", function(coords)
	Citizen.CreateThread(function()
		local ten_fifthteen_blip = nil
		local coords = coords
		local endTime = GetGameTimer() + ((ten_fifthteen_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(ten_fifthteen_blip) then
				ten_fifthteen_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(ten_fifthteen_blip, 496)
				SetBlipColour(ten_fifthteen_blip, 28)
				SetBlipAsShortRange(ten_fifthteen_blip, true)
				SetBlipScale(ten_fifthteen_blip, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("10-31")
				EndTextCommandSetBlipName(ten_fifthteen_blip)
			end
			if not arrived then
                coords = vector3(coords.x, coords.y, coords.z)
				if #(pos - coords) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-31")
				end
			end
		end
		RemoveBlip(ten_fifthteen_blip)
	end)
end)

AddEventHandler("dispatch:lockpick_property", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	if willNPCreport("property_lock") then
		local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
		TriggerServerEvent("dispatch:ten-thirtyone_2", pos, GetStreetNameFromHashKey(street))
        TriggerServerEvent("News:Dispatch", GetStreetNameFromHashKey(street))
	end
end)

RegisterNetEvent("dispatch:ten-thirtyone_2")
AddEventHandler("dispatch:ten-thirtyone_2", function(coords)
	Citizen.CreateThread(function()
		local ten_thirtyone_2_blip = nil
		local coords = coords
		local endTime = GetGameTimer() + ((ten_thirtytwo_2_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(ten_thirtyone_2_blip) then
				ten_thirtyone_2_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(ten_thirtyone_2_blip, 459)
				SetBlipColour(ten_thirtyone_2_blip, 28)
				SetBlipAsShortRange(ten_thirtyone_2_blip, true)
				SetBlipScale(ten_thirtyone_2_blip, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("10-31")
				EndTextCommandSetBlipName(ten_thirtyone_2_blip)
			end
			if not arrived then
                coords = vector3(coords.x, coords.y, coords.z)
				if #(pos - coords) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-31")
				end
			end
		end
		RemoveBlip(ten_thirtyone_2_blip)
	end)
end)

RegisterNetEvent("dispatch:robbery")
AddEventHandler("dispatch:robbery", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
	TriggerServerEvent("dispatch:ten-ninety", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street))
    TriggerServerEvent("News:Dispatch", GetStreetNameFromHashKey(street))
end)

RegisterNetEvent("dispatch:ten-ninety")
AddEventHandler("dispatch:ten-ninety", function(coords)
	Citizen.CreateThread(function()
		local ten_ninety_blip = nil
		local coords = coords
		local endTime = GetGameTimer() + ((ten_ninety_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(ten_ninety_blip) then
				ten_ninety_blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(ten_ninety_blip, 459)
				SetBlipColour(ten_ninety_blip, 28)
				SetBlipAsShortRange(ten_ninety_blip, true)
				SetBlipScale(ten_ninety_blip, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("10-90")
				EndTextCommandSetBlipName(ten_ninety_blip)
			end
			if not arrived then
                coords = vector3(coords.x, coords.y, coords.z)
				if #(pos - coords) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-90")
				end
			end
		end
		RemoveBlip(ten_ninety_blip)
	end)
end)

RegisterNetEvent("dispatch:notify-cops")
AddEventHandler("dispatch:notify-cops", function(message)
	local pos = GetEntityCoords(PlayerPedId(), false)
	local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
	message = string.gsub(message, "STREETNAME", GetStreetNameFromHashKey(street))
	TriggerServerEvent("dispatch:notify-cops", message)
end)

RegisterNetEvent("dispatch:notify-cops31")
AddEventHandler("dispatch:notify-cops31", function(message)
	local pos = GetEntityCoords(PlayerPedId(), false)
	local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
	message = string.gsub(message, "STREETNAME", GetStreetNameFromHashKey(street))
	vehicle = string.gsub(vehicle, "VEHICLE MODEL", GetVehiclePedIsUsing(PlayerPedId()))
	plate = string.gsub(plate, "VEHICLE PLATE", GetVehicleNumberPlateText(vehicle))
	TriggerServerEVent("dispatch:notify-cops31", message, vehicle, plate)
end)

local user_call_311_timer = 10
local user_call_911_timer = 10

RegisterNetEvent("dispatch:311")
AddEventHandler("dispatch:311", function(id, message)
	Citizen.CreateThread(function()
		local user_call_311 = nil
		local id = GetPlayerPed(GetPlayerFromServerId(id))
		local coords = GetEntityCoords(id, false)
		local endTime = GetGameTimer() + ((user_call_311_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(user_call_311) then
				user_call_311 = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(user_call_311, 459)
				SetBlipColour(user_call_311, 28)
				SetBlipAsShortRange(user_call_311, true)
				SetBlipScale(user_call_311, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("311 Call")
				EndTextCommandSetBlipName(user_call_311)
			end
			if not arrived then
                coords = vector3(coords.x, coords.y, coords.z)
				if #(pos - coords) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "311")
				end
			end
		end
		RemoveBlip(user_call_311)
	end)
end)

RegisterNetEvent("dispatch:911")
AddEventHandler("dispatch:911", function(id, message)
	Citizen.CreateThread(function()
		local user_call_911 = nil
		local id = GetPlayerPed(GetPlayerFromServerId(id))
		local coords = GetEntityCoords(id, false)
		local endTime = GetGameTimer() + ((user_call_911_timer * 60)/ 0.001)
		local arrived = false
		while endTime > GetGameTimer() and not arrived do
			Citizen.Wait(0)
			local pos = GetEntityCoords(PlayerPedId(), false)
			if not DoesBlipExist(user_call_911) then
				user_call_911 = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(user_call_911, 459)
				SetBlipColour(user_call_911, 28)
				SetBlipAsShortRange(user_call_911, true)
				SetBlipScale(user_call_911, 0.85)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("911 Call")
				EndTextCommandSetBlipName(user_call_911)
			end
			if not arrived then
                coords = vector3(coords.x, coords.y, coords.z)
				if #(pos - coords) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "911")
				end
			end
		end
		RemoveBlip(user_call_911)
	end)
end)

RegisterNetEvent("trigger:animation")
AddEventHandler("trigger:animation", function()
    if not IsPedInAnyVehicle(PlayerPedId(), 0) then
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)
        Citizen.Wait(5000)
        ClearPedTasks(PlayerPedId())
    end
end)
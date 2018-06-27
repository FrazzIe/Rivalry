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

RegisterNetEvent('phonecheck')
AddEventHandler('phonecheck', function()
	local bool = exports["phone"]:PlayerHasPhone()
	TriggerServerEvent('phone:has_phone', bool)
end)

local weapons_whitelist = {
	["WEAPON_BALL"]	= 1,
	["WEAPON_PETROLCAN"] = 1,
	["WEAPON_SNOWBALL"] = 1,
}

local ten_fifthteen_timer = 10 --Minutes --Drugs
local ten_thirtyone_timer = 10 --Minutes --Gunshots
local ten_thirtytwo_timer = 10 --Minutes --Car Lockpicking
local ten_thirtytwo_2_timer = 10 --Minutes --Property lockpicking
local ten_ninety_timer = 10

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

RegisterNetEvent("trigger:animation")
AddEventHandler("trigger:animation", function()
	 TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 8.0, -1 , -1 , 0, false, true, true)
     Wait(7000)
     ClearPedTasks(PlayerPedId())
end)

ten_thirteen_pressed = false
AddEventHandler("dispatch:ten-thirteen", function(_source)
	ten_thirteen_pressed = true
	local pos = GetEntityCoords(PlayerPedId(), false)
	local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
	TriggerServerEvent("dispatch:ten-thirteen", GetStreetNameFromHashKey(street))
end)

RegisterNetEvent("dispatch:add_ten-thirteen")
AddEventHandler("dispatch:add_ten-thirteen", function(_source)
	if PlayerId ~= GetPlayerFromServerId(_source) then
		Citizen.CreateThread(function()
			local player_id = GetPlayerFromServerId(_source)
			local officer_down = true
			local player_blip = nil
			while officer_down do
				Citizen.Wait(0)
				if NetworkIsPlayerActive(player_id) then
					if DoesEntityExist(GetPlayerPed(player_id)) then
						if IsEntityDead(GetPlayerPed(player_id)) then
							if not DoesBlipExist(player_blip) then
								player_blip = AddBlipForEntity(GetPlayerPed(player_id))
								SetBlipSprite(player_blip, 1)
								SetBlipColour(player_blip, 1)
								SetBlipAsShortRange(player_blip, true)
								SetBlipScale(player_blip, 0.85)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("10-13")
								EndTextCommandSetBlipName(player_blip)
							end
						else
							officer_down = false
							RemoveBlip(player_blip)
						end
					else
						officer_down = false
						RemoveBlip(player_blip)
					end
				else
					officer_down = false
					RemoveBlip(player_blip)
				end
			end
		end)
	end
end)

Citizen.CreateThread(function()
	local lastpos = {x = 0.0, y = 0.0, z = 0.0}
	while true do
		Citizen.Wait(0)
		if not exports.policejob:getIsInService() then
			if IsPedShooting(PlayerPedId()) then
				local hasWeapon, currentWeapon = GetCurrentPedWeapon(PlayerPedId(), 1)
				if currentWeapon ~= nil then
					if GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(Weaponhashes[tostring(currentWeapon)])) > 0 then
						if not weapons_whitelist[Weaponhashes[tostring(currentWeapon)]] then
							local pos = GetEntityCoords(PlayerPedId(), false)
							if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, lastpos.x, lastpos.y, lastpos.z, true) > 50 then
								if willNPCreport("gunshots") then
									lastpos = pos
									local pos = GetEntityCoords(PlayerPedId(), false)
									local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
									TriggerServerEvent("dispatch:ten-thirtytwo", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street))
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
				AddTextComponentString("10-32")
				EndTextCommandSetBlipName(ten_thirtytwo_blip)
			end
			if not arrived then
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-32")
				end
			end
		end
		RemoveBlip(ten_thirtytwo_blip)
	end)
end)

PossibleVehicles = {
	""
}

local lockpick_lastpos = {x = 0.0, y = 0.0, z = 0.0}
AddEventHandler("dispatch:lockpick", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, lockpick_lastpos.x, lockpick_lastpos.y, lockpick_lastpos.z, true) > 25 then
		if willNPCreport("vehicle") then
			lockpick_lastpos = pos
			local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
			local plate =  GetVehicleNumberPlateText(vehicle)
			TriggerServerEvent("dispatch:ten-thirtyone", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street), model, plate)
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
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-31")
				end
			end
		end
		RemoveBlip(ten_thirtyone_blip)
	end)
end)

local drugs_lastpos = {x = 0.0, y = 0.0, z = 0.0}
AddEventHandler("dispatch:drug", function()
	local pos = GetEntityCoords(PlayerPedId(), false)
	if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, drugs_lastpos.x, drugs_lastpos.y, drugs_lastpos.z, true) > 50 then
		if willNPCreport("drugs") then
			drugs_lastpos = pos
			local street, crossing = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
			local sex = IsPedMale(PlayerPedId())
			if sex then
				gender = "Male"
			elseif not sex then
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
				AddTextComponentString("10-15")
				EndTextCommandSetBlipName(ten_fifthteen_blip)
			end
			if not arrived then
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
					arrived = true
					TriggerServerEvent("dispatch:pay", "10-15")
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
		TriggerServerEvent("dispatch:ten-thirtyone_2", {x = pos.x, y = pos.y, z = pos.z}, GetStreetNameFromHashKey(street))
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
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
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
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
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
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
				arrived = true
				TriggerServerEvent("dispatch:pay", "311")
			end
		end
	end
	RemoveBlip(user_call_311)
end)

RegisterNetEvent("dispatch:911")
AddEventHandler("dispatch:911", function(id, message)
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
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true) < 20 then
				arrived = true
				TriggerServerEvent("dispatch:pay", "911")
			end
		end
	end
	RemoveBlip(user_call_911)
end)
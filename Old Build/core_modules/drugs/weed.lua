local drug_zones = { 
	['AIRP'] = {label = "Los Santos International Airport", chance = 50}, -- 80% chance of success for selling drugs to a civ
	['ALAMO'] = {label = "Alamo Sea", chance = 50}, 
	['ALTA'] = {label = "Alta", chance = 50}, 
	['ARMYB'] = {label = "Fort Zancudo", chance = 0}, 
	['BANHAMC'] = {label = "Banham Canyon Dr", chance = 50}, 
	['BANNING'] = {label = "Banning", chance = 50}, 
	['BEACH'] = {label = "Vespucci Beach", chance = 70}, 
	['BHAMCA'] = {label = "Banham Canyon", chance = 50}, 
	['BRADP'] = {label = "Braddock Pass", chance = 50}, 
	['BRADT'] = {label = "Braddock Tunnel", chance = 50}, 
	['BURTON'] = {label = "Burton", chance = 50}, 
	['CALAFB'] = {label = "Calafia Bridge", chance = 50}, 
	['CANNY'] = {label = "Raton Canyon", chance = 50}, 
	['CCREAK'] = {label = "Cassidy Creek", chance = 50}, 
	['CHAMH'] = {label = "Chamberlain Hills", chance = 50}, 
	['CHIL'] = {label = "Vinewood Hills", chance = 50}, 
	['CHU'] = {label = "Chumash", chance = 50}, 
	['CMSW'] = {label = "Chiliad Mountain State Wilderness", chance = 70}, 
	['CYPRE'] = {label = "Cypress Flats", chance = 50},
	['DAVIS'] = {label = "Davis", chance = 70}, 
	['DELBE'] = {label = "Del Perro Beach", chance = 70}, 
	['DELPE'] = {label = "Del Perro", chance = 50}, 
	['DELSOL'] = {label = "La Puerta", chance = 50}, 
	['DESRT'] = {label = "Grand Senora Desert", chance = 50}, 
	['DOWNT'] = {label = "Downtown", chance = 50}, 
	['DTVINE'] = {label = "Downtown Vinewood", chance = 50}, 
	['EAST_V'] = {label = "East Vinewood", chance = 50}, 
	['EBURO'] = {label = "El Burro Heights", chance = 50}, 
	['ELGORL'] = {label = "El Gordo Lighthouse", chance = 50}, 
	['ELYSIAN'] = {label = "Elysian Island", chance = 50}, 
	['GALFISH'] = {label = "Galilee", chance = 50}, 
	['GOLF'] = {label = "GWC and Golfing Society", chance = 50}, 
	['GRAPES'] = {label = "Grapeseed", chance = 70}, 
	['GREATC'] = {label = "Great Chaparral", chance = 50}, 
	['HARMO'] = {label = "Harmony", chance = 50}, 
	['HAWICK'] = {label = "Hawick", chance = 50}, 
	['HORS'] = {label = "Vinewood Racetrack", chance = 50}, 
	['HUMLAB'] = {label = "Humane Labs and Research", chance = 0}, 
	['JAIL'] = {label = "Bolingbroke Penitentiary", chance = 0}, 
	['KOREAT'] = {label = "Little Seoul", chance = 70}, 
	['LACT'] = {label = "Land Act Reservoir", chance = 50}, 
	['LAGO'] = {label = "Lago Zancudo", chance = 50}, 
	['LDAM'] = {label = "Land Act Dam", chance = 50}, 
	['LEGSQU'] = {label = "Legion Square", chance = 50}, 
	['LMESA'] = {label = "La Mesa", chance = 50}, 
	['LOSPUER'] = {label = "La Puerta", chance = 50}, 
	['MIRR'] = {label = "Mirror Park", chance = 70}, 
	['MORN'] = {label = "Morningwood", chance = 50}, 
	['MOVIE'] = {label = "Richards Majestic", chance = 50}, 
	['MTCHIL'] = {label = "Mount Chiliad", chance = 70}, 
	['MTGORDO'] = {label = "Mount Gordo", chance = 70}, 
	['MTJOSE'] = {label = "Mount Josiah", chance = 70}, 
	['MURRI'] = {label = "Murrieta Heights", chance = 70}, 
	['NCHU'] = {label = "North Chumash", chance = 50}, 
	['NOOSE'] = {label = "N.O.O.S.E", chance = 0}, 
	['OCEANA'] = {label = "Pacific Ocean", chance = 50}, 
	['PALCOV'] = {label = "Paleto Cove", chance = 50}, 
	['PALETO'] = {label = "Paleto Bay", chance = 50}, 
	['PALFOR'] = {label = "Paleto Forest", chance = 50}, 
	['PALHIGH'] = {label = "Palomino Highlands", chance = 50}, 
	['PALMPOW'] = {label = "Palmer-Taylor Power Station", chance = 50}, 
	['PBLUFF'] = {label = "Pacific Bluffs", chance = 50}, 
	['PBOX'] = {label = "Pillbox Hill", chance = 50}, 
	['PROCOB'] = {label = "Procopio Beach", chance = 50}, 
	['RANCHO'] = {label = "Rancho", chance = 70}, 
	['RGLEN'] = {label = "Richman Glen", chance = 50}, 
	['RICHM'] = {label = "Richman", chance = 50}, 
	['ROCKF'] = {label = "Rockford Hills", chance = 50}, 
	['RTRAK'] = {label = "Redwood Lights Track", chance = 50}, 
	['SANAND'] = {label = "San Andreas", chance = 50}, 
	['SANCHIA'] = {label = "San Chianski Mountain Range", chance = 50}, 
	['SANDY'] = {label = "Sandy Shores", chance = 50}, 
	['SKID'] = {label = "Mission Row", chance = 50}, 
	['SLAB'] = {label = "Stab City", chance = 70}, 
	['STAD'] = {label = "Maze Bank Arena", chance = 50}, 
	['STRAW'] = {label = "Strawberry", chance = 70}, 
	['TATAMO'] = {label = "Tataviam Mountains", chance = 50}, 
	['TERMINA'] = {label = "Terminal", chance = 50}, 
	['TEXTI'] = {label = "Textile City", chance = 50}, 
	['TONGVAH'] = {label = "Tongva Hills", chance = 50}, 
	['TONGVAV'] = {label = "Tongva Valley", chance = 50}, 
	['VCANA'] = {label = "Vespucci Canals", chance = 50}, 
	['VESP'] = {label = "Vespucci", chance = 50}, 
	['VINE'] = {label = "Vinewood", chance = 50}, 
	['WINDF'] = {label = "Ron Alternates Wind Farm", chance = 70}, 
	['WVINE'] = {label = "West Vinewood", chance = 50}, 
	['ZANCUDO'] = {label = "Zancudo River", chance = 50}, 
	['ZP_ORT'] = {label = "Port of South Los Santos", chance = 50}, 
	['ZQ_UAR'] = {label = "Davis Quartz", chance = 50},
}
local joint_id, weed_id = 8, 4
local weed_pay = {
    min = 300,
    max = 400,
}
local weed_plants = {
    [1] = {x = 2215.85, y = 5575.36, z = 53.69, start_time = 0, end_time = 0},
    [2] = {x = 2216.24, y = 5577.55, z = 53.78, start_time = 0, end_time = 0},
    [3] = {x = 2218.19, y = 5575.20, z = 53.70, start_time = 0, end_time = 0},
    [4] = {x = 2221.00, y = 5575.00, z = 53.71, start_time = 0, end_time = 0},
    [5] = {x = 2222.70, y = 5574.80, z = 53.73, start_time = 0, end_time = 0},
    [6] = {x = 2227.30, y = 5574.60, z = 53.79, start_time = 0, end_time = 0},
    [7] = {x = 2230.70, y = 5574.40, z = 53.90, start_time = 0, end_time = 0},
    [8] = {x = 2232.43, y = 5576.30, z = 53.97, start_time = 0, end_time = 0},
    [9] = {x = 2230.22, y = 5576.55, z = 53.93, start_time = 0, end_time = 0},
    [10] = {x = 2227.74, y = 5576.66, z = 53.86, start_time = 0, end_time = 0},
    [11] = {x = 2225.44, y = 5576.90, z = 53.85, start_time = 0, end_time = 0},
    [12] = {x = 2223.05, y = 5577.12, z = 53.83, start_time = 0, end_time = 0},
    [13] = {x = 2220.60, y = 5577.06, z = 53.83, start_time = 0, end_time = 0},
    [14] = {x = 2218.60, y = 5577.26, z = 53.85, start_time = 0, end_time = 0},
    [15] = {x = 2219.00, y = 5579.42, z = 53.89, start_time = 0, end_time = 0},
    [16] = {x = 2223.80, y = 5579.30, z = 53.91, start_time = 0, end_time = 0},
    [17] = {x = 2225.40, y = 5578.94, z = 53.88, start_time = 0, end_time = 0},
    [18] = {x = 2230.15, y = 5579.00, z = 53.97, start_time = 0, end_time = 0},
    [19] = {x = 2233.90, y = 5578.70, z = 54.11, start_time = 0, end_time = 0},
}

local traders = {
	[1] = {
        model = "g_m_y_lost_03", --Sandy
		coordinates = {
			trader = {x = 966.1474609375, y = -1620.4439697266, z = 30.110685348511, h = 264.15948486328},
			marker = {x = 967.06030273438, y = -1620.4417724609, z = 30.110685348511, h = 264.35244750977},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
    [2] = {
   		model = "a_m_y_beach_02", --Beach
		coordinates = {
			trader = {x = -1162.34765625, y = -1566.4310302734, z = 4.4249238967896, h = 302.57464599609},
			marker = {x = -1161.7086181641, y = -1565.9797363281, z = 4.4265594482422, h = 304.82141113281},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
    [3] = {
   		model = "a_m_y_beach_02", --Beach
		coordinates = {
			trader = {x = -1822.6064453125, y = -1203.9437255859, z = 19.164642333984, h = 335.11407470703},
			marker = {x = -1822.6064453125, y = -1203.9437255859, z = 19.164642333984, h = 335.11407470703},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
    [4] = {
   		model = "a_m_y_beach_02", --Beach
		coordinates = {
			trader = {x = -1629.0004882813, y = -1029.5299072266, z = 5.9618558883667, h = 129.71435546875},
			marker = {x = -1629.7355957031, y = -1030.3135986328, z = 5.9027328491211, h = 141.95785522461},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
    [5] = {
   		model = "a_m_y_beach_02", --Beach
		coordinates = {
			trader = {x = -1889.751953125, y = -591.72735595703, z = 18.331005096436, h = 141.96781921387},
			marker = {x = -1890.3259277344, y = -592.46343994141, z = 18.331005096436, h = 139.14726257324},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
    [6] = {
   		model = "g_m_y_lost_03", --Sandy
		coordinates = {
			trader = {x = 1790.7663574219, y = 3895.560546875, z = 34.389263153076, h = 94.902809143066},
			marker = {x = 1789.869140625, y = 3895.3481445313, z = 34.389263153076, h = 108.38442993164},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
    [7] = {
   		model = "g_m_y_lost_03", --Sandy Shores
		coordinates = {
			trader = {x = 1414.744140625, y = 3823.8518066406, z = 32.009101867676, h = 160.28286743164},
			marker = {x = 1414.4262695313, y = 3822.8994140625, z = 32.047939300537, h = 160.88723754883},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},    
  	[8] = {
   		model = "g_m_y_lost_03", --Franklin's House
		coordinates = {
			trader = {x = -11.311979293823, y = -1430.8831787109, z = 31.10146522522, h = 175.85705566406},
			marker = {x = -11.271890640259, y = -1432.0723876953, z = 31.116764068604, h = 182.2947845459},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
  	[9] = {
   		model = "g_m_y_lost_03", --Grove Street
		coordinates = {
			trader = {x = 71.604370117188, y = -1974.7972412109, z = 20.860677719116, h = 333.85516357422},
			marker = {x = 72.142684936523, y = -1974.1370849609, z = 20.821695327759, h = 320.23635864258},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
  	[10] = {
   		model = "g_m_y_lost_03", --By Orchardville Ave and El Rancho Blvd
		coordinates = {
			trader = {x = 843.07501220703, y = -2185.8581542969, z = 30.308256149292, h = 264.65069580078},
			marker = {x = 844.01770019531, y = -2185.9035644531, z = 30.308437347412, h = 267.88580322266},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
  	[11] = {
   		model = "g_m_y_lost_03", --Vinewood, Behind Tequi-La-La's
		coordinates = {
			trader = {x = -565.30908203125, y = 302.17816162109, z = 83.150939941406, h = 259.66613769531},
			marker = {x = -564.109375, y = 302.22872924805, z = 83.159049987793, h = 273.30770874023},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
  	[12] = {
   		model = "g_m_y_lost_01", --Lost Hideout
		coordinates = {
			trader = {x = 975.49450683594, y = -97.277130126953, z = 74.84642791748, h = 290.23361206055},
			marker = {x = 976.61743164063, y = -96.703575134277, z = 74.845603942871, h = 308.88668823242},
		}, 
		rate = GetRandomIntInRange(40, 101),
		id = 0,
	},
}

local trader_timer = 10 --Minutes

local sell_cooldown = -1

DecorRegister("isTrader", 2)
DecorRegister("soldTo", 2)

local function willNPCbuy()
	local pos = GetEntityCoords(PlayerPedId(), false)
	local zone = GetNameOfZone(pos.x, pos.y, pos.z)
	local percentage = GetRandomIntInRange(0, 101)
	if not drug_zones[zone] then
		return false
	else
		return percentage > (100 - drug_zones[zone]["chance"])
	end
end

local function CalculateGrowth(current_time, plant_start, plant_end)
	local total_seconds = plant_end - plant_start
	local elapsed_seconds = current_time - plant_start
	if math.floor((elapsed_seconds/total_seconds) * 100) > 100 then
		return 100
	else
		return math.floor((elapsed_seconds/total_seconds) * 100)
	end
end

local function GetGrowthInformation(current_growth)
	if current_growth >= 100 then
		return "Ready", 5
	elseif current_growth >= 80 then
		return "Flowering", 3
	elseif current_growth >= 70 then
		return "Vegetative", 2
	elseif current_growth >= 50 then
		return "Germination", 1
	elseif current_growth >= 30 then
		return "Seedling", 0
	else
		return "Seed", 0
	end
end

local function CreateTrader(_id, _model, _x, _y, _z, _h)
	local model = GetHashKey(_model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	local trader_ped = CreatePed(4, model, _x, _y, _z, _h, true, false)
	AddArmourToPed(trader_ped, 100)
	SetPedAlertness(trader_ped, 0)
	SetPedAccuracy(trader_ped, 100)
	SetPedCanSwitchWeapon(trader_ped, true)
	SetEntityHealth(trader_ped,  200)
	SetPedFleeAttributes(trader_ped, 0, 0)
	SetPedCombatAttributes(trader_ped, 1, true)
	SetPedCombatAttributes(trader_ped, 2, true)
	SetPedCombatAbility(trader_ped,  2)
	SetPedCombatRange(trader_ped, 1)
	SetPedPathAvoidFire(trader_ped,  1)
	SetPedPathPreferToAvoidWater(trader_ped, 1)
	GiveWeaponToPed(trader_ped, GetHashKey("WEAPON_SMG"), 5000, true, true)
	SetPedDropsWeaponsWhenDead(trader_ped, false)
	SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(trader_ped), true)
	SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(trader_ped), true)
	traders[_id].id = PedToNet(trader_ped)
	DecorSetBool(trader_ped, "isTrader", true)
	TriggerServerEvent("weed:trader", _id, NetworkGetNetworkIdFromEntity(trader_ped))
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if(sell_cooldown > 0)then
			sell_cooldown = sell_cooldown - 1
		end
	end
end)

Citizen.CreateThread(function()
	RequestAnimDict("mp_common")
	while not HasAnimDictLoaded("mp_common") do
		Citizen.Wait(0)
	end
	while true do
		Citizen.Wait(0)
		if GetItemQuantity(joint_id) > 0 then
			for ped in EnumeratePeds() do
				if DoesEntityExist(ped) then
					if not IsEntityDead(ped) then
						if not IsPedAPlayer(ped) and not DecorGetBool(ped, "isTrader") and not DecorGetBool(ped, "soldTo") and not IsPedAnAnimal(GetEntityModel(ped)) then
							if Vdist2(GetEntityCoords(PlayerPedId(), false), GetEntityCoords(ped, false)) < 1 then
								if sell_cooldown > 0 then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to sell a joint! ["..sell_cooldown.."]")
								else
									DisplayHelpText("Press ~INPUT_CONTEXT~ to sell a joint!")
									if IsControlJustPressed(1, 51) then
										sell_cooldown = 10
										DecorSetBool(ped, "soldTo", true)
										if willNPCbuy() then

											local methbag_model = GetHashKey("prop_meth_bag_01")
											
											RequestModel(methbag_model)

											while not HasModelLoaded(methbag_model) do
												Citizen.Wait(250)
											end

											SetEntityHeading(ped, GetEntityHeading(PlayerPedId()) - 180)

											local methbag = CreateObject(methbag_model, 0.01, 0, 0, 1, 0, 0)

											AttachEntityToEntity(methbag, PlayerPedId(), GetPedBoneIndex(GetPlayerPed(-1), 64096), 0.0, 0.0, 0.020, 90.0, -10.0, -130.0 ,true, true, false, true, 1, true)

											TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)

	                    					TaskPlayAnim(ped, "mp_common", "givetake1_b", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)

	                    					Citizen.Wait(500)

	                    					DestroyObject(methbag)

											local amount = GetRandomIntInRange(1, 8)

											if GetItemQuantity(joint_id) >= amount then
												removeQty(joint_id, amount)
												local pay = GetRandomIntInRange(weed_pay.min, weed_pay.max+1) * amount
												local money_type = GetRandomIntInRange(1, 3)
												if getCops() <= 0 then pay = pay/2 end
												Notify("You sold "..amount.." joint(s) for <span style='color:lime'>$</span><span style='color:white'>"..math.floor(pay).."</span>")
												TriggerServerEvent("weed:sell", math.floor(pay), money_type)
											else
												removeQty(joint_id, 1)
												local pay = GetRandomIntInRange(weed_pay.min, weed_pay.max+1)
												local money_type = GetRandomIntInRange(1, 3)
												if getCops() <= 0 then pay = pay/2 end
												Notify("You sold "..amount.." joint(s) for <span style='color:lime'>$</span><span style='color:white'>"..math.floor(pay).."</span>")
												TriggerServerEvent("weed:sell", math.floor(pay), money_type)
											end

											PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
										else
											TaskReactAndFleePed(ped, PlayerPedId())
											PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
											TriggerEvent("dispatch:drug")
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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId(), false)
		for k,v in pairs(weed_plants) do
			if Vdist2(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1 then
				local growth = CalculateGrowth(GetCurrentServerTime(), v.start_time, v.end_time)
				local message, amount = GetGrowthInformation(growth)
				Draw3DText(v.x, v.y, v.z, growth.."%")
				Draw3DText(v.x, v.y, v.z-0.1, message.." ["..amount.."]")
				if IsControlJustPressed(1, 51) then
					if growth >= 50 then
						TriggerServerEvent("weed:harvest", k)
						IsStanceAllowed = false
						TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, false);
						Citizen.Wait(4000)
						ClearPedTasks(PlayerPedId())
						IsStanceAllowed = true
					end
				end
			end
		end
	end
end)

--gather = same
--transfer = phone thing, Helix Trading Inc.
--lets you only transfer some each time

RegisterNetEvent("weed:sync")
AddEventHandler("weed:sync", function(_plants, _traders)
	for i = 1, #_plants do
		weed_plants[i].start_time = _plants[i].start_time
		weed_plants[i].end_time = _plants[i].end_time
	end
	for i = 1, #_traders do
		traders[i].id = _traders[i]
	end
end)

local trading, trader_blip = false, nil
AddEventHandler("weed:setuptrader", function()
	if not trading then
		Citizen.CreateThread(function()
			local trader_id = GetRandomIntInRange(1, #traders+1)
			local existingPed = NetToPed(traders[trader_id].id)
			if not DoesEntityExist(existingPed) and existingPed == 0 and traders[trader_id].id == 0 then
				CreateTrader(trader_id, traders[trader_id].model, traders[trader_id].coordinates.trader.x, traders[trader_id].coordinates.trader.y, traders[trader_id].coordinates.trader.z, traders[trader_id].coordinates.trader.h)
			elseif DoesEntityExist(existingPed) and existingPed ~= 0 and traders[trader_id].id ~= 0 and IsEntityDead(existingPed) then
				CreateTrader(trader_id, traders[trader_id].model, traders[trader_id].coordinates.trader.x, traders[trader_id].coordinates.trader.y, traders[trader_id].coordinates.trader.z, traders[trader_id].coordinates.trader.h)
			elseif DoesEntityExist(existingPed) and existingPed == 0 and traders[trader_id].id ~= 0 and IsEntityDead(existingPed) then
				DeletePed(existingPed)
				DeleteEntity(existingPed)
				CreateTrader(trader_id, traders[trader_id].model, traders[trader_id].coordinates.trader.x, traders[trader_id].coordinates.trader.y, traders[trader_id].coordinates.trader.z, traders[trader_id].coordinates.trader.h)
			elseif not DoesEntityExist(existingPed) and existingPed ~= 0 and traders[trader_id].id ~= 0 then
				CreateTrader(trader_id, traders[trader_id].model, traders[trader_id].coordinates.trader.x, traders[trader_id].coordinates.trader.y, traders[trader_id].coordinates.trader.z, traders[trader_id].coordinates.trader.h)
			end
			local startTime = GetGameTimer()
			local endTime = startTime + (trader_timer * 60000)
			trading = true
			trader_blip = nil
			while endTime > GetGameTimer() and trading do
				Citizen.Wait(0)
				if not DoesBlipExist(trader_blip) then
					trader_blip = AddBlipForCoord(traders[trader_id].coordinates.marker.x, traders[trader_id].coordinates.marker.y, traders[trader_id].coordinates.marker.z)
					SetBlipSprite(trader_blip, 1)
					SetBlipColour(trader_blip, 60)
					SetBlipAsShortRange(trader_blip, true)
					SetBlipScale(trader_blip, 0.85)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString("Helix trader")
					EndTextCommandSetBlipName(trader_blip)
					SetBlipRoute(trader_blip, true)
				end

				existingPed = NetToPed(traders[trader_id].id)
				--print(traders[trader_id].id, existingPed)
				if DoesEntityExist(existingPed) and existingPed ~= 0 then
					local ped_pos = GetEntityCoords(existingPed, false)
					if IsEntityDead(existingPed) then
						trading = false
						SetBlipRoute(trader_blip, false)
						RemoveBlip(trader_blip)
						Notify("The trade was cancelled as the trader was killed!", 3500)
					else
						DecorSetBool(existingPed, "isTrader", true)
						Draw3DText(ped_pos.x, ped_pos.y, ped_pos.z+1, "Rate: "..traders[trader_id].rate.."%")
						if Vdist(ped_pos.x, ped_pos.y, ped_pos.z, traders[trader_id].coordinates.trader.x, traders[trader_id].coordinates.trader.y, traders[trader_id].coordinates.trader.z) > 1 then
							Citizen.Wait(7500)
							TaskGoStraightToCoord(existingPed, traders[trader_id].coordinates.trader.x, traders[trader_id].coordinates.trader.y, traders[trader_id].coordinates.trader.z, 2.0, -1, traders[trader_id].coordinates.trader.h, 0.0)
						end
					end
				else
					--CreateTrader(trader.model, trader.coordinates.trader.x, trader.coordinates.trader.y, trader.coordinates.trader.z, trader.coordinates.trader.h)
				end
				local pos = GetEntityCoords(PlayerPedId(), false)
				if Vdist(pos.x, pos.y, pos.z, traders[trader_id].coordinates.marker.x, traders[trader_id].coordinates.marker.y, traders[trader_id].coordinates.marker.z) < 20 then

					drawMarker(25, traders[trader_id].coordinates.marker.x, traders[trader_id].coordinates.marker.y, traders[trader_id].coordinates.marker.z, 1.0, 1.0, 1.5, 255, 0, 0, 255)
					if Vdist(pos.x, pos.y, pos.z, traders[trader_id].coordinates.marker.x, traders[trader_id].coordinates.marker.y, traders[trader_id].coordinates.marker.z) < 2 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to trade your ~g~Cannabis ~w~for Joints")
						if IsControlJustPressed(1, 51) then
							if GetItemQuantity(weed_id) > 0 then
								trading = false
								Notify("Trade completed!", 3500)
								TriggerServerEvent("weed:trade", traders[trader_id], existingPed)
								SetBlipRoute(trader_blip, false)
								RemoveBlip(trader_blip)
							else
								if DoesEntityExist(existingPed) and existingPed ~= 0 then
									Notify("You pissed off the trader as you had nothing to trade!", 3500)
									PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
									TaskCombatPed(existingPed, PlayerPedId(), 0, 16)
									trading = false
									SetBlipRoute(trader_blip, false)
									RemoveBlip(trader_blip)
								end
							end
						end
					end
				end
			end
			SetBlipRoute(trader_blip, false)
			RemoveBlip(trader_blip)
			trading, trader_blip = false, nil
		end)
	end
end)

AddEventHandler("weed:canceltrader", function()
	if trading then
		trading = false
	elseif DoesBlipExist(trader_blip) then
		SetBlipRoute(trader_blip, false)
		RemoveBlip(trader_blip)
		trading, trader_blip = false, nil
	end
end)
local Cocaine = {
	Locations = {
		Pickup = vector3(-495.73739624023,-2911.3024902344,6.0003871917725),
		Van = vector3(-488.9792175293,-2909.376953125,6.000385761261),
	},
	Cost = {
		Dirty = 50,
		Van = 250,
	},
	Items = {
		Dirty = 47,
		Cocaine = 28,
	},
	Vehicle = {
		Model = "boxville4",
		Handle = nil,
	},
	Pay = {
		Min = 150,
		Max = 200,
	},
	Harvesting = false,
	Cooldown = 0,
}
local drug_zones = { 
	['AIRP'] = {label = "Los Santos International Airport", chance = 10}, -- 80% chance of success for selling drugs to a civ
	['ALAMO'] = {label = "Alamo Sea", chance = 10}, 
	['ALTA'] = {label = "Alta", chance = 10}, 
	['ARMYB'] = {label = "Fort Zancudo", chance = 10}, 
	['BANHAMC'] = {label = "Banham Canyon Dr", chance = 10}, 
	['BANNING'] = {label = "Banning", chance = 10}, 
	['BEACH'] = {label = "Vespucci Beach", chance = 50}, 
	['BHAMCA'] = {label = "Banham Canyon", chance = 10}, 
	['BRADP'] = {label = "Braddock Pass", chance = 10}, 
	['BRADT'] = {label = "Braddock Tunnel", chance = 10}, 
	['BURTON'] = {label = "Burton", chance = 10}, 
	['CALAFB'] = {label = "Calafia Bridge", chance = 10}, 
	['CANNY'] = {label = "Raton Canyon", chance = 10}, 
	['CCREAK'] = {label = "Cassidy Creek", chance = 10}, 
	['CHAMH'] = {label = "Chamberlain Hills", chance = 70}, 
	['CHIL'] = {label = "Vinewood Hills", chance = 10}, 
	['CHU'] = {label = "Chumash", chance = 10}, 
	['CMSW'] = {label = "Chiliad Mountain State Wilderness", chance = 10}, 
	['CYPRE'] = {label = "Cypress Flats", chance = 70},
	['DAVIS'] = {label = "Davis", chance = 70}, 
	['DELBE'] = {label = "Del Perro Beach", chance = 50}, 
	['DELPE'] = {label = "Del Perro", chance = 10}, 
	['DELSOL'] = {label = "La Puerta", chance = 50}, 
	['DESRT'] = {label = "Grand Senora Desert", chance = 10}, 
	['DOWNT'] = {label = "Downtown", chance = 10}, 
	['DTVINE'] = {label = "Downtown Vinewood", chance = 10}, 
	['EAST_V'] = {label = "East Vinewood", chance = 10}, 
	['EBURO'] = {label = "El Burro Heights", chance = 10}, 
	['ELGORL'] = {label = "El Gordo Lighthouse", chance = 10}, 
	['ELYSIAN'] = {label = "Elysian Island", chance = 10}, 
	['GALFISH'] = {label = "Galilee", chance = 10}, 
	['GOLF'] = {label = "GWC and Golfing Society", chance = 10}, 
	['GRAPES'] = {label = "Grapeseed", chance = 70}, 
	['GREATC'] = {label = "Great Chaparral", chance = 10}, 
	['HARMO'] = {label = "Harmony", chance = 50}, 
	['HAWICK'] = {label = "Hawick", chance = 10}, 
	['HORS'] = {label = "Vinewood Racetrack", chance = 10}, 
	['HUMLAB'] = {label = "Humane Labs and Research", chance = 0}, 
	['JAIL'] = {label = "Bolingbroke Penitentiary", chance = 0}, 
	['KOREAT'] = {label = "Little Seoul", chance = 70}, 
	['LACT'] = {label = "Land Act Reservoir", chance = 10}, 
	['LAGO'] = {label = "Lago Zancudo", chance = 10}, 
	['LDAM'] = {label = "Land Act Dam", chance = 10}, 
	['LEGSQU'] = {label = "Legion Square", chance = 10}, 
	['LMESA'] = {label = "La Mesa", chance = 70}, 
	['LOSPUER'] = {label = "La Puerta", chance = 50}, 
	['MIRR'] = {label = "Mirror Park", chance = 10}, 
	['MORN'] = {label = "Morningwood", chance = 10}, 
	['MOVIE'] = {label = "Richards Majestic", chance = 10}, 
	['MTCHIL'] = {label = "Mount Chiliad", chance = 10}, 
	['MTGORDO'] = {label = "Mount Gordo", chance = 10}, 
	['MTJOSE'] = {label = "Mount Josiah", chance = 10}, 
	['MURRI'] = {label = "Murrieta Heights", chance = 10}, 
	['NCHU'] = {label = "North Chumash", chance = 10}, 
	['NOOSE'] = {label = "N.O.O.S.E", chance = 0}, 
	['OCEANA'] = {label = "Pacific Ocean", chance = 10}, 
	['PALCOV'] = {label = "Paleto Cove", chance = 10}, 
	['PALETO'] = {label = "Paleto Bay", chance = 70}, 
	['PALFOR'] = {label = "Paleto Forest", chance = 50}, 
	['PALHIGH'] = {label = "Palomino Highlands", chance = 10}, 
	['PALMPOW'] = {label = "Palmer-Taylor Power Station", chance = 10}, 
	['PBLUFF'] = {label = "Pacific Bluffs", chance = 10}, 
	['PBOX'] = {label = "Pillbox Hill", chance = 10}, 
	['PROCOB'] = {label = "Procopio Beach", chance = 10}, 
	['RANCHO'] = {label = "Rancho", chance = 70}, 
	['RGLEN'] = {label = "Richman Glen", chance = 10}, 
	['RICHM'] = {label = "Richman", chance = 10}, 
	['ROCKF'] = {label = "Rockford Hills", chance = 10}, 
	['RTRAK'] = {label = "Redwood Lights Track", chance = 10}, 
	['SANAND'] = {label = "San Andreas", chance = 50}, 
	['SANCHIA'] = {label = "San Chianski Mountain Range", chance = 10}, 
	['SANDY'] = {label = "Sandy Shores", chance = 50}, 
	['SKID'] = {label = "Mission Row", chance = 10}, 
	['SLAB'] = {label = "Stab City", chance = 70}, 
	['STAD'] = {label = "Maze Bank Arena", chance = 10}, 
	['STRAW'] = {label = "Strawberry", chance = 70}, 
	['TATAMO'] = {label = "Tataviam Mountains", chance = 50}, 
	['TERMINA'] = {label = "Terminal", chance = 50}, 
	['TEXTI'] = {label = "Textile City", chance = 50}, 
	['TONGVAH'] = {label = "Tongva Hills", chance = 50}, 
	['TONGVAV'] = {label = "Tongva Valley", chance = 50}, 
	['VCANA'] = {label = "Vespucci Canals", chance = 50}, 
	['VESP'] = {label = "Vespucci", chance = 10}, 
	['VINE'] = {label = "Vinewood", chance = 10}, 
	['WINDF'] = {label = "Ron Alternates Wind Farm", chance = 10}, 
	['WVINE'] = {label = "West Vinewood", chance = 10}, 
	['ZANCUDO'] = {label = "Zancudo River", chance = 10}, 
	['ZP_ORT'] = {label = "Port of South Los Santos", chance = 10}, 
	['ZQ_UAR'] = {label = "Davis Quartz", chance = 10},
}

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

function PlayConcaineAnimation(ped)
	Citizen.CreateThread(function()
		RequestAnimDict("anim@amb@business@coc@coc_unpack_cut@")
		while not HasAnimDictLoaded("anim@amb@business@coc@coc_unpack_cut@") do
			Citizen.Wait(0)
		end
		TaskPlayAnim(ped, "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_cokecutter", 5.0, -1, -1, 10, 0, false, false, false)
		Citizen.Wait(21000)
		if IsEntityPlayingAnim(ped, "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_cokecutter", 3) then
			ClearPedTasks(ped)
			if GetItemQuantity(Cocaine.Items.Dirty) > 0 then
				TriggerServerEvent("cocaine:clean")
			end
		else
			Notify("You didn't finish cleaning the coke!", 3000)
		end
		Cocaine.Harvesting = false
	end)
end

function CreateCocaineVan()
	Cocaine.Vehicle.Handle = exports["core"]:SpawnVehicle(Cocaine.Vehicle.Model, Cocaine.Locations.Van, 316.04577636719, false)

	if Cocaine.Vehicle.Handle ~= nil and Cocaine.Vehicle.Handle ~= 0 then
		DecorSetBool(Cocaine.Vehicle.Handle, "hotwire", true)

		SetVehicleOnGroundProperly(Cocaine.Vehicle.Handle)

		TaskWarpPedIntoVehicle(PlayerPedId(), Cocaine.Vehicle.Handle, -1)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		local CokeDistance = #(PlayerPosition - Cocaine.Locations.Pickup) 
		local VanDistance = #(PlayerPosition - Cocaine.Locations.Van) 

		if (IsInZone("coke") or IsInZone("coke2") or IsInZone("coke3")) and PlayerPosition.z <= -35.50 then
			if GetItemQuantity(Cocaine.Items.Dirty) > 0 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to clean cocaine")
				if IsControlJustPressed(1, 51) and not Cocaine.Harvesting then
					Cocaine.Harvesting = true
					PlayConcaineAnimation(PlayerPedId())
				end
			end
		end
		if CokeDistance < 20 then
			RenderMarker(25, Cocaine.Locations.Pickup.x, Cocaine.Locations.Pickup.y, Cocaine.Locations.Pickup.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
			if CokeDistance < 1 then
				if not isFull() then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to purchase dirty cocaine for $"..Cocaine.Cost.Dirty.." each!")
					if IsControlJustPressed(1, 51) then
						local Amount = tonumber(KeyboardInput("Enter amount:", 100, 3))
						if Amount ~= nil and Amount > 0 then
							TriggerServerEvent("cocaine:purchase", Amount)
						else
							Notify("Invalid amount entered!")
						end
					end
				else
					DisplayHelpText("Your inventory is full!")
				end
			end
		end
		if VanDistance < 20 then
			RenderMarker(25, Cocaine.Locations.Van.x, Cocaine.Locations.Van.y, Cocaine.Locations.Van.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
			if VanDistance < 2 then
				if Cocaine.Vehicle.Handle == nil then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a Post OP van for $"..Cocaine.Cost.Van.."!")
					if IsControlJustPressed(1, 51) then
						TriggerServerEvent("cocaine:vehicle")
					end
				else
					DisplayHelpText("Press ~INPUT_CONTEXT~ to return the van!")
					if IsControlJustPressed(1, 51) then
						DestroyCar(Cocaine.Vehicle.Handle)
						Cocaine.Vehicle.Handle = nil
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if(Cocaine.Cooldown > 0)then
			Cocaine.Cooldown = Cocaine.Cooldown - 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)
		RequestAnimDict("mp_common")
		while not HasAnimDictLoaded("mp_common") do
			Citizen.Wait(0)
		end
		local methbag_model = GetHashKey("prop_meth_bag_01")
		if GetItemQuantity(Cocaine.Items.Cocaine) > 0 then
			if not IsPedSittingInAnyVehicle(PlayerPed) then
				for ped in EnumeratePeds() do
					if DoesEntityExist(ped) then
						if not IsEntityDead(ped) then
							if not IsPedAPlayer(ped) and not DecorGetBool(ped, "isTrader") and not DecorGetBool(ped, "soldTo") and not IsPedAnAnimal(GetEntityModel(ped)) then
								if #(PlayerPosition - GetEntityCoords(ped, false)) < 1 then
									if Cocaine.Cooldown > 0 then
										DisplayHelpText("Press ~INPUT_CONTEXT~ to sell cocaine! ["..Cocaine.Cooldown.."]")
									else
										DisplayHelpText("Press ~INPUT_CONTEXT~ to sell cocaine!")
										if IsControlJustPressed(1, 51) then
											Cocaine.Cooldown = 10
											DecorSetBool(ped, "soldTo", true)
											if willNPCbuy() then

												RequestModel(methbag_model)

												while not HasModelLoaded(methbag_model) do
													Citizen.Wait(250)
												end

												SetEntityHeading(ped, GetEntityHeading(PlayerPed) - 180)

												local methbag = CreateObject(methbag_model, 0.01, 0, 0, 1, 0, 0)

												AttachEntityToEntity(methbag, PlayerPed, GetPedBoneIndex(PlayerPed, 64096), 0.0, 0.0, 0.020, 90.0, -10.0, -130.0 ,true, true, false, true, 1, true)

												TaskPlayAnim(PlayerPed, "mp_common", "givetake1_a", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)

		                    					TaskPlayAnim(ped, "mp_common", "givetake1_b", 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)

		                    					Citizen.Wait(500)

		                    					DestroyObject(methbag)

												local amount = GetRandomIntInRange(1, 8)
												
												if GetItemQuantity(Cocaine.Items.Cocaine) >= amount then
													local pay = GetRandomIntInRange(Cocaine.Pay.Min, Cocaine.Pay.Max+1) * amount
													local money_type = 1
													if getCops() <= 0 then pay = pay/2 end
													Notify("You sold "..amount.." gram(s) of coke for <span style='color:lime'>$</span><span style='color:white'>"..math.floor(pay).."</span>")
													TriggerServerEvent("cocaine:sell", math.floor(pay), money_type, amount)
												else
													local pay = GetRandomIntInRange(Cocaine.Pay.Min, Cocaine.Pay.Max+1)
													local money_type = 1
													if getCops() <= 0 then pay = pay/2 end
													Notify("You sold 1 gram of coke for <span style='color:lime'>$</span><span style='color:white'>"..math.floor(pay).."</span>")
													TriggerServerEvent("cocaine:sell", math.floor(pay), money_type, 1)
												end
												PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
											else
												PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
												TaskReactAndFleePed(ped, PlayerPed)
												Citizen.Wait(4000)
												TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 0, true)
												Citizen.Wait(5000)
												ClearPedTasks(ped)

												if not IsEntityDead(ped) then
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
		end
	end
end)

RegisterNetEvent("cocaine:vehicle")
AddEventHandler("cocaine:vehicle", function()
	CreateCocaineVan()
end)

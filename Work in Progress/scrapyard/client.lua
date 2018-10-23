local IsScrap = true
local OnDuty = false
local isSearching = false
local Scrap = {
	Data = {
		Doors = {
			{x = -589.53009033203, y = -1621.603515625, z = 33.161777496338, h = 174.73043823242, model = 812467272},
			{x = -590.82397460938, y = -1621.5015869141, z = 33.162761688232, h = 354.52551269531, model = 812467272},
		},
		Blips = {},
		Sand = 0,
		Service = {x = -618.65423583984, y = -1623.2392578125, z = 33.010543823242, h = 174.02153015137},
		Items = {
		    [1] = {name = "Aluminum Can", item_id = 66},
		    [2] = {name = "Copper Wire", item_id = 67},
		    [3] = {name = "Light Iron", item_id = 68},
		    [4] = {name = "Copper Tubing", item_id = 69},
		    [5] = {name = "Brass Scrap", item_id = 70},
		    [6] = {name = "Bronze Scrap", item_id = 71},
		    [7] = {name = "Golden Ring", item_id = 72},
		    [8] = {name = "Silver Necklace", item_id = 73},
		    [9] = {name = "Silver Earing", item_id = 74},
		},
		Container = {

		},
		Recycle = 
	},
}

RegisterNetEvent("scrapyard:set")
AddEventHandler("scrapyard:set", function(_IsScrap)
	OnDuty = false
	IsScrap = _IsScrap
end)

function DrawJobBlips()
	for k, v in ipairs(--[[INSERT TABLE--]]) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 316)
		SetBlipColour(blip, 11)
		SetBlipAsShortRange(blip, true)
		SetBlipScale(blip, 0.85)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(--[["INSERT NAME"--]])
		EndTextCommandSetBlipName(blip)
		table.insert(Scrap.Data.Blips, blip)
	end
end

function DeleteJobBlips()
	for k, v in ipairs(Scrap.Data.Blips) do
		RemoveBlip(v)
		table.remove(Scrap.Data.Blips, k)
	end
end

function GetGroundHash(ped)
    local posped = GetEntityCoords(ped)
    local num = StartShapeTestCapsule(posped.x,posped.y,posped.z+4,posped.x,posped.y,posped.z-2.0, 2, 1, ped, 7)
    local arg1, arg2, arg3, arg4, arg5 = GetShapeTestResultEx(num)
    Scrap.Data.Sand = arg5
end

function startDetecting()
	isSearching = true
	local anim = "WORLD_HUMAN_GARDENER_PLANT"
	local randomnum = math.random(1,9)
	Notify("You are currently searching for metal objects!", 10000)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
	Wait(10000)
	TriggerServerEvent('scrapyardgiveitem', Scrap.Data.Items[randomnum].item_id)
	ClearPedTasks(PlayerPedId())
	isSearching = false
end

Citizen.CreateThread(function()
	CreateBlip("Rogers Salvage & Scrap", 356, 68, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z)
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId(), 0)
		for k, v in ipairs(Scrap.Data.Doors) do
			local entity = GetClosestObjectOfType(v.x, v.y, v.z, 5.0, v.model, 0, 1, 1)
			SetEntityAsMissionEntity(entity, true, true)
			DeleteEntity(entity)
		end
		if IsScrap then
			if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z) < 10 then
				DrawMarker(25, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z) < 1 then
					if OnDuty then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to sign off duty")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to sign on duty")
					end
					if IsControlJustPressed(1, 51) then
						OnDuty = not OnDuty
					end
				end
			end
			if OnDuty then
				if Vdist(pos.x pos.y, pos.z, Scrap.Data.Recycle.x, Scrap.Data.Recycle.y, Scrap.Data.Recycle.z) < 10 then
					DrawMarker(25, Scrap.Data.Recycle.x, Scrap.Data.Recycle.y, Scrap.Data.Recycle.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
					if Vdist(pos.x pos.y, pos.z, Scrap.Data.Recycle.x, Scrap.Data.Recycle.y, Scrap.Data.Recycle.z) < 1 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to use the recycler!")
						if IsControlJustPressed(1, 51) then
							local timerequired = 1000
							Notify("Please type /recycle [AMOUNT] in chat!", 10000)
							for k, v in ipairs(Scrap.Data.Items) do
								if GetItemQuantity(k.item_id) > 0 then
									while recycleAmount < 1 do
										Citizen.Wait(0)
									end
									if recycleAmount <= GetItemQuantity(k.item_id) then
										timerequired = timerequired * recycleAmount
										Notify("Recyling In Progress", timerequired)
										while timerequired > 0 then
											Citizen.Wait(1000)
											TriggerEvent('inventory:removeQty', k.item_id, 1)
											TriggerEvent('inventory:addQty', 75, 1)
											timerequired = timerequired - 1000
										end
										recycleAmount = 0
									else
										Notify("You don't have the amount of "..k.name.." that you entered!", 7500)
									end
								else
									Notify("You don't have any items that can be scrapped!", 7000)
								end
							end
						end
					end
				end
				if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Chop.x, Scrap.Data.Chop.y, Scrap.Data.Chop.z) < 20 then
					drawMarker(25, Scrap.Data.Chop.x, Scrap.Data.Chop.y, Scrap.Data.Chop.z, 3.0, 3.0, 3.5, 255, 255, 0, 255)
					if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Chop.x, Scrap.Data.Chop.y, Scrap.Data.Chop.z) < 2 then
						if IsPedSittingInAnyVehicle(PlayerPedId()) then
							local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
							if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
								DisplayHelpText("Press ~INPUT_CONTEXT~ to chop for clean money!\nPress ~INPUT_DETONATE~ to chop for dirty money!")
								if IsControlJustPressed(1, 51) then
									local owned = false
									local playervehicle = false
									for k,v in pairs(user_vehicles) do
										if v.plate == GetVehicleNumberPlateText(vehicle) then
											playervehicle = true
											break
										end
									end
									if not owned then
										local class = GetVehicleClass(vehicle)
									    for seat = -1, GetVehicleMaxNumberOfPassengers(vehicle) do
									        if not IsVehicleSeatFree(vehicle, seat) then
									            TaskLeaveVehicle(GetPedInVehicleSeat(vehicle, seat), vehicle, 0)
									        end
									    end
									    NetworkRequestControlOfEntity(vehicle)
									    while not NetworkHasControlOfEntity(vehicle) do
									        Citizen.Wait(0)
									    end
									    SetEntityAsMissionEntity(vehicle, true, true)
									    while IsPedInAnyVehicle(PlayerPedId(), true) do
									        Citizen.Wait(0)
									    end
									    DestroyVehicle(vehicle)
									    if playervehicle then
											TriggerServerEvent("chopshop:pay", "clean", class)
										else
											TriggerServerEvent("chopshop:pay", "clean", 22)
										end
									else
										Notify("We don't accept that type of vehicle!", 3000)
									end
								end
								if IsControlJustPressed(1, 47) then
									local owned = false
									local playervehicle = false
									for k,v in pairs(user_vehicles) do
										if v.plate == GetVehicleNumberPlateText(vehicle) then
											playervehicle = true
											break
										end
									end
									if not owned then
										local class = GetVehicleClass(vehicle)
									    for seat = -1, GetVehicleMaxNumberOfPassengers(vehicle) do
									        if not IsVehicleSeatFree(vehicle, seat) then
									            TaskLeaveVehicle(GetPedInVehicleSeat(vehicle, seat), vehicle, 0)
									        end
									    end
									    NetworkRequestControlOfEntity(vehicle)
									    while not NetworkHasControlOfEntity(vehicle) do
									        Citizen.Wait(0)
									    end
									    SetEntityAsMissionEntity(vehicle, true, true)
									    while IsPedInAnyVehicle(PlayerPedId(), true) do
									        Citizen.Wait(0)
									    end
									    DestroyVehicle(vehicle)
									    if playervehicle then
											TriggerServerEvent("chopshop:pay", "dirty", class)
										else
											TriggerServerEvent("chopshop:pay", "dirty", 22)
										end
									else
										Notify("We don't accept that type of vehicle!", 3000)
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
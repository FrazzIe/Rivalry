--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
--[[ Open Menu ]]--
drivers_license = "false"
controller = false

local seat_cooldown = -1
Citizen.CreateThread(function()
	local voice_count = 1
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		if not IsPauseMenuActive() and not exports["PlayerCustomisation"]:IsInstanced() then
			if IsControlJustReleased(1, 311) or IsControlJustReleased(1, 19) then
				if exports.ui:currentmenu() == "" then
					if not IsPedFalling(PlayerPed) then
						TriggerEvent("interaction:main")
					end
				elseif exports.ui:currentmenu() ~= "" then
					exports.ui:close()
				end
			end

			if IsControlJustPressed(1, 182) and IsInputDisabled(2) and not controller and not exports.policejob:getIsInService() then
				TriggerEvent("keys:toggle")
			end

			if IsControlJustPressed(1, 170) and IsInputDisabled(2) and not controller then
				voice_count = voice_count + 1
				if voice_count > 3 then voice_count = 1 end
				TriggerEvent("interaction:voice_change", voice_count)
			end

			if exports.policejob:getIsInService() then 
				if IsPedInAnyPoliceVehicle(PlayerPed) then
					local CurrentVehicle = GetVehiclePedIsIn(PlayerPed, false)
					if GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPed then
						if IsControlJustPressed(1, 182) and IsInputDisabled(2) and not controller then
							local vehicle = GetVehiclePedIsIn(PlayerPed, false)
							local lockstatus = GetVehicleDoorLockStatus(vehicle)
							if lockstatus == 1 or lockstatus == 0 then
								Notify("Vehicle locked", 3000)
								SetVehicleDoorsLocked(vehicle, 4)
							else
								Notify("Vehicle unlocked", 300)
								SetVehicleDoorsLocked(vehicle, 1)
							end
						end
					end
				else
					if IsControlJustPressed(1, 182) and IsInputDisabled(2) and not controller then
						local pos = GetEntityCoords(PlayerPed)
						local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPed, 0.0, 20.0, 0.0)

						local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPed, 0)
						local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

						if vehicleHandle ~= nil then
							if DoesEntityExist(vehicleHandle) then
							   	TriggerServerEvent("interaction:check_keys", GetVehicleNumberPlateText(vehicleHandle), vehicleHandle)
							end
						end
					end
				end
			end
		else
			if exports.ui:currentmenu() ~= "" then
				exports.ui:close()
			end
		end

		if IsPedSittingInAnyVehicle(PlayerPed) then
			local CurrentVehicle = GetVehiclePedIsIn(PlayerPed, false)
			if GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPed then
				if IsControlJustPressed(1, 15) and IsInputDisabled(2) and not controller then
					local model = GetEntityModel(CurrentVehicle)
					if IsThisModelACar(model) or IsThisModelAQuadbike(model) or IsThisModelABike(model) then
						if DecorGetFloat(CurrentVehicle, "_Fuel_Level") > 0 then
							TriggerEvent("interaction:vehicle_engine")
						end
					else
						TriggerEvent("interaction:vehicle_engine")
					end
				end
			end

			if GetPedInVehicleSeat(CurrentVehicle, 0) == PlayerPed then
				if GetIsTaskActive(PlayerPed, 165) then
					SetPedIntoVehicle(PlayerPed, CurrentVehicle, 0)
				end
			end

			local seat = GetSeat(CurrentVehicle, PlayerPed)

			if seat ~= nil then
				if seat % 2 == 0 then
					if IsDisabledControlPressed(0, 36) then
						if IsControlJustPressed(1, 174) then
							if IsVehicleSeatFree(CurrentVehicle, seat - 1) then
								if seat_cooldown <= 0 then
									seat_cooldown = 2
									SetPedIntoVehicle(PlayerPed, CurrentVehicle, seat - 1)
								end
							end
						end
						if IsControlJustPressed(1, 172) then
							if IsVehicleSeatFree(CurrentVehicle, seat - 2) then
								if seat_cooldown <= 0 then
									seat_cooldown = 4
									SetPedIntoVehicle(PlayerPed, CurrentVehicle, seat - 2)
								end
							end
						end
						if IsControlJustPressed(1, 173) then
							if IsVehicleSeatFree(CurrentVehicle, seat + 2) then
								if seat_cooldown <= 0 then
									seat_cooldown = 4
									SetPedIntoVehicle(PlayerPed, CurrentVehicle, seat + 2)
								end
							end
						end
					end
				end

				if seat % 2 == 1 then
					if IsDisabledControlPressed(0, 36) then
						if IsControlJustPressed(1, 175) then
							if IsVehicleSeatFree(CurrentVehicle, seat + 1) then
								if seat_cooldown <= 0 then
									seat_cooldown = 2
									SetPedIntoVehicle(PlayerPed, CurrentVehicle, seat + 1)
								end
							end
						end
						if IsControlJustPressed(1, 172) then
							if IsVehicleSeatFree(CurrentVehicle, seat - 2) then
								if seat_cooldown <= 0 then
									seat_cooldown = 4
									SetPedIntoVehicle(PlayerPed, CurrentVehicle, seat - 2)
								end
							end
						end
						if IsControlJustPressed(1, 173) then
							if IsVehicleSeatFree(CurrentVehicle, seat + 2) then
								if seat_cooldown <= 0 then
									seat_cooldown = 4
									SetPedIntoVehicle(PlayerPed, CurrentVehicle, seat + 2)
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
		if seat_cooldown > -1 then
			Citizen.Wait(1000)
			seat_cooldown = seat_cooldown - 1
		end
	end
end)

local hasphonebool = false
--[[ Main Menu ]]--
AddEventHandler("interaction:main", function()
	exports.ui:reset()
	exports.ui:open()
	if IsEntityDead(PlayerPedId()) then
		if exports.policejob:getIsCop() or exports.emsjob:getIsParamedic() then 
			if exports.policejob:getIsInService() or exports.emsjob:getIsInService() then 
				if HasTracker() then
					exports.ui:addOption("10-13", [[TriggerEvent("EmergencyBlips.Panic")]])
				end 

				if not exports.policejob:getIsCuffed() and not isCuffed() then
					if HasTracker() then
						exports.ui:addOption("Turn tracker off", [[TriggerEvent("interaction:tracker2")]])
					else
						exports.ui:addOption("Turn tracker on", [[TriggerEvent("interaction:tracker2")]])
					end
				end
			end
		end
		if exports["phone"]:PlayerHasPhone() then
			exports.ui:addOption("Life Alert", [[TriggerEvent("Phone.Open")]])
		else
			exports.ui:addOption("Respawn at Hospital", [[TriggerEvent("paramedic:respawnCheck")]])
		end	
	else
		if exports.policejob:getIsCop() then if exports.policejob:getIsInService() then exports.ui:addOption("Police", [[TriggerEvent("police:menu")]]) end end
		if exports.emsjob:getIsParamedic() then if exports.emsjob:getIsInService() then exports.ui:addOption("Paramedic", [[TriggerEvent("paramedic:menu")]]) end end
		if DOJ.IsDOJ then if DOJ.Active then exports.ui:addOption("DOJ", [[TriggerEvent("DOJ:Menu")]]) end end
		if exports.others:getIsInService() then exports.ui:addOption("Taxi", [[TriggerEvent("taxi:menu")]]) end
		if exports.jobs:getMechanicIsInService() then exports.ui:addOption("Mechanic", [[TriggerEvent("mechanic:menu")]]) end
		exports.ui:addOption("Actions", [[TriggerEvent("interaction:actions_emotes")]])
		if not IsJailed and not exports.policejob:getIsCuffed() and not isCuffed() then
			exports.ui:addOption("Inventory", [[TriggerEvent("inventory:open")]])
			exports.ui:addOption("Vehicle", [[TriggerEvent("interaction:vehicle")]])
			exports.ui:addOption("Weapons", [[TriggerEvent("interaction:weapons")]])
			exports.ui:addOption("Keys", [[TriggerEvent("interaction:keys")]])
		end
		exports.ui:addOption("Phone / Wallet", [[TriggerEvent("interaction:wallet")]])
	end
	exports.ui:back("")
end)

--[[ Actions / Emotes ]]--
AddEventHandler("interaction:actions_emotes", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Rob", [[TriggerEvent("interaction:rob")]])
	exports.ui:addOption("Escort", [[TriggerEvent("interaction:drag_execute")]])
	if exports.policejob:getIsCop() or exports.emsjob:getIsParamedic() then 
		if exports.policejob:getIsInService() or exports.emsjob:getIsInService() then 
			if not exports.policejob:getIsCuffed() and not isCuffed() then
				if HasTracker() then
					exports.ui:addOption("Turn tracker off", [[TriggerEvent("interaction:tracker")]])
				else
					exports.ui:addOption("Turn tracker on", [[TriggerEvent("interaction:tracker")]])
				end
			end
		end
	end
	exports.ui:back([[TriggerEvent("interaction:main")]])
end)

AddEventHandler("interaction:tracker", function(TurnOn)
	local ServerId = GetPlayerServerId(PlayerId())
	local Position = GetEntityCoords(PlayerPedId(), false)
	local Street, Crossing = GetStreetNameAtCoord(Position.x, Position.y, Position.z)

	if not HasTracker() then
		EmergencyPlayers[ServerId] = {1, false, "Unknown?"}
		TriggerServerEvent("EmergencyBlips.Add", GetStreetNameFromHashKey(Street), (exports.emsjob:getIsInService() and 1 or 2))
	else
		EmergencyPlayers[ServerId] = nil
		TriggerServerEvent("EmergencyBlips.Remove", GetStreetNameFromHashKey(Street))
	end
	TriggerEvent("interaction:actions_emotes")
end)

AddEventHandler("interaction:tracker2", function(TurnOn)
	local ServerId = GetPlayerServerId(PlayerId())
	local Position = GetEntityCoords(PlayerPedId(), false)
	local Street, Crossing = GetStreetNameAtCoord(Position.x, Position.y, Position.z)

	if not HasTracker() then
		EmergencyPlayers[ServerId] = {1, false, "Unknown?"}
		TriggerServerEvent("EmergencyBlips.Add", GetStreetNameFromHashKey(Street), (exports.emsjob:getIsInService() and 1 or 2))
	else
		EmergencyPlayers[ServerId] = nil
		TriggerServerEvent("EmergencyBlips.Remove", GetStreetNameFromHashKey(Street))
	end
	TriggerEvent("interaction:main")
end)

AddEventHandler("interaction:drag_execute", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	TriggerServerEvent("interaction:drag", GetPlayerServerId(t))
    else
        Messages(5)
    end
end)

--[[ Inventory Menu ]]--
AddEventHandler("inventory:open", function()
	exports.ui:reset()
	exports.ui:open("inventory")
	for k,v in pairs(user_inventory) do
		exports.ui:addOption(v.quantity.." | "..v.name, "inventory:options", v)
	end
	exports.ui:back([[TriggerEvent("interaction:main")]])
end)

AddEventHandler("inventory:options", function(data)
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Use "..data.name, "inventory:use", data)
	exports.ui:addOption("Give "..data.name, "inventory:give", data)
	exports.ui:addOption("Drop "..data.name, "inventory:drop", data)
	exports.ui:back([[TriggerEvent("inventory:open")]])
end)

--[[ Vehicle Menu ]]--
AddEventHandler("interaction:vehicle", function()
	exports.ui:reset()
	exports.ui:open("vehicle_menu")
	exports.ui:addOption("Inventory", [[TriggerEvent("inventory:vehicle_open")]])
	exports.ui:addOption("Weapons", [[TriggerEvent("inventory:vehicle_weapon_open")]])
	exports.ui:addOption("Unlock", [[TriggerEvent("interaction:vehicle_unlock")]])
	exports.ui:addOption("Lock", [[TriggerEvent("interaction:vehicle_lock")]])
	if IsPedSittingInAnyVehicle(PlayerPedId()) then	
		if (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()) then
			exports.ui:addOption("Engine", [[TriggerEvent("interaction:vehicle_engine")]])
			exports.ui:addOption("Lock speed", [[TriggerEvent("interaction:vehicle_speedlock")]])
			exports.ui:addOption("Doors", [[TriggerEvent("interaction:vehicle_doors")]])
		end
	end
	exports.ui:back([[TriggerEvent("interaction:main")]])
end)

AddEventHandler("interaction:vehicle_doors", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Front left",  [[TriggerEvent("interaction:toggle_doors", 0)]])
	exports.ui:addOption("Front right",  [[TriggerEvent("interaction:toggle_doors", 1)]])
	exports.ui:addOption("Back left",  [[TriggerEvent("interaction:toggle_doors", 2)]])
	exports.ui:addOption("Back right",  [[TriggerEvent("interaction:toggle_doors",3)]])
	exports.ui:addOption("Hood",  [[TriggerEvent("interaction:toggle_doors", 4)]])
	exports.ui:addOption("Trunk",  [[TriggerEvent("interaction:toggle_doors", 5)]])
	exports.ui:addOption("Back",  [[TriggerEvent("interaction:toggle_doors", 6)]])
	exports.ui:addOption("All doors",  [[TriggerEvent("interaction:toggle_all_doors")]])
	exports.ui:back([[TriggerEvent("interaction:vehicle")]])
end)
--[[ Vehicle Menu Functions ]]--
AddEventHandler("interaction:vehicle_engine", function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		if (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()) then
			SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), (not IsVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false))), true, false)
			SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId(), false), (not IsVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false))))
		end
	end
end)

AddEventHandler("interaction:toggle_doors", function(door)
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		if (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()) then
			exports.ui:open()
			if GetVehicleDoorAngleRatio(GetVehiclePedIsIn(PlayerPedId(), false), door) > 0.0 then
				SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), false), door, false)
			else
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), false), door, false, false)
			end
		end
	end
end)

AddEventHandler("interaction:toggle_all_doors", function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		if (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()) then
			exports.ui:open()
			for i = 0, 7 do
				if GetVehicleDoorAngleRatio(GetVehiclePedIsIn(PlayerPedId(), false), i) > 0.0 then
					SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), false), i, false)
				else
					SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), false), i, false, false)
				end
			end
		end
	end
end)
--[[ Weapon Menu ]]--
AddEventHandler("interaction:weapons", function()
	exports.ui:reset()
	exports.ui:open("weapons")
    for k,v in pairs(user_weapons) do
    	if GetMaxAmmoInClip(PlayerPedId(), GetHashKey(k), 1) ~= 0 then
    		exports.ui:addOption(Weapons_names[k].." ["..GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(k)).."]", "interaction:weapon_options", k)
    	else
    		exports.ui:addOption(Weapons_names[k], "interaction:weapon_options", k)
    	end
    end
    exports.ui:back([[TriggerEvent("interaction:main")]])
end)

AddEventHandler("interaction:weapon_options", function(model)
	exports.ui:reset()
	exports.ui:open("weapons")
	exports.ui:addOption("Give", "interaction:give_weapon", model)
	exports.ui:addOption("Destroy", "interaction:destroy_weapon", model)
    exports.ui:back([[TriggerEvent("interaction:weapons")]])
end)
--[[ Weapon Functions ]]--
AddEventHandler("interaction:give_weapon", function(model)
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	TriggerServerEvent("weapon:give", model, GetPlayerServerId(t))
    else
        Messages(5)
    end
end)

AddEventHandler("interaction:destroy_weapon", function(model)
    TriggerServerEvent("weapon:destroy", model, FindNearbyPlayers(8))
end)
--[[ Key menu ]]--
AddEventHandler("interaction:keys", function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Car keys", [[TriggerEvent("keys:menu")]])
	exports.ui:addOption("Handcuff keys", [[TriggerEvent("interaction:handcuff_keys")]])
	exports.ui:back([[TriggerEvent("interaction:main")]])
end)
--[[ Phone/Wallet Menu ]]--
AddEventHandler("interaction:wallet", function()
	exports.ui:reset()
	exports.ui:open()
	if not IsInJail() and not exports.policejob:getIsCuffed() and not isCuffed() then
		exports.ui:addOption("Phone", [[TriggerEvent("Phone.Open")]])
	end

	exports.ui:addOption("Licenses", [[TriggerEvent("interaction:licenses")]])
	exports.ui:addOption("Give money", [[TriggerEvent("interaction:give_money")]])
	exports.ui:addOption("Give dirty", [[TriggerEvent("interaction:give_dirtymoney")]])
	exports.ui:addOption("Voice", [[TriggerEvent("interaction:voice")]])
	exports.ui:addOption("Toggle hud", [[TriggerEvent("interaction:hud")]])
	exports.ui:back([[TriggerEvent("interaction:main")]])
end)

AddEventHandler("interaction:licenses",function()
	exports.ui:reset()
	exports.ui:open("licenses")
	if tobool(weapon_license) then
		exports.ui:addOption("Weapon license", [[]])
	end
	if tobool(drivers_license) then
		exports.ui:addOption("Drivers license", [[]])
	end
	exports.ui:back([[TriggerEvent("interaction:wallet")]])
end)

AddEventHandler("interaction:voice",function()
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Whisper", [[TriggerEvent("interaction:voice_change", 1)]])
	exports.ui:addOption("Normal", [[TriggerEvent("interaction:voice_change",  2)]])
	exports.ui:addOption("Shout", [[TriggerEvent("interaction:voice_change",  3)]])
	exports.ui:back([[TriggerEvent("interaction:wallet")]])
end)

--[[ Phone/Wallet Menu Functions ]]--
AddEventHandler("interaction:give_money",function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	local amount = tonumber(KeyboardInput("Enter amount:", 0, 10))
		if amount ~= nil then
			if math.floor(amount) > 0 then
            	TriggerServerEvent("interaction:givemoney", math.floor(amount), GetPlayerServerId(t))
            else
            	TriggerEvent("interaction:wallet")
            end
        else
        	TriggerEvent("interaction:wallet")
        end
    else
        Messages(5)
    end
end)

--[[ Phone/Wallet Menu Functions ]]--
RegisterNetEvent("interaction:give_money_ID")
AddEventHandler("interaction:give_money_ID",function(Amount, Id)
	local Target = GetPlayerPed(GetPlayerFromServerId(Id))
	local Ped = PlayerPedId()
	local TargetPosition = GetEntityCoords(Target, 0)
	local PlayerPosition = GetEntityCoords(Ped, 0)
	local Distance = #(PlayerPosition - TargetPosition)
	if not exports.policejob:getIsCuffed() and not isCuffed() then
		if not IsPlayerDead(Ped) and not IsEntityDead(Ped) then
			if Target ~= Ped and GetPlayerFromServerId(Id) ~= nil and Target ~= nil then
			    if(Distance ~= -1 and Distance < 3) then
					if Amount ~= nil then
						if math.floor(Amount) > 0 then
			            	TriggerServerEvent("interaction:givemoney", math.floor(Amount), Id)
			            else
			            	TriggerEvent("interaction:wallet")
			            end
			        else
			        	TriggerEvent("interaction:wallet")
			        end
			    else
			        Messages(5)
			    end
			else
				Notify("This player doesn't exist, and also can't be yourself!", 2500)
			end
		else
			Notify("You can't give someone money while dead!", 2500)
		end
	else
		Notify("You can't give money while restrained!", 2500)
	end
end)

RegisterNetEvent("interaction:give_dirtymoney_ID")
AddEventHandler("interaction:give_dirtymoney_ID",function(Amount, Id)
	local Target = GetPlayerPed(GetPlayerFromServerId(Id))
	local Ped = PlayerPedId()
	local TargetPosition = GetEntityCoords(Target, 0)
	local PlayerPosition = GetEntityCoords(Ped, 0)
	local Distance = #(PlayerPosition - TargetPosition)
	if not exports.policejob:getIsCuffed() and not isCuffed() then
		if not IsPlayerDead(Ped) and not IsEntityDead(Ped) then
			if Target ~= Ped and GetPlayerFromServerId(Id) ~= nil and Target ~= nil then
			    if(Distance ~= -1 and Distance < 3) then
					if Amount ~= nil then
						if math.floor(Amount) > 0 then
			            	TriggerServerEvent("interaction:givedmoney", math.floor(Amount), Id)
			            else
			            	TriggerEvent("interaction:wallet")
			            end
			        else
			        	TriggerEvent("interaction:wallet")
			        end
			    else
			        Messages(5)
			    end
			else
				Notify("This player doesn't exist, and also can't be yourself!", 2500)
			end
		else
			Notify("You can't give someone money while dead!", 2500)
		end
	else
		Notify("You can't give money while restrained!", 2500)
	end
end)

AddEventHandler("interaction:give_dirtymoney", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	local amount = tonumber(KeyboardInput("Enter amount:", 0, 10))
        if amount ~= nil then
        	if math.floor(amount) > 0 then
            	TriggerServerEvent("interaction:givedmoney", math.floor(amount), GetPlayerServerId(t))
            else
            	TriggerEvent("interaction:wallet")
            end
        else
        	TriggerEvent("interaction:wallet")
        end
    else
        Messages(5)
    end
end)

AddEventHandler("interaction:showid", function()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerEvent("gcl:showItentity")
	else
		TriggerEvent("gcl:openMeIdentity")
	end
end)

RegisterNetEvent("interaction:set_drivers_license")
AddEventHandler("interaction:set_drivers_license", function(_license)
	drivers_license = _license
	if exports.ui:currentmenu() == "licenses" then
		TriggerEvent("interaction:licenses")
	end
end)

RegisterNetEvent("interaction:controller")
AddEventHandler("interaction:controller", function()
	controller = not controller
end)

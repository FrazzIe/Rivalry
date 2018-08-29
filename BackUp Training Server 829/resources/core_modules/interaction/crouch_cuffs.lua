--[[
	Script created by: Frazzle

	Contact: frazzle9999@gmail.com

	Note: this script is licensed under "No License", you are allowed to:

	Use and Edit the Script.

	you are not allowed to:

	Copy, re-release, re-distribute it without my written permission.
--]]
--[[ HANDS UP ]]--
local handcuffs = {}
local handcuff_keys = {}
local cuffed = false
local cuffable = false
--[[ STANCE ]]--
local stance = "standing"
local Timer = {}
local time = 0
local time_on = false
local lastanim = "onfront_fwd"
IsStanceAllowed = true
--[[ DRAG ]]--
local drag = false
local draggedBy = -1
local wasDragged = false

function StanceAllowed(value)
	if type(value) == "boolean" then
		IsStanceAllowed = value
	else
		return IsStanceAllowed
	end
end

--[[ STANCE ]]--
function Timer.start()
	time_on = true
	Citizen.CreateThread(function()
		while time_on do
			Citizen.Wait(1)
			time = time + 1
		end
	end)
end

function Timer.stop()
	time_on = false
end

function Timer.reset()
	time = 0
end

function setStance(_stance)
	if _stance == "standing" then
		ClearPedTasks(PlayerPedId())
		ResetPedMovementClipset(PlayerPedId(), 0)
		if stance == "prone" then
			TaskPlayAnim(PlayerPedId(), "get_up@directional@movement@from_knees@action", "getup_l_0", 8.0, -8.0, -1, 0, 0, false, false, false)
		end
		stance = "standing"
	elseif _stance == "crouch" then
		ClearPedTasks(PlayerPedId())
		SetPedMovementClipset(PlayerPedId(), "move_ped_crouched", 0.25)
		stance = "crouch"
	elseif _stance == "prone" then
		ClearPedTasksImmediately(PlayerPedId())
		if IsPedArmed(PlayerPedId(), 6) then
			TaskAimGunScripted(PlayerPedId(), GetHashKey("SCRIPTED_GUN_TASK_PLANE_WING"), 1, 1)
		else
			if lastanim == "onfront_bwd" then
				TaskPlayAnim(PlayerPedId(), "move_crawl", "onfront_bwd", 8.0, -4.0, -1, 2, 0, false, false, false)
			elseif lastanim == "onfront_fwd" then
				TaskPlayAnim(PlayerPedId(), "move_crawl", "onfront_fwd", 8.0, -4.0, -1, 2, 0, false, false, false)
			end
		end
		stance = "prone"
	end
end

function ProneMovement()
	if IsControlPressed(0, 34) then
		SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) + 1.5)
	elseif IsControlPressed(0, 35) then
		SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 1.5)
	end
	if IsControlJustPressed(0, 32) or IsControlJustPressed(0, 33) then
		if IsEntityPlayingAnim(PlayerPedId(), "move_crawl", "onfront_bwd", 3) then
			StopAnimTask(PlayerPedId(), "move_crawl", "onfront_bwd", 0)
		elseif IsEntityPlayingAnim(PlayerPedId(), "move_crawl", "onfront_fwd", 3) then
			StopAnimTask(PlayerPedId(), "move_crawl", "onfront_fwd", 0)
		end
	elseif IsControlPressed(0, 32) then
		if not IsEntityPlayingAnim(PlayerPedId(), "move_crawl", "onfront_fwd", 3) then
			TaskPlayAnim(PlayerPedId(), "move_crawl", "onfront_fwd", 8.0, -4.0, -1, 9, 0, false, false, false)
			lastanim = "onfront_fwd"
		end
	elseif IsControlPressed(0, 33) then
		if not IsEntityPlayingAnim(PlayerPedId(), "move_crawl", "onfront_bwd", 3) then
			TaskPlayAnim(PlayerPedId(), "move_crawl", "onfront_bwd", 8.0, -4.0, -1, 9, 0, false, false, false)
			lastanim = "onfront_bwd"
		end
	elseif IsControlJustReleased(0, 32) or IsControlJustReleased(0, 33) then
		ClearPedTasks(PlayerPedId())
		if IsPedArmed(PlayerPedId(), 6) then
			TaskAimGunScripted(PlayerPedId(), GetHashKey("SCRIPTED_GUN_TASK_PLANE_WING"), 1, 1)
		else
			if lastanim == "onfront_bwd" then
				TaskPlayAnim(PlayerPedId(), "move_crawl", "onfront_bwd", 8.0, -4.0, -1, 2, 0, false, false, false)
			elseif lastanim == "onfront_fwd" then
				TaskPlayAnim(PlayerPedId(), "move_crawl", "onfront_fwd", 8.0, -4.0, -1, 2, 0, false, false, false)
			end
		end
	end
end

Citizen.CreateThread(function()
	RequestAnimSet("move_ped_crouched")
	RequestAnimSet("move_ped_crouched_strafing")
	RequestAnimDict("move_crawl")

	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()

		if DoesEntityExist(PlayerPed) and not IsEntityDead(PlayerPed) then 
			DisableControlAction(0, 36, true)
			if not IsPauseMenuActive() then
				if not IsPedSittingInAnyVehicle(PlayerPed) then
					if stance == "standing" then
						if IsDisabledControlPressed(0, 36) and IsStanceAllowed then 
							Timer.start()
						elseif IsDisabledControlJustReleased(0, 36) and IsStanceAllowed then
							if time >= 250 then
								if not cuffed and not exports.policejob:getIsCuffed() then
									if IsPedSprinting(PlayerPed) or IsPedRunning(PlayerPed) then
										ClearPedTasks()
										TaskPlayAnim(PlayerPed, "move_jump", "dive_start_run", 8.0, -8.0, -1, 0, 0, false, false, false)
										Citizen.Wait(1000)
										setStance("prone")
									else
										setStance("prone")
									end
								else
									setStance("crouch")
								end
							else
								setStance("crouch")
							end
							Timer.stop()
							Timer.reset()
						end
					elseif stance == "crouch" then
						if IsDisabledControlPressed(0, 36) and IsStanceAllowed then
							Timer.start()
						elseif IsDisabledControlJustReleased(0, 36) and IsStanceAllowed then
							if time >= 250 then
								if not cuffed and not exports.policejob:getIsCuffed() then
									setStance("prone")
								else
									setStance("standing")
								end
							else
								setStance("standing")
							end
							Timer.stop()
							Timer.reset()
						end
					elseif stance == "prone" then
						if IsDisabledControlPressed(0, 36) and IsStanceAllowed then
							Timer.start()
						elseif IsDisabledControlJustReleased(0, 36) and IsStanceAllowed then
							if time >= 250 then
								setStance("standing")
							else
								setStance("crouch")
							end
							Timer.stop()
							Timer.reset()
						end
						ProneMovement()				
					end
				else
					if stance ~= "standing" then
						setStance("standing")
					end
				end
			end
		elseif DoesEntityExist(PlayerPed) and IsEntityDead(PlayerPed) then
			if stance ~= "standing" then
				setStance("standing")
			end
		end
	end
end)
--[[ HANDS UP ]]--

Citizen.CreateThread(function()
    local dict = "missminuteman_1ig_2"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    while true do
        Citizen.Wait(0)
        local PlayerPed = PlayerPedId()
        if IsControlJustPressed(1, 323) and not cuffed and not exports.policejob:getIsCuffed() then
            if not cuffable and stance ~= "prone" and not IsPedSittingInAnyVehicle(PlayerPed) then
                TaskPlayAnim(PlayerPed, dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                cuffable = true
            elseif cuffable then
                cuffable = false
                ClearPedSecondaryTask(PlayerPed)
            end
        end
        if cuffable and stance == "prone" then
        	cuffable = false
            ClearPedTasks(PlayerPed)
            if not IsPedArmed(PlayerPed, 6) then
                if lastanim == "onfront_bwd" then
                    TaskPlayAnim(PlayerPed, "move_crawl", "onfront_bwd", 8.0, -4.0, -1, 2, 0, false, false, false)
                elseif lastanim == "onfront_fwd" then
                    TaskPlayAnim(PlayerPed, "move_crawl", "onfront_fwd", 8.0, -4.0, -1, 2, 0, false, false, false)
                end
            end
        end

    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		
		if cuffed and not IsEntityPlayingAnim(PlayerPed, "mp_arresting", "idle", 3) then
			Citizen.Wait(100)
			TaskPlayAnim(PlayerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
		end

		if IsEntityPlayingAnim(PlayerPed, "mp_arresting", "idle", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			SetPedPathCanUseLadders(PlayerPed, false)
			if IsPedInAnyVehicle(PlayerPed, false) then
				DisableControlAction(0, 59, true)
			end
		end
	end
end)

Citizen.CreateThread(function()
	local KnifeHash = GetHashKey("WEAPON_KNIFE")
	while true do
		Citizen.Wait(0)

		local PlayerId = PlayerId()
		local ServerId = GetPlayerServerId(PlayerId)
		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		for PlayerIndex = 0, 32 do
			if NetworkIsPlayerActive(i) then
				if PlayerId ~= PlayerIndex then
					local OtherPed = GetPlayerPed(PlayerIndex)
					if DoesEntityExist(OtherPed) then
						local OtherPlayerPosition = GetEntityCoords(OtherPed, false)
						if GetDistanceBetweenCoords(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, OtherPlayerPosition.x, OtherPlayerPosition.y, OtherPlayerPosition.z, true) < 2 then
							local OtherServerId = GetPlayerServerId(PlayerIndex)
							if handcuffs[OtherServerId] then
								if handcuffs[OtherServerId].cuffed then
									if GetCurrentPedWeapon(PlayerPed, KnifeHash, true) or handcuffs[OtherServerId].keyholder == ServerId then
										DisplayHelpText("Press ~INPUT_CONTEXT~ to uncuff "..exports.core:GetCharacterName(OtherServerId))
										if IsControlJustPressed(1, 51) then
                                    		local uncuffing = GetGameTimer() + 4000
                                    		while uncuffing > GetGameTimer() do
                                        		Citizen.Wait(0)
                                        		PlayerPed = PlayerPedId()

                                        		if not IsEntityPlayingAnim(PlayerPed, "weapons@first_person@aim_idle@p_m_zero@melee@knife@fidgets@b", "fidget_low_loop", 3) then
                                            		TaskPlayAnim(PlayerPed, "weapons@first_person@aim_idle@p_m_zero@melee@knife@fidgets@b", "fidget_low_loop", 8.0, -4.0, -1, 9, 0, false, false, false)
                                        		end
                                    		end
                                    		ClearPedTasks(PlayerPed)

                                    		if not IsEntityDead(PlayerPed) and not cuffed then 
												TriggerServerEvent("handcuffs:uncuff", OtherServerId)
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

RegisterNetEvent("handcuffs:sync")
AddEventHandler("handcuffs:sync", function(_handcuffs)
	handcuffs = _handcuffs
end)

RegisterNetEvent("handcuffs:sync_keys")
AddEventHandler("handcuffs:sync_keys", function(_handcuff_keys)
	handcuff_keys = _handcuff_keys
end)

RegisterNetEvent("handcuffs:check")
AddEventHandler("handcuffs:check", function(_source)
	if cuffable then
		TriggerEvent("handcuffs:cuff")
		TriggerServerEvent("handcuffs:success", _source)
	else
		TriggerServerEvent("handcuffs:fail", "The target must have their hands up", _source)
	end
end)

RegisterNetEvent("handcuffs:cuff")
AddEventHandler("handcuffs:cuff", function()
	if DoesEntityExist(PlayerPedId()) then
		ClearPedTasks(PlayerPedId())
		cuffable = false
		RequestAnimDict("mp_arresting")
		while not HasAnimDictLoaded("mp_arresting") do
			Citizen.Wait(100)
		end

		TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
		SetEnableHandcuffs(PlayerPedId(), true)
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
		cuffed = true
	end
end)

RegisterNetEvent("handcuffs:uncuff")
AddEventHandler("handcuffs:uncuff", function()
	if DoesEntityExist(PlayerPedId()) then
		ClearPedSecondaryTask(PlayerPedId())
		SetEnableHandcuffs(PlayerPedId(), false)
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
		cuffed = false
	end
end)

TriggerServerEvent("handcuffs:reload")

AddEventHandler("interaction:handcuff_keys", function()
	exports.ui:reset()
	exports.ui:open()
	local count = 1
	for k,v in pairs(handcuff_keys) do
		if v ~= nil then
			exports.ui:addOption("Key "..count.." [ID: "..k.."]", "interaction:handcuff_key_options", k)
			count = count + 1
		end
	end
	exports.ui:back([[TriggerEvent("interaction:keys")]])
end)

AddEventHandler("interaction:handcuff_key_options", function(keyid)
	exports.ui:reset()
	exports.ui:open()
	exports.ui:addOption("Give", "handcuffs:give_key", keyid)
	exports.ui:back([[TriggerEvent("interaction:handcuff_keys")]])
end)

AddEventHandler("handcuffs:give_key",function(keyid)
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("handcuffs:give_key", GetPlayerServerId(t), keyid)
    else
        Messages(5)
    end
end)

function isCuffed()
	return cuffed
end

function isCuffable()
	return cuffable
end

RegisterNetEvent('interaction:drag')
AddEventHandler('interaction:drag', function(_source)
	if cuffed then
		drag = not drag
		draggedBy = _source
	end
end)

AddEventHandler('interaction:undrag', function()
	drag = false
	draggedBy = -1
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if drag then
            wasDragged = true
			AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(draggedBy)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
            if not IsPedInParachuteFreeFall(PlayerPedId()) and wasDragged then
                wasDragged = false
                DetachEntity(PlayerPedId(), true, false)    
            end
		end
	end
end)

AddEventHandler("interaction:rob", function()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
    	local target_id = GetPlayerServerId(t)
    	if handcuffs[target_id] then
    		if handcuffs[target_id].cuffed and handcuffs[target_id].keyholder == GetPlayerServerId(PlayerId()) then
    			if server_weapons[target_id] and inventories[target_id] then
    				exports.ui:reset()
    				exports.ui:open("rob")
					exports.ui:addOption("Inventory", "interaction:rob_inventory", target_id)
					exports.ui:addOption("Weapons", "interaction:rob_weapons", target_id)
					exports.ui:addOption("Money", "interaction:rob_money", target_id)
					exports.ui:addOption("Phone", "interaction:rob_phone", target_id)
					exports.ui:back([[TriggerEvent("interaction:actions_emotes")]])			
    			end
    		else
    			Notify("The target is handcuffed, but you do not have the keys!", 3000)
    		end
    	else
    		Notify("The target is not handcuffed!", 3000)
    	end
    else
        Messages(5)
    end
end)

AddEventHandler("interaction:rob_inventory", function(target_id)
	exports.ui:reset()
	exports.ui:open("rob_inventory")
    if handcuffs[target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[target_id].cuffed and handcuffs[target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[target_id] and inventories[target_id] then
					for k,v in pairs(inventories[target_id]) do
						exports.ui:addOption(v.quantity.." | "..v.name, "interaction:rob_inventory_options", {target_id = target_id, item = v})
					end
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
    exports.ui:back([[TriggerEvent("interaction:rob")]])
end)

AddEventHandler("interaction:rob_inventory_options", function(data)
	exports.ui:reset()
	exports.ui:open("rob_inventory")
    if handcuffs[data.target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[data.target_id].cuffed and handcuffs[data.target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[data.target_id] and inventories[data.target_id] then
					exports.ui:addOption("Take "..data.item.name, "interaction:rob_inventory_take", data)
					exports.ui:addOption("Destroy "..data.item.name, "interaction:rob_inventory_destroy", data)    			
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
    exports.ui:back("interaction:rob_inventory", data.target_id)
end)

AddEventHandler("interaction:rob_inventory_take", function(data)
    if handcuffs[data.target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[data.target_id].cuffed and handcuffs[data.target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[data.target_id] and inventories[data.target_id] then
	    			local amount = tonumber(KeyboardInput("Enter quantity:", 0, 10))
			        if amount ~= nil then
			        	if math.floor(amount) > 0 then
				            exports.ui:reset()
				            exports.ui:open("rob_inventory")
				            TriggerServerEvent("inventory:take", tonumber(data.item.item_id), math.floor(amount), data.target_id)
				        else
				        	TriggerEvent("interaction:rob_inventory", data.target_id)
				        end
			        else
			            TriggerEvent("interaction:rob_inventory", data.target_id)
			        end
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
end)

AddEventHandler("interaction:rob_inventory_destroy", function(data)
    if handcuffs[data.target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[data.target_id].cuffed and handcuffs[data.target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[data.target_id] and inventories[data.target_id] then
	    			local amount = tonumber(KeyboardInput("Enter quantity:", 0, 10))
			        if amount ~= nil then
			        	if math.floor(amount) > 0 then
				            exports.ui:reset()
				            exports.ui:open("rob_inventory")
				            TriggerServerEvent("inventory:destroy", tonumber(data.item.item_id), math.floor(amount), data.target_id)
				        else
				        	TriggerEvent("interaction:rob_inventory", data.target_id)
				        end
			        else
			            TriggerEvent("interaction:rob_inventory", data.target_id)
			        end  
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
end)

AddEventHandler("interaction:rob_weapons", function(target_id)
	exports.ui:reset()
	exports.ui:open("rob_weapons")
    if handcuffs[target_id] then
    	local target_ped = GetPlayerPed(GetPlayerFromServerId(target_id))
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(target_ped, false)
    	if handcuffs[target_id].cuffed and handcuffs[target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[target_id] and inventories[target_id] then
					for k,v in pairs(server_weapons[target_id]) do
				    	if GetMaxAmmoInClip(target_ped, GetHashKey(k), 1) ~= 0 then
				    		exports.ui:addOption(Weapons_names[k].." ["..v.ammo.."]", "interaction:rob_weapons_options", {target_id = target_id, weapon = v})
				    	else
				    		exports.ui:addOption(Weapons_names[k], "interaction:rob_weapons_options", {target_id = target_id, weapon = v})
				    	end
					end
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
    exports.ui:back([[TriggerEvent("interaction:rob")]])
end)

AddEventHandler("interaction:rob_weapons_options", function(data)
	exports.ui:reset()
	exports.ui:open("rob_weapons")
    if handcuffs[data.target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[data.target_id].cuffed and handcuffs[data.target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[data.target_id] and inventories[data.target_id] then
					exports.ui:addOption("Take "..Weapons_names[data.weapon.model], "interaction:rob_weapons_take", data)
					exports.ui:addOption("Destroy "..Weapons_names[data.weapon.model], "interaction:rob_weapons_destroy", data)    
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
    exports.ui:back([[TriggerEvent("interaction:rob_weapons")]])
end)

AddEventHandler("interaction:rob_weapons_take", function(data)
    if handcuffs[data.target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[data.target_id].cuffed and handcuffs[data.target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[data.target_id] and inventories[data.target_id] then
					exports.ui:reset()
					exports.ui:open("rob_weapons")
					TriggerServerEvent("weapon:take", data.weapon.model, data.target_id)
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
end)

AddEventHandler("interaction:rob_weapons_destroy", function(data)
    if handcuffs[data.target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[data.target_id].cuffed and handcuffs[data.target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[data.target_id] and inventories[data.target_id] then
					exports.ui:reset()
					exports.ui:open("rob_weapons")
					TriggerServerEvent("weapon:destroy_target", data.weapon.model, data.target_id)
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
end)

AddEventHandler("interaction:rob_money", function(target_id)
	exports.ui:reset()
	exports.ui:open("rob_money")
    if handcuffs[target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[target_id].cuffed and handcuffs[target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[target_id] and inventories[target_id] then
					exports.ui:addOption("Take ", "interaction:rob_money_take", target_id)
					exports.ui:addOption("Destroy ", "interaction:rob_money_destroy", target_id)    
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
    exports.ui:back([[TriggerEvent("interaction:rob")]])
end)

AddEventHandler("interaction:rob_money_take", function(target_id)
    if handcuffs[target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[target_id].cuffed and handcuffs[target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[target_id] and inventories[target_id] then
					TriggerServerEvent("interaction:take_money", target_id)
					TriggerEvent("interaction:rob")
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
end)

AddEventHandler("interaction:rob_money_destroy", function(target_id)
    if handcuffs[target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[target_id].cuffed and handcuffs[target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[target_id] and inventories[target_id] then
					TriggerServerEvent("interaction:destroy_money", target_id)
					TriggerEvent("interaction:rob")
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
end)

AddEventHandler("interaction:rob_phone", function(target_id)
    if handcuffs[target_id] then
    	local player_pos, target_pos = GetEntityCoords(PlayerPedId(), false), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target_id)), false)
    	if handcuffs[target_id].cuffed and handcuffs[target_id].keyholder == GetPlayerServerId(PlayerId()) then
    		if GetDistanceBetweenCoords(player_pos.x, player_pos.y, player_pos.z, target_pos.x, target_pos.y, target_pos.z, true) < 3 then
	    		if server_weapons[target_id] and inventories[target_id] then
					TriggerServerEvent("interaction:take_phone", target_id)
					TriggerEvent("interaction:rob")
	    		end
	    	else
	    		Notify("You're not close enough to the target!", 3000)
	    	end
	    else
	    	Notify("The target is handcuffed, but you do not have the keys!", 3000)
    	end
    else
    	Notify("The target is not handcuffed!", 3000)
    end
end)
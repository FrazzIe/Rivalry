SelectedEvidence = 0
SelectedEvidenceFP = 0
function Chat_Message(Author, Message, R, G, B, Multiline, Template)
	local Data = {
		color = {tonumber(R) or 255, tonumber(G) or 255,tonumber(B) or 255},
		multiline = Multiline or false,
		args = {},
	}
	if type(Author) == "string" then table.insert(Data.args, Author) end
	if type(Message) == "string" then table.insert(Data.args, Message) end
	if type(Template) == "string" then Data.templateId = Template end
	TriggerEvent("chat:addMessage", Data)
end

function Chat_Command(Command, Callback, Restricted, Suggestions)
    if type(Command) ~= "string" and type(Command) ~= "table" then
        return --Log.Error("Unable to add command!")
    end
    if type(Callback) ~= "function" then return --[[Log.Error("Unable to add command!")]] end
    if type(Restricted) ~= "boolean" then Restricted = false end

    if type(Command) == "table" then
        for Index = 1, #Command do
            RegisterCommand(Command[Index], function(source, args, fullCommand)
                Callback(source, args, fullCommand)
            end, Restricted)
            
            if Suggestions then
                Chat_Suggestion(Command[Index], Suggestions.Help or "", Suggestions.Params or {})
            end
        end
    else
        RegisterCommand(Command, function(source, args, fullCommand)
            Callback(source, args, fullCommand)
        end, Restricted)

        if Suggestions then
            Chat_Suggestion(Command, Suggestions.Help or "", Suggestions.Params or {})
        end
    end
end

function Chat_Suggestion(Command, Help, Params)
	if type(Help) ~= "string" then	Help = "" end
	if type(Params) ~= "table" then Params = {} end

	if type(Command) == "string" then
		if not string.starts(Command, "/") then 
			Command = "/" .. Command 
		end

		TriggerEvent("chat:addSuggestion", Command, Help, Params)
	elseif type(Command) == "table" then
		for Index = 1, #Command do
			if not string.starts(Command[Index], "/") then 
				Command[Index] = "/" .. Command 
			end
		end

		for Index = 1, #Command do
			TriggerEvent("chat:addSuggestion", Command[Index], Help, Params)
		end
	else
		return
	end
end

AddEventHandler("playerSpawned", function()
	Chat_Command("spikes", function(source, args, rawCommand)
		if isInService then
			TriggerEvent("Spikes.Create", 3)
		end
	end, false, {Help = "Toggle spike strips",  Params = {}})

	Chat_Command("speedtrap", function(source, args, rawCommand)
		if isInService then
			TriggerEvent("PortableRadar.Create")
		end
	end, false, {Help = "Toggle speed camera",  Params = {}})

	Chat_Command("mdt", function(source, args, rawCommand)
		if isInService or exports.emsjob:getIsInService() or exports.core_modules:DOJonduty() then
			TriggerEvent("mdt.toggle")
		end
	end, false, {Help = "Open the MDT",  Params = {}})

	Chat_Command("investigate", function(source, args, rawCommand)
		TriggerEvent("Police.Forensics.Toggle.InvestigationMode")
	end, false, {Help = "Toggle inspection mode", Params = {}})

	Chat_Command("evidence", function(source, args, rawCommand)
		if args[2] then
			if args[1] == "fp" or args[1] == "wep" or args[1] == "bl" then
				if isInService then
					if args[1] == "wep" and tonumber(args[2]) ~= 0 then
						SelectedEvidence = tonumber(args[2])
					elseif args[1] == "fp" and tonumber(args[2]) ~= 0 then
						SelectedEvidenceFP = tonumber(args[2])
					else
						Notify("Zero is a invalid input!")
					end
				end
			end
		end
	end, false, {Help = "Selected Evidence", Params = {{name = "type", help = "wep | fp"},{name = "number", help = "integer"}}})

	Chat_Command("showevidence", function(source, args, rawCommand)
		if args[1] == "fp" or args[1] == "wep" or args[1] == "bl" then
			if isInService then
				if args[1] == "wep"  then
					TriggerServerEvent("Forensics.List.Evidence", "BulletCasings")
				elseif args[1] == "fp" then
					TriggerServerEvent("Forensics.List.Evidence", "FingerPrints")
				else
					Notify("Invalid input!")
				end
			end
		end
	end, false, {Help = "Show Evidence", Params = {{name = "type", help = "wep | fp"}}})

	Chat_Command("removeevidence", function(source, args, rawCommand)
		if args[2] then
			if args[1] == "fp" or args[1] == "wep" or args[1] == "bl" then
				if isInService then
					if args[1] == "wep" and tonumber(args[2]) ~= 0 then
						TriggerServerEvent("Forensics.Remove.Evidence", "BulletCasings", tonumber(args[2]))
					elseif args[1] == "fp" and tonumber(args[2]) ~= 0 then
						TriggerServerEvent("Forensics.Remove.Evidence", "FingerPrints", tonumber(args[2]))
					else
						Notify("Zero is a invalid input!")
					end
				end
			end
		end
	end, false, {Help = "Remove Evidence", Params = {{name = "type", help = "wep | fp"},{name = "number", help = "integer"}}})

	Chat_Command("swab", function(source, args, rawCommand)
		if isInService then
			local pos = GetEntityCoords(PlayerPedId(), false)
			local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
			local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
			local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
			if vehicleHandle ~= nil then
				TriggerEvent("Police.Swab.Vehicle", GetVehicleNumberPlateText(vehicleHandle))
			else
				Notify("Couldn't find a vehicle!", 2500)
			end
		end
	end, false, {Help = "This swabs a vehicle for fingerprints.", Params = {}})

	Chat_Command("charge", function(source, args, rawCommand)
		if args[1] then
			if args[1] == "review" or args[1] == "clear" or args[1] == "apply" then
				if isInService then
					TriggerEvent("police:"..args[1].."_charge", true)
				end
			else
				Chat_Message("Error", "^0Invalid Syntax: option", 255, 0, 0, true)
			end
		end
	end, false, {Help = "Review, apply or clear charges", Params = {{name = "type", help = "apply | clear | review"}}})

	Chat_Command("drag", function(source, args, rawCommand)
		local InServiceParamedic = exports["emsjob"]:getIsInService()
		if isInService or InServiceParamedic then
		    local t, distance = GetClosestPlayer()
		    if(distance ~= -1 and distance < 3) then
		    	TriggerServerEvent(((isInService == true) and "police:drag" or "paramedic:drag"), GetPlayerServerId(t))
		    else
		        Notify("Please get closer to the target!", 2500)
		    end
		end
	end, false, {help = "Toggle drag the closest player",  params = {}})

	Chat_Command("impound", function(source, args, rawCommand)
		if isInService then
			TriggerEvent("police:menu_vehicle_impound", 0)
		end
	end, false, {Help = "Impound, costs the owner nothing",  Params = {}})

	Chat_Command("impound3", function(source, args, rawCommand)
		if isInService then
			TriggerEvent("police:menu_vehicle_impound", 5000)
		end
	end, false, {Help = "Impound, costs the owner $3000",  Params = {}})

	Chat_Command("force", function(source, args, rawCommand)
		local InServiceParamedic = exports["emsjob"]:getIsInService()
		if isInService or InServiceParamedic then
		    local t, distance = GetClosestPlayer()
		    if(distance ~= -1 and distance < 3) then
		    	if IsPedSittingInAnyVehicle(GetPlayerPed(t)) then
		    		TriggerServerEvent(((isInService == true) and "police:force" or "paramedic:force"), GetPlayerServerId(t), "out")
		    	else
		    		TriggerServerEvent(((isInService == true) and "police:force" or "paramedic:force"), GetPlayerServerId(t), "in")
		    	end
		    else
		        Notify("Please get closer to the target!", 2500)
		    end
		end
	end, false, {Help = "Force someone in/out of a vehicle", Params = {}})

	Chat_Command("gsr", function(source, args, rawCommand)
		if isInService then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				isGSRactive = DecorGetBool(GetPlayerPed(t), "GSR_Active")
				if isGSRactive then
					Notify("Subject tested <b style='color:red'>Positive</b><br>They have discharged a firearm recently!", 3000)
				else
					Notify("Subject tested <b style='color:lime'>Negative</b><br>They haven't discharged a firearm recently!", 3000)
				end
			else
				Notify("Please get closer to the target!", 2500)
			end
		end
	end, false, {Help = "Test someone for gun residue", Params = {}})

	Chat_Command("frisk", function(source, args, rawCommand)
		if isInService then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				RequestAnimDict("car_steal_3_mcs_3-4")
				while not HasAnimDictLoaded("car_steal_3_mcs_3-4") do
					Wait(0)
				end
				TriggerServerEvent("police:frisk", GetPlayerServerId(t))
				PlayerPosition = GetEntityCoords(PlayerPedId())
				PlayerRotation = GetEntityRotation(PlayerPedId())
				TaskPlayAnimAdvanced(PlayerPedId(), "car_steal_3_mcs_3-4", "player_two_dual-4", PlayerPosition.x, PlayerPosition.y, PlayerPosition.z, PlayerRotation.x, PlayerRotation.y, PlayerRotation.z, 2.0, 2.0, -1, 48, 0.7, false, false, false)
			else
				Notify("Please get closer to the target!", 2500)
			end
		end
	end, false, {Help = "Frisk someone for weapons.", Params = {}})
	
	Chat_Command("search", function(source, args, rawCommand)
		if args[2] then
			if args[1] == "p" or args[1] == "v" or args[1] == "vehicle" or args[1] == "person" then
				if isInService then
					if (args[1] == "p" or args[1] == "person") and (args[2] == "weapons" or args[2] == "id" or args[2] == "wl" or args[2] == "dl" or args[2] == "inventory" or args[2] == "wallet") then
						local t, distance = GetClosestPlayer()
						if(distance ~= -1 and distance < 3) then
							TriggerServerEvent("police:search", GetPlayerServerId(t), args[2])
						else
							Notify("Please get closer to the target!", 2500)
						end
					elseif (args[1] == "v" or args[1] == "vehicle") and (args[2] == "weapons" or args[2] == "inventory") then
						local pos = GetEntityCoords(PlayerPedId(), false)
						local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
						local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
						local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
						if vehicleHandle ~= nil then
							TriggerServerEvent("police:search_vehicle", GetVehicleNumberPlateText(vehicleHandle), args[2])
						else
							Notify("Couldn't find a vehicle!", 2500)
						end
					else
						Chat_Message("Error", "^0Invalid Syntax", 255, 0, 0, true)
					end
				end
			else
				Chat_Message("Error", "^0Invalid Syntax", 255, 0, 0, true)
			end
		end
	end, false, {Help = "Search stuff", Params = {{name = "target", help = "p | person | v | vehicle"}, {name = "type", help = "weapons | id | wl (weapons license) | dl (drivers license) | inventory | wallet"}}})

	Chat_Command("seize", function(source, args, rawCommand)
		if args[2] then
			if args[1] == "p" or args[1] == "v" or args[1] == "vehicle" or args[1] == "person" then
				if isInService then
					if (args[1] == "p" or args[1] == "person") and (args[2] == "weapons" or args[2] == "wl" or args[2] == "dl" or args[2] == "inventory" or args[2] == "wallet" or args[2] == "phone") then
						local t, distance = GetClosestPlayer()
						if(distance ~= -1 and distance < 3) then
							TriggerServerEvent("police:seize", GetPlayerServerId(t), args[2])
						else
							Notify("Please get closer to the target!", 2500)
						end
					elseif (args[1] == "v" or args[1] == "vehicle") and (args[2] == "weapons" or args[2] == "inventory") then
						local pos = GetEntityCoords(PlayerPedId(), false)
						local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
						local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
						local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
						if vehicleHandle ~= nil then
							TriggerServerEvent("police:seize_vehicle", GetVehicleNumberPlateText(vehicleHandle), args[2])
						else
							Notify("Couldn't find a vehicle!", 2500)
						end
					else
						Chat_Message("Error", "^0Invalid Syntax: type", 255, 0, 0, true)
					end
				end
			else
				Chat_Message("Error", "^0Invalid Syntax: target", 255, 0, 0, true)
			end
		end
	end, false, {Help = "Seize stuff", Params = {{name = "target", help = "p | person | v | vehicle"}, {name = "type", help = "weapons | wl (weapons license) | dl (drivers license) | inventory | wallet | phone"}}})

	Chat_Command("highvis", function(source, args, rawCommand)
			if isInService then
				RequestAnimDict("switch@franklin@getting_ready")
				while not HasAnimDictLoaded("switch@franklin@getting_ready") do
					Wait(0)
				end
				TaskPlayAnim(PlayerPedId(), "switch@franklin@getting_ready", "002334_02_fras_v2_11_getting_dressed_exit", 4.0, -4, -1, 1, 0, false, false, false)
				Wait(500)
				if not vestOn then
					vestOn = true
					if IsPedMale(PlayerPedId()) then
						SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0)
					elseif not IsPedMale(PlayerPedId()) then
						SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0)
					end
				else
					vestOn = false
					if IsPedMale(PlayerPedId()) then
						SetPedComponentVariation(PlayerPedId(), 9, 18, 0, 0)
					elseif not IsPedMale(PlayerPedId()) then
						SetPedComponentVariation(PlayerPedId(), 9, 21, 0, 0)
					end
				end
				Wait(1700)
				ClearPedTasks(PlayerPedId())
			end
	end, false, {Help = "Put on vest!", Params = {}})
end)
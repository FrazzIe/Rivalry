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
		if isInService then
			TriggerEvent("mdt:open")
		end
	end, false, {Help = "Open the MDT",  Params = {}})

	Citizen.CreateThread(function()
		Chat.Template("policedispatch", "<img src=\"data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA0NTkuNjY4IDQ1OS42NjgiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDQ1OS42NjggNDU5LjY2ODsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSIxNnB4IiBoZWlnaHQ9IjE2cHgiPgo8ZyBpZD0iWE1MSURfMl8iPgoJPGc+CgkJPGc+CgkJCTxwYXRoIGQ9Ik0zNTkuNTc0LDI5Ny4wNDNjLTE4LjIwNCwyNS4wMDItNDcuNjkyLDQxLjI4Ni04MC45MTYsNDEuMjg2aC00Ni42MThjLTE2LjEwNCwwLTI5LjgxOC0xMC4yMjQtMzUuMDExLTI0LjUzNCAgICAgYy02LjQxLTEuOTEyLTEyLjY5Ni00LjM5NC0xOC44My03LjQ0MmMtMTIuOTktNi40NTQtMjQuNzg1LTE1LjE5OC0zNS4xNjgtMjYuMDNjLTY3LjM1LDE0Ljc5Ni0xMTcuNzU3LDc0LjgwOC0xMTcuNzU3LDE0Ni42MDMgICAgIHY5LjM4NGMwLDEyLjksMTAuNDU4LDIzLjM1OCwyMy4zNTgsMjMuMzU4aDM2Mi40MDNjMTIuOSwwLDIzLjM1OC0xMC40NTgsMjMuMzU4LTIzLjM1OHYtOS4zODQgICAgIEM0MzQuMzkyLDM3MS40NjQsNDA0LjMwOSwzMjMuMDMyLDM1OS41NzQsMjk3LjA0M3oiIGZpbGw9IiMxNDc1YmEiLz4KCQkJPHBhdGggZD0iTTExOC4yMDUsMjMyLjE3OGMxMC4wMzksMCwxOC43NzctNS41NjQsMjMuMzA0LTEzLjc3NWMwLjExOSwwLjMyNSwwLjI0LDAuNjQ4LDAuMzYyLDAuOTcxICAgICBjMC4wMzYsMC4wOTcsMC4wNzIsMC4xOTQsMC4xMDgsMC4yOTFjMTAuNjIsMjcuOTU0LDMxLjI4NCw1MS4zODgsNTguNTMyLDYxLjYyN2M2LjU5LTEwLjQ3MSwxOC4yNDMtMTcuNDM1LDMxLjUzLTE3LjQzNWg0Ni42MTggICAgIGM0LjY1LDAsOC45NzgtMS4zMTIsMTIuNzcyLTMuNDMzYzYuMzcyLTMuNTYzLDEyLjEwMi0xMi42MDIsMTUuMDYxLTE3LjM5M2M0LjczNS03LjY2Nyw4LjQwNC0xNS43ODgsMTEuNjU3LTI0LjY0MiAgICAgYzEuODI4LDMuMzIsNC4zNDIsNi4yMDgsNy4zNTQsOC40NzF2MTEuNDMxYzAsMjUuODMtMjEuMDE0LDQ2Ljg0NS00Ni44NDUsNDYuODQ1SDIzMi4wNGMtOC44MTMsMC0xNS45NTgsNy4xNDUtMTUuOTU4LDE1Ljk1OCAgICAgYzAsOC44MTQsNy4xNDUsMTUuOTU4LDE1Ljk1OCwxNS45NThoNDYuNjE4YzQzLjQyOSwwLDc4Ljc2MS0zNS4zMzIsNzguNzYxLTc4Ljc2MVYyMjYuODYgICAgIGM2LjQ2LTQuODUzLDEwLjYzOS0xMi41NzcsMTAuNjM5LTIxLjI3OHYtNDguMTE5di0xOC40NTJjMC04Ljg4LTQuMzU1LTE2LjczNy0xMS4wNDItMjEuNTY4QzM1MS44Myw1MS44MTYsMjk2Ljc3LDAsMjI5LjgzMywwICAgICBDMTYyLjg5NSwwLDEwNy44MzYsNTEuODE2LDEwMi42NSwxMTcuNDQyYy02LjY4Nyw0LjgzMS0xMS4wNDIsMTIuNjg5LTExLjA0MiwyMS41Njh2NjYuNTcgICAgIEM5MS42MDgsMjIwLjMxMSwxMDMuNTc1LDIzMi4xNzgsMTE4LjIwNSwyMzIuMTc4eiBNMjI5LjgzMywzMS45MTdjNDkuNTUyLDAsOTAuNDIzLDM3Ljg2OCw5NS4yLDg2LjE4NSAgICAgYy0zLjEzNiwyLjQ2Ny01LjcwNSw1LjYyLTcuNDc1LDkuMjM4Yy0xNS4wNTgtMzkuMjg2LTQ4LjY3Mi02Ni42MzgtODcuNzI2LTY2LjYzOGMtMzkuODk2LDAtNzIuOTcxLDI4LjI5Mi04Ny42NjcsNjYuNDgxICAgICBjLTAuMDIsMC4wNTItMC4wMzksMC4xMDUtMC4wNTksMC4xNThjLTEuNzctMy42MTgtNC4zMzktNi43NzEtNy40NzUtOS4yMzhDMTM5LjQxMSw2OS43ODUsMTgwLjI4MSwzMS45MTcsMjI5LjgzMywzMS45MTd6IiBmaWxsPSIjMTQ3NWJhIi8+CgkJPC9nPgoJPC9nPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=\" height=\"16\" />  <b>{0}</b>: {1}")
	end)

	Chat_Command("dispatch", function(source, args, rawCommand)
		if isInService then
			local source = source
			if args[2] then
				local Target, Message = args[1], table.concat(args, " ", 2)
				if GetPlayerName(Target) ~= nil then
		        	Chat.Message(Target, "Dispatch: ", Message, 0, 200, 0, true, "policedispatch")
					Chat.Message(source, "Dispatch: ", "Sent \""..Message.."\" to caller "..Target..".", 0, 200, 0, true, "policedispatch")
		        else
		        	Chat.Message(source, "Dispatch: ", "Unable to reach caller "..Target, 0, 200, 0, true, "policedispatch")
		        end
		    end
		end
	end, false, {Help = "Respond back towards a call.", Params = {"id", "message"}})

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

	Chat_Command("impound5", function(source, args, rawCommand)
		if isInService then
			TriggerEvent("police:menu_vehicle_impound", 5000)
		end
	end, false, {Help = "Impound, costs the owner 5k",  Params = {}})

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
end)
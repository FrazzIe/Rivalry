local emergency_users = {}
local pay = {
	["10-15"] = 50,
	["10-31"] = 50,
	["10-32"] = 50,
	["10-90"] = 50,
}

RegisterServerEvent('paramedic:setService')
AddEventHandler('paramedic:setService', function (inService)
	local source = source
	if inService and not emergency_users[source] then
		emergency_users[source] = "paramedic"
	elseif not inService and emergency_users[source] then
		emergency_users[source] = nil
	end
end)

RegisterServerEvent('police:setService')
AddEventHandler('police:setService', function (inService)
	local source = source
	if inService and not emergency_users[source] then
		emergency_users[source] = "cop"
	elseif not inService and emergency_users[source] then
		emergency_users[source] = nil
	end
end)

AddEventHandler("playerDropped", function()
    local source = source
    if emergency_users[source] then
    	emergency_users[source] = nil
    end
end)

AddEventHandler("core:switch", function(source)
    local source = source
    if emergency_users[source] then
    	emergency_users[source] = nil
    end
end)

Citizen.CreateThread(function()
		Chat.Template("policethreeoneone", "<img src=\"data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA1MTEuOTk5IDUxMS45OTkiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMS45OTkgNTExLjk5OTsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSIxNnB4IiBoZWlnaHQ9IjE2cHgiPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0zMTEuMjkzLDMzMi42MTNjLTE2LjcyLDcuOTI4LTM3LjI4NSw1LjE1OC01MS4xLTguNjU3bC03Mi4xNDktNzIuMTVjLTEzLjgxNS0xMy44MTUtMTYuNTg2LTM0LjM3OC04LjY1Ny01MS4wOTggICAgTDUwLjEwNiw3MS40MjZMMzkuNDk0LDgyLjAzNWMtNTIuNjU5LDUyLjY2MS01Mi42NTksMTM4LjMzMSwwLDE5MC45OTJsMTk5LjQ3OCwxOTkuNDc4YzUyLjY1OSw1Mi42NTksMTM4LjMzMSw1Mi42NTksMTkwLjk5MSwwICAgIGwxMC42MTEtMTAuNjExTDMxMS4yOTMsMzMyLjYxM3oiIGZpbGw9IiNEODAwMjciLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik00NzMuODA3LDM2NS41OThsLTYzLjY2NC02My42NjJjLTE3LjU1NC0xNy41NTQtNDYuMTEtMTcuNTU0LTYzLjY2NCwwbC0xMC42MDksMTAuNjA5bDEyNy4zMjYsMTI3LjMyOGwxMC42MTEtMTAuNjExICAgIEM0OTEuMzYsNDExLjcwOCw0OTEuMzYsMzgzLjE1MSw0NzMuODA3LDM2NS41OTh6IiBmaWxsPSIjRDgwMDI3Ii8+Cgk8L2c+CjwvZz4KPGc+Cgk8Zz4KCQk8cGF0aCBkPSJNNDM3LjM5Niw3NC42MDNDMzg5LjI4OCwyNi40OTQsMzI1LjIyLDAsMjU3LjAwNiwwQzI0OC43MTEsMCwyNDIsNi43MTIsMjQyLDE1LjAwNnM2LjcxMiwxNS4wMDYsMTUuMDA2LDE1LjAwNiAgICBjNjAuMTk5LDAsMTE2LjczNCwyMy4zNzMsMTU5LjE3Miw2NS44MTFjNDIuNDM4LDQyLjQzOCw2NS44MTEsOTguOTcyLDY1LjgxMSwxNTkuMTcxYzAsOC4yOTQsNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDYgICAgczE1LjAwNi02LjcxMiwxNS4wMDUtMTUuMDA2QzUxMS45OTksMTg2Ljc4LDQ4NS41MDQsMTIyLjcxMiw0MzcuMzk2LDc0LjYwM3oiIGZpbGw9IiNEODAwMjciLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0zOTUuMzQ0LDExNy4yNTVjLTM2Ljc4Mi0zNi43OTYtODUuNzcxLTU3LjA2My0xMzcuOTM4LTU3LjA2M2MtOC4yOTQsMC0xNS4wMDYsNi43MTItMTUuMDA2LDE1LjAwNiAgICBzNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDZjNDQuMTUzLDAsODUuNjA4LDE3LjE0NiwxMTYuNzE5LDQ4LjI3YzMxLjEyNSwzMS4xMTEsNDguMjcsNzIuNTY3LDQ4LjI3LDExNi43MTkgICAgYzAsOC4yOTQsNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDZjOC4yOTQsMCwxNS4wMDYtNi43MTIsMTUuMDA2LTE1LjAwNkM0NTIuNDA3LDIwMy4wMjUsNDMyLjE0LDE1NC4wMzcsMzk1LjM0NCwxMTcuMjU1eiIgZmlsbD0iI0Q4MDAyNyIvPgoJPC9nPgo8L2c+CjxnPgoJPGc+CgkJPHBhdGggZD0iTTM1Mi45MDYsMTU5LjY5M2MtMjUuNDg0LTI1LjQ5OC01OS40MDgtMzkuNTUxLTk1LjUtMzkuNTUxYy04LjI5NCwwLTE1LjAwNiw2LjcxMi0xNS4wMDYsMTUuMDA2ICAgIGMwLDguMjk0LDYuNzEyLDE1LjAwNiwxNS4wMDYsMTUuMDA2YzI4LjA3NywwLDU0LjQ1NSwxMC45MTcsNzQuMjgxLDMwLjc1OWMxOS44NDEsMTkuODI3LDMwLjc1OSw0Ni4yMDUsMzAuNzU5LDc0LjI4MSAgICBjMCw4LjI5NCw2LjcxMiwxNS4wMDYsMTUuMDA2LDE1LjAwNnMxNS4wMDYtNi43MTIsMTUuMDA2LTE1LjAwNkMzOTIuNDU3LDIxOS4xMDEsMzc4LjQwNCwxODUuMTc3LDM1Mi45MDYsMTU5LjY5M3oiIGZpbGw9IiNEODAwMjciLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0yMTAuNjY1LDEwMi40NThsLTYzLjY2NC02My42NjRjLTE3LjU1Mi0xNy41NTQtNDYuMTEtMTcuNTU0LTYzLjY2MiwwTDcyLjcyNyw0OS40MDVsMTI3LjMyNiwxMjcuMzI2bDEwLjYxMi0xMC42MTEgICAgQzIyOC4yMTksMTQ4LjU2OCwyMjguMjE5LDEyMC4wMDksMjEwLjY2NSwxMDIuNDU4eiIgZmlsbD0iI0Q4MDAyNyIvPgoJPC9nPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=\" height=\"16\" />  <b>{0}</b>: {1}")
		Chat.Template("policenineoneone", "<img src=\"data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTkuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iTGF5ZXJfMSIgeD0iMHB4IiB5PSIwcHgiIHZpZXdCb3g9IjAgMCA1MTEuOTk5IDUxMS45OTkiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMS45OTkgNTExLjk5OTsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSIxNnB4IiBoZWlnaHQ9IjE2cHgiPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0zMTEuMjkzLDMzMi42MTNjLTE2LjcyLDcuOTI4LTM3LjI4NSw1LjE1OC01MS4xLTguNjU3bC03Mi4xNDktNzIuMTVjLTEzLjgxNS0xMy44MTUtMTYuNTg2LTM0LjM3OC04LjY1Ny01MS4wOTggICAgTDUwLjEwNiw3MS40MjZMMzkuNDk0LDgyLjAzNWMtNTIuNjU5LDUyLjY2MS01Mi42NTksMTM4LjMzMSwwLDE5MC45OTJsMTk5LjQ3OCwxOTkuNDc4YzUyLjY1OSw1Mi42NTksMTM4LjMzMSw1Mi42NTksMTkwLjk5MSwwICAgIGwxMC42MTEtMTAuNjExTDMxMS4yOTMsMzMyLjYxM3oiIGZpbGw9IiMwYzI1NWMiLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik00NzMuODA3LDM2NS41OThsLTYzLjY2NC02My42NjJjLTE3LjU1NC0xNy41NTQtNDYuMTEtMTcuNTU0LTYzLjY2NCwwbC0xMC42MDksMTAuNjA5bDEyNy4zMjYsMTI3LjMyOGwxMC42MTEtMTAuNjExICAgIEM0OTEuMzYsNDExLjcwOCw0OTEuMzYsMzgzLjE1MSw0NzMuODA3LDM2NS41OTh6IiBmaWxsPSIjMGMyNTVjIi8+Cgk8L2c+CjwvZz4KPGc+Cgk8Zz4KCQk8cGF0aCBkPSJNNDM3LjM5Niw3NC42MDNDMzg5LjI4OCwyNi40OTQsMzI1LjIyLDAsMjU3LjAwNiwwQzI0OC43MTEsMCwyNDIsNi43MTIsMjQyLDE1LjAwNnM2LjcxMiwxNS4wMDYsMTUuMDA2LDE1LjAwNiAgICBjNjAuMTk5LDAsMTE2LjczNCwyMy4zNzMsMTU5LjE3Miw2NS44MTFjNDIuNDM4LDQyLjQzOCw2NS44MTEsOTguOTcyLDY1LjgxMSwxNTkuMTcxYzAsOC4yOTQsNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDYgICAgczE1LjAwNi02LjcxMiwxNS4wMDUtMTUuMDA2QzUxMS45OTksMTg2Ljc4LDQ4NS41MDQsMTIyLjcxMiw0MzcuMzk2LDc0LjYwM3oiIGZpbGw9IiMwYzI1NWMiLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0zOTUuMzQ0LDExNy4yNTVjLTM2Ljc4Mi0zNi43OTYtODUuNzcxLTU3LjA2My0xMzcuOTM4LTU3LjA2M2MtOC4yOTQsMC0xNS4wMDYsNi43MTItMTUuMDA2LDE1LjAwNiAgICBzNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDZjNDQuMTUzLDAsODUuNjA4LDE3LjE0NiwxMTYuNzE5LDQ4LjI3YzMxLjEyNSwzMS4xMTEsNDguMjcsNzIuNTY3LDQ4LjI3LDExNi43MTkgICAgYzAsOC4yOTQsNi43MTIsMTUuMDA2LDE1LjAwNiwxNS4wMDZjOC4yOTQsMCwxNS4wMDYtNi43MTIsMTUuMDA2LTE1LjAwNkM0NTIuNDA3LDIwMy4wMjUsNDMyLjE0LDE1NC4wMzcsMzk1LjM0NCwxMTcuMjU1eiIgZmlsbD0iIzBjMjU1YyIvPgoJPC9nPgo8L2c+CjxnPgoJPGc+CgkJPHBhdGggZD0iTTM1Mi45MDYsMTU5LjY5M2MtMjUuNDg0LTI1LjQ5OC01OS40MDgtMzkuNTUxLTk1LjUtMzkuNTUxYy04LjI5NCwwLTE1LjAwNiw2LjcxMi0xNS4wMDYsMTUuMDA2ICAgIGMwLDguMjk0LDYuNzEyLDE1LjAwNiwxNS4wMDYsMTUuMDA2YzI4LjA3NywwLDU0LjQ1NSwxMC45MTcsNzQuMjgxLDMwLjc1OWMxOS44NDEsMTkuODI3LDMwLjc1OSw0Ni4yMDUsMzAuNzU5LDc0LjI4MSAgICBjMCw4LjI5NCw2LjcxMiwxNS4wMDYsMTUuMDA2LDE1LjAwNnMxNS4wMDYtNi43MTIsMTUuMDA2LTE1LjAwNkMzOTIuNDU3LDIxOS4xMDEsMzc4LjQwNCwxODUuMTc3LDM1Mi45MDYsMTU5LjY5M3oiIGZpbGw9IiMwYzI1NWMiLz4KCTwvZz4KPC9nPgo8Zz4KCTxnPgoJCTxwYXRoIGQ9Ik0yMTAuNjY1LDEwMi40NThsLTYzLjY2NC02My42NjRjLTE3LjU1Mi0xNy41NTQtNDYuMTEtMTcuNTU0LTYzLjY2MiwwTDcyLjcyNyw0OS40MDVsMTI3LjMyNiwxMjcuMzI2bDEwLjYxMi0xMC42MTEgICAgQzIyOC4yMTksMTQ4LjU2OCwyMjguMjE5LDEyMC4wMDksMjEwLjY2NSwxMDIuNDU4eiIgZmlsbD0iIzBjMjU1YyIvPgoJPC9nPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=\" height=\"16\" />  <b>{0}</b>: {1}")
end)

	Chat.Command("311", function(source, args, rawCommand)
		local source = source
	    local Message = table.concat(args, " ")
	    if Message ~= "" then
			for id, dept in pairs(emergency_users) do
				if dept ~= nil then
	        		Chat.Message(id, "311 - ["..source.."]", Message, 0, 200, 0, true, "policethreeoneone")
					TriggerClientEvent("dispatch:311", id, source, Message)
					TriggerClientEvent("trigger:animation", source)
				end
			end
	    	Chat.Message(source, "311 - ["..source.."]", Message, 0, 200, 0, true, "policethreeoneone")
	    end
	end, false, {Help = "Call for assistance(Non-Emergency)", Params = {"message"}})

	Chat.Command("911", function(source, args, rawCommand)
		local source = source
	    local Message = table.concat(args, " ")
	    if Message ~= "" then
			for id, dept in pairs(emergency_users) do
				if dept ~= nil then
	        		Chat.Message(id, "911 - ["..source.."]", Message, 0, 200, 0, true, "policenineoneone")
					TriggerClientEvent("dispatch:911", id, source, Message)
					TriggerClientEvent("trigger:animation", source)
				end
			end
	    	Chat.Message(source, "911 - ["..source.."]", Message, 0, 200, 0, true, "policenineoneone")
	    end
	end, false, {Help = "Call for assistance(Emergency)", Params = {"message"}})

RegisterServerEvent("dispatch:ten-thirteen")
AddEventHandler("dispatch:ten-thirteen", function(street_name)
	local source = source
	for id, dept in pairs(emergency_users) do
		if dept ~= nil then
			TriggerClientEvent("chatMessage", id, "10-13", {255, 0, 0}, "^7Officer down at "..street_name)
			TriggerClientEvent("dispatch:add_ten-thirteen", id, source)
		end
	end
end)

RegisterServerEvent("dispatch:ten-thirtytwo")
AddEventHandler("dispatch:ten-thirtytwo", function(coords, street_name)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-32", {255, 0, 0}, "^7Shots fired at "..street_name)
			TriggerClientEvent("dispatch:ten-thirtytwo", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-thirtyone")
AddEventHandler("dispatch:ten-thirtyone", function(coords, street_name, model, plate)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-31", {255, 0, 0}, "^7Grand theft auto reported at "..street_name..". Car is a "..model.." with plate "..plate)
			TriggerClientEvent("dispatch:ten-thirtyone", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-thirtyone_2")
AddEventHandler("dispatch:ten-thirtyone_2", function(coords, street_name)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-31", {255, 0, 0}, "^7Possible break-in reported at "..street_name)
			TriggerClientEvent("dispatch:ten-thirtyone_2", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-fifthteen")
AddEventHandler("dispatch:ten-fifthteen", function(coords, street_name, gender)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-15", {255, 0, 0}, "^7Suspicious "..gender.." dealing drugs was reported at "..street_name)
			TriggerClientEvent("dispatch:ten-fifthteen", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:ten-ninety")
AddEventHandler("dispatch:ten-ninety", function(coords, street_name)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "10-90", {255, 0, 0}, "^7A silent alarm has been triggered on "..street_name)
			TriggerClientEvent("dispatch:ten-ninety", id, coords)
		end
	end
end)

RegisterServerEvent("dispatch:pay")
AddEventHandler("dispatch:pay", function(type)
	local source = source
	TriggerEvent("core:getuser", source, function(user)
		TriggerClientEvent("chatMessage", source, "Dispatch", {0, 255, 0}, "^4You have been paid $"..pay[type].." for responding to the "..type)
		user.addWallet(pay[type])
	end)
end)

RegisterServerEvent("dispatch:notify-cops")
AddEventHandler("dispatch:notify-cops", function(message)
	for id, dept in pairs(emergency_users) do
		if dept ~= nil and dept ~= "paramedic" then
			TriggerClientEvent("chatMessage", id, "Dispatch", {0, 255, 0}, "^7"..message)
		end
	end
end)
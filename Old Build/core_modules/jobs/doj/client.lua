DOJ = {}
DOJ.IsDOJ = false
DOJ.Active = false
DOJ.Rank = nil
DOJ.Position = nil
DOJ.Locations = {
	{x = 227.40411376953, y = -414.59469604492, z = -118.19954681396, h = 249.44790649414},
}

function DOJonduty()
	return DOJ.Active
end

function DOJgetrank()
	return DOJ.Rank
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if DOJ.IsDOJ then
			DOJ.Position = GetEntityCoords(PlayerPedId(), false)
			for i = 1, #DOJ.Locations, 1 do
				if GetDistanceBetweenCoords(DOJ.Position.x, DOJ.Position.y, DOJ.Position.z, DOJ.Locations[i].x, DOJ.Locations[i].y, DOJ.Locations[i].z, true) < 20 then
					drawMarker(25, DOJ.Locations[i].x, DOJ.Locations[i].y, DOJ.Locations[i].z, 1.0, 1.0, 1.5, 255, 255, 0, 255)
					if GetDistanceBetweenCoords(DOJ.Position.x, DOJ.Position.y, DOJ.Position.z, DOJ.Locations[i].x, DOJ.Locations[i].y, DOJ.Locations[i].z, true) < 1 then
						if not DOJ.Active then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to ~g~clock in~w~!")
						else
							DisplayHelpText("Press ~INPUT_CONTEXT~ to ~r~clock out~w~!")
						end
						if IsControlJustPressed(1, 51) then
							DOJ.Active = not DOJ.Active
						end
					end
				end
			end
		end
	end
end)

AddEventHandler("DOJ:Menu", function()
	if DOJ.Active and (DOJ.Rank == "chief justice" or DOJ.Rank == "judge") then
		exports.ui:reset()
		exports.ui:open()
		exports.ui:addOption("MDT", [[TriggerEvent("mdt:open")]])
		exports.ui:addOption("Weapons license", [[TriggerEvent("DOJ:Weapon")]])
		exports.ui:addOption("Drivers license", [[TriggerEvent("DOJ:Drivers")]])
		exports.ui:addOption("Optional fine", [[TriggerEvent("DOJ:Fine")]])
		exports.ui:back([[TriggerEvent("interaction:main")]])
	end
	if DOJ.Active and (DOJ.Rank == "assistant district attorney" or DOJ.Rank == "district attorney") then
		exports.ui:reset()
		exports.ui:open()
		exports.ui:addOption("MDT", [[TriggerEvent("mdt:open")]])
		exports.ui:back([[TriggerEvent("interaction:main")]])
	end
end)

AddEventHandler("DOJ:Weapon", function()
	if DOJ.Active and (DOJ.Rank == "chief justice" or DOJ.Rank == "judge") then
		exports.ui:reset()
		exports.ui:open()
		exports.ui:addOption("Grant", [[TriggerEvent("DOJ:Grant", "weapon")]])
		exports.ui:addOption("Seize", [[TriggerEvent("DOJ:Seize", "weapon")]])
		exports.ui:back([[TriggerEvent("DOJ:Menu")]])
	end
end)

AddEventHandler("DOJ:Drivers", function()
	if DOJ.Active and (DOJ.Rank == "chief justice" or DOJ.Rank == "judge") then
		exports.ui:reset()
		exports.ui:open()
		exports.ui:addOption("Grant", [[TriggerEvent("DOJ:Grant", "drivers")]])
		exports.ui:addOption("Seize", [[TriggerEvent("DOJ:Seize", "drivers")]])
		exports.ui:back([[TriggerEvent("DOJ:Menu")]])
	end
end)

AddEventHandler("DOJ:Seize", function(type)
	exports.ui:open()
	local t, distance = GetClosestPlayer()
	if distance ~= -1 and distance < 3 then
		TriggerServerEvent("DOJ:Seize", GetPlayerServerId(t), type)
	else
		Notify("Please get closer to the target!", 2500)
	end
end)

AddEventHandler("DOJ:Grant", function(type)
	exports.ui:open()
	local t, distance = GetClosestPlayer()
	if distance ~= -1 and distance < 3 then
		TriggerServerEvent("DOJ:Grant", GetPlayerServerId(t), type)
	else
		Notify("Please get closer to the target!", 2500)
	end
end)

AddEventHandler("DOJ:Fine", function(type)
	exports.ui:open()
	local t, distance = GetClosestPlayer()
	local amount = tonumber(KeyboardInput("Enter amount:", "0", 11))
	if distance ~= -1 and distance < 3 then
		if amount ~= nil then
			if math.floor(amount) > 0 then
				TriggerServerEvent("DOJ:RequestFine", GetPlayerServerId(t), math.floor(amount))
			else
				Notify("Amount must be a number and greater than zero!", 2500)
				TriggerEvent("DOJ:Menu")
			end
		else
			Notify("Amount must be a number and greater than zero!", 2500)
			TriggerEvent("DOJ:Menu")
		end
	else
		Notify("Please get closer to the target!", 2500)
	end
end)

RegisterNetEvent("DOJ:Set")
AddEventHandler("DOJ:Set", function(_Data, _DOJ, first)
	DOJ.Rank = _Data.rank
	DOJ.IsDOJ = _DOJ
	if not DOJ.IsDOJ and DOJ.Active then
		DOJ.Active = false
		TriggerServerEvent("jobcenter:jobs", 1)
	elseif not DOJ.IsDOJ and not DOJ.Active then
		if not first then
			TriggerServerEvent("jobcenter:jobs", 1)
		end
	elseif DOJ.IsDOJ then
		TriggerServerEvent("jobcenter:jobs", 23)
	end
end)

RegisterNetEvent("DOJ:RequestFine")
AddEventHandler("DOJ:RequestFine", function(amount, source)
    Citizen.CreateThread(function()
        local start, answered = GetGameTimer(), false
        SetInstructionalButtons({
            {GetControlInstructionalButton(1, 7, 0), "No"},
            {GetControlInstructionalButton(1, 246, 0), "Do you accept the fee of $"..amount.." | Yes"},
        }, 0)
        while GetTimeDifference(GetGameTimer(), start) < 30000 and not answered do
            Citizen.Wait(0)
            DrawInstructionalButtons()

            if IsControlJustPressed(1, 246) then
                answered = true
                TriggerServerEvent("DOJ:Fine", source, amount, true)
            elseif IsControlJustPressed(1, 7) then
                answered = true
                TriggerServerEvent("DOJ:Fine", source, amount, false)
            end
        end
        if not answered then
            TriggerServerEvent("DOJ:Fine", source, amount, false)
        end
    end)
end)
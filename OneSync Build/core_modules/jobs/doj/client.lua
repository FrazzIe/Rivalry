DOJ = {}
DOJ.IsDOJ = false
DOJ.Active = false
DOJ.Rank = nil
DOJ.Position = nil
DOJ.Locations = {
	vector3(-552.6015625, -191.19027709961, 38.219696044922),
}

function DOJonduty()
	return DOJ.Active
end

function DOJgetrank()
	return DOJ.Rank
end

function DOJisdoj()
	return DOJ.IsDOJ
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if DOJ.IsDOJ then
			PlayerPosition = GetEntityCoords(PlayerPedId(), false)
			for i = 1, #DOJ.Locations, 1 do
				if #(PlayerPosition - DOJ.Locations[i]) < 20 then
					RenderMarker(25, DOJ.Locations[i].x, DOJ.Locations[i].y, DOJ.Locations[i].z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(PlayerPosition - DOJ.Locations[i]) < 1 then
						if not DOJ.Active then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to ~g~clock in~w~!")
						else
							DisplayHelpText("Press ~INPUT_CONTEXT~ to ~r~clock out~w~!")
						end
						if IsControlJustPressed(1, 51) then
							DOJ.Active = not DOJ.Active
							TriggerServerEvent('DOJ:setService', DOJ.Active)
						end
					end
				end
			end
		end
	end
end)

AddEventHandler("DOJ:Menu", function()
	if DOJ.Active and (DOJ.Rank == "chief justice" or DOJ.Rank == "judge" or DOJ.Rank == "justice") then
		exports.ui:reset()
		exports.ui:open()
		exports.ui:addOption("MDT", [[TriggerEvent("mdt.toggle")]])
		exports.ui:addOption("Weapons license", [[TriggerEvent("DOJ:Weapon")]])
		exports.ui:addOption("Drivers license", [[TriggerEvent("DOJ:Drivers")]])
		exports.ui:addOption("Optional fine", [[TriggerEvent("DOJ:Fine")]])
		exports.ui:back([[TriggerEvent("interaction:main")]])
	end
	if DOJ.Active and (DOJ.Rank == "assistant district attorney" or DOJ.Rank == "district attorney") then
		exports.ui:reset()
		exports.ui:open()
		exports.ui:addOption("MDT", [[TriggerEvent("mdt.toggle")]])
		exports.ui:back([[TriggerEvent("interaction:main")]])
	end
end)

AddEventHandler("DOJ:Weapon", function()
	if DOJ.Active and (DOJ.Rank == "chief justice" or DOJ.Rank == "judge" or DOJ.Rank == "justice") then
		exports.ui:reset()
		exports.ui:open()
		exports.ui:addOption("Grant", [[TriggerEvent("DOJ:Grant", "weapon")]])
		exports.ui:addOption("Seize", [[TriggerEvent("DOJ:Seize", "weapon")]])
		exports.ui:back([[TriggerEvent("DOJ:Menu")]])
	end
end)

AddEventHandler("DOJ:Drivers", function()
	if DOJ.Active and (DOJ.Rank == "chief justice" or DOJ.Rank == "judge" or DOJ.Rank == "justice") then
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
	DOJ.IsDOJ = _DOJ

	if not DOJ.IsDOJ then
		DOJ.Rank = nil
	else
		if _Data ~= nil then
			if _Data.rank ~= nil then
				DOJ.Rank = _Data.rank
			end
		end
	end

	if not DOJ.IsDOJ and DOJ.Active then
		DOJ.Active = false
		exports["core_modules2"]:SetDOJ(DOJ.IsDOJ)
		TriggerServerEvent("jobcenter:jobs", 1)
	elseif not DOJ.IsDOJ and not DOJ.Active then
		if not first then
			exports["core_modules2"]:SetDOJ(DOJ.IsDOJ)
			TriggerServerEvent("jobcenter:jobs", 1)
		end
	elseif DOJ.IsDOJ then
		exports["core_modules2"]:SetDOJ(DOJ.IsDOJ)
		TriggerServerEvent("jobcenter:jobs", 23)
	end
end)

RegisterNetEvent("Lawyer:Set")
AddEventHandler("Lawyer:Set", function(Status)
	if Status == true then
		exports["core_modules2"]:SetDOJ(DOJ.IsDOJ)
		TriggerServerEvent("jobcenter:jobs", 5)
	else
		exports["core_modules2"]:SetDOJ(DOJ.IsDOJ)
		TriggerServerEvent("jobcenter:jobs", 1)
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
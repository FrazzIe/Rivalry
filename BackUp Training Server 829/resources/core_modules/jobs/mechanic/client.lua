Mechanic = {}
Mechanic.IsMechanic = false
Mechanic.Active = false
Mechanic.Rank = nil
Mechanic.Position = nil

RegisterNetEvent("Mechanic:Set")
AddEventHandler("Mechanic:Set", function(_Data, _Mechanic, first)
	Mechanic.Rank = ((type(_Data) == "table") and _Data.rank or nil)
	Mechanic.IsMechanic = _Mechanic
	if not Mechanic.IsMechanic and Mechanic.Active then
		Mechanic.Active = false
		TriggerServerEvent("jobcenter:jobs", 1)
	elseif not Mechanic.IsMechanic and not Mechanic.Active then
		if not first then
			TriggerServerEvent("jobcenter:jobs", 1)
		end
	elseif Mechanic.IsMechanic then
		TriggerServerEvent("jobcenter:jobs", 16)
	end
end)
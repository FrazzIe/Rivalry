Mechanic = {}
Mechanic.IsMechanic = false
Mechanic.Active = false
Mechanic.Rank = nil
Mechanic.Position = nil

local SelectedVehicle = nil

RegisterNetEvent("Mechanic:Set")
AddEventHandler("Mechanic:Set", function(_Data, _Mechanic, first)
	Mechanic.IsMechanic = _Mechanic

	if not Mechanic.IsMechanic then
		Mechanic.Rank = nil
	else
		if _Data ~= nil then
			if _Data.rank ~= nil then
				Mechanic.Rank = _Data.rank
			end
		end
	end

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

function IsMechanic
	return Mechanic.IsMechanic	
end

function MechanicIsInService
	return Mechanic.Active	
end

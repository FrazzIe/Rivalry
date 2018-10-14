local Scrap = {
	Data = {
		IsScrap = true,
		OnDuty = false,
		Doors = {
			{x = -589.53009033203, y = -1621.603515625, z = 33.161777496338, h = 174.73043823242, model = 812467272},
			{x = -590.82397460938, y = -1621.5015869141, z = 33.162761688232, h = 354.52551269531, model = 812467272},
		},
		Blips = {},
	},
}

RegisterNetEvent("scrapyard:set")
AddEventHandler("scrapyard:set", function(_IsScrap)
	Scrap.Data.OnDuty = false
	Scrap.Data.IsScrap = _IsScrap
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
		if Scrap.Data.IsScrap then
			if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z) < 10 then
				DrawMarker()
				if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z) < 1 then
					if Scrap.Data.OnDuty then
						DisplayHelpText("Press ~INPUT CONTEXT~ to sign off duty")
					else
						DisplayHelpText("Press ~INPUT CONTEXT~ to sign on duty")
					end
					if IsControlJustPressed(1, 51) then
						Scrap.Data.OnDuty = not Scrap.Data.OnDuty
					end
				end
			end
			if Scrap.Data.OnDuty then

			end
		end
	end
end)
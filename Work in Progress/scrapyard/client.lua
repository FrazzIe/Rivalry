local IsScrap = true
local OnDuty = false
local isSearching = false
local Scrap = {
	Data = {
		Doors = {
			{x = -589.53009033203, y = -1621.603515625, z = 33.161777496338, h = 174.73043823242, model = 812467272},
			{x = -590.82397460938, y = -1621.5015869141, z = 33.162761688232, h = 354.52551269531, model = 812467272},
		},
		Blips = {},
		Sand = 0,
		Service = {x = -618.65423583984, y = -1623.2392578125, z = 33.010543823242, h = 174.02153015137},
		Items = {
		    [1] = {name = "Aluminum Can", item_id = 66},
		    [2] = {name = "Copper Wire", item_id = 67},
		    [3] = {name = "Light Iron", item_id = 68},
		    [4] = {name = "Copper Tubing", item_id = 69},
		    [5] = {name = "Brass Scrap", item_id = 70},
		    [6] = {name = "Bronze Scrap", item_id = 71},
		    [7] = {name = "Golden Ring", item_id = 72},
		    [8] = {name = "Silver Necklace", item_id = 73},
		    [9] = {name = "Silver Earing", item_id = 74},
		},
	},
}

RegisterNetEvent("scrapyard:set")
AddEventHandler("scrapyard:set", function(_IsScrap)
	OnDuty = false
	IsScrap = _IsScrap
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

function GetGroundHash(ped)
    local posped = GetEntityCoords(ped)
    local num = StartShapeTestCapsule(posped.x,posped.y,posped.z+4,posped.x,posped.y,posped.z-2.0, 2, 1, ped, 7)
    local arg1, arg2, arg3, arg4, arg5 = GetShapeTestResultEx(num)
    Scrap.Data.Sand = arg5
end

function startDetecting()
	RequestAnimDict("WORLD_HUMAN_GARDENER_PLANT")
	while not HasAnimDictLoaded("WORLD_HUMAN_GARDENER_PLANT") do
		Wait(0)
	end
	local randomnum = math.random(1,9)
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, false)
	Citizen.Wait(10000)
	TriggerServerEvent('scrapyard:giveitem', Scrap.Data.Items[randomnum].item_id)
	ClearPedTasks(PlayerPedId())
	isSearching = false
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
		if IsScrap then
			if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z) < 10 then
				DrawMarker()
				if Vdist(pos.x, pos.y, pos.z, Scrap.Data.Service.x, Scrap.Data.Service.y, Scrap.Data.Service.z) < 1 then
					if OnDuty then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to sign off duty")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to sign on duty")
					end
					if IsControlJustPressed(1, 51) then
						OnDuty = not OnDuty
					end
				end
			end
			if OnDuty then
				GetGroundHash(PlayerPedId())
				if Scrap.Data.Sand == 2699818980 then
					if GetItemQuantity(65) > 0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to use your metal detector.")
						if IsControlJustPressed(1, 51) and isSearching == false then
							startDetecting()
							isSearching = true
						end
					end
				end
			end
		end
	end
end)
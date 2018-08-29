local Scuba = {}
Scuba.locations = {
	{name = "Scuba Diving", sprite = 175, x = -1800.3881835938, y = -1225.7358398438, z = 1.5795079469681, h = 142.85076904297}, --Del Perro Beach
	{name = "Scuba Diving", sprite = 175, x = -275.20385742188, y = 6631.4912109375, z = 7.4263591766357, h = 218.80029296875}, --Jetti in Paleto
	{name = "Scuba Diving", sprite = 175, x = 713.35919189453, y = 4093.6579589844, z = 34.727825164795, h = 181.92189025879}, --Jetti north of Sandy
	{name = "Scuba Diving", sprite = 175, x = -790.04699707031, y = -1451.9326171875, z = 1.5952184200287, h = 122.65202331543}, --Jetti by the helipad
}

Citizen.CreateThread(function()
	local underwater_time = 10
	local scubatank = nil
	local scubamask = nil
	local attached = nil
	local mask_equipped = true
	local last_used = GetGameTimer()

	function Scuba.equip(_ped)
		last_used = GetGameTimer() + 300000
		Citizen.CreateThread(function()
			Scuba.delete()
			underwater_time = 310
			SetPedMaxTimeUnderwater(_ped, underwater_time+0.0)
			local tank = GetHashKey("p_michael_scuba_tank_s")
			local mask = GetHashKey("p_michael_scuba_mask_s")
			RequestModel(tank)
			while not HasModelLoaded(tank) do
				Citizen.Wait(0)
			end
			RequestModel(mask)
			while not HasModelLoaded(mask) do
				Citizen.Wait(0)
			end
			scubatank = CreateObject(tank, GetEntityCoords(_ped, false), true, false, false)
			while not DoesEntityExist(scubatank) do
				Citizen.Wait(0)
			end			
			scubamask = CreateObject(mask, GetEntityCoords(_ped, false), true, false, false)
			while not DoesEntityExist(scubamask) do
				Citizen.Wait(0)
			end
			AttachEntityToEntity(scubatank, _ped, 0, 0.0, -0.25, 0.01, 0.0, 0.0, 180.0, false, false, false, false, 2, true)
			AttachEntityToEntity(scubamask, _ped, GetPedBoneIndex(_ped, 65068), 0.0, 0.0, 0.0, 0.0, -90.0, 180.0, false, false, false, false, 2, true)
			SetEntityCollision(scubatank, false, true)
			SetEntityCollision(scubamask, false, true)
			attached = _ped
		end)
	end

	function Scuba.toggle(_ped, toggle)
		mask_equipped = toggle
		if toggle then
			AttachEntityToEntity(scubamask, _ped, GetPedBoneIndex(_ped, 65068), 0.0, 0.0, 0.0, 0.0, -90.0, 180.0, false, false, false, false, 2, true)
		else
			AttachEntityToEntity(scubamask, _ped, 0, 0.0, -0.2, 0.2, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		end
	end

	function Scuba.delete()
		if scubatank then
			DetachEntity(scubatank, 1, false)
			DeleteObject(scubatank)
			DeleteEntity(scubatank)
			if DoesEntityExist(scubatank) then
				SetEntityCoords(scubatank, -589.14331054688, 2062.5161132813, 128.88488769531)
			end
			scubatank = nil
		end
		if scubamask then
			DetachEntity(scubamask, 1, false)
			DeleteObject(scubamask)
			DeleteEntity(scubamask)
			if DoesEntityExist(scubamask) then
				SetEntityCoords(scubamask, -589.14331054688, 2062.5161132813, 128.88488769531)
			end
			scubamask = nil
			mask_equipped = true
		end
	end

	function Scuba.reset(_ped)
		underwater_time = 10
		SetPedMaxTimeUnderwater(_ped, underwater_time+0.0)
	end

	function Scuba.reattach(_ped)
		AttachEntityToEntity(scubatank, _ped, 0, 0.0, -0.25, 0.01, 0.0, 0.0, 180.0, false, false, false, false, 2, true)
		AttachEntityToEntity(scubamask, _ped, GetPedBoneIndex(_ped, 65068), 0.0, 0.0, 0.0, 0.0, -90.0, 180.0, false, false, false, false, 2, true)
		SetEntityCollision(scubatank, false, true)
		SetEntityCollision(scubamask, false, true)
		attached = _ped
		mask_equipped = true
	end

	function Scuba.has()
		if scubatank or scubamask then
			return true
		else
			return false
		end
	end

	function Scuba.timeremaining()
		return underwater_time
	end

	function Scuba.lastused()
		return last_used
	end

	for i = 1, #Scuba.locations do
		addBlip(Scuba.locations[i])
	end

	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped, false)

		if underwater_time > 10 and Scuba.has() and not IsPedSwimmingUnderWater(ped) then
			SetPedMaxTimeUnderwater(ped, underwater_time+0.0)
		end

		if GetPlayerUnderwaterTimeRemaining(PlayerId()) > 10 and not Scuba.has() then
			Scuba.reset(ped)
		end

		if Scuba.has() and ped ~= attached then
			Scuba.reattach(ped)
		end

		if Scuba.has() and IsPedSwimmingUnderWater(ped) and not mask_equipped then
			Scuba.toggle(ped, not mask_equipped)
		elseif Scuba.has() and not IsPedSwimmingUnderWater(ped) and mask_equipped then
			Scuba.toggle(ped, not mask_equipped)
		end

		while underwater_time > 10 and Scuba.has() and IsPedSwimmingUnderWater(ped) do
			underwater_time = underwater_time - 1
			Citizen.Wait(1000)
		end

		for i = 1, #Scuba.locations do
			local Distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Scuba.locations[i].x, Scuba.locations[i].y, Scuba.locations[i].z, true)
			if Distance < 20 then
				drawMarker(25, Scuba.locations[i].x, Scuba.locations[i].y, Scuba.locations[i].z, 1.0, 1.0, 1.5, 255, 255, 0, 255)
				if Distance < 1 then
					if not Scuba.has() then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to get a diving set for ~g~$~w~300 with 5 minutes of air!")
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to return diving set!")
					end
					if IsControlJustPressed(1, 51) then
						if Scuba.has() then
							Scuba.delete()
							Scuba.reset(ped)
						else
							TriggerServerEvent("diving:buy")
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("diving:bought")
AddEventHandler("diving:bought", function()
	Scuba.equip(PlayerPedId())
end)

RegisterNetEvent("diving:emergency")
AddEventHandler("diving:emergency", function()
	if Scuba.has() then
		Scuba.delete()
		Scuba.reset(PlayerPedId())
	else		
		if Scuba.lastused() < GetGameTimer() then
			Scuba.equip(PlayerPedId())
		else
			TriggerEvent("chatMessage", "NOTICE", {255,255,255}, "^1Your scuba gear is currently on cooldown!")
		end
	end
end)
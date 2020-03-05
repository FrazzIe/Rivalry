Players = {}

exports("GetNearbyPlayers", function(distance)
	-- TODO: use grids, for now return players
	if not Players.Cache or (GetGameTimer() - Players.LastUpdate) > 1.0 then
		Players.Cache = GetActivePlayers() -- TODO: Use grid caching, prototype already made in the 'grids' resource
		Players.LastUpdate = GetGameTimer()
	end

	return Players.Cache
end)

exports("SetPlayersVisible", function(toggle, selfToggle)
	local ped = PlayerPedId()
	SetEntityVisible(ped, selfToggle)

	Players.Visible = toggle
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		-- Player visibility.
		if Players.Visible ~= nil then
			local ped = PlayerPedId()
			for _, player in ipairs(exports.utils:GetNearbyPlayers()) do
				local otherPed = GetPlayerPed(player)
				if otherPed ~= ped then
					SetEntityVisible(otherPed, Players.Visible)
					SetEntityNoCollisionEntity(ped, otherPed, not Players.Visible)
				end
			end
			if Players.Visible then
				Players.Visible = nil
			end
		end
	end
end)
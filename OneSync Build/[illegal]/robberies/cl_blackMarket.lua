Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()
		local pedPos = GetEntityCoords(ped)

		for _, market in ipairs(Config.BlackMarket) do
			local coords = market.Coords
			if #(vector3(coords.x, coords.y, coords.z) - pedPos) < 4.0 then
				local canSell = 2
				for _, item in ipairs(market.Items) do
					if exports.core_modules:GetItemQuantity(item[1]) > 0 then
						canSell = 1
						break
					end
				end

				if exports.utils:DrawContext(market.Text, market.Coords, canSell) then
					SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z)
					SetEntityHeading(ped, coords.w)

					exports.mythic_progbar:Progress({
						name = "selling",
						duration = (market.Duration or 1) * 1000,
						label = market.Label or "Robbing",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
						animation = market.Anim or {},
					}, function(status)
						if status then return end
						SellTo(market)
					end)
				end
			end
		end
	end
end)

function SellTo(market)
	local money = 0
	for _, item in ipairs(market.Items) do
		local id = item[1]
		local value = item[2]
		local quantity = exports.core_modules:GetItemQuantity(id)

		if quantity > 0 then
			exports.core_modules:removeQty(id, quantity)
			money = money + quantity * value
		end
	end
	if money ~= 0 then
		TriggerServerEvent("robberies:sell", money)
	end
end
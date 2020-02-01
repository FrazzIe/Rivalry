DecorRegister("isTrader", 2)
DecorRegister("soldTo", 2)

function Weed:CanPlayerSell(PlayerPosition)
	local PlayerZone = GetNameOfZone(PlayerPosition.x, PlayerPosition.y, PlayerPosition.z)
	local Percentage = GetRandomIntInRange(0, 101)

	if not Weed.Zones[PlayerZone] then
		return false
	else
		return Percentage > (100 - Weed.Zones[PlayerZone])
	end
end

function Weed:CreateTrader(Model, Coords, Heading)
	RequestModel(Model)

	while not HasModelLoaded(Model) do
		Citizen.Wait(50)
	end

	local Trader = CreatePed(4, Model, Coords.x, Coords.y, Coords.z, Heading, false, false)

	SetEntityCanBeDamaged(Trader, false)
	SetPedCanRagdollFromPlayerImpact(Trader, false)
	TaskSetBlockingOfNonTemporaryEvents(Trader, true)
	SetPedFleeAttributes(Trader, 0, 0)
	SetPedCombatAttributes(Trader, 17, 1)
	SetEntityInvincible(Trader, true)
	DecorSetBool(Trader, "isTrader", true)

	return Trader
end

function Weed:CreateBag(PlayerPed)
	RequestModel(Weed.Bag.Model)
	while not HasModelLoaded(Weed.Bag.Model) do
		Citizen.Wait(0)
	end

	Weed.Bag.Handle = CreateObject(Weed.Bag.Model, 0.01, 0, 0, true, false, false)

	AttachEntityToEntity(Weed.Bag.Handle, PlayerPed, GetPedBoneIndex(PlayerPed, Weed.Bag.Bone), Weed.Bag.Offset.x, Weed.Bag.Offset.y, Weed.Bag.Offset.z, Weed.Bag.Rotation.x, Weed.Bag.Rotation.y, Weed.Bag.Rotation.z, true, true, false, true, 1, true)

	SetModelAsNoLongerNeeded(Weed.Bag.Handle)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if Weed.Cooldown > 0 then
			Weed.Cooldown = Weed.Cooldown - 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		if not IsPedSittingInAnyVehicle(PlayerPed) then
			if GetItemQuantity(Weed.Items.Joint) > 0 then
				for RandomPed in EnumeratePeds() do
					if DoesEntityExist(RandomPed) then
						if not IsEntityDead(RandomPed) then
							local Model = GetEntityModel(RandomPed)

							if not IsPedAPlayer(RandomPed) and not DecorGetBool(RandomPed, "isTrader") and not DecorGetBool(RandomPed, "soldTo") and not IsPedAnAnimal(Model) then
								local RandomPedPosition = GetEntityCoords(RandomPed, false)

								if #(RandomPedPosition - PlayerPosition) < 1 then
									if Weed.Cooldown > 0 then
										DisplayHelpText("Press ~INPUT_CONTEXT~ to sell some weed! ["..Weed.Cooldown.."]")
									else
										DisplayHelpText("Press ~INPUT_CONTEXT~ to sell some weed!")

										if IsControlJustPressed(1, 51) then
											Weed.Cooldown = 10
											DecorSetBool(RandomPed, "soldTo", true)

											if Weed:CanPlayerSell(PlayerPosition) then
												Weed:CreateBag(PlayerPed)

												SetEntityHeading(RandomPed, GetEntityHeading(PlayerPed) - 180)

												ClearPedTasksImmediately(PlayerPed)
												
												TaskPlayAnim(PlayerPed, Weed.Animation.Dictionary, Weed.Animation.Player, 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)

												ClearPedTasksImmediately(RandomPed)
												
												TaskPlayAnim(RandomPed, Weed.Animation.Dictionary, Weed.Animation.Ped, 100.0, 200.0, 0.3, 16, 0.2, 0, 0, 0)

												Citizen.Wait(500)

												DestroyObject(Weed.Bag.Handle)

												local Amount = GetRandomIntInRange(2, 5)
												local HasEnoughJoints = GetItemQuantity(Weed.Items.Joint) >= Amount

												local Pay = GetRandomIntInRange(Weed.Pay.Minimum, Weed.Pay.Maximum + 1)
												local Clean = GetRandomIntInRange(0, 2)

												if HasEnoughJoints then
													Pay = Pay * Amount
												else
													Amount = 1
												end

												if getCops() <= 0 then 
													Pay = Pay/2
												end

												Notify("You sold "..Amount.." bags(s) of weed for <span style='color:lime'>$</span><span style='color:white'>"..math.floor(Pay).."</span>")
													
												TriggerServerEvent("Weed.Sell", math.floor(Pay), Clean, Amount)

												PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
											else
												PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
												
												TaskReactAndFleePed(RandomPed, PlayerPed)

												Citizen.Wait(4000)

												TaskStartScenarioInPlace(RandomPed, "WORLD_HUMAN_STAND_MOBILE", 0, true)
												Citizen.Wait(5000)
												ClearPedTasks(RandomPed)

												if not IsEntityDead(RandomPed) then
													TriggerEvent("dispatch:drug")
												end
											end
										end 
									end
								end
							end
						end
					end
				end
			end
		end	
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local PlayerPed = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPed, false)

		for Index = 1, #Weed.Plants do
			if #(Weed.Plants[Index].Coordinates - PlayerPosition) < 1 then
				local Growth = Weed:CalculateGrowth(GetCurrentServerTime(), Weed.Plants[Index].Time.Start, Weed.Plants[Index].Time.End)
				local Message, Amount, Cost = Weed:GetGrowthInformation(Growth)

				Draw3DText(Weed.Plants[Index].Coordinates.x, Weed.Plants[Index].Coordinates.y, Weed.Plants[Index].Coordinates.z, Growth.."%")
				Draw3DText(Weed.Plants[Index].Coordinates.x, Weed.Plants[Index].Coordinates.y, Weed.Plants[Index].Coordinates.z - 0.1, Message.." ["..Amount.."]")

				if IsControlJustPressed(1, 51) then
					if Growth >= 50 then
						TriggerServerEvent("Weed.Harvest", Index)

						IsStanceAllowed = false

						TaskStartScenarioInPlace(PlayerPed, Weed.Scenario, 0, false)

						Citizen.Wait(4000)

						ClearPedTasks(PlayerPed)

						IsStanceAllowed = true
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if Weed.Trading.Is then
			local PlayerPed = PlayerPedId()
			local PlayerPosition = GetEntityCoords(PlayerPed, false)

			if Weed.Trading.Index then
				if not Weed.Traders[Weed.Trading.Index].Handle then
					Weed.Traders[Weed.Trading.Index].Handle = Weed:CreateTrader(Weed.Traders[Weed.Trading.Index].Model, Weed.Traders[Weed.Trading.Index].Ped.Coordinates, Weed.Traders[Weed.Trading.Index].Ped.Heading)
				end

				if not Weed.Trading.Blip then
					Weed.Trading.Blip = CreateBlip("helix trader", 1, 60, Weed.Traders[Weed.Trading.Index].Marker.x, Weed.Traders[Weed.Trading.Index].Marker.y, Weed.Traders[Weed.Trading.Index].Marker.z, 0.85, true)
					SetBlipRoute(Weed.Trading.Blip, true)
					SetNewWaypoint(Weed.Traders[Weed.Trading.Index].Marker.x, Weed.Traders[Weed.Trading.Index].Marker.y)
				end

				local Distance = #(Weed.Traders[Weed.Trading.Index].Marker - PlayerPosition)

				if Distance < 20 then
					RenderMarker(25, Weed.Traders[Weed.Trading.Index].Marker.x, Weed.Traders[Weed.Trading.Index].Marker.y, Weed.Traders[Weed.Trading.Index].Marker.z, 1.5, 1.5, 2.0, 255, 0, 0, 100)
					
					if Distance < 2 then
						Draw3DText(Weed.Traders[Weed.Trading.Index].Ped.Coordinates.x, Weed.Traders[Weed.Trading.Index].Ped.Coordinates.y, Weed.Traders[Weed.Trading.Index].Ped.Coordinates.z + 1, "Rate: "..Weed.Traders[Weed.Trading.Index].Rate.."%")

						DisplayHelpText("Press ~INPUT_CONTEXT~ to trade your ~g~Cannabis ~w~for Weed")

						if IsControlJustPressed(1, 51) then
							if GetItemQuantity(Weed.Items.Weed) > 0 then
								Notify("Trade completed!", 3500)

								TriggerServerEvent("Weed.Trade", Weed.Traders[Weed.Trading.Index].Rate)

								Weed.Traders[Weed.Trading.Index].Rate = GetRandomIntInRange(60, 101)


								if Weed.Traders[Weed.Trading.Index].Handle ~= nil then
									DestroyPed(Weed.Traders[Weed.Trading.Index].Handle)

									Weed.Traders[Weed.Trading.Index].Handle = nil
								end

								Weed.Trading.Index = nil

								if Weed.Trading.Blip then
									DeleteBlip(Weed.Trading.Blip)

									Weed.Trading.Blip = nil
								end

								Weed.Trading.Is = false
							else
								Notify("Trade failed!", 3500)

								Weed.Traders[Weed.Trading.Index].Rate = GetRandomIntInRange(60, 101)


								if Weed.Traders[Weed.Trading.Index].Handle ~= nil then
									DestroyPed(Weed.Traders[Weed.Trading.Index].Handle)

									Weed.Traders[Weed.Trading.Index].Handle = nil
								end

								Weed.Trading.Index = nil

								if Weed.Trading.Blip then
									DeleteBlip(Weed.Trading.Blip)

									Weed.Trading.Blip = nil
								end

								Weed.Trading.Is = false						
							end
						end
					end
				end
			end
		end
	end	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent("Weed.Initialise")
			return
		end
	end
end)

RegisterNetEvent("Weed.Sync")
AddEventHandler("Weed.Sync", function(Plants)
	for Index = 1, #Plants do
		Weed.Plants[Index].Time.Start = Plants[Index].Start
		Weed.Plants[Index].Time.End = Plants[Index].End
	end
end)

AddEventHandler("weed:setuptrader", function()
	if not Weed.Trading.Is then
		Weed.Trading.Is = true
		Weed.Trading.Index = GetRandomIntInRange(1, #Weed.Traders + 1)
	end
end)

AddEventHandler("weed:canceltrader", function()
	if Weed.Trading.Is then
		if Weed.Trading.Index then
			if Weed.Traders[Weed.Trading.Index].Handle ~= nil then
				DestroyPed(Weed.Traders[Weed.Trading.Index].Handle)

				Weed.Traders[Weed.Trading.Index].Handle = nil
			end

			Weed.Trading.Index = nil
		end

		if Weed.Trading.Blip then
			DeleteBlip(Weed.Trading.Blip)

			Weed.Trading.Blip = nil
		end

		Weed.Trading.Is = false
	end
end)
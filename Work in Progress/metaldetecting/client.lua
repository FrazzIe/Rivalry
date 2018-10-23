local IsMetalDetector = true
local OnDuty = false
local isSearching = false
local Metal = {
	Data = {
		Sand = 0,
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

RegisterNetEvent("metaldetector:set")
AddEventHandler("metaldetector:set", function(_IsMetalDetector)
	OnDuty = false
	IsMetalDetector = _IsMetalDetector
end)

function GetGroundHash(ped)
    local posped = GetEntityCoords(ped)
    local num = StartShapeTestCapsule(posped.x,posped.y,posped.z+4,posped.x,posped.y,posped.z-2.0, 2, 1, ped, 7)
    local arg1, arg2, arg3, arg4, arg5 = GetShapeTestResultEx(num)
    Metal.Data.Sand = arg5
end

function startDetecting()
	isSearching = true
	local anim = "WORLD_HUMAN_GARDENER_PLANT"
	local randomnum = math.random(1,9)
	Notify("You are currently searching for metal objects!", 10000)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
	Wait(10000)
	TriggerServerEvent('scrapyardgiveitem', Metal.Data.Items[randomnum].item_id)
	ClearPedTasks(PlayerPedId())
	isSearching = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId(), 0)
		if IsMetalDetector then
			GetGroundHash(PlayerPedId())
			if Metal.Data.Sand == 2699818980 then
				if GetItemQuantity(65) > 0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to use your metal detector.")
					if IsControlJustPressed(1, 51) and isSearching == false then
						startDetecting()
					end
				end
			end
			if Vdist(pos.x pos.y, pos.z, Metal.Data.Recycle.x, Metal.Data.Recycle.y, Metal.Data.Recycle.z) < 10 then
				DrawMarker(25, Metal.Data.Recycle.x, Metal.Data.Recycle.y, Metal.Data.Recycle.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if Vdist(pos.x pos.y, pos.z, Metal.Data.Recycle.x, Metal.Data.Recycle.y, Metal.Data.Recycle.z) < 1 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to use the recycler!")
					if IsControlJustPressed(1, 51) then
						local timerequired = 1000
						Notify("Please type /recycle [AMOUNT] in chat!", 10000)
						for k, v in ipairs(Metal.Data.Items) do
							if GetItemQuantity(k.item_id) > 0 then
								while recycleAmount < 1 do
									Citizen.Wait(0)
								end
								if recycleAmount <= GetItemQuantity(k.item_id) then
									timerequired = timerequired * recycleAmount
									Notify("Recyling In Progress", timerequired)
									while timerequired > 0 then
										Citizen.Wait(1000)
										TriggerEvent('inventory:removeQty', k.item_id, 1)
										TriggerEvent('inventory:addQty', 75, 1)
										timerequired = timerequired - 1000
									end
									recycleAmount = 0
								else
									Notify("You don't have the amount of "..k.name.." that you entered!", 7500)
								end
							else
								Notify("You don't have any items that can be scrapped!", 7000)
							end
						end
					end
				end
			end
		end
	end
end)
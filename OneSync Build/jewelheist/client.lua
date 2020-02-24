IsRobber = false

local JewelryCases = {
	vector3(-626.72320556641,-238.4764251709,38.057029724121),
	vector3(-625.73675537109,-237.79011535644,38.057029724121),
	vector3(-626.82897949219,-235.45208740234,38.057029724121),
	vector3(-625.77331542969,-234.69453430176,38.057029724121),
	vector3(-626.93194580078,-233.05238342285,38.057029724121),
	vector3(-627.98156738281,-233.81484985352,38.057029724121),
	vector3(-624.51605224609,-231.09585571289,38.057029724121),
	vector3(-624.04626464844,-228.1071472168,38.057029724121),
	vector3(-620.98590087891,-228.52828979492,38.057029724121),
	vector3(-619.63037109375,-230.39764404297,38.057029724121),
	vector3(-620.06665039062,-233.38737487793,38.057029724121),
	vector3(-623.17474365234,-232.9469909668,38.057029724121),
	vector3(-624.97729492188,-227.94902038574,38.057029724121),
	vector3(-623.83392333984,-227.11199951172,38.057029724121),
	vector3(-620.51794433594,-226.56936645508,38.056983947754),
	vector3(-619.71691894531,-227.69183349609,38.056995391846),
	vector3(-618.37786865234,-229.52967834473,38.057010650635),
	vector3(-617.53491210938,-230.56993103027,38.057010650635),
	vector3(-619.25134277344,-233.6502532959,38.090309143066),
	vector3(-620.24621582031,-234.36782836914,38.057052612305),
}

local Doors = {
	Left = {
		Coords = vector3(-631.95538330078,-236.33326721191,38.206531524658),
		Heading = 306.12963867188,
		Model = 1425919976,
		Handle = nil,
		Locked = true,
	},
	Right = {
		Coords = vector3(-630.42651367188,-238.43754577637,38.206531524658),
		Heading = 305.68853759766,
		Model = 9467943,
		Handle = nil,
		Locked = true,
	},
	Top = {
		Coords = vector3(-618.12347412109,-242.64210510254,52.785106658936),
		Heading = 205.51049804688,
		Locked = true,
	},
	Bottom = {
		Coords = vector3(-620.74792480469,-224.90423583984,38.056922912598),
		Heading = 218.01945495605,
		Locked = true,
	},
}

local SoundEffect = {
	Dictionary = "Drill_Pin_Break",
	Effect = "DLC_HEIST_FLEECA_SOUNDSET",
}

local Animations = {
	Dictionary = "missheist_jewel",
	Animation = {
		[1] = "smash_case_b",
		[2] = "smash_case",
		[3] = "smash_case_tray_b",
		[4] = "smash_case_tray_a",
		[5] = "fp_smash_case_d",
		[6] = "smash_case_necklace",
		[7] = "fp_smash_case_tray_b",
		[8] = "fp_smash_case_tray_a",
		[9] = "smash_case_f",
		[10] = "smash_case_e",
		[11] = "smash_case_d",
		[12] = "fp_smash_case_e",
		[13] = "smash_case_c",
		[14] = "fp_smash_case_necklace"
	}
}

local StartLocation = vector3(-630.07141113281,-240.92134094238,38.168064117432)
local ComputerLocation = vector3(-631.27142333984,-230.01849365234,38.057056427002)

function TriggerSmashAnimation()
	Citizen.CreateThread(function()
		RequestAnimDict(Animations.Dictionary)
		while not HasAnimDictLoaded(Animations.Dictionary) do
			Citizen.Wait(0)
		end
		local Randomizer = math.random(1, #Animations.Animation)
		TaskPlayAnim(PlayerPedId(), Animations.Dictionary, Animations.Animation[Randomizer], 4.0, -4, -1, 0, 0, 0, 0, 0)
		Citizen.Wait(600)
		PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1);
	end)
end


function DisplayHelpText(Str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(Str or "")
	EndTextCommandDisplayHelp(0, 0, 0, -1)
end

function Notify(Message, Time)
	exports.pNotify:SendNotification({text = Message or "", type = "error", timeout = Time or 3000, layout = "centerRight", queue = "left"})
end

function RenderMarker(Type, X, Y, Z, SX, SY, SZ, R, G, B, A, BobUpAndDown)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		DrawMarker(Type, X, Y, Z - 0.9, 0, 0, 0, 0, 0, 0, SX or 0, SY or 0, SZ or 0, R or 255, G or 255, B or 255, A or 255, BobUpAndDown or false, 0, 2, 0, 0, 0, 0)
	end
end

function BlowTorch()
	exports.core_modules:removeQty(82, 1)
	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
	exports['mythic_progbar']:Progress({
		name = "blowtorch_action",
		duration = 30000,
		label = "Blowtorching",
		useWhileDead = true,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}
	}, function(status)
		if not status then
			if IsPedUsingScenario(PlayerPedId(), "WORLD_HUMAN_WELDING") then
				TriggerServerEvent("JewelryHeist.UnlockTopDoors")
			else
				Notify("Why are you canceling the animation?", 3100)
			end
			ClearPedTasksImmediately(PlayerPedId())
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
		if #(PlayerPosition - StartLocation) <= 40 then
			if #(PlayerPosition - Doors.Right.Coords) <= 1.1 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to lockpick the doors!")
				if IsControlJustPressed(1, 51) then
					TriggerEvent("Rivalry.LockpickJewelry")
				end
			end
			if #(PlayerPosition - Doors.Top.Coords) <= 1.1 then
				if Doors.Top.Locked then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to blowtorch the doors!")
					if IsControlJustPressed(1, 51) then
						if exports.core_modules:GetItemQuantity(82) > 0 then
							BlowTorch()
						else
							Notify("You need a blow torch to break this doors lock open!", 3100)
						end
					end
				else
					DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
					if IsControlJustPressed(1, 51) then
						exports.core_modules2:TeleportPlayer(Doors.Bottom.Coords.x, Doors.Bottom.Coords.y, Doors.Bottom.Coords.z, Doors.Bottom.Heading)
					end
				end
			elseif #(PlayerPosition - Doors.Bottom.Coords) <= 1.1 then
				if Doors.Bottom.Locked then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to blowtorch the doors!")
					if IsControlJustPressed(1, 51) then
						if exports.core_modules:GetItemQuantity(82) > 0 then
							BlowTorch()
						else
							Notify("You need a blow torch to break this doors lock open!", 3100)
						end
					end
				else
					DisplayHelpText("Press ~INPUT_CONTEXT~ to enter!")
					if IsControlJustPressed(1, 51) then
						exports.core_modules2:TeleportPlayer(Doors.Top.Coords.x, Doors.Top.Coords.y, Doors.Top.Coords.z, Doors.Top.Heading)
					end
				end
			end
			if not exports.policejob:getIsInService() and not exports.emsjob:getIsInService() then
				if #(PlayerPosition - StartLocation) <= 11.0 then
					RenderMarker(25, StartLocation.x, StartLocation.y, StartLocation.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(PlayerPosition - StartLocation) <= 2.0 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to start jewelry heist! ( Max Four Players )")
						if IsControlJustPressed(1, 51) then
							TriggerServerEvent("JewelryHeist.StartGroup")
						end
					end
				end
			elseif exports.police:getIsInService() then
				if #(PlayerPosition - ComputerLocation) <= 1.1 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to enable cameras!")
					if IsControlJustPressed(1, 51) then
						RequestAnimDict("anim@amb@warehouse@laptop@")
						while not HasAnimDictLoaded("anim@amb@warehouse@laptop@") do
							Citizen.Wait(0)
						end
						TaskPlayAnim(PlayerPedId(), "anim@amb@warehouse@laptop@", "idle_a", 2.0, 2.0, -1, 129, 0, false, false, false)
						exports['mythic_progbar']:Progress({
							name = "cameras_action",
							duration = 10000,
							label = "Smashing Case",
							useWhileDead = true,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							}
						}, function(status)
							ClearPedTasksImmediately(PlayerPedId())
							TriggerServerEvent("Rivalry.EnableJewelryCameras")
						end)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2500)

		if not DoesEntityExist(Doors.Left.Handle) then
			Doors.Left.Handle = GetClosestObjectOfType(Doors.Left.Coords.x, Doors.Left.Coords.y, Doors.Left.Coords.z, 1.0, Doors.Left.Model, false, false, false)
		end

		if not DoesEntityExist(Doors.Right.Handle) then
			Doors.Right.Handle = GetClosestObjectOfType(Doors.Right.Coords.x, Doors.Right.Coords.y, Doors.Right.Coords.z, 1.0, Doors.Right.Model, false, false, false)
		end

	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(Player, false)
		if #(PlayerPosition - StartLocation) <= 25.0 then
			if Doors.Left.Locked == true then
				if Doors.Left.Handle ~= nil and Doors.Left.Handle ~= 0 then
					SetEntityHeading(Doors.Left.Handle, Doors.Left.Heading)
				end
			end
			if Doors.Right.Locked == true then
				if Doors.Right.Handle ~= nil and Doors.Right.Handle ~= 0 then
					SetEntityHeading(Doors.Right.Handle, Doors.Right.Heading)
				end
			end
		end
	end
end)

local Data = {
    HasJobTask = false,
    Meeting = nil,
    PedestrianModel = nil,
    MeetingPed = nil,
    MeetingVehicle = nil,
	OpenMenu = false,
	HasVisited = false,
}

local Meetings = {
    [1] = {
		VehicleTaskCoord = vector3(-1290.4296875,-811.24694824219,16.728660583496),
		VehicleTaskCoordHeading = 306.89462280273,
		PedTaskCoord = vector3(-1290.4296875,-811.24694824219,16.7286605834969),
		PedTaskHeading = 235.28324890137,
		CarModel = "oracle2",
	},
	[2] = {
		VehicleTaskCoord = vector3(-910.31158447266,-1294.2923583984,4.217689037323),
		VehicleTaskCoordHeading = 21.017053604126,
		PedTaskCoord = vector3(-910.31158447266,-1294.2923583984,4.217689037323), 
		PedTaskHeading = 0.071580804884434,
		CarModel = "buffalo",
	},
	[3] = {
		VehicleTaskCoord = vector3(-788.60778808594,-1279.0372314453,4.1956162452698), 
		VehicleTaskCoordHeading = 169.52738952637,
		PedTaskCoord = vector3(-788.60778808594,-1279.0372314453,4.1956162452698), 
		PedTaskHeading = 41.771751403809,
		CarModel = "buffalo",
	},
	[4] = {
		VehicleTaskCoord = vector3(906.65985107422,-1731.6839599609,29.766738891602), 
		VehicleTaskCoordHeading = 174.70381164551,
		PedTaskCoord = vector3(906.65985107422,-1731.6839599609,29.766738891602), 
		PedTaskHeading = 300.31268310547,
		CarModel = "baller",
	},
}

RegisterNetEvent("Create.Jewelry.Meeting")
AddEventHandler("Create.Jewelry.Meeting", function()
	if Data.Meeting == nil and Data.HasJobTask == false then
		Data.Meeting = math.random(1, #Meetings)
		Data.HasJobTask = true
		Notify("The buyer has sent you a location!")
		SetNewWaypoint(Meetings[Data.Meeting].PedTaskCoord.x, Meetings[Data.Meeting].PedTaskCoord.y)
	else
		if DoesEntityExist(Data.MeetingVehicle) then
			DestroyVehicle(Data.MeetingVehicle)
			Data.MeetingVehicle = nil
		end
		Data.Meeting = math.random(1, #Meetings)
		Data.HasJobTask = true
		Notify("The buyer has sent you a new location!")
		SetNewWaypoint(Meetings[Data.Meeting].PedTaskCoord.x, Meetings[Data.Meeting].PedTaskCoord.y)
	end
	Data.HasVisited = false
end)

RegisterNetEvent("Cancel.Jewelry.Meeting")
AddEventHandler("Cancel.Jewelry.Meeting", function()
	Data.Meeting = nil
	Data.HasJobTask = false
	Data.OpenMenu = false
	if DoesEntityExist(Data.MeetingVehicle) then
		exports.core_modules:DestroyVehicle(Data.MeetingVehicle)
		Data.MeetingVehicle = nil
	end
	ClearGpsPlayerWaypoint()
	Data.HasVisited = false
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Data.HasJobTask then
			if Data.Meeting ~= nil then
				local Player = PlayerPedId()
				local PlayerPosition = GetEntityCoords(Player, false)
                if #(PlayerPosition - Meetings[Data.Meeting].PedTaskCoord) <= 47.0 then
					if not DoesEntityExist(Data.MeetingVehicle) then
						Data.MeetingVehicle = exports["core"]:SpawnVehicle(Meetings[Data.Meeting].CarModel, Meetings[Data.Meeting].VehicleTaskCoord, Meetings[Data.Meeting].VehicleTaskCoordHeading, false)
                    else
                        if #(PlayerPosition - Meetings[Data.Meeting].PedTaskCoord) <= 6.0 then
                           if DoesEntityExist(Data.MeetingVehicle) then
                                SetVehicleDoorOpen(Data.MeetingVehicle, 5)
                                if #(PlayerPosition - Meetings[Data.Meeting].PedTaskCoord) <= 2.3 then
									DisplayHelpText("Press ~INPUT_CONTEXT~ to sell jewelry!")
									if IsControlJustPressed(1, 51) then
										Data.HasVisited = true
										local JewelryQuantity = exports.core_modules:GetItemQuantity(134)
										if JewelryQuantity >= 25 then
											exports.core_modules:removeQty(134, 25)
											TriggerServerEvent("JewelryHeist.SellJewels", 25)
										else
											exports.core_modules:removeQty(134, JewelryQuantity)
											TriggerServerEvent("JewelryHeist.SellJewels", JewelryQuantity)
										end
									end
                                end
                            end
                        end
                    end
				else
					if Data.HasVisited then
						TriggerEvent("Cancel.Jewelry.Meeting")
						Data.HasVisited = false
					end
				end
            end
        end
    end
end)

RegisterNetEvent("JewelryHeist.StartGroup")
AddEventHandler("JewelryHeist.StartGroup", function()
	local PlayerPed = PlayerPedId()
	local PlayerPosition = GetEntityCoords(PlayerPed, false)
	if #(PlayerPosition - StartLocation) <= 2.0 then
		TriggerServerEvent("JewelryHeist.AddRobber")
		IsRobber = true
		Notify("Robbery Started!")
	end
end)

RegisterNetEvent("JewelryHeist.SmashCase")
AddEventHandler("JewelryHeist.SmashCase", function(WasTrue)
	if WasTrue then
		if GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("WEAPON_UNARMED") then
			exports['mythic_progbar']:Progress({
				name = "smash_action",
				duration = 15000,
				label = "Smashing Case",
				useWhileDead = true,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}
			}, function(status)
				if not exports.core_modules:isFull() then
					if exports.core_modules:getQuantity() >= 95 then
						exports.core_modules:addQty(134, 100 - exports.core_modules:getQuantity())
						Notify("You stole "..100 - exports.core_modules:getQuantity().." pieces of Jewelry!")
					else
						exports.core_modules:addQty(134, 5)
						Notify("You stole 5 pieces of Jewelry!")
					end

				else
					Notify("You are carrying too many items!")
				end
			end)
			for Index = 1, 5 do
				TriggerSmashAnimation()
				Citizen.Wait(3000)
			end
		else
			Notify("You must have a weapon to smash this case!")
		end
	else
		Notify("This case has been smashed already!")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsRobber then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
			if #(PlayerPosition - StartLocation) >= 51 then
				IsRobber = false
				TriggerServerEvent("JewleryHeist.RemoveRobber")
			else
				if ( not Doors.Right.Locked and not Doors.Left.Locked ) or ( not Doors.Top.Locked and not Doors.Bottom.Locked ) then
					if #(PlayerPosition - ComputerLocation) <= 1.1 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to hack cameras!")
						if IsControlJustPressed(1, 51) then
							TriggerEvent("Rivalry.HackJewelryCameras", 1, 6)
							TriggerServerEvent("dispatch:cameras", 2)
							TriggerEvent('customNotification', Source, "You have just tripped an antitampering system! Better be quick!")
						end
					end
					for Index = 1, #JewelryCases do
						if #(PlayerPosition - JewelryCases[Index]) <= 1.0 then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to smash case!")
							if IsControlJustPressed(1, 51) then
								TriggerServerEvent("JewelryHeist.SmashCase", Index)
							end
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("Rivalry.HackJewelryCameras")
AddEventHandler("Rivalry.HackJewelryCameras", function(phase, phase_max)
	isRobbing = true
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start", 5, 31, "Starting Hack.. Phase "..phase.." of "..phase_max,function(success)
		if success then
			if phase == phase_max then
				isRobbing = false
				TriggerEvent("mhacking:hide")
				TriggerServerEvent("Rivalry.Disable.Jewelry.Cameras")
			else
				TriggerEvent("Rivalry.HackJewelryCameras", phase+1, 6)
			end
		else
			isRobbing = false
			TriggerEvent("mhacking:hide")
		end
	end)
end)

RegisterNetEvent("Rivalry.FinishedLockpickJewelry")
AddEventHandler("Rivalry.FinishedLockpickJewelry", function()
	Doors.Left.Locked = false
	Doors.Right.Locked = false
end)

RegisterNetEvent("JewelryHeist.UnlockTopDoors")
AddEventHandler("JewelryHeist.UnlockTopDoors", function()
	Doors.Top.Locked = false
	Doors.Bottom.Locked = false
end)

RegisterNetEvent("Rivalry.ResetJewelryStore")
AddEventHandler("Rivalry.ResetJewelryStore", function()
	Doors.Left.Locked = true
	Doors.Right.Locked = true
	Doors.Top.Locked = true
	Doors.Bottom.Locked = true
end)
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
local SecurityPanel = vector3(-629.15948486328,-230.77798461914,38.057048797607)

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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Player = PlayerPedId()
		local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
		if #(PlayerPosition - StartLocation) <= 11.0 then
			RenderMarker(25, StartLocation.x, StartLocation.y, StartLocation.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
			if #(PlayerPosition - StartLocation) <= 2.0 then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to start jewelry heist! ( Max Four Players )")
				if IsControlJustPressed(1, 51) then
					TriggerServerEvent("JewelryHeist.StartGroup")
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
		for Index = 1, 5 do
			TriggerSmashAnimation()
			Citizen.Wait(1000)
		end
		exports.core_modules:addQty(134, 1)
	else
		Notify("This case has been smashed already!", 3100)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsRobber then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(PlayerPedId(), false)
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
end)
